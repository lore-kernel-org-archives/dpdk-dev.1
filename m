Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F276CF2599
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 08:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E34D4029D;
	Wed, 19 Nov 2025 09:06:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2AECA40265
 for <dev@dpdk.org>; Wed, 19 Nov 2025 09:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763539607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H8FjPLIDjljq0lvQmwxZE7gsZKZNCD0nA2TTc6zSAPM=;
 b=aORsGczm/s8vu0VUh0wgXXW249dmWAmmTx6bGaochnUP9xET40kQhxnE+pekXPSgWRGNvv
 WWx2RH8DEg7rF4X5mnjCs9zDcb1/9lLR0bT5DHwRN6UK1H1zLrXXacFIWranGOfJ0I0jXX
 v7t2/Sr2gb1IyS7ZfoncswTGmDiUUOs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-YcaEY6JGM9aHcQ1i4xSYww-1; Wed,
 19 Nov 2025 03:06:46 -0500
X-MC-Unique: YcaEY6JGM9aHcQ1i4xSYww-1
X-Mimecast-MFC-AGG-ID: YcaEY6JGM9aHcQ1i4xSYww_1763539605
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91D57195609F; Wed, 19 Nov 2025 08:06:44 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.244])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEAE2180049F; Wed, 19 Nov 2025 08:06:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: maxime@leroys.fr, Gagandeep Singh <g.singh@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH] crypto/dpaa2_sec: use bus device name
Date: Wed, 19 Nov 2025 09:06:32 +0100
Message-ID: <20251119080633.25507-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O0ck90P_EW6G-SZHPdoZPVrqj3QA-NooxLuTf4NEuRk_1763539605
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

dpaa2_sec_dev_init() sets the crypto device name again after
it has been set by rte_cryptodev_pmd_create/allocate().
Overwritting its value could end up as a bug if the cryptodev
library changes the way it calls cryptodev objects.

Besides, there is no need to generate a name for the crypto device
different than the bus device, as there is a 1:1 relation between
those objects.

Reuse the bus device name directly, iow: dpseci.XXX instead of dpsec-XXX.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Note: this is a followup cleanup following Maxime comment, no pressure on
getting this merged for this release.

---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 698548e6ea..995e375fb5 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4456,8 +4456,6 @@ dpaa2_sec_dev_init(struct rte_cryptodev *cryptodev)
 			     retcode);
 		goto init_error;
 	}
-	snprintf(cryptodev->data->name, sizeof(cryptodev->data->name),
-			"dpsec-%u", hw_id);
 
 	internals->max_nb_queue_pairs = attr.num_tx_queues;
 	cryptodev->data->nb_queue_pairs = internals->max_nb_queue_pairs;
@@ -4482,7 +4480,6 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *dpaa2_drv __rte_unused,
 			  struct rte_dpaa2_device *dpaa2_dev)
 {
 	struct rte_cryptodev *cryptodev;
-	char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
 	int retval;
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
@@ -4493,10 +4490,7 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *dpaa2_drv __rte_unused,
 			/* setting default, will be updated in init. */
 	};
 
-	snprintf(cryptodev_name, sizeof(cryptodev_name), "dpsec-%d",
-			dpaa2_dev->object_id);
-
-	cryptodev = rte_cryptodev_pmd_create(cryptodev_name, &dpaa2_dev->device,
+	cryptodev = rte_cryptodev_pmd_create(dpaa2_dev->device.name, &dpaa2_dev->device,
 			&init_params);
 	if (cryptodev == NULL) {
 		DPAA2_SEC_ERR("failed to create cryptodev vdev");
@@ -4524,14 +4518,10 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *dpaa2_drv __rte_unused,
 static int
 cryptodev_dpaa2_sec_remove(struct rte_dpaa2_device *dpaa2_dev)
 {
-	char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
 	struct rte_cryptodev *cryptodev;
 	int ret;
 
-	snprintf(cryptodev_name, sizeof(cryptodev_name), "dpsec-%d",
-			dpaa2_dev->object_id);
-
-	cryptodev = rte_cryptodev_pmd_get_named_dev(cryptodev_name);
+	cryptodev = rte_cryptodev_pmd_get_named_dev(dpaa2_dev->device.name);
 	if (cryptodev == NULL)
 		return -ENODEV;
 
-- 
2.51.1

