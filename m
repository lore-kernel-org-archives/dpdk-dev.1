Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C77606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wp2OOeFZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A2B040A67;
	Sat, 24 Oct 2026 15:22:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C0DB3402EF
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kR5cGj1/0Li+2++ccfEHAbMZE/y/RXqeS9Zi6IdfU0k=;
 b=Wp2OOeFZGo6g4NJlyJKwiugXOWUi76d44NfEgx6stFCtfRR4AwmZtx48+d9eXUqqZfPT05
 srAK2d6TrMkwct/aChyBzGhYuVdNfejaoXiHhcy9jhwSIB6wMtK8QPjmJBepincQ8iO0OK
 b2gBmWg5WW+h+1R0gYmkf4NyxssAAPs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-8ZgO3RgzMlSeP8acCaWjGA-1; Sat,
 24 Oct 2026 09:22:27 -0400
X-MC-Unique: 8ZgO3RgzMlSeP8acCaWjGA-1
X-Mimecast-MFC-AGG-ID: 8ZgO3RgzMlSeP8acCaWjGA_1792848146
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A84A91801347; Sat, 24 Oct 2026 13:22:26 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 274EF1800444; Sat, 24 Oct 2026 13:22:24 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, anatoly.burakov@intel.com,
 stable@dpdk.org, Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH v2 10/12] eal/linux: fix closing of event FDs not owned by EAL
Date: Sat, 24 Oct 2026 15:21:35 +0200
Message-ID: <20261024132138.7239-11-david.marchand@redhat.com>
In-Reply-To: <20261024132138.7239-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bc4o98-kebAEYAiTF1i_GaoF0eqp7wYY3jv5v-KB2QQ_1792848146
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

From: Anatoly Burakov <anatoly.burakov@intel.com>

rte_intr_efd_disable() decides whether to close the event FDs based on
max_intr being greater than nb_efd. This is a side effect of how
rte_intr_efd_enable() fills the handle for VFIO MSI-X, where an extra
slot is reserved for the misc interrupt, and only indirectly identifies
the eventfds that EAL created itself.

Any driver filling the event FD array for a VDEV or EXT handle and
setting max_intr the same way gets its descriptors closed by EAL even
though it owns them. The virtio-user driver does exactly this, so its
callfds are closed by rte_intr_efd_disable() and then closed again by
the driver on uninit.

Check the interrupt handle type instead, so that only the eventfds
created by rte_intr_efd_enable() for VFIO MSI-X are closed.

Fixes: b9e0662a931d ("eal/linux: add interrupt API for drivers")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_interrupts.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index dcc2c0efdb..fa658f5a3c 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1607,7 +1607,11 @@ rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 	uint32_t i;
 
 	rte_intr_free_epoll_fd(intr_handle);
-	if (rte_intr_max_intr_get(intr_handle) > rte_intr_nb_efd_get(intr_handle)) {
+	/* Only eventfds created by rte_intr_efd_enable() for MSI-X are owned
+	 * by the handle. In other modes the entries reference fds owned by
+	 * the device or the driver and must not be closed here.
+	 */
+	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX) {
 		for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
 			close(rte_intr_efds_index_get(intr_handle, i));
 	}
-- 
2.54.0

