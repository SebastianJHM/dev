const person = () => {
    let saveName = "Name";
    return {
        getName: function() {
            return saveName
        },
        setName: function(name) {
            saveName = name;
        },
    };
    // return {
    //     getName: () => saveName,
    //     setName: (name) => {
    //       saveName = name;
    //     },
    // };
};

const newPerson = person();
console.log(newPerson.getName());
newPerson.setName('Edward');
console.log(newPerson.getName());


// Lo mismo pero con get y set
const usuario = () => {
    let name = 'Name'

    return {
        get name() {
            return name
        },

        set name(value) {
            name = value
        }
    }
}

const newUsuario = usuario()
console.log(newUsuario.name)
newUsuario.name = 'Jousmo'
console.log(newUsuario.name)


