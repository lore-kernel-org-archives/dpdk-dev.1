Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C452C3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:39:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 971024069D;
	Wed, 14 Oct 2026 18:39:53 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id BD1FC4069D
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:39:51 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-88b5f43cb8aso279384b3a.3
 for <dev@dpdk.org>; Wed, 14 Oct 2026 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791995991; x=1792600791; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fF9KBn+fPuJHTOUw+HX0HzJuh3JtbOLlhLl5PUuGMlM=;
 b=hKTv8aH/p1MgSBO0PI2YaZi0gi4fbQsJcQLL92kau453J0L6GFT7cn6oIun7x0mAJs
 wWmshLcYhcV427w6RLA9mOQUF6FFCKYggEG/V3NTtcoXT96s5Virf1p8+CtfWYKYhkeH
 toB58fazE8qtlmQPlp5ODZ9jxCFTWL6hG/RVhx1oesb62MJDq+gSta6RHAxmFNAgbaTW
 CvFraUtyx5Wr1ANC0xnUzgztQVnLIsnNet6M1tGAPC+qq4Bgm5fP0GCRXbozycaKy9iz
 NK1tqgAaPXZOyJVFacTW6gRTEGPllweOPyYe8PuTvESlLo9TD4gsBUzovnnUrty3SIev
 cTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791995991; x=1792600791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fF9KBn+fPuJHTOUw+HX0HzJuh3JtbOLlhLl5PUuGMlM=;
 b=KhFX18XJT/s65KluNCJxfSXccwZPPmcDB6zs2iaJ90wZ+KWrRyxoTu1bSnYAnFgCsI
 nFV3W3f1buNBVUaHseI3Qwye30kzBtzXioHt5QJjsxWKCw7y8nYIgJ9zvY9dz+M8pUNh
 nyxz9tzpEhSYsVAwM+Cko5wiB/3DWGrKRn72bNZ6lCKXTelqkTQYwhcPt6LrkKmhSz57
 punv5sN6/kzlY3zW+JiSRywJFxWIn+UF3OtmCsrX4Fw1WqVUmLmnPZT9/G0aUBbe7g0m
 Brmkj7J3i9vQYNcvY2YqAE5wI1HWAYYcGB2lVK3xHY/GOjkRFP+P7/yqE7M1eHthJHJj
 9N9Q==
X-Gm-Message-State: AFq9FYJL53lYfpWE0oY/PCfSaqauMsEyc9IcFDlJPDCKY7KdPdFZF3d3
 j+j9o4/9YfueV/OslRSEvwe5N4vVQvSBTuEhCBuQXOP9xNoxvr/wVORT5xsRxRI+
X-Gm-Gg: AYBFou2IksRdaZeh6sOv8fctKlCWyHixzlRvkPhOtxctCnEYyOL9gcTU709Mli0XHJR
 xruNqW5ZTeQa5jUzW1CN+kIKLvyG1lDGxf8fGEqQoinXo616vkmdaW+d46gbY7O13CMjBr7xSCo
 MT+B3QV07SSWJ7iwY7uOFfN9LDcSXtW0DsBH/DDp6hWzSpujz3WdsfqP7bCbSlt1AZRc5hw6cm1
 3JJ5tzelxUbJRrT5ezBD6ViSZVg458GQ1Z9/pVAFhOwMNed+7aOQ7IiucUgVmSI0pwpyBR3MfsO
 3TYVZVCkQmEACxifFtQdjoQ6/go0zZ3Q62brUgLlsSOntZwH7S1aA7LNwZIKZFDN4nlW7ldoedA
 QfRRhHnpJ39oiNiNZgkBdFWS+CGf0S+m7XxcUxNRnOm1YBG6tUYTDej5mHXXAXATl6v0tLe6c4h
 IFKRduMNRbSvvaAvHpFxmuQAoshf0FgbUNPVPKzKPAC+Q6wU8CNanI/15bryfe4il0+F44gfqMh
 KdXe+U=
X-Received: by 2002:a05:6300:6bd6:20b0:3e1:73d6:692a with SMTP id
 adf61e73a8af0-3e173d6748bmr8868886637.5.1791995990704; 
 Wed, 14 Oct 2026 09:39:50 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635cd3b34sm83677a12.28.2026.10.14.09.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:39:50 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: Zhang Tengfei <zhtfdev@gmail.com>, jiawenwu@trustnetic.com,
 zaiyuwang@trustnetic.com, stephen@networkplumber.org, stable@dpdk.org
Subject: [PATCH v2 2/3] net/txgbe: do not enable flow director on flow validate
Date: Thu, 15 Oct 2026 00:39:23 +0800
Message-ID: <955d2662143a361ab48d8517e5f2fe5c3de78e84.1791995192.git.zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791995192.git.zhtfdev@gmail.com>
References: <cover.1791995192.git.zhtfdev@gmail.com>
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

Flow Director was enabled and its mode recorded while parsing a rule,
so validating a rule configured the hardware, and the mode stayed
locked when the rule was rejected afterwards, e.g. for an invalid
queue or when the rule could not be programmed.

Enable Flow Director only when creating the rule, and reset the mode
if the first rule fails. Reject a mode other than signature or perfect
while parsing. Configuration does not implement it, so validate and
create fail the same way.

Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 59 ++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index f8d8c6850d..0b7ce3aa2d 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2966,16 +2966,13 @@ txgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 	if (!txgbe_is_pf(TXGBE_DEV_HW(dev)))
 		return ret;
 
-	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
-		fdir_conf->mode = rule->mode;
-		ret = txgbe_fdir_configure(dev);
-		if (ret) {
-			fdir_conf->mode = RTE_FDIR_MODE_NONE;
-			return ret;
-		}
-	} else if (fdir_conf->mode != rule->mode) {
+	if (rule->mode != RTE_FDIR_MODE_SIGNATURE &&
+	    rule->mode != RTE_FDIR_MODE_PERFECT)
+		return -ENOTSUP;
+
+	if (fdir_conf->mode != RTE_FDIR_MODE_NONE &&
+	    fdir_conf->mode != rule->mode)
 		return -ENOTSUP;
-	}
 
 	if (rule->queue >= dev->data->nb_rx_queues)
 		return -ENOTSUP;
@@ -3208,17 +3205,19 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 	struct txgbe_fdir_rule fdir_rule;
 	struct txgbe_l2_tunnel_conf l2_tn_filter;
 	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(dev);
+	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(dev);
 	struct txgbe_rte_flow_rss_conf rss_conf;
 	struct rte_flow *flow = NULL;
 	struct txgbe_ntuple_filter_ele *ntuple_filter_ptr;
 	struct txgbe_ethertype_filter_ele *ethertype_filter_ptr;
 	struct txgbe_eth_syn_filter_ele *syn_filter_ptr;
 	struct txgbe_eth_l2_tunnel_conf_ele *l2_tn_filter_ptr;
-	struct txgbe_fdir_rule_ele *fdir_rule_ptr;
+	struct txgbe_fdir_rule_ele *fdir_rule_ptr = NULL;
 	struct txgbe_rss_conf_ele *rss_filter_ptr;
 	struct txgbe_flow_mem *txgbe_flow_mem_ptr;
 	struct txgbe_filter_info *filter_info = TXGBE_DEV_FILTER(dev);
 	uint8_t first_mask = FALSE;
+	bool fdir_configured = false;
 
 	flow = rte_zmalloc("txgbe_rte_flow", sizeof(struct rte_flow), 0);
 	if (!flow) {
@@ -3360,6 +3359,16 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			goto out;
 		}
 
+		if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
+			fdir_conf->mode = fdir_rule.mode;
+			ret = txgbe_fdir_configure(dev);
+			if (ret) {
+				fdir_conf->mode = RTE_FDIR_MODE_NONE;
+				goto fdir_out;
+			}
+			fdir_configured = true;
+		}
+
 		/* A mask cannot be deleted. */
 		if (fdir_rule.b_mask) {
 			if (!fdir_info->mask_added) {
@@ -3381,10 +3390,8 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				fdir_info->mask.pkt_type_mask =
 					fdir_rule.mask.pkt_type_mask;
 				ret = txgbe_fdir_set_input_mask(dev);
-				if (ret) {
-					rte_free(fdir_rule_ptr);
-					goto out;
-				}
+				if (ret)
+					goto fdir_out;
 
 				fdir_info->mask_added = TRUE;
 				first_mask = TRUE;
@@ -3397,9 +3404,8 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 					&fdir_rule.mask,
 					sizeof(struct txgbe_hw_fdir_mask)) != 0) {
 					PMD_DRV_LOG(ERR, "only support one global mask");
-					rte_free(fdir_rule_ptr);
 					ret = -EINVAL;
-					goto out;
+					goto fdir_out;
 				}
 
 				if (fdir_info->flex_bytes_offset !=
@@ -3408,25 +3414,16 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				    fdir_rule.flex_relative) {
 					PMD_DRV_LOG(ERR,
 						"flex bytes offset mismatch");
-					rte_free(fdir_rule_ptr);
 					ret = -EINVAL;
-					goto out;
+					goto fdir_out;
 				}
 			}
 		}
 
 		ret = txgbe_fdir_filter_program(dev, &fdir_rule,
 				FALSE, FALSE);
-		if (ret) {
-			rte_free(fdir_rule_ptr);
-			/**
-			 * clean the mask_added flag if fail to
-			 * program
-			 **/
-			if (first_mask)
-				fdir_info->mask_added = FALSE;
-			goto out;
-		}
+		if (ret)
+			goto fdir_out;
 
 		fdir_rule_ptr->filter_info = fdir_rule;
 		TAILQ_INSERT_TAIL(&filter_fdir_list,
@@ -3486,6 +3483,12 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		return flow;
 	}
 
+fdir_out:
+	rte_free(fdir_rule_ptr);
+	if (first_mask)
+		fdir_info->mask_added = FALSE;
+	if (fdir_configured)
+		fdir_conf->mode = RTE_FDIR_MODE_NONE;
 out:
 	TAILQ_REMOVE(&txgbe_flow_list,
 		txgbe_flow_mem_ptr, entries);
-- 
2.53.0

