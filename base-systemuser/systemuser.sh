#!/bin/sh
set -e
echo $(date)
if getent passwd $USER_ID > /dev/null ; then
  date; echo "$USER ($USER_ID) exists"
else
  date; echo "Creating group $USER ($USER_ID)"
  groupadd -g $USER_ID $USER
  date; echo "Creating user $USER ($USER_ID)"
  useradd -u $USER_ID -g $USER_ID -s $SHELL $USER
  date; echo "Chowning home user dir"
  # This takes about 45 seconds
  #chown -R $USER /home/$USER
  find /home/$USER -not -user $USER -exec chown $USER {} \+
fi

date; echo "Setting notebook dir..."
notebook_arg=""
if [ -n "${NOTEBOOK_DIR:+x}" ]
then
    notebook_arg="--notebook-dir=${NOTEBOOK_DIR}"
fi

date; echo "Starting singleuser instance"
sudo LD_LIBRARY_PATH="${CONDA_DIR}/lib" -E PATH="${CONDA_DIR}/bin:$PATH" -u $USER jupyterhub-singleuser \
  --port=8888 \
  --ip=0.0.0.0 \
  --user=$JPY_USER \
  --cookie-name=$JPY_COOKIE_NAME \
  --base-url=$JPY_BASE_URL \
  --hub-prefix=$JPY_HUB_PREFIX \
  --hub-api-url=$JPY_HUB_API_URL \
  ${notebook_arg} \
  $@
