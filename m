Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D11CD5BB4
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 18:08:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A46640A4B;
	Thu, 21 May 2026 20:07:24 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 7BF9D4067E
 for <dev@dpdk.org>; Thu, 21 May 2026 20:07:20 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-303dbfbec77so7018282eec.0
 for <dev@dpdk.org>; Thu, 21 May 2026 11:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779386839;
 x=1779991639; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=hLE8U8TwGXptD/EXuxJeYt02rN3QlC1GzcgMi01a5CfsiHEOPIYicLdWnJxKCVBc5p
 Yw29ZUolPj4lyhaHujcpviM7j+Hy15JIIuMa7iazKXlb7zlBc+0KCRk4rBf6Ok3+QBA5
 H2bn9uCmLLUdbZCu5h75hEZWYquutRt9IGP7QHP4gXNz6clJeEhShI1ZcYM23iWbbFcE
 xz59DJGSIFxz81j+04h86zXM5g/OZp8puXANjGwZFY+gmYT1JKlxFa7VNGbj2E1vdxXy
 qdeOaLhRRqcM6NTeKbJATxN5C8DPaOBnfE2stiI0e5mx6ANUzlH5ozjc7WfFBESWUh96
 LIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386839; x=1779991639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wy0LWLsrRgN2Tir69nk6vc0zGehOJuqPUdF+aOw17wg=;
 b=KDzD42zoRRE4szjPGyzypR5dUvvNoTHHQ9Tf/uxK42fXcvpt4L7xOrivDFvLw9D+90
 YeiDS6c9anuQ+ZRhB3EPHnCvmn2Fxue0Gw7jpSWm8as01RQ/hSJfAnJCUaSgODreeghx
 y6dwuz53Eh3MB0SUR/9/XDPjh7uNlE5GnxDdlchcZMM/u+5Cc4Ee0zYhjDrnIzPqPfK9
 nfS15WTkKqUuTcD0aJZofAZZl9XwF7EGe3njaoRjocukeOJHTUGabXxYa6/KamcIz0H0
 L04CUg7MiNuXUUnH2kuqePXWEqooRaTBtZUwcre9SQkkJbbsRsrGm2GrJZWCbx3pL+zG
 Jjaw==
X-Gm-Message-State: AOJu0Yzn8SXFcNP9v979IzI7PnB4rS0hG/Os0elXPTWbN9CVX0UVTXfQ
 Fb8OkCpvBxHjRCB85Ev39Id1mxDCwaI4z/94oemHgF8OjCv0G0lDsR6g2NvHoaKfNw9/fWZ2+DD
 NdGLp
X-Gm-Gg: Acq92OF9tUkWKouzgtb2A35m2QydG4zS6nzxf6GxjWSq2hkYSogtEsAzun5GJkm3on/
 7b3XFmBunPxx/uUrDFHLu8pTKoLf4A3Fz21SK2ImwPtIpl5rkCapUejA0nNqk77yuEtPyIcoQWi
 QWpwg1NfzduzZYSVG7XGFOmrS3D2uTc1PaVGTY/4ohQQXX01DrHnregDYDkfefRodi2wkRmF30I
 g6UVt7ek7YkTPR4bQNp2wyaH9dTh98SHhjwnkGzl5HaumU4uS88MTKuLGgxrByG5nGfjLuAKznA
 GlVB5hKCNjnk3wlB06jm1dl2lZ+BlS1JZNSiI4bbaFI/22GwvDeQ8TEWyL7czepNniHS4RKn3+q
 3RmLj2R8Ukr4LYAIJ2urVnmkFT5sb8jlLfwO3Rus9zDJ2Zgq0YZGrkvUshgSya69J7dFEckniMy
 gOSnE5ArmH9mX99oha3Sul+U9+8nAFLHM/z+ozkudrzgVa981vKy6ucQkB8X5+kQ==
X-Received: by 2002:a05:7300:2313:b0:2f5:285c:4374 with SMTP id
 5a478bee46e88-30449119476mr135372eec.35.1779386839421; 
 Thu, 21 May 2026 11:07:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c10desm1034069eec.27.2026.05.21.11.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [RFC v2 09/11] net/pfe: use ethdev linkstatus helpers
Date: Thu, 21 May 2026 11:04:21 -0700
Message-ID: <20260521180706.678377-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521180706.678377-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521180706.678377-1-stephen@networkplumber.org>
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

