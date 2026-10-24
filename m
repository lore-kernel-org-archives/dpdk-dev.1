Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97C5606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BZxFA/To
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EB2C40A76;
	Sat, 24 Oct 2026 15:22:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4CF7E4021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kN4b3D4BhMhV3ltdQhpjn1Cu1N2u458MgaF86VZi45E=;
 b=BZxFA/Tohp+5V67HNadkf+sUNFOyGAXRUgTztYdsttJyNcUgJQiBJtI4YKjkp859TjS1PJ
 2hlareQnWuyBYAqW1lWmc5Af9/f5jyMnM0D9vep3n+nmMxYD0DUL84G/OyBIQxFo8OdQtH
 yoDtOkrFX0IBFi99YspNYogr9PAQ6eo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-J7vX-992P7W0_BNAQ1481A-1; Sat,
 24 Oct 2026 09:22:35 -0400
X-MC-Unique: J7vX-992P7W0_BNAQ1481A-1
X-Mimecast-MFC-AGG-ID: J7vX-992P7W0_BNAQ1481A_1792848154
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DB321801352; Sat, 24 Oct 2026 13:22:34 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 22244195608A; Sat, 24 Oct 2026 13:22:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, anatoly.burakov@intel.com
Subject: [PATCH v2 12/12] interrupts: warn on leaked event FDs
Date: Sat, 24 Oct 2026 15:21:37 +0200
Message-ID: <20261024132138.7239-13-david.marchand@redhat.com>
In-Reply-To: <20261024132138.7239-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4mWJqqJ-8sJI92J-xTDeqNdVry3VENn48FGGLLHPhPo_1792848154
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

Extend the leak warning in rte_intr_instance_free() to the event FD
array, in the same way as the handle FD and device FD.

rte_intr_efd_disable() used to close the eventfds it owns but left
the stale descriptors in the array, and never cleared the entry that
merely references the handle FD in the non-MSI-X case.
For all types but VDEV, reset all entries in use to -1 so a properly
disabled handle is not reported.

Drivers filling the event FD array themselves are expected to reset
the entries once the descriptors are closed or no longer referenced.

Suggested-by: David Marchand <david.marchand@redhat.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since Anatoly v4:
- added check on type != VDEV when disabling,

---
 lib/eal/common/eal_common_interrupts.c | 5 +++++
 lib/eal/include/rte_interrupts.h       | 7 ++++++-
 lib/eal/linux/eal_interrupts.c         | 9 ++++++---
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index 1208a2597d..f3eee636df 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -167,6 +167,11 @@ void rte_intr_instance_free(struct rte_intr_handle *intr_handle)
 	if (rte_intr_dev_fd_get(intr_handle) >= 0)
 		EAL_LOG(NOTICE, "Some interrupt handle is leaking a device FD: %d",
 			rte_intr_dev_fd_get(intr_handle));
+	for (int i = 0; i < intr_handle->nb_intr; i++) {
+		if (intr_handle->efds[i] >= 0)
+			EAL_LOG(NOTICE, "Some interrupt handle is leaking an event FD: %d (index %d)",
+				intr_handle->efds[i], i);
+	}
 	if (RTE_INTR_INSTANCE_USES_RTE_MEMORY(intr_handle->alloc_flags)) {
 		rte_free(intr_handle->efds);
 		rte_free(intr_handle->elist);
diff --git a/lib/eal/include/rte_interrupts.h b/lib/eal/include/rte_interrupts.h
index bb06180bea..85b5546dee 100644
--- a/lib/eal/include/rte_interrupts.h
+++ b/lib/eal/include/rte_interrupts.h
@@ -389,6 +389,7 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd);
  * @internal
  * It disables the packet I/O interrupt event.
  * It deletes registered eventfds and closes the open fds.
+ * All event fd entries in use are reset to -1.
  *
  * @param intr_handle
  *   Pointer to the interrupt handle.
@@ -605,12 +606,16 @@ rte_intr_efd_counter_size_get(const struct rte_intr_handle *intr_handle);
  * @internal
  * Set the event fd array index with the given fd.
  *
+ * Entries still holding a valid fd when the instance is freed are reported
+ * as leaks, so callers managing the array themselves must reset entries
+ * to -1 once the fd is closed or no longer referenced.
+ *
  * @param intr_handle
  *  pointer to the interrupt handle.
  * @param index
  *  efds array index to be set
  * @param fd
- *  event fd
+ *  event fd, or -1 to clear the entry
  *
  * @return
  *  - On success, zero.
diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index 73f23c314b..dfe1660dd0 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1626,17 +1626,20 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
 void
 rte_intr_efd_disable(struct rte_intr_handle *intr_handle)
 {
-	uint32_t i;
-
 	rte_intr_free_epoll_fd(intr_handle);
 	/* Only eventfds created by rte_intr_efd_enable() for MSI-X are owned
 	 * by the handle. In other modes the entries reference fds owned by
 	 * the device or the driver and must not be closed here.
 	 */
 	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX) {
-		for (i = 0; i < (uint32_t)rte_intr_nb_efd_get(intr_handle); i++)
+		for (int i = 0; i < rte_intr_nb_efd_get(intr_handle); i++)
 			close(rte_intr_efds_index_get(intr_handle, i));
 	}
+	/* VDEV is responsible for efds, see rte_intr_efd_enable(). */
+	if (rte_intr_type_get(intr_handle) != RTE_INTR_HANDLE_VDEV) {
+		for (int i = 0; i < rte_intr_nb_efd_get(intr_handle); i++)
+			rte_intr_efds_index_set(intr_handle, i, -1);
+	}
 	rte_intr_nb_efd_set(intr_handle, 0);
 	rte_intr_max_intr_set(intr_handle, 0);
 }
-- 
2.54.0

