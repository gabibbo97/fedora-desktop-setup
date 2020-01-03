#!/bin/sh
set -e
LAST_COMMIT=$(git rev-parse HEAD~1)

if [ -f "migrations/${LAST_COMMIT}.sh" ]; then
  echo "Not overwriting ${LAST_COMMIT}.sh"
  exit 0
fi

cat > "migrations/${LAST_COMMIT}.sh" <<EOF
#!/bin/sh
. migrations/_lib.sh


EOF
chmod +x "migrations/${LAST_COMMIT}.sh"
echo "Created ${LAST_COMMIT}.sh"
