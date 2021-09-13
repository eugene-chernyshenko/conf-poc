# conf-poc

## prepare

```
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
```

## example

prepare env vars for templates if needed

```
export DEMO_PASSWORD=qwerty
```

process all components with default vars

```
make
```

process demo component with default vars

```
make demo
```

process demo component with stage vars

```
make demostage
```

## result

rendered component will be in target/components

merged vars will be in target/vars (for debug)
