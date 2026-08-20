Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AE7C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:25:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7319440E0A;
	Thu, 20 Aug 2026 07:24:51 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id BAECD402BA
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:50 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38e347638adso2003699a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203490;
 x=1787808290; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bKAAYztonh4rZ9ZQAL+VA0XYHIAH7rMLe7QscpqFO7E=;
 b=gJOqE60s9T/ALHzQBBK8OtruyUdk3XHaWKabkvhDmGo3uqpQ2oTlPMr5dwjkQ79hOs
 aI9Ghhs+KuuuLZocnSqlwJygb+GY3fODVWp5QJrsG84f0gWFKSStxa+U/aIaUgJc1SfD
 YwcmCk2GifgM7j3JVLmpAtlSL2Ye/l3GbauVzUca3b1xtneSRf4kG34GBSZT3Nw8xJ4m
 WB8b1iemmlX0h6J0pl3t03ANUxW+NpIxR37thHLqzS0yhpd5lU02FR9WYGEYOHy0l1gl
 dRJlQGnr1mwDAJ0gwWz5ftXVjcyxCJMu45d15LywyYcCQ2Pgbl4RxVLVpT3cPndaUZSc
 norQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203490; x=1787808290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bKAAYztonh4rZ9ZQAL+VA0XYHIAH7rMLe7QscpqFO7E=;
 b=ehvtdQQiqZ4wqBeLz8R3uidpCehiVSBRQTs8ZR6KXqmkNfam4fUhkxvzHO9WwiLCuK
 B0LMByEHE7qNt4mDTrN6S98nfl9NRUjjfwcF2ak6oPtiR/+PG50Hvl74dJBNHdbX2bsZ
 EXhP64XQE81YY2jh06Ka8upBfjks6C3UvzZEnLuQfFV/QHOTg9uP82BDLjK3rQmuQiUx
 id0JPspob9KJyi55IPZmD2KZckZeRO+oLhmEr3eQwfGLU0sacOorCO4O8blHsubhQF5f
 KsrJhXQ0z2PrTleeVvEvoZhLPZNQNhvGp+k8rXbHzbFSpAwr/qfUYHnoodsioVpXtJIP
 VjWw==
X-Gm-Message-State: AFuF++lI4qMUjbU/RlRXokd0v6QKJmj3hle+npJS6FYSs99noknNsrEx
 hLn6e5eY8444R64YyOaNgAeWJwemZaeiMlW8s8BgKxEsz/DegCj6xwgzJ2ET/jAJLI1tftva/0f
 N1wR/
X-Gm-Gg: AR+sD10fO5F/Tyq/qvUjC/VIiW3eFQQXL3UNP5sMY4J3f/y5jbY/43UpYtx1C77eApx
 kjMIHuMtB8xBdJtjdBvLl2vIs7mQfSkWp7b9P5DlJXIEC1EgHYcCZr6Wkh+gFP5zZW0s/es3iRx
 XSYbqfjkzSt6AfE+4EJNZ1AAem0mHMmBS8lxzZITWcx38JkMB5RzdJ7YwtMt3Nx4u2HwBmJ43b0
 ropEH3aopbVBN1d+Q6B+8PA8qtRA28HpkpLXW9exrek2PAP5tHC/BVKMxZaxIm5vEmZKg3+Wn/T
 f47x2zoTPONfP3SJjJBbYbseHzaCbt0UGZFSwXL3CsHOO1ANCnml+0ISQbg66OzV87QkYWUhAqg
 tc7e+lmuZDGa6BO1ArHVzUyUVX8/8x0Ay/LogtcSotdi9dzLHR2HWnfK6ysA6JfUrTLAVIG6r10
 GpsQABkmFoIl4SySsAXadeW93vwoghKJ/6Rt6jIRSg9kUjMMc9rR2KuDGN5L7hTRNXtWlQ9or8u
 5Sgz9dBACt4fuWOPYZ0PELuhVg=
X-Received: by 2002:a17:90b:4c12:b0:393:1cf4:d972 with SMTP id
 98e67ed59e1d1-39580a80649mr17814461a91.3.1787203489798; 
 Wed, 19 Aug 2026 22:24:49 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiaoyun Wang <cloud.wangxiaoyun@huawei.com>
Subject: [PATCH 29/61] net/hinic: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:19 -0700
Message-ID: <20260820052251.1453273-30-stephen@networkplumber.org>
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

