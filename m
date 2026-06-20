Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ADFCD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 562AB40B8C;
	Sat, 20 Jun 2026 04:31:51 +0200 (CEST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by mails.dpdk.org (Postfix) with ESMTP id A141E4068A
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:48 +0200 (CEST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-7fdb04d774aso30014147b3.2
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922708;
 x=1782527508; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=aCrtcE1ohoE8E/MWN9pjeMwkU1eUTRYbMp1NTqm+FRWzm+sktit8CGxt+gy6F4sHFg
 pa3hhKTpRunvEH5FmiHA2ei9plsx25yUuYbtrDML0cDTL2OiDk2prqD0QN5I2TK+hwYz
 iqyk9DIF+p56xaCQNnU8wDbsEz0RvgYa94vx0FLF3ONAnuFPASTYPJe7J4fYzWe4j7On
 TevO8MsNT/X2miYn43OdDCjoy0c+sIRKJWfIoGtXQIsnuu+9zSxejxGRCn/oMcxXWKib
 8GxIFV87ZNHJEuy+hvMJmTTsV5eEO/e+LvFezp0sfSj5JHvYebuKO15DE3oimy+o7Ex9
 BzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922708; x=1782527508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=QbdbA1ilfgAFuLGkeHNeNp8FDjdCrD2osQymtLoZinEaQlu90vDsL4lMc3vSGsVhll
 n8JGjeW69mvrRUgGfxuhYxzuo+WpY3Bnl2xc24ojyxBMXhwC9lnaiS5Y2tQ6g11CdyzN
 Gb4Ayc01zUcHxT+eGk6vV5VNtAkzCajFUVQ2Nh8AjwW48fLyS3A/ctAVghlSzqkDaGVC
 nW0Ebvn+vSyULFj2LLSxr8aELeSw4niZ/DIICRZNZgPCF+Je/zQwCljhH/vkLywm8aQU
 linwZh4W+IGCK7kUG+vGrGMfI7H4Z/b5Ns75PdkUizMJVlf3fEgjSHriX5xBCHMFSPhs
 zoJA==
X-Gm-Message-State: AOJu0YxD0N1pjxwGURPhgVaNY2AkRW1jtZwvCN66azLe2MxBe5uCzKe8
 XheArbY6kys8gSQ14wwJjtPN22REpayjYqWSB4HVaMD8TTyEAxvlBWv20QAoBXqagbAo2A+MF6F
 9t/xy
X-Gm-Gg: AfdE7cm2WulBTEmPdZh2o9/tiYpgS5+kU8XxzIStA06CC2mAgM5VMYn6ocVwe7GXY1N
 S+JXIji2m66G215aWvZd6Ln4qzlM2GcLjw9qCQy6wxIuhTBy2FWi445IEdfTUn9UhFS7OMB0qK1
 Vh/5KmgnqiyipEbSMqkoMrW5Z5wvUwORqFsDmSziL/9Dw3fBE3hXhQ9WxyvRn2bhj+XEAsUSaZc
 tc2okZNfeK0B/D+swmitJvK3jwp9Xuamjrw1vQYRgPWnOtXx/t3pUqUiopjqKwvGkqFPoC+QHuZ
 h0YM+Af/gQZmR5tZtgDzAeye4UGwKwk5MRXXtns1IhiInaRNtkbh25FOCt7wJrdw/C6XozPFlfj
 tr9dkyipriguoc6TI4Q26R+yoYJvHUQoCduWyUGFlNzM3o/RvbprwXKWrlhLWaLLgVy8YpSbROX
 ndpMSBcVLP5rNUOTmAYcCfAgvYOD8/pRy0UzLLgaHlA5MBnWv+o3I=
X-Received: by 2002:a05:690c:7403:b0:7dd:7dc9:c2c5 with SMTP id
 00721157ae682-80263fc80ecmr26516197b3.4.1781922707963; 
 Fri, 19 Jun 2026 19:31:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v5 07/24] net/pfe: use ethdev linkstatus helpers
Date: Fri, 19 Jun 2026 19:28:32 -0700
Message-ID: <20260620023134.42877-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Rather than open coding with deprecated rte_atomic64,
use the existing ethdev helpers to get and set link status.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pfe/pfe_ethdev.c | 32 ++------------------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/net/pfe/pfe_ethdev.c b/drivers/net/pfe/pfe_ethdev.c
index 1efa17539e..1b183ab1f3 100644
--- a/drivers/net/pfe/pfe_ethdev.c
+++ b/drivers/net/pfe/pfe_ethdev.c
@@ -531,34 +531,6 @@ pfe_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 	return NULL;
 }
 
-static inline int
-pfe_eth_atomic_read_link_status(struct rte_eth_dev *dev,
-				struct rte_eth_link *link)
-{
-	struct rte_eth_link *dst = link;
-	struct rte_eth_link *src = &dev->data->dev_link;
-
-	if (rte_atomic64_cmpset((uint64_t *)dst, *(uint64_t *)dst,
-				*(uint64_t *)src) == 0)
-		return -1;
-
-	return 0;
-}
-
-static inline int
-pfe_eth_atomic_write_link_status(struct rte_eth_dev *dev,
-				 struct rte_eth_link *link)
-{
-	struct rte_eth_link *dst = &dev->data->dev_link;
-	struct rte_eth_link *src = link;
-
-	if (rte_atomic64_cmpset((uint64_t *)dst, *(uint64_t *)dst,
-				*(uint64_t *)src) == 0)
-		return -1;
-
-	return 0;
-}
-
 static int
 pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 {
@@ -570,7 +542,7 @@ pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	memset(&old, 0, sizeof(old));
 	memset(&link, 0, sizeof(struct rte_eth_link));
 
-	pfe_eth_atomic_read_link_status(dev, &old);
+	rte_eth_linkstatus_get(dev, &old);
 
 	/* Read from PFE CDEV, status of link, if file was successfully
 	 * opened.
@@ -601,7 +573,7 @@ pfe_eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
 	link.link_autoneg = RTE_ETH_LINK_AUTONEG;
 
-	pfe_eth_atomic_write_link_status(dev, &link);
+	rte_eth_linkstatus_set(dev, &link);
 
 	PFE_PMD_INFO("Port (%d) link is %s", dev->data->port_id,
 		     link.link_status ? "up" : "down");
-- 
2.53.0

