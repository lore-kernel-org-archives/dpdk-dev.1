Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C7EC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 14:14:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B478C42EFA;
	Tue, 10 Jun 2025 16:14:11 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id D8D0B42EFF
 for <dev@dpdk.org>; Tue, 10 Jun 2025 16:14:08 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7d38d1eae03so226137985a.2
 for <dev@dpdk.org>; Tue, 10 Jun 2025 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749564848;
 x=1750169648; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nfzftuol9TKasfULCQivt7OsevKxD6HzWoJJXbL/TuA=;
 b=shRdOqW6NSFFVg5XgaT3vwPO+Mo8Xi9jvhl1EdqSSdytMCQYDYWt5DGutF5F20LW7q
 YvW/Vl3Y9IFW38eJD6L4DfG1smcg0uzcfYGPvAVhCkhMMKbiDOt1PxBtd1WHCF1wHU5L
 +QNy+SlD/NJgHYommOXNidrLPzDy+jXximfSoSBbA5kPrndbsrs/G3sTSaVzYdeclcp1
 EIiGHDP1BuJ0nigFjt/3jbwVud+dCozYmLkJFOCSIe495gA/lgTV3fZuGhkKv6ROZZ5c
 8dBIrf+ibgo3W8Up3oQLCDh3w5blI3UXS3cgUe80UcW9btZbp9thEi4sQujZ0XB3QHLD
 SWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749564848; x=1750169648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nfzftuol9TKasfULCQivt7OsevKxD6HzWoJJXbL/TuA=;
 b=h1NXKsq8wVUwT6/2gDVe3KJ0UjLWu59yx9eMTrap5pH5MkRg3bJ64/PBWTZf8uNJSW
 xOHMIxqhweVLrHyaTL2cAHVbKZYTqZ0Hew3odbWSzCqwvGbHhA+bpYJtpg+uc43X6+kX
 pqsDx3LozB4G4vzmt+b0pmbf7vveweoTWAqyQIsaDDgne33YVtW8WwqZocS/Z1EAWzu8
 wb3u6xhbeDIn89HOjPl3/HxH9g7GjaCQQIZTW56jn3kicPWnxuvdGXLjrO1r74XGeyKj
 8D+cYoesTa+2YMkPTtoIWf2vy8vnK0K547VmU0112o8XfvNZdmVYPddnWL2Vvd5fOJvk
 bIww==
X-Gm-Message-State: AOJu0YzxMtIkTK1h6ndGafRmOkbNnYY64i4VKk5GCrxK8A76xqPrk72J
 jKlVcLU/zeRocemfgr54TwZ0A5MZjZk6+7Cmh3l7GQpJVrw31XLoz/HyY0mgxqo7y3kJTsj34rx
 7KLXu
X-Gm-Gg: ASbGnctGY8g76ZSwoAP0EPrTwEo86btvQ5lAa0Ri1Ei3Ndnbtk+MhyG/RSwhvWKzWcW
 gYqtiGNFBK3oNKqY3NTGEQhUD9CcYPntAgw0edsuZb8JcacqmeDbrJKFOt1SqDmEPl/nGTy7U8v
 eaFq05bqAVx44IYm4ugO5XVb62aOgitOwsZeDujkbuDaBBWrVlStEafgjxtu9Wr8fRk91Mr03uE
 qM9oxLk+2lGtQpsPP7KEMeaJE0Xosflye270AMNvXiYcWk6Hqr5i6Hnt1NKo9DK9wzuWaHORYeK
 ugi6nOefgIyCiB12G2k9YyhuI5UusJykKbez6HuJfU/dLLPennpGOF18E7s+K5BePTZ8toqRTQk
 +FGTEjOMSdjQXk76MAnqeug5ebSsVTuafZWOZ
X-Google-Smtp-Source: AGHT+IF9Rs6R/5PpicjY2v926aoffoxeqIf7UOg6JL6yDXEb7QjL5nXBjNggD4KElwVMcZn8263Iyg==
X-Received: by 2002:a05:620a:4487:b0:7ce:bd05:83ed with SMTP id
 af79cd13be357-7d22987d994mr3030179385a.7.1749564848205; 
 Tue, 10 Jun 2025 07:14:08 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2669b573asm698525985a.110.2025.06.10.07.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 07:14:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v8 7/7] test: update to latencystats tests
Date: Tue, 10 Jun 2025 07:12:46 -0700
Message-ID: <20250610141355.91759-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610141355.91759-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
 <20250610141355.91759-1-stephen@networkplumber.org>
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

