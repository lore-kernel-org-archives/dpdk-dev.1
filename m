Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5206BCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:05:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3826740B8F;
	Tue, 30 Sep 2025 09:05:16 +0200 (CEST)
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com
 [209.85.160.228])
 by mails.dpdk.org (Postfix) with ESMTP id 26ADF402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:40 +0200 (CEST)
Received: by mail-qt1-f228.google.com with SMTP id
 d75a77b69052e-4df2911ac5aso17213691cf.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192599; x=1759797399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8awvPmoGY/dQQXwjK9SPQZOiFtuSD/X/fXdrTTHrXw=;
 b=CAMnz3XVkdqgY27WKOrQhPb/6nBUACHAHlb+i+mbn5Glv0eUIeQy8RyJ8xLHre/nf+
 YQFLX339iWO0NG1NX+fDYAoT/p9/mrD0rRNEanT7U24l0qs/KOVEDWBeC79ReWQkN8L7
 lXdmDJJPnQp7laBLg0AbZJ4XsJhqh69IjpXhQ8PZ+pldnOKMBUqIhAI8JTsuThW/loSK
 DlqRmMrsoOdMd+A3AHFmfNS0uzj9p8wFvv3Xgldd6bQsJBSuEHqdbAzD/yRmWoQvREal
 UxhVeq3Pf9eBW8iT1tT0As8MVLzre8OsVhORLXSwPphJfSiCHEAH3Q9DI9tJus9izUDS
 6dgA==
X-Gm-Message-State: AOJu0YwNCkukIFChusd95KY7frQ3vHO77M4XbsAcMvgnVIGOXkF6V7DR
 BhHABp61ttqAlxharq/vi4imYEAObDGuGGYsje+M7YN4/bSEyqtHVEZM6yjqGl5KcFN4jVXrnBo
 8WXr/HFCA3pfhkLkt+gs6ZcYaayH5wDqMJ8if1GcmRx8Gc86jE1j/NtBDOwibRXjsphNhgr/e0R
 OuJN/zPkgFp6ovYwmxVAbczCcsdBkUGFxzKyoDN+59qiMl3BPI/Y4JdMI7qFv9jKVDvSjlLA==
X-Gm-Gg: ASbGncvRca6ClKHh/q3d+CZzKqTBzK3xsFXZ2RYfr7rhEyeurltHC2RpVtS7BMuhJT7
 wcKxKmtSkWZdjOvil04UoiN7epAS3344V9mHiOnuOf2F1tWycuwb2MNst158Pg2bJC5TKjLUFve
 19YEKOzqxtoHUmPKHcp5cpY5BGkmxFqkntSMis1x9dd4KUSz2+CPSm0kwArH8VKgd94YNUWWffB
 Zd4xHjq7ftV8YsDuofya34y2qGT/V/65RbN0m2N+5+gLODZxjW6peGdEXZMMcv8rkBj2rKQqgLx
 q+F+vhKYJv8/TXlLCM/Y/ym05YUKgu/AdXij8iOOx3W+4/Z6onIIMcathsNTTN3FEOPUjHFgTOa
 dx1OaLXjguMDIThxv56Uhq10VK2PAuBCXPrehKEwGRt34T31WzgcB05oFL6fKvzcucL2V8k+CK1
 gZ7A==
X-Google-Smtp-Source: AGHT+IHauKrZtF+036gnseS4DTka6vaCEUhpB6TCxvEYXd7ghHtS1MDbzEVbEAAvRS8lNxpHnDt2IaXR96pt
X-Received: by 2002:a05:622a:4e:b0:4d9:f929:1531 with SMTP id
 d75a77b69052e-4da47dfd7camr284747961cf.23.1759192599391; 
 Mon, 29 Sep 2025 17:36:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-4db0ee49556sm3435101cf.9.2025.09.29.17.36.39
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b5527f0d39bso7422040a12.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192598; x=1759797398; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8awvPmoGY/dQQXwjK9SPQZOiFtuSD/X/fXdrTTHrXw=;
 b=PShZVSWYuY567lVAzwUGIt5vNhzLXXBL49sbUfDEyYFVYXHd2dX/qPJwcLjtPLlWw9
 UO4GGXK3pACbmQQ7QANGD6ypjfNld0sdSCRU7+PgW03esxC+qo0q0Mea352jJLV4SXXa
 3JIXyC1I6xUfWXUO2ayvy9BmuEDPTrOkOSnWw=
X-Received: by 2002:a05:6a21:4d05:b0:302:9f3b:3e5c with SMTP id
 adf61e73a8af0-3029f3b3f6dmr11638863637.39.1759192597912; 
 Mon, 29 Sep 2025 17:36:37 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d05:b0:302:9f3b:3e5c with SMTP id
 adf61e73a8af0-3029f3b3f6dmr11638829637.39.1759192597348; 
 Mon, 29 Sep 2025 17:36:37 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:36 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 07/54] net/bnxt/tf_core: thor2 TF table scope sizing
 adjustments
Date: Mon, 29 Sep 2025 20:35:17 -0400
Message-Id: <20250930003604.87108-8-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:06 +0200
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

