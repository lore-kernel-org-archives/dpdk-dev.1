Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14531C83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 18:53:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BB0B402E8;
	Tue, 15 Jul 2025 20:53:36 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8A32E4013F
 for <dev@dpdk.org>; Tue, 15 Jul 2025 20:53:35 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-23649faf69fso47777975ad.0
 for <dev@dpdk.org>; Tue, 15 Jul 2025 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752605614; x=1753210414; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nZ5iCFGHKvqLE8PCYaSLG72JFY5UIUgQ67Ee12qIVSk=;
 b=IIwt+/+AWVTsJ9he7KsxjxIAKIYHhP0e1siolYOFyjTCCIlnhyiddrcFQMbBaIJ0dE
 yxQQo41Bz7+ghOhb3NOsXuDpmLZCRvagc+N+vVBIsWPRaYWogZe8XXtH2uvbucgGPb01
 /57uDt2LN4L2gxh0Cir+iDBpEcE6wStYZup4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752605614; x=1753210414;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZ5iCFGHKvqLE8PCYaSLG72JFY5UIUgQ67Ee12qIVSk=;
 b=Wm1klu1NJ+Czr651kjLFsL8jm1a7NaKty49a+1f3qgLaMpKz38ozZbmiOPdDSyKjXe
 Y5pKFE/ZeHVF+hvPNn6Eg23CRi/bBrtXzBuIB1AoDwAaW7KpGXrd3vw8TTct8u29vnbn
 F5ywdfpqK2jzYANwzd+pwbTfz8RPl4C3uR38j2vQg8ZOgB4qdSf4Y4jhxmbBIDUfzxch
 TgAB3O9Vu8xuUejamUf+/Lxl0jc+2JPV2DluiFFDiB0QbrsSQqvCjI5wWOJB9M0b0U/N
 bnIMhXgF+h/Ov08XeBzw3H/FF9KUPcj5QQT4J+osiVSHcUPKC/gtc9dSCCw9Ok5tb2Y7
 JGZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDIL0pt+2g7F/FKwpr8Ck9UlLocLZHSGuxRXCvdHdyTL/XUIHz2TyvZwS8YHdlBOdG4JM=@dpdk.org
X-Gm-Message-State: AOJu0Yx7oCXpk5d2yJBOCkkg7gbDWSeWPCZCznE0LArJZDvkEyJfRKUn
 NV7EVuvPu+6oiinb9T+X09aV9WnsVA6g9uz18xrBfgj0Fi7jyMJmBM5nVDipprqJxWtDd7oNUd1
 39ZP05Bop6xqoYw3AzqgMmUImsYBmGfLmMwPXc/Ldxw==
X-Gm-Gg: ASbGncv6wQV+JEcXSroyqrjOTdIkzx1c+M9XlN3yHey+Ak/U6JaIFeIx4XDlOBi5ue4
 MfeAUT1CfMjoRpaV2QH9bKj6uVtU1185I5bS9n1htSe08LkLS1S8oG2Aqrj5s2WoJi97o11+nZU
 CgFhkCFxn2plgF9XWU/dTNHRQ7ja3Kiq9fmcgKr44vpZX8Jt20Bwg02RGHAQyw0mJ4gsTB65O33
 JVaG1d9Ew==
X-Google-Smtp-Source: AGHT+IH5GAE+kRCQBHd5pc1atVzaxANPByRYLEZ9kdNdsYIz67MULrn+nHV1blRbjtjlPhmxLrqC4XaMs+ttyPFxxZo=
X-Received: by 2002:a17:90b:3b83:b0:31c:15b4:8e22 with SMTP id
 98e67ed59e1d1-31c9e6e9a3amr375014a91.7.1752605614121; Tue, 15 Jul 2025
 11:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <1746458561-13525-1-git-send-email-andremue@linux.microsoft.com>
 <1752588889-27133-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1752588889-27133-1-git-send-email-andremue@linux.microsoft.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 15 Jul 2025 14:47:43 -0400
X-Gm-Features: Ac12FXxNI_ezesqEd2Q5LvpUKnWnWbaqymLx9Nv3lnH5gnGwswE4zAqvONQMQ8s
Message-ID: <CAJvnSUChvkJkMsGC3RVn_uEw2GPD8F6tcetDVPfSqEb3Sfrsnw@mail.gmail.com>
Subject: Re: [PATCH v2] doc: update parameters to use for mlx5 on Windows
To: Andre Muezerie <andremue@linux.microsoft.com>, ci@dpdk.org, 
 Manit Mahajan <mmahajan@iol.unh.edu>, Andrew Bailey <abailey@iol.unh.edu>
Cc: bingz@nvidia.com, dev@dpdk.org, dsosnowski@nvidia.com, matan@nvidia.com, 
 orika@nvidia.com, suanmingm@nvidia.com, viacheslavo@nvidia.com
Content-Type: multipart/alternative; boundary="0000000000001041ec0639fc4b06"
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

--0000000000001041ec0639fc4b06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ci@dpdk.org <ci@dpdk.org>
+Manit Mahajan <mmahajan@iol.unh.edu>
+Andrew Bailey <abailey@iol.unh.edu>

Thank you for this we will modify our Clang and MSVC build pipelines at UNH=
.

Acked-by: Patrick Robb <probb@iol.unh.edu>

On Tue, Jul 15, 2025 at 10:14=E2=80=AFAM Andre Muezerie <
andremue@linux.microsoft.com> wrote:

> The linker parameters to use with MSVC and Clang differ.
> Showing explicitly what to use with each in the documentation.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---
>  doc/guides/platform/mlx5.rst | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst
> index ab3107209a..94ed59b170 100644
> --- a/doc/guides/platform/mlx5.rst
> +++ b/doc/guides/platform/mlx5.rst
> @@ -268,14 +268,33 @@ configured by the ``ibverbs_link`` build option:
>  Compilation on Windows
>  ~~~~~~~~~~~~~~~~~~~~~~
>
> -The DevX SDK location must be set through CFLAGS/LDFLAGS,
> -either::
> +The DevX SDK location must be set through CFLAGS/LDFLAGS.
> +When compiling with MSVC, use either::
>
> -   meson.exe setup "-Dc_args=3D-I\"%DEVX_INC_PATH%\""
> "-Dc_link_args=3D-L\"%DEVX_LIB_PATH%\"" ...
> +   meson.exe setup ^
> +       "-Dc_args=3D-I\"%DEVX_INC_PATH%\"" ^
> +       "-Dc_link_args=3D-LIBPATH:\"%DEVX_LIB_PATH%\"" ^
> +       -Denable_stdatomic=3Dtrue ^
> +       ...
>
>  or::
>
> -   set CFLAGS=3D-I"%DEVX_INC_PATH%" && set LDFLAGS=3D-L"%DEVX_LIB_PATH%"=
 &&
> meson.exe setup ...
> +   set CFLAGS=3D-I"%DEVX_INC_PATH%"
> +   set LDFLAGS=3D-LIBPATH:"%DEVX_LIB_PATH%"
> +   meson.exe setup -Denable_stdatomic=3Dtrue ...
> +
> +When compiling with Clang, use either::
> +
> +   meson.exe setup ^
> +       "-Dc_args=3D-I\"%DEVX_INC_PATH%\"" ^
> +       "-Dc_link_args=3D-Wl,-LIBPATH:\"%DEVX_LIB_PATH%\"" ^
> +       ...
> +
> +or::
> +
> +   set CFLAGS=3D-I"%DEVX_INC_PATH%"
> +   set LDFLAGS=3D-Wl,-LIBPATH:"%DEVX_LIB_PATH%"
> +   meson.exe setup ...
>
>
>  .. _mlx5_common_env:
> --
> 2.50.1.vfs.0.0
>
>

--0000000000001041ec0639fc4b06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a class=3D"gmail_plusreply" id=3D"plusReplyChip-0" href=
=3D"mailto:ci@dpdk.org" tabindex=3D"-1">+ci@dpdk.org</a>=C2=A0<br><div><a c=
lass=3D"gmail_plusreply" id=3D"plusReplyChip-1" href=3D"mailto:mmahajan@iol=
.unh.edu" tabindex=3D"-1">+Manit Mahajan</a>=C2=A0<br></div><div><a class=
=3D"gmail_plusreply" id=3D"plusReplyChip-2" href=3D"mailto:abailey@iol.unh.=
edu" tabindex=3D"-1">+Andrew Bailey</a>=C2=A0<br></div><div><br></div><div>=
Thank you for this we will modify our Clang and MSVC=C2=A0build pipelines a=
t UNH.</div><div><br></div><div>Acked-by: Patrick Robb &lt;<a href=3D"mailt=
o:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Jul 15, 2025 at 10:14=E2=80=AFAM Andre Muezerie &lt;<a href=3D"mailt=
o:andremue@linux.microsoft.com">andremue@linux.microsoft.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The linker para=
meters to use with MSVC and Clang differ.<br>
Showing explicitly what to use with each in the documentation.<br>
<br>
Signed-off-by: Andre Muezerie &lt;<a href=3D"mailto:andremue@linux.microsof=
t.com" target=3D"_blank">andremue@linux.microsoft.com</a>&gt;<br>
---<br>
=C2=A0doc/guides/platform/mlx5.rst | 27 +++++++++++++++++++++++----<br>
=C2=A01 file changed, 23 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/doc/guides/platform/mlx5.rst b/doc/guides/platform/mlx5.rst<br=
>
index ab3107209a..94ed59b170 100644<br>
--- a/doc/guides/platform/mlx5.rst<br>
+++ b/doc/guides/platform/mlx5.rst<br>
@@ -268,14 +268,33 @@ configured by the ``ibverbs_link`` build option:<br>
=C2=A0Compilation on Windows<br>
=C2=A0~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
-The DevX SDK location must be set through CFLAGS/LDFLAGS,<br>
-either::<br>
+The DevX SDK location must be set through CFLAGS/LDFLAGS.<br>
+When compiling with MSVC, use either::<br>
<br>
-=C2=A0 =C2=A0meson.exe setup &quot;-Dc_args=3D-I\&quot;%DEVX_INC_PATH%\&qu=
ot;&quot; &quot;-Dc_link_args=3D-L\&quot;%DEVX_LIB_PATH%\&quot;&quot; ...<b=
r>
+=C2=A0 =C2=A0meson.exe setup ^<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-Dc_args=3D-I\&quot;%DEVX_INC_PATH%\&quot=
;&quot; ^<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-Dc_link_args=3D-LIBPATH:\&quot;%DEVX_LIB=
_PATH%\&quot;&quot; ^<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-Denable_stdatomic=3Dtrue ^<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
<br>
=C2=A0or::<br>
<br>
-=C2=A0 =C2=A0set CFLAGS=3D-I&quot;%DEVX_INC_PATH%&quot; &amp;&amp; set LDF=
LAGS=3D-L&quot;%DEVX_LIB_PATH%&quot; &amp;&amp; meson.exe setup ...<br>
+=C2=A0 =C2=A0set CFLAGS=3D-I&quot;%DEVX_INC_PATH%&quot;<br>
+=C2=A0 =C2=A0set LDFLAGS=3D-LIBPATH:&quot;%DEVX_LIB_PATH%&quot;<br>
+=C2=A0 =C2=A0meson.exe setup -Denable_stdatomic=3Dtrue ...<br>
+<br>
+When compiling with Clang, use either::<br>
+<br>
+=C2=A0 =C2=A0meson.exe setup ^<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-Dc_args=3D-I\&quot;%DEVX_INC_PATH%\&quot=
;&quot; ^<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;-Dc_link_args=3D-Wl,-LIBPATH:\&quot;%DEVX=
_LIB_PATH%\&quot;&quot; ^<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
+<br>
+or::<br>
+<br>
+=C2=A0 =C2=A0set CFLAGS=3D-I&quot;%DEVX_INC_PATH%&quot;<br>
+=C2=A0 =C2=A0set LDFLAGS=3D-Wl,-LIBPATH:&quot;%DEVX_LIB_PATH%&quot;<br>
+=C2=A0 =C2=A0meson.exe setup ...<br>
<br>
<br>
=C2=A0.. _mlx5_common_env:<br>
-- <br>
2.50.1.vfs.0.0<br>
<br>
</blockquote></div>

--0000000000001041ec0639fc4b06--
