Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE66CFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 13:56:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67EFE402BC;
	Fri, 28 Nov 2025 14:56:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6370A4013F
 for <dev@dpdk.org>; Fri, 28 Nov 2025 14:56:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZ1Ws9H8hTGbNrSL89W4zNizAGD/ZICqes28zMTyP8Y=;
 b=dNCPZZPyi4ukcDquKtv1be96hhawqUFeWqWdSCgt//Y5417W2zxBX6xboBc5G1pep/UHwL
 7AdgZf8o9kljhB74C41q312ezw/Wyg48aCOzV0XkKEGXjd49zyz+a9JwwtUnvEbYIEVM2d
 PL/W+nNhe9jxadTZicxsgMuNXAD2sVA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-8JKRb9-cNAefRru77tJESA-1; Fri,
 28 Nov 2025 08:56:37 -0500
X-MC-Unique: 8JKRb9-cNAefRru77tJESA-1
X-Mimecast-MFC-AGG-ID: 8JKRb9-cNAefRru77tJESA_1764338196
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 440AE1955F11; Fri, 28 Nov 2025 13:56:36 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.89])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FC0D1800451; Fri, 28 Nov 2025 13:56:32 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Kai Ji <kai.ji@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 Brian Dooley <brian.dooley@intel.com>,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Subject: [PATCH 3/7] drivers: fix some const pointers in qat drivers
Date: Fri, 28 Nov 2025 14:56:11 +0100
Message-ID: <20251128135616.2662164-4-david.marchand@redhat.com>
In-Reply-To: <20251128135616.2662164-1-david.marchand@redhat.com>
References: <20251128135616.2662164-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sJz3xA9uTeNoYPIgX5OtBwEhx06oZoPiIilxAGUv9vk_1764338196
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

With latest glibc (Fedora Rawhide):
../drivers/common/qat/qat_device.c: In function 'qat_dev_cmdline_get_val':
../drivers/common/qat/qat_device.c:183:43: warning: return discards 'const'
	qualifier from pointer target type [-Wdiscarded-qualifiers]
  183 |         return key ? strchr(key, '=') + 1 : NULL;
      |                                           ^
../drivers/common/qat/qat_device.c: In function 'cmdline_validate':
../drivers/common/qat/qat_device.c:189:25: warning: initialization discards
	'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  189 |         char *eq_sign = strchr(arg, '=');
      |                         ^~~~~~

Fixes: 99ab2806687b ("common/qat: isolate parser arguments configuration")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/common/qat/qat_device.c     | 7 ++++---
 drivers/common/qat/qat_device.h     | 2 +-
 drivers/compress/qat/qat_comp_pmd.c | 2 +-
 drivers/crypto/qat/qat_asym.c       | 2 +-
 drivers/crypto/qat/qat_sym.c        | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_device.c
index b582e3bf8b..07a8b19583 100644
--- a/drivers/common/qat/qat_device.c
+++ b/drivers/common/qat/qat_device.c
@@ -173,7 +173,7 @@ wireless_slice_support(uint16_t pci_dev_id)
  * other than the equals sign is ignored. It will not work with other conversion
  * functions like strt*.
  */
-char *qat_dev_cmdline_get_val(struct qat_pci_device *qat_dev,
+const char *qat_dev_cmdline_get_val(struct qat_pci_device *qat_dev,
 	const char *key)
 {
 	if (qat_dev->command_line == NULL)
@@ -185,8 +185,9 @@ char *qat_dev_cmdline_get_val(struct qat_pci_device *qat_dev,
 
 static int cmdline_validate(const char *arg)
 {
+	const char *eq_sign = strchr(arg, '=');
 	int i, len;
-	char *eq_sign = strchr(arg, '=');
+
 	/* Check for the equal sign */
 	if (eq_sign == NULL) {
 		QAT_LOG(ERR, "malformed string, no equals sign, %s", arg);
@@ -263,7 +264,7 @@ qat_pci_device_allocate(struct rte_pci_device *pci_dev)
 	struct rte_mem_resource *mem_resource;
 	const struct rte_memzone *qat_dev_mz;
 	int qat_dev_size, extra_size;
-	char *cmdline = NULL;
+	const char *cmdline = NULL;
 
 	rte_pci_device_name(&pci_dev->addr, name, sizeof(name));
 	snprintf(name+strlen(name), QAT_DEV_NAME_MAX_LEN-strlen(name), "_qat");
diff --git a/drivers/common/qat/qat_device.h b/drivers/common/qat/qat_device.h
index f5ba1592c3..34937e963e 100644
--- a/drivers/common/qat/qat_device.h
+++ b/drivers/common/qat/qat_device.h
@@ -42,7 +42,7 @@ typedef int (*qat_dev_get_extra_size_t)(void);
 typedef int (*qat_dev_get_slice_map_t)(uint32_t *map,
 		const struct rte_pci_device *pci_dev);
 
-char *qat_dev_cmdline_get_val(struct qat_pci_device *qat_dev, const char *key);
+const char *qat_dev_cmdline_get_val(struct qat_pci_device *qat_dev, const char *key);
 
 struct qat_dev_hw_spec_funcs {
 	qat_dev_reset_ring_pairs_t	qat_dev_reset_ring_pairs;
diff --git a/drivers/compress/qat/qat_comp_pmd.c b/drivers/compress/qat/qat_comp_pmd.c
index 55e510c91f..92dac79423 100644
--- a/drivers/compress/qat/qat_comp_pmd.c
+++ b/drivers/compress/qat/qat_comp_pmd.c
@@ -690,7 +690,7 @@ qat_comp_dev_create(struct qat_pci_device *qat_pci_dev)
 			&qat_comp_gen_dev_ops[qat_pci_dev->qat_dev_gen];
 	uint64_t capa_size;
 	uint16_t sub_id = qat_dev_instance->pci_dev->id.subsystem_device_id;
-	char *cmdline = NULL;
+	const char *cmdline = NULL;
 
 	snprintf(name, RTE_COMPRESSDEV_NAME_MAX_LEN, "%s_%s",
 			qat_pci_dev->name, "comp");
diff --git a/drivers/crypto/qat/qat_asym.c b/drivers/crypto/qat/qat_asym.c
index 8808337551..06f037cc14 100644
--- a/drivers/crypto/qat/qat_asym.c
+++ b/drivers/crypto/qat/qat_asym.c
@@ -1697,7 +1697,7 @@ qat_asym_dev_create(struct qat_pci_device *qat_pci_dev)
 	char name[RTE_CRYPTODEV_NAME_MAX_LEN];
 	char capa_memz_name[RTE_CRYPTODEV_NAME_MAX_LEN];
 	uint16_t sub_id = qat_dev_instance->pci_dev->id.subsystem_device_id;
-	char *cmdline = NULL;
+	const char *cmdline = NULL;
 
 	snprintf(name, RTE_CRYPTODEV_NAME_MAX_LEN, "%s_%s",
 			qat_pci_dev->name, "asym");
diff --git a/drivers/crypto/qat/qat_sym.c b/drivers/crypto/qat/qat_sym.c
index d979ae6489..83f1084030 100644
--- a/drivers/crypto/qat/qat_sym.c
+++ b/drivers/crypto/qat/qat_sym.c
@@ -217,7 +217,7 @@ qat_sym_dev_create(struct qat_pci_device *qat_pci_dev)
 	const struct qat_crypto_gen_dev_ops *gen_dev_ops =
 		&qat_sym_gen_dev_ops[qat_pci_dev->qat_dev_gen];
 	uint16_t sub_id = qat_dev_instance->pci_dev->id.subsystem_device_id;
-	char *cmdline = NULL;
+	const char *cmdline = NULL;
 
 	snprintf(name, RTE_CRYPTODEV_NAME_MAX_LEN, "%s_%s",
 			qat_pci_dev->name, "sym");
-- 
2.51.1

