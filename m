Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E84CC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:53:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AD9940A81;
	Mon,  6 Jul 2026 12:53:39 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 145A24027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 12:53:35 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gv1Qt2RcXzJ46bN;
 Mon,  6 Jul 2026 18:52:38 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id AD93140571;
 Mon,  6 Jul 2026 18:53:34 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jul 2026 12:53:34 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>
Subject: [PATCH v2 6/7] doc: add missing drivers to doxy-api.conf.in
Date: Mon, 6 Jul 2026 11:52:54 +0100
Message-ID: <20260706105256.79904-7-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706105256.79904-1-marat.khalili@huawei.com>
References: <20260702200050.88710-1-marat.khalili@huawei.com>
 <20260706105256.79904-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100001.china.huawei.com (7.182.19.23) To
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

Make sure all drivers declaring public headers are added to
`doxy-api.conf.in` to trigger documentation generation. Sort them.

The only driver still omitted is cnxk_bphy since it needs writing
multiple new doxygen descriptions which could not be done on the spot
(tracked by bug 1962 in bugzilla).

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 doc/api/doxy-api.conf.in | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index 2cb152d6db98..1620027215a9 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -5,15 +5,20 @@ PROJECT_NAME            = DPDK
 PROJECT_NUMBER          = @VERSION@
 USE_MDFILE_AS_MAINPAGE  = @TOPDIR@/doc/api/doxy-api-index.md
 INPUT                   = @TOPDIR@/doc/api/doxy-api-index.md \
+                          @TOPDIR@/drivers/baseband/acc \
+                          @TOPDIR@/drivers/baseband/fpga_5gnr_fec \
+                          @TOPDIR@/drivers/bus/pci \
                           @TOPDIR@/drivers/bus/vdev \
+                          @TOPDIR@/drivers/bus/vmbus \
                           @TOPDIR@/drivers/common/dpaax \
                           @TOPDIR@/drivers/crypto/cnxk \
                           @TOPDIR@/drivers/crypto/scheduler \
-                          @TOPDIR@/drivers/event/dlb2 \
                           @TOPDIR@/drivers/event/cnxk \
+                          @TOPDIR@/drivers/event/dlb2 \
                           @TOPDIR@/drivers/mempool/cnxk \
                           @TOPDIR@/drivers/mempool/dpaa2 \
                           @TOPDIR@/drivers/net/ark \
+                          @TOPDIR@/drivers/net/avp \
                           @TOPDIR@/drivers/net/bnxt \
                           @TOPDIR@/drivers/net/bonding \
                           @TOPDIR@/drivers/net/cnxk \
@@ -23,9 +28,16 @@ INPUT                   = @TOPDIR@/doc/api/doxy-api-index.md \
                           @TOPDIR@/drivers/net/intel/iavf \
                           @TOPDIR@/drivers/net/intel/ixgbe \
                           @TOPDIR@/drivers/net/mlx5 \
+                          @TOPDIR@/drivers/net/ntnic \
+                          @TOPDIR@/drivers/net/ring \
                           @TOPDIR@/drivers/net/softnic \
+                          @TOPDIR@/drivers/net/txgbe \
+                          @TOPDIR@/drivers/net/vhost \
+                          @TOPDIR@/drivers/power/kvm_vm \
+                          @TOPDIR@/drivers/raw/cnxk_gpio \
                           @TOPDIR@/drivers/raw/dpaa2_cmdif \
                           @TOPDIR@/drivers/raw/ifpga \
+                          @TOPDIR@/drivers/raw/ntb \
                           @TOPDIR@/lib/eal/include \
                           @TOPDIR@/lib/eal/include/generic \
                           @TOPDIR@/lib/acl \
-- 
2.43.0

