Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FABBC02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:46:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2030B42E64;
	Wed, 12 Feb 2025 17:46:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 24FEF42DD1
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:46:09 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A72C01E7D;
 Wed, 12 Feb 2025 08:46:29 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.11.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8B093F5A1;
 Wed, 12 Feb 2025 08:46:07 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Nicholas Pratte <npratte@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 3/7] dts: revamp Topology model
Date: Wed, 12 Feb 2025 16:45:56 +0000
Message-ID: <20250212164600.23759-4-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212164600.23759-1-luca.vizzarro@arm.com>
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250212164600.23759-1-luca.vizzarro@arm.com>
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

Change the Topology model to add further flexility in its usage as a
standalone entry point to test suites.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/testbed_model/topology.py | 85 +++++++++++++------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 814c3f3fe4..cf5c2c28ba 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -9,10 +9,12 @@
 """
 
 from collections.abc import Iterator
+from dataclasses import dataclass
 from enum import Enum
 from typing import NamedTuple
 
-from framework.config.node import PortConfig
+from typing_extensions import Self
+
 from framework.exception import ConfigurationError
 
 from .port import Port
@@ -43,35 +45,32 @@ class PortLink(NamedTuple):
     tg_port: Port
 
 
+@dataclass(frozen=True)
 class Topology:
     """Testbed topology.
 
     The topology contains ports processed into ingress and egress ports.
-    If there are no ports on a node, dummy ports (ports with no actual values) are stored.
-    If there is only one link available, the ports of this link are stored
+    If there are no ports on a node, accesses to :attr:`~Topology.tg_port_egress` and alike will
+    raise an exception. If there is only one link available, the ports of this link are stored
     as both ingress and egress ports.
 
-    The dummy ports shouldn't be used. It's up to :class:`~framework.runner.DTSRunner`
-    to ensure no test case or suite requiring actual links is executed
-    when the topology prohibits it and up to the developers to make sure that test cases
-    not requiring any links don't use any ports. Otherwise, the underlying methods
-    using the ports will fail.
+    It's up to :class:`~framework.test_run.TestRun` to ensure no test case or suite requiring actual
+    links is executed when the topology prohibits it and up to the developers to make sure that test
+    cases not requiring any links don't use any ports. Otherwise, the underlying methods using the
+    ports will fail.
 
     Attributes:
         type: The type of the topology.
-        tg_port_egress: The egress port of the TG node.
-        sut_port_ingress: The ingress port of the SUT node.
-        sut_port_egress: The egress port of the SUT node.
-        tg_port_ingress: The ingress port of the TG node.
+        sut_ports: The SUT ports.
+        tg_ports: The TG ports.
     """
 
     type: TopologyType
-    tg_port_egress: Port
-    sut_port_ingress: Port
-    sut_port_egress: Port
-    tg_port_ingress: Port
+    sut_ports: list[Port]
+    tg_ports: list[Port]
 
-    def __init__(self, port_links: Iterator[PortLink]):
+    @classmethod
+    def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
         """Create the topology from `port_links`.
 
         Args:
@@ -80,34 +79,40 @@ def __init__(self, port_links: Iterator[PortLink]):
         Raises:
             ConfigurationError: If an unsupported link topology is supplied.
         """
-        dummy_port = Port(
-            "",
-            PortConfig(
-                name="dummy",
-                pci="0000:00:00.0",
-                os_driver_for_dpdk="",
-                os_driver="",
-            ),
-        )
-
-        self.type = TopologyType.no_link
-        self.tg_port_egress = dummy_port
-        self.sut_port_ingress = dummy_port
-        self.sut_port_egress = dummy_port
-        self.tg_port_ingress = dummy_port
+        type = TopologyType.no_link
 
         if port_link := next(port_links, None):
-            self.type = TopologyType.one_link
-            self.tg_port_egress = port_link.tg_port
-            self.sut_port_ingress = port_link.sut_port
-            self.sut_port_egress = self.sut_port_ingress
-            self.tg_port_ingress = self.tg_port_egress
+            type = TopologyType.one_link
+            sut_ports = [port_link.sut_port]
+            tg_ports = [port_link.tg_port]
 
             if port_link := next(port_links, None):
-                self.type = TopologyType.two_links
-                self.sut_port_egress = port_link.sut_port
-                self.tg_port_ingress = port_link.tg_port
+                type = TopologyType.two_links
+                sut_ports.append(port_link.sut_port)
+                tg_ports.append(port_link.tg_port)
 
                 if next(port_links, None) is not None:
                     msg = "More than two links in a topology are not supported."
                     raise ConfigurationError(msg)
+
+        return cls(type, sut_ports, tg_ports)
+
+    @property
+    def tg_port_egress(self) -> Port:
+        """The egress port of the TG node."""
+        return self.tg_ports[0]
+
+    @property
+    def sut_port_ingress(self) -> Port:
+        """The ingress port of the SUT node."""
+        return self.sut_ports[0]
+
+    @property
+    def sut_port_egress(self) -> Port:
+        """The egress port of the SUT node."""
+        return self.sut_ports[1 if self.type is TopologyType.two_links else 0]
+
+    @property
+    def tg_port_ingress(self) -> Port:
+        """The ingress port of the TG node."""
+        return self.tg_ports[1 if self.type is TopologyType.two_links else 0]
-- 
2.43.0

