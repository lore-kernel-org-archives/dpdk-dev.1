Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DCD606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaspersky.com header.i=@kaspersky.com header.a=rsa-sha256 header.s=mail202505 header.b=ClXzVJO4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5473F402B2;
	Wed, 25 Nov 2026 06:30:27 +0100 (CET)
Received: from mx15.kaspersky-labs.com (mx15.kaspersky-labs.com
 [46.165.235.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 1D4844027A;
 Wed, 25 Nov 2026 06:30:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1795584625;
 bh=fvuxB99osMwhyV1o/4SowYWfo7zgS9+ep3gN9QKfDi0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=ClXzVJO4ZRHkqZVOuXyMyRBbSHnx5ZBhYs3Om05B8Wu2V6zdBXkM8UGxteJORXihu
 bOTgfUKpa9UbZSuHXje9Gzyh45nmwxBo5NtiVvkER8bVGZriwZJznBL90JF6y4zH8C
 NJAROQU0f3SqwjGTItXhcVFUesEamv0tR76bZQp8QbEGV9wzoas+mZ4eBjCoOiCEnQ
 a2LCBKNZDMnf80K8lgqZjRf39vPnFoKRVxf3KJ2wyOj8mFjqjxWtunSRzvX3WWtw21
 09kbcpYcJ5lXQZhBDCgDuZra11R+HrKOQ2XSm2oA3mUTfcdpzusOz/pWuSE9c9PGTJ
 DWbXWDVdvPNBw==
Received: from relay15.kaspersky-labs.com (localhost [127.0.0.1])
 by relay15.kaspersky-labs.com (Postfix) with ESMTP id BD11CA0B63;
 Wed, 25 Nov 2026 08:30:25 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub15.kaspersky-labs.com (Postfix) with ESMTPS id BD447A2026;
 Wed, 25 Nov 2026 08:30:24 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 08:30:23 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <cristian.dumitrescu@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <jasvinder.singh@intel.com>,
 AlexanderChesnokov <Alexander.Chesnokov@kaspersky.com>
Subject: [PATCH] sched: fix subport free on RED/PIE config failure
Date: Wed, 25 Nov 2026 08:30:21 +0300
Message-ID: <20261125053021.741146-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/25/2026 05:18:32
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 207810 [Nov 25 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 135 0.3.135
 58dcfca10e9e4d27990d8f7387f1467d65061802
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: chesnokov.avp.ru:5.0.1,7.1.1; kaspersky.com:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions_lk}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/25/2026 05:20:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/25/2026 4:13:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.1.0.9599,
 bases: 2026/11/25 01:50:00 #28976341
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

rte_sched_subport_config() registers the newly allocated subport in
port->subports[] right after the allocation, but assigns the queue
array pointers s->queue and s->queue_array only later in the
function, after the CMAN configuration block. If rte_red_config_init()
or rte_pie_config_init() rejects the parameters, the function returns
before reaching the assignments, and the failure path frees the port
through rte_sched_free_memory() -> rte_sched_subport_free(), which
drains enqueued mbufs by dereferencing subport->queue and
subport->queue_array. Both pointers are still NULL at that point and
the drain loop faults reading the queue pointers.

The PIE tail queue threshold check rejects the parameters without
freeing anything. The half-initialized subport then stays reachable
through port->subports[], and a later rte_sched_port_free() faults
in the same drain loop.

Move the CMAN configuration after the queue base calculation and the
array base assignments. Those are pure functions of the subport
parameters and the subport allocation, so nothing changes for
configurations that pass. On the failure path the subport is freed
with the array pointers referencing the zeroed subport memory, the
drain loop finds empty queues and completes safely.

Add sched_autotest cases verifying that rte_sched_subport_config()
rejects invalid RED (min_th == max_th) and invalid PIE (qdelay_ref
== 0, tailq_th > qsize) parameters without crashing, and that a
later rte_sched_port_free() completes safely on the subport that a
rejected PIE tail queue threshold leaves half-initialized. Check
that a valid RED configuration still succeeds.

Freeing the whole port on a configuration error, which leaves the
caller with a dangling port pointer, is a separate problem and is
not changed here.

Fixes: ce7c4fd7c2ac ("sched: add pipe config to subport level")
Cc: stable@dpdk.org

Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---

Cc: jasvinder.singh@intel.com

 app/test/test_sched.c | 69 +++++++++++++++++++++++++++++++++++++++++++
 lib/sched/rte_sched.c | 24 +++++++--------
 2 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/app/test/test_sched.c b/app/test/test_sched.c
index 96b48f1897..69b1bf59dd 100644
--- a/app/test/test_sched.c
+++ b/app/test/test_sched.c
@@ -210,6 +210,75 @@ test_sched(void)
 
 	rte_sched_port_free(port);
 
+	static struct rte_sched_cman_params cman_red_bad = {
+		.cman_mode = RTE_SCHED_CMAN_RED,
+		.red_params[0][RTE_COLOR_GREEN] = {
+			.min_th = 1, .max_th = 1, .maxp_inv = 10, .wq_log2 = 9,
+		},
+	};
+	static struct rte_sched_cman_params cman_pie_bad = {
+		.cman_mode = RTE_SCHED_CMAN_PIE,
+		.pie_params[0] = {
+			.qdelay_ref = 0,
+			.dp_update_interval = 100,
+			.max_burst = 10,
+			.tailq_th = 1,
+		},
+	};
+	static struct rte_sched_cman_params cman_pie_tailq_bad = {
+		.cman_mode = RTE_SCHED_CMAN_PIE,
+		.pie_params[0] = {
+			.qdelay_ref = 10,
+			.dp_update_interval = 100,
+			.max_burst = 10,
+			.tailq_th = 64,
+		},
+	};
+	static struct rte_sched_cman_params cman_red_ok = {
+		.cman_mode = RTE_SCHED_CMAN_RED,
+		.red_params[0][RTE_COLOR_GREEN] = {
+			.min_th = 1, .max_th = 1023, .maxp_inv = 10, .wq_log2 = 9,
+		},
+	};
+	struct rte_sched_subport_params sp = subport_param[0];
+
+	port_param.rate = (uint64_t) 10000 * 1000 * 1000 / 8;
+
+	/* Invalid RED (min_th == max_th) is rejected without crashing */
+	sp.cman_params = &cman_red_bad;
+	port = rte_sched_port_config(&port_param);
+	TEST_ASSERT_NOT_NULL(port, "Error config sched port\n");
+	err = rte_sched_subport_config(port, SUBPORT, &sp, 0);
+	TEST_ASSERT_FAIL(err, "Invalid RED configuration accepted\n");
+	port = NULL;
+
+	/* Invalid PIE (qdelay_ref == 0) is rejected without crashing */
+	sp.cman_params = &cman_pie_bad;
+	port = rte_sched_port_config(&port_param);
+	TEST_ASSERT_NOT_NULL(port, "Error config sched port\n");
+	err = rte_sched_subport_config(port, SUBPORT, &sp, 0);
+	TEST_ASSERT_FAIL(err, "Invalid PIE configuration accepted\n");
+	port = NULL;
+
+	/*
+	 * PIE tailq threshold above qsize keeps the half-initialized
+	 * subport registered; freeing the port must not fault
+	 */
+	sp.cman_params = &cman_pie_tailq_bad;
+	port = rte_sched_port_config(&port_param);
+	TEST_ASSERT_NOT_NULL(port, "Error config sched port\n");
+	err = rte_sched_subport_config(port, SUBPORT, &sp, 0);
+	TEST_ASSERT_FAIL(err, "Invalid PIE tailq threshold accepted\n");
+	rte_sched_port_free(port);
+
+	/* Valid RED configuration succeeds and the port frees cleanly */
+	sp.cman_params = &cman_red_ok;
+	port = rte_sched_port_config(&port_param);
+	TEST_ASSERT_NOT_NULL(port, "Error config sched port\n");
+	err = rte_sched_subport_config(port, SUBPORT, &sp, 0);
+	TEST_ASSERT_SUCCESS(err, "Valid RED configuration rejected\n");
+	rte_sched_port_free(port);
+
 	return 0;
 }
 
diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index daa31e8b99..b49771f285 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -1280,18 +1280,6 @@ rte_sched_subport_config(struct rte_sched_port *port,
 		/* TC oversubscription is enabled by default */
 		s->tc_ov_enabled = 1;
 
-		if (params->cman_params != NULL) {
-			s->cman_enabled = true;
-			status = rte_sched_cman_config(port, s, params, n_subports);
-			if (status) {
-				SCHED_LOG(NOTICE,
-					"%s: CMAN configuration fails", __func__);
-				return status;
-			}
-		} else {
-			s->cman_enabled = false;
-		}
-
 		/* Scheduling loop detection */
 		s->pipe_loop = RTE_SCHED_PIPE_INVALID;
 		s->pipe_exhaustion = 0;
@@ -1321,6 +1309,18 @@ rte_sched_subport_config(struct rte_sched_port *port,
 			(s->memory + rte_sched_subport_get_array_base(params,
 			e_RTE_SCHED_SUBPORT_ARRAY_QUEUE_ARRAY));
 
+		if (params->cman_params != NULL) {
+			s->cman_enabled = true;
+			status = rte_sched_cman_config(port, s, params, n_subports);
+			if (status) {
+				SCHED_LOG(NOTICE,
+					"%s: CMAN configuration fails", __func__);
+				return status;
+			}
+		} else {
+			s->cman_enabled = false;
+		}
+
 		/* Pipe profile table */
 		rte_sched_subport_config_pipe_profile_table(s, params,
 							    port->rate);
-- 
2.53.0

