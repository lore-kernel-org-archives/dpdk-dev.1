Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E455C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 18:46:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47F5640A67;
	Tue, 11 Feb 2025 19:46:55 +0100 (CET)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by mails.dpdk.org (Postfix) with ESMTP id 383C1409FA
 for <dev@dpdk.org>; Tue, 11 Feb 2025 19:46:53 +0100 (CET)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-51eb1a6ca1bso1589865e0c.1
 for <dev@dpdk.org>; Tue, 11 Feb 2025 10:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739299612; x=1739904412; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=orH2wQTqYtvIeetHum/N0lGI9QW0IQcgIoYrwGZDNfU=;
 b=kzkEPD0p0inoMDYCNXbw7tlTYBxXQn6JPz+uRIrlFIMRUnPSdCdPbAGIvtctmZXOwU
 zLCAghEbHI0I0PuwoBn4ymjwyc2x7A0v3MxUIcuANCkj9H3V3E+7BjSNEHh0pC3Lt868
 4/0lHx+TEX0cTlZB753dH44Oc176TILOS5L5V+VlhJoDT6DGFKEUSJoMI0dP2KYv+mN0
 wMYQWD40rlAFpAlJFwBRDdZqv7q6usZPBHP3g1EIB/fPVIE0OQhewX403KP0vhaibw+g
 T5CnKH1V273xuHlEG1XDwwqSepQVUzj94uaytrevj8/eHPcX6bSeyDEXJH0IU4lEKslE
 AlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739299612; x=1739904412;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=orH2wQTqYtvIeetHum/N0lGI9QW0IQcgIoYrwGZDNfU=;
 b=O15i2O6M/1f69ftKqAeQO6zEuXY3U5BtCO8BZEVdKLnZUaUQJvppFRxV/yGn+3Qpg9
 0rcZbO2Jsg1uOYlwCHCWN8eIbFan5f6eZRNPuV37FlYkU3bW8yFh/bqCf9+wULmDIGtx
 KEwSqBM8A43u1x9z5d2Vq17QNZHB1AuML6gV/rB9buVsIqYmhz69z9gEUO3bJhBzxLSh
 W2dei7s/zJxX/JLCWipIlHRck4IbW+ikckd22wtCs5fPHLAniUUGUJbT2eBYuhgx+B9S
 t9E95S+012cRtPu7M4TGGPZr96LwSCboeVki1n0WuCPCt1aYeXYX8rDqYyeudRCKcNhP
 3ehA==
X-Gm-Message-State: AOJu0Yx7FZyV7dRLqBEkHeZtwg8EDgJ15LVjNgrafte78p2idsuWl2RC
 icBkVglT72TFsL5Q9YJo0OD4QwOJ0OiGNqGMVeYorohQvoGMd3vmTZOdxkKNIoZdaoK0FUnmri2
 OtbVH9MCJ9k7hffbd3oXhTvQNBrVxPchOE0Q=
X-Gm-Gg: ASbGncsYVNKCn+sOCwZodL0ihWq8z3vzIFRxoAK4BObXmA8tYwVG1owGomZHut2Xa17
 VIoZf0zzuNVSRFgfiKZ0K8cQLP1zYx706ttAeTnGIVd0fXygPTcgWfepOuNwTmeicobbNuKb11Q
 ==
X-Google-Smtp-Source: AGHT+IHxs6VTACwpV/8mAyHeHGyQx47mjs7h3pEVAvNkzPWJq0Dabjdos891gVfaZF2JhDF7OzV0EXS92kEJJdRFV0g=
X-Received: by 2002:a05:6122:1d0d:b0:518:6286:87a4 with SMTP id
 71dfb90a1353d-52067c637e5mr739211e0c.4.1739299612258; Tue, 11 Feb 2025
 10:46:52 -0800 (PST)
MIME-Version: 1.0
From: Ben Magistro <koncept1@gmail.com>
Date: Tue, 11 Feb 2025 13:46:41 -0500
X-Gm-Features: AWEUYZlWrTlT_khBHIDOonqk8jqzwKxThfD00d1vpKtvpt7DC1vElqaqMqt_a8A
Message-ID: <CAKx8PBic6QVBP2ntcke_mxxjjPmAtGmMY4YtSN0gZ5wmjcfTRg@mail.gmail.com>
Subject: Link custom libarchive meson support
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000008bfcad062de23ff1"
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

--0000000000008bfcad062de23ff1
Content-Type: text/plain; charset="UTF-8"

Will acknowledge this may be more of a meson question and less of a DPDK
issue but things didn't seem to work as expected and had to tweak the
config/meson.build to want to start with the DPDK team.

Our project is cmake based and we use fetch content to pull in our external
dependencies (eg dpdk, libarchive, etc).  We recently noticed
(rediscovered) that DPDK was not linking libarchive which causes the OS
provided DDP for the Intel ICE based cards to be unable to be
decompressed.  Previously we had some additional items installed that
provided an uncompressed DDP file.  As our project already builds
libarchive we did not want to install it at the os level for inclusion into
DPDK as we may now be mixing versions within our application.

In our cmake we added -Dpkg_config_path to help meson find our libarchive
build (it is not installed as it is statically linked into our app).  This
worked but did not expose the include and link directories or any libs that
may also need to be linked from the pc file.  We had to make some changes
to get those added and allow things to compile cleanly.  I can confirm the
changes here work but feel they should not have been necessary.

What is the correct way to link/use a custom libarchive (or any dependency
for that matter) with DPDK?  I've attached the diff for the meson changes
plus the generated pc file for libarchive that we are telling meson to find
with the pkg_config_path parameter.

---

```
diff --git a/config/meson.build b/config/meson.build
index 6d9ffd4f4b..3942b3e1dc 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -207,11 +207,21 @@ endif

 libarchive = dependency('libarchive', required: false, method:
'pkg-config')
 if libarchive.found()
+    link_libs = libarchive.get_pkgconfig_variable('tc_link_libs').split()
+    libarchive_link_libs = []
+    foreach lib : link_libs
+      if lib.startswith('-l')
+        libarchive_link_libs += lib
+      endif
+    endforeach
+
     dpdk_conf.set('RTE_HAS_LIBARCHIVE', 1)
     # Push libarchive link dependency at the project level to support
     # statically linking dpdk apps. Details at:
     # https://inbox.dpdk.org/dev/20210605004024.660267a1@sovereign/
-    add_project_link_arguments('-larchive', language: 'c')
+    add_project_link_arguments('-larchive',
'-L@0@'.format(libarchive.get_pkgconfig_variable('libdir')),
libarchive_link_libs, language: 'c')
+
+    add_project_arguments('-I@0@'.format(libarchive.get_pkgconfig_variable('includedir')),
language: 'c')
     dpdk_extra_ldflags += '-larchive'
 endif
```

----
some paths have been altered to hide user/application info
```
prefix=/opt/vendor/debug-trace
exec_prefix=${prefix}
libdir=/home/user/bitbucket/app/build/lib
includedir=/home/user/bitbucket/app/build/_deps/libarchive-src/libarchive
tc_link_libs=" -lz -lbz2 -llzma -llzo2 -llz4 -lnettle -lcrypto -lxml2
-lxml2 -lz -llzma -lm"

Name: libarchive
Description: library that can create and read several streaming archive
formats
Version: 3.7.2
Cflags: -I${includedir}
Cflags.private: -DLIBARCHIVE_STATIC
Libs: -L${libdir} -larchive
Libs.private:  -lz -lbz2 -llzma -llzo2 -llz4 -lnettle -lcrypto -lxml2
-lxml2 -lz -llzma -lm
Requires.private:
```

--0000000000008bfcad062de23ff1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Will acknowledge this may be more of a meson question=
 and less of a DPDK issue but things didn&#39;t seem to work as expected an=
d had to tweak the config/meson.build to want to start with the DPDK team.<=
/div><div><br></div><div>Our project is cmake based and we use fetch conten=
t to pull in our external dependencies (eg dpdk, libarchive, etc).=C2=A0 We=
 recently noticed (rediscovered) that DPDK was not linking libarchive which=
 causes the OS provided DDP for the Intel ICE based cards to be unable to b=
e decompressed.=C2=A0 Previously we had some additional items installed tha=
t provided an uncompressed DDP file.=C2=A0 As our project already builds li=
barchive we did not want to install it at the os level for inclusion into D=
PDK as we may now be mixing versions within our application.</div><div><br>=
</div><div>In our cmake we added -Dpkg_config_path to help meson find our l=
ibarchive build (it is not installed as it is statically linked into our ap=
p).=C2=A0 This worked but did not expose the include and link directories o=
r any libs that may also need to be linked from the pc file.=C2=A0 We had t=
o make some changes to get those added and allow things to compile cleanly.=
=C2=A0 I can confirm the changes here work but feel they should not have be=
en necessary.</div><div><br></div><div>What is the correct way to link/use =
a custom libarchive (or any dependency for that matter) with DPDK?=C2=A0 I&=
#39;ve attached the diff for the meson changes plus the generated pc file f=
or libarchive that we are telling meson to find with the pkg_config_path pa=
rameter.</div><div><br></div><div>---</div><div><br></div><div>```</div><di=
v>diff --git a/config/meson.build b/config/meson.build<br>index 6d9ffd4f4b.=
.3942b3e1dc 100644<br>--- a/config/meson.build<br>+++ b/config/meson.build<=
br>@@ -207,11 +207,21 @@ endif<br>=C2=A0<br>=C2=A0libarchive =3D dependency=
(&#39;libarchive&#39;, required: false, method: &#39;pkg-config&#39;)<br>=
=C2=A0if libarchive.found()<br>+ =C2=A0 =C2=A0link_libs =3D libarchive.get_=
pkgconfig_variable(&#39;tc_link_libs&#39;).split()<br>+ =C2=A0 =C2=A0libarc=
hive_link_libs =3D []<br>+ =C2=A0 =C2=A0foreach lib : link_libs<br>+ =C2=A0=
 =C2=A0 =C2=A0if lib.startswith(&#39;-l&#39;)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0libarchive_link_libs +=3D lib<br>+ =C2=A0 =C2=A0 =C2=A0endif<br>+ =C2=A0=
 =C2=A0endforeach<br>+<br>=C2=A0 =C2=A0 =C2=A0dpdk_conf.set(&#39;RTE_HAS_LI=
BARCHIVE&#39;, 1)<br>=C2=A0 =C2=A0 =C2=A0# Push libarchive link dependency =
at the project level to support<br>=C2=A0 =C2=A0 =C2=A0# statically linking=
 dpdk apps. Details at:<br>=C2=A0 =C2=A0 =C2=A0# <a href=3D"https://inbox.d=
pdk.org/dev/20210605004024.660267a1@sovereign/">https://inbox.dpdk.org/dev/=
20210605004024.660267a1@sovereign/</a><br>- =C2=A0 =C2=A0add_project_link_a=
rguments(&#39;-larchive&#39;, language: &#39;c&#39;)<br>+ =C2=A0 =C2=A0add_=
project_link_arguments(&#39;-larchive&#39;, &#39;-L@0@&#39;.format(libarchi=
ve.get_pkgconfig_variable(&#39;libdir&#39;)), libarchive_link_libs, languag=
e: &#39;c&#39;)<br>+<br>+ =C2=A0 =C2=A0add_project_arguments(&#39;-I@0@&#39=
;.format(libarchive.get_pkgconfig_variable(&#39;includedir&#39;)), language=
: &#39;c&#39;)<br>=C2=A0 =C2=A0 =C2=A0dpdk_extra_ldflags +=3D &#39;-larchiv=
e&#39;<br>=C2=A0endif</div><div>```<br><br></div><div>----</div><div>some p=
aths have been altered to hide user/application info</div><div>```</div><di=
v>prefix=3D/opt/vendor/debug-trace<br>exec_prefix=3D${prefix}<br>libdir=3D/=
home/user/bitbucket/app/build/lib<br>includedir=3D/home/user/bitbucket/app/=
build/_deps/libarchive-src/libarchive<br>tc_link_libs=3D&quot; -lz -lbz2 -l=
lzma -llzo2 -llz4 -lnettle -lcrypto -lxml2 -lxml2 -lz -llzma -lm&quot;<br><=
br>Name: libarchive<br>Description: library that can create and read severa=
l streaming archive formats<br>Version: 3.7.2<br>Cflags: -I${includedir}<br=
>Cflags.private: -DLIBARCHIVE_STATIC<br>Libs: -L${libdir} -larchive<br>Libs=
.private: =C2=A0-lz -lbz2 -llzma -llzo2 -llz4 -lnettle -lcrypto -lxml2 -lxm=
l2 -lz -llzma -lm<br>Requires.private: <br>```</div>
</div>

--0000000000008bfcad062de23ff1--
