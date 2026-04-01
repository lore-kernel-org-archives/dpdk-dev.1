Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0F410F6FDC
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:41:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D47D240DDA;
	Wed,  1 Apr 2026 18:41:15 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 3D17040B94
 for <dev@dpdk.org>; Wed,  1 Apr 2026 18:41:14 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2c54c68db4dso6675608eec.0
 for <dev@dpdk.org>; Wed, 01 Apr 2026 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775061673;
 x=1775666473; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mVGlcgvYGzkfYc6dXrRCMEJ9rc1LlsaxfKABHE3Ue8=;
 b=ASNnsQFbTiWGAHsCrY+W8bc51cwxbA9kc6kvQz5p3l0nqrdHvcAzmNeq0PVJEx8efh
 UHVjzQKKZ59hRtBFFefiCIgAVXARYxCYml/CnqpKgkY89TskNgMmiXebLwuR1mww+cf6
 zGi/R3nZGZN2o8ORjJDFOO8SnaaeG7Rig4Dm89AjYWv7xHDZO0fmPNxcUVtUCk62QZqe
 BWmfNbE4o7ROZ3h1dznpEb2cmmFmqvWkbtpvDKTD/QPD1xf2Z32J81/lOlw4zJcplKnD
 9nYhBJ/k9AiMUcMBpDKX+SHv4eC1luII5tP0B56rweYqVpMA2EWppu+PcOJ+Ks8rwbp5
 fWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775061673; x=1775666473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0mVGlcgvYGzkfYc6dXrRCMEJ9rc1LlsaxfKABHE3Ue8=;
 b=M60/Cci5YbRF8Pt2CNZMllZFPkHBgvP50jOFG/EfMnaUmkEacGSS0QNjE0hYmo1tA8
 bm00Zzm2lhY+u+xjPN+z4HAdieOJ3ztmbuJF6GB9FGFdWChCGbg8yVez+gCQvTqWFjo5
 xF7L6H3eP9Jah4XvsidXTAVXinDo43Z8KpA6MPxYbLnJkzF5JJ6xUKKwQ8ktGVrjlXWp
 B8gA1qPXGt6LournioHDm/259L7vnLAw3OYLvMGJUcN5ZS4rcgOpmZSXCQ+9SoIQ8Qum
 1wE49H4nCMUm7tZY+9fOnVVIQ6/c3VMfEUCZ4UKyyPe4m/P/n9dlie82vHIk3xzDsajz
 ekbA==
X-Gm-Message-State: AOJu0YyhxlcWF5wVEyzKXPYV7D3Kcu08ISKChY8UymYRLeTMVcplRzSc
 yrCU/cJaU06KFXON8Z5xEXpm6oCEFfrZ8O3n/myt8uR/ecyxM31RfLX+9zWaPtTF+zEjEefLlHO
 9HFbI
X-Gm-Gg: ATEYQzy2NsLmsd23JO9arL41DN8DLg3sEpGDId1d7kfyTV0AcDiBR+F3cGdb9mGXr3S
 YNFWZqZfy6ZMZX0hQazSccL32A2uHiIaH2HeR0SSj4Dr5IHcABlQCLrFE8N02rePFgu/fjzSbli
 t4SaXSwz0bC5DaJ3JYzoW/rYn0SJKS+yoZymhap9aw5/xagyf+9VGUNkc2QYvJAbNzpO4v2KJF4
 PojdnLTBJRDnko55aWA5WibXlTCsmPnCusY08JLezOV7db1/XQelQcTmu/VEJx/1SVLNiYNeAeF
 DrlUKlD+MtpM/yDVwPfSRnnNZrN71jQltZLlW36uz5nuYYzUTaht6IBikkLxhBgUnGh4ObPgF08
 +eBoB6rb0n6e4i2C/Atp+Tt1Zyv/ZqSZ5MDl8AKbhDfOVMovXRTpPcROij3tqKiKNotVKvdhLjr
 CPHxAgJCx1zsFODGlb49l92cbKRg5pxIAmGm5PRuHZUmI=
X-Received: by 2002:a05:7300:320b:b0:2c4:4fcb:4f37 with SMTP id
 5a478bee46e88-2c932caa0dfmr2637027eec.27.1775061673194; 
 Wed, 01 Apr 2026 09:41:13 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca7c20c0c2sm202583eec.17.2026.04.01.09.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 09:41:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH 2/4] net/bnxt: remove unnecessary null check
Date: Wed,  1 Apr 2026 09:40:23 -0700
Message-ID: <20260401164108.201404-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401164108.201404-1-stephen@networkplumber.org>
References: <20260401164108.201404-1-stephen@networkplumber.org>
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

No need to check for null before calling free.
Found by coccinelle script null_free.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/tf_core/v3/tfo.c    | 6 ++----
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfo.c b/drivers/net/bnxt/tf_core/v3/tfo.c
index 4b1f545476..681d1dd8d3 100644
--- a/drivers/net/bnxt/tf_core/v3/tfo.c
+++ b/drivers/net/bnxt/tf_core/v3/tfo.c
@@ -183,13 +183,11 @@ void tfo_close(void **tfo)
 				}
 			}
 		}
-		if (tim)
-			rte_free(tim);
+		rte_free(tim);
 		tfco->ts_tim = NULL;
 		tfco->tfgo = NULL;
 
-		if (*tfo)
-			rte_free(*tfo);
+		rte_free(*tfo);
 		*tfo = NULL;
 	}
 }
diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index 23e1b59ca4..3707cd1a2d 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -169,11 +169,9 @@ ulp_sc_mgr_deinit(struct bnxt_ulp_context *ctxt)
 
 	ulp_sc_mgr_thread_cancel(ctxt);
 
-	if (ulp_sc_info->stats_cache_tbl)
-		rte_free(ulp_sc_info->stats_cache_tbl);
+	rte_free(ulp_sc_info->stats_cache_tbl);
 
-	if (ulp_sc_info->read_data)
-		rte_free(ulp_sc_info->read_data);
+	rte_free(ulp_sc_info->read_data);
 
 	rte_free(ulp_sc_info);
 
-- 
2.53.0

