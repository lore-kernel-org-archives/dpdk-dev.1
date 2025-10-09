Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C958CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 153D940E2E;
	Fri, 10 Oct 2025 00:16:26 +0200 (CEST)
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com
 [209.85.210.100])
 by mails.dpdk.org (Postfix) with ESMTP id 69E0340B9B
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:23 +0200 (CEST)
Received: by mail-ot1-f100.google.com with SMTP id
 46e09a7af769-7a76561c291so968941a34.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048182; x=1760652982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ppYHn13KO0Du4KFq4Ryfa4j5VeeeZaQR4lrPcYj8NAI=;
 b=mwDKntTV7mZ86nno0d3Y0ldPk4C46HMgvy3L6u4WlIEE9FkV0zPAxnVGxfgWrLqFvV
 jh2HcgL2KnHsHuf1VqhLtfVafsLcEaTg42b4p9V8IYh66dcPYUd5T2fCx1sSXIg9Q/wC
 RBqSZDVfDB70w0YEARYPjPu7UGSWIDFREnqLbKdrUOrNd0AAaAGyDn7gfIsg22asi86i
 4sQhNwK5hTWLY7XGftGv+8QkyaqxlX8i+LnAFVo4FJQKnAVQGv1ZQXq1fdkrg4t4v37y
 /RyprzpvlOoWLMWNqPdpyK3XRiXca/jgmLmmqhapYQ50emd8W5d2MiPEKouW63yrWer5
 Xr1Q==
X-Gm-Message-State: AOJu0YyaA4BSvI7GccROUUaWpYaPLMeqWTzqGaJQHq7jfgdHBFFWe2Kt
 hj4MqbASiLMy9vrc5hzlAwPREtQE+z/mLOJAzsSvLSCHfioUtPfs5GH1n9JMWNPi5oiEIlyLHjx
 bbeqbUIbHCZnyKz4TlPjTNV4iz3p1blLggCH73qfLpiyrIcE2CcKsGj+CiUKbCiPrtGsYqTSWM2
 3F6GnA70vV7FR14ZKM+nEsam0TF0IahubKjoKmt+F7qIJPED4prMFfxhbbAYzzXJNbf+p8GQ==
X-Gm-Gg: ASbGncvjx8sU6tgSa6+MzBN9XE6yuvXGBGQQrQI+ztyoYly6863SA4jLEdEjW6KQxhF
 gDNFm3XXDpn27GPsci3UK9fx5jqPsEOwKOCzQXVJufwLEjj7hYgKkdzPkpvCrQel9pwbYbtZEcd
 kQZatGc6n8da1NwFBviIyKKLGwON7T28KDhoy6MgSSYTfyrv5K7IR8Owucd4gAHs5HnjgBtsj3p
 +/h0MIRX38XhRp6v4U/wghONBSbzd2W+rN7EEhQnaqO9zODc0VOE5k+U7JEHaD6ThFE+59nMYg8
 QDVX/j3lbYVBw5lYAOdHjjC4kOyd1zSh2/cwy0DmE1b64MgnTJON3PiitKC85ZJrnrHsdoEYBAS
 6vSfAC408eJHVCGZZnsOeETpd8XsAfeiVmJECK6jCPZGVSVySkIfsakqP8WXMMnRXDWiQRlE7Mg
 U5iOq4
X-Google-Smtp-Source: AGHT+IE86TgwFVcHqX8ETLffQkDOUUPMwCIglRbasQboMEOXbf94Eps/RUykDyr7Kfu12YZW+mpxA6Bb6i39
X-Received: by 2002:a05:6830:83a9:b0:757:5bc5:3f5c with SMTP id
 46e09a7af769-7c0df732147mr6158272a34.33.1760048182517; 
 Thu, 09 Oct 2025 15:16:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7c0f90fbadbsm56595a34.7.2025.10.09.15.16.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7c547f51b36so46500156d6.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048181; x=1760652981; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppYHn13KO0Du4KFq4Ryfa4j5VeeeZaQR4lrPcYj8NAI=;
 b=fcx1EvUcIJNWKKWONP6EsxhFUM/nHqqBGrvi67QW7I4W1pgzSyE/+vVF+jhRyTeP41
 +T/gBaQbQ0A/3Sl1gO2QWGMu72BZV+o83U1/Jrn856ep/CraLzgrL/HnwMxeCKVt6ijM
 vtlEzJAcLxp3Bbc+RoB7Ndh5ZkxwCnRBP7Xrc=
X-Received: by 2002:a05:6214:caa:b0:80e:327d:be5b with SMTP id
 6a1803df08f44-87b2ef951ebmr131822756d6.66.1760048181139; 
 Thu, 09 Oct 2025 15:16:21 -0700 (PDT)
X-Received: by 2002:a05:6214:caa:b0:80e:327d:be5b with SMTP id
 6a1803df08f44-87b2ef951ebmr131822316d6.66.1760048180623; 
 Thu, 09 Oct 2025 15:16:20 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:20 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v2 38/54] net/bnxt/tf_ulp: change rte_mem_virt2iova to
 rte_mem_virt2phys
Date: Thu,  9 Oct 2025 18:11:13 -0400
Message-Id: <20251009221129.28256-39-manish.kurup@broadcom.com>
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

