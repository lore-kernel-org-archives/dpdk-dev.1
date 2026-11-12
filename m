Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BC606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=MXCNS91N
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1450642D6A;
	Thu, 12 Nov 2026 22:00:44 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTPS id 8804C42D68
 for <dev@dpdk.org>; Thu, 12 Nov 2026 22:00:42 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-93f30660e69so24578185a.0
 for <dev@dpdk.org>; Thu, 12 Nov 2026 13:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1794517241; x=1795122041; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CCj1NIps0UUt4f9gtlv8iOSW7m7HZOmttQ01JwF+qD0=;
 b=MXCNS91NmwyagyTAE+XB5JviLW+XK5uvlao9wE/WKPHJr+OcdwpZx+rxfEyVAgWMpN
 rwgkt8EWQfgTAAZuEZC7rNZN3pEQ+0VaiZOqEv7IspIKA6Q/woTkImi4gH3NrG1+KXzp
 kjhRKIF+KRBIYXtQTyqdjF++xhfWR2hershn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794517241; x=1795122041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CCj1NIps0UUt4f9gtlv8iOSW7m7HZOmttQ01JwF+qD0=;
 b=s1DVHgec7ICMFJA1M512ysXcA9QNkKWm0o6s1AmZxp6Cmq8G9l8ADdbR7xUnwfgpoi
 5PYSh/c/VLNFwMGV4xaoWFRyqq5OeIy0n5ly4YCOOsdm85k+0BaZW7/CSxZgkqtH7RiK
 BrVCLk3IBh/soJ8rnzmUQxfsf2I4R4Hq4gg/MVclTegmWBAoGHB89ZTsD3QG8paImY9k
 K3n3R807YVJ4PwsgytWPnq0sJiSY5Hekc451zCYnC39WnTKTKpfrfIpoPzDng97Lxdq3
 Dcoi/Tac/nXW+6j4Ej+wFIrTfCE9T53WmMmi24LJsL0xTa1zPcQKy9isxEUO1inA6wem
 hhpQ==
X-Gm-Message-State: APuU4Z/5zsTcTkJSPi3Lxtg4SScvFfXVKICV3xLT+SPljEBkeAiOYsx1
 M1oqVTgsadL24NH6RX/vWm5udO8oTDb+22iYj6EnSg968yDFqGfgxre7UDCyaAUaBxc=
X-Gm-Gg: AYBFou1076SzYIFOuzz5hDm0oSevL6TRFj8dn45IfIc2Uw6nVvgXm4b7i9JbAsVfKEJ
 yIcGXRcpXB1qhRuVaQX3dZcQwXwoJaUr7tojlAxEpiQCOJw7I7VnMGolnn4dnjAROewEPCrLG6e
 kAr5K0ztfwFuIxD4Jbm/IYZEftjWUyo7B8Q8yN0MjzUCM8fkSKSvwLdHMomQL+rBayXedf+4EyK
 TLFFPW/RbBY5tmvrSebpMPLV374FNkFpjWQs3TTmWg9D4Yk73LfBPDzTE1DSXeyH3FZWhDJVWEZ
 /7AnnmVOCHHp+MAIX5coVKisZijbO5ZVLlFZKWKQQhljpxf5aYaSzY71tx+fq+ywb4Vsj80tuxZ
 x1E5Bk54BuSakxqHZNW+q22qrS9CR8zfBejEAB/PJ5VrNbBrnRikJh0omOXMqhfCiv3pUYVHEiZ
 dOzdMqHYwipYQNXHqj0DjvKbnBKxhfHbcsYsOQ/GQk9DWWfgiHfSbBlyYUadVKDN2dMuHnYp168
 yZP8osR/kdS2aVp+ojQg8VoJ3lLwVQq60S9xvw10m84p1IHcF7wKywcGiE0E7WRTeh3kGRzvc9q
 eYPkeX3bm3a9qeTe2AOh18b+v0+7p85urVE0YN+lyoJWm76BzVzyJXSvJScVh+x3SGiEd55FuGX
 KtWw8QfpoHD0NkeMpQRqPvcEt0fhwUvSkUvySdXyQMgZcnIzFs6iPdN0uR29635oTveTfADp0af
 n57vILFGE1ZWCnNs2q2jKvxo4Wxv3xzVGsfUiGI8RxH04c
X-Received: by 2002:a05:620a:6c01:b0:914:afc1:c66d with SMTP id
 af79cd13be357-9494b9aeca0mr109710585a.11.1794517241145; 
 Thu, 12 Nov 2026 13:00:41 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:79a6:f2bd:f6a:842d])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8d8298sm25178585a.38.2026.11.12.13.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:00:39 -0800 (PST)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v6 2/3] dts: add pvp multi paths vhost performance testsuite
Date: Thu, 12 Nov 2026 16:00:08 -0500
Message-ID: <20261112210009.1620168-2-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112210009.1620168-1-knimoji@iol.unh.edu>
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261112210009.1620168-1-knimoji@iol.unh.edu>
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

This patch adds the pvp multi paths vhost single core forward
performance testsuite, which launches testpmd using the vhost
and virtio virtual devices with one and two cores respectively,
and tests the vhost single core throughput performance.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 ...pvp_multi_paths_vhost_single_core_perf.rst |   8 +
 dts/configurations/tests_config.example.yaml  |  13 +
 ..._pvp_multi_paths_vhost_single_core_perf.py | 462 ++++++++++++++++++
 3 files changed, 483 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst
 create mode 100644 dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py

diff --git a/doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst b/doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst
new file mode 100644
index 0000000000..4fcc6b6c91
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_pvp_multi_paths_vhost_single_core_perf.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+pvp_multi_paths_vhost_single_core_perf Test Suite
+=================================================
+
+.. automodule:: tests.TestSuite_pvp_multi_paths_vhost_single_core_perf
+   :members:
+   :show-inheritance:
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index e20edc0855..1222469b3a 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -36,6 +36,19 @@ hello_world:
 #   test_repetitions: 5 # See `Optional Fields`
 #   delta_tolerance: 0.05
 
+# pvp_multi_paths_vhost_single_core_perf:
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
+
 # pmd_rss:
 #   NUM_QUEUES: 4
 #   ACTUAL_KEY_SIZE: 52
diff --git a/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
new file mode 100644
index 0000000000..83849bb99c
--- /dev/null
+++ b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
@@ -0,0 +1,462 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 University of New Hampshire
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
+from pathlib import PurePath
+from typing import cast
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Raw
+
+from api.artifact import Artifact
+from api.capabilities import (
+    LinkTopology,
+    requires_link_topology,
+)
+from api.packet import assess_performance_by_packet
+from api.params.eal import VirtualDevice
+from api.params.types import LogicalCoreList, RSSSetting, TestPmdParamsDict
+from api.test import get_current_test_case_name, verify, write_performance_json
+from api.test_suite import PerfSuiteConfig, TestSuite, perf_suite, perf_test
+from api.testpmd import TestPmd
+from api.testpmd.config import (
+    Params,
+    PortTopology,
+    RXRingParams,
+    SimpleForwardingModes,
+    TXRingParams,
+)
+
+
+@perf_suite
+@requires_link_topology(LinkTopology.TWO_LINKS)
+class TestPvpMultiPathsVhostSingleCorePerf(TestSuite):
+    """pvp multi paths vhost single core performance test suite."""
+
+    config: PerfSuiteConfig
+    vhost_net_path: PurePath
+
+    def set_up_suite(self):
+        """Set up the test suite.
+
+        Creates a safe path for vhost socket files and creates an
+        editable copy of the test parameters to store results.
+        """
+        self.vhost_net_path = Artifact(
+            "sut", "vhost-net", save_local_copy=False, custom_path=PurePath(".")
+        )
+        self.test_parameters = [p.model_dump() for p in self.config.test_parameters]
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
+    ) -> None:
+        """Create testpmd instances with specified params and send traffic.
+
+        Args:
+            ring_format: selects the virtio queue descriptor layout.
+            in_order: toggles in-order packet processing.
+            buffers: enables mergeable rx buffers.
+            vectorized: enables SIMD vectorized rx/tx data paths.
+            extra_args: extra/generic TestPmd arguments.
+        """
+        sut_dpdk_driver = self._ctx.sut_node.config.ports[0].os_driver_for_dpdk
+        vhost_user_vdev = VirtualDevice(f"net_vhost0,iface={self.vhost_net_path},queues=1")
+        virtio_user_vdev = VirtualDevice(
+            "net_virtio_user0,"
+            "mac=00:11:22:33:44:10,"
+            f"path={self.vhost_net_path},"
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
+            expected_mpps = params["expected_mpps"]
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
+                verify(expected_mpps > 0, "Invalid expected mpps, must be greater than 0.")
+                measured_mpps = round(
+                    self._transmit(vhost, virtio, int(frame_size), repetitions=5), 3
+                )
+                performance_delta = round(
+                    (float(measured_mpps) - float(expected_mpps)) / float(expected_mpps),
+                    3,
+                )
+
+                params["measured_mpps"] = measured_mpps
+                params["performance_delta"] = performance_delta
+                params["passing"] = float(performance_delta) >= -self.config.delta_tolerance
+
+        self._produce_stats_table(self.test_parameters)
+        for params in self.test_parameters:
+            verify(
+                params["passing"] is True,
+                f"""Packets forwarded is less than {(1 - self.config.delta_tolerance) * 100}%
+                of the expected baseline.
+                Measured MPPS = {params["measured_mpps"]}
+                Expected MPPS = {params["expected_mpps"]}""",
+            )
+
+    def _produce_stats_table(self, test_parameters: list[dict]) -> None:
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
2.56.0

