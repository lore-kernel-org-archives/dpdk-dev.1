Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929DEC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 05:37:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4946940615;
	Fri, 28 Aug 2026 07:37:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7F6E040613
 for <dev@dpdk.org>; Fri, 28 Aug 2026 07:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787895429; x=1819431429;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PtQzsXZvLBJpCwJ0YW3aw9VOt80czc1jX2mBTHLn7BU=;
 b=gxwcOdiYlndlRArsrFZWl6MdTc1lo2bwX+aqF955rZ6xHJmJF3jch/Lg
 3FcyYVpjinyXSvj/sPS5F8jto1wdagd59D30XWyo+SvJwK2yiXUtR/2PU
 Pu5vIGTZmjqbhZKk729SzqZn3PP8Q2cMgCYOz7GeXy/pGGSKa+LcoQ19U
 bjvL2idz6jlKYI7fbpNlnUi/g5W0JPPQv8wAzWmmmQsTI+x90YlkXB5Sp
 zAoviCj762ELDAm59PFMNI6oJTcahJS15RhfxDCkUBigKtEa9rbuTfx/f
 uDbcs0J4JWPrcpPZhltlSJ7v0nTKEN7ysOieJYqlrtd9jzFJ+eGkpZG/N Q==;
X-CSE-ConnectionGUID: GOHRLqmrSFqLUropaLHAXg==
X-CSE-MsgGUID: /YOdXptfSkGGmp7XOHJ3nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88425727"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88425727"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 22:37:08 -0700
X-CSE-ConnectionGUID: D4kPF/HKR1OxtGczpM1ppg==
X-CSE-MsgGUID: mzJcbZRTRbeI2U+iXnRrPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="267477139"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by orviesa008.jf.intel.com with ESMTP; 27 Aug 2026 22:37:06 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, orika@nvidia.com, nirint.shah@intel.com,
 prudvi.deti@intel.com
Subject: [RFC 3/7] regex/hs: add rule database update and compilation
Date: Fri, 28 Aug 2026 11:05:52 +0530
Message-ID: <20260828053629.1224611-4-prudvi.deti@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828053629.1224611-1-prudvi.deti@intel.com>
References: <20260828053629.1224611-1-prudvi.deti@intel.com>
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

Implement rule_db_update, rule_db_compile_activate, db_import, and
db_export.

rule_db_update supports ADD and REMOVE operations with O(1) duplicate
detection via rte_hash. Extended parameters (min_offset, max_offset)
are extracted from rule_flags bits 37-63.

Compilation uses hs_compile_ext_multi() with per-rule extended
parameter support. Per-QP scratch is allocated with rollback on
partial failure.

The configure path optionally imports a serialized database when
cfg->rule_db is provided.

Signed-off-by: Prudvi Deti <prudvi.deti@intel.com>
---
 drivers/regex/hs/hs_regex.c | 404 +++++++++++++++++++++++++++++++++++-
 drivers/regex/hs/hs_regex.h |  11 +
 2 files changed, 414 insertions(+), 1 deletion(-)

diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
index afe00b5..116aff9 100644
--- a/drivers/regex/hs/hs_regex.c
+++ b/drivers/regex/hs/hs_regex.c
@@ -39,6 +39,10 @@ RTE_LOG_REGISTER_DEFAULT(hs_regex_logtype, NOTICE);
 #define HS_LOG(level, ...) \
 	RTE_LOG_LINE(level, HS_REGEX, __VA_ARGS__)
 
+static int
+hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
+			uint32_t rule_db_len);
+
 /* Device Info */
 static int
 hs_regex_info_get(struct rte_regexdev *dev __rte_unused,
@@ -66,6 +70,7 @@ hs_regex_configure(struct rte_regexdev *dev,
 		   const struct rte_regexdev_config *cfg)
 {
 	struct hs_regex_priv *priv;
+	int ret;
 
 	if (dev == NULL || cfg == NULL)
 		return -EINVAL;
@@ -92,7 +97,6 @@ hs_regex_configure(struct rte_regexdev *dev,
 
 	if (priv->rules) {
 		uint32_t i;
-
 		for (i = 0; i < priv->nb_rules; i++)
 			rte_free(priv->rules[i].pattern);
 		rte_free(priv->rules);
@@ -100,6 +104,10 @@ hs_regex_configure(struct rte_regexdev *dev,
 		priv->nb_rules = 0;
 		priv->rules_cap = 0;
 	}
+	if (priv->rule_id_hash) {
+		rte_hash_free(priv->rule_id_hash);
+		priv->rule_id_hash = NULL;
+	}
 	if (priv->db) {
 		hs_free_database(priv->db);
 		priv->db = NULL;
@@ -126,6 +134,20 @@ hs_regex_configure(struct rte_regexdev *dev,
 	       priv->nb_queue_pairs, priv->max_matches);
 
 	priv->dev_state = HS_REGEX_DEV_CONFIGURED;
+
+	if (cfg->rule_db != NULL && cfg->rule_db_len > 0) {
+		ret = hs_regex_rule_db_import(dev, cfg->rule_db,
+					     cfg->rule_db_len);
+		if (ret < 0) {
+			HS_LOG(ERR, "Failed to import rule DB in configure");
+			rte_free(priv->qps);
+			priv->qps = NULL;
+			priv->nb_queue_pairs = 0;
+			priv->dev_state = HS_REGEX_DEV_CREATED;
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -211,6 +233,382 @@ hs_regex_qp_setup(struct rte_regexdev *dev, uint16_t qp_id,
 	return 0;
 }
 
+/* Rule Database Update */
+static int
+hs_regex_rule_db_update(struct rte_regexdev *dev,
+			const struct rte_regexdev_rule *rules,
+			uint16_t nb_rules)
+{
+	struct hs_regex_priv *priv;
+	uint64_t rf;
+	uint16_t i;
+
+	if (dev == NULL || rules == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	if (nb_rules == 0)
+		return 0;
+
+	if (!priv->rule_id_hash) {
+		struct rte_hash_parameters hp = {
+			.name = "hs_rule_ids",
+			.entries = HS_REGEX_MAX_RULES,
+			.key_len = sizeof(uint32_t),
+			.socket_id = SOCKET_ID_ANY,
+		};
+		priv->rule_id_hash = rte_hash_create(&hp);
+		if (!priv->rule_id_hash) {
+			HS_LOG(ERR, "Failed to create rule_id hash");
+			return -ENOMEM;
+		}
+	}
+
+	for (i = 0; i < nb_rules; i++) {
+		if (rules[i].op == RTE_REGEX_RULE_OP_ADD) {
+			uint32_t idx;
+
+			if (!rules[i].pcre_rule || rules[i].pcre_rule_len == 0) {
+				HS_LOG(ERR, "Rule %u: NULL or empty pattern",
+				       rules[i].rule_id);
+				rte_errno = EINVAL;
+				return i;
+			}
+
+			if (priv->rule_id_hash &&
+			    rte_hash_lookup(priv->rule_id_hash,
+					   &rules[i].rule_id) >= 0) {
+				HS_LOG(ERR, "Rule %u: duplicate rule_id",
+				       rules[i].rule_id);
+				rte_errno = EINVAL;
+				return i;
+			}
+
+			if (priv->nb_rules >= HS_REGEX_MAX_RULES) {
+				HS_LOG(ERR, "Rule limit reached (%u)",
+				       HS_REGEX_MAX_RULES);
+				rte_errno = ENOSPC;
+				return i;
+			}
+
+			if (priv->nb_rules >= priv->rules_cap) {
+				uint32_t new_cap = priv->rules_cap ?
+					priv->rules_cap * 2 :
+					HS_REGEX_INITIAL_RULES_CAP;
+				struct hs_regex_rule *tmp = rte_realloc(
+					priv->rules,
+					new_cap * sizeof(struct hs_regex_rule), 0);
+				if (!tmp) {
+					HS_LOG(ERR, "Failed to grow rules");
+					rte_errno = ENOMEM;
+					return i;
+				}
+				priv->rules = tmp;
+				priv->rules_cap = new_cap;
+			}
+
+			idx = priv->nb_rules;
+
+			priv->rules[idx].pattern = rte_malloc("hs_pattern",
+				rules[i].pcre_rule_len + 1, 0);
+			if (!priv->rules[idx].pattern) {
+				rte_errno = ENOMEM;
+				return i;
+			}
+			memcpy(priv->rules[idx].pattern,
+			       rules[i].pcre_rule, rules[i].pcre_rule_len);
+			priv->rules[idx].pattern[rules[i].pcre_rule_len] = '\0';
+
+			priv->rules[idx].rule_id = rules[i].rule_id;
+			priv->rules[idx].group_id = rules[i].group_id;
+			priv->rules[idx].rule_flags = rules[i].rule_flags;
+
+			rf = rules[i].rule_flags;
+			priv->rules[idx].max_offset =
+				(rf >> HS_REGEX_EXT_MAX_OFFSET_SHIFT) &
+				HS_REGEX_EXT_MAX_OFFSET_MASK;
+			priv->rules[idx].min_offset =
+				(rf >> HS_REGEX_EXT_MIN_OFFSET_SHIFT) &
+				HS_REGEX_EXT_MIN_OFFSET_MASK;
+			priv->rules[idx].min_length = 0;
+
+			priv->nb_rules++;
+
+			if (priv->rule_id_hash)
+				rte_hash_add_key(priv->rule_id_hash,
+						 &rules[i].rule_id);
+
+		} else if (rules[i].op == RTE_REGEX_RULE_OP_REMOVE) {
+			uint32_t j;
+
+			if (priv->rule_id_hash)
+				rte_hash_del_key(priv->rule_id_hash,
+						 &rules[i].rule_id);
+
+			for (j = 0; j < priv->nb_rules; j++) {
+				if (priv->rules[j].rule_id !=
+				    rules[i].rule_id)
+					continue;
+				rte_free(priv->rules[j].pattern);
+				memmove(&priv->rules[j], &priv->rules[j + 1],
+					(priv->nb_rules - j - 1) *
+					sizeof(struct hs_regex_rule));
+				priv->nb_rules--;
+				break;
+			}
+		}
+	}
+
+	priv->db_compiled = 0;
+	HS_LOG(INFO, "Rule DB updated: %u total rules", priv->nb_rules);
+	return nb_rules;
+}
+
+/* Compile and Activate */
+static int
+hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
+{
+	struct hs_regex_priv *priv;
+	hs_compile_error_t *compile_err = NULL;
+	hs_error_t err;
+	const char **expressions;
+	unsigned int *flags;
+	unsigned int *ids;
+	hs_expr_ext_t *ext;
+	const hs_expr_ext_t **ext_ptrs;
+	uint32_t i;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	if (priv->nb_rules == 0) {
+		HS_LOG(ERR, "No rules to compile");
+		return -EINVAL;
+	}
+
+	if (priv->qps == NULL) {
+		HS_LOG(ERR, "Cannot compile: queue pairs not allocated");
+		return -EINVAL;
+	}
+
+	if (priv->db) {
+		hs_free_database(priv->db);
+		priv->db = NULL;
+	}
+
+	expressions = rte_malloc("hs_expr",
+				 sizeof(char *) * priv->nb_rules, 0);
+	flags = rte_malloc("hs_flags",
+			   sizeof(unsigned int) * priv->nb_rules, 0);
+	ids = rte_malloc("hs_ids",
+			 sizeof(unsigned int) * priv->nb_rules, 0);
+	ext = rte_zmalloc("hs_ext",
+			  sizeof(hs_expr_ext_t) * priv->nb_rules, 0);
+	ext_ptrs = rte_malloc("hs_ext_ptrs",
+			      sizeof(hs_expr_ext_t *) * priv->nb_rules, 0);
+
+	if (!expressions || !flags || !ids || !ext || !ext_ptrs) {
+		rte_free(expressions);
+		rte_free(flags);
+		rte_free(ids);
+		rte_free(ext);
+		rte_free(ext_ptrs);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < priv->nb_rules; i++) {
+		expressions[i] = priv->rules[i].pattern;
+		ids[i] = priv->rules[i].rule_id;
+
+		flags[i] = 0;
+		if (priv->rules[i].rule_flags & RTE_REGEX_PCRE_RULE_CASELESS_F)
+			flags[i] |= HS_FLAG_CASELESS;
+		if (priv->rules[i].rule_flags & RTE_REGEX_PCRE_RULE_DOTALL_F)
+			flags[i] |= HS_FLAG_DOTALL;
+		if (priv->rules[i].rule_flags & RTE_REGEX_PCRE_RULE_MULTILINE_F)
+			flags[i] |= HS_FLAG_MULTILINE;
+		if (priv->rules[i].rule_flags & RTE_REGEX_PCRE_RULE_UTF_F)
+			flags[i] |= HS_FLAG_UTF8;
+
+		ext[i].flags = 0;
+		if (priv->rules[i].min_offset) {
+			ext[i].flags |= HS_EXT_FLAG_MIN_OFFSET;
+			ext[i].min_offset = priv->rules[i].min_offset;
+		}
+		if (priv->rules[i].max_offset) {
+			ext[i].flags |= HS_EXT_FLAG_MAX_OFFSET;
+			ext[i].max_offset = priv->rules[i].max_offset;
+		}
+		if (priv->rules[i].min_length) {
+			ext[i].flags |= HS_EXT_FLAG_MIN_LENGTH;
+			ext[i].min_length = priv->rules[i].min_length;
+		}
+		ext_ptrs[i] = &ext[i];
+	}
+
+	err = hs_compile_ext_multi(expressions, flags, ids, ext_ptrs,
+				   priv->nb_rules, HS_MODE_BLOCK, NULL,
+				   &priv->db, &compile_err);
+
+	rte_free(expressions);
+	rte_free(flags);
+	rte_free(ids);
+	rte_free(ext);
+	rte_free(ext_ptrs);
+
+	if (err != HS_SUCCESS) {
+		HS_LOG(ERR, "hs_compile_ext_multi failed: %s (pattern %d)",
+		       compile_err ? compile_err->message : "unknown",
+		       compile_err ? compile_err->expression : -1);
+		if (compile_err)
+			hs_free_compile_error(compile_err);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < priv->nb_queue_pairs; i++) {
+		struct hs_regex_qp *qp = &priv->qps[i];
+
+		if (qp->scratch) {
+			hs_free_scratch(qp->scratch);
+			qp->scratch = NULL;
+		}
+		err = hs_alloc_scratch(priv->db, &qp->scratch);
+		if (err != HS_SUCCESS) {
+			uint32_t j;
+
+			HS_LOG(ERR, "Scratch alloc failed for qp %u", i);
+			for (j = 0; j < i; j++) {
+				if (priv->qps[j].scratch) {
+					hs_free_scratch(priv->qps[j].scratch);
+					priv->qps[j].scratch = NULL;
+				}
+			}
+			hs_free_database(priv->db);
+			priv->db = NULL;
+			return -ENOMEM;
+		}
+	}
+
+	priv->db_compiled = 1;
+	HS_LOG(INFO, "Compiled %u rules into Hyperscan database",
+	       priv->nb_rules);
+	return 0;
+}
+
+static int
+hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
+			uint32_t rule_db_len)
+{
+	struct hs_regex_priv *priv;
+	hs_error_t err;
+	uint32_t i;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	if (!rule_db || rule_db_len == 0) {
+		HS_LOG(ERR, "Invalid rule_db pointer or length");
+		return -EINVAL;
+	}
+
+	if (priv->qps == NULL) {
+		HS_LOG(ERR, "Cannot import: queue pairs not allocated");
+		return -EINVAL;
+	}
+
+	if (priv->db) {
+		hs_free_database(priv->db);
+		priv->db = NULL;
+	}
+
+	err = hs_deserialize_database(rule_db, (size_t)rule_db_len, &priv->db);
+	if (err != HS_SUCCESS) {
+		HS_LOG(ERR, "hs_deserialize_database failed (error %d)", err);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < priv->nb_queue_pairs; i++) {
+		struct hs_regex_qp *qp = &priv->qps[i];
+
+		if (qp->scratch) {
+			hs_free_scratch(qp->scratch);
+			qp->scratch = NULL;
+		}
+		err = hs_alloc_scratch(priv->db, &qp->scratch);
+		if (err != HS_SUCCESS) {
+			uint32_t j;
+
+			HS_LOG(ERR, "Scratch alloc failed for qp %u"
+			       " after import", i);
+			for (j = 0; j < i; j++) {
+				if (priv->qps[j].scratch) {
+					hs_free_scratch(priv->qps[j].scratch);
+					priv->qps[j].scratch = NULL;
+				}
+			}
+			hs_free_database(priv->db);
+			priv->db = NULL;
+			return -ENOMEM;
+		}
+	}
+
+	priv->db_compiled = 1;
+	HS_LOG(INFO, "Imported serialized Hyperscan database (%u bytes)",
+	       rule_db_len);
+	return 0;
+}
+
+static int
+hs_regex_rule_db_export(struct rte_regexdev *dev, char *rule_db)
+{
+	struct hs_regex_priv *priv;
+	hs_error_t err;
+	char *buf;
+	size_t len;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	if (!priv->db) {
+		HS_LOG(ERR, "No database to export");
+		return -EINVAL;
+	}
+
+	err = hs_serialize_database(priv->db, &buf, &len);
+	if (err != HS_SUCCESS) {
+		HS_LOG(ERR, "hs_serialize_database failed (error %d)", err);
+		return -EIO;
+	}
+
+	if (rule_db == NULL) {
+		free(buf);
+		if (len > INT_MAX) {
+			HS_LOG(ERR, "Serialized DB too large (%zu bytes)", len);
+			return -EOVERFLOW;
+		}
+		return (int)len;
+	}
+
+	memcpy(rule_db, buf, len);
+	free(buf);
+	return 0;
+}
+
 /* Fast path stubs replaced by real implementations in later patches. */
 
 static uint16_t
@@ -235,6 +633,10 @@ static const struct rte_regexdev_ops hs_regexdev_ops = {
 	.dev_info_get = hs_regex_info_get,
 	.dev_configure = hs_regex_configure,
 	.dev_qp_setup = hs_regex_qp_setup,
+	.dev_rule_db_update = hs_regex_rule_db_update,
+	.dev_rule_db_compile_activate = hs_regex_rule_db_compile_activate,
+	.dev_db_import = hs_regex_rule_db_import,
+	.dev_db_export = hs_regex_rule_db_export,
 };
 
 /* Device Lifecycle */
diff --git a/drivers/regex/hs/hs_regex.h b/drivers/regex/hs/hs_regex.h
index be4c2e9..ddd6d9b 100644
--- a/drivers/regex/hs/hs_regex.h
+++ b/drivers/regex/hs/hs_regex.h
@@ -6,6 +6,7 @@
 #define HS_REGEX_H
 
 #include <rte_regexdev.h>
+#include <rte_hash.h>
 #include <hs/hs.h>
 
 #define HS_REGEX_DRIVER_NAME "regex_hs"
@@ -16,6 +17,12 @@
 #define HS_REGEX_DEFAULT_NB_DESC 1024
 #define HS_REGEX_MAX_NB_DESC 32768
 
+/* Ext params encoded in rule_flags bits 37-63 */
+#define HS_REGEX_EXT_MAX_OFFSET_SHIFT 37
+#define HS_REGEX_EXT_MAX_OFFSET_MASK  0x1FFFULL
+#define HS_REGEX_EXT_MIN_OFFSET_SHIFT 50
+#define HS_REGEX_EXT_MIN_OFFSET_MASK  0x3FFFULL
+
 /* Device lifecycle state machine. */
 enum hs_regex_dev_state {
 	HS_REGEX_DEV_CREATED = 0,
@@ -30,6 +37,9 @@ struct hs_regex_rule {
 	uint32_t rule_id;
 	uint16_t group_id;
 	uint64_t rule_flags;
+	uint64_t min_offset;
+	uint64_t max_offset;
+	uint64_t min_length;
 };
 
 /* Queue pair */
@@ -48,6 +58,7 @@ struct hs_regex_qp {
 /* Per-device private data */
 struct hs_regex_priv {
 	struct hs_regex_rule *rules;
+	struct rte_hash *rule_id_hash;
 	uint32_t nb_rules;
 	uint32_t rules_cap;
 
-- 
2.43.0

