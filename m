Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04FFCD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:27:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDFE7402BE;
	Tue,  9 Jun 2026 16:27:53 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id B78574025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 16:27:51 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8cceaacd07bso60372426d6.3
 for <dev@dpdk.org>; Tue, 09 Jun 2026 07:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015271; cv=none;
 d=google.com; s=arc-20240605;
 b=Svj9D1vnG/DGsUwdfFkxyzqhn4rzH1KQ63+AzxLe5Rm9WldYdhHgKB+ZBxUyQnCF47
 R9fHDhqZ4IJbJ36pZVe+d0TWEeeDkYfxSBvkdLUybJliVbVvwELme/AZOes69W8UsL4+
 bdpaAnctV+Ubnqj7DIP369D9q81OTy7T7OelJH0FIYFhXwkypffa4jLinJuAxuaytIb4
 tUnwe4d4exE2o2q4eTvE25NYknM7sXhICofXscb92acbObaQpQo1TN+bLf6sWZfQrdJe
 CeJ2myTV0/C4ZHzt/SFJBzphlmumsSk1vkzduJHNap/TTFotom5DHXqkqgBHMYg0Q79d
 O+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=2ObjnoJFHo4mTkfKemZzlkdUPqRO36iSQOqY8uMwJ+A=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=GuLjOsepj2Qi2TurUV9Umey8QN//FWaeTamNPlIMXcYx/ipNQJCal5nGhDLpzYt3db
 RKES+jy4KdUDKxOF/eBOZUYFzOAS6428EXIX1h1nYMtrpw8FJrFoa5dZJRxpy9nNxe8v
 muTCzu8WKjQAKIMnU5YxgtX2uXHQcPW+VxYAUIQ1p/vJ7pdBG0YkVYDwLrEKMK+9M0EW
 lN74XwUo2Cnlp994UfBrKIUelGDZRs12ktipCGSOiOJ9n8qcenfGIj9147iPABb9s7Hm
 FKuCXLo2kQ4/qmSwzTJTjDUdaHNNHmozgRPHuoZV5vrL6hSpWs+HEbVr3m/ysOgU/Fxn
 xvfQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781015271; x=1781620071; darn=dpdk.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ObjnoJFHo4mTkfKemZzlkdUPqRO36iSQOqY8uMwJ+A=;
 b=FaSbOccYatqQ8uRitOubKcY1IGSiz64XPutpX0b826WVcCjY7icP810GbM/Pa1w3MJ
 BbXD8hkiqAAaBYUiBhsrmvpaktTEBsQvb9s55JPFwOeb3tGspRxXHtYnDUPZSYozpUor
 P5P3x8pt0CRKiRuSVSdVfrC0CoF5wrpkDPzCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015271; x=1781620071;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ObjnoJFHo4mTkfKemZzlkdUPqRO36iSQOqY8uMwJ+A=;
 b=nV/cwCutJ0sbSMPTsxvlrp6DT5c/Deys6yQgMbIrM7y0A6nYo7LAG/jLueFIfBPwF5
 Iptjhz6OpGsw6gTiNWFf3diMJZjoZ5Oooa1RqWIiabKHLjVqZSEXU2ociNPWfu3gpQ3U
 46Hgk9MvPXugX1Wifr42lcq0ZS1zSaq4Piw5ghV+gll5iG0nSJzwOYwj0lJnw7dlTOiJ
 Xb1YA2g5S7l1eQZmzksSE3lD151prCLNKPukNPiA50suO5bBYQ+7T34TXfFMZrIUworL
 QmVbyzUAbdZ0CnGRVSRIegFrqEmEJ2xkDU/6YZrj7aM6KGcS+bwLDl+dWn8UZIxvf0Mp
 DueA==
X-Gm-Message-State: AOJu0YwqpWVwVeBhJcPEQzccFxPuUBTfIFM6GY9GPhLFAOcV//eo3y2A
 nXQcVKoD3wIFZngh/MFWy4FXLyW5qeLNctj4e04dm5wyho+qS3AQbLga3i8Il+W9cJu6OumELng
 FQW08qzzdwVqzBO6fi+Z9c1EWideB4deK4/NTofVfeDjL+fugP5So
X-Gm-Gg: Acq92OHvJyPIRgJ+Ih11ZlTz/nclOCSJdrHAyIaHxdwVH0g7R1lDRgJ5MjI1vMJ84HR
 ojveNzJ9geIMPaPl4QdEiwfM67CKVKHzIoFzZI0e+qysH4ChSXQ7H8aquI/ovyfLfrR9EAq1bxM
 YpqJ+XypIVG9kQ52jwoobFW7k7sBNn9X28IzMFZHIFc1rUHWtv6WUwK0P1O57nbFZ9EifRg0t5a
 Q4Eyv4+QMMPtwB4qwSPVqeHHQjdSy9MZ727QxvXRNiV19YRceidgJcaj6a/cu4d+DAm1k9bzrcE
 k8fKdu1vjsYNeV22G8CrSmClmshFAn8Dtl0R10CEzXr7h29BELP2MCyu9wl17zQl/hFu191rugP
 zjrXuXXxaU7jrCQcMRv2CaW0DtgMTxoFF7jmbeyyxY4NGO81Wm9MIXUb3o59bWR9UD5SkHvEMnG
 Fs3CyocfM=
X-Received: by 2002:ac8:59d6:0:b0:50b:38c1:c6a with SMTP id
 d75a77b69052e-517959fdda5mr273143891cf.19.1781015270691; Tue, 09 Jun 2026
 07:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260608132303.1099012-1-knimoji@iol.unh.edu>
 <20260608132303.1099012-2-knimoji@iol.unh.edu>
In-Reply-To: <20260608132303.1099012-2-knimoji@iol.unh.edu>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 9 Jun 2026 10:27:14 -0400
X-Gm-Features: AVVi8CeDMEsTvXbI88WBj_tnLM7cqxw14Frz6a4IrLp-th_smTUh4VFuE6SYZrQ
Message-ID: <CAKYPG+wAOXU4rcbwDU9A8+7+S6JRWYZJcFGNnCrK_J9Uq2WchA@mail.gmail.com>
Subject: Fwd: [PATCH v1 2/2] dts: add build arguments to test run configuration
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000008ca5ee0653d2ee17"
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

--0000000000008ca5ee0653d2ee17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Mon, Jun 8, 2026 at 9:23=E2=80=AFAM
Subject: [PATCH v1 2/2] dts: add build arguments to test run configuration
To: <luca.vizzarro@arm.com>, <patrickrobb1997@gmail.com>
Cc: <abailey@iol.unh.edu>, <ahassick@iol.unh.edu>, <lylavoie@iol.unh.edu>,
Koushik Bhargav Nimoji <knimoji@iol.unh.edu>


This patch adds the ability to specify build arguments when building DPDK
through DTS. Doing so allows users to build DPDK with the desired build
arguments, which allows for a more configurable DTS run.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 dts/configurations/test_run.example.yaml | 13 +++++++++++++
 dts/framework/config/test_run.py         |  2 ++
 dts/framework/remote_session/dpdk.py     | 12 ++++++++----
 dts/framework/utils.py                   | 21 ++++++++++++++++++++-
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/dts/configurations/test_run.example.yaml
b/dts/configurations/test_run.example.yaml
index ee641f5dce..0bd5151801 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -16,6 +16,8 @@
 #       `precompiled_build_dir` or `build_options` can be defined, but not
both.
 #   `compiler_wrapper`:
 #       Optional, adds a compiler wrapper if present.
+#   `build_args`:
+#       The additional build arguments to be used when building DPDK.
 #   `func_traffic_generator` & `perf_traffic_generator`:
 #       Define `func_traffic_generator` when `func` set to true.
 #       Define `perf_traffic_generator` when `perf` set to true.
@@ -40,6 +42,17 @@ dpdk:
       # the combination of the following two makes CC=3D"ccache gcc"
       compiler: gcc
       compiler_wrapper: ccache # see `Optional Fields`
+      # arguments to be used when building DPDK
+      # build_args:
+      #   c_args:
+      #     - O3
+      #     - g
+      #   b_coverage:
+      #     - "true"
+      #   buildtype:
+      #     - release
+      #   flags:
+      #     - strip
 func_traffic_generator:
   type: SCAPY
 # perf_traffic_generator:
diff --git a/dts/framework/config/test_run.py
b/dts/framework/config/test_run.py
index 76e24d1785..eab12041fc 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -191,6 +191,8 @@ class DPDKBuildOptionsConfiguration(FrozenModel):
     #: This string will be put in front of the compiler when executing the
build. Useful for adding
     #: wrapper commands, such as ``ccache``.
     compiler_wrapper: str =3D ""
+    #: The build arguments to build dpdk with
+    build_args: dict[str, list[str]] =3D {}


 class DPDKUncompiledBuildConfiguration(BaseDPDKBuildConfiguration):
diff --git a/dts/framework/remote_session/dpdk.py
b/dts/framework/remote_session/dpdk.py
index 865f97f6ca..4dc0ceeaaf 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -100,8 +100,8 @@ def setup(self) -> None:
         match self.config:
             case
DPDKPrecompiledBuildConfiguration(precompiled_build_dir=3Dbuild_dir):
                 self._set_remote_dpdk_build_dir(build_dir)
-            case
DPDKUncompiledBuildConfiguration(build_options=3Dbuild_options):
-                self._configure_dpdk_build(build_options)
+            case DPDKUncompiledBuildConfiguration():
+                self._configure_dpdk_build(self.config.build_options)
                 self._build_dpdk()

     def teardown(self) -> None:
@@ -277,16 +277,20 @@ def _build_dpdk(self) -> None:
         `remote_dpdk_tree_path` has already been set on the SUT node.
         """
         ctx =3D get_ctx()
+        build_options =3D getattr(self.config, "build_options")
         # If the SUT is an ice driver device, make sure to build with 16B
descriptors.
         if (
             ctx.topology.sut_port_ingress
             and ctx.topology.sut_port_ingress.config.os_driver =3D=3D "ice=
"
         ):
             meson_args =3D MesonArgs(
-                default_library=3D"static", libdir=3D"lib",
c_args=3D"-DRTE_NET_INTEL_USE_16BYTE_DESC"
+                build_options.build_args,
+                default_library=3D"static",
+                libdir=3D"lib",
+                c_args=3D"-DRTE_NET_INTEL_USE_16BYTE_DESC",
             )
         else:
-            meson_args =3D MesonArgs(default_library=3D"static", libdir=3D=
"lib")
+            meson_args =3D MesonArgs(build_options.build_args,
default_library=3D"static", libdir=3D"lib")

         if SETTINGS.code_coverage:
             meson_args._add_arg("-Db_coverage=3Dtrue")
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index 38da88cd9c..e0ed35066c 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -99,10 +99,16 @@ class MesonArgs:

     _default_library: str

-    def __init__(self, default_library: str | None =3D None, **dpdk_args:
str | bool):
+    def __init__(
+        self,
+        dpdk_build_args: dict[str, list[str]],
+        default_library: str | None =3D None,
+        **dpdk_args: str | bool,
+    ):
         """Initialize the meson arguments.

         Args:
+            dpdk_build_args: The DPDK build arguments specified in the
test run configuration file.
             default_library: The default library type, Meson supports
``shared``, ``static`` and
                 ``both``. Defaults to :data:`None`, in which case the
argument won't be used.
             dpdk_args: The arguments found in ``meson_options.txt`` in
root DPDK directory.
@@ -121,6 +127,19 @@ def __init__(self, default_library: str | None =3D Non=
e,
**dpdk_args: str | bool):
             )
         )

+        arguments =3D []
+        for option, value in dpdk_build_args.items():
+            if option =3D=3D "c_args":
+                values =3D " ".join(f"-{val}" for val in value)
+                arguments.append(f'-D{option}=3D"{values}"')
+            elif option =3D=3D "flags":
+                values =3D " ".join(f"--{val}" for val in value)
+                arguments.append(values)
+            else:
+                arguments.append(f" -D{option}=3D{value[0]}")
+
+        self._dpdk_args =3D " ".join(arguments)
+
     def __str__(self) -> str:
         """The actual args."""
         return " ".join(f"{self._default_library}
{self._dpdk_args}".split())
--=20
2.54.0

--0000000000008ca5ee0653d2ee17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">---------- Forwarded message ---------=
<br>From: <strong class=3D"gmail_sendername" dir=3D"auto">Koushik Bhargav N=
imoji</strong> <span dir=3D"auto">&lt;<a href=3D"mailto:knimoji@iol.unh.edu=
">knimoji@iol.unh.edu</a>&gt;</span><br>Date: Mon, Jun 8, 2026 at 9:23=E2=
=80=AFAM<br>Subject: [PATCH v1 2/2] dts: add build arguments to test run co=
nfiguration<br>To:  &lt;<a href=3D"mailto:luca.vizzarro@arm.com">luca.vizza=
rro@arm.com</a>&gt;,  &lt;<a href=3D"mailto:patrickrobb1997@gmail.com">patr=
ickrobb1997@gmail.com</a>&gt;<br>Cc:  &lt;<a href=3D"mailto:abailey@iol.unh=
.edu">abailey@iol.unh.edu</a>&gt;,  &lt;<a href=3D"mailto:ahassick@iol.unh.=
edu">ahassick@iol.unh.edu</a>&gt;,  &lt;<a href=3D"mailto:lylavoie@iol.unh.=
edu">lylavoie@iol.unh.edu</a>&gt;, Koushik Bhargav Nimoji &lt;<a href=3D"ma=
ilto:knimoji@iol.unh.edu">knimoji@iol.unh.edu</a>&gt;<br></div><br><br>This=
 patch adds the ability to specify build arguments when building DPDK<br>
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
</div></div>

--0000000000008ca5ee0653d2ee17--
