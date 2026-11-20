Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2435E606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.a=rsa-sha256 header.s=mail202505 header.b=PEZ8mLXQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A749E40659;
	Fri, 20 Nov 2026 11:13:22 +0100 (CET)
Received: from mx15.kaspersky-labs.com (mx15.kaspersky-labs.com
 [46.165.235.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 8ABD140284;
 Fri, 20 Nov 2026 07:00:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
 s=mail202505; t=1795154459;
 bh=SeG0py77NGT6ukc2vV8cpLaqlhTJFToz+MITvSsxfbA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=PEZ8mLXQnTG86TlhZZLsyzlarhzMFxSxbJunllA2kn5beb6R/ApGrkD1Uzu/z3abc
 bUi5EKFMo6jnPJlFpLFmtWoyVKD3fd7jLuPzTxte/xkz3GZAqRwDmWWbRajY4LfaTH
 1h0leqlDIR0KKFY8SDHjMB9SuH89tzyVfZp9aKDQ9wzzpxVr2WUMeiViw2pcL90yBo
 vq9W2cbfN+sgP0+JTNbn2kZEp/svgXfwozhNxcheFuM/XmxOICtfuX3Eax4fPPCUbq
 twc7ovGGCRuvOTqs6cNKk39JG9+CbXflOzmme/13hh9jSMNa7lEQeE55SMBa3rkNUX
 EtF2/NUcvuJMQ==
Received: from relay15.kaspersky-labs.com (localhost [127.0.0.1])
 by relay15.kaspersky-labs.com (Postfix) with ESMTP id 27C89A837D;
 Fri, 20 Nov 2026 09:00:59 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "mail-hq2.kaspersky.com",
 Issuer "Kaspersky MailRelays CA G3" (verified OK))
 by mailhub15.kaspersky-labs.com (Postfix) with ESMTPS id 049D8A8367;
 Fri, 20 Nov 2026 09:00:59 +0300 (MSK)
Received: from chesnokov.avp.ru (10.16.105.7) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 09:00:58 +0300
From: <Alexander.Chesnokov@kaspersky.com>
To: <cristian.dumitrescu@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>,
 Alexander Chesnokov<Alexander.Chesnokov@kaspersky.com>
Subject: [PATCH 2/2] test/sched: check port rate byte clock limits
Date: Fri, 20 Nov 2026 09:00:44 +0300
Message-ID: <20261120060044.3252671-3-Alexander.Chesnokov@kaspersky.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120060044.3252671-1-Alexander.Chesnokov@kaspersky.com>
References: <20261120060044.3252671-1-Alexander.Chesnokov@kaspersky.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/20/2026 05:54:05
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 207674 [Nov 20 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.27
X-KSE-AntiSpam-Info: Envelope from: Alexander.Chesnokov@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 135 0.3.135
 58dcfca10e9e4d27990d8f7387f1467d65061802
X-KSE-AntiSpam-Info: {diag_burst_silent}
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2; kaspersky.com:5.0.1,7.1.1; chesnokov.avp.ru:5.0.1,7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_black_eng_exceptions_lk}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/20/2026 05:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/20/2026 3:47:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 3.1.0.9599,
 bases: 2026/11/20 03:41:00 #28939126
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52
X-Mailman-Approved-At: Fri, 20 Nov 2026 11:13:15 +0100
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

Add sched_autotest cases verifying that rte_sched_port_config()
rejects port rates whose byte clock value is zero or does not fit
in 32 bits, and accepts the boundary rate rte_get_tsc_hz() << 8,
at which the byte clock value is 1.

Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
---
 app/test/test_sched.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/app/test/test_sched.c b/app/test/test_sched.c
index 96b48f1897..ea5bdd4272 100644
--- a/app/test/test_sched.c
+++ b/app/test/test_sched.c
@@ -210,6 +210,22 @@ test_sched(void)
 
 	rte_sched_port_free(port);
 
+	/* Rate above the byte clock limit is rejected */
+	port_param.rate = UINT64_MAX;
+	port = rte_sched_port_config(&port_param);
+	TEST_ASSERT_NULL(port, "Port config accepted rate too high\n");
+
+	/* Rate below the byte clock limit is rejected */
+	port_param.rate = rte_get_tsc_hz() >> 24;
+	port = rte_sched_port_config(&port_param);
+	TEST_ASSERT_NULL(port, "Port config accepted rate too low\n");
+
+	/* Boundary rate is accepted */
+	port_param.rate = rte_get_tsc_hz() << 8;
+	port = rte_sched_port_config(&port_param);
+	TEST_ASSERT_NOT_NULL(port, "Port config rejected limit rate\n");
+	rte_sched_port_free(port);
+
 	return 0;
 }
 
-- 
2.43.0

