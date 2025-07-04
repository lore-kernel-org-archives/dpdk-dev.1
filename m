Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345CDC8303D
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 03:10:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40B6A4028B;
	Fri,  4 Jul 2025 05:10:02 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 37F2E4027D
 for <dev@dpdk.org>; Fri,  4 Jul 2025 05:10:01 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-315c1b0623cso725569a91.1
 for <dev@dpdk.org>; Thu, 03 Jul 2025 20:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751598600; x=1752203400; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hBKPtYZwE4ukb4lNeNXqsi/TM6Pw9XuKsE6rFusBgL0=;
 b=UJJRzkzQiDnb+2UCDj565lM/zgV6yimsWkIo3wfqwVIOqrNiFPhNv5mMDWT7M+nHZJ
 emwUPYLe5VodcSotvzh6Pzkm6DXxedRphwmpHXBs6rEIK0ZF8GeEUByf3zwWWrs4zSWu
 tZYElfWd/twOBuUy9NcVVvVHLqXmu8Ep0zDMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751598600; x=1752203400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBKPtYZwE4ukb4lNeNXqsi/TM6Pw9XuKsE6rFusBgL0=;
 b=pgtnKHXKhGqDgvPOAdAdqEAijysSc1SjVuaEX48QE1thmMs8BiX9xMhReWLjgF98N3
 ZLeETH0XrWVmcRlI6YjaFFWfgRUS8NBXH6PLfCNfutfAmxnUR3yBpxeAOuRpxJDDkqO5
 Xi4UKjUaF5q1C63OIufUyiagPISI2aKtoOSGTpThF8Qn0XxKmrk26xABsoqnVCEer5xu
 fO0cPTerxrmLMkSeEaS9zUJpjEOjgm377H28prkSdwIsRaIJERYrHdZ5lZgy4EIViad6
 v0S93OGg2YG1jWmBDcD+ksfdrFM8G3QM/kxKodnQ8fzm1ZvLw8j3v8TsyQ+7NMQfgZkR
 ffJQ==
X-Gm-Message-State: AOJu0Yx5SQYDjYdsCE6YcR2RTcxJVI+Abi/4/dr/EK9G9XAm3QCaS+EI
 PVz5tC5mBXhcAYazPQfJ2Bq9vubZLeK/dDmaTV0MdBrtMkFZ8I4rtpHr3Upv4C8lM7/9CeeDYtn
 n8qFvmhVr7bSKBp8Muk5XljwPgH0u61bItB2yEmkCIfKE1CdRhywk
X-Gm-Gg: ASbGncs4wI7ViQB4Ku+q+jjzLxk7L1ineclQ/24la12glWY3idj7DNkH1p5bZJNuNP7
 GS5KTnsQ8kiDooFeS9vndbKIp/QIqGagKwlCKz+vbQktfTGwYY2maaJs062ugkhtDKp7a3o92oj
 PVzf7oYZKE1AX7Htw1kWMrY5ea6CkKDNuUpkPXHBLlsJvNqGoc935Ax+xd10M=
X-Google-Smtp-Source: AGHT+IHwdG0v9GHwQ+ZNUmMWe7DTk/OSPpw7Zh60PqVKcCXFglthZTrOnBfYouIY6UJeTydeAQupVDUvvcyalCATrKQ=
X-Received: by 2002:a17:90b:3dce:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-31aadcef372mr735380a91.3.1751598600222; Thu, 03 Jul 2025
 20:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250702164204.607685-1-luca.vizzarro@arm.com>
 <20250702164204.607685-2-luca.vizzarro@arm.com>
In-Reply-To: <20250702164204.607685-2-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 3 Jul 2025 23:04:23 -0400
X-Gm-Features: Ac12FXw8QdXtieme3C5PLnSNm7NAGf4Mfj_KfowJpUQKE8Kd2gimzjKzDXOPOB8
Message-ID: <CAJvnSUDcQb1wyFpoYvyw5YP7bXd5+Pybw3HuOHypJPcuFnc8Pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dts: add DPDK build app helper function
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="0000000000005b0f6e063911d4f2"
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

--0000000000005b0f6e063911d4f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:43=E2=80=AFPM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:

> Make a distinction between example apps and app/ apps by renaming the
> build app function. Moreover, provide a dedicated helper function to
> retrieve the path to a DPDK app.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  dts/framework/remote_session/dpdk.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/dts/framework/remote_session/dpdk.py
> b/dts/framework/remote_session/dpdk.py
> index e00c4a9bf9..ed1f808bdd 100644
> --- a/dts/framework/remote_session/dpdk.py
> +++ b/dts/framework/remote_session/dpdk.py
> @@ -267,8 +267,8 @@ def _build_dpdk(self) -> None:
>              self.remote_dpdk_build_dir,
>          )
>
> -    def build_dpdk_app(self, app_name: str, **meson_dpdk_args: str |
> bool) -> PurePath:
> -        """Build one or all DPDK apps.
> +    def build_dpdk_example_app(self, app_name: str, **meson_dpdk_args:
> str | bool) -> PurePath:
> +        """Build one or all DPDK example apps.
>
>
We have previously been encouraged to avoid using sample apps unless
absolutely necessary, so it probably doesn't make sense for us to add this
in until we have a specific reason and justification for supporting example
apps (and this may never happen).


>          Requires DPDK to be already built on the SUT node.
>
> @@ -298,6 +298,10 @@ def build_dpdk_app(self, app_name: str,
> **meson_dpdk_args: str | bool) -> PurePa
>              self.remote_dpdk_build_dir, "examples", f"dpdk-{app_name}"
>          )
>
> +    def get_app(self, app_name: str) -> PurePath:
> +        """Retrieve path for a DPDK app."""
> +        return self._session.join_remote_path(self.remote_dpdk_build_dir=
,
> "app", f"dpdk-{app_name}")
> +
>      @cached_property
>      def remote_dpdk_tree_path(self) -> PurePath:
>          """The remote DPDK tree path."""
> --
> 2.43.0
>
>
Otherwise this looks fine for dumpcap and the others /app apps - thanks.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--0000000000005b0f6e063911d4f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 2, =
2025 at 12:43=E2=80=AFPM Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@=
arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Make a distinction between example apps and a=
pp/ apps by renaming the<br>
build app function. Moreover, provide a dedicated helper function to<br>
retrieve the path to a DPDK app.<br>
<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
Reviewed-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com"=
 target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
---<br>
=C2=A0dts/framework/remote_session/dpdk.py | 8 ++++++--<br>
=C2=A01 file changed, 6 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_se=
ssion/dpdk.py<br>
index e00c4a9bf9..ed1f808bdd 100644<br>
--- a/dts/framework/remote_session/dpdk.py<br>
+++ b/dts/framework/remote_session/dpdk.py<br>
@@ -267,8 +267,8 @@ def _build_dpdk(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.remote_dpdk_build_dir,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 def build_dpdk_app(self, app_name: str, **meson_dpdk_args: s=
tr | bool) -&gt; PurePath:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Build one or all DPDK apps.<=
br>
+=C2=A0 =C2=A0 def build_dpdk_example_app(self, app_name: str, **meson_dpdk=
_args: str | bool) -&gt; PurePath:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Build one or all DPDK exampl=
e apps.<br>
<br></blockquote><div><br></div><div>We have previously been encouraged to =
avoid using sample apps unless absolutely necessary, so it probably doesn&#=
39;t make sense for us to add this in until we have a specific reason and j=
ustification for supporting example apps (and this may never happen).</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Requires DPDK to be already built on the =
SUT node.<br>
<br>
@@ -298,6 +298,10 @@ def build_dpdk_app(self, app_name: str, **meson_dpdk_a=
rgs: str | bool) -&gt; PurePa<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.remote_dpdk_build_dir,=
 &quot;examples&quot;, f&quot;dpdk-{app_name}&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
+=C2=A0 =C2=A0 def get_app(self, app_name: str) -&gt; PurePath:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Retrieve path for a DPDK app=
.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._session.join_remote_path(self.rem=
ote_dpdk_build_dir, &quot;app&quot;, f&quot;dpdk-{app_name}&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@cached_property<br>
=C2=A0 =C2=A0 =C2=A0def remote_dpdk_tree_path(self) -&gt; PurePath:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The remote DPDK tree pa=
th.&quot;&quot;&quot;<br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div>Otherwise this looks fine for dumpcap =
and the others /app apps - thanks.=C2=A0</div><div><br></div><div>Reviewed-=
by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu=
</a>&gt;</div><div>=C2=A0</div></div></div>

--0000000000005b0f6e063911d4f2--
