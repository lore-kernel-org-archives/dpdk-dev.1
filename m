Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8566DEA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:11:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EAB44066F;
	Sun, 19 Apr 2026 18:11:12 +0200 (CEST)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48]) by mails.dpdk.org (Postfix) with ESMTP id 2F02C40665
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:11 +0200 (CEST)
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-40427db1300so1804343fac.0
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615070;
 x=1777219870; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=VBgtyo9w7LYsVKEE3V/SnTdio/CElPxdi0n6A8J66zhaeaXJZOr2CSEJM97QQXpFIc
 QWfiMve3X/T1Svn1YkXPFgeFLzZ7Lb/04E67LO8WdB447VYumYr5Wanuwu/CW0pMXBfa
 1Ai8M5e6EBEivNmpk1KZbqYQ9y5pmYnV62BEIPljmMQUe9Io+s83yutmsGAMMYRUIvqH
 GSPQVgfyaDU8z6yiLuUwupLLWKTNgzhQfwsiLsJ1j72dMZZ0zHPgzczELApmiVaPdehR
 fGnnieToVbkXmi/0nuv6i55WIRzfQo0lWKD2WGo36wDQEyGnme11MlMhXA7i7j3JnPJf
 BjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615070; x=1777219870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SHvyTLl5Ryy7ZPBy8BRoBW2iPF2MZ5pOx3G/cJDj5UM=;
 b=B567JgMZ+XJczt71hZ2u/lZqHWxQ2gYKRiq6LibIddfcOXMQQeV6yJ/SULT3TyNHMw
 URsNJkOTea/KO1UHlz6zhT7kdFvzod0cBCeeLPd7mfGziou1ZwR1CTGyzHU3yHRev53P
 GTts7Rqt7pBfHTRpi5mFGp3GG+SgAHdfEfbOGHSFLpQWiEzIt6jjyczQOTyYVEartWAW
 UZyFuci/yTNPPndI7+zLMW6YW7BJM0yXzIZ9YxuJ608hpYb30iCpU3eKHk/FBaD7qyQQ
 gqFvvlCt3A3YkRE+HxwEtt/Idl1U9KqDCtpHRuEikQsk0Kq8Dm/fRZ3LRwF+Soaf71hj
 29lg==
X-Gm-Message-State: AOJu0YxLpAsB3heHuGmthWS/94D5uedTQ/SQ7vIKR4ckfqOms1lBN0qK
 V2Av+CcGMIIdQDQ8yFuHXrXCN1ypjpM2Gd/CN19/rHuX4KQiEA5blx74kcVpFftvIXIPiZIKgja
 7LnNg
X-Gm-Gg: AeBDieuxJhoV4MsrR0ESOynK+C+4OA8gxNTa46WFg6uIqeQPiFYR5GoXd9Hn3xkcp5h
 Sep6Am1+kMauivcFtQnRcldrSCgrVtjmhZPFrRAJqcKiWRt9xUbgD7YddBjPpl51MBI9chNpUQg
 z6z40VS7jwISiucBjgywxeo/IgNYGqOIqNs296U8oYVKjXGTmXRJe+t9WAOyxAgezJVt2R0/s7B
 rNRydh2H94iLsb3zBMOEnzFxx1TMYiNIx7Ho86UtyhIylcLfyqMz7lRQLXwedacHvWwT2pW7SmB
 vopYznkHFAp5iY+oCUocDvA7gkG6rsSQ8ROP7Mq1dRszx3qlrxu4zILNcZU9Laz7dlix1XoV65b
 YkFkFD8+zPeVlCYkni7ekD7XLYc0e5AAphE0q9hzWSDzxWquPjQRvZhtbvAaX1ykfa4ChXOQq6p
 y7M9klWh1tRSSMQ+nN63su6sEF45TFKiyN+0OMJDT231I=
X-Received: by 2002:a05:6870:9a8b:b0:417:22e:e2d1 with SMTP id
 586e51a60fabf-42abf23c02fmr6580727fac.2.1776615070414; 
 Sun, 19 Apr 2026 09:11:10 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v25 05/24] net/pcap: remove unnecessary casts
Date: Sun, 19 Apr 2026 09:09:38 -0700
Message-ID: <20260419161059.205954-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

The function rte_zmalloc returns void * so cast is unnecessary.
Use numa aware allocation and add tag for tracing.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 4513d46d61..d6fe062b92 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1217,13 +1217,11 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	struct pmd_process_private *pp;
 	unsigned int numa_node = vdev->device.numa_node;
 
-	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
+	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %u",
 		numa_node);
 
-	pp = (struct pmd_process_private *)
-		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
-				RTE_CACHE_LINE_SIZE);
-
+	pp = rte_zmalloc_socket("pcap_private", sizeof(struct pmd_process_private),
+		RTE_CACHE_LINE_SIZE, numa_node);
 	if (pp == NULL) {
 		PMD_LOG(ERR,
 			"Failed to allocate memory for process private");
@@ -1284,7 +1282,7 @@ eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
 	if (osdep_iface_mac_get(if_name, &mac) < 0)
 		return -1;
 
-	mac_addrs = rte_zmalloc_socket(NULL, RTE_ETHER_ADDR_LEN, 0, numa_node);
+	mac_addrs = rte_zmalloc_socket("pcap_mac", RTE_ETHER_ADDR_LEN, 0, numa_node);
 	if (mac_addrs == NULL)
 		return -1;
 
@@ -1590,11 +1588,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		unsigned int i;
 
 		internal = eth_dev->data->dev_private;
-			pp = (struct pmd_process_private *)
-				rte_zmalloc(NULL,
-					sizeof(struct pmd_process_private),
-					RTE_CACHE_LINE_SIZE);
-
+		pp = rte_zmalloc("pcap_private", sizeof(struct pmd_process_private),
+			 RTE_CACHE_LINE_SIZE);
 		if (pp == NULL) {
 			PMD_LOG(ERR,
 				"Failed to allocate memory for process private");
-- 
2.53.0

