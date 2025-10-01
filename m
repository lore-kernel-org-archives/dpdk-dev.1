Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19C4CCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 23:19:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3467D40654;
	Thu,  2 Oct 2025 01:19:25 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 108CD40648
 for <dev@dpdk.org>; Thu,  2 Oct 2025 01:19:23 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8599c274188so41454485a.1
 for <dev@dpdk.org>; Wed, 01 Oct 2025 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759360762; x=1759965562; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBAXVtjBTrZU/cF35USQEulq0oyGobOMdR/sAABZ3bA=;
 b=jyLYMyOE/MGP0RTfMYCjFE3Do2AfWr+J0hAcf8AF0LVfbK59JaFxK2wat8bY8DYsy5
 8AsZDZNILA8a8KoSie85/f6E4xZXwwoqCZamgoZNr/q+n04DZ1wCdohf+O/69uuphMn+
 kQQSWowDbouoBZnQ1XsO9BxIOqajTiBIOM9eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759360762; x=1759965562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBAXVtjBTrZU/cF35USQEulq0oyGobOMdR/sAABZ3bA=;
 b=C6iXN0k3+u8zg1EwDrO0ImbzJx/2zhev4OpvrwDvdwFZUMKWNnRGRhjQvZV8r64RwV
 Ovg2CGuoTklEe3Ymb3XGkdMmbSw4D44QwWbh37lsX/j7N2LYSJbZ/4fO1EecXqJ1lmzx
 9U7tT/Ps0BxrjiPFtizUWeKtyiqnC3mIOzjTwo2/U9GSQwco0M4HW/YkGAzjKtUeTYNR
 QQpwqDnv3pS9E6K3KQmMWsY3JLXLxAsyQmsANWTol/tLPtNqNWG6U2ECGgyE4GrdgS1i
 Em1DGx8oyJO0nZU/Ae6JK3yfcbGDRHoPEmwZ/vSmeX/1FJCF6aViNfd1I+8OCwA8w0ni
 oNFA==
X-Gm-Message-State: AOJu0Yz3M8u709GIetJaj8ThSsVqkkGglKs5airG4/CvvjiotSoh2rl7
 ra5u06Rwkt0f1zyE2JgpXdwf2jUt5rDuG3vd3SEaZX26bM4KdButR8voCxPDb8pkUuw=
X-Gm-Gg: ASbGncvH1vJ02wC4bq5thR9gmRjcqtNHsjEudTzHYQtR3i78s/+gqWRwZMikIk2B+ct
 riJT7Ax2zBQpXCdbYv1jqKlON1+G5G3bXaiD5LMe78c82KTMoodyjPfyWev6a4DIRzjtYG7FXKQ
 rhemfPVVrXVT5UNocgcfXGmVFZInNuuPVxRv1eGW8eDg74ruGz42CLz4F8EHAfe1m9nMq5vRHZJ
 UKzs4HCqG/XfBkvduFybcy6Ayyvu+dCt8XqFWQ4wYFdqWcQrLcJHB/DmD67aHROrqafbl3DgJSZ
 sV/uKyNJ/hCEvRV50uGSBDAWtjB3x8yShQNSaxw97Mll+IAKfK6gkg4CNSh+tSDL+pCZBlgcfUi
 uHjKhUUdxUW212dszDxLHCsm5u1hjh4vizjmZVKxeUErXbumN
X-Google-Smtp-Source: AGHT+IGwCMBQcvCYZR9mq+1oIKHvU2IbJCWEiQpCRXJYyhF3qo1uBwPT2ZOQwj69rpnqicIHe4+5Xg==
X-Received: by 2002:a05:620a:290f:b0:868:54ba:7c42 with SMTP id
 af79cd13be357-8737415f07dmr762236185a.25.1759360762230; 
 Wed, 01 Oct 2025 16:19:22 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1257::10e7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8777aabeac7sm95224285a.64.2025.10.01.16.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 16:19:21 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 3/3] dts: add performance test functions to test suite API
Date: Wed,  1 Oct 2025 19:16:59 -0400
Message-ID: <20251001231659.2297751-4-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251001231659.2297751-1-probb@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20251001231659.2297751-1-probb@iol.unh.edu>
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

Provide functional performance method to run performance tests using a
user-supplied performance traffic generator. The single core performance
test is included, with some basic statistics checks verifying TG packet
transmission rates.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
---
 ...sts.TestSuite_single_core_forward_perf.rst |   8 +
 dts/configurations/tests_config.example.yaml  |  12 ++
 dts/framework/test_suite.py                   |  25 ++++
 .../TestSuite_single_core_forward_perf.py     | 139 ++++++++++++++++++
 4 files changed, 184 insertions(+)
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
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index c720106112..3816f4c921 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -38,6 +38,10 @@
     CapturingTrafficGenerator,
     PacketFilteringConfig,
 )
+from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+    PerformanceTrafficGenerator,
+    PerformanceTrafficStats,
+)
 
 from .exception import ConfigurationError, InternalError, SkippedTestException, TestCaseVerifyError
 from .logger import DTSLogger, get_dts_logger
@@ -269,6 +273,27 @@ def send_packets_and_capture(
             duration,
         )
 
+    def assess_performance_by_packet(
+        self, packet: Packet, duration: float, send_mpps: int | None = None
+    ) -> PerformanceTrafficStats:
+        """Send a given packet for a given duration and assess basic performance statistics.
+
+        Send `packet` and assess NIC performance for a given duration, corresponding to the test
+        suite's given topology.
+
+        Args:
+            packet: The packet to send.
+            duration: Performance test duration (in seconds).
+            send_mpps: The millions packets per second send rate.
+
+        Returns:
+            Performance statistics of the generated test.
+        """
+        assert isinstance(
+            self._ctx.perf_tg, PerformanceTrafficGenerator
+        ), "Cannot run performance tests on non-performance traffic generator."
+        return self._ctx.perf_tg.calculate_traffic_and_stats(packet, duration, send_mpps)
+
     def send_packets(
         self,
         packets: list[Packet],
diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/TestSuite_single_core_forward_perf.py
new file mode 100644
index 0000000000..eab82443b6
--- /dev/null
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -0,0 +1,139 @@
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
+from api.testpmd import TestPmd
+from api.testpmd.config import RXRingParams, TXRingParams
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
+        stats = self.assess_performance_by_packet(packet, duration=30)
+
+        rx_mpps = stats.rx_pps / 1000000
+
+        return rx_mpps
+
+    def _show_stats_table(self, test_parameters: list[dict[str, int | float]]) -> None:
+        """Create a testpmd session with every rule in the given list, verify jump behavior.
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
+        driver_specific_testpmd_args = {}
+
+        if sut_dpdk_driver == "mlx5_core":
+            driver_specific_testpmd_args["burst"] = 64
+            driver_specific_testpmd_args["mbcache"] = 512
+        elif sut_dpdk_driver == "i40e":
+            driver_specific_testpmd_args["rx_queues"] = 2
+            driver_specific_testpmd_args["tx_queues"] = 2
+
+        for params in self.test_parameters:
+            frame_size = params["frame_size"]
+            num_descriptors = params["num_descriptors"]
+
+            with TestPmd(
+                tx_ring=TXRingParams(descriptors=num_descriptors),
+                rx_ring=RXRingParams(descriptors=num_descriptors),
+                nb_cores=1,
+                **driver_specific_testpmd_args,
+            ) as testpmd:
+                params["measured_mpps"] = self._transmit(testpmd, frame_size)
+
+        self._show_stats_table(self.test_parameters)
+
+        for params in self.test_parameters:
+            self.verify(
+                params["measured_mpps"] >= params["expected_mpps"] * (1 - self.delta_tolerance),
+                f"""Packets forwarded is less than {(1 -self.delta_tolerance)*100}%
+                of the expected baseline.
+                Measured MPPS = {params["measured_mpps"]}
+                Expected MPPS = {params["expected_mpps"]}""",
+            )
-- 
2.49.0

