Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE50CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 13:23:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A8B54026C;
	Fri, 15 Aug 2025 15:23:46 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 133BD4003C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 15:23:45 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7e864a60b26so341928185a.0
 for <dev@dpdk.org>; Fri, 15 Aug 2025 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755264224; x=1755869024; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Lek2dOB0gFXvATf7qDdouTyF+fipY+8OZA5gGYRkUo=;
 b=Y8Kzc1vITUOzs81QkPMhBZa4gvgWJv92W3fPGlyWBLcEdIl0b9Jla2k/sBV5fOQZi8
 +RD3qHrTXc+TPAkWDO5eCZmnjMGHufh/MFZHtnrhwIDku78WwDJF4iN1+TeaeJCE3Rex
 iOQ7vBF/i99bfNmeyK8FuB77dmAHyAAk5ZJLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755264224; x=1755869024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Lek2dOB0gFXvATf7qDdouTyF+fipY+8OZA5gGYRkUo=;
 b=ZJMyTaRSUyufLePiCCwrqlCqMkykQOhWwKrDxtfbwDHXjJHSy9XFdiu36bV3tYsibQ
 vEV+sKMnMqOClv+k9i5C78JLQjCejdFv3c+W8WdWBhAFU1Gr1cAsuebu3rJJjl92zGZj
 ibJ4Oh6IOTzoWY2Cw6HXhgq/3Pa2JB+LFltDg7MV6CMigfbWzVqq8S3pmxY0xAeTYDou
 /bWsh0VqzYFkh2ZZ7T52wkqqlyrkw/udkkuUZSJg1cmpSVCc7TqmMZna9sziUuL+EhjJ
 yLbCFKBo6L7SFlmuHzsYh8UzVWiBhZpSkyVe8rhHToFs9DWWDPTFP24dD7b9DwNq+JsG
 sARA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9zzGtgUDGtA4rhgbw18uHQO7nB+AV1RKJvi18hN8rKiDogmTv3ZqANkwb7lyT81sIXyg=@dpdk.org
X-Gm-Message-State: AOJu0YwguZ3Ah80dn3y+vjCGjQN6z6cR8ZP+s+EMrh44iu6VaPsEYwqv
 TGHaEK8t39rbI9UK6XKhgbfiwbF92544g3/R1aq0aMHM79vX8RTbpF9VBXR7KZ+UXqY=
X-Gm-Gg: ASbGncvXVRBX9UjsEmUQrxTr4Ux+tZYPvnqGRDHoDTOBgP6FEdsWT8uSNtWBWRtk8z6
 etUnHK/GrzEjkSLd5Zm6RKAPRqdrmm2r07BisihAIZoO/MJPX8EWT+mhcRd1JCj0H6KTW211mQp
 gOtcyu1dwPuJjkRMu7nFJh1Be3kCnoEV1mZHHdezUTeH2+6WwesS/maOQc/4Uyu9PdEAkcv993C
 vPrs2ORN+fSECHzp0laGAL+YHFj0eWGHHtsqz9bD6uFgqNDySFJ1BhxT6c0/k3LCY76gtOXOxv+
 uWrM1qdjLIsxTn5MwqFNHSSsCPWTtIZZW8DMzdvqgbm9i/Yjclq9BVPkt0GGylhHQo/+K0BM5w0
 /kg2ZYrCUGAh8pcY8p9eSxD9Nb2x2TcIoPOGbWnItRxu1DaGy
X-Google-Smtp-Source: AGHT+IEr4maXN04hC5yEDlqdgHj1z+lfmKHpArTneRG3EV9aozs8izYErrMl+bUzQcRPv6iEI8KAvQ==
X-Received: by 2002:a05:620a:aa0c:b0:7e8:7a7b:5723 with SMTP id
 af79cd13be357-7e87a7b5765mr422983185a.22.1755264224232; 
 Fri, 15 Aug 2025 06:23:44 -0700 (PDT)
Received: from dhcp-10-21-132-190.iol.unh.edu
 ([2606:4100:3880:1220:a136:b4d:e75:44c4])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e1977dcsm106709085a.49.2025.08.15.06.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 06:23:43 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v2] dts: enable port binding on the TG
Date: Fri, 15 Aug 2025 09:22:40 -0400
Message-ID: <20250815132240.412709-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814203846.407334-1-abailey@iol.unh.edu>
References: <20250814203846.407334-1-abailey@iol.unh.edu>
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

Relocate prepare devbind script method to topology class to be used by both
TG and SUT nodes.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 .mailmap                                |  1 +
 dts/framework/remote_session/dpdk.py    | 36 +-----------------------
 dts/framework/testbed_model/topology.py | 37 +++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 35 deletions(-)

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
index 899ea0ad3a..d1ad5edc0e 100644
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
 
@@ -250,6 +253,40 @@ def _bind_ports_to_drivers(
         for driver_name, ports in driver_to_ports.items():
             node.main_session.bind_ports_to_driver(ports, driver_name)
 
+    def _prepare_devbind_script(self) -> None:
+        """Prepare the devbind script.
+
+        Copy devbind script from local repository.
+
+        This script is only available for Linux, if the detected session is not Linux then do
+        nothing.
+
+        Raises:
+            InternalError: If dpdk-devbind.py could not be found.
+        """
+        from framework.context import get_ctx
+
+        local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
+        valid_script_path = local_script_path.exists()
+
+        def prepare_node(node: Node) -> None:
+            if not isinstance(node.main_session, LinuxSession):
+                return
+
+            if not valid_script_path:
+                raise InternalError("Could not find dpdk-devbind.py locally.")
+
+            devbind_script_path = node.main_session.join_remote_path(
+                node.tmp_dir, local_script_path.name
+            )
+
+            node.main_session.copy_to(local_script_path, devbind_script_path)
+            node.main_session.devbind_script_path = devbind_script_path
+
+        ctx = get_ctx()
+        prepare_node(ctx.tg_node)
+        prepare_node(ctx.sut_node)
+
     @property
     def sut_dpdk_ports(self) -> list[Port]:
         """The DPDK ports for the SUT node."""
-- 
2.50.1

