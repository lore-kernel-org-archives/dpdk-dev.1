Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15687606A31B
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hpS9xaW1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4D98402B0;
	Sat, 24 Oct 2026 15:21:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0037A40269
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eetn5lu1vfeNN0SHTmYGF7KONiv5nDG+WPj4m52c68w=;
 b=hpS9xaW1CjLBIalhREUsH+IRWgIBfhGxJUEgtDnzIaXu2SNTWL6yy9h1hVCESBGHkv1Fo+
 CSc9UL2/PL3VLrR6KFpchWJcImO3gb1OCmVmhvI3OG9nlW3IPlGUu+Gie3PRJ3RAl0w8N8
 dSzh26hfGlhr/4ESxEDOW7LOuW27N7k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-54tFqBuFOlWzyE3RckpaXg-1; Sat,
 24 Oct 2026 09:21:49 -0400
X-MC-Unique: 54tFqBuFOlWzyE3RckpaXg-1
X-Mimecast-MFC-AGG-ID: 54tFqBuFOlWzyE3RckpaXg_1792848108
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5B5E1955F5A; Sat, 24 Oct 2026 13:21:47 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3709F300019F; Sat, 24 Oct 2026 13:21:45 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, anatoly.burakov@intel.com,
 stable@dpdk.org
Subject: [PATCH v2 01/12] eal/linux: fix FD leak in alarm subsystem
Date: Sat, 24 Oct 2026 15:21:26 +0200
Message-ID: <20261024132138.7239-2-david.marchand@redhat.com>
In-Reply-To: <20261024132138.7239-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _-mcuiK_GqHqlKRDG-uAtdae6nYQWVVBooMXQcA-zTM_1792848108
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

From: Stephen Hemminger <stephen@networkplumber.org>

The timerfd used for alarms is never closed on EAL cleanup.
FreeBSD was fixed to close it, do the same on Linux.

Fixes: 90b13ab8d4f7 ("alarm: remove direct access to interrupt handle")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_alarm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/eal/linux/eal_alarm.c b/lib/eal/linux/eal_alarm.c
index a1433eb867..5f8655ea11 100644
--- a/lib/eal/linux/eal_alarm.c
+++ b/lib/eal/linux/eal_alarm.c
@@ -61,6 +61,7 @@ rte_eal_alarm_cleanup(void)
 	int ret = rte_intr_callback_unregister_sync(intr_handle,
 						eal_alarm_callback, (void *)-1);
 	if (ret >= 0) {
+		rte_intr_fd_close(intr_handle);
 		rte_intr_instance_free(intr_handle);
 		intr_handle = NULL;
 		handler_registered = 0;
-- 
2.54.0

