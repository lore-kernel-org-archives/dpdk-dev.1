Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5B606A31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VydlJfXM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BFE740613;
	Thu, 29 Oct 2026 15:47:33 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTPS id D8B7340284
 for <dev@dpdk.org>; Thu, 29 Oct 2026 15:47:31 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2eb18f4da15so5083905ad.1
 for <dev@dpdk.org>; Thu, 29 Oct 2026 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793285250;
 x=1793890050; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nCo9kDtat3L0dT1R2Q51fPZqU4SdJ8eRWHd5yjUegE0=;
 b=VydlJfXMsAxYjOSMlBksDAiQAwaXLaF2aTBVp3skDx3L+v+FJ0hg1EGUKkynABUn97
 dGhtBPDn/LHUqlM5Ki3OKJmYK16cQEJDw83y48bJ2p+0VR6eB4RifBLTU5V9WUmxke5+
 Bi3wse4Nz7EPHmgvk8cOOakGQFK19wWNVyHhYAoLCJ4UXjlZKauA/t61uGIqfISQ72f2
 9fC6TH1oBisCU4MOsSlwK4PwhpMU9XCQCw8Ui3Au4Ypcs1zdNqFJd8buvnkp1esjWnjy
 zjJrqpSaHuhe1JZX+vmYcMunGQMso5R/yQJHJGNkYWb6TAZ+G12KiOPAOOQoxFx42wwe
 ivMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793285250; x=1793890050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nCo9kDtat3L0dT1R2Q51fPZqU4SdJ8eRWHd5yjUegE0=;
 b=FPrRPvOO3IKDfsYvK0VIpX8HaX5NdjQyE8f+XeFHaKPmpiqBZuxJLDRPSD+X/JhFlY
 cwMkAXcCGECsKDv3FMMUHtmbKftarWgSnOCakpd2/G2uxx3gkBOXd48smJlNzw41kLqo
 Hxf3XNHlKdsHAXLQEt7dZ2npdexa6BnaGuhMuh7YPN/VR6lcw0w0FXip6qecBBZx4uK4
 MQNteOVfqbtj0oGnDQgBUI8bEVf+84EpHrR4B0jqRD4kxwxTK5bv9hHO3jfFqraQ9qG2
 48cwHWKwzUBfBjVTFCHM3TpuovhzzTVVmianKaLSLhhq6+BVaQ9V2IfMHNhFpoQZRoq+
 A/Eg==
X-Gm-Message-State: AFq9FYINjwMaK/JMedLVjGFeUufcOI94NRqp9+EAFDJIZVfWvvJwLRzN
 3Nr2Wr3XmowAiTvuc2kEF7FBpEVcg7Ir5PVf343LUFhMHS3bmk2fiA01PDoACxL9gcpDovp0yw/
 yokH3MhY=
X-Gm-Gg: AYBFou11aOTkIB5omCnc+YzGo1qZgCdHjrIZXpMKDIzMREvGldHg0QsBdYXgZ3UCyrL
 cSwzJWg9z9AXzM3Eo4kWyBOj2sIgrLg5prbADwJNXOUfeoD5Jx0/6PRIaSU0lpWRUe4S03h20pb
 TTQizRNhMz3Qfb0fQiaUx+5AcZRQRi5EPP3S7uZ7lEKol2s6R9uem5OOiKTSQddDG34X8cxA1Ov
 SFYRoDv5cyVLNXJcRd80cHQQQdbkxgVzqaP0RCU0Agq8orr9NoBmjlLzq1dkUOt1JsULUwyyGwl
 lEDe/oIput5Aa8EUH3w90CAmW4FTTbjDvKk/XRsYnms3qvQPedO6UQRv9zRNQTAunDRb5fIbyPk
 sLWCbopgtSPG20qgWg7XWhkts+e6bPVWp9qlvVtsFhu3BfO3uklvRkw5tISABdxGbwBaVun638P
 USZZEZJpSAOiIneqDxtaL8ZdxkFyZqO7XYJEu6D6+bkt6F1qJeLV4Axn8Sv1EMDqjKHzo25T7VL
 zJRY0u0a5QYx1SUqfLGBdYhHPXj7Og6JE0ilBMzfKpA7HQkL0oY89NjuK04HLQhPKBnTB687TfU
 xq03hzIFcaEHqAYdsNXbMxNQMcFpbpmA36DrQXy3/GV2Tru+Cs1/3hUdgvx3Vue8oItqxVk4rDq
 /Uyi16RCb7wddAw==
X-Received: by 2002:a17:902:ecc1:b0:2e9:814c:dccb with SMTP id
 d9443c01a7336-2eb005715aamr55430825ad.69.1793285250017; 
 Thu, 29 Oct 2026 07:47:30 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae64564b5sm36281645ad.5.2026.10.29.07.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 07:47:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Yu Jiang <yux.jiang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] examples/vhost: fix hang on exit
Date: Thu, 29 Oct 2026 07:47:27 -0700
Message-ID: <20261029144727.119072-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Unregister the drivers while the workers are still polling, then
stop and join them.

Bugzilla ID: 2071
Fixes: 5ffa8fafcbd3 ("examples/vhost: make signal handler safe")
Cc: stable@dpdk.org

Reported-by: Yu Jiang <yux.jiang@intel.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vhost/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/examples/vhost/main.c b/examples/vhost/main.c
index 523195f5c4..16c9387f8f 100644
--- a/examples/vhost/main.c
+++ b/examples/vhost/main.c
@@ -69,6 +69,8 @@ static uint32_t enabled_port_mask = 0;
 /* Set by the SIGINT handler to stop the worker loops. */
 static volatile sig_atomic_t quit;
 
+static RTE_ATOMIC(bool) stop_workers;
+
 /* Promiscuous mode */
 static uint32_t promiscuous;
 
@@ -1242,7 +1244,7 @@ switch_worker(void *arg)
 		}
 	}
 
-	while (!quit) {
+	while (!rte_atomic_load_explicit(&stop_workers, rte_memory_order_relaxed)) {
 		drain_mbuf_table(tx_q);
 		drain_vhost_table();
 		/*
-- 
2.53.0

