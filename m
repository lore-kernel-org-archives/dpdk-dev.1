Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A3ACAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 10:38:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E59024066A;
	Tue, 23 Sep 2025 12:38:07 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id B898F4021F
 for <dev@dpdk.org>; Tue, 23 Sep 2025 12:38:06 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB7CBFEC;
 Tue, 23 Sep 2025 03:37:57 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.70.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CD753F694;
 Tue, 23 Sep 2025 03:38:05 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH v1 1/2] dts: add packet handling and test utilities to API
Date: Tue, 23 Sep 2025 11:37:57 +0100
Message-Id: <20250923103758.3192015-2-paul.szczepanek@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923103758.3192015-1-paul.szczepanek@arm.com>
References: <20250923103758.3192015-1-paul.szczepanek@arm.com>
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

Split TestSuite methods between test run methods
and packet related methods.

Depends-on: series-36111 ("Split DTS framework and public API")

Signed-off-by: Paul Szczepanek <paul.szczepanek@arm.com>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 doc/api/dts/api.packet.rst  |   8 +
 doc/api/dts/api.rst         |   4 +-
 doc/api/dts/api.test.rst    |   8 +
 doc/guides/tools/dts.rst    |   2 +-
 dts/api/packet.py           | 311 ++++++++++++++++++++++++++++++++++++
 dts/api/test.py             | 126 +++++++++++++++
 dts/framework/test_suite.py | 305 +----------------------------------
 7 files changed, 460 insertions(+), 304 deletions(-)
 create mode 100644 doc/api/dts/api.packet.rst
 create mode 100644 doc/api/dts/api.test.rst
 create mode 100644 dts/api/packet.py
 create mode 100644 dts/api/test.py

diff --git a/doc/api/dts/api.packet.rst b/doc/api/dts/api.packet.rst
new file mode 100644
index 0000000000..93d455a609
--- /dev/null
+++ b/doc/api/dts/api.packet.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+packet - Sending and capturing packets
+======================================
+
+.. automodule:: api.packet
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/api.rst b/doc/api/dts/api.rst
index 9a13704f16..d7d927bfa9 100644
--- a/doc/api/dts/api.rst
+++ b/doc/api/dts/api.rst
@@ -17,5 +17,7 @@ api - DTS API
    :hidden:
    :maxdepth: 1

+   api.test
    api.artifact
-   api.capabilities
\ No newline at end of file
+   api.capabilities
+   api.packet
\ No newline at end of file
diff --git a/doc/api/dts/api.test.rst b/doc/api/dts/api.test.rst
new file mode 100644
index 0000000000..91605cc31b
--- /dev/null
+++ b/doc/api/dts/api.test.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+test - Reporting results and logging
+====================================
+
+.. automodule:: api.test
+   :members:
+   :show-inheritance:
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index e7af60b7a6..2445efccfc 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -455,7 +455,7 @@ Test Case Verification

    Use the verify method to assert conditions and record test results.
    This should typically be called at the end of each test case.
-   Example: self.verify(link_up, "Link should be up after configuration.")
+   Example: verify(link_up, "Link should be up after configuration.")

 Other Methods

diff --git a/dts/api/packet.py b/dts/api/packet.py
new file mode 100644
index 0000000000..bf6f3e1be8
--- /dev/null
+++ b/dts/api/packet.py
@@ -0,0 +1,311 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""Features common to all test suites.
+
+The module defines the :class:`TestSuite` class which doesn't contain any test cases, and as such
+must be extended by subclasses which add test cases. The :class:`TestSuite` contains the basics
+needed by subclasses:
+
+    * Testbed (SUT, TG) configuration,
+    * Packet sending and verification,
+    * Test case verification.
+"""
+
+from collections import Counter
+from typing import cast
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Packet, Padding, raw
+
+from api.test import fail, log_debug
+from framework.context import get_ctx
+from framework.exception import InternalError
+from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
+    PacketFilteringConfig,
+)
+from framework.utils import get_packet_summaries
+
+
+def send_packet_and_capture(
+    packet: Packet,
+    filter_config: PacketFilteringConfig = PacketFilteringConfig(),
+    duration: float = 1,
+) -> list[Packet]:
+    """Send and receive `packet` using the associated TG.
+
+    Send `packet` through the appropriate interface and receive on the appropriate interface.
+    Modify the packet with l3/l2 addresses corresponding to the testbed and desired traffic.
+
+    Args:
+        packet: The packet to send.
+        filter_config: The filter to use when capturing packets.
+        duration: Capture traffic for this amount of time after sending `packet`.
+
+    Returns:
+        A list of received packets.
+    """
+    return send_packets_and_capture(
+        [packet],
+        filter_config,
+        duration,
+    )
+
+
+def send_packets_and_capture(
+    packets: list[Packet],
+    filter_config: PacketFilteringConfig = PacketFilteringConfig(),
+    duration: float = 1,
+) -> list[Packet]:
+    """Send and receive `packets` using the associated TG.
+
+    Send `packets` through the appropriate interface and receive on the appropriate interface.
+    Modify the packets with l3/l2 addresses corresponding to the testbed and desired traffic.
+
+    Args:
+        packets: The packets to send.
+        filter_config: The filter to use when capturing packets.
+        duration: Capture traffic for this amount of time after sending `packet`.
+
+    Returns:
+        A list of received packets.
+    """
+    from framework.context import get_ctx
+    from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
+        CapturingTrafficGenerator,
+    )
+
+    assert isinstance(
+        get_ctx().tg, CapturingTrafficGenerator
+    ), "Cannot capture with a non-capturing traffic generator"
+    tg: CapturingTrafficGenerator = cast(CapturingTrafficGenerator, get_ctx().tg)
+    # TODO: implement @requires for types of traffic generator
+    packets = adjust_addresses(packets)
+    return tg.send_packets_and_capture(
+        packets,
+        get_ctx().topology.tg_port_egress,
+        get_ctx().topology.tg_port_ingress,
+        filter_config,
+        duration,
+    )
+
+
+def send_packets(
+    packets: list[Packet],
+) -> None:
+    """Send packets using the traffic generator and do not capture received traffic.
+
+    Args:
+        packets: Packets to send.
+    """
+    packets = adjust_addresses(packets)
+    get_ctx().tg.send_packets(packets, get_ctx().topology.tg_port_egress)
+
+
+def get_expected_packets(
+    packets: list[Packet],
+    sent_from_tg: bool = False,
+) -> list[Packet]:
+    """Inject the proper L2/L3 addresses into `packets`.
+
+    Inject the L2/L3 addresses expected at the receiving end of the traffic generator.
+
+    Args:
+        packets: The packets to modify.
+        sent_from_tg: If :data:`True` packet was sent from the TG.
+
+    Returns:
+        `packets` with injected L2/L3 addresses.
+    """
+    return adjust_addresses(packets, not sent_from_tg)
+
+
+def get_expected_packet(
+    packet: Packet,
+    sent_from_tg: bool = False,
+) -> Packet:
+    """Inject the proper L2/L3 addresses into `packet`.
+
+    Inject the L2/L3 addresses expected at the receiving end of the traffic generator.
+
+    Args:
+        packet: The packet to modify.
+        sent_from_tg: If :data:`True` packet was sent from the TG.
+
+    Returns:
+        `packet` with injected L2/L3 addresses.
+    """
+    return get_expected_packets([packet], sent_from_tg)[0]
+
+
+def adjust_addresses(packets: list[Packet], expected: bool = False) -> list[Packet]:
+    """L2 and L3 address additions in both directions.
+
+    Copies of `packets` will be made, modified and returned in this method.
+
+    Only missing addresses are added to packets, existing addresses will not be overridden. If
+    any packet in `packets` has multiple IP layers (using GRE, for example) only the inner-most
+    IP layer will have its addresses adjusted.
+
+    Assumptions:
+        Two links between SUT and TG, one link is TG -> SUT, the other SUT -> TG.
+
+    Args:
+        packets: The packets to modify.
+        expected: If :data:`True`, the direction is SUT -> TG,
+            otherwise the direction is TG -> SUT.
+
+    Returns:
+        A list containing copies of all packets in `packets` after modification.
+
+    Raises:
+        InternalError: If no tests are running.
+    """
+    from framework.test_suite import TestSuite
+
+    if get_ctx().local.current_test_suite is None:
+        raise InternalError("No current test suite, tests aren't running?")
+    current_test_suite: TestSuite = cast(TestSuite, get_ctx().local.current_test_suite)
+    return current_test_suite._adjust_addresses(packets, expected)
+
+
+def match_all_packets(
+    expected_packets: list[Packet],
+    received_packets: list[Packet],
+    verify: bool = True,
+) -> bool:
+    """Matches all the expected packets against the received ones.
+
+    Matching is performed by counting down the occurrences in a dictionary which keys are the
+    raw packet bytes. No deep packet comparison is performed. All the unexpected packets (noise)
+    are automatically ignored.
+
+    Args:
+        expected_packets: The packets we are expecting to receive.
+        received_packets: All the packets that were received.
+        verify: If :data:`True`, and there are missing packets an exception will be raised.
+
+    Raises:
+        TestCaseVerifyError: if and not all the `expected_packets` were found in
+            `received_packets`.
+
+    Returns:
+        :data:`True` If there are no missing packets.
+    """
+    expected_packets_counters = Counter(map(raw, expected_packets))
+    received_packets_counters = Counter(map(raw, received_packets))
+    # The number of expected packets is subtracted by the number of received packets, ignoring
+    # any unexpected packets and capping at zero.
+    missing_packets_counters = expected_packets_counters - received_packets_counters
+    missing_packets_count = missing_packets_counters.total()
+    log_debug(
+        f"match_all_packets: expected {len(expected_packets)}, "
+        f"received {len(received_packets)}, missing {missing_packets_count}"
+    )
+
+    if missing_packets_count != 0:
+        if verify:
+            fail(
+                f"Not all packets were received, expected {len(expected_packets)} "
+                f"but {missing_packets_count} were missing."
+            )
+        return False
+
+    return True
+
+
+def verify_packets(expected_packet: Packet, received_packets: list[Packet]) -> None:
+    """Verify that `expected_packet` has been received.
+
+    Go through `received_packets` and check that `expected_packet` is among them.
+    If not, raise an exception and log the last 10 commands
+    executed on both the SUT and TG.
+
+    Args:
+        expected_packet: The packet we're expecting to receive.
+        received_packets: The packets where we're looking for `expected_packet`.
+
+    Raises:
+        TestCaseVerifyError: `expected_packet` is not among `received_packets`.
+    """
+    for received_packet in received_packets:
+        if _compare_packets(expected_packet, received_packet):
+            break
+    else:
+        log_debug(
+            f"The expected packet {expected_packet.summary()} "
+            f"not found among received {get_packet_summaries(received_packets)}"
+        )
+        fail("An expected packet not found among received packets.")
+
+
+def _compare_packets(expected_packet: Packet, received_packet: Packet) -> bool:
+    log_debug(f"Comparing packets: \n{expected_packet.summary()}\n{received_packet.summary()}")
+
+    l3 = IP in expected_packet.layers()
+    log_debug("Found l3 layer")
+
+    received_payload = received_packet
+    expected_payload = expected_packet
+    while received_payload and expected_payload:
+        log_debug("Comparing payloads:")
+        log_debug(f"Received: {received_payload}")
+        log_debug(f"Expected: {expected_payload}")
+        if type(received_payload) is type(expected_payload):
+            log_debug("The layers are the same.")
+            if type(received_payload) is Ether:
+                if not _verify_l2_frame(received_payload, l3):
+                    return False
+            elif type(received_payload) is IP:
+                assert type(expected_payload) is IP
+                if not _verify_l3_packet(received_payload, expected_payload):
+                    return False
+        else:
+            # Different layers => different packets
+            return False
+        received_payload = received_payload.payload
+        expected_payload = expected_payload.payload
+
+    if expected_payload:
+        log_debug(f"The expected packet did not contain {expected_payload}.")
+        return False
+    if received_payload and received_payload.__class__ != Padding:
+        log_debug("The received payload had extra layers which were not padding.")
+        return False
+    return True
+
+
+def _verify_l2_frame(received_packet: Ether, contains_l3: bool) -> bool:
+    """Verify the L2 frame of `received_packet`.
+
+    Args:
+        received_packet: The received L2 frame to verify.
+        contains_l3: If :data:`True`, the packet contains an L3 layer.
+    """
+    log_debug("Looking at the Ether layer.")
+    log_debug(
+        f"Comparing received dst mac '{received_packet.dst}' "
+        f"with expected '{get_ctx().topology.tg_port_ingress.mac_address}'."
+    )
+    if received_packet.dst != get_ctx().topology.tg_port_ingress.mac_address:
+        return False
+
+    expected_src_mac = get_ctx().topology.tg_port_egress.mac_address
+    if contains_l3:
+        expected_src_mac = get_ctx().topology.sut_port_egress.mac_address
+    log_debug(
+        f"Comparing received src mac '{received_packet.src}' "
+        f"with expected '{expected_src_mac}'."
+    )
+    if received_packet.src != expected_src_mac:
+        return False
+
+    return True
+
+
+def _verify_l3_packet(received_packet: IP, expected_packet: IP) -> bool:
+    log_debug("Looking at the IP layer.")
+    if received_packet.src != expected_packet.src or received_packet.dst != expected_packet.dst:
+        return False
+    return True
diff --git a/dts/api/test.py b/dts/api/test.py
new file mode 100644
index 0000000000..f58c82715d
--- /dev/null
+++ b/dts/api/test.py
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""Common test utilities.
+
+This module provides utility functions for test cases, including logging, verification.
+"""
+
+from framework.context import get_ctx
+from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
+from framework.logger import DTSLogger
+
+
+def get_current_test_case_name() -> str:
+    """The name of the current test case.
+
+    Raises:
+        InternalError: If no test is running.
+    """
+    current_test_case = get_ctx().local.current_test_case
+    if current_test_case is None:
+        raise InternalError("No current test case")
+    return current_test_case.name
+
+
+def log(message: str) -> None:
+    """Log the given message with the level 'INFO'.
+
+    Args:
+        message: String representing the message to log.
+
+    Raises:
+        InternalError: If no test is running.
+    """
+    get_logger().info(message)
+
+
+def log_debug(message: str) -> None:
+    """Log the given message with the level 'DEBUG'.
+
+    Args:
+        message: String representing the message to log.
+
+    Raises:
+        InternalError: If no test is running.
+    """
+    get_logger().debug(message)
+
+
+def verify(condition: bool, failure_description: str) -> None:
+    """Verify `condition` and handle failures.
+
+    When `condition` is :data:`False`, raise an exception and log the last 10 commands
+    executed on both the SUT and TG.
+
+    Args:
+        condition: The condition to check.
+        failure_description: A short description of the failure
+            that will be stored in the raised exception.
+
+    Raises:
+        TestCaseVerifyError: If `condition` is :data:`False`.
+    """
+    if not condition:
+        fail(failure_description)
+
+
+def verify_else_skip(condition: bool, skip_reason: str) -> None:
+    """Verify `condition` and handle skips.
+
+    When `condition` is :data:`False`, raise a skip exception.
+
+    Args:
+        condition: The condition to check.
+        skip_reason: Description of the reason for skipping.
+
+    Raises:
+        SkippedTestException: If `condition` is :data:`False`.
+    """
+    if not condition:
+        skip(skip_reason)
+
+
+def skip(skip_description: str) -> None:
+    """Skip the current test case or test suite with a given description.
+
+    Args:
+        skip_description: Description of the reason for skipping.
+
+    Raises:
+        SkippedTestException: Always raised to indicate the test was skipped.
+    """
+    get_logger().debug(f"Test skipped: {skip_description}")
+    raise SkippedTestException(skip_description)
+
+
+def fail(failure_description: str) -> None:
+    """Fail the current test case with a given description.
+
+    Logs the last 10 commands executed on both the SUT and TG before raising an exception.
+
+    Args:
+        failure_description: Description of the reason for failure.
+
+    Raises:
+        TestCaseVerifyError: Always raised to indicate the test case failed.
+    """
+    get_logger().debug("A test case failed, showing the last 10 commands executed on SUT:")
+    for command_res in get_ctx().sut_node.main_session.remote_session.history[-10:]:
+        get_logger().debug(command_res.command)
+    get_logger().debug("A test case failed, showing the last 10 commands executed on TG:")
+    for command_res in get_ctx().tg_node.main_session.remote_session.history[-10:]:
+        get_logger().debug(command_res.command)
+    raise TestCaseVerifyError(failure_description)
+
+
+def get_logger() -> DTSLogger:
+    """Get a logger instance for tests.
+
+    Raises:
+        InternalError: If no test is running.
+    """
+    current_test_suite = get_ctx().local.current_test_suite
+    if current_test_suite is None:
+        raise InternalError("No current test suite")
+    return current_test_suite._logger
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 5ee5a039d7..9c57e343ac 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -15,7 +15,6 @@
 """

 import inspect
-from collections import Counter
 from collections.abc import Callable, Sequence
 from dataclasses import dataclass
 from enum import Enum, auto
@@ -27,21 +26,16 @@
 from typing import TYPE_CHECKING, ClassVar, Protocol, TypeVar, Union, cast

 from scapy.layers.inet import IP
-from scapy.layers.l2 import Ether
-from scapy.packet import Packet, Padding, raw
+from scapy.packet import Packet
 from typing_extensions import Self

 from framework.config.common import FrozenModel
 from framework.testbed_model.capability import TestProtocol
 from framework.testbed_model.topology import Topology
-from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
-    CapturingTrafficGenerator,
-    PacketFilteringConfig,
-)

-from .exception import ConfigurationError, InternalError, SkippedTestException, TestCaseVerifyError
+from .exception import ConfigurationError, InternalError
 from .logger import DTSLogger, get_dts_logger
-from .utils import get_packet_summaries, to_pascal_case
+from .utils import to_pascal_case

 if TYPE_CHECKING:
     from framework.context import Context
@@ -212,121 +206,6 @@ def tear_down_test_case(self) -> None:
         This is done after *each* test case.
         """

-    def send_packet_and_capture(
-        self,
-        packet: Packet,
-        filter_config: PacketFilteringConfig = PacketFilteringConfig(),
-        duration: float = 1,
-    ) -> list[Packet]:
-        """Send and receive `packet` using the associated TG.
-
-        Send `packet` through the appropriate interface and receive on the appropriate interface.
-        Modify the packet with l3/l2 addresses corresponding to the testbed and desired traffic.
-
-        Args:
-            packet: The packet to send.
-            filter_config: The filter to use when capturing packets.
-            duration: Capture traffic for this amount of time after sending `packet`.
-
-        Returns:
-            A list of received packets.
-        """
-        return self.send_packets_and_capture(
-            [packet],
-            filter_config,
-            duration,
-        )
-
-    def send_packets_and_capture(
-        self,
-        packets: list[Packet],
-        filter_config: PacketFilteringConfig = PacketFilteringConfig(),
-        duration: float = 1,
-    ) -> list[Packet]:
-        """Send and receive `packets` using the associated TG.
-
-        Send `packets` through the appropriate interface and receive on the appropriate interface.
-        Modify the packets with l3/l2 addresses corresponding to the testbed and desired traffic.
-
-        Args:
-            packets: The packets to send.
-            filter_config: The filter to use when capturing packets.
-            duration: Capture traffic for this amount of time after sending `packet`.
-
-        Returns:
-            A list of received packets.
-        """
-        assert isinstance(
-            self._ctx.tg, CapturingTrafficGenerator
-        ), "Cannot capture with a non-capturing traffic generator"
-        # TODO: implement @requires for types of traffic generator
-        packets = self._adjust_addresses(packets)
-        return self._ctx.tg.send_packets_and_capture(
-            packets,
-            self._ctx.topology.tg_port_egress,
-            self._ctx.topology.tg_port_ingress,
-            filter_config,
-            duration,
-        )
-
-    def send_packets(
-        self,
-        packets: list[Packet],
-    ) -> None:
-        """Send packets using the traffic generator and do not capture received traffic.
-
-        Args:
-            packets: Packets to send.
-        """
-        packets = self._adjust_addresses(packets)
-        self._ctx.tg.send_packets(packets, self._ctx.topology.tg_port_egress)
-
-    def get_expected_packets(
-        self,
-        packets: list[Packet],
-        sent_from_tg: bool = False,
-    ) -> list[Packet]:
-        """Inject the proper L2/L3 addresses into `packets`.
-
-        Inject the L2/L3 addresses expected at the receiving end of the traffic generator.
-
-        Args:
-            packets: The packets to modify.
-            sent_from_tg: If :data:`True` packet was sent from the TG.
-
-        Returns:
-            `packets` with injected L2/L3 addresses.
-        """
-        return self._adjust_addresses(packets, not sent_from_tg)
-
-    def get_expected_packet(
-        self,
-        packet: Packet,
-        sent_from_tg: bool = False,
-    ) -> Packet:
-        """Inject the proper L2/L3 addresses into `packet`.
-
-        Inject the L2/L3 addresses expected at the receiving end of the traffic generator.
-
-        Args:
-            packet: The packet to modify.
-            sent_from_tg: If :data:`True` packet was sent from the TG.
-
-        Returns:
-            `packet` with injected L2/L3 addresses.
-        """
-        return self.get_expected_packets([packet], sent_from_tg)[0]
-
-    def log(self, message: str) -> None:
-        """Call the private instance of logger within the TestSuite class.
-
-        Log the given message with the level 'INFO'.
-
-        Args:
-            message: String representing the message to log.
-        """
-        self._logger.info(message)
-
     def _adjust_addresses(self, packets: list[Packet], expected: bool = False) -> list[Packet]:
         """L2 and L3 address additions in both directions.

@@ -388,184 +267,6 @@ def _adjust_addresses(self, packets: list[Packet], expected: bool = False) -> li

         return ret_packets

-    def verify(self, condition: bool, failure_description: str) -> None:
-        """Verify `condition` and handle failures.
-
-        When `condition` is :data:`False`, raise an exception and log the last 10 commands
-        executed on both the SUT and TG.
-
-        Args:
-            condition: The condition to check.
-            failure_description: A short description of the failure
-                that will be stored in the raised exception.
-
-        Raises:
-            TestCaseVerifyError: `condition` is :data:`False`.
-        """
-        if not condition:
-            self._fail_test_case_verify(failure_description)
-
-    def _fail_test_case_verify(self, failure_description: str) -> None:
-        self._logger.debug("A test case failed, showing the last 10 commands executed on SUT:")
-        for command_res in self._ctx.sut_node.main_session.remote_session.history[-10:]:
-            self._logger.debug(command_res.command)
-        self._logger.debug("A test case failed, showing the last 10 commands executed on TG:")
-        for command_res in self._ctx.tg_node.main_session.remote_session.history[-10:]:
-            self._logger.debug(command_res.command)
-        raise TestCaseVerifyError(failure_description)
-
-    def verify_else_skip(self, condition: bool, skip_reason: str) -> None:
-        """Verify `condition` and handle skips.
-
-        When `condition` is :data:`False`, raise a skip exception.
-
-        Args:
-            condition: The condition to check.
-            skip_reason: Description of the reason for skipping.
-
-        Raises:
-            SkippedTestException: `condition` is :data:`False`.
-        """
-        if not condition:
-            self._skip_test_case_verify(skip_reason)
-
-    def _skip_test_case_verify(self, skip_description: str) -> None:
-        self._logger.debug(f"Test case skipped: {skip_description}")
-        raise SkippedTestException(skip_description)
-
-    def verify_packets(self, expected_packet: Packet, received_packets: list[Packet]) -> None:
-        """Verify that `expected_packet` has been received.
-
-        Go through `received_packets` and check that `expected_packet` is among them.
-        If not, raise an exception and log the last 10 commands
-        executed on both the SUT and TG.
-
-        Args:
-            expected_packet: The packet we're expecting to receive.
-            received_packets: The packets where we're looking for `expected_packet`.
-
-        Raises:
-            TestCaseVerifyError: `expected_packet` is not among `received_packets`.
-        """
-        for received_packet in received_packets:
-            if self._compare_packets(expected_packet, received_packet):
-                break
-        else:
-            self._logger.debug(
-                f"The expected packet {expected_packet.summary()} "
-                f"not found among received {get_packet_summaries(received_packets)}"
-            )
-            self._fail_test_case_verify("An expected packet not found among received packets.")
-
-    def match_all_packets(
-        self,
-        expected_packets: list[Packet],
-        received_packets: list[Packet],
-        verify: bool = True,
-    ) -> bool:
-        """Matches all the expected packets against the received ones.
-
-        Matching is performed by counting down the occurrences in a dictionary which keys are the
-        raw packet bytes. No deep packet comparison is performed. All the unexpected packets (noise)
-        are automatically ignored.
-
-        Args:
-            expected_packets: The packets we are expecting to receive.
-            received_packets: All the packets that were received.
-            verify: If :data:`True`, and there are missing packets an exception will be raised.
-
-        Raises:
-            TestCaseVerifyError: if and not all the `expected_packets` were found in
-                `received_packets`.
-
-        Returns:
-            :data:`True` If there are no missing packets.
-        """
-        expected_packets_counters = Counter(map(raw, expected_packets))
-        received_packets_counters = Counter(map(raw, received_packets))
-        # The number of expected packets is subtracted by the number of received packets, ignoring
-        # any unexpected packets and capping at zero.
-        missing_packets_counters = expected_packets_counters - received_packets_counters
-        missing_packets_count = missing_packets_counters.total()
-        self._logger.debug(
-            f"match_all_packets: expected {len(expected_packets)}, "
-            f"received {len(received_packets)}, missing {missing_packets_count}"
-        )
-
-        if missing_packets_count != 0:
-            if verify:
-                self._fail_test_case_verify(
-                    f"Not all packets were received, expected {len(expected_packets)} "
-                    f"but {missing_packets_count} were missing."
-                )
-            return False
-
-        return True
-
-    def _compare_packets(self, expected_packet: Packet, received_packet: Packet) -> bool:
-        self._logger.debug(
-            f"Comparing packets: \n{expected_packet.summary()}\n{received_packet.summary()}"
-        )
-
-        l3 = IP in expected_packet.layers()
-        self._logger.debug("Found l3 layer")
-
-        received_payload = received_packet
-        expected_payload = expected_packet
-        while received_payload and expected_payload:
-            self._logger.debug("Comparing payloads:")
-            self._logger.debug(f"Received: {received_payload}")
-            self._logger.debug(f"Expected: {expected_payload}")
-            if type(received_payload) is type(expected_payload):
-                self._logger.debug("The layers are the same.")
-                if type(received_payload) is Ether:
-                    if not self._verify_l2_frame(received_payload, l3):
-                        return False
-                elif type(received_payload) is IP:
-                    assert type(expected_payload) is IP
-                    if not self._verify_l3_packet(received_payload, expected_payload):
-                        return False
-            else:
-                # Different layers => different packets
-                return False
-            received_payload = received_payload.payload
-            expected_payload = expected_payload.payload
-
-        if expected_payload:
-            self._logger.debug(f"The expected packet did not contain {expected_payload}.")
-            return False
-        if received_payload and received_payload.__class__ != Padding:
-            self._logger.debug("The received payload had extra layers which were not padding.")
-            return False
-        return True
-
-    def _verify_l2_frame(self, received_packet: Ether, l3: bool) -> bool:
-        self._logger.debug("Looking at the Ether layer.")
-        self._logger.debug(
-            f"Comparing received dst mac '{received_packet.dst}' "
-            f"with expected '{self.topology.tg_port_ingress.mac_address}'."
-        )
-        if received_packet.dst != self.topology.tg_port_ingress.mac_address:
-            return False
-
-        expected_src_mac = self.topology.tg_port_egress.mac_address
-        if l3:
-            expected_src_mac = self.topology.sut_port_egress.mac_address
-        self._logger.debug(
-            f"Comparing received src mac '{received_packet.src}' "
-            f"with expected '{expected_src_mac}'."
-        )
-        if received_packet.src != expected_src_mac:
-            return False
-
-        return True
-
-    def _verify_l3_packet(self, received_packet: IP, expected_packet: IP) -> bool:
-        self._logger.debug("Looking at the IP layer.")
-        if received_packet.src != expected_packet.src or received_packet.dst != expected_packet.dst:
-            return False
-        return True
-

 #: The generic type for a method of an instance of TestSuite
 TestSuiteMethodType = TypeVar("TestSuiteMethodType", bound=Callable[[TestSuite], None])
--
2.39.5

