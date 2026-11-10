Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C05606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=qCqzf1cN
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C0A140283;
	Tue, 10 Nov 2026 07:23:46 +0100 (CET)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by mails.dpdk.org (Postfix) with ESMTPS id F20284027C;
 Tue, 10 Nov 2026 07:23:44 +0100 (CET)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 3C863203DD11;
 Tue, 10 Nov 2026 11:23:44 +0500 (+05)
Received: from home.mcr.net (unknown [5.165.224.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id 8F756203DD0F;
 Tue, 10 Nov 2026 11:23:42 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 8F756203DD0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1794291823; bh=OTr5SSWDSxJlt8/ZEWk+g5HfYpisWAYpznttw4Om+Wo=;
 h=From:To:Cc:Subject:Date;
 b=qCqzf1cNCj73hI+gT+PBUyTRsgfL8oVenPiwg/OpupI91l1sos5pK8RQEliXLVCyj
 PAfbmFeYz2a3BTmb44W+qK0VKxH9d8EKhijTCh2iJnfBj3ByHUrWQPS3O4/FZHQ25u
 G6OaZ9TBmGRqHNXABI4glcKtRKhJTVAaepmLcW4zxS3Z5aQKRObUTn7TfOqt9koiL1
 I8cfa1SmPYvUYTrFV7BEjR8JvSaJl1mOL81zIT2DBfyWr5MAwq5rfHd/WqIzrTqI84
 r6DpT43Ep0zgwlNCHDcZPlZnc1gS9NTFOSD3ltk4t/U6mpvRumzaOc5/xClWhXJ1Rz
 AJw0kOOMJT3Cw==
From: =?UTF-8?q?=D0=9C=D0=BE=D0=BA=D1=80=D1=83=D1=88=D0=B8=D0=BD=20=D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9?=
 <a.mokrushin@ideco.ru>
To: dev@dpdk.org
Cc: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, stable@dpdk.org,
 Andrey Mokrushin <a.mokrushin@ideco.ru>
Subject: [PATCH] acl: reject rules with inverted range
Date: Tue, 10 Nov 2026 11:23:41 +0500
Message-ID: <20261110062341.52126-1-a.mokrushin@ideco.ru>
X-Mailer: git-send-email 2.56.0
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

From: Andrey Mokrushin <a.mokrushin@ideco.ru>

rte_acl_build() doesn't check that for a RANGE field the low bound
(value) doesn't exceed the high bound (mask_range), and
rte_acl_add_rules() can't check it, as it doesn't know the field
types. Such a rule is accepted, and then:
- for a 1-byte field the build crashes with a NULL pointer
  dereference in acl_gen_node();
- for a 2-byte field (e.g. port range 80..22) the build succeeds,
  but the rule matches every value of the field instead of none.

The check was done only for the legacy ipv4vlan rules
(acl_ipv4vlan_check_rule(), now in app/test). Validate RANGE fields
in acl_build_rules(), where the configuration is known, and fail
the build with -EINVAL. Add a test case with the generic API.

Fixes: dc276b5780c2 ("acl: new library")
Cc: stable@dpdk.org

Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
---
 app/test/test_acl.c | 26 ++++++++++++++++++++++++
 lib/acl/acl_bld.c   | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

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
index 99d1dbc..aa25c78 100644
--- a/lib/acl/acl_bld.c
+++ b/lib/acl/acl_bld.c
@@ -1443,6 +1443,52 @@ acl_build_log(const struct acl_build_context *ctx)
 	}
 }
 
+/*
+ * Check that for all RANGE fields lower bound doesn't exceed upper bound.
+ */
+static int
+acl_check_rule_ranges(const struct rte_acl_config *cfg,
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
+		if (lo > hi) {
+			ACL_LOG(ERR,
+				"Error in rule[%u]: invalid range for %u-th field",
+				rule->data.userdata, n);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int
 acl_build_rules(struct acl_build_context *bcx)
 {
@@ -1467,6 +1513,8 @@ acl_build_rules(struct acl_build_context *bcx)
 		rule = (const struct rte_acl_rule *)
 			((uintptr_t)bcx->acx->rules + bcx->acx->rule_sz * i);
 		if ((rule->data.category_mask & bcx->category_mask) != 0) {
+			if (acl_check_rule_ranges(&bcx->cfg, rule) != 0)
+				return -EINVAL;
 			br[num].next = head;
 			br[num].config = &bcx->cfg;
 			br[num].f = rule;
-- 
2.56.0


