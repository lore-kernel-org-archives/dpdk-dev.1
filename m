Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEBFCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:10:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B54F427CD;
	Wed,  7 Oct 2026 10:10:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 581AF427CF
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:10:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yb2GlzaUclwP6sb9NSbuegjmTymecpuQmheCpUb3IvM=;
 b=jIWRT6tVavHLm/bb40tgIMztdsSk6xYHjeCYOAwKsi/NvWLqG9Pr5ZD+PLm4CgjphhD/hU
 tWJqseSAolhpkHve72nLNwG4vvyRy6cCyWK62EW3uAcQMXfX4IHxVL57b1vaeD5u9PgN9C
 NMGiUs69RqJXr3CYnopqWKZsH371Irg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-wsG533ntOTGl2EcXP8dfxg-1; Wed, 7
 Oct 2026 08:10:39 +0000
X-MC-Unique: wsG533ntOTGl2EcXP8dfxg-1
X-Mimecast-MFC-AGG-ID: wsG533ntOTGl2EcXP8dfxg_1791360638
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F4AF19772C0; Wed,  7 Oct 2026 08:10:38 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25A9A1800352; Wed,  7 Oct 2026 08:10:36 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RESEND][PATCH v19 02/26] bus/fslmc: decouple from EAL VFIO
Date: Wed,  7 Oct 2026 10:09:59 +0200
Message-ID: <20261007081026.574382-3-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _obGnN7HFz12CWPjU2tjf3GeRdaEihl8sFbTkcAPRb4_1791360638
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

From: Anatoly Burakov <anatoly.burakov@intel.com>

FSLMC bus has its own VFIO implementation which is completely separate from
one in EAL or rte_vfio. Yet, it references a couple of macros and uses a
struct definition. Fully decoupling them is not a huge lift, so do that.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/fslmc/fslmc_vfio.c | 50 +++++++++++++++++++++-------------
 drivers/bus/fslmc/meson.build  |  1 -
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 412b70e5ae..8d39895bac 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -35,7 +35,6 @@
 #include <dev_driver.h>
 #include <rte_eal_memconfig.h>
 #include <rte_vfio.h>
-#include <eal_vfio.h>
 
 #include "private.h"
 #include "fslmc_vfio.h"
@@ -73,8 +72,21 @@ struct fslmc_dmaseg_list fslmc_iosegs =
 static uint64_t fslmc_mem_va2iova = RTE_BAD_IOVA;
 static int fslmc_mem_map_num;
 
+#define FSLMC_VFIO_SOCKET_OK 0x0
+#define FSLMC_VFIO_SOCKET_NO_FD 0x1
+#define FSLMC_VFIO_SOCKET_ERR 0xFF
+
+struct fslmc_vfio_mp_param {
+	int req;
+	int result;
+	union {
+		int group_num;
+		int iommu_type_id;
+	};
+};
+
 struct fslmc_mem_param {
-	struct vfio_mp_param mp_param;
+	struct fslmc_vfio_mp_param mp_param;
 	struct fslmc_dmaseg_list memsegs;
 	struct fslmc_dmaseg_list iosegs;
 	uint64_t mem_va2iova;
@@ -386,7 +398,7 @@ fslmc_vfio_open_group_fd(const char *group_name)
 	struct rte_mp_msg mp_req, *mp_rep;
 	struct rte_mp_reply mp_reply = {0};
 	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
-	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
+	struct fslmc_vfio_mp_param *p = (struct fslmc_vfio_mp_param *)mp_req.param;
 	int iommu_group_num, ret;
 
 	vfio_group_fd = fslmc_vfio_group_fd_by_name(group_name);
@@ -417,10 +429,10 @@ fslmc_vfio_open_group_fd(const char *group_name)
 	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
 	    mp_reply.nb_received == 1) {
 		mp_rep = &mp_reply.msgs[0];
-		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == SOCKET_OK && mp_rep->num_fds == 1)
+		p = (struct fslmc_vfio_mp_param *)mp_rep->param;
+		if (p->result == FSLMC_VFIO_SOCKET_OK && mp_rep->num_fds == 1)
 			vfio_group_fd = mp_rep->fds[0];
-		else if (p->result == SOCKET_NO_FD)
+		else if (p->result == FSLMC_VFIO_SOCKET_NO_FD)
 			DPAA2_BUS_ERR("Bad VFIO group fd");
 	}
 
@@ -490,7 +502,7 @@ fslmc_vfio_open_container_fd(void)
 	struct rte_mp_msg mp_req, *mp_rep;
 	struct rte_mp_reply mp_reply = {0};
 	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
-	struct vfio_mp_param *p = (void *)mp_req.param;
+	struct fslmc_vfio_mp_param *p = (void *)mp_req.param;
 
 	if (fslmc_vfio_container_fd() > 0)
 		return fslmc_vfio_container_fd();
@@ -551,7 +563,7 @@ fslmc_vfio_open_container_fd(void)
 
 	mp_rep = &mp_reply.msgs[0];
 	p = (void *)mp_rep->param;
-	if (p->result == SOCKET_OK && mp_rep->num_fds == 1) {
+	if (p->result == FSLMC_VFIO_SOCKET_OK && mp_rep->num_fds == 1) {
 		vfio_container_fd = mp_rep->fds[0];
 		free(mp_reply.msgs);
 	}
@@ -594,8 +606,8 @@ fslmc_vfio_mp_primary(const struct rte_mp_msg *msg,
 	int fd = -1;
 	int ret;
 	struct rte_mp_msg reply;
-	struct vfio_mp_param *r = (void *)reply.param;
-	const struct vfio_mp_param *m = (const void *)msg->param;
+	struct fslmc_vfio_mp_param *r = (void *)reply.param;
+	const struct fslmc_vfio_mp_param *m = (const void *)msg->param;
 	struct fslmc_mem_param *map;
 
 	if (msg->len_param != sizeof(*m)) {
@@ -612,13 +624,13 @@ fslmc_vfio_mp_primary(const struct rte_mp_msg *msg,
 		r->group_num = m->group_num;
 		fd = fslmc_vfio_group_fd_by_id(m->group_num);
 		if (fd < 0) {
-			r->result = SOCKET_ERR;
+			r->result = FSLMC_VFIO_SOCKET_ERR;
 		} else if (!fd) {
 			/* if group exists but isn't bound to VFIO driver */
-			r->result = SOCKET_NO_FD;
+			r->result = FSLMC_VFIO_SOCKET_NO_FD;
 		} else {
 			/* if group exists and is bound to VFIO driver */
-			r->result = SOCKET_OK;
+			r->result = FSLMC_VFIO_SOCKET_OK;
 			reply.num_fds = 1;
 			reply.fds[0] = fd;
 		}
@@ -628,9 +640,9 @@ fslmc_vfio_mp_primary(const struct rte_mp_msg *msg,
 		r->req = FSLMC_VFIO_SOCKET_REQ_CONTAINER;
 		fd = fslmc_vfio_container_fd();
 		if (fd <= 0) {
-			r->result = SOCKET_ERR;
+			r->result = FSLMC_VFIO_SOCKET_ERR;
 		} else {
-			r->result = SOCKET_OK;
+			r->result = FSLMC_VFIO_SOCKET_OK;
 			reply.num_fds = 1;
 			reply.fds[0] = fd;
 		}
@@ -640,7 +652,7 @@ fslmc_vfio_mp_primary(const struct rte_mp_msg *msg,
 		map = (void *)reply.param;
 		r = &map->mp_param;
 		r->req = FSLMC_VFIO_SOCKET_REQ_MEM;
-		r->result = SOCKET_OK;
+		r->result = FSLMC_VFIO_SOCKET_OK;
 		map->memsegs = fslmc_memsegs;
 		map->iosegs = fslmc_iosegs;
 		map->mem_va2iova = fslmc_mem_va2iova;
@@ -666,19 +678,19 @@ fslmc_vfio_mp_sync_mem_req(void)
 	struct rte_mp_reply mp_reply = {0};
 	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
 	int ret = 0;
-	struct vfio_mp_param *mp_param;
+	struct fslmc_vfio_mp_param *mp_param;
 	struct fslmc_mem_param *mem_rsp;
 
 	mp_param = (void *)mp_req.param;
 	memset(&mp_req, 0, sizeof(struct rte_mp_msg));
 	mp_param->req = FSLMC_VFIO_SOCKET_REQ_MEM;
 	rte_strscpy(mp_req.name, FSLMC_VFIO_MP, sizeof(mp_req.name));
-	mp_req.len_param = sizeof(struct vfio_mp_param);
+	mp_req.len_param = sizeof(struct fslmc_vfio_mp_param);
 	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
 		mp_reply.nb_received == 1) {
 		mp_rep = &mp_reply.msgs[0];
 		mem_rsp = (struct fslmc_mem_param *)mp_rep->param;
-		if (mem_rsp->mp_param.result == SOCKET_OK) {
+		if (mem_rsp->mp_param.result == FSLMC_VFIO_SOCKET_OK) {
 			fslmc_memsegs = mem_rsp->memsegs;
 			fslmc_mem_va2iova = mem_rsp->mem_va2iova;
 			fslmc_mem_map_num = mem_rsp->mem_map_num;
diff --git a/drivers/bus/fslmc/meson.build b/drivers/bus/fslmc/meson.build
index 50d9e91a37..55f9d2e808 100644
--- a/drivers/bus/fslmc/meson.build
+++ b/drivers/bus/fslmc/meson.build
@@ -30,4 +30,3 @@ sources = files(
 )
 
 includes += include_directories('mc', 'qbman/include', 'portal')
-includes += include_directories('../../../lib/eal/linux')
-- 
2.54.0

