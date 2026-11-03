Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834E606A7B8
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uR/u/GAD
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51D7542E7E;
	Tue,  3 Nov 2026 16:18:23 +0100 (CET)
Received: from mta1.migadu.com (out-59.mta1.migadu.com [95.215.58.59])
 by mails.dpdk.org (Postfix) with ESMTPS id C4669427E0
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:18:21 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=uryErjYljC+oEODnoJI+VrQf5N3u5b6BalTTiurf5hM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719101; v=1; x=1794323901;
 b=uR/u/GAD+WdB+vEp4K7DcpIvxGWe9xLcuvW63lRhMe0NhzCAdAJ3HxbkONRi4e+EJsVReOb9
 J/WcwkHZjG+izRby1lYfhhSlACnqUTkFmt29+HOLEYmGu9rM1AtUoaaN2vVuNpiOom1pnOJci6j
 wGe2owPGdlHdK+oHMa10XD10=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id c0cbc888749d9a09;
 Tue, 03 Nov 2026 15:18:21 +0000
X-Mizu-Trace-ID: c0cbc888749d9a09
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 160/227] raw/dpaa2_cmdif: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:58 +0800
Message-ID: <20261103145306.487255-161-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c b/drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c
index 34a3c4f6af..fd3b3145c2 100644
--- a/drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c
+++ b/drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c
@@ -195,14 +195,14 @@ static const struct rte_rawdev_ops dpaa2_cmdif_ops = {
 static int
 dpaa2_cmdif_create(const char *name,
 		   struct rte_vdev_device *vdev,
-		   int socket_id)
+		   int numa_id)
 {
 	struct rte_rawdev *rawdev;
 	struct dpaa2_dpci_dev *cidev;
 
 	/* Allocate device structure */
 	rawdev = rte_rawdev_pmd_allocate(name, sizeof(struct dpaa2_dpci_dev),
-					 socket_id);
+					 numa_id);
 	if (!rawdev) {
 		DPAA2_CMDIF_ERR("Unable to allocate rawdevice");
 		return -EINVAL;
@@ -258,9 +258,9 @@ dpaa2_cmdif_probe(struct rte_vdev_device *vdev)
 
 	name = rte_vdev_device_name(vdev);
 
-	DPAA2_CMDIF_INFO("Init %s on NUMA node %d", name, rte_socket_id());
+	DPAA2_CMDIF_INFO("Init %s on NUMA node %d", name, rte_numa_id());
 
-	ret = dpaa2_cmdif_create(name, vdev, rte_socket_id());
+	ret = dpaa2_cmdif_create(name, vdev, rte_numa_id());
 
 	return ret;
 }
@@ -275,7 +275,7 @@ dpaa2_cmdif_remove(struct rte_vdev_device *vdev)
 	if (name == NULL)
 		return -1;
 
-	DPAA2_CMDIF_INFO("Closing %s on NUMA node %d", name, rte_socket_id());
+	DPAA2_CMDIF_INFO("Closing %s on NUMA node %d", name, rte_numa_id());
 
 	ret = dpaa2_cmdif_destroy(name);
 
-- 
2.55.0

