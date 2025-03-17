Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B277C282EC
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Mar 2025 14:30:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16133402D1;
	Mon, 17 Mar 2025 15:30:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 719CB402BB
 for <dev@dpdk.org>; Mon, 17 Mar 2025 15:30:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742221824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EJcLDWsMYIkvG+V03KXZb2miZS7VVGDIBgIheB4Vdck=;
 b=A4mhTVAWlfdLP15BWUYaVHHzvtROMYLcJlx14NypBh+AMqtwBd1Mosc2LUcxVDABMw0phV
 cdjW8akYcz3l0elcWWjhdx4/Zj2c8SaO9yWxg4LUUqQpcPc/tDn2YrcZrcE05USYnSCMTJ
 8A5RtgM6DEecbnqqUCDl9ZcqaHbaQCQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-z0LbQM4TMkyv5Xu0_EEkZQ-1; Mon,
 17 Mar 2025 10:30:23 -0400
X-MC-Unique: z0LbQM4TMkyv5Xu0_EEkZQ-1
X-Mimecast-MFC-AGG-ID: z0LbQM4TMkyv5Xu0_EEkZQ_1742221822
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15E531800267; Mon, 17 Mar 2025 14:30:22 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.34.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BC6A3001D12; Mon, 17 Mar 2025 14:30:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH] test: fix race in per lcore test
Date: Mon, 17 Mar 2025 15:30:15 +0100
Message-ID: <20250317143015.2559854-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M4XCMy2UHVEU2dnIcDH4fe9HQcVYVAsaJtyXGdfgtJc_1742221822
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

In some CI, this unit test can fail, as the main thread may get
rescheduled while lcores execute the callback waiting 100ms.

Bugzilla ID: 1668
Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_per_lcore.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/app/test/test_per_lcore.c b/app/test/test_per_lcore.c
index 63c5c80c24..9c72f0fa21 100644
--- a/app/test/test_per_lcore.c
+++ b/app/test/test_per_lcore.c
@@ -59,17 +59,29 @@ display_vars(__rte_unused void *arg)
 }
 
 static int
-test_per_lcore_delay(__rte_unused void *arg)
+test_per_lcore_delay(void *arg)
 {
+	RTE_ATOMIC(bool) *wait;
+
 	rte_delay_ms(100);
 	printf("wait 100ms on lcore %u\n", rte_lcore_id());
 
+	if (arg == NULL)
+		return 0;
+
+	wait = arg;
+	while (rte_atomic_load_explicit(wait, rte_memory_order_relaxed)) {
+		rte_delay_ms(100);
+		printf("wait 100ms on lcore %u\n", rte_lcore_id());
+	}
+
 	return 0;
 }
 
 static int
 test_per_lcore(void)
 {
+	RTE_ATOMIC(bool) wait = true;
 	unsigned lcore_id;
 	int ret;
 
@@ -86,7 +98,7 @@ test_per_lcore(void)
 	}
 
 	/* test if it could do remote launch twice at the same time or not */
-	ret = rte_eal_mp_remote_launch(test_per_lcore_delay, NULL, SKIP_MAIN);
+	ret = rte_eal_mp_remote_launch(test_per_lcore_delay, &wait, SKIP_MAIN);
 	if (ret < 0) {
 		printf("It fails to do remote launch but it should able to do\n");
 		return -1;
@@ -97,6 +109,7 @@ test_per_lcore(void)
 		printf("It does remote launch successfully but it should not at this time\n");
 		return -1;
 	}
+	rte_atomic_store_explicit(&wait, false, rte_memory_order_relaxed);
 	RTE_LCORE_FOREACH_WORKER(lcore_id) {
 		if (rte_eal_wait_lcore(lcore_id) < 0)
 			return -1;
-- 
2.48.1

