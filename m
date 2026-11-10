Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB3606A775
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A1uAFiPN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20EC640285;
	Tue, 10 Nov 2026 14:22:16 +0100 (CET)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 1F38340281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 14:22:15 +0100 (CET)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-3712b6d9843so1732298eec.1
 for <dev@dpdk.org>; Tue, 10 Nov 2026 05:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794316933; x=1794921733; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/eJiG5XbtNhcVQfBz3b82Q/neFBube+UFH01EGV3yus=;
 b=A1uAFiPN1+IVCXPYpbs1IyVp2EjNKjYwdjWu4iXR4ttgeahcKQrUUyzxnPz90Scg49
 Oso5hogLkbw6/fQBh/LsG8Hxx2Zq9aQ7cIaMEvyH2VBput+SAE4Kk7eZLHf3Zz6BLx32
 iUS2bMvZ5OjzpcfFZEUkr9KbQpl/rkFk3wRamTG++REjdHOt4+SWSXnu3wFrlKli+kH9
 F5MOtl9mBUTvv96BnumEdGXprKWJCrqRxPwOF+A56thdZO2HKfC40SWc5X03gLJgdug3
 7z7zqY4Gq4zL1OmTBuMs7OpD6XG65Rnn6QkR3T/2lNmTgvWxfzgG4GWZnHgEwNm11y6V
 Cfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316933; x=1794921733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/eJiG5XbtNhcVQfBz3b82Q/neFBube+UFH01EGV3yus=;
 b=JtqN/GxEGTNSzL7ONO49dsGdJqbqR+KaV7VwIhGKNj6OFANxZ0d4gMIIh3cskR1xeu
 DrVn2X8R7Q1IcOsUrhXdU1GZp/W+inAuHe9Kg4aRlFlf/1MtkvreWPoi/4J4dclQ5UtC
 PV1Ma50dsd8KQNiGsXoTqZ4OkkGZOPADq8p10Ilx9t4zztHC53hRySpV6OK7yVIKNYEt
 q/RJ1pgbH+SGQO0qnwQCIFNQwRmc91IHBe/yQ7Wv6G4EDdu2PMsZ+5s12aygFDnhnnhq
 X3DxbdD3DX4BuSjLjaob6RAw6dfu1Z+Rhsk2/2OpUGPnp3m2VA+zdFaeLEJvE8BdxGNq
 lgnQ==
X-Gm-Message-State: APuU4Z9FnXaZX4sTK4wkqquVlZ2FOQypw1FyEmz6XHJGP0P4cTJocye8
 dYmp7H2FaF4QD4cm97NJAr/seXYTvqEFfQV3lMq+v4qqIFdgLTRLLAzX4fp2jyjo
X-Gm-Gg: AYBFou3+dQm0dNpVk3SO2keg3EC8RAecC9Qg2GyWPZDBx0ZwXwnLLADl92b8qoyMWEl
 Xi6uef3GwoO6nYuQvvaDKzd+EoO5PntKJUSTl/35tFYxGmr9l2qtNnlDvYPmvPn/bqC13YYlKK9
 ZgzD0A0afFOytgRhdIkI87aIxG2X4p2g8r1rZZze2xOazQvtw6LCJAgNzL78cKLkNWGv5KuOAY9
 QWSN+Ir6W8F8GiD+w3YrCW8P+NoWJbCNgh6VFvcAM+crN9gf8obWfcpz9Gq3uRo60GgnWwDV6QN
 7KS1iyWyZ2rkhzuo7ju8GUD6bx/4EcJ3RfEl6YiNRuZxelAPSH7lCdM2UrUpaZnwXy0ylks6670
 GTtkvQwD6e0Xjgz7h/ahVUzteN2RvhrIgQgs5Jx+7YK80OTOarLE88wEStzuRdGSbp9Utcd9UN7
 drBalCCwJNtDn1T5fHesAWsuNA+7HNLm44HNHxo19LbVzCgurqxbjJbIXjTTR1kMT02/wm24O3k
 /GjELjDNLFvJ2knuQ0qUr4bW5wEdgYPMtiLGUGr3WxIhfEJ1iiF4mNkeT/p8Dq+pdTP0VZp/I9W
 mB391Dy44zK3a8yPBamE13TfiYP0DZuv9udD1A==
X-Received: by 2002:a05:693c:810b:b0:36f:6d81:3f99 with SMTP id
 5a478bee46e88-3751fb343b4mr3465597eec.7.1794316932859; 
 Tue, 10 Nov 2026 05:22:12 -0800 (PST)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751dae6377sm6716685eec.3.2026.11.10.05.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:22:12 -0800 (PST)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com,
 stephen@networkplumber.org, Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH] net/txgbe: store flow rules without wrappers
Date: Tue, 10 Nov 2026 21:22:00 +0800
Message-ID: <20261110132200.12673-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The flow rule wrappers each held one filter structure after their
list links were removed. Store the filter structure directly in
rte_flow. RSS still goes through txgbe_rss_conf_init() so the saved
key and queue pointers refer to that stored copy.

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 105 ++++++++++++---------------------
 1 file changed, 38 insertions(+), 67 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 64128dfc27..39d94eb1ea 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -16,30 +16,6 @@
 #define TXGBE_MAX_N_TUPLE_PRIO 7
 #define TXGBE_MAX_FLX_SOURCE_OFF 62
 
-/* ntuple filter list structure */
-struct txgbe_ntuple_filter_ele {
-	struct rte_eth_ntuple_filter filter_info;
-};
-/* ethertype filter list structure */
-struct txgbe_ethertype_filter_ele {
-	struct rte_eth_ethertype_filter filter_info;
-};
-/* syn filter list structure */
-struct txgbe_eth_syn_filter_ele {
-	struct rte_eth_syn_filter filter_info;
-};
-/* fdir filter list structure */
-struct txgbe_fdir_rule_ele {
-	struct txgbe_fdir_rule filter_info;
-};
-/* l2_tunnel filter list structure */
-struct txgbe_eth_l2_tunnel_conf_ele {
-	struct txgbe_l2_tunnel_conf filter_info;
-};
-/* rss filter list structure */
-struct txgbe_rss_conf_ele {
-	struct txgbe_rte_flow_rss_conf filter_info;
-};
 /* txgbe_flow memory list structure */
 struct txgbe_flow_mem {
 	TAILQ_ENTRY(txgbe_flow_mem) entries;
@@ -3136,12 +3112,12 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
 	struct txgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
-	struct txgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct txgbe_ethertype_filter_ele *ethertype_filter_ptr;
-	struct txgbe_eth_syn_filter_ele *syn_filter_ptr;
-	struct txgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
-	struct txgbe_fdir_rule_ele *fdir_rule_ptr = NULL;
-	struct txgbe_rss_conf_ele *rss_filter_ptr;
+	struct rte_eth_ntuple_filter *ntuple_filter_ptr;
+	struct rte_eth_ethertype_filter *ethertype_filter_ptr;
+	struct rte_eth_syn_filter *syn_filter_ptr;
+	struct txgbe_l2_tunnel_conf *l2_tn_filter_ptr;
+	struct txgbe_fdir_rule *fdir_rule_ptr = NULL;
+	struct txgbe_rte_flow_rss_conf *rss_filter_ptr;
 	struct txgbe_flow_mem *txgbe_flow_mem_ptr;
 	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_filter_info *filter_info = TXGBE_DEV_FILTER(dev);
@@ -3175,13 +3151,13 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 
 	if (!ret) {
 		ntuple_filter_ptr = rte_zmalloc("txgbe_ntuple_filter",
-			sizeof(struct txgbe_ntuple_filter_ele), 0);
+			sizeof(struct rte_eth_ntuple_filter), 0);
 		if (!ntuple_filter_ptr) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			ret = -ENOMEM;
 			goto out;
 		}
-		ntuple_filter_ptr->filter_info = ntuple_filter;
+		*ntuple_filter_ptr = ntuple_filter;
 		ret = txgbe_add_del_ntuple_filter(dev, &ntuple_filter, TRUE);
 		if (ret) {
 			rte_free(ntuple_filter_ptr);
@@ -3200,13 +3176,13 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				actions, &ethertype_filter, error);
 	if (!ret) {
 		ethertype_filter_ptr = rte_zmalloc("txgbe_ethertype_filter",
-			sizeof(struct txgbe_ethertype_filter_ele), 0);
+			sizeof(struct rte_eth_ethertype_filter), 0);
 		if (!ethertype_filter_ptr) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			ret = -ENOMEM;
 			goto out;
 		}
-		ethertype_filter_ptr->filter_info = ethertype_filter;
+		*ethertype_filter_ptr = ethertype_filter;
 		ret = txgbe_add_del_ethertype_filter(dev,
 				&ethertype_filter, TRUE);
 		if (ret) {
@@ -3223,13 +3199,13 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				actions, &syn_filter, error);
 	if (!ret) {
 		syn_filter_ptr = rte_zmalloc("txgbe_syn_filter",
-			sizeof(struct txgbe_eth_syn_filter_ele), 0);
+			sizeof(struct rte_eth_syn_filter), 0);
 		if (!syn_filter_ptr) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			ret = -ENOMEM;
 			goto out;
 		}
-		syn_filter_ptr->filter_info = syn_filter;
+		*syn_filter_ptr = syn_filter;
 		ret = txgbe_syn_filter_set(dev, &syn_filter, TRUE);
 		if (ret) {
 			rte_free(syn_filter_ptr);
@@ -3246,7 +3222,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 	if (!ret) {
 		if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
 			fdir_rule_ptr = rte_zmalloc("txgbe_fdir_filter",
-					sizeof(struct txgbe_fdir_rule_ele), 0);
+					sizeof(struct txgbe_fdir_rule), 0);
 			if (!fdir_rule_ptr) {
 				PMD_DRV_LOG(ERR, "failed to allocate memory");
 				ret = -ENOMEM;
@@ -3260,7 +3236,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				goto out;
 			}
 
-			fdir_rule_ptr->filter_info = fdir_rule;
+			*fdir_rule_ptr = fdir_rule;
 			flow->rule = fdir_rule_ptr;
 			flow->filter_type = RTE_ETH_FILTER_FDIR;
 			return flow;
@@ -3272,7 +3248,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		}
 
 		fdir_rule_ptr = rte_zmalloc("txgbe_fdir_filter",
-				sizeof(struct txgbe_fdir_rule_ele), 0);
+				sizeof(struct txgbe_fdir_rule), 0);
 		if (!fdir_rule_ptr) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			ret = -ENOMEM;
@@ -3345,7 +3321,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		if (ret)
 			goto fdir_out;
 
-		fdir_rule_ptr->filter_info = fdir_rule;
+		*fdir_rule_ptr = fdir_rule;
 		flow->rule = fdir_rule_ptr;
 		flow->filter_type = RTE_ETH_FILTER_FDIR;
 
@@ -3357,13 +3333,13 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 					actions, &l2_tn_filter, error);
 	if (!ret) {
 		l2_tn_filter_ptr = rte_zmalloc("txgbe_l2_tn_filter",
-			sizeof(struct txgbe_eth_l2_tunnel_conf_ele), 0);
+			sizeof(struct txgbe_l2_tunnel_conf), 0);
 		if (!l2_tn_filter_ptr) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			ret = -ENOMEM;
 			goto out;
 		}
-		l2_tn_filter_ptr->filter_info = l2_tn_filter;
+		*l2_tn_filter_ptr = l2_tn_filter;
 		ret = txgbe_dev_l2_tunnel_filter_add(dev, &l2_tn_filter, FALSE);
 		if (ret) {
 			rte_free(l2_tn_filter_ptr);
@@ -3379,7 +3355,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 					actions, &rss_conf, error);
 	if (!ret) {
 		rss_filter_ptr = rte_zmalloc("txgbe_rss_filter",
-			sizeof(struct txgbe_rss_conf_ele), 0);
+			sizeof(struct txgbe_rte_flow_rss_conf), 0);
 		if (!rss_filter_ptr) {
 			PMD_DRV_LOG(ERR, "failed to allocate memory");
 			ret = -ENOMEM;
@@ -3390,7 +3366,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			rte_free(rss_filter_ptr);
 			goto out;
 		}
-		txgbe_rss_conf_init(&rss_filter_ptr->filter_info,
+		txgbe_rss_conf_init(rss_filter_ptr,
 				    &rss_conf.conf);
 		flow->rule = rss_filter_ptr;
 		flow->filter_type = RTE_ETH_FILTER_HASH;
@@ -3486,16 +3462,16 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 	struct rte_eth_syn_filter syn_filter;
 	struct txgbe_fdir_rule fdir_rule;
 	struct txgbe_l2_tunnel_conf l2_tn_filter;
-	struct txgbe_ntuple_filter_ele *ntuple_filter_ptr;
-	struct txgbe_ethertype_filter_ele *ethertype_filter_ptr;
-	struct txgbe_eth_syn_filter_ele *syn_filter_ptr;
-	struct txgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
-	struct txgbe_fdir_rule_ele *fdir_rule_ptr;
+	struct rte_eth_ntuple_filter *ntuple_filter_ptr;
+	struct rte_eth_ethertype_filter *ethertype_filter_ptr;
+	struct rte_eth_syn_filter *syn_filter_ptr;
+	struct txgbe_l2_tunnel_conf *l2_tn_filter_ptr;
+	struct txgbe_fdir_rule *fdir_rule_ptr;
 	struct txgbe_flow_mem *txgbe_flow_mem_ptr;
 	struct txgbe_adapter *adapter = TXGBE_DEV_ADAPTER(dev);
 	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(dev);
 	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
-	struct txgbe_rss_conf_ele *rss_filter_ptr;
+	struct txgbe_rte_flow_rss_conf *rss_filter_ptr;
 
 	/*
 	 * Confirm the handle is on this port before changing hardware.
@@ -3513,20 +3489,18 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 	filter_type = pmd_flow->filter_type;
 	switch (filter_type) {
 	case RTE_ETH_FILTER_NTUPLE:
-		ntuple_filter_ptr = (struct txgbe_ntuple_filter_ele *)
+		ntuple_filter_ptr = (struct rte_eth_ntuple_filter *)
 					pmd_flow->rule;
-		rte_memcpy(&ntuple_filter,
-			&ntuple_filter_ptr->filter_info,
+		rte_memcpy(&ntuple_filter, ntuple_filter_ptr,
 			sizeof(struct rte_eth_ntuple_filter));
 		ret = txgbe_add_del_ntuple_filter(dev, &ntuple_filter, FALSE);
 		if (!ret)
 			rte_free(ntuple_filter_ptr);
 		break;
 	case RTE_ETH_FILTER_ETHERTYPE:
-		ethertype_filter_ptr = (struct txgbe_ethertype_filter_ele *)
+		ethertype_filter_ptr = (struct rte_eth_ethertype_filter *)
 					pmd_flow->rule;
-		rte_memcpy(&ethertype_filter,
-			&ethertype_filter_ptr->filter_info,
+		rte_memcpy(&ethertype_filter, ethertype_filter_ptr,
 			sizeof(struct rte_eth_ethertype_filter));
 		ret = txgbe_add_del_ethertype_filter(dev,
 				&ethertype_filter, FALSE);
@@ -3534,19 +3508,17 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 			rte_free(ethertype_filter_ptr);
 		break;
 	case RTE_ETH_FILTER_SYN:
-		syn_filter_ptr = (struct txgbe_eth_syn_filter_ele *)
+		syn_filter_ptr = (struct rte_eth_syn_filter *)
 				pmd_flow->rule;
-		rte_memcpy(&syn_filter,
-			&syn_filter_ptr->filter_info,
+		rte_memcpy(&syn_filter, syn_filter_ptr,
 			sizeof(struct rte_eth_syn_filter));
 		ret = txgbe_syn_filter_set(dev, &syn_filter, FALSE);
 		if (!ret)
 			rte_free(syn_filter_ptr);
 		break;
 	case RTE_ETH_FILTER_FDIR:
-		fdir_rule_ptr = (struct txgbe_fdir_rule_ele *)pmd_flow->rule;
-		rte_memcpy(&fdir_rule,
-			&fdir_rule_ptr->filter_info,
+		fdir_rule_ptr = (struct txgbe_fdir_rule *)pmd_flow->rule;
+		rte_memcpy(&fdir_rule, fdir_rule_ptr,
 			sizeof(struct txgbe_fdir_rule));
 		if (txgbe_is_pf(TXGBE_DEV_HW(dev)))
 			ret = txgbe_fdir_filter_program(dev, &fdir_rule,
@@ -3570,19 +3542,18 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 		}
 		break;
 	case RTE_ETH_FILTER_L2_TUNNEL:
-		l2_tn_filter_ptr = (struct txgbe_eth_l2_tunnel_conf_ele *)
+		l2_tn_filter_ptr = (struct txgbe_l2_tunnel_conf *)
 				pmd_flow->rule;
-		rte_memcpy(&l2_tn_filter, &l2_tn_filter_ptr->filter_info,
+		rte_memcpy(&l2_tn_filter, l2_tn_filter_ptr,
 			sizeof(struct txgbe_l2_tunnel_conf));
 		ret = txgbe_dev_l2_tunnel_filter_del(dev, &l2_tn_filter);
 		if (!ret)
 			rte_free(l2_tn_filter_ptr);
 		break;
 	case RTE_ETH_FILTER_HASH:
-		rss_filter_ptr = (struct txgbe_rss_conf_ele *)
+		rss_filter_ptr = (struct txgbe_rte_flow_rss_conf *)
 				pmd_flow->rule;
-		ret = txgbe_config_rss_filter(dev,
-					&rss_filter_ptr->filter_info, FALSE);
+		ret = txgbe_config_rss_filter(dev, rss_filter_ptr, FALSE);
 		if (!ret)
 			rte_free(rss_filter_ptr);
 		break;
-- 
2.53.0

