Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB478C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 15:33:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B90042F87;
	Thu, 17 Sep 2026 17:33:28 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id BAE1642F13
 for <dev@dpdk.org>; Thu, 17 Sep 2026 17:33:26 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396cccbba92so874274a91.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789659206; x=1790264006; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CM+ng/It2Pc9djPxWfU5YzOHj/aFBESVd6QwsOw0b1s=;
 b=nsYgeUkPnPcmtGXc0JQ9mU/RvSxyFuQRfQScr/TPEsijLCiBvlZk64XA38nXRzL3mW
 2yb5ZdysO1hN8tgX8d8YYxEGwtz9ubARFs7vw0c4+AF2DM6wb/xuw1At+lvITwl1fzSz
 BomrrYVW3Hav4bXTIAlM53wIuk7G43utVAvFWJecqPPOzZqoEvjvEgRmnfcRVHJKNzMH
 +pweW+yYueVcLgwTBdTioFyZCkTLGWrT9zQUodHMdAan4b9sIBu9fkOrIHk/4C9akvF4
 CglAT/48XIgJTCLyNyqgCHjQuivCbfnlVdZodp5iw+IRF6ydiTbTvYzKe7jjs+dlUFrC
 92Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789659206; x=1790264006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CM+ng/It2Pc9djPxWfU5YzOHj/aFBESVd6QwsOw0b1s=;
 b=OOOvgUgGll6gzxc/NFfbYInk8Op9eEP85JAFeSZYqvDQdA+O5NuLqlYR4E9ZrDCRrd
 B9l/6W0t63pXVDLJ3kjKXZDt3VUe4V1ykA4ZayVR89rB5+WKSYZjSHJnoVd9/gEL8D2R
 Sg3Ytpe0FOR4ql18DNzi9iyB/RLWW2hOgYIMOJQUxDYqy7U/cKkb2J/G0Z7sKhDznhXo
 7L6xUN9dJwOH4ff5ccwHBVn12cPkHJBKlGGb8fT2iwK2Dbv21TQRkJbpgw7g2KcCRXMH
 /ywp2HokBcpQ8gvux2rk4cRDLFCW8luwwPju65iZXUf7bsxFzvwY8wGtoBQ/L15Hg/9E
 WXIQ==
X-Gm-Message-State: AFuF++kJwdBjxJffUi+YxrVchmMSJWrzDlRN7kFoUndY7+jtaDeN1BFu
 bICRyboGG3PFxlEbUuB/4fTQVagk7Y5LrsOycn9UZ/xcCiZnB2EQvvAL
X-Gm-Gg: AYBFou3lb7inUr2MQlK8kbEWQDH8yZZWheu7w1dVCWXOelUfzU4Nx7/ZYqsXwPqvUw4
 StSOmJP4ziOCcN61WyfjzSjjhIjWQtfBym+d1xgcc8Q1LPMItIJnEcDXy25Ockpcb10bDIC/t8r
 SkFr0P/pE5AZJMu9N7w/qTkstAc45YhyMLsNMafdtZofL1KqUAA46c5gY31QTOcIk/vbxcrkwwT
 LrVsKMZAYqvAn1CBBVlBXZNhk9CoVJxaHGofljyHOtMqqP7v1nuXiCno30+VZNmXNyss4Jg/bJ0
 aDVwzRzXdaWXE+oliqqildhOGqyCuwmMkkP1EOy7SV+sZGeQiRWmMTnUqhoyBlL0aOlU9yOYBNZ
 CAJRjiwJaSibjoIAPJHG1qbxByRKmezJaJ50fTr9tDLeq5ERksen0mQiuZLELXEHA4rs/dr+ShB
 8P/15NzTwUkTGEzACLj4uQobBqvgPBJPIpAMWRoY/Ek1MoAi0IHM4TPWlUvrUx9MFthYmpp75dH
 yjdty2AHBKsMYcH8A==
X-Received: by 2002:a17:90b:4e83:b0:39e:4c81:6c66 with SMTP id
 98e67ed59e1d1-39e4c817908mr1268405a91.33.1789659205733; 
 Thu, 17 Sep 2026 08:33:25 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e35df6112sm5730350a91.7.2026.09.17.08.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 08:33:25 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org
Subject: [PATCH v3 3/3] net/txgbe: fix FDIR error handling on flow create
Date: Thu, 17 Sep 2026 23:32:42 +0800
Message-ID: <20260917153242.29315-4-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917153242.29315-1-zhtfdev@gmail.com>
References: <20260916131106.105667-1-zhtfdev@gmail.com>
 <20260917153242.29315-1-zhtfdev@gmail.com>
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

Reject a mask-only FDIR rule before programming the global input mask,
so a failed create cannot leave the mask committed.

Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 56 ++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index a1a497fa22..b4138cdc4e 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3355,6 +3355,12 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			goto out;
 		}
 
+		if (!fdir_rule.b_spec) {
+			rte_free(fdir_rule_ptr);
+			ret = -EINVAL;
+			goto out;
+		}
+
 		/* A mask cannot be deleted. */
 		if (fdir_rule.b_mask) {
 			if (!fdir_info->mask_added) {
@@ -3388,12 +3394,12 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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
 
@@ -3401,37 +3407,35 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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

