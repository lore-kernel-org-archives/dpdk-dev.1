Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDAEC2A09B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 13:07:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EBE640A7F;
	Fri,  7 Aug 2026 15:07:04 +0200 (CEST)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43]) by mails.dpdk.org (Postfix) with ESMTP id CC6484060F
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:26:55 +0200 (CEST)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-66843536f94so3348025d50.3
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weka.io; s=google; t=1786037215; x=1786642015; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SV+1fwiYf110porWwfyxdrLwi+GbXoj206WHly05qT0=;
 b=TLIYrhrU5L23dLU1vQgSbrCbGd5aDqyOUO8xXG/VbdczXEvZ0afhUdvzR5mvcsmIT/
 EfttTyd6evVTIGZdAfR+Wxv/hEBM5hr3BhvKBGBT0289LaKGLzdJcPV6ZwZur2ZZXqod
 QTdtDGOcOO4VhiPESBQQW3E4nygJz7NxD2JW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037215; x=1786642015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SV+1fwiYf110porWwfyxdrLwi+GbXoj206WHly05qT0=;
 b=pu5/0H1xqJ1UtMPMLmuLIaqV3L9q7d5Hd5qpdUdvruqq3qTCHXLHGT0X8qHVgWZ35N
 N1aRjpep5A+wdjpGLK0DB0nRYcCetMTqZ7xDuqIPlHLZuXsKdF83oIGDVkoyihV+Vhai
 pisi6PrSoB6flmXr84X5/bTy9e2E4QZT1/Yz0DSYWuZrJ+UP9QXNlwjfW+WmupUkQKS3
 lqu/csoxHfEMXqEztrk0lDz8lZHnvB7Gynbx8zdngAOWh1ncEncahMiURjCtA3jKo/Jc
 UZP4uVQx7d8JbeiVJ0C1qZSeE1Rd6X6M4DDtl8ggrNWq8qMO5fu1++mwykzK8F1oAa2l
 I/NQ==
X-Gm-Message-State: AOJu0YzSyCRihMVP0p/ZYOgfbCNTlXPnsZTcpEjTdfdV0It/SZQJ8JuF
 G6PCFZCOAftSI7B/Ok/rOpF1jnemp76JktBSW0Ev2ciKPG9o5wbQ/FprQokLP5MLGj+96WOdVP1
 emKjfBCxjb79YNykwVwW90md13BV0cxy5912ylJ8dr6tgqh0MbFMqhPuzFDGJCz2HwQAHKG4dXB
 1otjTAF727PehEII7Gv18VFcU98+b2x9BT4xfrHKEjBF4=
X-Gm-Gg: AR+sD10O4MEHd1GBPcfG1khG70ND9FX1NripSkhnb8pLmLlQn/MVio93TPrf0FwBWaf
 bGTGQQH1Y6BhQPZogTmQGXR/lItrWr90j9NRoeR4Ak8FraD6iCUEG5wmUZHmnIxBjxugIMp1AS1
 a3GkOOkvlMGz6ig/7KreRc0y0XrmdNZ2zc+hxVk8kSX7dVXxEGfiINrHTB1ti7An5GJN+VI3ufv
 iIDsDQ/ho0KSXgMnZ5/5aS4nCVQEtIDUjftegNM+GNMvs+tIbuRskCP1asOPymOwY5VbcDMb4dv
 1uQ0r7O2VvswVKEwzQZDuCD6nTVxU+V7O5rpJE2ceNsBODdBY0DHHVUTC3M1iUdEzmg8SStlE3R
 GUkVWq53yAjD+VnrgbpUb4r1/HOk+0l8hSqvc3DFxtzNPb3G3WjImwhfM+2eIqjH027kgs+ujiK
 5P2A+I9PcwL5i2z+nuLRCmSHtz9KRnjckjL86jiegbKhac9dDiL+TNXeT+AVZqoLmOe+DJQgyd9
 VoRZkFiXyj+R0+XP8V1xroeBntbXrdwlBzpuSWBO21Cpq4lQH69
X-Received: by 2002:a05:690c:6e0f:b0:81c:89a2:dbce with SMTP id
 00721157ae682-8201f0c18f9mr106774857b3.3.1786037214846; 
 Thu, 06 Aug 2026 10:26:54 -0700 (PDT)
Received: from rita-ruvinsky-Precision-3490.wekalab.io ([185.114.120.1])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-82013261c83sm43073417b3.18.2026.08.06.10.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:26:54 -0700 (PDT)
From: Rita Ruvinsky <rita.ruvinsky@weka.io>
To: dev@dpdk.org
Cc: longli@microsoft.com, weh@microsoft.com, stephen@networkplumber.org,
 Rita Ruvinsky <rita.ruvinsky@weka.io>, stable@dpdk.org
Subject: [PATCH v2 2/2] net/mana: fix double free of mbuf on Rx WQE post
 failure
Date: Thu,  6 Aug 2026 20:26:40 +0300
Message-ID: <20260806172640.2456451-2-rita.ruvinsky@weka.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806172640.2456451-1-rita.ruvinsky@weka.io>
References: <20260806172640.2456451-1-rita.ruvinsky@weka.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 15:07:01 +0200
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
Reviewed-by: Long Li <longli@microsoft.com>
---
v2:
- Rebased on main (no functional change to this patch).
- Added Reviewed-by from Long Li.

 drivers/net/mana/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mana/rx.c b/drivers/net/mana/rx.c
index aedb05d46f..274c6e88ce 100644
--- a/drivers/net/mana/rx.c
+++ b/drivers/net/mana/rx.c
@@ -73,10 +73,10 @@ mana_post_rx_wqe(struct mana_rxq *rxq, struct rte_mbuf *mbuf)
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

