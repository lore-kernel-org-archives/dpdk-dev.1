Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F5CC021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 16:44:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C52D42EB1;
	Thu, 13 Feb 2025 17:44:07 +0100 (CET)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 03498402A3
 for <dev@dpdk.org>; Thu, 13 Feb 2025 17:44:05 +0100 (CET)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-47195f8f272so9594261cf.0
 for <dev@dpdk.org>; Thu, 13 Feb 2025 08:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739465045; x=1740069845; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrCmcYkvfVY72J0jIfL5Ie+LRB1Krj9gqtmLRPEEHnE=;
 b=jd4a/nPWHpUX1v8TmGS/QC8NEx/zX+jmRIjxO17J0MZd/CF6MD7vj6aXdoAr7Bos1/
 pYk16OX7wLzU02tWJbnnlTLYjQ2sjTlLzmzht7E+lFlIsJpsIE67h2Lcb/DLSX/xrwSy
 CLOlxyrBQ+44Z9FDzhfiKqac09VmjT/8z+szM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739465045; x=1740069845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nrCmcYkvfVY72J0jIfL5Ie+LRB1Krj9gqtmLRPEEHnE=;
 b=RGCzMGjpyL8KexIkmF7bEAWo+0eT38Q/lh3G7Rh6YPvhK+baUTiNX4CLXI/zUlVEhd
 2LtAzFJG86UwIdQuE7ZDqEB23+bnsEwkpaQ+4Ywa4btrZRIPcEHQ6AU5xyQ3GzD+84bd
 CjnywA9nmzd/YmHxSF6R49nh8hXDQokLVrVwRhIri7gxqW/ZzlS42A5Q3uv5uM9BYczu
 3LPj7SMhNskYy1NWIytpJfAeF1V2Hn4WzG5Fv7rJAfu4Sj67ZKEudZEK1OBlc8nFDavx
 4Q9WNd3NtFAjI5/ONiFUj8s5Y7M3zkj2lSGxZwJSbuxm+pR9+6qwE7pQq7GTyi/fH5ue
 jpWA==
X-Gm-Message-State: AOJu0YwosDTDyT5g/msvQZoWNvV+t1TyKT4+fTgbfnFjZcOW3esvPWXH
 yudESUGpHKT8Hxk05GKqaMA+wnDeASx0JilSEedqdTNb0r7dpIToEdBGhLpLbgc=
X-Gm-Gg: ASbGnctoLAV/MbYDbkM45m2EkUt7Sx3i1wUao2L+rBMRBdQY0fhmCsp+hT0jvmCnWSI
 vGSqzS9mt0knMKVtxCHhF3h8U5mlyQHeSv6F1ZX1eVbrH8ZmA2+mWxyE9sTqGJUl1TWzy8QifkD
 erbMh5j6xKNZtaNrXESINN+ZN20zi3PFe26SvrLM1laIbyGf5fZO3wLUNj8nQXqSCPI2+sjlYB/
 z2WlYMAk8+DqvUT+eX1WgVK4pbFpa4JP32BR0sxn2R6aXvIGeDowAMTvZN/dZzZKb8710oUGsas
 mD69FDo=
X-Google-Smtp-Source: AGHT+IEBzN7V1DFdVg3qS2kbsinJmpAyQEv2uD9XF1xQYIn+8p6/bLjQh+3BSoCFmkZAJYvV45qppw==
X-Received: by 2002:a05:622a:5196:b0:471:c9a9:135c with SMTP id
 d75a77b69052e-471c9a91c02mr26709621cf.1.1739465045141; 
 Thu, 13 Feb 2025 08:44:05 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1257::100a])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2a30b2esm9496161cf.39.2025.02.13.08.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:44:04 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3] dts: add SUT cleanup to framework
Date: Thu, 13 Feb 2025 11:44:01 -0500
Message-ID: <20250213164401.20384-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130221324.75711-1-dmarx@iol.unh.edu>
References: <20250130221324.75711-1-dmarx@iol.unh.edu>
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

Add method cleanup_sut to framework that removes a
DPDK source from a SUT node at the conclusion of a testrun.
This will only run when the DPDK source is being copied
from the DTS engine node during the testrun
(when remote=false in the configuration).

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/runner.py                 |  2 +-
 dts/framework/testbed_model/sut_node.py | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index 9f9789cf49..367034e038 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -336,7 +336,7 @@ def _run_test_run(
         finally:
             try:
                 self._logger.set_stage(DtsStage.test_run_teardown)
-                sut_node.tear_down_test_run()
+                sut_node.tear_down_test_run(test_run_config.dpdk_config.dpdk_location)
                 tg_node.tear_down_test_run()
                 test_run_result.update_teardown(Result.PASS)
             except Exception as e:
diff --git a/dts/framework/testbed_model/sut_node.py b/dts/framework/testbed_model/sut_node.py
index 483733cede..82ae5a65c2 100644
--- a/dts/framework/testbed_model/sut_node.py
+++ b/dts/framework/testbed_model/sut_node.py
@@ -22,6 +22,7 @@
 from framework.config.test_run import (
     DPDKBuildConfiguration,
     DPDKBuildOptionsConfiguration,
+    DPDKLocation,
     DPDKPrecompiledBuildConfiguration,
     DPDKUncompiledBuildConfiguration,
     LocalDPDKTarballLocation,
@@ -188,6 +189,21 @@ def path_to_devbind_script(self) -> PurePath | str:
             )
         return self._path_to_devbind_script
 
+    def cleanup_sut(
+        self, dpdk_build_location: DPDKLocation, remote_tree: str | PurePath | None
+    ) -> None:
+        """Removes the DPDK tree and/or build directory/tarball depending on the configuration."""
+        match dpdk_build_location:
+            case LocalDPDKTreeLocation(dpdk_tree=dpdk_tree):
+                tree_path = self.main_session.join_remote_path(self._remote_tmp_dir, dpdk_tree.name)
+                self.main_session.remove_remote_dir(tree_path)
+            case LocalDPDKTarballLocation(tarball=tarball):
+                self.main_session.remove_remote_dir(str(remote_tree))
+                tarball_path = self.main_session.join_remote_path(
+                    self._remote_tmp_dir, tarball.name
+                )
+                self.main_session.remove_remote_file(tarball_path)
+
     def get_dpdk_build_info(self) -> DPDKBuildInfo:
         """Get additional DPDK build information.
 
@@ -216,11 +232,11 @@ def set_up_test_run(
             self.virtual_devices.append(VirtualDevice(vdev))
         self._set_up_dpdk(dpdk_build_config)
 
-    def tear_down_test_run(self) -> None:
+    def tear_down_test_run(self, dpdk_build_location=None) -> None:
         """Extend the test run teardown with virtual device teardown and DPDK teardown."""
         super().tear_down_test_run()
         self.virtual_devices = []
-        self._tear_down_dpdk()
+        self._tear_down_dpdk(dpdk_build_location)
 
     def _set_up_dpdk(
         self,
@@ -256,14 +272,16 @@ def _set_up_dpdk(
 
         self.bind_ports_to_driver()
 
-    def _tear_down_dpdk(self) -> None:
+    def _tear_down_dpdk(self, dpdk_build_location) -> None:
         """Reset DPDK variables and bind port driver to the OS driver."""
         self._env_vars = {}
+        remote_tree = self.__remote_dpdk_tree_path
         self.__remote_dpdk_tree_path = None
         self._remote_dpdk_build_dir = None
         self._dpdk_version = None
         self.compiler_version = None
         self.bind_ports_to_driver(for_dpdk=False)
+        self.cleanup_sut(dpdk_build_location, remote_tree)
 
     def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath):
         """Set the path to the remote DPDK source tree based on the provided DPDK location.
-- 
2.48.1

