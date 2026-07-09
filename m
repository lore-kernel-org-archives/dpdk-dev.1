Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BC8C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 17:29:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A1C7402CC;
	Thu,  9 Jul 2026 19:29:24 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id A3EFB40268
 for <dev@dpdk.org>; Thu,  9 Jul 2026 19:29:22 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-51a868b6962so194741cf.2
 for <dev@dpdk.org>; Thu, 09 Jul 2026 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783618162; x=1784222962; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O5Hmfv3Sl4dkLocS5gwAMNuxNXOWwLcnKILxD37gDw4=;
 b=DBbfo0svUnZOrvgK33y3iPW0UtC52X5epsEX8x4x9/xrNCb9qaHOkhBo/dyOE9o+MX
 sKlU6NBTLK0OnbU+Vhyu/OpnUiLinXJdYVAB9y4h+Bxav9M7DB+11vf4UY+Ao8qUoFja
 IilpOE3rXC2pUbQOcXArardSjaDVlRmEwJvG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783618162; x=1784222962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O5Hmfv3Sl4dkLocS5gwAMNuxNXOWwLcnKILxD37gDw4=;
 b=lzC8oO8jj5s8NAuccZyZleZWWuB9YhgMGo7cTZCoTMA4FpWxn56gqWTCVrfswCoALn
 6Kg4FQAuNWYww30ZyZ1PQ1MR6C0VCGRziI9N6Njhlz+80h8zoudoSrotp2bPFj4UlnL7
 T9PiI0HnHbuna3k0lj/N091loLniq7tDp+33tFR6tSrB1HK2kjI4hypFTov7UoM3mu1k
 m7OyQTNND4DhfG0aob3ggRSkIglHWAnabFWAiidJi3LyzX2nlLgcGYSS97twXbfMIYlx
 /gq7N1D/IcWVnyzikMYw1tNdoabYvI2DjsGVX9Usnyoksyt5gnRrPK+0uxY9pRayMpPq
 CTFA==
X-Gm-Message-State: AOJu0YxufIA5q2J1EeAakP9XOC4fmBSMc6TPYwgAzbLDSfMmFyLTprsc
 +8I1fZMkfdQ6zhvH8JoUU+223xx1Ah9mjgCBKPplsfTbXlazpcuUVxjkAVLkCZatNag=
X-Gm-Gg: AfdE7ckknN8Oo2cj9Fq/tzFOqJ6HSDpSNEPASXSu5qbxWK2pG5WiO7bScETSwccvBKT
 mg0fMQSuVdYwIhbwLiN+BVQ70j2txZc79ZBSapG4KsFItD71VBUulCY7cTvYTLl83227O9RitDu
 ntbF0If3Esw5T46r/7szvUxONmdNYgmHlMtJvsr+Cb+Sz2u0sBGOWdx3exRTbIvNfYzVAc26Xyf
 hALMnHyRUnqz//1nzQ2W6+JC0JJNQOLdoJYhAqgkIzN86J0Bb48//YK5bXc4EWxREgTTtOqjoOb
 mpc4V0RviWA1MR6uLTAGhfQ1j6seuWpzLGsFORgoj1DwDPSI0smcEdm2AddLdrgbwbFO7ThCqvd
 ctYLxtdWcoElwhvsyH1hNHu6nhIModI3mkUTBdtEBg1iaXaHBLvfEhk4Lh2+u8/6F/qgVkKQTS5
 WfCBDf0K8v/fCNy+1Vm6KaWyS0XTvk/bX4IUzPFh8X827khh+vXvVobxUFKYBTZO0jbJMlkpefr
 Ula7sZytq0sZcPiroEPr7qOvr8eITZx3X43HvqLrrwcKK/OGemjweVOjBOST4i4S+3nsaHNwsQF
 b7Q0Ihtc/PpP
X-Received: by 2002:a05:622a:144f:b0:517:9570:c1bd with SMTP id
 d75a77b69052e-51c8b3e2e1fmr88639331cf.25.1783618161619; 
 Thu, 09 Jul 2026 10:29:21 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd56bdcdbsm22103326d6.11.2026.07.09.10.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 10:29:21 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v5 2/2] dts: add build arguments to test run configuration
Date: Thu,  9 Jul 2026 13:28:23 -0400
Message-ID: <20260709172823.972163-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709172823.972163-1-knimoji@iol.unh.edu>
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260709172823.972163-1-knimoji@iol.unh.edu>
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
v5:
    *Resolved an issue where existing build arguments get overwritten
     by those specified in the test_run.yaml config file
---
 dts/configurations/test_run.example.yaml | 13 +++++++++++++
 dts/framework/config/test_run.py         |  2 ++
 dts/framework/remote_session/dpdk.py     | 16 ++++++++++------
 dts/framework/utils.py                   | 21 ++++++++++++++++++++-
 4 files changed, 45 insertions(+), 7 deletions(-)

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
index 3cd643981d..5968b953a9 100644
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
index 31610f14c4..f822033f95 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -108,8 +108,8 @@ def setup(self) -> None:
                         "Cannot create code coverage report using a precompiled build directory."
                     )
                 self._set_remote_dpdk_build_dir(build_dir)
-            case DPDKUncompiledBuildConfiguration(build_options=build_options):
-                self._configure_dpdk_build(build_options)
+            case DPDKUncompiledBuildConfiguration():
+                self._configure_dpdk_build(self.config.build_options)
                 self._build_dpdk()
 
     def teardown(self) -> None:
@@ -289,16 +289,20 @@ def _build_dpdk(self) -> None:
         `remote_dpdk_tree_path` has already been set on the SUT node.
         """
         ctx = get_ctx()
+        build_options = getattr(self.config, "build_options")
         # If the SUT is an ice driver device, make sure to build with 16B descriptors.
         if (
             ctx.topology.sut_port_ingress
             and ctx.topology.sut_port_ingress.config.os_driver == "ice"
         ):
-            meson_args = MesonArgs(
-                default_library="static", libdir="lib", c_args="-DRTE_NET_INTEL_USE_16BYTE_DESC"
-            )
+            if "c_args" in build_options.build_args:
+                build_options.build_args["c_args"].append("DRTE_NET_INTEL_USE_16BYTE_DESC")
+            else:
+                build_options.build_args["c_args"] = ["DRTE_NET_INTEL_USE_16BYTE_DESC"]
+
+            meson_args = MesonArgs(build_options.build_args, default_library="static", libdir="lib")
         else:
-            meson_args = MesonArgs(default_library="static", libdir="lib")
+            meson_args = MesonArgs(build_options.build_args, default_library="static", libdir="lib")
 
         if SETTINGS.code_coverage:
             meson_args._add_arg("-Db_coverage=true")
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index 55d6dfc337..0e41f3f48c 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -101,10 +101,16 @@ class MesonArgs:
 
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
@@ -123,6 +129,19 @@ def __init__(self, default_library: str | None = None, **dpdk_args: str | bool):
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
+        self._dpdk_args = " ".join(f"{self._dpdk_args} {' '.join(arguments)}".split())
+
     def __str__(self) -> str:
         """The actual args."""
         return " ".join(f"{self._default_library} {self._dpdk_args}".split())
-- 
2.54.0

