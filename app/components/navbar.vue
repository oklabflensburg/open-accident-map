<template>
<nav class="w-full bg-gray-700 p-2 fixed w-full z-40 top-0 left-0">
    <div class="flex flex-wrap items-center justify-between mx-auto">
        <a class="flex items-center bg-white rounded-lg py-1.5 px-3" href="https://open-accident-map.de">
                <span class="self-center text-xl font-semibold whitespace-nowrap text-red-700">Open Accident Map <span
                        class="self-bottom text-xl font-thin text-gray-800">2.0</span></span>
        </a>
        <div class="flex w-1/5 md:order-2">
            <button aria-controls="navbar-search" aria-expanded="false"
                    class="md:hidden text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-4 focus:ring-gray-200 dark:focus:ring-gray-700 rounded text-sm p-2.5 mr-1"
                    data-collapse-toggle="navbar-search"
                    type="button">
                <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"
                     xmlns="http://www.w3.org/2000/svg">
                    <path clip-rule="evenodd"
                          d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                          fill-rule="evenodd"></path>
                </svg>
                <span class="sr-only">Search</span>
            </button>
            <div class="relative items-center flex w-full mx-2">
                <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                    <svg aria-hidden="true" class="w-5 h-5 text-gray-500" fill="currentColor" viewBox="0 0 20 20"
                         xmlns="http://www.w3.org/2000/svg">
                        <path clip-rule="evenodd"
                              d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                              fill-rule="evenodd"></path>
                    </svg>
                    <span class="sr-only">Search icon</span>
                </div>
                <input class="block w-full p-2 pl-10 text-md text-gray-900 border border-gray-300 rounded bg-gray-50 focus-ring-0 focus:outline-none focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                       id="search-navbar"
                       placeholder="Search..."
                       type="text">
            </div>
            <button class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-0 focus:outline-none focus:ring-blue-300 font-medium rounded text-sm px-5 py-2.5 text-center mr-3 md:mr-0 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                    type="button">Go
            </button>
            <button aria-controls="navbar-sticky" aria-expanded="false"
                    class="inline-flex items-center p-2 text-sm text-gray-500 rounded md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200"
                    data-collapse-toggle="navbar-sticky" type="button">
                <span class="sr-only">Open main menu</span>
                <svg aria-hidden="true" class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                     xmlns="http://www.w3.org/2000/svg">
                    <path clip-rule="evenodd"
                          d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
                          fill-rule="evenodd"></path>
                </svg>
            </button>
        </div>
        <div class="items-center justify-between hidden w-full md:flex md:w-auto md:order-1 z-50"
             id="navbar-sticky">
            <ul class="flex flex-col py-3 px-6 mt-4 md:flex-row md:space-x-8 md:mt-0 md:font-medium">
                <li>
                    <a aria-current="page"
                       class="block py-2 pl-3 pr-4 text-white hover:text-orange-50 focus:text-orange-50 md:p-0"
                       href="#">Projekt</a>
                </li>
                <li>
                    <a class="block py-2 pl-3 pr-4 text-white hover:text-orange-50 focus:text-orange-50 md:p-0"
                       href="#">Daten</a>
                </li>
                <li>
                    <a class="block py-2 pl-3 pr-4 text-white hover:text-orange-50 focus:text-orange-50 md:p-0"
                       href="#">Download </a>
                </li>
                <li>
                    <a class="block py-2 pl-3 pr-4 text-white hover:text-orange-50 focus:text-orange-50 md:p-0"
                       href="#">GitHub</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
</template>
