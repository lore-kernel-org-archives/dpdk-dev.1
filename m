Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9794606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=F1aBdGhW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77F5E40285;
	Tue, 10 Nov 2026 17:20:28 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 7FC8740281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 17:20:26 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAF0r011890999; Tue, 10 Nov 2026 08:20:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=hF/h4/cIUI26sRcv415fW9J
 YcuOsNm3P/Y8WjLE3eO0=; b=F1aBdGhW1iqwxAiPh5B+E/j3rNvdgtceWGi+jdH
 ziSqu9560SgFjp95DJgEhMB59UrRl1qlmiG7lAVkA6H6M8d5LUUlg3QKZ0AuXAOt
 NeYvsud9KkA2kXd39RTyJKacINzKX0oxEcdgQUuiDP0A6nPoV6rswr3Z21fUz8RY
 L5yqwLfuh/1JM5IruLe2HkFf958AzFNI9qmIYShrGfSsA1eJn4p852dQ4ufqa5mO
 Vip3fCLxk4iUQHx/PsE4f3kse56N796mrO+siP0XExvo/02Ph6+rq2UWjk1lP/Zx
 kYqZ0vA32f0hdV5LC4WZD5HJHksROWxbMbG8vUgL5FCF5Tg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4huhfvpt5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Nov 2026 08:20:25 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Nov 2026 08:20:24 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 10 Nov 2026 08:20:24 -0800
Received: from cavium-System-Product-Name.. (unknown [10.28.38.196])
 by maili.marvell.com (Postfix) with ESMTP id C5EF53F703F;
 Tue, 10 Nov 2026 08:20:20 -0800 (PST)
From: Harman Kalra <hkalra@marvell.com>
To: Thomas Monjalon <thomas@monjalon.net>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, "Sunil
 Kumar Kori" <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 "Harman Kalra" <hkalra@marvell.com>,
 David Marchand <david.marchand@redhat.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Mohit Kumar Parjapat <mprajapat@marvell.com>
Subject: [PATCH v2] common/cnxk: use one interrupt handle per vector
Date: Tue, 10 Nov 2026 21:50:00 +0530
Message-ID: <20261110162000.768230-1-hkalra@marvell.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2NSBTYWx0ZWRfX90cSv9nDLRB2
 Kj+SEJmNqSlrt0vTXwP8LxyjA4l/x2QTpU9wyAKUuTLvCyKL1Q5OS4gtn2RPUQk2oOZ6BDmgiZi
 uyftuV9U8Pioh/KkyPFRatFbGB+heK4=
X-Proofpoint-ORIG-GUID: 5_cWQhdI1CmvS4jYN4-VWeQwexu49os1
X-Authority-Analysis: v=2.4 cv=X+nHu2Te c=1 sm=1 tr=0 ts=6af34449 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=Q-fNiiVtAAAA:8 a=20KFwNOVAAAA:8
 a=vBLQeB-DAAAA:8 a=pGLkceISAAAA:8 a=NQolgeQzAAAA:8 a=z3WRe0ENAAAA:8
 a=DuG982J98LIkI8obGPsA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=u_ZAi6OwbbHxVo6T9Mhb:22
 a=we4VnhAU2_OSqmN109HU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2NSBTYWx0ZWRfX2MbELAoIIDts
 ZptkkDVvitjJMUPjDrGBX6BhaLR3DZaipBhSFkLU/vEiKx7h0JPXdG880P5Ytcg2MFSAv5Z+5+g
 LhQZZXlZapM50isZdH7/jsus4FyM+QX19hFmd77Me0WfAdbhd3ky86FGJtEw0ExW139GduX+nQ4
 WT20+o94SPQzjXrCGhGlBx36WZ6a4lgI3DV6YHGCuuereWMX0ezi/66EjNaomfCRblu4VBQTy35
 6+xAWMxZH5pI4TeSM+oj9wXjgOXvH6cRUrr/Ln9tqZ00jGPCcpwG3glbMRq3tY+Qy61204nD2R6
 VMtkxSd8p8jqMbom3f3hOCZGdbOiP7bT9UUuh34ewk+0RRzH09cVEHxcKrSnZ8t7IhAXFzPyXmr
 ZlrwBNFyc/KOS6mp6W3yZYy45qRGln8gG+qb/2gPCvJg1FgjlED93OaWA9sYogtyv4uF9uaG9Au
 d++0XIgIcmeIea6IScg==
X-Proofpoint-GUID: 5_cWQhdI1CmvS4jYN4-VWeQwexu49os1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohit Kumar Parjapat <mprajapat@marvell.com>

All MSI-X vectors were registered on pci_dev->intr_handle, rewriting
its fd before each rte_intr_callback_register(). Since EAL references
the caller's handle instead of a copy, all vectors share one interrupt
source whose fd is read live, so only the last vector is polled.
Mailbox replies are lost, probe times out, and the cleanup path leaves
a closed fd in the source, making the interrupt thread panic in
epoll_ctl().

Register each vector on its own handle, tracked in a list so that
unregister uses and frees the same handle. Reject duplicate vector
registration, close the vector's own eventfd on unregister, and unwind
all error paths of plt_irq_register().

Fixes: c663018eb7f3 ("interrupts: do not duplicate interrupt handles")

Signed-off-by: Mohit Kumar Parjapat <mprajapat@marvell.com>
Signed-off-by: Harman Kalra <hkalra@marvell.com>
---
 .mailmap                           |   1 +
 drivers/common/cnxk/roc_platform.c | 134 ++++++++++++++++++++++++-----
 2 files changed, 115 insertions(+), 20 deletions(-)

diff --git a/.mailmap b/.mailmap
index a4af517007..3fc374fd2e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1175,6 +1175,7 @@ Mohammad Iqbal Ahmad <mahmad@marvell.com>
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
 Mohammed Gamal <mgamal@redhat.com>
 Mohand Alrasheed <mrasheed@wirefilter.com>
+Mohit Kumar Parjapat <mprajapat@marvell.com>
 Mohsin Kazmi <mohsin.kazmi14@gmail.com>
 Mohsin Mazhar Shaikh <mohsinmazhar_shaikh@trendmicro.com>
 Mohsin Shaikh <mohsinshaikh@niometrics.com>
diff --git a/drivers/common/cnxk/roc_platform.c b/drivers/common/cnxk/roc_platform.c
index 59d662fab4..0a1b96092b 100644
--- a/drivers/common/cnxk/roc_platform.c
+++ b/drivers/common/cnxk/roc_platform.c
@@ -16,8 +16,49 @@
 #include <stdlib.h>
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
+#include <sys/queue.h>
 #include <unistd.h>
 
+/*
+ * EAL interrupt sources are keyed by interrupt handle pointer and read the
+ * handle FD at epoll/dispatch time, so each MSI-X vector needs its own
+ * handle holding that vector's eventfd.
+ */
+struct plt_irq_vec {
+	TAILQ_ENTRY(plt_irq_vec) next;
+	const struct plt_intr_handle *dev_handle;
+	struct plt_intr_handle *handle;
+	plt_intr_callback_fn cb;
+	void *data;
+	unsigned int vec;
+};
+
+static TAILQ_HEAD(, plt_irq_vec) plt_irq_vec_list = TAILQ_HEAD_INITIALIZER(plt_irq_vec_list);
+static plt_spinlock_t plt_irq_vec_lock = RTE_SPINLOCK_INITIALIZER;
+
+static struct plt_irq_vec *
+irq_vec_find(const struct plt_intr_handle *dev_handle, unsigned int vec)
+{
+	struct plt_irq_vec *irq_vec;
+
+	TAILQ_FOREACH(irq_vec, &plt_irq_vec_list, next) {
+		if (irq_vec->dev_handle == dev_handle && irq_vec->vec == vec)
+			return irq_vec;
+	}
+
+	return NULL;
+}
+
+static void
+irq_vec_free(struct plt_irq_vec *irq_vec)
+{
+	if (irq_vec->handle != NULL) {
+		plt_intr_fd_close(irq_vec->handle);
+		plt_intr_instance_free(irq_vec->handle);
+	}
+	free(irq_vec);
+}
+
 static int
 irq_get_info(struct plt_intr_handle *intr_handle)
 {
@@ -150,7 +191,7 @@ int
 plt_irq_register(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, void *data,
 		 unsigned int vec)
 {
-	struct plt_intr_handle *tmp_handle;
+	struct plt_irq_vec *irq_vec;
 	uint32_t nb_efd, tmp_nb_efd;
 	int rc, fd;
 
@@ -166,25 +207,61 @@ plt_irq_register(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, v
 		return -EINVAL;
 	}
 
-	tmp_handle = intr_handle;
+	irq_vec = calloc(1, sizeof(*irq_vec));
+	if (irq_vec == NULL)
+		return -ENOMEM;
+	irq_vec->dev_handle = intr_handle;
+	irq_vec->cb = cb;
+	irq_vec->data = data;
+	irq_vec->vec = vec;
+
+	irq_vec->handle = plt_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (irq_vec->handle == NULL) {
+		rc = -ENOMEM;
+		goto free_vec;
+	}
+
 	/* Create new eventfd for interrupt vector */
 	fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
-	if (fd == -1)
-		return -ENODEV;
+	if (fd == -1) {
+		rc = -ENODEV;
+		goto free_vec;
+	}
 
-	if (plt_intr_fd_set(tmp_handle, fd))
-		return -errno;
+	if (plt_intr_fd_set(irq_vec->handle, fd)) {
+		close(fd);
+		rc = -EINVAL;
+		goto free_vec;
+	}
+
+	/* EAL reads the 8 byte eventfd counter only for VFIO handle types */
+	if (plt_intr_type_set(irq_vec->handle, plt_intr_type_get(intr_handle))) {
+		rc = -EINVAL;
+		goto free_vec;
+	}
+
+	plt_spinlock_lock(&plt_irq_vec_lock);
+	if (irq_vec_find(intr_handle, vec) != NULL) {
+		plt_spinlock_unlock(&plt_irq_vec_lock);
+		plt_err("Vector:0x%x irq already registered", vec);
+		rc = -EEXIST;
+		goto free_vec;
+	}
+	TAILQ_INSERT_TAIL(&plt_irq_vec_list, irq_vec, next);
+	plt_spinlock_unlock(&plt_irq_vec_lock);
 
 	/* Register vector interrupt callback */
-	rc = plt_intr_callback_register(tmp_handle, cb, data);
+	rc = plt_intr_callback_register(irq_vec->handle, cb, data);
 	if (rc) {
 		plt_err("Failed to register vector:0x%x irq callback.", vec);
-		return rc;
+		goto remove_vec;
 	}
 
 	rc = plt_intr_efds_index_set(intr_handle, vec, fd);
-	if (rc)
-		return rc;
+	if (rc) {
+		plt_intr_callback_unregister(irq_vec->handle, cb, data);
+		goto remove_vec;
+	}
 
 	nb_efd = (vec > (uint32_t)plt_intr_nb_efd_get(intr_handle)) ?
 			 vec :
@@ -199,15 +276,23 @@ plt_irq_register(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, v
 
 	/* Enable MSIX vectors to VFIO */
 	return irq_config(intr_handle, vec);
+
+remove_vec:
+	plt_spinlock_lock(&plt_irq_vec_lock);
+	TAILQ_REMOVE(&plt_irq_vec_list, irq_vec, next);
+	plt_spinlock_unlock(&plt_irq_vec_lock);
+free_vec:
+	irq_vec_free(irq_vec);
+	return rc;
 }
 
 void
 plt_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb, void *data,
 		   unsigned int vec)
 {
-	struct plt_intr_handle *tmp_handle;
+	struct plt_irq_vec *irq_vec;
 	uint8_t retries = 5; /* 5 ms */
-	int rc, fd;
+	int rc;
 
 	if (vec > (uint32_t)plt_intr_max_intr_get(intr_handle)) {
 		plt_err("Error unregistering MSI-X interrupts vec:%d > %d", vec,
@@ -215,17 +300,23 @@ plt_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb,
 		return;
 	}
 
-	tmp_handle = intr_handle;
-	fd = plt_intr_efds_index_get(intr_handle, vec);
-	if (fd == -1)
+	plt_spinlock_lock(&plt_irq_vec_lock);
+	irq_vec = irq_vec_find(intr_handle, vec);
+	plt_spinlock_unlock(&plt_irq_vec_lock);
+	if (irq_vec == NULL) {
+		if (plt_intr_efds_index_get(intr_handle, vec) != -1)
+			plt_err("Error unregistering MSI-X vec %d cb, not registered", vec);
 		return;
+	}
 
-	if (plt_intr_fd_set(tmp_handle, fd))
+	if (irq_vec->cb != cb || irq_vec->data != data) {
+		plt_err("MSI-X vec %d registered with a different callback", vec);
 		return;
+	}
 
 	do {
 		/* Un-register callback func from platform lib */
-		rc = plt_intr_callback_unregister(tmp_handle, cb, data);
+		rc = plt_intr_callback_unregister(irq_vec->handle, cb, data);
 		/* Retry only if -EAGAIN */
 		if (rc != -EAGAIN)
 			break;
@@ -238,15 +329,18 @@ plt_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb,
 		return;
 	}
 
+	plt_spinlock_lock(&plt_irq_vec_lock);
+	TAILQ_REMOVE(&plt_irq_vec_list, irq_vec, next);
+	plt_spinlock_unlock(&plt_irq_vec_lock);
+
 	plt_base_dbg("Disable vector:0x%x for vfio (efds: %d, max:%d)", vec,
 		     plt_intr_nb_efd_get(intr_handle), plt_intr_max_intr_get(intr_handle));
 
-	if (plt_intr_efds_index_get(intr_handle, vec) != -1)
-		close(plt_intr_efds_index_get(intr_handle, vec));
 	/* Disable MSIX vectors from VFIO */
 	plt_intr_efds_index_set(intr_handle, vec, -1);
-
 	irq_config(intr_handle, vec);
+
+	irq_vec_free(irq_vec);
 }
 #endif
 
-- 
2.43.0

