Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182DDC61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 09:45:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61E7740655;
	Wed, 11 Jun 2025 11:45:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0E73640659
 for <dev@dpdk.org>; Wed, 11 Jun 2025 11:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749635148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YF3G2smVOVArO0EEhUBmwUFONk9NUayAg7zbsNzah3s=;
 b=ZY1mL9Xv5nFHhAOB7mdVyvYL8dbzDfB8bfY18/j7h76GwXBoOR0vdJEI8c1iP12Twic+XP
 AnkBUnamKlJ7fjVd9P8bzqCpnzNuuTnPCgClb4XpxNkAPOB8ofT5rSVJAuvYA+IBvM2q9b
 cSCuu+XHCQ1O9Cm15xNwPtpt5gFnJAo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-vORZrY3vO8u34jdYvTrG9A-1; Wed,
 11 Jun 2025 05:45:45 -0400
X-MC-Unique: vORZrY3vO8u34jdYvTrG9A-1
X-Mimecast-MFC-AGG-ID: vORZrY3vO8u34jdYvTrG9A_1749635144
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55CD719560BD; Wed, 11 Jun 2025 09:45:44 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 332051956087; Wed, 11 Jun 2025 09:45:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v7 1/5] dev: hide driver export macros
Date: Wed, 11 Jun 2025 11:45:28 +0200
Message-ID: <20250611094532.1242167-2-david.marchand@redhat.com>
In-Reply-To: <20250611094532.1242167-1-david.marchand@redhat.com>
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250611094532.1242167-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aw6tY-xAGLfU4OPNiJlLJTK5z2-zIovjkjCSsRx_6BM_1749635144
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

The macros for tagging/exporting informations about a driver do not need
to be exported in the public API.
Move this to driver only header.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/include/dev_driver.h | 41 ++++++++++++++++++++++++++++++++++++
 lib/eal/include/rte_dev.h    | 41 ------------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/lib/eal/include/dev_driver.h b/lib/eal/include/dev_driver.h
index c07d83a43a..22e48226f9 100644
--- a/lib/eal/include/dev_driver.h
+++ b/lib/eal/include/dev_driver.h
@@ -30,4 +30,45 @@ struct rte_device {
 	struct rte_devargs *devargs;  /**< Arguments for latest probing */
 };
 
+#define RTE_PMD_EXPORT_NAME_ARRAY(n, idx) n##idx[]
+
+#define RTE_PMD_EXPORT_NAME(name, idx) \
+static const char RTE_PMD_EXPORT_NAME_ARRAY(this_pmd_name, idx) \
+__rte_used = RTE_STR(name)
+
+#define DRV_EXP_TAG(name, tag) __##name##_##tag
+
+#define RTE_PMD_REGISTER_PCI_TABLE(name, table) \
+static const char DRV_EXP_TAG(name, pci_tbl_export)[] __rte_used = \
+RTE_STR(table)
+
+#define RTE_PMD_REGISTER_PARAM_STRING(name, str) \
+static const char DRV_EXP_TAG(name, param_string_export)[] \
+__rte_used = str
+
+/**
+ * Advertise the list of kernel modules required to run this driver
+ *
+ * This string lists the kernel modules required for the devices
+ * associated to a PMD. The format of each line of the string is:
+ * "<device-pattern> <kmod-expression>".
+ *
+ * The possible formats for the device pattern are:
+ *   "*"                     all devices supported by this driver
+ *   "pci:*"                 all PCI devices supported by this driver
+ *   "pci:v8086:d*:sv*:sd*"  all PCI devices supported by this driver
+ *                           whose vendor id is 0x8086.
+ *
+ * The format of the kernel modules list is a parenthesized expression
+ * containing logical-and (&) and logical-or (|).
+ *
+ * The device pattern and the kmod expression are separated by a space.
+ *
+ * Example:
+ * - "* igb_uio | uio_pci_generic | vfio"
+ */
+#define RTE_PMD_REGISTER_KMOD_DEP(name, str) \
+static const char DRV_EXP_TAG(name, kmod_dep_export)[] \
+__rte_used = str
+
 #endif /* DEV_DRIVER_H */
diff --git a/lib/eal/include/rte_dev.h b/lib/eal/include/rte_dev.h
index 738400e8d1..7eca5e8cf2 100644
--- a/lib/eal/include/rte_dev.h
+++ b/lib/eal/include/rte_dev.h
@@ -232,47 +232,6 @@ int rte_dev_remove(struct rte_device *dev);
  */
 typedef int (*rte_dev_cmp_t)(const struct rte_device *dev, const void *data);
 
-#define RTE_PMD_EXPORT_NAME_ARRAY(n, idx) n##idx[]
-
-#define RTE_PMD_EXPORT_NAME(name, idx) \
-static const char RTE_PMD_EXPORT_NAME_ARRAY(this_pmd_name, idx) \
-__rte_used = RTE_STR(name)
-
-#define DRV_EXP_TAG(name, tag) __##name##_##tag
-
-#define RTE_PMD_REGISTER_PCI_TABLE(name, table) \
-static const char DRV_EXP_TAG(name, pci_tbl_export)[] __rte_used = \
-RTE_STR(table)
-
-#define RTE_PMD_REGISTER_PARAM_STRING(name, str) \
-static const char DRV_EXP_TAG(name, param_string_export)[] \
-__rte_used = str
-
-/**
- * Advertise the list of kernel modules required to run this driver
- *
- * This string lists the kernel modules required for the devices
- * associated to a PMD. The format of each line of the string is:
- * "<device-pattern> <kmod-expression>".
- *
- * The possible formats for the device pattern are:
- *   "*"                     all devices supported by this driver
- *   "pci:*"                 all PCI devices supported by this driver
- *   "pci:v8086:d*:sv*:sd*"  all PCI devices supported by this driver
- *                           whose vendor id is 0x8086.
- *
- * The format of the kernel modules list is a parenthesized expression
- * containing logical-and (&) and logical-or (|).
- *
- * The device pattern and the kmod expression are separated by a space.
- *
- * Example:
- * - "* igb_uio | uio_pci_generic | vfio"
- */
-#define RTE_PMD_REGISTER_KMOD_DEP(name, str) \
-static const char DRV_EXP_TAG(name, kmod_dep_export)[] \
-__rte_used = str
-
 /**
  * Iteration context.
  *
-- 
2.49.0

