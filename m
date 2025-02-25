Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861A2C021BB
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 15:34:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB297402DA;
	Tue, 25 Feb 2025 16:34:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id F2AA040299
 for <dev@dpdk.org>; Tue, 25 Feb 2025 16:34:11 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC9AD28C7;
 Tue, 25 Feb 2025 07:34:27 -0800 (PST)
Received: from e132991.cambridge.arm.com (unknown [10.1.195.24])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4249B3F5A1;
 Tue, 25 Feb 2025 07:34:10 -0800 (PST)
From: Thomas Wilks <thomas.wilks@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Alex Chapman <alex.chapman@arm.com>, Thomas Wilks <thomas.wilks@arm.com>
Subject: [PATCH v2 1/6] dts: add RSS functions to testpmd
Date: Tue, 25 Feb 2025 15:33:40 +0000
Message-ID: <20250225153345.331216-2-thomas.wilks@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225153345.331216-1-thomas.wilks@arm.com>
References: <20240829125020.34341-1-alex.chapman@arm.com>
 <20250225153345.331216-1-thomas.wilks@arm.com>
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

From: Alex Chapman <alex.chapman@arm.com>

This patch adds the required functionality for the RSS key_update,
RETA, and hash test suites. This includes:
The setting of custom RETA values for routing packets to specific
queues.
The setting of the RSS mode on all ports, to specify how to hash
the packets.
The updating of the RSS hash key used during the hashing process.

Alongside this, there is the addition of a __str__ method to the
RSSOffloadTypesFlags class, so that when flag names are cast to
a string they will use '-' as separators, instead of '_'.
This allows them to be directly used within testpmd RSS commands
without any further changes.

Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>

Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/remote_session/testpmd_shell.py | 137 ++++++++++++++++--
 1 file changed, 123 insertions(+), 14 deletions(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 1f291fcb68..0e1f29f2f3 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -350,6 +350,12 @@ def make_parser(cls) -> ParserFn:
             RSSOffloadTypesFlag.from_list_string,
         )
 
+    def __str__(self):
+        """Replaces underscores with hyphens to produce valid testpmd value."""
+        if self.name is None:
+            return ""
+        return self.name.replace("_", "-")
+
 
 class DeviceCapabilitiesFlag(Flag):
     """Flag representing the device capabilities."""
@@ -655,7 +661,8 @@ class TestPmdPort(TextParser):
     )
     #: Maximum number of VMDq pools
     max_vmdq_pools_num: int | None = field(
-        default=None, metadata=TextParser.find_int(r"Maximum number of VMDq pools: (\d+)")
+        default=None,
+        metadata=TextParser.find_int(r"Maximum number of VMDq pools: (\d+)"),
     )
 
     #:
@@ -1482,7 +1489,9 @@ def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs):
     return _wrapper
 
 
-def add_remove_mtu(mtu: int = 1500) -> Callable[[TestPmdShellMethod], TestPmdShellMethod]:
+def add_remove_mtu(
+    mtu: int = 1500,
+) -> Callable[[TestPmdShellMethod], TestPmdShellMethod]:
     """Configure MTU to `mtu` on all ports, run the decorated function, then revert.
 
     Args:
@@ -1723,6 +1732,82 @@ def set_ports_queues(self, number_of: int) -> None:
         self.send_command(f"port config all rxq {number_of}")
         self.send_command(f"port config all txq {number_of}")
 
+    def port_config_rss_reta(
+        self, port_id: int, hash_index: int, queue_id: int, verify: bool = True
+    ) -> None:
+        """Configure a port's RSS redirection table.
+
+        Args:
+            port_id: The port where the redirection table will be configured.
+            hash_index: The index into the redirection table associated with the destination queue.
+            queue_id: The destination queue of the packet.
+            verify: If :data:`True`, verifies if a port's redirection table
+                was correctly configured.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True`
+                Testpmd failed to config RSS reta.
+        """
+        out = self.send_command(f"port config {port_id} rss reta ({hash_index},{queue_id})")
+        if verify:
+            if f"The reta size of port {port_id} is" not in out:
+                self._logger.debug(f"Failed to config RSS reta: \n{out}")
+                raise InteractiveCommandExecutionError("Testpmd failed to config RSS reta.")
+
+    def port_config_all_rss_offload_type(
+        self, flag: RSSOffloadTypesFlag, verify: bool = True
+    ) -> None:
+        """Set the RSS mode on all ports.
+
+        Args:
+            flag: The RSS iptype all ports will be configured to.
+            verify: If :data:`True`, it verifies if all ports RSS offload type
+                was correctly configured.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True`
+                Testpmd failed to config the RSS mode on all ports.
+        """
+        out = self.send_command(f"port config all rss {flag.name}")
+        if verify:
+            if "error" in out:
+                self._logger.debug(f"Failed to config the RSS mode on all ports: \n{out}")
+                raise InteractiveCommandExecutionError(
+                    f"Testpmd failed to change RSS mode to {flag.name}"
+                )
+
+    def port_config_rss_hash_key(
+        self,
+        port_id: int,
+        offload_type: RSSOffloadTypesFlag,
+        hex_str: str,
+        verify: bool = True,
+    ) -> str:
+        """Sets the RSS hash key for the specified port.
+
+        Args:
+            port_id: The port that will have the hash key applied to.
+            offload_type: The offload type the hash key will be applied to.
+            hex_str: The hash key to set.
+            verify: If :data:`True`, verify that RSS has the key.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True`
+                Testpmd failed to set the RSS hash key.
+        """
+        output = self.send_command(
+            f"port config {port_id} rss-hash-key {offload_type} {hex_str}",
+            skip_first_line=True,
+        )
+
+        if verify:
+            if output.strip():
+                self._logger.debug(f"Failed to set rss hash key: \n{output}")
+                raise InteractiveCommandExecutionError(
+                    f"Testpmd failed to set {hex_str} on {port_id} with a flag of {offload_type}."
+                )
+        return output
+
     def show_port_info_all(self) -> list[TestPmdPort]:
         """Returns the information of all the ports.
 
@@ -1939,22 +2024,28 @@ def csum_set_hw(
                                                            {port_id}:\n{csum_output}"""
                     )
 
-    def flow_create(self, flow_rule: FlowRule, port_id: int) -> int:
+    def flow_create(self, flow_rule: FlowRule, port_id: int, verify: bool = True) -> int:
         """Creates a flow rule in the testpmd session.
 
-        This command is implicitly verified as needed to return the created flow rule id.
-
         Args:
             flow_rule: :class:`FlowRule` object used for creating testpmd flow rule.
             port_id: Integer representing the port to use.
+            verify: If :data:`True`, the output of the command is scanned
+            to ensure the flow rule was created successfully.
 
         Raises:
             InteractiveCommandExecutionError: If flow rule is invalid.
 
         Returns:
-            Id of created flow rule.
+            Id of created flow rule as an integer.
         """
         flow_output = self.send_command(f"flow create {port_id} {flow_rule}")
+        if verify:
+            if "created" not in flow_output:
+                self._logger.debug(f"Failed to create flow rule:\n{flow_output}")
+                raise InteractiveCommandExecutionError(
+                    f"Failed to create flow rule:\n{flow_output}"
+                )
         match = re.search(r"#(\d+)", flow_output)
         if match is not None:
             match_str = match.group(1)
@@ -1968,10 +2059,10 @@ def flow_delete(self, flow_id: int, port_id: int, verify: bool = True) -> None:
         """Deletes the specified flow rule from the testpmd session.
 
         Args:
-            flow_id: ID of the flow to remove.
+            flow_id: :class:`FlowRule` id used for deleting testpmd flow rule.
             port_id: Integer representing the port to use.
             verify: If :data:`True`, the output of the command is scanned
-                to ensure the flow rule was deleted successfully.
+            to ensure the flow rule was deleted successfully.
 
         Raises:
             InteractiveCommandExecutionError: If flow rule is invalid.
@@ -2639,7 +2730,10 @@ class NicCapability(NoAliasEnum):
         None,
     )
     #: Device supports Large Receive Offload.
-    RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
+    RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
+    )
     #: Device supports QinQ (queue in queue) offload.
     RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability = (
         TestPmdShell.get_capabilities_rx_offload,
@@ -2666,7 +2760,10 @@ class NicCapability(NoAliasEnum):
         None,
     )
     #: Device supports receiving segmented mbufs.
-    RX_OFFLOAD_SCATTER: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
+    RX_OFFLOAD_SCATTER: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
+    )
     #: Device supports Timestamp.
     RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability = (
         TestPmdShell.get_capabilities_rx_offload,
@@ -2708,7 +2805,10 @@ class NicCapability(NoAliasEnum):
         None,
     )
     #: Device supports all VLAN capabilities.
-    RX_OFFLOAD_VLAN: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
+    RX_OFFLOAD_VLAN: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_rx_offload,
+        None,
+    )
     #: Device supports Rx queue setup after device started.
     RUNTIME_RX_QUEUE_SETUP: TestPmdShellNicCapability = (
         TestPmdShell.get_capabilities_show_port_info,
@@ -2720,9 +2820,15 @@ class NicCapability(NoAliasEnum):
         None,
     )
     #: Device supports shared Rx queue among ports within Rx domain and switch domain.
-    RXQ_SHARE: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_show_port_info, None)
+    RXQ_SHARE: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_show_port_info,
+        None,
+    )
     #: Device supports keeping flow rules across restart.
-    FLOW_RULE_KEEP: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_show_port_info, None)
+    FLOW_RULE_KEEP: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_show_port_info,
+        None,
+    )
     #: Device supports keeping shared flow objects across restart.
     FLOW_SHARED_OBJECT_KEEP: TestPmdShellNicCapability = (
         TestPmdShell.get_capabilities_show_port_info,
@@ -2734,7 +2840,10 @@ class NicCapability(NoAliasEnum):
         None,
     )
     #: Device supports flow ctrl.
-    FLOW_CTRL: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_flow_ctrl, None)
+    FLOW_CTRL: TestPmdShellNicCapability = (
+        TestPmdShell.get_capabilities_flow_ctrl,
+        None,
+    )
 
     def __call__(
         self,
-- 
2.43.0

