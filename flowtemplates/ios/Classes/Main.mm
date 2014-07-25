#include <stdio.h>
#include "./sdl/SDL_main.h"

extern "C" const char *hxRunLibrary();
extern "C" void hxcpp_set_top_of_stack();

{{#each project.app.mobile.ios.libs.native}}
  extern "C" int {{this}}_register_prims();
{{/each}}

extern "C" int main(int argc, char *argv[]) {

    //printf("Starting ...\n" );
    hxcpp_set_top_of_stack();

    {{#each project.app.mobile.ios.libs.native~}}
        {{this}}_register_prims();
    {{/each}}

    const char *err = NULL;
    err = hxRunLibrary();

    if (err) {
        printf(" Error %s\n", err );
        return -1;
    }

    return 0;
}