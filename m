Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB42606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=iVcdZhWv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 596B440A70;
	Tue,  3 Nov 2026 23:02:25 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 0423A40272
 for <dev@dpdk.org>; Tue,  3 Nov 2026 23:02:24 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-53669f7b518so55889201cf.2
 for <dev@dpdk.org>; Tue, 03 Nov 2026 14:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793743343; x=1794348143; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xiz2RqvjeZGuzNdiqHf/NncyR1cZ2VQMeKmquiHDNPw=;
 b=iVcdZhWvODgl3KWuIohBgrMM5UnI6ESQ/L+rAgQapnzSgnCGDA+oUFMd2Scwr7ziIY
 tUYTjoDmPdS/lJGeL9T6m2KUbJwBdyqkAy3/8XktnS9WlbEVvbE81AS+RUUFLZKrBaEc
 Eh3CsQ4UL0iCb0ijaSQyyLs1pxLruevD1DOiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793743343; x=1794348143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xiz2RqvjeZGuzNdiqHf/NncyR1cZ2VQMeKmquiHDNPw=;
 b=W19EoHrlVm2ENbr394j72FjXpT5hf9ylYFtc8KKmbhQWSdfn2jh+70FYafSSfICm8+
 7CAE3TCafIW4lnuE5/2aBT0bfv2I4xMwpviUa00PYQIogJvGMAmQtWtEGyTr2nFQD2cG
 91d3J5x8ehpqtgFipUsJfLP0IycX1zHBkyDEYinXzG58g5uUh+ISZdyQQEiRVHTySLkn
 joW6LsUgMtDWiur4/muEE/ytuVEKN2J9N+tPH/tG6SjyqO4x72A1XNwHnOpZkiNljVF4
 s7oFwlnjLT61BYYJaAb8RtoxNJuu8uTfWaYJ55+LYrs9lmzXbsa+z3tOrwVzV0ZCrAza
 EFrA==
X-Gm-Message-State: APuU4Z+1/qtAiGhlYS4/QndBNuWRUGmfMmAukGfaVUY9e7USbL6ZR4NF
 YQNZi8mHqghQvmEY9QgTzQOJOGkY7G0c2XTVOREPk5jH0fspdABeBAQqnMsCjy7Q7j0=
X-Gm-Gg: AYBFou3x9OJVw+BtJGzoNcy+FyA4KJt7jLIhUl7bZuWLZrus0LFMCMm+bRpQL2WK/eQ
 CXkT2mfPoOtTgEOOYqcvknhSqYZAiAYrvI1i2tHj8e+5KGK3xxNw//dpI+9yHqUnztGpnQ4tZ1s
 cqeSasf6KhXr25FSJJFd4+Pz686aMeAS7dHqm4eteS/EdSloYCA0x5tVSla2UkT8zskkvz2g93Q
 EbFhJGEndwZymxiDIA21IHbgtl61k/msjJAMFs6KoaJjXZ4gDACByqPZwMfgngJytY6nn1wWs+z
 8wUY0rEYRYDnpDigEgohmoztwwKxzmIiFLXguLUj2+GT2aJWkVvR0XRDWiDf5mtlCb3pBuw/RRw
 d+w2qXnzuJ3cHqmthI0aRvqJB5Y+49yTQ5noCCiOC6IztJm4FG/UyJSYR9+/EuYqJWjLVgHa4qA
 3cB5rgmpLmU+RZQWUvthXXfztBst4bBMWrlZWDZR6ds19Huk7CqCCKmoUUrhpt5eJ8/TU8yEboG
 wM63PwBhsHZexGCCSIXvQuQOpK9uGwy1jp3Lcgov3d7MqeGs4giiBNpfjcH+Sw1Jmy8S9n9oFSm
 b+mmpDOHb4PUTni61skdw1wP6OYS2Tl5bl9tbc/FRhDmFMS8efX/zTz2CstKMAjploPsLx+qYCR
 81K2l66WlSqKnaaLM9whGeTNj8fT9T4uqWCpgxAZA7aeFO5f4vG+V6crzxsI8TagnIvmjcX0Tl1
 7i1cdM5rzZsK9hitN3t77dTds=
X-Received: by 2002:a05:622a:a584:b0:536:6ae9:f581 with SMTP id
 d75a77b69052e-542b8ad94a8mr250457881cf.67.1793743342635; 
 Tue, 03 Nov 2026 14:02:22 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:79a6:f2bd:f6a:842d])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54b100aba19sm6938511cf.8.2026.11.03.14.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 14:02:22 -0800 (PST)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v4 2/2] dts: add pvp multi paths virtio performance testsuite
Date: Tue,  3 Nov 2026 17:02:18 -0500
Message-ID: <20261103220218.902765-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103220218.902765-1-knimoji@iol.unh.edu>
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261103220218.902765-1-knimoji@iol.unh.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch adds the pvp multi paths virtio single core forward
performance testsuite, which launches testpmd using the vhost
and virtio virtual devices with two and one core respectively,
and tests the virtio single core throughputperformance.

Depends-on: series-39456 ("dts: add pvp multi paths vhost performance")
Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
v4:
    *Refactored testsuite config parameters, moved test case
     setup logic outside of test suite setuo
---

 ...vp_multi_paths_virtio_single_core_perf.rst |   8 +
 dts/api/test_suite.py                         |   4 +-
 dts/configurations/tests_config.example.yaml  |  12 +
 ...pvp_multi_paths_virtio_single_core_perf.py | 477 ++++++++++++++++++
 4 files changed, 499 insertions(+), 2 deletions(-)
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
diff --git a/dts/api/test_suite.py b/dts/api/test_suite.py
index 8a96a5cbad..e4d7abe6ff 100644
--- a/dts/api/test_suite.py
+++ b/dts/api/test_suite.py
@@ -107,10 +107,10 @@ def make_decorator(
         determine the type of test suite.
 
         Args:
-            test_suite_type: A functional, performance, or cryptodev test suite.
+            test_suite_type: A functional or performance test suite.
 
         Returns:
-            The decorator of a functional, performance, or cryptodev test suite.
+            The decorator of a functional or performance test suite.
         """
 
         def _decorator(test_suite_cls: TestSuiteClassType) -> TestSuiteClassType:
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index 36a0e7c2f1..25dcce89a1 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -42,6 +42,18 @@ hello_world:
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
index 0000000000..e67ee2b09b
--- /dev/null
+++ b/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_perf.py
@@ -0,0 +1,477 @@
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
+from typing import TypedDict, cast
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Raw
+from typing_extensions import NotRequired
+
+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.packet import assess_performance_by_packet
+from api.params.eal import Params, VirtualDevice
+from api.params.types import LogicalCoreList, RSSSetting, TestPmdParamsDict
+from api.test import get_current_test_case_name, verify, write_performance_json
+from api.test_suite import BaseConfig, TestSuite, perf_suite, perf_test
+from api.testbed_model.virtual_device import clean_up_vhost
+from api.testpmd import TestPmd
+from api.testpmd.config import PortTopology, RXRingParams, SimpleForwardingModes, TXRingParams
+
+
+class TestParameter(TypedDict):
+    """Performance test metrics."""
+
+    frame_size: int
+    num_descriptors: int
+    expected_mpps: float
+    performance_delta: NotRequired[float | None]
+    measured_mpps: NotRequired[float | None]
+    passing: NotRequired[float | None]
+
+
+class Config(BaseConfig):
+    """Test configuration for pvp_multi_paths_vhost_single_core_perf test suite."""
+
+    test_parameters: list[TestParameter] = [
+        {
+            "frame_size": 64,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "performance_delta": None,
+            "measured_mpps": None,
+            "passing": None,
+        },
+        {
+            "frame_size": 128,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "performance_delta": None,
+            "measured_mpps": None,
+            "passing": None,
+        },
+        {
+            "frame_size": 256,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "performance_delta": None,
+            "measured_mpps": None,
+            "passing": None,
+        },
+        {
+            "frame_size": 512,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "performance_delta": None,
+            "measured_mpps": None,
+            "passing": None,
+        },
+        {
+            "frame_size": 1024,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "performance_delta": None,
+            "measured_mpps": None,
+            "passing": None,
+        },
+        {
+            "frame_size": 1518,
+            "num_descriptors": 1024,
+            "expected_mpps": 1.00,
+            "performance_delta": None,
+            "measured_mpps": None,
+            "passing": None,
+        },
+    ]
+    delta_tolerance: float = 0.05
+
+
+@perf_suite
+@requires_link_topology(LinkTopology.TWO_LINKS)
+class TestPvpMultiPathsVirtioSingleCorePerf(TestSuite):
+    """pvp multi paths virtio single core performance test suite."""
+
+    config: Config
+
+    def set_up_test_case(self) -> None:
+        """Delete stale vhost-user Unix domain socket files."""
+        clean_up_vhost()
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
+        for params in self.config.test_parameters:
+            frame_size = params.get("frame_size")
+            num_descriptors = params.get("num_descriptors") or 1024
+            expected_mpps = params.get("expected_mpps") or 1.00
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
+                assert expected_mpps > 0, "Invalid expected mpps, must be greater than 0."
+
+                measured_mpps = round(
+                    self._transmit(vhost, virtio, int(frame_size), repetitions=5), 3
+                )
+
+                performance_delta = round(
+                    (float(measured_mpps) - float(expected_mpps)) / float(expected_mpps),
+                    3,
+                )
+
+                params["measured_mpps"] = measured_mpps
+                params["performance_delta"] = performance_delta
+                params["passing"] = float(performance_delta) >= -self.config.delta_tolerance
+
+        self._produce_stats_table(self.config.test_parameters)
+        for params in self.config.test_parameters:
+            verify(
+                params["passing"] is True,
+                f"""Packets forwarded is less than {(1 - self.config.delta_tolerance) * 100}%
+                of the expected baseline.
+                Measured MPPS = {params["measured_mpps"]}
+                Expected MPPS = {params["expected_mpps"]}""",
+            )
+
+    def _produce_stats_table(self, test_parameters: list[TestParameter]) -> None:
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
2.56.0

