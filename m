Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AAFCCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 22:37:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A67FC40E1D;
	Wed,  5 Nov 2025 23:37:45 +0100 (CET)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id 881BF40E13
 for <dev@dpdk.org>; Wed,  5 Nov 2025 23:37:44 +0100 (CET)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-87fc4d29301so5744276d6.2
 for <dev@dpdk.org>; Wed, 05 Nov 2025 14:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762382264; x=1762987064; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1f6EYsDS3x3p4VUpEhQ9Ar7s87hKMaTHQ9YT04uyts=;
 b=RxA+uJJ2c8cZatCiFa1TwUj6GYYNyhAX46k/J1P4lw7OmNZ4McNeDECy4IuvqGe2bi
 uIbt/3ipX/IG5Ap1/Ou9YH7vyPNINkw7ehvmr9cCp8VvopzYR5iA2fOpocf/cX/E0q1H
 ePH7MlNnLiov6YI8oR4+D53cKOEONf/+SCqog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762382264; x=1762987064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1f6EYsDS3x3p4VUpEhQ9Ar7s87hKMaTHQ9YT04uyts=;
 b=VFZjZKzNHN+aKMHvyPiGVj/QyU8MGTUQ5rPG2M5mQLIySXmjYBmagscdoBSTqj9tRK
 NNcVDLnM0URD9Q7DJohMyMpme5r4T0HXZl6QCU/nrlu6f41n7ZwgptxEF22B23gOL4CG
 SEyMXHYCmNIkEZsTZRzSw9RjDEEXE+LtdPXsj4A6LIlSDkUI+3/gWAlarUky6g9VebvN
 c+IoIIh7A9rMg1Gr7P635UbU8Bw7nw5qZv1l7YVoYWPGbKRBzeM6azhBWLC02K4CyHTP
 I7ovEtiBvKEzZRUSDNXIF9mb0tTcX2UbKekxCLvzfOiW3Dk9ESinZaNzlNIhnO29Kx81
 IlIA==
X-Gm-Message-State: AOJu0YyQKeZA5gKxIgaqOkXl/w/dpg7ojKe4STYhvrXtPwbgNrxJWS/z
 8Ne1ADbntdKMKA3jT+d1oFfI+ShgfR+bW62tIBX+YxvX7l5U60DLFQheETycsoC5yaE=
X-Gm-Gg: ASbGnctLVItSHqGpi8zuwuBxLzQw3xnVfrC3Arf6g9H4CdE5wYDzkbuNJz66+ycALMo
 Qvl0YOHybsxsIfO/G3Go3E1p7JJMeTcUPtr9sdZjClrxs/aIM36vAGb9qzbv8t+8slamSJp0D9X
 3Za3wjJ115I7nRc8qHJMgRai4PyahteYW3IMMUMr2mKS51RVoBAqtI5SUOiBXs04Vx89MyMWto0
 6l5f3Ua7r+jDwQlFir8YX7wGtAmjcx0STFHQ3M1oVYZT0NaeZF90WVKa8Aj3V3kplfU/9fyhF+G
 5kMLaLxdV+Mhd+QcZpaLabGHiatxuQvcfHSv9DyTdf8I3FvGHA4HCKYvxXUQcuNRep8OdPWcbPK
 9i4ZQaSuTtL9rzIjM4RqCxrczmYtey8972pA4AS83dcMjvCmkKF6PqLkjaotZhU837Ukz3eA6br
 iEvinX1oT+A/c=
X-Google-Smtp-Source: AGHT+IFfvpeI0RPKAkax4SVpmnF4I2kljBe35mM3h0NM5J4Kp4VpROlkSHcbBksDqy4U4AjtfchwbA==
X-Received: by 2002:a05:622a:4a0a:b0:4ec:ef85:cfb2 with SMTP id
 d75a77b69052e-4ed7267da56mr74241811cf.78.1762382263689; 
 Wed, 05 Nov 2025 14:37:43 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed813da43asm4883981cf.27.2025.11.05.14.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 14:37:42 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v6 3/3] dts: add performance test functions to test suite API
Date: Wed,  5 Nov 2025 17:36:28 -0500
Message-ID: <20251105223628.1659390-4-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251105223628.1659390-1-probb@iol.unh.edu>
References: <20251023013049.1368129-1-probb@iol.unh.edu>
 <20251105223628.1659390-1-probb@iol.unh.edu>
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
not forward a mpps count within 5% of the given baseline.

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
 .../TestSuite_single_core_forward_perf.py     | 149 ++++++++++++++++++
 5 files changed, 235 insertions(+), 1 deletion(-)
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
index f58c82715d..11265ee2c1 100644
--- a/dts/api/test.py
+++ b/dts/api/test.py
@@ -6,9 +6,13 @@
 This module provides utility functions for test cases, including logging, verification.
 """
 
+import json
+from datetime import datetime
+
 from framework.context import get_ctx
 from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger
+from framework.testbed_model.artifact import Artifact
 
 
 def get_current_test_case_name() -> str:
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
index c011ac0588..167bc91a35 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -3,3 +3,15 @@
 # Define the custom test suite configurations
 hello_world:
   msg: A custom hello world to you!
+single_core_forward_perf:
+  test_parameters: # Add frame size / descriptor count combinations as needed
+    - frame_size: 64
+      num_descriptors: 512
+      expected_mpps: 1.0 # Set millions of packets per second according to your devices expected throughput for this given frame size / descriptor count
+    - frame_size: 64
+      num_descriptors: 1024
+      expected_mpps: 1.0
+    - frame_size: 512
+      num_descriptors: 1024
+      expected_mpps: 1.0
+  delta_tolerance: 0.05
\ No newline at end of file
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

