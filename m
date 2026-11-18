Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6E606A32A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 15:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H9Vu/2lf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A3964029D;
	Wed, 18 Nov 2026 16:30:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 07CD440298
 for <dev@dpdk.org>; Wed, 18 Nov 2026 16:30:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795015806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gwNYtO979rokiHtnVwMzio+QH33ULEHDbI1soJmiCBI=;
 b=H9Vu/2lf5f/m7/eQkeHNPGGlW2uYsAnS2GRIAxISM4JVXibJWAd0yo3V+p1nTh3NFt+8Ga
 IJcOwlRA/YIuEwJGl3fXJV+SFQeiTVDCNn+RVHDfIxafPVXgza/eNOPNiwt31NTcGSchmL
 osMX3ToBAl2kCz7VruTgCGAwCnzfSD0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-evQd3x4HOkyRj8KHrdf-Bw-1; Wed,
 18 Nov 2026 10:30:01 -0500
X-MC-Unique: evQd3x4HOkyRj8KHrdf-Bw-1
X-Mimecast-MFC-AGG-ID: evQd3x4HOkyRj8KHrdf-Bw_1795015800
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A73D1800366; Wed, 18 Nov 2026 15:30:00 +0000 (UTC)
Received: from dmarchan-thinkpadx1carbongen13.rmtfr.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2ED0C589; Wed, 18 Nov 2026 15:29:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: iboukris@gmail.com, maxime.coquelin@redhat.com, thomas@monjalon.net,
 Harman Kalra <hkalra@marvell.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] eal/linux: revert eventfd leak fix for MSI-X
Date: Wed, 18 Nov 2026 16:29:45 +0100
Message-ID: <20261118152945.1404317-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sg4vsdoCBoxDwG86Xr9R2xRne9XdVA-eKPNrWEuyIN4_1795015800
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The event FDs leak fix looks correct on the principle but it seems it
was too soon to take it, as it broke net/virtio and may have broken
other drivers.

Revert this fix until we get a proper fix and acknowledgement that
other drivers are fine with the change.

Fixes: 3ba6b689893f ("eal/linux: fix eventfd leaks when enabling interrupts")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_interrupts.c | 46 +++++++++-------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index dfe1660dd0..c63956cde5 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1556,44 +1556,31 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable)
 int
 rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 {
+	uint32_t i;
+	int fd;
 	uint32_t n = RTE_MIN(nb_efd, (uint32_t)RTE_MAX_RXTX_INTR_VEC_ID);
-	int ret;
 
 	assert(nb_efd != 0);
 
 	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX) {
-		if (rte_intr_nb_efd_get(intr_handle) != 0) {
-			EAL_LOG(ERR, "Interrupt eventfds are already enabled");
-			return -EBUSY;
-		}
-
-		for (uint32_t i = 0; i < n; i++) {
-			int fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
-
+		for (i = 0; i < n; i++) {
+			fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
 			if (fd < 0) {
-				ret = -errno;
 				EAL_LOG(ERR,
 					"can't setup eventfd, error %i (%s)",
 					errno, strerror(errno));
-				goto error;
+				return -errno;
 			}
 
-			/* Record each eventfd as it is created so that the
-			 * error path can close exactly those that exist.
-			 */
-			if (rte_intr_efds_index_set(intr_handle, i, fd) ||
-					rte_intr_nb_efd_set(intr_handle, i + 1)) {
-				ret = -rte_errno;
-				close(fd);
-				rte_intr_efds_index_set(intr_handle, i, -1);
-				goto error;
-			}
+			if (rte_intr_efds_index_set(intr_handle, i, fd))
+				return -rte_errno;
 		}
 
-		if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n)) {
-			ret = -rte_errno;
-			goto error;
-		}
+		if (rte_intr_nb_efd_set(intr_handle, n))
+			return -rte_errno;
+
+		if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n))
+			return -rte_errno;
 	} else if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VDEV) {
 		/* only check, initialization would be done in vdev driver.*/
 		if ((uint64_t)rte_intr_efd_counter_size_get(intr_handle) >
@@ -1611,15 +1598,6 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 	}
 
 	return 0;
-
-error:
-	for (int i = 0; i < rte_intr_nb_efd_get(intr_handle); i++) {
-		close(rte_intr_efds_index_get(intr_handle, i));
-		rte_intr_efds_index_set(intr_handle, i, -1);
-	}
-	rte_intr_nb_efd_set(intr_handle, 0);
-
-	return ret;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
-- 
2.56.1

