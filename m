Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5952CC4451C
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 14:49:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D17B40A6C;
	Fri, 17 Jul 2026 16:49:41 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8FA47406B4
 for <dev@dpdk.org>; Fri, 17 Jul 2026 16:49:39 +0200 (CEST)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-51c2b2c9eccso59892631cf.2
 for <dev@dpdk.org>; Fri, 17 Jul 2026 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1784299779; x=1784904579; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iRWx4j5se872ugDK536gzgj9d1C4lVwnbGHbzxGAS1Y=;
 b=JnD2IYqhNijftUIGJ7rD5oJHCdlYQckD4EdIa4T4tzYUVuc+1femrj0DLwhjKkBxBy
 /BJgbOQn/qIZaXAEnkihTJ9V2nOyLVwcqe5WQgdm2nLedgSjaX5yqylqrkNQrLpgQh0K
 f1V+s5pEp8oaV+pOCYyht/MCtBRekhMbiPPo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784299779; x=1784904579;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iRWx4j5se872ugDK536gzgj9d1C4lVwnbGHbzxGAS1Y=;
 b=AjutXas7ydxDAxsmKLXHYiB3r+iCsX8WC4fLRtH2eHs0/IJRh51yi+OApXzBkGEAUq
 Vl7xw+sadAgG2xy9d5d+drJwf+1DzF78PBPTg75e8GfkysBDA9kjAAeUGU9FNLzgknLA
 OwaveC+xF6Gxp9J9vPUEZSXIRGHgZlYpI5Eu1QZ5ALxHPrADaPDjPqVP/7ombFJpKOhp
 X4QHdU4VzjS3KM3Shv94pZYKg7HgIgdSU2MpOZGZYC0/kFJX2XR9I6mOw7giaDFJdKzC
 HhtEpK+ZGxb/mN+eiygfOu2u7oCjpehMzxG/vVA9qGGq3+FJNNbfxVYMwFsxb1N0lfBD
 /Ekg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6NBGKUOxGcLPjMbHGND21KaVzd4FOhB1asrPhq5O6I7JQN7sIzJkGcz6fB6I4vG4zByE=@dpdk.org
X-Gm-Message-State: AOJu0YwqSUZCcP7SWAHcfBCQ0O6Fo0dPJVh0dKBGbAitKQZz/sxKAPhF
 oKdd/qNxMrihZHH7bntK6bA8icdqoLeU3WAg5VjxhVqPREDuvcvjtYeiSdEDwzte48Q=
X-Gm-Gg: AfdE7ckWkc6ZhBxqvqbVycKA/SjVGuLYiDV9TJ3TIF87w0fIGGJ/BbxQm8jKUFoB8LE
 321+6InEP9RBuumY8fDEs3kqYrm1Za8rHB9+qL+dCvAALhNA6V+IQ9Cyx0fU6/+VJIZP7B4Hm6R
 ShI9rHWYoTPhkqj54lmjRjlbhGmEDdRmXV4iVisi6vvPdSrBNYTmng3yxMDRZdVNhSlFPwjoBSa
 8BD1DYBrTV5e4l8VFxvS8RBLAcUv2Qf5azYzrJAFJBX57TqaJPi1LTZ0w1HU2+IIJbZpF9uIPZH
 SAVJAYKXHyVHeqtSdRkKF98E6OVDNOHcvVxL7lLFPgZOcPj597NxL/8GMciuj7Wix9ydcbsHHA8
 LFGqCRNtRcUle3FQQYRqJkM6MGk2sWBl8exHeKYvEYig+XEJIFVXj/hil5qUlCqzdykFplM2Eep
 NZzLETGoaUSpGTTR9pHVXoDuiYerUZX7Ah4EvflzRbnu8=
X-Received: by 2002:ac8:7f53:0:b0:51c:1967:5091 with SMTP id
 d75a77b69052e-5213e28f192mr27451831cf.41.1784299778444; 
 Fri, 17 Jul 2026 07:49:38 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210:5d7f:246:cd51:1b62])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-521500c53fcsm13284361cf.29.2026.07.17.07.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:49:37 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: patrickrobb1997@gmail.com,
	luca.vizzarro@arm.com,
	dev@dpdk.org
Cc: knimoji@iol.unh.edu, llavoie@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: resolve variance in performance reporting
Date: Fri, 17 Jul 2026 10:49:33 -0400
Message-ID: <20260717144933.515139-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
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

Currently, the single core forward performance test suite reports
variable results with a standard deviation of ~10Mpps. Currently,
traffic is measured over 30 seconds a single time and the stats are
reported from this metric. This commit reduces the time traffic is sent
to only 5 seconds but runs numerous times to take an average and limit
variance to a standard deviation of ~1Mpps.

Bugzilla ID: 1969
Fixes: d77d7f04f24c ("dts: add single-core performance test suite")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 .../TestSuite_single_core_forward_perf.py     | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/TestSuite_single_core_forward_perf.py
index acdf8ae2f6..47cb592692 100644
--- a/dts/tests/TestSuite_single_core_forward_perf.py
+++ b/dts/tests/TestSuite_single_core_forward_perf.py
@@ -53,12 +53,13 @@ def set_up_suite(self):
         self.test_parameters = self.config.test_parameters
         self.delta_tolerance = self.config.delta_tolerance
 
-    def _transmit(self, testpmd: TestPmd, frame_size: int) -> float:
+    def _transmit(self, testpmd: TestPmd, frame_size: int, repetitions: int = 1) -> float:
         """Create a testpmd session with every rule in the given list, verify jump behavior.
 
         Args:
             testpmd: The testpmd shell to use for forwarding packets.
             frame_size: The size of the frame to transmit.
+            repetitions: The number of times to rerun the transmission.
 
         Returns:
             The MPPS (millions of packets per second) forwarded by the SUT.
@@ -71,13 +72,13 @@ def _transmit(self, testpmd: TestPmd, frame_size: int) -> float:
         )
 
         testpmd.start()
+        rx_avg: float = 0
 
-        # Transmit for 30 seconds.
-        stats = assess_performance_by_packet(packet=packet, duration=30)
-
-        rx_mpps = stats.rx_pps / 1_000_000
-
-        return rx_mpps
+        for _ in range(repetitions):
+            # Transmit for 5 seconds.
+            stats = assess_performance_by_packet(packet=packet, duration=5)
+            rx_avg += stats.rx_pps
+        return rx_avg / (repetitions * 1_000_000)
 
     def _produce_stats_table(self, test_parameters: list[dict[str, int | float]]) -> None:
         """Display performance results in table format and write to structured JSON file.
@@ -131,7 +132,9 @@ def single_core_forward_perf(self) -> None:
             with TestPmd(
                 **driver_specific_testpmd_args,
             ) as testpmd:
-                params["measured_mpps"] = round(self._transmit(testpmd, frame_size), 3)
+                params["measured_mpps"] = round(
+                    self._transmit(testpmd, frame_size, repetitions=5), 3
+                )
                 params["performance_delta"] = round(
                     (float(params["measured_mpps"]) - float(params["expected_mpps"]))
                     / float(params["expected_mpps"]),
-- 
2.54.0

