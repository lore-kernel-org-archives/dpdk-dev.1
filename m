Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FBAC56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 13:51:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E55C40615;
	Thu,  6 Aug 2026 15:51:49 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id 34AD64021F
 for <dev@dpdk.org>; Wed,  5 Aug 2026 17:44:23 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-81e69a2db34so18610087b3.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weka.io; s=google; t=1785944662; x=1786549462; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFoheVKnRk+xSJqbWzgzM1JpYAB1QRl+FHQ+7AzNf74=;
 b=MztGyj0ljDwCyUQWZAcqcVlswopMm4zO2dXNd0mcoLoq6qGQRW7VIZWb1zONERbEcH
 +xKd+ZI4NX04GGBtNXiCWC+YFwq6KSf4xFXgaWul1PF4DezjG8hkrEZqK1RE/hqbk5Eo
 2lJiu7vKQbXmqPoIPGH5jaMBNEwl0d3hUaTa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785944662; x=1786549462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JFoheVKnRk+xSJqbWzgzM1JpYAB1QRl+FHQ+7AzNf74=;
 b=Da5EE3LWHIw0g0GOwgjWHT0x8MLD6R2PFhsaaWVj/2x6JR5fNTU7qGWdTdt9xvKfpE
 DTk5IJxpvsPsRD3c5xqcbPoA+hiwZ1XUIWRtX5f084d8VREuIDsubxi5ye37txoOTnVg
 Q7zqgRrDrWtLJuFHTMPjPZqNp4SXXVVeduosUK/nk72MosChxg2SKtoLEAsXe2GEoTMz
 7RU2o1TwO9R2NIGMkdaK2unu9g3/HKgb/VhKFcNBh5FHn07Ol183miwqs1YLE186SFAu
 my8NcdnP+IeNRAsC4sR06MjiRrNTu8pGuIjOrcmDRgs1P0MZXXbE2XRuelmIeUpwfEFE
 Ys4g==
X-Gm-Message-State: AOJu0YyeZJ4qrv7oU4BvHQ2HuROsrDlSVClJPiRrtFGBOjhMon4f6XfP
 RByM8w2x45S+40xNFlu0Me2jr2gaBwmAcuo+Qi4z11vt3pE7b6JTTKGRsbos6dHuIZA6aKFcuxL
 UDIaH1vlbsSnxnA4NV+HUT1aBihmjK/0l2FC5sPxRFmiV4sP731hp3JOgI9eM1tWb3fwwFDQHaI
 km9U34x3VATaHGaZ689uqxUVyRixcabSfAcra0tgaB
X-Gm-Gg: AR+sD10vN6Ca7Y2roLHyyXTZ7EJmLkVbjP73MrHM+5WuRidSI0v8TwCZlOw+foBIFlz
 loHF95WIFHuqFnYrzrsUvasQlDcnCRS3vCjIeNcSwz7iddJExEXLxGIbiWNxgsa2GHk+U7LiHUp
 1QN5xr2NNRz2FUZVlbxtbibd4q0F73yfUP9NUP8FGaBu/j3Tdvu5LSk5W0ZoYgfU1RalGhUdQXf
 /p8g19fX5msHoM5cYoCf4tAXQhGUHQXMD6iVqV51lxzabrl+mQeYneaHn74qWFswP+PxkxFXFqC
 Fux1QMnh3uklZWTLP7M9y9mb+IpC18R8IvG0XRxg4He/3sC57O6ehu3a7XBcWN2l0NBl4nzQtot
 JAl1+fyUInkFoFkmhDAQA8JUFaT8RHz8uh5h52OAHpIBpgxfLLpOhrogOUVFAcDGLyvh/+M4/ao
 pt3gDiCwv5R1oaisiqz9wd3ovWuHn30pEeVlG7blauN8nhPFxkEPqjsY+NVdC1PX+3Y2IYQAMya
 1IH+AjAkcdDkMTzikGJIWuUz2irFXMblHyyLh0KgQ==
X-Received: by 2002:a05:690c:681:b0:81f:2825:de9 with SMTP id
 00721157ae682-820224e100cmr44784167b3.20.1785944662231; 
 Wed, 05 Aug 2026 08:44:22 -0700 (PDT)
Received: from rita-ruvinsky-Precision-3490.wekalab.io ([185.114.120.1])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-820134a9e21sm22878737b3.42.2026.08.05.08.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:44:21 -0700 (PDT)
From: Rita Ruvinsky <rita.ruvinsky@weka.io>
To: dev@dpdk.org
Cc: longli@microsoft.com, weh@microsoft.com,
 Rita Ruvinsky <rita.ruvinsky@weka.io>, stable@dpdk.org
Subject: [PATCH 2/2] net/mana: fix double free of mbuf on Rx WQE post failure
Date: Wed,  5 Aug 2026 18:44:07 +0300
Message-ID: <20260805154407.1965063-2-rita.ruvinsky@weka.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805154407.1965063-1-rita.ruvinsky@weka.io>
References: <20260805154407.1965063-1-rita.ruvinsky@weka.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 15:51:47 +0200
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

mana_post_rx_wqe() frees the mbuf when mana_alloc_pmd_mr() fails, but
the caller already frees the un-posted range starting at that same
mbuf via rte_pktmbuf_free_bulk(&mbufs[i], batch_count - i), so the
mbuf is returned to the mempool twice and can be handed out to two
consumers at once.

The free was correct before the bulk allocation rework, when this
function allocated the mbuf itself. Now that the caller owns it, leave
the mbuf to the caller on every error path.

Fixes: eeb37809601b ("net/mana: use bulk mbuf allocation for Rx WQEs")
Cc: stable@dpdk.org
Signed-off-by: Rita Ruvinsky <rita.ruvinsky@weka.io>
---
 drivers/net/mana/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mana/rx.c b/drivers/net/mana/rx.c
index f196d43aee..2bca004dfa 100644
--- a/drivers/net/mana/rx.c
+++ b/drivers/net/mana/rx.c
@@ -68,10 +68,10 @@ mana_post_rx_wqe(struct mana_rxq *rxq, struct rte_mbuf *mbuf)
 	int ret;
 	struct mana_mr_cache *mr;
 
+	/* Don't free mbuf on error: the caller bulk-frees it from &mbufs[i]. */
 	mr = mana_alloc_pmd_mr(&rxq->mr_btree, priv, mbuf);
 	if (!mr) {
 		DP_LOG(ERR, "failed to register RX MR");
-		rte_pktmbuf_free(mbuf);
 		return -ENOMEM;
 	}
 
-- 
2.43.0

