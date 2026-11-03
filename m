Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E4606A32E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZioPsbW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EAE8427B6;
	Tue,  3 Nov 2026 18:36:18 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 8740C42795
 for <dev@dpdk.org>; Tue,  3 Nov 2026 18:36:15 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-93f1e5d7450so406389385a.2
 for <dev@dpdk.org>; Tue, 03 Nov 2026 09:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793727374; x=1794332174; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aDUaHLuLbfOdbsEwmrtNPD+PTkz/fmoZRoY2igATUKU=;
 b=zZioPsbWe4Tho7yquyCqrebedg3/57JFVIllIAa0BxAFPIGAe+i8bG/p1yJBHFsXDv
 O56Q3LcRILCjkH+PO0EVNMFW/YjH2G0z5oX58lYc2idEVjB2e/fJ84//R7xvDE8gGBrI
 f0Rn9wkInbh6joOl++6vmjpnn+coMp6EfUaxPhNtUXE5iV3HLnURZT0cNBVtkRyg+ub2
 dP6qhVOjGW0VB06IgUVaK1REryD6IMPZ7Q4gM8yyR8O3uQbhqUGqxFQnWPGSEEMZ5q2q
 zw6HkwjVNmtEJw2zw8SCPpfSbXh64/nPWMkcVFlaqZ94aQpOocX1vwG4gCMB1nJ5cCsz
 3A7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793727374; x=1794332174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aDUaHLuLbfOdbsEwmrtNPD+PTkz/fmoZRoY2igATUKU=;
 b=vob1lUhcRHtEwEtT/LjCaZylw6zf/KuA9WK8fFEcWRtpNVFgaiogSgIx8TMU7Oy0QL
 dxunytgSFIRoux/vMvjpI5ynU16TSpEKnM1dgs68iX2Bprpk6qnaRcvY6/aIECNz6RW+
 FKDzozNXKpbSh/Q00koJ6YcTkez2OpgSHkxBL/Hm9nMce+eUFwiK0hHIzwIgqLz++Djm
 fUW30ga5cAMGZKeLdlQy+hHYtP4FYGp29b5gWYMG+EZuczNAK6U68jqfrCXZHfAlU6cA
 768txxA8hqMPdLomWy2XOd4zc2BYjG3OGfu/mtQ8KpB6w4Y5Zhk+UWTcTWP9bBrh1q/m
 69ZQ==
X-Gm-Message-State: APuU4Z/Q+GbBtn3H7ydr7OZPpKTptJfn9a66s3kz3ep143kZP+wZV4Iv
 sScHfglMcukelX0yAjBpctCoddKqnFj6f3+XwQLDabdFxViwrpx9iOR5nLZ7+xah
X-Gm-Gg: AYBFou2exC7jm3fHwgfsHmG6HhLe6DsJnQFJMsTVtoN+Zo3pcg8GbHE7C6wcgFc35OC
 Y4cJnUY51XqljaRdLcoYMlFaCDlCyqmiyc7xGy02gMnGN3dJXA9Q9eH8loxeZ0XqpMSx1pKSgFD
 K897ue3Ao67dsUQzXDorNv2jQXsGdBHdoyWZ6rMyVhV7c36t43V79MnG20wFr/sQz3dsMXYRIw1
 cyYUGT/G85uwKFY+A7yTSg/7ARin11HvEfHxUWle36Vo1GkOqjtvyQHUQc1iux6WrEPNL34opC8
 JYNe3wneMXE5KByYy/ZxpgvBhk5lnWf0Ikub6LHJF3INWVR/OLjKofsp27GxBIKrOfQIGA3U7bz
 q0y5TOyrj7uALZAGYcIDWHN0X3IHLDM5stZCtD2UNk0XHe6A0+CwnnxxO/PukN0vtxPVAxU0qU/
 G/lRizGcWyGasH15ryPm6KC4pWRgVZE/wKyXrlwyGwt7THnbmvjLghLtoYBhrgm9zLK7iQaTymL
 HF2PkluQfXyJF3F+W5jCBZ9f7JSI6HEAYgpFK8ijRxZ7V7n2Hc6qbgyAabhDMTnI5P5tS9324uL
 A8HIhywXsfZSEhhDKcbrldPfUTLrlIbbagsbm3rVttk9aI2pp3xXVmRv4z8gLVzXhknyFd1LG1J
 /Ac8JRfJJWRh0T1Y6E1QZwaitEeh43svZfa/y+77/u1or2K3j58qcREHPdQLJ1KWbtgPPzUT3Ks
 W0bX9mpCgsU+hZa5S9qHPUyw==
X-Received: by 2002:a05:620a:a51c:b0:945:b967:475f with SMTP id
 af79cd13be357-945b967477fmr855053385a.16.1793727374450; 
 Tue, 03 Nov 2026 09:36:14 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d33c0052sm15113385a.8.2026.11.03.09.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:36:13 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v2 3/3] test/mempool: add list walk race test
Date: Tue,  3 Nov 2026 12:35:43 -0500
Message-Id: <20261103173543.130142-4-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103173543.130142-1-rsanford2@gmail.com>
References: <20261103011107.3658840-1-rsanford2@gmail.com>
 <20261103173543.130142-1-rsanford2@gmail.com>
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
mempool, and it checks RTE_MEMPOOL_F_POOL_CREATED before querying the
mempool driver, as documented for rte_mempool_walk().

Without either of the two previous patches, the test crashes. It
needs at least 3 lcores and is skipped otherwise. It adds about one
second to mempool_autotest.

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 app/test/test_mempool.c | 146 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 0a4d794346..a8daa813c7 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -839,6 +839,148 @@ test_mempool_flag_non_io_unset_when_populated_with_valid_iova(void)
 
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
+	/* as documented for rte_mempool_walk(), check the flag first */
+	if ((rte_atomic_load_explicit((RTE_ATOMIC(unsigned int) *)&mp->flags,
+			rte_memory_order_acquire) &
+			RTE_MEMPOOL_F_POOL_CREATED) == 0)
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
@@ -1105,6 +1247,10 @@ test_mempool(void)
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

