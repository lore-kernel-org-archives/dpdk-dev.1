Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0014DC3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 19:22:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 453BE40659;
	Wed, 14 Oct 2026 21:22:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 43E34402EF
 for <dev@dpdk.org>; Wed, 14 Oct 2026 21:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792005730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQivOD/CvxIhVqYcLY0doDcJHPj4nmJMOv+J5T6HsCQ=;
 b=eRxk81AOPWLhWthYeD9dhlL2M1Jxa7Dwcg4qENZI4X58uJGWHab2gfCAINqMgpD92zK4ae
 wf2w30ntfdkUqIYoyJ83x6xSP4srr4uUVHqU1CwqeGalerrMMs87+8LHr5NlX1K83pJfGv
 iEguJ/Ax80zgoO8q7PWZKbw1Ad6GlVQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-WHRXpge7MDOL_Zk-_-4jlA-1; Wed,
 14 Oct 2026 19:22:09 +0000
X-MC-Unique: WHRXpge7MDOL_Zk-_-4jlA-1
X-Mimecast-MFC-AGG-ID: WHRXpge7MDOL_Zk-_-4jlA_1792005728
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BEA81800C3C
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:22:08 +0000 (UTC)
Received: from ringo.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAF5C1800480; Wed, 14 Oct 2026 19:22:07 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org
Subject: [PATCH dpdk 2/2] lib: remove stack from always enabled libraries
Date: Wed, 14 Oct 2026 21:21:55 +0200
Message-ID: <20261014192153.2693883-6-rjarry@redhat.com>
In-Reply-To: <20261014192153.2693883-4-rjarry@redhat.com>
References: <20261014192153.2693883-4-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sNW5UBpusMEFlIDvsLTjxUUJpS9uRE9MOwbRjb_dKp8_1792005728
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

rte_stack is only used by the associated mempool driver and the stack
tests which explicitly declare it as a dependency:

	$ git grep -l '#include <rte_stack.*\.h>'
	app/test/test_stack.c
	app/test/test_stack_perf.c
	drivers/mempool/stack/rte_mempool_stack.c

There is no reason to always build it.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 lib/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/meson.build b/lib/meson.build
index 72ac21b5fa86..458951054c55 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -84,7 +84,6 @@ always_enable = [
         'pci',
         'rcu',
         'ring',
-        'stack',
         'telemetry',
 ]
 
-- 
2.56.0

