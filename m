Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C66CA6012
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 07:25:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE55D4026D;
	Fri,  9 Oct 2026 09:25:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 260494021E
 for <dev@dpdk.org>; Fri,  9 Oct 2026 09:25:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791530751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D7KzaCHLZfjNdgA7fwOQUSoPCvyN+kFWDZlYeHWzK4I=;
 b=R5JPoXF3zRydIu7XwOFCtdsh5K7Mg6/3XpLa+I8VD0Oi+nmOJrRiBH3UIFPWq6RvETPPdm
 EwGyKdUuXoquM2+z3n+QLJszeXh4gBngq82t1StOi0t0qhsKEzZB13PsMGmowiaj5xiS48
 FftX6wosEnKA4yiPdbDRNAXpD+IruS8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-JTzcN7L0Pp2fjRgtP3nQkw-1; Fri,
 09 Oct 2026 03:25:48 -0400
X-MC-Unique: JTzcN7L0Pp2fjRgtP3nQkw-1
X-Mimecast-MFC-AGG-ID: JTzcN7L0Pp2fjRgtP3nQkw_1791530745
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DF171977021; Fri,  9 Oct 2026 07:25:44 +0000 (UTC)
Received: from dmarchan.home (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EC4D1800446; Fri,  9 Oct 2026 07:25:37 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, g.singh@nxp.com,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Rosen Xu <rosen.xu@altera.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Kai Ji <kai.ji@intel.com>, Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Liron Himi <lironh@marvell.com>, Martin Spinler <spinler@cesnet.cz>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>, Harman Kalra <hkalra@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Matan Azrad <matan@nvidia.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH] drivers: remove driver alias macro
Date: Fri,  9 Oct 2026 09:25:35 +0200
Message-ID: <20261009072535.3039944-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: amEgvl7OuUGFu_8wxdm2ZQGp7ZQ0m4Uvljxq9G0kyyk_1791530745
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

Remove the RTE_PMD_REGISTER_ALIAS macro defined in the vdev bus.

The old macro relied on a trick where a static pointer was first
declared as NULL, then redefined with the actual alias string by
the ALIAS macro.
This required careful ordering of macros and was confusing.

Additionally, the stringification of the alias parameter meant that
aliases containing commas were impossible, as the preprocessor would
interpret them as macro argument separators.

Replace this macro with directly setting .driver.alias in the driver
struct definitions.

This macro had clones in the platform bus and the ifpga bus, though none
of them were in use, remove them.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/baseband/null/bbdev_null.c               | 4 ++--
 drivers/baseband/turbo_sw/bbdev_turbo_software.c | 4 ++--
 drivers/bus/ifpga/bus_ifpga_driver.h             | 5 -----
 drivers/bus/platform/bus_platform_driver.h       | 6 ------
 drivers/bus/vdev/bus_vdev_driver.h               | 5 -----
 drivers/crypto/armv8/rte_armv8_pmd.c             | 4 ++--
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c          | 4 ++--
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c           | 4 ++--
 drivers/crypto/ipsec_mb/pmd_snow3g.c             | 4 ++--
 drivers/crypto/ipsec_mb/pmd_zuc.c                | 5 ++---
 drivers/crypto/null/null_crypto_pmd.c            | 2 +-
 drivers/net/af_packet/rte_eth_af_packet.c        | 2 +-
 drivers/net/bonding/rte_eth_bond_pmd.c           | 2 +-
 drivers/net/mvpp2/mrvl_ethdev.c                  | 2 +-
 drivers/net/nfb/nfb_vdev.c                       | 2 +-
 drivers/net/null/rte_eth_null.c                  | 2 +-
 drivers/net/octeontx/octeontx_ethdev.c           | 2 +-
 drivers/net/pcap/pcap_ethdev.c                   | 2 +-
 drivers/net/ring/rte_eth_ring.c                  | 2 +-
 drivers/net/tap/rte_eth_tap.c                    | 2 +-
 drivers/net/vdev_netvsc/vdev_netvsc.c            | 2 +-
 drivers/net/vhost/rte_eth_vhost.c                | 2 +-
 drivers/net/virtio/virtio_user_ethdev.c          | 2 +-
 drivers/raw/ifpga/ifpga_rawdev.c                 | 2 +-
 24 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/drivers/baseband/null/bbdev_null.c b/drivers/baseband/null/bbdev_null.c
index cfa1790126..d359bdcb5e 100644
--- a/drivers/baseband/null/bbdev_null.c
+++ b/drivers/baseband/null/bbdev_null.c
@@ -345,12 +345,12 @@ null_bbdev_remove(struct rte_vdev_device *vdev)
 }
 
 static struct rte_vdev_driver bbdev_null_pmd_drv = {
+	.driver.alias = "bbdev_null",
 	.probe = null_bbdev_probe,
-	.remove = null_bbdev_remove
+	.remove = null_bbdev_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(DRIVER_NAME, bbdev_null_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(DRIVER_NAME,
 	BBDEV_NULL_MAX_NB_QUEUES_ARG"=<int> "
 	BBDEV_NULL_SOCKET_ID_ARG"=<int>");
-RTE_PMD_REGISTER_ALIAS(DRIVER_NAME, bbdev_null);
diff --git a/drivers/baseband/turbo_sw/bbdev_turbo_software.c b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
index 2cab495294..9d5c505943 100644
--- a/drivers/baseband/turbo_sw/bbdev_turbo_software.c
+++ b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
@@ -1981,12 +1981,12 @@ turbo_sw_bbdev_remove(struct rte_vdev_device *vdev)
 }
 
 static struct rte_vdev_driver bbdev_turbo_sw_pmd_drv = {
+	.driver.alias = "turbo_sw",
 	.probe = turbo_sw_bbdev_probe,
-	.remove = turbo_sw_bbdev_remove
+	.remove = turbo_sw_bbdev_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(DRIVER_NAME, bbdev_turbo_sw_pmd_drv);
 RTE_PMD_REGISTER_PARAM_STRING(DRIVER_NAME,
 	TURBO_SW_MAX_NB_QUEUES_ARG"=<int> "
 	TURBO_SW_SOCKET_ID_ARG"=<int>");
-RTE_PMD_REGISTER_ALIAS(DRIVER_NAME, turbo_sw);
diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index 4df95485c9..66ef5daf0f 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -119,18 +119,13 @@ __rte_internal
 void rte_ifpga_driver_unregister(struct rte_afu_driver *driver);
 
 #define RTE_PMD_REGISTER_AFU(nm, afudrv)\
-static const char *afudrvinit_ ## nm ## _alias;\
 RTE_INIT(afudrvinitfn_ ##afudrv)\
 {\
 	(afudrv).driver.name = RTE_STR(nm);\
-	(afudrv).driver.alias = afudrvinit_ ## nm ## _alias;\
 	rte_ifpga_driver_register(&afudrv);\
 } \
 RTE_PMD_EXPORT_NAME(nm)
 
-#define RTE_PMD_REGISTER_AFU_ALIAS(nm, alias)\
-static const char *afudrvinit_ ## nm ## _alias = RTE_STR(alias)
-
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index e4dcbacf5e..1a55c729db 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -117,19 +117,13 @@ struct rte_platform_driver {
 
 /** Helper for platform driver registration. */
 #define RTE_PMD_REGISTER_PLATFORM(nm, platform_drv) \
-static const char *pdrvinit_ ## nm ## _alias; \
 RTE_INIT(pdrvinitfn_ ##nm) \
 { \
 	(platform_drv).driver.name = RTE_STR(nm); \
-	(platform_drv).driver.alias = pdrvinit_ ## nm ## _alias; \
 	rte_platform_register(&(platform_drv)); \
 } \
 RTE_PMD_EXPORT_NAME(nm)
 
-/** Helper for setting platform driver alias. */
-#define RTE_PMD_REGISTER_ALIAS(nm, alias) \
-static const char *pdrvinit_ ## nm ## _alias = RTE_STR(alias)
-
 /**
  * Register a platform device driver.
  *
diff --git a/drivers/bus/vdev/bus_vdev_driver.h b/drivers/bus/vdev/bus_vdev_driver.h
index ecfc5384fc..d3e60d4902 100644
--- a/drivers/bus/vdev/bus_vdev_driver.h
+++ b/drivers/bus/vdev/bus_vdev_driver.h
@@ -119,18 +119,13 @@ __rte_internal
 void rte_vdev_unregister(struct rte_vdev_driver *driver);
 
 #define RTE_PMD_REGISTER_VDEV(nm, vdrv)\
-static const char *vdrvinit_ ## nm ## _alias;\
 RTE_INIT(vdrvinitfn_ ##vdrv)\
 {\
 	(vdrv).driver.name = RTE_STR(nm);\
-	(vdrv).driver.alias = vdrvinit_ ## nm ## _alias;\
 	rte_vdev_register(&vdrv);\
 } \
 RTE_PMD_EXPORT_NAME(nm)
 
-#define RTE_PMD_REGISTER_ALIAS(nm, alias)\
-static const char *vdrvinit_ ## nm ## _alias = RTE_STR(alias)
-
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/crypto/armv8/rte_armv8_pmd.c b/drivers/crypto/armv8/rte_armv8_pmd.c
index a7caac186d..582dbadbdd 100644
--- a/drivers/crypto/armv8/rte_armv8_pmd.c
+++ b/drivers/crypto/armv8/rte_armv8_pmd.c
@@ -845,8 +845,9 @@ cryptodev_armv8_crypto_uninit(struct rte_vdev_device *vdev)
 }
 
 static struct rte_vdev_driver armv8_crypto_pmd_drv = {
+	.driver.alias = "cryptodev_armv8_pmd",
 	.probe = cryptodev_armv8_crypto_init,
-	.remove = cryptodev_armv8_crypto_uninit
+	.remove = cryptodev_armv8_crypto_uninit,
 };
 
 static struct cryptodev_driver armv8_crypto_drv;
@@ -854,7 +855,6 @@ static struct cryptodev_driver armv8_crypto_drv;
 RTE_LOG_REGISTER_DEFAULT(crypto_armv8_log_type, ERR);
 
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_ARMV8_PMD, armv8_crypto_pmd_drv);
-RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_ARMV8_PMD, cryptodev_armv8_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_ARMV8_PMD,
 	"max_nb_queue_pairs=<int> "
 	"socket_id=<int>");
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
index 3c266cc47e..2a4bede7dd 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -780,15 +780,15 @@ aesni_gcm_probe(struct rte_vdev_device *vdev)
 }
 
 static struct rte_vdev_driver cryptodev_aesni_gcm_pmd_drv = {
+	.driver.alias = "cryptodev_aesni_gcm_pmd",
 	.probe = aesni_gcm_probe,
-	.remove = ipsec_mb_remove
+	.remove = ipsec_mb_remove,
 };
 
 static struct cryptodev_driver aesni_gcm_crypto_drv;
 
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_AESNI_GCM_PMD,
 		      cryptodev_aesni_gcm_pmd_drv);
-RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_AESNI_GCM_PMD, cryptodev_aesni_gcm_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_AESNI_GCM_PMD,
 			      "max_nb_queue_pairs=<int> socket_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(aesni_gcm_crypto_drv,
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index 4c5b6e70b5..d39539d7aa 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -2542,15 +2542,15 @@ aesni_mb_probe(struct rte_vdev_device *vdev)
 }
 
 static struct rte_vdev_driver cryptodev_aesni_mb_pmd_drv = {
+	.driver.alias = "cryptodev_aesni_mb_pmd",
 	.probe = aesni_mb_probe,
-	.remove = ipsec_mb_remove
+	.remove = ipsec_mb_remove,
 };
 
 static struct cryptodev_driver aesni_mb_crypto_drv;
 
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_AESNI_MB_PMD,
 	cryptodev_aesni_mb_pmd_drv);
-RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_AESNI_MB_PMD, cryptodev_aesni_mb_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_AESNI_MB_PMD,
 			"max_nb_queue_pairs=<int> socket_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(
diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index 35fe23c157..28b078ea0c 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -566,14 +566,14 @@ snow3g_probe(struct rte_vdev_device *vdev)
 }
 
 static struct rte_vdev_driver cryptodev_snow3g_pmd_drv = {
+	.driver.alias = "cryptodev_snow3g_pmd",
 	.probe = snow3g_probe,
-	.remove = ipsec_mb_remove
+	.remove = ipsec_mb_remove,
 };
 
 static struct cryptodev_driver snow3g_crypto_drv;
 
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_SNOW3G_PMD, cryptodev_snow3g_pmd_drv);
-RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_SNOW3G_PMD, cryptodev_snow3g_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_SNOW3G_PMD,
 			       "max_nb_queue_pairs=<int> socket_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(snow3g_crypto_drv,
diff --git a/drivers/crypto/ipsec_mb/pmd_zuc.c b/drivers/crypto/ipsec_mb/pmd_zuc.c
index 28ab6982f2..102ac520bb 100644
--- a/drivers/crypto/ipsec_mb/pmd_zuc.c
+++ b/drivers/crypto/ipsec_mb/pmd_zuc.c
@@ -369,15 +369,14 @@ zuc_probe(struct rte_vdev_device *vdev)
 }
 
 static struct rte_vdev_driver cryptodev_zuc_pmd_drv = {
+	.driver.alias = "cryptodev_zuc_pmd",
 	.probe = zuc_probe,
-	.remove = ipsec_mb_remove
-
+	.remove = ipsec_mb_remove,
 };
 
 static struct cryptodev_driver zuc_crypto_drv;
 
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_ZUC_PMD, cryptodev_zuc_pmd_drv);
-RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_ZUC_PMD, cryptodev_zuc_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_ZUC_PMD,
 	"max_nb_queue_pairs=<int> socket_id=<int>");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(zuc_crypto_drv, cryptodev_zuc_pmd_drv.driver,
diff --git a/drivers/crypto/null/null_crypto_pmd.c b/drivers/crypto/null/null_crypto_pmd.c
index 8458306556..6db9deaee8 100644
--- a/drivers/crypto/null/null_crypto_pmd.c
+++ b/drivers/crypto/null/null_crypto_pmd.c
@@ -227,6 +227,7 @@ cryptodev_null_remove_dev(struct rte_vdev_device *vdev)
 }
 
 static struct rte_vdev_driver cryptodev_null_pmd_drv = {
+	.driver.alias = "cryptodev_null_pmd",
 	.probe = cryptodev_null_probe,
 	.remove = cryptodev_null_remove_dev,
 };
@@ -234,7 +235,6 @@ static struct rte_vdev_driver cryptodev_null_pmd_drv = {
 static struct cryptodev_driver null_crypto_drv;
 
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_NULL_PMD, cryptodev_null_pmd_drv);
-RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_NULL_PMD, cryptodev_null_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_NULL_PMD,
 	"max_nb_queue_pairs=<int> "
 	"socket_id=<int>");
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index a93df97023..ef57719803 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -1388,12 +1388,12 @@ rte_pmd_af_packet_remove(struct rte_vdev_device *dev)
 }
 
 static struct rte_vdev_driver pmd_af_packet_drv = {
+	.driver.alias = "eth_af_packet",
 	.probe = rte_pmd_af_packet_probe,
 	.remove = rte_pmd_af_packet_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(net_af_packet, pmd_af_packet_drv);
-RTE_PMD_REGISTER_ALIAS(net_af_packet, eth_af_packet);
 RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"iface=<string> "
 	"qpairs=<int> "
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a4f997b5a..526f8118b3 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -4305,12 +4305,12 @@ bond_ethdev_configure(struct rte_eth_dev *dev)
 }
 
 struct rte_vdev_driver pmd_bond_drv = {
+	.driver.alias = "eth_bond",
 	.probe = bond_probe,
 	.remove = bond_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(net_bonding, pmd_bond_drv);
-RTE_PMD_REGISTER_ALIAS(net_bonding, eth_bond);
 
 RTE_PMD_REGISTER_PARAM_STRING(net_bonding,
 	"member=<ifc> "
diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethdev.c
index d7ed504bee..2df3a77e7f 100644
--- a/drivers/net/mvpp2/mrvl_ethdev.c
+++ b/drivers/net/mvpp2/mrvl_ethdev.c
@@ -3316,10 +3316,10 @@ rte_pmd_mrvl_remove(struct rte_vdev_device *vdev)
 }
 
 static struct rte_vdev_driver pmd_mrvl_drv = {
+	.driver.alias = "eth_mvpp2",
 	.probe = rte_pmd_mrvl_probe,
 	.remove = rte_pmd_mrvl_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(net_mvpp2, pmd_mrvl_drv);
-RTE_PMD_REGISTER_ALIAS(net_mvpp2, eth_mvpp2);
 RTE_LOG_REGISTER_DEFAULT(mrvl_logtype, NOTICE);
diff --git a/drivers/net/nfb/nfb_vdev.c b/drivers/net/nfb/nfb_vdev.c
index 57f10d2068..f077663889 100644
--- a/drivers/net/nfb/nfb_vdev.c
+++ b/drivers/net/nfb/nfb_vdev.c
@@ -95,12 +95,12 @@ vdev_nfb_vdev_remove(struct rte_vdev_device *dev)
 
 /** Virtual device descriptor. */
 static struct rte_vdev_driver vdev_nfb_vdev = {
+	.driver.alias = "eth_vdev_nfb",
 	.probe = vdev_nfb_vdev_probe,
 	.remove = vdev_nfb_vdev_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(VDEV_NFB_DRIVER, vdev_nfb_vdev);
-RTE_PMD_REGISTER_ALIAS(VDEV_NFB_DRIVER, eth_vdev_nfb);
 RTE_PMD_REGISTER_PARAM_STRING(net_vdev_nfb,
 		VDEV_NFB_ARG_DEV "=<string> "
 		NFB_COMMON_ARGS
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index a469825cb6..a2f70fee79 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -767,12 +767,12 @@ rte_pmd_null_remove(struct rte_vdev_device *dev)
 }
 
 static struct rte_vdev_driver pmd_null_drv = {
+	.driver.alias = "eth_null",
 	.probe = rte_pmd_null_probe,
 	.remove = rte_pmd_null_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(net_null, pmd_null_drv);
-RTE_PMD_REGISTER_ALIAS(net_null, eth_null);
 RTE_PMD_REGISTER_PARAM_STRING(net_null,
 	"size=<int> "
 	"copy=<int> "
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index e4dca30d9d..e173535d29 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -1896,10 +1896,10 @@ octeontx_probe(struct rte_vdev_device *dev)
 }
 
 static struct rte_vdev_driver octeontx_pmd_drv = {
+	.driver.alias = "eth_octeontx",
 	.probe = octeontx_probe,
 	.remove = octeontx_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(OCTEONTX_PMD, octeontx_pmd_drv);
-RTE_PMD_REGISTER_ALIAS(OCTEONTX_PMD, eth_octeontx);
 RTE_PMD_REGISTER_PARAM_STRING(OCTEONTX_PMD, "nr_port=<int> ");
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index b1f3718c8a..1e114e0008 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -2128,12 +2128,12 @@ pmd_pcap_remove(struct rte_vdev_device *dev)
 }
 
 static struct rte_vdev_driver pmd_pcap_drv = {
+	.driver.alias = "eth_pcap",
 	.probe = pmd_pcap_probe,
 	.remove = pmd_pcap_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(net_pcap, pmd_pcap_drv);
-RTE_PMD_REGISTER_ALIAS(net_pcap, eth_pcap);
 RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_PCAP_ARG "=<string> "
 	ETH_PCAP_TX_PCAP_ARG "=<string> "
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 4cbdbe3085..d75ae2cbed 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -783,11 +783,11 @@ rte_pmd_ring_remove(struct rte_vdev_device *dev)
 }
 
 static struct rte_vdev_driver pmd_ring_drv = {
+	.driver.alias = "eth_ring",
 	.probe = rte_pmd_ring_probe,
 	.remove = rte_pmd_ring_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(net_ring, pmd_ring_drv);
-RTE_PMD_REGISTER_ALIAS(net_ring, eth_ring);
 RTE_PMD_REGISTER_PARAM_STRING(net_ring,
 	ETH_RING_NUMA_NODE_ACTION_ARG "=name:node:action(ATTACH|CREATE)");
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index f23c23b465..604cf76b61 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2777,13 +2777,13 @@ static struct rte_vdev_driver pmd_tun_drv = {
 };
 
 static struct rte_vdev_driver pmd_tap_drv = {
+	.driver.alias = "eth_tap",
 	.probe = rte_pmd_tap_probe,
 	.remove = rte_pmd_tap_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(net_tap, pmd_tap_drv);
 RTE_PMD_REGISTER_VDEV(net_tun, pmd_tun_drv);
-RTE_PMD_REGISTER_ALIAS(net_tap, eth_tap);
 RTE_PMD_REGISTER_PARAM_STRING(net_tun,
 			      ETH_TAP_IFACE_ARG "=<string> ");
 RTE_PMD_REGISTER_PARAM_STRING(net_tap,
diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index d70da6c7c1..9b452ace97 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -756,12 +756,12 @@ vdev_netvsc_vdev_remove(__rte_unused struct rte_vdev_device *dev)
 
 /** Virtual device descriptor. */
 static struct rte_vdev_driver vdev_netvsc_vdev = {
+	.driver.alias = "eth_vdev_netvsc",
 	.probe = vdev_netvsc_vdev_probe,
 	.remove = vdev_netvsc_vdev_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(VDEV_NETVSC_DRIVER, vdev_netvsc_vdev);
-RTE_PMD_REGISTER_ALIAS(VDEV_NETVSC_DRIVER, eth_vdev_netvsc);
 RTE_PMD_REGISTER_PARAM_STRING(net_vdev_netvsc,
 			      VDEV_NETVSC_ARG_IFACE "=<string> "
 			      VDEV_NETVSC_ARG_MAC "=<string> "
diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index f7425d04e6..f6ef997455 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1792,12 +1792,12 @@ rte_pmd_vhost_remove(struct rte_vdev_device *dev)
 }
 
 static struct rte_vdev_driver pmd_vhost_drv = {
+	.driver.alias = "eth_vhost",
 	.probe = rte_pmd_vhost_probe,
 	.remove = rte_pmd_vhost_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(net_vhost, pmd_vhost_drv);
-RTE_PMD_REGISTER_ALIAS(net_vhost, eth_vhost);
 RTE_PMD_REGISTER_PARAM_STRING(net_vhost,
 	"iface=<ifc> "
 	"queues=<int> "
diff --git a/drivers/net/virtio/virtio_user_ethdev.c b/drivers/net/virtio/virtio_user_ethdev.c
index 747dddeb2e..437727c043 100644
--- a/drivers/net/virtio/virtio_user_ethdev.c
+++ b/drivers/net/virtio/virtio_user_ethdev.c
@@ -805,6 +805,7 @@ static int virtio_user_pmd_dma_unmap(struct rte_vdev_device *vdev, void *addr,
 }
 
 static struct rte_vdev_driver virtio_user_driver = {
+	.driver.alias = "virtio_user",
 	.probe = virtio_user_pmd_probe,
 	.remove = virtio_user_pmd_remove,
 	.dma_map = virtio_user_pmd_dma_map,
@@ -812,7 +813,6 @@ static struct rte_vdev_driver virtio_user_driver = {
 };
 
 RTE_PMD_REGISTER_VDEV(net_virtio_user, virtio_user_driver);
-RTE_PMD_REGISTER_ALIAS(net_virtio_user, virtio_user);
 RTE_PMD_REGISTER_PARAM_STRING(net_virtio_user,
 	"path=<path> "
 	"mac=<mac addr> "
diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index 1846cca669..c4143bfb3e 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -1893,12 +1893,12 @@ ifpga_cfg_remove(struct rte_vdev_device *vdev)
 }
 
 static struct rte_vdev_driver ifpga_cfg_driver = {
+	.driver.alias = "ifpga_cfg",
 	.probe = ifpga_cfg_probe,
 	.remove = ifpga_cfg_remove,
 };
 
 RTE_PMD_REGISTER_VDEV(ifpga_rawdev_cfg, ifpga_cfg_driver);
-RTE_PMD_REGISTER_ALIAS(ifpga_rawdev_cfg, ifpga_cfg);
 RTE_PMD_REGISTER_PARAM_STRING(ifpga_rawdev_cfg,
 	"ifpga=<string> "
 	"port=<int> "
-- 
2.54.0

