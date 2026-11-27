Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B187606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaspersky.com header.i=@kaspersky.com header.a=rsa-sha256 header.s=mail202505 header.b=aoMDRRUt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1117402B2;
	Fri, 27 Nov 2026 05:41:02 +0100 (CET)
Received: from mx15.kaspersky-labs.com (mx15.kaspersky-labs.com
 [46.165.235.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 65B7F40291;
 Fri, 27 Nov 2026 05:41:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1795754460;
 bh=RKHK6hpCpRNO8B6f6M8jFYaJumJNyIXx3C0/BahvKk8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=aoMDRRUt7Bu0k2BnDbWi38ga8P8Aoj9U/ZVaErHA0ltClB9rC03Zh25KmBpk7cUaj
 4NR2JTXZ3UlsV+TUoAUj6Fxla3AlNSXmmVqDOvH3ELA+yjgzWQO9ssO8V7cZjsqkvf
 H1Egtt/87/1c27wjJWfQBIMUxc8HskBmfzxmGX+Jwz6/3bfC29t4LnPUYAQDsyn3QC
 jLxavM7gVCn8tmqnVCnCZgclBSZpTTs2+sCEq9dZNHJofmA1ioyPr1TipPTEPEfRLM
 epg1tvUonnlP3I2SELWkjD7z4vJLkamLpN45bE8uMZenUhONuo6TxzJpziss70us7q
 blsJsc5Yh9orw==
Received: from relay15.kaspersky-labs.com (localhost [127.0.0.1])
 by relay15.kaspersky-labs.com (Postfix) with ESMTP id 2AD6FE70D4;
 Fri, 27 Nov 2026 07:41:00 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub15.kaspersky-labs.com (Postfix) with ESMTPS id 02D71E6B1A;
 Fri, 27 Nov 2026 07:40:59 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 07:40:58 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <cristian.dumitrescu@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <jasvinder.singh@intel.com>,
 AlexanderChesnokov <Alexander.Chesnokov@kaspersky.com>
Subject: [PATCH 1/3] sched: keep port valid on subport and pipe config failure
Date: Fri, 27 Nov 2026 07:40:54 +0300
Message-ID: <20261127044056.2869218-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
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
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 kaspersky.com:5.0.1,7.1.1; chesnokov.avp.ru:5.0.1,7.1.1; 127.0.0.199:7.1.2
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

rte_sched_subport_config() and rte_sched_pipe_config() release the
whole port through rte_sched_free_memory() when a parameter check
fails: the port, its subport profile table, and every subport
already configured, together with the packets enqueued in them.
The caller gets an error code and keeps the port handle, so the
next API call on the port reads freed memory. The API announces no
such ownership change: rte_sched_port_config() hands the port out
under __rte_dealloc(rte_sched_port_free, 1), and
rte_sched_port_free() is documented as the only way to release it.

A bad parameter for one subport also destroys unrelated work: the
failure frees the other subports of the same port and drains the
packets queued in them.

Keep the port and the configured subports untouched when a
configuration call fails. The subport whose configuration failed
is rolled back to the unconfigured state: its memory is released
and port->subports[subport_id] is reset to NULL, so the call can
be repeated with corrected parameters. No packet can sit in the
queues of a subport whose configuration has not completed, so the
rollback releases the subport memory directly, without the queue
drain loop. The out-of-range subport id paths no longer walk the
subport array at all, which also removes the out of bounds read
of port->subports[] on those paths.

The port handle stays valid after any configuration error; the
caller releases it with rte_sched_port_free() as on success.
Document this in both functions.

Fixes: 44c730b0e379 ("sched: add PIE based congestion management")
Fixes: 34a90f86657c ("sched: modify pipe functions for config flexibility")
Fixes: ce7c4fd7c2ac ("sched: add pipe config to subport level")
Cc: stable@dpdk.org
Cc: jasvinder.singh@intel.com

Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---
 lib/sched/rte_sched.c | 87 +++++++++++--------------------------------
 lib/sched/rte_sched.h | 14 ++++++-
 2 files changed, 33 insertions(+), 68 deletions(-)

diff --git a/lib/sched/rte_sched.c b/lib/sched/rte_sched.c
index daa31e8b99..f7df0886c4 100644
--- a/lib/sched/rte_sched.c
+++ b/lib/sched/rte_sched.c
@@ -1066,26 +1066,9 @@ rte_sched_port_free(struct rte_sched_port *port)
 	rte_free(port);
 }
 
-static void
-rte_sched_free_memory(struct rte_sched_port *port, uint32_t n_subports)
-{
-	uint32_t i;
-
-	for (i = 0; i < n_subports; i++) {
-		struct rte_sched_subport *subport = port->subports[i];
-
-		rte_sched_subport_free(port, subport);
-	}
-
-	rte_free(port->subport_profiles);
-	rte_free(port);
-}
-
 static int
-rte_sched_red_config(struct rte_sched_port *port,
-	struct rte_sched_subport *s,
-	struct rte_sched_subport_params *params,
-	uint32_t n_subports)
+rte_sched_red_config(struct rte_sched_subport *s,
+	struct rte_sched_subport_params *params)
 {
 	uint32_t i;
 
@@ -1105,8 +1088,6 @@ rte_sched_red_config(struct rte_sched_port *port,
 				params->cman_params->red_params[i][j].min_th,
 				params->cman_params->red_params[i][j].max_th,
 				params->cman_params->red_params[i][j].maxp_inv) != 0) {
-				rte_sched_free_memory(port, n_subports);
-
 				SCHED_LOG(NOTICE,
 				"%s: RED configuration init fails", __func__);
 				return -EINVAL;
@@ -1118,10 +1099,8 @@ rte_sched_red_config(struct rte_sched_port *port,
 }
 
 static int
-rte_sched_pie_config(struct rte_sched_port *port,
-	struct rte_sched_subport *s,
-	struct rte_sched_subport_params *params,
-	uint32_t n_subports)
+rte_sched_pie_config(struct rte_sched_subport *s,
+	struct rte_sched_subport_params *params)
 {
 	uint32_t i;
 
@@ -1137,8 +1116,6 @@ rte_sched_pie_config(struct rte_sched_port *port,
 			params->cman_params->pie_params[i].dp_update_interval,
 			params->cman_params->pie_params[i].max_burst,
 			params->cman_params->pie_params[i].tailq_th) != 0) {
-			rte_sched_free_memory(port, n_subports);
-
 			SCHED_LOG(NOTICE,
 			"%s: PIE configuration init fails", __func__);
 			return -EINVAL;
@@ -1149,16 +1126,14 @@ rte_sched_pie_config(struct rte_sched_port *port,
 }
 
 static int
-rte_sched_cman_config(struct rte_sched_port *port,
-	struct rte_sched_subport *s,
-	struct rte_sched_subport_params *params,
-	uint32_t n_subports)
+rte_sched_cman_config(struct rte_sched_subport *s,
+	struct rte_sched_subport_params *params)
 {
 	if (params->cman_params->cman_mode == RTE_SCHED_CMAN_RED)
-		return rte_sched_red_config(port, s, params, n_subports);
+		return rte_sched_red_config(s, params);
 
 	else if (params->cman_params->cman_mode == RTE_SCHED_CMAN_PIE)
-		return rte_sched_pie_config(port, s, params, n_subports);
+		return rte_sched_pie_config(s, params);
 
 	return -EINVAL;
 }
@@ -1197,12 +1172,10 @@ rte_sched_subport_config(struct rte_sched_port *port,
 	uint32_t subport_profile_id)
 {
 	struct rte_sched_subport *s = NULL;
-	uint32_t n_subports = subport_id;
 	struct rte_sched_subport_profile *profile;
 	uint32_t n_subport_pipe_queues, i;
 	uint32_t size0, size1, bmp_mem_size;
 	int status;
-	int ret;
 
 	/* Check user parameters */
 	if (port == NULL) {
@@ -1214,16 +1187,14 @@ rte_sched_subport_config(struct rte_sched_port *port,
 	if (subport_id >= port->n_subports_per_port) {
 		SCHED_LOG(ERR,
 			"%s: Incorrect value for subport id", __func__);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	if (subport_profile_id >= port->n_max_subport_profiles) {
 		SCHED_LOG(ERR, "%s: "
 			"Number of subport profile exceeds the max limit",
 			__func__);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/** Memory is allocated only on first invocation of the api for a
@@ -1239,8 +1210,7 @@ rte_sched_subport_config(struct rte_sched_port *port,
 			SCHED_LOG(NOTICE,
 				"%s: Port scheduler params check failed (%d)",
 				__func__, status);
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
 		/* Determine the amount of memory to allocate */
@@ -1254,12 +1224,9 @@ rte_sched_subport_config(struct rte_sched_port *port,
 		if (s == NULL) {
 			SCHED_LOG(ERR,
 				"%s: Memory allocation fails", __func__);
-			ret = -ENOMEM;
-			goto out;
+			return -ENOMEM;
 		}
 
-		n_subports++;
-
 		/* Port */
 		port->subports[subport_id] = s;
 
@@ -1282,10 +1249,12 @@ rte_sched_subport_config(struct rte_sched_port *port,
 
 		if (params->cman_params != NULL) {
 			s->cman_enabled = true;
-			status = rte_sched_cman_config(port, s, params, n_subports);
+			status = rte_sched_cman_config(s, params);
 			if (status) {
 				SCHED_LOG(NOTICE,
 					"%s: CMAN configuration fails", __func__);
+				port->subports[subport_id] = NULL;
+				rte_free(s);
 				return status;
 			}
 		} else {
@@ -1334,8 +1303,9 @@ rte_sched_subport_config(struct rte_sched_port *port,
 		if (s->bmp == NULL) {
 			SCHED_LOG(ERR,
 				"%s: Subport bitmap init error", __func__);
-			ret = -EINVAL;
-			goto out;
+			port->subports[subport_id] = NULL;
+			rte_free(s);
+			return -EINVAL;
 		}
 
 		for (i = 0; i < RTE_SCHED_PORT_N_GRINDERS; i++)
@@ -1376,11 +1346,6 @@ rte_sched_subport_config(struct rte_sched_port *port,
 	rte_sched_port_log_subport_profile(port, subport_profile_id);
 
 	return 0;
-
-out:
-	rte_sched_free_memory(port, n_subports);
-
-	return ret;
 }
 
 RTE_EXPORT_SYMBOL(rte_sched_pipe_config)
@@ -1394,9 +1359,7 @@ rte_sched_pipe_config(struct rte_sched_port *port,
 	struct rte_sched_subport_profile *sp;
 	struct rte_sched_pipe *p;
 	struct rte_sched_pipe_profile *params;
-	uint32_t n_subports = subport_id + 1;
 	uint32_t deactivate, profile, i;
-	int ret;
 
 	/* Check user parameters */
 	profile = (uint32_t) pipe_profile;
@@ -1411,23 +1374,20 @@ rte_sched_pipe_config(struct rte_sched_port *port,
 	if (subport_id >= port->n_subports_per_port) {
 		SCHED_LOG(ERR,
 			"%s: Incorrect value for parameter subport id", __func__);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	s = port->subports[subport_id];
 	if (pipe_id >= s->n_pipes_per_subport_enabled) {
 		SCHED_LOG(ERR,
 			"%s: Incorrect value for parameter pipe id", __func__);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	if (!deactivate && profile >= s->n_pipe_profiles) {
 		SCHED_LOG(ERR,
 			"%s: Incorrect value for parameter pipe profile", __func__);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	sp = port->subport_profiles + s->profile;
@@ -1501,11 +1461,6 @@ rte_sched_pipe_config(struct rte_sched_port *port,
 	}
 
 	return 0;
-
-out:
-	rte_sched_free_memory(port, n_subports);
-
-	return ret;
 }
 
 RTE_EXPORT_SYMBOL(rte_sched_subport_pipe_profile_add)
diff --git a/lib/sched/rte_sched.h b/lib/sched/rte_sched.h
index e98f43072d..b839392250 100644
--- a/lib/sched/rte_sched.h
+++ b/lib/sched/rte_sched.h
@@ -390,7 +390,12 @@ rte_sched_port_subport_profile_add(struct rte_sched_port *port,
  * @param subport_profile_id
  *   ID of subport bandwidth profile
  * @return
- *   0 upon success, error code otherwise
+ *   0 upon success, negative error code otherwise. On error, the port
+ *   scheduler instance stays valid and is released by
+ *   rte_sched_port_free() as usual. The subport whose configuration
+ *   failed stays unconfigured and the call can be repeated with
+ *   corrected parameters. The subports configured before the failed
+ *   call keep their configuration, statistics and queued packets.
  */
 int
 rte_sched_subport_config(struct rte_sched_port *port,
@@ -410,7 +415,12 @@ rte_sched_subport_config(struct rte_sched_port *port,
  * @param pipe_profile
  *   ID of subport-level pre-configured pipe profile
  * @return
- *   0 upon success, error code otherwise
+ *   0 upon success, negative error code otherwise. On error, the port
+ *   scheduler instance stays valid and is released by
+ *   rte_sched_port_free() as usual. The subport whose configuration
+ *   failed stays unconfigured and the call can be repeated with
+ *   corrected parameters. The subports configured before the failed
+ *   call keep their configuration, statistics and queued packets.
  */
 int
 rte_sched_pipe_config(struct rte_sched_port *port,
-- 
2.53.0

