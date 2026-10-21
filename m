Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1069F606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VeHs7saj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA21A4069D;
	Wed, 21 Oct 2026 11:23:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 66B7240679
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:23:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792574619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NaMcw1Angmy/gxhXbItzEi6jPvWM8hCa6vG+st19HX4=;
 b=VeHs7sajOSk8xCoLWkZU3m7+9FX4s/SiQE9opIQ7C/l64jAb0nUER9NZJNTGwkgoK09ysI
 OuM1H2ISs7314QRCY1JDw2qOjLIfitgGjBQK6bN1YBK0TtHU+RqchsD01jC9/mB4lohRNR
 IWeqXVtINtzZ9baeNmKuFXN/WO2m3Wo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-t9Ip7GbpO42AwHqhhyL_oA-1; Wed,
 21 Oct 2026 05:23:35 -0400
X-MC-Unique: t9Ip7GbpO42AwHqhhyL_oA-1
X-Mimecast-MFC-AGG-ID: t9Ip7GbpO42AwHqhhyL_oA_1792574614
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E5A21955F39; Wed, 21 Oct 2026 09:23:34 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5A3A1800677; Wed, 21 Oct 2026 09:23:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH 2/9] eal/linux: reset FD in interrupt handle for uevent
Date: Wed, 21 Oct 2026 11:23:11 +0200
Message-ID: <20261021092318.1554295-3-david.marchand@redhat.com>
In-Reply-To: <20261021092318.1554295-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R9yoQyjt4ycxtf2pfLTGB0Ytumi4gG1Fj2nF16O_xNk_1792574614
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

Clear the warning when freeing the interrupt handle used for the uevent
handler.

Fixes: d770ee9caed0 ("interrupts: warn on leaked FDs")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index 35223b6b26..1c8ae1d60b 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -366,7 +366,7 @@ rte_dev_event_monitor_start(void)
 	ret = rte_intr_callback_register(intr_handle, dev_uev_handler, NULL);
 
 	if (ret) {
-		close(rte_intr_fd_get(intr_handle));
+		rte_intr_fd_close(intr_handle);
 		goto exit;
 	}
 
@@ -406,7 +406,7 @@ rte_dev_event_monitor_stop(void)
 		goto exit;
 	}
 
-	close(rte_intr_fd_get(intr_handle));
+	rte_intr_fd_close(intr_handle);
 	rte_intr_instance_free(intr_handle);
 	intr_handle = NULL;
 	ret = 0;
-- 
2.54.0

