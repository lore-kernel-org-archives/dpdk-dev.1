Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A20CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:20:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E096840664;
	Fri, 16 Oct 2026 13:20:25 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 86E084066C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 13:20:05 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63D042001FF;
 Fri, 16 Oct 2026 13:20:05 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F8462001D6;
 Fri, 16 Oct 2026 13:20:05 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B343B18000B1;
 Fri, 16 Oct 2026 19:20:04 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v27 09/25] net/dpaa: prefix fmlib device helpers
Date: Fri, 16 Oct 2026 16:49:42 +0530
Message-Id: <20261016111958.163060-10-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261016111958.163060-1-hemant.agrawal@nxp.com>
References: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
 <20261016111958.163060-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

create_device() and get_device_id() are global symbols with no driver
prefix, so they can clash with another driver when DPDK is linked
statically. The rest of the low-level fmlib code already uses fm_.

Rename them to fm_create_device() and fm_get_device_id().

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_flow.c      | 12 ++++++------
 drivers/net/dpaa/dpaa_fmc.c       |  2 +-
 drivers/net/dpaa/fmlib/fm_lib.c   |  4 ++--
 drivers/net/dpaa/fmlib/ncsw_ext.h |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index f21950f64d..3a5ef7f41c 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -87,18 +87,18 @@ static void fm_prev_cleanup(void)
 		}
 		dpaa_intf.port_handle =
 				fm_port_open(&fm_model.fm_port_params[devid]);
-		dpaa_intf.scheme_handle[0] = create_device(fm_info.pcd_handle,
+		dpaa_intf.scheme_handle[0] = fm_create_device(fm_info.pcd_handle,
 					fm_model.scheme_devid[devid][0]);
 		dpaa_intf.scheme_count = 1;
 		if (fm_model.scheme_devid[devid][1]) {
 			dpaa_intf.scheme_handle[1] =
-				create_device(fm_info.pcd_handle,
+				fm_create_device(fm_info.pcd_handle,
 					fm_model.scheme_devid[devid][1]);
 			if (dpaa_intf.scheme_handle[1])
 				dpaa_intf.scheme_count++;
 		}
 
-		dpaa_intf.netenv_handle = create_device(fm_info.pcd_handle,
+		dpaa_intf.netenv_handle = fm_create_device(fm_info.pcd_handle,
 					fm_model.netenv_devid[devid]);
 		i++;
 		if (!dpaa_intf.netenv_handle ||
@@ -598,7 +598,7 @@ static inline int set_default_scheme(struct dpaa_if *dpaa_intf)
 	}
 
 	fm_model.scheme_devid[dpaa_intf->ifid][idx] =
-				get_device_id(dpaa_intf->scheme_handle[idx]);
+				fm_get_device_id(dpaa_intf->scheme_handle[idx]);
 	dpaa_intf->scheme_count++;
 	return 0;
 }
@@ -642,7 +642,7 @@ static inline int set_pcd_netenv_scheme(struct dpaa_if *dpaa_intf,
 	}
 
 	fm_model.scheme_devid[dpaa_intf->ifid][idx] =
-				get_device_id(dpaa_intf->scheme_handle[idx]);
+				fm_get_device_id(dpaa_intf->scheme_handle[idx]);
 	dpaa_intf->scheme_count++;
 	return 0;
 }
@@ -714,7 +714,7 @@ static inline int set_fm_port_handle(struct dpaa_if *dpaa_intf,
 	}
 
 	fm_model.netenv_devid[dpaa_intf->ifid] =
-				get_device_id(dpaa_intf->netenv_handle);
+				fm_get_device_id(dpaa_intf->netenv_handle);
 
 	return 0;
 }
diff --git a/drivers/net/dpaa/dpaa_fmc.c b/drivers/net/dpaa/dpaa_fmc.c
index 7dc42f6e23..e1cbc99c8e 100644
--- a/drivers/net/dpaa/dpaa_fmc.c
+++ b/drivers/net/dpaa/dpaa_fmc.c
@@ -202,7 +202,7 @@ struct fmc_model_t {
 		(FMC_SCHEMES_NUM + FMC_CC_NODES_NUM)];
 };
 
-struct fmc_model_t *g_fmc_model;
+static struct fmc_model_t *g_fmc_model;
 
 static int
 dpaa_port_fmc_port_parse(struct fman_if *fif,
diff --git a/drivers/net/dpaa/fmlib/fm_lib.c b/drivers/net/dpaa/fmlib/fm_lib.c
index 65a818372e..1130ef3630 100644
--- a/drivers/net/dpaa/fmlib/fm_lib.c
+++ b/drivers/net/dpaa/fmlib/fm_lib.c
@@ -533,7 +533,7 @@ fm_port_delete_pcd(t_handle h_fm_port)
 }
 
 t_handle
-create_device(t_handle h_user_priv, t_handle h_dev_id)
+fm_create_device(t_handle h_user_priv, t_handle h_dev_id)
 {
 	t_device *p_user_priv_dev = (t_device *)h_user_priv;
 	t_device *p_dev = NULL;
@@ -555,7 +555,7 @@ create_device(t_handle h_user_priv, t_handle h_dev_id)
 }
 
 t_handle
-get_device_id(t_handle h_dev)
+fm_get_device_id(t_handle h_dev)
 {
 	t_device *p_dev = (t_device *)h_dev;
 
diff --git a/drivers/net/dpaa/fmlib/ncsw_ext.h b/drivers/net/dpaa/fmlib/ncsw_ext.h
index 1a6e337f49..e6b3145e82 100644
--- a/drivers/net/dpaa/fmlib/ncsw_ext.h
+++ b/drivers/net/dpaa/fmlib/ncsw_ext.h
@@ -152,7 +152,7 @@ typedef struct t_device {
 	uint32_t	owners;
 } t_device;
 
-t_handle create_device(t_handle h_user_priv, t_handle h_dev_id);
-t_handle get_device_id(t_handle h_dev);
+t_handle fm_create_device(t_handle h_user_priv, t_handle h_dev_id);
+t_handle fm_get_device_id(t_handle h_dev);
 
 #endif /* __NCSW_EXT_H */
-- 
2.25.1

