Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75293CA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 12:38:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6780D4025A;
	Thu, 28 Aug 2025 14:38:31 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id D3ABE400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 14:38:29 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-70dfa0a9701so3848026d6.2
 for <dev@dpdk.org>; Thu, 28 Aug 2025 05:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756384709; x=1756989509; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCLbSqoGuQS+JljYG3C1Cp6P+XqS/8EQPLt5t9NzMJg=;
 b=Z1cLFaroFTf7j3JOrrlWH5hpzDEKyQlImuAFmtbLyzW/OMNxE3Pp07pdxlD3NpIrrJ
 fNBYMdFhFRCJABHuiSDCs1K55XFAnZXQ837WyZptKYDq2+EWpkjeGkVrikYf+A0xoory
 uZdznS88kkfasH/GQehIwWbK3v0VUYLlKexCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756384709; x=1756989509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCLbSqoGuQS+JljYG3C1Cp6P+XqS/8EQPLt5t9NzMJg=;
 b=WTw/GEOv9mAis2liiITbJgFcgVP/uDZe+ZpBguHWlf1sdClCoRKNKfB5IbbLbs1ME5
 jPTN+rj/PHiksCtS9CJCOtJklFz1auBiSELrMByACotZHo0lBrvLa4T0SKxrFMTKW3NY
 TTfMfgth/aeUaDHA98S4T+siU3UJS8ejenDmef4eoL5Iq2uhUxxO6Qj6O1F/dvXy4f2/
 ZGVJ7rGop8Iw9olKJLFdePR1g60riZ6+G7BL09OA8Z00HP1xXJsikafT408M7V3HKC0t
 bKPia/LI6RAZ4HucOdfo9deHth/MMUfkw4tCXCzFAy7iLcwqIAa3WXqOMMQ6YSKFVAxm
 7PYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHYvt2cFmTiMwVH3znQ0tGr0/DynIC2cstngPpkXbnC3/sjKW5KonTIzaQSA4Fz/7STUA=@dpdk.org
X-Gm-Message-State: AOJu0Yw/1NwMHp9rcWU9pZX77bqLbldG2i2WvpqzWTuO2P0eNrgcUv3s
 AofM2vM32Nk7Mccgb+63RUWh2cvIVnHUTQyWTPB7U6c37KKkj3UHxgsbTEkWvwM7Tcw=
X-Gm-Gg: ASbGncvIU9H7p5gAkU4iWNSCBYAWSk8r0KdSieGFF7PuBKkLYM+DpkhBS5hqo00rb8h
 V/G8+rJTP4REG4Mf+FkpC0VvvGGHgtAZTCTEleHz/U4UBxTQZUmRa7k172Yl/TgjYHB6K396zI4
 CPWBkPTzdbgh3eYgM2XHyFuQIRYyJTaSPQrKgHrN5lTiP5szk1x+rv8G0tOo8EXb24io2TWDQJR
 D6rVDsEL1ZISh4ogOT9VpCfkf0L7gFNIkQ9eNeBEUtF8xkIuFbOD1jXYQCAYq0ZwtN8Gy0+6O/I
 bmyIT3zcfPUeWMdThAXAQi91K11wPI1lY7HM+UxZ/5L7AbK8cdTKiOht/YtD81AI1KW4PzdOgHF
 WHIaO8BEm7qCYrvuc2VNOBwFp0CruTy7cro6ci5TqJM5QTQ==
X-Google-Smtp-Source: AGHT+IGhj3zxFcawSAzM/ny75qy3mVt6VYl1ZdIhEmz2X+93TXw65VM6BrYFqw6PNVpe3OpiVUHejg==
X-Received: by 2002:a05:6214:29ee:b0:70d:cbbc:ad02 with SMTP id
 6a1803df08f44-70dcbbcb087mr132627736d6.3.1756384708907; 
 Thu, 28 Aug 2025 05:38:28 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70da72872bbsm104805726d6.49.2025.08.28.05.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:38:28 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v3] dts: enable port binding on the TG
Date: Thu, 28 Aug 2025 08:37:58 -0400
Message-ID: <20250828123758.20451-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808182152.356879-2-abailey@iol.unh.edu>
References: <20250808182152.356879-2-abailey@iol.unh.edu>
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

Currently, ports on the TG are not bound to the correct drivers prior to
running DTS. This causes DTS to crash if they are not initially bound to
the intended drivers. Binding the TG ports to the proper driver caused
DTS to fail when the OS and DPDK drivers were the same, due to the port
link not being up. Changing the bound_for_dpdk method for a port to
return false when the OS driver and DPDK driver were shared on a TG
node allowed the TG ports to enter the logic to be brought up in the
configure_ports method within the topology class.

Leverage TG runtime environment to bind TG ports to correct drivers
before and after running DTS.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/remote_session/dpdk.py    | 36 +----------------------
 dts/framework/testbed_model/port.py     |  7 ++++-
 dts/framework/testbed_model/topology.py | 38 +++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 36 deletions(-)

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
diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_model/port.py
index fc58e2b993..e9ad145f97 100644
--- a/dts/framework/testbed_model/port.py
+++ b/dts/framework/testbed_model/port.py
@@ -126,7 +126,12 @@ def original_driver(self) -> str | None:
     @property
     def bound_for_dpdk(self) -> bool:
         """Is the port bound to the driver for DPDK?"""
-        return self.current_driver == self.config.os_driver_for_dpdk
+        dpdk_driver = self.config.os_driver_for_dpdk
+
+        if "TG" in self.node.name:
+            return self.current_driver == dpdk_driver and dpdk_driver != self.config.os_driver
+
+        return self.current_driver == dpdk_driver
 
     def configure_mtu(self, mtu: int):
         """Configure the port's MTU value.
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 899ea0ad3a..b35a519719 100644
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
 
@@ -250,6 +253,41 @@ def _bind_ports_to_drivers(
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
+        # ctx.tg_node.main_session.bring_up_link(self.sut_ports)
+
     @property
     def sut_dpdk_ports(self) -> list[Port]:
         """The DPDK ports for the SUT node."""
-- 
2.50.1

