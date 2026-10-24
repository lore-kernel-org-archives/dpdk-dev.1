Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBB0606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gRvukT2T
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEC3D40678;
	Sat, 24 Oct 2026 15:22:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C828F40663
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkCUq2L4VjLsFhyj0prprejAXJbQeZqEe1ON359Fsqg=;
 b=gRvukT2Txj97h0WNcC/TuYO69E/7Ljz92R/zHwmUJrfwqF2OUlTFt1tdiYNOUAVkZg7DEa
 EfX5JWZBWz2RHachN0G+lUOa4dWKPVtE6P8Ral07Fu5PlsKsLYllKJOJfZf43rRs7OogAB
 5bvo2Gh72tMyxySNCc53Z9TUdATcxns=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-b0NuKYrbNaeWJGSs2j76TA-1; Sat,
 24 Oct 2026 09:22:19 -0400
X-MC-Unique: b0NuKYrbNaeWJGSs2j76TA-1
X-Mimecast-MFC-AGG-ID: b0NuKYrbNaeWJGSs2j76TA_1792848138
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75F7F193FA91; Sat, 24 Oct 2026 13:22:18 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F6471956087; Sat, 24 Oct 2026 13:22:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, anatoly.burakov@intel.com,
 Jie Liu <liujie5@linkdatatechnology.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2 08/12] net/sxe2: reset FD in interrupt handle
Date: Sat, 24 Oct 2026 15:21:33 +0200
Message-ID: <20261024132138.7239-9-david.marchand@redhat.com>
In-Reply-To: <20261024132138.7239-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 05DWNMppGcATeqA6AMaq1HKv6td8nEEzz_WhBy7ijNc_1792848138
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The fd passed to sxe2_intr_handler_create() is not owned by this
function. Clear the FD reference before freeing the interrupt handle
on error to avoid a spurious leak warning.

Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/net/sxe2/sxe2_irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_irq.c b/drivers/net/sxe2/sxe2_irq.c
index 256949e74e..0a16c263c1 100644
--- a/drivers/net/sxe2/sxe2_irq.c
+++ b/drivers/net/sxe2/sxe2_irq.c
@@ -387,6 +387,8 @@ sxe2_intr_handler_create(int32_t fd, rte_intr_callback_fn cb, void *cb_arg)
 
 	return tmp_intr_handle;
 err:
+	/* fd is not owned by this function, only clear reference here. */
+	rte_intr_fd_set(tmp_intr_handle, -1);
 	rte_intr_instance_free(tmp_intr_handle);
 	return NULL;
 }
-- 
2.54.0

