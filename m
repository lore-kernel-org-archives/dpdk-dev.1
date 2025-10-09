Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20D9CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:15:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2510E4066B;
	Fri, 10 Oct 2025 00:15:32 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id 012F34066B
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:15:30 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-71d60157747so14980727b3.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048130; x=1760652930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3QDFoWFB+cEq9OUyywXDabkxOCbl/adbGvZIBIcM9Kc=;
 b=eHsL3pF6YP8zMJ3Iu6u0cdMT2+FzazGEyZmdxaxdHX/cIhon/zDAyxUUupMAyJVM0g
 adBOPeJNzhGxHOCWg85fQZDdgIivCp4wE0THNddsihejiWtga8PuRL1D2XaPjzSqyrjh
 fGtMfs42TuGHYuJ7FUT+qBioV6phFBMEoBWXdaQuTECaGMqgCCSjw2v2HSYJbuyoZvOx
 DkmlAraj5JctDLhJftp4+RdyA11opkJaPtA4/DnguiN3vssfVDxm4lkY4OOCNjoP8jtk
 da3TRN3i/v+95ulNMwDa2GjT6A7nVupT6uIoAQOx904cA3ol2Bl1/40DmTaNMxEEbGHA
 J1mA==
X-Gm-Message-State: AOJu0Yyf1hoRH4c1BLGL8U3OGEERXUYm7r7cu6NuLdshn/8CljiEWBGY
 GxEU6l43+nsiOpLKbBpbXLyqbZWIzi4zXCp/38Z2bIZGORnFmYCS3LQI4Ucqqco7KQTkpqe++dS
 9fwdw5IeKxcyMjFJmXqFdzpu2GCCmn1BDRx7MVz8Ux8iceqVqu6ZbEWyFDp0NJ9niD0vu1Tsgza
 y9hgIPp4aCi8Em17gKGBd1pSKhThLvjBR+zc5D3FNL5Lli4Cq1R9829abIKxWINuH0RzB76Q==
X-Gm-Gg: ASbGncsiMgB1ez4sPCbEd+axnK/5hZt9PcoXawJl5nUJyNRwBbE+5kep1A6znl/AaeP
 MUgLfwIzUjQ+arMJg4N2FxnipuDTdD+bwgIjEC8LNnSQCy2mucxrmBaaN3GZxQMRJpQ43XciFtL
 5Ze+HE5y5hxEfNcD9Lm2bsiqtjonmzcG4+A5ZwWAdCzELMhuHglLtK9iyo3lq/qMqD8EGa90ejW
 N1cCKE1m/iCIWslK3L6pNLEYM9EChOjNv8WrFxCd+saBx6S8NZlQoOXo7VopG4gH/tnFP3iKX42
 Jwi84FyHOU5wPRzPDjB6ymakqPF2PgwABXK45XLJN3+hF1fVV1qhuoUMfmNkd7MNIUV8rfBHHIZ
 NXxPyqbNsdcxxvzyQ7pcLGlZvdeiit0DukGMcGEGTX4uj0rFSljo9igHz8Ir3hQ7A2rDH2oKdFV
 eFPtW0
X-Google-Smtp-Source: AGHT+IFlxdbqFrOf86cW5xriYzLGIdCX/k2VIJkW8p3GAV5dVeLP4WPiRzGK1qgBAw8dQtlOBwJO4pElAyVr
X-Received: by 2002:a53:de02:0:b0:62d:cb07:f098 with SMTP id
 956f58d0204a3-63ccb854de4mr6710914d50.18.1760048130085; 
 Thu, 09 Oct 2025 15:15:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7810700506esm377787b3.25.2025.10.09.15.15.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:15:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-803339f345bso63155696d6.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048129; x=1760652929; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QDFoWFB+cEq9OUyywXDabkxOCbl/adbGvZIBIcM9Kc=;
 b=Tnzsb2Ag4XEqqYX4j/Q40eHEWsC/baif/PsOQpvMBO9c9hjWaNNtUXGSSKuRM1xVsQ
 sQgF6aucnaraR/2+iWBEDYwz7osOMfvlYCEWaq721j9A7xxjnVibeLZrakkDsgLb2Q06
 u68ZAayhYXFuFY1tCJANiOC3PHXIOYalE1/ic=
X-Received: by 2002:a05:6214:8089:b0:87b:b925:3c42 with SMTP id
 6a1803df08f44-87bb9253e8cmr46739656d6.65.1760048128990; 
 Thu, 09 Oct 2025 15:15:28 -0700 (PDT)
X-Received: by 2002:a05:6214:8089:b0:87b:b925:3c42 with SMTP id
 6a1803df08f44-87bb9253e8cmr46739266d6.65.1760048128522; 
 Thu, 09 Oct 2025 15:15:28 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.15.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:15:28 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Jay Ding <jay.ding@broadcom.com>,
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v2 14/54] next/bnxt/tf_ulp: truflow fixes for meter and
 mac_addr cache
Date: Thu,  9 Oct 2025 18:10:49 -0400
Message-Id: <20251009221129.28256-15-manish.kurup@broadcom.com>
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

From: Jay Ding <jay.ding@broadcom.com>

1. Thor doesn't support meter stats. Add null pointer check on
   ulp_mapper_mtr_stats_hndl_del.
2. Increased the number of mac_addr_cache from 512 to 2048.
   Changed the data type in an error message.

Signed-off-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c | 10 ++++++++++
 drivers/net/bnxt/tf_ulp/ulp_gen_hash.c   |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
index bc48e35c00..7f6a84e699 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
@@ -598,6 +598,16 @@ bnxt_flow_mtr_destroy(struct rte_eth_dev *dev,
 	if (ret)
 		goto parse_error;
 
+	oper = ulp_mapper_data_oper_get(ulp_ctx);
+	if (!oper)
+		goto parse_error;
+
+	if (oper->ulp_mapper_mtr_stats_hndl_del) {
+		ret = oper->ulp_mapper_mtr_stats_hndl_del(mtr_id);
+		if (ret)
+			goto parse_error;
+	}
+
 	BNXT_DRV_DBG(DEBUG, "Bnxt flow meter %d is deleted\n", mtr_id);
 
 	return 0;
diff --git a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
index e8cb1a3784..74cdd5c1da 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_gen_hash.c
@@ -33,7 +33,7 @@ int32_t ulp_bit_alloc_list_alloc(struct bit_alloc_list *blist,
 		return 0;
 	}
 	jdx = (uint32_t)(bsize_64 * ULP_INDEX_BITMAP_SIZE);
-	BNXT_DRV_DBG(ERR, "bit allocator is full reached max:%x\n", jdx);
+	BNXT_DRV_DBG(ERR, "bit allocator is full reached max:%d\n", jdx);
 	return -1;
 }
 
-- 
2.39.5 (Apple Git-154)

