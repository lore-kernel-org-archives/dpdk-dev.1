Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F881C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 13:53:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD1BC402EA;
	Wed, 11 Jun 2025 15:53:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 02CCD402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 15:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749649989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KN4vss10ZH7j3H+bd1Nq7+OWIcGdVlik7/w4D4ZOY2E=;
 b=EXx80nQksv+EmrqtM76lnC/0agEOL13AiXXkgFrPlZgZmTf4ZLWgKjWmvmEFrHhmN5eV1y
 DoXDukcWzw3nUuad8N2RPs/szHE5bCTQ8S9RY+cGvHiZOfkVcYfySP4RtEnm6DClNTLK3U
 B2Y1uNQLX284P9HaWCQxxtvKWYbNuhw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-Ie6Mni1KPj-Vqka-QkE_Ig-1; Wed,
 11 Jun 2025 09:53:07 -0400
X-MC-Unique: Ie6Mni1KPj-Vqka-QkE_Ig-1
X-Mimecast-MFC-AGG-ID: Ie6Mni1KPj-Vqka-QkE_Ig_1749649985
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 025F319560BA; Wed, 11 Jun 2025 13:53:05 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCC1C19560A3; Wed, 11 Jun 2025 13:53:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH] test/event: disable vector adapter test
Date: Wed, 11 Jun 2025 15:37:51 +0200
Message-ID: <20250611133751.1477562-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tHBEdhPGoM7tPH6ZwN_MyGaGkwxGb0GttmaAHN-zH48_1749649985
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

This test triggers random failures in the CI.
Disable it until we have a fix.

Bugzilla ID: 1720
Fixes: de09387f1313 ("eventdev/vector: add default software vector adapter")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 app/test/test_event_vector_adapter.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/app/test/test_event_vector_adapter.c b/app/test/test_event_vector_adapter.c
index 8c05853831..1441b0ff17 100644
--- a/app/test/test_event_vector_adapter.c
+++ b/app/test/test_event_vector_adapter.c
@@ -10,7 +10,7 @@
 #include "test.h"
 
 #ifdef RTE_EXEC_ENV_WINDOWS
-static int
+static int __rte_unused
 test_event_vector_adapter(void)
 {
 	printf("event_vector_adapter not supported on Windows, skipping test\n");
@@ -669,7 +669,7 @@ static struct unit_test_suite functional_testsuite = {
 	}
 };
 
-static int
+static int __rte_unused
 test_event_vector_adapter(void)
 {
 	return unit_test_suite_runner(&functional_testsuite);
@@ -677,4 +677,6 @@ test_event_vector_adapter(void)
 
 #endif
 
-REGISTER_FAST_TEST(event_vector_adapter_autotest, true, true, test_event_vector_adapter);
+/* disabled because of reported failures, waiting for a fix
+ * REGISTER_FAST_TEST(event_vector_adapter_autotest, true, true, test_event_vector_adapter);
+ */
-- 
2.49.0

