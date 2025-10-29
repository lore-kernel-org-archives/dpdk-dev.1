Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40324CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:21:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94C8140A79;
	Wed, 29 Oct 2025 17:21:02 +0100 (CET)
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com
 [209.85.166.225])
 by mails.dpdk.org (Postfix) with ESMTP id 1836840A79
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:21:01 +0100 (CET)
Received: by mail-il1-f225.google.com with SMTP id
 e9e14a558f8ab-431d65ad973so31320325ab.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754860; x=1762359660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ppYHn13KO0Du4KFq4Ryfa4j5VeeeZaQR4lrPcYj8NAI=;
 b=T9nO+yygVOpHS06NQTIcBByTv0UFs3hsMInjEEOeKw7hC4UgRMQAACk+rkOlBsV1rE
 c0j22otDRvfgRaAUQqnCWASrd63m1ckgvIgZzpmbX7HTAIKPLiimwQtnmzXWOTx2ea3Y
 QtnPvrV2rFoE6+FvobFuGoZXGwyFTR5U1AmL0GMZTGAk7ovCReJil2T3kIAkSBZoFgFB
 w7V0ApRdmOwp8E1zshzI3HPDWuenzQ+rtYDXQJFlxMS8ptK49Q1y839SZerNWOuOGZDh
 hUMSZWD9E2Krb/XTrc7Wq1p4rSbODw2r//L9HSWzIbwZnN6H+OzUAzbq3chMnwhP7YwY
 EuMg==
X-Gm-Message-State: AOJu0YzZqe1KvAHDg7KFPwvYgGZsVrtxMbtxvKC28QBlLTqy+aymm/1D
 /gb2YbX1xFu/RehomE9nkRY39uWlgEAHbPS8wJNMiHRKJ+3WZBpg4nCVx7C2dzkvAinOW+NJlwL
 x8h9xaICbvt47vBCs7KubPPIoFOFfs5AMWpBOrYuu1+6Ic56VwTNfaQwZtVaUWgfw7NVrUgI5u7
 hlK3eHTnaKrqHTfdp5h9xyHkzZVd6wyG/LH0Lbo9aTfqk5N+awH8SRJzl2/pBzN7cjF5eKxQ==
X-Gm-Gg: ASbGncttwibChBU/DLTOH0J7sM2F8lFO5wFwN8QRyamDjSWXElR2xthFuWWLDApPz9i
 yePmC7mjhy4+TaO0Z/Vav0YcGFQfYCeoW7yeCxtpmyP/O7/Ty+qlM3BsYbT2QXoGklxdyspVfEu
 wFTz1x4G3fnAHxRZu1jA/3OLNAlcpy3pWbKGx+53f5rs8H5pxvMmOQwvtvZJ7N1S2Bf0+Oyv+eO
 w+t70f3zBB3p58FJ3q9i2hGYlBnJqVGt8ikK5JrFAtR49gxU24DOJ5e8JkAbdUwl+TYAuUirEmY
 BZc1+12se0t60hv06o81ge4Wu3bvoOnLlU5cGzmhXDoarSwTnwqMb0QqUpoQ+NOHJusTdFwW9Wg
 16vPd3sBT56HMdmbOEzXE3ndGk9MW0aNAiG4d0Em5OjjBhCf/gIDZPWolymHu354DLH1CnGKtt4
 A4YcVrR1jOS3yPpWbqfJsN0yH5TnY8qGwuIR+9
X-Google-Smtp-Source: AGHT+IHfPI5+KlZN1Rj8l9In9kkKU8N4W6OG+Np7SX/Ut/g45lgU/4mDGcl9XcnQRLGW/EpxRyEnMb2xk1Ol
X-Received: by 2002:a05:6e02:198f:b0:430:bf84:e941 with SMTP id
 e9e14a558f8ab-432f8f94133mr47355355ab.3.1761754860208; 
 Wed, 29 Oct 2025 09:21:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-431f68a693dsm13975635ab.32.2025.10.29.09.20.59
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:21:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-89090e340bfso1211185a.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754859; x=1762359659; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppYHn13KO0Du4KFq4Ryfa4j5VeeeZaQR4lrPcYj8NAI=;
 b=GPG0RHM6VUpiJBilkPA5eZmZ9a6P3yD3tsYjuK+DslwYXQfaZWZT8ttV05VyFV4dEP
 V1kFkZSrbMZjLiL5JkjvR6AZxNCF4Yii524+GwkGloE10Rvbqlj+lvq9UTm3bdlZ6gqh
 5jqhtX7+LytWfN1LZ/I+gAu6pQkRTcvzCyYK8=
X-Received: by 2002:a05:620a:3721:b0:88f:4264:ea78 with SMTP id
 af79cd13be357-8a8e4361100mr473274085a.15.1761754859020; 
 Wed, 29 Oct 2025 09:20:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3721:b0:88f:4264:ea78 with SMTP id
 af79cd13be357-8a8e4361100mr473268785a.15.1761754858386; 
 Wed, 29 Oct 2025 09:20:58 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.20.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:20:58 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v5 41/57] net/bnxt/tf_ulp: change rte_mem_virt2iova to
 rte_mem_virt2phys
Date: Wed, 29 Oct 2025 12:06:56 -0400
Message-Id: <20251029160712.58519-42-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

