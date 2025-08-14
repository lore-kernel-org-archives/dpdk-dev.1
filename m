Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D150ACA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 20:42:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FD8B4021F;
	Thu, 14 Aug 2025 22:42:42 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id 384274003C
 for <dev@dpdk.org>; Thu, 14 Aug 2025 22:42:41 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-70a9282f475so12618846d6.1
 for <dev@dpdk.org>; Thu, 14 Aug 2025 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755204160; x=1755808960; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=revoyH2mqLk9KAf+n7tXEIuqfOkug62S0VTccRy4lk4=;
 b=ciCl8lVIDHmbcO08TCx9jlokVFqWaNhkvyRYRi00/QMO3B2GXOU07wYZ4xhP6Vg6ga
 t9tEcSFQGArYV+NVvTmlrz6IlmMTgn4yn/QNpi4NNVa0SncO+1dSh2uStEEvGho0n0xM
 Vrnd/OhRWFcf6oCtw8QK3pLbINHWGj/JKPLCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755204160; x=1755808960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=revoyH2mqLk9KAf+n7tXEIuqfOkug62S0VTccRy4lk4=;
 b=I6s/PysOw+IQmFwwNm1460/e+ZFoBFfDQVysX5LITqhevU/lfhSQhf7Xi1tgZVg30f
 kfFX+0db+umWRhOGMcrAjKhuCRDmgNCGXzMtD/PR45mSqs26Cuyyp17a3OCrrVI5Gb/F
 bkZdVxZSrpPgCeq7Rk32s0MYteyjbu98U0hB1TmHm48796njnWNH2XULve3itYYNgbHr
 8lO/Y2v9XvbSnbFjC1z2mtrZKuukGq9fuwMwfgwteZY/cy31IwRFZRbeZHym7n8OUIPg
 zsvTZyq4xBEnubRgW9CHPtESPR9+zlxtQYN2YEXv2up9wrWiHExBSjc4yr7ls38cfyLs
 jVqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2EyRhKU8JhEEboskY4qcw4hnUN0LSNNdBMt2oUPDTf0G5zxV4GWe0ktAzFytuD4u++TQ=@dpdk.org
X-Gm-Message-State: AOJu0YyCo3jP9rJIaMlztPPU2Xp2Lt87Es8fD2fF53ABTzZKxq9TvzVp
 /wTf1DOAdxXKM/9bq5qvNRpo0T47d/SJKVUDuFkpBD7vCxnzi7E0rq0k4cNHLnZr+SU=
X-Gm-Gg: ASbGncv2clIXcERx5PtISEkVY3kHddmFjfA/LAdVBMbTW5qv/LWvzGf8F54mEyB+HQZ
 dIE+HiSEqjE9pbQIGlfzFBc33QYVTiFuY/LvQ3vGVBAvc3/TjGpVsEqUDvhi74lLnx+1IrWZqlT
 eYhRTFIjZk28dMfqqanuw9vWdwGfrnxgDU3DQn2T4gJNNqz36MnHJdB4K98z63n6XdqNa8p9Rp+
 WCl41dG8K9Mk8D1t2985q08Cmqe7A1MftASZkBgGvws37oj8pHpZQgAKFzHYoZhDKPDIK873hoz
 3O1L5uZSGrBglS0v8z7EBZRcozLwpc4tPo+mMBzE4/4T7uE94sx8YnnYSIkEvBxi/g/xYdRy3oQ
 CkHJV8UFIgdEPK69FCp33X95nLvjix/AqFQ==
X-Google-Smtp-Source: AGHT+IHEsBHECiviUdWZHfUSD30z0lwoi05kMfuvu4sjnl94hwuBOCMGe7qDjp6UsjEPrPfsGd/XCg==
X-Received: by 2002:a05:6214:c2a:b0:709:eea9:676f with SMTP id
 6a1803df08f44-70b98315908mr61470166d6.18.1755204160384; 
 Thu, 14 Aug 2025 13:42:40 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:a136:b4d:e75:44c4])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70af5b80440sm18085896d6.62.2025.08.14.13.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 13:42:39 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH] dts: enable port binding on the TG
Date: Thu, 14 Aug 2025 16:38:46 -0400
Message-ID: <20250814203846.407334-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

Currently, driver binding for all nodes relies on a devbind_script_path
attribute in the node main sessions. This attribute is being set on the
SUT node, but not the TG node. Consequently, if the TG node ports are
not bound to the correct driver before DTS execution, the TG ports will
fail to bind and DTS will error.

relocate prepare devbind script method to topology class to be used by both
TG and SUT nodes.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

done
---
 .mailmap                                |  1 +
 dts/framework/remote_session/dpdk.py    | 36 +----------------------
 dts/framework/testbed_model/topology.py | 39 +++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/.mailmap b/.mailmap
index 34a99f93a1..df06862d8b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -104,6 +104,7 @@ Andre Muezerie <andremue@linux.microsoft.com> <andremue@microsoft.com>
 Andrea Arcangeli <aarcange@redhat.com>
 Andrea Grandi <andrea.grandi@intel.com>
 Andre Richter <andre.o.richter@gmail.com>
+Andrew Bailey <abailey@iol.unh.edu>
 Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
 Andrew Harvey <agh@cisco.com>
 Andrew Jackson <ajackson@solarflare.com>
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 606d6e22fe..d1ab3ae50d 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -24,12 +24,11 @@
     RemoteDPDKTarballLocation,
     RemoteDPDKTreeLocation,
 )
-from framework.exception import ConfigurationError, InternalError, RemoteFileNotFoundError
+from framework.exception import ConfigurationError, RemoteFileNotFoundError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
 from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
-from framework.testbed_model.linux_session import LinuxSession
 from framework.testbed_model.node import Node
 from framework.testbed_model.os_session import OSSession
 from framework.testbed_model.virtual_device import VirtualDevice
@@ -358,7 +357,6 @@ def setup(self):
         """Set up the DPDK runtime on the target node."""
         if self.build:
             self.build.setup()
-        self._prepare_devbind_script()
 
     def teardown(self) -> None:
         """Reset DPDK variables and bind port driver to the OS driver."""
@@ -385,38 +383,6 @@ def run_dpdk_app(
             f"{app_path} {eal_params}", timeout, privileged=True, verify=True
         )
 
-    def _prepare_devbind_script(self) -> None:
-        """Prepare the devbind script.
-
-        If the environment has a build associated with it, then use the script within that build's
-        tree. Otherwise, copy the script from the local repository.
-
-        This script is only available for Linux, if the detected session is not Linux then do
-        nothing.
-
-        Raises:
-            InternalError: If dpdk-devbind.py could not be found.
-        """
-        if not isinstance(self._node.main_session, LinuxSession):
-            return
-
-        if self.build:
-            devbind_script_path = self._node.main_session.join_remote_path(
-                self.build.remote_dpdk_tree_path, "usertools", "dpdk-devbind.py"
-            )
-        else:
-            local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
-            if not local_script_path.exists():
-                raise InternalError("Could not find dpdk-devbind.py locally.")
-
-            devbind_script_path = self._node.main_session.join_remote_path(
-                self._node.tmp_dir, local_script_path.name
-            )
-
-            self._node.main_session.copy_to(local_script_path, devbind_script_path)
-
-        self._node.main_session.devbind_script_path = devbind_script_path
-
     def filter_lcores(
         self,
         filter_specifier: LogicalCoreCount | LogicalCoreList,
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 899ea0ad3a..db96aaf170 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -12,11 +12,13 @@
 from collections.abc import Iterator
 from dataclasses import dataclass
 from enum import Enum
+from pathlib import Path
 from typing import Literal, NamedTuple
 
 from typing_extensions import Self
 
 from framework.exception import ConfigurationError, InternalError
+from framework.testbed_model.linux_session import LinuxSession
 from framework.testbed_model.node import Node
 
 from .port import DriverKind, Port, PortConfig
@@ -128,6 +130,7 @@ def setup(self) -> None:
 
         Binds all the ports to the right kernel driver to retrieve MAC addresses and logical names.
         """
+        self._prepare_devbind_script()
         self._setup_ports("sut")
         self._setup_ports("tg")
 
@@ -250,6 +253,42 @@ def _bind_ports_to_drivers(
         for driver_name, ports in driver_to_ports.items():
             node.main_session.bind_ports_to_driver(ports, driver_name)
 
+    def _prepare_devbind_script(self) -> None:
+        """Prepare the devbind script.
+
+        If the environment has a build associated with it, then use the script within that build's
+        tree. Otherwise, copy the script from the local repository.
+
+        This script is only available for Linux, if the detected session is not Linux then do
+        nothing.
+
+        Raises:
+            InternalError: If dpdk-devbind.py could not be found.
+        """
+        from framework.context import get_ctx
+
+        ctx = get_ctx()
+        tg = ctx.tg_node
+        sut = ctx.sut_node
+
+        def prepare_node(node: Node) -> None:
+            if not isinstance(node.main_session, LinuxSession):
+                return
+
+            local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
+            if not local_script_path.exists():
+                raise InternalError("Could not find dpdk-devbind.py locally.")
+
+            devbind_script_path = node.main_session.join_remote_path(
+                node.tmp_dir, local_script_path.name
+            )
+
+            node.main_session.copy_to(local_script_path, devbind_script_path)
+            node.main_session.devbind_script_path = devbind_script_path
+
+        prepare_node(tg)
+        prepare_node(sut)
+
     @property
     def sut_dpdk_ports(self) -> list[Port]:
         """The DPDK ports for the SUT node."""
-- 
2.50.1

