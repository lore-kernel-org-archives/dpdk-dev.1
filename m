Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2740606A31A
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZBUPDJTC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E28D40A6D;
	Sat, 24 Oct 2026 15:22:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id ACCE140A70
 for <dev@dpdk.org>; Sat, 24 Oct 2026 15:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTnhYEI+MVaodyG59YWmBLW4jgLJvzSZzQPuMRh8JlE=;
 b=ZBUPDJTCtC2fuc5mAm41qc5rxfM9cN9HkYgwKKc1kjuGWHSAZHnFP7UPcdwOs9Om2GJF4B
 XpiDlsUpLPmN0I4D7rUrrZwOzEOQJVWv//PP6HJtQWiPMvXD+72g+MRyu7zoMrlFBx5wfT
 +l1ktgH5sqFQaeN9scuKr+FmtvBjQuI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-xzzjKNWlMBy4CXXn06W9Vg-1; Sat,
 24 Oct 2026 09:22:31 -0400
X-MC-Unique: xzzjKNWlMBy4CXXn06W9Vg-1
X-Mimecast-MFC-AGG-ID: xzzjKNWlMBy4CXXn06W9Vg_1792848150
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9348E1955D89; Sat, 24 Oct 2026 13:22:30 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C1041800495; Sat, 24 Oct 2026 13:22:28 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, hkalra@marvell.com, anatoly.burakov@intel.com,
 stable@dpdk.org, Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH v2 11/12] eal/linux: fix eventfd leaks when enabling interrupts
Date: Sat, 24 Oct 2026 15:21:36 +0200
Message-ID: <20261024132138.7239-12-david.marchand@redhat.com>
In-Reply-To: <20261024132138.7239-1-david.marchand@redhat.com>
References: <20261021092318.1554295-1-david.marchand@redhat.com>
 <20261024132138.7239-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2j6SIEa2_bkHrVQsc0xcT9hxi8yLqaUCLeBajjlmsJ4_1792848150
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

When enabling MSI-X eventfds, a failure after creating some descriptors
leaves them open. The eventfd count is recorded only after all allocations
succeed, so disabling eventfds cannot clean up a partial allocation.

Calling enable again without disabling first also leaks descriptors by
overwriting the existing eventfd entries.

Reject repeated MSI-X enable calls with EBUSY before modifying the handle.
Update the eventfd count as each descriptor is created, so that on failure
every eventfd created by the call can be closed, its entry cleared, and the
count reset.

Fixes: b9e0662a931d ("eal/linux: add interrupt API for drivers")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_interrupts.c | 46 +++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
index fa658f5a3c..73f23c314b 100644
--- a/lib/eal/linux/eal_interrupts.c
+++ b/lib/eal/linux/eal_interrupts.c
@@ -1556,31 +1556,44 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_enable)
 int
 rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 {
-	uint32_t i;
-	int fd;
 	uint32_t n = RTE_MIN(nb_efd, (uint32_t)RTE_MAX_RXTX_INTR_VEC_ID);
+	int ret;
 
 	assert(nb_efd != 0);
 
 	if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX) {
-		for (i = 0; i < n; i++) {
-			fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+		if (rte_intr_nb_efd_get(intr_handle) != 0) {
+			EAL_LOG(ERR, "Interrupt eventfds are already enabled");
+			return -EBUSY;
+		}
+
+		for (uint32_t i = 0; i < n; i++) {
+			int fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+
 			if (fd < 0) {
+				ret = -errno;
 				EAL_LOG(ERR,
 					"can't setup eventfd, error %i (%s)",
 					errno, strerror(errno));
-				return -errno;
+				goto error;
 			}
 
-			if (rte_intr_efds_index_set(intr_handle, i, fd))
-				return -rte_errno;
+			/* Record each eventfd as it is created so that the
+			 * error path can close exactly those that exist.
+			 */
+			if (rte_intr_efds_index_set(intr_handle, i, fd) ||
+					rte_intr_nb_efd_set(intr_handle, i + 1)) {
+				ret = -rte_errno;
+				close(fd);
+				rte_intr_efds_index_set(intr_handle, i, -1);
+				goto error;
+			}
 		}
 
-		if (rte_intr_nb_efd_set(intr_handle, n))
-			return -rte_errno;
-
-		if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n))
-			return -rte_errno;
+		if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n)) {
+			ret = -rte_errno;
+			goto error;
+		}
 	} else if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VDEV) {
 		/* only check, initialization would be done in vdev driver.*/
 		if ((uint64_t)rte_intr_efd_counter_size_get(intr_handle) >
@@ -1598,6 +1611,15 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
 	}
 
 	return 0;
+
+error:
+	for (int i = 0; i < rte_intr_nb_efd_get(intr_handle); i++) {
+		close(rte_intr_efds_index_get(intr_handle, i));
+		rte_intr_efds_index_set(intr_handle, i, -1);
+	}
+	rte_intr_nb_efd_set(intr_handle, 0);
+
+	return ret;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
-- 
2.54.0

