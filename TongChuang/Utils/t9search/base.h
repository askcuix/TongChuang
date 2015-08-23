#pragma once

//for ios
#ifdef DEBUG_BUILD
#define _DEBUG
#endif


typedef const char*	LPCSTR;

typedef unsigned short  WCHAR;
typedef const WCHAR*	LPCWSTR;

#include <string>

#include <vector>
namespace std {
    //typedef basic_string<WCHAR>  w16string;
    template <class CharType> class basic_string_v {
        typedef vector<CharType>   _VecType;
        
    public:
        typedef typename _VecType::value_type              value_type;
        typedef typename _VecType::pointer                 pointer;
        typedef typename _VecType::const_pointer           const_pointer;
        typedef typename _VecType::reference               reference;
        typedef typename _VecType::const_reference         const_reference;
        typedef typename _VecType::size_type		       size_type;
        typedef typename _VecType::difference_type	       difference_type;
        typedef typename _VecType::allocator_type	       allocator_type;
        typedef typename _VecType::iterator                iterator;
        typedef typename _VecType::const_iterator          const_iterator;
        typedef typename _VecType::reverse_iterator        reverse_iterator;
        typedef typename _VecType::const_reverse_iterator  const_reverse_iterator;
        
    public:
        basic_string_v() : m_data() {this->assign(NULL, 0);}
        basic_string_v(const basic_string_v& r) : m_data() {this->assign(r);}
        basic_string_v(const CharType* sz, size_t len) : m_data() {this->assign(sz, len);}
        basic_string_v(const CharType* sz) : m_data() {this->assign(sz);}
        template <class IT> basic_string_v(IT first, IT last) : m_data() {this->assign(first, last);}

        void assign(const basic_string_v& r) {m_data = r.m_data;}
        void assign(const CharType* sz, size_t len) {this->assign(sz, sz + len);}
        void assign(const CharType* sz) {this->assign(sz, char_traits<CharType>::length(sz));}
        template <class IT> void assign(IT first, IT last) {m_data.reserve(last - first + 1); m_data.assign(first, last); m_data.push_back(CharType());}

        bool empty() const {return m_data.size() <= 1;}
        size_t size() const {return m_data.size() - 1;}
        size_t length() const {return m_data.size() - 1;}
        const CharType* c_str() const {return &m_data[0];}
        const CharType* data() const {return &m_data[0];}
        CharType& operator [](size_t index) {return m_data[index];}
        const CharType& operator [](size_t index) const {return m_data[index];}
        basic_string_v& operator =(const basic_string_v& r) {m_data = r.m_data; return *this;}
        void swap(basic_string_v& r) {m_data.swap(r.m_data);}

        iterator begin() {return m_data.begin();}
        const_iterator begin() const {return m_data.begin();}
        iterator end() {return m_data.end() - 1;}
        const_iterator end() const {return m_data.end() - 1;}
        reverse_iterator rbegin() {return m_data.rbegin();}
        const_reverse_iterator rbegin() const {return m_data.rbegin();}
        reverse_iterator rend() {return m_data.rend() - 1;}
        const_reverse_iterator rend() const {return m_data.rend() - 1;}

    private:
        _VecType m_data;
    }; 
    
    template <class CharType> inline 
    void swap(basic_string_v<CharType>& x, basic_string_v<CharType>& y) {x.swap(y);}
    

    typedef basic_string_v<WCHAR>   w16string;
} //namespace std

#include <deque>
#include <set>

#include <algorithm>


#ifdef _DEBUG
    #include <assert.h>
    #define ASSERT	assert
#else
    #define ASSERT(x)
#endif
