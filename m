Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5061AE92FF7
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 23:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 669F940667;
	Tue, 30 Dec 2025 00:02:39 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id 65E9340648
 for <dev@dpdk.org>; Tue, 30 Dec 2025 00:02:37 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b7355f6ef12so1822235166b.3
 for <dev@dpdk.org>; Mon, 29 Dec 2025 15:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767049357;
 x=1767654157; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ysr89MrjIeLmO7ecNHaEnIo5RrhM6cudjCI9dRjkKE=;
 b=I6hbgDZklyBLvSMhbjv3kFBnBSq9CWWSiyii0CC0O6L63h67oseNpw0+cPBtneUahp
 fcOdnRVdGXJdz+VRpEytWyr9f5BiDIFlrFwryd1gk40LJ0AGu4LITjSfYWxmX9HC/nin
 d77jZdIldx3W3fDCCgq9ZwOgn3dWlk/abgZnRpJugwB9MLU7mne6gosGX0+jmMrBCz8/
 UPhyVK4fgWP5xVLLo11bGvx7G99oYtk/kAXSWJMvQUu//pB2RXfR2fqD23v49+vtyjHP
 g0N+NkEQM433Zxquxle+J3ZB0GEWfmngdFhbCgw1OJR76tDyCzVzjaDShZ+/kU1+qfgw
 gh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767049357; x=1767654157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ysr89MrjIeLmO7ecNHaEnIo5RrhM6cudjCI9dRjkKE=;
 b=Ose13IVVt9radEqpbkxe+G372Y5MUyhVgswchci4cRFdpEEVQgfMDuTnorxODdZjeT
 XyiPU6cYVI4hz7fgmuZ6imktPrRkZl1U6uJqoSu6OiQZu3dBz47uFNfJ93WHef6050pY
 +ltgn/Yx0xkq6i/g1VgzaCGYAZbhRIV+5aF5vpHPree5mUrAyne7Nr6svtNYL77/s3ei
 aR3Z8aUZsibkgpiEbSNdh8PCEB6BZ+209w9lhajXxNFvwQQcJbf0NpAtZAV+6FA+7vh8
 JhMjRbSMe6dJOZpeLreYeQMgdo+1FFB+X2tvc/FiKkqspe09Lk3lgSCtvO0srVNijmtA
 0hKQ==
X-Gm-Message-State: AOJu0YztOP24l09GhgBfvieV7p2BUrfIktSIjaX+ocdAuU4UvIdS+qp5
 SpFCOyNZVQQsbNe8a1ey6jve8l3xU+ckT7YT/xD4ktGTa3Fs12PiMKNREWerp/HCY9Zt5MKuT98
 rYRX3vVc=
X-Gm-Gg: AY/fxX7/gGLYnA/lmJkrElsDo7Ta/Mix9dluhp0RIPqnoy1t9x8vSqOXUHRU8ZZ8yYt
 J0oH6sHDqE9fqY7XYcFgRH08B6y3HuJbNFqgyw/xHUgAh446TIQTBgjl3bqcqOK9ceYAqXMv42p
 eoVpBCKgl8y/uc6pQDrlAFlpgCVVtqr7LCZaLR4+Agpcs2uqOijHC6Nq22gFp1JDEcPrDF1G8Hj
 oPvGudid3nq5WJ2WdeCybkE+S51mGLk9bo9FKREMf821A4MbnMCefXG5Y+Eyx3PklVfP5qWJ5fz
 IgSq6O8AV+af8I2XiXBf0CBj0EqGokKY6fE7sV63ADfN6x0WuCjyJL8M2nnqQ0j4pt4jUiQL983
 M8bbHosZnzSKoDNyX1JxixCMI7WibXV+bzH9VrvNKRw45s9xTy1tk2H0vffnxTHYT92ozCWitmV
 mjfLrkIn0XfksrCnpApeyDXK0LtKW5A6G5C1CWdfNKztT5VL7SWA==
X-Google-Smtp-Source: AGHT+IHuroDnwxRYxq40EHVYU2/u+RhAHTwvG7tEPTwRU4huCoiyVXb3pj3utKdt7f1Kd1dPxzklEw==
X-Received: by 2002:a17:907:3e08:b0:b79:f8f7:38ea with SMTP id
 a640c23a62f3a-b80371802f1mr3211446566b.45.1767049356911; 
 Mon, 29 Dec 2025 15:02:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b830b5fe8cfsm1933148166b.59.2025.12.29.15.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 15:02:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 5/6] test: increase gap in pcapng test
Date: Mon, 29 Dec 2025 15:01:08 -0800
Message-ID: <20251229230223.151874-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251229230223.151874-1-stephen@networkplumber.org>
References: <20251126051218.50568-1-stephen@networkplumber.org>
 <20251229230223.151874-1-stephen@networkplumber.org>
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
 app/test/test_pcapng.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/app/test/test_pcapng.c b/app/test/test_pcapng.c
index 5010355df5..73557eb2f1 100644
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
@@ -193,7 +192,15 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 	mbuf1_prepare(&mbfs);
 	orig  = &mbfs.mb[0];
 
-	for (count = 0; count < num_packets; count += burst_size) {
+	/* How many microseconds does it take TSC to wrap around 32 bits */
+	const unsigned wrap_us
+		= (US_PER_S * (uint64_t)UINT32_MAX) / rte_get_tsc_hz();
+
+	/* Want overall test to take to wraparound at least twice. */
+	const unsigned int avg_gap = (2 * wrap_us)
+		/ (TOTAL_PACKETS / (MAX_BURST / 2));
+
+	for (count = 0; count < TOTAL_PACKETS; count += burst_size) {
 		struct rte_mbuf *clones[MAX_BURST];
 		unsigned int i;
 
@@ -229,8 +236,7 @@ fill_pcapng_file(rte_pcapng_t *pcapng, unsigned int num_packets)
 			return -1;
 		}
 
-		/* Leave a small gap between packets to test for time wrap */
-		usleep(rte_rand_max(MAX_GAP_US));
+		rte_delay_us_block(rte_rand_max(2 * avg_gap));
 	}
 
 	return count;
@@ -467,7 +473,7 @@ test_write_packets(void)
 		goto fail;
 	}
 
-	count = fill_pcapng_file(pcapng, TOTAL_PACKETS);
+	count = fill_pcapng_file(pcapng);
 	if (count < 0)
 		goto fail;
 
-- 
2.51.0

