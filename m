Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1D4C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:09:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 883EF4114B;
	Thu, 13 Mar 2025 18:09:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 15C0041141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:09:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741885782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGbAIGbxXs4kokSRHRviEeTlDcjg4B0fDNdgiYaaZlU=;
 b=YT+VN/UN1mrjqxwh2x5mdsTVyr52IvlAMDwAswVqw7gOkGuXlLT7OGVolDuCjNWmlN6uLs
 ljz/b0EjisfytXT7//O0k14ZJKReOzBBjCaFK3NGQdQDEmxRX5sFsn0Vfi7FdC9skpDNIq
 5Mn+YaipoaKL17FPEPEuD7BGBwbPhj8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-gKb5MUtcMlaYmLIzBQHYVg-1; Thu, 13 Mar 2025 13:09:41 -0400
X-MC-Unique: gKb5MUtcMlaYmLIzBQHYVg-1
X-Mimecast-MFC-AGG-ID: gKb5MUtcMlaYmLIzBQHYVg_1741885780
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5498f71580cso564278e87.3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 10:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741885780; x=1742490580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGbAIGbxXs4kokSRHRviEeTlDcjg4B0fDNdgiYaaZlU=;
 b=xPkcU/w0JURgIyNfcLscx1hhsLE9Ts3dt28Gd+KsGtrCwjRqWudBIfCTK/LIelYvja
 fl6VO7KDjzbqBmufq033cYohKCzA0aicGIGZH3CxL6n9T+ztoeg+0vV0RXLIfzIxDOT/
 gpX56gyjPlTVwcm53EGidVGs//vMiZQ/XnnwOWZPkrFokJC64s3kYt9Rj5vOUn2WUllJ
 LUY/LvaxQ2+lYF2DXW51ZrFeUW9/7FQMjjoXrRdFGqSIAFan12opuQ7UCEBjclqpXbBf
 Z6RoWbhCUXKhbtJJYVlui1WUSkZYx4MZrkaNr+aw2aKrTNw4x7Pc51IFxc1C73PYnIkm
 ga3w==
X-Gm-Message-State: AOJu0YxqVaeNsdvkssSTLN5VMj/iMGtIrfOPY4TPP96KqRzqdqKEjv2a
 eEBbJYdpOsZCys1BFv4zDuXjTTiaBZFc7uxLNVviamm9iwZb1aiqRbzm+WpYTZ2x+I/WsmDOfw0
 Wp/yUv7c6079IdXlGahTPynZQQfSgMQuxBOuGYdnjSKwwyfyQv9wkJy8p/eiFjEi1XKFWKQab+a
 8RqZX+q6oJXaqk8rU=
X-Gm-Gg: ASbGnctC4UgOPGjz9m3eqtKqm234IkJ8jW01Syy+cANxh/fITGq20XILbCsggRM+OGA
 zYX41QtIU9/9xl2/MPdN5dm9YA9iIY4LiByj6cUnOwc3Igk9hXLWxdqOsN39rF/mDfabHVruigS
 g=
X-Received: by 2002:a05:6512:280d:b0:545:1e2d:6b8e with SMTP id
 2adb3069b0e04-549c0a54327mr184159e87.42.1741885779389; 
 Thu, 13 Mar 2025 10:09:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd1eIy1LokGjOfutg/uG4X3VDfmlKGFcBljbFIXl4p63IZ6HXCLI0bRlJKVA7EDpGC0WhvaxalmVFAK+UVm7k=
X-Received: by 2002:a05:6512:280d:b0:545:1e2d:6b8e with SMTP id
 2adb3069b0e04-549c0a54327mr184151e87.42.1741885778762; Thu, 13 Mar 2025
 10:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-4-david.marchand@redhat.com>
 <Z9MNiiyVYXrRBpJx@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z9MNiiyVYXrRBpJx@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 13 Mar 2025 18:09:26 +0100
X-Gm-Features: AQ5f1JpMCtMEuLBdfxQ3qf6wwmuHyvrr7bAPzZiJ1kyAkhvX2vHc4K1PXv-CU0c
Message-ID: <CAJFAV8y3D3aqHwfDZQg+248OBOMB4SVYeL9qsQxFMFTT+SSnxg@mail.gmail.com>
Subject: Re: [RFC v3 3/8] eal: rework function versioning macros
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, andremue@linux.microsoft.com, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1MdpSLvSpASKys70EhbHrF1JkNPGEpXSG0i6UNnwG3I_1741885780
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On Thu, Mar 13, 2025 at 5:54=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
> > diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/co=
ntributing/abi_versioning.rst
> > index 7afd1c1886..88dd776b4c 100644
> > --- a/doc/guides/contributing/abi_versioning.rst
> > +++ b/doc/guides/contributing/abi_versioning.rst
> > @@ -138,27 +138,20 @@ macros are used in conjunction with the ``version=
.map`` file for
> >  a given library to allow multiple versions of a symbol to exist in a s=
hared
> >  library so that older binaries need not be immediately recompiled.
> >
> > -The macros exported are:
> > +The macros are:
> >
> > -* ``VERSION_SYMBOL(b, e, n)``: Creates a symbol version table entry bi=
nding
> > -  versioned symbol ``b@DPDK_n`` to the internal function ``be``.
> > +* ``RTE_VERSION_SYMBOL(ver, type, name, args``: Creates a symbol versi=
on table
>
> Missing closing brace .........................^ here
>
> > +  entry binding symbol ``<name>@DPDK_<ver>`` to the internal function =
name
> > +  ``<name>_v<ver>``.
> >
> > -* ``BIND_DEFAULT_SYMBOL(b, e, n)``: Creates a symbol version entry ins=
tructing
> > -  the linker to bind references to symbol ``b`` to the internal symbol
> > -  ``be``.
> > +* ``RTE_DEFAULT_SYMBO(ver, type, name, args)``: Creates a symbol versi=
on entry
>
> s/SYMBO/SYMBOL/

Good catch thanks...

>
> > +  instructing the linker to bind references to symbol ``<name>`` to th=
e internal
> > +  symbol ``<name>_v<ver>``.
> >
> > -* ``MAP_STATIC_SYMBOL(f, p)``: Declare the prototype ``f``, and map it=
 to the
> > -  fully qualified function ``p``, so that if a symbol becomes versione=
d, it
> > -  can still be mapped back to the public symbol name.
> > -
> > -* ``__vsym``:  Annotation to be used in a declaration of the internal =
symbol
> > -  ``be`` to signal that it is being used as an implementation of a par=
ticular
> > -  version of symbol ``b``.
> > -
> > -* ``VERSION_SYMBOL_EXPERIMENTAL(b, e)``: Creates a symbol version tabl=
e entry
> > -  binding versioned symbol ``b@EXPERIMENTAL`` to the internal function=
 ``be``.
> > -  The macro is used when a symbol matures to become part of the stable=
 ABI, to
> > -  provide an alias to experimental until the next major ABI version.
> > +* ``RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args)``:  Similar to R=
TE_VERSION_SYMBOL
> > +  but for experimental API symbols. The macro is used when a symbol ma=
tures
> > +  to become part of the stable ABI, to provide an alias to experimenta=
l
> > +  until the next major ABI version.
>
> Just to clarify - this is where we create two names/aliases for the one
> function, so it can be found either as an experimental version or a stabl=
e
> one, right? In that way it's actually quite different from
> RTE_VERSION_SYMBOL which is used to define a *NEW" version of an existing
> function, i.e. two functions rather than one function with two names.

I did not change the behavior, it is still mapping a symbol to an
actual implementation (there is an example later in this doc).
The previous description about an alias was probably inaccurate.


>
> >
> >  .. _example_abi_macro_usage:
> >
> > @@ -277,49 +270,36 @@ list of exported symbols when DPDK is compiled as=
 a shared library.
> >
> >  Next, we need to specify in the code which function maps to the rte_ac=
l_create
> >  symbol at which versions.  First, at the site of the initial symbol de=
finition,
> > -we need to update the function so that it is uniquely named, and not i=
n conflict
> > -with the public symbol name
> > +we wrap the function with ``RTE_VERSION_SYMBOL``, passing the current =
ABI version,
> > +the function return type, and the function name and its arguments.
> >
> >  .. code-block:: c
> >
> >   -struct rte_acl_ctx *
> >   -rte_acl_create(const struct rte_acl_param *param)
> > - +struct rte_acl_ctx * __vsym
> > - +rte_acl_create_v21(const struct rte_acl_param *param)
> > + +RTE_VERSION_SYMBOL(21, struct rte_acl_ctx *, rte_acl_create, (const =
struct rte_acl_param *param))
> >   {
> >          size_t sz;
> >          struct rte_acl_ctx *ctx;
> >          ...
> > -
> > -Note that the base name of the symbol was kept intact, as this is cond=
ucive to
> > -the macros used for versioning symbols and we have annotated the funct=
ion as
> > -``__vsym``, an implementation of a versioned symbol . That is our next=
 step,
> > -mapping this new symbol name to the initial symbol name at version nod=
e 21.
> > -Immediately after the function, we add the VERSION_SYMBOL macro.
> > -
> > -.. code-block:: c
> > -
> > -   #include <rte_function_versioning.h>
> > -
> > -   ...
> > -   VERSION_SYMBOL(rte_acl_create, _v21, 21);
> > + }
> >
> >  Remembering to also add the rte_function_versioning.h header to the re=
quisite c
> >  file where these changes are being made. The macro instructs the linke=
r to
> >  create a new symbol ``rte_acl_create@DPDK_21``, which matches the symb=
ol created
> > -in older builds, but now points to the above newly named function. We =
have now
> > -mapped the original rte_acl_create symbol to the original function (bu=
t with a
> > -new name).
> > +in older builds, but now points to the above newly named function ``rt=
e_acl_create_v21``.
> > +We have now mapped the original rte_acl_create symbol to the original =
function
> > +(but with a new name).
> >
> >  Please see the section :ref:`Enabling versioning macros
> >  <enabling_versioning_macros>` to enable this macro in the meson/ninja =
build.
> > -Next, we need to create the new ``v22`` version of the symbol. We crea=
te a new
> > -function name, with the ``v22`` suffix, and implement it appropriately=
.
> > +Next, we need to create the new version of the symbol. We create a new
> > +function name and implement it appropriately, then wrap it in a call t=
o ``RTE_DEFAULT_SYMBOL``.
> >
> >  .. code-block:: c
> >
> > -   struct rte_acl_ctx * __vsym
> > -   rte_acl_create_v22(const struct rte_acl_param *param, int debug);
> > +   RTE_DEFAULT_SYMBOL(22, struct rte_acl_ctx *, rte_acl_create, (const=
 struct rte_acl_param *param,
> > +        int debug))
>
> Not directly relevant to the changes in this patch, but since this is
> documentation which doesn't actually need to be based on a real-life
> example, we should maybe come up with example functions which are short a=
nd
> don't need line wrapping. This example would be just as
> effective/instructive with a return value of "int" and parameter type
> without a "const" qualifier. :-)

Yep, I'll simplify the example.


>
> >     {
> >          struct rte_acl_ctx *ctx =3D rte_acl_create_v21(param);
> >
> > @@ -328,35 +308,9 @@ function name, with the ``v22`` suffix, and implem=
ent it appropriately.
> >          return ctx;
> >     }
> >
> > -This code serves as our new API call. Its the same as our old call, bu=
t adds the
> > -new parameter in place. Next we need to map this function to the new d=
efault
> > -symbol ``rte_acl_create@DPDK_22``. To do this, immediately after the f=
unction,
> > -we add the BIND_DEFAULT_SYMBOL macro.
> > -
> > -.. code-block:: c
> > -
> > -   #include <rte_function_versioning.h>
> > -
> > -   ...
> > -   BIND_DEFAULT_SYMBOL(rte_acl_create, _v22, 22);
> > -
> >  The macro instructs the linker to create the new default symbol
> > -``rte_acl_create@DPDK_22``, which points to the above newly named func=
tion.
> > -
> > -We finally modify the prototype of the call in the public header file,
> > -such that it contains both versions of the symbol and the public API.
> > -
> > -.. code-block:: c
> > -
> > -   struct rte_acl_ctx *
> > -   rte_acl_create(const struct rte_acl_param *param);
> > -
> > -   struct rte_acl_ctx * __vsym
> > -   rte_acl_create_v21(const struct rte_acl_param *param);
> > -
> > -   struct rte_acl_ctx * __vsym
> > -   rte_acl_create_v22(const struct rte_acl_param *param, int debug);
> > -
> > +``rte_acl_create@DPDK_22``, which points to the function named ``rte_a=
cl_create_v22``
> > +(declared by the macro).
> >
> >  And that's it, on the next shared library rebuild, there will be two v=
ersions of
> >  rte_acl_create, an old DPDK_21 version, used by previously built appli=
cations,
> > @@ -365,43 +319,10 @@ and a new DPDK_22 version, used by future built a=
pplications.
> >  .. note::
> >
> >     **Before you leave**, please take care reviewing the sections on
> > -   :ref:`mapping static symbols <mapping_static_symbols>`,
> >     :ref:`enabling versioning macros <enabling_versioning_macros>`,
> >     and :ref:`ABI deprecation <abi_deprecation>`.
> >
> >
> > -.. _mapping_static_symbols:
> > -
> > -Mapping static symbols
> > -______________________
> > -
> > -Now we've taken what was a public symbol, and duplicated it into two u=
niquely
> > -and differently named symbols. We've then mapped each of those back to=
 the
> > -public symbol ``rte_acl_create`` with different version tags. This onl=
y applies
> > -to dynamic linking, as static linking has no notion of versioning. Tha=
t leaves
> > -this code in a position of no longer having a symbol simply named
> > -``rte_acl_create`` and a static build will fail on that missing symbol=
.
> > -
> > -To correct this, we can simply map a function of our choosing back to =
the public
> > -symbol in the static build with the ``MAP_STATIC_SYMBOL`` macro.  Gene=
rally the
> > -assumption is that the most recent version of the symbol is the one yo=
u want to
> > -map.  So, back in the C file where, immediately after ``rte_acl_create=
_v22`` is
> > -defined, we add this
> > -
> > -
> > -.. code-block:: c
> > -
> > -   struct rte_acl_ctx * __vsym
> > -   rte_acl_create_v22(const struct rte_acl_param *param, int debug)
> > -   {
> > -        ...
> > -   }
> > -   MAP_STATIC_SYMBOL(struct rte_acl_ctx *rte_acl_create(const struct r=
te_acl_param *param, int debug), rte_acl_create_v22);
> > -
> > -That tells the compiler that, when building a static library, any call=
s to the
> > -symbol ``rte_acl_create`` should be linked to ``rte_acl_create_v22``
> > -
> > -
> >  .. _enabling_versioning_macros:
> >
> >  Enabling versioning macros
> > @@ -519,26 +440,17 @@ and ``DPDK_22`` version nodes.
> >      * Create an acl context object for apps to
> >      * manipulate
> >      */
> > -   struct rte_acl_ctx *
> > -   rte_acl_create(const struct rte_acl_param *param)
> > +   RTE_DEFAULT_SYMBOL(22, struct rte_acl_ctx *, rte_acl_create,
> > +        (const struct rte_acl_param *param))
> >     {
> >     ...
> >     }
> >
> > -   __rte_experimental
> > -   struct rte_acl_ctx *
> > -   rte_acl_create_e(const struct rte_acl_param *param)
> > -   {
> > -      return rte_acl_create(param);
> > -   }
> > -   VERSION_SYMBOL_EXPERIMENTAL(rte_acl_create, _e);
> > -
> > -   struct rte_acl_ctx *
> > -   rte_acl_create_v22(const struct rte_acl_param *param)
> > +   RTE_VERSION_EXPERIMENTAL_SYMBOL(struct rte_acl_ctx *, rte_acl_creat=
e,
> > +        (const struct rte_acl_param *param))
> >     {
> >        return rte_acl_create(param);
> >     }
> > -   BIND_DEFAULT_SYMBOL(rte_acl_create, _v22, 22);
> >
> >  In the map file, we map the symbol to both the ``EXPERIMENTAL``
> >  and ``DPDK_22`` version nodes.
> > @@ -564,13 +476,6 @@ and ``DPDK_22`` version nodes.
> >          rte_acl_create;
> >     };
> >
> > -.. note::
> > -
> > -   Please note, similar to :ref:`symbol versioning <example_abi_macro_=
usage>`,
> > -   when aliasing to experimental you will also need to take care of
> > -   :ref:`mapping static symbols <mapping_static_symbols>`.
> > -
> > -
> >  .. _abi_deprecation:
> >
> >  Deprecating part of a public API
> > @@ -616,10 +521,10 @@ Next remove the corresponding versioned export.
> >
> >  .. code-block:: c
> >
> > - -VERSION_SYMBOL(rte_acl_create, _v21, 21);
> > + -RTE_VERSION_SYMBOL(21, struct rte_acl_ctx *, rte_acl_create, (const =
struct rte_acl_param *param))
> >
> >
> > -Note that the internal function definition could also be removed, but =
its used
> > +Note that the internal function definition must also be removed, but i=
ts used
>
> its -> it's (or "it is" if you want the longer version).

Ok, I'll fix this too.

>
> >  in our example by the newer version ``v22``, so we leave it in place a=
nd declare
> >  it as static. This is a coding style choice.
> >

[snip]

> > diff --git a/lib/eal/include/rte_function_versioning.h b/lib/eal/includ=
e/rte_function_versioning.h
> > index eb6dd2bc17..0020ce4885 100644
> > --- a/lib/eal/include/rte_function_versioning.h
> > +++ b/lib/eal/include/rte_function_versioning.h
> > @@ -11,8 +11,6 @@
> >  #error Use of function versioning disabled, is "use_function_versionin=
g=3Dtrue" in meson.build?
> >  #endif
> >
> > -#ifdef RTE_BUILD_SHARED_LIB
> > -
> >  /*
> >   * Provides backwards compatibility when updating exported functions.
> >   * When a symbol is exported from a library to provide an API, it also=
 provides a
> > @@ -20,80 +18,54 @@
> >   * arguments, etc.  On occasion that function may need to change to ac=
commodate
> >   * new functionality, behavior, etc.  When that occurs, it is desirabl=
e to
> >   * allow for backwards compatibility for a time with older binaries th=
at are
> > - * dynamically linked to the dpdk.  To support that, the __vsym and
> > - * VERSION_SYMBOL macros are created.  They, in conjunction with the
> > - * version.map file for a given library allow for multiple versions of
> > - * a symbol to exist in a shared library so that older binaries need n=
ot be
> > - * immediately recompiled.
> > - *
> > - * Refer to the guidelines document in the docs subdirectory for detai=
ls on the
> > - * use of these macros
> > + * dynamically linked to the dpdk.
> >   */
> >
> > -/*
> > - * Macro Parameters:
> > - * b - function base name
> > - * e - function version extension, to be concatenated with base name
> > - * n - function symbol version string to be applied
> > - * f - function prototype
> > - * p - full function symbol name
> > - */
> > +#ifdef RTE_BUILD_SHARED_LIB
> >
> >  /*
> > - * VERSION_SYMBOL
> > - * Creates a symbol version table entry binding symbol <b>@DPDK_<n> to=
 the internal
> > - * function name <b><e>
> > + * RTE_VERSION_SYMBOL
> > + * Creates a symbol version table entry binding symbol <name>@DPDK_<ve=
r> to the internal
> > + * function name <name>_v<ver>.
> >   */
> > -#define VERSION_SYMBOL(b, e, n) __asm__(".symver " RTE_STR(b) RTE_STR(=
e) ", " RTE_STR(b) "@DPDK_" RTE_STR(n))
> > +#define RTE_VERSION_SYMBOL(ver, type, name, args) \
> > +__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) =
"@DPDK_" RTE_STR(ver)); \
> > +__rte_used type name ## _v ## ver args; \
> > +type name ## _v ## ver args
> >
> >  /*
> > - * VERSION_SYMBOL_EXPERIMENTAL
> > - * Creates a symbol version table entry binding the symbol <b>@EXPERIM=
ENTAL to the internal
> > - * function name <b><e>. The macro is used when a symbol matures to be=
come part of the stable ABI,
> > - * to provide an alias to experimental for some time.
> > + * RTE_VERSION_EXPERIMENTAL_SYMBOL
> > + * Similar to RTE_VERSION_SYMBOL but for experimental API symbols.
> > + * This is mainly used for keeping compatibility for symbols that get =
promoted to stable ABI.
> >   */
> > -#define VERSION_SYMBOL_EXPERIMENTAL(b, e) __asm__(".symver " RTE_STR(b=
) RTE_STR(e) ", " RTE_STR(b) "@EXPERIMENTAL")
> > +#define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args) \
> > +__asm__(".symver " RTE_STR(name) "_exp, " RTE_STR(name) "@EXPERIMENTAL=
") \
> > +__rte_used type name ## _exp args; \
> > +type name ## _exp args
> >
> >  /*
> > - * BIND_DEFAULT_SYMBOL
> > + * RTE_DEFAULT_SYMBOL
> >   * Creates a symbol version entry instructing the linker to bind refer=
ences to
> > - * symbol <b> to the internal symbol <b><e>
> > + * symbol <name> to the internal symbol <name>_v<ver>.
> >   */
> > -#define BIND_DEFAULT_SYMBOL(b, e, n) __asm__(".symver " RTE_STR(b) RTE=
_STR(e) ", " RTE_STR(b) "@@DPDK_" RTE_STR(n))
> > +#define RTE_DEFAULT_SYMBOL(ver, type, name, args) \
> > +__asm__(".symver " RTE_STR(name) "_v" RTE_STR(ver) ", " RTE_STR(name) =
"@@DPDK_" RTE_STR(ver)); \
> > +__rte_used type name ## _v ## ver args; \
> > +type name ## _v ## ver args
> >
> > -/*
> > - * __vsym
> > - * Annotation to be used in declaration of the internal symbol <b><e> =
to signal
> > - * that it is being used as an implementation of a particular version =
of symbol
> > - * <b>.
> > - */
> > -#define __vsym __rte_used
> > +#else /* !RTE_BUILD_SHARED_LIB */
> >
> > -/*
> > - * MAP_STATIC_SYMBOL
> > - * If a function has been bifurcated into multiple versions, none of w=
hich
> > - * are defined as the exported symbol name in the map file, this macro=
 can be
> > - * used to alias a specific version of the symbol to its exported name=
.  For
> > - * example, if you have 2 versions of a function foo_v1 and foo_v2, wh=
ere the
> > - * former is mapped to foo@DPDK_1 and the latter is mapped to foo@DPDK=
_2 when
> > - * building a shared library, this macro can be used to map either foo=
_v1 or
> > - * foo_v2 to the symbol foo when building a static library, e.g.:
> > - * MAP_STATIC_SYMBOL(void foo(), foo_v2);
> > - */
> > -#define MAP_STATIC_SYMBOL(f, p)
> > +#define RTE_VERSION_SYMBOL(ver, type, name, args) \
> > +type name ## _v ## ver args; \
> > +type name ## _v ## ver args
> >
> > -#else
> > -/*
> > - * No symbol versioning in use
> > - */
> > -#define VERSION_SYMBOL(b, e, n)
> > -#define VERSION_SYMBOL_EXPERIMENTAL(b, e)
> > -#define __vsym
> > -#define BIND_DEFAULT_SYMBOL(b, e, n)
> > -#define MAP_STATIC_SYMBOL(f, p) f __attribute__((alias(RTE_STR(p))))
> > -/*
> > - * RTE_BUILD_SHARED_LIB=3Dn
> > - */
> > -#endif
> > +#define RTE_VERSION_EXPERIMENTAL_SYMBOL(type, name, args) \
> > +type name ## _exp args; \
> > +type name ## _exp args
> > +
> > +#define RTE_DEFAULT_SYMBOL(ver, type, name, args) \
> > +type name args
> > +
> > +#endif /* RTE_BUILD_SHARED_LIB */
> >
> >  #endif /* _RTE_FUNCTION_VERSIONING_H_ */
>
> Changes to this file look ok to me.

Thank you Bruce.


--=20
David Marchand

