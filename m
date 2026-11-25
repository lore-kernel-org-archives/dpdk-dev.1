Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3907E606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaspersky.com header.i=@kaspersky.com header.a=rsa-sha256 header.s=mail202505 header.b=OxDBGwmh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5996402EE;
	Wed, 25 Nov 2026 11:33:20 +0100 (CET)
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
 by mails.dpdk.org (Postfix) with ESMTPS id 587364027A;
 Wed, 25 Nov 2026 11:33:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1795602798;
 bh=NFWJWQAxg6qelOOEapIjkww702xyVUoeivmB8o/HQiI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=OxDBGwmh7RqcN7tuI8H9qsQSRAC6RPHA8t4m4dRJS3KR5z4CNtAq+n8s/vTlBwWVW
 tbV/kv98FUUMQkzmoc9qF70wD1jEQ1Z/A0E80OaeUXM6OrCiTgTHj1KuXy73t0YYIe
 q1yxXslF7bhTM+4eD5f68HxLreHpFc96J92eYRx6dNx8bPAFmAo6MX29MpyVZHGzOU
 izzQZOJiW2mvf0iNsUyVkUjLURt6h92uUKueYRfCiGyGG/WrzXDOaC+osf5beclFBs
 QdzkT5mczcoixR74O/e3SrteUrtPym+zBk7z+4p3JtOZVhtXGMyOMaOBcl4xgPoKjj
 FLdmJgqeRFffw==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
 by relay16.kaspersky-labs.com (Postfix) with ESMTP id E3EA1C038BA;
 Wed, 25 Nov 2026 13:33:18 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id BE5D0C03533;
 Wed, 25 Nov 2026 13:33:18 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 13:33:17 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <cristian.dumitrescu@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <jasvinder.singh@intel.com>,
 AlexanderChesnokov <Alexander.Chesnokov@kaspersky.com>
Subject: [PATCH] sched: fix queue stats read for mixed subports
Date: Wed, 25 Nov 2026 13:33:15 +0300
Message-ID: <20261125103315.1854655-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/25/2026 10:20:45
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 207821 [Nov 25 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 135 0.3.135
 58dcfca10e9e4d27990d8f7387f1467d65061802
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2; chesnokov.avp.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; kaspersky.com:5.0.1,7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions_lk}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/25/2026 10:22:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/25/2026 9:20:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.1.0.9599,
 bases: 2026/11/25 09:22:00 #28978498
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>

rte_sched_queue_read_stats() checks the queue ID against the total
number of queues of the port, summed over the subports. The queue
address is computed the other way: with a fixed subport capacity of
n_pipes_per_subport pipes. Subports of the same port may enable
different numbers of pipes, so a queue ID that passes the check can
decode to an index beyond the arrays of a smaller subport. The stats
copy and the clear then write outside the subport memory. The damage
surfaces later, at the first use of the overwritten data; ASAN does
not see it because the subport arrays share one allocation.

Validate the decoded queue index against the number of queues of the
subport that owns the queue ID, and reject queue IDs that decode
outside of it with -EINVAL. Queue IDs produced by
rte_sched_port_pkt_write() are valid before and after the change.
Numbering queues consecutively across subports matches this layout
only when all subports enable the same number of pipes. The stats
commands of the qos_sched example number queues this way, so on a
mixed subport layout they now get -EINVAL instead of corrupting the
memory of a smaller subport.

Add a sched_hetero_subports_autotest case with a port of two
subports: one pipe enabled on subport 0 and eight on subport 1.
Queue IDs inside the hole of the small subport and IDs beyond the
total queue count are rejected. Queue IDs of the first and the last
queue of both subports read cleanly. A packet enqueued through the
first queue of subport 1 shows up in the queue stats read for that
queue ID.

Fixes: 831104f0e84f ("sched: update queue stats read for config flexibility")
Cc: stable@dpdk.org

Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---

Cc: jasvinder.singh@intel.com

---
 app/test/test_sched.c | 108 ++++++++++++++++++++++++++++++++++++++++++
 lib/sched/rte_sched.c |   5 ++
 2 files changed, 113 insertions(+)

diff --git a/app/test/test_sched.c b/app/test/test_sched.c
index 96b48f1897..c73da2c7af 100644
--- a/app/test/test_sched.c
+++ b/app/test/test_sched.c
@@ -22,6 +22,13 @@ test_sched(void)
 	printf("sched not supported on Windows, skipping test\n");
 	return TEST_SKIPPED;
 }
+
+static int
+test_sched_hetero_subports(void)
+{
+	printf("sched not supported on Windows, skipping test\n");
+	return TEST_SKIPPED;
+}
 #else
 
 #include <rte_sched.h>
@@ -213,6 +220,107 @@ test_sched(void)
 	return 0;
 }
 
+/*
+ * Port with mixed subports: subport 0 enables 1 pipe, subport 1 enables
+ * 8. Queue IDs valid for the queue stats API follow the subport shift
+ * layout of rte_sched_port_pkt_write().
+ */
+static int
+test_sched_hetero_subports(void)
+{
+	struct rte_sched_port_params port_params = port_param;
+	struct rte_sched_subport_params sp[2];
+	struct rte_sched_queue_stats queue_stats;
+	struct rte_mbuf *mbufs[1];
+	struct rte_mempool *mp;
+	struct rte_sched_port *port;
+	uint16_t qlen;
+	uint32_t i;
+	int err;
+
+	port_params.rate = (uint64_t) 10000 * 1000 * 1000 / 8;
+	port_params.n_subports_per_port = 2;
+	port_params.n_pipes_per_subport = 8;
+
+	sp[0] = subport_param[0];
+	sp[0].n_pipes_per_subport_enabled = 1;
+	sp[1] = sp[0];
+	sp[1].n_pipes_per_subport_enabled = 8;
+
+	mp = create_mempool();
+	TEST_ASSERT_NOT_NULL(mp, "Error creating mempool\n");
+
+	port = rte_sched_port_config(&port_params);
+	TEST_ASSERT_NOT_NULL(port, "Error config sched port\n");
+
+	for (i = 0; i < 2; i++) {
+		err = rte_sched_subport_config(port, i, &sp[i], 0);
+		TEST_ASSERT_SUCCESS(err,
+			"Error config sched subport %u, err=%d\n", i, err);
+	}
+
+	for (i = 0; i < sp[0].n_pipes_per_subport_enabled; i++) {
+		err = rte_sched_pipe_config(port, 0, i, 0);
+		TEST_ASSERT_SUCCESS(err,
+			"Error config sched subport 0 pipe %u, err=%d\n",
+			i, err);
+	}
+
+	for (i = 0; i < sp[1].n_pipes_per_subport_enabled; i++) {
+		err = rte_sched_pipe_config(port, 1, i, 0);
+		TEST_ASSERT_SUCCESS(err,
+			"Error config sched subport 1 pipe %u, err=%d\n",
+			i, err);
+	}
+
+	/* Queue ID in the hole of the small subport 0 is rejected */
+	err = rte_sched_queue_read_stats(port, 92, &queue_stats, &qlen);
+	TEST_ASSERT_FAIL(err, "Queue ID 92 accepted, err=%d\n", err);
+
+	/* Queue ID at or above the total queue count is rejected */
+	err = rte_sched_queue_read_stats(port, 144, &queue_stats, &qlen);
+	TEST_ASSERT_FAIL(err, "Queue ID 144 accepted, err=%d\n", err);
+
+	/* First and last queue of the small subport 0 read cleanly */
+	err = rte_sched_queue_read_stats(port, 0, &queue_stats, &qlen);
+	TEST_ASSERT_SUCCESS(err, "Queue ID 0 rejected, err=%d\n", err);
+	err = rte_sched_queue_read_stats(port, 15, &queue_stats, &qlen);
+	TEST_ASSERT_SUCCESS(err, "Queue ID 15 rejected, err=%d\n", err);
+
+	/* First and last queue of the large subport 1 read cleanly */
+	err = rte_sched_queue_read_stats(port, 128, &queue_stats, &qlen);
+	TEST_ASSERT_SUCCESS(err, "Queue ID 128 rejected, err=%d\n", err);
+	err = rte_sched_queue_read_stats(port, 143, &queue_stats, &qlen);
+	TEST_ASSERT_SUCCESS(err, "Queue ID 143 rejected, err=%d\n", err);
+
+	/*
+	 * A packet through the first queue of subport 1 (queue ID 128)
+	 * shows up in the queue that the stats API reads for that ID
+	 */
+	mbufs[0] = rte_pktmbuf_alloc(mp);
+	TEST_ASSERT_NOT_NULL(mbufs[0], "Packet allocation failed\n");
+	mbufs[0]->pkt_len = 60;
+	mbufs[0]->data_len = 60;
+	rte_sched_port_pkt_write(port, mbufs[0], 1, 0, 0, 0, RTE_COLOR_GREEN);
+
+	err = rte_sched_port_enqueue(port, mbufs, 1);
+	TEST_ASSERT_EQUAL(err, 1, "Wrong enqueue, err=%d\n", err);
+
+	err = rte_sched_port_dequeue(port, mbufs, 1);
+	TEST_ASSERT_EQUAL(err, 1, "Wrong dequeue, err=%d\n", err);
+
+	err = rte_sched_queue_read_stats(port, 128, &queue_stats, &qlen);
+	TEST_ASSERT_SUCCESS(err, "Queue ID 128 rejected, err=%d\n", err);
+	TEST_ASSERT_EQUAL(queue_stats.n_pkts, 1, "Wrong queue stats\n");
+	TEST_ASSERT_EQUAL(qlen, 0, "Wrong queue length\n");
+
+	rte_sched_port_free(port);
+
+	return 0;
+}
+
 #endif /* !RTE_EXEC_ENV_WINDOWS */
 
 REGISTER_FAST_TEST(sched_autotest, NOHUGE_OK, ASAN_OK, test_sched);
+REGISTER_FAST_TEST(sched_hetero_subports_autotest, NOHUGE_OK, ASAN_OK,
+	test_sched_hetero_subports);
diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index daa31e8b99..7b6a26879e 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -1780,6 +1780,11 @@ rte_sched_queue_read_stats(struct rte_sched_port *port,
 
 	s = port->subports[subport_id];
 	subport_qindex = ((1 << subport_qmask) - 1) & queue_id;
+	if (subport_qindex >= rte_sched_subport_pipe_queues(s)) {
+		SCHED_LOG(ERR,
+			"%s: Incorrect value for queue id", __func__);
+		return -EINVAL;
+	}
 	q = s->queue + subport_qindex;
 	qe = s->queue_extra + subport_qindex;
 
-- 
2.43.0

