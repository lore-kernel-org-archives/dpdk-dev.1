Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE20AC8303D
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 16:42:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 986DE4060B;
	Fri,  4 Jul 2025 18:42:25 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id CC6F84028E
 for <dev@dpdk.org>; Fri,  4 Jul 2025 18:42:23 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-234b9dfb842so10412565ad.1
 for <dev@dpdk.org>; Fri, 04 Jul 2025 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751647343; x=1752252143; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KlbKfSwMD2bQPGsPbJeaVZojE6svekxR35vGKbtJL3g=;
 b=LwS8+UgEAty0VkzRgq8Y+8IK9TyoiDZJA5ioWYVIdelAuNyQf7Op7cmwohCa/a1rne
 UJMf4IysjwTdUybzKrOL/+nEaK/QlNXGEn5twcbjMa0nxqvVcWGTtJ8CkZjyBM8KQHnG
 tX0yJHzi57/OCps6miBMfmiEIuDIRElputKlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751647343; x=1752252143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KlbKfSwMD2bQPGsPbJeaVZojE6svekxR35vGKbtJL3g=;
 b=bZEA811/yn4FnpQ2au5jqus9xqa14MYsWy4VuFaU3xGMXgKLTp3+eTCqLBwRKL+HuZ
 mDom0C+jDxU1a271jzJxciPQBo3y3Zzfg5w93OIU1x6qPho7z3ZbKEmgyT5Df5kH4jqZ
 Nabr6CsZH5S3OcYp8GGSJTGR5bk5YrRti7nX0dE4JZPuZ60dBpApWj5f4p3VpUjRL2BO
 rDzCHP5HxZNYB77NnoBxjJXcTOVnwzq80Z1qZk/TSqj4TVJuFJj3IFaYlrc+1xqYOBbf
 +oFIvsjuN8VieAtjfUvvPtps/1TmnciUNnGMFfRoe1ZZkt9mVM05dDiBhG20Mt8hbCKH
 EOHw==
X-Gm-Message-State: AOJu0YztlNQjxrQWs1xrYfnpv1YEd3Cpk+w5+nNmvxVCtfEndyfgvbLb
 C172xjS3znsHo4uNHP1Yn1NjxwaT3kARZMrpmWYyK65f7eYIOYLCTOrXibB3ciG3WktJjCAkASX
 T6VL6eAITbEmkdBkmbBQgCGsC9ipvAl4VtHHfp39++Q==
X-Gm-Gg: ASbGncvb5qwJ0e4Y7MxneRxux+pTGKTys4ldf2YLI4eQP9Jwa7V2RC4Uy17uQpdgMih
 HC0BqeClCE0LsYcEEN1PZrxKtGjjb/S9pDLbybIIyy2b2L9zVSmBF0ot2XwDt61FtWa2rNZ16bQ
 chu1TLrwtkBeDAycIo3FUUw3QgLQEUqPjn5vRBWdSUOpaxIhKb06/cDvZ+qDM=
X-Google-Smtp-Source: AGHT+IH75W3TPdzwRFPnVY9wrN3tyms1s9VfHMcSEXjSDWxNlzHPrerXOlXWYULxdd8pzaymBah4l5r3pCV6qmGyq1Q=
X-Received: by 2002:a17:90b:2dcd:b0:312:e9d:4002 with SMTP id
 98e67ed59e1d1-31aaddba55cmr3643047a91.28.1751647342758; Fri, 04 Jul 2025
 09:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250702164204.607685-1-luca.vizzarro@arm.com>
 <20250704152908.683265-1-luca.vizzarro@arm.com>
 <20250704152908.683265-2-luca.vizzarro@arm.com>
In-Reply-To: <20250704152908.683265-2-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 4 Jul 2025 12:36:45 -0400
X-Gm-Features: Ac12FXwxc49RK5sn-Of1GXKDa4RSGJlCMkBrCsfv4uQ-bSUEimf5dOxh01jGaIk
Message-ID: <CAJvnSUA9oW+zFqjRDF09Q9wm4OgtWBZ=ipeqKJT9VhqAikdKug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dts: remove dpdk example build function
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000a324b906391d2d07"
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

--000000000000a324b906391d2d07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to next-dts, thanks.

On Fri, Jul 4, 2025 at 11:30=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:

> Usage of example DPDK apps should be avoided. Therefore, remove
> the function that allows to build example apps. Moreover,
> provide a dedicated helper function to retrieve the path to a
> DPDK app.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  dts/framework/remote_session/dpdk.py | 33 +++-------------------------
>  1 file changed, 3 insertions(+), 30 deletions(-)
>
> diff --git a/dts/framework/remote_session/dpdk.py
> b/dts/framework/remote_session/dpdk.py
> index e00c4a9bf9..606d6e22fe 100644
> --- a/dts/framework/remote_session/dpdk.py
> +++ b/dts/framework/remote_session/dpdk.py
> @@ -267,36 +267,9 @@ def _build_dpdk(self) -> None:
>              self.remote_dpdk_build_dir,
>          )
>
> -    def build_dpdk_app(self, app_name: str, **meson_dpdk_args: str |
> bool) -> PurePath:
> -        """Build one or all DPDK apps.
> -
> -        Requires DPDK to be already built on the SUT node.
> -
> -        Args:
> -            app_name: The name of the DPDK app to build.
> -                When `app_name` is ``all``, build all example apps.
> -            meson_dpdk_args: The arguments found in ``meson_options.txt`=
`
> in root DPDK directory.
> -                Do not use ``-D`` with them.
> -
> -        Returns:
> -            The directory path of the built app. If building all apps,
> return
> -            the path to the examples directory (where all apps reside).
> -        """
> -        self._session.build_dpdk(
> -            self._env_vars,
> -            MesonArgs(examples=3Dapp_name, **meson_dpdk_args),  # type:
> ignore [arg-type]
> -            # ^^ https://github.com/python/mypy/issues/11583
> -            self.remote_dpdk_tree_path,
> -            self.remote_dpdk_build_dir,
> -            rebuild=3DTrue,
> -            timeout=3Dself._app_compile_timeout,
> -        )
> -
> -        if app_name =3D=3D "all":
> -            return
> self._session.join_remote_path(self.remote_dpdk_build_dir, "examples")
> -        return self._session.join_remote_path(
> -            self.remote_dpdk_build_dir, "examples", f"dpdk-{app_name}"
> -        )
> +    def get_app(self, app_name: str) -> PurePath:
> +        """Retrieve path for a DPDK app."""
> +        return self._session.join_remote_path(self.remote_dpdk_build_dir=
,
> "app", f"dpdk-{app_name}")
>
>      @cached_property
>      def remote_dpdk_tree_path(self) -> PurePath:
> --
> 2.43.0
>
>

--000000000000a324b906391d2d07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied to next-dts, thanks.</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, =
Jul 4, 2025 at 11:30=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:luca.vi=
zzarro@arm.com">luca.vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Usage of example DPDK apps should be a=
voided. Therefore, remove<br>
the function that allows to build example apps. Moreover,<br>
provide a dedicated helper function to retrieve the path to a<br>
DPDK app.<br>
<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
---<br>
=C2=A0dts/framework/remote_session/dpdk.py | 33 +++------------------------=
-<br>
=C2=A01 file changed, 3 insertions(+), 30 deletions(-)<br>
<br>
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_se=
ssion/dpdk.py<br>
index e00c4a9bf9..606d6e22fe 100644<br>
--- a/dts/framework/remote_session/dpdk.py<br>
+++ b/dts/framework/remote_session/dpdk.py<br>
@@ -267,36 +267,9 @@ def _build_dpdk(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.remote_dpdk_build_dir,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 def build_dpdk_app(self, app_name: str, **meson_dpdk_args: s=
tr | bool) -&gt; PurePath:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Build one or all DPDK apps.<=
br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Requires DPDK to be already built on the SUT n=
ode.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 app_name: The name of the DPDK a=
pp to build.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 When `app_name` is=
 ``all``, build all example apps.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 meson_dpdk_args: The arguments f=
ound in ``meson_options.txt`` in root DPDK directory.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Do not use ``-D`` =
with them.<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The directory path of the built =
app. If building all apps, return<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the path to the examples directo=
ry (where all apps reside).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._session.build_dpdk(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._env_vars,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MesonArgs(examples=3Dapp_name, *=
*meson_dpdk_args),=C2=A0 # type: ignore [arg-type]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # ^^ <a href=3D"https://github.c=
om/python/mypy/issues/11583" rel=3D"noreferrer" target=3D"_blank">https://g=
ithub.com/python/mypy/issues/11583</a><br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.remote_dpdk_tree_path,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.remote_dpdk_build_dir,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rebuild=3DTrue,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout=3Dself._app_compile_time=
out,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if app_name =3D=3D &quot;all&quot;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._session.join_remote=
_path(self.remote_dpdk_build_dir, &quot;examples&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._session.join_remote_path(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.remote_dpdk_build_dir, &quo=
t;examples&quot;, f&quot;dpdk-{app_name}&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 def get_app(self, app_name: str) -&gt; PurePath:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Retrieve path for a DPDK app=
.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._session.join_remote_path(self.rem=
ote_dpdk_build_dir, &quot;app&quot;, f&quot;dpdk-{app_name}&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@cached_property<br>
=C2=A0 =C2=A0 =C2=A0def remote_dpdk_tree_path(self) -&gt; PurePath:<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000a324b906391d2d07--
