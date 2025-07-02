Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B87BC83038
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 05:28:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE8DB40684;
	Wed,  2 Jul 2025 07:28:05 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id CB3E6406BC
 for <dev@dpdk.org>; Wed,  2 Jul 2025 07:28:04 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7c5b8d13f73so372046085a.0
 for <dev@dpdk.org>; Tue, 01 Jul 2025 22:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751434084; x=1752038884; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZGVEpeaBSkjtv42GdMzrQO7p4AgPpajaHtpiGmCD6I=;
 b=P6pXdSYWXpVJSEe3vWELQHGdoEs+vOSJEuOwmDf/zZWAKn5oFHaGOI0NA8SaRV34gQ
 BynUvJnZCgk1vVzMzM5d8b0IKLuXGDPbANuj7rUKvJqfe26OBxWCYBJaHHTDU5ipTwv4
 LRZk3iV8bcrnvDDMReTzX1XjtmT7lQpXWPZgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751434084; x=1752038884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZGVEpeaBSkjtv42GdMzrQO7p4AgPpajaHtpiGmCD6I=;
 b=RRHk7SZRM+7Y0+w997xChIqDUeLK7J7ysS/OxLhWPWMmZe/mYTF/i+Xhe1FveaAysU
 3GyR+a8QMvpX+F5nrf9vAiWUAGIlBKzQvFDopwH0CTXbMM2g9vp6roq07jwczipG/EKd
 s1zDHjU9LiWyhulNjLzNP5+NEExYmqWgKxwQHS/QMLoG1uuX9jcLI4LUxfFKPJZDAT2e
 vLUuyemtB3Ybsg2OoYpLkcTNXbZ7Ap5t2IyfmO+LY3Y1L28eD2kyDgsQhFcegw4FLS7M
 wrSsvZPGGn+NLkplI+23Ag7DXaqtrgkWCpJTKmMClOkpdHFaYORIB2lkqxclDBVTXgYZ
 2Btw==
X-Gm-Message-State: AOJu0YwvMbyFbQD9MhK5HI2s2W/rcP1Uqwz3OPOWljiZH+JCBX+/5YiO
 DoQMii2KNkcYa03nK7k2HWKeVc1oRTLLuX69Mvyw0B6s038AvpGaXHLRqelgTs7cjRA=
X-Gm-Gg: ASbGnctQSZ7+jJHvQXKUnAAcZpB3lIt9VTSCIUV8Exq2+Og5kreo/qghpdbMuoEDWPQ
 CfDosplN37rbHZb3F3pMyd0hhzcQubf8Ac1h0NVEv1owRNXIaoX942NEWZpxCz8W41e6K+CkXGp
 xaYeBdETT/iTlrHNj/35+gAUseGmpbzRuOzC1/xXwqIYHCY4FWiW+ae3Wf8+v7aGVBTdLKbDcWq
 +TA1dVP3c2hrAAzMYqhEGUN6dghcpKtlyhV860lv7wSYMzsWDqCccRBJhw/Y2gBa/8/S+X36K90
 qp0w7JwO2h4MQkmyRsc4MqDBpTLXJ83ldpXekBcyjgt9FTOQvi9MwwpHJRzQxg4/
X-Google-Smtp-Source: AGHT+IEiwu0OfM9ORN6m6kbmyVQyjoRKxbfl+ZinHR7IJx1WkOae8vpSrsaXyaOSjLNLVwNcRDTYFg==
X-Received: by 2002:a05:620a:c44:b0:7d4:4aa6:a509 with SMTP id
 af79cd13be357-7d5c47990dcmr272853085a.48.1751434084079; 
 Tue, 01 Jul 2025 22:28:04 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1257::10e7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d45c0fe6dfsm469274185a.58.2025.07.01.22.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 22:28:03 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, nprattedev@gmail.com,
 mmahajan@iol.unh.edu, abailey@iol.unh.edu, Luca.Vizzarro@arm.com,
 thomas.wilks@arm.com, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v3 5/5] dts: add performance test functions to test suite API
Date: Wed,  2 Jul 2025 01:21:54 -0400
Message-ID: <20250702052154.381690-5-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702052154.381690-1-probb@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250702052154.381690-1-probb@iol.unh.edu>
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
 dts/configurations/tests_config.example.yaml | 12 +++++++
 dts/framework/test_suite.py                  | 34 ++++++++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/dts/configurations/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
index c011ac0588..c56951b2b0 100644
--- a/dts/configurations/tests_config.example.yaml
+++ b/dts/configurations/tests_config.example.yaml
@@ -3,3 +3,15 @@
 # Define the custom test suite configurations
 hello_world:
   msg: A custom hello world to you!
+single_core_forward_perf:
+  test_parameters:
+    - frame_size: 64
+      num_descriptors: 128
+      expected_mpps: 30.1234
+    - frame_size: 64
+      num_descriptors: 128
+      expected_mpps: 30.2341
+    - frame_size: 512
+      num_descriptors: 128
+      expected_mpps: 19.453376
+  delta_tolerance: 0.05
\ No newline at end of file
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 75d7a6eb6c..4044c85d4d 100644
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
@@ -254,11 +258,11 @@ def send_packets_and_capture(
             A list of received packets.
         """
         assert isinstance(
-            self._ctx.func_tg, CapturingTrafficGenerator
+            self._ctx.tg, CapturingTrafficGenerator
         ), "Cannot capture with a non-capturing traffic generator"
         # TODO: implement @requires for types of traffic generator
         packets = self._adjust_addresses(packets)
-        return self._ctx.func_tg.send_packets_and_capture(
+        return self._ctx.tg.send_packets_and_capture(
             packets,
             self._ctx.topology.tg_port_egress,
             self._ctx.topology.tg_port_ingress,
@@ -266,6 +270,27 @@ def send_packets_and_capture(
             duration,
         )
 
+    def assess_performance_by_packet(
+        self, packet: Packet, send_mpps: int, duration: int = 60
+    ) -> PerformanceTrafficStats:
+        """Send a given packet for a given duration and assess basic performance statistics.
+
+        Send `packet` and assess NIC performance for a given duration, corresponding to the test
+        suite's given topology.
+
+        Args:
+            packet: The packet to send.
+            send_mpps: The millions packets per second send rate.
+            duration: Performance test duration (in seconds).
+
+        Returns:
+            Performance statistics of the generated test.
+        """
+        assert isinstance(
+            self._ctx.tg, PerformanceTrafficGenerator
+        ), "Cannot run performance tests on non-performance traffic generator."
+        return self._ctx.tg.calculate_traffic_and_stats(packet, send_mpps, duration)
+
     def send_packets(
         self,
         packets: list[Packet],
@@ -275,8 +300,11 @@ def send_packets(
         Args:
             packets: Packets to send.
         """
+        assert isinstance(
+            self._ctx.tg, CapturingTrafficGenerator
+        ), "Cannot run performance tests on non-capturing traffic generator."
         packets = self._adjust_addresses(packets)
-        self._ctx.func_tg.send_packets(packets, self._ctx.topology.tg_port_egress)
+        self._ctx.tg.send_packets(packets, self._ctx.topology.tg_port_egress)
 
     def get_expected_packets(
         self,
-- 
2.49.0

