Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7690606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 01:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyWOvcnK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3396410FA;
	Tue,  3 Nov 2026 02:11:18 +0100 (CET)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTPS id 4CCEF410EE
 for <dev@dpdk.org>; Tue,  3 Nov 2026 02:11:18 +0100 (CET)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-93e63ee7b4cso366744785a.2
 for <dev@dpdk.org>; Mon, 02 Nov 2026 17:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793668277; x=1794273077; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Cqu+FZ4OVCLkyFFAi+vRlsKRX169lO4Fh/XLlPfGnU=;
 b=tyWOvcnKZJoDdhrJFK0kIHCXWChXwoLoR0QHT1JxFMRGqkgLBCa4kIckm70YJYOyT9
 8Wn/oLp11rxJGCBjOM/2oYU515NKDsbGgxgv8cHiDYWFShUZQPhhJ6gX90n+vDa4jorR
 /OaH8Mi/2biJsleJco7VvruP/Li9zGZfjP41DHQzF5KW4gpULN5tcmVrrOcQNXxhkT5u
 pf1f6E2bA/FNN1WXYW+ns4sPqPS20Ca/qOj7ws3x0tbO3yN0yEIraVA/guTE78AgtXzC
 uWQkqPZRMM0ewR+l53tMiN5CmQPJLpQ5IwRvzUdfElICue4X79411j9t+fU8LteDXjo3
 A97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793668277; x=1794273077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Cqu+FZ4OVCLkyFFAi+vRlsKRX169lO4Fh/XLlPfGnU=;
 b=VMGfymyBeKX1rPfiZpw4y1j0MYxeJAnY6/dmxIRSfq4EdACvYG3YTetRe4wmrGrUfl
 UBuJInaNECKo+Hy7Qzu7Lw5MhxFEFuAqLmE+7gYZm6Cce7VdIw6yweIEYIsPVBBNIHUY
 6ez0zZX0m8t5sB4zH7VPtFIAZZP8KhsFvLmKRj9PLrcxhS+X4t0A/TGheoNx0iuetvo0
 ZHNMrntdR1lIl0DW5Lz9teyM82XibJULkf7L72D2y9N2LOVhLIJbCty7s2OdU0vyJW4a
 PltxmmPrLSYs1ZEirQmI1hetH5fGKxyh0Pjd7GzDkp3c39fzj0NV28wNrVtqMAF51+Gh
 guCA==
X-Gm-Message-State: APuU4Z9Z9ecPoK/3uB+J2Csu1lx636sn4pUfHGF35xL8NHRYZPjG3nQB
 IMkvP42+Sv0jVJOHwzfcLVgA9UBZtWnlKwB3jD8Gm2C4ha3MAun5D87Exr5DRWdL
X-Gm-Gg: AYBFou34pQkpU/WVRbDARbNjFXVmKX37wI3kjNb1mwQHErigkD/FY3VMhBVbekC5X1g
 S9mdjt63G/fpckma9zzV+PAFzXjLR9xWDDqrzNmV8x0l0qxNd5F+aVzF0ZGRZ7m1eJh+k+12h5Y
 ZQncoOdNcS0tJHwGFn9DGyWl2GdZRNE1P9rooxO70PCUg5Ymr2Ze5xAq7cmIQJiwwDni7qVVnzZ
 tuz3sDw1H/503LkHj6mY2xsyNtKMWgRm/laYwaVbrDanPZAPZ1R6erCyGbXxO5iR9oeU8LQ2iF7
 hqesrlVGfudtxZ5FbR/hyLCsqY/i0zsD0mfZy7ZO+nHulubiNA13pBI1TnNOE4+qNXmCm5R090V
 bEHKV/0qhMWRs1UPx69Mahzpq0npQ7cJ3adSzuLTXZdeSY2JCP/s/fbRz1wpjTJKX6gM2Nk5vto
 ARrqk6uolGsoIydCS5Al6ge9A1koRPKts0vM9hAEMaaeaMLu9sQJrQsHomos8wDIM8QaKjc70LK
 KUH4096c2x6BwJmEHaS56nBoOUbPAxO50awIMmlC7BvNHbbLaWi0A5Ii9gAV6vsZfFxSqpLhPqH
 sOy2L0HUU7dvx1KWL6p5FYQFK3kLiFnAS5BFAnc8oet7grP8WJPNHDI1vVsn37a7tNGzV+YnbxI
 2I70xq+xSWL15EDyg0QBPYSoU0PZpHJPE/6f2ineQ78IkUvGYjer3dtja4JRBOvRFMRRFLtx3mi
 XJ
X-Received: by 2002:ad4:5cc5:0:b0:91b:9136:d303 with SMTP id
 6a1803df08f44-91ca4ad5257mr188429816d6.10.1793668276939; 
 Mon, 02 Nov 2026 17:11:16 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7e2749asm103788266d6.1.2026.11.02.17.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 17:11:15 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v1 3/3] test/mempool: add list walk race test
Date: Mon,  2 Nov 2026 20:11:07 -0500
Message-Id: <20261103011107.3658840-4-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103011107.3658840-1-rsanford2@gmail.com>
References: <20261103011107.3658840-1-rsanford2@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

Walk, look up and dump the mempool list on some lcores while other
lcores create and free mempools, in two phases of 500 ms. In the
first phase, mempools are created and freed as fast as possible. In
the second phase, every other mempool is created empty and populated
after a short delay, so that the walkers also find mempools that are
not populated yet.

Without either of the two previous patches, the test crashes. It
needs at least 3 lcores and is skipped otherwise. It adds about one
second to mempool_autotest.

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 app/test/test_mempool.c | 137 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 0a4d794346..ae19064cb1 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -839,6 +839,139 @@ test_mempool_flag_non_io_unset_when_populated_with_valid_iova(void)
 
 #pragma pop_macro("RTE_TEST_TRACE_FAILURE")
 
+/*
+ * Walk, look up and dump the mempool list on some lcores while other lcores
+ * create and free mempools. In the first phase the creators free mempools as
+ * fast as possible. In the second phase every other mempool is created empty
+ * and populated after a short delay, so that the walkers also find mempools
+ * that are not populated yet.
+ */
+#define LIST_RACE_PHASE_MS	500
+#define LIST_RACE_NB_OBJ	63
+#define LIST_RACE_ELT_SIZE	64
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
+			rte_delay_us(10);
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
+	/* access both the mempool and its store */
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
+	f = fopen("/dev/null", "w");
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
@@ -1105,6 +1238,10 @@ test_mempool(void)
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

