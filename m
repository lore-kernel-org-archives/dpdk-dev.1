Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FBDC02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:38:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADB7C4068A;
	Tue, 18 Feb 2025 16:38:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C63614067C
 for <dev@dpdk.org>; Tue, 18 Feb 2025 16:38:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739893104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkmQ6ytYlhPphvZ88SaLAQNi9Dkj4O4QflVcyt4FkOE=;
 b=GXmmdkTi0KvqcS6ygEMVYoePfaWIWG/jSVDRNoXhS0cH7UUN0HhCniu/VdaazuyhofAzc2
 WyICFbf/afBqikg4Rtku4xwUP/MAZzxo1KKtiTNAl87Th8vRs0HlUHY5bPF/ZOIoK9dDdD
 4mM97neCvfdyHZtZ4OoGA+n4ID4I0NI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-jVTTcHpOMTOKIXSqQL0Xdg-1; Tue,
 18 Feb 2025 10:38:23 -0500
X-MC-Unique: jVTTcHpOMTOKIXSqQL0Xdg-1
X-Mimecast-MFC-AGG-ID: jVTTcHpOMTOKIXSqQL0Xdg_1739893102
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F30F51955F28; Tue, 18 Feb 2025 15:38:21 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.171])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E23D1800366; Tue, 18 Feb 2025 15:38:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [PATCH v3 09/10] app/compress-perf: remove weak symbols
Date: Tue, 18 Feb 2025 16:37:23 +0100
Message-ID: <20250218153730.773836-10-david.marchand@redhat.com>
In-Reply-To: <20250218153730.773836-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250218153730.773836-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9LeJlmgDzAX7NvUq4rVk2EEWYXuyiXD47AeNkMn3-2Q_1739893102
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

Remove dead code, those symbols are never used as the "strong" symbols
are always linked in.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test-compress-perf/main.c | 62 -----------------------------------
 1 file changed, 62 deletions(-)

diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c
index fa366123ed..70ce4316cc 100644
--- a/app/test-compress-perf/main.c
+++ b/app/test-compress-perf/main.c
@@ -521,65 +521,3 @@ main(int argc, char **argv)
 	}
 	return ret;
 }
-
-__rte_weak void *
-cperf_cyclecount_test_constructor(uint8_t dev_id __rte_unused,
-				 uint16_t qp_id __rte_unused,
-				 struct comp_test_data *options __rte_unused)
-{
-	RTE_LOG(INFO, USER1, "Cycle count test is not supported yet\n");
-	return NULL;
-}
-
-__rte_weak void
-cperf_cyclecount_test_destructor(void *arg __rte_unused)
-{
-	RTE_LOG(INFO, USER1, "Something wrong happened!!!\n");
-}
-
-__rte_weak int
-cperf_cyclecount_test_runner(void *test_ctx __rte_unused)
-{
-	return 0;
-}
-
-__rte_weak void *
-cperf_throughput_test_constructor(uint8_t dev_id __rte_unused,
-				 uint16_t qp_id __rte_unused,
-				 struct comp_test_data *options __rte_unused)
-{
-	RTE_LOG(INFO, USER1, "Benchmark test is not supported yet\n");
-	return NULL;
-}
-
-__rte_weak void
-cperf_throughput_test_destructor(void *arg __rte_unused)
-{
-
-}
-
-__rte_weak int
-cperf_throughput_test_runner(void *test_ctx __rte_unused)
-{
-	return 0;
-}
-__rte_weak void *
-cperf_verify_test_constructor(uint8_t dev_id __rte_unused,
-				 uint16_t qp_id __rte_unused,
-				 struct comp_test_data *options __rte_unused)
-{
-	RTE_LOG(INFO, USER1, "Verify test is not supported yet\n");
-	return NULL;
-}
-
-__rte_weak void
-cperf_verify_test_destructor(void *arg __rte_unused)
-{
-
-}
-
-__rte_weak int
-cperf_verify_test_runner(void *test_ctx __rte_unused)
-{
-	return 0;
-}
-- 
2.48.1

