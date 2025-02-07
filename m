Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4025DC02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:33:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76934427CD;
	Fri,  7 Feb 2025 09:33:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 43366427C0
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:33:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738917226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkmQ6ytYlhPphvZ88SaLAQNi9Dkj4O4QflVcyt4FkOE=;
 b=WFReGEtyKx3kPLfp03iKpjBb00OGedUPuUXgwXYqHw4H9e3Sl1TM8XLrGIU40rK19Z/0dj
 P18bdtBLJwf5rfpk7AqOjFDvAupVkoxI9/+fpx+ZCfN58xPj//qffe/ggDChfTN9bpsiSn
 JSgbfrka7MPDmnFW7evZlnDU5yb8sNM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-NzZvrbkmMRyex-aeW1bcYA-1; Fri,
 07 Feb 2025 03:33:43 -0500
X-MC-Unique: NzZvrbkmMRyex-aeW1bcYA-1
X-Mimecast-MFC-AGG-ID: NzZvrbkmMRyex-aeW1bcYA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 596ED1800874; Fri,  7 Feb 2025 08:33:42 +0000 (UTC)
Received: from dmarchan.com (unknown [10.45.224.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B69D51800871; Fri,  7 Feb 2025 08:33:40 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [RFC 09/10] app/compress-perf: remove weak symbols
Date: Fri,  7 Feb 2025 09:32:49 +0100
Message-ID: <20250207083252.3131588-10-david.marchand@redhat.com>
In-Reply-To: <20250207083252.3131588-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uyzHM4lWFnEvM8Vwj6dGemIO4cgHUxBqsfwxwE9sV5c_1738917222
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

