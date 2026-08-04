Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD1FC55ABA
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 19:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16D3E40671;
	Tue,  4 Aug 2026 21:38:54 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id D925E40285
 for <dev@dpdk.org>; Tue,  4 Aug 2026 21:38:51 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-90873ce5278so1916016d6.0
 for <dev@dpdk.org>; Tue, 04 Aug 2026 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1785872331; x=1786477131; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6dP7BVhWwAfdBW2FdDGddNOOsCR5SvmAw21sSLVA9PM=;
 b=ZJWMaN/qwCBz/Y/Bc4t0iy1pz4xjZGC5J840Q/4kMAjY0qwpz1L3Dm7jBEpbuLJFnM
 wmj5xlop1kq0Kl3SdF+xhnfuWWHxnZS1QAx0f5/T3G6UVdPKB+JUJp51U+xpEucADfuN
 0ocegHACJpiIl9+zIJ8a024i8Mlj6lAx137H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785872331; x=1786477131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6dP7BVhWwAfdBW2FdDGddNOOsCR5SvmAw21sSLVA9PM=;
 b=OTllCMo/VyKVevvr3f1R4W6tfZ074poY3D/050Tt99Q1XRUgsHlMeAuogYiX+gXPk7
 oDhmlE0LGtsHYHYisIH6w4leAG5qG4wPMz65Xy5wwCDmvkmD5bqMHjYF4LF9RRhAYz+I
 KH0WxWv1ZqOJfS2L5k5+cF+UUa3ugsuPqrIktiLNAZ1tDFpVIKWT5Ptr28o16fyNgHZ3
 YtmJ0apnEzmDFyDmfv8/xWDdVHMr1y18cxyULXy3M+kSfpat7W148MI4Eg5+eCf/GUdY
 r/zEyWPHGW/RYB+oy9UiBwupjirhNKY1Gd95oZp7UclYQwTPsTbRWnc8pfdyhk7I3isP
 Ho1g==
X-Gm-Message-State: AOJu0Yy5TGJWXj+Qq6m6PHlYmAAzvN4X17VkKllmZCnjOsNcOCrZ1eNl
 cLAShUsra4Pe4gGv6u8GB4yK1xvSEbCUAn3uOARpnH67IkDrgbHe1E1LFyHtUIFAhiY=
X-Gm-Gg: AR+sD11TJ+tmxFL+g15z8v4XduwX5ZiLiHNie23URU2O2SfqdPwzzpfpewvmR90g13I
 qF7W29TEN8E/vkXUuiQee4D0KbqdTyMHiu37TMPFGXH2NT8aYgm9DD3Wq9OqeeoxK2CXw4A/tMG
 L1CANG3ZJbEVty0kSldU+bCd60IBJLrlUa+XMbXnRKzXz8yPqNLp+FQxxdXn+mzGKJVUxVzc006
 1i2abMrQW7DixDhr+lH2C4awyP23EM6JnM9GgcOZBYwBaFWOlvR2bGkwJJBqk4NqZZRt3JOrIkH
 9cxH9nUV96KGluk+0FD2/ncnAq552wIzzOWIDbo5KVgNxmmCO+k09KM9wrQEfR95HeIi5abick3
 q3IsPG/D7M7iPzizL6MCbRcEMhgzm8UvEetwmt2IbtnMIgen5JAzW/M/gdebZYi/kgEZlhmcNPR
 JvTBt6yf0uvx4b+wkoo1P++dJHXVnTYUn4n/R5UQ1/kg3dOJSUOnGPcuiCI4ZncW0iba7lmVj4t
 xeIDAJ2kydF4/fGJD4Y4njsMEOBgPHubgyCNNT0LWqlpPbKzQdpPCDTKYq1GQnnFbUKw9YzyBvS
 M0QwO5qiQ6WRRhC7j3DmxbgmP9tWvcWz+P2e3tg2dIYpSlrdRwS+cWAvbXur
X-Received: by 2002:a05:6214:2e4a:b0:8f4:d86:ec0f with SMTP id
 6a1803df08f44-90881387b91mr22148726d6.27.1785872331110; 
 Tue, 04 Aug 2026 12:38:51 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908800cabedsm8739746d6.46.2026.08.04.12.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 12:38:50 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v8 2/2] dts: add build arguments to test run configuration
Date: Tue,  4 Aug 2026 15:38:46 -0400
Message-ID: <20260804193846.556368-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804193846.556368-1-knimoji@iol.unh.edu>
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260804193846.556368-1-knimoji@iol.unh.edu>
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
2.55.0

