# When executed within a directory, this function creates a python virtual environment inside of .venv of cwd, and updates pip, (if it finds requirements.txt in the same folder, it installs those packages automatically.)

function pyvenv () {
  # Check if .venv exists.
  if [ -d "./.venv" ] ; then
    # If exists.
    source ./.venv/bin/activate # activate
    echo "Virtual Environment activated successfully."
    echo "Python Path: " $(which python3)
    echo "PIP Path: " $(which pip3)

  else
    # If it doesn't
    python3 -m venv ./.venv # create

    source ./.venv/bin/activate # activate
    echo "Virtual Environment activated successfully."
    echo "Python Path: " $(which python3)
    echo "PIP Path: " $(which pip3)

    #  Update pip
    python3 -m pip install --upgrade pip

    # If requirements.txt file exists, install deps.
    [ -f "./requirements.txt" ] && pip3 install -r ./requirements.txt
  fi
}

