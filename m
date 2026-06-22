Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5B4CD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 17:02:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D53E540647;
	Mon, 22 Jun 2026 19:02:37 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id A36554060F
 for <dev@dpdk.org>; Mon, 22 Jun 2026 19:02:36 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-139b914bab6so1514792c88.1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782147755; x=1782752555; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kYFSwL72txGugI4ZKTGMdOCoAFv1IcZHD+/kq3nCRM=;
 b=D/PlPnnnimQgsf3YVMnaZcOI40TPou5tw2ViLxmBOwvqxJp2uxeOuTZMPb5GQ4JgQ/
 ieJO82282/kazVH4nWw4y/gmjeOWAQV1pgYI3ad0v/yqzXc2Ng+HLZxSzaslXdXHVZZx
 c6cqroreKQEhoIo4RbcWzclqC0X4LofySerhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782147755; x=1782752555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8kYFSwL72txGugI4ZKTGMdOCoAFv1IcZHD+/kq3nCRM=;
 b=G8xDv1GryhMLZHQD8Bz6qIzRQ285C/rT6awhU/A5okYm2eC/huQr+h078Yii60yCDT
 XTsVPvvw3m3PykPM7W8fghv9mnsnThmp9jFzokR7AenCsLI5kivchKCV2kGHLMMgr3wZ
 EIBmmGKmwr/KunIayCz6lZop+E5E2+MhKS5UXwBE1khPRGkeAP68Tr0tAXm76zvnKMxg
 6GhZl2Cv4ZgTuM3HWkMiVVmXvdtOA4FHPkHaO2kK+G6jbhYpH8I0Jm2VPS93sdPruQW8
 GoYfk4ssw0aK05SXdvbcYKKpGhWQ0jcP5bfd0M9/saqGePDFBoZR/fatyydaBlQke2fx
 hjPg==
X-Gm-Message-State: AOJu0YyKUSVDJpoJsp9ODyIREkMb7FpQfhZiv7JTP5PkJCo0cAPuNG0j
 NA+9KqmqMq93Ipt7QzoQ9F77k9gs39M3qu1uETECV+TPky6rZlX7+dzqqO+xYfiyRsc=
X-Gm-Gg: AfdE7clkJ4sIpbSRoULtkhOtJMMTMbYGTeddqz6tub967SnO6uN+MUIDnkmdQe2MhRB
 t2RAf1RDjFsLTGd9liF2x/uWS5sv1yYy+12hk6wf6dMzn1xcGRfLkb/HPFFHBmDDwkpXsrN5dOL
 JoZMdcOxdqcw1R1AL2Xb6R5CFJaZGkW6uZZcVCv9M0XsDhPZfP7WylWI2++BTNXqXqB1XcL7LWu
 vOYqdce/L5ZldiDn4J8TceEpj/8DeI0hQ2B7q9qyik6kBTtDDLk571jHwGwRDMCDlyE9Uc3ULFP
 O00Da/yVi9dD2VFKyUhs2ISwlQJTZGUyYBxoadWKbmyUQHRGGuzjP+VBVhrG4mmNSv51JKTAEfe
 oJ86tOrSV4TunQCw+SlKwq0NTm4572Qls1kWeOKEM8xhA5t2EnB6fpBdJxmTiUa0C9L+hX9S2/g
 xiCKum+FLQzqcR0JHaTmBnHMfE9VdJsnmOk+lys2+V5//Quoxvr/tb8wcfpt4FHelvov/ACJa8j
 dBqE0bQgAuorXn0mvsfICT3q2VdbImnXlbNmmMn/1Q43gMcAAe6fyslt+QTYsRY6+oOJdIDg4Ei
 ldbvRE5YsNAS3En5mAzBQ3bP
X-Received: by 2002:a05:7022:485:b0:138:243e:ceb1 with SMTP id
 a92af1059eb24-139a2033be2mr11062441c88.6.1782147754968; 
 Mon, 22 Jun 2026 10:02:34 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cde319sm100840426d6.31.2026.06.22.10.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 10:02:34 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v3 2/2] dts: add build arguments to test run configuration
Date: Mon, 22 Jun 2026 13:02:23 -0400
Message-ID: <20260622170223.1152746-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622170223.1152746-1-knimoji@iol.unh.edu>
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260622170223.1152746-1-knimoji@iol.unh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

diff --git a/dts/configurations/test_run.example.yaml b/dts/configurations/test_run.example.yaml
index ee641f5dce..0bd5151801 100644
--- a/dts/configurations/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -16,6 +16,8 @@
 #       `precompiled_build_dir` or `build_options` can be defined, but not both.
 #   `compiler_wrapper`:
 #       Optional, adds a compiler wrapper if present.
+#   `build_args`:
+#       The additional build arguments to be used when building DPDK.
 #   `func_traffic_generator` & `perf_traffic_generator`:
 #       Define `func_traffic_generator` when `func` set to true.
 #       Define `perf_traffic_generator` when `perf` set to true.
@@ -40,6 +42,17 @@ dpdk:
       # the combination of the following two makes CC="ccache gcc"
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
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 76e24d1785..eab12041fc 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -191,6 +191,8 @@ class DPDKBuildOptionsConfiguration(FrozenModel):
     #: This string will be put in front of the compiler when executing the build. Useful for adding
     #: wrapper commands, such as ``ccache``.
     compiler_wrapper: str = ""
+    #: The build arguments to build dpdk with
+    build_args: dict[str, list[str]] = {}
 
 
 class DPDKUncompiledBuildConfiguration(BaseDPDKBuildConfiguration):
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 865f97f6ca..4dc0ceeaaf 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -100,8 +100,8 @@ def setup(self) -> None:
         match self.config:
             case DPDKPrecompiledBuildConfiguration(precompiled_build_dir=build_dir):
                 self._set_remote_dpdk_build_dir(build_dir)
-            case DPDKUncompiledBuildConfiguration(build_options=build_options):
-                self._configure_dpdk_build(build_options)
+            case DPDKUncompiledBuildConfiguration():
+                self._configure_dpdk_build(self.config.build_options)
                 self._build_dpdk()
 
     def teardown(self) -> None:
@@ -277,16 +277,20 @@ def _build_dpdk(self) -> None:
         `remote_dpdk_tree_path` has already been set on the SUT node.
         """
         ctx = get_ctx()
+        build_options = getattr(self.config, "build_options")
         # If the SUT is an ice driver device, make sure to build with 16B descriptors.
         if (
             ctx.topology.sut_port_ingress
             and ctx.topology.sut_port_ingress.config.os_driver == "ice"
         ):
             meson_args = MesonArgs(
-                default_library="static", libdir="lib", c_args="-DRTE_NET_INTEL_USE_16BYTE_DESC"
+                build_options.build_args,
+                default_library="static",
+                libdir="lib",
+                c_args="-DRTE_NET_INTEL_USE_16BYTE_DESC",
             )
         else:
-            meson_args = MesonArgs(default_library="static", libdir="lib")
+            meson_args = MesonArgs(build_options.build_args, default_library="static", libdir="lib")
 
         if SETTINGS.code_coverage:
             meson_args._add_arg("-Db_coverage=true")
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index 38da88cd9c..e0ed35066c 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -99,10 +99,16 @@ class MesonArgs:
 
     _default_library: str
 
-    def __init__(self, default_library: str | None = None, **dpdk_args: str | bool):
+    def __init__(
+        self,
+        dpdk_build_args: dict[str, list[str]],
+        default_library: str | None = None,
+        **dpdk_args: str | bool,
+    ):
         """Initialize the meson arguments.
 
         Args:
+            dpdk_build_args: The DPDK build arguments specified in the test run configuration file.
             default_library: The default library type, Meson supports ``shared``, ``static`` and
                 ``both``. Defaults to :data:`None`, in which case the argument won't be used.
             dpdk_args: The arguments found in ``meson_options.txt`` in root DPDK directory.
@@ -121,6 +127,19 @@ def __init__(self, default_library: str | None = None, **dpdk_args: str | bool):
             )
         )
 
+        arguments = []
+        for option, value in dpdk_build_args.items():
+            if option == "c_args":
+                values = " ".join(f"-{val}" for val in value)
+                arguments.append(f'-D{option}="{values}"')
+            elif option == "flags":
+                values = " ".join(f"--{val}" for val in value)
+                arguments.append(values)
+            else:
+                arguments.append(f" -D{option}={value[0]}")
+
+        self._dpdk_args = " ".join(arguments)
+
     def __str__(self) -> str:
         """The actual args."""
         return " ".join(f"{self._default_library} {self._dpdk_args}".split())
-- 
2.54.0

