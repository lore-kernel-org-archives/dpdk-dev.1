Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1885FCD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 13:08:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 526C242D2B;
	Thu, 11 Jun 2026 15:08:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B3A2140041
 for <dev@dpdk.org>; Thu, 11 Jun 2026 15:08:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781183290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtqUKX/3FqAsKPvUS0AfAQfwLQk8ctw1UuXvGZ4vKyQ=;
 b=Li/u7YQSNW00HbX20cZ0I95iMLrvDOJI6i11JNTSGyQ55TlcjEhKBYuTGZatfMPbnaGaRJ
 gwXfU084ZstzIAvdZDdQsJCQIMKSrLPv2JbvXAcne3Kw0AFFhoEoeW9qvEUFeNCg/GtvMg
 rEz1gzZ1Ek0mi4ojRY7Uj6ak0d9fFYk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-N9tzUionOoK0mME8rA34tw-1; Thu,
 11 Jun 2026 09:08:06 -0400
X-MC-Unique: N9tzUionOoK0mME8rA34tw-1
X-Mimecast-MFC-AGG-ID: N9tzUionOoK0mME8rA34tw_1781183285
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0297D195D014; Thu, 11 Jun 2026 13:08:05 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B79C1800583; Thu, 11 Jun 2026 13:08:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, Sachin Saxena <sachin.saxena@nxp.com>,
 Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH 1/3] crypto/dpaa_sec: remove cryptodev pointer from bus device
Date: Thu, 11 Jun 2026 15:07:35 +0200
Message-ID: <20260611130738.1720628-2-david.marchand@redhat.com>
In-Reply-To: <20260611130738.1720628-1-david.marchand@redhat.com>
References: <20260611130738.1720628-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WW6z-xjl8mK8kQxRUyV_-fc_gJhhwFEFmoh3f3WJzdA_1781183285
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

This leaves no user of the crypto_dev field in the dpaa device object.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/dpaa/bus_dpaa_driver.h | 1 -
 drivers/crypto/dpaa_sec/dpaa_sec.c | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 5ddb52c419..6759792eea 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -82,7 +82,6 @@ struct rte_dpaa_device {
 	struct rte_device device;
 	union {
 		struct rte_eth_dev *eth_dev;
-		struct rte_cryptodev *crypto_dev;
 		struct rte_dma_dev *dmadev;
 	};
 	struct dpaa_device_id id;
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index 65bbd38b17..c53ee70853 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -3773,7 +3773,6 @@ cryptodev_dpaa_sec_probe(struct rte_dpaa_driver *dpaa_drv __rte_unused,
 				struct rte_dpaa_device *dpaa_dev)
 {
 	struct rte_cryptodev *cryptodev;
-	char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
 	int retval;
 	struct rte_cryptodev_pmd_init_params init_params = {
 		.name = "",
@@ -3786,14 +3785,11 @@ cryptodev_dpaa_sec_probe(struct rte_dpaa_driver *dpaa_drv __rte_unused,
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
-	snprintf(cryptodev_name, sizeof(cryptodev_name), "%s", dpaa_dev->name);
-
-	cryptodev = rte_cryptodev_pmd_create(cryptodev_name, &dpaa_dev->device, &init_params);
+	cryptodev = rte_cryptodev_pmd_create(dpaa_dev->name, &dpaa_dev->device, &init_params);
 	if (cryptodev == NULL) {
 		DPAA_SEC_ERR("failed to create cryptodev vdev");
 		return -ENOMEM;
 	}
-	dpaa_dev->crypto_dev = cryptodev;
 
 	/* if sec device version is not configured */
 	if (!rta_get_sec_era()) {
@@ -3839,7 +3835,7 @@ cryptodev_dpaa_sec_remove(struct rte_dpaa_device *dpaa_dev)
 	struct rte_cryptodev *cryptodev;
 	int ret;
 
-	cryptodev = dpaa_dev->crypto_dev;
+	cryptodev = rte_cryptodev_pmd_get_named_dev(dpaa_dev->name);
 	if (cryptodev == NULL)
 		return -ENODEV;
 
-- 
2.53.0

