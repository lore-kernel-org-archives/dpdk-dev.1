Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FB4606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=YV2DeRX6
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55EF740664;
	Tue,  3 Nov 2026 23:02:24 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTPS id 981C240272
 for <dev@dpdk.org>; Tue,  3 Nov 2026 23:02:22 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-53665358476so53060991cf.2
 for <dev@dpdk.org>; Tue, 03 Nov 2026 14:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793743341; x=1794348141; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IXzXiSJ9VWxk5ySPc6PyDVnfS4R1wMbrll59BZvRyyM=;
 b=YV2DeRX6bHNFO/0KU1A7+ZCwu6uk0HsOSBZocwoWAJDjEKAQrTPcccpMymlNkR1upp
 h9mx+6sa+u+ysNbJzNskyZAf38pJFZ5jv4M4tS7hIlgpoqUpcp6gQHe7lYtlqVzIUXGV
 NZ1b+jExZX093OfVWx476thh6cKx9ovA6uKaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793743341; x=1794348141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IXzXiSJ9VWxk5ySPc6PyDVnfS4R1wMbrll59BZvRyyM=;
 b=o/znL9dNguhh8nz3ldgutoEbeh0L26kNPAT4G0IGYGAQDMwPPxz1Byf8fB7L7AOP6u
 Jrm9LDzew70zaiAYwanhu+AfExkpae2NdxYGANf7w/AJFfrCcotWad3LNVrpdEFKuQpf
 WQLenb+eINlKZfkUjJ4ZUEiptFmlW9k8oc6B512gaKqOChQmUE7IJ0wSfVkgbCUwIjvQ
 4BMKBGfN5U16d1QJP+OA3zt7xc9LQb66WXt5p8yvGnbZCN8qC1EYaaaEDof66ACGh9D7
 Qm38sTn857C+2b65/v663pK1UBmyKQpWFmBjXkhahfU1eM2zZ6xKbXZW8N41cPQ/qPfn
 8xqw==
X-Gm-Message-State: APuU4Z/KU5Epze+ZnomongpEWXcJhhd80jlYz+XpkDZT97yFMdB7oIGz
 1iqJEkenTCidZwTtoJm6if4jLt3rMVK01IpEFUKjOzPIY/XgX5h6KunfDkjgPiS0mMRXUaxUfH+
 0JtuB
X-Gm-Gg: AYBFou1f9ml7obhKr8OJDPp/96guC+Bw1Dtng0w5zFd2JCKpHUvIul4BYaCAtMsjs/1
 U/mkrOY7nTlHWfEA5nirH8J9JYDvn3Cb8lXnc9KnAH7F5nXWCZRTgDsIBjfcYGN/aPQ2zPuSry5
 W/vF0r8wY39YcQ1dIQzf4MnuHElUIsVAUCU3ZgfZViRP/QxeLq65qyk6Hi/ldOhgtdHuNRnZOna
 NA//sq14loc5pEDnhH+7gTq7zGj/fbJqZk7Wo5TSGqJmZYLeqYlA09OfBZlMEkjjpk4qOvJNQip
 zIm8IlZbBBPzuW34ZDC97FH0kZvQfkS3AtTj5LtYySZZIC335ToPrcKHQbrnB8qY/S7ruqSQdfJ
 9+zx540KnvJwL5SBFgOwACGmNvwI/APOoO5NDHi0khrqsNpTWHP8obQuja5cimUIceCTcd4LhHt
 MDH8zyEzaTGDgTCPkriKyQSq9jj8pJCuSH6xYVgh+IaimgG9Q5f1iNj16AoCUWDeShvUuyr3wRf
 mtWgtDdDhaIQ4rasFxPp05IcemkQZay/vdklIBYzoIJkZkTB6D3VGAXCLxzPsQp4iaRLLv7JIx6
 DWp4NN18CADuQkLBHAhLvLNEwYUt2gblfnQFDU4pFo2WrlQ3FVsJcwJDI7tG9kWu9ziteG8OO9f
 Cp6XCRRxMjInis6mRZTjiPjfa0/IIz7+6eC1o6S/z7ZdADuou2fM4pgM+qOgNo3KbHGPL23j4Gg
 8UXVG6bmAWsjbYi2b1wd3v06Ebyf5dB4w5LDZVPI+bgNHF
X-Received: by 2002:a05:622a:48f:b0:535:162c:2e85 with SMTP id
 d75a77b69052e-542b3c732eamr229713681cf.10.1793743341125; 
 Tue, 03 Nov 2026 14:02:21 -0800 (PST)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:79a6:f2bd:f6a:842d])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54b100aba19sm6938511cf.8.2026.11.03.14.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 14:02:20 -0800 (PST)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v4 1/2] dts: add pvp multi paths vhost performance testsuite
Date: Tue,  3 Nov 2026 17:02:17 -0500
Message-ID: <20261103220218.902765-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.56.0
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
v4:
    *Refactored testsuite config parameters, moved test case
     setup logic outside of test suite setup
---
 ...pvp_multi_paths_vhost_single_core_perf.rst |   8 +
 dts/api/testbed_model/virtual_device.py       |   8 +
 dts/configurations/tests_config.example.yaml  |  24 +
 ..._pvp_multi_paths_vhost_single_core_perf.py | 523 ++++++++++++++++++
 4 files changed, 563 insertions(+)
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
diff --git a/dts/api/testbed_model/virtual_device.py b/dts/api/testbed_model/virtual_device.py
index 1a4794e695..8ac9a625f5 100644
--- a/dts/api/testbed_model/virtual_device.py
+++ b/dts/api/testbed_model/virtual_device.py
@@ -6,6 +6,8 @@
 Alongside support for physical hardware, DPDK can create various virtual devices.
 """
 
+from api.context import get_ctx
+
 
 class VirtualDevice:
     """Base class for virtual devices used by DPDK.
@@ -27,3 +29,9 @@ def __init__(self, name: str) -> None:
     def __str__(self) -> str:
         """This corresponds to the name used for DPDK devices."""
         return self.name
+
+
+def clean_up_vhost() -> None:
+    """Deletes stale vhost-user Unix domain socket files."""
+    ctx = get_ctx()
+    ctx.sut_node.main_session.send_command("rm -rf /tmp/vhost-net*", privileged=True)
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index ce67385b0b..36a0e7c2f1 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -18,6 +18,30 @@ hello_world:
 #       num_descriptors: 1024
 #       expected_mpps: 1.0
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
+# pvp_multi_paths_virtio_single_core_perf:
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
diff --git a/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
new file mode 100644
index 0000000000..269fad1782
--- /dev/null
+++ b/dts/tests/TestSuite_pvp_multi_paths_vhost_single_core_perf.py
@@ -0,0 +1,523 @@
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
+from api.params.eal import VirtualDevice
+from api.params.types import LogicalCoreList, RSSSetting, TestPmdParamsDict
+from api.test import get_current_test_case_name, verify, write_performance_json
+from api.test_suite import BaseConfig, TestSuite, perf_suite, perf_test
+from api.testbed_model.virtual_device import clean_up_vhost
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
+class TestPvpMultiPathsVhostSingleCorePerf(TestSuite):
+    """pvp multi paths vhost single core performance test suite."""
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

