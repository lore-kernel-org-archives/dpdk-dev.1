Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DAEC982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D85642FE9;
	Thu, 17 Sep 2026 22:11:33 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id D5F6642FCF
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:29 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 d9443c01a7336-2d93ff61046so310115ad.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675889;
 x=1790280689; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=Fx5IJlD1antkXa88KS0MzIuqx731DwtTCozLr9PQB5dp+c9+fot9pa+0mNsLFDoTp0
 3tCp9iMy2athKQePI69lo1oUOZfFmF55BP4W1MYDUM7zjQ82L4Et1pGNtGhzw9Dgp2Hc
 vTLzTm6bW75MdYKPCLDrhoxP7JP79IZmgxqS1q7/ci6qrm1YT9Q+FrHEaWiKVOouOeqJ
 aZ8C60Ko5566YJpbyH75zfrjTwN+M8Toh9GmS54hX95Yk6EJnmn3YeUqm2Z4PhqxN+uE
 DfeFETstxmhWEMemVIij/s15aEgk4DLwPmkU7G1jPTju9l7MnavSrhxU0YFGa1yJZbyP
 Sy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675889; x=1790280689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=uiD/mzMFKNBbM3SzbV0oTg/v1E6AjoldlAubhx/30Jat77uvvNouqxcjlSNhLXy+Ss
 dCzhUsXWTucIN1h7JlPJY6ARShpd5YEteql890g1LqwcAbJ9WQS3+Ah43gMqYLxau9uW
 ET+ztOSsmXY57uF4Xy5fcf9hcUFy1kFAzL4k2l1aTNCW1nZaIKlYJI4zQMPTmpUiZ7fm
 B/IgB2LBINk6MLq7s7OKp9prqEeZHnLcUSGVfWpbyuzkz0Wh64Dt3rrlht1J+mvmPCbP
 ZZEQv4XshGOKgAGsNv5JIj/CNlQCwyKrFZFptelt2vA/illwupixlqNsVA93l1zHTJpO
 7H1A==
X-Gm-Message-State: AFuF++lUTGI6KClXmvA5/JuB9VHQn/uCZepvsw3DWvzhVbUnMNUcaW22
 vk4jQUkgj9VU78l8tIoPdd3DKLebTuXAOyZ6TdVEqEikUsEOrn6vBlUaqHz0d5fQXL3mPiDhc9J
 YR1p7
X-Gm-Gg: AYBFou3WlzCPVZJzQShUTsL06Jfwz9f8Q5EPMTEfTDGjxJVu418dmHxpqwi1C434yEk
 tdNSsSXvenz2DY1Lwo9Q+U9PRl+M0zF8QsDLh5Wf+WL9K5AZo+kYpU1KOIKgXyA05wj+L0u+j5w
 jxTrt8fwk72D+oXEMgbZSh49/1xpWGBZvR3w/UEzLy5lMaT9ETSeEFX6kZ6TVJXMFsnib4hPsaS
 e/4V+vNYYObOJ99BmSudCbPhFAUkYUnqX7RAh2idgVZVex72p86MuL1iX23Oss3j3lLzGnTDf9d
 CIdkwQREc+PkFAy/XXx7LC7ctU9OGPN7zKfm37tmsteJlw1SROkZaRgr0uvr6Nj3dKL0ROJgIsD
 LhXAJRPo5eQoKR7CelQi2/kw9AB8BkTTbxVaAb9yMwaxFYqvT3Q4oA/iSeT2LSzZSg4deA0Ezv7
 /hbkg/aQ3DocUiufm/S1N/1Szdbbep8gNBEZpjzlW+GsoGaPDr5Lss1B3pFW43Lhe6dwNLfKcb1
 51yxXZw8toeZUypQyvmb6L8T/lptwcrDeQt5vx5bf6QOnxX
X-Received: by 2002:a17:903:2a8f:b0:2d9:1dee:43db with SMTP id
 d9443c01a7336-2ddb1b7ac15mr5387805ad.15.1789675888853; 
 Thu, 17 Sep 2026 13:11:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v8 07/25] net/pfe: use ethdev linkstatus helpers
Date: Thu, 17 Sep 2026 13:10:11 -0700
Message-ID: <20260917201119.2168234-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

