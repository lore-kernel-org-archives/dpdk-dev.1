Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0431CCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:33:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E5C642E46;
	Wed,  7 Oct 2026 09:33:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 38AC542E46
 for <dev@dpdk.org>; Wed,  7 Oct 2026 09:33:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791358397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NdQ3D0HyvAGq6PDeDL2wW5SJ1xKwL30poxRYYJe4H8A=;
 b=WHxnzOmfsLp1mnumkioyAghLZBakN2TJIQ1N+PjfejDNHntDpQOZ6e4j8jbwgpZop3gPUy
 hm1D8x+3xaOvWDht2FqwNCAFL/3TLO4opl6iOYaYDreUWnrv6VKhT33JbA+p3Mj0h7UDdO
 pOJrSv9SNAA0IpO20gl1O8ELL/1g+gk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-a48oXeTmMJubkGrdqK67rQ-1; Wed,
 07 Oct 2026 03:33:14 -0400
X-MC-Unique: a48oXeTmMJubkGrdqK67rQ-1
X-Mimecast-MFC-AGG-ID: a48oXeTmMJubkGrdqK67rQ_1791358393
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D86D195C272; Wed,  7 Oct 2026 07:33:13 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABF961800581; Wed,  7 Oct 2026 07:33:11 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [PATCH v19 16/26] vhost: remove group-related API from driver
Date: Wed,  7 Oct 2026 09:31:54 +0200
Message-ID: <20261007073206.567001-17-david.marchand@redhat.com>
In-Reply-To: <20261007073206.567001-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007073206.567001-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 407DmfMID2tt6gJgfjUYK5vM5DoYg-uAuRQQgm8oKZ4_1791358393
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

The vDPA driver API has "get_vfio_group_fd" in its ops structure, but no
driver is using it any more, as better API's were added and implemented.
Remove this API from vDPA ops structure.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
Changes since v18:
- squashed vdpa/mlx5 update,

---
 doc/guides/prog_guide/vhost_lib.rst    | 4 ----
 doc/guides/rel_notes/deprecation.rst   | 4 ----
 doc/guides/rel_notes/release_26_11.rst | 3 +++
 drivers/vdpa/mlx5/mlx5_vdpa.c          | 1 -
 lib/vhost/vdpa_driver.h                | 3 ---
 5 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/doc/guides/prog_guide/vhost_lib.rst b/doc/guides/prog_guide/vhost_lib.rst
index 345a621716..99355b8afd 100644
--- a/doc/guides/prog_guide/vhost_lib.rst
+++ b/doc/guides/prog_guide/vhost_lib.rst
@@ -471,10 +471,6 @@ Finally, a set of device ops is defined for device specific operations:
 
   Called to allow the device to respond to RARP sending.
 
-* ``get_vfio_group_fd``
-
-   Called to get the VFIO group fd of the device.
-
 * ``get_vfio_device_fd``
 
   Called to get the VFIO device fd of the device.
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index fad4ffc72c..49ee85fa4e 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -29,10 +29,6 @@ Deprecation Notices
   Use the ``-S <service-corelist>`` parameter instead
   to specify the cores to be used for background services in DPDK.
 
-* vdpa: The vDPA driver API will no longer offer ``get_vfio_group_fd``
-  as part of its internal API. All drivers will be adjusted
-  to use the new unified VFIO container device assignment API.
-
 * rte_smp_*mb: These APIs provide full barrier functionality. However, many
   use cases do not require full barriers. To support such use cases, DPDK has
   adopted atomic operations from
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dd9c7bf514..39d36b2279 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -317,6 +317,9 @@ API Changes
   ``rte_reorder_seqn``, ``rte_reorder_drain_up_to_seqn``,
   ``rte_reorder_min_seqn_set`` and ``rte_reorder_memory_footprint_get``.
 
+* vhost: Removed ``get_vfio_group_fd`` from ``struct rte_vdpa_dev_ops``.
+  vDPA drivers should now use the VFIO container device assignment API.
+
 * telemetry: Promoted the following API from experimental to stable:
 
   * ``rte_tel_data_add_array_uint_hex``
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.c b/drivers/vdpa/mlx5/mlx5_vdpa.c
index 11708e2005..1bb5de51b6 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa.c
@@ -523,7 +523,6 @@ static struct rte_vdpa_dev_ops mlx5_vdpa_ops = {
 	.set_vring_state = mlx5_vdpa_set_vring_state,
 	.set_features = mlx5_vdpa_features_set,
 	.migration_done = NULL,
-	.get_vfio_group_fd = NULL,
 	.get_vfio_device_fd = mlx5_vdpa_get_device_fd,
 	.get_notify_area = mlx5_vdpa_get_notify_area,
 	.get_stats_names = mlx5_vdpa_get_stats_names,
diff --git a/lib/vhost/vdpa_driver.h b/lib/vhost/vdpa_driver.h
index 42392a0d14..c7b9be09fb 100644
--- a/lib/vhost/vdpa_driver.h
+++ b/lib/vhost/vdpa_driver.h
@@ -50,9 +50,6 @@ struct rte_vdpa_dev_ops {
 	/** Destination operations when migration done */
 	int (*migration_done)(int vid);
 
-	/** Get the vfio group fd */
-	int (*get_vfio_group_fd)(int vid);
-
 	/** Get the vfio device fd */
 	int (*get_vfio_device_fd)(int vid);
 
-- 
2.54.0

