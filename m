Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC49C624D0
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 18:37:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E54CF4064F;
	Tue,  1 Sep 2026 20:37:06 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id AB3174064E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 20:37:05 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-90cdebdfe63so1216276d6.3
 for <dev@dpdk.org>; Tue, 01 Sep 2026 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788287824; x=1788892624; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B4NzKdwhy23Uh2tAwVbx1coJTMBAhIxSkOGSK51Txok=;
 b=RQ77ICZOLyYr2YIsO+ADOQOtA5nX1YeM2Mbe/iT0GNpV4gAQT+8LZwLqbi0ZfmT2Mm
 BzjbRhpYWoq1VYqF+UzHYLKQBRjxnEEr06ZWf7osYy01MJ9KWYxN7McEutoNxSZ/kqEX
 ZnBmaRq2nkV3vC1SPozyfgrjDVkNbQgH+RFZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788287824; x=1788892624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B4NzKdwhy23Uh2tAwVbx1coJTMBAhIxSkOGSK51Txok=;
 b=FeUf5dw+a58a4ZCxwqV7wB4GlRQ5uYwgC7SK15teDS8JFiEkzOAgQILee+lk5TYVYR
 eW1ynT9sjBcYILkZJRGcuDNKuRewb3zxgI+T9kfHiEuRJ8W6ex4u/sJT/fKWa+JXKy+q
 fT3xA7EK0NeLsjeh+U6shFQe+BEyGfFEbM/ompRBTD9o/DH2TML+bB1PWqRU7p7TA289
 1r/pmBeFBVkXo1hhTD3zLAewgMtEmynWnsPh4GVxhturkYZx+t54dAJ9ipNdZWMOdAVN
 jXhXT7qvto+Pq+75l5+N3oKhKPeo0/ce1JJ3iar41P1VSXNYEL57s7lHxmEC4keZjuKx
 UKZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiFerG37XNZPOLNEGh4Dp2AQL7EZjalFMgS5meupGcuXwj9WtKyZivwIJ8aI7hKjyNvgk=@dpdk.org
X-Gm-Message-State: AFuF++mfTCwrF+GkaB1Fyc1Z3QN6/kjvbQTqPTKUJdf27RZMoUuLf0g5
 5ryOKZ9boqQILVFvlBX0pyT1zDvStZn/XeE6tQ7iE9qBWwrvSHYk2Br5qh/QLdghiqU=
X-Gm-Gg: AR+sD13t5gPYKQaWzsz25HSRROzZkrQgErwqW5MZR/WxwFTMx10g/k+3yKdAc3DPl31
 jBi1/WwlyZ7cZGLOm8gojkXVFOZKk4CGQh8jFXnkVJ7ye61VlW252r3mso95u3S9UwQ+uhKgk0n
 NREAOM/ytk/tb5Ru2hbKgM+iCLUFdjtP8V7M14biDhcZgqgA1Qfe/TIV7vPDD58Z+P8JtTJbygk
 G0xgv7Erx7gNuWHsQP6gjrGwkC291lpkcjrz3+MP5sgCd/DWz2mht/RRk0W4tuhibD1dHIoJqAt
 ET7aVrBu/vewcKHt9fxQALA4IUYB8qxTfsjsLjNlH4XwfqhX5dbpLHxWovTyBoHLs7OJ/d5l1OU
 /7GMLzaXgSxpE85LYVl8aXWcnX1zB02cVUZjlwrhhoPMcfH9kX7tPWlBz+Htdv1tQ0xJ3yv3hac
 0v7VlRZouTZfivQTakR/XV1ril7DLCu9fOZmCNLXTNiWY0Gu+ShCzwW0Y0DTxh0zM+SSHpVYLgi
 M62oV6JqfX/cT3r6DlSMwJ5lM+RzbqhkUG5zNQKMSmPvV3TSbPI+CSRVtbfLJpQf/U4g3F3an3F
 uzopngahmCRyLh3jgJfMWhqRa0pjtSHLOtXbjvsf5DeTtxBrnf09mXan5MPqwwSEqHFQUVs=
X-Received: by 2002:ad4:5769:0:b0:90e:838f:d282 with SMTP id
 6a1803df08f44-90e838fd2famr258413946d6.18.1788287824219; 
 Tue, 01 Sep 2026 11:37:04 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9eef37a6sm138666d6.35.2026.09.01.11.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 11:37:03 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com,
	dev@dpdk.org
Cc: dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [RFC PATCH] dts: add pvp multi paths virtio performance testsuite
Date: Tue,  1 Sep 2026 14:37:01 -0400
Message-ID: <20260901183701.431831-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
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

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 ...ti_paths_virtio_single_core_performance.py | 399 ++++++++++++++++++
 1 file changed, 399 insertions(+)
 create mode 100644 dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_performance.py

diff --git a/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_performance.py b/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_performance.py
new file mode 100644
index 0000000000..aefc29facf
--- /dev/null
+++ b/dts/tests/TestSuite_pvp_multi_paths_virtio_single_core_performance.py
@@ -0,0 +1,399 @@
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
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Raw
+
+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.packet import assess_performance_by_packet
+from api.test import verify, write_performance_json
+from api.testpmd import TestPmd
+from api.testpmd.config import PortTopology, RXRingParams, SimpleForwardingModes, TXRingParams
+from framework.params.eal import VirtualDevice
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
+class TestPvpMultiPathsVirtioSingleCorePerformance(TestSuite):
+    """pvp multi paths virtio single core performance test suite."""
+
+    config: Config
+
+    def set_up_suite(self):
+        """Assign test parameters."""
+        self.test_parameters = self.config.test_parameters
+        self.delta_tolerance = self.config.delta_tolerance
+
+    def set_up_test_case(self):
+        """Delete stale vhost-user Unix domain socket files."""
+        self._ctx.sut_node.main_session.send_command("rm -rf /tmp/vhost-net*", privileged=True)
+
+    def _transmit(
+        self, vhost: TestPmd, virtio: TestPmd, frame_size: int, repetitions: int = 1
+    ) -> float:
+        """Create a testpmd session with every rule in the given list, verify jump behavior.
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
+        assert repetitions > 0, "Invalid number of repetitions given."
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
+    ):
+        """Create testpmd instance with specified params and send traffic."""
+        sut_dpdk_driver = self._ctx.sut_node.config.ports[0].os_driver_for_dpdk
+        vhost_user_vdev = VirtualDevice("net_vhost0,iface=/tmp/vhost-net,queues=1")
+        virtio_user_vdev = VirtualDevice(
+            "net_virtio_user0,"
+            "mac=00:11:22:33:44:10,"
+            "path=/tmp/vhost-net,"
+            "queues=1,"
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
+            default_args = {
+                "tx_ring": TXRingParams(descriptors=num_descriptors),
+                "rx_ring": RXRingParams(descriptors=num_descriptors),
+            }
+
+            if sut_dpdk_driver == "mlx5_core":
+                default_args["burst"] = 64
+                default_args["mbcache"] = 512
+            elif sut_dpdk_driver == "i40e":
+                default_args["rx_queues"] = 1
+                default_args["tx_queues"] = 1
+
+            with (
+                TestPmd(
+                    prefix="vhost",
+                    allowed_ports=[],
+                    memory_channels=4,
+                    port_topology=PortTopology.chained,
+                    vdevs=[vhost_user_vdev],
+                    lcore_list=LogicalCoreList([1, 2, 3]),
+                    nb_cores=2,
+                    **default_args,
+                ) as vhost,
+                TestPmd(
+                    prefix="virtio",
+                    no_pci=True,
+                    memory_channels=4,
+                    allowed_ports=[],
+                    vdevs=[virtio_user_vdev],
+                    lcore_list=LogicalCoreList([4, 5]),
+                    nb_cores=1,
+                    **extra_args,
+                    **default_args,
+                ) as virtio,
+            ):
+                vhost.set_forward_mode(SimpleForwardingModes.io)
+                virtio.set_forward_mode(SimpleForwardingModes.mac)
+                vhost.set_portlist([0, 2, 1])
+
+                params["measured_mpps"] = round(
+                    self._transmit(vhost, virtio, frame_size, repetitions=5), 3
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
+        header = f"{'Frame Size':>12} | {'TXD/RXD':>12} | {'Real MPPS':>12} | {'Expected MPPS':>14}"
+        print("-" * len(header))
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
+    def test_perf_vhost_single_core_virtio11_mergeable(self):
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
+            "rss": RSSSetting.SetIPOnly(),
+        }
+        self._create_and_transmit(
+            ring_format=1, buffers=1, in_order=0, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio11_non_mergeable(self):
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
+            "rss": RSSSetting.SetIPOnly(),
+        }
+        self._create_and_transmit(
+            ring_format=1, buffers=0, in_order=0, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio_inorder_mergeable(self):
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
+            "rss": RSSSetting.SetIPOnly(),
+        }
+        self._create_and_transmit(
+            ring_format=0, buffers=1, in_order=1, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio_inorder_nonmergeable(self):
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
+            "rss": RSSSetting.SetIPOnly(),
+        }
+        self._create_and_transmit(
+            ring_format=0, buffers=0, in_order=1, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio_mergeable(self):
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
+            "rss": RSSSetting.SetIPOnly(),
+        }
+        self._create_and_transmit(
+            ring_format=0, buffers=1, in_order=0, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio_nonmergeable(self):
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
+            "tx_offloads": 0,
+            "enable_hw_vlan_strip": True,
+            "rss": RSSSetting.SetIPOnly(),
+        }
+        self._create_and_transmit(
+            ring_format=0, buffers=0, in_order=0, vectorized=1, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio_vectorized(self):
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
+        self._create_and_transmit(ring_format=0, buffers=1, in_order=0, vectorized=0, extra_args={})
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio11_inorder_mergeable(self):
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
+            "rss": RSSSetting.SetIPOnly(),
+        }
+        self._create_and_transmit(
+            ring_format=1, buffers=1, in_order=1, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio11_inorder_nonmergeable(self):
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
+        extra_args: TestPmdParamsDict = {"rss": RSSSetting.SetIPOnly()}
+        self._create_and_transmit(
+            ring_format=1, buffers=0, in_order=1, vectorized=0, extra_args=extra_args
+        )
+
+    @perf_test
+    def test_perf_vhost_single_core_virtio11_vectorized(self):
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
+        extra_args: TestPmdParamsDict = {"rss": RSSSetting.SetIPOnly()}
+        self._create_and_transmit(
+            ring_format=1, buffers=0, in_order=1, vectorized=1, extra_args=extra_args
+        )
-- 
2.55.0

