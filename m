Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED22ECC6B3A
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 562D940E2E;
	Thu, 15 Oct 2026 16:12:21 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9976940A76
 for <dev@dpdk.org>; Thu, 15 Oct 2026 16:11:56 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 73CC61A00B2;
 Thu, 15 Oct 2026 16:11:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3EA3C1A00A9;
 Thu, 15 Oct 2026 16:11:56 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C089218000B1;
 Thu, 15 Oct 2026 22:11:55 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v26 25/26] net/dpaa: prefix fmlib device helpers
Date: Thu, 15 Oct 2026 19:41:43 +0530
Message-Id: <20261015141144.3140281-26-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261015141144.3140281-1-hemant.agrawal@nxp.com>
References: <20261013103833.3822265-1-hemant.agrawal@nxp.com>
 <20261015141144.3140281-1-hemant.agrawal@nxp.com>
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
 drivers/net/dpaa/fmlib/fm_lib.c   |  4 ++--
 drivers/net/dpaa/fmlib/ncsw_ext.h |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 201a9ff8e2..05c1c1c065 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -88,18 +88,18 @@ static void fm_prev_cleanup(void)
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
@@ -599,7 +599,7 @@ static inline int set_default_scheme(struct dpaa_if *dpaa_intf)
 	}
 
 	fm_model.scheme_devid[dpaa_intf->ifid][idx] =
-				get_device_id(dpaa_intf->scheme_handle[idx]);
+				fm_get_device_id(dpaa_intf->scheme_handle[idx]);
 	dpaa_intf->scheme_count++;
 	return 0;
 }
@@ -643,7 +643,7 @@ static inline int set_pcd_netenv_scheme(struct dpaa_if *dpaa_intf,
 	}
 
 	fm_model.scheme_devid[dpaa_intf->ifid][idx] =
-				get_device_id(dpaa_intf->scheme_handle[idx]);
+				fm_get_device_id(dpaa_intf->scheme_handle[idx]);
 	dpaa_intf->scheme_count++;
 	return 0;
 }
@@ -715,7 +715,7 @@ static inline int set_fm_port_handle(struct dpaa_if *dpaa_intf,
 	}
 
 	fm_model.netenv_devid[dpaa_intf->ifid] =
-				get_device_id(dpaa_intf->netenv_handle);
+				fm_get_device_id(dpaa_intf->netenv_handle);
 
 	return 0;
 }
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

