Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2B1CD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:18:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E0CF40A81;
	Thu,  4 Jun 2026 05:17:22 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id E4FB140A71
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:20 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-36d6bb38b44so144449a91.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543040; x=1781147840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sT1sGOaMDAWk16ZpkEcK2lk+IIkPGasy10YVZBKpuQg=;
 b=Z0e/TfAcuXYVh06eu+cium57pSYro4QKixautap8E7HF4Zaq899ulTPnxQitCe0Sdm
 +do9SP2Zula/ih1p9ukVakSYDMm0Dl0ESv/WbS2HwYrrMfXG3INGlK3NzpRly4miVlG6
 8iCw6vQdChLcQSPcxDeHm4NQ6wY7LicZ/0bytz3R7jY4Xes/npI08PhOJk/oVKsHXna3
 WJwivgV0ShukYCrUTnE92WpezogR6jbYmmRxSQ63FBfMUswjZY7cexoZ0rni+YTZd/4s
 3VtkpU1dnunfg/H5aww5HOVkPWydSiZQvitisNIw7Yp6Pxq84s0Gc/M3MKU72G7Io2g0
 Nfpw==
X-Gm-Message-State: AOJu0YydcY90N2Xq/XSPIfBQXUd3NpbrWGu+R269eLoIdVOC61+VA6h9
 sqUMRNd3x3Pfh28vPN6T9kDuef72/OnQ7lOBbjprqtGNWztFADk4y09zs+KhwLj2PgWaJpyBs7q
 OVj7x0LgJvO7zi8CBVpS8oBLVBvx5SD1wcEGJx7MMN7Gv7eLln52nOJ3J4nXbqD+HjsUZmOnmGR
 uwPRBzCC9g6PX7763qiMj+EIMPS8C45b2OZ/8R1Sbdxb4DB47dDjEg3KvfA50X3L8BvSb9BttYs
 FScDAqb7rLd
X-Gm-Gg: Acq92OH3+iWBrtui2+K1xWWEAnHeGejVGXDWluzFOhOwB1Hq6wJrRHMQgUKf5PToqhw
 UiGjpGI5JeejSQrchO3j+8U6gkiO4Zj+/ikTzwXg/rC+FblymhlSY7oqpaQGzrBGMgxaU2KzGi5
 KoTsas+JJxP8vQ52sRK2qlvcIGWgQs1JzTEVVRjeYzKzDfGhoEs5v+ENrK52e4PGu2Y/+rvfVpM
 5tCBtc+PwtF0EdF1mBtJCD23+1u6bxnMfazMmoI9LbahyY8Xz7IACqqHIN8MIiMtGOo8wicVDJs
 c5F330UVjCfSwUxwHP8YKZ1FijBgOA7QxUl/YQUeyx0Mr5xKMh2c+hcq1VKGiuLq/bw31upS8mU
 kdOihmgm3kzshEQCM58tLnA8TRtlWWTpRTbRzozl2ehup0zMfYmKoBbUvSPyCAI1fdFT7su0CDU
 0Y39C46QNxhdHiswnGByY86G1k3FeXPp9wVYRo/U12nogk7lRiHFRhRU+UZ5JC1cLsXbOr+gH8K
 RLI0itINQ==
X-Received: by 2002:a17:902:c948:b0:2c0:b4f5:41d4 with SMTP id
 d9443c01a7336-2c1644ccc6emr67259175ad.41.1780543040011; 
 Wed, 03 Jun 2026 20:17:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c165f9fd9dsm3991005ad.28.2026.06.03.20.17.19
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915767b341eso29279885a.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543039; x=1781147839; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sT1sGOaMDAWk16ZpkEcK2lk+IIkPGasy10YVZBKpuQg=;
 b=Z81dpyU9bkkxBhHz2UVy28Y0cCRj21PSSX4R5dD8pU+138teU/FxzuFGWDRi3eozsd
 5QIqnNdTYu4hYz22U0mO1+7XFF5/aUnaQIW2xMzAJ7qSl56xGfeo63lq8iFoDnXB/Agx
 ob1kwOmEsmEtS331n/LAgGvE+4dIBAdUoIXEU=
X-Received: by 2002:a05:620a:6ccc:b0:914:daf0:d97f with SMTP id
 af79cd13be357-9158a6cbb8cmr1027812985a.9.1780543038819; 
 Wed, 03 Jun 2026 20:17:18 -0700 (PDT)
X-Received: by 2002:a05:620a:6ccc:b0:914:daf0:d97f with SMTP id
 af79cd13be357-9158a6cbb8cmr1027809085a.9.1780543038268; 
 Wed, 03 Jun 2026 20:17:18 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:16 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 09/10] net/bnxt: add vector AVX2 burst mode indicator for v3
Date: Wed,  3 Jun 2026 21:18:50 -0600
Message-ID: <20260604031851.2267548-10-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

When querying the burst mode while the AVX2 RX vector
mode was in use, bnxt_rx_burst_mode_get added nothing
to the mode->info as the bnxt_rx_burst_info was not
populated with an entry for the v3. Added an entry
for v3 in bnxt_rx_burst_info.

Fixes: 15276ba987bd ("net/bnxt: fix getting burst mode for Arm")
Cc: stable@dpdk.org
Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 791a89f040..63f9f6fb48 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -3326,6 +3326,7 @@ static const struct {
 	{bnxt_recv_pkts_vec,		"Vector SSE"},
 	{bnxt_crx_pkts_vec_avx2,	"Vector AVX2"},
 	{bnxt_recv_pkts_vec_avx2,	"Vector AVX2"},
+	{bnxt_recv_pkts_vec_avx2_v3,	"Vector AVX2"},
 #endif
 #if defined(RTE_ARCH_ARM64)
 	{bnxt_recv_pkts_vec,		"Vector Neon"},
-- 
2.47.3

