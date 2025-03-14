Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D732EC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 15:51:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EEAA4029E;
	Fri, 14 Mar 2025 16:51:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BB1DD40289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 16:51:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741967498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XtmB/gvjqIAaqfb+JeXzxjcgpcAynFu0Jj0MALlIPAo=;
 b=FvyrgVxCczkm0U3YFOA9Kk7qlM9uwaILJLXGNGVlkYNHE15S9FBhs4CI9TjHVYvd3sPsws
 5vy26nk/0zQHwW83hqVvxxEo6tW7UQb/nxOXQ0RlzWEDRZZhHCh0W2bUaDNl1U5x/Y9Iij
 NhgPDYOl0hyEKVRtsz0/uC2EcMls8jg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-OtjgedjyNmmMkWtdneW-Wg-1; Fri, 14 Mar 2025 11:51:36 -0400
X-MC-Unique: OtjgedjyNmmMkWtdneW-Wg-1
X-Mimecast-MFC-AGG-ID: OtjgedjyNmmMkWtdneW-Wg_1741967495
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5496d38f725so1147156e87.2
 for <dev@dpdk.org>; Fri, 14 Mar 2025 08:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741967495; x=1742572295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XtmB/gvjqIAaqfb+JeXzxjcgpcAynFu0Jj0MALlIPAo=;
 b=N4gIhXWjVipERlLwGalOFHvJf+H7ohENxDdZdNWOaosECZ7BVOIYKasSFldRrg8Lpf
 jNFSir8eWuThwkn9EFzLRVfifVUalwWukUY962gmwIn9wJmtkACKNiHuEvpae9THcBPs
 WDsbnj37RGKwv/Y/mcF1Q+XLs295qcTOMd9unYc5YYt0NOCElncTmbvU9lTirx8NfbTI
 M8f+DNYXuuWQ4CfTjNiGfLiGFRNshiIk64UomWjhE9aGGKZqizMSvaJm3RK5P0saYJvg
 m7zgQ2Jo/9/rZnzGw/fzfTGOmK7jbZDVzAWv/TeO5tv46f+RheUiEhKhNMOb0Dr1Znnm
 92mw==
X-Gm-Message-State: AOJu0YzvZF8k2Vib3x6BJY5iEV1OM3RL28WH5gixa2x+rlm1EN84VQK3
 n01jPSouALnKKn+Pdz1W2zi/uByHU6yutlEF3tjKF957PkP81AVFzN7AcK283RUm5HjW+f55Bbp
 WkWLlLkKjn+KBItF95rfktK5xiEBOXEJMv9UgoMyZaS5h9u2Jft8c2dNYjpGuXWIUH3WRuwWev2
 /YhCfI3VxeWKrKTDU=
X-Gm-Gg: ASbGnctH2VxQ+/IE9ubJPrDqgyZairo4qrK0XF8xi9P+ejcGTxsvjDnqu1C3oykTw6Q
 59mcVG6ucgzuWmCPRRapnB45sSD9c6q3A2VDHWe/0IoSAsP9CJQMPM4WE2tU3/8vo7b3lUApoiT
 Y=
X-Received: by 2002:a05:6512:3091:b0:545:6cf:6f3e with SMTP id
 2adb3069b0e04-549c3989ac9mr1278263e87.49.1741967494673; 
 Fri, 14 Mar 2025 08:51:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE3ouThe3vGZ3EIfyVb/sb6h1i9WisqvY0rh+i1qYo9fh3YfZt3ilxyFi6RRSuRWnNaLo4To4w+Oy17mTFyrc=
X-Received: by 2002:a05:6512:3091:b0:545:6cf:6f3e with SMTP id
 2adb3069b0e04-549c3989ac9mr1278250e87.49.1741967494058; Fri, 14 Mar 2025
 08:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-6-david.marchand@redhat.com>
 <20250314152756.GA31674@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20250314152756.GA31674@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 14 Mar 2025 16:51:22 +0100
X-Gm-Features: AQ5f1JpbrjeFNqZCyUzonQhsSTSkOtADMqTxL-huy7UruI11EJTedXdNzdAl3X8
Message-ID: <CAJFAV8yLT9876sPu5v9EsgwiTZhNXnVJ_EU-fxTRqXVYNTWkWQ@mail.gmail.com>
Subject: Re: [RFC v3 5/8] build: generate symbol maps
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NjvO1k5to2hyd5KM6dvwFx7Oumi8isGHwTXAUxrV8UM_1741967495
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

On Fri, Mar 14, 2025 at 4:28=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> On Tue, Mar 11, 2025 at 10:56:03AM +0100, David Marchand wrote:
> > Rather than maintain a file in parallel of the code, symbols to be
> > exported can be marked with a token RTE_EXPORT_*SYMBOL.
> >
> > >From those marks, the build framework generates map files only for
> > symbols actually compiled (which means that the WINDOWS_NO_EXPORT hack
> > becomes unnecessary).
> >
> > The build framework directly creates a map file in the format that the
> > linker expects (rather than converting from GNU linker to MSVC linker).
> >
> > Empty maps are allowed again as a replacement for drivers/version.map.
> >
> > The symbol check is updated to only support the new format.
> >
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > ---
> > Changes since RFC v2:
> > - because of MSVC limitations wrt macro passed via cmdline,
> >   used an internal header for defining RTE_EXPORT_* macros,
> > - updated documentation and tooling,
> >
> > ---
> >  MAINTAINERS                                |   2 +
> >  buildtools/gen-version-map.py              | 111 ++++++++++
> >  buildtools/map-list-symbol.sh              |  10 +-
> >  buildtools/meson.build                     |   1 +
> >  config/meson.build                         |   2 +
> >  config/rte_export.h                        |  16 ++
> >  devtools/check-symbol-change.py            |  90 +++++++++
> >  devtools/check-symbol-maps.sh              |  14 --
> >  devtools/checkpatches.sh                   |   2 +-
> >  doc/guides/contributing/abi_versioning.rst | 224 ++-------------------
> >  drivers/meson.build                        |  94 +++++----
> >  drivers/version.map                        |   3 -
> >  lib/meson.build                            |  91 ++++++---
> >  13 files changed, 371 insertions(+), 289 deletions(-)
> >  create mode 100755 buildtools/gen-version-map.py
> >  create mode 100644 config/rte_export.h
> >  create mode 100755 devtools/check-symbol-change.py
> >  delete mode 100644 drivers/version.map
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 312e6fcee5..04772951d3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -95,6 +95,7 @@ F: devtools/check-maintainers.sh
> >  F: devtools/check-forbidden-tokens.awk
> >  F: devtools/check-git-log.sh
> >  F: devtools/check-spdx-tag.sh
> > +F: devtools/check-symbol-change.py
> >  F: devtools/check-symbol-change.sh
> >  F: devtools/check-symbol-maps.sh
> >  F: devtools/checkpatches.sh
> > @@ -127,6 +128,7 @@ F: config/
> >  F: buildtools/check-symbols.sh
> >  F: buildtools/chkincs/
> >  F: buildtools/call-sphinx-build.py
> > +F: buildtools/gen-version-map.py
> >  F: buildtools/get-cpu-count.py
> >  F: buildtools/get-numa-count.py
> >  F: buildtools/list-dir-globs.py
> > diff --git a/buildtools/gen-version-map.py b/buildtools/gen-version-map=
.py
> > new file mode 100755
> > index 0000000000..b160aa828b
> > --- /dev/null
> > +++ b/buildtools/gen-version-map.py
> > @@ -0,0 +1,111 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: BSD-3-Clause
> > +# Copyright (c) 2024 Red Hat, Inc.
>
> 2025?

Well, technically, I had written the first version of this script in 2024 :=
-).
But I'll align to the rest of the patch.

> I appreciate that Python was chosen instead of sh/bash.
>
> > +
> > +"""Generate a version map file used by GNU or MSVC linker."""
> > +
> > +import re
> > +import sys
> > +
> > +# From rte_export.h
> > +export_exp_sym_regexp =3D re.compile(r"^RTE_EXPORT_EXPERIMENTAL_SYMBOL=
\(([^,]+), ([0-9]+.[0-9]+)\)")
> > +export_int_sym_regexp =3D re.compile(r"^RTE_EXPORT_INTERNAL_SYMBOL\(([=
^)]+)\)")
> > +export_sym_regexp =3D re.compile(r"^RTE_EXPORT_SYMBOL\(([^)]+)\)")
> > +# From rte_function_versioning.h
> > +ver_sym_regexp =3D re.compile(r"^RTE_VERSION_SYMBOL\(([^,]+), [^,]+, (=
[^,]+),")
> > +ver_exp_sym_regexp =3D re.compile(r"^RTE_VERSION_EXPERIMENTAL_SYMBOL\(=
[^,]+, ([^,]+),")
> > +default_sym_regexp =3D re.compile(r"^RTE_DEFAULT_SYMBOL\(([^,]+), [^,]=
+, ([^,]+),")
> > +
> > +with open(sys.argv[2]) as f:
> > +    abi =3D 'DPDK_{}'.format(re.match("([0-9]+).[0-9]", f.readline()).=
group(1))
> > +
> > +symbols =3D {}
> > +
> > +for file in sys.argv[4:]:
> > +    with open(file, encoding=3D"utf-8") as f:
> > +        for ln in f.readlines():
> > +            node =3D None
> > +            symbol =3D None
> > +            comment =3D None
> > +            if export_exp_sym_regexp.match(ln):
> > +                node =3D 'EXPERIMENTAL'
> > +                symbol =3D export_exp_sym_regexp.match(ln).group(1)
> > +                comment =3D ' # added in {}'.format(export_exp_sym_reg=
exp.match(ln).group(2))
> > +            elif export_int_sym_regexp.match(ln):
> > +                node =3D 'INTERNAL'
> > +                symbol =3D export_int_sym_regexp.match(ln).group(1)
> > +            elif export_sym_regexp.match(ln):
> > +                node =3D abi
> > +                symbol =3D export_sym_regexp.match(ln).group(1)
> > +            elif ver_sym_regexp.match(ln):
> > +                node =3D 'DPDK_{}'.format(ver_sym_regexp.match(ln).gro=
up(1))
> > +                symbol =3D ver_sym_regexp.match(ln).group(2)
> > +            elif ver_exp_sym_regexp.match(ln):
> > +                node =3D 'EXPERIMENTAL'
> > +                symbol =3D ver_exp_sym_regexp.match(ln).group(1)
> > +            elif default_sym_regexp.match(ln):
> > +                node =3D 'DPDK_{}'.format(default_sym_regexp.match(ln)=
.group(1))
> > +                symbol =3D default_sym_regexp.match(ln).group(2)
> > +
> > +            if not symbol:
> > +                continue
> > +
> > +            if node not in symbols:
> > +                symbols[node] =3D {}
> > +            symbols[node][symbol] =3D comment
> > +
> > +if sys.argv[1] =3D=3D 'msvc':
> > +    with open(sys.argv[3], "w") as outfile:
> > +        outfile.writelines(f"EXPORTS\n")
> > +        for key in (abi, 'EXPERIMENTAL', 'INTERNAL'):
> > +            if key not in symbols:
> > +                continue
> > +            for symbol in sorted(symbols[key].keys()):
> > +                outfile.writelines(f"\t{symbol}\n")
> > +            del symbols[key]
> > +else:
> > +    with open(sys.argv[3], "w") as outfile:
>
> Consider having output file samples documented, perhaps in this script it=
self, to make
> it easier to understand what this script it doing and highlight the diffe=
rences between
> the formats supported (msvc, etc).

I am not sure I follow.

The differences between the format is not something "normal" DPDK
contributors/developers should care about.
DPDK documentation was giving (too much) details on the version.map
gnu linker stuff, and I would prefer we stop documenting this.
Instead, the focus should be on the new sets of export macros, which
serve as an abstraction.


>
> > +        local_token =3D False
> > +        for key in (abi, 'EXPERIMENTAL', 'INTERNAL'):
> > +            if key not in symbols:
> > +                continue
> > +            outfile.writelines(f"{key} {{\n\tglobal:\n\n")
> > +            for symbol in sorted(symbols[key].keys()):
> > +                if sys.argv[1] =3D=3D 'mingw' and symbol.startswith('p=
er_lcore'):
> > +                    prefix =3D '__emutls_v.'
> > +                else:
> > +                    prefix =3D ''
> > +                outfile.writelines(f"\t{prefix}{symbol};")
> > +                comment =3D symbols[key][symbol]
> > +                if comment:
> > +                    outfile.writelines(f"{comment}")
> > +                outfile.writelines("\n")
> > +            outfile.writelines("\n")
> > +            if not local_token:
> > +                outfile.writelines("\tlocal: *;\n")
> > +                local_token =3D True
> > +            outfile.writelines("};\n")
> > +            del symbols[key]
> > +        for key in sorted(symbols.keys()):
> > +            outfile.writelines(f"{key} {{\n\tglobal:\n\n")
> > +            for symbol in sorted(symbols[key].keys()):
> > +                if sys.argv[1] =3D=3D 'mingw' and symbol.startswith('p=
er_lcore'):
> > +                    prefix =3D '__emutls_v.'
> > +                else:
> > +                    prefix =3D ''
> > +                outfile.writelines(f"\t{prefix}{symbol};")
> > +                comment =3D symbols[key][symbol]
> > +                if comment:
> > +                    outfile.writelines(f"{comment}")
> > +                outfile.writelines("\n")
> > +            outfile.writelines(f"}} {abi};\n")
> > +            if not local_token:
> > +                outfile.writelines("\tlocal: *;\n")
> > +                local_token =3D True
> > +            del symbols[key]
> > +        # No exported symbol, add a catch all
> > +        if not local_token:
> > +            outfile.writelines(f"{abi} {{\n")
> > +            outfile.writelines("\tlocal: *;\n")
> > +            local_token =3D True
> > +            outfile.writelines("};\n")
> > diff --git a/buildtools/map-list-symbol.sh b/buildtools/map-list-symbol=
.sh
> > index eb98451d8e..0829df4be5 100755
> > --- a/buildtools/map-list-symbol.sh
> > +++ b/buildtools/map-list-symbol.sh
> > @@ -62,10 +62,14 @@ for file in $@; do
> >               if (current_section =3D=3D "") {
> >                       next;
> >               }
> > +             symbol_version =3D current_version
> > +             if (/^[^}].*[^:*]; # added in /) {
> > +                     symbol_version =3D $5
> > +             }
> >               if ("'$version'" !=3D "") {
> > -                     if ("'$version'" =3D=3D "unset" && current_versio=
n !=3D "") {
> > +                     if ("'$version'" =3D=3D "unset" && symbol_version=
 !=3D "") {
> >                               next;
> > -                     } else if ("'$version'" !=3D "unset" && "'$versio=
n'" !=3D current_version) {
> > +                     } else if ("'$version'" !=3D "unset" && "'$versio=
n'" !=3D symbol_version) {
> >                               next;
> >                       }
> >               }
> > @@ -73,7 +77,7 @@ for file in $@; do
> >               if ("'$symbol'" =3D=3D "all" || $1 =3D=3D "'$symbol'") {
> >                       ret =3D 0;
> >                       if ("'$quiet'" =3D=3D "") {
> > -                             print "'$file' "current_section" "$1" "cu=
rrent_version;
> > +                             print "'$file' "current_section" "$1" "sy=
mbol_version;
> >                       }
> >                       if ("'$symbol'" !=3D "all") {
> >                               exit 0;
> > diff --git a/buildtools/meson.build b/buildtools/meson.build
> > index 4e2c1217a2..b745e9afa4 100644
> > --- a/buildtools/meson.build
> > +++ b/buildtools/meson.build
> > @@ -16,6 +16,7 @@ else
> >      py3 =3D ['meson', 'runpython']
> >  endif
> >  echo =3D py3 + ['-c', 'import sys; print(*sys.argv[1:])']
> > +gen_version_map =3D py3 + files('gen-version-map.py')
> >  list_dir_globs =3D py3 + files('list-dir-globs.py')
> >  map_to_win_cmd =3D py3 + files('map_to_win.py')
> >  sphinx_wrapper =3D py3 + files('call-sphinx-build.py')
> > diff --git a/config/meson.build b/config/meson.build
> > index f31fef216c..54657055fb 100644
> > --- a/config/meson.build
> > +++ b/config/meson.build
> > @@ -303,8 +303,10 @@ endif
> >  # add -include rte_config to cflags
> >  if is_ms_compiler
> >      add_project_arguments('/FI', 'rte_config.h', language: 'c')
> > +    add_project_arguments('/FI', 'rte_export.h', language: 'c')
> >  else
> >      add_project_arguments('-include', 'rte_config.h', language: 'c')
> > +    add_project_arguments('-include', 'rte_export.h', language: 'c')
> >  endif
> >
> >  # enable extra warnings and disable any unwanted warnings
> > diff --git a/config/rte_export.h b/config/rte_export.h
> > new file mode 100644
> > index 0000000000..83d871fe11
> > --- /dev/null
> > +++ b/config/rte_export.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright (c) 2025 Red Hat, Inc.
> > + */
> > +
> > +#ifndef RTE_EXPORT_H
> > +#define RTE_EXPORT_H
> > +
> > +/* *Internal* macros for exporting symbols, used by the build system.
> > + * For RTE_EXPORT_EXPERIMENTAL_SYMBOL, ver indicates the
> > + * version this symbol was introduced in.
> > + */
> > +#define RTE_EXPORT_EXPERIMENTAL_SYMBOL(a, ver)
> > +#define RTE_EXPORT_INTERNAL_SYMBOL(a)
> > +#define RTE_EXPORT_SYMBOL(a)
> > +
> > +#endif /* RTE_EXPORT_H */
> > diff --git a/devtools/check-symbol-change.py b/devtools/check-symbol-ch=
ange.py
> > new file mode 100755
> > index 0000000000..09709e4f06
> > --- /dev/null
> > +++ b/devtools/check-symbol-change.py
> > @@ -0,0 +1,90 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: BSD-3-Clause
> > +# Copyright (c) 2025 Red Hat, Inc.
> > +
> > +"""Check exported symbols change in a patch."""
> > +
> > +import re
> > +import sys
> > +
> > +file_header_regexp =3D re.compile(r"^(\-\-\-|\+\+\+) [ab]/(lib|drivers=
)/([^/]+)/([^/]+)")
> > +# From rte_export.h
> > +export_exp_sym_regexp =3D re.compile(r"^.RTE_EXPORT_EXPERIMENTAL_SYMBO=
L\(([^,]+),")
> > +export_int_sym_regexp =3D re.compile(r"^.RTE_EXPORT_INTERNAL_SYMBOL\((=
[^)]+)\)")
> > +export_sym_regexp =3D re.compile(r"^.RTE_EXPORT_SYMBOL\(([^)]+)\)")
> > +# TODO, handle versioned symbols from rte_function_versioning.h
> > +# ver_sym_regexp =3D re.compile(r"^.RTE_VERSION_SYMBOL\(([^,]+), [^,]+=
, ([^,]+),")
> > +# ver_exp_sym_regexp =3D re.compile(r"^.RTE_VERSION_EXPERIMENTAL_SYMBO=
L\([^,]+, ([^,]+),")
> > +# default_sym_regexp =3D re.compile(r"^.RTE_DEFAULT_SYMBOL\(([^,]+), [=
^,]+, ([^,]+),")
> > +
> > +symbols =3D {}
> > +
> > +for file in sys.argv[1:]:
> > +    with open(file, encoding=3D"utf-8") as f:
> > +        for ln in f.readlines():
> > +            if file_header_regexp.match(ln):
> > +                if file_header_regexp.match(ln).group(2) =3D=3D "lib":
> > +                    lib =3D '/'.join(file_header_regexp.match(ln).grou=
p(2, 3))
> > +                elif file_header_regexp.match(ln).group(3) =3D=3D "int=
el":
> > +                    lib =3D '/'.join(file_header_regexp.match(ln).grou=
p(2, 3, 4))
> > +                else:
> > +                    lib =3D '/'.join(file_header_regexp.match(ln).grou=
p(2, 3))
> > +
> > +                if lib not in symbols:
> > +                    symbols[lib] =3D {}
> > +                continue
> > +
> > +            if export_exp_sym_regexp.match(ln):
> > +                symbol =3D export_exp_sym_regexp.match(ln).group(1)
> > +                node =3D 'EXPERIMENTAL'
> > +            elif export_int_sym_regexp.match(ln):
> > +                node =3D 'INTERNAL'
> > +                symbol =3D export_int_sym_regexp.match(ln).group(1)
> > +            elif export_sym_regexp.match(ln):
> > +                symbol =3D export_sym_regexp.match(ln).group(1)
> > +                node =3D 'stable'
> > +            else:
> > +                continue
> > +
> > +            if symbol not in symbols[lib]:
> > +                symbols[lib][symbol] =3D {}
> > +            added =3D ln[0] =3D=3D '+'
> > +            if added and 'added' in symbols[lib][symbol] and node !=3D=
 symbols[lib][symbol]['added']:
> > +                print(f"{symbol} in {lib} was found in multiple ABI, p=
lease check.")
> > +            if not added and 'removed' in symbols[lib][symbol] and nod=
e !=3D symbols[lib][symbol]['removed']:
> > +                print(f"{symbol} in {lib} was found in multiple ABI, p=
lease check.")
> > +            if added:
> > +                symbols[lib][symbol]['added'] =3D node
> > +            else:
> > +                symbols[lib][symbol]['removed'] =3D node
> > +
> > +    for lib in sorted(symbols.keys()):
> > +        error =3D False
> > +        for symbol in sorted(symbols[lib].keys()):
> > +            if 'removed' not in symbols[lib][symbol]:
> > +                # Symbol addition
> > +                node =3D symbols[lib][symbol]['added']
> > +                if node =3D=3D 'stable':
> > +                    print(f"ERROR: {symbol} in {lib} has been added di=
rectly to stable ABI.")
> > +                    error =3D True
> > +                else:
> > +                    print(f"INFO: {symbol} in {lib} has been added to =
{node} ABI.")
> > +                continue
> > +
> > +            if 'added' not in symbols[lib][symbol]:
> > +                # Symbol removal
> > +                node =3D symbols[lib][symbol]['added']
> > +                if node =3D=3D 'stable':
> > +                    print(f"INFO: {symbol} in {lib} has been removed f=
rom stable ABI.")
>
> Some people would argue that WARN instead of INFO is more appropriate bec=
ause some attention
> is needed from the user. INFO many times is just ignored.

True, though the ABI check is supposed to fail with a big ERROR :-).

I would have to remember why we put INFO initially (I am just
reimplementing the .sh check that existed on static maps).
I think Thomas was the one who wanted it as INFO...


>
> > +                    print(f"Please check it has gone though the deprec=
ation process.")
> > +                continue
> > +
> > +            if symbols[lib][symbol]['added'] =3D=3D symbols[lib][symbo=
l]['removed']:
> > +                # Symbol was moved around
> > +                continue
> > +
> > +            # Symbol modifications
> > +            added =3D symbols[lib][symbol]['added']
> > +            removed =3D symbols[lib][symbol]['removed']
> > +            print(f"INFO: {symbol} in {lib} is moving from {removed} t=
o {added}")
>
> Perhaps use WARN instead of INFO.

On this part, I disagree.
Moving from a non stable (like experimental) ABI to stable or other
non stable ABI (like internal) is not an issue.


>
> > +            print(f"Please check it has gone though the deprecation pr=
ocess.")

[snip]


--=20
David Marchand

