Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B08ACA1016
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 17:36:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E74140616;
	Mon,  8 Sep 2025 19:36:27 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id D6D9D40615
 for <dev@dpdk.org>; Mon,  8 Sep 2025 19:36:25 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4b5e4fc9b4fso24751091cf.2
 for <dev@dpdk.org>; Mon, 08 Sep 2025 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757352985; x=1757957785; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ls0BGSsj/h4EcC3aZGtHAAepPWHkZeCOizn8YMRq2c=;
 b=CuSBvAaeoZByO8x+8/ke6vfW1DRCXR0t3zO7jOhx4dokOTw3B/boViXgIyIKvXQXkr
 kNzKD8/+oXTdL4ZDNgnEvgptTJY1lXw02qc89OTOHassZCjOQ9ppuP2SWoByMspInwJF
 KM9kTadcTphvKw2e6oEnEtiO62Ye6pLVl5sBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757352985; x=1757957785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ls0BGSsj/h4EcC3aZGtHAAepPWHkZeCOizn8YMRq2c=;
 b=CL3hEMXzIuQLEp6yqvcjgaUJwSKvoRDu3bfra1b/tE1VwVq5x06mB7vIHEHqk4Z8Ee
 fquO7aW7IULbiIG8Jmx1kAJ5ifEdVEIldgV3IKpVWeFfpyoYTSw2Bm7c2zQzGPWG/7sr
 Fm9ISt1jlMy2T1uCFYulhqgUr/X5PBIDK0JhtWjw60Oczt4V3KPTTnISrz3+SFZH9GIz
 /scSi/hH99NSDEQcemf8ZfeiPkr0AHwRABq5Rxz3mYutVTKLiPrMnJnTljl67xbBMIY5
 Ow7rMo+mlCS/Ob284/d4dfg/sAT4ZvJ1HKIIKZO36lWoP3+U5a00XGbsp1jiK/lcHvwe
 N7+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1II+2mVzFr4JZr+jP4e+BTWpnLigwy7b0vIa1IbpDa8Iqj7kPUV2XEqJ+CoWr1U+aTy8=@dpdk.org
X-Gm-Message-State: AOJu0YyCE4ZsVTjj4isjmIsqjRNgv1sXwimZSLjde/3H3JEWavGoOBC9
 gGu+u3y40Kb4na2aFJNjP5oXk9nn+yKvt17q18SdiwhKQcbEtWrzlHqgR4RTJ/scCEk=
X-Gm-Gg: ASbGnctArwp1yCc7Tzf3rxYbAhw8G1VafjXUBaGlufkuh02sjvmlYIDvh0/XK/ZgB7I
 lgjkSQ02RKExSHC8liUjcop9TaVLlrTYEOvvA1dWGVcNW74E9wuhN/9FvKbMRLSJgdOMpLyzQJC
 /uV13xqN4Lc6EtD/ZLPXmJ+oRAne79XvMp/TgZ9gwQ7MOxelaNqVvJXN2kTtlyMaHijTF3w3sGl
 Lv2PbMUR1I+s9zL1JHP+9/0aIIITvutKKKhIT632x/cHceade8gNWFSN2HjJY9wxWUc1xo957JH
 pi1wqc68LXNC2Kv4k8DHPeKXfINFHv9FSKGa/XrQwNyB8R+07fa/WyHqnuunrFw2YqKMNBxTAjt
 58OHEkcPRYwDR49h25R0ypzJ8pqAIG3U6ECi/w+bda/xxe2S93xLWrSk=
X-Google-Smtp-Source: AGHT+IHy4eJh4ny9WUe1ajYHGavUm42bgZZCPTErTzZuKhugpgLrgnUN4cY9xsHB6bmgtuVJtXiCRQ==
X-Received: by 2002:a05:622a:14d4:b0:4b5:8af8:6b28 with SMTP id
 d75a77b69052e-4b5f8465f7emr79458961cf.65.1757352984897; 
 Mon, 08 Sep 2025 10:36:24 -0700 (PDT)
Received: from dhcp-10-21-133-214.unh.edu
 ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f7ac9f8sm107614451cf.52.2025.09.08.10.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 10:36:24 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: abailey@iol.unh.edu, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: [PATCH v4] dts: enable port binding on the TG
Date: Mon,  8 Sep 2025 13:36:18 -0400
Message-ID: <20250908173618.202075-1-abailey@iol.unh.edu>
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

v4: Relocated logic for bringing up ports using mellanox drivers. This
moved from the ports class to the configure_ports method in the
topology class.

 dts/framework/remote_session/dpdk.py    | 36 +------------------
 dts/framework/testbed_model/port.py     |  3 +-
 dts/framework/testbed_model/topology.py | 46 ++++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 37 deletions(-)

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
index fc58e2b993..8f9b5c3931 100644
--- a/dts/framework/testbed_model/port.py
+++ b/dts/framework/testbed_model/port.py
@@ -126,7 +126,8 @@ def original_driver(self) -> str | None:
     @property
     def bound_for_dpdk(self) -> bool:
         """Is the port bound to the driver for DPDK?"""
-        return self.current_driver == self.config.os_driver_for_dpdk
+        dpdk_driver = self.config.os_driver_for_dpdk
+        return self.current_driver == dpdk_driver

     def configure_mtu(self, mtu: int):
         """Configure the port's MTU value.
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 899ea0ad3a..370bcc3c03 100644
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

@@ -232,7 +235,14 @@ def configure_ports(

         self._bind_ports_to_drivers(node, ports, drivers)

-        ports_to_bring_up = [p for p in ports if not (p.bound_for_dpdk or p.is_link_up)]
+        ports_to_bring_up = [
+            p
+            for p in ports
+            if not (
+                (p.bound_for_dpdk and p.config.os_driver_for_dpdk != p.config.os_driver)
+                or p.is_link_up
+            )
+        ]
         if ports_to_bring_up:
             node.main_session.bring_up_link(ports_to_bring_up)

@@ -250,6 +260,40 @@ def _bind_ports_to_drivers(
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

