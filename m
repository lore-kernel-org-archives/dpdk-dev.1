Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2CACAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:10:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F70840695;
	Tue, 30 Sep 2025 09:06:17 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id BD5E1402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:33 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-27ee41e074dso49144055ad.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192653; x=1759797453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaWEVold8cuQKjp13gcJ5y3xDXeDF5ZOcHOfLvjvyAY=;
 b=r8A/4+4X9j4VhdFfbWq5Kk5X5ow5Lsp8FFBBWoXIVMQCo/ArK+92vdoat24pB6Q9iS
 JpGHqTDOSgHcshSmKeoiA5pqWxD3cir6n7IZF9nmKzRw1Rl6YYHtIIWJZxpW8b98DK8o
 F0JkA4SeHbEtAiPXQXBcTEZOoqAARllbZxDve7tiNHN2TUJ/PJolwicMWTDzpvbB5dnN
 loWrIBY9qF6zs0dVIa2XbvlFQKsBa70fGEvX0XZ/40oi+4sns66/E5K77SDHiALEveDV
 PnwR4D7CdvDV60+SEz/W+O7RTymbn11xikgaIBllhDGPOOJhngz2u3TQwDZySPvMWoD3
 W/zQ==
X-Gm-Message-State: AOJu0Yy4bDRwJHuTrFD3eFgxZk/Ai4UxqmJQarHYVuryuvN3NulkStso
 S1C4cO3zTwZWja6c0fWIVr0yV1ouJJRnPoPOmhoSvWzlOiAPwF5APkT42HkN8qfGgx5zOWaZ004
 Fx73PmLyB60nLDUZ45lXW+zsJB2okGsS0jqNlkWIF2NuvHE5cbitb8kmlJII6ESBZHdnp6ojHdh
 Y5I0OVKJF+mY4sPKvY+/kJpqYI5Ocxr59IbzhuJcmm2lyj6oAGAdOkuJmYH4grBaRT/4Zolw==
X-Gm-Gg: ASbGncsxKS+qkJNPhbsGnnxF4Y+blPmrgBMGkz4WfF4JUNa3Hj5f1OxcRnvQqplgshX
 pyy56MHE7Zbg/oysksY+9rgaPpvuq489M23XW9RXCFT2JrLSAvv+qCMxrMxiDGpKw9K8eqDX9lZ
 dX+1598Q8gSDMIVgU4WETQY7HKltFZ/Yha+iHFpv9IqsbBo4IGSh5pYr+aAQf6S/ZzZ2//CDvyn
 lh6/NcBwMW71EDU9HC90BLNyoqdhp62zl4v0OxN9nypLXCz0czI2tfcJUfUwpa3eS2hz6qXbDUR
 rfkR+XBxwaNg8VFqBHNwJGq9Wl6MGcy4aDrH8o1+zPafEwDUiiU2IK/b527fc/kX2ciqsNxyaj3
 Ef7fr6jjrBW2gX4HwyNBPoAM4RnhQFDstR0w8kAKD46gGM57c3Tf+9W0rLD1b3cDu8XvxwGXPkP
 8/ux8E+WU=
X-Google-Smtp-Source: AGHT+IGMb0OU8WJwducwLfzG2cpSg9TV0Bo2ljMbsDiuf1c55k4mwCk7hUyperVHPbNHWNNlx+ztwB5pnrUr
X-Received: by 2002:a17:903:3c25:b0:275:2328:5d3e with SMTP id
 d9443c01a7336-27ed4a17a93mr212250695ad.18.1759192652904; 
 Mon, 29 Sep 2025 17:37:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed66bbbf4sm10586915ad.11.2025.09.29.17.37.32
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-78427dae77eso1845012b3a.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192651; x=1759797451; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZaWEVold8cuQKjp13gcJ5y3xDXeDF5ZOcHOfLvjvyAY=;
 b=AWpiSEgjJfod5MKCeg5MJo7M11aPnFBtrEfbUg9VymyVDcAYHjuIsc1bc0HeRExIXN
 yL0kM1mUP6mdQts2ocUmv8x8pmHtdedSd/Tef8L75D3odFWcySdQEH3j6aC0kBPdGG0C
 qky4w8rwe6LZmoWpQBvRgOUxrTNoA0cMiIIVU=
X-Received: by 2002:a05:6a20:9188:b0:262:23dd:2ed0 with SMTP id
 adf61e73a8af0-2e7d437af01mr23670214637.31.1759192650827; 
 Mon, 29 Sep 2025 17:37:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:9188:b0:262:23dd:2ed0 with SMTP id
 adf61e73a8af0-2e7d437af01mr23670185637.31.1759192650247; 
 Mon, 29 Sep 2025 17:37:30 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:29 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH 40/54] net/bnxt: fix stats collection when rx queue is not set
Date: Mon, 29 Sep 2025 20:35:50 -0400
Message-Id: <20250930003604.87108-41-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

When rx queue is not started and the stats context id is not
allocated then skip the stats collection.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/bnxt/bnxt_stats.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 9d7cdf925d..697f9ad9fe 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -656,6 +656,9 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (!rxq->rx_started)
 			continue;
 
+		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+			continue;
+
 		rc = bnxt_hwrm_ring_stats_ext(bp, cpr->hw_stats_ctx_id, i,
 					      &ring_stats, true);
 		if (unlikely(rc))
@@ -717,6 +720,8 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 
 		if (!rxq->rx_started)
 			continue;
+		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+			continue;
 
 		rc = bnxt_hwrm_ring_stats(bp, cpr->hw_stats_ctx_id, i,
 					  &ring_stats, true);
-- 
2.39.5 (Apple Git-154)

