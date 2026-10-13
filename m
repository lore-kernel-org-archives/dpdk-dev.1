Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F97CC6B08
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:01:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20B0A40653;
	Tue, 13 Oct 2026 16:01:33 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3BE9D4064E
 for <dev@dpdk.org>; Tue, 13 Oct 2026 16:01:31 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc502d509c0so931012a12.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791900090; x=1792504890; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hhZAPKpUhDknhOImBHyfkajD1xItfAhDDv4ljYn6r3s=;
 b=UBmmTJ6JwzW/wfXd6qKqT87ifDRUkHw07Kf3wI99rdAGmEo9RoJ4jH8GqY5D3z4Uca
 NV/xUX6lRbtAJDhoXYvs/6oXbDOodI2rbWEaAX+aUtiS3bcSxfXNE+pWuIBL6BXpR+ch
 lkdu0sSeNPqBUhqhoolhbCPguPO5uY8phH5AGBA0maGUfVHgbHTNpJSn/POtp2mHNXHy
 tQD7qirFSCd/wUl6m2Pllgr8axSakSRENKvhQuSh5UKsLAUQm9WnrBWC3g55cbcsM5KD
 ZK0PELswzGddLiTi7fm5WrOHwD8qkqkBMnJ9qvMtZ6S20Quze7QzbH7/kC3TAjt1PlvZ
 GbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791900090; x=1792504890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hhZAPKpUhDknhOImBHyfkajD1xItfAhDDv4ljYn6r3s=;
 b=jygVm0mZlJgrETJn73cxtU3kXSb2JpdcSdBYUmbXSb+b8eJOKDrfZPUcGl/LIkaMEh
 VCJMcYq8wfPuf95CFKDujhJmz6o2GsF8ozB95VAmHtNYW9mRUV0Otn87Rwwl4dQw9vzo
 TyXEiz5Z2LgfphWVCgIMPczGt1uYaQkFHBjEZ/YGfQqQIZaxyl+/me3sdmaR+YrOhQfQ
 pP+n52DZDbKxB9qivB00LAIlub6QiUn+Z7aFY4qrcHUjH2uxmc52m17snJ1Hc13vSJZV
 it16egXA/ev2QbWshc31FTAzSGqzXpPM1Gbgta8ECtMO0ZJHueBE1O+Pn1d3CqN6Tcnt
 5jCA==
X-Gm-Message-State: AFq9FYKxqUB1JK+QWUsOXfyGf0PAvll4ACTNubbtSGI1CdA4ggX+Y6oH
 f2YU/Ryi+dAzcLk9m12wvu0RxCNlEyK6g/SaT2N/mkndBtftbZT0R/NLem7Wlg==
X-Gm-Gg: AYBFou23Mkoy9CG/FUyEqxJqwEhb0e5bNX4xv5oDVtJXdwl+xZo7q9chuRD8jqKrE60
 3TqcGqzL0ZzUO5tDZT3GMreKYF+RMXb7pK/z9LDkXhnUdwwz3g92FResF1kfG2l2MteqtxCkj9f
 ndD1k5CGxtbD2z8a61CoSP3Oi4hLzmBT6YegBSOgE9yHwkgKW0dDIsgviAbgxKGUCs+JA2TXJsb
 azF+fgKM/K1u8plhsoGmk5g8SJhBuW7yZGJSe1HdkjrJ52ng5rsPJbCCVhI+u/2a09KTdbhZj30
 hqC4yzDKDlfjT6EBsqePPyakwX4yeBLXGw2BzKHEk6lLgFoludinvT2mMgzmUwUdbv8uXzLeiwg
 O7OzZOxiHUV+33xucRelM5xctdv/4P/Bgcbv2JDaCjvA7xCDWCJCoF/1sOINPfMZf+jW1+DfIDj
 GiRffIfcFB0Bve83+kuK+KFcVzm/EFxKn/rPOSKIRTDjXFeVhM3H5jlT5OVxOZMBJNfrHfIpaNG
 Tj5J9g=
X-Received: by 2002:a17:90b:2d0b:b0:3a7:e11c:4e6e with SMTP id
 98e67ed59e1d1-3ab3a97a71dmr10799133a91.59.1791900090049; 
 Tue, 13 Oct 2026 07:01:30 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371c32cesm20733947a91.16.2026.10.13.07.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:01:29 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Zhang Tengfei <zhtfdev@gmail.com>,
 jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com, stable@dpdk.org
Subject: [PATCH 2/3] net/txgbe: do not enable flow director on flow validate
Date: Tue, 13 Oct 2026 22:00:18 +0800
Message-ID: <c5100ed9a24b032f070da660ec4ecb59469ef504.1791898970.git.zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791898970.git.zhtfdev@gmail.com>
References: <cover.1791898970.git.zhtfdev@gmail.com>
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
if the first rule fails.

Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 55 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index f8d8c6850d..f2fc589a10 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2966,16 +2966,9 @@ txgbe_parse_fdir_filter(struct rte_eth_dev *dev,
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
+	if (fdir_conf->mode != RTE_FDIR_MODE_NONE &&
+	    fdir_conf->mode != rule->mode)
 		return -ENOTSUP;
-	}
 
 	if (rule->queue >= dev->data->nb_rx_queues)
 		return -ENOTSUP;
@@ -3208,17 +3201,19 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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
@@ -3360,6 +3355,16 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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
@@ -3381,10 +3386,8 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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
@@ -3397,9 +3400,8 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 					&fdir_rule.mask,
 					sizeof(struct txgbe_hw_fdir_mask)) != 0) {
 					PMD_DRV_LOG(ERR, "only support one global mask");
-					rte_free(fdir_rule_ptr);
 					ret = -EINVAL;
-					goto out;
+					goto fdir_out;
 				}
 
 				if (fdir_info->flex_bytes_offset !=
@@ -3408,25 +3410,16 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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
@@ -3486,6 +3479,12 @@ txgbe_flow_create(struct rte_eth_dev *dev,
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

