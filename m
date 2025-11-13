Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F75BCD4F2C
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 01:29:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C7F840E1E;
	Thu, 13 Nov 2025 02:28:48 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id E881240E17
 for <dev@dpdk.org>; Thu, 13 Nov 2025 02:28:45 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4ed75832448so3365731cf.2
 for <dev@dpdk.org>; Wed, 12 Nov 2025 17:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762997325; x=1763602125; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vH7qKJKiOIpaYZOzOcYfXAw98zzzRWeEm+v81ExEBSc=;
 b=S6gazwaqWgGB6N2vZn9yE6ZgqRd1XVeDkSa3ApnmLVGIjXNchaWV20cvEngDn9uHQi
 +Rp6Ym/jAc91HNKJWTRY3CUIRWaAAGAG04qtHPy9hoH5EbhtAKacCv4j8U57hmwSzi9w
 67c1//858McK+aaFMoLwlb6WiSuqRj1pg7cCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762997325; x=1763602125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vH7qKJKiOIpaYZOzOcYfXAw98zzzRWeEm+v81ExEBSc=;
 b=r6iPstv7B4wWROsbL49OYEgIiz6Nb6p2hijwLGhWdP07mKz7kAGPHRsgvQtk0pg4Dv
 9NkzWCkgq6B0QIE0tqqXqawV8S84uwxW+cgFK+kOm+BCqcy1WnBbtuuSSbT2rAis9wjS
 YFeo9YtUeqJdpQEQIeYsEE6mn1iiqNQ64yYUMTS7ZMHWGiLIwXIaq2xEdvbjXy+5uVCY
 827mnkEZriP/KoVkLjlDXhJcTqlSX45OoxbgBsNgktitpEMOENlAbqdg6wsObc2q047j
 7zfLYTTJl1b2NqDlLVIMjQPaApmEt3A4N0jZC2CB9I3wWnC7QWQvgKLMA3YhcQ23Ldnr
 dw3Q==
X-Gm-Message-State: AOJu0Yxahuu8xLoEZiBqdA5wNj/ot1m2lNQrEnhmEI9nCnNNHlQHu/36
 7njf/eZ/vKEVh1OVOL8Uqn/lQahdH64k8vXKAUdm6Hqi0o/BqHe9v7fKKpEAVpZpdEA=
X-Gm-Gg: ASbGncts1+rd6n//1b6MXzqQaW25BAMjtZ2Yho0Cn8rbGSgRWSqZDGXIx+odoBHKmOP
 m1zy1ZmMraTmxG1ZG/UD4pSEwax37owgdDaBOXoyASGIRECF4DOLOJsbdbO+VbZ0Gd+GaFfBCGR
 N1k8Med59GOiuenpfU6ffiE06l+V0VM0K6UGntvqIugL11Pe28XzUeDowhcwmaJhbGLow+VGTTd
 0riGOHj0Hk1FKJdu1Fl4rxBDwujuK/a46Kv8Bx+CrKD9ssHNXes80IHOYSLxksAsD4w5R9n/eZJ
 isHn2FPWwM03dbS3yhwUx3FgbutJf7JBKyFwe8jDSoLgXTgLy5cXDcaqCHl3mFreY1H/LvZTwh0
 ySjozlM3awFVRqOXbrQEwy6jqpT7TGo8ATranR4xsyrcas9GLaZkdhCOnf/YlV+IECrB6UZFxWH
 bi
X-Google-Smtp-Source: AGHT+IEuf3FAdp1XdFmQh+atrNrfdmuoiKQOP351L5UTfxp2XsZYjTqn6oexlgsqw2PsJMRcnOcS1A==
X-Received: by 2002:ac8:7f42:0:b0:4ed:da56:7a96 with SMTP id
 d75a77b69052e-4eddbdae8d3mr75593791cf.60.1762997325028; 
 Wed, 12 Nov 2025 17:28:45 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ede86b3820sm3567821cf.4.2025.11.12.17.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 17:28:44 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, abailey@iol.unh.edu,
 Paul.Szczepanek@arm.com, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v7 3/3] dts: add performance test functions and support
Date: Wed, 12 Nov 2025 20:27:32 -0500
Message-ID: <20251113012732.1059669-4-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251113012732.1059669-1-probb@iol.unh.edu>
References: <20251105223628.1659390-1-probb@iol.unh.edu>
 <20251113012732.1059669-1-probb@iol.unh.edu>
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

From: Nicholas Pratte <npratte@iol.unh.edu>

Provide packet transmission function to support performance tests using a
user-supplied performance traffic generator. The single core performance
test is included. It allows the user to define a matrix of frame size,
descriptor count, and expected mpps, and fails if any combination does
not forward a mpps count within 5% of the given baseline. Furthermore
ensure that the DPDK build on the SUT is including the correct arguments
to allow for the highest possible packet throughput.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
---
 ...sts.TestSuite_single_core_forward_perf.rst |   8 +
 dts/api/packet.py                             |  35 +++-
 dts/api/test.py                               |  32 ++++
 dts/configurations/tests_config.example.yaml  |  12 ++
 dts/framework/remote_session/dpdk.py          |  15 +-
 .../TestSuite_single_core_forward_perf.py     | 149 ++++++++++++++++++
 6 files changed, 249 insertions(+), 2 deletions(-)
 create mode 100644 doc/api/dts/tests.TestSuite_single_core_forward_perf.rst
 create mode 100644 dts/tests/TestSuite_single_core_forward_perf.py

diff --git a/doc/api/dts/tests.TestSuite_single_core_forward_perf.rst b/doc/api/dts/tests.TestSuite_single_core_forward_perf.rst
new file mode 100644
index 0000000000..3651b0b041
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_single_core_forward_perf.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+single_core_forward_perf Test Suite
+===================================
+
+.. automodule:: tests.TestSuite_single_core_forward_perf
+   :members:
+   :show-inheritance:
diff --git a/dts/api/packet.py b/dts/api/packet.py
index ac7f64dd17..094a1b7a9d 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -33,6 +33,9 @@
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
 )
+from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+    PerformanceTrafficStats,
+)
 from framework.utils import get_packet_summaries
 
 
@@ -108,7 +111,9 @@ def send_packets(
         packets: Packets to send.
     """
     packets = adjust_addresses(packets)
-    get_ctx().func_tg.send_packets(packets, get_ctx().topology.tg_port_egress)
+    tg = get_ctx().func_tg
+    if tg:
+        tg.send_packets(packets, get_ctx().topology.tg_port_egress)
 
 
 def get_expected_packets(
@@ -317,3 +322,31 @@ def _verify_l3_packet(received_packet: IP, expected_packet: IP) -> bool:
     if received_packet.src != expected_packet.src or received_packet.dst != expected_packet.dst:
         return False
     return True
+
+
+def assess_performance_by_packet(
+    packet: Packet, duration: float, send_mpps: int | None = None
+) -> PerformanceTrafficStats:
+    """Send a given packet for a given duration and assess basic performance statistics.
+
+    Send `packet` and assess NIC performance for a given duration, corresponding to the test
+    suite's given topology.
+
+    Args:
+        packet: The packet to send.
+        duration: Performance test duration (in seconds).
+        send_mpps: The millions packets per second send rate.
+
+    Returns:
+        Performance statistics of the generated test.
+    """
+    from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+        PerformanceTrafficGenerator,
+    )
+
+    assert isinstance(
+        get_ctx().perf_tg, PerformanceTrafficGenerator
+    ), "Cannot send performance traffic with non-performance traffic generator"
+    tg: PerformanceTrafficGenerator = cast(PerformanceTrafficGenerator, get_ctx().perf_tg)
+    # TODO: implement @requires for types of traffic generator
+    return tg.calculate_traffic_and_stats(packet, duration, send_mpps)
diff --git a/dts/api/test.py b/dts/api/test.py
index f58c82715d..e17babe0ca 100644
--- a/dts/api/test.py
+++ b/dts/api/test.py
@@ -6,6 +6,10 @@
 This module provides utility functions for test cases, including logging, verification.
 """
 
+import json
+from datetime import datetime
+
+from api.artifact import Artifact
 from framework.context import get_ctx
 from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger
@@ -124,3 +128,31 @@ def get_logger() -> DTSLogger:
     if current_test_suite is None:
         raise InternalError("No current test suite")
     return current_test_suite._logger
+
+
+def write_performance_json(
+    performance_data: dict, filename: str = "performance_metrics.json"
+) -> None:
+    """Write performance test results to a JSON file in the test suite's output directory.
+
+    This method creates a JSON file containing performance metrics in the test suite's
+    output directory. The data can be a dictionary of any structure. No specific format
+    is required.
+
+    Args:
+        performance_data: Dictionary containing performance metrics and results.
+        filename: Name of the JSON file to create.
+
+    Raises:
+        InternalError: If performance data is not provided.
+    """
+    if not performance_data:
+        raise InternalError("No performance data to write")
+
+    perf_data = {"timestamp": datetime.now().isoformat(), **performance_data}
+    perf_json_artifact = Artifact("local", filename)
+
+    with perf_json_artifact.open("w") as json_file:
+        json.dump(perf_data, json_file, indent=2)
+
+    get_logger().info(f"Performance results written to: {perf_json_artifact.local_path}")
diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index c011ac0588..fede1fda80 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -3,3 +3,15 @@
 # Define the custom test suite configurations
 hello_world:
   msg: A custom hello world to you!
+# single_core_forward_perf:
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
\ No newline at end of file
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index c6e8c1b2ec..c3575cfcaf 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -24,6 +24,7 @@
     RemoteDPDKTarballLocation,
     RemoteDPDKTreeLocation,
 )
+from framework.context import get_ctx
 from framework.exception import ConfigurationError, RemoteFileNotFoundError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
@@ -259,9 +260,21 @@ def _build_dpdk(self) -> None:
         Uses the already configured DPDK build configuration. Assumes that the
         `remote_dpdk_tree_path` has already been set on the SUT node.
         """
+        ctx = get_ctx()
+        # If the SUT is an ice driver device, make sure to build with 16B descriptors.
+        if (
+            ctx.topology.sut_port_ingress
+            and ctx.topology.sut_port_ingress.config.os_driver == "ice"
+        ):
+            meson_args = MesonArgs(
+                default_library="static", libdir="lib", c_args="-DRTE_NET_INTEL_USE_16BYTE_DESC"
+            )
+        else:
+            meson_args = MesonArgs(default_library="static", libdir="lib")
+
         self._session.build_dpdk(
             self._env_vars,
-            MesonArgs(default_library="static", libdir="lib"),
+            meson_args,
             self.remote_dpdk_tree_path,
             self.remote_dpdk_build_dir,
         )
diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/TestSuite_single_core_forward_perf.py
new file mode 100644
index 0000000000..8a92ba39b5
--- /dev/null
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Single core forwarding performance test suite.
+
+This suite measures the amount of packets which can be forwarded by DPDK using a single core.
+The testsuites takes in as parameters a set of parameters, each consisting of a frame size,
+Tx/Rx descriptor count, and the expected MPPS to be forwarded by the DPDK application. The
+test leverages a performance traffic generator to send traffic at two paired TestPMD interfaces
+on the SUT system, which forward to one another and then back to the traffic generator's ports.
+The aggregate packets forwarded by the two TestPMD ports are compared against the expected MPPS
+baseline which is given in the test config, in order to determine the test result.
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
+from api.testpmd.config import RXRingParams, TXRingParams
+from framework.params.types import TestPmdParamsDict
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
+class TestSingleCoreForwardPerf(TestSuite):
+    """Single core forwarding performance test suite."""
+
+    config: Config
+
+    def set_up_suite(self):
+        """Set up the test suite."""
+        self.test_parameters = self.config.test_parameters
+        self.delta_tolerance = self.config.delta_tolerance
+
+    def _transmit(self, testpmd: TestPmd, frame_size: int) -> float:
+        """Create a testpmd session with every rule in the given list, verify jump behavior.
+
+        Args:
+            testpmd: The testpmd shell to use for forwarding packets.
+            frame_size: The size of the frame to transmit.
+
+        Returns:
+            The MPPS (millions of packets per second) forwarded by the SUT.
+        """
+        # Build packet with dummy values, and account for the 14B and 20B Ether and IP headers
+        packet = (
+            Ether(src="52:00:00:00:00:00")
+            / IP(src="1.2.3.4", dst="192.18.1.0")
+            / Raw(load="x" * (frame_size - 14 - 20))
+        )
+
+        testpmd.start()
+
+        # Transmit for 30 seconds.
+        stats = assess_performance_by_packet(packet=packet, duration=30)
+
+        rx_mpps = stats.rx_pps / 1_000_000
+
+        return rx_mpps
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
+            print(f"{params['measured_mpps']:>12.2f} | {params['expected_mpps']:>14.2f}")
+            print("-" * len(header))
+
+        write_performance_json({"results": test_parameters})
+
+    @perf_test
+    def single_core_forward_perf(self) -> None:
+        """Validate expected single core forwarding performance.
+
+        Steps:
+            * Create a packet according to the frame size specified in the test config.
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect.
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance).
+        """
+        # Find SUT DPDK driver to determine driver specific performance optimization flags
+        sut_dpdk_driver = self._ctx.sut_node.config.ports[0].os_driver_for_dpdk
+
+        for params in self.test_parameters:
+            frame_size = params["frame_size"]
+            num_descriptors = params["num_descriptors"]
+
+            driver_specific_testpmd_args: TestPmdParamsDict = {
+                "tx_ring": TXRingParams(descriptors=num_descriptors),
+                "rx_ring": RXRingParams(descriptors=num_descriptors),
+                "nb_cores": 1,
+            }
+
+            if sut_dpdk_driver == "mlx5_core":
+                driver_specific_testpmd_args["burst"] = 64
+                driver_specific_testpmd_args["mbcache"] = 512
+            elif sut_dpdk_driver == "i40e":
+                driver_specific_testpmd_args["rx_queues"] = 2
+                driver_specific_testpmd_args["tx_queues"] = 2
+
+            with TestPmd(
+                **driver_specific_testpmd_args,
+            ) as testpmd:
+                params["measured_mpps"] = self._transmit(testpmd, frame_size)
+                params["performance_delta"] = (
+                    float(params["measured_mpps"]) - float(params["expected_mpps"])
+                ) / float(params["expected_mpps"])
+                params["pass"] = float(params["performance_delta"]) >= -self.delta_tolerance
+
+        self._produce_stats_table(self.test_parameters)
+
+        for params in self.test_parameters:
+            verify(
+                params["pass"] is True,
+                f"""Packets forwarded is less than {(1 -self.delta_tolerance)*100}%
+                of the expected baseline.
+                Measured MPPS = {params["measured_mpps"]}
+                Expected MPPS = {params["expected_mpps"]}""",
+            )
-- 
2.49.0

