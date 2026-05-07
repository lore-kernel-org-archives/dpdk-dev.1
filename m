Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48E5CD37AA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 21:02:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 158404060A;
	Thu,  7 May 2026 23:01:59 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 623C24025A
 for <dev@dpdk.org>; Thu,  7 May 2026 23:01:57 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1309f4ee973so1684088c88.1
 for <dev@dpdk.org>; Thu, 07 May 2026 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778187716;
 x=1778792516; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVyt7UEVPmjFaIAvwsSDphYo04ulEbvaeff65GGXmCc=;
 b=JBxI8DdINwjON1LwkPwT0TgVmS0di+dI0DRz0vYI6nYb7VtdW+sH1tKkI42mQ756xm
 Qde3R/RfrH5epL2wuk7cnWOAP2SQqnwbg23u2yZgwvik/chXRdNHabxmgI52gIcZhr7Q
 4byoaZyWsBRqWOf2FOVfBcyfLq3qH2v5uHMuAXF6fq5sPr7KRUmpN4F9pGQoC9cR3A8e
 AoPIOfE1njeSmcEkL0icXRXZat3oYqX+gZjDa8egIew3Gh5kQMW1FwqObK2XNxyQdSar
 Q6S1GY5fO+RZjDFjbBma0LAHvJndOGi4Unay2F/nPh/TWSocZ0S9O8oLAzBfbw8Fk+EI
 THSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778187716; x=1778792516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LVyt7UEVPmjFaIAvwsSDphYo04ulEbvaeff65GGXmCc=;
 b=XtS/FmLqVYPFT3bDS6ISJW53Xq2oE3gI4DVoqDsINXqUdUBDPLJx2S0jsxIVtsH18z
 28e23xDMSgOSBVkE2Z1DgOV1+xbyr3vGderYJD4w/k6huK42rb2jliFD7nmOY6XfZKy/
 67Rjrl3fNTtmsjYAb+zbE8dQ03bOVQMRw9s+la5MPkFILMzsJXygWAkodVUhfrE6GBw3
 ssH8iEcSVJCPF5Klauzg3ly5F6/akY1kfbS1UwT4XKjnmlC8PDgejjb38fnodBceXRaq
 kiqpEgJD2f5DB3irVXy5NJDmTUNZOELZ41n9J4D+RokB+r2qZsDy6muAGKnDF7y9zM23
 zWVw==
X-Gm-Message-State: AOJu0Yw9YUKFo0dInxdBrP/FqeC1rUmMsfFwy13BIJ2LfRhxm6G4dduf
 mRsnFR2cBHMvAvJIcDiCE7+zY1lm9BmEp/lbrCIcehk7HaKKRgF19QSRUb+skEy/CrlBB/JLKQK
 BUvvY
X-Gm-Gg: AeBDiesSFGLVHWB0CvVjQufhYbJ2m7/bVORVu/w20tYShPLHqiw3ZwB4yjDva7e+36V
 jNeKSRUt/F8ueYJ3LwydGqs5/ASwncpeaoQTgP08znr+fBSg6Zysd40t+aISlOX4QnBJWmI41ar
 8AQ6O9+RYEbbbhYM1rUVPX2GG2YFkxneIlAVUccwYd6EoE+nQswVl6iDxW54v958ZrxGIg9Qgpc
 9mZ7vs9uQFyTKAb86qqdt4hPI6glD4gxI/rr/eEaavIf22Ul4v7iQ3QdVDjYaU9sRVqcKuBezS4
 sNK00el15qtANXhL6IUIh8D0NZx2xN5X8BnsNVFThOOdKthvzC+38sWN2p7ovOE6oeGD0BUwRXJ
 xdvlxS4Gh0L2268ZMU9LGfZBeXgMSjszBXm1+dRNU6o/bpMOFmgdKdNtwggrTOoxz2ch1lwb2ra
 Z2zzQvlJ5ltM/DoIFNqmXWwaab0VAa8+mY
X-Received: by 2002:a05:7022:6998:b0:119:e56c:18a5 with SMTP id
 a92af1059eb24-131851d7b45mr4648387c88.13.1778187716327; 
 Thu, 07 May 2026 14:01:56 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13270901ba2sm227282c88.11.2026.05.07.14.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 14:01:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Aman Singh <aman.deep.singh@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 1/2] Revert "app/testpmd: stop forwarding in secondary process"
Date: Thu,  7 May 2026 13:58:36 -0700
Message-ID: <20260507210152.410419-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507210152.410419-1-stephen@networkplumber.org>
References: <20260507210152.410419-1-stephen@networkplumber.org>
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

Testpmd must not assume that the secondary process
is testpmd. The notification needs to be done by EAL.

This reverts commit f96273c8e9d39e472bb07acc05e493b1e712e51b.

Bugzilla ID: 1942
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/testpmd.c | 103 ++---------------------------------------
 1 file changed, 4 insertions(+), 99 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index e2569d9e30..e54a3981e9 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -3716,83 +3716,6 @@ detach_devargs(char *identifier)
 	rte_devargs_reset(&da);
 }
 
-#ifndef RTE_EXEC_ENV_WINDOWS
-
-enum testpmd_req_type {
-	TESTPMD_REQ_TYPE_EXIT,
-};
-
-struct testpmd_mp_req {
-	enum testpmd_req_type t;
-};
-
-struct testpmd_mp_resp {
-	int result;
-};
-
-#define TESTPMD_MP	"mp_testpmd"
-
-/* Send reply to this peer when testpmd exits */
-static RTE_ATOMIC(const char *) primary_name;
-
-static void
-reply_to_primary(const char *peer, int result)
-{
-	struct rte_mp_msg reply = { };
-	struct testpmd_mp_resp *resp = (struct testpmd_mp_resp *) &reply.param;
-
-	strlcpy(reply.name, TESTPMD_MP, RTE_MP_MAX_NAME_LEN);
-	reply.len_param = sizeof(*resp);
-	resp->result = result;
-
-	printf("Replying %d to primary\n", result);
-	fflush(stdout);
-
-	if (rte_mp_reply(&reply, peer) < 0)
-		printf("Failed to send response to primary:%s", strerror(rte_errno));
-}
-
-/* Primary process is exiting, stop secondary process */
-static void
-pmd_notify_secondary(void)
-{
-	struct testpmd_mp_req request = {
-		.t = TESTPMD_REQ_TYPE_EXIT,
-	};
-	struct rte_mp_msg mp_req = {
-		.name = TESTPMD_MP,
-		.len_param = sizeof(request),
-	};
-	struct rte_mp_reply reply;
-	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
-
-	printf("\nPrimary: Sending 'stop_req' request to secondary...\n");
-	fflush(stdout);
-
-	memcpy(mp_req.param, &request, sizeof(request));
-	rte_mp_request_sync(&mp_req, &reply, &ts);
-}
-
-static int
-handle_testpmd_request(const struct rte_mp_msg *request, const void *peer)
-{
-	const struct testpmd_mp_req *req = (const struct testpmd_mp_req *)request->param;
-
-	if (req->t == TESTPMD_REQ_TYPE_EXIT) {
-		printf("\nReceived notification of primary exiting\n");
-		fflush(stdout);
-
-		/* Response is sent after forwarding loop exits */
-		rte_atomic_store_explicit(&primary_name, peer, rte_memory_order_relaxed);
-
-		kill(getpid(), SIGINT);
-	} else {
-		reply_to_primary(peer, -EINVAL);
-	}
-	return 0;
-}
-#endif
-
 void
 pmd_test_exit(void)
 {
@@ -3804,10 +3727,6 @@ pmd_test_exit(void)
 		stop_packet_forwarding();
 
 #ifndef RTE_EXEC_ENV_WINDOWS
-	/* Tell secondary to exit */
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
-		pmd_notify_secondary();
-
 	for (i = 0 ; i < RTE_DIM(mempools) ; i++) {
 		if (mempools[i]) {
 			if (mp_alloc_type == MP_ALLOC_ANON)
@@ -4623,12 +4542,9 @@ main(int argc, char** argv)
 			 rte_strerror(rte_errno));
 
 #ifndef RTE_EXEC_ENV_WINDOWS
-	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
-		if (enable_primary_monitor() < 0)
-			rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
-		if (rte_mp_action_register(TESTPMD_MP, handle_testpmd_request) < 0)
-			rte_exit(EXIT_FAILURE, "Failed to register message action\n");
-	}
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+	    enable_primary_monitor() < 0)
+		rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
 #endif
 
 	/* allocate port structures, and init them */
@@ -4830,23 +4746,12 @@ main(int argc, char** argv)
 	}
 
 #ifndef RTE_EXEC_ENV_WINDOWS
-	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
 		disable_primary_monitor();
-		rte_mp_action_unregister(TESTPMD_MP);
-	}
 #endif
 
 	pmd_test_exit();
 
-#ifndef RTE_EXEC_ENV_WINDOWS
-	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
-		const char *peer = rte_atomic_exchange_explicit(&primary_name, NULL,
-				rte_memory_order_relaxed);
-		if (peer)
-			reply_to_primary(peer, 0);
-	}
-#endif
-
 #ifdef RTE_LIB_PDUMP
 	/* uninitialize packet capture framework */
 	rte_pdump_uninit();
-- 
2.53.0

