Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F7C369D5
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 19:41:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 098C14065F;
	Wed, 23 Apr 2025 21:40:56 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id EE01340395
 for <dev@dpdk.org>; Wed, 23 Apr 2025 21:40:52 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-47745b679a4so220851cf.1
 for <dev@dpdk.org>; Wed, 23 Apr 2025 12:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745437252; x=1746042052; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5UL6C66X0HaGXaOXsi2g/xdZhYn3mAvpKEKVPj0/2I=;
 b=FMV4tvneN+EzL5IuXXlWsme8IJ1Bg/aDerv35wOk/R9gjnrlVnAxyazWD+kSA8Mu1L
 yiU6sICgi10qYxkd4EXSvxwRVr5ZnaR3kNjQ49V9Dqoc7D919z4fbnxm2Pgu6kQbPe6c
 fe+8Xt2xR9IBikNRD/QvV/sNr8xojUrUaDmqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745437252; x=1746042052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5UL6C66X0HaGXaOXsi2g/xdZhYn3mAvpKEKVPj0/2I=;
 b=icS86GPLHNC5emfCtn2FS9MbmBgFR85FdTD+vh4FFwjCPYUfTW8zK7XxM/jHmF6MHr
 +Z9q9r3NrZbjfyX16eqvbYzB/HKanp+xg5SrD/uv4Rk/L3La5iqsgR7GD8YWry2FKakj
 c3AGHgxUMWsJVfx8UCdBqA9zWs0xxfO2I2nW3+BqXe5ntYpUMAHnREEZIk9Gi20ISLQk
 Cqf+gQjPuKQ6dVjjNUy+17iYSnow9nnvGY5K8PXYoo3ytXYlSBQ/R5AlsB5oT861ELxL
 syqw7JMPMLmt9gYORHqPlmNX9KfI72yzNB9qm/FlzeEGu/SoZOcJkH9FIZHcu7E6R/53
 KNPg==
X-Gm-Message-State: AOJu0YwPWl2Y7HiJH5FaGd0BDtYjMPCtCx8TJA7GBvGsnvIp7HwP3acJ
 h6jZdmQmjVNhXhRywznTZisUkpTa3pZnDCVTdUKdMLQ8iMMQYB91izT4b5luduY=
X-Gm-Gg: ASbGncuES+jY8Bg0WeddJfG2HAsKbMK4HumKOadZVwXCC+XD6B5BZdCWxYQni7FHSRt
 Z2EW/M6+YO2EGqR2WhKVQuDWOWn/WUsBP35gMIYSS3rImllvNi74rd96FjaePG38B6zLvNMVll3
 IArbfIFWtfWPNNnU3YuEGk56dOxexVWYf8hfquTKwIZ3OBU+iI7e9M/UR7uXCXOQq7p8+AvITas
 9AKxJrrarsKdvQFPdgPXOy/fRCGKl8WkWHZqtPwAlkf0vrM9xzBIjdOwV7fPFzqbXApFC47NcyE
 1GxV+RlcsbWdXIdOk9y3LmFuT/Mne22x719KOXAxRFSJDYm+A4CDmARI3Wz4Bki4uIul9F+FRk9
 IQor86ECc1NKT7wDT
X-Google-Smtp-Source: AGHT+IFXyQtPpfOmF9T0qHxFLjOcFmkgSDatMojC+SHjVZyV6zAy2XmiMW4Z25c5+lPzWysWNM2etA==
X-Received: by 2002:ac8:5885:0:b0:472:2122:5a37 with SMTP id
 d75a77b69052e-47d1be7a34emr26623111cf.4.1745437252344; 
 Wed, 23 Apr 2025 12:40:52 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ae9cf9f7dsm71635691cf.74.2025.04.23.12.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 12:40:52 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: ian.stokes@intel.com, yoan.picchi@foss.arm.com, probb@iol.unh.edu,
 paul.szczepanek@arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net,
 luca.vizzarro@arm.com, thomas.wilks@arm.com, dmarx@iol.unh.edu,
 stephen@networkplumber.org
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC Patch v1 5/5] dts: add performance test functions to test suite
 api
Date: Wed, 23 Apr 2025 15:40:11 -0400
Message-ID: <20250423194011.1447679-6-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250423194011.1447679-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
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
 dts/framework/test_suite.py             | 27 +++++++++++++++++++++++++
 dts/tests/TestSuite_single_core_perf.py | 24 ++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 dts/tests/TestSuite_single_core_perf.py

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
index 0000000000..31a8c8608f
--- /dev/null
+++ b/dts/tests/TestSuite_single_core_perf.py
@@ -0,0 +1,24 @@
+"""Single core performance test suite."""
+
+from scapy.layers.inet import IP
+from scapy.layers.l2 import Ether
+from scapy.packet import Raw
+
+from framework.remote_session.testpmd_shell import TestPmdShell
+from framework.test_suite import TestSuite, perf_test
+
+
+class TestSingleCorePerf(TestSuite):
+    """Single core performance test suite."""
+
+    @perf_test
+    def test_perf_test(self) -> None:
+        """Prototype test case."""
+        with TestPmdShell() as testpmd:
+            packet = Ether() / IP() / Raw(load="x" * 1484)  # 1518 byte packet.
+
+            testpmd.start()
+            stats = self.assess_performance_by_packet(packet, duration=5)
+            self.verify(
+                stats.tx_expected_bps == 40, "Expected output does not patch recorded output."
+            )
-- 
2.47.1

