Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5ECC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 17:41:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8210B402E1;
	Tue, 18 Mar 2025 18:41:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 08314402D1
 for <dev@dpdk.org>; Tue, 18 Mar 2025 18:41:00 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 378BB13D5;
 Tue, 18 Mar 2025 10:41:08 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EFDDA3F673;
 Tue, 18 Mar 2025 10:40:58 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] dts: add Scapy asynchronous sniffer
Date: Tue, 18 Mar 2025 17:40:51 +0000
Message-ID: <20250318174051.1931041-1-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
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

Currently packet capturing in Scapy is used by running Scapy's own
class AsyncSniffer in the same shell as packet sending. Because there is
some start up time involved in the AsyncSniffer, doing this every single
time a test case requires it can become slow and unreliable if sniffer
was not ready yet at the time of sending.

Add a multi-threaded implementation for sniffing and capturing packets
on-demand using Scapy. The sniffer lives in its own dedicated shell,
which is setup for sniffing at the start up of the test run. Packets are
only captured when requested by the tests through the use of Event
signals.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 dts/framework/test_run.py                     |   2 +-
 .../testbed_model/traffic_generator/scapy.py  | 347 ++++++++++++------
 .../traffic_generator/traffic_generator.py    |   2 +-
 dts/framework/utils.py                        |   1 -
 4 files changed, 239 insertions(+), 113 deletions(-)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index f9cfe5e908..24e6fe4e94 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -345,7 +345,7 @@ def next(self) -> State | None:
         test_run.ctx.sut_node.setup()
         test_run.ctx.tg_node.setup()
         test_run.ctx.dpdk.setup(test_run.ctx.topology.sut_ports)
-        test_run.ctx.tg.setup(test_run.ctx.topology.tg_ports)
+        test_run.ctx.tg.setup(test_run.ctx.topology.tg_ports, test_run.ctx.topology.tg_port_ingress)
 
         self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
         self.result.sut_info = test_run.ctx.sut_node.node_info
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index 520561b2eb..09adcafcd8 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2022 University of New Hampshire
 # Copyright(c) 2023 PANTHEON.tech s.r.o.
+# Copyright(c) 2025 Arm Limited
 
 """The Scapy traffic generator.
 
@@ -12,9 +13,9 @@
 implement the methods for handling packets by sending commands into the interactive shell.
 """
 
-import re
-import time
-from collections.abc import Iterable
+from collections.abc import Callable, Iterable
+from queue import Empty, SimpleQueue
+from threading import Event, Thread
 from typing import ClassVar
 
 from scapy.compat import base64_bytes
@@ -23,17 +24,227 @@
 
 from framework.config.node import OS
 from framework.config.test_run import ScapyTrafficGeneratorConfig
+from framework.exception import InteractiveSSHSessionDeadError, InternalError
 from framework.remote_session.python_shell import PythonShell
 from framework.testbed_model.node import Node
 from framework.testbed_model.port import Port
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
 )
-from framework.utils import REGEX_FOR_BASE64_ENCODING
 
 from .capturing_traffic_generator import CapturingTrafficGenerator
 
 
+class ScapyAsyncSniffer(PythonShell):
+    """Asynchronous Scapy sniffer class.
+
+    Starts its own dedicated :class:`PythonShell` to constantly sniff packets asynchronously to
+    minimize delays between runs. This is achieved using the synchronous `sniff` Scapy function,
+    which prints one packet per line in Base 64 notation. This class spawns a thread to constantly
+    read the stdout for packets. Packets are only parsed and captured, i.e. placed on a thread-safe
+    queue, when the `_is_capturing` event is set.
+    """
+
+    _sniffer: Thread
+    _is_sniffing: Event
+    _is_capturing: Event
+    _packets: SimpleQueue[Packet]
+    _packet_filter: Callable[[Packet], bool] | None
+
+    def __init__(
+        self, node: Node, recv_port: Port, name: str | None = None, privileged: bool = True
+    ):
+        """Sniffer constructor.
+
+        Args:
+            node: Node to start the sniffer on.
+            recv_port: Port to sniff packets from.
+            name: Name identifying the sniffer.
+            privileged: Enables the shell to run as superuser.
+        """
+        super().__init__(node, name, privileged)
+        self._sniffer = Thread(target=self._sniff, args=(recv_port,))
+        self._is_sniffing = Event()
+        self._is_capturing = Event()
+        self._packets = SimpleQueue()
+        self._packet_filter = None
+
+    def start_capturing(self, filter_config: PacketFilteringConfig) -> None:
+        """Start packet capturing.
+
+        Args:
+            filter_config: The packet filtering configuration.
+
+        Raises:
+            InternalError: If the sniffer is already capturing packets.
+        """
+        if self._is_capturing.is_set():
+            raise InternalError("Already capturing. Did you intend to do this?")
+        self._set_packet_filter(filter_config)
+        self._is_capturing.set()
+
+    def collect(
+        self, stop_condition: Callable[[Packet], bool] | None = None, timeout: float = 1.0
+    ) -> list[Packet]:
+        """Collect packets until timeout or stop condition is met.
+
+        A `stop_condition` callback can be passed to trigger a capture stop as soon as the last
+        desired packet has been captured. Without a stop condition, the specified `timeout` is  used
+        to determine when to stop.
+
+        Args:
+            stop_condition: Callback which decides when to stop capturing packets.
+            timeout: Time to wait after the last captured packet before stopping.
+
+        Raises:
+            InternalError: If the sniffer is not capturing any packets.
+            TimeoutError: If a `stop_condition` has been set and was not met before timeout.
+
+        Returns:
+            A list of the captured packets.
+        """
+        if not self._is_capturing.is_set():
+            raise InternalError("Already not capturing. Did you intend to do this?")
+
+        collected_packets = []
+        try:
+            while packet := self._packets.get(timeout=timeout):
+                collected_packets.append(packet)
+                if stop_condition is not None and stop_condition(packet):
+                    break
+        except Empty:
+            if stop_condition is not None:
+                msg = "The stop condition was not met before timeout."
+                raise TimeoutError(msg)
+
+        return collected_packets
+
+    def stop_capturing(self) -> None:
+        """Stop packet capturing.
+
+        It also drains the internal queue from uncollected packets.
+
+        Raises:
+            InternalError: If the sniffer is not capturing any packets.
+        """
+        if not self._is_capturing.is_set():
+            raise InternalError("Already not capturing. Did you intend to do this?")
+
+        self._is_capturing.clear()
+
+        while True:
+            try:
+                self._packets.get_nowait()
+            except Empty:
+                break
+
+    def stop_capturing_and_collect(
+        self, stop_condition: Callable[[Packet], bool] | None = None, timeout: float = 1.0
+    ) -> list[Packet]:
+        """Stop packet capturing and collect all the captured packets in a list.
+
+        A `stop_condition` callback can be passed to trigger a capture stop as soon as the last
+        desired packet has been captured. Without a stop condition, the specified `timeout` is  used
+        to determine when to stop.
+
+        Args:
+            stop_condition: Callback which decides when to stop capturing packets.
+            timeout: Time to wait after the last captured packet before stopping.
+
+        Raises:
+            InternalError: If the sniffer is not capturing any packets.
+            TimeoutError: If a `stop_condition` has been set and was not met before timeout.
+
+        Returns:
+            A list of the captured packets.
+        """
+        if not self._is_capturing.is_set():
+            raise InternalError("Already not capturing. Did you intend to do this?")
+
+        try:
+            return self.collect(stop_condition, timeout)
+        finally:
+            self.stop_capturing()
+
+    def start_application(self) -> None:
+        """Overrides :meth:`framework.remote_session.interactive_shell.start_application`.
+
+        Prepares the Python shell for scapy and starts the sniffing in a new thread.
+        """
+        super().start_application()
+        self.send_command("from scapy.all import *")
+        self._sniffer.start()
+        self._is_sniffing.wait()
+
+    def close(self) -> None:
+        """Overrides :meth:`framework.remote_session.interactive_shell.start_application`.
+
+        Sends a stop signal to the sniffer thread and waits until its exit before closing the shell.
+        """
+        self._is_sniffing.clear()
+        self._sniffer.join()
+        super().close()
+
+    def _sniff(self, recv_port: Port):
+        """Sniff packets and use events and queue to communicate with the main thread.
+
+        Raises:
+            InteractiveSSHSessionDeadError: If the SSH connection has been unexpectedly interrupted.
+        """
+        ready_prompt = "Ready."
+        self.send_command(
+            "sniff("
+            f'iface="{recv_port.logical_name}", quiet=True, store=False, '
+            "prn=lambda p: bytes_base64(p.build()).decode(), "
+            f'started_callback=lambda: print("{ready_prompt}")'
+            ")",
+            prompt=ready_prompt,
+        )
+        self._ssh_channel.settimeout(1)
+
+        self._logger.debug("Start sniffing.")
+        self._is_sniffing.set()
+        while self._is_sniffing.is_set():
+            try:
+                line = self._stdout.readline()
+                if not line:
+                    raise InteractiveSSHSessionDeadError(
+                        self._node.main_session.interactive_session.hostname
+                    )
+
+                if self._is_capturing.is_set():
+                    packet = Ether(base64_bytes(line.rstrip()))
+                    if self._packet_filter is None or self._packet_filter(packet):
+                        self._logger.debug(f"CAPTURING sniffed packet: {repr(packet)}")
+                        self._packets.put(packet)
+                    else:
+                        self._logger.debug(f"DROPPING sniffed packet: {repr(packet)}")
+            except TimeoutError:
+                pass
+
+        self._logger.debug("Stop sniffing.")
+        self.send_command("\x03")  # send Ctrl+C to trigger a KeyboardInterrupt in `sniff`.
+
+    def _set_packet_filter(self, filter_config: PacketFilteringConfig):
+        """Make and set a filtering function from `filter_config`.
+
+        Args:
+            filter_config: Config class that specifies which filters should be applied.
+        """
+
+        def _filter(packet: Packet) -> bool:
+            if ether := packet.getlayer(Ether):
+                if filter_config.no_arp and ether.type == 0x0806:
+                    return False
+
+                if filter_config.no_lldp and ether.type == 0x88CC:
+                    return False
+
+            return True
+
+        self._packet_filter = _filter
+
+
 class ScapyTrafficGenerator(PythonShell, CapturingTrafficGenerator):
     """Provides access to scapy functions on a traffic generator node.
 
@@ -41,7 +252,8 @@ class ScapyTrafficGenerator(PythonShell, CapturingTrafficGenerator):
     processing packets are implemented using an underlying
     :class:`framework.remote_session.python_shell.PythonShell` which imports the Scapy library. This
     class also extends :class:`.capturing_traffic_generator.CapturingTrafficGenerator` to expose
-    methods that utilize said packet processing functionality to test suites.
+    methods that utilize said packet processing functionality to test suites, which are delegated to
+    a dedicated asynchronous packet sniffer with :class:`ScapyAsyncSniffer`.
 
     Because of the double inheritance, this class has both methods that wrap scapy commands
     sent into the shell (running on the TG node) and methods that run locally to fulfill
@@ -57,9 +269,10 @@ class also extends :class:`.capturing_traffic_generator.CapturingTrafficGenerato
     """
 
     _config: ScapyTrafficGeneratorConfig
+    _sniffer: ScapyAsyncSniffer
 
     #: Name of sniffer to ensure the same is used in all places
-    _sniffer_name: ClassVar[str] = "sniffer"
+    _sniffer_name: ClassVar[str] = "scapy_sniffer"
     #: Name of variable that points to the list of packets inside the scapy shell.
     _send_packet_list_name: ClassVar[str] = "packets"
     #: Padding to add to the start of a line for python syntax compliance.
@@ -85,14 +298,25 @@ def __init__(self, tg_node: Node, config: ScapyTrafficGeneratorConfig, **kwargs)
         super().__init__(node=tg_node, config=config, tg_node=tg_node, **kwargs)
         self.start_application()
 
-    def setup(self, ports: Iterable[Port]):
+    def setup(self, ports: Iterable[Port], rx_port: Port):
         """Extends :meth:`.traffic_generator.TrafficGenerator.setup`.
 
-        Brings up the port links.
+        Brings up the port links and starts up the async sniffer.
         """
-        super().setup(ports)
+        super().setup(ports, rx_port)
         self._tg_node.main_session.bring_up_link(ports)
 
+        self._sniffer = ScapyAsyncSniffer(self._tg_node, rx_port, self._sniffer_name)
+        self._sniffer.start_application()
+
+    def teardown(self, ports):
+        """Extends :meth:`.traffic_generator.TrafficGenerator.teardown`.
+
+        Stops the async sniffer.
+        """
+        self._sniffer.close()
+        super().teardown(ports)
+
     def start_application(self) -> None:
         """Extends :meth:`framework.remote_session.interactive_shell.start_application`.
 
@@ -122,23 +346,18 @@ def _send_packets_and_capture(
         self,
         packets: list[Packet],
         send_port: Port,
-        recv_port: Port,
+        _: Port,
         filter_config: PacketFilteringConfig,
         duration: float,
     ) -> list[Packet]:
         """Implementation for sending packets and capturing any received traffic.
 
-        This method first creates an asynchronous sniffer that holds the packets to send, then
-        starts and stops said sniffer, collecting any packets that it had received while it was
-        running.
-
         Returns:
             A list of packets received after sending `packets`.
         """
-        self._shell_create_sniffer(
-            packets, send_port, recv_port, self._create_packet_filter(filter_config)
-        )
-        return self._shell_start_and_stop_sniffing(duration)
+        self._sniffer.start_capturing(filter_config)
+        self.send_packets(packets, send_port)
+        return self._sniffer.stop_capturing_and_collect(timeout=duration)
 
     def _shell_set_packet_list(self, packets: list[Packet]) -> None:
         """Build a list of packets to send later.
@@ -158,95 +377,3 @@ def _shell_set_packet_list(self, packets: list[Packet]) -> None:
         self.send_command(
             f"{self._send_packet_list_name} = [{', '.join(map(Packet.command, packets))}]"
         )
-
-    def _create_packet_filter(self, filter_config: PacketFilteringConfig) -> str:
-        """Combine filter settings from `filter_config` into a BPF that scapy can use.
-
-        Scapy allows for the use of Berkeley Packet Filters (BPFs) to filter what packets are
-        collected based on various attributes of the packet.
-
-        Args:
-            filter_config: Config class that specifies which filters should be applied.
-
-        Returns:
-            A string representing the combination of BPF filters to be passed to scapy. For
-            example:
-
-            "ether[12:2] != 0x88cc && ether[12:2] != 0x0806"
-        """
-        bpf_filter = []
-        if filter_config.no_arp:
-            bpf_filter.append("ether[12:2] != 0x0806")
-        if filter_config.no_lldp:
-            bpf_filter.append("ether[12:2] != 0x88cc")
-        return " && ".join(bpf_filter)
-
-    def _shell_create_sniffer(
-        self,
-        packets_to_send: list[Packet],
-        send_port: Port,
-        recv_port: Port,
-        filter_config: str,
-    ) -> None:
-        """Create an asynchronous sniffer in the shell.
-
-        A list of packets is passed to the sniffer's callback function so that they are immediately
-        sent at the time sniffing is started.
-
-        Args:
-            packets_to_send: A list of packets to send when sniffing is started.
-            send_port: The port to send the packets on when sniffing is started.
-            recv_port: The port to collect the traffic from.
-            filter_config: An optional BPF format filter to use when sniffing for packets. Omitted
-                when set to an empty string.
-        """
-        self._shell_set_packet_list(packets_to_send)
-
-        self.send_command("import time")
-        sniffer_commands = [
-            f"{self._sniffer_name} = AsyncSniffer(",
-            f"iface='{recv_port.logical_name}',",
-            "store=True,",
-            # *args is used in the arguments of the lambda since Scapy sends parameters to the
-            # callback function which we do not need for our purposes.
-            "started_callback=lambda *args: (time.sleep(1), sendp(",
-            (
-                # Additional indentation is added to this line only for readability of the logs.
-                f"{self._python_indentation}{self._send_packet_list_name},"
-                f" iface='{send_port.logical_name}')),"
-            ),
-            ")",
-        ]
-        if filter_config:
-            sniffer_commands.insert(-1, f"filter='{filter_config}'")
-
-        self.send_command(f"\n{self._python_indentation}".join(sniffer_commands))
-
-    def _shell_start_and_stop_sniffing(self, duration: float) -> list[Packet]:
-        """Start asynchronous sniffer, run for a set `duration`, then collect received packets.
-
-        This method expects that you have first created an asynchronous sniffer inside the shell
-        and will fail if you haven't. Received packets are collected by printing the base64
-        encoding of each packet in the shell and then harvesting these encodings using regex to
-        convert back into packet objects.
-
-        Args:
-            duration: The amount of time in seconds to sniff for received packets.
-
-        Returns:
-            A list of all packets that were received while the sniffer was running.
-        """
-        sniffed_packets_name = "gathered_packets"
-        self.send_command(f"{self._sniffer_name}.start()")
-        # Insert a one second delay to prevent timeout errors from occurring
-        time.sleep(duration + 1)
-        self.send_command(f"{sniffed_packets_name} = {self._sniffer_name}.stop(join=True)")
-        # An extra newline is required here due to the nature of interactive Python shells
-        packet_strs = self.send_command(
-            f"for pakt in {sniffed_packets_name}: print(bytes_base64(pakt.build()))\n"
-        )
-        # In the string of bytes "b'XXXX'", we only want the contents ("XXXX")
-        list_of_packets_base64 = re.findall(
-            rf"^b'({REGEX_FOR_BASE64_ENCODING})'", packet_strs, re.MULTILINE
-        )
-        return [Ether(base64_bytes(pakt)) for pakt in list_of_packets_base64]
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
index 804662e114..74fc900a22 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -50,7 +50,7 @@ def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
         self._logger = get_dts_logger(f"{self._tg_node.name} {self._config.type}")
         super().__init__(**kwargs)
 
-    def setup(self, ports: Iterable[Port]):
+    def setup(self, ports: Iterable[Port], rx_port: Port):
         """Setup the traffic generator."""
 
     def teardown(self, ports: Iterable[Port]):
diff --git a/dts/framework/utils.py b/dts/framework/utils.py
index d6f4c11d58..a2b51a1d6b 100644
--- a/dts/framework/utils.py
+++ b/dts/framework/utils.py
@@ -32,7 +32,6 @@
 _REGEX_FOR_COLON_OR_HYPHEN_SEP_MAC: str = r"(?:[\da-fA-F]{2}[:-]){5}[\da-fA-F]{2}"
 _REGEX_FOR_DOT_SEP_MAC: str = r"(?:[\da-fA-F]{4}.){2}[\da-fA-F]{4}"
 REGEX_FOR_MAC_ADDRESS: str = rf"{_REGEX_FOR_COLON_OR_HYPHEN_SEP_MAC}|{_REGEX_FOR_DOT_SEP_MAC}"
-REGEX_FOR_BASE64_ENCODING: str = r"[-a-zA-Z0-9+\\/]*={0,3}"
 REGEX_FOR_IDENTIFIER: str = r"\w+(?:[\w -]*\w+)?"
 REGEX_FOR_PORT_LINK: str = (
     rf"(?:(sut|tg)\.)?({REGEX_FOR_IDENTIFIER})"  # left side
-- 
2.43.0

