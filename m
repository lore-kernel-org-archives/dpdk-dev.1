Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA50CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:11:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F12C40B9C;
	Tue, 30 Sep 2025 09:06:31 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id B86C6402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:30 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-32ec291a325so4128221a91.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192650; x=1759797450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ppYHn13KO0Du4KFq4Ryfa4j5VeeeZaQR4lrPcYj8NAI=;
 b=u9RrTWZGYq6FIUhIxT+FlTcdAyzl1uEKHjNvt/0Pm67GvggDMyGIp+KqDD0H9uIqQq
 okZdL5U4JUpkIh2YygMzLBVkDZjGSX0q8Q6wNAqk1DTnCL9Jq5DlKZOJi2DKgEn+aj0I
 a9yzcwmYJkElwRO/pVLFb/KOMQu83jNz6VbYpRi+y5ethIwZUr6jRfQda4Ic6o/se9su
 uxopcn7Pfkklkb2JZRXCi9DdZ5EMiZy2sNq/AbFr0D6eNMEUMcMf6YxNCs0yRbLJ93QK
 xI/UpIVxa9+sAyh+Ps01ovhdmk1w5bVJeC34MY4dPpNgTzpt00Pyc12qHwi0LvG10Vct
 ML5g==
X-Gm-Message-State: AOJu0Yy7vllJEgWiYvayz/k3/IJv9JTb1PTna3dT2mzgpMR+vkVEWt7J
 5NY5kR7TGlcOe0JWPtQrqBseWXNWck1TfgLqAU0QctprgWH0+wtIy+94N+68naiFQXzNbU/A+zz
 Lhf/q8ybOu1FduO18b0PDaR0YPRERW8/6LaJ1mOPu2br0LswE0/LvRH3RcHGshBUbNYB6oTnW6D
 /tu01/9cHUaVOOyU63j7HXH02BlOgAbl4xOAkQektFz2sfP+cjLIyuwgA8Tq4SxqZQLUzBnQ==
X-Gm-Gg: ASbGncsf9TVP6vErIBZRv5vVFFZn6DDjnttmwNVwadeNUraNABS3f+GJ2IzOKwnkQwB
 qcbfKibfNsLcixu9F5am9RKjQZAOmfC8G5H6FaCUxZHteOw0Cr19eg6Ar44Qa9ShicsJ5uU3LxR
 jMwmlVGl5Zj6Wf6SQb6fj27e9zGxshcOwPYyembUMC5DqwmMLHWnvGFRM631jg9RrO9cOgLMzX1
 PPw2rXEn7oEwD1Vx61QkcPjbt/lb0lQITCr9G0+bbOmLl4ytdCtnUS46ZGTTL84Q8pGf7LGpaZN
 uO6FLTD1CAK+eDXqqK3V0Pre/uLU5L8hHNbJqdC+bErUwGU830sx4E0JFrkKlFS6P3ngDD0MEOb
 L4daNNqKe6uvhwOycMpxsMxtGUgfsrrRR5xpCGU3XpRc9AzDYzcl/DaopXWuo2MxE3uv/AKI1VV
 ACxw==
X-Google-Smtp-Source: AGHT+IHdx/kGmajyJfIAUbqA8OeKF7aXkk/nsRZ3LIB3+qSsjAXAXyVxmBJa5rQ7FdkecnaehEUaDt4HPXTq
X-Received: by 2002:a17:90b:5109:b0:32b:baaa:21b0 with SMTP id
 98e67ed59e1d1-3342a2498b0mr20866374a91.6.1759192649920; 
 Mon, 29 Sep 2025 17:37:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3341bdf72d8sm1035855a91.3.2025.09.29.17.37.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b5535902495so3960841a12.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192648; x=1759797448; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ppYHn13KO0Du4KFq4Ryfa4j5VeeeZaQR4lrPcYj8NAI=;
 b=G699hebm56tcPKkdQ0xC2VQpbJ5qOHIfUcxS7Y3MZ8qgjLy+MkwcYb0Jj5tT2Rqdfh
 nE/kQxCU7UBdEVY+dFQCWEEgU8LwWshHV3PJ2J8iS62GG3ke6+g1J6IwiTZfW6qo0erN
 tbaQwom1eDLd2+rDkio3qI0wIT4WM+A6DJYgY=
X-Received: by 2002:a05:6a20:320c:b0:2f4:abe3:2c94 with SMTP id
 adf61e73a8af0-2f4abe32f54mr12667510637.50.1759192647831; 
 Mon, 29 Sep 2025 17:37:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:320c:b0:2f4:abe3:2c94 with SMTP id
 adf61e73a8af0-2f4abe32f54mr12667482637.50.1759192647293; 
 Mon, 29 Sep 2025 17:37:27 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:26 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH 38/54] net/bnxt/tf_ulp: change rte_mem_virt2iova to
 rte_mem_virt2phys
Date: Mon, 29 Sep 2025 20:35:48 -0400
Message-Id: <20250930003604.87108-39-manish.kurup@broadcom.com>
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

