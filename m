Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E46CAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 06:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 459C4402D0;
	Thu, 18 Sep 2025 08:47:17 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id E1A964027A
 for <dev@dpdk.org>; Thu, 18 Sep 2025 08:47:15 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b54c86f3fdfso1241695a12.1
 for <dev@dpdk.org>; Wed, 17 Sep 2025 23:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1758178035;
 x=1758782835; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBq3D06fH/ss0LaDqYrRau+6RjWHX7xTFGCfMNMavoc=;
 b=bxSYoSiMKLcsoYFp+sq7HD68LpTrBUB5GhuW7j5MB4RTezN6jYxCxZ16egx4A7Fdb1
 s04Lt8qB+RJwN/cxBTiU+oTklP/gUv729saZoC4KjxRkyB7mRA6HDa1BGeN3Mot0Emsz
 rEwvkVDsGXuQ6V2U8FJNayPEH7/EO7JmImLWtcPQd74NtBoIRkb60G68Ew4mE+7mWOPT
 nOgVgYGpRKyo4jLZx088cHoTB/+fJCuzpdP4MBPbedxT5ojY4+sG3utzlQUahtthXwtp
 8Za2OXCLxp9YCu4TxnGqe5XjvkxI9vyg9//TaytKPljIN7YebZlKyANnilESocBu7OoP
 27ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758178035; x=1758782835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBq3D06fH/ss0LaDqYrRau+6RjWHX7xTFGCfMNMavoc=;
 b=Uwv6AL6GU/9SV5fxwfJBAE4JfH8fHOOo7ATBFQhbjTl/tqg3Al7fHNNWnZ/9tZxNB0
 XKyFwd+1JNbdYGrpzpsP4678htu00vNwyONtOORMQXTQyepDWXEAmfQOpLzdVlpx6hkk
 mtKV98rk0TIuyW9Pj/yGaQ/LHnigKl5nPANkt35Kocvx1BZ7VseS5s7daKij3MC1Bx33
 hz2XMPsGDISMRdqEjdz3r5Oyme6HWhzFJz4qMsuFxjmK0zXRInRButKgzWv9beby71aw
 MrALoooAKhAfIeju8gy2sWgH+dZJyLpxGRKuryvS5akx4xZxOagZh7MNdHKjKLIM/HxL
 Gf0g==
X-Gm-Message-State: AOJu0YwF5eFQXGqEDBaNXH7/Ho7XWTr/NqiVJ8rMY1DYocsG64DrhUlR
 VWHzPrHqn3Kn0ZARuvsAOQdpaCOa2j8P7Z3+MLAoYQG28R6dyQucorjcrI/pxRzDYjA=
X-Gm-Gg: ASbGncsc4jXkIN9ePv/lVYiTQM60KwiEcpIk0jgodq9nPyF0rJ1K+44G4lC9+DZN/5e
 XVGz093NvPRndQIy6Fdv8u1PhDMc6hecNX5y/K/wkNl1XIy8oSVDHzMKZJJC3Ioa+4YRAjiYnPu
 YUnDkZCn7sgPuU3Jb/FiXxAQRaeRPVUdiOlkYx3jleRefYWc9+DLq3+gIuP8FW2FP+ANr8+U+db
 UtKNGyAVm7SpxGBxU3ZEsQzHYTBWOjkNHx64QrhX3uRR0Vi/KO4rM6Dylr8LicDXb7WwuuE0YCx
 uPgGdTNyxnDmoaeTZtt5qOHnlWg6uO4v2DmzmXDdunndV87RdBBumwneiuNmtHBy5v5mValE08n
 1VO/3QxOQtR5VZnhjUiQR/2gvGSPWybRILbidlFmGNgQzQeZjeMSS0uuagbsQMlH3kXs6GLb0ve
 CpNu/XuEx677mq1HCavt2ttF+UJTiCBtLTihpY28hw1ZQ1tJx15JOpED1waJtkVL+hhX24RXHSt
 a2CU6NhrtiqGD8vSAzGMa0xYYU4Ifhnt0YkeO3t1AFcvwxE
X-Google-Smtp-Source: AGHT+IHpZd26fRw102QPBKfWefpSufgEPJsRshvQnuTug4AiCDnt7vjLlFkpAv2FBObqriFWdteH7Q==
X-Received: by 2002:a17:903:46cf:b0:267:9601:dca0 with SMTP id
 d9443c01a7336-2697ce85e7cmr25242935ad.27.1758178035006; 
 Wed, 17 Sep 2025 23:47:15 -0700 (PDT)
Received: from localhost.localdomain
 (108-92-19-205.lightspeed.sntcca.sbcglobal.net. [108.92.19.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26980053230sm15271235ad.30.2025.09.17.23.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 23:47:14 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Aman Singh <aman.deep.singh@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Lijun Ou <oulijun@huawei.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: dev@dpdk.org, Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5] app/testpmd: stop secondary process fwd_lcores during
 primary teardown
Date: Wed, 17 Sep 2025 23:47:03 -0700
Message-Id: <20250918064703.528973-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20250917113601.521308-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250917113601.521308-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

When the secondary process testpmd application running any fwd_engine
and after that primary has exited will cause a crash.

This patch forces secondary process forwarding lcores
in fwd_engine to stop before the primary process exits.

Fixes: a550baf24af90f ("app/testpmd: support multi-process")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/testpmd.c | 104 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 0f58a31eb5..6c97026962 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3609,6 +3609,83 @@ detach_devargs(char *identifier)
 	rte_devargs_reset(&da);
 }
 
+#ifndef RTE_EXEC_ENV_WINDOWS
+
+enum testpmd_req_type {
+	TESTPMD_REQ_TYPE_EXIT,
+};
+
+struct testpmd_mp_req {
+	enum testpmd_req_type t;
+};
+
+struct testpmd_mp_resp {
+	int result;
+};
+
+#define TESTPMD_MP	"mp_testpmd"
+
+/* Send reply to this peer when testpmd exits */
+static RTE_ATOMIC(const char *) primary_name;
+
+static void
+reply_to_primary(const char *peer, int result)
+{
+	struct rte_mp_msg reply = { };
+	struct testpmd_mp_resp *resp = (struct testpmd_mp_resp *) &reply.param;
+
+	strlcpy(reply.name, TESTPMD_MP, RTE_MP_MAX_NAME_LEN);
+	reply.len_param = sizeof(*resp);
+	resp->result = result;
+
+	printf("Replying %d to primary\n", result);
+	fflush(stdout);
+
+	if (rte_mp_reply(&reply, peer) < 0)
+		printf("Failed to send response to primary:%s", strerror(rte_errno));
+}
+
+/* Primary process is exiting, stop secondary process */
+static void
+pmd_notify_secondary(void)
+{
+	struct testpmd_mp_req request = {
+		.t = TESTPMD_REQ_TYPE_EXIT,
+	};
+	struct rte_mp_msg mp_req = {
+		.name = TESTPMD_MP,
+		.len_param = sizeof(request),
+	};
+	struct rte_mp_reply reply;
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+
+	printf("\nPrimary: Sending 'stop_req' request to secondary...\n");
+	fflush(stdout);
+
+	memcpy(mp_req.param, &request, sizeof(request));
+	rte_mp_request_sync(&mp_req, &reply, &ts);
+}
+
+static int
+handle_testpmd_request(const struct rte_mp_msg *request, const void *peer)
+{
+	const struct testpmd_mp_req *req = (const struct testpmd_mp_req *)request->param;
+
+	if (req->t == TESTPMD_REQ_TYPE_EXIT) {
+		printf("\nReceived notification of primary exiting\n");
+		fflush(stdout);
+
+		/* Response is sent after forwarding loop exits */
+		rte_atomic_store_explicit(&primary_name, peer, rte_memory_order_relaxed);
+
+		kill(getpid(), SIGINT);
+	} else {
+		reply_to_primary(peer, -EINVAL);
+	}
+	return 0;
+}
+#endif
+
 void
 pmd_test_exit(void)
 {
@@ -3620,6 +3697,10 @@ pmd_test_exit(void)
 		stop_packet_forwarding();
 
 #ifndef RTE_EXEC_ENV_WINDOWS
+	/* Tell secondary to exit */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		pmd_notify_secondary();
+
 	for (i = 0 ; i < RTE_DIM(mempools) ; i++) {
 		if (mempools[i]) {
 			if (mp_alloc_type == MP_ALLOC_ANON)
@@ -3628,6 +3709,7 @@ pmd_test_exit(void)
 		}
 	}
 #endif
+
 	if (ports != NULL) {
 		no_link_check = 1;
 		RTE_ETH_FOREACH_DEV(pt_id) {
@@ -4429,9 +4511,12 @@ main(int argc, char** argv)
 			 rte_strerror(rte_errno));
 
 #ifndef RTE_EXEC_ENV_WINDOWS
-	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
-	    enable_primary_monitor() < 0)
-		rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		if (enable_primary_monitor() < 0)
+			rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
+		if (rte_mp_action_register(TESTPMD_MP, handle_testpmd_request) < 0)
+			rte_exit(EXIT_FAILURE, "Failed to register message action\n");
+	}
 #endif
 
 	/* allocate port structures, and init them */
@@ -4628,12 +4713,23 @@ main(int argc, char** argv)
 	}
 
 #ifndef RTE_EXEC_ENV_WINDOWS
-	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		disable_primary_monitor();
+		rte_mp_action_unregister(TESTPMD_MP);
+	}
 #endif
 
 	pmd_test_exit();
 
+#ifndef RTE_EXEC_ENV_WINDOWS
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		const char *peer = rte_atomic_exchange_explicit(&primary_name, NULL,
+				rte_memory_order_relaxed);
+		if (peer)
+			reply_to_primary(peer, 0);
+	}
+#endif
+
 #ifdef RTE_LIB_PDUMP
 	/* uninitialize packet capture framework */
 	rte_pdump_uninit();
-- 
2.27.0

