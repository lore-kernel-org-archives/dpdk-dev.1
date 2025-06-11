Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B4C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 09:46:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6495440665;
	Wed, 11 Jun 2025 11:46:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 35C1340649
 for <dev@dpdk.org>; Wed, 11 Jun 2025 11:46:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749635172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/KLCzk7QgH7Wr+Gm3YjtFjBzyfoLpNlavnEU69+eZ4=;
 b=ihXbFwRKLIAZCw2hsx+dn8BIBqb6h3xHOaOprvzhM4RKqubk3LuX/+bUY9/63fVN0/4fRa
 kuEQOLemQDyhd+L3TqTH25W6x8kGf0euf9g9eWRZPOnbaACFjZKZxOo8YNBw6mRidBp7LN
 yWKVt38S4uwLM9h9Q4A18+KvOtskgNc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-GxQJ-71IPBuevtOvWbEPvg-1; Wed,
 11 Jun 2025 05:46:07 -0400
X-MC-Unique: GxQJ-71IPBuevtOvWbEPvg-1
X-Mimecast-MFC-AGG-ID: GxQJ-71IPBuevtOvWbEPvg_1749635166
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42FA9180029D; Wed, 11 Jun 2025 09:46:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36D6A30002C3; Wed, 11 Jun 2025 09:46:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v7 3/5] dev: export driver information with MSVC
Date: Wed, 11 Jun 2025 11:45:30 +0200
Message-ID: <20250611094532.1242167-4-david.marchand@redhat.com>
In-Reply-To: <20250611094532.1242167-1-david.marchand@redhat.com>
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250611094532.1242167-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4JubV38eGrAE6Lqgb4mc_2VWCvzCkJ5rhoSDnDTYmaI_1749635166
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

From: Andre Muezerie <andremue@linux.microsoft.com>

DPDK uses GCC attribute "used" through macro __rte_used to indicate
that a variable not referenced in the code should be assumed being
used and therefore not be optimized away. This technique is used to embed
information in the binaries, by having crafted information stored in
them.

MSVC offers similar functionality, but it differs significantly: MSVC
requires a pragma to be used to send a command to the linker telling it
explicitly the name of the symbol that should be included (even if not
referenced). As a side-effect, variables called out to be included cannot
be static, otherwise their symbols are not "seen" by the linker. This
restriction requires some DPDK code to be refactored.

To assimilate these requirements/restrictions, a new macro
RTE_PMD_EXPORT_SYMBOL is added in this patch to ensure these special
variables make it to the final binaries.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/cdx/bus_cdx_driver.h    |  3 +--
 lib/eal/common/eal_common_options.c |  2 +-
 lib/eal/include/dev_driver.h        | 19 ++++++++++++-------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/cdx/bus_cdx_driver.h b/drivers/bus/cdx/bus_cdx_driver.h
index 4febf1fd3b..f0780a84ad 100644
--- a/drivers/bus/cdx/bus_cdx_driver.h
+++ b/drivers/bus/cdx/bus_cdx_driver.h
@@ -35,8 +35,7 @@ struct rte_cdx_bus;
 #define RTE_CDX_ANY_ID (0xffff)
 
 #define RTE_PMD_REGISTER_CDX_TABLE(name, table) \
-static const char DRV_EXP_TAG(name, cdx_tbl_export)[] __rte_used = \
-RTE_STR(table)
+RTE_PMD_EXPORT_SYMBOL(const char, DRV_EXP_TAG(name, cdx_tbl_export))[] = RTE_STR(table)
 
 /** Device needs resource mapping */
 #define RTE_CDX_DRV_NEED_MAPPING 0x0001
diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index b4f0e23a9c..83b6fc7e89 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -137,7 +137,7 @@ static const char *default_solib_dir = RTE_EAL_PMD_PATH;
  * Note: PLEASE DO NOT ALTER THIS without making a corresponding
  * change to usertools/dpdk-pmdinfo.py
  */
-static const char dpdk_solib_path[] __rte_used =
+RTE_PMD_EXPORT_SYMBOL(const char, dpdk_solib_path)[] =
 "DPDK_PLUGIN_PATH=" RTE_EAL_PMD_PATH;
 
 TAILQ_HEAD(device_option_list, device_option);
diff --git a/lib/eal/include/dev_driver.h b/lib/eal/include/dev_driver.h
index 7766038b1b..a2517ac1d4 100644
--- a/lib/eal/include/dev_driver.h
+++ b/lib/eal/include/dev_driver.h
@@ -30,18 +30,24 @@ struct rte_device {
 	struct rte_devargs *devargs;  /**< Arguments for latest probing */
 };
 
+#ifdef RTE_TOOLCHAIN_MSVC
+#define RTE_PMD_EXPORT_SYMBOL(type, name) \
+__pragma(comment(linker, "/include:" RTE_STR(name))) type name
+#else
+#define RTE_PMD_EXPORT_SYMBOL(type, name) \
+__attribute__((used)) type name
+#endif
+
 #define RTE_PMD_EXPORT_NAME(name) \
-static const char this_pmd_name ## name __rte_used = RTE_STR(name)
+RTE_PMD_EXPORT_SYMBOL(const char, this_pmd_name ## name)[] = RTE_STR(name)
 
 #define DRV_EXP_TAG(name, tag) __##name##_##tag
 
 #define RTE_PMD_REGISTER_PCI_TABLE(name, table) \
-static const char DRV_EXP_TAG(name, pci_tbl_export)[] __rte_used = \
-RTE_STR(table)
+RTE_PMD_EXPORT_SYMBOL(const char, DRV_EXP_TAG(name, pci_tbl_export))[] = RTE_STR(table)
 
 #define RTE_PMD_REGISTER_PARAM_STRING(name, str) \
-static const char DRV_EXP_TAG(name, param_string_export)[] \
-__rte_used = str
+RTE_PMD_EXPORT_SYMBOL(const char, DRV_EXP_TAG(name, param_string_export))[] = str
 
 /**
  * Advertise the list of kernel modules required to run this driver
@@ -65,7 +71,6 @@ __rte_used = str
  * - "* igb_uio | uio_pci_generic | vfio"
  */
 #define RTE_PMD_REGISTER_KMOD_DEP(name, str) \
-static const char DRV_EXP_TAG(name, kmod_dep_export)[] \
-__rte_used = str
+RTE_PMD_EXPORT_SYMBOL(const char, DRV_EXP_TAG(name, kmod_dep_export))[] = str
 
 #endif /* DEV_DRIVER_H */
-- 
2.49.0

