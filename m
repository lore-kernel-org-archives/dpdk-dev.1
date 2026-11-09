Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED7606A321
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=It9nqb5X
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 029024026E;
	Mon,  9 Nov 2026 13:52:07 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTPS id 1A41B40151
 for <dev@dpdk.org>; Mon,  9 Nov 2026 13:52:05 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso381184a12.0
 for <dev@dpdk.org>; Mon, 09 Nov 2026 04:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794228723; x=1794833523; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IRztP/EzshW4wUCovCkvkJGIMEhNIK5aA319xQFpzqs=;
 b=It9nqb5XM8n3TlOcq0wnNSB8ifCKqmMBVgrJNBvUqDS2D/qMWvldH24QBlmBAApTnL
 Dg05Q8vqEg2/6ylDrIwI4/0Acp+fSB9kq0S2KSrKf41bHR8AWvWRN+arM4lX/Iq9YDYz
 ZjrUijmII/+pAzOwwRUh3S7+hxoON2ApTdOdApTLqL/QhvT75inhMItePeOwyKULv5ik
 uEnbdDtNPkoDeNK5671GvQB+IhLNOQ+NzQuSLWEyYlf2y1h453VE9FV5wz/x2gCYzdz1
 RfP3LDcu5/lHAzCJahumVgYfDQVu1qrYJNPS9JUqTIr7LSUCeDRfBmzlRaZD9UR2rHoJ
 9Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794228723; x=1794833523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IRztP/EzshW4wUCovCkvkJGIMEhNIK5aA319xQFpzqs=;
 b=RznM7glmJN703qMf9JqhcYsrq9Kf/kiXeS8bnN/t+NzlA9khXR5l8R6aQslME6UX/f
 nWpNBre01NXr2SXLDSTyaptV+JYANIFf30N7W84Biv91GKGwTU+C0mlABzfrkPh3i0/y
 lo2nkOHqY1dkQnYi/vrWhbeN5/2foTHOVVBx6ZMIYJpIVTs87EB/8GVZOXUr8cb759M/
 aTysZ5Si3s/CUjy2dT4QmXADv2GMPKYJ3xA4lWjtXENYk1Lsua9Q7/m35GiIz3SUuu25
 tQ3df/hn6QJ7l2I1+biaoxBmNuJl8AaPlUXZaTvrYb3qr7aWJqShTC0Bvsj6HKMay1Xs
 GPTA==
X-Gm-Message-State: APuU4Z/G0D3NeTQvqj1xBVi8GCfZEDQMEOYws/m87aIbxE04kG3RGtzz
 iS4XrxkCvIkq7OmJwQIpPQpkbZujHBlFA8F2OnvGjqEJcn44CNxHHp4soOeAFA==
X-Gm-Gg: AYBFou3KpM+szmD5YE4pBwnzYVJUq+l7x66Jw7AQfIX2OpgG4fPRs180z5zBvRwfzXQ
 7/PKPJnal2gp3tqLSVesGq2L1y6DYvaczHDOUhZmgfjUGo6N59fdMR18gl4fipDUu/UInGI9smH
 C+BvF4ETuTQCeqxYidBdPoyMjJvkuqYmDkY6XH6fBaVy8XVUta46fk88FWyN0vIov09vuvDuMG3
 QRPIc+JXqoW+UpV2P6n3iwVIpe6fQ7p9jXfVxdAo5qQP3Vhxrzd8uLX7ny0lwyeq1SsfKC4+ZmH
 SSVot1rya5+CV/O5uydgYP76FDHiGwsyrSvsKYmZ1ITkovR2FG+zMPFrYnwpnY35ilMVIONTA0o
 2Weq6qE3XgfY6QMo1AtXY8Hb7NRUEuL9C6gjgutuTP79Vs3ShsjTwZyr6LEJKJ8rSbTqq5KKNXf
 zhSN4muH1G2amv89hQr06cN7AZVNSNub5XUf5MCWzfESRDdFQC4/UqCzAbW0Hsxsc2dXJrBl4ZT
 BCgCZKFQIn99nOucq/CPZXZYu8LU805Ne54ayjWydxhuGvPN/qrtcwM6Cc+qOdMDylVk58RtFfG
 8WoGzmMSIXnxcBosEBoC3iQTCQCf+oXG9YhAXA==
X-Received: by 2002:a17:902:fc8d:b0:2e6:e9a:eb48 with SMTP id
 d9443c01a7336-2ed837c25demr25314675ad.41.1794228723159; 
 Mon, 09 Nov 2026 04:52:03 -0800 (PST)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed815e72acsm10816335ad.13.2026.11.09.04.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:52:02 -0800 (PST)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com,
 stephen@networkplumber.org, Zhang Tengfei <zhtfdev@gmail.com>,
 stable@dpdk.org
Subject: [PATCH v2] net/txgbe: keep flow rules per port
Date: Mon,  9 Nov 2026 20:51:49 +0800
Message-ID: <20261109125149.16218-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108160021.31789-1-zhtfdev@gmail.com>
References: <20261108160021.31789-1-zhtfdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rte_flow rules for every txgbe port were stored in file-scope lists.
Flushing or closing one port freed the rte_flow handles of the others
while their hardware rules stayed programmed, and probing another port
reinitialized the lists. The same lists are used by the PF and VF flow
operations.

Keep one flow list in struct txgbe_adapter. A port disables flow
director only when its own FDIR filter list is empty.

Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
v2:
* Drop n_flows. A successful delete already updates the per-port FDIR
  filter list, so test that list instead.

 drivers/net/txgbe/txgbe_ethdev.c    |   4 +-
 drivers/net/txgbe/txgbe_ethdev.h    |   8 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c |   4 +-
 drivers/net/txgbe/txgbe_flow.c      | 180 +++++++---------------------
 4 files changed, 53 insertions(+), 143 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 9dbdbfa309..81f685722e 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -902,7 +902,7 @@ eth_txgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	txgbe_l2_tn_filter_init(eth_dev);
 
 	/* initialize flow filter lists */
-	txgbe_filterlist_init();
+	txgbe_filterlist_init(eth_dev);
 
 	/* initialize bandwidth configuration info */
 	memset(bw_conf, 0, sizeof(struct txgbe_bw_conf));
@@ -2352,7 +2352,7 @@ txgbe_dev_close(struct rte_eth_dev *dev)
 	txgbe_ntuple_filter_uninit(dev);
 
 	/* clear all the filters list */
-	txgbe_filterlist_flush();
+	txgbe_filterlist_flush(dev);
 
 	/* Remove all Traffic Manager configuration */
 	txgbe_tm_conf_uninit(dev);
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 28dfa1bc5e..d3e42f0756 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -337,6 +337,9 @@ struct txgbe_tm_conf {
 	bool committed;
 };
 
+struct txgbe_flow_mem;
+TAILQ_HEAD(txgbe_flow_mem_list, txgbe_flow_mem);
+
 /*
  * Structure to store private data for each driver instance (for each port).
  */
@@ -352,6 +355,7 @@ struct txgbe_adapter {
 	struct txgbe_vf_info        *vfdata;
 	struct txgbe_uta_info       uta_info;
 	struct txgbe_filter_info    filter;
+	struct txgbe_flow_mem_list  flow_list;
 	struct txgbe_l2_tn_info     l2_tn;
 	struct txgbe_bw_conf        bw_conf;
 #ifdef RTE_LIB_SECURITY
@@ -542,8 +546,8 @@ txgbe_dev_l2_tunnel_filter_add(struct rte_eth_dev *dev,
 int
 txgbe_dev_l2_tunnel_filter_del(struct rte_eth_dev *dev,
 			       struct txgbe_l2_tunnel_conf *l2_tunnel);
-void txgbe_filterlist_init(void);
-void txgbe_filterlist_flush(void);
+void txgbe_filterlist_init(struct rte_eth_dev *dev);
+void txgbe_filterlist_flush(struct rte_eth_dev *dev);
 int txgbe_fdir_filter_init(struct rte_eth_dev *eth_dev);
 int txgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev);
 
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 3cf33a8bd6..a66897a4fb 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -390,7 +390,7 @@ eth_txgbevf_dev_init(struct rte_eth_dev *eth_dev)
 	TAILQ_INIT(&filter_info->fivetuple_list);
 
 	/* initialize flow filter lists */
-	txgbe_filterlist_init();
+	txgbe_filterlist_init(eth_dev);
 
 	PMD_INIT_LOG(DEBUG, "port %d vendorID=0x%x deviceID=0x%x mac.type=%s",
 		     eth_dev->data->port_id, pci_dev->id.vendor_id,
@@ -882,7 +882,7 @@ txgbevf_dev_close(struct rte_eth_dev *dev)
 	txgbe_ntuple_filter_uninit(dev);
 
 	/* clear all the filters list */
-	txgbe_filterlist_flush();
+	txgbe_filterlist_flush(dev);
 
 	return ret;
 }
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 7016fb29d2..64128dfc27 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -18,32 +18,26 @@
 
 /* ntuple filter list structure */
 struct txgbe_ntuple_filter_ele {
-	TAILQ_ENTRY(txgbe_ntuple_filter_ele) entries;
 	struct rte_eth_ntuple_filter filter_info;
 };
 /* ethertype filter list structure */
 struct txgbe_ethertype_filter_ele {
-	TAILQ_ENTRY(txgbe_ethertype_filter_ele) entries;
 	struct rte_eth_ethertype_filter filter_info;
 };
 /* syn filter list structure */
 struct txgbe_eth_syn_filter_ele {
-	TAILQ_ENTRY(txgbe_eth_syn_filter_ele) entries;
 	struct rte_eth_syn_filter filter_info;
 };
 /* fdir filter list structure */
 struct txgbe_fdir_rule_ele {
-	TAILQ_ENTRY(txgbe_fdir_rule_ele) entries;
 	struct txgbe_fdir_rule filter_info;
 };
 /* l2_tunnel filter list structure */
 struct txgbe_eth_l2_tunnel_conf_ele {
-	TAILQ_ENTRY(txgbe_eth_l2_tunnel_conf_ele) entries;
 	struct txgbe_l2_tunnel_conf filter_info;
 };
 /* rss filter list structure */
 struct txgbe_rss_conf_ele {
-	TAILQ_ENTRY(txgbe_rss_conf_ele) entries;
 	struct txgbe_rte_flow_rss_conf filter_info;
 };
 /* txgbe_flow memory list structure */
@@ -52,22 +46,6 @@ struct txgbe_flow_mem {
 	struct rte_flow *flow;
 };
 
-TAILQ_HEAD(txgbe_ntuple_filter_list, txgbe_ntuple_filter_ele);
-TAILQ_HEAD(txgbe_ethertype_filter_list, txgbe_ethertype_filter_ele);
-TAILQ_HEAD(txgbe_syn_filter_list, txgbe_eth_syn_filter_ele);
-TAILQ_HEAD(txgbe_fdir_rule_filter_list, txgbe_fdir_rule_ele);
-TAILQ_HEAD(txgbe_l2_tunnel_filter_list, txgbe_eth_l2_tunnel_conf_ele);
-TAILQ_HEAD(txgbe_rss_filter_list, txgbe_rss_conf_ele);
-TAILQ_HEAD(txgbe_flow_mem_list, txgbe_flow_mem);
-
-static struct txgbe_ntuple_filter_list filter_ntuple_list;
-static struct txgbe_ethertype_filter_list filter_ethertype_list;
-static struct txgbe_syn_filter_list filter_syn_list;
-static struct txgbe_fdir_rule_filter_list filter_fdir_list;
-static struct txgbe_l2_tunnel_filter_list filter_l2_tunnel_list;
-static struct txgbe_rss_filter_list filter_rss_list;
-static struct txgbe_flow_mem_list txgbe_flow_list;
-
 /**
  * Endless loop will never happen with below assumption
  * 1. there is at least one no-void item(END)
@@ -3112,75 +3090,25 @@ txgbe_clear_rss_filter(struct rte_eth_dev *dev)
 }
 
 void
-txgbe_filterlist_init(void)
+txgbe_filterlist_init(struct rte_eth_dev *dev)
 {
-	TAILQ_INIT(&filter_ntuple_list);
-	TAILQ_INIT(&filter_ethertype_list);
-	TAILQ_INIT(&filter_syn_list);
-	TAILQ_INIT(&filter_fdir_list);
-	TAILQ_INIT(&filter_l2_tunnel_list);
-	TAILQ_INIT(&filter_rss_list);
-	TAILQ_INIT(&txgbe_flow_list);
+	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
+
+	TAILQ_INIT(&adapter->flow_list);
 }
 
 void
-txgbe_filterlist_flush(void)
+txgbe_filterlist_flush(struct rte_eth_dev *dev)
 {
-	struct txgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct txgbe_ethertype_filter_ele *ethertype_filter_ptr;
-	struct txgbe_eth_syn_filter_ele *syn_filter_ptr;
-	struct txgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
-	struct txgbe_fdir_rule_ele *fdir_rule_ptr;
+	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_flow_mem *txgbe_flow_mem_ptr;
-	struct txgbe_rss_conf_ele *rss_filter_ptr;
 
-	while ((ntuple_filter_ptr = TAILQ_FIRST(&filter_ntuple_list))) {
-		TAILQ_REMOVE(&filter_ntuple_list,
-				 ntuple_filter_ptr,
-				 entries);
-		rte_free(ntuple_filter_ptr);
-	}
-
-	while ((ethertype_filter_ptr = TAILQ_FIRST(&filter_ethertype_list))) {
-		TAILQ_REMOVE(&filter_ethertype_list,
-				 ethertype_filter_ptr,
-				 entries);
-		rte_free(ethertype_filter_ptr);
-	}
+	while ((txgbe_flow_mem_ptr = TAILQ_FIRST(&adapter->flow_list))) {
+		struct rte_flow *flow = txgbe_flow_mem_ptr->flow;
 
-	while ((syn_filter_ptr = TAILQ_FIRST(&filter_syn_list))) {
-		TAILQ_REMOVE(&filter_syn_list,
-				 syn_filter_ptr,
-				 entries);
-		rte_free(syn_filter_ptr);
-	}
-
-	while ((l2_tn_filter_ptr = TAILQ_FIRST(&filter_l2_tunnel_list))) {
-		TAILQ_REMOVE(&filter_l2_tunnel_list,
-				 l2_tn_filter_ptr,
-				 entries);
-		rte_free(l2_tn_filter_ptr);
-	}
-
-	while ((fdir_rule_ptr = TAILQ_FIRST(&filter_fdir_list))) {
-		TAILQ_REMOVE(&filter_fdir_list,
-				 fdir_rule_ptr,
-				 entries);
-		rte_free(fdir_rule_ptr);
-	}
-
-	while ((rss_filter_ptr = TAILQ_FIRST(&filter_rss_list))) {
-		TAILQ_REMOVE(&filter_rss_list,
-				 rss_filter_ptr,
-				 entries);
-		rte_free(rss_filter_ptr);
-	}
-
-	while ((txgbe_flow_mem_ptr = TAILQ_FIRST(&txgbe_flow_list))) {
-		TAILQ_REMOVE(&txgbe_flow_list,
-				 txgbe_flow_mem_ptr,
-				 entries);
-		rte_free(txgbe_flow_mem_ptr->flow);
+		TAILQ_REMOVE(&adapter->flow_list, txgbe_flow_mem_ptr, entries);
+		rte_free(flow->rule);
+		rte_free(flow);
 		rte_free(txgbe_flow_mem_ptr);
 	}
 }
@@ -3215,6 +3143,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 	struct txgbe_fdir_rule_ele *fdir_rule_ptr = NULL;
 	struct txgbe_rss_conf_ele *rss_filter_ptr;
 	struct txgbe_flow_mem *txgbe_flow_mem_ptr;
+	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_filter_info *filter_info = TXGBE_DEV_FILTER(dev);
 	uint8_t first_mask = FALSE;
 	bool fdir_configured = false;
@@ -3232,8 +3161,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		return NULL;
 	}
 	txgbe_flow_mem_ptr->flow = flow;
-	TAILQ_INSERT_TAIL(&txgbe_flow_list,
-				txgbe_flow_mem_ptr, entries);
+	TAILQ_INSERT_TAIL(&adapter->flow_list, txgbe_flow_mem_ptr, entries);
 
 	memset(&ntuple_filter, 0, sizeof(struct rte_eth_ntuple_filter));
 	ret = txgbe_parse_ntuple_filter(dev, attr, pattern,
@@ -3261,8 +3189,6 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				goto next;
 			goto out;
 		}
-		TAILQ_INSERT_TAIL(&filter_ntuple_list,
-			ntuple_filter_ptr, entries);
 		flow->rule = ntuple_filter_ptr;
 		flow->filter_type = RTE_ETH_FILTER_NTUPLE;
 		return flow;
@@ -3287,8 +3213,6 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			rte_free(ethertype_filter_ptr);
 			goto out;
 		}
-		TAILQ_INSERT_TAIL(&filter_ethertype_list,
-			ethertype_filter_ptr, entries);
 		flow->rule = ethertype_filter_ptr;
 		flow->filter_type = RTE_ETH_FILTER_ETHERTYPE;
 		return flow;
@@ -3311,8 +3235,6 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			rte_free(syn_filter_ptr);
 			goto out;
 		}
-		TAILQ_INSERT_TAIL(&filter_syn_list,
-			syn_filter_ptr, entries);
 		flow->rule = syn_filter_ptr;
 		flow->filter_type = RTE_ETH_FILTER_SYN;
 		return flow;
@@ -3339,8 +3261,6 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			}
 
 			fdir_rule_ptr->filter_info = fdir_rule;
-			TAILQ_INSERT_TAIL(&filter_fdir_list,
-					  fdir_rule_ptr, entries);
 			flow->rule = fdir_rule_ptr;
 			flow->filter_type = RTE_ETH_FILTER_FDIR;
 			return flow;
@@ -3426,8 +3346,6 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			goto fdir_out;
 
 		fdir_rule_ptr->filter_info = fdir_rule;
-		TAILQ_INSERT_TAIL(&filter_fdir_list,
-			fdir_rule_ptr, entries);
 		flow->rule = fdir_rule_ptr;
 		flow->filter_type = RTE_ETH_FILTER_FDIR;
 
@@ -3451,8 +3369,6 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			rte_free(l2_tn_filter_ptr);
 			goto out;
 		}
-		TAILQ_INSERT_TAIL(&filter_l2_tunnel_list,
-			l2_tn_filter_ptr, entries);
 		flow->rule = l2_tn_filter_ptr;
 		flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
 		return flow;
@@ -3476,8 +3392,6 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		}
 		txgbe_rss_conf_init(&rss_filter_ptr->filter_info,
 				    &rss_conf.conf);
-		TAILQ_INSERT_TAIL(&filter_rss_list,
-			rss_filter_ptr, entries);
 		flow->rule = rss_filter_ptr;
 		flow->filter_type = RTE_ETH_FILTER_HASH;
 		return flow;
@@ -3492,8 +3406,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		fdir_conf->mode = RTE_FDIR_MODE_NONE;
 	}
 out:
-	TAILQ_REMOVE(&txgbe_flow_list,
-		txgbe_flow_mem_ptr, entries);
+	TAILQ_REMOVE(&adapter->flow_list, txgbe_flow_mem_ptr, entries);
 	rte_flow_error_set(error, -ret,
 			   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 			   "Failed to create flow.");
@@ -3567,7 +3480,7 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 {
 	int ret = 0;
 	struct rte_flow *pmd_flow = flow;
-	enum rte_filter_type filter_type = pmd_flow->filter_type;
+	enum rte_filter_type filter_type;
 	struct rte_eth_ntuple_filter ntuple_filter;
 	struct rte_eth_ethertype_filter ethertype_filter;
 	struct rte_eth_syn_filter syn_filter;
@@ -3579,10 +3492,25 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct txgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
 	struct txgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct txgbe_flow_mem *txgbe_flow_mem_ptr;
+	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(dev);
 	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
 	struct txgbe_rss_conf_ele *rss_filter_ptr;
 
+	/*
+	 * Confirm the handle is on this port before changing hardware.
+	 * A flow created on another port must not be removed here.
+	 */
+	TAILQ_FOREACH(txgbe_flow_mem_ptr, &adapter->flow_list, entries) {
+		if (txgbe_flow_mem_ptr->flow == pmd_flow)
+			break;
+	}
+	if (txgbe_flow_mem_ptr == NULL)
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Flow not found for this port");
+
+	filter_type = pmd_flow->filter_type;
 	switch (filter_type) {
 	case RTE_ETH_FILTER_NTUPLE:
 		ntuple_filter_ptr = (struct txgbe_ntuple_filter_ele *)
@@ -3591,11 +3519,8 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 			&ntuple_filter_ptr->filter_info,
 			sizeof(struct rte_eth_ntuple_filter));
 		ret = txgbe_add_del_ntuple_filter(dev, &ntuple_filter, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_ntuple_list,
-			ntuple_filter_ptr, entries);
+		if (!ret)
 			rte_free(ntuple_filter_ptr);
-		}
 		break;
 	case RTE_ETH_FILTER_ETHERTYPE:
 		ethertype_filter_ptr = (struct txgbe_ethertype_filter_ele *)
@@ -3605,11 +3530,8 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 			sizeof(struct rte_eth_ethertype_filter));
 		ret = txgbe_add_del_ethertype_filter(dev,
 				&ethertype_filter, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_ethertype_list,
-				ethertype_filter_ptr, entries);
+		if (!ret)
 			rte_free(ethertype_filter_ptr);
-		}
 		break;
 	case RTE_ETH_FILTER_SYN:
 		syn_filter_ptr = (struct txgbe_eth_syn_filter_ele *)
@@ -3618,11 +3540,8 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 			&syn_filter_ptr->filter_info,
 			sizeof(struct rte_eth_syn_filter));
 		ret = txgbe_syn_filter_set(dev, &syn_filter, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_syn_list,
-				syn_filter_ptr, entries);
+		if (!ret)
 			rte_free(syn_filter_ptr);
-		}
 		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct txgbe_fdir_rule_ele *)pmd_flow->rule;
@@ -3630,14 +3549,14 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 			&fdir_rule_ptr->filter_info,
 			sizeof(struct txgbe_fdir_rule));
 		if (txgbe_is_pf(TXGBE_DEV_HW(dev)))
-			ret = txgbe_fdir_filter_program(dev, &fdir_rule, TRUE, FALSE);
+			ret = txgbe_fdir_filter_program(dev, &fdir_rule,
+							TRUE, FALSE);
 		else
-			ret = txgbevf_fdir_filter_program(dev, &fdir_rule, TRUE);
+			ret = txgbevf_fdir_filter_program(dev, &fdir_rule,
+							  TRUE);
 		if (!ret) {
-			TAILQ_REMOVE(&filter_fdir_list,
-				fdir_rule_ptr, entries);
 			rte_free(fdir_rule_ptr);
-			if (TAILQ_EMPTY(&filter_fdir_list)) {
+			if (TAILQ_EMPTY(&fdir_info->fdir_list)) {
 				memset(&fdir_info->mask, 0,
 					sizeof(struct txgbe_hw_fdir_mask));
 				fdir_info->mask_added = false;
@@ -3656,22 +3575,16 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 		rte_memcpy(&l2_tn_filter, &l2_tn_filter_ptr->filter_info,
 			sizeof(struct txgbe_l2_tunnel_conf));
 		ret = txgbe_dev_l2_tunnel_filter_del(dev, &l2_tn_filter);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_l2_tunnel_list,
-				l2_tn_filter_ptr, entries);
+		if (!ret)
 			rte_free(l2_tn_filter_ptr);
-		}
 		break;
 	case RTE_ETH_FILTER_HASH:
 		rss_filter_ptr = (struct txgbe_rss_conf_ele *)
 				pmd_flow->rule;
 		ret = txgbe_config_rss_filter(dev,
 					&rss_filter_ptr->filter_info, FALSE);
-		if (!ret) {
-			TAILQ_REMOVE(&filter_rss_list,
-				rss_filter_ptr, entries);
+		if (!ret)
 			rte_free(rss_filter_ptr);
-		}
 		break;
 	default:
 		PMD_DRV_LOG(WARNING, "Filter type (%d) not supported",
@@ -3687,15 +3600,8 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 		return ret;
 	}
 
-	TAILQ_FOREACH(txgbe_flow_mem_ptr, &txgbe_flow_list, entries) {
-		if (txgbe_flow_mem_ptr->flow == pmd_flow)
-			break;
-	}
-	if (txgbe_flow_mem_ptr != NULL) {
-		TAILQ_REMOVE(&txgbe_flow_list,
-			txgbe_flow_mem_ptr, entries);
-		rte_free(txgbe_flow_mem_ptr);
-	}
+	TAILQ_REMOVE(&adapter->flow_list, txgbe_flow_mem_ptr, entries);
+	rte_free(txgbe_flow_mem_ptr);
 	rte_free(flow);
 
 	return ret;
@@ -3733,7 +3639,7 @@ txgbe_flow_flush(struct rte_eth_dev *dev,
 	txgbe_clear_rss_filter(dev);
 
 out:
-	txgbe_filterlist_flush();
+	txgbe_filterlist_flush(dev);
 
 	return 0;
 }
-- 
2.53.0

