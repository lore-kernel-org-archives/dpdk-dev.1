Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC6AC02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:26:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA8F440A7D;
	Wed,  5 Feb 2025 17:25:48 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id C034140A67
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:46 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2f9d5f6df4cso2358571a91.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772746;
 x=1739377546; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDhw28+EUF/HlEE2pqYuojbCu6BgdSQ5N3cpWGYIXsM=;
 b=23P19y7zEw8HbV6PUJ3T3xvFNtHgCu+DgYvKexFve8csvpe/hNAco6IVI67Zdle++0
 aLbLvJ6n80biltALANCtexMDS1bkV4d+XajLRTkGQhcOxWkLxt8NfhnnXf3+UHBoMfW1
 +1+NkxZRXAFylcp5e5xk11vscTc5z8sI76w3D+MDG0u0nZJIIT1n/S3Gz5MSMrlrgnbI
 IW52nyG3JsQ3bZrbk8B1JWBuqQSZwXJiho5gYc0tsXoUMwdZay0KQB40CaKT/CTIbXnc
 qs28Gax7E7N7uChWdGefA8nPKSv2StaUIwVw3RMwp4ur0J1nKvtZyJhvJ8XqCZAZntg+
 +YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772746; x=1739377546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDhw28+EUF/HlEE2pqYuojbCu6BgdSQ5N3cpWGYIXsM=;
 b=Iivh9i85mS9tsGukDioAJ6T0A0BKuoxfs2b7SsI0Cga/b0GItMKQtsI1Sasgkns6MY
 4k5tDwkb1UbpKbLV7QdGyMzXif1fMOquJnKRkAHj4nb1dSUlooA4pSkeBHKymYcnMVSx
 LyLysJeHqclmzf9Ekhdy/i/fgrALf/V5Fg2dtzoKVVS6fy0ZUEPvyUmFFGFUzcoMS8fs
 6DWQrzRjb8e1ApMdFHHqU7sdtvR/IEQj+XGVl50DcgurXILW5/MdAARnOZemPUEESkqX
 dvae5g+bEIxHxuiwE15qIgDUJWpYIOlQj8t7yYeRrklw04vTG9uKGwHhtu0gIQO1e/dj
 yvxw==
X-Gm-Message-State: AOJu0YxjV6OheQbd/A980OuJf6U4UjPz6PwhdJu2dyCkme831RdZqu5r
 SQ/EMt6LCm7tVjlpApytipvMC6zQrKkeKZi6lNL4rV2hjPRcKzlYWnEXTkL/LQMFIPx4DBtbySW
 R
X-Gm-Gg: ASbGncs27tpqh2SQ3Xlnxf0/bO3xWlTYjYM5NHmLiLO3TM/oxhyBALDhFr7+AjSTZRO
 y8+ImmbTVXcXXyptI9r3rUBS3Lg4Dbk5jZS/fxku0XjPpPJ3C81+oaOo0zlnleCY0Y32DgFDo18
 igCRx1YmBPQw6VmCt+ESVlwxT26mC8gq7gx1eauIMifTn1Cl1O0dzF19IhN6NNUcKTG0awTs09C
 Ml+SqhdGh4XeBOV/TQfMS5fwzOx0heYnrLrv2WzmazMIXlYlRI3S+cFRbgxELVkgRjz+9Wnc2WF
 ECcsctWn4mOBdctB1VkbWSopLJI6ILXv93x5GTbFLfmE99dOx3vIyB+NzzH/0y6FkL8I
X-Google-Smtp-Source: AGHT+IEd8jhjg8wFxDyRKd5aL2NRrQnVJtHT83KEm8SH0piHsHC039NnEn1jv5Jtdfofq/PD2hw+qQ==
X-Received: by 2002:a17:90b:28c4:b0:2ea:61de:38f7 with SMTP id
 98e67ed59e1d1-2f9e082dff0mr5324144a91.29.1738772745924; 
 Wed, 05 Feb 2025 08:25:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:45 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, sunil.kori@nxp.com,
 stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v3 15/19] net/dpaa: fix bitmask truncation
Date: Wed,  5 Feb 2025 08:23:16 -0800
Message-ID: <20250205162448.161161-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

The dqrr_held mask is 64 bit but updates were getting truncated
because 1 is of type int (32 bit) and the result shift of int is of
type int (32 bit); therefore any value >= 32 would get truncated.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Fixes: 5e7455931442 ("net/dpaa: support Rx queue configurations with eventdev")
Cc: sunil.kori@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_rxtx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_rxtx.c b/drivers/net/dpaa/dpaa_rxtx.c
index 247e7b92ba..05bd73becf 100644
--- a/drivers/net/dpaa/dpaa_rxtx.c
+++ b/drivers/net/dpaa/dpaa_rxtx.c
@@ -842,7 +842,7 @@ dpaa_rx_cb_atomic(void *event,
 	/* Save active dqrr entries */
 	index = DQRR_PTR2IDX(dqrr);
 	DPAA_PER_LCORE_DQRR_SIZE++;
-	DPAA_PER_LCORE_DQRR_HELD |= 1 << index;
+	DPAA_PER_LCORE_DQRR_HELD |= UINT64_C(1) << index;
 	DPAA_PER_LCORE_DQRR_MBUF(index) = mbuf;
 	ev->impl_opaque = index + 1;
 	*dpaa_seqn(mbuf) = (uint32_t)index + 1;
@@ -1338,13 +1338,12 @@ dpaa_eth_queue_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 			seqn = *dpaa_seqn(mbuf);
 			if (seqn != DPAA_INVALID_MBUF_SEQN) {
 				index = seqn - 1;
-				if (DPAA_PER_LCORE_DQRR_HELD & (1 << index)) {
+				if (DPAA_PER_LCORE_DQRR_HELD & (UINT64_C(1) << index)) {
 					flags[loop] =
 					   ((index & QM_EQCR_DCA_IDXMASK) << 8);
 					flags[loop] |= QMAN_ENQUEUE_FLAG_DCA;
 					DPAA_PER_LCORE_DQRR_SIZE--;
-					DPAA_PER_LCORE_DQRR_HELD &=
-								~(1 << index);
+					DPAA_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << index);
 				}
 			}
 
-- 
2.47.2

