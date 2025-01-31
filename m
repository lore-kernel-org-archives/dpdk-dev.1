Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC68C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 19:19:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2164402B2;
	Fri, 31 Jan 2025 20:19:40 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 581354026E
 for <dev@dpdk.org>; Fri, 31 Jan 2025 20:19:37 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 319C8497;
 Fri, 31 Jan 2025 11:20:02 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.75.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF4D73F694;
 Fri, 31 Jan 2025 11:19:35 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, Akhil Goyal <gakhil@marvell.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Paul Szczepanek <paul.szczepanek@arm.com>
Subject: [PATCH 2/3] dts: stop using partial in enums
Date: Fri, 31 Jan 2025 19:19:23 +0000
Message-ID: <20250131191924.1936157-3-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250131191924.1936157-1-luca.vizzarro@arm.com>
References: <20250131191924.1936157-1-luca.vizzarro@arm.com>
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

Starting from Python 3.13 functools.partial is started to be treated as
a method descriptor. As a consequence, any class attributes whose value
is functools.partial is no longer treated as an attribute, but a class
method instead.

NicCapability is an enum that expects to have methods as values, and
functools.partial was used exactly for the purpose of turning them into
attributes instead of being treated as descriptors. Python 3.11
introduces enum.member which purpose is to make anything passed to it
being always treated as an enum member. Which is exactly what it was
being achieved with partial.

While DTS still supports 3.10 and enum.member is not available, make
NicCapability accept only decorator tuples, where the decorator can now
be set to None when not in use.

Bugzilla ID: 1617

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 dts/framework/remote_session/testpmd_shell.py | 145 +++++++++---------
 dts/framework/testbed_model/capability.py     |   6 +-
 2 files changed, 77 insertions(+), 74 deletions(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 9f07696aa2..8456120c9e 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -50,9 +50,7 @@
 
 TestPmdShellDecorator: TypeAlias = Callable[[TestPmdShellMethod], TestPmdShellMethod]
 
-TestPmdShellNicCapability = (
-    TestPmdShellCapabilityMethod | tuple[TestPmdShellCapabilityMethod, TestPmdShellDecorator]
-)
+TestPmdShellNicCapability = tuple[TestPmdShellCapabilityMethod, TestPmdShellDecorator | None]
 
 
 class TestPmdDevice:
@@ -1816,7 +1814,7 @@ def set_multicast_mac_addr(
         if verify:
             if (
                 "Invalid multicast_addr" in output
-                or f'multicast address {"already" if add else "not"} filtered by port' in output
+                or f"multicast address {'already' if add else 'not'} filtered by port" in output
             ):
                 self._logger.debug(f"Failed to {mcast_cmd} {multi_addr} on port {port_id}")
                 raise InteractiveCommandExecutionError(
@@ -1950,7 +1948,7 @@ def set_port_mtu(self, port_id: int, mtu: int, verify: bool = True) -> None:
         set_mtu_output = self.send_command(f"port config mtu {port_id} {mtu}")
         if verify and (f"MTU: {mtu}" not in self.send_command(f"show port info {port_id}")):
             self._logger.debug(
-                f"Failed to set mtu to {mtu} on port {port_id}." f" Output was:\n{set_mtu_output}"
+                f"Failed to set mtu to {mtu} on port {port_id}. Output was:\n{set_mtu_output}"
             )
             raise InteractiveCommandExecutionError(
                 f"Test pmd failed to update mtu of port {port_id} to {mtu}"
@@ -2018,11 +2016,11 @@ def set_vlan_filter(self, port: int, enable: bool, verify: bool = True) -> None:
             vlan_settings = self.show_port_info(port_id=port).vlan_offload
             if enable ^ (vlan_settings is not None and VLANOffloadFlag.FILTER in vlan_settings):
                 self._logger.debug(
-                    f"""Failed to {'enable' if enable else 'disable'}
+                    f"""Failed to {"enable" if enable else "disable"}
                                    filter on port {port}: \n{filter_cmd_output}"""
                 )
                 raise InteractiveCommandExecutionError(
-                    f"""Failed to {'enable' if enable else 'disable'}
+                    f"""Failed to {"enable" if enable else "disable"}
                     filter on port {port}"""
                 )
 
@@ -2109,7 +2107,7 @@ def rx_vlan(self, vlan: int, port: int, add: bool, verify: bool = True) -> None:
                 or "Bad arguments" in rx_cmd_output
             ):
                 self._logger.debug(
-                    f"""Failed to {'add' if add else 'remove'} tag {vlan}
+                    f"""Failed to {"add" if add else "remove"} tag {vlan}
                     port {port}: \n{rx_cmd_output}"""
                 )
                 raise InteractiveCommandExecutionError(
@@ -2135,7 +2133,7 @@ def set_vlan_strip(self, port: int, enable: bool, verify: bool = True) -> None:
             vlan_settings = self.show_port_info(port_id=port).vlan_offload
             if enable ^ (vlan_settings is not None and VLANOffloadFlag.STRIP in vlan_settings):
                 self._logger.debug(
-                    f"""Failed to set strip {'on' if enable else 'off'}
+                    f"""Failed to set strip {"on" if enable else "off"}
                     port {port}: \n{strip_cmd_output}"""
                 )
                 raise InteractiveCommandExecutionError(
@@ -2543,113 +2541,122 @@ class NicCapability(NoAliasEnum):
         add_remove_mtu(9000),
     )
     #:
-    RX_OFFLOAD_VLAN_STRIP: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_VLAN_STRIP: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports L3 checksum offload.
-    RX_OFFLOAD_IPV4_CKSUM: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_UDP_CKSUM: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_TCP_CKSUM: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports Large Receive Offload.
-    RX_OFFLOAD_TCP_LRO: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
-    )
+    RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
     #: Device supports QinQ (queue in queue) offload.
-    RX_OFFLOAD_QINQ_STRIP: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports inner packet L3 checksum.
-    RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports MACsec.
-    RX_OFFLOAD_MACSEC_STRIP: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_MACSEC_STRIP: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports filtering of a VLAN Tag identifier.
-    RX_OFFLOAD_VLAN_FILTER: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_VLAN_FILTER: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports VLAN offload.
-    RX_OFFLOAD_VLAN_EXTEND: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_VLAN_EXTEND: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports receiving segmented mbufs.
-    RX_OFFLOAD_SCATTER: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
-    )
+    RX_OFFLOAD_SCATTER: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
     #: Device supports Timestamp.
-    RX_OFFLOAD_TIMESTAMP: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports crypto processing while packet is received in NIC.
-    RX_OFFLOAD_SECURITY: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports CRC stripping.
-    RX_OFFLOAD_KEEP_CRC: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_KEEP_CRC: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports L4 checksum offload.
-    RX_OFFLOAD_SCTP_CKSUM: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports inner packet L4 checksum.
-    RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports RSS hashing.
-    RX_OFFLOAD_RSS_HASH: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_RSS_HASH: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports scatter Rx packets to segmented mbufs.
-    RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports all checksum capabilities.
-    RX_OFFLOAD_CHECKSUM: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
+    RX_OFFLOAD_CHECKSUM: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
     )
     #: Device supports all VLAN capabilities.
-    RX_OFFLOAD_VLAN: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_rx_offload
-    )
+    RX_OFFLOAD_VLAN: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
     #: Device supports Rx queue setup after device started.
-    RUNTIME_RX_QUEUE_SETUP: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_show_port_info
+    RUNTIME_RX_QUEUE_SETUP: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_show_port_info,
+        None,
     )
     #: Device supports Tx queue setup after device started.
-    RUNTIME_TX_QUEUE_SETUP: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_show_port_info
+    RUNTIME_TX_QUEUE_SETUP: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_show_port_info,
+        None,
     )
     #: Device supports shared Rx queue among ports within Rx domain and switch domain.
-    RXQ_SHARE: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_show_port_info
-    )
+    RXQ_SHARE: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_show_port_info, None)
     #: Device supports keeping flow rules across restart.
-    FLOW_RULE_KEEP: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_show_port_info
-    )
+    FLOW_RULE_KEEP: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_show_port_info, None)
     #: Device supports keeping shared flow objects across restart.
-    FLOW_SHARED_OBJECT_KEEP: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_show_port_info
+    FLOW_SHARED_OBJECT_KEEP: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_show_port_info,
+        None,
     )
     #: Device supports multicast address filtering.
-    MCAST_FILTERING: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_mcast_filtering
+    MCAST_FILTERING: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_mcast_filtering,
+        None,
     )
     #: Device supports flow ctrl.
-    FLOW_CTRL: TestPmdShellCapabilityMethod = functools.partial(
-        TestPmdShell.get_capabilities_flow_ctrl
-    )
+    FLOW_CTRL: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_flow_ctrl, None)
 
     def __call__(
         self,
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index 6a7a1f5b6c..ddfa3853df 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -186,11 +186,7 @@ def get_unique(cls, nic_capability: NicCapability) -> Self:
         Returns:
             The capability uniquely identified by `nic_capability`.
         """
-        decorator_fn = None
-        if isinstance(nic_capability.value, tuple):
-            capability_fn, decorator_fn = nic_capability.value
-        else:
-            capability_fn = nic_capability.value
+        capability_fn, decorator_fn = nic_capability.value
 
         if nic_capability not in cls._unique_capabilities:
             cls._unique_capabilities[nic_capability] = cls(
-- 
2.43.0

