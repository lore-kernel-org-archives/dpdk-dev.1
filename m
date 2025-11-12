Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F54CD37BF
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 20:05:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26286402B2;
	Wed, 12 Nov 2025 21:05:18 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 7E95E40151
 for <dev@dpdk.org>; Wed, 12 Nov 2025 21:05:16 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-34374febdefso54105a91.0
 for <dev@dpdk.org>; Wed, 12 Nov 2025 12:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762977915;
 x=1763582715; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E8K7lkxnF5kdhfKXkyyx68BvK7P4uJwUfG3I74A8gYM=;
 b=xbnprwAWayz+I/5fj6Xn3Ph8Rk8r3Py2FSgWhecAz6+WBu3yNm8dXTuG6GhQW7h32c
 huNck6ALaWRnNnxcDDlRx0tW2g8FFT2l2vwHVc5ItrcZNl+jeAxGMycC7Bt8vQ4kHAE+
 GJEwNy0kRs8QZ/zo32eLh+NWm2+ROIa0Q0ZjCr//DXW4nqQSvqQu/htb7oibys4Rg5Vf
 zXtJ5Dy4W3uU8NB0C/VbCH2IAVAZsHU6UL9HUYThJ8yGrNf0hRqdZD9RCDzOY788klrb
 Hz0RzB+d7EfzaC/oKJGT3WlZpdveavGkLzdA+KjnF9rs/RmC66VyQOlGBuP8PiPIMsjs
 Dg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762977915; x=1763582715;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8K7lkxnF5kdhfKXkyyx68BvK7P4uJwUfG3I74A8gYM=;
 b=Uvp+aUbvlGVEZ762ekYuvqLAQyPcoVTzzzdWEuZ2AVj3r0rXdfCrewe7zZqYmVwo9D
 KI665kh6p6bPDjAoytDnwcVeTdObul+abwk8R2F9C9SsTHZwS2/9FwMdD+TVsgQAM7ks
 wvznmSdsuEMJqWPb2eafI3GBxUg4ipYeS5vSXifhrue7t3PYf47PmEq+9JYjhvueNsjx
 PWsR2RHbn8rZp6qQuo5vj+NnmH6QgyiSH0PHH2eK+ZB8I5mEWiALr2dUH4CGnRIYnf9D
 NwJAwwJ/ysWsfQQLsjJkZhAanpFWsFExwXuFTLkhAuaWw9eaMYcrF4vKlRiWMicZ+KVh
 xpgQ==
X-Gm-Message-State: AOJu0YzPKQQ3E3KfA9uooG1OtUsvxVaYZdHTAjfBZ6+j1HO3MksQbks8
 1in9pX3DqZY5lDoHhBw523hE8xx/+bVjs3TJnId17/uGkw2O7z63Op6QkV3of/uLtXwc9UUcUYk
 emxxL
X-Gm-Gg: ASbGncvD2ZmhzWLNpEcg9SKM+kvwLq/Go20e+rwwbC7sE1WxgPyphczj3tfS2XwkBQu
 yxcebgMGxHt0VPtyQ/Sz+gh4yPIwicNMmUwQD+q8eKJg0XSUOGA6dLRB+nRoGr3MjI2r6wLFbHP
 v4vb29JLc8MyaQvDZ7XsJlpdZfaalz4T8YGnvZn3XY6FtxalLsCPtUsVW9etBOZSW2DlCDilUvF
 oIkWu/bSE7Qt0mA4Y//I3Ogs5MvZpwpjinK10kDpq25uJH4KeW/HB3Mjp170TAfdLdIJFSM/bO4
 lk1hqD/PO/vdKlGO98SdNebng8RsOAZRKDjzJxCWf3J8BztUFlI7pIO59g1S5wMVbpOeBZcY8CD
 TooUwWSSDOqiam0JEckouKEYUwVcOiR3Mk7xYxHHROqWbpUQIj0BL0vCVim13KgzoH5hk0tWVSh
 +wHqFFKVfWXx3ZOVxTWZm/Q7yPOF65QIq6IzRJ3KiZHV22yYk/fw==
X-Google-Smtp-Source: AGHT+IHSbHalKdJconENS1kfdPSlS9Jev1lfgFCTJVvssJlmI+/HWZ3qttWqOvEHTVDYWboFC44rhw==
X-Received: by 2002:a17:90b:384c:b0:33b:8ac4:1ac4 with SMTP id
 98e67ed59e1d1-343ddf0cf3fmr5433060a91.35.1762977915380; 
 Wed, 12 Nov 2025 12:05:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e0714121sm3528929a91.5.2025.11.12.12.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 12:05:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/2] pdump: avoid integer issues
Date: Wed, 12 Nov 2025 12:05:09 -0800
Message-ID: <20251112200510.332651-1-stephen@networkplumber.org>
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

There are warnings from Coverity and other tools that handling
of intermediate bursts may wraparound. Shouldn't be possible but
use unsigned int to avoid any issues, and just as fast.

Coverity issue: 499471
Fixes: 0dea03ef2e8c ("pdump: remove use of VLA")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index 039a4013dd..c3d0ffa779 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -27,7 +27,7 @@ RTE_LOG_REGISTER_DEFAULT(pdump_logtype, NOTICE);
 /* Used for the multi-process communication */
 #define PDUMP_MP	"mp_pdump"
 
-#define PDUMP_BURST_SIZE	32
+#define PDUMP_BURST_SIZE	32u
 
 /* Overly generous timeout for secondary to respond */
 #define MP_TIMEOUT_S 5
@@ -139,13 +139,11 @@ pdump_cb_release(struct pdump_rxtx_cbs *cbs)
 static void
 pdump_copy_burst(uint16_t port_id, uint16_t queue_id,
 		 enum rte_pcapng_direction direction,
-		 struct rte_mbuf **pkts, uint16_t nb_pkts,
+		 struct rte_mbuf **pkts, unsigned int nb_pkts,
 		 const struct pdump_rxtx_cbs *cbs,
 		 struct rte_pdump_stats *stats)
 {
-	unsigned int i;
-	int ring_enq;
-	uint16_t d_pkts = 0;
+	unsigned int i, ring_enq, d_pkts = 0;
 	struct rte_mbuf *dup_bufs[PDUMP_BURST_SIZE]; /* duplicated packets */
 	struct rte_ring *ring;
 	struct rte_mempool *mp;
@@ -188,7 +186,7 @@ pdump_copy_burst(uint16_t port_id, uint16_t queue_id,
 			dup_bufs[d_pkts++] = p;
 	}
 
-	if (unlikely(d_pkts == 0))
+	if (d_pkts == 0)
 		return;
 
 	rte_atomic_fetch_add_explicit(&stats->accepted, d_pkts, rte_memory_order_relaxed);
@@ -210,10 +208,10 @@ pdump_copy(uint16_t port_id, uint16_t queue_id,
 	   const struct pdump_rxtx_cbs *cbs,
 	   struct rte_pdump_stats *stats)
 {
-	uint16_t offs = 0;
+	unsigned int offs = 0;
 
 	do {
-		uint16_t n = RTE_MIN(nb_pkts - offs, PDUMP_BURST_SIZE);
+		unsigned int n = RTE_MIN(nb_pkts - offs, PDUMP_BURST_SIZE);
 
 		pdump_copy_burst(port_id, queue_id, direction, &pkts[offs], n, cbs, stats);
 		offs += n;
-- 
2.51.0

