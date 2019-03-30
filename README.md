# Keyboard layouts for Macbook Pro under Ubuntu Linux
Modifying the following keyboardl ayouts:

- English (Macintosh)
- Russian (Macintosh)
- Ukrainian (Macintosh)

## Add the keyboard layout into the system

### 1.a Copy  modified files

```
$ cd /path/to/the/mac-linuxxkb/
$ sudo cp us ru ua /usr/share/X11/xkb/symbols/
```

### 1.b Or edit the keyboard layout files
#### English (Macintosh)

Has the following problems:

- Incorrect arrangement of the `tilde` and `plusminus` symbols;
- Incorrect location of the `sharp` symbol;

Open the `/usr/share/X11/xkb/symbols/us` with root privileges, find the `English (Macintosh)` block and change the codes as:
```
...
key <TLDE> { [   section,  plusminus,       section,        plusminus ] };
key <LSGT> { [     grave, asciitilde,    dead_grave,        dead_horn ] };
key <AE03> { [         3, numbersign ] }; 
...
```

#### Russian (Macintosh)

Has no problems.

#### Ukrainian (Macintosh)
The keyboard layout is completely absent in the system.

Open the `/usr/share/X11/xkb/symbols/ua` with root privileges, find the `Ukrainian (legacy)` block and after this block, create a new block `Ukrainian (Macintosh)` as:

```
...
partial alphanumeric_keys
xkb_symbols "legacy" {

    name[Group1]= "Ukrainian (legacy)";
    ...
};

partial alphanumeric_keys
xkb_symbols "mac" {

    include "ua(legacy)"
    name[Group1]= "Ukrainian (Macintosh)";

    key <AC02> { [   Cyrillic_i,  Cyrillic_I  ] };
    key <AB05> { [  Ukrainian_i, Ukrainian_I  ] };

    key <LSGT> { [         less,     greater  ] };
    key <AE02> { [            2,    quotedbl  ] };
    key <AE03> { [            3,  numerosign  ] };
    key <AE04> { [            4,     percent  ] };
    key <AE05> { [            5,       colon  ] };
    key <AE06> { [            6,       comma  ] };
    key <AE07> { [            7,      period  ] };
    key <AE08> { [            8,   semicolon  ] };
    key <TLDE> { [ bracketright, bracketleft  ] };
    key <BKSL> { [ Ukrainian_ghe_with_upturn, Ukrainian_GHE_WITH_UPTURN ] };
};
...
```

### 2. Registrate the keyboard layout
The `English (Macintosh)` and the `Russian (Macintosh)` keyboard layouts already registered in the system. Now need to add a record about `Ukrainian (Macintosh)`.

Open the `/usr/share/X11/xkb/rules/xorg.lst` with root privileges, find the `homophonic ua: Ukrainian (homophonic)` string, and add after this line: `mac ua: Ukrainian (Macintosh)`:
```
...
legacy          ua: Ukrainian (legacy)
rstu            ua: Ukrainian (standard RSTU)
homophonic      ua: Ukrainian (homophonic)
mac             ua: Ukrainian (Macintosh)
extd            gb: English (UK, extended, with Win keys)
...
```
Open the `/usr/share/X11/xkb/rules/evdev.xml` with root privileges, find the `Ukrainian` block, and add `Ukrainian (Macintosh)` variant into `variantList`:
```
...
      <variantList>
        <variant>
          <configItem>
            <name>mac</name>
            <description>Ukrainian (Macintosh)</description>
          </configItem>
        </variant>
        ...
      </variantList>
...
```
## The end

Reboot your system!
Open keyboard settings and select layouts:

- English (Macintosh)
- Russian (Macintosh)
- Ukrainian (Macintosh)
