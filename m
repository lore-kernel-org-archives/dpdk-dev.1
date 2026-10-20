Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB19606A31F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=ReDs8ByN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4078640297;
	Tue, 20 Oct 2026 19:30:35 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 338EB40151
 for <dev@dpdk.org>; Tue, 20 Oct 2026 19:30:33 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-91b63bd2030so29229106d6.3
 for <dev@dpdk.org>; Tue, 20 Oct 2026 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792517432; x=1793122232; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=foJjOV1k8kVlrd7y0Ih7UMb1MlgrxbBlnKYEQHeBQWQ=;
 b=ReDs8ByNaO5Gtwdq0rqpK4PSwksnJdOY6A3LE7aOZqyUuz+t18bWjndSSTAd49ELz3
 PuErrcoGjjdYAC29+wJFIW/LeURQ8wOBOXmfRY3rqX6XOAGyoUTWM6EmKwKBeDGw/PoT
 V1AcyXjonYETLZp0JsjjOLoABSy/Vfhc5pJvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792517432; x=1793122232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=foJjOV1k8kVlrd7y0Ih7UMb1MlgrxbBlnKYEQHeBQWQ=;
 b=i+vZKFWaJLk7LM0x2st9XruE0TEauIJMssMnP/nkYqOdcM/WKvijq4y4dzLMwjOj16
 I4hwXwS94ZK+rfXg/m1WWr+5WxJqw76XxlW+JhHH/rNn8wuwAE6WQJ38etnm2INK9IHe
 C4oInogW38NPwYRlM1bl28NxkiJHTdwbrMFwqp972hy9ui/bRRPuZTukznI0q0ACQ8aF
 T5/r9eg5l9ir6N0+BZRem38MVij3yBMZuu+5dcFIvz+TLap3A5YTxl/5zkF4djQqZ3BH
 CPY4O/L4lbf0uLR4nGr8CDowElYP7JoGJN7Aawd/dDhUqkt/ypZaZLuu4KBJ6liNtt3t
 EeFg==
X-Gm-Message-State: AFq9FYLI4T3VTUDLK2W7rfRxNXTl2p4bHWrR38ROgM1NYrdO+uahDS4G
 uqi8K72U2OoYTG/Nk9c0sYEtr2yctUF/VQ8p8MmjutorSGHu5qbJrrbaV+y0Q6ijD4U=
X-Gm-Gg: AYBFou2n5J4o9TMDT2AleC4w6GRK7UANvpUrcagtlU8Ob9XK6B4nS44fkcG7TPc4cND
 FWywiEU0MfqovMkeoytqYJ48Y4cg87GszxuYhjaMChxjIph3A11YbLkYcbzrFbfnNob1yp2UQob
 3jHaAgr9Zivvy65mBIErVL96w50sc5OaiW6gw1gKo+HvmA1cHe3dUFDRaezIoV070ok54iEJgOm
 AN5eHIPrHbk/wfqDs6nDPfw3YY1X0JcvODXQvlpj627Vy5emKUoG3pC3z/fkLEYIumEfnk4ftTc
 KWe1D2vDoYRyddXbsjapYIH2MglriAobNmr0BIVQ4MAX9xXIO7ipiHUMTb8lqnEOICIavsmxO/n
 IYcX0KSevUm8xF7L6Re40YvukaWozrcod3OlhgsY9t63D0qeJJ+T2xwnVwJy6v+JigcXxpeL9Dg
 iq5g8G+Btue5+6IHIH/ANKB0RfwsReEdmeElpJhB5zsL9IJA+Bk/te/KOu/6+kvXDBZFv41GQv9
 BIxIJyOZYIfT482vVA2Rj4MIWxVUq2FiRH5xvSkfs1kwHrPdGqIA8AETbvHXysE85GLVQKBFPut
 zq5tfeBN44T8oNv6qDgOPPUn7BYRI6nStgAI54IFXxAP8SkOtJQElA==
X-Received: by 2002:a05:6214:2b0d:b0:90e:8be9:c384 with SMTP id
 6a1803df08f44-91bdf12668amr208830186d6.27.1792517432074; 
 Tue, 20 Oct 2026 10:30:32 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:79a6:f2bd:f6a:842d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c10c45747sm3278616d6.39.2026.10.20.10.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 10:30:31 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v3 1/2] dts: add pvp multi paths vhost performance testsuite
Date: Tue, 20 Oct 2026 13:30:28 -0400
Message-ID: <20261020173029.162255-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008191139.1094155-1-knimoji@iol.unh.edu>
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
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
 dts/configurations/tests_config.example.yaml  |  12 +
 dts/framework/testbed_model/linux_session.py  |   4 +
 dts/framework/testbed_model/os_session.py     |   4 +
 ..._pvp_multi_paths_vhost_single_core_perf.py | 467 ++++++++++++++++++
 5 files changed, 495 insertions(+)
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
index ce67385b0b..f765526442 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -18,6 +18,18 @@ hello_world:
 #       num_descriptors: 1024
 #       expected_mpps: 1.0
 #   delta_tolerance: 0.05
+# pvp_multi_paths_vhost_single_core_forward_perf:
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
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 8cc0d09d01..b5cc0a78a9 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -460,3 +460,7 @@ def configure_ipv4_forwarding(self, enable: bool) -> None:
         """Overrides :meth:`~.os_session.OSSession.configure_ipv4_forwarding`."""
         state = 1 if enable else 0
         self.send_command(f"sysctl -w net.ipv4.ip_forward={state}", privileged=True)
+
+    def clean_up_vhost(self) -> None:
+        """Overrides :meth:`~.os_session.OSSession.clean_up_vhost`."""
+        self.send_command("rm -rf /tmp/vhost-net*", privileged=True)
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 3f588acd44..a107bfdf1d 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -719,3 +719,7 @@ def get_pci_addr_of_crypto_vfs(self, pf_port: Port) -> list[str]:
             A list containing all of the PCI addresses of the VFs on the port. If the port has no
             VFs then the list will be empty.
         """
+
+    @abstractmethod
+    def clean_up_vhost(self) -> None:
+        """Deletes stale vhost-user Unix domain socket files."""
diff --git a/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
new file mode 100644
index 0000000000..bc220b34b9
--- /dev/null
+++ b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
@@ -0,0 +1,467 @@
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
+from api.params.eal import VirtualDevice
+from api.params.types import LogicalCoreList, RSSSetting, TestPmdParamsDict
+from api.test import get_current_test_case_name, verify, write_performance_json
+from api.test_suite import BaseConfig, TestSuite, perf_test
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
+class TestPvpMultiPathsVhostSingleCorePerf(TestSuite):
+    """pvp multi paths vhost single core performance test suite."""
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

