Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40B3CD6E56
	for <dpdk-dev@archiver.kernel.org>; Sun, 31 May 2026 18:01:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5576402AF;
	Sun, 31 May 2026 20:01:23 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 8B33D4025F
 for <dev@dpdk.org>; Sun, 31 May 2026 20:01:22 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-3042a388168so5520528eec.1
 for <dev@dpdk.org>; Sun, 31 May 2026 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780250481;
 x=1780855281; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YmvYwnc7o8cmSrZZ4O26pphQAsr4Mw3pfKcN+aDBsjM=;
 b=dC8bceJlsSSfPrm3JllIUI10TS7KMpe7ZpQt2OS5Oia4zkA2/am3/hgYa8x/M82iKz
 0/zuYGKtBrtYwrLn9LlRezn7Djkj4LR4Hgu8cql5ytC4x9TboI4uBptyhkVN6b3ros2I
 4p3/unI0AN8V3guuNlNwIRQkyaiv/KJq+aU//fEzTMoeaLKkkuhlkYYWx3/VNIcJgsnu
 C7GZE/UmJ82nh0vmp8ti90Aocg/iBuwn28LVgdPYkZG4SzcBMvKgYjw0QUpBLhpN1OpB
 CiOA766duaUnp4drx2QClmDGVp33tzxEZK3daIaNUy2+EoJ9sXZReNdTZzgopvtkzvbs
 RYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780250481; x=1780855281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmvYwnc7o8cmSrZZ4O26pphQAsr4Mw3pfKcN+aDBsjM=;
 b=byMyxSBkvyB6HKK7ZX4C21xMGBiSgsWyxAme3V8hyt2r8IKsP2jWeZpQqWgXAIjUD7
 ISgN8wARIU3ytv7J+h4n4NEZqo0GDwJJoAIfA4WGqh0QNxQ8mG9orpdo2+vvbh+enHMW
 i5O0voiOvcWn54ePr8gdLZcptrrwZilloc6bfgEzMBgdVlv1407LUvDxhUy4fluv32iw
 06gDimPg8zfNjucS1pqe9gjHEkjxWVWSbkpTuKfh2WY0aHRinUU1S7TDhD/hexaoJUpW
 JU+3BUdQIoP/7SozsLpvg1FQEUw9gjbhlNnIhRw0N7vnLD0WkISbhMiYmv9yuRQQn1rf
 PvHQ==
X-Gm-Message-State: AOJu0YzjKNJXOSi8XQqKnV7EVd+iY9+BbUJ6AvveXrEFO9iY+I6uOR4h
 +fIRfQe73/dZ+mBtgwzWkErIa1RndA7Cmxxg/5HRE8PIBGMKuM/Fya6pBHc5J14oTxaMvgWajjQ
 d5mBL
X-Gm-Gg: Acq92OGlZIREmE4yFYlFXd6AdgZTnbcc/yD3xSEAXS/bn96AiNB5TvuitKupPbSF1Ek
 yysmeJNRWgXaNJouBGkWcSt6sdjcJcGWk+TsfzhAjkJkqXPb9Lsw1JzD2OlQA1QTvYntAFR5lAU
 RzROy+JmFRUgL3584XdhlbwLS7IflgFKtKHqqvUI+b0c/V+lh4NIott94UqK86MISBX7YI7y45m
 vuFsV40S/WweIcV3eJVo3K9YAr1c9MY/kUmP98jRtA/SPF8e2AngHR2A48EVDCxAabGOmlV1Ex9
 Pc9fny90yRv7PoZHXYfGFpxNMJ7xKWlBe0PIQZZG5rCQGAf5u43KwwT+Jxi6xyI74semiVboo14
 BC0OWB6mJI1crPmNYi2w3rObExtmIvo1oOD2NVIOorVnX+5mKOmA7GmSyT+xaRM4iJmSyEOWO/Y
 nEhkIXPE5I0ujTmA4dViKBpqsoy4aOpPbkXh+U01BR1rBpbee3GXGSafy/MXsxxIROPTVUjaDa
X-Received: by 2002:a05:7301:1006:b0:304:70d0:4f03 with SMTP id
 5a478bee46e88-304fb1d2db6mr2921282eec.6.1780250481242; 
 Sun, 31 May 2026 11:01:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c312csm7170703eec.6.2026.05.31.11.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 11:01:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Luca Boccassi <bluca@debian.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] test/latency: fix intermittent failure on slow platforms
Date: Sun, 31 May 2026 11:01:18 -0700
Message-ID: <20260531180118.274308-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The forwarding loop was bounded by a fixed interval of 0.5ms
but on slow or emulated platforms with a low-frequency timebase
(e.g. RISC-V rdtime) this fails because the loop only ran once.
The test needs two iterations to get any samples.

Rearrange the forwarding loop so that a minimum number of iterations
are required. The loop still has an upper bound on packets and time
interval which is expanded to 10 ms.

If no samples are collected, mark the test as skipped.
Refactor the forwarding loop test so that cleanup happens on
failure.

Reported-by: Luca Boccassi <bluca@debian.org>
Fixes: b34508b9cbcd ("test/latency: update with more checks")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_latencystats.c | 75 ++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 29 deletions(-)

diff --git a/app/test/test_latencystats.c b/app/test/test_latencystats.c
index e0483e3e4f..76498b66b4 100644
--- a/app/test/test_latencystats.c
+++ b/app/test/test_latencystats.c
@@ -16,6 +16,10 @@
 
 #define NUM_STATS 5
 #define LATENCY_NUM_PACKETS 10
+#define LATENCY_FORWARD_ITERATIONS 10000u
+#define LATENCY_FORWARD_MS 10u
+#define MIN_ITERATIONS	10u
+
 #define QUEUE_ID 0
 
 static uint16_t portid;
@@ -140,28 +144,13 @@ static void test_latency_ring_free(void)
 	test_vdev_uninit("net_ring_net_ringa");
 }
 
-static int test_latency_packet_forward(void)
+static int test_forward_loop(uint16_t portid, struct rte_mbuf *pbuf[LATENCY_NUM_PACKETS])
 {
-	unsigned int i;
-	int ret;
-	struct rte_mbuf *pbuf[LATENCY_NUM_PACKETS] = { };
-	struct rte_mempool *mp;
-	char poolname[] = "mbuf_pool";
+	unsigned int i, iters = 0;
 	uint64_t end_cycles;
 	struct rte_metric_value values[NUM_STATS] = { };
 	struct rte_metric_name names[NUM_STATS] = { };
-
-	ret = test_get_mbuf_from_pool(&mp, pbuf, poolname);
-	if (ret < 0) {
-		printf("allocate mbuf pool Failed\n");
-		return TEST_FAILED;
-	}
-	ret = test_dev_start(portid, mp);
-	if (ret < 0) {
-		printf("test_dev_start(%hu, %p) failed, error code: %d\n",
-			portid, mp, ret);
-		return TEST_FAILED;
-	}
+	int ret;
 
 	ret = rte_latencystats_get_names(names, NUM_STATS);
 	TEST_ASSERT((ret == NUM_STATS), "Test Failed to get metrics names");
@@ -170,37 +159,65 @@ static int test_latency_packet_forward(void)
 	TEST_ASSERT(ret == NUM_STATS, "Test failed to get results before forwarding");
 	TEST_ASSERT(values[4].value == 0, "Samples not zero at start of test");
 
-	/*
-	 * Want test to run long enough to collect sufficient samples
-	 * but not so long that scheduler decides to reschedule it (1000 hz).
-	 */
-	end_cycles = rte_rdtsc() + rte_get_tsc_hz() / 2000;
-	do {
+	/* Want test to run long enough to collect sufficient samples */
+	end_cycles = rte_rdtsc() + rte_get_tsc_hz() / MS_PER_S * LATENCY_FORWARD_MS;
+	for (i = 0; i < LATENCY_FORWARD_ITERATIONS; i++) {
 		ret = test_packet_forward(pbuf, portid, QUEUE_ID);
 		if (ret < 0)
 			printf("send pkts Failed\n");
-	} while (rte_rdtsc() < end_cycles);
+
+		if (++iters >= MIN_ITERATIONS && rte_rdtsc() >= end_cycles)
+			break;
+	}
 
 	ret = rte_latencystats_get(values, NUM_STATS);
 	TEST_ASSERT(ret == NUM_STATS, "Test failed to get results after forwarding");
 
+	if (values[4].value == 0) {
+		printf("No latency samples collected after %u iterations, skipping\n", iters);
+		return TEST_SKIPPED;
+	}
+
 	for (i = 0; i < NUM_STATS; i++) {
 		uint16_t k = values[i].key;
 
-		printf("%s = %"PRIu64"\n",
-		       names[k].name, values[i].value);
+		printf("%s = %"PRIu64"\n", names[k].name, values[i].value);
 	}
-
+	fflush(stdout);
 	TEST_ASSERT(values[4].value > 0, "No samples taken");
 
 	TEST_ASSERT(values[0].value < values[1].value, "Min latency > Avg latency");
 	TEST_ASSERT(values[0].value < values[2].value, "Min latency > Max latency");
 	TEST_ASSERT(values[1].value < values[2].value, "Avg latency > Max latency");
+	return TEST_SUCCESS;
+}
+
+static int test_latency_packet_forward(void)
+{
+	struct rte_mempool *mp = NULL;
+	char poolname[] = "mbuf_pool";
+	struct rte_mbuf *pbuf[LATENCY_NUM_PACKETS] = { };
+	int ret;
+
+	ret = test_get_mbuf_from_pool(&mp, pbuf, poolname);
+	if (ret < 0) {
+		printf("allocate mbuf pool Failed\n");
+		return TEST_FAILED;
+	}
+
+	ret = test_dev_start(portid, mp);
+	if (ret < 0) {
+		printf("test_dev_start(%hu, %p) failed, error code: %d\n",
+			portid, mp, ret);
+		ret = TEST_FAILED;
+	} else {
+		ret = test_forward_loop(portid, pbuf);
+	}
 
 	rte_eth_dev_stop(portid);
 	test_put_mbuf_to_pool(mp, pbuf);
 
-	return (ret >= 0) ? TEST_SUCCESS : TEST_FAILED;
+	return ret;
 }
 
 static struct
-- 
2.53.0

