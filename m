Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C0C83F03
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 15:30:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CD8540665;
	Fri,  4 Jul 2025 17:30:36 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B442540658
 for <dev@dpdk.org>; Fri,  4 Jul 2025 17:30:33 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31F4F26AC;
 Fri,  4 Jul 2025 08:30:19 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC-2.cambridge.arm.com
 [10.1.30.57])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6DEC93F66E;
 Fri,  4 Jul 2025 08:30:32 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: add generic blocking app class
Date: Fri,  4 Jul 2025 16:29:08 +0100
Message-ID: <20250704152908.683265-3-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704152908.683265-1-luca.vizzarro@arm.com>
References: <20250702164204.607685-1-luca.vizzarro@arm.com>
 <20250704152908.683265-1-luca.vizzarro@arm.com>
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

Add a generic blocking app class to allow a test writer to run any app
in the background. Make the original BlockingDPDKApp class inherit from
this one. Implement the new BlockingApp class in the packet_capture test
suite.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/remote_session/blocking_app.py | 135 +++++++++++++++++++
 dts/framework/remote_session/dpdk_app.py     |  80 -----------
 dts/tests/TestSuite_packet_capture.py        |  66 +++------
 3 files changed, 154 insertions(+), 127 deletions(-)
 create mode 100644 dts/framework/remote_session/blocking_app.py
 delete mode 100644 dts/framework/remote_session/dpdk_app.py

diff --git a/dts/framework/remote_session/blocking_app.py b/dts/framework/remote_session/blocking_app.py
new file mode 100644
index 0000000000..8de536c259
--- /dev/null
+++ b/dts/framework/remote_session/blocking_app.py
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""Class to run blocking apps in the background.
+
+The class won't automatically start the app. The start-up is done as part of the
+:meth:`BlockingApp.wait_until_ready` method, which will return execution to the caller only
+when the desired stdout has been returned by the app. Usually this is used to detect when the app
+has been loaded and ready to be used.
+
+This module also provides the class :class:`BlockingDPDKApp` useful to run any DPDK app from the
+DPDK build dir.
+
+Example:
+    ..code:: python
+
+        pdump = BlockingDPDKApp(
+            PurePath("app/dpdk-pdump"),
+            app_params="--pdump 'port=0,queue=*,rx-dev=/tmp/rx-dev.pcap'"
+        )
+        pdump.wait_until_ready("65535") # start app
+
+        # pdump is now ready to capture
+
+        pdump.close() # stop/close app
+"""
+
+from pathlib import PurePath
+from typing import Generic, TypeVar, cast
+
+from typing_extensions import Self
+
+from framework.context import get_ctx
+from framework.params import Params
+from framework.params.eal import EalParams
+from framework.remote_session.dpdk_shell import compute_eal_params
+from framework.remote_session.interactive_shell import InteractiveShell
+from framework.testbed_model.node import Node
+
+P = TypeVar("P", bound=Params)
+
+
+class BlockingApp(InteractiveShell, Generic[P]):
+    """Class to manage generic blocking apps."""
+
+    _app_params: P
+
+    def __init__(
+        self,
+        node: Node,
+        path: PurePath,
+        name: str | None = None,
+        privileged: bool = False,
+        app_params: P | str = "",
+    ) -> None:
+        """Constructor.
+
+        Args:
+            node: The node to run the app on.
+            path: Path to the application on the node.
+            name: Name to identify this application.
+            privileged: Run as privileged user.
+            app_params: The application parameters. Can be of any type inheriting :class:`Params` or
+                a plain string.
+        """
+        if isinstance(app_params, str):
+            params = Params()
+            params.append_str(app_params)
+            app_params = cast(P, params)
+
+        self._path = path
+
+        super().__init__(node, name, privileged, app_params)
+
+    @property
+    def path(self) -> PurePath:
+        """The path of the DPDK app relative to the DPDK build folder."""
+        return self._path
+
+    def wait_until_ready(self, end_token: str) -> Self:
+        """Start app and wait until ready.
+
+        Args:
+            end_token: The string at the end of a line that indicates the app is ready.
+
+        Returns:
+            Itself.
+        """
+        self.start_application(end_token)
+        return self
+
+    def close(self) -> None:
+        """Close the application.
+
+        Sends a SIGINT to close the application.
+        """
+        self.send_command("\x03")
+        super().close()
+
+
+PE = TypeVar("PE", bound=EalParams)
+
+
+class BlockingDPDKApp(BlockingApp, Generic[PE]):
+    """Class to manage blocking DPDK apps on the SUT."""
+
+    _app_params: PE
+
+    def __init__(
+        self,
+        path: PurePath,
+        name: str | None = None,
+        privileged: bool = True,
+        app_params: PE | str = "",
+    ) -> None:
+        """Constructor.
+
+        Args:
+            path: Path relative to the DPDK build to the executable.
+            name: Name to identify this application.
+            privileged: Run as privileged user.
+            app_params: The application parameters. If a string or an incomplete :class:`EalParams`
+                object are passed, the EAL params are computed based on the current context.
+        """
+        if isinstance(app_params, str):
+            eal_params = compute_eal_params()
+            eal_params.append_str(app_params)
+            app_params = cast(PE, eal_params)
+        else:
+            app_params = cast(PE, compute_eal_params(app_params))
+
+        node = get_ctx().sut_node
+        path = PurePath(get_ctx().dpdk_build.remote_dpdk_build_dir).joinpath(self.path)
+
+        super().__init__(node, path, name, privileged, app_params)
diff --git a/dts/framework/remote_session/dpdk_app.py b/dts/framework/remote_session/dpdk_app.py
deleted file mode 100644
index dc4b817bdd..0000000000
--- a/dts/framework/remote_session/dpdk_app.py
+++ /dev/null
@@ -1,80 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2025 Arm Limited
-
-"""Class to run blocking DPDK apps in the background.
-
-The class won't automatically start the app. The start-up is done as part of the
-:meth:`BlockingDPDKApp.wait_until_ready` method, which will return execution to the caller only
-when the desired stdout has been returned by the app. Usually this is used to detect when the app
-has been loaded and ready to be used.
-
-Example:
-    ..code:: python
-
-        pdump = BlockingDPDKApp(
-            PurePath("app/dpdk-pdump"),
-            app_params="--pdump 'port=0,queue=*,rx-dev=/tmp/rx-dev.pcap'"
-        )
-        pdump.wait_until_ready("65535") # start app
-
-        # pdump is now ready to capture
-
-        pdump.close() # stop/close app
-"""
-
-from pathlib import PurePath
-
-from framework.params.eal import EalParams
-from framework.remote_session.dpdk_shell import DPDKShell
-
-
-class BlockingDPDKApp(DPDKShell):
-    """Class to manage blocking DPDK apps."""
-
-    def __init__(
-        self,
-        path: PurePath,
-        name: str | None = None,
-        privileged: bool = True,
-        app_params: EalParams | str = "",
-    ) -> None:
-        """Constructor.
-
-        Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`.
-
-        Args:
-            path: Path relative to the DPDK build to the executable.
-            name: Name to identify this application.
-            privileged: Run as privileged user.
-            app_params: The application parameters. If a string or an incomplete :class:`EalParams`
-                object are passed, the EAL params are computed based on the current context.
-        """
-        if isinstance(app_params, str):
-            eal_params = EalParams()
-            eal_params.append_str(app_params)
-            app_params = eal_params
-
-        self._path = path
-
-        super().__init__(name, privileged, app_params)
-
-    @property
-    def path(self) -> PurePath:
-        """The path of the DPDK app relative to the DPDK build folder."""
-        return self._path
-
-    def wait_until_ready(self, end_token: str) -> None:
-        """Start app and wait until ready.
-
-        Args:
-            end_token: The string at the end of a line that indicates the app is ready.
-        """
-        self.start_application(end_token)
-
-    def close(self) -> None:
-        """Close the application.
-
-        Sends a SIGINT to close the application.
-        """
-        self.send_command("\x03")
-        super().close()
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index e162bded87..bad243a571 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -24,12 +24,10 @@
 from scapy.layers.sctp import SCTP
 from scapy.packet import Packet, Raw, raw
 from scapy.utils import rdpcap
-from typing_extensions import Self
 
-from framework.context import get_ctx
 from framework.params import Params
+from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
-from framework.remote_session.interactive_shell import InteractiveShell
 from framework.remote_session.testpmd_shell import TestPmdShell
 from framework.settings import SETTINGS
 from framework.test_suite import TestSuite, func_test
@@ -61,57 +59,31 @@ class DumpcapParams(Params):
     packet_filter: str | None = field(default=None, metadata=Params.short("f"))
 
 
-class Dumpcap(InteractiveShell):
-    """Class to spawn and manage a dpdk-dumpcap process.
-
-    The dpdk-dumpcap is a DPDK app but instead of providing a regular DPDK EAL interface to the
-    user, it replicates the Wireshark dumpcap app.
-    """
-
-    _app_params: DumpcapParams
-
-    def __init__(self, params: DumpcapParams) -> None:
-        """Extends :meth:`~.interactive_shell.InteractiveShell.__init__`."""
-        self.ctx = get_ctx()
-        eal_params = compute_eal_params()
-        params.lcore_list = eal_params.lcore_list
-        params.file_prefix = eal_params.prefix
-
-        super().__init__(self.ctx.sut_node, name=None, privileged=True, app_params=params)
-
-    @property
-    def path(self) -> PurePath:
-        """Path to the shell executable."""
-        return PurePath(self.ctx.dpdk_build.remote_dpdk_build_dir).joinpath("app/dpdk-dumpcap")
-
-    def wait_until_ready(self) -> Self:
-        """Start app and wait until ready."""
-        self.start_application(f"Capturing on '{self._app_params.interface}'")
-        return self
-
-    def close(self) -> None:
-        """Close the application.
-
-        Sends a SIGINT to close the application.
-        """
-        self.send_command("\x03")
-        super().close()
-
-
 @requires(topology_type=TopologyType.two_links)
 class TestPacketCapture(TestSuite):
     """Packet Capture TestSuite.
 
     Attributes:
-        packets: List of packets to send for testing pdump.
-        rx_pcap_path: The remote path where to create the Rx packets pcap with pdump.
-        tx_pcap_path: The remote path where to create the Tx packets pcap with pdump.
+        packets: List of packets to send for testing dumpcap.
+        rx_pcap_path: The remote path where to create the Rx packets pcap with dumpcap.
+        tx_pcap_path: The remote path where to create the Tx packets pcap with dumpcap.
     """
 
     packets: list[Packet]
     rx_pcap_path: PurePath
     tx_pcap_path: PurePath
 
+    def _run_dumpcap(self, params: DumpcapParams) -> BlockingApp:
+        eal_params = compute_eal_params()
+        params.lcore_list = eal_params.lcore_list
+        params.file_prefix = eal_params.prefix
+        return BlockingApp(
+            self._ctx.sut_node,
+            self._ctx.dpdk_build.get_app("dumpcap"),
+            app_params=params,
+            privileged=True,
+        ).wait_until_ready(f"Capturing on '{params.interface}'")
+
     def set_up_suite(self) -> None:
         """Test suite setup.
 
@@ -147,21 +119,21 @@ def _load_pcap_packets(self, remote_pcap_path: PurePath) -> list[Packet]:
     def _send_and_dump(
         self, packet_filter: str | None = None, rx_only: bool = False
     ) -> list[Packet]:
-        dumpcap_rx = Dumpcap(
+        dumpcap_rx = self._run_dumpcap(
             DumpcapParams(
                 interface=self.topology.sut_port_ingress.pci,
                 output_pcap_path=self.rx_pcap_path,
                 packet_filter=packet_filter,
             )
-        ).wait_until_ready()
+        )
         if not rx_only:
-            dumpcap_tx = Dumpcap(
+            dumpcap_tx = self._run_dumpcap(
                 DumpcapParams(
                     interface=self.topology.sut_port_egress.pci,
                     output_pcap_path=self.tx_pcap_path,
                     packet_filter=packet_filter,
                 )
-            ).wait_until_ready()
+            )
 
         received_packets = self.send_packets_and_capture(
             self.packets, PacketFilteringConfig(no_lldp=False)
-- 
2.43.0

