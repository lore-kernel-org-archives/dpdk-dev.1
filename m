Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0A0CA600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 19:11:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0E48427DD;
	Thu,  8 Oct 2026 21:11:46 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id AFC2942830
 for <dev@dpdk.org>; Thu,  8 Oct 2026 21:11:44 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-53396adbc53so57789551cf.3
 for <dev@dpdk.org>; Thu, 08 Oct 2026 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1791486704; x=1792091504; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OG6g7Z6hqewzIzpk11582HmD7BzBDSQrgYfTTpulVfk=;
 b=FQPb9xvD6W+EvNrLUJx7uxpoyXVTDfr/qcTCe1TFDnT6OnQk7tN4WAOH8JuPRFz+AQ
 ssNDRXRLFwYxQVsIiPq9HFSFq56QA/13Rmx6f1E1a1yCdGPA+WZWlTWroADXcFdnJTvu
 0dD/a8kvtYWIBAbdRXzgAtFsOnnX9cOZZW5OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791486704; x=1792091504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OG6g7Z6hqewzIzpk11582HmD7BzBDSQrgYfTTpulVfk=;
 b=GBcVbilcEWX3VekADc/YTHAQ0Skv2w2LLJEm053K3L4XzY7OR+6Svayqc41ziyAP5N
 zp5VRUrtUvSXNp8UJqGR/mrzUWKqGriDTzKQMDNxhTrpNvnGbCLy1R8HYQxXOEGxbgIq
 fDoN72HipWrQ5xd+NOSjqryrxjeD+iKOlnIwpOluNfUDvYLeUSJWojjZrxq5C2LdiiPz
 t3tClxNd+uQAY7q9OKb6UgqWF5G+7upO82d97Jdzx7C2wQOtLTezF8tKOD0ksVmO/cc0
 ayZTEUFZsU7wg2SAYjhtZn1rnBO/OK+95au39rfmmlB8RDMjTedhb06NhwYjZsfUIP5B
 VMkQ==
X-Gm-Message-State: AFuF++let/kZyVmE4PyENrBOkpy/lnmiDKhSZXpmxJG/Juj0bbPxZlEb
 5zdOoHNvxyirrQ7LpvuglugooTmzZeRx3n2i5EMqv0Mb/fcgnS0aIwxqsUOHLCwE4F6Yyv5RTQw
 N6fablG0=
X-Gm-Gg: AYBFou0OFuqezcjkfk4S2ndmot9rAyYvEB2BFCP1EM68vUFFSS8WDYGkmM18HDVR9l+
 6z1xwkq6GEh+rjq23SIy+7pDP7oMtTqPOyqvly5kjd4C9jRVp5Gc7qENd+BnpC9T159hn0V8SoN
 fqokos0LA99gBxH0dqGUPkffyAJgmpsYvIaMzJ+lTM7blj2G5OaTuAu+xKNmizxXabFq1UfD3Ov
 ue2kHabEFOPrjv60Eah8B4AtgQLHX+e3FZePVm0t9fS5W8f2MyWwxuUaWL5Nyp1k5sM164Fh1OH
 R3TZMg2pfQf/lXW7bRve7k9Kius2vHijG6RAGtETuOlpJYe1a6AnMbfE0D13yg/EZ6GcvpOdF0o
 vO+dte8su/3M1mDVFi8QH+0F/rB/rurWKoVm44mw0ocSZqzlsxdMXPDEYA1ch1EF5sQK45sVj5z
 HQvghmyV/0vMl5OQ2eZWQWGC8Mz/nF/2jTwFuHhQSmB+2ZWR8jXov/DzPMaj4Ky7AL3rOSsvkB8
 O8XgpXdzq+mUaE7lNEkPZoql+47v3H4pBH6D1ZJoNsWMXkncJyZg4CzFfHIAlBu/I/M4VQ5ibwR
 FTppTmDEO8xgNPhJtWtR9mbQ8IkoxokoC+9s39EbjkGlkURPANFmtRHWeQmjMPIWcmGs
X-Received: by 2002:a05:622a:4010:b0:533:3a14:6a2e with SMTP id
 d75a77b69052e-5357539262dmr116184041cf.17.1791486703945; 
 Thu, 08 Oct 2026 12:11:43 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:79a6:f2bd:f6a:842d])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b757437sm1175871cf.16.2026.10.08.12.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 12:11:42 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v2 2/2] dts: add pvp multi paths virtio performance testsuite
Date: Thu,  8 Oct 2026 15:11:39 -0400
Message-ID: <20261008191139.1094155-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008191139.1094155-1-knimoji@iol.unh.edu>
References: <20260901183701.431831-1-knimoji@iol.unh.edu>
 <20261008191139.1094155-1-knimoji@iol.unh.edu>
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

This patch adds the pvp multi paths virtio single core forward
performance testsuite, which launches testpmd using the vhost
and virtio virtual devices with two and one core respectively,
and tests the virtio single core throughputperformance.

Depends-on: series-39456 ("dts: add pvp multi paths vhost performance")
Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 ...vp_multi_paths_virtio_single_core_perf.rst |   8 +
 dts/configurations/tests_config.example.yaml  |  12 +
 ...pvp_multi_paths_virtio_single_core_perf.py | 421 ++++++++++++++++++
 3 files changed, 441 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_pvp_multi_paths_virtio_single_core_perf.rst
 create mode 100644 dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_perf.py

diff --git a/doc/api/dts/tests.TestSuite_pvp_multi_paths_virtio_single_core_perf.rst b/doc/api/dts/tests.TestSuite_pvp_multi_paths_virtio_single_core_perf.rst
new file mode 100644
index 0000000000..853d04ad40
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_pvp_multi_paths_virtio_single_core_perf.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+pvp_multi_paths_virtio_single_core_perf Test Suite
+==================================================
+
+.. automodule:: tests.TestSuite_pvp_multi_paths_virtio_single_core_perf
+   :members:
+   :show-inheritance:
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index f765526442..14715014fb 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -30,6 +30,18 @@ hello_world:
 #       num_descriptors: 1024
 #       expected_mpps: 1.0
 #   delta_tolerance: 0.05
+# pvp_multi_paths_virtio_single_core_forward_perf:
+#   test_parameters: # Add frame size / descriptor count combinations as needed
+#     - frame_size: 64
+#       num_descriptors: 512
+#       expected_mpps: 1.0 # Set millions of packets per second according to your devices expected throughput for this given frame size / descriptor count
+#     - frame_size: 64
+#       num_descriptors: 1024
+#       expected_mpps: 1.0
+#     - frame_size: 512
+#       num_descriptors: 1024
+#       expected_mpps: 1.0
+#   delta_tolerance: 0.05
 # pmd_rss:
 #   NUM_QUEUES: 4
 #   ACTUAL_KEY_SIZE: 52
diff --git a/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_perf.py b/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_perf.py
new file mode 100644
index 0000000000..b18ec01a15
--- /dev/null
+++ b/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_perf.py
@@ -0,0 +1,421 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Virtio-user single-core forwarding performance test suite.
+
+This suite measures the packet forwarding throughput of DPDK's virtio-user PMD running on a
+single CPU core. Performance is evaluated across multiple virtio path implementations, including
+packed versus split rings, in-order delivery, mergeable buffers, and SIMD vectorization.
+Test cases are parameterized using combinations of frame sizes, RX/TX descriptor ring counts,
+and target MPPS baselines specified in the test configuration. High-speed traffic is injected
+from an external generator through the physical host ports into the virtio-user instance,
+looped back, and returned to the generator. The aggregate MPPS processed by the single virtio
+core is verified against configured expected performance baselines to determine the test result.
+"""
+
+from typing import cast
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Raw
+
+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.packet import assess_performance_by_packet
+from api.test import get_current_test_case_name, verify, write_performance_json
+from api.testpmd import TestPmd
+from api.testpmd.config import PortTopology, RXRingParams, SimpleForwardingModes, TXRingParams
+from framework.params.eal import Params, VirtualDevice
+from framework.params.types import LogicalCoreList, RSSSetting, TestPmdParamsDict
+from framework.test_suite import BaseConfig, TestSuite, perf_test
+
+
+class Config(BaseConfig):
+    """Performance test metrics."""
+
+    test_parameters: list[dict[str, int | float]] = [
+        {"frame_size": 64, "num_descriptors": 1024, "expected_mpps": 1.00},
+        {"frame_size": 128, "num_descriptors": 1024, "expected_mpps": 1.00},
+        {"frame_size": 256, "num_descriptors": 1024, "expected_mpps": 1.00},
+        {"frame_size": 512, "num_descriptors": 1024, "expected_mpps": 1.00},
+        {"frame_size": 1024, "num_descriptors": 1024, "expected_mpps": 1.00},
+        {"frame_size": 1518, "num_descriptors": 1024, "expected_mpps": 1.00},
+    ]
+    delta_tolerance: float = 0.05
+
+
+@requires_link_topology(LinkTopology.TWO_LINKS)
+class TestPvpMultiPathsVirtioSingleCorePerf(TestSuite):
+    """pvp multi paths virtio single core performance test suite."""
+
+    config: Config
+
+    def set_up_suite(self) -> None:
+        """Assign test parameters."""
+        self.test_parameters = self.config.test_parameters
+        self.delta_tolerance = self.config.delta_tolerance
+
+    def set_up_test_case(self) -> None:
+        """Delete stale vhost-user Unix domain socket files."""
+        self._ctx.sut_node.main_session.clean_up_vhost()
+
+    def _transmit(
+        self, vhost: TestPmd, virtio: TestPmd, frame_size: int, repetitions: int = 1
+    ) -> float:
+        """Transmit packets using testpmd instances and compute average MPPS.
+
+        Args:
+            vhost: the running vhost testpmd shell.
+            virtio: the running virtio testpmd shell.
+            frame_size: The size of the frame to transmit.
+            repetitions: The number of times to rerun the transmission.
+
+        Returns:
+            The MPPS (millions of packets per second) forwarded by the SUT.
+        """
+        assert repetitions > 0, "Invalid number of repetitions given, must be greater than 0."
+        # Build packet with dummy values, and account for the 14B and 20B Ether and IP headers
+        packet = (
+            Ether(src="52:00:00:00:00:00")
+            / IP(src="1.2.3.4", dst="192.18.1.0")
+            / Raw(load="x" * (frame_size - 14 - 20))
+        )
+
+        vhost.start()
+        virtio.start()
+        rx_avg = 0.0
+
+        for _ in range(repetitions):
+            # Transmit for 5 seconds.
+            stats = assess_performance_by_packet(packet=packet, duration=5)
+            rx_avg += stats.rx_pps
+        return rx_avg / (repetitions * 1_000_000)
+
+    def _create_and_transmit(
+        self,
+        ring_format: int,
+        in_order: int,
+        buffers: int,
+        vectorized: int,
+        extra_args: TestPmdParamsDict,
+        queues: int = 1,
+    ) -> None:
+        """Create testpmd instances with specified params and send traffic.
+
+        Args:
+            ring_format: selects the virtio queue descriptor layout.
+            in_order: toggles in-order packet processing.
+            buffers: enables mergeable rx buffers.
+            vectorized: enables SIMD vectorized rx/tx data paths.
+            extra_args: extra/generic TestPmd arguments.
+            queues: number of rx/tx queues allocated to virtio device.
+        """
+        sut_dpdk_driver = self._ctx.sut_node.config.ports[0].os_driver_for_dpdk
+        vhost_user_vdev = VirtualDevice(f"net_vhost0,iface=/tmp/vhost-net,queues={queues}")
+        virtio_user_vdev = VirtualDevice(
+            "net_virtio_user0,"
+            "mac=00:11:22:33:44:10,"
+            "path=/tmp/vhost-net,"
+            f"queues={queues},"
+            f"packed_vq={ring_format},"
+            f"mrg_rxbuf={buffers},"
+            f"in_order={in_order},"
+            f"vectorized={vectorized}"
+        )
+
+        for params in self.test_parameters:
+            frame_size = params["frame_size"]
+            num_descriptors = params["num_descriptors"]
+
+            default_args: TestPmdParamsDict = {
+                "tx_ring": TXRingParams(descriptors=int(num_descriptors)),
+                "rx_ring": RXRingParams(descriptors=int(num_descriptors)),
+            }
+
+            if sut_dpdk_driver == "mlx5_core":
+                default_args["burst"] = 64
+                default_args["mbcache"] = 512
+            elif sut_dpdk_driver == "i40e":
+                default_args["rx_queues"] = 1
+                default_args["tx_queues"] = 1
+
+            vhost_params: TestPmdParamsDict = {
+                "prefix": "vhost",
+                "allowed_ports": [],
+                "memory_channels": 4,
+                "port_topology": PortTopology.chained,
+                "vdevs": [vhost_user_vdev],
+                "lcore_list": LogicalCoreList([1, 2, 3]),
+                "nb_cores": 2,
+                **default_args,
+            }
+
+            virtio_params: TestPmdParamsDict = {
+                "prefix": "virtio",
+                "no_pci": True,
+                "memory_channels": 4,
+                "allowed_ports": [],
+                "vdevs": [virtio_user_vdev],
+                "lcore_list": LogicalCoreList([4, 5]),
+                "nb_cores": 1,
+                **extra_args,
+                **default_args,
+            }
+
+            with (
+                TestPmd(**vhost_params) as vhost,
+                TestPmd(**virtio_params) as virtio,
+            ):
+                vhost.set_forward_mode(SimpleForwardingModes.io)
+                virtio.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.set_portlist([0, 2, 1])
+
+                assert params["expected_mpps"] > 0, "Invalid expected mpps, must be greater than 0."
+                params["measured_mpps"] = round(
+                    self._transmit(vhost, virtio, int(frame_size), repetitions=5), 3
+                )
+                params["performance_delta"] = round(
+                    (float(params["measured_mpps"]) - float(params["expected_mpps"]))
+                    / float(params["expected_mpps"]),
+                    3,
+                )
+                params["pass"] = float(params["performance_delta"]) >= -self.delta_tolerance
+
+        self._produce_stats_table(self.test_parameters)
+        for params in self.test_parameters:
+            verify(
+                params["pass"] is True,
+                f"""Packets forwarded is less than {(1 - self.delta_tolerance) * 100}%
+                of the expected baseline.
+                Measured MPPS = {params["measured_mpps"]}
+                Expected MPPS = {params["expected_mpps"]}""",
+            )
+
+    def _produce_stats_table(self, test_parameters: list[dict[str, int | float]]) -> None:
+        """Display performance results in table format and write to structured JSON file.
+
+        Args:
+            test_parameters: The expected and real stats per set of test parameters.
+        """
+        test_case = get_current_test_case_name()
+        header = f"{'Frame Size':>12} | {'TXD/RXD':>12} | {'Real MPPS':>12} | {'Expected MPPS':>14}"
+        print(f"{test_case} Results:")
+        print(header)
+        print("-" * len(header))
+        for params in test_parameters:
+            print(f"{params['frame_size']:>12} | {params['num_descriptors']:>12} | ", end="")
+            print(f"{params['measured_mpps']:>12} | {params['expected_mpps']:>14}")
+            print("-" * len(header))
+
+        write_performance_json({"results": test_parameters})
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio11_mergeable(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Set TestPMD virtio parameters: ring_format=1, buffers=1.
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        extra_args: TestPmdParamsDict = {
+            "tx_offloads": 0,
+            "enable_hw_vlan_strip": True,
+            "rss": cast(RSSSetting, RSSSetting.SetIPOnly()),
+        }
+        self._create_and_transmit(
+            ring_format=1, buffers=1, in_order=0, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio11_non_mergeable(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Set TestPMD virtio parameters: ring_format=1.
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        extra_args: TestPmdParamsDict = {
+            "tx_offloads": 0,
+            "enable_hw_vlan_strip": True,
+            "rss": cast(RSSSetting, RSSSetting.SetIPOnly()),
+        }
+        self._create_and_transmit(
+            ring_format=1, buffers=0, in_order=0, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio_inorder_mergeable(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Set TestPMD virtio parameters: buffers=1, in_order=1.
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        extra_args: TestPmdParamsDict = {
+            "tx_offloads": 0,
+            "enable_hw_vlan_strip": True,
+            "rss": cast(RSSSetting, RSSSetting.SetIPOnly()),
+        }
+        self._create_and_transmit(
+            ring_format=0, buffers=1, in_order=1, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio_inorder_nonmergeable(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Set TestPMD virtio parameters: in_order=1.
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        extra_args: TestPmdParamsDict = {
+            "tx_offloads": 0,
+            "enable_hw_vlan_strip": True,
+            "rss": cast(RSSSetting, RSSSetting.SetIPOnly()),
+        }
+        self._create_and_transmit(
+            ring_format=0, buffers=0, in_order=1, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio_mergeable(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Set TestPMD virtio parameters: buffers=1.
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        extra_args: TestPmdParamsDict = {
+            "tx_offloads": 0,
+            "enable_hw_vlan_strip": True,
+            "rss": cast(RSSSetting, RSSSetting.SetIPOnly()),
+        }
+        self._create_and_transmit(
+            ring_format=0, buffers=1, in_order=0, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio_nonmergeable(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Set TestPMD virtio parameters: vectorized=1.
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        extra_args: TestPmdParamsDict = {
+            "enable_hw_vlan_strip": True,
+            "rss": cast(RSSSetting, RSSSetting.SetIPOnly()),
+        }
+        self._create_and_transmit(
+            ring_format=0, buffers=0, in_order=0, vectorized=1, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio_vectorized(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Set TestPMD virtio parameters: vectorized=1.
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        self._create_and_transmit(ring_format=0, buffers=0, in_order=0, vectorized=1, extra_args={})
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio11_inorder_mergeable(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Set TestPMD virtio parameters: ring_format=1, buffers=1, in_order=1.
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        extra_args: TestPmdParamsDict = {
+            "tx_offloads": 0,
+            "enable_hw_vlan_strip": True,
+            "rss": cast(RSSSetting, RSSSetting.SetIPOnly()),
+        }
+        self._create_and_transmit(
+            ring_format=1, buffers=1, in_order=1, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio11_inorder_nonmergeable(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Set TestPMD virtio parameters: ring_format=1, in_order=1.
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        extra_args: TestPmdParamsDict = {
+            "rss": cast(RSSSetting, RSSSetting.SetIPOnly()),
+        }
+        self._create_and_transmit(
+            ring_format=1, buffers=0, in_order=1, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio11_vectorized(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Set TestPMD virtio parameters: ring_format=1, in_order=1, vectorized=1.
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        extra_args: TestPmdParamsDict = {
+            "rss": cast(RSSSetting, RSSSetting.SetIPOnly()),
+            "other_eal_param": Params.from_str("--force-max-simd-bitwidth=512"),
+        }
+        self._create_and_transmit(
+            ring_format=1, buffers=0, in_order=1, vectorized=1, extra_args=extra_args, queues=2
+        )
-- 
2.55.0

