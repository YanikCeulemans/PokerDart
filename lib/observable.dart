library Observable;

abstract class IObserver {
    void notify();
}


class Observable {
    List<IObserver> _observers;

    Observable() {
        _observers = new List<IObserver>();
    }

    void registerObserver(IObserver obs) {
        _observers.add(obs);
    }

    void unregisterObserver(IObserver obs) {
        _observers.remove(obs);
    }

    void _notifyObservers() {
        _observers.forEach((o) => o.notify());
    }
}

class ObservableList<T> extends Observable {
    List<T> _myList;

    ObservableList([List<T> myList]) {
        if (myList != null) {
            _myList = myList;
        } else {
            _myList = new List<T>();
        }
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
        var result = _myList.remove(obj);
        _notifyObservers();
        return result;
    }

    List<T> toList() => new List<T>.from(_myList);

    /**
     * Empty the List
     */
    void clear() {
        _myList.removeRange(0, _myList.length);
        _notifyObservers();
    }

    void forEach(void f(T element)) {
        for (int i = 0; i < _myList.length; i++) {
            f(_myList[i]);
        }
    }
}
