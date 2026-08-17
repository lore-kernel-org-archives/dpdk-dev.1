Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA501C5DF66
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 13:44:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE6E140685;
	Mon, 17 Aug 2026 15:44:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 91E154021F;
 Mon, 17 Aug 2026 15:44:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786974282; x=1818510282;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=upYfvdtlrgwbCdVcR/m7cigq2fYA5MrQp7GJ/xoCp+Y=;
 b=YFrVLYwgPUMICubgkeeFhZno8Cjfxi20VDzMlWYr4OhUfvpMRJHAQTGW
 4Q1DeadEJZNGSYA1Q8uPcOdQPgD1OfMkRjUDLvyasiC6U6D/BhQqIw47d
 WORcUexqNg7nN7sJe8n8YFF7LPcBKl4EfUMAlGZxlWrIx7YgRMUZOzkyZ
 21SaGF6EaZeXbBdUxnmL6/q0N3aNiY69LaMq1EQRaUzpXtI3a4z6QAu/e
 SxxiSk/C/+FqDgSvcqCD1x36CU1vU2lTS6Pd9u8wBzEuvCjka4y/srca6
 GBSHkxUEat/q/Z1cdhARvJR65oOKs4oSsM4E9xodHHISfqi4IB48dCh4J g==;
X-CSE-ConnectionGUID: UQJw5rAyRDCxpveZj7ukrw==
X-CSE-MsgGUID: xqQiTWkNToOOgH2M00HMug==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104831502"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="104831502"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 06:44:41 -0700
X-CSE-ConnectionGUID: LdgLfc4OSt2lhVmNUOutFw==
X-CSE-MsgGUID: B4f25NL7Q7CiGULIIoauhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="263165829"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 17 Aug 2026 06:44:40 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v2 3/3] vhost: remove use of strncpy
Date: Mon, 17 Aug 2026 14:42:42 +0100
Message-ID: <20260817134432.1206297-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817134432.1206297-1-bruce.richardson@intel.com>
References: <20260623141930.704771-1-bruce.richardson@intel.com>
 <20260817134432.1206297-1-bruce.richardson@intel.com>
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

The strlcpy is preferred over use of strncpy, which removes the need to
try and explicitly null-terminate some string buffers. We can also
simplify some name length handling as a result of this, as we no longer
need to use strnlen to clamp the length before calling the set_ifname
function.

Fixes: a277c7159876 ("vhost: refactor code structure")
Fixes: 0adb8eccc6a6 ("vhost: add VDUSE device creation and destruction")
Fixes: c171a2d5ff17 ("vhost: use strlcpy instead of strncpy")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/vhost/socket.c |  4 +---
 lib/vhost/vduse.c  |  2 +-
 lib/vhost/vhost.c  | 12 +++---------
 lib/vhost/vhost.h  |  2 +-
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
index 70e582a18d..0943b3e9bb 100644
--- a/lib/vhost/socket.c
+++ b/lib/vhost/socket.c
@@ -207,7 +207,6 @@ static void
 vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 {
 	int vid;
-	size_t size;
 	struct vhost_user_connection *conn;
 	int ret;
 	struct virtio_net *dev;
@@ -226,8 +225,7 @@ vhost_user_add_connection(int fd, struct vhost_user_socket *vsocket)
 		goto err;
 	}
 
-	size = strnlen(vsocket->path, PATH_MAX);
-	vhost_set_ifname(vid, vsocket->path, size);
+	vhost_set_ifname(vid, vsocket->path);
 
 	vhost_setup_virtio_net(vid, vsocket->use_builtin_virtio_net,
 		vsocket->net_compliant_ol_flags, vsocket->stats_enabled,
diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
index 0b5d158fee..f8a4a8edcb 100644
--- a/lib/vhost/vduse.c
+++ b/lib/vhost/vduse.c
@@ -796,7 +796,7 @@ vduse_device_create(const char *path, bool compliant_ol_flags, bool extbuf, bool
 		goto out_dev_destroy;
 	}
 
-	strncpy(dev->ifname, path, IF_NAME_SZ - 1);
+	strlcpy(dev->ifname, path, sizeof(dev->ifname));
 	dev->vduse_ctrl_fd = control_fd;
 	dev->vduse_dev_fd = dev_fd;
 
diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 7e68b2c3be..fde8acb00c 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -776,20 +776,15 @@ vhost_attach_vdpa_device(int vid, struct rte_vdpa_device *vdpa_dev)
 }
 
 void
-vhost_set_ifname(int vid, const char *if_name, unsigned int if_len)
+vhost_set_ifname(int vid, const char *if_name)
 {
 	struct virtio_net *dev;
-	unsigned int len;
 
 	dev = get_device(vid);
 	if (dev == NULL)
 		return;
 
-	len = if_len > sizeof(dev->ifname) ?
-		sizeof(dev->ifname) : if_len;
-
-	strncpy(dev->ifname, if_name, len);
-	dev->ifname[sizeof(dev->ifname) - 1] = '\0';
+	strlcpy(dev->ifname, if_name, sizeof(dev->ifname));
 }
 
 void
@@ -915,8 +910,7 @@ rte_vhost_get_ifname(int vid, char *buf, size_t len)
 
 	len = RTE_MIN(len, sizeof(dev->ifname));
 
-	strncpy(buf, dev->ifname, len);
-	buf[len - 1] = '\0';
+	strlcpy(buf, dev->ifname, len);
 
 	return 0;
 }
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index ee61f7415e..1c957d2929 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -877,7 +877,7 @@ int alloc_vring_queue(struct virtio_net *dev, uint32_t vring_idx);
 
 void vhost_attach_vdpa_device(int vid, struct rte_vdpa_device *dev);
 
-void vhost_set_ifname(int, const char *if_name, unsigned int if_len);
+void vhost_set_ifname(int, const char *if_name);
 void vhost_setup_virtio_net(int vid, bool enable, bool legacy_ol_flags, bool stats_enabled,
 	bool support_iommu);
 void vhost_enable_extbuf(int vid);
-- 
2.53.0

