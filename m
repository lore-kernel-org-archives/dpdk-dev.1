Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F48CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 22:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75DD8402AC;
	Fri,  5 Jun 2026 00:54:41 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 8035840665
 for <dev@dpdk.org>; Fri,  5 Jun 2026 00:54:39 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2bf55c39e16so10620365ad.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 15:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780613679; x=1781218479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mvaz+3kKC3VgK2pnIrGdhj6b4Wm7smYFljlS6USPtmE=;
 b=Qu6EQnoojhm8qb6ZTLUI/aupr8Hst3byn5ip3ouEXMa5Le+tUylqhs7d+PbbpvFK1H
 YC/lW9BbsHXFqX9eVE56Ff6VesKAxPcH0IHEqxYQHKef3o0OoV0vBlQf8q5EPJDtV2+z
 /1YA3lpFEk02HOw/DPeTgMZOoqdB3yvKjWIsJyuLuvSO1b+3uaOc41izAlivJfWMYOsG
 d6h0F0Dh9J2ytN2PYp8Lcg104pZzK4nosyJQwD1HWnT+NOZbBojJZGeotHoHJMw5G7+s
 +RHb+ju9GilXZ0pM0MJAr3VIT/ELEC7Az6iyFpTKg0FhVMjaebH2OXxHQhOwOVd1xwO2
 E7zg==
X-Gm-Message-State: AOJu0Yz8jA/qWHUTkNdbk8nRaUkCehefHQCf0OUGoPSkXpBB4E7UZ2in
 h/s+qLybAi+zdbzTWftqlUVqMfbhc02XJN899vtcB9p8jM6vBmlGAwa3UV/ix7AT4Zn+8ZzSK/l
 mGo28OhasyUTlK1LLeurHRMaNPv/lrmY02JFQ16Asee829ICjzt9zYbMqhfD67w9nedGjl8JMUc
 SZh2woApX5mp63kXIwVMjzXraL9tRjyf+RC6R6LjQxX/A2KJLgLHP9Np/VgemJC8w8Tea5TJpaD
 U/A8Eko9e1V
X-Gm-Gg: Acq92OH5X2BfOSNY7HtBSQeqI2wPvl/2FX15n9e+GVo7wRCGE77YfVqIIBvAhEBPheD
 KTwFcl7V1i87JYAU8VXAf9hZiw06KJkJXHStEqgMiegkE3eZ4Da1TdGjESZJI1b+muBDUELzKgD
 9hjvSmpYBsJJ6Uc8BjXt/pHumzpBN+GCrkP7RSprNMn+pOoS3+6Be/7qES2J9NedJ7XuutMaH1u
 BM7gQ+MGSwHkLr7Pgvvg8yAHgeNgB/pvOrnd7sizYegFwfzmn7FQWHWUB6iWX++Diki52hPXDm5
 f0TTjivN87x+jfJuBCTS/eLASOKqG19/ALhuuzIr22DU4iA1HdisXozpDkppAHzyCyuQBdQ7Bc3
 2Du99BGyHPEx8lPJTN819QwEFw6GTtU73Uiwtmf8xkgkWHF8zBASxPj7VF+Hp6jFVGQ6qZLaG2v
 bP5HHhTenRLGmZqLRUWROQF4g4oPkRlQ==
X-Received: by 2002:a17:902:ecd0:b0:2c0:b31b:b19 with SMTP id
 d9443c01a7336-2c1ec7d946fmr154195ad.21.1780613678479; 
 Thu, 04 Jun 2026 15:54:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2c16648f2dfsm6771525ad.47.2026.06.04.15.54.38
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 15:54:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-517582695d7so30692701cf.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780613677; x=1781218477; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mvaz+3kKC3VgK2pnIrGdhj6b4Wm7smYFljlS6USPtmE=;
 b=WKGdP24w+LnP2CHTLqfmGv2eGx7kKSjeb5iw+EMzMNeB2NBnNpcX39lNUVUEsqFcR3
 xRCe8zgCVNPOtdGqxudNfvoxhK3dab0nRYfHS39sEMkKSnEdVL29asrtF9H0HEq0Wz7N
 C9LaOmLYC34oLXyZpTLAUI1M0vZqTH/zVORZc=
X-Received: by 2002:a05:622a:4c8:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-517987de912mr371481cf.19.1780613677286; 
 Thu, 04 Jun 2026 15:54:37 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-517987de912mr371161cf.19.1780613676756; 
 Thu, 04 Jun 2026 15:54:36 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd053032sm67043146d6.24.2026.06.04.15.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 15:54:36 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Zoe Cheimets <zoe.cheimets@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 3/4] net/bnxt: remove implicit integer sign-extension
Date: Thu,  4 Jun 2026 16:56:21 -0600
Message-ID: <20260604225622.2285191-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Zoe Cheimets <zoe.cheimets@broadcom.com>

In bnxt_ring.c, the result on line 389 was auto-sign extended by
the compiler because the arithmetic result is an int, but the
dpi_offset is uint64_t. Fix by casting the result to uint64_t
before the multiplication forces extension. To ensure that a
negative integer is not being cast to uint64_t, add a check in
the if-statement.

Fixes: 7a1f9c782b50 ("net/bnxt: add multi-doorbell support")
Cc: stable@dpdk.org
Signed-off-by: Zoe Cheimets <zoe.cheimets@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c
index ccca779b97..579b73d2ce 100644
--- a/drivers/net/bnxt/bnxt_ring.c
+++ b/drivers/net/bnxt/bnxt_ring.c
@@ -385,9 +385,10 @@ void bnxt_set_db(struct bnxt *bp,
 		db->doorbell = (char *)bp->doorbell_base + db_offset;
 
 		if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB &&
-				dpi != BNXT_PRIVILEGED_DPI) {
-			dpi_offset = (dpi - bp->nq_dpi_start) *
-					bp->db_page_size;
+		    dpi != BNXT_PRIVILEGED_DPI &&
+		    dpi >= bp->nq_dpi_start) {
+			dpi_offset = (uint64_t)(dpi - bp->nq_dpi_start) *
+							bp->db_page_size;
 			db->doorbell = (char *)db->doorbell + dpi_offset;
 		}
 		db->db_key64 |= (uint64_t)fid << DBR_XID_SFT;
-- 
2.47.3

