part of PokerDart;

class ObservableList<T> {
    List<T> _myList;
    List<IObserver> _observers;

    ObservableList([List<T> myList]) {
        if (myList != null){
            _myList = myList;
        }else{
            _myList = new List<T>();
        }
        _observers = new List<IObserver>();
    }

    void subscribe(IObserver obs) {
        _observers.add(obs);
    }

    void _notifyObservers() {
        _observers.forEach((o) => o.notify());
    }

    void add(T obj) {
        _myList.add(obj);
        _notifyObservers();
    }

    void addAll(Iterable<T> objs) {
        _myList.addAll(objs);
        _notifyObservers();
    }

    bool remove(T obj) {
        var result =_myList.remove(obj);
        _notifyObservers();
        return result;
    }

    void clear(){
        _myList.removeRange(0, _myList.length);
        _notifyObservers();
    }

    void forEach(void f(T element)){
        for (int i = 0; i < _myList.length; i++){
            f(_myList[i]);
        }
    }
}
