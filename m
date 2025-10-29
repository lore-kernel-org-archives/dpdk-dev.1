Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713A8CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:08:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3F054066E;
	Wed, 29 Oct 2025 17:08:37 +0100 (CET)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id B61A44066F
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:08:36 +0100 (CET)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-33e27cda4d7so1232972a91.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754116; x=1762358916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8awvPmoGY/dQQXwjK9SPQZOiFtuSD/X/fXdrTTHrXw=;
 b=b+OfdMXwq0nIhEe7PZ+1R4O4A0CnAsH9JZg2jLUZxB6qIEzTWbU2Z42saAGWw3iFk6
 dfsUTb9dxFnyMnM0keW7MW9yDDQRobVQV019BsSqdiyTuRFyptm4jwbFT8Z3KDGWJy4z
 T0ydCCiEVn8/PDnIXSznapKRslk4F7r9eikPDdrz4wANrmZ77XiT5JWQ3dVaNpux5dyr
 ZOC6QpP3bhMJGdXfCWI/IFvFl7qzBBRN9+nm8By/7laJJ1VLDWFVE4ZCZD+nd/zilU/s
 Y8EClRavuBKB0UfCoVNrXmgpJcRzDcBPbNXcGR5HFsAE9r77EzJ1p4H/Yca5ATNYXHej
 3mLg==
X-Gm-Message-State: AOJu0YwyyCBKPeGdXkDYATdUp3PmYPqjCinrT/R0B+KlRTnOkIVGq1vc
 epbyH0ImrdefKe9eoZ1qlW0YETmxI8TDvLw+aOiTUWaNUcAgHBvWOTUy2GXNZJTIenUSJNiUdZ6
 n0uAWul/X9+iaDVBkBtPVg4OtYKm8SvBje382YFdeFMHnwW91X8H8wCMIhOYyrqnUn5bEwPLLiE
 WevAnlISOY/VFsv+D/VW6jNcjtlmSY8JJLaUT/0Cdv/Cz/SXViDIHMhdubLt9LiE4M5I5AKA==
X-Gm-Gg: ASbGncuMslB8vtmcZlBSq6obuzxmyKenV5hgh6lcwuPOk14ymIu+oh5dSs+LDxtSQuc
 a5QazUUJq7jMkXHnxpUHwqPlKisFN4PdzEMxnkuqJp/z97l1vtzC9BO6jaKoN1fh9BRfN8CtAYg
 fzMFOcCXXESCXeXo15iJhxaVVZGUPLOGMGO4a3damGF+4UAMbYyjg/kuiuULSyStVP7sK880GfU
 Ha2/FjA4BFw8wyGxBtxir9vSNDj1lxueh5mz+05wqr4HcYU/00vB8x/pxEETfVZ6gCg0zIhMDat
 5j4NA8yizwBd4s//6wKLTriXpHqb4qpEXe54mpYgPpAEZ87wQ6y6vk95BdxCb7gVAYdAlJcuJxH
 hAF0iGlLZrYUaJ3MsUaNioHPn4sTVboK8fPTX/TJllsA9sVcG58IlfpDvOkq3tAoBJJKDGl0Os4
 2YgiGgn2U0zRXXncOLzNJ6HnGUVRSfnkqIboQS
X-Google-Smtp-Source: AGHT+IF3RNkWEeeevIgMd/UIF7aKBvZT++pP/8q8kVjgE3AHALFxUygoGeUkzOCilj3alNULPg9JKGQuz9Dq
X-Received: by 2002:a17:90b:388a:b0:32e:3592:581a with SMTP id
 98e67ed59e1d1-3404ac7ef11mr139147a91.17.1761754115597; 
 Wed, 29 Oct 2025 09:08:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33fed7e5521sm1340669a91.8.2025.10.29.09.08.34
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:08:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a2594fa114so25382185a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754113; x=1762358913; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8awvPmoGY/dQQXwjK9SPQZOiFtuSD/X/fXdrTTHrXw=;
 b=bodenhccy90hq3pePZbKJHN3nZAijf+PrddnhMs8jOBt5drY7xuye/P/wT5Rg+Hfaj
 e9y7y6Cu1wIsKGEhI16IDsXp+m8WDnOsA1affjGQf3UIYG8ACKg8EIrul+zpIGGGNqEm
 TkVigoh1iYQyH9rGeqgpWGeZpdosG2Ker7UAM=
X-Received: by 2002:a05:620a:44ce:b0:89d:3318:a811 with SMTP id
 af79cd13be357-8aa2ab3d3b7mr22872685a.15.1761754113533; 
 Wed, 29 Oct 2025 09:08:33 -0700 (PDT)
X-Received: by 2002:a05:620a:44ce:b0:89d:3318:a811 with SMTP id
 af79cd13be357-8aa2ab3d3b7mr22866685a.15.1761754112973; 
 Wed, 29 Oct 2025 09:08:32 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.08.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:08:32 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v5 10/57] net/bnxt/tf_core: thor2 TF table scope sizing
 adjustments
Date: Wed, 29 Oct 2025 12:06:25 -0400
Message-Id: <20251029160712.58519-11-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Farah Smith <farah.smith@broadcom.com>

In order for the pool size to be calculated correctly flow counts
must be updated to the next power of 2 so that the pool_size_exp
shift can be used correctly without losing pool entries due to
rounding errors.  Also, max_pools must be a power of 2 for same
reasons.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 88863ed6ad..e7b82eee49 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -86,6 +86,8 @@ static int calc_lkup_rec_cnt(uint32_t flow_cnt, uint16_t key_sz_in_bytes,
 	unsigned int flow_adj;	  /* flow_cnt adjusted for factor */
 	unsigned int key_rec_cnt;
 
+	flow_cnt = 1 << next_pow2(flow_cnt);
+
 	switch (factor) {
 	case TFC_TBL_SCOPE_BUCKET_FACTOR_1:
 		flow_adj = flow_cnt;
@@ -924,6 +926,12 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 		return -EINVAL;
 	}
 
+	if (parms->max_pools != next_pow2(parms->max_pools)) {
+		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n",
+			    __func__, parms->max_pools);
+		return -EINVAL;
+	}
+
 	for (dir = CFA_DIR_RX; dir < CFA_DIR_MAX; dir++) {
 		rc = calc_lkup_rec_cnt(parms->flow_cnt[dir],
 				       parms->key_sz_in_bytes[dir],
@@ -941,7 +949,8 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 			break;
 
 		rc = calc_pool_sz_exp(&parms->lkup_pool_sz_exp[dir],
-				      parms->lkup_rec_cnt[dir],
+				      parms->lkup_rec_cnt[dir] -
+				      (1 << parms->static_bucket_cnt_exp[dir]),
 				      parms->max_pools);
 		if (rc)
 			break;
@@ -1033,6 +1042,11 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 		PMD_DRV_LOG_LINE(ERR, "tsid(%d) not allocated", tsid);
 		return -EINVAL;
 	}
+	if (parms->max_pools != next_pow2(parms->max_pools)) {
+		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n", __func__,
+			    parms->max_pools);
+		return -EINVAL;
+	}
 
 	/* Normalize page size to a power of 2 */
 	page_sz = 1 << next_pow2(parms->pbl_page_sz_in_bytes);
-- 
2.39.5 (Apple Git-154)

