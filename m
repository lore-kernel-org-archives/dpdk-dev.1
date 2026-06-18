Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0253CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 19:00:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 416DE40A8A;
	Thu, 18 Jun 2026 21:00:22 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 937F740679
 for <dev@dpdk.org>; Thu, 18 Jun 2026 21:00:20 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-918559ee2a8so190920385a.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 12:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781809220; cv=none;
 d=google.com; s=arc-20240605;
 b=Rph5vv9vSIvXwNiIgiH4R33it0kIKL85bmMoNVYgMp0J8kj8T7jFQyNdAUBM/Pxv2x
 uoI4pYOrXU1JzGaPB05E22I3mm185CTSENrl34KyoqGIV87InZWAy5s56D7YWT6E+ZiP
 EK2hIPvsDoS9ObG3Anypy3fSqQLbHnnKBaAB763Y35Xk+DqVW/8/dBmumz2UMBI3dTwl
 sBSYImhs7JEYpQg6iN+kuHKqlEe512z8j4QvI0q0ufppdAUPIk/r+TS03FGgkTkUBuRR
 lja8xHMGLEF0dNNnH5iWYrGYfVX/qij8DFPvnjL7NxwDAMbYlwv28rBEn0z5/F/TcnlI
 e/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gCq4zYqi7leHPBByY05GkFsiKJwRrcOk2VrS8JMvS7k=;
 fh=vaLxhdRJyM7czFTZ1rXyniaP+lGsRee4DTjo5W83h2o=;
 b=cHyJF7mDyHl4rCRUvFZ7KwsCZnjkWZZTvcNXUif8qibpx3D/VB8L+fRu/Hqf+hZ3dl
 2gCiuMlpznO4cAQht7irf+SZkY2pVQ8/VMezgs9Y5KMkG6yNBrMHIo/KGmlrvBGPGhY0
 wgCwAyZxvp2XYePBhkHZCWZLD6bViMVTyYgWQ4cJBZdMSXWyjlpuOPE09MWgwzQqQVVK
 sMALhALJwZ/TlFXxLgG8R7tTTiTiHVWCKrYltKd71h0uJHq1fLSKwH/Uo8yMtDP20O+t
 wQ2a3oYqXr8lALCXSB6yE19lBpkWS8TDEAkKXX64n8l8qE8Exfm/xuL4Ez7ryDtbqrjt
 Joqw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781809220; x=1782414020; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gCq4zYqi7leHPBByY05GkFsiKJwRrcOk2VrS8JMvS7k=;
 b=GnJsVPrd328mNkrPeyZ63hPs9c+qeRV0BAu3rKn6lCxE4DnEnxRvR1KsErB3d1BxFJ
 wbDKzcb0pUF6GQn4aY75hVETZaNmxjL6p0Z8qhpSU0YyoM+23xLxaj9kdbtEoDSmT5TR
 PaSdcHzumiOhuOxgteAZHKB+QxYcRDknzI3nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781809220; x=1782414020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCq4zYqi7leHPBByY05GkFsiKJwRrcOk2VrS8JMvS7k=;
 b=WFwqeuvriTkDJRBkWpXh64HpHIJO2+Bf9KK3U/kK4mIG/tFGnPo+8FeJQEzBkcbG26
 omory3fcjbNoq8n5Irg19b4wxyzPlkdjDsfaTyx+R5tZnYFNwPmXWeDY+ldjEbxm0LaW
 MYZV5jMJaZ79VZAF8xZAhcoy5EfaZ2v26IU4LT4/uGhrqdnTtNQhHef8Hy+s4scrWFx0
 W24LSPJpjPSy9FlHJpwGr24kHy6fQCwiIVqwcnRxZrzygDpb7B/dkw7bEzZCkUFW1ErR
 GD9qank76OFfVzDTIthw8DcaMArWHm0VbWxX24C6SLlKZQyCmRRgM8tw7FIdVPTZIptS
 0efw==
X-Gm-Message-State: AOJu0Yz/hjlZhqzyNsEgwTq/btdAB9UgeD1EuVlDQc+pmHUflos4oRLx
 bJ9q3jw4wiYbWpeLN7TONwS11qAkGIqlLXGe4v48/pXEMI4IdPF74QcYpRYhWjfENvOuolv3+7f
 fIS5mMydTRbmBY+g4SHM/tToWMQpLY9Q1F6dOFbMecg==
X-Gm-Gg: AfdE7clg0kRJajTcaeHJn7Gl5XZsbj4pHsV2UZ8Yt/aREgXD+mm8eBlyDJf23noZ0Ax
 dyHTYyNVQg3LKo8NC4efbsWLRfNcbxKbDV4fyO//t7JFoxhM1/UQ0/91HgoZDpya24wu30vhZBF
 MlsPEwIk0Io09jmOZCA+IqB0vy6SClweTpyTAKS5REc1jbOaj5wq/ynqqeJS6e5a7ryrlyyXhYA
 f0s8wIBdqbFKLFLsd2GITMLlw4rCMmmf5O5IuvRkJVxeT4asBqL8B5kE3Wm6SHePLkjvHnfmuK1
 rfUCbZw2E2rWPsxEZcTJOSx7VOEXzZ8SDEmAK71d8iyHaW/98NTCaDR/x/Ov7jI/F+oejWO+4qZ
 b4aP2wCJj1gXLbtZNN0K6gu+jOibl4pcB6tONg5UNgo3F0VXq7SexJt35fon6Xw==
X-Received: by 2002:a05:620a:d8d:b0:915:8502:f808 with SMTP id
 af79cd13be357-920901f5979mr36324585a.25.1781809217376; Thu, 18 Jun 2026
 12:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260609143647.1434076-1-knimoji@iol.unh.edu>
 <20260609143647.1434076-2-knimoji@iol.unh.edu>
In-Reply-To: <20260609143647.1434076-2-knimoji@iol.unh.edu>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Thu, 18 Jun 2026 14:59:41 -0400
X-Gm-Features: AVVi8CdtpD-Rsv6KLOd6YXTm9MDEK-jSbKtwflRoCWxTTFexFGQKN5wAi7NdwP0
Message-ID: <CAKYPG+wCVjqCyHOA+nEfJzeiix5r4Kg=TVHSi2dusruhZ9raeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: add build arguments to test run configuration
To: luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu, 
 lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000075a6cd06548bc963"
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

--00000000000075a6cd06548bc963
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Recheck-request: github-robot: build

On Tue, Jun 9, 2026 at 10:36=E2=80=AFAM Koushik Bhargav Nimoji <knimoji@iol=
.unh.edu>
wrote:

> This patch adds the ability to specify build arguments when building DPDK
> through DTS. Doing so allows users to build DPDK with the desired build
> arguments, which allows for a more configurable DTS run.
>
> Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
> ---
>  dts/configurations/test_run.example.yaml | 13 +++++++++++++
>  dts/framework/config/test_run.py         |  2 ++
>  dts/framework/remote_session/dpdk.py     | 12 ++++++++----
>  dts/framework/utils.py                   | 21 ++++++++++++++++++++-
>  4 files changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/dts/configurations/test_run.example.yaml
> b/dts/configurations/test_run.example.yaml
> index ee641f5dce..0bd5151801 100644
> --- a/dts/configurations/test_run.example.yaml
> +++ b/dts/configurations/test_run.example.yaml
> @@ -16,6 +16,8 @@
>  #       `precompiled_build_dir` or `build_options` can be defined, but
> not both.
>  #   `compiler_wrapper`:
>  #       Optional, adds a compiler wrapper if present.
> +#   `build_args`:
> +#       The additional build arguments to be used when building DPDK.
>  #   `func_traffic_generator` & `perf_traffic_generator`:
>  #       Define `func_traffic_generator` when `func` set to true.
>  #       Define `perf_traffic_generator` when `perf` set to true.
> @@ -40,6 +42,17 @@ dpdk:
>        # the combination of the following two makes CC=3D"ccache gcc"
>        compiler: gcc
>        compiler_wrapper: ccache # see `Optional Fields`
> +      # arguments to be used when building DPDK
> +      # build_args:
> +      #   c_args:
> +      #     - O3
> +      #     - g
> +      #   b_coverage:
> +      #     - "true"
> +      #   buildtype:
> +      #     - release
> +      #   flags:
> +      #     - strip
>  func_traffic_generator:
>    type: SCAPY
>  # perf_traffic_generator:
> diff --git a/dts/framework/config/test_run.py
> b/dts/framework/config/test_run.py
> index 76e24d1785..eab12041fc 100644
> --- a/dts/framework/config/test_run.py
> +++ b/dts/framework/config/test_run.py
> @@ -191,6 +191,8 @@ class DPDKBuildOptionsConfiguration(FrozenModel):
>      #: This string will be put in front of the compiler when executing
> the build. Useful for adding
>      #: wrapper commands, such as ``ccache``.
>      compiler_wrapper: str =3D ""
> +    #: The build arguments to build dpdk with
> +    build_args: dict[str, list[str]] =3D {}
>
>
>  class DPDKUncompiledBuildConfiguration(BaseDPDKBuildConfiguration):
> diff --git a/dts/framework/remote_session/dpdk.py
> b/dts/framework/remote_session/dpdk.py
> index 865f97f6ca..4dc0ceeaaf 100644
> --- a/dts/framework/remote_session/dpdk.py
> +++ b/dts/framework/remote_session/dpdk.py
> @@ -100,8 +100,8 @@ def setup(self) -> None:
>          match self.config:
>              case
> DPDKPrecompiledBuildConfiguration(precompiled_build_dir=3Dbuild_dir):
>                  self._set_remote_dpdk_build_dir(build_dir)
> -            case
> DPDKUncompiledBuildConfiguration(build_options=3Dbuild_options):
> -                self._configure_dpdk_build(build_options)
> +            case DPDKUncompiledBuildConfiguration():
> +                self._configure_dpdk_build(self.config.build_options)
>                  self._build_dpdk()
>
>      def teardown(self) -> None:
> @@ -277,16 +277,20 @@ def _build_dpdk(self) -> None:
>          `remote_dpdk_tree_path` has already been set on the SUT node.
>          """
>          ctx =3D get_ctx()
> +        build_options =3D getattr(self.config, "build_options")
>          # If the SUT is an ice driver device, make sure to build with 16=
B
> descriptors.
>          if (
>              ctx.topology.sut_port_ingress
>              and ctx.topology.sut_port_ingress.config.os_driver =3D=3D "i=
ce"
>          ):
>              meson_args =3D MesonArgs(
> -                default_library=3D"static", libdir=3D"lib",
> c_args=3D"-DRTE_NET_INTEL_USE_16BYTE_DESC"
> +                build_options.build_args,
> +                default_library=3D"static",
> +                libdir=3D"lib",
> +                c_args=3D"-DRTE_NET_INTEL_USE_16BYTE_DESC",
>              )
>          else:
> -            meson_args =3D MesonArgs(default_library=3D"static", libdir=
=3D"lib")
> +            meson_args =3D MesonArgs(build_options.build_args,
> default_library=3D"static", libdir=3D"lib")
>
>          if SETTINGS.code_coverage:
>              meson_args._add_arg("-Db_coverage=3Dtrue")
> diff --git a/dts/framework/utils.py b/dts/framework/utils.py
> index 38da88cd9c..e0ed35066c 100644
> --- a/dts/framework/utils.py
> +++ b/dts/framework/utils.py
> @@ -99,10 +99,16 @@ class MesonArgs:
>
>      _default_library: str
>
> -    def __init__(self, default_library: str | None =3D None, **dpdk_args=
:
> str | bool):
> +    def __init__(
> +        self,
> +        dpdk_build_args: dict[str, list[str]],
> +        default_library: str | None =3D None,
> +        **dpdk_args: str | bool,
> +    ):
>          """Initialize the meson arguments.
>
>          Args:
> +            dpdk_build_args: The DPDK build arguments specified in the
> test run configuration file.
>              default_library: The default library type, Meson supports
> ``shared``, ``static`` and
>                  ``both``. Defaults to :data:`None`, in which case the
> argument won't be used.
>              dpdk_args: The arguments found in ``meson_options.txt`` in
> root DPDK directory.
> @@ -121,6 +127,19 @@ def __init__(self, default_library: str | None =3D
> None, **dpdk_args: str | bool):
>              )
>          )
>
> +        arguments =3D []
> +        for option, value in dpdk_build_args.items():
> +            if option =3D=3D "c_args":
> +                values =3D " ".join(f"-{val}" for val in value)
> +                arguments.append(f'-D{option}=3D"{values}"')
> +            elif option =3D=3D "flags":
> +                values =3D " ".join(f"--{val}" for val in value)
> +                arguments.append(values)
> +            else:
> +                arguments.append(f" -D{option}=3D{value[0]}")
> +
> +        self._dpdk_args =3D " ".join(arguments)
> +
>      def __str__(self) -> str:
>          """The actual args."""
>          return " ".join(f"{self._default_library}
> {self._dpdk_args}".split())
> --
> 2.54.0
>
>

--00000000000075a6cd06548bc963
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0<span style=3D"color:rgb(51,51,51);f=
ont-family:&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:=
14px">github-robot: build</span></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 9, 2026 at 10:36=E2=80=AFAM Kou=
shik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh.edu" target=3D"_b=
lank">knimoji@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">This patch adds the ability to specify build argum=
ents when building DPDK<br>
through DTS. Doing so allows users to build DPDK with the desired build<br>
arguments, which allows for a more configurable DTS run.<br>
<br>
Signed-off-by: Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh=
.edu" target=3D"_blank">knimoji@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/configurations/test_run.example.yaml | 13 +++++++++++++<br>
=C2=A0dts/framework/config/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 ++<br>
=C2=A0dts/framework/remote_session/dpdk.py=C2=A0 =C2=A0 =C2=A0| 12 ++++++++=
----<br>
=C2=A0dts/framework/utils.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 21 ++++++++++++++++++++-<br>
=C2=A04 files changed, 43 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/dts/configurations/test_run.example.yaml b/dts/configurations/=
test_run.example.yaml<br>
index ee641f5dce..0bd5151801 100644<br>
--- a/dts/configurations/test_run.example.yaml<br>
+++ b/dts/configurations/test_run.example.yaml<br>
@@ -16,6 +16,8 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0`precompiled_build_dir` or `build_options=
` can be defined, but not both.<br>
=C2=A0#=C2=A0 =C2=A0`compiler_wrapper`:<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0Optional, adds a compiler wrapper if pres=
ent.<br>
+#=C2=A0 =C2=A0`build_args`:<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0The additional build arguments to be used when=
 building DPDK.<br>
=C2=A0#=C2=A0 =C2=A0`func_traffic_generator` &amp; `perf_traffic_generator`=
:<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0Define `func_traffic_generator` when `fun=
c` set to true.<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0Define `perf_traffic_generator` when `per=
f` set to true.<br>
@@ -40,6 +42,17 @@ dpdk:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0# the combination of the following two makes CC=
=3D&quot;ccache gcc&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: gcc<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler_wrapper: ccache # see `Optional Fields`=
<br>
+=C2=A0 =C2=A0 =C2=A0 # arguments to be used when building DPDK<br>
+=C2=A0 =C2=A0 =C2=A0 # build_args:<br>
+=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0c_args:<br>
+=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0- O3<br>
+=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0- g<br>
+=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0b_coverage:<br>
+=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0- &quot;true&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0buildtype:<br>
+=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0- release<br>
+=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0flags:<br>
+=C2=A0 =C2=A0 =C2=A0 #=C2=A0 =C2=A0 =C2=A0- strip<br>
=C2=A0func_traffic_generator:<br>
=C2=A0 =C2=A0type: SCAPY<br>
=C2=A0# perf_traffic_generator:<br>
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_r=
un.py<br>
index 76e24d1785..eab12041fc 100644<br>
--- a/dts/framework/config/test_run.py<br>
+++ b/dts/framework/config/test_run.py<br>
@@ -191,6 +191,8 @@ class DPDKBuildOptionsConfiguration(FrozenModel):<br>
=C2=A0 =C2=A0 =C2=A0#: This string will be put in front of the compiler whe=
n executing the build. Useful for adding<br>
=C2=A0 =C2=A0 =C2=A0#: wrapper commands, such as ``ccache``.<br>
=C2=A0 =C2=A0 =C2=A0compiler_wrapper: str =3D &quot;&quot;<br>
+=C2=A0 =C2=A0 #: The build arguments to build dpdk with<br>
+=C2=A0 =C2=A0 build_args: dict[str, list[str]] =3D {}<br>
<br>
<br>
=C2=A0class DPDKUncompiledBuildConfiguration(BaseDPDKBuildConfiguration):<b=
r>
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_se=
ssion/dpdk.py<br>
index 865f97f6ca..4dc0ceeaaf 100644<br>
--- a/dts/framework/remote_session/dpdk.py<br>
+++ b/dts/framework/remote_session/dpdk.py<br>
@@ -100,8 +100,8 @@ def setup(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0match self.config:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case DPDKPrecompiledBuildCo=
nfiguration(precompiled_build_dir=3Dbuild_dir):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._set_rem=
ote_dpdk_build_dir(build_dir)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case DPDKUncompiledBuildConfigur=
ation(build_options=3Dbuild_options):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._configure_dp=
dk_build(build_options)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case DPDKUncompiledBuildConfigur=
ation():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._configure_dp=
dk_build(self.config.build_options)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._build_d=
pdk()<br>
<br>
=C2=A0 =C2=A0 =C2=A0def teardown(self) -&gt; None:<br>
@@ -277,16 +277,20 @@ def _build_dpdk(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0`remote_dpdk_tree_path` has already been =
set on the SUT node.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx =3D get_ctx()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_options =3D getattr(self.config, &quot;b=
uild_options&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# If the SUT is an ice driver device, mak=
e sure to build with 16B descriptors.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx.topology.sut_port_ingre=
ss<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and ctx.topology.sut_port_i=
ngress.config.os_driver =3D=3D &quot;ice&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson_args =3D MesonArgs(<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_library=3D=
&quot;static&quot;, libdir=3D&quot;lib&quot;, c_args=3D&quot;-DRTE_NET_INTE=
L_USE_16BYTE_DESC&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_options.buil=
d_args,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default_library=3D=
&quot;static&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 libdir=3D&quot;lib=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c_args=3D&quot;-DR=
TE_NET_INTEL_USE_16BYTE_DESC&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 meson_args =3D MesonArgs(default=
_library=3D&quot;static&quot;, libdir=3D&quot;lib&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 meson_args =3D MesonArgs(build_o=
ptions.build_args, default_library=3D&quot;static&quot;, libdir=3D&quot;lib=
&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if SETTINGS.code_coverage:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0meson_args._add_arg(&quot;-=
Db_coverage=3Dtrue&quot;)<br>
diff --git a/dts/framework/utils.py b/dts/framework/utils.py<br>
index 38da88cd9c..e0ed35066c 100644<br>
--- a/dts/framework/utils.py<br>
+++ b/dts/framework/utils.py<br>
@@ -99,10 +99,16 @@ class MesonArgs:<br>
<br>
=C2=A0 =C2=A0 =C2=A0_default_library: str<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, default_library: str | None =3D None, **d=
pdk_args: str | bool):<br>
+=C2=A0 =C2=A0 def __init__(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpdk_build_args: dict[str, list[str]],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default_library: str | None =3D None,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 **dpdk_args: str | bool,<br>
+=C2=A0 =C2=A0 ):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the meson ar=
guments.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dpdk_build_args: The DPDK build =
arguments specified in the test run configuration file.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default_library: The defaul=
t library type, Meson supports ``shared``, ``static`` and<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0``both``. Def=
aults to :data:`None`, in which case the argument won&#39;t be used.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dpdk_args: The arguments fo=
und in ``meson_options.txt`` in root DPDK directory.<br>
@@ -121,6 +127,19 @@ def __init__(self, default_library: str | None =3D Non=
e, **dpdk_args: str | bool):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arguments =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for option, value in dpdk_build_args.items():<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if option =3D=3D &quot;c_args&qu=
ot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 values =3D &quot; =
&quot;.join(f&quot;-{val}&quot; for val in value)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arguments.append(f=
&#39;-D{option}=3D&quot;{values}&quot;&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif option =3D=3D &quot;flags&q=
uot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 values =3D &quot; =
&quot;.join(f&quot;--{val}&quot; for val in value)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arguments.append(v=
alues)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arguments.append(f=
&quot; -D{option}=3D{value[0]}&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._dpdk_args =3D &quot; &quot;.join(argumen=
ts)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def __str__(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The actual args.&quot;&=
quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return &quot; &quot;.join(f&quot;{self._d=
efault_library} {self._dpdk_args}&quot;.split())<br>
-- <br>
2.54.0<br>
<br>
</blockquote></div>

--00000000000075a6cd06548bc963--
