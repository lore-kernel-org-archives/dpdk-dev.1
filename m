Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609B7C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:26:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86A864068A;
	Thu, 20 Aug 2026 07:25:00 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 05F82402BA
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:24:59 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so1690466a91.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203498;
 x=1787808298; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bgVmLLtEOCwhmcbaigCWS66335gVrY7HhRX6ppZ/dKA=;
 b=0MCNgUjbpBIs9EkThQ2Uj1RErqKBLIGzMojgt0DhmugRvMYFtxggDPgO0a9m9wvua8
 ixJrcD8yJa/k05Q1m9Nc/tqDZM7ZP21W8KfXue7IeWwFFJX5S6jVKBBINDowS/sCpAGu
 6quYkfdN78a56AS7s7n+TJOgDgPrsw5+J4JQcxRjtrwU0CBjQWj6M/JE9sz0SE1qW9nM
 hqiRz7DTNI2RFzEEokbDQO+H2LVS/QoI06zOIp2t1EcGydatXAVfqAMURLOF8wFLKdlu
 /QinwwN3+Xtxg57wA/swhAWmixaNw9BJsY2NAx5HVx+NAL5TTncab2rHXlJpe++tN13p
 sLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203498; x=1787808298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bgVmLLtEOCwhmcbaigCWS66335gVrY7HhRX6ppZ/dKA=;
 b=lBZviDpYipU4jvVadD9S5uei30uTgfwbVaNdh8Rfklr109NJtVoErgx69zcM+0W2Zu
 MWLJjxOmSPseKteQkT35Gp8E8tGokXH2mFdSjTsRnDgtAsfYpwW1FACwXC9dRpIhCp8l
 6MYW3sTjlj+L2v6FTO42HAw3d0MI2l4kimPMfAxR49Zh5YCV6lezpTOId4Gezxu/u9EX
 BYBWBZ8inrXhb3Txr5pK09+vJmUWtnhQumXvsGFHp4Yu8j8U3KS+gLlhswhgNb1udmEn
 LnO1UXt0yu87KuBqPrvDj/kfg/9NvxiYcbK3hBMeL85CxYJgdGemHVI+LrWmLvKVvrbm
 +xVg==
X-Gm-Message-State: AFuF++nY+UimFbDeh/Xzu/bjvuXcPdn2Fi7IArQL9I8mFh3bSU4533+V
 /Qv8e6moqVL9V6zXem7i54NZmCyaHgprc6rPAcKkK9cqgN2zHrCIJu9GIRcGCND094TEP5VESRs
 z33p1
X-Gm-Gg: AR+sD10IWfNC3s+7OS1fmHP/fXeK0K2KHgDxFaNgQxxUccQMdykES72YlYyyWVbu0j9
 Zbb9P2Rvla3si6AVlPe5DKEp6x32xS7tcHIOWMDSAVbe7JrqETkQcVAGaqD/4Wr7C5ccar+zMtN
 4JQYkJqTPIs8tKHojnXFnMhFTDSlq1mTQDUSMEj21oq145ymfnYEKWtf1U2rV6W2J5iTljXAkwq
 2j9C2s6OeUqdM8FRCNruotIu0lzBMAHN41RHHfcfuQRbgg6t2djLifdO9ulYrVvHG/VMDMdI8S1
 W1rZ0+5N9bWRV0Du9pIjEh0C1XnRCr9WCmWwdAUAoeKlnCi0DkEHb6dSWBoxqOk1KKBaAXj+5I/
 ijDnnXNQ1q++TYBswbkTj92pzBIZ5VWI6Tf098bRNLyla91d8/WyM4WVH/2FBloMbpIQWwoRdEl
 16LAIo4JpEsVbft2he4+5JbJ2yN8wPc9szUWMWViidLOtdkkkRUYbtrXj24tkUfLed8IJA0qeRp
 bqOjhjOO+fmPvc9J7zsdMf3gZQ=
X-Received: by 2002:a17:90b:1cc8:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-39580a5052fmr19408686a91.4.1787203498017; 
 Wed, 19 Aug 2026 22:24:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:24:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 31/61] net/mlx5: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:21 -0700
Message-ID: <20260820052251.1453273-32-stephen@networkplumber.org>
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

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/mlx5/mlx5_devx.c     |  4 ++--
 drivers/net/mlx5/mlx5_flow.c     | 38 ++++++++++++++++----------------
 drivers/net/mlx5/mlx5_flow_aso.c |  6 ++---
 drivers/net/mlx5/mlx5_flow_hw.c  | 31 +++++++++++++-------------
 drivers/net/mlx5/mlx5_rx.c       |  6 ++---
 drivers/net/mlx5/mlx5_rxtx_vec.c |  8 +++----
 6 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 4b30a4fade..ace23b6906 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -587,7 +587,7 @@ mlx5_rxq_obj_hairpin_new(struct mlx5_rxq_priv *rxq)
 		 * during queue setup.
 		 */
 		MLX5_ASSERT(hca_attr->hairpin_data_buffer_locked);
-		rte_memcpy(&locked_attr, &unlocked_attr, sizeof(locked_attr));
+		memcpy(&locked_attr, &unlocked_attr, sizeof(locked_attr));
 		locked_attr.hairpin_data_buffer_type =
 				MLX5_RQC_HAIRPIN_DATA_BUFFER_TYPE_LOCKED_INTERNAL_BUFFER;
 		tmpl->rq = mlx5_devx_cmd_create_rq(priv->sh->cdev->ctx, &locked_attr,
@@ -1379,7 +1379,7 @@ mlx5_txq_obj_hairpin_new(struct rte_eth_dev *dev, uint16_t idx)
 		 */
 		MLX5_ASSERT(hca_attr->hairpin_sq_wq_in_host_mem);
 		MLX5_ASSERT(hca_attr->hairpin_sq_wqe_bb_size > 0);
-		rte_memcpy(&host_mem_attr, &dev_mem_attr, sizeof(host_mem_attr));
+		memcpy(&host_mem_attr, &dev_mem_attr, sizeof(host_mem_attr));
 		umem_size = MLX5_WQE_SIZE *
 			(size_t)RTE_BIT32(host_mem_attr.wq_attr.log_hairpin_num_packets);
 		umem_dbrec = RTE_ALIGN(umem_size, MLX5_DBR_SIZE);
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index b0eac185b5..981bec15be 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -4632,8 +4632,8 @@ flow_action_handles_translate(struct rte_eth_dev *dev,
 				(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION_NUM,
 				 NULL, "too many shared actions");
 		}
-		rte_memcpy(&handle[copied_n].action, &actions[n].conf,
-			   sizeof(actions[n].conf));
+		memcpy(&handle[copied_n].action, &actions[n].conf,
+		       sizeof(actions[n].conf));
 		handle[copied_n].index = n;
 		copied_n++;
 	}
@@ -5487,30 +5487,30 @@ flow_hairpin_split(struct rte_eth_dev *dev,
 		case RTE_FLOW_ACTION_TYPE_NVGRE_ENCAP:
 		case RTE_FLOW_ACTION_TYPE_OF_PUSH_VLAN:
 		case RTE_FLOW_ACTION_TYPE_OF_SET_VLAN_PCP:
-			rte_memcpy(actions_tx, actions,
+			memcpy(actions_tx, actions,
 			       sizeof(struct rte_flow_action));
 			actions_tx++;
 			break;
 		case RTE_FLOW_ACTION_TYPE_OF_SET_VLAN_VID:
 			if (push_vlan) {
-				rte_memcpy(actions_tx, actions,
-					   sizeof(struct rte_flow_action));
+				memcpy(actions_tx, actions,
+				       sizeof(struct rte_flow_action));
 				actions_tx++;
 			} else {
-				rte_memcpy(actions_rx, actions,
-					   sizeof(struct rte_flow_action));
+				memcpy(actions_rx, actions,
+				       sizeof(struct rte_flow_action));
 				actions_rx++;
 			}
 			break;
 		case RTE_FLOW_ACTION_TYPE_COUNT:
 		case RTE_FLOW_ACTION_TYPE_AGE:
 			if (encap) {
-				rte_memcpy(actions_tx, actions,
-					   sizeof(struct rte_flow_action));
+				memcpy(actions_tx, actions,
+				       sizeof(struct rte_flow_action));
 				actions_tx++;
 			} else {
-				rte_memcpy(actions_rx, actions,
-					   sizeof(struct rte_flow_action));
+				memcpy(actions_rx, actions,
+				       sizeof(struct rte_flow_action));
 				actions_rx++;
 			}
 			break;
@@ -5522,8 +5522,8 @@ flow_hairpin_split(struct rte_eth_dev *dev,
 				actions_tx++;
 				encap = 1;
 			} else {
-				rte_memcpy(actions_rx, actions,
-					   sizeof(struct rte_flow_action));
+				memcpy(actions_rx, actions,
+				       sizeof(struct rte_flow_action));
 				actions_rx++;
 			}
 			break;
@@ -5534,14 +5534,14 @@ flow_hairpin_split(struct rte_eth_dev *dev,
 				       sizeof(struct rte_flow_action));
 				actions_tx++;
 			} else {
-				rte_memcpy(actions_rx, actions,
-					   sizeof(struct rte_flow_action));
+				memcpy(actions_rx, actions,
+				       sizeof(struct rte_flow_action));
 				actions_rx++;
 			}
 			break;
 		default:
-			rte_memcpy(actions_rx, actions,
-				   sizeof(struct rte_flow_action));
+			memcpy(actions_rx, actions,
+			       sizeof(struct rte_flow_action));
 			actions_rx++;
 			break;
 		}
@@ -5551,7 +5551,7 @@ flow_hairpin_split(struct rte_eth_dev *dev,
 	tag_action->type = (enum rte_flow_action_type)
 			   MLX5_RTE_FLOW_ACTION_TYPE_TAG;
 	actions_rx++;
-	rte_memcpy(actions_rx, actions, sizeof(struct rte_flow_action));
+	memcpy(actions_rx, actions, sizeof(struct rte_flow_action));
 	actions_rx++;
 	set_tag = (void *)actions_rx;
 	*set_tag = (struct mlx5_rte_flow_action_set_tag) {
@@ -5561,7 +5561,7 @@ flow_hairpin_split(struct rte_eth_dev *dev,
 	MLX5_ASSERT(set_tag->id > REG_NON);
 	tag_action->conf = set_tag;
 	/* Create Tx item list. */
-	rte_memcpy(actions_tx, actions, sizeof(struct rte_flow_action));
+	memcpy(actions_tx, actions, sizeof(struct rte_flow_action));
 	addr = (void *)&pattern_tx[2];
 	item = pattern_tx;
 	item->type = (enum rte_flow_item_type)
diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flow_aso.c
index cd84ab1966..fff6bfcd24 100644
--- a/drivers/net/mlx5/mlx5_flow_aso.c
+++ b/drivers/net/mlx5/mlx5_flow_aso.c
@@ -1373,9 +1373,9 @@ mlx5_aso_ct_status_update(struct mlx5_aso_sq *sq, uint16_t num)
 		MLX5_ASSERT(ct);
 		MLX5_ASO_CT_UPDATE_STATE(ct, ASO_CONNTRACK_READY);
 		if (sq->elts[idx].query_data)
-			rte_memcpy(sq->elts[idx].query_data,
-				   (char *)((uintptr_t)sq->mr.addr + idx * 64),
-				   64);
+			memcpy(sq->elts[idx].query_data,
+			       (char *)((uintptr_t)sq->mr.addr + idx * 64),
+			       64);
 	}
 }
 
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 1cffdcc54d..953d63975b 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2509,7 +2509,7 @@ mlx5_tbl_translate_modify_header(struct rte_eth_dev *dev,
 		return rte_flow_error_set(error, ENOMEM,
 					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 					  NULL, "translate modify_header: no memory for modify header context");
-	rte_memcpy(acts->mhdr, mhdr, sizeof(*mhdr));
+	memcpy(acts->mhdr, mhdr, sizeof(*mhdr));
 	if (!mhdr->shared) {
 		pattern.data = (rte_be64_t *)acts->mhdr->mhdr_cmds;
 		typeof(mp_ctx->mh) *mh = &mp_ctx->mh;
@@ -3231,7 +3231,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 	err = rte_errno;
 	__flow_hw_action_template_destroy(dev, acts);
 	if (error != NULL && sub_error.type != RTE_FLOW_ERROR_TYPE_NONE) {
-		rte_memcpy(error, &sub_error, sizeof(sub_error));
+		memcpy(error, &sub_error, sizeof(sub_error));
 		return -EINVAL;
 	}
 	return rte_flow_error_set(error, err,
@@ -3296,8 +3296,8 @@ flow_hw_populate_rule_acts_caches(struct rte_eth_dev *dev,
 		struct mlx5dr_rule_action *rule_acts =
 				flow_hw_get_dr_action_buffer(priv, table, at_idx, q);
 
-		rte_memcpy(rule_acts, table->ats[at_idx].acts.rule_acts,
-			   sizeof(table->ats[at_idx].acts.rule_acts));
+		memcpy(rule_acts, table->ats[at_idx].acts.rule_acts,
+		       sizeof(table->ats[at_idx].acts.rule_acts));
 	}
 }
 
@@ -3599,9 +3599,9 @@ flow_hw_modify_field_construct(struct mlx5_modification_cmd *mhdr_cmd,
 	    mhdr_action->src.field != RTE_FLOW_FIELD_POINTER)
 		return 0;
 	if (mhdr_action->src.field == RTE_FLOW_FIELD_VALUE)
-		rte_memcpy(values, &mhdr_action->src.value, sizeof(values));
+		memcpy(values, &mhdr_action->src.value, sizeof(values));
 	else
-		rte_memcpy(values, mhdr_action->src.pvalue, sizeof(values));
+		memcpy(values, mhdr_action->src.pvalue, sizeof(values));
 	if (mhdr_action->dst.field == RTE_FLOW_FIELD_META ||
 	    mhdr_action->dst.field == RTE_FLOW_FIELD_TAG ||
 	    mhdr_action->dst.field == RTE_FLOW_FIELD_METER_COLOR ||
@@ -5537,7 +5537,7 @@ flow_hw_table_create(struct rte_eth_dev *dev,
 			rte_flow_error_set(error, err, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 					   "Failed to create template table");
 		else
-			rte_memcpy(error, &sub_error, sizeof(sub_error));
+			memcpy(error, &sub_error, sizeof(sub_error));
 	}
 	return NULL;
 }
@@ -7951,8 +7951,9 @@ flow_hw_set_vlan_vid(struct rte_eth_dev *dev,
 	if (masked) {
 		uint32_t mask_val = 0xffffffff;
 
-		rte_memcpy(spec->src.value, &conf->vlan_vid, sizeof(conf->vlan_vid));
-		rte_memcpy(mask->src.value, &mask_val, sizeof(mask_val));
+		memcpy(spec->src.value, &conf->vlan_vid,
+		       sizeof(conf->vlan_vid));
+		memcpy(mask->src.value, &mask_val, sizeof(mask_val));
 	}
 	ra[set_vlan_vid_ix].type = RTE_FLOW_ACTION_TYPE_MODIFY_FIELD;
 	ra[set_vlan_vid_ix].conf = spec;
@@ -7989,7 +7990,7 @@ flow_hw_set_vlan_vid_construct(struct rte_eth_dev *dev,
 		.conf = &conf
 	};
 
-	rte_memcpy(conf.src.value, &vid, sizeof(vid));
+	memcpy(conf.src.value, &vid, sizeof(vid));
 	return flow_hw_modify_field_construct(mhdr_cmd, act_data, hw_acts, &modify_action);
 }
 
@@ -10217,8 +10218,8 @@ flow_hw_create_tx_repr_tag_jump_acts_tmpl(struct rte_eth_dev *dev,
 	struct rte_flow_action actions_m[4] = { { 0 } };
 	unsigned int idx = 0;
 
-	rte_memcpy(set_tag_v.src.value, &tag_value, sizeof(tag_value));
-	rte_memcpy(set_tag_m.src.value, &tag_mask, sizeof(tag_mask));
+	memcpy(set_tag_v.src.value, &tag_value, sizeof(tag_value));
+	memcpy(set_tag_m.src.value, &tag_mask, sizeof(tag_mask));
 	flow_hw_update_action_mask(&actions_v[idx], &actions_m[idx],
 				   RTE_FLOW_ACTION_TYPE_MODIFY_FIELD,
 				   &set_tag_v, &set_tag_m);
@@ -10585,8 +10586,8 @@ flow_hw_create_ctrl_regc_jump_actions_template(struct rte_eth_dev *dev,
 	};
 
 	set_reg_v.dst.offset = rte_bsf32(marker_mask);
-	rte_memcpy(set_reg_v.src.value, &marker_bits, sizeof(marker_bits));
-	rte_memcpy(set_reg_m.src.value, &marker_mask, sizeof(marker_mask));
+	memcpy(set_reg_v.src.value, &marker_bits, sizeof(marker_bits));
+	memcpy(set_reg_m.src.value, &marker_mask, sizeof(marker_mask));
 	return flow_hw_actions_template_create(dev, &attr, actions_v, actions_m, error);
 }
 
@@ -14137,7 +14138,7 @@ static int flow_hw_register_matcher(struct rte_eth_dev *dev,
 		mlx5_hlist_unregister(priv->sh->groups, group_entry);
 	if (error) {
 		if (sub_error.type != RTE_FLOW_ERROR_TYPE_NONE)
-			rte_memcpy(error, &sub_error, sizeof(sub_error));
+			memcpy(error, &sub_error, sizeof(sub_error));
 	}
 	return rte_flow_error_set(error, rte_errno,
 					RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index c0ad8d6701..a874998a31 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -883,9 +883,9 @@ mlx5_rx_poll_len(struct mlx5_rxq_data *rxq, volatile struct mlx5_cqe *cqe,
 					ret = check_cqe_iteration(next, rxq->cqe_n, rxq->cq_ci);
 					if (ret != MLX5_CQE_STATUS_SW_OWN ||
 					    MLX5_CQE_FORMAT(next->op_own) == MLX5_COMPRESSED)
-						rte_memcpy(&rxq->title_cqe,
-							   (const void *)(uintptr_t)cqe,
-							   sizeof(struct mlx5_cqe));
+						memcpy(&rxq->title_cqe,
+						       (const void *)(uintptr_t)cqe,
+						       sizeof(struct mlx5_cqe));
 				}
 			}
 		}
diff --git a/drivers/net/mlx5/mlx5_rxtx_vec.c b/drivers/net/mlx5/mlx5_rxtx_vec.c
index 79e92811d5..1032c9bc02 100644
--- a/drivers/net/mlx5/mlx5_rxtx_vec.c
+++ b/drivers/net/mlx5/mlx5_rxtx_vec.c
@@ -364,8 +364,8 @@ rxq_burst_v(struct mlx5_rxq_data *rxq, struct rte_mbuf **pkts,
 			ret = check_cqe_iteration(next,	rxq->cqe_n, rxq->cq_ci);
 			if (MLX5_CQE_FORMAT(next->op_own) == MLX5_COMPRESSED ||
 			    ret != MLX5_CQE_STATUS_SW_OWN)
-				rte_memcpy(&rxq->title_pkt, elts[nocmp_n - 1],
-					   sizeof(struct rte_mbuf));
+				memcpy(&rxq->title_pkt, elts[nocmp_n - 1],
+				       sizeof(struct rte_mbuf));
 		}
 	}
 decompress:
@@ -528,8 +528,8 @@ rxq_burst_mprq_v(struct mlx5_rxq_data *rxq, struct rte_mbuf **pkts,
 			ret = check_cqe_iteration(next,	rxq->cqe_n, rxq->cq_ci);
 			if (MLX5_CQE_FORMAT(next->op_own) == MLX5_COMPRESSED ||
 			    ret != MLX5_CQE_STATUS_SW_OWN)
-				rte_memcpy(&rxq->title_pkt, elts[nocmp_n - 1],
-					   sizeof(struct rte_mbuf));
+				memcpy(&rxq->title_pkt, elts[nocmp_n - 1],
+				       sizeof(struct rte_mbuf));
 		}
 	}
 decompress:
-- 
2.53.0

