Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0A606A322
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c6NAx3Xm
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08B1F40A7F;
	Wed, 21 Oct 2026 11:24:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C6B7E4068E
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:24:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792574644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hkCUq2L4VjLsFhyj0prprejAXJbQeZqEe1ON359Fsqg=;
 b=c6NAx3XmK9VdtuVllH1gHT1jyKgl+UkuW3xMcOMyWN6N3lP8QSNekB1ebeLXmyDTfcEAjX
 K/xHXR2oJ81aLhLE9DnLKyriwezdolWfrI3ujqZPDqvTe6O94VXTNo8nYF62R32891PLTz
 UNV6uQbxfxQgT/72LkX2cDiGmapnzx4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-rajF5uV7N4exr30XHRTNig-1; Wed,
 21 Oct 2026 09:24:00 +0000
X-MC-Unique: rajF5uV7N4exr30XHRTNig-1
X-Mimecast-MFC-AGG-ID: rajF5uV7N4exr30XHRTNig_1792574639
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B6B619560B4; Wed, 21 Oct 2026 09:23:59 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A4DC21800444; Wed, 21 Oct 2026 09:23:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com,
 Jie Liu <liujie5@linkdatatechnology.com>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH 8/9] net/sxe2: reset FD in interrupt handle
Date: Wed, 21 Oct 2026 11:23:17 +0200
Message-ID: <20261021092318.1554295-9-david.marchand@redhat.com>
In-Reply-To: <20261021092318.1554295-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OGVKlWtlqNk_5anaXTD0EVqJt2MlkM8pDK-OfVgYec0_1792574639
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

