Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1BACDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 18:16:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 009BA40647;
	Thu, 25 Jun 2026 20:16:16 +0200 (CEST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by mails.dpdk.org (Postfix) with ESMTP id BA31E402BC
 for <dev@dpdk.org>; Thu, 25 Jun 2026 20:16:13 +0200 (CEST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-809b19a7f25so2577547b3.3
 for <dev@dpdk.org>; Thu, 25 Jun 2026 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782411373; x=1783016173; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzHW/Axyzo0qMSyHjS/VBjp9SDXQfPl0bjEoah6m8f8=;
 b=BF+PthgjiPFZwwlAZAyWQFdCZxX6Ut+qX+rG3oIo9T4sGYaBhZW411ennB0E/aeJD+
 T9GDmLja2wV7sRbmcy8fJ6eQu9HHNhvbfnii5cQC/MKxo/uKGpZMKp/bEmvTQUqT5Iec
 sQk+3vFFwdojGxMo1BpusJewFqVvTCbACkz+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782411373; x=1783016173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VzHW/Axyzo0qMSyHjS/VBjp9SDXQfPl0bjEoah6m8f8=;
 b=ej1RkY0csyCBEbBELPF9EeXCocROnsaC4jT4WpjS4gC5HIsc6EQ5ZiINfNnqkTxoX+
 fyJtQC0YaeeILs3aDjEyCY8GXqRl0n4SY2TC2lV9na3itcMpBS9BY8lLCzBbDWzx1XbP
 aTth3KQ5w0PQ7IlGRRjlEFpj8CWkuFkQAc5/Y8ENmT6+80AvcisPuYfTEvsCcD38BKgt
 unmE04Qm4gwSg2Zmmhjoau/YaHTnPYY0cZASgJtcUVjihopujAc7q4gP52SGt/aq9hIF
 KeFcqDrd6w/IrwaMq+c9jV8UwkKAvYXQqaEEQHos0oxi85lpzFE34p3c2fqBgkbeAs8X
 PXvw==
X-Gm-Message-State: AOJu0YxgceGVecuCpfqU6oWibHc93USCps1cJLt1h6HrdvM33WP1FY/P
 P9zExnufuCWjojuzwisP/TVrLEL4gwx32/gHlI8ppW2Ai1SHvB1Jajk/JNdVX4kXSuo=
X-Gm-Gg: AfdE7clVUmYlhVkBXd6bXL1Cp2SeERKkSlraBnhP9aFSzyvrQntlvfUuxEY8uhKfFu6
 kS2RALrORpUNYSbEu41tWcb41aQ4qIKBguSyDEwUyeJzJ8O5eI9+OX7+PxT7YlqH5HMxbfOM4pi
 QplpP5fpZJDB0Sf0idebUJKwF1QaPmdBIIduUtJkXF0V+8Obbu6vei+BnWvKR6s5nTqSXXLNOn+
 D/vHMEC5dRiNmbzhd89lPsHU8LQ5G5cgHMUI4eBSqk/OIoqdL5y8Jcralql383RlTXmMI5PMXeY
 EAmeJQCOq4DOPpOktSqWfdp9RYUzx5YZql9JDIj42a3Tw+2g5oy4/vmj6OEqT5cg9zqy6QtaDRK
 zlGjxJHBzF0KWGY/9SdiwI1e8iAhUoaSoZWOuUc5Dd6tlGfw5CJVE3Fi9HaNcf/bA5VMLxKtEOw
 nlkS2UVYUgPu5e31YnEiCOfsurxluB4kSr3NtmalBQWKGBnze7E7rwLOBDuxM94sFsN3p3hRrVI
 wK8ZIngK9xSEh3cgF0C9iuuDeBd5zHggjWV4h/VZh0kJ2LcM13aiwS5Tc0XsI5KYZsengdXnlxe
 VCpZUU4zM8CESg==
X-Received: by 2002:a05:690c:c6d0:b0:80a:9f1a:d48c with SMTP id
 00721157ae682-80a9f1ad729mr25814327b3.55.1782411372828; 
 Thu, 25 Jun 2026 11:16:12 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df7f0180d3sm187088876d6.3.2026.06.25.11.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 11:16:12 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v4 2/2] dts: add build arguments to test run configuration
Date: Thu, 25 Jun 2026 14:15:57 -0400
Message-ID: <20260625181557.2331771-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625181557.2331771-1-knimoji@iol.unh.edu>
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260625181557.2331771-1-knimoji@iol.unh.edu>
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
index 1e6d8a01b5..b8485b9c3c 100644
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
@@ -285,16 +285,20 @@ def _build_dpdk(self) -> None:
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
index fb6b95271e..be528bb4da 100644
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

