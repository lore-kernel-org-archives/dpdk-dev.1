Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7707606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=oK3VBooP
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A016640687;
	Mon,  9 Nov 2026 07:01:19 +0100 (CET)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by mails.dpdk.org (Postfix) with ESMTPS id 0BF16402BC;
 Mon,  9 Nov 2026 07:01:17 +0100 (CET)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 4BC29203C242;
 Mon, 09 Nov 2026 11:01:17 +0500 (+05)
Received: from home.mcr.net (unknown [5.165.224.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id 99895203C246;
 Mon, 09 Nov 2026 11:01:14 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 99895203C246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1794204076; bh=7hQQzGSEBL8cW7sD9fF8hnRK3YCJtzNFhBVomeF8Src=;
 h=From:To:Cc:Subject:Date;
 b=oK3VBooP51fltPbiOg2ztJnloTPkg+kuZ2ZV0IGi4jgu/dJMk6ZdcGaBqMHs4FX67
 K9J2zf9Pfs0SsvbGaojvtCzQM6DM2ub5d2OXda53oTUGxXxXwcKM2Fl4CbPkUzB6lY
 7ewolL0/LVg4FYDxh1ILsARnV70mooNN2GaQOQ2OzkhT7Qwf/9Mp84ewGS3Kxwhpsk
 qGKYDFSh5QBW7FgLpBLvvsY4DPEO7ARF+vrZvH9cF4Ue0YeCCycmQL5oMTSV/ZD3in
 Ehk9KMvTn036jRMjA4MqVTHE8lBZlk7a0c9pqE7GbALwsvXSN4Tptrz3WK/2LJFXSs
 c7Y0ZeBVe609g==
From: Andrey Mokrushin <a.mokrushin@ideco.ru>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, stable@dpdk.org,
 Andrey Mokrushin <a.mokrushin@ideco.ru>
Subject: [PATCH] lpm6: fix tbl8 reference counters after bulk delete
Date: Mon,  9 Nov 2026 11:01:13 +0500
Message-ID: <20261109060113.34711-1-a.mokrushin@ideco.ru>
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

rte_lpm6_delete_bulk_func() clears tbl24 and tbl8 and rebuilds them
by calling rte_lpm6_add() for each rule left in the rules table.
As these rules are still in the rules table, rule_add() reports them
as existing ones, and add_step() does not increment the reference
counter of the tbl8 group the rule ends in. After the rebuild, every
tbl8 group is under-counted by the number of rules ending in it.

A following rte_lpm6_delete() then drops the counter to zero too early,
and remove_tbl() frees a tbl8 group that still holds more specific
rules. Lookups for these rules return the next hop of a less specific
rule. Deleting them walks an entry that is no longer extended and uses
its next hop as a tbl8 group index: this triggers an assert in
rule_find_range(), or an out of bounds access with NDEBUG.

Add the rules to tbl24/tbl8 as new ones during the rebuild,
and add a unit test for this case.

Fixes: e480688dce6d ("lpm6: add incremental update on delete")
Cc: stable@dpdk.org

Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
---
 app/test/test_lpm6.c | 67 ++++++++++++++++++++++++++++++++++++++++++++
 lib/lpm/rte_lpm6.c   | 47 +++++++++++++++++++++++--------
 2 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/app/test/test_lpm6.c b/app/test/test_lpm6.c
index 7340331..7d9d87b 100644
--- a/app/test/test_lpm6.c
+++ b/app/test/test_lpm6.c
@@ -52,6 +52,7 @@ static int32_t test25(void);
 static int32_t test26(void);
 static int32_t test27(void);
 static int32_t test28(void);
+static int32_t test29(void);
 
 rte_lpm6_test tests6[] = {
 /* Test Cases */
@@ -84,6 +85,7 @@ rte_lpm6_test tests6[] = {
 	test26,
 	test27,
 	test28,
+	test29,
 };
 
 #define MAX_DEPTH                                                    128
@@ -1745,6 +1747,71 @@ test28(void)
 	return PASS;
 }
 
+/*
+ * Add three nested rules deeper than 24 bits and one more rule.
+ * Delete the last rule with the delete_bulk function, which rebuilds
+ * the tables. Then delete the middle rule with the incremental delete
+ * function and check that the most specific rule is still found,
+ * i.e. the tbl8 groups were not freed while still in use.
+ */
+int32_t
+test29(void)
+{
+	struct rte_lpm6 *lpm = NULL;
+	struct rte_lpm6_config config;
+	struct rte_ipv6_addr ip_16 = RTE_IPV6(0x2001, 0, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr ip_32 = RTE_IPV6(0x2001, 0xdb8, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr ip_48 = RTE_IPV6(0x2001, 0xdb8, 1, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr ip_del = RTE_IPV6(0x2001, 0xdb8, 2, 0, 0, 0, 0, 0);
+	uint8_t depth_del = 48;
+	uint32_t next_hop_return = 0;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	status = rte_lpm6_add(lpm, &ip_16, 16, 16);
+	TEST_LPM_ASSERT(status == 0);
+	status = rte_lpm6_add(lpm, &ip_32, 32, 32);
+	TEST_LPM_ASSERT(status == 0);
+	status = rte_lpm6_add(lpm, &ip_48, 48, 48);
+	TEST_LPM_ASSERT(status == 0);
+	status = rte_lpm6_add(lpm, &ip_del, 48, 100);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6_delete_bulk_func(lpm, &ip_del, &depth_del, 1);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6_lookup(lpm, &ip_48, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == 48));
+
+	status = rte_lpm6_delete(lpm, &ip_32, 32);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6_lookup(lpm, &ip_48, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == 48));
+
+	status = rte_lpm6_delete(lpm, &ip_48, 48);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6_lookup(lpm, &ip_48, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == 16));
+
+	status = rte_lpm6_delete(lpm, &ip_16, 16);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6_lookup(lpm, &ip_48, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6_free(lpm);
+
+	return PASS;
+}
+
 /*
  * Do all unit tests.
  */
diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index e23c886..2c2c17e 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -189,6 +189,10 @@ rule_key_init(struct rte_lpm6_rule_key *key, const struct rte_ipv6_addr *ip, uin
 	key->depth = depth;
 }
 
+static int
+add_rule_to_tbl(struct rte_lpm6 *lpm, struct rte_ipv6_addr *masked_ip,
+		uint8_t depth, uint32_t next_hop, uint8_t is_new_rule);
+
 /*
  * Rebuild the entire LPM tree by reinserting all rules
  */
@@ -197,12 +201,21 @@ rebuild_lpm(struct rte_lpm6 *lpm)
 {
 	uint64_t next_hop;
 	struct rte_lpm6_rule_key *rule_key;
+	struct rte_ipv6_addr ip;
 	uint32_t iter = 0;
 
+	/*
+	 * The rules are already in the rules table, so rte_lpm6_add() would
+	 * treat them as existing ones and would not account them in the
+	 * reference counters of the freshly allocated tbl8 groups.
+	 * Insert them as new rules instead.
+	 */
 	while (rte_hash_iterate(lpm->rules_tbl, (void *) &rule_key,
-			(void **) &next_hop, &iter) >= 0)
-		rte_lpm6_add(lpm, &rule_key->ip, rule_key->depth,
-			(uint32_t) next_hop);
+			(void **) &next_hop, &iter) >= 0) {
+		ip = rule_key->ip;
+		add_rule_to_tbl(lpm, &ip, rule_key->depth,
+			(uint32_t) next_hop, 1);
+	}
 }
 
 /*
@@ -828,13 +841,7 @@ int
 rte_lpm6_add(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip, uint8_t depth,
 	     uint32_t next_hop)
 {
-	struct rte_lpm6_tbl_entry *tbl;
-	struct rte_lpm6_tbl_entry *tbl_next = NULL;
-	/* init to avoid compiler warning */
-	uint32_t tbl_next_num = 123456;
-	int status;
 	struct rte_ipv6_addr masked_ip;
-	int i;
 
 	/* Check user arguments. */
 	if ((lpm == NULL) || (depth < 1) || (depth > RTE_IPV6_MAX_DEPTH))
@@ -855,10 +862,28 @@ rte_lpm6_add(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip, uint8_t depth
 	if (is_new_rule < 0)
 		return is_new_rule;
 
+	return add_rule_to_tbl(lpm, &masked_ip, depth, next_hop, is_new_rule);
+}
+
+/*
+ * Add a rule to the data structure (tbl24+tbl8s).
+ * The rule must be already present in the rules table.
+ */
+static int
+add_rule_to_tbl(struct rte_lpm6 *lpm, struct rte_ipv6_addr *masked_ip,
+		uint8_t depth, uint32_t next_hop, uint8_t is_new_rule)
+{
+	struct rte_lpm6_tbl_entry *tbl;
+	struct rte_lpm6_tbl_entry *tbl_next = NULL;
+	/* init to avoid compiler warning */
+	uint32_t tbl_next_num = 123456;
+	int status;
+	int i;
+
 	/* Inspect the first three bytes through tbl24 on the first step. */
 	tbl = lpm->tbl24;
 	status = add_step(lpm, tbl, TBL24_IND, &tbl_next, &tbl_next_num,
-		&masked_ip, ADD_FIRST_BYTE, 1, depth, next_hop,
+		masked_ip, ADD_FIRST_BYTE, 1, depth, next_hop,
 		is_new_rule);
 	assert(status >= 0);
 
@@ -869,7 +894,7 @@ rte_lpm6_add(struct rte_lpm6 *lpm, const struct rte_ipv6_addr *ip, uint8_t depth
 	for (i = ADD_FIRST_BYTE; i < RTE_IPV6_ADDR_SIZE && status == 1; i++) {
 		tbl = tbl_next;
 		status = add_step(lpm, tbl, tbl_next_num, &tbl_next,
-			&tbl_next_num, &masked_ip, 1, (uint8_t)(i + 1),
+			&tbl_next_num, masked_ip, 1, (uint8_t)(i + 1),
 			depth, next_hop, is_new_rule);
 		assert(status >= 0);
 	}
-- 
2.56.0


