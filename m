Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226F1C79FAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 14:47:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40A4D402DF;
	Tue,  8 Sep 2026 16:47:14 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id CCCAB4028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 16:47:12 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-91041ee9230so49678756d6.2
 for <dev@dpdk.org>; Tue, 08 Sep 2026 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788878831; x=1789483631; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=flbcu2944ZDvJ2JEp22dJUfG2YHJGLActPSsiu+KY7c=;
 b=cT+tkdHTsAqaYADBWQj1Xwyi9eg+tqcKl1SZJDBFqR4fgsHEj5mWgqkCHNnxSK/Uzy
 5MISP+F/5k+dmva5M8GWcgMwMwlRxESM/ocTxPusTKfyUKVnut6dPtmQZClkNevyGUlZ
 0N4TORVqGzVakKZ3DdxDYcdjfZIjPqmcQcVKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788878831; x=1789483631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=flbcu2944ZDvJ2JEp22dJUfG2YHJGLActPSsiu+KY7c=;
 b=lYdgspOmAFqVRV/BDJHCE81c8YstqkjCq2LK8NM3w2HGw3Ml/ftBEd3rT39eiYCFSS
 Bh7NXbjJ0ZzLl8kgxOgjNO1/4k/KkAZCb4vlMwLe2yMaSk0lj443IgedaJZVDZcKYTUK
 G+Qegnh8a+xv/74A9Cj2oreg114U9e5NG/mTNd0BDPuoxecFgL7Ktm2tVqvdDHwD1Fnl
 d38fxmXjni9Kih2/3RaZZ33qmKWmHclH+B9BdGW7rvxrNcj3EZpFqaufh+YNmUeVN6a5
 qUFM+cXVegSKq5syWqpaL8ts03FQGxEm0bm+Fm+ZrJGYBKM8tPIwWk4S1rJNDXDhy0C6
 R+JQ==
X-Gm-Message-State: AFuF++ns4CfPJ786bTJwUxvNn620dsYTsgtRuqA5qScVIlVTIlzNhzmC
 vCBwjazmu/I9aMzPCL2QMxwJxCxiCVg7PTlQto5oo2twhwFmqq7+v8O/XJo3V6P/rf0=
X-Gm-Gg: AYBFou0BzXakccbM0tNfUZ2Vvd8Trv4nJlWSU6EwhRHnt83ed2uGWZD6//M+Sf9DwQ7
 4eOknfth+/BxzX3fEkceTEmG5GDnfoxLMcW8WUZEL9IgVLNzupFh/Q5fd45yEDe1mxbF5/kJSg0
 Nuiiw4dTFmm9d+vB7u4usj8TJUjasL80gWyGExSHgrv7q+Fy80dq+A4g4JIChavMY7P3a7lhWMJ
 KUgEj/sWW3GxeJzhxx92MESXx/OWF5SslWp6phMXQ0E15+Mk+nEi1ipatdtNlbuuEJAhAAkz+uS
 nLqLp3LoRCfZ2q3mIpM8a+sx8qMKmAnV7HZoku4zBzXWrLyOG+0lw8LkknlpUTSHM1+s7iqyoAQ
 P5GYo9pBYaFhkPr88U+XYUiqGcvoxuLhwzGkc0+sMrzvCACA+L4a7emb2tk4HHvhm/kb91W6xgj
 DNbTtCYwPLVMFX+uqJ7S0w/vUz1PZRi+faTNon1yEDmjI6mDCyZjMSFG6C0tsmmM36aFU0lc6MX
 /CGyArbTyrkC3X1CqbHdIeAbpdLMRkU3mVgDoVKmZPFDNaVNAkg77w1pmCld9bIMFz4/KwZTj6b
 17ZG0NrwP26ia7ho1oPQf68etl9G5Un84Lbp7cGE3aQjPLMbH93O6DGAL1nzNVanRTz1Pgk=
X-Received: by 2002:a05:620a:1982:b0:933:aa0:bb83 with SMTP id
 af79cd13be357-93980400a22mr3245952085a.34.1788878831020; 
 Tue, 08 Sep 2026 07:47:11 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939b554f1d2sm348146985a.21.2026.09.08.07.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 07:47:10 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v2] dts: add pvp multi paths vhost performance testsuite
Date: Tue,  8 Sep 2026 10:47:07 -0400
Message-ID: <20260908144707.862960-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901185957.453730-1-knimoji@iol.unh.edu>
References: <20260901185957.453730-1-knimoji@iol.unh.edu>
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
v2:
    *Added simd bandwidth EAL param to virtio 1.1 vectorized testcase
---
 ...lti_paths_vhost_single_core_performance.py | 458 ++++++++++++++++++
 1 file changed, 458 insertions(+)
 create mode 100644 dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_performance.py

diff --git a/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_performance.py b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_performance.py
new file mode 100644
index 0000000000..9ea29b29dc
--- /dev/null
+++ b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_performance.py
@@ -0,0 +1,458 @@
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
+from api.testpmd.config import (
+    Params,
+    PortTopology,
+    RXRingParams,
+    SimpleForwardingModes,
+    TXRingParams,
+)
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
+    ) -> None:
+        """Create testpmd instances with specified params and send traffic."""
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
+            default_args: TestPmdParamsDict = {
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
+            vhost_params: TestPmdParamsDict = {
+                "prefix": "vhost",
+                "allowed_ports": [],
+                "memory_channels": 4,
+                "port_topology": PortTopology.chained,
+                "vdevs": [vhost_user_vdev],
+                "lcore_list": LogicalCoreList([1, 2]),
+                "nb_cores": 1,
+                **default_args,
+            }
+
+            virtio_params: TestPmdParamsDict = {
+                "prefix": "virtio",
+                "no_pci": True,
+                "memory_channels": 4,
+                "allowed_ports": [],
+                "vdevs": [virtio_user_vdev],
+                "lcore_list": LogicalCoreList([3, 4, 5]),
+                "nb_cores": 2,
+                **extra_args,
+                **default_args,
+            }
+
+            with (
+                TestPmd(**vhost_params) as vhost,
+                TestPmd(**virtio_params) as virtio,
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
+        test_case = get_current_test_case_name()
+        header = f"{'Frame Size':>12} | {'TXD/RXD':>12} | {'Real MPPS':>12} | {'Expected MPPS':>14}"
+        print(f"{test_case} Results:")
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
+            ring_format=1,
+            buffers=1,
+            in_order=0,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=1,
+            buffers=0,
+            in_order=0,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=0,
+            buffers=1,
+            in_order=1,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=0,
+            buffers=0,
+            in_order=1,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=0,
+            buffers=1,
+            in_order=0,
+            vectorized=0,
+            extra_args=extra_args,
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
+            "tx_offloads": 0,
+            "enable_hw_vlan_strip": True,
+            "rss": cast(RSSSetting, RSSSetting.SetIPOnly()),
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
+        self._create_and_transmit(
+            ring_format=0,
+            buffers=0,
+            in_order=0,
+            vectorized=1,
+            extra_args={},
+        )
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
+            ring_format=1,
+            buffers=1,
+            in_order=1,
+            vectorized=0,
+            extra_args=extra_args,
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
+        extra_args: TestPmdParamsDict = {"rss": cast(RSSSetting, RSSSetting.SetIPOnly())}
+        self._create_and_transmit(
+            ring_format=1,
+            buffers=0,
+            in_order=1,
+            vectorized=0,
+            extra_args=extra_args,
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
+            ring_format=1,
+            buffers=0,
+            in_order=1,
+            vectorized=1,
+            extra_args=extra_args,
+        )
-- 
2.55.0

