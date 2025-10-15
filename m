Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E543CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:06:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B174841060;
	Wed, 15 Oct 2025 11:05:07 +0200 (CEST)
Received: from mail-oi1-f228.google.com (mail-oi1-f228.google.com
 [209.85.167.228])
 by mails.dpdk.org (Postfix) with ESMTP id 77FDC40EDF
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:06 +0200 (CEST)
Received: by mail-oi1-f228.google.com with SMTP id
 5614622812f47-43f50c2765dso3238294b6e.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519106; x=1761123906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ppYHn13KO0Du4KFq4Ryfa4j5VeeeZaQR4lrPcYj8NAI=;
 b=a01UesRRC24Vb7lzTlqzW416xJC51su02zdYw3J6KJOM9AWURLVKqRPmI0tURWRxDc
 yN91vvsCKTjOdLH3e4uXti3rIQkoQQ8au1k3mPGVtEWgPplwueWFWc1MLcES8Evw/U7d
 7ENoIj0EM4XDAtf2hHlsVj5ANYZ07crOTLh5OSE99Vjahe9D7yseg9MG5RsPXhCPnE/l
 SalY5jaCQ3BOfyCXYWbcONAZl5GG8eTtRT45hP0QzyxmuOhRgMEnF2Z5idL9BGXYH1sZ
 SewTJ7Wwdn94Y1a7FQI0ecJc8OeT/QUmKgTD8fYQo0WvCmQRJ1jphHSfPhjwrYmrBIFw
 wPvg==
X-Gm-Message-State: AOJu0YwDEKy1q6ofV6WmWtC7FyHMTloQEi+ApeJGuZZAggYTpuIrXaLT
 KOGMTsJGnMPkGKyQRXFYh+3CCJUFvWBoSrpUeQ7cQZ8Vpponx+nPSSyW2hAuR6zS/P3pmydfUE9
 OzOTYQPtueHAneNanM5XVe1ty8VgabNLGm7Ok4yjDjbd9cYzYOvAYOe8XcxM+7D47O3i1a8wRpP
 y+cvqfX+QUbTzpEH9wM0N8IR8PmbmOfPEuHRVix6mYvQa+UkN2x0TLgo8rHAgcxNh+Sl9QBg==
X-Gm-Gg: ASbGncvLFY1aQs1X56+AyR9g0v3vOAUmUOmtMtF4UcZLuxk3D4OBIftn2D54mM+lG9Q
 pRuv7gC4E972L+YR7gZ4iooczceZa/79koqfVSO8R9r7VCghdeAquGjjhTvsSeEFmO1G5b7yptE
 DHyqW1TWwtA9azuGBfMeXgmjuxycam1kaQXq2BqXRRPgAx4h0mIt00s9yBh3NQ+pWcRXdeCAM/U
 d94MDBHuD1wCwYf5gupjTE246LqJbL5SecOuTTxzDswCo91SKSSe4Nh10Ww7x+6zKIFGwesBQV+
 O7E/ixk6MsrG108UT/VBETWHUpgyEGqhscJyXCNL4b6ccbN2NuC/eL6bLUriKWYs6Dp2Ye0U0kN
 ICxvFSN/1eWxNYpvrNIeh87Uz9waqJAUUHJ/CggaHH0L+AtXRM6QdVt94+RnuhU3llDibL8Mo
X-Google-Smtp-Source: AGHT+IHzrKw5RUiucu7j1JlHhrYRN3JnhVt6tXVPoHIOpF8iS42z5Ggq3rVgxwkKg7syhkIUL2Rv4U8We+vH
X-Received: by 2002:a05:6808:4a89:b0:441:8f74:fb6 with SMTP id
 5614622812f47-4418f741cccmr8632364b6e.67.1760519105603; 
 Wed, 15 Oct 2025 02:05:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-6501803a003sm264941eaf.0.2025.10.15.02.05.04
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b6474cf4573so7037278a12.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519103; x=1761123903; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppYHn13KO0Du4KFq4Ryfa4j5VeeeZaQR4lrPcYj8NAI=;
 b=iRfV9eWl+sBVzNrf6hsvVXO9IaXHxlWHFvvwc459TgeoTr6IT6sxVWNT8fqNcz6SgN
 4nJEW6hmcUS4rlSeSWOkm6W/VcUvHUOcg46eAdd8koeOAYlTu+WJxXGIVBRXA443KDbm
 51pMGb5Jpfi1vSasEUnsKSZj0UblctgCGcLWA=
X-Received: by 2002:a05:6a20:5491:b0:2b0:ff55:f830 with SMTP id
 adf61e73a8af0-32da83e6971mr38601528637.51.1760519102989; 
 Wed, 15 Oct 2025 02:05:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:5491:b0:2b0:ff55:f830 with SMTP id
 adf61e73a8af0-32da83e6971mr38601487637.51.1760519102296; 
 Wed, 15 Oct 2025 02:05:02 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:01 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v3 38/54] net/bnxt/tf_ulp: change rte_mem_virt2iova to
 rte_mem_virt2phys
Date: Wed, 15 Oct 2025 05:00:08 -0400
Message-Id: <20251015090024.32250-39-manish.kurup@broadcom.com>
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

From: Shahaji Bhosle <shahaji.bhosle@broadcom.com>

Need to support --no-huge mode which allows application
to run as unprivileged user and does not have access to
hugepage mount point and files within it.

rte_mem_virt2phy() does not have access to physical
addresses(PA) without hugepages, so use rte_mem_virt2iova()
with vfio-pci kernel driver.

Signed-off-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c
index 4be2703740..c765e123fe 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr.c
@@ -62,9 +62,9 @@ ulp_fc_mgr_shadow_mem_alloc(struct hw_fc_mem_info *parms, int size)
 
 	rte_mem_lock_page(parms->mem_va);
 
-	parms->mem_pa = (void *)(uintptr_t)rte_mem_virt2phy(parms->mem_va);
+	parms->mem_pa = (void *)(uintptr_t)rte_mem_virt2iova(parms->mem_va);
 	if (parms->mem_pa == (void *)RTE_BAD_IOVA) {
-		BNXT_DRV_DBG(ERR, "Allocate failed mem_pa\n");
+		BNXT_DRV_DBG(ERR, "virt2iova failed for mem_va 0x%p", parms->mem_va);
 		return -ENOMEM;
 	}
 
-- 
2.39.5 (Apple Git-154)

