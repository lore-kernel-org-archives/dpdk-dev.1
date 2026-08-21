Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A7C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:30:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E44F040E2C;
	Fri, 21 Aug 2026 21:30:06 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 0A89540E28
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:06 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so1019958b3a.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340605;
 x=1787945405; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bKAAYztonh4rZ9ZQAL+VA0XYHIAH7rMLe7QscpqFO7E=;
 b=z8O6WYd8tK7T1vWwf07BCAnoCa8ocKISW0tzhaTihLUnRpUsRnXaef/ouxJbekeokB
 fgmQMpt3J6Nckdy1WRrkisxgE2I5rV30a1wHoeaYIouRUQK0snYZ3c/115iitLNz+V3l
 PvGKOUsDJa30Y2b7JNzDgIep/kaXjXP4vORbFrPLynWW7x3Ko4ATPwHtgl5Nb78Bt1ga
 Mx7eCaNzw/22vLKMuee7Xi5zDVRSpQQzzOj5z3v1Xp7H1+wrrm+G2qsQV/Dcv6kvKrYE
 U+sKAc6jcb8Lq30TMiPI82CjNyxpjtHUrRu3O1tqLL5rP+ppW9Ob9pviorRyhzkn1W9r
 ra3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340605; x=1787945405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bKAAYztonh4rZ9ZQAL+VA0XYHIAH7rMLe7QscpqFO7E=;
 b=kHtOULixBeReW3vmoYctEMSisokZG8vV/HQP0aJ1GGXoVVMNzCFmkTaH3cmkXe9fEN
 ybFTRMAI9+WwyVY1dZW/9sM2Zfhh8iN0G7Ib4JHtRgr+Z72Kcc2AZN941tjJIZBA5JJQ
 wqNb+HurI+INd7fbneupfnZLHfCrRwwbUm1yU5RUsOniRJGzJ2Ji4rx8hOfaowa/C2yv
 hO/oF9od5I2tecZtvSGz8bbqB3E9GSnygUrmb7ihKIIY6nZa80Zef4Axfz0JwPrX7MUq
 ESJ2V2jAcf+CkTePQj8+o58PkV74QvJzZxoAS6t1oFSDrMGewAirAqfpWTPexy8D+FTl
 KweQ==
X-Gm-Message-State: AFuF++lQ55suJTZ6AKdH6oi1pee3X6G1n4nbiRyjYjV91ayKvd26Nbtv
 tx+zZr8mLUwTw156oo69GYLSKnDSouRheSbTniCfOPRrnexFH79aHbc5HuhCD+LmDU6uTl5kPzd
 x22Ptvsc=
X-Gm-Gg: AR+sD12NPg/8MPQKLdGlUVxOhu+OvnukVHOi41MnAq4+oKmRoFIHUNkQaPQSsbnifk6
 0W58FSFjOO955/Hrtik3HZI3fco2p3MWBzyt8BcCDZ0MengyyKNrtQZNj0HMJLzWnP9AHALiHpC
 JronIoA+jQaCWyIe2Nr/tQ8XT8wFdXsONts+Jo4ew3HhfrKQrlERbw5mEEG4BDSDMedJ9EHYOdk
 vsn4Ud+woqy/FSzu139V7f2ZRyTW3j+svaX8qCK3hEcGYlmOWLxMX6Y/0ZjlKhI83H3EoZ1Iubk
 zRmK2ZmSSMvYIN4JXwYpeDLzUAH26eYkdh9X2Y0xmLniiDiwek8aRQre6PypaKg/rrNMRZPLEmw
 YBASyrnIarS0ZoaewIxAyBXTGTvxCJU9z20siU1G4YLN34O6acnhfgZtzRXIiAOl+ruQGZe8TI5
 9wEA1FGOP4i/iMi1ig36OXcWJS48/dFUhM53OyTDtjJZ17DqsXYJ90+ugE9nQsPwhVBYObvX58r
 l06BGOrRz4+kmGGAHyFDFm/XzY=
X-Received: by 2002:a05:6a20:4324:b0:3bf:9b61:f7ae with SMTP id
 adf61e73a8af0-3cd300caf9cmr15326994637.14.1787340605201; 
 Fri, 21 Aug 2026 12:30:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH v2 36/68] net/hinic: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:31 -0700
Message-ID: <20260821192646.146382-37-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.
Use memcpy() or structure assignment.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hinic/hinic_pmd_ethdev.c |  1 -
 drivers/net/hinic/hinic_pmd_flow.c   | 41 +++++++++++++---------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/net/hinic/hinic_pmd_ethdev.c b/drivers/net/hinic/hinic_pmd_ethdev.c
index 91a4348fb6..9db2979365 100644
--- a/drivers/net/hinic/hinic_pmd_ethdev.c
+++ b/drivers/net/hinic/hinic_pmd_ethdev.c
@@ -8,7 +8,6 @@
 #include <ethdev_driver.h>
 #include <rte_mbuf.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_mempool.h>
 #include <rte_errno.h>
 #include <rte_ether.h>
diff --git a/drivers/net/hinic/hinic_pmd_flow.c b/drivers/net/hinic/hinic_pmd_flow.c
index 6b1ca6ff88..12e8d4ac36 100644
--- a/drivers/net/hinic/hinic_pmd_flow.c
+++ b/drivers/net/hinic/hinic_pmd_flow.c
@@ -983,8 +983,8 @@ static int hinic_normal_item_check_ip(const struct rte_flow_item **in_out_item,
 		}
 
 		ipv6_spec = (const struct rte_flow_item_ipv6 *)item->spec;
-		rte_memcpy(rule->hinic_fdir.dst_ipv6,
-			   &ipv6_spec->hdr.dst_addr, 16);
+		memcpy(rule->hinic_fdir.dst_ipv6, &ipv6_spec->hdr.dst_addr,
+		       16);
 
 		/*
 		 * Check if the next not void item is TCP or UDP or ICMP.
@@ -2193,8 +2193,8 @@ static int hinic_add_del_ntuple_filter(struct rte_eth_dev *dev,
 				sizeof(struct hinic_5tuple_filter), 0);
 		if (filter == NULL)
 			return -ENOMEM;
-		rte_memcpy(&filter->filter_info, &filter_5tuple,
-				sizeof(struct hinic_5tuple_filter_info));
+		memcpy(&filter->filter_info, &filter_5tuple,
+		       sizeof(struct hinic_5tuple_filter_info));
 		filter->queue = ntuple_filter->queue;
 
 		filter_info->qid = ntuple_filter->queue;
@@ -2912,8 +2912,7 @@ static int hinic_add_del_tcam_fdir_filter(struct rte_eth_dev *dev,
 				sizeof(struct hinic_tcam_filter), 0);
 		if (tcam_filter == NULL)
 			return -ENOMEM;
-		(void)rte_memcpy(&tcam_filter->tcam_key,
-				 &tcam_key, sizeof(struct tag_tcam_key));
+		tcam_filter->tcam_key = tcam_key;
 		tcam_filter->queue = fdir_tcam_rule.data.qid;
 
 		ret = hinic_add_tcam_filter(dev, tcam_filter, &fdir_tcam_rule);
@@ -2990,9 +2989,9 @@ static struct rte_flow *hinic_flow_create(struct rte_eth_dev *dev,
 							&ntuple_filter, FALSE);
 				goto out;
 			}
-			rte_memcpy(&ntuple_filter_ptr->filter_info,
-				   &ntuple_filter,
-				   sizeof(struct rte_eth_ntuple_filter));
+			memcpy(&ntuple_filter_ptr->filter_info,
+			       &ntuple_filter,
+			       sizeof(struct rte_eth_ntuple_filter));
 			TAILQ_INSERT_TAIL(&nic_dev->filter_ntuple_list,
 			ntuple_filter_ptr, entries);
 			flow->rule = ntuple_filter_ptr;
@@ -3022,9 +3021,9 @@ static struct rte_flow *hinic_flow_create(struct rte_eth_dev *dev,
 						&ethertype_filter, FALSE);
 				goto out;
 			}
-			rte_memcpy(&ethertype_filter_ptr->filter_info,
-				&ethertype_filter,
-				sizeof(struct rte_eth_ethertype_filter));
+			memcpy(&ethertype_filter_ptr->filter_info,
+			       &ethertype_filter,
+			       sizeof(struct rte_eth_ethertype_filter));
 			TAILQ_INSERT_TAIL(&nic_dev->filter_ethertype_list,
 				ethertype_filter_ptr, entries);
 			flow->rule = ethertype_filter_ptr;
@@ -3065,8 +3064,8 @@ static struct rte_flow *hinic_flow_create(struct rte_eth_dev *dev,
 
 				goto out;
 			}
-			rte_memcpy(&fdir_rule_ptr->filter_info, &fdir_rule,
-				sizeof(struct hinic_fdir_rule));
+			memcpy(&fdir_rule_ptr->filter_info, &fdir_rule,
+			       sizeof(struct hinic_fdir_rule));
 			TAILQ_INSERT_TAIL(&nic_dev->filter_fdir_rule_list,
 				fdir_rule_ptr, entries);
 			flow->rule = fdir_rule_ptr;
@@ -3109,8 +3108,8 @@ static int hinic_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *flow,
 	case RTE_ETH_FILTER_NTUPLE:
 		ntuple_filter_ptr = (struct hinic_ntuple_filter_ele *)
 					pmd_flow->rule;
-		rte_memcpy(&ntuple_filter, &ntuple_filter_ptr->filter_info,
-			sizeof(struct rte_eth_ntuple_filter));
+		memcpy(&ntuple_filter, &ntuple_filter_ptr->filter_info,
+		       sizeof(struct rte_eth_ntuple_filter));
 		ret = hinic_add_del_ntuple_filter(dev, &ntuple_filter, FALSE);
 		if (!ret) {
 			TAILQ_REMOVE(&nic_dev->filter_ntuple_list,
@@ -3121,9 +3120,8 @@ static int hinic_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *flow,
 	case RTE_ETH_FILTER_ETHERTYPE:
 		ethertype_filter_ptr = (struct hinic_ethertype_filter_ele *)
 					pmd_flow->rule;
-		rte_memcpy(&ethertype_filter,
-			&ethertype_filter_ptr->filter_info,
-			sizeof(struct rte_eth_ethertype_filter));
+		memcpy(&ethertype_filter, &ethertype_filter_ptr->filter_info,
+		       sizeof(struct rte_eth_ethertype_filter));
 		ret = hinic_add_del_ethertype_filter(dev,
 				&ethertype_filter, FALSE);
 		if (!ret) {
@@ -3134,9 +3132,8 @@ static int hinic_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *flow,
 		break;
 	case RTE_ETH_FILTER_FDIR:
 		fdir_rule_ptr = (struct hinic_fdir_rule_ele *)pmd_flow->rule;
-		rte_memcpy(&fdir_rule,
-			&fdir_rule_ptr->filter_info,
-			sizeof(struct hinic_fdir_rule));
+		memcpy(&fdir_rule, &fdir_rule_ptr->filter_info,
+		       sizeof(struct hinic_fdir_rule));
 		if (fdir_rule.mode == HINIC_FDIR_MODE_NORMAL) {
 			ret = hinic_add_del_fdir_filter(dev, &fdir_rule, FALSE);
 		} else if (fdir_rule.mode == HINIC_FDIR_MODE_TCAM) {
-- 
2.53.0

