Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EDECA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 15:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E465240E2D;
	Wed,  3 Sep 2025 17:18:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7C00C40E2B
 for <dev@dpdk.org>; Wed,  3 Sep 2025 17:18:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756912697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxhhjJ3J3m7a+cZCy9ht7AKjaMIMR8EwY82bepJwZ+0=;
 b=gugM8IXTLUR1GWspwwoeu11TdpxO5nm8iVrViMQxvecBI8WU9o1RCKdcgGXeFnogBsRzqm
 +Qg7xBE/AWXwUSjO1W5LaO2WCtC/yQ8mW4W/k695UYBEy2aduvGwYHz71BcFMJLhZo01OX
 ZIUkEH2F70SabOAzudLAS+fxotJaIBY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-kDAXR1D8NIGEWHcvenRMpg-1; Wed,
 03 Sep 2025 11:18:14 -0400
X-MC-Unique: kDAXR1D8NIGEWHcvenRMpg-1
X-Mimecast-MFC-AGG-ID: kDAXR1D8NIGEWHcvenRMpg_1756912692
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79C02195608B; Wed,  3 Sep 2025 15:18:12 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F37A19560B8; Wed,  3 Sep 2025 15:18:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com,
 Kai Ji <kai.ji@intel.com>, Dengdui Huang <huangdengdui@huawei.com>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [RFC v2 1/9] drivers: remove unneeded VFIO header inclusion
Date: Wed,  3 Sep 2025 17:17:51 +0200
Message-ID: <20250903151800.1965006-2-david.marchand@redhat.com>
In-Reply-To: <20250903151800.1965006-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151800.1965006-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2fv8W3xhWW6lMAiIQ52huUCplhcTNTKaPpjCbnxVN4k_1756912692
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

Those drivers sources do nothing related to VFIO.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/common/qat/dev/qat_dev_gen_lce.c | 4 ----
 drivers/net/hns3/hns3_ethdev_vf.c        | 1 -
 drivers/raw/ifpga/afu_pmd_he_hssi.c      | 1 -
 drivers/raw/ifpga/afu_pmd_he_lpbk.c      | 1 -
 drivers/raw/ifpga/afu_pmd_he_mem.c       | 1 -
 5 files changed, 8 deletions(-)

diff --git a/drivers/common/qat/dev/qat_dev_gen_lce.c b/drivers/common/qat/dev/qat_dev_gen_lce.c
index 6514321c32..9173b6c681 100644
--- a/drivers/common/qat/dev/qat_dev_gen_lce.c
+++ b/drivers/common/qat/dev/qat_dev_gen_lce.c
@@ -3,7 +3,6 @@
  */
 
 #include <rte_pci.h>
-#include <rte_vfio.h>
 
 #include "qat_device.h"
 #include "qat_qp.h"
@@ -17,9 +16,6 @@
 
 #define BITS_PER_ULONG		(sizeof(unsigned long) * 8)
 
-#define VFIO_PCI_LCE_DEVICE_CFG_REGION_INDEX	VFIO_PCI_NUM_REGIONS
-#define VFIO_PCI_LCE_CY_CFG_REGION_INDEX	(VFIO_PCI_NUM_REGIONS + 2)
-#define VFIO_PCI_LCE_RING_CFG_REGION_INDEX	(VFIO_PCI_NUM_REGIONS + 4)
 #define LCE_DEVICE_NAME_SIZE			64
 #define LCE_DEVICE_MAX_BANKS			2080
 #define LCE_DIV_ROUND_UP(n, d)  (((n) + (d) - 1) / (d))
diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
index f9ef3dbb06..59fb790240 100644
--- a/drivers/net/hns3/hns3_ethdev_vf.c
+++ b/drivers/net/hns3/hns3_ethdev_vf.c
@@ -5,7 +5,6 @@
 #include <rte_alarm.h>
 #include <ethdev_pci.h>
 #include <rte_io.h>
-#include <rte_vfio.h>
 
 #include "hns3_ethdev.h"
 #include "hns3_common.h"
diff --git a/drivers/raw/ifpga/afu_pmd_he_hssi.c b/drivers/raw/ifpga/afu_pmd_he_hssi.c
index 859f28dcc1..bcb952935a 100644
--- a/drivers/raw/ifpga/afu_pmd_he_hssi.c
+++ b/drivers/raw/ifpga/afu_pmd_he_hssi.c
@@ -17,7 +17,6 @@
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <rte_io.h>
-#include <rte_vfio.h>
 #include <bus_pci_driver.h>
 #include <bus_ifpga_driver.h>
 #include <rte_rawdev.h>
diff --git a/drivers/raw/ifpga/afu_pmd_he_lpbk.c b/drivers/raw/ifpga/afu_pmd_he_lpbk.c
index c7c5cda48c..df3b093157 100644
--- a/drivers/raw/ifpga/afu_pmd_he_lpbk.c
+++ b/drivers/raw/ifpga/afu_pmd_he_lpbk.c
@@ -17,7 +17,6 @@
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <rte_io.h>
-#include <rte_vfio.h>
 #include <bus_pci_driver.h>
 #include <bus_ifpga_driver.h>
 #include <rte_rawdev.h>
diff --git a/drivers/raw/ifpga/afu_pmd_he_mem.c b/drivers/raw/ifpga/afu_pmd_he_mem.c
index a1db533eeb..b595cd729c 100644
--- a/drivers/raw/ifpga/afu_pmd_he_mem.c
+++ b/drivers/raw/ifpga/afu_pmd_he_mem.c
@@ -16,7 +16,6 @@
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <rte_io.h>
-#include <rte_vfio.h>
 #include <bus_pci_driver.h>
 #include <bus_ifpga_driver.h>
 #include <rte_rawdev.h>
-- 
2.51.0

