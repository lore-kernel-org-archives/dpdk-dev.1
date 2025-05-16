Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6D4C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 20:19:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDA854066D;
	Fri, 16 May 2025 22:19:10 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 158E940667
 for <dev@dpdk.org>; Fri, 16 May 2025 22:19:10 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7c5445cb72dso28768685a.3
 for <dev@dpdk.org>; Fri, 16 May 2025 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747426749; x=1748031549; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+RdxeoMpz/FEo6YXqrljVvAux5wJD3KjP3KWSuE5Ymk=;
 b=EiXhQ2cq4rvOecv5SmvCJjAR4LqGz9MLWQvhf3c0401H46wfQ9YQNpdWiKOnEZkBur
 v8FbARSEAW7YIE1dFIgYUdsUHzLVyPTerLDB2ggRPGxL4PpYWk1unJbTZ4vvBGkxgmFx
 WKmenmcq//6wLaBiGOyAp3H+kIyqFlYhpMMHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747426749; x=1748031549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+RdxeoMpz/FEo6YXqrljVvAux5wJD3KjP3KWSuE5Ymk=;
 b=Y5PoLgl5hEL0uggBG7K1hLnA5qHIdfysSreWt0DI87cuArV6vCzoE9kacJIFvjTRIA
 tNG/W/MmQ9NOLnRT4DgTVyOuQAt5dYWLI3uN+O5FyzD8SQG1mi81ddHhkQSwUqUfKBS+
 IBz5coa/Jy9jEYkwZVdWfStyhWtczBDtk0bkPzVcBQBKgyrHN17prOi5sSS3m0jeAdme
 CHj6+/JLEygf07ii7w4itUfe8sEU8DzMkBvltTVO0FDk0CdZZUWMedZuKA4bv6f4Wv9X
 A3Uo0zfwI5gLBV40Zn360lgmvgyOQyhvrSZhhWR6CfuGQoEvMR0X5NjbKreGEFHQ9qlB
 Ckng==
X-Gm-Message-State: AOJu0YzLXpsMBxWDNetfkWc/GjnLVuWFhxHWNyGa6p6VKoXwEPTVjlEy
 v4HssDSaOMtzMwiaBKsRHxOT4m48SjTw2ECdZsPKt/nfWFC3i2tbX9jjEM1B7f0sni28lzHLsOW
 HSk0g
X-Gm-Gg: ASbGncuokV+SJVXC/jEODYxBLr9oH1XrqcCHbnkTHdMv8J8hEdZVTpgRSRFXcNWsSOM
 2W38XF3Pu+AXj+GQzifXIoowkzOskh71alQpIaqyjEb0IUW5BbRWA6bRrA878zDPQticPiAgp7f
 iMO11SSvfUJsRoOcVrftZBCznarRFaOKDHRHAX3pAVH33h8gF7g0lmTsLESg6d8jll30/tKoYFi
 Rrf0GDMwPhdKxxUERd/oOjqgTJ4kRZHVYlZ2SCA5wOnthaxzPyup8YSZDnS8qBk0+FQ6R2rfQxb
 Z3Q7bU/WHrfarYHqcaO5x7kzeKTEZh6qlUsOZp2ikf536fWOJfMGPE9RGNRb5xs=
X-Google-Smtp-Source: AGHT+IG/Sh3kAX89NSP9hfICXrISAYMzP7pzfKCU+FTHrE7qWEuKh5pkw39yv0KeEiKjafc0BpGnCA==
X-Received: by 2002:a05:620a:890b:b0:7c5:ac06:af8 with SMTP id
 af79cd13be357-7cd4674ba6dmr289858385a.9.1747426749320; 
 Fri, 16 May 2025 13:19:09 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467d93d5sm159673685a.31.2025.05.16.13.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 13:19:08 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: stephen@networkplumber.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com,
 paul.szczepanek@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, thomas.wilks@arm.com,
 probb@iol.unh.edu
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC v2 6/6] dts: add performance test functions to test suite api
Date: Fri, 16 May 2025 16:18:34 -0400
Message-ID: <20250516201834.626206-7-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250516201834.626206-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
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

Provide functional performance method to run performance tests using a
user-supplied performance traffic generator. The single core performance
test is included, with some basic statistics checks verifying TG packet
transmission rates.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 dts/configurations/tests_config.example.yaml |  5 ++
 dts/framework/test_suite.py                  | 27 ++++++++++
 dts/tests/TestSuite_single_core_perf.py      | 56 ++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 dts/tests/TestSuite_single_core_perf.py

diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index 38cf7a0dce..d3d867ae18 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -2,3 +2,8 @@
 
 hello_world:
   msg: A custom hello world to you!
+single_core_perf:
+  tx_rx_descriptors: [128, 512, 2048]
+  frame_sizes: [64, 128]
+  expected_throughput: 40
+  # rate: gbps | mbps
\ No newline at end of file
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 507df508cb..a89faac2d5 100644
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
 
 from .exception import ConfigurationError, InternalError, TestCaseVerifyError
 from .logger import DTSLogger, get_dts_logger
@@ -266,6 +270,26 @@ def send_packets_and_capture(
             duration,
         )
 
+    def assess_performance_by_packet(
+        self, packet: Packet, duration: int = 60
+    ) -> PerformanceTrafficStats:
+        """Send a given packet for a given duration and assess basic performance statistics.
+
+        Send `packet` and assess NIC performance for a given duration, corresponding to the test
+        suite's given topology.
+
+        Args:
+            packet: The packet to send.
+            duration: Performance test duration (in seconds)
+
+        Returns:
+            Performance statistics of the generated test.
+        """
+        assert isinstance(
+            self._ctx.perf_tg, PerformanceTrafficGenerator
+        ), "Cannot run performance tests on non-performance traffic generator."
+        return self._ctx.perf_tg.generate_traffic_and_stats(packet, duration)
+
     def send_packets(
         self,
         packets: list[Packet],
@@ -275,6 +299,9 @@ def send_packets(
         Args:
             packets: Packets to send.
         """
+        assert isinstance(
+            self._ctx.perf_tg, CapturingTrafficGenerator
+        ), "Cannot run performance tests on non-capturing traffic generator."
         packets = self._adjust_addresses(packets)
         self._ctx.func_tg.send_packets(packets, self._ctx.topology.tg_port_egress)
 
diff --git a/dts/tests/TestSuite_single_core_perf.py b/dts/tests/TestSuite_single_core_perf.py
new file mode 100644
index 0000000000..2e1d3c1ae8
--- /dev/null
+++ b/dts/tests/TestSuite_single_core_perf.py
@@ -0,0 +1,56 @@
+"""Single core performance test suite."""
+
+
+from framework.params.testpmd import RXRingParams, TXRingParams
+from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.test_suite import TestSuite, perf_test, BaseConfig
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Raw
+
+class Config(BaseConfig):
+    """Performance test metrics to be compared by real-world results."""
+
+    #: Expected results
+    tx_rx_descriptors: list[int]
+    frame_sizes: list[int]
+    expected_throughput: int
+    
+
+class TestSingleCorePerf(TestSuite):
+    """Single core performance test suite."""
+
+    config: Config
+
+    frame_sizes: list[int]
+    tx_rx_descriptors: list[int]
+    expected_throughput: int
+
+
+    def set_up_suite(self):
+        self.frame_sizes = self.config.frame_sizes
+        for frame_size in self.frame_sizes:
+            self.verify(frame_size >= 34,
+                "Provided frame size is too small. (Space needed for Ether()/IP())"
+            )
+        self.tx_rx_descriptors = self.config.tx_rx_descriptors
+        self.expected_throughput = self.config.expected_throughput
+
+    @perf_test
+    def test_perf_nic_single_core(self) -> None:
+        """Prototype test case."""
+        for frame_size in self.frame_sizes:
+            for descriptor_size in self.tx_rx_descriptors:
+                with TestPmdShell(
+                    tx_ring=TXRingParams(descriptors=descriptor_size),
+                    rx_ring=RXRingParams(descriptors=descriptor_size)
+                ) as testpmd:
+                    packet = Ether() / IP() / Raw(load="x" * (frame_size - 14 - 20))
+
+                    testpmd.start()
+                    stats = self.assess_performance_by_packet(packet, duration=60)
+                    print(stats)
+                    self.verify(
+                        stats.tx_expected_bps == 40, "Expected output does not match recorded output."
+                    )
\ No newline at end of file
-- 
2.47.1

