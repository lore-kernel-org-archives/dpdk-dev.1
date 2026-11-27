Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE15606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.a=rsa-sha256 header.s=mail202505 header.b=U1ARNGsf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D92F74065A;
	Fri, 27 Nov 2026 05:41:05 +0100 (CET)
Received: from mx16.kaspersky-labs.com (mx16.kaspersky-labs.com [5.79.125.27])
 by mails.dpdk.org (Postfix) with ESMTPS id 01B41402CE;
 Fri, 27 Nov 2026 05:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1795754462;
 bh=k+Oo5Pt+DeqrLc3fsLsQhTk9taETXQVgLL1f8st4BAg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=U1ARNGsfzq8zFg3rvw9NTWjUAbO2bz1nMxjUh+SsCxsKBqVWISIkhh3ubdFYUF0nz
 KMrgVlRK7dHrxutE/K3fzTBYCc+gp0Z1EBwg3lXF78HDF/l/OdDLWCQYtECey/hif2
 bABfVag5qd3f/LonOLDSGnG8KwbWla/ac8hS5HLt2s8oVlDv9eI6d7efiecK8FZ8aq
 Xp5K+4umW+IQvgqXf7FCIsvV/Akx5ZAGt9maWeX9HuBgzKJT4LcvTMnWutPDRRaMFf
 AuOfvwuWl6GyCMdvQ4hu02HYKE4yXHTmXumiCEQ4pam1GA0pn7if4gcWnmMi4xCUTN
 lH0+gtWY+sFDw==
Received: from relay16.kaspersky-labs.com (localhost [127.0.0.1])
 by relay16.kaspersky-labs.com (Postfix) with ESMTP id B6F08C63CC5;
 Fri, 27 Nov 2026 07:41:02 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub16.kaspersky-labs.com (Postfix) with ESMTPS id DDC59C657ED;
 Fri, 27 Nov 2026 07:41:01 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 07:41:01 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <cristian.dumitrescu@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <jasvinder.singh@intel.com>,
 AlexanderChesnokov <Alexander.Chesnokov@kaspersky.com>
Subject: [PATCH 2/3] sched: reject API calls on unconfigured subport
Date: Fri, 27 Nov 2026 07:40:55 +0300
Message-ID: <20261127044056.2869218-2-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127044056.2869218-1-Alexander.Chesnokov@kaspersky.com>
References: <20261127044056.2869218-1-Alexander.Chesnokov@kaspersky.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV2.avp.ru (10.64.57.52) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/27/2026 04:33:33
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 207887 [Nov 26 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 136 0.3.136
 23736263c36d600868e9fbb7b30669123b6e1813
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: chesnokov.avp.ru:5.0.1,7.1.1; 127.0.0.199:7.1.2;
 kaspersky.com:5.0.1,7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions_lk}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/27/2026 04:36:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/27/2026 2:36:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.1.0.9599,
 bases: 2026/11/27 01:57:00 #28986712
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

rte_sched_pipe_config(), rte_sched_subport_read_stats(),
rte_sched_queue_read_stats(), rte_sched_subport_tc_ov_config() and
rte_sched_subport_pipe_profile_add() dereference the subport slot
of the port without checking it. A subport whose
rte_sched_subport_config() has not completed leaves the slot NULL,
and the call crashes on the NULL pointer. The pipe profile add
also accepts subport_id equal to the number of subports and reads
one slot past the end of the array.

Return -EINVAL for an unconfigured subport in these calls and fix
the subport id check in the pipe profile add. Statistics of the
configured subports of the same port keep working, so a failed
subport configuration no longer poisons the statistics of the
whole port.

Fixes: 34a90f86657c ("sched: modify pipe functions for config flexibility")
Fixes: ce7c4fd7c2ac ("sched: add pipe config to subport level")
Fixes: f5e60154adec ("sched: enable traffic class oversubscription conditionally")
Cc: stable@dpdk.org

Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---
 lib/sched/rte_sched.c | 27 ++++++++++++++++++++++++++-
 lib/sched/rte_sched.h |  9 ++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index f7df0886c4..861efb4b37 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -1159,6 +1159,11 @@ rte_sched_subport_tc_ov_config(struct rte_sched_port *port,
 	}
 
 	s = port->subports[subport_id];
+	if (s == NULL) {
+		SCHED_LOG(ERR,
+			"%s: Subport is not configured", __func__);
+		return -EINVAL;
+	}
 	s->tc_ov_enabled = tc_ov_enable ? 1 : 0;
 
 	return 0;
@@ -1378,6 +1383,11 @@ rte_sched_pipe_config(struct rte_sched_port *port,
 	}
 
 	s = port->subports[subport_id];
+	if (s == NULL) {
+		SCHED_LOG(ERR,
+			"%s: Subport is not configured", __func__);
+		return -EINVAL;
+	}
 	if (pipe_id >= s->n_pipes_per_subport_enabled) {
 		SCHED_LOG(ERR,
 			"%s: Incorrect value for parameter pipe id", __func__);
@@ -1483,13 +1493,18 @@ rte_sched_subport_pipe_profile_add(struct rte_sched_port *port,
 	}
 
 	/* Subport id not exceeds the max limit */
-	if (subport_id > port->n_subports_per_port) {
+	if (subport_id >= port->n_subports_per_port) {
 		SCHED_LOG(ERR,
 			"%s: Incorrect value for subport id", __func__);
 		return -EINVAL;
 	}
 
 	s = port->subports[subport_id];
+	if (s == NULL) {
+		SCHED_LOG(ERR,
+			"%s: Subport is not configured", __func__);
+		return -EINVAL;
+	}
 
 	/* Pipe profiles exceeds the max limit */
 	if (s->n_pipe_profiles >= s->n_max_pipe_profiles) {
@@ -1683,6 +1698,11 @@ rte_sched_subport_read_stats(struct rte_sched_port *port,
 	}
 
 	s = port->subports[subport_id];
+	if (s == NULL) {
+		SCHED_LOG(ERR,
+			"%s: Subport is not configured", __func__);
+		return -EINVAL;
+	}
 
 	/* Copy subport stats and clear */
 	memcpy(stats, &s->stats, sizeof(struct rte_sched_subport_stats));
@@ -1734,6 +1754,11 @@ rte_sched_queue_read_stats(struct rte_sched_port *port,
 	subport_id = (queue_id >> subport_qmask) & (port->n_subports_per_port - 1);
 
 	s = port->subports[subport_id];
+	if (s == NULL) {
+		SCHED_LOG(ERR,
+			"%s: Subport is not configured", __func__);
+		return -EINVAL;
+	}
 	subport_qindex = ((1 << subport_qmask) - 1) & queue_id;
 	q = s->queue + subport_qindex;
 	qe = s->queue_extra + subport_qindex;
diff --git a/lib/sched/rte_sched.h b/lib/sched/rte_sched.h
index b839392250..53798ce3ee 100644
--- a/lib/sched/rte_sched.h
+++ b/lib/sched/rte_sched.h
@@ -420,7 +420,8 @@ rte_sched_subport_config(struct rte_sched_port *port,
  *   rte_sched_port_free() as usual. The subport whose configuration
  *   failed stays unconfigured and the call can be repeated with
  *   corrected parameters. The subports configured before the failed
- *   call keep their configuration, statistics and queued packets.
+ *   call keep their configuration, statistics and queued packets. A
+ *   call on a subport that is not configured returns -EINVAL.
  */
 int
 rte_sched_pipe_config(struct rte_sched_port *port,
@@ -461,7 +462,8 @@ rte_sched_port_get_memory_footprint(struct rte_sched_port_params *port_params,
  *   where the oversubscription status for each of the subport traffic classes
  *   should be stored.
  * @return
- *   0 upon success, error code otherwise
+ *   0 upon success, error code otherwise; -EINVAL if the subport
+ *   is not configured
  */
 int
 rte_sched_subport_read_stats(struct rte_sched_port *port,
@@ -483,7 +485,8 @@ rte_sched_subport_read_stats(struct rte_sched_port *port,
  *   Pointer to pre-allocated variable where the current queue length
  *   should be stored.
  * @return
- *   0 upon success, error code otherwise
+ *   0 upon success, error code otherwise; -EINVAL if the subport
+ *   is not configured
  */
 int
 rte_sched_queue_read_stats(struct rte_sched_port *port,
-- 
2.53.0

