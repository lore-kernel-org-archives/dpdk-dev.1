Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFDD606A891
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+KIT+om
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50B7A4279C;
	Thu, 12 Nov 2026 16:44:14 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 3A9944270A
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:44:11 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-91eb449364cso49291866d6.2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794498250; x=1795103050; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v2nr0irbPLtwUqwFIwCL8edIha6ZZ1dUc5Xabiv97Is=;
 b=H+KIT+omxHbUV3fKCQdfyjs+iqL70MZ79t6gu0aNaicNmeb0mLRCXh4uX7McqXyx7j
 WXWzhFW++RoHmwLygPWOaiaa0BJYkr8Oddjwe+urQezr4zYxxqC8R7FvYhGjkgZFYaGs
 CjouyAU5k5Kk9yP2jjwGGnlihpO9s++KztyuCMlI0uBPULonG+GHt96t0S4QVjkcE0W7
 skH/O1Ig904rUUWTcICT8dwd1Y6LPgyVm+2AxJCzQpjLR39Y0rU2FO7wmSTSupx1SIE5
 9ZW+zfJkaZWF12SqBPdSeA3XlbcX8lX+O7Kdge9KTdMqiDMmfXE8Vb3aMfu0Hfwq8W67
 AgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794498250; x=1795103050;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v2nr0irbPLtwUqwFIwCL8edIha6ZZ1dUc5Xabiv97Is=;
 b=TWP1oCmG9W3QKuLUSQur3UXli9s6Cg3QYM1P2S3j9rZVGKM38gTxsNNS4e7o/OZr1w
 ByxfzAQo3KcdhnYelCV9t8Tpfb0LgfNa7hdYWdHh1b6/JQLn+crV80xt+smSnLM6DIDu
 +Hy8Y9d/DbATWdJ9zvWMOx08fLRIoNBsFRf2bC2mIzJX+I9Y+UPhhiWRAH/oGuNbGZ3d
 Ufi7Rt4KmrfDtrsEF+X+494Fyeua2JSmLjMPjxnkiKsUz15m2si5xpACiypYcAzercXu
 evZtWVNskkK4e/s0KmdHi7JylKzqkTlrculer+Xhn1/NT7YcAS0UGGkbaHedK0DnTfKW
 vaIg==
X-Gm-Message-State: APuU4Z+aTjrN4MqMgp3tIe3bqDOtIDLN/Npz/cvqVjg5xL1QC8lfYa95
 O2yk01QZjEOQdmRslI23YnBxNRvPZHDsa7QEt8OdpcwSr2+o2YH38uAyZYp/URVX
X-Gm-Gg: AYBFou2k365gvh9tl6+cqqGF5TJJrFfms/2vwwmcNTpKkxJTns7BtxvH5DDV0Wi/314
 9tcQPsNqVSSyZyGXDUlD0x+jWNupwLEmviHP5ke9J/FMXISkHN37ickoq5cgv23N13Fihh6e4qD
 PTiXpl1tAW34G2sOg1zmYC0h2dM66mbGXzBkpgGgrds3cqMJPKdcehXawg8+Z5EWFSnBVsNXPYS
 r3L1tuY1/Q1OiEmSxJ3NJzI8VOt3ETnIlbsN9B7OQ/gyZYBQ358O/yqj9L+nk5K22FFYAkkNkX7
 /GOS8RVBKoQ9Z2Efv6aEha6qzrq1bPoVcdccLPvQOiBGDcgwBiIKrs8ocB6aHVHX2QXoLz6qFjQ
 6gXVZmhxKFAJT7g1eAFYVGXR9I7zRqH0TlwReQxJ3ZktgoEv0rOZS43980qFegQgXz7LTfKRyU6
 mgktzKNIim+QX1e1egb5CqDPlxeNkPJIr5ZT9aLHm/KOga8A9/iOiZXPg1aRV2R3LdLP4q7MmWu
 CatWMo20T05K9YKeWbpLEp2pJaRjFap8F9Mrc4M/5+qKGWhInLJIr7354FOokgmgby9y8JO7pV2
 YklpP9MEKS0sQ9Q5rmQhADXYzVCkmgN3HG6BVpw5BFAKBVrkdlU5MHTVg/dtfpXM0nPy4j6YTMa
 tV/UwcoedOJkBx3tW/DHDzC6trNRmBgrs0aG8/9sicC+IfjYVnPfvPMkfwuxtaHs1+Y0e9/8i2O
 7D
X-Received: by 2002:a05:6214:398d:b0:91e:aa6d:d408 with SMTP id
 6a1803df08f44-91f03e88ff2mr103183056d6.7.1794498249870; 
 Thu, 12 Nov 2026 07:44:09 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f02df714csm50400586d6.28.2026.11.12.07.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:44:09 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v4 3/3] test/mempool: add list walk race test
Date: Thu, 12 Nov 2026 10:43:42 -0500
Message-Id: <20261112154342.1484709-4-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261112154342.1484709-1-rsanford2@gmail.com>
References: <20261109144054.3784583-1-rsanford2@gmail.com>
 <20261112154342.1484709-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

Walk, look up and dump the mempool list on some lcores while other
lcores create and free mempools, in two phases of 500 ms. In the
first phase, mempools are created and freed as fast as possible. In
the second phase, every other mempool is created empty and populated
after a short delay, so that the walkers also find mempools that are
not populated yet. In that phase, the walk callback also dumps each
mempool, and it checks rte_mempool_is_created() before querying the
mempool driver, as documented for rte_mempool_walk().

Without either of the two previous patches, the test crashes. It
needs at least 3 lcores and is skipped otherwise. It adds about one
second to mempool_autotest.

Signed-off-by: Robert Sanford <rsanford@akamai.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 app/test/test_mempool.c | 150 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 0a4d794346..0edb691b56 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -839,6 +839,152 @@ test_mempool_flag_non_io_unset_when_populated_with_valid_iova(void)
 
 #pragma pop_macro("RTE_TEST_TRACE_FAILURE")
 
+/*
+ * Walk, look up and dump the mempool list on some lcores while other lcores
+ * create and free mempools. In the first phase the creators free mempools as
+ * fast as possible. In the second phase every other mempool is created empty
+ * and populated after a short delay, so that the walkers also find mempools
+ * that are not populated yet, and dump them.
+ */
+#define LIST_RACE_PHASE_MS	500
+#define LIST_RACE_NB_OBJ	63
+#define LIST_RACE_ELT_SIZE	64
+
+#ifndef RTE_EXEC_ENV_WINDOWS
+#define LIST_RACE_DUMP_FILE	"/dev/null"
+#else
+#define LIST_RACE_DUMP_FILE	"NUL"
+#endif
+
+static RTE_ATOMIC(uint32_t) list_race_stop;
+static int list_race_populate_later;
+static FILE *list_race_dump;
+
+static int
+test_mempool_list_race_create(__rte_unused void *arg)
+{
+	char name[RTE_MEMPOOL_NAMESIZE];
+	struct rte_mempool *mp;
+	int populate_later = 0;
+
+	snprintf(name, sizeof(name), "test_list_race_%u", rte_lcore_id());
+	while (rte_atomic_load_explicit(&list_race_stop,
+			rte_memory_order_relaxed) == 0) {
+		if (populate_later) {
+			mp = rte_mempool_create_empty(name, LIST_RACE_NB_OBJ,
+				LIST_RACE_ELT_SIZE, 0, 0, SOCKET_ID_ANY, 0);
+			if (mp == NULL)
+				RET_ERR();
+			rte_delay_us(100);
+			if (rte_mempool_set_ops_byname(mp,
+					rte_mbuf_best_mempool_ops(), NULL) < 0 ||
+					rte_mempool_populate_default(mp) < 0) {
+				rte_mempool_free(mp);
+				RET_ERR();
+			}
+		} else {
+			mp = rte_mempool_create(name, LIST_RACE_NB_OBJ,
+				LIST_RACE_ELT_SIZE, 0, 0, NULL, NULL, NULL, NULL,
+				SOCKET_ID_ANY, 0);
+			if (mp == NULL)
+				RET_ERR();
+		}
+		rte_mempool_free(mp);
+		if (list_race_populate_later)
+			populate_later = !populate_later;
+	}
+	return 0;
+}
+
+static void
+test_mempool_list_race_walk_cb(struct rte_mempool *mp, void *arg)
+{
+	unsigned int *count = arg;
+
+	/* rte_mempool_dump() must handle mempools that are not populated yet */
+	if (list_race_dump != NULL)
+		rte_mempool_dump(list_race_dump, mp);
+
+	/* as documented for rte_mempool_walk(), check this first */
+	if (!rte_mempool_is_created(mp))
+		return;
+	/* access the store */
+	*count += mp->size + rte_mempool_avail_count(mp);
+}
+
+static int
+test_mempool_list_race_walk(__rte_unused void *arg)
+{
+	unsigned int count = 0;
+
+	while (rte_atomic_load_explicit(&list_race_stop,
+			rte_memory_order_relaxed) == 0) {
+		rte_mempool_walk(test_mempool_list_race_walk_cb, &count);
+		if (rte_mempool_lookup("test_list_race_none") != NULL)
+			RET_ERR();
+		if (list_race_dump != NULL)
+			rte_mempool_list_dump(list_race_dump);
+	}
+	return 0;
+}
+
+static int
+test_mempool_list_race_phase(int populate_later, FILE *dump)
+{
+	unsigned int nb_creators = (rte_lcore_count() - 1) / 2;
+	unsigned int lcore_id, i = 0;
+	int ret = 0;
+
+	list_race_populate_later = populate_later;
+	list_race_dump = dump;
+	rte_atomic_store_explicit(&list_race_stop, 0, rte_memory_order_relaxed);
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		lcore_function_t *func = i++ < nb_creators ?
+			test_mempool_list_race_create :
+			test_mempool_list_race_walk;
+
+		if (rte_eal_remote_launch(func, NULL, lcore_id) != 0)
+			ret = -1;
+	}
+
+	rte_delay_ms(LIST_RACE_PHASE_MS);
+	rte_atomic_store_explicit(&list_race_stop, 1, rte_memory_order_relaxed);
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		if (rte_eal_wait_lcore(lcore_id) < 0)
+			ret = -1;
+	}
+	return ret;
+}
+
+static int
+test_mempool_list_race(void)
+{
+	FILE *f;
+	int ret;
+
+	if (rte_lcore_count() < 3) {
+		printf("%s skipped: needs at least 3 lcores\n", __func__);
+		return 0;
+	}
+
+	/* mempools freed while the list is walked */
+	ret = test_mempool_list_race_phase(0, NULL);
+	if (ret != 0) {
+		LOG_ERR();
+		return ret;
+	}
+
+	/* mempools not populated yet while the list is walked and dumped */
+	f = fopen(LIST_RACE_DUMP_FILE, "w");
+	ret = test_mempool_list_race_phase(1, f);
+	if (f != NULL)
+		fclose(f);
+	if (ret != 0)
+		LOG_ERR();
+	return ret;
+}
+
 static int
 test_mempool(void)
 {
@@ -1105,6 +1251,10 @@ test_mempool(void)
 	if (test_mempool_flag_non_io_unset_when_populated_with_valid_iova() < 0)
 		GOTO_ERR(ret, err);
 
+	/* test walking the mempool list while mempools are created and freed */
+	if (test_mempool_list_race() < 0)
+		GOTO_ERR(ret, err);
+
 	rte_mempool_list_dump(stdout);
 
 	ret = 0;
-- 
2.34.1

