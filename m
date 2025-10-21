Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4051CCD1A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 13:19:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96BF4402C5;
	Tue, 21 Oct 2025 15:19:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 36057400D5;
 Tue, 21 Oct 2025 15:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761052788; x=1792588788;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pye68mp64RpEbWyCCMtooiC0QFi4FCpnrURcfJAK//M=;
 b=juNjvFz6Z/r5mHBbQLShxaWmcjTcqd/WY+YdYAD0aFPM4JZIGsrBqAto
 QXBJZHUidNDSl4ks7NF1yawCSLjlpCcaX28lpd+shA758El/f9RujDRwe
 mduMD1fnPf95c4RbV+LmSuBwQcAhJV2wJRohpVikSvlNaacvlNuBEOTMB
 epqphPmJGvbcKtgjk+Ib+G8FNuxLP1MbmOsJS1LyewPPu+Y6XPfCB+tQN
 59BWLj4G6NVtTF1jjtPFNsmISzimiFoxv8qX3FMov8imupPGSNCU2An5/
 tzgvrFS24TBGY/JnscA4bZnplOMjAg9esgPZW86fFwsfC0p4xq4G8Unl9 A==;
X-CSE-ConnectionGUID: G8eax7gcRxasqzSKsUxJYg==
X-CSE-MsgGUID: FWYZlJEuScS8U7ZglxEeag==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73784518"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; d="scan'208";a="73784518"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 06:19:46 -0700
X-CSE-ConnectionGUID: PyyE603rQSGcaisIpgR75g==
X-CSE-MsgGUID: ziTVP56jQSusFKMEubysDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; d="scan'208";a="182748881"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 21 Oct 2025 06:19:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Xiao Wang <xiao.w.wang@intel.com>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Junjie Chen <junjie.j.chen@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: stable@dpdk.org
Subject: [PATCH v2 1/1] vfio: fix custom containers in multiprocess
Date: Tue, 21 Oct 2025 14:19:42 +0100
Message-ID: <7e195ed0245a80a7f3302ae5d3c08a66c206ca9b.1761052774.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <eb2c322e42a39e684514186503515e96633cd991.1761041388.git.anatoly.burakov@intel.com>
References: <eb2c322e42a39e684514186503515e96633cd991.1761041388.git.anatoly.burakov@intel.com>
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

Currently, the API regarding handling custom (non-default) containers has
a problem with how it behaves in secondary process. The expected flow for
using custom containers is to:

1) create a new container using rte_vfio_container_create()
2) look up IOMMU group with rte_vfio_get_group_num()
3) bind group to that container using rte_vfio_group_bind()
4) setup device with rte_vfio_setup_device()

When called from secondary process, rte_vfio_container_create() will check
if there's space in local VFIO config, and if there is, it will call
rte_vfio_get_container_fd() which, in secondary process, will call into a
multiprocess code to request primary process to open container fd, and then
pass it back to the requester. Primary process does not store this fd
anywhere, in fact it closes it immediately after responding to the request.

Following that, when we call rte_vfio_group_bind(), we check if the group
is open locally, and if not, we will call into multiprocess code again, to
request primary process to open the group fd for us, but since primary did
not store any information about the new container in step 1, it will store
the group in local config for default container, and return it to the
secondary, who will add it to its own config for a different container.

To address these issues, the following changes are made:

1) Clarify meaning of rte_vfio_get_container_fd() to only return the
   default container, and always pick it up from process-local config

2) Avoid calling into multiprocess on rte_vfio_container_create()

3) Avoid calling into multiprocess in group-related code, except when
   dealing with groups associated with default container

As a consequence, SOCKET_REQ_DEFAULT_CONTAINER can be removed and
consolidated with SOCKET_REQ_CONTAINER, which now only handles the
default container.

Fixes: ea2dc1066870 ("vfio: add multi container support")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v2:
    - Fixed missing initialization for fd on multiprocess path
    - Fixed always creating new container on secondary process request
    - Removed unnecessary fd close after returning fd to secondary

 lib/eal/include/rte_vfio.h       |   6 +-
 lib/eal/linux/eal_vfio.c         | 110 ++++++++++++++-----------------
 lib/eal/linux/eal_vfio.h         |   5 +-
 lib/eal/linux/eal_vfio_mp_sync.c |  13 ----
 4 files changed, 56 insertions(+), 78 deletions(-)

diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index 80951517fa..d1e8bce56b 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -192,14 +192,14 @@ rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 		int *vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
- * Open a new VFIO container fd
+ * Get the default VFIO container fd
  *
  * This function is only relevant to linux and will return
  * an error on BSD.
  *
  * @return
- *  > 0 container fd
- *  < 0 for errors
+ *  > 0 default container fd
+ *  < 0 if VFIO is not enabled or not supported
  */
 int
 rte_vfio_get_container_fd(void);
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 45c1354390..f1050ffa60 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -351,7 +351,7 @@ compact_user_maps(struct user_mem_maps *user_mem_maps)
 }
 
 static int
-vfio_open_group_fd(int iommu_group_num)
+vfio_open_group_fd(int iommu_group_num, bool mp_request)
 {
 	int vfio_group_fd;
 	char filename[PATH_MAX];
@@ -359,11 +359,9 @@ vfio_open_group_fd(int iommu_group_num)
 	struct rte_mp_reply mp_reply = {0};
 	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
 	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
-	/* if primary, try to open the group */
-	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
+	/* if not requesting via mp, open the group locally */
+	if (!mp_request) {
 		/* try regular group format */
 		snprintf(filename, sizeof(filename), RTE_VFIO_GROUP_FMT, iommu_group_num);
 		vfio_group_fd = open(filename, O_RDWR);
@@ -471,7 +469,24 @@ vfio_get_group_fd(struct vfio_config *vfio_cfg,
 		return -1;
 	}
 
-	vfio_group_fd = vfio_open_group_fd(iommu_group_num);
+	/*
+	 * When opening a group fd, we need to decide whether to open it locally
+	 * or request it from the primary process via mp_sync.
+	 *
+	 * For the default container, secondary processes use mp_sync so that
+	 * the primary process tracks the group fd and maintains VFIO state
+	 * across all processes.
+	 *
+	 * For custom containers, we open the group fd locally in each process
+	 * since custom containers are process-local and the primary has no
+	 * knowledge of them. Requesting a group fd from the primary for a
+	 * container it doesn't know about would be incorrect.
+	 */
+	const struct internal_config *internal_conf = eal_get_internal_configuration();
+	bool mp_request = (internal_conf->process_type == RTE_PROC_SECONDARY) &&
+			(vfio_cfg == default_vfio_cfg);
+
+	vfio_group_fd = vfio_open_group_fd(iommu_group_num, mp_request);
 	if (vfio_group_fd < 0) {
 		EAL_LOG(ERR, "Failed to open VFIO group %d",
 			iommu_group_num);
@@ -1140,13 +1155,13 @@ rte_vfio_enable(const char *modname)
 		if (vfio_mp_sync_setup() == -1) {
 			default_vfio_cfg->vfio_container_fd = -1;
 		} else {
-			/* open a new container */
-			default_vfio_cfg->vfio_container_fd = rte_vfio_get_container_fd();
+			/* open a default container */
+			default_vfio_cfg->vfio_container_fd = vfio_open_container_fd(false);
 		}
 	} else {
 		/* get the default container from the primary process */
 		default_vfio_cfg->vfio_container_fd =
-				vfio_get_default_container_fd();
+			vfio_open_container_fd(true);
 	}
 
 	/* check if we have VFIO driver enabled */
@@ -1168,49 +1183,6 @@ rte_vfio_is_enabled(const char *modname)
 	return default_vfio_cfg->vfio_enabled && mod_available;
 }
 
-int
-vfio_get_default_container_fd(void)
-{
-	struct rte_mp_msg mp_req, *mp_rep;
-	struct rte_mp_reply mp_reply = {0};
-	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
-	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
-	int container_fd;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-
-	if (default_vfio_cfg->vfio_enabled)
-		return default_vfio_cfg->vfio_container_fd;
-
-	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
-		/* if we were secondary process we would try requesting
-		 * container fd from the primary, but we're the primary
-		 * process so just exit here
-		 */
-		return -1;
-	}
-
-	p->req = SOCKET_REQ_DEFAULT_CONTAINER;
-	strcpy(mp_req.name, EAL_VFIO_MP);
-	mp_req.len_param = sizeof(*p);
-	mp_req.num_fds = 0;
-
-	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
-	    mp_reply.nb_received == 1) {
-		mp_rep = &mp_reply.msgs[0];
-		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == SOCKET_OK && mp_rep->num_fds == 1) {
-			container_fd = mp_rep->fds[0];
-			free(mp_reply.msgs);
-			return container_fd;
-		}
-	}
-
-	free(mp_reply.msgs);
-	EAL_LOG(ERR, "Cannot request default VFIO container fd");
-	return -1;
-}
-
 int
 vfio_get_iommu_type(void)
 {
@@ -1303,20 +1275,25 @@ vfio_has_supported_extensions(int vfio_container_fd)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd)
+/*
+ * Open a new VFIO container fd.
+ *
+ * If mp_request is true, requests a new container fd from the primary process
+ * via mp channel (for secondary processes that need to open the default container).
+ *
+ * Otherwise, opens a new container fd locally by opening /dev/vfio/vfio.
+ */
 int
-rte_vfio_get_container_fd(void)
+vfio_open_container_fd(bool mp_request)
 {
 	int ret, vfio_container_fd;
 	struct rte_mp_msg mp_req, *mp_rep;
 	struct rte_mp_reply mp_reply = {0};
 	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
 	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
 
-	/* if we're in a primary process, try to open the container */
-	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
+	/* if not requesting via mp, open a new container locally */
+	if (!mp_request) {
 		vfio_container_fd = open(RTE_VFIO_CONTAINER_PATH, O_RDWR);
 		if (vfio_container_fd < 0) {
 			EAL_LOG(ERR, "Cannot open VFIO container %s, error %i (%s)",
@@ -1372,6 +1349,20 @@ rte_vfio_get_container_fd(void)
 	return -1;
 }
 
+RTE_EXPORT_SYMBOL(rte_vfio_get_container_fd)
+int
+rte_vfio_get_container_fd(void)
+{
+	/* Return the default container fd if VFIO is enabled.
+	 * The default container is set up during rte_vfio_enable().
+	 * This function does not create a new container.
+	 */
+	if (!default_vfio_cfg->vfio_enabled)
+		return -1;
+
+	return default_vfio_cfg->vfio_container_fd;
+}
+
 RTE_EXPORT_SYMBOL(rte_vfio_get_group_num)
 int
 rte_vfio_get_group_num(const char *sysfs_base,
@@ -2093,7 +2084,8 @@ rte_vfio_container_create(void)
 		return -1;
 	}
 
-	vfio_cfgs[i].vfio_container_fd = rte_vfio_get_container_fd();
+	/* Create a new container fd */
+	vfio_cfgs[i].vfio_container_fd = vfio_open_container_fd(false);
 	if (vfio_cfgs[i].vfio_container_fd < 0) {
 		EAL_LOG(NOTICE, "Fail to create a new VFIO container");
 		return -1;
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index 5c5742b429..89c4b5ba45 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -42,7 +42,7 @@ struct vfio_iommu_type {
 };
 
 /* get the vfio container that devices are bound to by default */
-int vfio_get_default_container_fd(void);
+int vfio_open_container_fd(bool mp_request);
 
 /* pick IOMMU type. returns a pointer to vfio_iommu_type or NULL for error */
 const struct vfio_iommu_type *
@@ -62,8 +62,7 @@ void vfio_mp_sync_cleanup(void);
 
 #define SOCKET_REQ_CONTAINER 0x100
 #define SOCKET_REQ_GROUP 0x200
-#define SOCKET_REQ_DEFAULT_CONTAINER 0x400
-#define SOCKET_REQ_IOMMU_TYPE 0x800
+#define SOCKET_REQ_IOMMU_TYPE 0x400
 #define SOCKET_OK 0x0
 #define SOCKET_NO_FD 0x1
 #define SOCKET_ERR 0xFF
diff --git a/lib/eal/linux/eal_vfio_mp_sync.c b/lib/eal/linux/eal_vfio_mp_sync.c
index 8230f3d24d..26096987c0 100644
--- a/lib/eal/linux/eal_vfio_mp_sync.c
+++ b/lib/eal/linux/eal_vfio_mp_sync.c
@@ -59,17 +59,6 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 			reply.fds[0] = fd;
 		}
 		break;
-	case SOCKET_REQ_DEFAULT_CONTAINER:
-		r->req = SOCKET_REQ_DEFAULT_CONTAINER;
-		fd = vfio_get_default_container_fd();
-		if (fd < 0)
-			r->result = SOCKET_ERR;
-		else {
-			r->result = SOCKET_OK;
-			reply.num_fds = 1;
-			reply.fds[0] = fd;
-		}
-		break;
 	case SOCKET_REQ_IOMMU_TYPE:
 	{
 		int iommu_type_id;
@@ -95,8 +84,6 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 	reply.len_param = sizeof(*r);
 
 	ret = rte_mp_reply(&reply, peer);
-	if (m->req == SOCKET_REQ_CONTAINER && fd >= 0)
-		close(fd);
 	return ret;
 }
 
-- 
2.47.3

