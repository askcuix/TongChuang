#pragma once


class CPinyinTable
{
public:
	const static WCHAR c_min_chinese_char = 0x4E00;
	const static WCHAR c_max_chinese_char = 0x9FBF;

	typedef std::deque<LPCSTR>	LPCSTR_LIST;
	static void getPinyinListOf(WCHAR ch, LPCSTR_LIST* pPinyinList);
    static LPCSTR getFirstPinyinOf(WCHAR ch);
	static bool hasPinyinOf(WCHAR ch);
};
