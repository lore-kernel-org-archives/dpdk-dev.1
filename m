Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3959BD25030
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 04:54:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5605540A80;
	Mon, 12 Jan 2026 05:54:14 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 0FFB54013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 05:54:13 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-64b608ffca7so9242891a12.3
 for <dev@dpdk.org>; Sun, 11 Jan 2026 20:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768193652;
 x=1768798452; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4k9t6K8TqadMJGPXNqsodTMYil5GmHAJMHPbp+8uIQw=;
 b=qHdN3Ufwiq+HaRET9p0THb8J2fLYUdXRbyf01qMchxfnMCFWG0V7tU0S51G+4UliUn
 USBlbyMSEOnjgYPz4BZjro/07BCqTExgjs5uTh7jHL7FK36XbInZmQZsgTOh+jnOiP1D
 v/7G4UFquEXtvkKpOuVuABRxkTVMaaLIZG1g56PHSQQlRaxk+IdaDmDfIENNn7LT2amh
 7A8PznbwB1s9qdcDCuNq+Ugu8m66xTStLqoWjM+cS34kSJyOqpOTNBe5bYfzvJpIpFTK
 Jrdzc5s9z345eTVjRkm8Ve04ksuKkzfHYj09CiB38WgFng5AKOpOrENTHm7uI1x8+FpM
 WuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768193653; x=1768798453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4k9t6K8TqadMJGPXNqsodTMYil5GmHAJMHPbp+8uIQw=;
 b=XfHLWcIJiLpdKGcaKIEIcbgwy8ntRqMrz6w2m0Z3hbtm3ufc1eF1DPquPZxJ75vqWc
 X0Uced/W5QQp4qx2JPcVj7pAHXsEB61KFF9ntYfs+9BncjqomMLxtBQchPolSKjuvSvL
 tCWDlCTqXnTlDfIdbbPWk1A95LCgo5nvZDBknRs0eTJQJiVnnDpxDIZ5RqcrJFj+4Bat
 u2BIekTdS22EAz67Exxj5IN2fVH3gWpuDD+mqWSUopRNIJDuPbIdb7OCXiVz4CE1rhkf
 Sl7m6Dz9GbrgpKiP6Q1d+2A9s3E6U2nQW+gMMAW5ZPWKYk1gT4vSAaaVP7DisFMlCF48
 whMQ==
X-Gm-Message-State: AOJu0Yy/EP1nb8pFYmuHLImTb9rmNe12sHi9E+ZaUiSjoxHH9qTl/5Iy
 JTKJThHiyggBo6AcnJiCEwmZd+4cDXd8WF84G/akATsLXt1L4Dz02radDo18v2hgEhdksluxnUF
 7b9uZ
X-Gm-Gg: AY/fxX4V4Ff5uz3EGXrz+2FaPOnZeGz9kJ+F0mo/j+meRSRxg9hAiQhU7rfM1sV+rON
 khx30tJa+aKaQMbX4HzpA3NtgX1GDQ412apaLfLM9myN0/rQFbYhMfjsqaVRErEHQcnJMpz+6ji
 jBAAHCL9ZqOa5gXqt0rMLqS9CHD1WZ1x1EWZowAbTT5FerTkhklSV5v07p6QdLCfrLObLSkqdC+
 qmXyUAfWkdQy2W+uqgw2yr3mCeT1zH5pfGSm+581UFDzi/s8ayMpve79VsuJ+NhjjcR4WE5LRq/
 OivAO4si80sllvq/lNzrXnqPUbRZfk8fFSmTngyzYcR2ZZDFoHscrOGn0um/YPy2bAIW4WoFpcz
 dCojM3QRpAcmtczJqQpm5hg8MS/fzQEN6MylpW6TOFDhqGJoVWO3fAQR8i9L7HlEd8b50qiOoZI
 ORdRMTNvnAucdaeBZIxeqU/tW8CFjoqC+xrW5TW8/16aMjbshqiA==
X-Google-Smtp-Source: AGHT+IFvJEYBLAYFLC/OMDpNL508E8Gk/CWxHuyZQwJewAeRBjlaHeyOHmIc31CaSZHIXqkvHg/8+g==
X-Received: by 2002:a17:907:9494:b0:b87:2780:1b29 with SMTP id
 a640c23a62f3a-b872780494fmr51718666b.37.1768193652650; 
 Sun, 11 Jan 2026 20:54:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm534327166b.30.2026.01.11.20.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jan 2026 20:54:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v3 4/7] test: add more tests for comments in pcapng
Date: Sun, 11 Jan 2026 20:50:17 -0800
Message-ID: <20260112045359.142999-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112045359.142999-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260112045359.142999-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add some more cases where comment is set in pcapng file.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index bcf99724fa..228724d4c9 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -125,8 +125,7 @@ test_setup(void)
 
 	/* Make a pool for cloned packets */
 	mp = rte_pktmbuf_pool_create_by_ops("pcapng_test_pool",
-					    MAX_BURST * 32, 0, 0,
-					    rte_pcapng_mbuf_size(pkt_len) + 128,
+					    MAX_BURST * 32, 0, 0, rte_pcapng_mbuf_size(pkt_len),
 					    SOCKET_ID_ANY, "ring_mp_sc");
 	if (mp == NULL) {
 		fprintf(stderr, "Cannot create mempool\n");
@@ -149,6 +148,14 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 	unsigned int burst_size;
 	unsigned int count;
 	ssize_t len;
+	static const char *examples[] = {
+		"EAL init complete. May the cores be ever in your favor.",
+		"No packets were harmed in the making of this burst.",
+		"rte_eth_dev_start(): crossing fingers and enabling queues...",
+		"Congratulations, you’ve reached the end of the RX path. "
+		"Please collect your free cache miss.",
+		"Lockless and fearless - that’s how we roll in userspace."
+	};
 
 	/* make a dummy packet */
 	mbuf1_prepare(&mbfs, pkt_len);
@@ -162,9 +169,14 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		burst_size = rte_rand_max(MAX_BURST) + 1;
 		for (i = 0; i < burst_size; i++) {
 			struct rte_mbuf *mc;
+			const char *comment = NULL;
+
+			/* Put comment on occasional packets */
+			if ((count + i) % 42 == 0)
+				comment = examples[rte_rand_max(RTE_DIM(examples))];
 
 			mc = rte_pcapng_copy(port_id, 0, orig, mp, rte_pktmbuf_pkt_len(orig),
-					     RTE_PCAPNG_DIRECTION_IN, NULL);
+					     RTE_PCAPNG_DIRECTION_IN, comment);
 			if (mc == NULL) {
 				fprintf(stderr, "Cannot copy packet\n");
 				return -1;
@@ -386,7 +398,7 @@ static int
 test_write_packets(void)
 {
 	char file_name[] = "/tmp/pcapng_test_XXXXXX.pcapng";
-	static rte_pcapng_t *pcapng;
+	rte_pcapng_t *pcapng = NULL;
 	int ret, tmp_fd, count;
 	uint64_t now = current_timestamp();
 
@@ -413,6 +425,13 @@ test_write_packets(void)
 		goto fail;
 	}
 
+	/* write a statistics block */
+	ret = rte_pcapng_write_stats(pcapng, port_id, 0, 0, NULL);
+	if (ret <= 0) {
+		fprintf(stderr, "Write of statistics failed\n");
+		goto fail;
+	}
+
 	count = fill_pcapng_file(pcapng, TOTAL_PACKETS);
 	if (count < 0)
 		goto fail;
-- 
2.51.0

