Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0C8C982D8
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 18:30:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99DE34334B;
	Fri, 18 Sep 2026 20:30:50 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 5BB3543328
 for <dev@dpdk.org>; Fri, 18 Sep 2026 20:30:46 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so1121199a91.2
 for <dev@dpdk.org>; Fri, 18 Sep 2026 11:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789756245; x=1790361045; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t5MpOFNIcyz7ieW1N7t9E4vjpq/LF1h97JGOWuXlt34=;
 b=Noozf2KnDvnhbU6uTYprcQjHIojnsVmQ1SgCjYrwuXnVVYa8zHR4UsoGLmbA6CMgb/
 TaBC78lYqAD4ygU3YZ4ATvPkoTRFrGznc2WGzL2gP/yEcHRAXFQ8jydCUR3CILcrwlAc
 CLYCicJB0U8BodtGP/5G2qEySyuPk7PqL23CtRykNr5ikb4mRmG4PBRcGQbaxHeCyvrk
 7wYy+oiRJLEn2ByGRYCqdi10SmakcLWOVmB+lW9+QwLK7t+CKncTNOvBwYyOW9xHcWJS
 jW12p/95gnPjxclcqq6iKp5X8SW+PTa4XHrYDNcGhPjiprRoFJ2p8ZSXMCI8/iDy6lVD
 qd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789756245; x=1790361045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t5MpOFNIcyz7ieW1N7t9E4vjpq/LF1h97JGOWuXlt34=;
 b=lbBRfhoPcGJ4ycHzlDlSBuTQN0DNXqlVLGNKZPoMlEIl4Vjxy1tuiS0lm4ZthRRspo
 Tr6EhWzuCwucc2SO/BBw/xr8oO/eRiL05ZY4hLrelGwdyq9MW4tDJdgyDhnH2o0Rn738
 u2uyWzb8OwBYNefUXLmElJtD+or672DnQ848zA4BatgWKpoQPNnJvV2g1UCMY0tBpiVH
 PkzPyYWXEFjTUXHc7a/wf5tq4huomK7XdfXAELKodNBgXXbMcNn71QXrhT3HFjQ1GFTG
 8DQOwNK9KlASyo03DUbKMS6YbGbvQNRYXFVL5xeSRzvRWN/dqF4NpGRFxMdxqR8MVVpl
 84MQ==
X-Gm-Message-State: AFuF++mViDotNwLwjlxho6luOm9sfWxGDnNsmNHN37F6XQAO7Wn5kh8x
 hYMxj53g95FvWPe+66vNCcxQjZxe/U9hRWZMPUO+bnx1qVpV5gjUe7cK
X-Gm-Gg: AYBFou397FRLW5GozNaTQawps0YDCFP8Naaf/VTh6pdmCeISCRu5uNIiCCbUVOuhHVw
 QbHKAzgSKBwpxSSAwDFLTkdGo4/8vbr2YKnKOr9Q9jyaHg4QPGyoQsYXle1EX1ATiMjZ7qruHhL
 GvBXr+2CpN5XkVC50Ixo4lQODh3HgnRvzoVTjZrByufG98IclZ91s62qGShsMgMlk+w36XPBi7N
 MIZliRZK0J0+TCqhUFk2jwlemtNzXTg3etZ9o9dAAY7WG0rV8kp+PrX35TG2KtLk3b5wgFKK2nv
 Mpy9FQ8vUhK2HPEi348+6eWO12fdkAUZ8rGLPDYkj+PJ7oM9uyZppa1TwNxc4bjrc9rsCIqIzrD
 ENd6IqoHiXHS2MHH1OBywoUVwOAfHOX7JilcGe26KKH6o76MLuYjSO7v3q5ClK4Z1HzJ5H560wM
 x2N5+yGudE12u1lTXceOvgO6pdwlmeuBwmdGqnHBzPrv9p7bdtdTADNBh4Me70JgdCi9KcKzcLf
 6zfOdA=
X-Received: by 2002:a17:90b:57c5:b0:39e:3554:4d0e with SMTP id
 98e67ed59e1d1-39e54c584c7mr13363067a91.1.1789756245380; 
 Fri, 18 Sep 2026 11:30:45 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d4c0dsm397209eec.29.2026.09.18.11.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:30:45 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org
Subject: [PATCH v4 3/3] net/txgbe: fix FDIR error handling on flow create
Date: Sat, 19 Sep 2026 02:30:11 +0800
Message-ID: <20260918183012.42520-4-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918183012.42520-1-zhtfdev@gmail.com>
References: <20260917153242.29315-1-zhtfdev@gmail.com>
 <20260918183012.42520-1-zhtfdev@gmail.com>
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

On failure, txgbe_flow_create() calls rte_flow_error_set(error, -ret),
so ret must be a negative errno. The FDIR flex offset mismatch path
leaves ret at 0, and the application sees errno 0. The global mask
memcmp path stores memcmp's return value in ret, which is not an
errno. Set -EINVAL on both paths.

Reject a mask-only FDIR rule before allocating the software object or
programming the global input mask, so a failed create cannot leave the
mask committed.

Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 55 ++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index a1a497fa22..f8d8c6850d 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3347,6 +3347,11 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			return flow;
 		}
 
+		if (!fdir_rule.b_spec) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		fdir_rule_ptr = rte_zmalloc("txgbe_fdir_filter",
 				sizeof(struct txgbe_fdir_rule_ele), 0);
 		if (!fdir_rule_ptr) {
@@ -3388,12 +3393,12 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				 * Only support one global mask,
 				 * all the masks should be the same.
 				 */
-				ret = memcmp(&fdir_info->mask,
+				if (memcmp(&fdir_info->mask,
 					&fdir_rule.mask,
-					sizeof(struct txgbe_hw_fdir_mask));
-				if (ret) {
+					sizeof(struct txgbe_hw_fdir_mask)) != 0) {
 					PMD_DRV_LOG(ERR, "only support one global mask");
 					rte_free(fdir_rule_ptr);
+					ret = -EINVAL;
 					goto out;
 				}
 
@@ -3401,37 +3406,35 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				    fdir_rule.flex_bytes_offset ||
 				    fdir_info->flex_relative !=
 				    fdir_rule.flex_relative) {
+					PMD_DRV_LOG(ERR,
+						"flex bytes offset mismatch");
 					rte_free(fdir_rule_ptr);
+					ret = -EINVAL;
 					goto out;
 				}
 			}
 		}
 
-		if (fdir_rule.b_spec) {
-			ret = txgbe_fdir_filter_program(dev, &fdir_rule,
-					FALSE, FALSE);
-			if (ret) {
-				rte_free(fdir_rule_ptr);
-				/**
-				 * clean the mask_added flag if fail to
-				 * program
-				 **/
-				if (first_mask)
-					fdir_info->mask_added = FALSE;
-				goto out;
-			}
-
-			fdir_rule_ptr->filter_info = fdir_rule;
-			TAILQ_INSERT_TAIL(&filter_fdir_list,
-				fdir_rule_ptr, entries);
-			flow->rule = fdir_rule_ptr;
-			flow->filter_type = RTE_ETH_FILTER_FDIR;
-
-			return flow;
+		ret = txgbe_fdir_filter_program(dev, &fdir_rule,
+				FALSE, FALSE);
+		if (ret) {
+			rte_free(fdir_rule_ptr);
+			/**
+			 * clean the mask_added flag if fail to
+			 * program
+			 **/
+			if (first_mask)
+				fdir_info->mask_added = FALSE;
+			goto out;
 		}
 
-		rte_free(fdir_rule_ptr);
-		goto out;
+		fdir_rule_ptr->filter_info = fdir_rule;
+		TAILQ_INSERT_TAIL(&filter_fdir_list,
+			fdir_rule_ptr, entries);
+		flow->rule = fdir_rule_ptr;
+		flow->filter_type = RTE_ETH_FILTER_FDIR;
+
+		return flow;
 	}
 
 	memset(&l2_tn_filter, 0, sizeof(struct txgbe_l2_tunnel_conf));
-- 
2.53.0

