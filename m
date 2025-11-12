Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7722ECCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D256540676;
	Wed, 12 Nov 2025 10:11:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 48AF24066E
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:11:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762938674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJD5aM3GrVv9KadhLAh7gpj53FEu1hanJq8CFlf9fTo=;
 b=ExYzgY9AwUZEdbHpt6aLODPWdSVr65Wfrgusn6etzMPiGDLFLbNqy1vXfgCCnE+o/3Kcv0
 QFL7XvtXaFqfhcnUWzjmtMSoQrg4LyBwS9urojJQ8BRc5tMrOCQLRK6nxD8wHI90Mo70PA
 xcziD9gzfJw1xp1MHVeTl3Pi1XAYmvk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-qS_Sqy4JOXCb-ejR3jrNfQ-1; Wed,
 12 Nov 2025 04:11:09 -0500
X-MC-Unique: qS_Sqy4JOXCb-ejR3jrNfQ-1
X-Mimecast-MFC-AGG-ID: qS_Sqy4JOXCb-ejR3jrNfQ_1762938668
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B13C1956089; Wed, 12 Nov 2025 09:11:08 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.34.108])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6409018009A1; Wed, 12 Nov 2025 09:11:06 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, maxime@leroys.fr,
 Sachin Saxena <sachin.saxena@nxp.com>, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 1/5] crypto/dpaa2_sec: remove crypto device in bus device
Date: Wed, 12 Nov 2025 10:10:44 +0100
Message-ID: <20251112091049.2669481-2-david.marchand@redhat.com>
In-Reply-To: <20251112091049.2669481-1-david.marchand@redhat.com>
References: <20251108153207.1512863-1-david.marchand@redhat.com>
 <20251112091049.2669481-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mWlANko7UqYJSCGsf5fcyCX0bNeBwiP_8h4FyLmHBUQ_1762938668
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

Calling rte_cryptodev_pmd_get_named_dev() is enough to retrieve the
crypto device object.

This leaves no user of the cryptodev field in the fslmc device object.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h        | 1 -
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 8 +++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index b6a6238a01..45c7a519f9 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -99,7 +99,6 @@ struct rte_dpaa2_device {
 	struct rte_device device;           /**< Inherit core device */
 	union {
 		struct rte_eth_dev *eth_dev;        /**< ethernet device */
-		struct rte_cryptodev *cryptodev;    /**< Crypto Device */
 		struct rte_dma_dev *dmadev;          /**< DMA Device */
 		struct rte_rawdev *rawdev;          /**< Raw Device */
 	};
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index ca10d88da7..698548e6ea 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4503,8 +4503,6 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *dpaa2_drv __rte_unused,
 		return -ENOMEM;
 	}
 
-	dpaa2_dev->cryptodev = cryptodev;
-
 	if (dpaa2_svr_family == SVR_LX2160A)
 		rta_set_sec_era(RTA_SEC_ERA_10);
 	else
@@ -4526,10 +4524,14 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *dpaa2_drv __rte_unused,
 static int
 cryptodev_dpaa2_sec_remove(struct rte_dpaa2_device *dpaa2_dev)
 {
+	char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
 	struct rte_cryptodev *cryptodev;
 	int ret;
 
-	cryptodev = dpaa2_dev->cryptodev;
+	snprintf(cryptodev_name, sizeof(cryptodev_name), "dpsec-%d",
+			dpaa2_dev->object_id);
+
+	cryptodev = rte_cryptodev_pmd_get_named_dev(cryptodev_name);
 	if (cryptodev == NULL)
 		return -ENODEV;
 
-- 
2.51.0

