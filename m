Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E027CC02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 17:36:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C4408400EF;
	Tue,  4 Feb 2025 18:36:53 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 9FA7A400D7
 for <dev@dpdk.org>; Tue,  4 Feb 2025 18:36:52 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so9915309a91.0
 for <dev@dpdk.org>; Tue, 04 Feb 2025 09:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738690612; x=1739295412; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=igX9K9YBiAMSFTkgwbS7O29Y6LpzYxf7NS36ekt18I4=;
 b=f+IJY5buXPIczi3lylDY68taP2+0ZQkgj4KdJm0J0uhLZBlHCQiGaI77Xm5IlbBhVT
 1FkqkbkwtjN+Il2ZoEAVWYFtU880DI0Q2vpQqdjnnyXMvS8BJzwotjVqNSv98qSfKYt/
 PKDd4uWu6x48khpuvNNYUOAlgJpKvibccOzIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738690612; x=1739295412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igX9K9YBiAMSFTkgwbS7O29Y6LpzYxf7NS36ekt18I4=;
 b=VJHdRgwbCm62grMsAnYa2i+MICmCFYQWQ6t398HOwzjTy9X05qnZf1ROIteFsmifbk
 mo2f1WA8nxihzGyH6+eOBewXTAf4Fvepi+oNHqL43Ur05QeX2N2V+erXb6EUGjEUJp3j
 z8cLQdn3Ml31X61DWAvyUNN9nQzimMsR/E4th2LROsZZVbttnsWRaAUUPUDRjDe/G/gq
 F0TZrFbRKY2VXPRNIeK7vkV/Yal0ytC2yGoKOUj42Ab4yGt9FKf/Ec6IQGZ+5c5tz2Pg
 r8+Bw21F8eDP3FEbr3B+0QdkwK1Rqz9Nsw3yU6rZlu+r8Htl9Fra+sHtulXzEPuYwUXl
 ElNA==
X-Gm-Message-State: AOJu0YwRimWzTZ7DIlb+0RrNTLSpzRuJzj9orUIZXmCAq+iw6dp8f61N
 orzmVsL+zTBI1/h3UWut3AQRgp0APFEy11drXOXIOS4+eDhMxZkspiH8jzpMRyUUzY0whVQ/Rlr
 3p2F4Jk9CHumv/6/XTitBkKjTho5wNZuhHoxBlw==
X-Gm-Gg: ASbGncua365XFiNjISBOVe4ab2HqC662h8e6lX5mIA9qN0aGYtMB8FErk0ZOZpzFgzl
 v1F6suRFwBjQockB05r43Tjq6mlcXx8aGPzDRFdyu/mmtKScZOpjSszPHxQxJIZL+ZqOknRHnpL
 zDhXlAH6BdERE=
X-Google-Smtp-Source: AGHT+IF8BU7gIecXxsvv/bKBJPJOHKQn1Zp82fL4YvmG4CHAv+KjYajcfj/1+BM3jIKks1h4b8LFANBmh8zF1ne3pPE=
X-Received: by 2002:a17:90b:2711:b0:2ee:b2e6:4276 with SMTP id
 98e67ed59e1d1-2f83ac5e592mr37223013a91.27.1738690610836; Tue, 04 Feb 2025
 09:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20250204160739.1603197-1-aconole@redhat.com>
In-Reply-To: <20250204160739.1603197-1-aconole@redhat.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 4 Feb 2025 12:33:44 -0500
X-Gm-Features: AWEUYZkHq3O8CgI2mUbEh3UhYM2yVsb4EtNWALUFA0suHjkXO-4yHnXcPq5Q5t8
Message-ID: <CAJvnSUC0gSQ10P-Ddy0zjxzUPjD_+2PXO1WBESR5PUCm3KASkQ@mail.gmail.com>
Subject: Re: [RFC] ci: Add support for Cirrus-CI service to test FreeBSD.
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Michael Santana <maicolgabriel@hotmail.com>
Content-Type: multipart/alternative; boundary="0000000000003bcc3e062d547496"
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

--0000000000003bcc3e062d547496
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 11:07=E2=80=AFAM Aaron Conole <aconole@redhat.com> w=
rote:

> This commit adds preliminary support for developer driven FreeBSD testing
> via the Cirrus-CI cloud continuous integration system.
>
> NOTE: Currently, this does not successfully execute.  See the following
> build result:
>   https://cirrus-ci.com/task/5626189961756672
>
> Full Logs:
>   https://api.cirrus-ci.com/v1/task/5626189961756672/logs/check.log
>
> The tests themselves may need to be run as root.
>
> Signed-off-by: Aaron Conole <aconole@redhat.com>
> ---
>  .ci/freebsd-build.sh |  5 +++++
>  .ci/freebsd-setup.sh |  3 +++
>  .cirrus.yml          | 33 +++++++++++++++++++++++++++++++++
>  MAINTAINERS          |  1 +
>  4 files changed, 42 insertions(+)
>  create mode 100755 .ci/freebsd-build.sh
>  create mode 100755 .ci/freebsd-setup.sh
>  create mode 100644 .cirrus.yml
>
> diff --git a/.ci/freebsd-build.sh b/.ci/freebsd-build.sh
> new file mode 100755
> index 0000000000..099f9fd448
> --- /dev/null
> +++ b/.ci/freebsd-build.sh
> @@ -0,0 +1,5 @@
> +#!/bin/sh
> +
> +cd build
> +ninja
> +meson install
> diff --git a/.ci/freebsd-setup.sh b/.ci/freebsd-setup.sh
> new file mode 100755
> index 0000000000..762a8383c3
> --- /dev/null
> +++ b/.ci/freebsd-setup.sh
> @@ -0,0 +1,3 @@
> +#!/bin/sh
> +
> +meson setup build
> diff --git a/.cirrus.yml b/.cirrus.yml
> new file mode 100644
> index 0000000000..727dcb14f4
> --- /dev/null
> +++ b/.cirrus.yml
> @@ -0,0 +1,33 @@
> +freebsd_build_task:
> +
> +  freebsd_instance:
> +    matrix:
> +      image_family: freebsd-15-0-snap
> +      image_family: freebsd-14-2-snap
> +    cpu: 4
> +    memory: 4G
> +
> +  env:
> +    DEPENDENCIES: git gcc wget openssl python3 meson pkgconf
> +    PY_DEPS:      pyelftools
> +    matrix:
> +      COMPILER: gcc
> +      COMPILER: clang
> +
> +  prepare_script:
> +    - sysctl -w kern.coredump=3D0
> +    - pkg update -f
> +    - pkg install -y ${DEPENDENCIES}
> +        $(pkg search -xq "^py3[0-9]+-(${PY_DEPS})-[0-9]+" | xargs)
> +    - mkdir -p /usr/src
> +    - git clone --depth 1 https://git.freebsd.org/src.git /usr/src
>

Sorry, do you mind explaining why this is needed? And should it be cloning
to main or to the latest LTS tag? I think I am ignorant of what is required
for your build process.


> +
> +  configure_script:
> +    - ./.ci/freebsd-setup.sh
> +
> +  build_script:
> +    - ./.ci/freebsd-build.sh
> +
> +  check_script:
> +    - meson test -C build --suite fast-tests -t 3
>

You might be interested in this thread:
https://bugs.dpdk.org/show_bug.cgi?id=3D761

See Cody's comment from last April about unit tests being broken on FreeBSD
13.0 and 14.0. My recollection is that there is no volunteer to resolve
these issues currently, which is why we are not targeting unit tests for
FreeBSD at the Community Lab - only build tests.


> +            || { cat ./build/meson-logs/testlog.txt; exit 1; }
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b86cdd266b..ed1df17f3c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -142,6 +142,7 @@ M: Aaron Conole <aconole@redhat.com>
>  M: Michael Santana <maicolgabriel@hotmail.com>
>  F: .github/workflows/build.yml
>  F: .ci/
> +F: .cirrus.yml
>
>  Driver information
>  M: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
> --
> 2.47.1
>
>
Looks like it makes sense overall, thanks.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000003bcc3e062d547496
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 4, =
2025 at 11:07=E2=80=AFAM Aaron Conole &lt;<a href=3D"mailto:aconole@redhat.=
com">aconole@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">This commit adds preliminary support for developer d=
riven FreeBSD testing<br>
via the Cirrus-CI cloud continuous integration system.<br>
<br>
NOTE: Currently, this does not successfully execute.=C2=A0 See the followin=
g<br>
build result:<br>
=C2=A0 <a href=3D"https://cirrus-ci.com/task/5626189961756672" rel=3D"noref=
errer" target=3D"_blank">https://cirrus-ci.com/task/5626189961756672</a><br=
>
<br>
Full Logs:<br>
=C2=A0 <a href=3D"https://api.cirrus-ci.com/v1/task/5626189961756672/logs/c=
heck.log" rel=3D"noreferrer" target=3D"_blank">https://api.cirrus-ci.com/v1=
/task/5626189961756672/logs/check.log</a><br>
<br>
The tests themselves may need to be run as root.<br>
<br>
Signed-off-by: Aaron Conole &lt;<a href=3D"mailto:aconole@redhat.com" targe=
t=3D"_blank">aconole@redhat.com</a>&gt;<br>
---<br>
=C2=A0.ci/freebsd-build.sh |=C2=A0 5 +++++<br>
=C2=A0.ci/freebsd-setup.sh |=C2=A0 3 +++<br>
=C2=A0.cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 33 ++++++++++++++++++=
+++++++++++++++<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A04 files changed, 42 insertions(+)<br>
=C2=A0create mode 100755 .ci/freebsd-build.sh<br>
=C2=A0create mode 100755 .ci/freebsd-setup.sh<br>
=C2=A0create mode 100644 .cirrus.yml<br>
<br>
diff --git a/.ci/freebsd-build.sh b/.ci/freebsd-build.sh<br>
new file mode 100755<br>
index 0000000000..099f9fd448<br>
--- /dev/null<br>
+++ b/.ci/freebsd-build.sh<br>
@@ -0,0 +1,5 @@<br>
+#!/bin/sh<br>
+<br>
+cd build<br>
+ninja<br>
+meson install<br>
diff --git a/.ci/freebsd-setup.sh b/.ci/freebsd-setup.sh<br>
new file mode 100755<br>
index 0000000000..762a8383c3<br>
--- /dev/null<br>
+++ b/.ci/freebsd-setup.sh<br>
@@ -0,0 +1,3 @@<br>
+#!/bin/sh<br>
+<br>
+meson setup build<br>
diff --git a/.cirrus.yml b/.cirrus.yml<br>
new file mode 100644<br>
index 0000000000..727dcb14f4<br>
--- /dev/null<br>
+++ b/.cirrus.yml<br>
@@ -0,0 +1,33 @@<br>
+freebsd_build_task:<br>
+<br>
+=C2=A0 freebsd_instance:<br>
+=C2=A0 =C2=A0 matrix:<br>
+=C2=A0 =C2=A0 =C2=A0 image_family: freebsd-15-0-snap<br>
+=C2=A0 =C2=A0 =C2=A0 image_family: freebsd-14-2-snap<br>
+=C2=A0 =C2=A0 cpu: 4<br>
+=C2=A0 =C2=A0 memory: 4G<br>
+<br>
+=C2=A0 env:<br>
+=C2=A0 =C2=A0 DEPENDENCIES: git gcc wget openssl python3 meson pkgconf<br>
+=C2=A0 =C2=A0 PY_DEPS:=C2=A0 =C2=A0 =C2=A0 pyelftools<br>
+=C2=A0 =C2=A0 matrix:<br>
+=C2=A0 =C2=A0 =C2=A0 COMPILER: gcc<br>
+=C2=A0 =C2=A0 =C2=A0 COMPILER: clang<br>
+<br>
+=C2=A0 prepare_script:<br>
+=C2=A0 =C2=A0 - sysctl -w kern.coredump=3D0<br>
+=C2=A0 =C2=A0 - pkg update -f<br>
+=C2=A0 =C2=A0 - pkg install -y ${DEPENDENCIES}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(pkg search -xq &quot;^py3[0-9]+-(${PY_DEPS})=
-[0-9]+&quot; | xargs)<br>
+=C2=A0 =C2=A0 - mkdir -p /usr/src<br>
+=C2=A0 =C2=A0 - git clone --depth 1 <a href=3D"https://git.freebsd.org/src=
.git" rel=3D"noreferrer" target=3D"_blank">https://git.freebsd.org/src.git<=
/a> /usr/src<br></blockquote><div><br></div><div>Sorry, do you mind explain=
ing why this is needed? And should it be cloning to main or to the latest L=
TS tag? I think I am ignorant of what is required for your build process.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 configure_script:<br>
+=C2=A0 =C2=A0 - ./.ci/freebsd-setup.sh<br>
+<br>
+=C2=A0 build_script:<br>
+=C2=A0 =C2=A0 - ./.ci/freebsd-build.sh<br>
+<br>
+=C2=A0 check_script:<br>
+=C2=A0 =C2=A0 - meson test -C build --suite fast-tests -t 3<br></blockquot=
e><div><br></div><div>You might be interested in this thread:=C2=A0<a href=
=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D761">https://bugs.dpdk.org/show=
_bug.cgi?id=3D761</a></div><div><br></div><div>See Cody&#39;s comment from =
last April about unit tests being broken on FreeBSD 13.0 and 14.0. My recol=
lection is that there is no volunteer to resolve these issues currently, wh=
ich is why we are not targeting=C2=A0unit tests for FreeBSD at the Communit=
y Lab - only build tests.</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 || { cat ./build/meson-logs/test=
log.txt; exit 1; }<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index b86cdd266b..ed1df17f3c 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -142,6 +142,7 @@ M: Aaron Conole &lt;<a href=3D"mailto:aconole@redhat.co=
m" target=3D"_blank">aconole@redhat.com</a>&gt;<br>
=C2=A0M: Michael Santana &lt;<a href=3D"mailto:maicolgabriel@hotmail.com" t=
arget=3D"_blank">maicolgabriel@hotmail.com</a>&gt;<br>
=C2=A0F: .github/workflows/build.yml<br>
=C2=A0F: .ci/<br>
+F: .cirrus.yml<br>
<br>
=C2=A0Driver information<br>
=C2=A0M: Dmitry Kozlyuk &lt;<a href=3D"mailto:dmitry.kozliuk@gmail.com" tar=
get=3D"_blank">dmitry.kozliuk@gmail.com</a>&gt;<br>
-- <br>
2.47.1<br>
<br></blockquote><div><br></div><div>Looks like it makes sense overall, tha=
nks.</div><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mail=
to:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></div>

--0000000000003bcc3e062d547496--
