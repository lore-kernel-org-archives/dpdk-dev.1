Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D2EC021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 21:22:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 101FF4066C;
	Thu, 13 Feb 2025 22:22:14 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 302974064E
 for <dev@dpdk.org>; Thu, 13 Feb 2025 22:22:10 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-219f8263ae0so22811795ad.0
 for <dev@dpdk.org>; Thu, 13 Feb 2025 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739481729;
 x=1740086529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nfzftuol9TKasfULCQivt7OsevKxD6HzWoJJXbL/TuA=;
 b=EnfX7AQBJd9HrikYFj9AfYI/9MLZZWesA63yf/9hqG8LgxJUHVXHPrzGSTBGKAR+MC
 n1aIgjHx/ARrU1S+Ey8k3EYqzOv4kLz0kyroB6NfreIAT8/vyDc00B9kBtA7K9Ybu6Zp
 vZ5HGwHJLMkoZefTQGoRf5AhbiaRPX4BCmvR7/2LY5Ka0MkEEvMn9e5ll+uUtCOnnWhi
 4h2KhjDn/vtkOsMRZuKIp8txuoQ2ThY6C4+4OE9oOFaMgOZg17DHHuVjBXp0jZvFc18I
 GS7k/Y8susd5okmfDRpLqt2S8aos+xIKZQJP9eI9dcyrDl6eH+jaaqKc6IbMQFONsz8d
 d02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739481729; x=1740086529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nfzftuol9TKasfULCQivt7OsevKxD6HzWoJJXbL/TuA=;
 b=onxnTpdCN0Pu2apN2iWgaV4VT0uf6d1LW1aBhplo/Hdafln+RqZOh9EaytkF+Q1B/k
 I9vv0ZEUQVs5y05L49shZwPC8VTHX12oHUYmUNCZ7rgQQYEyekG3gnH7/os4qekd1JVO
 3OpZD9YxFkPgVsfPjHz/g4CzwZYE/tnSFLvBsUj98nrrQvfZSRHiYMTtKTs9Xn/n+PTH
 HLChPkYlqi3AKGeUeNdPK91cT/EpF/5KYOISEOWJ7Yd150HM8mTQhJYKaRTShlz4BvO8
 3DxW8yKHCnP73NpRwNlXLb+IkY1uTgprpdXJghTqjVlb5SLuaDV0kSb6LCSteKzZ1znQ
 1QeA==
X-Gm-Message-State: AOJu0YxVsymuHpDK2gnWviLl6crTeiHXv3JAFaQ0sRXAgwkSUadBoF51
 TFfpiSKZ0MCUpKHsCMtrltJr8xllj08QSwH663GGxUuactHCEqlV5SRERo7tW4pewIVkXOEmyS9
 O
X-Gm-Gg: ASbGncuehvxD0CjRiN+HFeH0epzw/BXgnMr/rFWpmUZW2TNE2z9CP8U67anXzUsTVTM
 wKmpJVmsWB1POulffwFy3r0hRPMzQOkJGtJe4IQ76u7wKcPNGv6IiIe/SDfBjFwfIsU+2q4QyjQ
 oVaWer7aMmWOtXH7f7/eJK8NkhjoUTFw8dVpqZBglW7buXDS3/ZMWANsIn8b55P53Y23Oye5WSa
 G2bEYzc8dJTF97arMQCKWcnHdQjt+X+Z6ColKZCZttXv0/SvONGNWyEe/XSwFfYxQJvVAb19ZDo
 mESKCgNNTFfeEordKWZVwLc4oMRbSIxh5sSVzB0q7xMlztnlbal9Cx9D0rr2+1whD04W
X-Google-Smtp-Source: AGHT+IEIQRBwIq1zJupZM2ZmjQoYn9aJD2zfrbvCC9m1DvpQqf14GnwNuvINidc+Q2dVfuiLZH7o7A==
X-Received: by 2002:a17:902:c945:b0:220:d5a4:3ac with SMTP id
 d9443c01a7336-220d5a404a4mr52353285ad.45.1739481729373; 
 Thu, 13 Feb 2025 13:22:09 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5de85sm1615822a12.10.2025.02.13.13.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:22:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 7/7] test: update to latencystats tests
Date: Thu, 13 Feb 2025 13:20:36 -0800
Message-ID: <20250213212151.1693506-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213212151.1693506-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250213212151.1693506-1-stephen@networkplumber.org>
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

No need for loop and memset() here. Just use structure
initialization.  Remove unnecessary initializations.

Look at the number of samples, min, max and average
numbers to make sure they look correct.
Forward for longer to make sure multiple samples are taken.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_latencystats.c | 84 ++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/app/test/test_latencystats.c b/app/test/test_latencystats.c
index c309ab194f..676a99d385 100644
--- a/app/test/test_latencystats.c
+++ b/app/test/test_latencystats.c
@@ -14,18 +14,19 @@
 #include "sample_packet_forward.h"
 #include "test.h"
 
-#define NUM_STATS 4
+#define NUM_STATS 5
 #define LATENCY_NUM_PACKETS 10
 #define QUEUE_ID 0
 
 static uint16_t portid;
 static struct rte_ring *ring;
 
-static struct rte_metric_name lat_stats_strings[] = {
+static struct rte_metric_name lat_stats_strings[NUM_STATS] = {
 	{"min_latency_ns"},
 	{"avg_latency_ns"},
 	{"max_latency_ns"},
 	{"jitter_ns"},
+	{"samples"},
 };
 
 /* Test case for latency init with metrics init */
@@ -70,13 +71,9 @@ static int test_latency_uninit(void)
 /* Test case to get names of latency stats */
 static int test_latencystats_get_names(void)
 {
-	int ret = 0, i = 0;
-	int size = 0;
-	struct rte_metric_name names[NUM_STATS];
-
-	size_t m_size = sizeof(struct rte_metric_name);
-	for (i = 0; i < NUM_STATS; i++)
-		memset(&names[i], 0, m_size);
+	int ret, i;
+	uint16_t size;
+	struct rte_metric_name names[NUM_STATS] = { };
 
 	/* Success Test: Valid names and size */
 	size = NUM_STATS;
@@ -106,13 +103,9 @@ static int test_latencystats_get_names(void)
 /* Test case to get latency stats values */
 static int test_latencystats_get(void)
 {
-	int ret = 0, i = 0;
-	int size = 0;
-	struct rte_metric_value values[NUM_STATS];
-
-	size_t v_size = sizeof(struct rte_metric_value);
-	for (i = 0; i < NUM_STATS; i++)
-		memset(&values[i], 0, v_size);
+	int ret;
+	uint16_t size;
+	struct rte_metric_value values[NUM_STATS] = { };
 
 	/* Success Test: Valid values and valid size */
 	size = NUM_STATS;
@@ -149,10 +142,14 @@ static void test_latency_ring_free(void)
 
 static int test_latency_packet_forward(void)
 {
+	unsigned int i;
 	int ret;
 	struct rte_mbuf *pbuf[LATENCY_NUM_PACKETS] = { };
 	struct rte_mempool *mp;
 	char poolname[] = "mbuf_pool";
+	uint64_t end_cycles;
+	struct rte_metric_value values[NUM_STATS] = { };
+	struct rte_metric_name names[NUM_STATS] = { };
 
 	ret = test_get_mbuf_from_pool(&mp, pbuf, poolname);
 	if (ret < 0) {
@@ -166,9 +163,41 @@ static int test_latency_packet_forward(void)
 		return TEST_FAILED;
 	}
 
-	ret = test_packet_forward(pbuf, portid, QUEUE_ID);
-	if (ret < 0)
-		printf("send pkts Failed\n");
+	ret = rte_latencystats_get_names(names, NUM_STATS);
+	TEST_ASSERT((ret == NUM_STATS), "Test Failed to get metrics names");
+
+	ret = rte_latencystats_get(values, NUM_STATS);
+	TEST_ASSERT(ret == NUM_STATS, "Test failed to get results before forwarding");
+	TEST_ASSERT(values[4].value == 0, "Samples not zero at start of test");
+
+	/*
+	 * Want test to run long enough to collect sufficient samples
+	 * but not so long that scheduler decides to reschedule it (1000 hz).
+	 */
+	end_cycles = rte_rdtsc() + rte_get_tsc_hz() / 2000;
+	do {
+		ret = test_packet_forward(pbuf, portid, QUEUE_ID);
+		if (ret < 0)
+			printf("send pkts Failed\n");
+	} while (rte_rdtsc() < end_cycles);
+
+	ret = rte_latencystats_get(values, NUM_STATS);
+	TEST_ASSERT(ret == NUM_STATS, "Test failed to get results after forwarding");
+
+	for (i = 0; i < NUM_STATS; i++) {
+		uint16_t k = values[i].key;
+
+		printf("%s = %"PRIu64"\n",
+		       names[k].name, values[i].value);
+	}
+
+	TEST_ASSERT(values[4].value > 0, "No samples taken");
+	TEST_ASSERT(values[0].value > 0, "Min latency should not be zero");
+	TEST_ASSERT(values[1].value > 0, "Avg latency should not be zero");
+	TEST_ASSERT(values[2].value > 0, "Max latency should not be zero");
+	TEST_ASSERT(values[0].value < values[1].value, "Min latency > Avg latency");
+	TEST_ASSERT(values[0].value < values[2].value, "Min latency > Max latency");
+	TEST_ASSERT(values[1].value < values[2].value, "Avg latency > Max latency");
 
 	rte_eth_dev_stop(portid);
 	test_put_mbuf_to_pool(mp, pbuf);
@@ -188,22 +217,23 @@ unit_test_suite latencystats_testsuite = {
 		 */
 		TEST_CASE_ST(NULL, NULL, test_latency_init),
 
-		/* Test Case 2: Do packet forwarding for metrics
-		 * calculation and check the latency metrics values
-		 * are updated
-		 */
-		TEST_CASE_ST(test_latency_packet_forward, NULL,
-				test_latency_update),
-		/* Test Case 3: To check whether latency stats names
+		/* Test Case 2: To check whether latency stats names
 		 * are retrieved
 		 */
 		TEST_CASE_ST(NULL, NULL, test_latencystats_get_names),
 
-		/* Test Case 4: To check whether latency stats
+		/* Test Case 3: To check whether latency stats
 		 * values are retrieved
 		 */
 		TEST_CASE_ST(NULL, NULL, test_latencystats_get),
 
+		/* Test Case 4: Do packet forwarding for metrics
+		 * calculation and check the latency metrics values
+		 * are updated
+		 */
+		TEST_CASE_ST(test_latency_packet_forward, NULL,
+				test_latency_update),
+
 		/* Test Case 5: To check uninit of latency test */
 		TEST_CASE_ST(NULL, NULL, test_latency_uninit),
 
-- 
2.47.2

