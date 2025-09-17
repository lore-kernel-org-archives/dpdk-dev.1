Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E52FCAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 20:54:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0294E402D0;
	Wed, 17 Sep 2025 22:54:58 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 2913A402C3
 for <dev@dpdk.org>; Wed, 17 Sep 2025 22:54:57 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4b61161c35cso3402421cf.3
 for <dev@dpdk.org>; Wed, 17 Sep 2025 13:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758142496;
 x=1758747296; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iirk0N2VocSfqZl83C6lz37T1DkmwIpoCRHEyes5dIc=;
 b=TFSzQiXVZOic/xwR/dwm3bFrNsBdHSFnwq1hjppRkR3ZF6YjqtBSeQedFhCUIk1juf
 i/5s1ped4mvszsaakHDi1LD0ohi42Eq00EqB1QLW+DcmIVGlqUflWMQsZbQip9o56JB8
 2jp/36p1dfqJIgr4FNlXNcNLeEKABf9e49/hTZ1HkZUBC6+i2wgr8hXxcSUtFeRVRimB
 cUFthbCH+F4salLRxqxjtcDPmk8a4atnVZ/QXtmkw6BDsnZ9qYpZ677bxfLBzjwjArzX
 NGH2BvR5CRae3VjbLnNWAJT3ke16vQ5kfca6iilrDZVXxlnF2MXaHRFpFbJFI/vVMVn+
 bqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758142496; x=1758747296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iirk0N2VocSfqZl83C6lz37T1DkmwIpoCRHEyes5dIc=;
 b=vfb1PPDZkL6UNMwYsL/LEs4v42E4DDn+T+WBS5aQTcfFIdYfdNPsrZmTfF8ej3Z+sw
 PuqzFZw8eAj0T+LW6x01WoiWHS1sxVm70+COhDyq5kbTTDkXg4VMDREeqKxM4XvDjVjo
 Q44KpWLNlRF9pqpInGHb/CLmRt628yvMQe5g8o8eyVXSYfsrri6e8fNjuTgiXi+Z/zBN
 Us1x3BUln1q1UX1ovqc3J0ZsF7vXL/yqWe1noh/XxvcloAPSTOg63sDCFpKOQXgXMSvg
 NmQaXYKTpqk1RjkeGEw1+l5lF0svBWAj6at4Z+1mBwQB5mi9hiOFdjOLlXWco7fnZrrd
 g6FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUreOtBuac68UsnT40BCxsx8Lf405u4e3JbUoQNRCQ/QZGEIAkh66S4jgHhDdFOB9lxIw=@dpdk.org
X-Gm-Message-State: AOJu0Yx3pndqctYPr0Qwt3BOirbucMnwv6CnYNWQ1Uz+EiraK6cN3NAZ
 c6pZWdbiV4GMcVsFBJ6OXhV1xpus+NqdoqpjR7DIt8y7ZW7gX7wIMOqQSacUNVWUo4M=
X-Gm-Gg: ASbGncuipI7SU1a8uJRM1JCs2yG0G0ywmTNPuPYGnK0mCykHXPftKlZpAzK/sxAUEHE
 NrzNC/7rnBc9knbWlINWjbo3nMsG0ad/sEG+Jm4U6qwFTiLdqfbBhkGBfhrEqCnjM7se6s0bRzL
 TFBm2LcXgB34so+ZcpZE1+yUXP99x7Mv0RMeyvGee9pJPokg+5/uD7GQTun7SWZr/8eAN0Pko8Z
 71zPnTpTqJTekprMBuf+rPxxzSS9B14ukYNlJbDQjQb3OuSkDUGfXD//BDOjOZyPeynQOqBEyeQ
 NfrY6SyS4rbJLju2uqdiev55pPDvtsBL8Oab+agR0SmdE1MSUYSBCDV535gbB9Wyt1ZKfvEvKQo
 BnWOYhc94SAAAhQT52Cif2JUj7LN2BfxEgtnuUDru3Ei3fmvKjwINSgkg2VdWDwhMzAKJbpuhlx
 vwsPVMdm7QFOGF3zKn/Q==
X-Google-Smtp-Source: AGHT+IFsOYEZ5qcONAhEAx3WLfEY5ubmBdMoLycoVwg5Y/iQqmysyfiMfRrnr1pYuX2OrBju/EPJ5Q==
X-Received: by 2002:a05:6214:ac8:b0:720:e5a:fe3b with SMTP id
 6a1803df08f44-78ecef1e391mr41518216d6.58.1758142496286; 
 Wed, 17 Sep 2025 13:54:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-79355ce6b34sm1760116d6.67.2025.09.17.13.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 13:54:56 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:54:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Cc: Aman Singh <aman.deep.singh@intel.com>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, "Min Hu (Connor)" <humin29@huawei.com>, Ferruh
 Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Xiaoyun Li <xiaoyun.li@intel.com>, Lijun
 Ou <oulijun@huawei.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v4] app/testpmd: stop secondary process fwd_lcores
 during primary teardown
Message-ID: <20250917135450.03f12cae@hermes.local>
In-Reply-To: <20250917113601.521308-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250915112513.496136-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250917113601.521308-1-14pwcse1224@uetpeshawar.edu.pk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 17 Sep 2025 04:36:01 -0700
Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk> wrote:

> When the secondary process testpmd application running any fwd_engine
> and after that primary has exited will cause a crash.
> 
> This patch forces secondary process forwarding lcores
> in fwd_engine to stop before the primary process exits.
> 
> Fixes: a550baf24af90f ("app/testpmd: support multi-process")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

There are still several issue left:
- using hotplug mp structs
- sending reply before fully exited.

Try this. It worked for simple quit and killing primary testpmd
with an ILL signal.



diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 0f58a31eb5..4c949adeda 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -46,6 +46,7 @@
 #include <rte_ether.h>
 #include <rte_ethdev.h>
 #include <rte_dev.h>
+#include <rte_stdatomic.h>
 #include <rte_string_fns.h>
 #include <rte_pci.h>
 #ifdef RTE_NET_IXGBE
@@ -3609,6 +3610,83 @@ detach_devargs(char *identifier)
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
+		.len_param = sizeof(&request),
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
@@ -3620,6 +3698,10 @@ pmd_test_exit(void)
 		stop_packet_forwarding();
 
 #ifndef RTE_EXEC_ENV_WINDOWS
+	/* Tell secondary to exit */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		pmd_notify_secondary();
+
 	for (i = 0 ; i < RTE_DIM(mempools) ; i++) {
 		if (mempools[i]) {
 			if (mp_alloc_type == MP_ALLOC_ANON)
@@ -3628,6 +3710,7 @@ pmd_test_exit(void)
 		}
 	}
 #endif
+
 	if (ports != NULL) {
 		no_link_check = 1;
 		RTE_ETH_FOREACH_DEV(pt_id) {
@@ -4429,9 +4512,12 @@ main(int argc, char** argv)
 			 rte_strerror(rte_errno));
 
 #ifndef RTE_EXEC_ENV_WINDOWS
-	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
-	    enable_primary_monitor() < 0)
-		rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		if (enable_primary_monitor() < 0)
+			rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
+		if (rte_mp_action_register(TESTPMD_MP, handle_testpmd_request) < 0)
+		    rte_exit(EXIT_FAILURE, "Failed to register message action\n");
+	}
 #endif
 
 	/* allocate port structures, and init them */
@@ -4628,12 +4714,23 @@ main(int argc, char** argv)
 	}
 
 #ifndef RTE_EXEC_ENV_WINDOWS
-	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		disable_primary_monitor();
+		rte_mp_action_unregister(TESTPMD_MP);
+	}
 #endif
-
 	pmd_test_exit();
 
+#ifndef RTE_EXEC_ENV_WINDOWS
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		const char *peer
+			= rte_atomic_exchange_explicit(&primary_name, NULL, rte_memory_order_relaxed);
+		if (peer)
+			reply_to_primary(peer, 0);
+	}
+#endif
+
+
 #ifdef RTE_LIB_PDUMP
 	/* uninitialize packet capture framework */
 	rte_pdump_uninit();
-- 
2.47.3

