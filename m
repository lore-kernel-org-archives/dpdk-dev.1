Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3293BC282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 15:38:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 218D04029E;
	Fri, 14 Mar 2025 16:38:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 04EE540289
 for <dev@dpdk.org>; Fri, 14 Mar 2025 16:38:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741966708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQEESEuP007a3zXuab/lgA3UOpaahoQI21gHkSL8hAk=;
 b=Fda/Ex/RBEBVgWF4cYss5dEQM4kQgZM++RjzjzcWTCmEUdsIBjTxPaovzdtmjV+BXP+HdD
 ICfMbxqO18+Lm5wg6v26A/iX0wC7DLZKrWBsjuuxfVYG/tiOLyFxuE7ZWOxs6pebKSsyl5
 kbpFBdrZLSKN22NHu4yTthdP+sqaMR8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-JPI3yyp0Md-11OkdW4nkDg-1; Fri, 14 Mar 2025 11:38:26 -0400
X-MC-Unique: JPI3yyp0Md-11OkdW4nkDg-1
X-Mimecast-MFC-AGG-ID: JPI3yyp0Md-11OkdW4nkDg_1741966705
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-54996475915so1138988e87.0
 for <dev@dpdk.org>; Fri, 14 Mar 2025 08:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741966705; x=1742571505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQEESEuP007a3zXuab/lgA3UOpaahoQI21gHkSL8hAk=;
 b=GjMbhETTiZCYVQ8ZXrbGgk887znart7GCzGb3aOizhEkYLncHlRA5/Y7gdXruQRJHM
 Ey/l9ZcjKDgP3FC1hyHqM9mljkMunqLgBGbAtZuNgr3DQp4fxkwGH0NmbGlo6R1jB/e/
 BnK8+fbcwM7SRvtb0NWc5f3zwbEl0DDDzTXLLKAzJNjb49FR1G/JZDgXsyxoaxNl2Hl5
 s4pvuVhcGvt5nA8bbf/6Z/+ldbrkx2Wa34gipUPiv1wfgtk0bq/oJMbF5wDCjAP2n/6w
 nZM8uNFugiqSgtOMHq9Gp6G1Yl+gt/VllBM47k3MT0OdNDZhXRE3s4pyIguM+L0r85W5
 v+zQ==
X-Gm-Message-State: AOJu0Yw9Pkm0J+WkMmVm2q/c2xDedjwyyphGjSlrAkvXPX+0kBw+lv+b
 qnDJVYmReOYMZ2pChV9g7h8C5yTqnhMHXlvjx/mydUt4vNZ1r/odW9QK4BGDNW/mtt45uqFDc+H
 1I0WhlA6nS8ctukn+Yyp4WgdvwUoeZm4Rf1r5DqkfOQ3pr44w+YoS0C76vA/umnlzMfT0M5iIk+
 gA5wJy7ypdDkvZmcc=
X-Gm-Gg: ASbGncsVjC+nhJjzE/t0QdByebna5lebOV1nEACJBb5k6/zC5ZPPEVyc2rljvPArqtO
 /3oySt7GVz33qrXIE16zuhBC8+5pJWCeKdN/dr4SDy49VYN/kVPrUe88vN3WHFbeidmJ8nj/KvL
 s=
X-Received: by 2002:a05:6512:31c3:b0:549:8f06:8225 with SMTP id
 2adb3069b0e04-549c39507ebmr1010590e87.53.1741966704719; 
 Fri, 14 Mar 2025 08:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9lQywGRxBD6mYTIBzhmKczZUcKJglpSDN0kpQ6bBaKnJIV+imOZs7seM4gkgmIUorXVXDTcssplLCvvMeru4=
X-Received: by 2002:a05:6512:31c3:b0:549:8f06:8225 with SMTP id
 2adb3069b0e04-549c39507ebmr1010569e87.53.1741966704070; Fri, 14 Mar 2025
 08:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250311095609.194523-1-david.marchand@redhat.com>
 <20250311095609.194523-6-david.marchand@redhat.com>
 <Z9MVVzHCtYaVy2AV@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z9MVVzHCtYaVy2AV@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 14 Mar 2025 16:38:12 +0100
X-Gm-Features: AQ5f1JrtPVwNSrzNr1SyPz-0qRYSkPdubGPphspoYa3b5NvAC9ZBVlOV4Wl4ZyI
Message-ID: <CAJFAV8x1nwdoEf_raBpCEpSwXZF8rToSLZd9pkZDKRBDGJvgpw@mail.gmail.com>
Subject: Re: [RFC v3 5/8] build: generate symbol maps
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, andremue@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wEAPP1FfonAJtwjs58iyBKue1QAbLLfSgSCP5JWcJP8_1741966705
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

On Thu, Mar 13, 2025 at 6:27=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Tue, Mar 11, 2025 at 10:56:03AM +0100, David Marchand wrote:
> > Rather than maintain a file in parallel of the code, symbols to be
> > exported can be marked with a token RTE_EXPORT_*SYMBOL.
> >
> > From those marks, the build framework generates map files only for
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
>
> Some comments inline below.
> /Bruce
>
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
> > +
> > +"""Generate a version map file used by GNU or MSVC linker."""
> > +
>
> While it's an internal build script not to be run by users directly, I
> believe a short one-line usage here might be useful, since the code below
> is directly referencing sys.argv[N] values. That makes it easier for the
> user to know what they are.
>
> Alternatively, assign them to proper names at the top of the script e.g.:
>         scriptname, link_mode, abi_version_file, output, *input =3D sys.a=
rgv

I like this simple form.

>
> Final alternative (which may be a bit overkill) is to use argparse.
>
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
>
> How about using "" rather than None for the default comment so you can
> always just do a print of "{prefix}{symbol};{comment}\n". The fact that
> writelines doesn't output a "\n" is a little confusing here, so maybe use
> "print" instead.
>
>         print("f\t{prefix}{symbol};{comment}", file=3Doutfile)

Yes, better.


>
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
> > +            print(f"Please check it has gone though the deprecation pr=
ocess.")
> > diff --git a/devtools/check-symbol-maps.sh b/devtools/check-symbol-maps=
.sh
> > index 6121f78ec6..fcd3931e5d 100755
> > --- a/devtools/check-symbol-maps.sh
> > +++ b/devtools/check-symbol-maps.sh
> > @@ -60,20 +60,6 @@ if [ -n "$local_miss_maps" ] ; then
> >      ret=3D1
> >  fi
> >
> > -find_empty_maps ()
> > -{
> > -    for map in $@ ; do
> > -        [ $(buildtools/map-list-symbol.sh $map | wc -l) !=3D '0' ] || =
echo $map
> > -    done
> > -}
> > -
> > -empty_maps=3D$(find_empty_maps $@)
> > -if [ -n "$empty_maps" ] ; then
> > -    echo "Found empty maps:"
> > -    echo "$empty_maps"
> > -    ret=3D1
> > -fi
> > -
> >  find_bad_format_maps ()
> >  {
> >      abi_version=3D$(cut -d'.' -f 1 ABI_VERSION)
> > diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
> > index 003bb49e04..7dcac7c8c9 100755
> > --- a/devtools/checkpatches.sh
> > +++ b/devtools/checkpatches.sh
> > @@ -33,7 +33,7 @@ VOLATILE,PREFER_PACKED,PREFER_ALIGNED,PREFER_PRINTF,S=
TRLCPY,\
> >  PREFER_KERNEL_TYPES,PREFER_FALLTHROUGH,BIT_MACRO,CONST_STRUCT,\
> >  SPLIT_STRING,LONG_LINE_STRING,C99_COMMENT_TOLERANCE,\
> >  LINE_SPACING,PARENTHESIS_ALIGNMENT,NETWORKING_BLOCK_COMMENT_STYLE,\
> > -NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG"
> > +NEW_TYPEDEFS,COMPARISON_TO_NULL,AVOID_BUG,EXPORT_SYMBOL"
> >  options=3D"$options $DPDK_CHECKPATCH_OPTIONS"
> >
> >  print_usage () {
> > diff --git a/doc/guides/contributing/abi_versioning.rst b/doc/guides/co=
ntributing/abi_versioning.rst
> > index 88dd776b4c..addbb24b9e 100644
> > --- a/doc/guides/contributing/abi_versioning.rst
> > +++ b/doc/guides/contributing/abi_versioning.rst
> > @@ -58,12 +58,12 @@ persists over multiple releases.
> >
> >  .. code-block:: none
> >
> > - $ head ./lib/acl/version.map
> > + $ head ./build/lib/librte_acl_exports.map
>
> I must admit I'm not a fan of these long filenames. How about just
> "acl_exports.map"?

I used the same prefix as other targets in ninja, I usually rely on
auto-completion.
But other than that, I don't mind.


>
> >   DPDK_21 {
> >          global:
> >   ...
> >
> > - $ head ./lib/eal/version.map
> > + $ head ./build/lib/librte_eal_exports.map
> >   DPDK_21 {
> >          global:
> >   ...
> > @@ -77,7 +77,7 @@ that library.
> >
> >  .. code-block:: none
> >
> > - $ head ./lib/acl/version.map
> > + $ head ./build/lib/librte_acl_exports.map
> >   DPDK_21 {
> >          global:
> >   ...
> > @@ -88,7 +88,7 @@ that library.
> >   } DPDK_21;
> >   ...
> >
> > - $ head ./lib/eal/version.map
> > + $ head ./build/lib/librte_eal_exports.map
> >   DPDK_21 {
> >          global:
> >   ...
> > @@ -100,12 +100,12 @@ how this may be done.
> >
> >  .. code-block:: none
> >
> > - $ head ./lib/acl/version.map
> > + $ head ./build/lib/librte_acl_exports.map
> >   DPDK_22 {
> >          global:
> >   ...
> >
> > - $ head ./lib/eal/version.map
> > + $ head ./build/lib/librte_eal_exports.map
> >   DPDK_22 {
> >          global:
> >   ...
> > @@ -134,8 +134,7 @@ linked to the DPDK.
> >
> >  To support backward compatibility the ``rte_function_versioning.h``
> >  header file provides macros to use when updating exported functions. T=
hese
> > -macros are used in conjunction with the ``version.map`` file for
> > -a given library to allow multiple versions of a symbol to exist in a s=
hared
> > +macros allow multiple versions of a symbol to exist in a shared
> >  library so that older binaries need not be immediately recompiled.
> >
> >  The macros are:
> > @@ -169,6 +168,7 @@ Assume we have a function as follows
> >    * Create an acl context object for apps to
> >    * manipulate
> >    */
> > + RTE_EXPORT_SYMBOL(rte_acl_create)
> >   struct rte_acl_ctx *
> >   rte_acl_create(const struct rte_acl_param *param)
> >   {
> > @@ -187,6 +187,7 @@ private, is safe), but it also requires modifying t=
he code as follows
> >    * Create an acl context object for apps to
> >    * manipulate
> >    */
> > + RTE_EXPORT_SYMBOL(rte_acl_create)
> >   struct rte_acl_ctx *
> >   rte_acl_create(const struct rte_acl_param *param, int debug)
> >   {
> > @@ -203,78 +204,16 @@ The addition of a parameter to the function is AB=
I breaking as the function is
> >  public, and existing application may use it in its current form. Howev=
er, the
> >  compatibility macros in DPDK allow a developer to use symbol versionin=
g so that
> >  multiple functions can be mapped to the same public symbol based on wh=
en an
> > -application was linked to it. To see how this is done, we start with t=
he
> > -requisite libraries version map file. Initially the version map file f=
or the acl
> > -library looks like this
> > +application was linked to it.
> >
> > -.. code-block:: none
> > -
> > -   DPDK_21 {
> > -        global:
> > -
> > -        rte_acl_add_rules;
> > -        rte_acl_build;
> > -        rte_acl_classify;
> > -        rte_acl_classify_alg;
> > -        rte_acl_classify_scalar;
> > -        rte_acl_create;
> > -        rte_acl_dump;
> > -        rte_acl_find_existing;
> > -        rte_acl_free;
> > -        rte_acl_ipv4vlan_add_rules;
> > -        rte_acl_ipv4vlan_build;
> > -        rte_acl_list_dump;
> > -        rte_acl_reset;
> > -        rte_acl_reset_rules;
> > -        rte_acl_set_ctx_classify;
> > -
> > -        local: *;
> > -   };
> > -
> > -This file needs to be modified as follows
> > -
> > -.. code-block:: none
> > -
> > -   DPDK_21 {
> > -        global:
> > -
> > -        rte_acl_add_rules;
> > -        rte_acl_build;
> > -        rte_acl_classify;
> > -        rte_acl_classify_alg;
> > -        rte_acl_classify_scalar;
> > -        rte_acl_create;
> > -        rte_acl_dump;
> > -        rte_acl_find_existing;
> > -        rte_acl_free;
> > -        rte_acl_ipv4vlan_add_rules;
> > -        rte_acl_ipv4vlan_build;
> > -        rte_acl_list_dump;
> > -        rte_acl_reset;
> > -        rte_acl_reset_rules;
> > -        rte_acl_set_ctx_classify;
> > -
> > -        local: *;
> > -   };
> > -
> > -   DPDK_22 {
> > -        global:
> > -        rte_acl_create;
> > -
> > -   } DPDK_21;
> > -
> > -The addition of the new block tells the linker that a new version node
> > -``DPDK_22`` is available, which contains the symbol rte_acl_create, an=
d inherits
> > -the symbols from the DPDK_21 node. This list is directly translated in=
to a
> > -list of exported symbols when DPDK is compiled as a shared library.
> > -
> > -Next, we need to specify in the code which function maps to the rte_ac=
l_create
> > +We need to specify in the code which function maps to the rte_acl_crea=
te
> >  symbol at which versions.  First, at the site of the initial symbol de=
finition,
> >  we wrap the function with ``RTE_VERSION_SYMBOL``, passing the current =
ABI version,
> > -the function return type, and the function name and its arguments.
> > +the function return type, the function name and its arguments.
>
> Good fix, though technically not relevant to this patch.

Indeed..
>
> >
> >  .. code-block:: c
> >
> > + -RTE_EXPORT_SYMBOL(rte_acl_create)
> >   -struct rte_acl_ctx *
> >   -rte_acl_create(const struct rte_acl_param *param)
> >   +RTE_VERSION_SYMBOL(21, struct rte_acl_ctx *, rte_acl_create, (const =
struct rte_acl_param *param))
> > @@ -293,6 +232,7 @@ We have now mapped the original rte_acl_create symb=
ol to the original function
> >
> >  Please see the section :ref:`Enabling versioning macros
> >  <enabling_versioning_macros>` to enable this macro in the meson/ninja =
build.
> > +
>
> Ditto.
>
> >  Next, we need to create the new version of the symbol. We create a new
> >  function name and implement it appropriately, then wrap it in a call t=
o ``RTE_DEFAULT_SYMBOL``.
> >
> > @@ -312,9 +252,9 @@ The macro instructs the linker to create the new de=
fault symbol
> >  ``rte_acl_create@DPDK_22``, which points to the function named ``rte_a=
cl_create_v22``
> >  (declared by the macro).
> >
> > -And that's it, on the next shared library rebuild, there will be two v=
ersions of
> > -rte_acl_create, an old DPDK_21 version, used by previously built appli=
cations,
> > -and a new DPDK_22 version, used by future built applications.
> > +And that's it. On the next shared library rebuild, there will be two v=
ersions of rte_acl_create,
> > +an old DPDK_21 version, used by previously built applications, and a n=
ew DPDK_22 version,
> > +used by future built applications.
>
> nit: not sure what others think but "future built" sounds strange to me?
> How about "later built" or "newly built"?

newly sounds better to me.

>
> >
> >  .. note::
> >
> > @@ -364,6 +304,7 @@ Assume we have an experimental function ``rte_acl_c=
reate`` as follows:
> >      * Create an acl context object for apps to
> >      * manipulate
> >      */
> <snip>
>


--=20
David Marchand

