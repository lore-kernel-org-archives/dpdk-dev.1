Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC13CCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:58:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8F0840EA5;
	Tue, 21 Oct 2025 20:57:59 +0200 (CEST)
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com
 [209.85.166.100])
 by mails.dpdk.org (Postfix) with ESMTP id 3A2D040B8C
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:57:59 +0200 (CEST)
Received: by mail-io1-f100.google.com with SMTP id
 ca18e2360f4ac-93e8d7d177aso121041739f.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073078; x=1761677878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ppYHn13KO0Du4KFq4Ryfa4j5VeeeZaQR4lrPcYj8NAI=;
 b=pxsgvuxcb+OfcbRWmxY54ZXU/uHCOy8xrYECePIikRsoi5u3LYQb6CX1xJxmQiU6Th
 kUgXtS0BiyIxOz1WRvkH4xqgCCMJsxAbcWfU8BWctbLGxXS8iXPK6S9fwALqqRIVc3nw
 a2LXnJTAe3o2lA++Aw4SvteKXqFjiMvBqNYh5ZrMtuyQPy4Pf4vwn/wN+joG9le6m+YM
 RWBeyTe5MDuxf0AHKphdi3ZSofIoeVL3np+tEyz8o0uqyTrgqpqMSYd5P0u/lgVG2ut5
 tW8mYueV6+JF5nv9gmzoNvOAgHJ4v0q84mDit+ygW0QJ6gLyc1vW1+6iZzSBWs/Z3JKc
 NSuw==
X-Gm-Message-State: AOJu0Yzm12/LINFYYjbn19xE/G/Ip3ufEqEFWv77lSw6pb3NvH/2xrTb
 lg+xHg/SOmnZVKDmNLEGTISITRC/Bg6SkZc8ovpxDT9kS4qq/PSrMHFMNR44gjDVUFW+kFRInMg
 5wcEvjPUq5KYE/8zH/z8rINQJwcmiEQueo3OqaId63tCevh07fi5qoqKLJAVLT5kBeGLnJ1vIbA
 KLLfQwZc1IgnrohIi87nj3SszHkXg4MwcPxLWXxxggcd5zRYJ5tdkzGdueNkPWUqU6qmly/w==
X-Gm-Gg: ASbGncuCGD4ApP80isW0mLrDQZDwrlYxIMYe0pfPA0h5OA0T/zjiO43hAKsMVL0CPGT
 03p9esA0Y0aJvsMjEAsVoa296xe+tmf8hzb/JgfHVt1KKROCNowskG/U75t2TXmWLnOU8VdY1ZA
 zAwYrZGNLVT7RDQkaBYtswhcY7IezJ99ZmqD17NiwSlP5zUO5j5E8aJTOJsShaAFjG3rZlIdgso
 iESgw7SzIbd6mfgRXoVM/7CWCHI15CZWXi+jPmCv5b/8cihq+U0J81HFJcbxavCVIy62vNf47/I
 b4UW+FEDrBin6y34XI40MwazRm/7yt7TLeiTJBdGxlOphjTTJ1pEJT+gtRlkubIZyMQidGt7wJx
 N3/585t8Bv3CScJr/Chd2Zfxd7KvaV+iffEMSkXkrE40OuMQiPiuRPSHEYEQmeFJWLyHd2/UVcr
 kRYzd6sZFdpshq1qHPm8w8jHrF2dsricUgpA==
X-Google-Smtp-Source: AGHT+IGy7aTcXOUnzNQO/EzA2Fo+PZERBbi4IGMTht6kyyqQhwAOMVah+8cpk9jyzZgGKw9qFOeb8HbdASYd
X-Received: by 2002:a05:6e02:b2b:b0:430:1c6b:7ed2 with SMTP id
 e9e14a558f8ab-430c5230101mr277931315ab.10.1761073078421; 
 Tue, 21 Oct 2025 11:57:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-430d071613csm12145135ab.10.2025.10.21.11.57.58
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:57:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-290bd7c835dso56453945ad.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073076; x=1761677876; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppYHn13KO0Du4KFq4Ryfa4j5VeeeZaQR4lrPcYj8NAI=;
 b=eQJMZcV+m/wxOV1OKhUJWW2VoN5Mcb+vWWmJsGuuVE6ZjRL8SPTIS/1UOjkNlsV8j9
 Z5pwcDUFCf294WTw1O+kJlyA5ltBtWmvAkx+nE5RrwNX9yi0zCOAUJCQLoiPRgvFsfrm
 vKsZ4oB9Fua5QFQjOS6ey1Kp930XqMZR/BzFA=
X-Received: by 2002:a17:902:db0b:b0:290:b53b:7459 with SMTP id
 d9443c01a7336-290cb65dc2amr212601905ad.56.1761073076516; 
 Tue, 21 Oct 2025 11:57:56 -0700 (PDT)
X-Received: by 2002:a17:902:db0b:b0:290:b53b:7459 with SMTP id
 d9443c01a7336-290cb65dc2amr212601615ad.56.1761073075953; 
 Tue, 21 Oct 2025 11:57:55 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.57.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:57:55 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v4 41/57] net/bnxt/tf_ulp: change rte_mem_virt2iova to
 rte_mem_virt2phys
Date: Tue, 21 Oct 2025 14:56:45 -0400
Message-Id: <20251021185701.71881-10-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

