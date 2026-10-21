Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517E6606A31D
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CldFsuW5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A804840687;
	Wed, 21 Oct 2026 11:23:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 69A014064C
 for <dev@dpdk.org>; Wed, 21 Oct 2026 11:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792574616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eetn5lu1vfeNN0SHTmYGF7KONiv5nDG+WPj4m52c68w=;
 b=CldFsuW5lO1HbOS9wyVDPRngSEQKx8CNmqAQdh2DpHU+S6qyuZ4nmU63rTQ/Bw5eP9XLFp
 vOuSD2rysRdImnzRmy8vOGTHMChqyy49qk7nitr49boSba2u5ccj44NGitBATywTjmr3sb
 agwBaqN3WnYyIDFFas7Wtq0JtfHjIW8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-FfyMHVYXM2itZEzP0jp50g-1; Wed,
 21 Oct 2026 05:23:31 -0400
X-MC-Unique: FfyMHVYXM2itZEzP0jp50g-1
X-Mimecast-MFC-AGG-ID: FfyMHVYXM2itZEzP0jp50g_1792574610
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54D7A180034C; Wed, 21 Oct 2026 09:23:30 +0000 (UTC)
Received: from dmarchan.home (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C75D41B; Wed, 21 Oct 2026 09:23:28 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	hkalra@marvell.com,
	stable@dpdk.org
Subject: [PATCH 1/9] eal/linux: fix FD leak in alarm subsystem
Date: Wed, 21 Oct 2026 11:23:10 +0200
Message-ID: <20261021092318.1554295-2-david.marchand@redhat.com>
In-Reply-To: <20261021092318.1554295-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zMIuUy3_dj9uOEl9AkQhfAUmJJgOQcvX3DloBqwB2bY_1792574610
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

