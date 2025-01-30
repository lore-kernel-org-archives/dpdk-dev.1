Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A21AC0218A
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jan 2025 22:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC83E40DCE;
	Thu, 30 Jan 2025 23:13:29 +0100 (CET)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 4580540275
 for <dev@dpdk.org>; Thu, 30 Jan 2025 23:13:28 +0100 (CET)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so125337685a.0
 for <dev@dpdk.org>; Thu, 30 Jan 2025 14:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738275207; x=1738880007; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYNhV+yKbhyfgQqZ6S8qOh49QVnNBO4AGb7BYFJK3GU=;
 b=OCnyGbrOG0/WXmjnuWqf+sGWG1yubVVRupIumVQ8QbSxm8cNto9N3LEcwHY7SUoV+m
 M9q0QA3ABzL8xTb49gjzPI5BycdMqZvUkeOD9vNU3eBkvvqTt0a+wuRpAl0vc44U7DI6
 yQjdrBKBwHeeQziaMCMtc0sG1qAidUVXqAp+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738275207; x=1738880007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYNhV+yKbhyfgQqZ6S8qOh49QVnNBO4AGb7BYFJK3GU=;
 b=hgbu/l36P4AJLJ9IdOZ767eaF14YqOxZwfeDrZBzcksRr3Ge7xC5VKIHQNP0rgOFJH
 jH46a5JEmyb7x+3r2jQ5m4Rx6QuY+7/55BljAFAbCY+UAJYX2ior3eJ2nBdXOrolrNwX
 qg2C5WeCgh4sA+q37pR0CQnQSyD2U0k9A48t2ZeTtV0qOMAEWfLFyfx2fs3ikwiTQt+N
 MNyC5YYMg42R3JsrR0YXPQTO/i5UyPbZ9n5ss4aZ2fLoqijrWXVe76XYgSpSCFRMjpL1
 R6PadabryT4bAPGU/4w5YoryAoBtJv1gmJpedf5lQGObnI6YKipNr57D7wot34HbVeg9
 Q4Ug==
X-Gm-Message-State: AOJu0Yz1JrdpTcX+JSDQY3ASWig31rPkIgIfWBunGC7vzKcW1J7Qcy4J
 cAbcWvWTPl14HeWpEAcFIuPg8oBDWDf3lmb/RZtzBvx7YS1wXKSvYI2w9Kcsr8Y=
X-Gm-Gg: ASbGncttl7xwGPov3lZRspdiZA9Z97/vOs24I2SqLe34ddbFieGRcSOxfWgiCsRWqsf
 9jYQsxauTdv2pRHO7L4Vlu+xNNpVwZBH1vazctn/daqAPKIjXrwzjZkOLWRke9FXPh+Fujpmr7W
 8pice1uYfNca6er3PAqrogEDj9JA3kAvD4p7OpDA6zHhajQY4lwXGV5L6YcVi2JR5YYY6iV1h8E
 sJVWYemWZKMnsHvoyLdGSLPTDtjtjIyaMFx5xrfHIb4D0jroman3An/Hi5Ib7IIXMlD3LProhGs
 FemM3lCa66seKVBwjpJGHmcXHgeCw/h4VQ+Kua7P00If8whdDP/0VeM=
X-Google-Smtp-Source: AGHT+IHPge9CNwFp12kihAe5JZYRrGNgHMVg3yft6PqQfspkJo8kdFwqMznYynIhzBpKT3aEsHMNCg==
X-Received: by 2002:a05:6214:3007:b0:6dd:d3b:de38 with SMTP id
 6a1803df08f44-6e243bb8914mr146642596d6.16.1738275207374; 
 Thu, 30 Jan 2025 14:13:27 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:cf73:250f:b43e:342b])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254940c8bsm10549786d6.100.2025.01.30.14.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 14:13:26 -0800 (PST)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, npratte@iol.unh.edu, luca.vizzarro@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2] dts: add SUT cleanup to framework
Date: Thu, 30 Jan 2025 17:13:24 -0500
Message-ID: <20250130221324.75711-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20241209205902.18321-2-dmarx@iol.unh.edu>
References: <20241209205902.18321-2-dmarx@iol.unh.edu>
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
(when remote=false in the conf.yaml).

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/runner.py                 |  2 +-
 dts/framework/testbed_model/sut_node.py | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

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
index 483733cede..c73500b146 100644
--- a/dts/framework/testbed_model/sut_node.py
+++ b/dts/framework/testbed_model/sut_node.py
@@ -188,6 +188,19 @@ def path_to_devbind_script(self) -> PurePath | str:
             )
         return self._path_to_devbind_script
 
+    def cleanup_sut(self, dpdk_build_location, remote_tree: str | PurePath | None) -> None:
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
 
@@ -216,11 +229,11 @@ def set_up_test_run(
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
@@ -256,14 +269,16 @@ def _set_up_dpdk(
 
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

