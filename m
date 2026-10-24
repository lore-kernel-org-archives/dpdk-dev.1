Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96629606A31B
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gj+MNXht
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA766402ED;
	Sat, 24 Oct 2026 15:21:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 884844060C
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NaMcw1Angmy/gxhXbItzEi6jPvWM8hCa6vG+st19HX4=;
 b=Gj+MNXhtAOlVx9I2vTrL56y6v+bgrcCp7fZA8ZGHy9nGDv84P9VO37Ut+dCIb1uWWfDZEa
 gApZY0gISiSRIr16CAI7k3o06rZ49iB2BbL79qTjOLL6OyrA92P54/gJQ39AbkDy5iKcG+
 e533dCP+klgcws0YxJY9Vm0V+7CDDaY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-Tj0c2PIzNjmcgIDU0kDp_w-1; Sat,
 24 Oct 2026 09:21:53 -0400
X-MC-Unique: Tj0c2PIzNjmcgIDU0kDp_w-1
X-Mimecast-MFC-AGG-ID: Tj0c2PIzNjmcgIDU0kDp_w_1792848112
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E38561800646; Sat, 24 Oct 2026 13:21:51 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37CFC1956087; Sat, 24 Oct 2026 13:21:50 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, anatoly.burakov@intel.com,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2 02/12] eal/linux: reset FD in interrupt handle for uevent
Date: Sat, 24 Oct 2026 15:21:27 +0200
Message-ID: <20261024132138.7239-3-david.marchand@redhat.com>
In-Reply-To: <20261024132138.7239-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2RWNhfZ3HCmAjNsegW2-C9CrqAXSKvR1Xf6OXOJfR9Q_1792848112
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

