Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CE9CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:12:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3022F4067C;
	Fri, 10 Oct 2025 00:12:16 +0200 (CEST)
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com
 [209.85.128.226])
 by mails.dpdk.org (Postfix) with ESMTP id 19E674066E
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:12:12 +0200 (CEST)
Received: by mail-yw1-f226.google.com with SMTP id
 00721157ae682-71d601859f5so14866357b3.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760047931; x=1760652731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8awvPmoGY/dQQXwjK9SPQZOiFtuSD/X/fXdrTTHrXw=;
 b=IXJoPyG+MeBQggHZZir0wOOyyTtXB2J6tFXnijBwya67pAg60CdWONwLJUaZTt+Hxh
 cTc5uN0+g0e8/ZcUVX9sIMbN7enfuiIfXDXBh2E8rWmPhZIFsfbXko/6LQoFpzjrVBwo
 BoDV1XQxmeYihSj6Xo0+ysOGBz9s2lPVcMUSS2d0eeItesw9XKAaTJAuUA5HhzXSty5B
 Ja1WPmztgHKJXOCK0nSPbneRSukq9xNNXz6CO/zv+cdYmgD6iNqgsX+FM6PDfFTBqOxc
 +QEj8D5wAGr1mRvw77ysSj6Pl2f/kHm0a66dMhuRA1QNZ7ME+zZdXlPpVhh0pY2pT/Q3
 QoOw==
X-Gm-Message-State: AOJu0Yz5fjwVztVQDMCj6oSFUt3N/xUEPSizXmHGLyTbT/91vWbz6vKW
 /0qQxWwQUF2flFbMrJA4s5oQFR9bCyTYkeKgxTYS0agsEaz6vT+J40JxHhD8v4pfugihVahOuYP
 ZrI2fo4oUNU3DynT+ESv4u+okISqee3IEJcPNETj41qOZPXrE1mFX04G0h7gUPDNe4LvbaH5LGV
 kY60uxAwKeb0HXgVdMI2ySMPjFK2Us96EnCKSy3f/hMEXQH0brYQYRlyknMau02oonOyLh4A==
X-Gm-Gg: ASbGncvifreS5XM+OEmYpaWaPwLpHUiONuLOulwZbWZhJLl+mMagsxhNgGerhWpOdBZ
 7xbZBZQn58+Z2fTjA1V5ILMZuy3DEBtuDu3BvqxtoPFoqeM1sEd80bZZPxjgs/JO1tBe+ADbsZq
 mUolM71beqEY1kOXwECE7Io8wQKV5p+ZM1vjsOrfLXg1GRS9UsZDCYEMx0e1Nvvi63796fyWXbw
 18U4FVwwFZW1PK9oDbZeBE/bcgLrScLWIG1mUKPAqrYU/Z9LanKfUwCARKIN/1+RJe6z2cob2QX
 IxyaUtbfH8UwEZYU8e1oSxnpMwjTxEbMx2KUmBAQoucMva10kyWFw1ZQYPNyN46W9gidow2cTBF
 N5HMX6dZCnlVUPKxBoug219iB3sDHZLRkNaBbHQSftO6SPSr+PrpowMdfUs8MCq5s9NkfDbKBca
 jUUc21
X-Google-Smtp-Source: AGHT+IGPKUAGtMXXoPABtb7dmAMZWq5ZhP/DTvGfoQdjT9+wx5ztR4dV8e1jJBkBxqFRarSb9ly0pmZJvOEL
X-Received: by 2002:a05:690c:4a01:b0:764:b3c2:8241 with SMTP id
 00721157ae682-780e173e250mr102733407b3.28.1760047931167; 
 Thu, 09 Oct 2025 15:12:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7810701208fsm439027b3.29.2025.10.09.15.12.10
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:12:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-818bf399f8aso53360486d6.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760047930; x=1760652730; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8awvPmoGY/dQQXwjK9SPQZOiFtuSD/X/fXdrTTHrXw=;
 b=EbHYbq03a8YrCIs+aRAjEp9C0qq77x2uenL8oWMeP+EM6kfZ2Cw8SyCj2guuqEbuPa
 C4CnMulsa6h0L6n0aOj7WzvTo4rl/+UpyPD2Q4dSt8tlR+HXVtGegFz7I+7tfd6RqOBd
 h59ARpj6Bu8nOC7bxqVk3plMPBClV+qAI4snY=
X-Received: by 2002:a05:6214:d4e:b0:7fd:2bc6:6cb0 with SMTP id
 6a1803df08f44-87b2ef4f033mr116973416d6.55.1760047930105; 
 Thu, 09 Oct 2025 15:12:10 -0700 (PDT)
X-Received: by 2002:a05:6214:d4e:b0:7fd:2bc6:6cb0 with SMTP id
 6a1803df08f44-87b2ef4f033mr116972906d6.55.1760047929509; 
 Thu, 09 Oct 2025 15:12:09 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.12.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:12:09 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v2 07/54] net/bnxt/tf_core: thor2 TF table scope sizing
 adjustments
Date: Thu,  9 Oct 2025 18:10:42 -0400
Message-Id: <20251009221129.28256-8-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

