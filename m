Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A1BC43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 00:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E628840A81;
	Sat, 11 Jul 2026 02:02:33 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 6176440685
 for <dev@dpdk.org>; Sat, 11 Jul 2026 02:02:32 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-902fc790cd5so9969586d6.1
 for <dev@dpdk.org>; Fri, 10 Jul 2026 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783728152; x=1784332952; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ciq4t1JwOdKcHWbpwSd1Xtn+/RypWUiFL5SZaVAHbWs=;
 b=AOKQz54dssOroQ+NHKaK5uTb4wEaOl+FkYmlfJywiATEWCSINMxHFPVV1d/1hOh5Kh
 rvmb1wbTyqoJkqfKUlSrMPZrFnBdBITND81T4SnMsAaiL+tZ66a8dqIevzxWsDuEH+fi
 W4KIqgiTTeicphJSWxh7MM/ZMbQ6CUX8iKTtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783728152; x=1784332952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ciq4t1JwOdKcHWbpwSd1Xtn+/RypWUiFL5SZaVAHbWs=;
 b=lqU1UfVsEdNXjB0bQJkimM7TrRjCOwdM8RNYXtKR+sikrXVW7pmZGUJRhHDP9tozem
 6Q4f01U6rOi7Eq4fyiiym/SouCP9L4PbtZwYH1RdWeQP2IbF7YVdOuwawtnsImwsyN4h
 V47sDs8j/xdO71AwyG6qlSgj7lWDSvPUZq9lMITX/FqpxNgxlQ+EklEm/rSVjEOebXHc
 FYL4D94SxNd1Yvl1gAZlCUHehIoE0FEwmbEM79L+IZr9wXSp0twx8+qthqabVKqQgYAa
 84hkpxPjmHS7yPN++9u3bXsckXmoXLGIojKijrh6TONtytgxIQBajpUrE6A3Sai1ape6
 3fDg==
X-Gm-Message-State: AOJu0YwxAbPJw95VyQGn1s4gwmqknqoMErEku1TV4Pbhuz70XFpNPgda
 OVYczXYqVBXlybZUwvoGCpgBjEepW6Ap/3bYQ6hO+3OKXkHYMML/AqyrMf0FVylYhUU=
X-Gm-Gg: AfdE7clLNWaCWpg7SXGHJhUFR7wpJhijXnzoqTqaV5QrvFjKUvkc2iQFmf/KEYNd0QA
 W0SFKDed/STZAvWgdUr8IxLr2zK0IB/ArOiEdTMkfViYgffA0FctJhGqKNqmYkGTvVbz5U3RHUh
 1zL7fzz8oG7cEaCFYdqHF9rlSetGJFCTbXEgxjgzRcmedH2OYIJNPPikr8/KlJC/CuiQZ6iLTIW
 qU0Gb7vxJ+RMusaSP3wAF1gVg5wGBwW//4jYIdpqC22jJ/7TuDaF2Pskw4OJUAaWbOMEcnzbyVS
 x9OqrNzQ7h2vYPFodVTenaoTjOxeyqOPODL2slkTM3avcGV+OSXUyEmyC0LOOSG2jaWdQrQS5IX
 L4PW3ULi6aJZpX0ZFSncGyp35++3QZ+tysxJUO2i5vXcMWMxOlHeT+Rs1Y1h4sVRewJhbirgJMd
 i+Ju6qiX9ipop50eyol/arQXcIh4fqt4qDQl+HlfYXUaBAqOxzHLij6DvuHMJB+vrewadnVcyO8
 GiCMrH4dBScM8bzCbCxw3Ev5jPHRK9+Ha6OSZrwGA==
X-Received: by 2002:a05:6214:27c9:b0:8ef:cfdb:29ad with SMTP id
 6a1803df08f44-90400f8c053mr16737616d6.2.1783728151438; 
 Fri, 10 Jul 2026 17:02:31 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1257::1006])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd50e081dsm53393706d6.9.2026.07.10.17.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 17:02:31 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v6 2/2] dts: add build arguments to test run configuration
Date: Fri, 10 Jul 2026 20:02:25 -0400
Message-ID: <20260711000225.1836433-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260711000225.1836433-1-knimoji@iol.unh.edu>
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260711000225.1836433-1-knimoji@iol.unh.edu>
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
 dts/framework/remote_session/dpdk.py     | 16 ++++++++++------
 dts/framework/utils.py                   | 21 ++++++++++++++++++++-
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/dts/configurations/test_run.example.yaml b/dts/configurations/test_run.example.yaml
index 51f9ab8237..182ee377aa 100644
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
@@ -46,6 +48,17 @@ dpdk:
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
index 81630df77d..cf6569ea0c 100644
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
index 683bc3470e..58d20efebe 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -109,8 +109,8 @@ def setup(self) -> None:
                         "Cannot create code coverage report using a precompiled build directory."
                     )
                 self._set_remote_dpdk_build_dir(build_dir)
-            case DPDKUncompiledBuildConfiguration(build_options=build_options):
-                self._configure_dpdk_build(build_options)
+            case DPDKUncompiledBuildConfiguration():
+                self._configure_dpdk_build(self.config.build_options)
                 self._build_dpdk()
 
     def teardown(self) -> None:
@@ -295,17 +295,21 @@ def _build_dpdk(self) -> None:
         `remote_dpdk_tree_path` has already been set on the SUT node.
         """
         ctx = get_ctx()
+        build_options = getattr(self.config, "build_options")
         # If the SUT is an ice driver device, make sure to build with 16B descriptors.
         if (
             ctx.topology.type is not LinkTopology.NO_LINK
             and ctx.topology.sut_port_ingress
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

