Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C726C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:26:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D8D340E17;
	Thu, 20 Aug 2026 07:25:19 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id EA37C40693
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:14 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d5655cc850so21358075ad.3
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203514;
 x=1787808314; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mHMzWHCAlTxtQ7LnNgxAJT/105wLQMiWJSNFS3PhR6k=;
 b=XAZpYbI1Gbe8spwYL+Hd/rI20si6rr472tHJJ39/gKOXgSuBHyjKsB56/3qEHGeSRM
 u/FUElAiUjPNW2yvCbeyf7nLzsPpNqOiLTlJeSZEx4hdgbV8y69lGYOFHG6lq3bwDbDR
 sVgenY4DSURTqwNSr6s5d72ZVu4Gh4c6iY8lW5Xspt2uMvxQ2Dwafg/Crclj0BKTiR9T
 ita+SyWpbzclrN6gbilZnV4l3DpWHRs+Smvbm84e8fUH+yzbncwFIKF3pT1rYpxtJ0Ko
 5Gcvew17/dLEttX+F4C981df4Ypoi3gqI6r7MC+xh8QWAbJIhOyXBnTRhb1OxLc8qVRc
 BaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203514; x=1787808314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mHMzWHCAlTxtQ7LnNgxAJT/105wLQMiWJSNFS3PhR6k=;
 b=pfJmgfhSUvD6KDbHdbazCJiuJDuNHLxuppsukD1rxInKjHvYSRVU4ZFgYSX1yDz9ox
 iuMTxCKS2SAM0WvMNC99Ojjj2/URutd7f3/GXH7wpQnpv/ulnItAbdainJp3b+p47Xur
 ydfk+QWdB5YuEzJ5IemRPDMksHUg5OenqEwR7QXgM3Qa7G/cbMPzemszAFdkLzR8mxhb
 JhUIAjp6cwd5kphT1ox3qsEPks5bMYF+wQ6LwOlUp1hE1mtRdPOEmeaNEIWHL02IY2rE
 H4regwjcb5RUJ2KeMmB8tqN2Yl55VOQaA4OqOXL9l5jJzjEuNoV9cbNwurGJV6H8TBIO
 YQOA==
X-Gm-Message-State: AFuF++lwxJ0hlyHQyg8DPAZJPnXfsMpMmsol3+zS7owBippCBqYlP4ke
 VWDzRwIShfib0r/9HKa9CNfTEGiIX92XuCb2meMuJNg3JBqRu3jiCNMb/kMVXaHDuoI5mxS3PMR
 DGRdz
X-Gm-Gg: AR+sD10YH1tzUvHl9L2kuZaejgyy23GWxMZs2nN5BODg/dnABntEtPDsfF4mOrXMQjr
 NSYWdr/85/BtOBqVMHwApkbU910r8fKug41eO6KEFKuYJ4jqnZx+YyspU10yeO+mFw5o/43p+Gr
 ZPU4rqhRoyvvNyScNMhAwYH8jC8cFQnp2N0S6XGwMtMyEhuesgB4RF8JFkctqTlhyF22uU7TrU3
 qMcKvI+FpiXQC5CzGlT8SpWJRi4WoH9j5B2yZ1Se6wbdnf8kG5cDu7LRWiXctgNFvnsrJv3XVr8
 SI3uG8VyGC6bbnfEpttZkl4pExcz2gAOMojVyrcGoLwTeb+oTeVjSEgWRjHDk8bbUIN78nCq5OH
 IDnNKy5T4DEaEaq7CRBcejKypP6c3i/KCkFBz9OrSbynATlqesfrqTudGTcuBvxdk/EjWOtT+rL
 9U8qpKSMQP667YbGCVcr6Xov8DW44K5HITF9Px+C/0fRVBY3R5cZYZ6TstPFf5hGRmZ77+hq5Wy
 iK09LTc4V0yIno2eFUXXrFtPEI=
X-Received: by 2002:a17:90b:3806:b0:380:9f17:6df3 with SMTP id
 98e67ed59e1d1-39580a91b8dmr19166087a91.4.1787203513949; 
 Wed, 19 Aug 2026 22:25:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH 36/61] net/ntnic: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:26 -0700
Message-ID: <20260820052251.1453273-37-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

The uses of rte_memcpy() in the RSS hash key update and get are
control path only. Regular memcpy() has no performance disadvantage
there and gets more compile time checking of the arguments.

The remaining uses of rte_memcpy() are left alone since they are on
the receive and transmit fast paths.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/ntnic_ethdev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 7cc90a7a5b..a61e675bd1 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -1768,7 +1768,7 @@ static int eth_dev_rss_hash_update(struct rte_eth_dev *eth_dev, struct rte_eth_r
 			return -1;
 		}
 
-		rte_memcpy(&tmp_rss_conf.rss_key, rss_conf->rss_key, rss_conf->rss_key_len);
+		memcpy(&tmp_rss_conf.rss_key, rss_conf->rss_key, rss_conf->rss_key_len);
 	}
 
 	tmp_rss_conf.algorithm = rss_conf->algorithm;
@@ -1778,7 +1778,8 @@ static int eth_dev_rss_hash_update(struct rte_eth_dev *eth_dev, struct rte_eth_r
 
 	if (res == 0) {
 		flow_filter_ops->nthw_mod_hsh_rcp_flush(&ndev->be, hsh_idx, 1);
-		rte_memcpy(&ndev->rss_conf, &tmp_rss_conf, sizeof(struct nt_eth_rss_conf));
+		memcpy(&ndev->rss_conf, &tmp_rss_conf,
+		       sizeof(struct nt_eth_rss_conf));
 
 	} else {
 		NT_LOG(ERR, NTNIC, "ERROR: - RSS hash update failed with error %i", res);
@@ -1803,7 +1804,7 @@ static int rss_hash_conf_get(struct rte_eth_dev *eth_dev, struct rte_eth_rss_con
 	if (rss_conf->rss_key != NULL) {
 		int key_len = RTE_MIN(rss_conf->rss_key_len, MAX_RSS_KEY_LEN);
 		memset(rss_conf->rss_key, 0, rss_conf->rss_key_len);
-		rte_memcpy(rss_conf->rss_key, &ndev->rss_conf.rss_key, key_len);
+		memcpy(rss_conf->rss_key, &ndev->rss_conf.rss_key, key_len);
 		rss_conf->rss_key_len = key_len;
 	}
 
@@ -2555,8 +2556,8 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		eth_dev->data->dev_private = internals;
 		eth_dev->data->mac_addrs = rte_malloc(NULL,
 					NUM_MAC_ADDRS_PER_PORT * sizeof(struct rte_ether_addr), 0);
-		rte_memcpy(&eth_dev->data->mac_addrs[0],
-					&internals->eth_addrs[0], RTE_ETHER_ADDR_LEN);
+		memcpy(&eth_dev->data->mac_addrs[0], &internals->eth_addrs[0],
+		       RTE_ETHER_ADDR_LEN);
 
 		NT_LOG_DBGX(DBG, NTNIC, "Setting up RX functions for SCG");
 		eth_dev->rx_pkt_burst = eth_dev_rx_scg;
-- 
2.53.0

