Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E86C79F9E
	for <dpdk-dev@archiver.kernel.org>; Sun,  6 Sep 2026 23:28:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A6D840A8B;
	Mon,  7 Sep 2026 01:28:11 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id B0C2040B92
 for <dev@dpdk.org>; Mon,  7 Sep 2026 01:28:09 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cc439aa0078so2343933a12.0
 for <dev@dpdk.org>; Sun, 06 Sep 2026 16:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788737289;
 x=1789342089; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JTSof6MVqrQSMor0jYEpRRZrHzV0YWV9wz5fZZb82l8=;
 b=RWBShPKgK+YNUnyFwguEtOjuGAQmgeuyNXXUV2ANBkgw6BC1P9MJNi5ieuOD6ESztx
 43txICUoTrWgMj0cUYyxiHJYJGtlWh1ZSqs4rpB8LSjEhEj/vuMrpXJdooD0KpcsytUf
 wAnjquOuTJkIjBDOM6KMw2Cc3Hlw2ko0dTrMTAZTSDzu5gvDFp7Srr6qFqMtejrxN52o
 d+IR4vQ97PWKh0bR9pz5GvaAYifAIIhARCIt4jb6AEtATIarU11OSNbWDA+Xi8moB7DD
 bf+9tYXu/Qm6H4X30svzCIY10GzKqeIObjzqfABz1w9R39pzAsxqwnC0k0G5e3ySUg+m
 xiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788737289; x=1789342089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JTSof6MVqrQSMor0jYEpRRZrHzV0YWV9wz5fZZb82l8=;
 b=mLmYMTVEF6Py4jp0tGYT86fjTOd0jMxuNkZN1EkaME+NcahPWT6grSQOdMC5ZbHB5f
 4AnNNNXLPdZCLY4Q6kYMZ6ODdAMtEEaoMYoXg4U4N0Fb4iQphvmf5O4ASKrvRW4fJq1K
 G8+R3koTcGH9mXSg6at5pNu3QNvTyLr6dCMazQdIam+mvAwrxA7bqCN7ebIM6FHBCAqk
 RlMI7Xu0uxAzI0FY/uadCIpvAB2UWdWwoV71ta/hYSwm1dtSrvAWXy93HuCpuL/If5Mi
 A+zQBzHkaWQy2/CgPwKrcL0fSt1k12kSFCi4OnUJCnq1fneGB9m6nwbUjzC8VlMzbKs8
 AqbQ==
X-Gm-Message-State: AFuF++kdMOGg+h2ROiNlJtv5gQvjEoGyTai8oHq8uCdCjxpuKlwgNVqh
 z3PTzsfdr1GO+jz6Uwzp7LnFRH4m5RuF6m/tmQ7HDHOm559EiwS2iiuhKYd03zi7Sj8Uxg2Hp34
 tb19k
X-Gm-Gg: AYBFou1a/od1Uzc3ibTipha5ToVBabijkIhTSxH5IGu8BMgW29bb9vQQ0gqZhGnw6oo
 sclZjOiDKavFKVn7FikpNZhHGZuer29vZOBLholqX8JvG7Fc6Wf0hiHuuT7EuozZKfhNBpgryZQ
 Ij+l4CsdfaXcn/dC65zuM3xOGFEmafIbRkPD47GUUqbxSrGclTll+s9tGqz3wDY8MS4dR+oaR9s
 tv87nVg48pPmrNVGgl8SrJiRiwa8JzErNmjoEj3VzLzZa6qvHWXqLFm20DS8RX5c0MFDP3fkLcb
 H1N1hTjEM0Gk0+Wq/a7Za9L0WdLgFa13fehUFpwzTI9Dp9Hk1iCj1XCq9Oc/7eUkLqccGunvyyM
 8T38PBDvHgJckud/BAmsHPK0JcJLcJkx5TDs/+OD4sugWqvGhS1NaOpThkc0XqjaDoXdlR13mg9
 IQ4zWC3wRcLKWFCepYMMs6JvCONk4/GbBY5iSVk6ufkztklenO4XNMht59IwhpQhZqhVgPENVM3
 455RJK8crzOX9NaNVKVFDTj7N4=
X-Received: by 2002:a17:90b:4c06:b0:396:b98b:a3c2 with SMTP id
 98e67ed59e1d1-39b26116d9fmr25391259a91.8.1788737288775; 
 Sun, 06 Sep 2026 16:28:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b3312f9a8sm14491741a91.2.2026.09.06.16.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 16:28:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 13/13] examples/eventdev_pipeline: make signal handler safe
Date: Sun,  6 Sep 2026 16:24:48 -0700
Message-ID: <20260906232716.496546-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906232716.496546-1-stephen@networkplumber.org>
References: <20260906232716.496546-1-stephen@networkplumber.org>
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

The handler called rte_exit(), rte_event_dev_dump() and (before the
previous patch) printf(), none of which are async-signal-safe.
rte_exit() in particular runs rte_eal_cleanup() and exit(), tearing
down the EAL from signal context while the worker lcores are still
running in it.

Set the done flag and let main() do the work:

- The second-signal path becomes _exit(), which is async-signal-safe.
  This keeps the "hit ^C twice to give up on a clean shutdown" escape
  hatch without running exit handlers from the handler.

- The --dump-dev dump on exit moves to main() after
  rte_eal_mp_wait_lcore(), where it also gets the real dev_id instead
  of the hardcoded 0.

- SIGTSTP sets cdata.dump_dev_signal, which schedule_devices() already
  checks and drains on the scheduler lcore. That mechanism was present
  but nothing ever set the flag. Note this makes the SIGTSTP dump
  depend on a scheduler lcore being configured; there is no dump in
  configurations without one.

dump_dev_signal is now written from signal context, so make it
volatile sig_atomic_t.

Unlike the rest of this series this one is not reported by
-fanalyzer: the handler is registered in main() after rte_eal_init(),
and the analyzer does not connect the registration to the handler
body there. Found by inspection while auditing the neighbours.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/eventdev_pipeline/main.c            | 16 +++++++---------
 examples/eventdev_pipeline/pipeline_common.h |  3 ++-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/examples/eventdev_pipeline/main.c b/examples/eventdev_pipeline/main.c
index 65e0cd437c..80197b7c21 100644
--- a/examples/eventdev_pipeline/main.c
+++ b/examples/eventdev_pipeline/main.c
@@ -314,18 +314,13 @@ do_capability_setup(uint8_t eventdev_id)
 static void
 signal_handler(int signum)
 {
-	static uint8_t once;
-
-	if (fdata->done)
-		rte_exit(1, "Exiting on signal %d\n", signum);
-	if ((signum == SIGINT || signum == SIGTERM) && !once) {
-		if (cdata.dump_dev)
-			rte_event_dev_dump(0, stdout);
-		once = 1;
+	if (signum == SIGINT || signum == SIGTERM) {
+		if (fdata->done)
+			_exit(1);
 		fdata->done = 1;
 	}
 	if (signum == SIGTSTP)
-		rte_event_dev_dump(0, stdout);
+		cdata.dump_dev_signal = 1;
 }
 
 static inline uint64_t
@@ -452,6 +447,9 @@ main(int argc, char **argv)
 
 	rte_eal_mp_wait_lcore();
 
+	if (cdata.dump_dev)
+		rte_event_dev_dump(dev_id, stdout);
+
 	if (!cdata.quiet && (port_stat(dev_id, worker_data[0].port_id) !=
 			(uint64_t)-ENOTSUP)) {
 		printf("\nPort Workload distribution:\n");
diff --git a/examples/eventdev_pipeline/pipeline_common.h b/examples/eventdev_pipeline/pipeline_common.h
index 7b8eb50240..131617cd5b 100644
--- a/examples/eventdev_pipeline/pipeline_common.h
+++ b/examples/eventdev_pipeline/pipeline_common.h
@@ -3,6 +3,7 @@
  * Copyright 2017 Cavium, Inc.
  */
 
+#include <signal.h>
 #include <stdbool.h>
 
 #include <rte_eal.h>
@@ -68,7 +69,7 @@ struct config_data {
 	int enable_queue_priorities;
 	int quiet;
 	int dump_dev;
-	int dump_dev_signal;
+	volatile sig_atomic_t dump_dev_signal;
 	int all_type_queues;
 	unsigned int num_stages;
 	unsigned int worker_cq_depth;
-- 
2.53.0

