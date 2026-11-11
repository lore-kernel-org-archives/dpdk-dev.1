Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81449606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=V19OI6Qv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1C88402A2;
	Wed, 11 Nov 2026 08:30:49 +0100 (CET)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by mails.dpdk.org (Postfix) with ESMTPS id A6DA14029B;
 Wed, 11 Nov 2026 08:30:48 +0100 (CET)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id E75D426BC2;
 Wed, 11 Nov 2026 12:30:47 +0500 (+05)
Received: from home.mcr.net (unknown [5.165.224.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id E634126BC1;
 Wed, 11 Nov 2026 12:30:46 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru E634126BC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1794382247; bh=8j0JjNuKcZZi6S5sYdPQgoL9debqrbQIcFtAwigud+k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=V19OI6QvY0Sofx+WAEbpUsjLWObdc3qort0fYaZ3DayHCPOqvoPuNKODLMRrizHtC
 5hdVj3iqnn+mAR1y3LSLC4NvdT+t12SdDTeYdJVmZzfdqmWnksllHmT/dxY6mfytql
 Jx1Ys1kVq4WN+4z4ILPCa13/4Mjivxj761snmZ0VlgKHe0+xRdLk7RBL89uQceuYDk
 vtcXIl5AN3hArasTJ2BOxIjNdh++fPhRXxlSToCLc/m2lKxu6XETg9cJ7FlEpRva33
 V4ysxiB1RN/oUpThnkZSTAz1F6DsGvEn3Q2JHc+Gtq+jMuInBY0+LVSdPe/bW5NTNL
 /mpwAQSu1vMbA==
From: Andrey Mokrushin <a.mokrushin@ideco.ru>
To: dev@dpdk.org
Cc: konstantin.v.ananyev@yandex.ru, dmitry.kozliuk@gmail.com, stable@dpdk.org,
 Andrey Mokrushin <a.mokrushin@ideco.ru>
Subject: [PATCH v2] acl: reject rules with inverted range
Date: Wed, 11 Nov 2026 12:30:41 +0500
Message-ID: <20261111073041.38712-1-a.mokrushin@ideco.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110062341.52126-1-a.mokrushin@ideco.ru>
References: <20261110062341.52126-1-a.mokrushin@ideco.ru>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rte_acl_build() doesn't check that for a RANGE field the low bound
(value) doesn't exceed the high bound (mask_range). Field types are
known only from the rte_acl_config passed to rte_acl_build(), so
rte_acl_add_rules() doesn't validate ranges. Such a rule is accepted,
and then:
- for a 1-byte field the build crashes with a NULL pointer
  dereference in acl_gen_node();
- for a 2-byte field (e.g. port range 80..22) the build succeeds,
  but the rule matches every value of the field instead of none.

The check was done only for the legacy ipv4vlan rules
(acl_ipv4vlan_check_rule(), now in app/test). Validate RANGE fields
of all rules in acl_check_bld_param(), together with the rest of the
build parameters, and fail rte_acl_build() with -EINVAL.
Add a test case with the generic API.

Fixes: dc276b5780c2 ("acl: new library")
Cc: stable@dpdk.org

Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
---
v2:
- move range validation from acl_build_rules() to acl_check_bld_param()
  so rules are validated once per rte_acl_build() call (Dmitry Kozlyuk);
- reword commit message: field types are known only at build time
  (Konstantin Ananyev).

 app/test/test_acl.c | 26 ++++++++++++++++++
 lib/acl/acl_bld.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/app/test/test_acl.c b/app/test/test_acl.c
index 5d207c8..47786bc 100644
--- a/app/test/test_acl.c
+++ b/app/test/test_acl.c
@@ -1274,6 +1274,7 @@ test_invalid_rules(void)
 	int ret;
 
 	struct rte_acl_ipv4vlan_rule rule;
+	struct acl_ipv4vlan_rule rv;
 
 	acx = rte_acl_create(&acl_param);
 	if (acx == NULL) {
@@ -1338,6 +1339,31 @@ test_invalid_rules(void)
 		goto err;
 	}
 
+	/* test inverted high/low destination ports added through the
+	 * generic API: rte_acl_add_rules() doesn't know the field types,
+	 * so the rule has to be rejected by rte_acl_build().
+	 */
+	rule = acl_rule;
+	rule.data.userdata = 1;
+	rule.dst_port_low = 0xfff0;
+	rule.dst_port_high = 0x0010;
+
+	acl_ipv4vlan_convert_rule(&rule, &rv);
+	ret = rte_acl_add_rules(acx, (struct rte_acl_rule *)&rv, 1);
+	if (ret != 0) {
+		printf("Line %i: Adding rules to ACL context failed!\n",
+			__LINE__);
+		goto err;
+	}
+
+	ret = rte_acl_ipv4vlan_build(acx, ipv4_7tuple_layout,
+		RTE_ACL_MAX_CATEGORIES);
+	if (ret != -EINVAL) {
+		printf("Line %i: Building ACL context "
+				"should have failed!\n", __LINE__);
+		goto err;
+	}
+
 	rte_acl_free(acx);
 
 	return 0;
diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
index 99d1dbc..534a0e1 100644
--- a/lib/acl/acl_bld.c
+++ b/lib/acl/acl_bld.c
@@ -1548,6 +1548,71 @@ acl_bld(struct acl_build_context *bcx, struct rte_acl_ctx *ctx,
 	return rc;
 }
 
+/*
+ * Check that for all RANGE fields lower bound doesn't exceed upper bound.
+ */
+static int
+acl_check_rule_range(const struct rte_acl_config *cfg,
+	const struct rte_acl_rule *rule)
+{
+	uint32_t n;
+	uint64_t lo, hi;
+	const struct rte_acl_field *fld;
+
+	for (n = 0; n != cfg->num_fields; n++) {
+		if (cfg->defs[n].type != RTE_ACL_FIELD_TYPE_RANGE)
+			continue;
+
+		fld = rule->field + cfg->defs[n].field_index;
+		switch (cfg->defs[n].size) {
+		case sizeof(uint8_t):
+			lo = fld->value.u8;
+			hi = fld->mask_range.u8;
+			break;
+		case sizeof(uint16_t):
+			lo = fld->value.u16;
+			hi = fld->mask_range.u16;
+			break;
+		case sizeof(uint32_t):
+			lo = fld->value.u32;
+			hi = fld->mask_range.u32;
+			break;
+		default:
+			lo = fld->value.u64;
+			hi = fld->mask_range.u64;
+			break;
+		}
+
+		if (lo > hi)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Check that rules added to the context are valid for the given config.
+ */
+static int
+acl_check_rules(const struct rte_acl_ctx *ctx, const struct rte_acl_config *cfg)
+{
+	uint32_t i;
+	const struct rte_acl_rule *rule;
+
+	for (i = 0; i != ctx->num_rules; i++) {
+		rule = (const struct rte_acl_rule *)
+			((uintptr_t)ctx->rules + ctx->rule_sz * i);
+		if (acl_check_rule_range(cfg, rule) != 0) {
+			ACL_LOG(ERR,
+			"ACL context: %s, rule[%u] (userdata: %u): low bound exceeds high bound of a range field",
+			ctx->name, i, rule->data.userdata);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Check that parameters for acl_build() are valid.
  */
@@ -1588,7 +1653,7 @@ acl_check_bld_param(struct rte_acl_ctx *ctx, const struct rte_acl_config *cfg)
 		}
 	}
 
-	return 0;
+	return acl_check_rules(ctx, cfg);
 }
 
 /*
-- 
2.56.0


