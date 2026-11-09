Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DDC606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=E7yv0riI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF216402CF;
	Mon,  9 Nov 2026 08:05:40 +0100 (CET)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by mails.dpdk.org (Postfix) with ESMTPS id 960DB402BC;
 Mon,  9 Nov 2026 08:05:39 +0100 (CET)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id BE25E2023653;
 Mon, 09 Nov 2026 12:05:38 +0500 (+05)
Received: from home.mcr.net (unknown [5.165.224.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id CA5DA20236DD;
 Mon, 09 Nov 2026 12:05:36 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru CA5DA20236DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1794207938; bh=A0G4CfQn3HwxWVQK+ZhyLgJU9N6SdyGpP/FEoHZNErE=;
 h=From:To:Cc:Subject:Date;
 b=E7yv0riIYRcMikGLle3enr2yDdmVTAqnmqYtexDTbxhuCwJ4ebsf92WRlMuAqyHFn
 UwHhAkDVuLhMYRlox8t0G2pOXnYNNwj10vEp7vaKYf0VvQe9SJPTgWSKmvRKOWkiPU
 dyzovjg1Mc5kbEFbVBpDORrNuZZCHnKmAngZBQH5YMBNTmrnbtTk+7RJNfWfgiDYEz
 +n5xtzK8R05cAPZZ6ifwXUzGKAtOfTSZ6FhNfFUU8VEMqucYQxbQT3jFVMHaeY0ekC
 NqwVQat1tKxc7AEeoN96vCgZe23VNTkfyiQSm6ekeiXOLN1Jb4/bfYYJ2vd8XX3PaC
 q3iu7w49kjHJA==
From: Andrey Mokrushin <a.mokrushin@ideco.ru>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, stable@dpdk.org,
 Andrey Mokrushin <a.mokrushin@ideco.ru>
Subject: [PATCH] lpm: fix tbl8 reuse after delete all with RCU defer queue
Date: Mon,  9 Nov 2026 12:05:35 +0500
Message-ID: <20261109070535.50977-1-a.mokrushin@ideco.ru>
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

In RCU defer queue mode, tbl8_free() pushes a freed tbl8 group into
the defer queue, and the group stays allocated until its reclamation.
rte_lpm_delete_all() clears all tbl8 groups, including the ones still
waiting in the defer queue, so they can be allocated again for new
rules. When the deferred reclamation runs later, it invalidates such
a group while it is in use: lookups for the new rule miss, and the
group can be allocated once more to another rule, so the lookups
return the next hop of that rule.

Wait for the readers and reclaim the defer queue in
rte_lpm_delete_all(), and add a unit test for this case.

Fixes: 8a9f8564e9f9 ("lpm: implement RCU rule reclamation")
Cc: stable@dpdk.org

Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>
---
 app/test/test_lpm.c | 75 ++++++++++++++++++++++++++++++++++++++++++++-
 lib/lpm/rte_lpm.c   | 11 +++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/app/test/test_lpm.c b/app/test/test_lpm.c
index f4a8031..4baab9e 100644
--- a/app/test/test_lpm.c
+++ b/app/test/test_lpm.c
@@ -44,6 +44,7 @@ static int32_t test18(void);
 static int32_t test19(void);
 static int32_t test20(void);
 static int32_t test21(void);
+static int32_t test22(void);
 
 rte_lpm_test tests[] = {
 /* Test Cases */
@@ -68,7 +69,8 @@ rte_lpm_test tests[] = {
 	test18,
 	test19,
 	test20,
-	test21
+	test21,
+	test22
 };
 
 #define MAX_DEPTH 32
@@ -1563,6 +1565,77 @@ test21(void)
 	return (status == 0) ? PASS : -1;
 }
 
+/*
+ * rte_lpm_delete_all with RCU QSBR in defer queue mode.
+ *  - Add a rule using a tbl8 group, delete it: the group goes to the
+ *    defer queue
+ *  - Delete all rules, add another rule using a tbl8 group
+ *  - Add one more rule needing a tbl8 group: there is none left
+ *  - Check that the second rule is still found
+ */
+int32_t
+test22(void)
+{
+	struct rte_lpm *lpm = NULL;
+	struct rte_lpm_config config;
+	size_t sz;
+	struct rte_rcu_qsbr *qsv;
+	int32_t status;
+	uint32_t ip1, ip2, ip3, next_hop_return;
+	uint8_t depth = 25;
+	struct rte_lpm_rcu_config rcu_cfg = {0};
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = 1;
+	config.flags = 0;
+
+	lpm = rte_lpm_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	/* Create RCU QSBR variable */
+	sz = rte_rcu_qsbr_get_memsize(1);
+	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz,
+				RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	TEST_LPM_ASSERT(qsv != NULL);
+
+	status = rte_rcu_qsbr_init(qsv, 1);
+	TEST_LPM_ASSERT(status == 0);
+
+	rcu_cfg.v = qsv;
+	rcu_cfg.mode = RTE_LPM_QSBR_MODE_DQ;
+	/* Attach RCU QSBR to LPM table */
+	status = rte_lpm_rcu_qsbr_add(lpm, &rcu_cfg);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip1 = RTE_IPV4(192, 0, 2, 0);
+	ip2 = RTE_IPV4(198, 51, 100, 0);
+	ip3 = RTE_IPV4(203, 0, 113, 0);
+
+	status = rte_lpm_add(lpm, ip1, depth, 1);
+	TEST_LPM_ASSERT(status == 0);
+	status = rte_lpm_delete(lpm, ip1, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	rte_lpm_delete_all(lpm);
+
+	status = rte_lpm_add(lpm, ip2, depth, 2);
+	TEST_LPM_ASSERT(status == 0);
+
+	/* No tbl8 group left, the one used by ip2 must not be reclaimed */
+	status = rte_lpm_add(lpm, ip3, depth, 3);
+	TEST_LPM_ASSERT(status != 0);
+
+	status = rte_lpm_lookup(lpm, ip2, &next_hop_return);
+	TEST_LPM_ASSERT(status == 0 && next_hop_return == 2);
+	status = rte_lpm_lookup(lpm, ip3, &next_hop_return);
+	TEST_LPM_ASSERT(status != 0);
+
+	rte_lpm_free(lpm);
+	rte_free(qsv);
+
+	return PASS;
+}
+
 /*
  * Do all unit tests.
  */
diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index 0d1afe0..9ddb079 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -1268,4 +1268,15 @@ rte_lpm_delete_all(struct rte_lpm *lpm)
 
 	/* Delete all rules form the rules table. */
 	memset(i_lpm->rules_tbl, 0, sizeof(i_lpm->rules_tbl[0]) * i_lpm->max_rules);
+
+	/*
+	 * The tbl8 groups waiting in the defer queue have just been
+	 * cleared and may be allocated again. Reclaim them now, otherwise
+	 * the deferred reclamation would invalidate a reused group.
+	 */
+	if (i_lpm->dq != NULL) {
+		rte_rcu_qsbr_synchronize(i_lpm->v, RTE_QSBR_THRID_INVALID);
+		rte_rcu_qsbr_dq_reclaim(i_lpm->dq, i_lpm->number_tbl8s,
+			NULL, NULL, NULL);
+	}
 }
-- 
2.56.0


