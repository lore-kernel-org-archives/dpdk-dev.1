Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4ACCD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:37:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C87C40684;
	Tue,  9 Jun 2026 16:37:00 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id DF3D240669
 for <dev@dpdk.org>; Tue,  9 Jun 2026 16:36:57 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-915c36e32abso244680585a.2
 for <dev@dpdk.org>; Tue, 09 Jun 2026 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781015817; x=1781620617; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kYFSwL72txGugI4ZKTGMdOCoAFv1IcZHD+/kq3nCRM=;
 b=CXgePmbEwCD7z8KyMm8B2NomUMajlMUxq4gq954HKQGBJMREmNVYyVor286+t1bc3J
 xoC/ygVuQ4G5e+DbHdEwf76o82TxtlkCBcFmpvYUNQRgvL4tetVvIpisCI+VIQRzW+i1
 hErMeWYPZKUb7rFKQRSEBmhPcaFvRywClOIl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015817; x=1781620617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8kYFSwL72txGugI4ZKTGMdOCoAFv1IcZHD+/kq3nCRM=;
 b=ZJMkOFOjjDrKimdS84UgHxZZKEXf/xisar/+8hIT7BC3u0BjTSPF6KVymcSWsy0kOc
 2Ut5yrXtFYKwS8kBsM2ggxm+wXBq/uh+4okupg/WA/IM1cAKaOuNpLa+rMvR+3oyFmim
 0hWW8kycK+vZVwJDbtXfDe6Re+nOEgyVO8ZyQxMkWbXESqHnQylHkH/NrfMIryrB9/TH
 23ok2twql3a/Iws7kcc7uJJiv7mA5iCg5qnsibDgB0ZRVZOAZ9RWLjPxLVCKDvkgu6We
 ALjTPxarKU1xjetZyijb4bLzecVn+RHlbmm+KMzPcf9Xnn4YQnlsW9t0mbNXYTDxK3ro
 8jPw==
X-Gm-Message-State: AOJu0Yz6jYhTSx9LUW2Xn7Lzpq5ibld2i/7DRmgmqy07eHXKvfzwjehx
 ls2vPgAh5MgXV4AYKH91hcOvuKiBTCp76vv9XNOPbHXJqIcm4uQSkcJUkawJXUtKwkI=
X-Gm-Gg: Acq92OGzD0xWSa/7Cf6v+eCVgV8bLzeUCtvuSNabRg/Hy4mC276sbDmjh69hw385z98
 Jj7AQ++x9eEr/mw8ZIwbKOThX1Jphsk85/U4U3BX8oR7HwAPfyUbuCMGQxzOQxq2WJYzRNugAhO
 QKYVqGjwK02B1CLpq58pyecYtr05XqJZ6CwRwcj+o6YDGtuTukn/ruQ9cHs0ACjBY3X8UbBaUDd
 eGK95rKXINnqNVPGc8tUDwqNB7nllI15yCoLPV/KoPx+QoQXoyilRRCSjOS9Hy8DLljQs+YUN+T
 691XYqwn1rY74WsjYpgSdmhtzPKQU9a84UBq83ULnI3bn2Szln8+hLSaltzwuaMoiIGUQg8eBqS
 N4B/w7VNLQSnlGbUosZAbJbHAvPqUqPp0kA2gzjQwlWiwJ4czoZZ13orWjMnA6C0CO4eOEKEEez
 ri9Q9qO1nZoAq3uNU4wrEwNvecZQJVmikI9V3iXWbZG796J6ck0HSZSVI2Q1KKeBaVQnVijZnSl
 c2uMtPAsipcnVhZhxv8lFUlsXH2f6HOpjsyIySF6oe6Kr7d8B+1zqOsDjWwaRqMck/y+JCoD/8z
 PYCqAWZaTFl81O90o1QSOzQltXooYmgCeTc=
X-Received: by 2002:a05:620a:2b4a:b0:912:1:b41c with SMTP id
 af79cd13be357-915a9a43532mr3330220785a.0.1781015817020; 
 Tue, 09 Jun 2026 07:36:57 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3eea49sm2100328385a.44.2026.06.09.07.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:36:56 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: add build arguments to test run configuration
Date: Tue,  9 Jun 2026 10:36:47 -0400
Message-ID: <20260609143647.1434076-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609143647.1434076-1-knimoji@iol.unh.edu>
References: <20260522154637.952588-1-knimoji@iol.unh.edu>
 <20260609143647.1434076-1-knimoji@iol.unh.edu>
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

