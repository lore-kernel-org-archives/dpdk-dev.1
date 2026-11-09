Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0E606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MA+a7ro4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D649A40A84;
	Mon,  9 Nov 2026 15:41:27 +0100 (CET)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47])
 by mails.dpdk.org (Postfix) with ESMTPS id B7F464025A
 for <dev@dpdk.org>; Mon,  9 Nov 2026 15:41:23 +0100 (CET)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-91ea0c05c92so9298526d6.0
 for <dev@dpdk.org>; Mon, 09 Nov 2026 06:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794235282; x=1794840082; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BKqxRCxzp0KFDIeq5w/qRXhwwldN987gLR2FVBf8k8s=;
 b=MA+a7ro4r+OEOh+iXUbVZAFUFAaqCiDuVYNGwtM+7kApRjcbpwEWPT533iPv9vzx7j
 3nTk4Va5v7ueDugvdSo5M5W4J4PDojBWncXwxqxBEN12s4Hzno2JXxMu/k//wIRm90JN
 lRJNQO9jljC71ACjrMLMS3JVL8K/6hlJ9FCjfkrKxSyCMSX7uON8W2Xy83HgUuPf+fmD
 K67lKWGObyrEEYbDYeI67LTJ2yalF8g8Kuiq+8Zb/LKTfV869VhSwt6CJTVjWGbQlBQ7
 Us+Ivk7KQZ5iz3hxvy9arg6OgmpU5E96za/T8Pi0bgQpygr6tu5ZSvN/k/Y7/XokWM3E
 BbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794235282; x=1794840082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BKqxRCxzp0KFDIeq5w/qRXhwwldN987gLR2FVBf8k8s=;
 b=ydPUb6qDVNr41GEB2R+C2jj+TJrHCntJ4Fn2S6Wpg1ty+0+UsdfI6AhdgncyAmVTYb
 pSllrMmLLJbwzQ5st+uqDrqHQk0t+msz0s4ZYljJQYOlv9/pKFNVkhO5uIwVyDKUOOOk
 8Xja1m5IKiPEHjyzG22siVDgfzoOCircYns78GOKMvq443EXiAQrq4C+G18fR85d5qeV
 gPQ7iw5SfxRDjlDMplpyUlPBkHK0TbvfgQ/HnT91M6SKdxgGVBM7biljiN4bkGe45jqF
 2rBph748vMiYlVEeyDaylXVQ7XZaJ2jrbLZHeq+kIXqDraGQam8WUQOp/bSq76iE/Op6
 ICTQ==
X-Gm-Message-State: APuU4Z8PmTz4z6QtLlrZGUxTzuZCfvepBDo+xG4CkPLzP9OdVno8tWXr
 N4YNnITO31EhJdQIiDmp9N0zHIxTov0HC+SXjAXZEAFETZ5f/sHiLJtGmUAFLbSb
X-Gm-Gg: AYBFou086e+dJTLU6bRTiejGx6CaLHOntVazZTATfwwQITtH92u/A9Fv0XqUgiYLv8z
 PnUmSEEatjzX960CYyeOVCFac0Ague6WPPLA6JXgitoha0kvMoyFzpg2zU37WgvWnVu3/6vFXLD
 QwCYZ+215ilDXN0znk0tqQ+RrPalFtNGs0VE/RGsRq2BfKI7mjp+wR1Yb6OvlJMUfL6Wf7//zTw
 OhlQh4MJZSO1qWMfAAwjPB8w8kWXrBl3joy/4dssGB7FTUZCAbSVeUqwVNZjX0ggOTkWhITE7vB
 nU9l4L7KndHu0vwGrYMh52w0r7A0vYChQyrxcAIiq9kYJhV/ZXCpKHG3hP4Miw5lULJekggn/Fp
 5UIJ3PPwbRHT4rkhShsb8kGVxxBSCjDYMHTsA5pUFmtFOaovyWmXBRdzNYK79eIL4Hs38jlxqNn
 XMwXpD98/aNSnxciLPlYpnhNnlP1UV5U++mX8/o17Emb3dS94Yl0mRpyjIHEBzRLW4fV1Hc5O2z
 hZ/kS1fkzxjRtGqYfcAT3sS2en8fmeCWb/m6yfxsz/Qyo1Qe0IchFNeJeffN/XRJ51erdU0GXy6
 jf8Zgo/jRTj6pxXXN8guj1IFt009hgnojCJBfYy8BHKZf7X6jipBWZSm78v+XheCZFjzJb/kxWT
 a+UXDBH6JKuXYKxU4CxNZZHkD8HEFnlFV+QZQhTWLXPrP0ca77lCrON6kMiF2oRaLYqkBDT6pIh
 M=
X-Received: by 2002:a05:6214:5784:b0:91c:cff6:533f with SMTP id
 6a1803df08f44-91ed21e100amr54002096d6.5.1794235282610; 
 Mon, 09 Nov 2026 06:41:22 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91eceed448dsm43579846d6.45.2026.11.09.06.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:41:21 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>
Subject: [PATCH v3 3/3] test/mempool: add list walk race test
Date: Mon,  9 Nov 2026 09:40:54 -0500
Message-Id: <20261109144054.3784583-4-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109144054.3784583-1-rsanford2@gmail.com>
References: <20261103173543.130142-1-rsanford2@gmail.com>
 <20261109144054.3784583-1-rsanford2@gmail.com>
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
mempool, and it checks rte_mempool_is_created() before querying the
mempool driver, as documented for rte_mempool_walk().

Without either of the two previous patches, the test crashes. It
needs at least 3 lcores and is skipped otherwise. It adds about one
second to mempool_autotest.

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 app/test/test_mempool.c | 144 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 0a4d794346..ac26ef55a6 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -839,6 +839,146 @@ test_mempool_flag_non_io_unset_when_populated_with_valid_iova(void)
 
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
@@ -1105,6 +1245,10 @@ test_mempool(void)
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

