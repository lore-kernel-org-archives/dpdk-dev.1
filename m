Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63BBCD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:47:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52E1540665;
	Fri, 22 May 2026 17:47:00 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 044DC4066B
 for <dev@dpdk.org>; Fri, 22 May 2026 17:46:59 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-516de78c4dcso3205011cf.2
 for <dev@dpdk.org>; Fri, 22 May 2026 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1779464818; x=1780069618; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kYFSwL72txGugI4ZKTGMdOCoAFv1IcZHD+/kq3nCRM=;
 b=ghuOYVJgZbA/OGq4p8KfV3bZzdQ4QIm5HgRWk9BlDXglsyaGN86iwucV6ZK9v/wzdo
 pIrBJ705i/YcLEWixMAujn7zJdg0V9buJQEJlDv3IdQ5mS/eFmEQdVPxRjPAeWig5HzP
 +/HUqYgxViKaHED7B89GJbVp6fDtBuOPdAtBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779464818; x=1780069618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8kYFSwL72txGugI4ZKTGMdOCoAFv1IcZHD+/kq3nCRM=;
 b=hnXMGcZ1CWCpVlUdnFucOkWb+7rvN1E901FctvRWvDxNgg1D8FJ4LekP6tWw49M/Jc
 KYqSMpFALr4L7IxrfuWwPKtXJJYAxRxYKSWS5sQp6yRk/wASXu/4zZgzNQ2uhZQHhqoh
 EPBXSpQawaW8kPEuxryxz1KfF8zdBPptuVIREiAF3vf/LXfOFl8vJOHJu42/afr2g3T8
 z6lSEU7fFmatkvf4aOb7mDrRmNXFNEp8aDcM65r0Aes8h6GaacB98RoS9yMXvCSKfYV8
 P/spCLdDfoACvRS7xc6+2fGJd/mW8znEmXj4N2bGfDw+9Zl7QIeU7d2UANPH8xFd2FcP
 8Pjw==
X-Gm-Message-State: AOJu0YyGAVh9aDK+GhgaCLaIIoGYS1IO7kE+oQ92XojF5WttFDt8efhT
 +b7yAOmMyYeG+X8XGzNMTtWcJO2dyw1XC+wM2JTZu/T7xuwvkdZ0sRYMSWBgg6OqATk=
X-Gm-Gg: Acq92OHluw8Z5g9//f0XR/vftXAtHUF9hme+rhyswMm3egmKzkBc5NMjP9f2BPsNB9t
 xw9sLhDkq9CnJrdhSQfgRw7JwYqJiL2cdsrX5oAjBBb7+Yo+8aJ86EJAPZ6IagbnywhobD1q1a6
 maXP/ZlQ7W3WfyUfhwD8gRxYQolQiIpSDP9u94QKWqEAzVyf2nduaytHecO4kOL6xVcTA9UdMs/
 MnJToHTvPDLtFmtYb0gjPEsJ9sE7fWAEa/4xG8GDIgb4v97pmtIbfvYcffU9+akTn+zcgLpM3kK
 9CRSWEO9adyy4Y7R5HOc51frk0lEt8O4QvB+Kq23lzp39vL4Q1IVnWLftJQeK3BHnnHpAAJPpNf
 FXv71ussEhoICuZRy0vR21p3f7f2Fc5sXNhZotlP98O27Hp3eZXSLOf3zZMvw/xm/EcZ6CKRkuO
 X1oMpxZm8WvxaRKRo8qH120onTITLbXT30PJf3CeXsMWpx8x+rCzW13UlUh+Ciuyxu2mYcw+8hP
 2x8pl74I3EPrf2fj8u2cB3Pf1Xeh1nFDcmSn4ynqRYtmAqO4r7Hj9kQwk24b0EpUaIaaHkdLl/N
 4yaY8hBZzQ5Epqze+fAbimpgiadPUTim8to=
X-Received: by 2002:a05:622a:2588:b0:516:d4b1:48d3 with SMTP id
 d75a77b69052e-516d4b14c9cmr53035841cf.6.1779464818028; 
 Fri, 22 May 2026 08:46:58 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d8cba4easm16299911cf.24.2026.05.22.08.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 08:46:57 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v1 2/2] dts: add build arguments to test run configuration
Date: Fri, 22 May 2026 11:46:37 -0400
Message-ID: <20260522154637.952588-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522154637.952588-1-knimoji@iol.unh.edu>
References: <20260430192911.297180-1-knimoji@iol.unh.edu>
 <20260522154637.952588-1-knimoji@iol.unh.edu>
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

