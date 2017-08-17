#!/bin/ksh

if [ $# -ne 2 ]; then
    echo "Usage: $0 <PROJECT NAME> <JOB NAME>"
    exit 1
fi

PROJ=$1
JOBNAME=$2

if [ -d $JOBNAME ]; then
    rm -rf $JOBNAME
fi
mkdir $JOBNAME

JOBS=()
i=0
JOBS[$i]=$JOBNAME

DS_HOME=`cat /.dshome`
. $DS_HOME/dsenv

STATUS=$($DS_HOME/bin/dsjob -report $PROJ $JOBNAME | grep "Job status" | cut -f2 -d'=' | cut -f1 -d' ')

if [ $? -ne 0 ]; then
    echo "Error: When get the job status on: Project: $PROJ Job: $JOBNAME"
    exit 2
fi

if [ $STATUS -eq 0 ]; then
    echo "Warning: Job: Project: $PROJ Job: $JOBNAME is running, please wait for it finish"
    exit 3
fi

RETRIVE_JOB_LIST(){
    LOGCNT=`$DS_HOME/bin/dsjob -logsum -type BATCH $PROJ $1 | grep $1 | grep "Job run requested" | sort | uniq | wc -l`
    if [ $LOGCNT -ne 0 ]; then
        $DS_HOME/bin/dsjob -logsum -type BATCH $PROJ $1 | grep $1 | grep "Job run requested" | sort | uniq | while read line; do
        JOB_TMP=`echo $line | awk -F'(' '{print $2}' | awk -F')' '{print $1}'`
        if [[ $JOB_TMP!=$1 ]]; then
            let i++
            JOBS[$i]=`echo $line | awk -F'(' '{print $2}' | awk -F')' '{print $1}'`
            RETRIVE_JOB_LIST ${JOBS[$i]}
        fi
    done
    fi
}

FETCH_LOG(){
    LOG_POS=()
    m=0
    $DS_HOME/bin/dsjob -logsum -type STARTED -max 2 $PROJ $1 | while read line; do
        echo "$line" | grep "^[0-9]" -q
        status=$?
        if [ $status -ne 0 ]; then
            continue
        fi
        LOG_POS[$m]=`echo $line | cut -d " " -f1`
        let m++
    done
    if [[ ${#LOG_POS[@]} != 2 ]]; then
        echo "Error to fetch Job Log for datastage job: $1 in project $PROJ"
        exit 4
    fi
    $DS_HOME/bin/dsjob -logdetail $PROJ $1 ${LOG_POS[0]} ${LOG_POS[1]} > $JOBNAME/$1.log
    if [[ $? != 0 ]]; then
        echo "Error occured when fetching datastage job log for datastage job: $1 in project $PROJ"
        exit 5
    fi
}

FETCH_RPT(){
    RUNTTIME=`$DS_HOME/bin/dsjob -report $PROJ $1 BASIC | grep 'Job elapsed time' | awk -F'=' '{print $2}'`
    printf "%s\t%s\n" "$1" "$RUNTTIME" >> $JOBNAME/$JOBNAME.rpt
}

RETRIVE_JOB_LIST $JOBNAME

for (( k=0; k<=i; k++ )); do
    FETCH_LOG ${JOBS[$k]}
    FETCH_RPT ${JOBS[$k]}
done
