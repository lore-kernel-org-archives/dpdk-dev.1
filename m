Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1F8CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:01:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF5FB40DF8;
	Wed, 15 Oct 2025 11:01:27 +0200 (CEST)
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com
 [209.85.166.97]) by mails.dpdk.org (Postfix) with ESMTP id D6DA240DD3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:01:25 +0200 (CEST)
Received: by mail-io1-f97.google.com with SMTP id
 ca18e2360f4ac-911afafcc20so252643439f.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760518885; x=1761123685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8awvPmoGY/dQQXwjK9SPQZOiFtuSD/X/fXdrTTHrXw=;
 b=FED+cMvxN6TzaVXlpItYIq3BZSnnydzIVYox+xzTEXfok2DuNHb0YWin7RAZwypLOq
 GTUb5Rfc4j0HqH3eU8GvOZWnbcrUCCf3e+W2ZD8iZ+d/xSt4MpDOAZ4SORIi5rAT0vo1
 /bAF2QYVpNtYW2I+JU/LjQo47oCiJf20qAEq9QlFfwaNMNrB6Xq4jt4ea2E6o/YU5RBq
 XnjUYagi6Xubi2cDaVsI4p/1BE2NbrRcNXDvawK4XcULZaXk139w7QjWA5+ATdqbuQ6c
 LUh0v2IDC8q4M/kKDsHEXV5fZUdCpJCe0y1vaeONvYVPFWH7J6+3a50PEHU1fpXgzOII
 RsHQ==
X-Gm-Message-State: AOJu0YwdDYVutI6X1asgZdYks0ktZHOxT8bfIFD02FBZq+4x9wFDQE99
 fbmsnVXrqNLiC4t70yoFCebPoV692sOJyc/G7l/wj5HdTRoeKEE0IBvJ8EsbYaGN+3jre/w84zj
 3ZhmkroIiZBXrs5kVL/WLUuBd+ZrKlsoQZEIfAkbiG7W/2XBKzA9gLbJsyeK1gV2FkGOFEseYkv
 ahXcFeLE1q5+dWvQEOUm5fKrIaa5YMF/lkr4dSs/8GjSieHFYeKx/8NVw+s2s+Xrs4TcbAuw==
X-Gm-Gg: ASbGncsdQJB9H7Z1yKmoiM53zGmfEcNoTIkd6BQHVN9XjDd+EPh8jNKoPewf0j45mqz
 lNAtYC1zsF8P9YOVTBebZZG+9I0t47YsP87QXMRe5XFlBj5N1zcBPe7VQzDNv6abay4AnpfVihz
 SKBx3AFfu2Sn5fAzhd5RCJO5O0QZ0/Bb6oK5LhkudWOx7+WLeH12ahxhYwNOVZyHIJyhwxdL8mi
 9RsIckxHmI9jyyAH/f/ECAWUXoLZO9aNLM10lVjpDLhQ15GysKg0CS7g21761kevYxo8+wXUExN
 NAVN0LRKak/UrYbjsjCa9hJlGBHv/+Dfnr1Hg0iQwRxIBIqlqkSZBpmb1evcMCk57y8U8Ddfndc
 d9iKxZvxoaGTGsa7sGNMMjRjidIQNMjiQi52gWIIAvSjhvRMvNPuIZvtWhpNC9Q6ZCrlEbL+7jM
 TvjA==
X-Google-Smtp-Source: AGHT+IFNxxUX+kzs+ROkThLtxPobitLJExdNsKttaD+HqLR//xH0GsanIM2bgmAarkiKUVyjgMrNey5+wgps
X-Received: by 2002:a05:6602:15ca:b0:93b:d8a9:97a1 with SMTP id
 ca18e2360f4ac-93bd8a99a47mr3074539139f.0.1760518885014; 
 Wed, 15 Oct 2025 02:01:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-93e25927e95sm87347539f.3.2025.10.15.02.01.23
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:01:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7a144677fd9so1734458b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760518882; x=1761123682; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8awvPmoGY/dQQXwjK9SPQZOiFtuSD/X/fXdrTTHrXw=;
 b=fGc7fqhTRtpuamxu7TfnSQOPyczhj5tHIbDCRWerDtnxaT8zwZex6hxWkam7Dj4hMV
 QISEjQVU9CaRAGhv8Lv1hFZ8ayK4VPRBxpGZ/Nmm7EpZKq4qquFVS7nocHTXYcS7Livk
 H7PAkxqQJcL1KaNwTfgqwm+/wrICO4/Jn6R7Y=
X-Received: by 2002:a05:6a00:398b:b0:77d:51e5:e5d1 with SMTP id
 d2e1a72fcca58-7938723dab3mr32187279b3a.19.1760518882232; 
 Wed, 15 Oct 2025 02:01:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:398b:b0:77d:51e5:e5d1 with SMTP id
 d2e1a72fcca58-7938723dab3mr32187237b3a.19.1760518881557; 
 Wed, 15 Oct 2025 02:01:21 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.01.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:01:21 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v3 07/54] net/bnxt/tf_core: thor2 TF table scope sizing
 adjustments
Date: Wed, 15 Oct 2025 04:59:37 -0400
Message-Id: <20251015090024.32250-8-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

