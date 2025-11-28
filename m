Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BA2D116E2
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 19:02:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33EE240281;
	Fri, 28 Nov 2025 20:02:37 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 75C23400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 20:02:36 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so21632925e9.3
 for <dev@dpdk.org>; Fri, 28 Nov 2025 11:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764356556;
 x=1764961356; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wr6obspcZ6tSl6XTX/epv+h7rBnSifhlAVMggkwgj3U=;
 b=E9SWwmZhYWxaAZwbjQABh+T65YgxtIXimR2fEIzWUQ04j4SnVHKWPWIFJFlU8E+mgD
 93tvR5/RrIs8q1iKq1wK0/1vsiJ6BQ29uhmOwnD6HiXNDXWG31aTZqR2hVAWyd3ImOYz
 oN11w74EmseYaFzgWlAZl/t32rxjC3nLaIR14jq2ZRI6yOwd4VAnu24jFrtua2bfhGQY
 SAcvNgJrPiCUukdM/nEAO5iVT2g9uFftGekkDQK/ejncj1e68NS5juIe3MreM89tPm/G
 ZlmDAOpp5ExDCZpYSYR6pQTiW7XHdRbYpKJaT4cMygeUkwdFQAd9+2qzE8iDOO+WVH8X
 lfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764356556; x=1764961356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wr6obspcZ6tSl6XTX/epv+h7rBnSifhlAVMggkwgj3U=;
 b=quwcMsnoihEg2/s0zbbXptLy0dMm5RKDC+T8jjc2d+PC3hDtD8xfrTo0LMPx2nc9uM
 qOvTXvTHOl4TZWxQpi9BSWgiqZW15Oz0jYb7SNdPR4vlQSiJQOoVer+fhc0tQjNnEqdZ
 HZ8ah/pOJqzUbJYFoQ6mLtVonpg+DWCWqKE7EpKfsh9+t+lYkbaRFuoj5BpCd702k+Cr
 9mmogipJqq4WJ7gVYLRG3KwqJe+a6lnxVF0tMgSifb4N76czxOoXXozKMh38nj952r17
 pwSSJi6qwmiBJAr+N32Dmh1HNCuNEYyTIbGTtrIIN80/epIx7LKN/113eKakcc06t+6/
 8C3A==
X-Gm-Message-State: AOJu0Yy3nS1tZ1CYzdE5rVP/BV9prGYwZIxpILrBRRrBKJnyHCrY1VA3
 Hvohh+iefdzlh/lYQDBDpEGP9VYBbnSKcLW6ogzXqKndGYCFJ84RuZrx8JSFgyLmMzDmvCwbmgx
 s5xa6
X-Gm-Gg: ASbGncugnIYdnABpU43zTyX+81rMr15TIaXm++NIlzqojevPeQddKsWL7NMhRtsLPxx
 g9M68O8ifbMftXR2vgqhlI88gaDLV+kRrP2MCrKVouBFFtXG8ktKxXd//B1jF7kgoCL6jxsEpg1
 abuFhn2GW/T9dBSQmhjOrhA+/yDMf6axtjTjL+9ca0MEjUft6k7pWK6YGS5UhOBN3DR9Mt/JPk5
 SJxlMA2jXnsKH7a3A3omBvZC9nF70aRvvphPtFHCZaj7+xZfbJ87Rfm94glMyf1sCvj+Vnrhi94
 M8Q2WEJ/PcWhJ+zxfqCzjY8aye4GX4QXetkss4ymKwKfo6mMrB3qmmnx/FPFsPenbplg9uXdJR+
 EC4UaQ+WlOWHWVcKD7zX9SFtkxqtlSESCNYWwg/q9m/fNGzSN04yusxlT3CmTofHKT7HoJs7FIs
 Lnt3zdrnuXI2+nxTs6IHdyCW8Redr4YKuu7CHVNyFs8d0K084AmQ==
X-Google-Smtp-Source: AGHT+IFXkxS1nc7Os17iPVYin7uL2Zf0LsPrJPHxtP9ZLhkc/9m1sTLtieVImVBOv3e0EPw0yl74Zg==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-477c114ed70mr415973735e9.24.1764356555824; 
 Fri, 28 Nov 2025 11:02:35 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479040d81e4sm102657795e9.3.2025.11.28.11.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 11:02:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC] test/latencystats: loosen requirements on measured latency
Date: Fri, 28 Nov 2025 11:02:20 -0800
Message-ID: <20251128190228.64278-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

On QEMU Arm there are failures because the minimum measured latency
was zero. This is likely because the TSC counter emulation is coarse
enough that successive measurements return same value.
Modify the test assertions to allow for TSC being slow (or even
constant).

Also, fix the test to cleanup before validating results
and print the values if a failure occurs. The field name values
printing loop was an earlier debug step not needed.

Fixes: b34508b9cbcd ("test/latency: update with more checks")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_latencystats.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/app/test/test_latencystats.c b/app/test/test_latencystats.c
index 676a99d385..0907f3f5a6 100644
--- a/app/test/test_latencystats.c
+++ b/app/test/test_latencystats.c
@@ -142,7 +142,6 @@ static void test_latency_ring_free(void)
 
 static int test_latency_packet_forward(void)
 {
-	unsigned int i;
 	int ret;
 	struct rte_mbuf *pbuf[LATENCY_NUM_PACKETS] = { };
 	struct rte_mempool *mp;
@@ -184,23 +183,26 @@ static int test_latency_packet_forward(void)
 	ret = rte_latencystats_get(values, NUM_STATS);
 	TEST_ASSERT(ret == NUM_STATS, "Test failed to get results after forwarding");
 
-	for (i = 0; i < NUM_STATS; i++) {
-		uint16_t k = values[i].key;
-
-		printf("%s = %"PRIu64"\n",
-		       names[k].name, values[i].value);
-	}
+	rte_eth_dev_stop(portid);
+	test_put_mbuf_to_pool(mp, pbuf);
 
 	TEST_ASSERT(values[4].value > 0, "No samples taken");
-	TEST_ASSERT(values[0].value > 0, "Min latency should not be zero");
-	TEST_ASSERT(values[1].value > 0, "Avg latency should not be zero");
-	TEST_ASSERT(values[2].value > 0, "Max latency should not be zero");
-	TEST_ASSERT(values[0].value < values[1].value, "Min latency > Avg latency");
-	TEST_ASSERT(values[0].value < values[2].value, "Min latency > Max latency");
-	TEST_ASSERT(values[1].value < values[2].value, "Avg latency > Max latency");
 
-	rte_eth_dev_stop(portid);
-	test_put_mbuf_to_pool(mp, pbuf);
+	/*
+	 * Test maybe run in emulated environment where TSC is very coarse.
+	 * Therefore can't assume that min/max/avg not zero.
+	 * But we can check that Min <= Avg <= Max.
+	 */
+
+	TEST_ASSERT(values[0].value <= values[1].value,
+		    "Min latency %"PRIu64" > Avg latency %"PRIu64,
+		    values[0].value, values[1].value);
+	TEST_ASSERT(values[0].value <= values[2].value,
+		    "Min latency %"PRIu64" > Max latency %"PRIu64,
+		    values[0].value, values[2].value);
+	TEST_ASSERT(values[1].value <= values[2].value,
+		    "Avg latency %"PRIu64 "> Max latency %"PRIu64,
+		    values[1].value, values[2].value);
 
 	return (ret >= 0) ? TEST_SUCCESS : TEST_FAILED;
 }
-- 
2.51.0

