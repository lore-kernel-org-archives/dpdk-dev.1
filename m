Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35641C0219B
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Feb 2025 17:29:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CCAA40A8A;
	Sun,  9 Feb 2025 18:29:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6EE3F40A8A
 for <dev@dpdk.org>; Sun,  9 Feb 2025 18:29:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739122183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkmQ6ytYlhPphvZ88SaLAQNi9Dkj4O4QflVcyt4FkOE=;
 b=iedpchO0rQnOaKKX36MrZAsg3FQTEyJa5OOahpxndk3lrL1E2uKCFApCRelb34BhoVbE5G
 5MVBffSMthPlrWV2uTi9nfudo+tY0OXQ9j68XdJBZh0z0v2V08I6TjVX16NDaDvIjMfiDf
 2V4YkpBKikfPHZWeDf9rJnYZioc1Fwc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-_wXFxDwrP6Oi1Bk-UsVYAg-1; Sun,
 09 Feb 2025 12:29:41 -0500
X-MC-Unique: _wXFxDwrP6Oi1Bk-UsVYAg-1
X-Mimecast-MFC-AGG-ID: _wXFxDwrP6Oi1Bk-UsVYAg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63ECE195608C; Sun,  9 Feb 2025 17:29:40 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAEC11800570; Sun,  9 Feb 2025 17:29:38 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com
Subject: [RFC v2 09/10] app/compress-perf: remove weak symbols
Date: Sun,  9 Feb 2025 18:28:47 +0100
Message-ID: <20250209172850.2429075-10-david.marchand@redhat.com>
In-Reply-To: <20250209172850.2429075-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
 <20250209172850.2429075-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rGcQfF0WcCxzMioepllak09t4sTQGDwcOvoIEb28sZg_1739122180
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

