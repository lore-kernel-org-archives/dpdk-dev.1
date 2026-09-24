Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32320C98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:14:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FE0543009;
	Thu, 24 Sep 2026 18:13:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2B5A640144
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:13:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266432; x=1821802432;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zqi9XQ/XMYwJlqLbH+hwSXE0wftXvwpyRYj94L5ia18=;
 b=Rn9tlbrA7S/W+zG1FM3/gTe9PV8l1toDs9XMGEFAGNJndWutF20xVimt
 MVggpIWx2Y3uC6O5CqNVhKnZXO4/AWAZwQOh74u9+cnbWi5YWzVhBhpzX
 ZlU2RNHhUYXwFXSJLIvEfKmX2POrQx1RAq4Tt3moiYjw0yzlwo1lcFBid
 uA+ReDGthpo7ZrntqBn8EJGVgs8eR5uYInpqFf8KzproqlNtBYyx5yfgN
 Irzocrm/w2ETJu2Ohv4rsVOqbhU8deEFrTvK7lmRw8YbVDZE8emNr6ScJ
 l3P/j0felrYqfnEmPys6FeqY/vASh+12X8j4FeugZnkVJWXbK43dPmVrq A==;
X-CSE-ConnectionGUID: 9PbWFOv2SjaJUguTnPROEQ==
X-CSE-MsgGUID: 8uDn5xRqRdeZO4jMmtkqXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000616"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000616"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:13:50 -0700
X-CSE-ConnectionGUID: eJyWf4fjRVGBJe2aHSX9SQ==
X-CSE-MsgGUID: MFomXIOiT/OLtyxyQ7gd3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277829965"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:13:49 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v18 03/29] bus/fslmc: decouple from EAL VFIO
Date: Thu, 24 Sep 2026 17:13:10 +0100
Message-ID: <ff76291baf1b6e77da2063ce8ce1939ec716ce56.1790266166.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790266165.git.anatoly.burakov@intel.com>
 <cover.1790266165.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

FSLMC bus has its own VFIO implementation which is completely separate from
one in EAL or rte_vfio. Yet, it references a couple of macros and uses a
struct definition. Fully decoupling them is not a huge lift, so do that.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/fslmc/fslmc_vfio.c | 50 +++++++++++++++++++++-------------
 drivers/bus/fslmc/meson.build  |  1 -
 2 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 412b70e5ae7..8d39895bacf 100644
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
index 50d9e91a37f..55f9d2e8081 100644
--- a/drivers/bus/fslmc/meson.build
+++ b/drivers/bus/fslmc/meson.build
@@ -30,4 +30,3 @@ sources = files(
 )
 
 includes += include_directories('mc', 'qbman/include', 'portal')
-includes += include_directories('../../../lib/eal/linux')
-- 
2.52.0

