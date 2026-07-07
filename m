Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26819C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:51:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9BD540695;
	Tue,  7 Jul 2026 10:51:27 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2DE9540679
 for <dev@dpdk.org>; Tue,  7 Jul 2026 10:51:25 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gvZgQ6QjczHnGjn;
 Tue,  7 Jul 2026 16:50:26 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id BB8404058D;
 Tue,  7 Jul 2026 16:51:24 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 7 Jul 2026 10:51:24 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Steven Webster <steven.webster@windriver.com>, Matt Peters
 <matt.peters@windriver.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>
Subject: [PATCH v3 3/8] doc: fix typos in rte_avp_common.h
Date: Tue, 7 Jul 2026 09:50:41 +0100
Message-ID: <20260707085048.15295-4-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707085048.15295-1-marat.khalili@huawei.com>
References: <20260706105256.79904-1-marat.khalili@huawei.com>
 <20260707085048.15295-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500001.china.huawei.com (7.182.19.243) To
 frapema500003.china.huawei.com (7.182.19.114)
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

The file contained doxygen typos that caused `unbalanced grouping
commands` errors and prevented successful documentation build. It was
not discovered previously because: (1) the driver despite the presence
of public headers was not included in the documentation build, and (2)
versions of doxygen before 1.9 did not fully parse and verify the syntax
of the file unless it contained the `@file` tag.

Make sure all doxygen grouping commands are balanced.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 drivers/net/avp/rte_avp_common.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/avp/rte_avp_common.h b/drivers/net/avp/rte_avp_common.h
index ffdf07cd8098..da84a1a3649c 100644
--- a/drivers/net/avp/rte_avp_common.h
+++ b/drivers/net/avp/rte_avp_common.h
@@ -117,7 +117,7 @@ struct __rte_cache_aligned __rte_packed_begin rte_avp_desc {
 } __rte_packed_end;
 
 
-/**{ AVP device features */
+/**@{ AVP device features */
 #define RTE_AVP_FEATURE_VLAN_OFFLOAD (1 << 0) /**< Emulated HW VLAN offload */
 /**@} */
 
@@ -160,14 +160,14 @@ struct __rte_cache_aligned __rte_packed_begin rte_avp_desc {
 #define RTE_AVP_MAX_MSIX_VECTORS 1
 /**@} */
 
-/**@} AVP Migration status/ack register values */
+/**@{ AVP Migration status/ack register values */
 #define RTE_AVP_MIGRATION_NONE      0 /**< Migration never executed */
 #define RTE_AVP_MIGRATION_DETACHED  1 /**< Device attached during migration */
 #define RTE_AVP_MIGRATION_ATTACHED  2 /**< Device reattached during migration */
 #define RTE_AVP_MIGRATION_ERROR     3 /**< Device failed to attach/detach */
 /**@} */
 
-/**@} AVP MMIO Register Offsets */
+/**@{ AVP MMIO Register Offsets */
 #define RTE_AVP_REGISTER_BASE 0
 #define RTE_AVP_INTERRUPT_MASK_OFFSET (RTE_AVP_REGISTER_BASE + 0)
 #define RTE_AVP_INTERRUPT_STATUS_OFFSET (RTE_AVP_REGISTER_BASE + 4)
@@ -175,7 +175,7 @@ struct __rte_cache_aligned __rte_packed_begin rte_avp_desc {
 #define RTE_AVP_MIGRATION_ACK_OFFSET (RTE_AVP_REGISTER_BASE + 12)
 /**@} */
 
-/**@} AVP Interrupt Status Mask */
+/**@{ AVP Interrupt Status Mask */
 #define RTE_AVP_MIGRATION_INTERRUPT_MASK (1 << 1)
 #define RTE_AVP_APP_INTERRUPTS_MASK      0xFFFFFFFF
 #define RTE_AVP_NO_INTERRUPTS_MASK       0
@@ -268,7 +268,7 @@ RTE_AVP_MAKE_VERSION(RTE_AVP_RELEASE_VERSION_1, \
 		     RTE_AVP_MINOR_VERSION_13)
 
 /**
- * Access AVP device version values
+ * @{ Access AVP device version values
  */
 #define RTE_AVP_GET_RELEASE_VERSION(_version) (((_version) >> 16) & 0xffff)
 #define RTE_AVP_GET_MAJOR_VERSION(_version) (((_version) >> 8) & 0xff)
-- 
2.43.0

