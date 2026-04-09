Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAFDEA3C5D
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 13:09:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA54B4028F;
	Thu,  9 Apr 2026 15:09:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7B1824028F
 for <dev@dpdk.org>; Thu,  9 Apr 2026 11:12:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775725956; x=1807261956;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d4CbzE1E2gYo0Co6MBJ1vpTT9Q1qdRqUC1MwCF5aHwI=;
 b=PwtQZ/QIP89+N1hB+ddaXOSe5x9S4nPqm8PxXh/KRoIbsn43p/Gz6Gco
 wGFJBefIOZC21tLhkjSNUN95zg9jQTT2rgfphtEJjnSaDqUpxjNhwIMG4
 liSx09Pt7RcNFFzxgDNFhCfotxFBd3sspOTeuIhrM+hjHkxStLYcdDD7b
 KaOT8ScCr7R+3HJElq/oEByfklQDLXg1h+gJUgaN3hr3iV5DigON6ldU7
 OO27wVBnjZX5m/zxIyD7CDOzLQ/HwYDxVWfPIpFEQrrdb4uSSgNzDViGG
 w8rJMv8R87JoGXs+5SNVsNvMF8eX+c+lJU6WwXxh5itBGM8lYuorUYTJZ g==;
X-CSE-ConnectionGUID: QiAhVqgYQteLneOpiooZOA==
X-CSE-MsgGUID: e0TYONTdQxmnsu8i3MSk7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="80611547"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="80611547"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 02:12:28 -0700
X-CSE-ConnectionGUID: NStFjTvtSWiwdoTiu1XdhQ==
X-CSE-MsgGUID: LXOotJi4TlSYzaE2Hbbhhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="232760730"
Received: from unknown (HELO spr4..) ([10.138.182.169])
 by orviesa003.jf.intel.com with ESMTP; 09 Apr 2026 02:12:26 -0700
From: Sushmita Hoskeri <sushmita.hoskeri@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: atul.patel@intel.com
Subject: [PATCH v2] net/cpfl: add LEM block support in CPFL PMD
Date: Thu,  9 Apr 2026 07:21:21 +0530
Message-Id: <20260409015121.2841143-1-sushmita.hoskeri@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217012153.36545-1-sushmita.hoskeri@intel.com>
References: <20260217012153.36545-1-sushmita.hoskeri@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:09:53 +0200
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

Added APIs to enable support for LEM (Large Exact Match) block
in CPFL PMD

Signed-off-by: Sushmita Hoskeri <sushmita.hoskeri@intel.com>
Signed-off-by: Atul Patel <atul.patel@intel.com>
---
v2:
- Expanded the LEM acronym in the commit message
- Removed code that wasn't directly related to LEM block
- Removed extra blank line

 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c | 10 +++
 drivers/net/intel/cpfl/cpfl_flow_parser.c     | 84 +++++++++++++++++++
 drivers/net/intel/cpfl/cpfl_flow_parser.h     | 18 ++++
 drivers/net/intel/cpfl/cpfl_fxp_rule.c        | 10 ++-
 drivers/net/intel/cpfl/cpfl_fxp_rule.h        | 10 +++
 drivers/net/intel/cpfl/cpfl_rules.c           | 36 ++++++++
 drivers/net/intel/cpfl/cpfl_rules.h           | 46 +++++++++-
 7 files changed, 212 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
index 361827cb10..f42156e28f 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c
@@ -41,6 +41,7 @@
 #define CPFL_PORT_NUM_DEF	0
 #define CPFL_RESP_REQ_DEF	2
 #define CPFL_PIN_TO_CACHE_DEF	0
+#define CPFL_PIN_TO_CACHE_CUST  1
 #define CPFL_CLEAR_MIRROR_1ST_STATE_DEF	0
 #define CPFL_FIXED_FETCH_DEF	0
 #define CPFL_PTI_DEF		0
@@ -180,6 +181,15 @@ cpfl_fxp_parse_pattern(const struct cpfl_flow_pr_action *pr_action,
 		memcpy(rinfo->sem.key, pr_action->sem.cpfl_flow_pr_fv, rinfo->sem.key_byte_len);
 		rinfo->sem.pin_to_cache = CPFL_PIN_TO_CACHE_DEF;
 		rinfo->sem.fixed_fetch = CPFL_FIXED_FETCH_DEF;
+	} else if (pr_action->type == CPFL_JS_PR_ACTION_TYPE_LEM) {
+		struct cpfl_rule_info *rinfo = &rim->rules[i];
+
+		rinfo->type = CPFL_RULE_TYPE_LEM;
+		rinfo->lem.prof_id = pr_action->lem.prof;
+		rinfo->lem.key_byte_len = pr_action->lem.keysize;
+		memcpy(rinfo->lem.key, pr_action->lem.cpfl_flow_pr_fv, rinfo->lem.key_byte_len);
+		rinfo->lem.pin_to_cache = CPFL_PIN_TO_CACHE_CUST;
+		rinfo->lem.fixed_fetch = CPFL_FIXED_FETCH_DEF;
 	} else {
 		PMD_DRV_LOG(ERR, "Invalid pattern item.");
 		return false;
diff --git a/drivers/net/intel/cpfl/cpfl_flow_parser.c b/drivers/net/intel/cpfl/cpfl_flow_parser.c
index e7deb619ee..dfaddc9ec5 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_parser.c
+++ b/drivers/net/intel/cpfl/cpfl_flow_parser.c
@@ -421,6 +421,56 @@ cpfl_flow_js_pattern_act_fv(json_t *ob_fvs, struct cpfl_flow_js_pr_action *js_ac
 	return -EINVAL;
 }
 
+static int
+cpfl_flow_js_pattern_act_fv_lem(json_t *cjson_fv, struct cpfl_flow_js_pr_action *js_act)
+{
+	int len, i, ret;
+
+	len = json_array_size(cjson_fv);
+	js_act->lem.fv = rte_malloc(NULL, sizeof(struct cpfl_flow_js_fv) * len, 0);
+	if (!js_act->lem.fv) {
+		PMD_DRV_LOG(ERR, "Failed to alloc memory.");
+		return -ENOMEM;
+	}
+	js_act->lem.fv_size = len;
+	for (i = 0; i < len; i++) {
+		struct cpfl_flow_js_fv *js_fv;
+		json_t *object, *cjson_value;
+		const char *type;
+
+		object = json_array_get(cjson_fv, i);
+		js_fv = &js_act->lem.fv[i];
+		ret = cpfl_json_t_to_uint16(object, "offset", &js_fv->offset);
+		if (ret < 0) {
+			PMD_DRV_LOG(ERR, "Can not parse 'offset'.");
+			return -EINVAL;
+		}
+		type = cpfl_json_t_to_string(object, "type");
+		if (!type) {
+			PMD_DRV_LOG(ERR, "Can not parse 'type'.");
+			return -EINVAL;
+		}
+		cjson_value = json_object_get(object, "value");
+		if (strcmp(type, "immediate") == 0) {
+			js_fv->type = CPFL_FV_TYPE_IMMEDIATE;
+			js_fv->immediate = json_integer_value(cjson_value);
+		} else if (strcmp(type, "metadata") == 0) {
+			js_fv->type = CPFL_FV_TYPE_METADATA;
+			cpfl_flow_js_pattern_act_fv_metadata(cjson_value, js_fv);
+		} else if (strcmp(type, "protocol") == 0) {
+			js_fv->type = CPFL_FV_TYPE_PROTOCOL;
+			cpfl_flow_js_pattern_act_fv_proto(cjson_value, js_fv);
+		} else {
+			PMD_DRV_LOG(ERR, "Not support this type: %s.", type);
+			goto err;
+		}
+	}
+	return 0;
+err:
+	rte_free(js_act->lem.fv);
+	return -EINVAL;
+}
+
 static int
 cpfl_flow_js_pattern_per_act(json_t *ob_per_act, struct cpfl_flow_js_pr_action *js_act)
 {
@@ -458,6 +508,25 @@ cpfl_flow_js_pattern_per_act(json_t *ob_per_act, struct cpfl_flow_js_pr_action *
 		ret = cpfl_flow_js_pattern_act_fv(ob_fvs, js_act);
 		if (ret < 0)
 			return ret;
+	} else if (strcmp(type, "lem") == 0) {
+		js_act->type = CPFL_JS_PR_ACTION_TYPE_LEM;
+		json_t *cjson_fv, *ob_lem;
+
+		ob_lem = json_object_get(ob_per_act, "data");
+		ret = cpfl_json_t_to_uint16(ob_lem, "profile", &js_act->lem.prof);
+		if (ret < 0) {
+			PMD_DRV_LOG(ERR, "Can not parse 'profile'.");
+			return -EINVAL;
+		}
+		ret = cpfl_json_t_to_uint16(ob_lem, "keysize", &js_act->lem.keysize);
+		if (ret < 0) {
+			PMD_DRV_LOG(ERR, "Can not parse 'keysize'.");
+			return -EINVAL;
+		}
+		cjson_fv = json_object_get(ob_lem, "fieldvectors");
+		ret = cpfl_flow_js_pattern_act_fv_lem(cjson_fv, js_act);
+		if (ret < 0)
+			return ret;
 	} else {
 		PMD_DRV_LOG(ERR, "Not support this type: %s.", type);
 		return -EINVAL;
@@ -984,6 +1053,8 @@ cpfl_parser_free_pr_action(struct cpfl_flow_js_pr_action *pr_act)
 {
 	if (pr_act->type == CPFL_JS_PR_ACTION_TYPE_SEM)
 		rte_free(pr_act->sem.fv);
+	else if (pr_act->type == CPFL_JS_PR_ACTION_TYPE_LEM)
+		rte_free(pr_act->lem.fv);
 }
 
 int
@@ -1149,6 +1220,19 @@ cpfl_parse_pr_actions(struct cpfl_itf *itf,
 			ret = cpfl_parse_fieldvectors(itf, sem->fv, sem->fv_size,
 						      pr_action->sem.cpfl_flow_pr_fv, items);
 			return ret;
+		} else if (attr->group % 10 == 4 && type == CPFL_JS_PR_ACTION_TYPE_LEM) {
+			struct cpfl_flow_js_pr_action_lem *lem = &pr_act->lem;
+
+			pr_action->type = CPFL_JS_PR_ACTION_TYPE_LEM;
+			pr_action->lem.prof = lem->prof;
+			pr_action->lem.keysize = lem->keysize;
+			memset(pr_action->lem.cpfl_flow_pr_fv, 0,
+					sizeof(pr_action->lem.cpfl_flow_pr_fv));
+			ret = cpfl_parse_fieldvectors(itf, lem->fv, lem->fv_size,
+							  pr_action->lem.cpfl_flow_pr_fv, items);
+			if (ret < 0)
+				return ret;
+			continue;
 		} else if (attr->group > 4 || attr->group == 0) {
 			return -EPERM;
 		}
diff --git a/drivers/net/intel/cpfl/cpfl_flow_parser.h b/drivers/net/intel/cpfl/cpfl_flow_parser.h
index 23904e39f1..f865ae8282 100644
--- a/drivers/net/intel/cpfl/cpfl_flow_parser.h
+++ b/drivers/net/intel/cpfl/cpfl_flow_parser.h
@@ -16,10 +16,12 @@
 #define CPFL_JS_PROG_CONTENT_FIELD_NUM_MAX 64
 #define CPFL_JS_PROG_CONSTANT_VALUE_NUM_MAX 8
 #define CPFL_JS_PROG_PARAM_NUM_MAX 10
+#define CPFL_JS_LEM_FV_KEY_NUM_MAX 32
 
 /* Pattern Rules Storage */
 enum cpfl_flow_pr_action_type {
 	CPFL_JS_PR_ACTION_TYPE_SEM,
+	CPFL_JS_PR_ACTION_TYPE_LEM,
 	CPFL_JS_PR_ACTION_TYPE_UNKNOWN = -1,
 };
 
@@ -85,11 +87,19 @@ struct cpfl_flow_js_pr_action_sem {
 	int fv_size;
 };
 
+struct cpfl_flow_js_pr_action_lem {
+	uint16_t prof;
+	uint16_t keysize;
+	struct cpfl_flow_js_fv *fv;
+	int fv_size;
+};
+
 /* define how to map current key to low level pipeline configuration */
 struct cpfl_flow_js_pr_action {
 	enum cpfl_flow_pr_action_type type;
 	union {
 		struct cpfl_flow_js_pr_action_sem sem;
+		struct cpfl_flow_js_pr_action_lem lem;
 	};
 };
 
@@ -230,10 +240,18 @@ struct cpfl_flow_pr_action_sem {
 	uint8_t cpfl_flow_pr_fv[CPFL_JS_SEM_FV_KEY_NUM_MAX];
 };
 
+struct cpfl_flow_pr_action_lem {
+	uint16_t prof;
+	uint16_t keysize;
+	uint8_t cpfl_flow_pr_fv[CPFL_JS_LEM_FV_KEY_NUM_MAX];
+};
+
+
 struct cpfl_flow_pr_action {
 	enum cpfl_flow_pr_action_type type;
 	union {
 		struct cpfl_flow_pr_action_sem sem;
+		struct cpfl_flow_pr_action_lem lem;
 	};
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_fxp_rule.c b/drivers/net/intel/cpfl/cpfl_fxp_rule.c
index 42553c9641..d1c992dfe4 100644
--- a/drivers/net/intel/cpfl/cpfl_fxp_rule.c
+++ b/drivers/net/intel/cpfl/cpfl_fxp_rule.c
@@ -192,6 +192,14 @@ cpfl_default_rule_pack(struct cpfl_rule_info *rinfo, struct idpf_dma_mem *dma,
 					rinfo->act_bytes, rinfo->act_byte_len,
 					cfg_ctrl, blob);
 		opc = add ? cpfl_ctlq_sem_add_rule : cpfl_ctlq_sem_del_rule;
+	} else if (rinfo->type == CPFL_RULE_TYPE_LEM) {
+		cfg_ctrl = CPFL_GET_MEV_LEM_RULE_CFG_CTRL(rinfo->lem.prof_id,
+							  rinfo->lem.pin_to_cache,
+							  rinfo->clear_mirror_1st_state);
+		cpfl_prep_lem_rule_blob(rinfo->lem.key, rinfo->lem.key_byte_len,
+					rinfo->act_bytes, rinfo->act_byte_len,
+					cfg_ctrl, blob);
+		opc = add ? cpfl_ctlq_lem_add_update_rule : cpfl_ctlq_lem_del_rule;
 	} else {
 		PMD_INIT_LOG(ERR, "not support %d rule.", rinfo->type);
 		return -1;
@@ -219,7 +227,7 @@ cpfl_rule_pack(struct cpfl_rule_info *rinfo, struct idpf_dma_mem *dma,
 {
 	int ret = 0;
 
-	if (rinfo->type == CPFL_RULE_TYPE_SEM) {
+	if (rinfo->type == CPFL_RULE_TYPE_SEM || rinfo->type == CPFL_RULE_TYPE_LEM) {
 		if (cpfl_default_rule_pack(rinfo, dma, msg, add) < 0)
 			ret = -1;
 	} else if (rinfo->type == CPFL_RULE_TYPE_MOD) {
diff --git a/drivers/net/intel/cpfl/cpfl_fxp_rule.h b/drivers/net/intel/cpfl/cpfl_fxp_rule.h
index 94eab6808c..544f441025 100644
--- a/drivers/net/intel/cpfl/cpfl_fxp_rule.h
+++ b/drivers/net/intel/cpfl/cpfl_fxp_rule.h
@@ -28,9 +28,18 @@ struct cpfl_mod_rule_info {
 	uint8_t mod_obj_size;
 };
 
+struct cpfl_lem_rule_info {
+	uint16_t prof_id;
+	uint8_t key[CPFL_MAX_KEY_LEN];
+	uint8_t key_byte_len;
+	uint8_t pin_to_cache;
+	uint8_t fixed_fetch;
+};
+
 enum cpfl_rule_type {
 	CPFL_RULE_TYPE_NONE,
 	CPFL_RULE_TYPE_SEM,
+	CPFL_RULE_TYPE_LEM,
 	CPFL_RULE_TYPE_MOD
 };
 
@@ -50,6 +59,7 @@ struct cpfl_rule_info {
 	union {
 		struct cpfl_mod_rule_info mod;
 		struct cpfl_sem_rule_info sem;
+		struct cpfl_lem_rule_info lem;
 	};
 };
 
diff --git a/drivers/net/intel/cpfl/cpfl_rules.c b/drivers/net/intel/cpfl/cpfl_rules.c
index 6c0e435b1d..ec636fdf4b 100644
--- a/drivers/net/intel/cpfl/cpfl_rules.c
+++ b/drivers/net/intel/cpfl/cpfl_rules.c
@@ -18,6 +18,14 @@ cpfl_prep_rule_desc_common_ctx(struct cpfl_rule_cfg_data_common *cmn_cfg)
 	case cpfl_ctlq_mod_query_rule:
 	case cpfl_ctlq_mod_add_update_rule:
 		/* fallthrough */
+	case cpfl_ctlq_lem_del_rule:
+	case cpfl_ctlq_lem_query_rule:
+	case cpfl_ctlq_lem_add_update_rule:
+	case cpfl_ctlq_lem_query_rule_hash_addr:
+	case cpfl_ctlq_lem_query_del_rule_hash_addr:
+		context |= SHIFT_VAL64(cmn_cfg->vsi_id,
+				       MEV_RULE_VSI_ID);
+		/* fallthrough */
 	case cpfl_ctlq_sem_query_rule_hash_addr:
 	case cpfl_ctlq_sem_query_del_rule_hash_addr:
 	case cpfl_ctlq_sem_add_rule:
@@ -66,6 +74,8 @@ cpfl_prep_rule_desc_ctx(struct cpfl_rule_cfg_data *cfg_data)
 		break;
 	case cpfl_ctlq_sem_query_rule_hash_addr:
 	case cpfl_ctlq_sem_query_del_rule_hash_addr:
+	case cpfl_ctlq_lem_query_rule_hash_addr:
+	case cpfl_ctlq_lem_query_del_rule_hash_addr:
 		context |= SHIFT_VAL64(cfg_data->ext.query_del_addr.obj_id,
 				       MEV_RULE_OBJ_ID);
 		context |= SHIFT_VAL64(cfg_data->ext.query_del_addr.obj_addr,
@@ -124,3 +134,29 @@ cpfl_prep_sem_rule_blob(const uint8_t *key,
 	rule_blob->sem_rule.cfg_ctrl[0] = cfg_ctrl & 0xFF;
 	rule_blob->sem_rule.cfg_ctrl[1] = (cfg_ctrl >> 8) & 0xFF;
 }
+
+/**
+ * cpfl_prep_lem_rule_blob - build LEM rule blob data from rule entry info
+ * note: call this function before sending rule to HW via fast path
+ */
+void
+cpfl_prep_lem_rule_blob(uint8_t *key,
+			uint8_t key_byte_len,
+			uint8_t *act_bytes,
+			uint8_t act_byte_len,
+			uint16_t cfg_ctrl,
+			union cpfl_rule_cfg_pkt_record *rule_blob)
+{
+	uint32_t *act_dst = (uint32_t *)&rule_blob->lem_rule.actions;
+	uint32_t *act_src = (uint32_t *)act_bytes;
+	uint32_t i;
+
+	idpf_memset(rule_blob, 0, sizeof(*rule_blob), IDPF_DMA_MEM);
+	memcpy(rule_blob->lem_rule.key, key, key_byte_len);
+
+	for (i = 0; i < act_byte_len / sizeof(uint32_t); i++)
+		*act_dst++ = CPU_TO_LE32(*act_src++);
+
+	rule_blob->lem_rule.cfg_ctrl[0] = cfg_ctrl & 0xFF;
+	rule_blob->lem_rule.cfg_ctrl[1] = (cfg_ctrl >> 8) & 0xFF;
+}
diff --git a/drivers/net/intel/cpfl/cpfl_rules.h b/drivers/net/intel/cpfl/cpfl_rules.h
index 10569b1fdc..2b65c7ecc8 100644
--- a/drivers/net/intel/cpfl/cpfl_rules.h
+++ b/drivers/net/intel/cpfl/cpfl_rules.h
@@ -46,6 +46,12 @@ enum cpfl_ctlq_rule_cfg_opc {
 	cpfl_ctlq_sem_query_rule_hash_addr		= 0x1307,
 	cpfl_ctlq_sem_query_del_rule_hash_addr		= 0x1308,
 
+	cpfl_ctlq_lem_add_update_rule			= 0x1343,
+	cpfl_ctlq_lem_del_rule					= 0x1345,
+	cpfl_ctlq_lem_query_rule				= 0x1346,
+	cpfl_ctlq_lem_query_rule_hash_addr		= 0x1347,
+	cpfl_ctlq_lem_query_del_rule_hash_addr	= 0x1348,
+
 	cpfl_ctlq_mod_add_update_rule			= 0x1360,
 	cpfl_ctlq_mod_query_rule			= 0x1361,
 };
@@ -188,11 +194,43 @@ struct cpfl_sem_rule_cfg_pkt {
 	uint8_t padding[46];
 };
 
+/**
+ * struct cpfl_lem_rule_cfg_pkt - Describes rule information for LEM
+ * note: The key may be in mixed big/little endian format, the rest of members
+ * are in little endian
+ */
+struct cpfl_lem_rule_cfg_pkt {
+#define MEV_LEM_RULE_KEY_SIZE 128
+	uint8_t key[MEV_LEM_RULE_KEY_SIZE];
+
+#define MEV_LEM_RULE_ACT_SIZE	48
+	uint8_t actions[MEV_LEM_RULE_ACT_SIZE];
+	/* Bit(s):
+	 * 10:0 : PROFILE_ID
+	 * 12:11: Reserved
+	 * 13   : pin the LEM key content into the cache
+	 * 14   : if set, clear mirror first state for first index in actions
+	 * 15   : Reserved.
+	 */
+	uint8_t cfg_ctrl[2];
+	/* Bit(s):
+	 * 0:     valid
+	 * 15:1:  Hints
+	 * 26:16: PROFILE_ID, the profile associated with the entry
+	 * 31:27: PF
+	 * 55:32: FLOW ID (assigned by HW)
+	 * 63:56: EPOCH
+	 */
+	uint8_t ctrl_word[8];
+	uint8_t padding[70];
+};
+
 /**
  * union cpfl_rule_cfg_pkt_record - Describes rule data blob
  */
 union cpfl_rule_cfg_pkt_record {
 	struct cpfl_sem_rule_cfg_pkt sem_rule;
+	struct cpfl_lem_rule_cfg_pkt lem_rule;
 	uint8_t pkt_data[256];
 	uint8_t mod_blob[256];
 };
@@ -313,5 +351,11 @@ cpfl_prep_sem_rule_blob(const uint8_t *key,
 			uint8_t act_byte_len,
 			uint16_t cfg_ctrl,
 			union cpfl_rule_cfg_pkt_record *rule_blob);
-
+void
+cpfl_prep_lem_rule_blob(uint8_t *key,
+			uint8_t key_byte_len,
+			uint8_t *act_bytes,
+			uint8_t act_byte_len,
+			uint16_t cfg_ctrl,
+			union cpfl_rule_cfg_pkt_record *rule_blob);
 #endif /* _CPFL_RULES_API_H_ */
-- 
2.34.1

