Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60651C28B30
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 13:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BFEC4065E;
	Fri, 14 Mar 2025 14:19:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 026C640613
 for <dev@dpdk.org>; Fri, 14 Mar 2025 14:19:26 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FB081BD0;
 Fri, 14 Mar 2025 06:19:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.40.184])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC89D3F673;
 Fri, 14 Mar 2025 06:19:24 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 6/7] dts: remove multi-inheritance classes
Date: Fri, 14 Mar 2025 15:18:56 +0200
Message-ID: <20250314131857.1298247-7-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131857.1298247-1-luca.vizzarro@arm.com>
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
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

Multi inheritance has proven to be flaky in Python, therefore revert
back to a simpler approach where classes will only inherit one base
class. As part of this change, instead of making the
ScapyTrafficGenerator class inehrit a PythonShell, use simple class
composition, by making the shell a class attribute.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 .../remote_session/interactive_shell.py       |  9 +----
 .../testbed_model/traffic_generator/scapy.py  | 38 +++++++++----------
 .../traffic_generator/traffic_generator.py    |  6 +--
 dts/framework/utils.py                        | 14 -------
 4 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index 6b7ca0b6af..d7e566e5c4 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -37,10 +37,9 @@
 from framework.params import Params
 from framework.settings import SETTINGS
 from framework.testbed_model.node import Node
-from framework.utils import MultiInheritanceBaseClass
 
 
-class InteractiveShell(MultiInheritanceBaseClass, ABC):
+class InteractiveShell(ABC):
     """The base class for managing interactive shells.
 
     This class shouldn't be instantiated directly, but instead be extended. It contains
@@ -90,20 +89,15 @@ def __init__(
         name: str | None = None,
         privileged: bool = False,
         app_params: Params = Params(),
-        **kwargs,
     ) -> None:
         """Create an SSH channel during initialization.
 
-        Additional keyword arguments can be passed through `kwargs` if needed for fulfilling other
-        constructors in the case of multiple inheritance.
-
         Args:
             node: The node on which to run start the interactive shell.
             name: Name for the interactive shell to use for logging. This name will be appended to
                 the name of the underlying node which it is running on.
             privileged: Enables the shell to run as superuser.
             app_params: The command line parameters to be passed to the application on startup.
-            **kwargs: Any additional arguments if any.
         """
         self._node = node
         if name is None:
@@ -112,7 +106,6 @@ def __init__(
         self._app_params = app_params
         self._privileged = privileged
         self._timeout = SETTINGS.timeout
-        super().__init__(**kwargs)
 
     def _setup_ssh_channel(self):
         self._ssh_channel = self._node.main_session.interactive_session.session.invoke_shell()
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index 520561b2eb..78a6ded74c 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -34,7 +34,7 @@
 from .capturing_traffic_generator import CapturingTrafficGenerator
 
 
-class ScapyTrafficGenerator(PythonShell, CapturingTrafficGenerator):
+class ScapyTrafficGenerator(CapturingTrafficGenerator):
     """Provides access to scapy functions on a traffic generator node.
 
     This class extends the base with remote execution of scapy functions. All methods for
@@ -56,6 +56,8 @@ class also extends :class:`.capturing_traffic_generator.CapturingTrafficGenerato
     first.
     """
 
+    _shell: PythonShell
+
     _config: ScapyTrafficGeneratorConfig
 
     #: Name of sniffer to ensure the same is used in all places
@@ -82,25 +84,21 @@ def __init__(self, tg_node: Node, config: ScapyTrafficGeneratorConfig, **kwargs)
             tg_node.config.os == OS.linux
         ), "Linux is the only supported OS for scapy traffic generation"
 
-        super().__init__(node=tg_node, config=config, tg_node=tg_node, **kwargs)
-        self.start_application()
+        super().__init__(tg_node=tg_node, config=config, **kwargs)
+        self._shell = PythonShell(tg_node, "scapy", privileged=True)
 
     def setup(self, ports: Iterable[Port]):
         """Extends :meth:`.traffic_generator.TrafficGenerator.setup`.
 
-        Brings up the port links.
+        Starts up the traffic generator and brings up the port links.
         """
-        super().setup(ports)
         self._tg_node.main_session.bring_up_link(ports)
+        self._shell.start_application()
+        self._shell.send_command("from scapy.all import *")
 
-    def start_application(self) -> None:
-        """Extends :meth:`framework.remote_session.interactive_shell.start_application`.
-
-        Adds a command that imports everything from the scapy library immediately after starting
-        the shell for usage in later calls to the methods of this class.
-        """
-        super().start_application()
-        self.send_command("from scapy.all import *")
+    def close(self):
+        """Close traffic generator."""
+        self._shell.close()
 
     def _send_packets(self, packets: list[Packet], port: Port) -> None:
         """Implementation for sending packets without capturing any received traffic.
@@ -116,7 +114,7 @@ def _send_packets(self, packets: list[Packet], port: Port) -> None:
             "verbose=True",
             ")",
         ]
-        self.send_command(f"\n{self._python_indentation}".join(send_command))
+        self._shell.send_command(f"\n{self._python_indentation}".join(send_command))
 
     def _send_packets_and_capture(
         self,
@@ -155,7 +153,7 @@ def _shell_set_packet_list(self, packets: list[Packet]) -> None:
             packets: The list of packets to recreate in the shell.
         """
         self._logger.info("Building a list of packets to send.")
-        self.send_command(
+        self._shell.send_command(
             f"{self._send_packet_list_name} = [{', '.join(map(Packet.command, packets))}]"
         )
 
@@ -202,7 +200,7 @@ def _shell_create_sniffer(
         """
         self._shell_set_packet_list(packets_to_send)
 
-        self.send_command("import time")
+        self._shell.send_command("import time")
         sniffer_commands = [
             f"{self._sniffer_name} = AsyncSniffer(",
             f"iface='{recv_port.logical_name}',",
@@ -220,7 +218,7 @@ def _shell_create_sniffer(
         if filter_config:
             sniffer_commands.insert(-1, f"filter='{filter_config}'")
 
-        self.send_command(f"\n{self._python_indentation}".join(sniffer_commands))
+        self._shell.send_command(f"\n{self._python_indentation}".join(sniffer_commands))
 
     def _shell_start_and_stop_sniffing(self, duration: float) -> list[Packet]:
         """Start asynchronous sniffer, run for a set `duration`, then collect received packets.
@@ -237,12 +235,12 @@ def _shell_start_and_stop_sniffing(self, duration: float) -> list[Packet]:
             A list of all packets that were received while the sniffer was running.
         """
         sniffed_packets_name = "gathered_packets"
-        self.send_command(f"{self._sniffer_name}.start()")
+        self._shell.send_command(f"{self._sniffer_name}.start()")
         # Insert a one second delay to prevent timeout errors from occurring
         time.sleep(duration + 1)
-        self.send_command(f"{sniffed_packets_name} = {self._sniffer_name}.stop(join=True)")
+        self._shell.send_command(f"{sniffed_packets_name} = {self._sniffer_name}.stop(join=True)")
         # An extra newline is required here due to the nature of interactive Python shells
-        packet_strs = self.send_command(
+        packet_strs = self._shell.send_command(
             f"for pakt in {sniffed_packets_name}: print(bytes_base64(pakt.build()))\n"
         )
         # In the string of bytes "b'XXXX'", we only want the contents ("XXXX")
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
index 804662e114..fbd9771eba 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -17,10 +17,10 @@
 from framework.logger import DTSLogger, get_dts_logger
 from framework.testbed_model.node import Node
 from framework.testbed_model.port import Port
-from framework.utils import MultiInheritanceBaseClass, get_packet_summaries
+from framework.utils import get_packet_summaries
 
 
-class TrafficGenerator(MultiInheritanceBaseClass, ABC):
+class TrafficGenerator(ABC):
     """The base traffic generator.
 
     Exposes the common public methods of all traffic generators and defines private methods
@@ -48,13 +48,13 @@ def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
         self._config = config
         self._tg_node = tg_node
         self._logger = get_dts_logger(f"{self._tg_node.name} {self._config.type}")
-        super().__init__(**kwargs)
 
     def setup(self, ports: Iterable[Port]):
         """Setup the traffic generator."""
 
     def teardown(self, ports: Iterable[Port]):
         """Teardown the traffic generator."""
+        self.close()
 
     def send_packet(self, packet: Packet, port: Port) -> None:
         """Send `packet` and block until it is fully sent.
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index d6f4c11d58..24277633c0 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -299,20 +299,6 @@ def _make_packet() -> Packet:
     return [_make_packet() for _ in range(number_of)]
 
 
-class MultiInheritanceBaseClass:
-    """A base class for classes utilizing multiple inheritance.
-
-    This class enables it's subclasses to support both single and multiple inheritance by acting as
-    a stopping point in the tree of calls to the constructors of superclasses. This class is able
-    to exist at the end of the Method Resolution Order (MRO) so that subclasses can call
-    :meth:`super.__init__` without repercussion.
-    """
-
-    def __init__(self) -> None:
-        """Call the init method of :class:`object`."""
-        super().__init__()
-
-
 def to_pascal_case(text: str) -> str:
     """Convert `text` from snake_case to PascalCase."""
     return "".join([seg.capitalize() for seg in text.split("_")])
-- 
2.43.0

