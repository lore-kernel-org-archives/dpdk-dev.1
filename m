Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B23CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 01:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDFB2402E6;
	Thu, 23 Oct 2025 03:32:15 +0200 (CEST)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7FF65402E3
 for <dev@dpdk.org>; Thu, 23 Oct 2025 03:32:11 +0200 (CEST)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-893c373500cso28147285a.0
 for <dev@dpdk.org>; Wed, 22 Oct 2025 18:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761183131; x=1761787931; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HF4yU45YqzxcjXG6APARqXiwD3DOqi1shdTiKLRC7rA=;
 b=Z74BQ/y7kGr49Lfa4tS7R50RINuDN1tsEUy+uG/jxZyUU0wjhHGIsrZ79txoy5exlr
 xt7qJ+lrIPyZNyIZugNue/EpR9QIxkH8C6PYWyoCn4WLM0IvmVkbPo3TvZ4N5zz7RGsg
 gfC82xUauPOe06pbO1/WDV+ntP2/9zKtH8gG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761183131; x=1761787931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HF4yU45YqzxcjXG6APARqXiwD3DOqi1shdTiKLRC7rA=;
 b=MDn4+Y1N6hFdWF2aVxIYEnuIVd3aDc6GGfFUE8adguPq6rQIRyxzcXOmJNablDcJL9
 oXnKRKq1iTJN1CNuFa7Idrgw0ODAgNyDdhQgFYSDNqxBE3OdHExiLt1HVknZTqYzDga1
 GkTs31ZlmCrBlu57QUrW2KJqQ5a+Ee4A84iQ+lHNa+F0GQVTG6UMKEkhjGmXjYskD0IJ
 Prusp6yGfcrfADlEI4GtosNXrflBL4qBzZbuzcvt7Ly4eGx5EjlmVFkYjQkXJiW9t5Cn
 JSVAvh74DD4MSwrmWg3ckCJfRRknw56QIu/NmjSm+DNH8tDilzqfDP735jYuoI0vWhcR
 ZxZw==
X-Gm-Message-State: AOJu0YyhR5EzRZFl/a6IGi8v98VUYH1F+48dInal2dxwFLP6EGfuPbku
 rmnrW+XtlJ7d6x8U9Cyza21mJwrW9KudICrTklTTtQsXkIdaABx3iNG2lzMiaOlXcfQ=
X-Gm-Gg: ASbGncvJfNtyOXHamTr2er8v4Si09hem58vtp3q5KJhCbUZqO/tEzWw4r5ZfWDz2VYF
 awxxwO7ofrw5WwOe4cUsLZXmDwKSJwzClrSjt9A6crA9WQHkd3/tOD5/0/86Npg5SbDA/yGJxqC
 wXPDkDHseI5Vbr0RWE/oK2ii8FjWvJURSpm1QapLTD4pGONOcW25TWGB7zv+SLII+yZfSwdA1bl
 C3svtnMtlA9Xo/XuYhVMehs14g6/HnN3n99fTdEfs8P9S5BIAZAn288ysLSqw1HHkD+9OCq5TVf
 KGwyaKDa3nOgaWPrr07HjuhaVAZqd6VZIfDQkaUU3bctUcE5sMJDYAcd7O3/AcSbPH5BVDe2U3X
 IBw8bn1JDhNpjYlS33dhfZv2ea4+zbrmx2jme+4dfpKwDHq0+UPQQXfSj2AHTgxsZuHxHmPAI82
 1zm+VkhBVMV9F/ArQsql5xsizq6ORZky8Z9p1pGjml
X-Google-Smtp-Source: AGHT+IFz6YKVNZ9crq4ayc4JmEZI6frVRzObSTeuOycjinpKVJc+K5fmCwAmJDAnOZ8ejAQFjR73FA==
X-Received: by 2002:a05:620a:29cb:b0:890:e60c:de2c with SMTP id
 af79cd13be357-89adfa0210fmr474991485a.14.1761183130667; 
 Wed, 22 Oct 2025 18:32:10 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu
 ([2606:4100:3880:1271:8c70:5b9e:ecd3:14e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c12546031sm56080085a.56.2025.10.22.18.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 18:32:10 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.ed, abailey@iol.unh.edu,
 Paul.Szczepanek@arm.com, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v5 3/3] dts: add performance test functions to test suite API
Date: Wed, 22 Oct 2025 21:30:49 -0400
Message-ID: <20251023013049.1368129-4-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251023013049.1368129-1-probb@iol.unh.edu>
References: <20251001231659.2297751-1-probb@iol.unh.edu>
 <20251023013049.1368129-1-probb@iol.unh.edu>
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
---
 ...sts.TestSuite_single_core_forward_perf.rst |   8 +
 dts/api/packet.py                             |  35 +++-
 dts/api/test.py                               |  32 ++++
 dts/configurations/tests_config.example.yaml  |  12 ++
 .../TestSuite_single_core_forward_perf.py     | 151 ++++++++++++++++++
 5 files changed, 237 insertions(+), 1 deletion(-)
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
index 0000000000..ceea6f25e5
--- /dev/null
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -0,0 +1,151 @@
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
+            testpmd: The testpmd shell to use for forwarding packets
+            frame_size: The size of the frame to transmit
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
+        rx_mpps = stats.rx_pps / 1000000
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
+            * Transmit from the traffic generator's ports 0 and 1 at above the expect
+            * Forward on TestPMD's interfaces 0 and 1 with 1 core.
+
+        Verify:
+            * The resulting MPPS forwarded is greater than expected_mpps*(1-delta_tolerance)
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
+                ) / float(params["measured_mpps"])
+                params["pass"] = float(params["measured_mpps"]) >= float(
+                    params["expected_mpps"]
+                ) * (1 - self.delta_tolerance)
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

