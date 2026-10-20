Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A36606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=ALPmbftS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E55704065A;
	Tue, 20 Oct 2026 19:30:38 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id AB5BF40151
 for <dev@dpdk.org>; Tue, 20 Oct 2026 19:30:34 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-917d595138fso23374626d6.3
 for <dev@dpdk.org>; Tue, 20 Oct 2026 10:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792517434; x=1793122234; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Fa5amF1DW9e17CrS3Ib7RmGG6L69m4MJNkYNljfvPk=;
 b=ALPmbftShuH23lEQRV/U2P2Ppj68JM+53+ncT1aSnNIoqyVd/X596zahYwFjmCNE0h
 TIGugn1fiYGpF//ED7PjWPXjxUMZ/NmefxVzaqF98hDqtvIOcvc4DzfBjHPJuygjmBzo
 xGIU+1nkA1V/h/ZvZAAa5z7iq8/xFAcillxXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792517434; x=1793122234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Fa5amF1DW9e17CrS3Ib7RmGG6L69m4MJNkYNljfvPk=;
 b=m46yVJpXllrWKR5UpPLtTIWtfVBm4FoBw9bGh8qyDdaaoJC0lclXNUPWbv0opWUwfm
 RyAuOc2FPC8MEn1P0o5dGNruG2Vm8V67plmGllHgkYWSE4keHtuKV9Mir8xBOWEhYnBT
 WXqmM7t8vouHqYlnX2ql2fehjqoDPZA5iIfhRRwA8ux9uXIAEH9Jp3yQ1tvRLM55uFWy
 wOHjVTtE0g4Nw7/wcNT2yC1GJIlWp7+usvw9bN2D5vfg06BWtuH5/xWht4Z3Yv5O/lKX
 AYRd6CH9Rcr28AagTi+tdpB29jKHSrTKFpqS+v+rL40LciF6LIx0jdzw35X7i2n8UfO+
 tB9g==
X-Gm-Message-State: AFq9FYKV8IOO2Y5SqER63l+B13U8HYXROKpRzg1ZOV9LuAnJUEN1UbVc
 Pp8GVxjtkwLqUmTh6keI4J+R0QkmHwKSGwXWiCe6bPp4CwvelWBesS4Zl1/N40WA6Kg=
X-Gm-Gg: AYBFou3/mozlCZE8Kt+nGgyEu4qcWZBlxuD3GhTKu/6L6352Xgm6nDi9k9AgCgF8Uz5
 0wNCjy4ffsZvgZ216IpGFqz/AQcGR+XyJ8Z2LZEhrxL4R2eyWSLWQ3o+BK3PsscvX9NsN6r4Vkm
 1ulrdLLr3wD1Gu8Z3li7sDP9fQTcKcEG8OpMXIiiXtU/6GIjlxn7MVSDMyXlEhXW6rm2MlXqBUh
 x6N0uVsjznSegjvi9wgumSebhirWdtTkv4NPDlOXgKiXzA0B7dI+YxnK8k3liRkc5eE0tdSSNmM
 Mr6QBBd5plWJkNCEPg3SNyPHY589aYjhvspx+C7aS2eGBZI/HLqooEVIL0lKEPSbGHTDUaFv3zt
 St59NXqWiTfnlo8wI61DsJqKsq6hQA6JwMA8bn4uv9sreuTRlpVYpZiF2ovR294DCpsz7NCYtNi
 PECFEw4wDgniLr42kJl39lfj/UpJ1tmaUrBz01ukJ+kSjNR7fTv/12GHpCdzcS5K28tinIvQBiU
 A29sHwBe/K9Y7QrfK179pqTMJJf4+m7Cg+//c4V+h6bIZRzU66agWj9FXiGn/cXnzhraroxT+KF
 Gx35I/y/ZpEHWdQNa7Iel9ENCZ1yEJefgSwnKyZublXowplG0TT9n7kG2J+a/502aOWl
X-Received: by 2002:a05:6214:4987:b0:914:cdbf:b68 with SMTP id
 6a1803df08f44-91bdf0a6942mr195771296d6.20.1792517433649; 
 Tue, 20 Oct 2026 10:30:33 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:79a6:f2bd:f6a:842d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c10c45747sm3278616d6.39.2026.10.20.10.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 10:30:33 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v3 2/2] dts: add pvp multi paths virtio performance testsuite
Date: Tue, 20 Oct 2026 13:30:29 -0400
Message-ID: <20261020173029.162255-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020173029.162255-1-knimoji@iol.unh.edu>
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261020173029.162255-1-knimoji@iol.unh.edu>
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
index 0000000000..b5397074e0
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
+from api.params.eal import Params, VirtualDevice
+from api.params.types import LogicalCoreList, RSSSetting, TestPmdParamsDict
+from api.test import get_current_test_case_name, verify, write_performance_json
+from api.test_suite import BaseConfig, TestSuite, perf_test
+from api.testpmd import TestPmd
+from api.testpmd.config import PortTopology, RXRingParams, SimpleForwardingModes, TXRingParams
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

