Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE70CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:40:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A52A40B92;
	Wed, 14 Oct 2026 19:40:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1841140693
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791999638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sExffriHbLOdMFqYRwR2u8NJ9xKI/HB66z2yqfmZKbg=;
 b=ef3+mh+wPSvC2sGWOE+CWSXQZhcVUQKBphNe5dkNCQqFfWnSS/ljfbM/F2vtjbPImBqPTR
 3IzWO475PQm6K1XmWtx3KBmjjfsrYaLVclS8a91jCAounEUxyG3QoXifZifMzOYwmRFWuv
 X+NNpH+D7KsT+fJz+6Ah6WPmN30IMAo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-rjja0BT8PQi9aJrtq3Wwrw-1; Wed,
 14 Oct 2026 17:40:35 +0000
X-MC-Unique: rjja0BT8PQi9aJrtq3Wwrw-1
X-Mimecast-MFC-AGG-ID: rjja0BT8PQi9aJrtq3Wwrw_1791999634
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 530F71955DD9; Wed, 14 Oct 2026 17:40:34 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26A71433; Wed, 14 Oct 2026 17:40:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 08/16] bus/fslmc: fix some VFIO device FD and memory leaks
Date: Wed, 14 Oct 2026 19:39:51 +0200
Message-ID: <20261014174001.1830726-9-david.marchand@redhat.com>
In-Reply-To: <20261014174001.1830726-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ewTosSWQymTP8xXSjbZAx89o-9QSBLOl_ap7tx-GGLs_1791999634
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

In case VFIO_DEVICE_GET_INFO fails, the vfio_dev_fd was leaked.
In a similar way, failing to add this device FD in the group list would
result in leaking the FD.

When uninitialising a device or doing a bus cleanup, the per device VFIO
FD and the associated memory used for tracking it were leaked.

Fixes: 57cb02edf122 ("bus/fslmc: enhance MC VFIO multi-process support")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_vfio.c | 45 ++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 2a3d022d2e..10efd98e7b 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -217,13 +217,17 @@ static int
 fslmc_vfio_clear_group(int vfio_group_fd)
 {
 	struct fslmc_vfio_group *group;
-	struct fslmc_vfio_device *dev;
 	int clear = 0;
 
 	LIST_FOREACH(group, &s_vfio_container.groups, next) {
 		if (group->fd == vfio_group_fd) {
-			LIST_FOREACH(dev, &group->vfio_devices, next)
+			while (!LIST_EMPTY(&group->vfio_devices)) {
+				struct fslmc_vfio_device *dev = LIST_FIRST(&group->vfio_devices);
+
+				close(dev->fd);
 				LIST_REMOVE(dev, next);
+				rte_free(dev);
+			}
 
 			close(vfio_group_fd);
 			LIST_REMOVE(group, next);
@@ -323,6 +327,8 @@ fslmc_vfio_group_add_dev(int vfio_group_fd,
 		if (group->fd == vfio_group_fd) {
 			dev = rte_zmalloc(NULL,
 				sizeof(struct fslmc_vfio_device), 0);
+			if (dev == NULL)
+				return -ENOMEM;
 			dev->fd = dev_fd;
 			rte_strscpy(dev->dev_name, name, sizeof(dev->dev_name));
 			LIST_INSERT_HEAD(&group->vfio_devices, dev, next);
@@ -338,26 +344,25 @@ fslmc_vfio_group_remove_dev(int vfio_group_fd,
 {
 	struct fslmc_vfio_group *group = NULL;
 	struct fslmc_vfio_device *dev;
-	int removed = 0;
 
 	LIST_FOREACH(group, &s_vfio_container.groups, next) {
 		if (group->fd == vfio_group_fd)
 			break;
 	}
 
-	if (group) {
-		LIST_FOREACH(dev, &group->vfio_devices, next) {
-			if (!strcmp(dev->dev_name, name)) {
-				LIST_REMOVE(dev, next);
-				removed = 1;
-				break;
-			}
+	if (group == NULL)
+		goto err;
+
+	LIST_FOREACH(dev, &group->vfio_devices, next) {
+		if (strcmp(dev->dev_name, name) == 0) {
+			close(dev->fd);
+			LIST_REMOVE(dev, next);
+			rte_free(dev);
+			return 0;
 		}
 	}
 
-	if (removed)
-		return 0;
-
+err:
 	return -ENODEV;
 }
 
@@ -1251,11 +1256,21 @@ fslmc_vfio_setup_device(const char *dev_addr,
 	if (ret) {
 		DPAA2_BUS_ERR("%s cannot get device info err(%d)(%s)",
 			dev_addr, errno, strerror(errno));
+		close(*vfio_dev_fd);
+		*vfio_dev_fd = -1;
 		return ret;
 	}
 
-	return fslmc_vfio_group_add_dev(vfio_group_fd, *vfio_dev_fd,
-			dev_addr);
+	ret = fslmc_vfio_group_add_dev(vfio_group_fd, *vfio_dev_fd, dev_addr);
+	if (ret) {
+		DPAA2_BUS_ERR("%s cannot add device in group err(%d)(%s)",
+			dev_addr, ret, strerror(-ret));
+		close(*vfio_dev_fd);
+		*vfio_dev_fd = -1;
+		return ret;
+	}
+
+	return 0;
 }
 
 static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
-- 
2.54.0

