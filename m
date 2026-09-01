Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C49C61DD3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 19:00:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5A584064F;
	Tue,  1 Sep 2026 21:00:01 +0200 (CEST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53]) by mails.dpdk.org (Postfix) with ESMTP id D840B4064E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 21:00:00 +0200 (CEST)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-90cd4631090so2138986d6.1
 for <dev@dpdk.org>; Tue, 01 Sep 2026 12:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788289200; x=1788894000; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vFUvMi++soezGWjLI+NImpd0uFHEZFQqa1N0bDmMKMQ=;
 b=Fn+7XJaqvcQnIDfWrrS8K00RKFly3hI7aw7my72dxNykwIuaxPvZOVkjKJRQ6LSR57
 ln6U3rdN9VHJadCW+PdnQ10HZwGNxJipTYuV8LopSydsSjW4PpmbCBAFofWnV9hs6qCM
 um493JWYcajw62Eefuv+mTqRFn1KDQupwmHrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788289200; x=1788894000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vFUvMi++soezGWjLI+NImpd0uFHEZFQqa1N0bDmMKMQ=;
 b=pCuj3PsJCKDROyOo3VXoOAZrmskTUXnYZ51PM/l4oM8BCl5TekNf33riY/k9+N8p05
 28Mim1fd+a0TFoNFu9aIuWy+P90WQNf2+d3jMY/ilyLfdyzDwEx6/OqQdlpf6KXPxmp3
 UCM5IcJ0CGajba0V3y5hdYMsc51ylBDk5Glo4v9e+aFXl5sl0ziKMybd9tGn23ga7j2i
 c5X1U86lt05iwnftoB7izxvjW8lmZoKpE40Pc8e2RjiAQIryqNZPYSFY1FheU678JxVB
 0bwbMH8lhXZvR6q48OOG/p7uS3JdG+QNNTPjVd3WB7pSGeCpg/CMkBZaujZRuSDx6iRH
 2qng==
X-Forwarded-Encrypted: i=1;
 AKwUvBykpqcIC3Pq8SwV8VLFrcfunj8GJOvJFPqsKy4Nu8R+J7bCsrTExlF+IC262l0UAKgzEt4=@dpdk.org
X-Gm-Message-State: AFuF++k007R0cbRxU2fBySeKgMr7sz8LdPmS1lrJNdKYFFVPXbH+NxI4
 OlX0zGrJpzH5DDUye2gA0DslA8Bbfa74sMjU4qRiqhpBoIm1kHuWH3kmQ/B8dKc25XA=
X-Gm-Gg: AYBFou2oEKqWH11QvUZpuaDJ3Ysz3FvEhglBY+XZIgarZjK8dwl98SRhvOXuwCXdrCh
 NjMoyz6htWRNJVpxkg+v/CW723QOuw8GDEhUpYBGlNRjC/sSjuH9uJylyZrW1cl18MTAIURmbgM
 WEemXazHIXe8ixhAYySUpDLrwUsAxjU4ERzx1XbRmx1AXJ+jahfJLowKZSpS8JzVHOUIC2P3d9x
 nODGZhy+mQfL7Trsuyt0aga6+SPtAYQCYlpqqQf7Jw0nfYpUH6t2+inmX9gH3tuYK0YDxb34ldp
 P2wkD6qEHZgOWv23aM85Cysm1K6BUOJyGMpx/32KSrF9UIyMeU16ujx/nircYm1q1HnG2/Q5eLK
 Nt7vsTbnBt5WEA0u0fkpAdQl9iC6ZqAsPbtCSeINzzxcon23iVQFwA6mXnQa09Odycz5QRjgfPP
 rm0iZ8NdyrnCl40MM2ggDMNUM0JNxxPlRSm409ODMRMJUl6IUnhQXMNVp+2qJCL1p2nyYUOgchB
 Qp74RWCBiUjFUewGfU4Z06D7gANPqPcxnIzi3lAy1TiLQETlaDHRAAo/FJr41XYTDNagXoChgTa
 ppGxth5CXy2efRaTLBs2E5iThJ3I6L7xG0lD0opZMNpSj2tEu8gvxwTtT+T8jQ==
X-Received: by 2002:a05:6214:1313:b0:907:7f86:ef51 with SMTP id
 6a1803df08f44-90e957a414amr89865256d6.14.1788289199896; 
 Tue, 01 Sep 2026 11:59:59 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9eee72f8sm534266d6.36.2026.09.01.11.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 11:59:59 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com,
	dev@dpdk.org
Cc: dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [RFC PATCH] dts: add pvp multi paths vhost performance testsuite
Date: Tue,  1 Sep 2026 14:59:57 -0400
Message-ID: <20260901185957.453730-1-knimoji@iol.unh.edu>
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

This patch adds the pvp multi paths vhost single core forward
performance testsuite, which launches testpmd using the vhost
and virtio virtual devices with one and two cores respectively,
and tests the vhost single core throughput performance.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 ...lti_paths_vhost_single_core_performance.py | 445 ++++++++++++++++++
 1 file changed, 445 insertions(+)
 create mode 100644 dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_performance.py

diff --git a/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_performance.py b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_performance.py
new file mode 100644
index 0000000000..111cb4df12
--- /dev/null
+++ b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_performance.py
@@ -0,0 +1,445 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Vhost-user single-core forwarding performance test suite.
+
+This suite measures the packet forwarding performance of DPDK's vhost-user PMD running on a
+single CPU core in a Physical-Virtual-Physical (PVP) topology. Performance is evaluated across
+multiple virtio-user backend options, including packed versus split ring formats, in-order packet
+processing, mergeable buffers, and SIMD vectorization. Test cases are parameterized using
+combinations of frame sizes, descriptor ring sizes, and target MPPS baselines specified in the
+test configuration. High-speed traffic is injected from an external generator through SUT physical
+interfaces, routed through Vhost and Virtio loops, and returned to the generator to measure
+aggregate MPPS.
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
+class TestPvpMultiPathsVhostSingleCorePerformance(TestSuite):
+    """pvp multi paths vhost single core performance test suite."""
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
+            testpmd: The testpmd shell to use for forwarding packets.
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
+            # extra_args["tx_ring"] = TXRingParams(descriptors=num_descriptors)
+            # extra_args["rx_ring"] = RXRingParams(descriptors=num_descriptors)
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
+                    lcore_list=LogicalCoreList([1, 2]),
+                    nb_cores=1,
+                    **default_args,
+                ) as vhost,
+                TestPmd(
+                    prefix="virtio",
+                    no_pci=True,
+                    memory_channels=4,
+                    allowed_ports=[],
+                    vdevs=[virtio_user_vdev],
+                    lcore_list=LogicalCoreList([3, 4, 5]),
+                    nb_cores=2,
+                    **extra_args,
+                    **default_args,
+                ) as virtio,
+            ):
+                vhost.set_forward_mode(SimpleForwardingModes.mac)
+                virtio.set_forward_mode(SimpleForwardingModes.io)
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
+            ring_format=1,
+            buffers=1,
+            in_order=0,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=1,
+            buffers=0,
+            in_order=0,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=0,
+            buffers=1,
+            in_order=1,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=0,
+            buffers=0,
+            in_order=1,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=0,
+            buffers=1,
+            in_order=0,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=0,
+            buffers=0,
+            in_order=0,
+            vectorized=1,
+            extra_args=extra_args,
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
+        self._create_and_transmit(
+            ring_format=0,
+            buffers=1,
+            in_order=0,
+            vectorized=0,
+            extra_args={},
+        )
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
+            ring_format=1,
+            buffers=1,
+            in_order=1,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=1,
+            buffers=0,
+            in_order=1,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=1,
+            buffers=0,
+            in_order=1,
+            vectorized=1,
+            extra_args=extra_args,
+        )
-- 
2.55.0

