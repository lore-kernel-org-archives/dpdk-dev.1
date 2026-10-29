Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE928606A31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=togzOLch
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B466E4025A;
	Thu, 29 Oct 2026 17:57:34 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 9241340151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 17:57:33 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e5378b281aso13599215ad.2
 for <dev@dpdk.org>; Thu, 29 Oct 2026 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793293052;
 x=1793897852; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n6/lTTUz9/pAORcUSwjW/Qinm/nCZ1+B/EmUxbM8yJw=;
 b=togzOLchW026YOyiPSI8IOI07UYA5/tucxW2NjHQnKxgncxeYpIP7h6fLSI8chQQzh
 YZ02M5UUHKTVeCxEFrGiZvcZxeqX020Qn/hnIbtI+WoH1aUGYm4+59XNUOtWQPM33NJr
 spXEOcfiH/oPmCewlTybpAiopwR5nUvgak//tfqFgcaubdUbh+lchh8FfnFBEyFJ1ssl
 PjVnp72DOKWCEYHb27LxEzojzsLlccY8HjykNm3/FXA6H4xw+kuJ8SRy72Z4x0p32HR6
 zWJwN1TNaXIAZrdaD5d+9Llg3xwTtoEGLllAAh4V1aT+TLQ8OHPq5sJQkTvnIKRFLPku
 NRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293052; x=1793897852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n6/lTTUz9/pAORcUSwjW/Qinm/nCZ1+B/EmUxbM8yJw=;
 b=aRHPtmDSpRcu/rPklDPl/0ACl2Xkwd/4vubFF3XFV5UboUCW4DzXlyhdF872hM3xHA
 HK65Zz4boChdES2CSnnKCtzTv4G1s4yu+HI5CAvrJ6GsgIQJDI/St9odX4cU1pUkSiBs
 +MR111O4kjbycztj/YuvlJva170VwQyohq67YNocKEb/qkWa3BLayU/oj7tel7pSXKaX
 k2tZt8F6zXIfFFsNM+GcvOd1zdnAXknTk6Gcor0k4Wxh6hwh6PpX647SyNSDbrdKAKoY
 mOYMntCCiFdSsK7ikHSkC9+PS3mfbLohKeDHD+etplqWwEWshtXJp8BcrwOMWu132gfz
 InjQ==
X-Gm-Message-State: AFq9FYL54Tt2iLbnzbh9PPi8UMITBv4tpG7LhBF9OfDDObKyDr+MzSPh
 /59/S3wPizZBM5yhkJqis3Z5eFPRt+8mahS64LDUkLeIOwm7SGGIgKSusPxmlPJ62Xe8cBojg6i
 krcKqZhw=
X-Gm-Gg: AYBFou2nUJDkbTbW9Ow6zDH3RItIbBZv+0nxSAiuiubL/zLUCX3sDhrEG91gZMQWdeh
 riSCha9k8togU1g7iYHYWSnmXwdtMLMJcpl4VynLG2+WJheEg1VG9jGBAVbz9d4iZn5A9DD8go1
 28iHCcNJwsbKybvlVSN4U6XQmy66Bs8MOea0SSP3yO8nR1daARewHo4YOtx3zBP24HddP33T7mf
 OqwMOcZe6RQJMl3dXnFrC4ZsYtKivfHJsRcXA52y+qo7fp04g8XqQXEUHspZM5+iokAJzgcPTv2
 c0THB/+dTEwSWIFemOTtAbdpkS4IhDD7dFKzBgKzYtuby1uNpymNpfackgH74zm5ruTxsuztDGu
 55813iHKkBKCxF7h7E0uec1RVXBBv6y82xC5BuoBH3FJiaFF6Ho3UlA/HhHaVpxjI6OHbueob4U
 eXs7KgXkZqjoZ+ep8MufZcz7RFSV2zeEdCcBAexyzSHw4HuW6QnXwY7qKf+7L1eVX9i6dPepuNi
 b+piwJLiHSLTtRobAWsqjEKgUZhSsWtSvltDq2U0lI7sk8U58SvVBz8IIIdhPgjbuYpMrERqf4H
 9EtWUP0RGWH2QrJodRJAExlEvcbKoueKmKLUiWWtQmUMElfnydIsNFRhbx5SEQENB185
X-Received: by 2002:a17:90b:57c5:b0:3ab:9f89:e1b3 with SMTP id
 98e67ed59e1d1-3ae580dded9mr4436395a91.40.1793293051888; 
 Thu, 29 Oct 2026 09:57:31 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e7d5b8csm5190648a91.1.2026.10.29.09.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:57:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Yu Jiang <yux.jiang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] examples/vhost: fix hang on exit
Date: Thu, 29 Oct 2026 09:57:29 -0700
Message-ID: <20261029165729.1081754-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029144727.119072-1-stephen@networkplumber.org>
References: <20261029144727.119072-1-stephen@networkplumber.org>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

destroy_device() waits for the worker lcore to ack device removal.
Since the signal handler rework, the workers exit before the vhost
drivers are unregistered, so the destroy callback spins forever.

Maing thread now blocks SIGINT and SIGTERM and uses sigwait
to wait for one of these signals. Then unregisters and tells
worker threads to stop.

Bugzilla ID: 2071
Fixes: 5ffa8fafcbd3 ("examples/vhost: make signal handler safe")
Cc: stable@dpdk.org

Reported-by: Yu Jiang <yux.jiang@intel.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vhost/main.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/examples/vhost/main.c b/examples/vhost/main.c
index 523195f5c4..e7434fd189 100644
--- a/examples/vhost/main.c
+++ b/examples/vhost/main.c
@@ -66,8 +66,7 @@ static int total_num_mbufs = NUM_MBUFS_DEFAULT;
 /* mask of enabled ports */
 static uint32_t enabled_port_mask = 0;
 
-/* Set by the SIGINT handler to stop the worker loops. */
-static volatile sig_atomic_t quit;
+static RTE_ATOMIC(bool) stop_workers;
 
 /* Promiscuous mode */
 static uint32_t promiscuous;
@@ -1242,7 +1241,7 @@ switch_worker(void *arg)
 		}
 	}
 
-	while (!quit) {
+	while (!rte_atomic_load_explicit(&stop_workers, rte_memory_order_relaxed)) {
 		drain_mbuf_table(tx_q);
 		drain_vhost_table();
 		/*
@@ -1494,12 +1493,6 @@ unregister_drivers(int socket_num)
 	}
 }
 
-static void
-sigint_handler(__rte_unused int signum)
-{
-	quit = 1;
-}
-
 /*
  * Main function, does initialisation and calls the per-lcore functions.
  */
@@ -1513,8 +1506,13 @@ main(int argc, char *argv[])
 	uint16_t portid;
 	rte_thread_t tid;
 	uint64_t flags = RTE_VHOST_USER_NET_COMPLIANT_OL_FLAGS;
+	sigset_t set;
+	int sig;
 
-	signal(SIGINT, sigint_handler);
+	sigemptyset(&set);
+	sigaddset(&set, SIGINT);
+	sigaddset(&set, SIGTERM);
+	pthread_sigmask(SIG_BLOCK, &set, NULL);
 
 	/* init EAL */
 	ret = rte_eal_init(argc, argv);
@@ -1654,12 +1652,17 @@ main(int argc, char *argv[])
 		}
 	}
 
-	RTE_LCORE_FOREACH_WORKER(lcore_id)
-		rte_eal_wait_lcore(lcore_id);
+	/* Wait until SIGINT or SIGTERM */
+	sigwait(&set, &sig);
+	pthread_sigmask(SIG_UNBLOCK, &set, NULL);
 
 	/* Unregister vhost driver. */
 	unregister_drivers(nb_sockets);
 
+	/* Tell worker threads to exit */
+	rte_atomic_store_explicit(&stop_workers, true, rte_memory_order_relaxed);
+	rte_eal_mp_wait_lcore();
+
 	/* clean up the EAL */
 	rte_eal_cleanup();
 
-- 
2.53.0

