Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70C1CF45D4
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 00:52:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DA784067D;
	Tue, 13 Jan 2026 01:52:15 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 986A74066F
 for <dev@dpdk.org>; Tue, 13 Jan 2026 01:52:13 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-432da746749so1813705f8f.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 16:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768265533;
 x=1768870333; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5HgGP04jqrIPe0ZkU/B4c49ec1QoOCO4lbr46XwcJho=;
 b=l0WDTZTULE8FHYa4iXQcKZ7s7wipj1N9FDM4UjFQGVqCmMcBNvBjiNExUaWMLC8gkd
 ajF/sEafn4UTkqVa3z8Er8MQ+NV9BlSnhRpzeDRbitSZI1TmficGjEhGQneKIEc3C34z
 mXHAzgzMz2TG0Z8KAe2R/hcjse2dPBMHZjlsADHPPc/mFLXr9CVCldMDcMF3jw+vZ++c
 wpWUbC6fhScdBb80We+Ctu/wTDKmDrpQlv6KqG1/hksOaWan8EMY0/E4xNY/wC9xmJvA
 gb/oyrkPcdQTLDcpETE5JX98YJzvnxNoTO0EndQeK+TXJSfdWqdDGHjMLJC1yQkNAuhk
 sV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768265533; x=1768870333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5HgGP04jqrIPe0ZkU/B4c49ec1QoOCO4lbr46XwcJho=;
 b=A43fr/kpSHBQZv/IGH8vgF1qakW+JetjNrQotYryGQnEFPWB+nTWN8eIX9FY4C4SPr
 mRQjDeulr7B/QJtD+TYsto+D24kxLkBCdejoBaFZD0fRF+OLvL9CvxtQ9jgdbFks63Nx
 k4gEzT56aZxXv+bt9dkbIoCTV+sU4fz6HHPboEiUKJs71MqtK9x2NqDNFSsNWD/rO1qD
 3QlO69cL1kbidPkuAodpZ0E1k6FfjJcurb9ypghq/LwIPKrUETaktBxjkVQEXdmyFXpW
 g0oiPgnitRRuvKZp4939Lpsb59madDNOURbnKZ47usxrBvtTkBaG7gjGHrf+YKzrxCPy
 UjIA==
X-Gm-Message-State: AOJu0YztPPt5jxYMGFEGcKGw2duMomJCdsah4PS5irAEf8b3+CILuNMQ
 3YfguZibCQPn9H2+2rUk/qmknuRFzoq6fMJriO2PG0lM/ktInDP7f2NToBzuwiUw7jf1qFdJ4fh
 nkLvb
X-Gm-Gg: AY/fxX4MieYxk8uZY1ld7ZtmB9P/K24+GF0lszdrKr8p63fMA4APSj4GZD1Gg6Ai4Bc
 COuZOAYamFd0k8WzQczz1/ttpaxZE2qASuBVFKpEkDguhT3ITBvXCISV8RY4eIKUza9fL+sS0Qf
 Xi7S+vkIi4j7yGHjgilfq2WcRwm82D1Qac/oal63raZEbwKtIG88DpglnlNJiqVHezNPl69ILtC
 XaZ9ayLuBgMQIy4cKJOzuhujAZRBqTBlc37un7hxOt9LWAtKKOyX1IySdi6zEXElLZXPWAiu4Ty
 OlHKGm5rLJDWpjG0nOByv+5TLwVV9KyiYR6Xb2OMxlvKxCkneG7JmUxu96+GeNCm0PDTiddxTR3
 dVGdnDcTBj9WVl95BS66fkHh8c4JfPQ/U/t0yKSu0BJybBDKGvbNBsvXvTkwPXdJPlTWgB0whca
 0RoiXLXngVvarv4B962gtceIwPPGf5fBHFF5CuPIp68VDeJkxo7Q==
X-Google-Smtp-Source: AGHT+IFgtrx63DQL5025n/L+7KRTEAOwieaV8M6TWz88vU6NQOenSXQ9sLqPcvOs2XUVbEHr1fAvUQ==
X-Received: by 2002:a5d:50c4:0:b0:432:dc1f:6982 with SMTP id
 ffacd0b85a97d-432dc1f6affmr10572047f8f.16.1768265533183; 
 Mon, 12 Jan 2026 16:52:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dad8bsm41603051f8f.8.2026.01.12.16.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 16:52:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 6/7] test: increase gap in pcapng test
Date: Mon, 12 Jan 2026 16:51:29 -0800
Message-ID: <20260113005154.44551-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113005154.44551-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20260113005154.44551-1-stephen@networkplumber.org>
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

Want to make sure that test takes long enough that 32 bit
counter wraps around.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pcapng.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index f1405cfa7c..8a311c92de 100644
--- a/app/test/test_pcapng.c
+++ b/app/test/test_pcapng.c
@@ -27,7 +27,6 @@
 
 #define TOTAL_PACKETS	4096
 #define MAX_BURST	64
-#define MAX_GAP_US	100000
 #define DUMMY_MBUF_NUM	2
 
 static struct rte_mempool *mp;
@@ -175,7 +174,7 @@ test_setup(void)
 }
 
 static int
-fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
+fill_pcapng_file(rte_pcapng_t *pcapng)
 {
 	struct dummy_mbuf mbfs;
 	struct rte_mbuf *orig;
@@ -198,11 +197,18 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 		 "generations of example code. The magic number 32 is not documented because "
 		 "nobody remembers why. Trust the process."),
 	};
+	/* How many microseconds does it take TSC to wrap around 32 bits */
+	const unsigned wrap_us
+		= (US_PER_S * (uint64_t)UINT32_MAX) / rte_get_tsc_hz();
+
+	/* Want overall test to take to wraparound at least twice. */
+	const unsigned int avg_gap = (2 * wrap_us)
+		/ (TOTAL_PACKETS / (MAX_BURST / 2));
 
 	mbuf1_prepare(&mbfs);
 	orig  = &mbfs.mb[0];
 
-	for (count = 0; count < num_packets; count += burst_size) {
+	for (count = 0; count < TOTAL_PACKETS; count += burst_size) {
 		struct rte_mbuf *clones[MAX_BURST];
 		unsigned int i;
 
@@ -238,8 +244,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 			return -1;
 		}
 
-		/* Leave a small gap between packets to test for time wrap */
-		usleep(rte_rand_max(MAX_GAP_US));
+		rte_delay_us_block(rte_rand_max(2 * avg_gap));
 	}
 
 	return count;
@@ -476,7 +481,7 @@ test_write_packets(void)
 		goto fail;
 	}
 
-	count = fill_pcapng_file(pcapng, TOTAL_PACKETS);
+	count = fill_pcapng_file(pcapng);
 	if (count < 0)
 		goto fail;
 
-- 
2.51.0

