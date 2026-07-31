Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE1AC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:00:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ADFF40B8C;
	Fri, 31 Jul 2026 07:00:01 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id EB8ED40A71
 for <dev@dpdk.org>; Fri, 31 Jul 2026 06:59:59 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-ca2fad0ae38so387297a12.3
 for <dev@dpdk.org>; Thu, 30 Jul 2026 21:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785473999;
 x=1786078799; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=qrer+mMdjLH+ZAWlNtvBdyCDYu0Mfd/qmy8GvW/wz0i3oScZgaqlziRXnmFc3sawq1
 dk2L1M7eDo+311Jf0wG/yajBDO7uKWXrW/IPCU/ZzUE0snsDpE45EX5qU2y4ZyXhBOeX
 1zyooRPfXGZyLr0DPUp+etY/1G4mNEKqRNvzQT1lsYTgVJHJjm7hSOrKqNgFk4c6mUFK
 yhkFwtfz1Bw7kc6cfU2IOrWRK6NMzqBKaw6r38kxXeHQELdiNRtXFdarFd0tZXTMw8nh
 YI3pcKkHtfExUvMm5xccDlmJccUzDP4Rd87xYG+d+bxRdsa3zhD3bKv/GKjWpNKwN4dl
 iPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785473999; x=1786078799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=hpzZhQhC2Sapgm4sILOpd9TO1EhknNa0OG1YoPuRXMNLSOrvVJBpdbu/E7nQWV4ZSb
 ewsbYAM1O8tqpsmTV3Km9KQklxp0wDq7TwAnJRZhN2vBdykjdjNEcMapBLueSnsr8Hzb
 lI8reTN152n0ftoj7SY+nfXr/4C9hdDJGEkO+YPmxrnPZEUT86Uixw8MlgPd2SKPkcCi
 fEFKONm5dpWmtlTEkZvlaisdLT8hUUKeaiIiO2CTUzpYffp6HOVUSct3fZonTVn7PuF+
 cpfw7ORAm06mLnTCHWK+jZUsq4C3DZOcBwqHWZUWrFMrJhZkga20hSw4Bacmd7q0sknV
 9SYg==
X-Gm-Message-State: AOJu0YzZHd+IPOBYmwB5EYaz8EaJsF5/tXxiQXTUu9M2NRUZbVV7PF/W
 sFxl3NSb4yl0j782x5Zaz1iOlBtf0Z8HWHkLv2y6VvZ1OcZvdUY1XmC7CFogbeuluSuzfu6V6dy
 kelE5
X-Gm-Gg: AR+sD13EP+ATIAeggtFYvCPmciDQLyoY14aP1G0OsDCGQndQnH/nEPOCZx9i0XyOuVK
 31yhGmrdCPgcWll18SybHuQAgi//1PCmMQ6PByQqeFPDwBofERS6qJLN2VwCvEPSXUcBt4ryNE0
 CdYBtXapaRBM19w/0JC2BKqOODbqOUuyrDbPbe9yvZ1ciDnYKKtqvpbKydCB+07IxU2WHvIAbbY
 AsUiukuZP5AkcbNgiBmxaEJeODyi1iPNKVSiVn6Eb6hXB6YWGv2YLUpcep87ygUYZ3ZWxg91sc0
 cCAgMOjwyV8JtPXc+Rc9ZiL/F6aotzkcoqzECxLJ5fAjnudv5ORLLSAOjLtmsJAL0cYq/NCyX3D
 BAf+nlHXpel7SHosmRXQG/9rCojebSL3DWgoaZUptQyvBT443hzXpcQsD0rMBAo2MEgX+Hdzeq5
 kP5V/UwMu5lTgzvU2juLQdAmTlr7wYedPC06JXcVziYCCGMwt0EJVZc81LC87jwcuoBXydRnWJg
 RE0jz0BqQ+eKxFkeL4gtNbs+FY=
X-Received: by 2002:a05:6a20:7fa6:b0:3c8:ead5:bf58 with SMTP id
 adf61e73a8af0-3c91b361ca8mr451126637.51.1785473999130; 
 Thu, 30 Jul 2026 21:59:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.21.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 21:59:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v6 07/24] net/pfe: use ethdev linkstatus helpers
Date: Thu, 30 Jul 2026 21:57:45 -0700
Message-ID: <20260731045948.769926-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

