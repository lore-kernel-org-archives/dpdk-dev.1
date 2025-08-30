Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF18CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:41:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D515040698;
	Sat, 30 Aug 2025 14:41:01 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 346C240670
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:40:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=f7OptPOqeetLBBL4GazSBe7n0xEGtrU6qW6U2N+5/Tk=;
 b=iUx7e4ZS339eRhrmhDmcZ6Kk553XGWAN+rWmOQOcPYCOwkwEwiqNBZzwjSO52p
 W0JhJSmpHrSXk5orOkIeWOA39z5rwq2TcIVVGeRBiREMxDIAohS6drM0VeuXH+BY
 5Bmesp2BgZQ5+v1zlFIB5IbKUQVUmxiRZIO9krwwAXa5U=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S12;
 Sat, 30 Aug 2025 20:40:54 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 08/18] net/hinic3: add module about hardware operation
Date: Sat, 30 Aug 2025 20:39:20 +0800
Message-ID: <20250830123942.5037-9-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S12
X-Coremail-Antispam: 1Uf129KBjvAXoWDXFWrXFWfAFWDGryDGr15Arb_yoW7GF1Duo
 WxJw43Kr1Fqr1xCw4jg340kFZ3XryDuFn5AwsIgFZrJ3W7Ary8ta43Gw1Sqa4I9ryFkrnr
 CFWftws5K3yUKwn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxFksDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAQi5CmiydD3F1AABs5
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

From: Yi Chen <chenyi221@huawei.com>=0D

Add code and data structure for hardware operation, including=0D
configuration, query, initialization and release.=0D
=0D
Signed-off-by: Yi Chen <chenyi221@huawei.com>=0D
Signed-off-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_hw_cfg.c  | 240 ++++++++++=0D
 drivers/net/hinic3/base/hinic3_hw_cfg.h  | 121 +++++=0D
 drivers/net/hinic3/base/hinic3_hw_comm.c | 452 ++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_hw_comm.h | 366 +++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_hwdev.c   | 573 +++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_hwdev.h   | 177 +++++++=0D
 6 files changed, 1929 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_cfg.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hw_comm.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_hwdev.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_hw_cfg.c b/drivers/net/hinic3/b=
ase/hinic3_hw_cfg.c=0D
new file mode 100644=0D
index 0000000000..ebe746a9ae=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_hw_cfg.c=0D
@@ -0,0 +1,240 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_mbox.h"=0D
+#include "hinic3_mgmt.h"=0D
+#include "hinic3_hw_cfg.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+=0D
+static void=0D
+parse_pub_res_cap(struct service_cap *cap,=0D
+		  struct hinic3_cfg_cmd_dev_cap *dev_cap, enum func_type type)=0D
+{=0D
+	cap->host_id =3D dev_cap->host_id;=0D
+	cap->ep_id =3D dev_cap->ep_id;=0D
+	cap->er_id =3D dev_cap->er_id;=0D
+	cap->port_id =3D dev_cap->port_id;=0D
+=0D
+	cap->svc_type =3D dev_cap->svc_cap_en;=0D
+	cap->chip_svc_type =3D cap->svc_type;=0D
+=0D
+	cap->cos_valid_bitmap =3D dev_cap->valid_cos_bitmap;=0D
+	cap->flexq_en =3D dev_cap->flexq_en;=0D
+=0D
+	cap->host_total_function =3D dev_cap->host_total_func;=0D
+	cap->max_vf =3D 0;=0D
+	if (type =3D=3D TYPE_PF || type =3D=3D TYPE_PPF) {=0D
+		cap->max_vf =3D dev_cap->max_vf;=0D
+		cap->pf_num =3D dev_cap->host_pf_num;=0D
+		cap->pf_id_start =3D dev_cap->pf_id_start;=0D
+		cap->vf_num =3D dev_cap->host_vf_num;=0D
+		cap->vf_id_start =3D dev_cap->vf_id_start;=0D
+	}=0D
+=0D
+	PMD_DRV_LOG(INFO, "Get public resource capability: ");=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "host_id: 0x%x, ep_id: 0x%x, er_id: 0x%x, port_id: 0x%x",=0D
+		    cap->host_id, cap->ep_id, cap->er_id, cap->port_id);=0D
+	PMD_DRV_LOG(INFO, "host_total_function: 0x%x, max_vf: 0x%x",=0D
+		    cap->host_total_function, cap->max_vf);=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "host_pf_num: 0x%x, pf_id_start: 0x%x, host_vf_num: 0x%x, "=0D
+		    "vf_id_start: 0x%x",=0D
+		    cap->pf_num, cap->pf_id_start, cap->vf_num,=0D
+		    cap->vf_id_start);=0D
+}=0D
+=0D
+static void=0D
+parse_l2nic_res_cap(struct service_cap *cap,=0D
+		    struct hinic3_cfg_cmd_dev_cap *dev_cap)=0D
+{=0D
+	struct nic_service_cap *nic_cap =3D &cap->nic_cap;=0D
+=0D
+	nic_cap->max_sqs =3D dev_cap->nic_max_sq_id + 1;=0D
+	nic_cap->max_rqs =3D dev_cap->nic_max_rq_id + 1;=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "L2nic resource capbility, "=0D
+		    "max_sqs: 0x%x, max_rqs: 0x%x",=0D
+		    nic_cap->max_sqs, nic_cap->max_rqs);=0D
+}=0D
+=0D
+static void=0D
+parse_dev_cap(struct hinic3_hwdev *dev, struct hinic3_cfg_cmd_dev_cap *dev=
_cap,=0D
+	      enum func_type type)=0D
+{=0D
+	struct service_cap *cap =3D &dev->cfg_mgmt->svc_cap;=0D
+=0D
+	parse_pub_res_cap(cap, dev_cap, type);=0D
+=0D
+	if (IS_NIC_TYPE(dev))=0D
+		parse_l2nic_res_cap(cap, dev_cap);=0D
+}=0D
+=0D
+static int=0D
+get_cap_from_fw(struct hinic3_hwdev *hwdev, enum func_type type)=0D
+{=0D
+	struct hinic3_cfg_cmd_dev_cap dev_cap;=0D
+	u16 out_len =3D sizeof(dev_cap);=0D
+	int err;=0D
+=0D
+	memset(&dev_cap, 0, sizeof(dev_cap));=0D
+	dev_cap.func_id =3D hinic3_global_func_id(hwdev);=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_CFGM,=0D
+				      HINIC3_CFG_CMD_GET_DEV_CAP, &dev_cap,=0D
+				      sizeof(dev_cap), &dev_cap, &out_len, 0);=0D
+	if (err || dev_cap.status || !out_len) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get capability from FW failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, dev_cap.status, out_len);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	parse_dev_cap(hwdev, &dev_cap, type);=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+get_dev_cap(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	enum func_type type =3D HINIC3_FUNC_TYPE(hwdev);=0D
+=0D
+	switch (type) {=0D
+	case TYPE_PF:=0D
+	case TYPE_PPF:=0D
+	case TYPE_VF:=0D
+		if (get_cap_from_fw(hwdev, type) !=3D 0)=0D
+			return -EFAULT;=0D
+		break;=0D
+	default:=0D
+		PMD_DRV_LOG(ERR, "Unsupported PCIe function type: %d", type);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+cfg_mbx_vf_proc_msg(void *hwdev, __rte_unused void *pri_handle, u16 cmd,=0D
+		    __rte_unused void *buf_in, __rte_unused u16 in_size,=0D
+		    __rte_unused void *buf_out, __rte_unused u16 *out_size)=0D
+{=0D
+	struct hinic3_hwdev *dev =3D hwdev;=0D
+=0D
+	if (!dev)=0D
+		return -EINVAL;=0D
+=0D
+	PMD_DRV_LOG(WARNING, "Unsupported cfg mbox vf event %d to process",=0D
+		    cmd);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_init_cfg_mgmt(void *dev)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D (struct hinic3_hwdev *)dev;=0D
+	struct cfg_mgmt_info *cfg_mgmt =3D NULL;=0D
+=0D
+	cfg_mgmt =3D rte_zmalloc("cfg_mgmt", sizeof(*cfg_mgmt),=0D
+			       HINIC3_MEM_ALLOC_ALIGN_MIN);=0D
+	if (!cfg_mgmt)=0D
+		return -ENOMEM;=0D
+=0D
+	memset(cfg_mgmt, 0, sizeof(struct cfg_mgmt_info));=0D
+	hwdev->cfg_mgmt =3D cfg_mgmt;=0D
+	cfg_mgmt->hwdev =3D hwdev;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_init_capability(void *dev)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D (struct hinic3_hwdev *)dev;=0D
+=0D
+	return get_dev_cap(hwdev);=0D
+}=0D
+=0D
+void=0D
+hinic3_deinit_cfg_mgmt(void *dev)=0D
+{=0D
+	rte_free(((struct hinic3_hwdev *)dev)->cfg_mgmt);=0D
+	((struct hinic3_hwdev *)dev)->cfg_mgmt =3D NULL;=0D
+}=0D
+=0D
+#ifdef HINIC3_RELEASE=0D
+static bool=0D
+hinic3_support_nic(void *hwdev, struct nic_service_cap *cap)=0D
+{=0D
+	struct hinic3_hwdev *dev =3D (struct hinic3_hwdev *)hwdev;=0D
+=0D
+	if (!hwdev)=0D
+		return false;=0D
+=0D
+	if (!IS_NIC_TYPE(dev))=0D
+		return false;=0D
+=0D
+	if (cap)=0D
+		memcpy(cap, &dev->cfg_mgmt->svc_cap.nic_cap, sizeof(*cap));=0D
+=0D
+	return true;=0D
+}=0D
+=0D
+static bool=0D
+hinic3_func_for_mgmt(void *hwdev)=0D
+{=0D
+	struct hinic3_hwdev *dev =3D hwdev;=0D
+=0D
+	if (!hwdev)=0D
+		return false;=0D
+=0D
+	if (dev->cfg_mgmt->svc_cap.chip_svc_type >=3D CFG_SVC_NIC_BIT0)=0D
+		return false;=0D
+	else=0D
+		return true;=0D
+}=0D
+#endif=0D
+=0D
+u16=0D
+hinic3_func_max_sqs(void *hwdev)=0D
+{=0D
+	struct hinic3_hwdev *dev =3D hwdev;=0D
+=0D
+	if (!dev) {=0D
+		PMD_DRV_LOG(INFO, "Hwdev is NULL for getting max_sqs");=0D
+		return 0;=0D
+	}=0D
+=0D
+	return dev->cfg_mgmt->svc_cap.nic_cap.max_sqs;=0D
+}=0D
+=0D
+u16=0D
+hinic3_func_max_rqs(void *hwdev)=0D
+{=0D
+	struct hinic3_hwdev *dev =3D hwdev;=0D
+=0D
+	if (!dev) {=0D
+		PMD_DRV_LOG(INFO, "Hwdev is NULL for getting max_rqs");=0D
+		return 0;=0D
+	}=0D
+=0D
+	return dev->cfg_mgmt->svc_cap.nic_cap.max_rqs;=0D
+}=0D
+=0D
+u8=0D
+hinic3_physical_port_id(void *hwdev)=0D
+{=0D
+	struct hinic3_hwdev *dev =3D hwdev;=0D
+=0D
+	if (!dev) {=0D
+		PMD_DRV_LOG(INFO, "Hwdev is NULL for getting physical port id");=0D
+		return 0;=0D
+	}=0D
+=0D
+	return dev->cfg_mgmt->svc_cap.port_id;=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_hw_cfg.h b/drivers/net/hinic3/b=
ase/hinic3_hw_cfg.h=0D
new file mode 100644=0D
index 0000000000..8ded52faa9=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_hw_cfg.h=0D
@@ -0,0 +1,121 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_HW_CFG_H_=0D
+#define _HINIC3_HW_CFG_H_=0D
+=0D
+#define CFG_MAX_CMD_TIMEOUT 30000 /**< ms */=0D
+=0D
+#define K_UNIT BIT(10)=0D
+#define M_UNIT BIT(20)=0D
+#define G_UNIT BIT(30)=0D
+=0D
+/* Number of PFs and VFs. */=0D
+#define HOST_PF_NUM	   4=0D
+#define HOST_VF_NUM	   0=0D
+#define HOST_OQID_MASK_VAL 2=0D
+=0D
+#define L2NIC_SQ_DEPTH (4 * K_UNIT)=0D
+#define L2NIC_RQ_DEPTH (4 * K_UNIT)=0D
+=0D
+enum intr_type { INTR_TYPE_MSIX, INTR_TYPE_MSI, INTR_TYPE_INT, INTR_TYPE_N=
ONE };=0D
+=0D
+/* Service type relates define. */=0D
+enum cfg_svc_type_en { CFG_SVC_NIC_BIT0 =3D 1 };=0D
+=0D
+struct nic_service_cap {=0D
+	u16 max_sqs;=0D
+	u16 max_rqs;=0D
+};=0D
+=0D
+/* Device capability. */=0D
+struct service_cap {=0D
+	enum cfg_svc_type_en svc_type;	    /**< User input service type. */=0D
+	enum cfg_svc_type_en chip_svc_type; /**< HW supported service type. */=0D
+=0D
+	u8 host_id;=0D
+	u8 ep_id;=0D
+	u8 er_id;   /**< PF/VF's ER. */=0D
+	u8 port_id; /**< PF/VF's physical port. */=0D
+=0D
+	u16 host_total_function;=0D
+	u8 pf_num;=0D
+	u8 pf_id_start;=0D
+	u16 vf_num; /**< Max numbers of vf in current host. */=0D
+	u16 vf_id_start;=0D
+=0D
+	u8 flexq_en;=0D
+	u8 cos_valid_bitmap;=0D
+	u16 max_vf; /**< Max VF number that PF supported. */=0D
+=0D
+	struct nic_service_cap nic_cap; /**< NIC capability. */=0D
+};=0D
+=0D
+struct cfg_mgmt_info {=0D
+	void *hwdev;=0D
+	struct service_cap svc_cap;=0D
+};=0D
+=0D
+enum hinic3_cfg_cmd {=0D
+	HINIC3_CFG_CMD_GET_DEV_CAP =3D 0,=0D
+};=0D
+=0D
+struct hinic3_cfg_cmd_dev_cap {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd1;=0D
+=0D
+	/* Public resource. */=0D
+	u8 host_id;=0D
+	u8 ep_id;=0D
+	u8 er_id;=0D
+	u8 port_id;=0D
+=0D
+	u16 host_total_func;=0D
+	u8 host_pf_num;=0D
+	u8 pf_id_start;=0D
+	u16 host_vf_num;=0D
+	u16 vf_id_start;=0D
+	u32 rsvd_host;=0D
+=0D
+	u16 svc_cap_en;=0D
+	u16 max_vf;=0D
+	u8 flexq_en;=0D
+	u8 valid_cos_bitmap;=0D
+	/* Reserved for func_valid_cos_bitmap. */=0D
+	u16 rsvd_cos;=0D
+=0D
+	u32 rsvd[11];=0D
+=0D
+	/* l2nic */=0D
+	u16 nic_max_sq_id;=0D
+	u16 nic_max_rq_id;=0D
+	u32 rsvd_nic[3];=0D
+=0D
+	u32 rsvd_glb[60];=0D
+};=0D
+=0D
+#define IS_NIC_TYPE(dev) \=0D
+	(((u32)(dev)->cfg_mgmt->svc_cap.chip_svc_type) & CFG_SVC_NIC_BIT0)=0D
+=0D
+int hinic3_init_cfg_mgmt(void *dev);=0D
+int hinic3_init_capability(void *dev);=0D
+void hinic3_deinit_cfg_mgmt(void *dev);=0D
+=0D
+u16 hinic3_func_max_sqs(void *hwdev);=0D
+u16 hinic3_func_max_rqs(void *hwdev);=0D
+=0D
+u8 hinic3_physical_port_id(void *hwdev);=0D
+=0D
+int cfg_mbx_ppf_proc_msg(void *hwdev, void *pri_handle, u16 pf_id, u16 vf_=
id,=0D
+			 u16 cmd, void *buf_in, u16 in_size, void *buf_out,=0D
+			 u16 *out_size);=0D
+=0D
+int cfg_mbx_vf_proc_msg(void *hwdev, void *pri_handle, u16 cmd, void *buf_=
in,=0D
+			u16 in_size, void *buf_out, u16 *out_size);=0D
+=0D
+#endif /* _HINIC3_HW_CFG_H_ */=0D
diff --git a/drivers/net/hinic3/base/hinic3_hw_comm.c b/drivers/net/hinic3/=
base/hinic3_hw_comm.c=0D
new file mode 100644=0D
index 0000000000..15d298a768=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_hw_comm.c=0D
@@ -0,0 +1,452 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_bus_pci.h>=0D
+#include <rte_hash.h>=0D
+#include <rte_jhash.h>=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_cmd.h"=0D
+#include "hinic3_cmdq.h"=0D
+#include "hinic3_hw_comm.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mgmt.h"=0D
+#include "hinic3_wq.h"=0D
+=0D
+/* Buffer sizes in hinic3_convert_rx_buf_size must be in ascending order. =
*/=0D
+const u32 hinic3_hw_rx_buf_size[] =3D {=0D
+	HINIC3_RX_BUF_SIZE_32B,=0D
+	HINIC3_RX_BUF_SIZE_64B,=0D
+	HINIC3_RX_BUF_SIZE_96B,=0D
+	HINIC3_RX_BUF_SIZE_128B,=0D
+	HINIC3_RX_BUF_SIZE_192B,=0D
+	HINIC3_RX_BUF_SIZE_256B,=0D
+	HINIC3_RX_BUF_SIZE_384B,=0D
+	HINIC3_RX_BUF_SIZE_512B,=0D
+	HINIC3_RX_BUF_SIZE_768B,=0D
+	HINIC3_RX_BUF_SIZE_1K,=0D
+	HINIC3_RX_BUF_SIZE_1_5K,=0D
+	HINIC3_RX_BUF_SIZE_2K,=0D
+	HINIC3_RX_BUF_SIZE_3K,=0D
+	HINIC3_RX_BUF_SIZE_4K,=0D
+	HINIC3_RX_BUF_SIZE_8K,=0D
+	HINIC3_RX_BUF_SIZE_16K,=0D
+};=0D
+=0D
+int=0D
+hinic3_get_interrupt_cfg(void *dev, struct interrupt_info *info)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D dev;=0D
+	struct hinic3_cmd_msix_config msix_cfg;=0D
+	u16 out_size =3D sizeof(msix_cfg);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !info)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&msix_cfg, 0, sizeof(msix_cfg));=0D
+	msix_cfg.func_id =3D hinic3_global_func_id(hwdev);=0D
+	msix_cfg.msix_index =3D info->msix_index;=0D
+	msix_cfg.opcode =3D HINIC3_MGMT_CMD_OP_GET;=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_CFG_MSIX_CTRL_REG,=0D
+		&msix_cfg, sizeof(msix_cfg), &msix_cfg, &out_size, 0);=0D
+	if (err || !out_size || msix_cfg.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get interrupt config failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, msix_cfg.status, out_size);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	info->lli_credit_limit =3D msix_cfg.lli_credit_cnt;=0D
+	info->lli_timer_cfg =3D msix_cfg.lli_tmier_cnt;=0D
+	info->pending_limt =3D msix_cfg.pending_cnt;=0D
+	info->coalesce_timer_cfg =3D msix_cfg.coalesce_timer_cnt;=0D
+	info->resend_timer_cfg =3D msix_cfg.resend_timer_cnt;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_interrupt_cfg(void *dev, struct interrupt_info info)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D dev;=0D
+	struct hinic3_cmd_msix_config msix_cfg;=0D
+	struct interrupt_info temp_info;=0D
+	u16 out_size =3D sizeof(msix_cfg);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	temp_info.msix_index =3D info.msix_index;=0D
+	err =3D hinic3_get_interrupt_cfg(hwdev, &temp_info);=0D
+	if (err)=0D
+		return -EIO;=0D
+=0D
+	memset(&msix_cfg, 0, sizeof(msix_cfg));=0D
+	msix_cfg.func_id =3D hinic3_global_func_id(hwdev);=0D
+	msix_cfg.msix_index =3D (u16)info.msix_index;=0D
+	msix_cfg.opcode =3D HINIC3_MGMT_CMD_OP_SET;=0D
+=0D
+	msix_cfg.lli_credit_cnt =3D temp_info.lli_credit_limit;=0D
+	msix_cfg.lli_tmier_cnt =3D temp_info.lli_timer_cfg;=0D
+	msix_cfg.pending_cnt =3D temp_info.pending_limt;=0D
+	msix_cfg.coalesce_timer_cnt =3D temp_info.coalesce_timer_cfg;=0D
+	msix_cfg.resend_timer_cnt =3D temp_info.resend_timer_cfg;=0D
+=0D
+	if (info.lli_set) {=0D
+		msix_cfg.lli_credit_cnt =3D info.lli_credit_limit;=0D
+		msix_cfg.lli_tmier_cnt =3D info.lli_timer_cfg;=0D
+	}=0D
+=0D
+	if (info.interrupt_coalesce_set) {=0D
+		msix_cfg.pending_cnt =3D info.pending_limt;=0D
+		msix_cfg.coalesce_timer_cnt =3D info.coalesce_timer_cfg;=0D
+		msix_cfg.resend_timer_cnt =3D info.resend_timer_cfg;=0D
+	}=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_CFG_MSIX_CTRL_REG,=0D
+		&msix_cfg, sizeof(msix_cfg), &msix_cfg, &out_size, 0);=0D
+	if (err || !out_size || msix_cfg.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set interrupt config failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, msix_cfg.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_wq_page_size(void *hwdev, u16 func_idx, u32 page_size)=0D
+{=0D
+	struct hinic3_cmd_wq_page_size page_size_info;=0D
+	u16 out_size =3D sizeof(page_size_info);=0D
+	int err;=0D
+=0D
+	memset(&page_size_info, 0, sizeof(page_size_info));=0D
+	page_size_info.func_idx =3D func_idx;=0D
+	page_size_info.page_size =3D HINIC3_PAGE_SIZE_HW(page_size);=0D
+	page_size_info.opcode =3D HINIC3_MGMT_CMD_OP_SET;=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,=0D
+				      HINIC3_MGMT_CMD_CFG_PAGESIZE,=0D
+				      &page_size_info, sizeof(page_size_info),=0D
+				      &page_size_info, &out_size, 0);=0D
+	if (err || !out_size || page_size_info.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set wq page size failed, "=0D
+			    "err: %d, status: 0x%x, out_size: 0x%0x",=0D
+			    err, page_size_info.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_func_reset(void *hwdev, u64 reset_flag)=0D
+{=0D
+	struct hinic3_reset func_reset;=0D
+	struct hinic3_hwif *hwif =3D ((struct hinic3_hwdev *)hwdev)->hwif;=0D
+	u16 out_size =3D sizeof(func_reset);=0D
+	int err =3D 0;=0D
+=0D
+	PMD_DRV_LOG(INFO, "Function is reset");=0D
+=0D
+	memset(&func_reset, 0, sizeof(func_reset));=0D
+	func_reset.func_id =3D HINIC3_HWIF_GLOBAL_IDX(hwif);=0D
+	func_reset.reset_flag =3D reset_flag;=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_FUNC_RESET, &func_reset,=0D
+		sizeof(func_reset), &func_reset, &out_size, 0);=0D
+	if (err || !out_size || func_reset.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Reset func resources failed, "=0D
+			    "err: %d, status: 0x%x, out_size: 0x%x",=0D
+			    err, func_reset.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_func_svc_used_state(void *hwdev, u16 svc_type, u8 state)=0D
+{=0D
+	struct comm_cmd_func_svc_used_state used_state;=0D
+	u16 out_size =3D sizeof(used_state);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&used_state, 0, sizeof(used_state));=0D
+	used_state.func_id =3D hinic3_global_func_id(hwdev);=0D
+	used_state.svc_type =3D svc_type;=0D
+	used_state.used_state =3D state;=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_SET_FUNC_SVC_USED_STATE,=0D
+		&used_state, sizeof(used_state), &used_state, &out_size, 0);=0D
+	if (err || !out_size || used_state.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Failed to set func service used state, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, used_state.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_convert_rx_buf_size(u32 rx_buf_sz, u32 *match_sz)=0D
+{=0D
+	u32 i, num_hw_types, best_match_sz;=0D
+=0D
+	if (unlikely(!match_sz || rx_buf_sz < HINIC3_RX_BUF_SIZE_32B))=0D
+		return -EINVAL;=0D
+=0D
+	if (rx_buf_sz >=3D HINIC3_RX_BUF_SIZE_16K) {=0D
+		best_match_sz =3D HINIC3_RX_BUF_SIZE_16K;=0D
+		goto size_matched;=0D
+	}=0D
+=0D
+	if (rx_buf_sz >=3D HINIC3_RX_BUF_SIZE_4K) {=0D
+		best_match_sz =3D ((rx_buf_sz >> RX_BUF_SIZE_1K_LEN)=0D
+				 << RX_BUF_SIZE_1K_LEN);=0D
+		goto size_matched;=0D
+	}=0D
+=0D
+	num_hw_types =3D sizeof(hinic3_hw_rx_buf_size) /=0D
+		       sizeof(hinic3_hw_rx_buf_size[0]);=0D
+	best_match_sz =3D hinic3_hw_rx_buf_size[0];=0D
+	for (i =3D 0; i < num_hw_types; i++) {=0D
+		if (rx_buf_sz =3D=3D hinic3_hw_rx_buf_size[i]) {=0D
+			best_match_sz =3D hinic3_hw_rx_buf_size[i];=0D
+			break;=0D
+		} else if (rx_buf_sz < hinic3_hw_rx_buf_size[i]) {=0D
+			break;=0D
+		}=0D
+		best_match_sz =3D hinic3_hw_rx_buf_size[i];=0D
+	}=0D
+=0D
+size_matched:=0D
+	*match_sz =3D best_match_sz;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static u16=0D
+get_hw_rx_buf_size(u32 rx_buf_sz)=0D
+{=0D
+	u16 num_hw_types =3D sizeof(hinic3_hw_rx_buf_size) /=0D
+			   sizeof(hinic3_hw_rx_buf_size[0]);=0D
+	u16 i;=0D
+=0D
+	for (i =3D 0; i < num_hw_types; i++) {=0D
+		if (hinic3_hw_rx_buf_size[i] =3D=3D rx_buf_sz)=0D
+			return i;=0D
+	}=0D
+=0D
+	PMD_DRV_LOG(WARNING, "Chip can't support rx buf size of %d", rx_buf_sz);=
=0D
+=0D
+	return DEFAULT_RX_BUF_SIZE; /**< Default 2K. */=0D
+}=0D
+=0D
+int=0D
+hinic3_set_root_ctxt(void *hwdev, u32 rq_depth, u32 sq_depth, u16 rx_buf_s=
z)=0D
+{=0D
+	struct hinic3_cmd_root_ctxt root_ctxt;=0D
+	u16 out_size =3D sizeof(root_ctxt);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&root_ctxt, 0, sizeof(root_ctxt));=0D
+	root_ctxt.func_idx =3D hinic3_global_func_id(hwdev);=0D
+	root_ctxt.set_cmdq_depth =3D 0;=0D
+	root_ctxt.cmdq_depth =3D 0;=0D
+	root_ctxt.lro_en =3D 1;=0D
+	root_ctxt.rq_depth =3D (u16)ilog2(rq_depth);=0D
+	root_ctxt.rx_buf_sz =3D get_hw_rx_buf_size(rx_buf_sz);=0D
+	root_ctxt.sq_depth =3D (u16)ilog2(sq_depth);=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_SET_VAT, &root_ctxt,=0D
+		sizeof(root_ctxt), &root_ctxt, &out_size, 0);=0D
+	if (err || !out_size || root_ctxt.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set root context failed, "=0D
+			    "err: %d, status: 0x%x, out_size: 0x%x",=0D
+			    err, root_ctxt.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_clean_root_ctxt(void *hwdev)=0D
+{=0D
+	struct hinic3_cmd_root_ctxt root_ctxt;=0D
+	u16 out_size =3D sizeof(root_ctxt);=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&root_ctxt, 0, sizeof(root_ctxt));=0D
+	root_ctxt.func_idx =3D hinic3_global_func_id(hwdev);=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_SET_VAT, &root_ctxt,=0D
+		sizeof(root_ctxt), &root_ctxt, &out_size, 0);=0D
+	if (err || !out_size || root_ctxt.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Clean root context failed, "=0D
+			    "err: %d, status: 0x%x, out_size: 0x%x",=0D
+			    err, root_ctxt.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_set_cmdq_depth(void *hwdev, u16 cmdq_depth)=0D
+{=0D
+	struct hinic3_cmd_root_ctxt root_ctxt;=0D
+	u16 out_size =3D sizeof(root_ctxt);=0D
+	int err;=0D
+=0D
+	memset(&root_ctxt, 0, sizeof(root_ctxt));=0D
+	root_ctxt.func_idx =3D hinic3_global_func_id(hwdev);=0D
+	root_ctxt.set_cmdq_depth =3D 1;=0D
+	root_ctxt.cmdq_depth =3D (u8)ilog2(cmdq_depth);=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_SET_VAT, &root_ctxt,=0D
+		sizeof(root_ctxt), &root_ctxt, &out_size, 0);=0D
+	if (err || !out_size || root_ctxt.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set cmdq depth failed, "=0D
+			    "err: %d, status: 0x%x, out_size: 0x%x",=0D
+			    err, root_ctxt.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_get_mgmt_version(void *hwdev, char *mgmt_ver, int max_mgmt_len)=0D
+{=0D
+	struct hinic3_cmd_get_fw_version fw_ver;=0D
+	u16 out_size =3D sizeof(fw_ver);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !mgmt_ver)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&fw_ver, 0, sizeof(fw_ver));=0D
+	fw_ver.fw_type =3D HINIC3_FW_VER_TYPE_MPU;=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,=0D
+				      HINIC3_MGMT_CMD_GET_FW_VERSION, &fw_ver,=0D
+				      sizeof(fw_ver), &fw_ver, &out_size, 0);=0D
+	if (MSG_TO_MGMT_SYNC_RETURN_ERR(err, out_size, fw_ver.status)) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get mgmt version failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, fw_ver.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	snprintf(mgmt_ver, max_mgmt_len, "%s", fw_ver.ver);=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_get_board_info(void *hwdev, struct hinic3_board_info *info)=0D
+{=0D
+	struct hinic3_cmd_board_info board_info;=0D
+	u16 out_size =3D sizeof(board_info);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !info)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&board_info, 0, sizeof(board_info));=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev,=0D
+		HINIC3_MOD_COMM, HINIC3_MGMT_CMD_GET_BOARD_INFO,=0D
+		&board_info, sizeof(board_info), &board_info, &out_size, 0);=0D
+	if (err || board_info.status || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get board info failed, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, board_info.status, out_size);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	memcpy(info, &board_info.info, sizeof(*info));=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_comm_features_nego(void *hwdev, u8 opcode, u64 *s_feature, u16 size=
)=0D
+{=0D
+	struct comm_cmd_feature_nego feature_nego;=0D
+	u16 out_size =3D sizeof(feature_nego);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !s_feature || size > COMM_MAX_FEATURE_QWORD)=0D
+		return -EINVAL;=0D
+=0D
+	memset(&feature_nego, 0, sizeof(feature_nego));=0D
+	feature_nego.func_id =3D hinic3_global_func_id(hwdev);=0D
+	feature_nego.opcode =3D opcode;=0D
+	if (opcode =3D=3D MGMT_MSG_CMD_OP_SET)=0D
+		memcpy(feature_nego.s_feature, s_feature, (size * sizeof(u64)));=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,=0D
+				      HINIC3_MGMT_CMD_FEATURE_NEGO,=0D
+				      &feature_nego, sizeof(feature_nego),=0D
+				      &feature_nego, &out_size, 0);=0D
+	if (err || !out_size || feature_nego.head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Failed to negotiate feature, "=0D
+			    "err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, feature_nego.head.status, out_size);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	if (opcode =3D=3D MGMT_MSG_CMD_OP_GET)=0D
+		memcpy(s_feature, feature_nego.s_feature, (size * sizeof(u64)));=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_get_comm_features(void *hwdev, u64 *s_feature, u16 size)=0D
+{=0D
+	return hinic3_comm_features_nego(hwdev, MGMT_MSG_CMD_OP_GET, s_feature,=0D
+					 size);=0D
+}=0D
+=0D
+int=0D
+hinic3_set_comm_features(void *hwdev, u64 *s_feature, u16 size)=0D
+{=0D
+	return hinic3_comm_features_nego(hwdev, MGMT_MSG_CMD_OP_SET, s_feature,=0D
+					 size);=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_hw_comm.h b/drivers/net/hinic3/=
base/hinic3_hw_comm.h=0D
new file mode 100644=0D
index 0000000000..c31952b3e6=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_hw_comm.h=0D
@@ -0,0 +1,366 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_HW_COMM_H_=0D
+#define _HINIC3_HW_COMM_H_=0D
+=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_mgmt.h"=0D
+#define HINIC3_MGMT_CMD_OP_GET 0=0D
+#define HINIC3_MGMT_CMD_OP_SET 1=0D
+=0D
+#define HINIC3_MSIX_CNT_LLI_TIMER_SHIFT	    0=0D
+#define HINIC3_MSIX_CNT_LLI_CREDIT_SHIFT    8=0D
+#define HINIC3_MSIX_CNT_COALESCE_TIMER_SHIFT 8=0D
+#define HINIC3_MSIX_CNT_PENDING_SHIFT	    8=0D
+#define HINIC3_MSIX_CNT_RESEND_TIMER_SHIFT  29=0D
+=0D
+#define HINIC3_MSIX_CNT_LLI_TIMER_MASK	   0xFFU=0D
+#define HINIC3_MSIX_CNT_LLI_CREDIT_MASK	   0xFFU=0D
+#define HINIC3_MSIX_CNT_COALESCE_TIMER_MASK 0xFFU=0D
+#define HINIC3_MSIX_CNT_PENDING_MASK	   0x1FU=0D
+#define HINIC3_MSIX_CNT_RESEND_TIMER_MASK  0x7U=0D
+=0D
+#define HINIC3_MSIX_CNT_SET(val, member)           \=0D
+	(((val) & HINIC3_MSIX_CNT_##member##_MASK) \=0D
+	 << HINIC3_MSIX_CNT_##member##_SHIFT)=0D
+=0D
+#define MSG_TO_MGMT_SYNC_RETURN_ERR(err, out_size, status) \=0D
+	((err) || (status) || !(out_size))=0D
+=0D
+#define DEFAULT_RX_BUF_SIZE ((u16)0xB)=0D
+#define RX_BUF_SIZE_1K_LEN  ((u16)0xA)=0D
+=0D
+enum hinic3_rx_buf_size {=0D
+	HINIC3_RX_BUF_SIZE_32B =3D 0x20,=0D
+	HINIC3_RX_BUF_SIZE_64B =3D 0x40,=0D
+	HINIC3_RX_BUF_SIZE_96B =3D 0x60,=0D
+	HINIC3_RX_BUF_SIZE_128B =3D 0x80,=0D
+	HINIC3_RX_BUF_SIZE_192B =3D 0xC0,=0D
+	HINIC3_RX_BUF_SIZE_256B =3D 0x100,=0D
+	HINIC3_RX_BUF_SIZE_384B =3D 0x180,=0D
+	HINIC3_RX_BUF_SIZE_512B =3D 0x200,=0D
+	HINIC3_RX_BUF_SIZE_768B =3D 0x300,=0D
+	HINIC3_RX_BUF_SIZE_1K =3D 0x400,=0D
+	HINIC3_RX_BUF_SIZE_1_5K =3D 0x600,=0D
+	HINIC3_RX_BUF_SIZE_2K =3D 0x800,=0D
+	HINIC3_RX_BUF_SIZE_3K =3D 0xC00,=0D
+	HINIC3_RX_BUF_SIZE_4K =3D 0x1000,=0D
+	HINIC3_RX_BUF_SIZE_8K =3D 0x2000,=0D
+	HINIC3_RX_BUF_SIZE_16K =3D 0x4000,=0D
+};=0D
+=0D
+struct hinic3_cmd_msix_config {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 func_id;=0D
+	u8 opcode;=0D
+	u8 rsvd1;=0D
+	u16 msix_index;=0D
+	u8 pending_cnt;=0D
+	u8 coalesce_timer_cnt;=0D
+	u8 resend_timer_cnt;=0D
+	u8 lli_tmier_cnt;=0D
+	u8 lli_credit_cnt;=0D
+	u8 rsvd2[5];=0D
+};=0D
+=0D
+struct hinic3_dma_attr_table {=0D
+	struct mgmt_msg_head head;=0D
+=0D
+	u16 func_id;=0D
+	u8 entry_idx;=0D
+	u8 st;=0D
+	u8 at;=0D
+	u8 ph;=0D
+	u8 no_snooping;=0D
+	u8 tph_en;=0D
+	u32 resv1;=0D
+};=0D
+=0D
+#define HINIC3_PAGE_SIZE_HW(pg_size) ((u8)ilog2((u32)((pg_size) >> 12)))=0D
+=0D
+struct hinic3_cmd_wq_page_size {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 func_idx;=0D
+	u8 opcode;=0D
+	/**=0D
+	 * Real size is 4KB * 2^page_size, range(0~20) must be checked by=0D
+	 * driver.=0D
+	 */=0D
+	u8 page_size;=0D
+=0D
+	u32 rsvd1;=0D
+};=0D
+=0D
+struct hinic3_reset {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 func_id;=0D
+	u16 rsvd1[3];=0D
+	u64 reset_flag;=0D
+};=0D
+=0D
+struct comm_cmd_func_svc_used_state {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 func_id;=0D
+	u16 svc_type;=0D
+	u8 used_state;=0D
+	u8 rsvd[35];=0D
+};=0D
+=0D
+struct hinic3_cmd_root_ctxt {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 func_idx;=0D
+	u8 set_cmdq_depth;=0D
+	u8 cmdq_depth;=0D
+	u16 rx_buf_sz;=0D
+	u8 lro_en;=0D
+	u8 rsvd1;=0D
+	u16 sq_depth;=0D
+	u16 rq_depth;=0D
+	u64 rsvd2;=0D
+};=0D
+=0D
+enum hinic3_fw_ver_type {=0D
+	HINIC3_FW_VER_TYPE_BOOT,=0D
+	HINIC3_FW_VER_TYPE_MPU,=0D
+	HINIC3_FW_VER_TYPE_NPU,=0D
+	HINIC3_FW_VER_TYPE_SMU,=0D
+	HINIC3_FW_VER_TYPE_CFG,=0D
+};=0D
+=0D
+#define MGMT_MSG_CMD_OP_SET 1=0D
+#define MGMT_MSG_CMD_OP_GET 0=0D
+=0D
+#define COMM_MAX_FEATURE_QWORD 4=0D
+struct comm_cmd_feature_nego {=0D
+	struct mgmt_msg_head head;=0D
+=0D
+	u16 func_id;=0D
+	u8 opcode; /**< 1: set, 0: get. */=0D
+	u8 rsvd;=0D
+	u64 s_feature[COMM_MAX_FEATURE_QWORD];=0D
+};=0D
+=0D
+#define HINIC3_FW_VERSION_LEN	    16=0D
+#define HINIC3_FW_COMPILE_TIME_LEN  20=0D
+#define HINIC3_MGMT_VERSION_MAX_LEN 32=0D
+struct hinic3_cmd_get_fw_version {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 fw_type;=0D
+	u16 rsvd1;=0D
+	u8 ver[HINIC3_FW_VERSION_LEN];=0D
+	u8 time[HINIC3_FW_COMPILE_TIME_LEN];=0D
+};=0D
+=0D
+struct hinic3_cmd_clear_doorbell {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 func_idx;=0D
+	u16 rsvd1[3];=0D
+};=0D
+=0D
+struct hinic3_cmd_clear_resource {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 func_idx;=0D
+	u16 rsvd1[3];=0D
+};=0D
+=0D
+struct hinic3_cmd_board_info {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	struct hinic3_board_info info;=0D
+=0D
+	u32 rsvd1[23];=0D
+};=0D
+=0D
+struct interrupt_info {=0D
+	u32 lli_set;=0D
+	u32 interrupt_coalesce_set;=0D
+	u16 msix_index;=0D
+	u8 lli_credit_limit;=0D
+	u8 lli_timer_cfg;=0D
+	u8 pending_limt;=0D
+	u8 coalesce_timer_cfg;=0D
+	u8 resend_timer_cfg;=0D
+};=0D
+=0D
+enum cfg_msix_operation {=0D
+	CFG_MSIX_OPERATION_FREE =3D 0,=0D
+	CFG_MSIX_OPERATION_ALLOC =3D 1,=0D
+};=0D
+=0D
+struct comm_cmd_cfg_msix_num {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 func_id;=0D
+	u8 op_code; /**< 1: alloc, 0: free. */=0D
+	u8 rsvd1;=0D
+=0D
+	u16 msix_num;=0D
+	u16 rsvd2;=0D
+};=0D
+=0D
+int hinic3_get_interrupt_cfg(void *dev, struct interrupt_info *info);=0D
+=0D
+/**=0D
+ * Set interrupt cfg.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] info=0D
+ * Interrupt info.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_interrupt_cfg(void *dev, struct interrupt_info info);=0D
+=0D
+int hinic3_set_wq_page_size(void *hwdev, u16 func_idx, u32 page_size);=0D
+=0D
+/**=0D
+ * Send a reset command to hardware.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[in] reset_flag=0D
+ * The flag that specifies the reset behavior.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_func_reset(void *hwdev, u64 reset_flag);=0D
+=0D
+/**=0D
+ * Send a command to management module to set usage state of a specific se=
rvice=0D
+ * for given function.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[in] svc_type=0D
+ * The service type to update.=0D
+ * @param[in] state=0D
+ * The state to set for the service.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_func_svc_used_state(void *hwdev, u16 svc_type, u8 state);=0D
+=0D
+/**=0D
+ * Adjust the requested RX buffer size to the closest valid size supported=
 by=0D
+ * the hardware.=0D
+ *=0D
+ * @param[in] rx_buf_sz=0D
+ * The requested RX buffer size.=0D
+ * @param[out] match_sz=0D
+ * The closest valid RX buffer size.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_convert_rx_buf_size(u32 rx_buf_sz, u32 *match_sz);=0D
+=0D
+/**=0D
+ * Send a command to apply the settings.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[in] rq_depth=0D
+ * The depth of the receive queue.=0D
+ * @param[in] sq_depth=0D
+ * The depth of the send queue.=0D
+ * @param[in] rx_buf_sz=0D
+ * The RX buffer size to set.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_root_ctxt(void *hwdev, u32 rq_depth, u32 sq_depth,=0D
+			 u16 rx_buf_sz);=0D
+=0D
+/**=0D
+ * Send a command to clear any previously set context.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_clean_root_ctxt(void *hwdev);=0D
+=0D
+/**=0D
+ * Send a command to set command queue depth.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[in] cmdq_depth=0D
+ * The desired depth of the command queue, converted to logarithmic value=
=0D
+ * before being set.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_set_cmdq_depth(void *hwdev, u16 cmdq_depth);=0D
+=0D
+/**=0D
+ * Send a command to get firmware version.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[out] mgmt_ver=0D
+ * The buffer to store the retrieved management firmware version.=0D
+ * @param[in] max_mgmt_len=0D
+ * The maximum length of the `mgmt_ver` buffer.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_get_mgmt_version(void *hwdev, char *mgmt_ver, int max_mgmt_len)=
;=0D
+=0D
+/**=0D
+ * Send a command to get board information.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @param[out] info=0D
+ * The structure to store the retrieved board information.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_get_board_info(void *hwdev, struct hinic3_board_info *info);=0D
+=0D
+int hinic3_get_comm_features(void *hwdev, u64 *s_feature, u16 size);=0D
+=0D
+int hinic3_set_comm_features(void *hwdev, u64 *s_feature, u16 size);=0D
+=0D
+#endif /* _HINIC3_HW_COMM_H_ */=0D
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/ba=
se/hinic3_hwdev.c=0D
new file mode 100644=0D
index 0000000000..38b9f88628=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c=0D
@@ -0,0 +1,573 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_bus_pci.h>=0D
+#include <rte_vfio.h>=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_cmd.h"=0D
+#include "hinic3_cmdq.h"=0D
+#include "hinic3_csr.h"=0D
+#include "hinic3_eqs.h"=0D
+#include "hinic3_hw_cfg.h"=0D
+#include "hinic3_hw_comm.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mbox.h"=0D
+#include "hinic3_mgmt.h"=0D
+#include "hinic3_wq.h"=0D
+=0D
+enum hinic3_pcie_nosnoop { HINIC3_PCIE_SNOOP =3D 0, HINIC3_PCIE_NO_SNOOP =
=3D 1 };=0D
+=0D
+enum hinic3_pcie_tph {=0D
+	HINIC3_PCIE_TPH_DISABLE =3D 0,=0D
+	HINIC3_PCIE_TPH_ENABLE =3D 1=0D
+};=0D
+=0D
+#define HINIC3_DMA_ATTR_INDIR_IDX_SHIFT 0=0D
+=0D
+#define HINIC3_DMA_ATTR_INDIR_IDX_MASK 0x3FF=0D
+=0D
+#define HINIC3_DMA_ATTR_INDIR_IDX_SET(val, member)            \=0D
+	(((u32)(val) & HINIC3_DMA_ATTR_INDIR_##member##_MASK) \=0D
+	 << HINIC3_DMA_ATTR_INDIR_##member##_SHIFT)=0D
+=0D
+#define HINIC3_DMA_ATTR_INDIR_IDX_CLEAR(val, member)      \=0D
+	((val) & (~(HINIC3_DMA_ATTR_INDIR_##member##_MASK \=0D
+		    << HINIC3_DMA_ATTR_INDIR_##member##_SHIFT)))=0D
+=0D
+#define HINIC3_DMA_ATTR_ENTRY_ST_SHIFT		0=0D
+#define HINIC3_DMA_ATTR_ENTRY_AT_SHIFT		8=0D
+#define HINIC3_DMA_ATTR_ENTRY_PH_SHIFT		10=0D
+#define HINIC3_DMA_ATTR_ENTRY_NO_SNOOPING_SHIFT 12=0D
+#define HINIC3_DMA_ATTR_ENTRY_TPH_EN_SHIFT	13=0D
+=0D
+#define HINIC3_DMA_ATTR_ENTRY_ST_MASK	       0xFF=0D
+#define HINIC3_DMA_ATTR_ENTRY_AT_MASK	       0x3=0D
+#define HINIC3_DMA_ATTR_ENTRY_PH_MASK	       0x3=0D
+#define HINIC3_DMA_ATTR_ENTRY_NO_SNOOPING_MASK 0x1=0D
+#define HINIC3_DMA_ATTR_ENTRY_TPH_EN_MASK      0x1=0D
+=0D
+#define HINIC3_DMA_ATTR_ENTRY_SET(val, member)                \=0D
+	(((u32)(val) & HINIC3_DMA_ATTR_ENTRY_##member##_MASK) \=0D
+	 << HINIC3_DMA_ATTR_ENTRY_##member##_SHIFT)=0D
+=0D
+#define HINIC3_DMA_ATTR_ENTRY_CLEAR(val, member)          \=0D
+	((val) & (~(HINIC3_DMA_ATTR_ENTRY_##member##_MASK \=0D
+		    << HINIC3_DMA_ATTR_ENTRY_##member##_SHIFT)))=0D
+=0D
+#define HINIC3_PCIE_ST_DISABLE 0=0D
+#define HINIC3_PCIE_AT_DISABLE 0=0D
+#define HINIC3_PCIE_PH_DISABLE 0=0D
+=0D
+#define PCIE_MSIX_ATTR_ENTRY 0=0D
+=0D
+#define HINIC3_CHIP_PRESENT 1=0D
+#define HINIC3_CHIP_ABSENT  0=0D
+=0D
+#define HINIC3_DEFAULT_EQ_MSIX_PENDING_LIMIT	0=0D
+#define HINIC3_DEFAULT_EQ_MSIX_COALESCE_TIMER_CFG 0xFF=0D
+#define HINIC3_DEFAULT_EQ_MSIX_RESEND_TIMER_CFG	7=0D
+=0D
+typedef void (*mgmt_event_cb)(void *handle, void *buf_in, u16 in_size,=0D
+			      void *buf_out, u16 *out_size);=0D
+=0D
+struct mgmt_event_handle {=0D
+	u16 cmd;=0D
+	mgmt_event_cb proc;=0D
+};=0D
+=0D
+bool=0D
+hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *rte_dev)=0D
+{=0D
+	return ((RTE_ETH_DEV_TO_PCI(rte_dev)->kdrv =3D=3D RTE_PCI_KDRV_VFIO) &&=0D
+		(rte_vfio_noiommu_is_enabled() !=3D 1));=0D
+}=0D
+=0D
+int=0D
+vf_handle_pf_comm_mbox(void *handle, __rte_unused void *pri_handle,=0D
+		       __rte_unused u16 cmd, __rte_unused void *buf_in,=0D
+		       __rte_unused u16 in_size, __rte_unused void *buf_out,=0D
+		       __rte_unused u16 *out_size)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D handle;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	PMD_DRV_LOG(WARNING, "Unsupported pf mbox event %d to process", cmd);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void=0D
+fault_event_handler(__rte_unused void *hwdev, __rte_unused void *buf_in,=0D
+		    __rte_unused u16 in_size, __rte_unused void *buf_out,=0D
+		    __rte_unused u16 *out_size)=0D
+{=0D
+	PMD_DRV_LOG(WARNING, "Unsupported fault event handler");=0D
+}=0D
+=0D
+static void=0D
+ffm_event_msg_handler(__rte_unused void *hwdev, void *buf_in, u16 in_size,=
=0D
+		      __rte_unused void *buf_out, u16 *out_size)=0D
+{=0D
+	struct ffm_intr_info *intr =3D NULL;=0D
+=0D
+	if (in_size !=3D sizeof(*intr)) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Invalid fault event report, "=0D
+			    "length: %d, should be %zu",=0D
+			    in_size, sizeof(*intr));=0D
+		return;=0D
+	}=0D
+=0D
+	intr =3D buf_in;=0D
+=0D
+	PMD_DRV_LOG(ERR,=0D
+		    "node_id: 0x%x, err_type: 0x%x, err_level: %d, "=0D
+		    "err_csr_addr: 0x%08x, err_csr_value: 0x%08x",=0D
+		    intr->node_id, intr->err_type, intr->err_level,=0D
+		    intr->err_csr_addr, intr->err_csr_value);=0D
+=0D
+	*out_size =3D sizeof(*intr);=0D
+}=0D
+=0D
+static const struct mgmt_event_handle mgmt_event_proc[] =3D {=0D
+	{=0D
+		.cmd =3D HINIC3_MGMT_CMD_FAULT_REPORT,=0D
+		.proc =3D fault_event_handler,=0D
+	},=0D
+=0D
+	{=0D
+		.cmd =3D HINIC3_MGMT_CMD_FFM_SET,=0D
+		.proc =3D ffm_event_msg_handler,=0D
+	},=0D
+};=0D
+=0D
+void=0D
+pf_handle_mgmt_comm_event(void *handle, __rte_unused void *pri_handle, u16=
 cmd,=0D
+			  void *buf_in, u16 in_size, void *buf_out,=0D
+			  u16 *out_size)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D handle;=0D
+	u32 i, event_num =3D RTE_DIM(mgmt_event_proc);=0D
+=0D
+	if (!hwdev)=0D
+		return;=0D
+=0D
+	for (i =3D 0; i < event_num; i++) {=0D
+		if (cmd =3D=3D mgmt_event_proc[i].cmd) {=0D
+			if (mgmt_event_proc[i].proc)=0D
+				mgmt_event_proc[i].proc(handle, buf_in, in_size,=0D
+							buf_out, out_size);=0D
+			return;=0D
+		}=0D
+	}=0D
+=0D
+	PMD_DRV_LOG(WARNING, "Unsupported mgmt cpu event %d to process", cmd);=0D
+}=0D
+=0D
+static int=0D
+set_dma_attr_entry(__rte_unused struct hinic3_hwdev *hwdev,=0D
+		   __rte_unused u8 entry_idx, __rte_unused u8 st,=0D
+		   __rte_unused u8 at, __rte_unused u8 ph,=0D
+		   __rte_unused enum hinic3_pcie_nosnoop no_snooping,=0D
+		   __rte_unused enum hinic3_pcie_tph tph_en)=0D
+{=0D
+	struct hinic3_dma_attr_table attr;=0D
+	u16 out_size =3D sizeof(attr);=0D
+	int err;=0D
+=0D
+	memset(&attr, 0, sizeof(attr));=0D
+	attr.func_id =3D hinic3_global_func_id(hwdev);=0D
+	attr.entry_idx =3D entry_idx;=0D
+	attr.st =3D st;=0D
+	attr.at =3D at;=0D
+	attr.ph =3D ph;=0D
+	attr.no_snooping =3D no_snooping;=0D
+	attr.tph_en =3D tph_en;=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,=0D
+				      HINIC3_MGMT_CMD_SET_DMA_ATTR, &attr,=0D
+				      sizeof(attr), &attr, &out_size, 0);=0D
+	if (err || !out_size || attr.head.status) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set dma attribute failed, err: %d, status: 0x%x, "=0D
+			    "out_size: 0x%x",=0D
+			    err, attr.head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Initialize the default dma attributes.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ *=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+dma_attr_table_init(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	return set_dma_attr_entry(hwdev,=0D
+		PCIE_MSIX_ATTR_ENTRY, HINIC3_PCIE_ST_DISABLE,=0D
+		HINIC3_PCIE_AT_DISABLE, HINIC3_PCIE_PH_DISABLE,=0D
+		HINIC3_PCIE_SNOOP, HINIC3_PCIE_TPH_DISABLE);=0D
+}=0D
+=0D
+static int=0D
+init_aeqs_msix_attr(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_aeqs *aeqs =3D hwdev->aeqs;=0D
+	struct interrupt_info info =3D {0};=0D
+	struct hinic3_eq *eq =3D NULL;=0D
+	u16 q_id;=0D
+	int err;=0D
+=0D
+	info.lli_set =3D 0;=0D
+	info.interrupt_coalesce_set =3D 1;=0D
+	info.pending_limt =3D HINIC3_DEFAULT_EQ_MSIX_PENDING_LIMIT;=0D
+	info.coalesce_timer_cfg =3D HINIC3_DEFAULT_EQ_MSIX_COALESCE_TIMER_CFG;=0D
+	info.resend_timer_cfg =3D HINIC3_DEFAULT_EQ_MSIX_RESEND_TIMER_CFG;=0D
+=0D
+	for (q_id =3D 0; q_id < aeqs->num_aeqs; q_id++) {=0D
+		eq =3D &aeqs->aeq[q_id];=0D
+		info.msix_index =3D eq->eq_irq.msix_entry_idx;=0D
+		err =3D hinic3_set_interrupt_cfg(hwdev, info);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Set msix attr for aeq %d failed",=0D
+				    q_id);=0D
+			return -EFAULT;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_comm_pf_to_mgmt_init(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	int err;=0D
+=0D
+	/* VF does not support send msg to mgmt directly. */=0D
+	if (hinic3_func_type(hwdev) =3D=3D TYPE_VF)=0D
+		return 0;=0D
+=0D
+	err =3D hinic3_pf_to_mgmt_init(hwdev);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void=0D
+hinic3_comm_pf_to_mgmt_free(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	/* VF does not support send msg to mgmt directly. */=0D
+	if (hinic3_func_type(hwdev) =3D=3D TYPE_VF)=0D
+		return;=0D
+=0D
+	hinic3_pf_to_mgmt_free(hwdev);=0D
+}=0D
+=0D
+static int=0D
+hinic3_comm_cmdqs_init(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D hinic3_cmdqs_init(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init cmd queues failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D hinic3_set_cmdq_depth(hwdev, HINIC3_CMDQ_DEPTH);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set cmdq depth failed");=0D
+		goto set_cmdq_depth_err;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+set_cmdq_depth_err:=0D
+	hinic3_cmdqs_free(hwdev);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void=0D
+hinic3_comm_cmdqs_free(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	hinic3_cmdqs_free(hwdev);=0D
+}=0D
+=0D
+static void=0D
+hinic3_sync_mgmt_func_state(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_ACTIVE_FLAG);=0D
+}=0D
+=0D
+static int=0D
+get_func_misc_info(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D hinic3_get_board_info(hwdev, &hwdev->board_info);=0D
+	if (err) {=0D
+		/* For the PF/VF of secondary host, return error. */=0D
+		if (hinic3_pcie_itf_id(hwdev))=0D
+			return err;=0D
+=0D
+		memset(&hwdev->board_info, 0xff,=0D
+		       sizeof(struct hinic3_board_info));=0D
+	}=0D
+=0D
+	err =3D hinic3_get_mgmt_version(hwdev, hwdev->mgmt_ver,=0D
+				      HINIC3_MGMT_VERSION_MAX_LEN);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Get mgmt cpu version failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+init_mgmt_channel(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D hinic3_aeqs_init(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init async event queues failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D hinic3_comm_pf_to_mgmt_init(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init mgmt channel failed");=0D
+		goto msg_init_err;=0D
+	}=0D
+=0D
+	err =3D hinic3_func_to_func_init(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init mailbox channel failed");=0D
+		goto func_to_func_init_err;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+func_to_func_init_err:=0D
+	hinic3_comm_pf_to_mgmt_free(hwdev);=0D
+=0D
+msg_init_err:=0D
+	hinic3_aeqs_free(hwdev);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void=0D
+free_mgmt_channel(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	hinic3_func_to_func_free(hwdev);=0D
+	hinic3_comm_pf_to_mgmt_free(hwdev);=0D
+	hinic3_aeqs_free(hwdev);=0D
+}=0D
+=0D
+static int=0D
+init_cmdqs_channel(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D dma_attr_table_init(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init dma attr table failed");=0D
+		goto dma_attr_init_err;=0D
+	}=0D
+=0D
+	err =3D init_aeqs_msix_attr(hwdev);=0D
+	if (err)=0D
+		goto init_aeqs_msix_err;=0D
+=0D
+	/* Set default wq page_size. */=0D
+	hwdev->wq_page_size =3D HINIC3_DEFAULT_WQ_PAGE_SIZE;=0D
+	err =3D hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),=0D
+				      hwdev->wq_page_size);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set wq page size failed");=0D
+		goto init_wq_pg_size_err;=0D
+	}=0D
+=0D
+	err =3D hinic3_comm_cmdqs_init(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init cmd queues failed");=0D
+		goto cmdq_init_err;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+cmdq_init_err:=0D
+	if (HINIC3_FUNC_TYPE(hwdev) !=3D TYPE_VF)=0D
+		hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),=0D
+					HINIC3_HW_WQ_PAGE_SIZE);=0D
+init_wq_pg_size_err:=0D
+init_aeqs_msix_err:=0D
+dma_attr_init_err:=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D init_mgmt_channel(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init mgmt channel failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D get_func_misc_info(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Get function msic information failed");=0D
+		goto get_func_info_err;=0D
+	}=0D
+=0D
+	err =3D hinic3_func_reset(hwdev, HINIC3_NIC_RES | HINIC3_COMM_RES);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Reset function failed");=0D
+		goto func_reset_err;=0D
+	}=0D
+=0D
+	err =3D hinic3_set_func_svc_used_state(hwdev, HINIC3_MOD_COMM, 1);=0D
+	if (err)=0D
+		goto set_used_state_err;=0D
+=0D
+	err =3D init_cmdqs_channel(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init cmdq channel failed");=0D
+		goto init_cmdqs_channel_err;=0D
+	}=0D
+=0D
+	hinic3_sync_mgmt_func_state(hwdev);=0D
+=0D
+	return 0;=0D
+=0D
+init_cmdqs_channel_err:=0D
+	hinic3_set_func_svc_used_state(hwdev, HINIC3_MOD_COMM, 0);=0D
+set_used_state_err:=0D
+func_reset_err:=0D
+get_func_info_err:=0D
+	free_mgmt_channel(hwdev);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void=0D
+hinic3_uninit_comm_ch(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_INIT);=0D
+=0D
+	hinic3_comm_cmdqs_free(hwdev);=0D
+=0D
+	if (HINIC3_FUNC_TYPE(hwdev) !=3D TYPE_VF)=0D
+		hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),=0D
+					HINIC3_HW_WQ_PAGE_SIZE);=0D
+=0D
+	hinic3_set_func_svc_used_state(hwdev, HINIC3_MOD_COMM, 0);=0D
+=0D
+	hinic3_func_to_func_free(hwdev);=0D
+=0D
+	hinic3_comm_pf_to_mgmt_free(hwdev);=0D
+=0D
+	hinic3_aeqs_free(hwdev);=0D
+}=0D
+=0D
+int=0D
+hinic3_init_hwdev(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	int err;=0D
+=0D
+	hwdev->chip_fault_stats =3D rte_zmalloc("chip_fault_stats",=0D
+					      HINIC3_CHIP_FAULT_SIZE,=0D
+					      RTE_CACHE_LINE_SIZE);=0D
+	if (!hwdev->chip_fault_stats) {=0D
+		PMD_DRV_LOG(ERR, "Alloc memory for chip_fault_stats failed");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	err =3D hinic3_init_hwif(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Initialize hwif failed");=0D
+		goto init_hwif_err;=0D
+	}=0D
+=0D
+	err =3D hinic3_init_comm_ch(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init communication channel failed");=0D
+		goto init_comm_ch_err;=0D
+	}=0D
+=0D
+	err =3D hinic3_init_cfg_mgmt(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init cfg_mgnt failed");=0D
+		goto init_cfg_err;=0D
+	}=0D
+=0D
+	err =3D hinic3_init_capability(hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init capability failed");=0D
+		goto init_cap_err;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+init_cap_err:=0D
+	hinic3_deinit_cfg_mgmt(hwdev);=0D
+init_cfg_err:=0D
+	hinic3_uninit_comm_ch(hwdev);=0D
+=0D
+init_comm_ch_err:=0D
+	hinic3_free_hwif(hwdev);=0D
+=0D
+init_hwif_err:=0D
+	rte_free(hwdev->chip_fault_stats);=0D
+=0D
+	return -EFAULT;=0D
+}=0D
+=0D
+void=0D
+hinic3_free_hwdev(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	hinic3_deinit_cfg_mgmt(hwdev);=0D
+=0D
+	hinic3_uninit_comm_ch(hwdev);=0D
+=0D
+	hinic3_free_hwif(hwdev);=0D
+=0D
+	rte_free(hwdev->chip_fault_stats);=0D
+}=0D
+=0D
+#ifndef RTE_VFIO_DMA_MAP_BASE_ADDR=0D
+#define RTE_VFIO_DMA_MAP_BASE_ADDR 0=0D
+#endif=0D
+const struct rte_memzone *=0D
+hinic3_dma_zone_reserve(const void *dev, const char *ring_name,=0D
+			uint16_t queue_id, size_t size, unsigned int align,=0D
+			int socket_id)=0D
+{=0D
+	return rte_eth_dma_zone_reserve(dev, ring_name, queue_id, size, align,=0D
+					socket_id);=0D
+}=0D
+=0D
+int=0D
+hinic3_memzone_free(const struct rte_memzone *mz)=0D
+{=0D
+	return rte_memzone_free(mz);=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.h b/drivers/net/hinic3/ba=
se/hinic3_hwdev.h=0D
new file mode 100644=0D
index 0000000000..080d1400ed=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_hwdev.h=0D
@@ -0,0 +1,177 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_HWDEV_H_=0D
+#define _HINIC3_HWDEV_H_=0D
+=0D
+#include <rte_ether.h>=0D
+#include <rte_memory.h>=0D
+#include <hinic3_mgmt.h>=0D
+=0D
+struct cfg_mgmt_info;=0D
+=0D
+struct hinic3_hwif;=0D
+struct hinic3_aeqs;=0D
+struct hinic3_mbox;=0D
+struct hinic3_msg_pf_to_mgmt;=0D
+=0D
+#define MGMT_VERSION_MAX_LEN 32=0D
+=0D
+enum hinic3_set_arm_type {=0D
+	HINIC3_SET_ARM_CMDQ,=0D
+	HINIC3_SET_ARM_SQ,=0D
+	HINIC3_SET_ARM_TYPE_NUM=0D
+};=0D
+=0D
+struct hinic3_page_addr {=0D
+	void *virt_addr;=0D
+	u64 phys_addr;=0D
+};=0D
+=0D
+struct ffm_intr_info {=0D
+	u8 node_id;=0D
+	/* Error level of the interrupt source. */=0D
+	u8 err_level;=0D
+	/* Classification by interrupt source properties. */=0D
+	u16 err_type;=0D
+	u32 err_csr_addr;=0D
+	u32 err_csr_value;=0D
+};=0D
+=0D
+struct link_event_stats {=0D
+	RTE_ATOMIC(int32_t)link_down_stats;=0D
+	RTE_ATOMIC(int32_t)link_up_stats;=0D
+};=0D
+=0D
+enum hinic3_fault_err_level {=0D
+	FAULT_LEVEL_FATAL,=0D
+	FAULT_LEVEL_SERIOUS_RESET,=0D
+	FAULT_LEVEL_SERIOUS_FLR,=0D
+	FAULT_LEVEL_GENERAL,=0D
+	FAULT_LEVEL_SUGGESTION,=0D
+	FAULT_LEVEL_MAX=0D
+};=0D
+=0D
+enum hinic3_fault_type {=0D
+	FAULT_TYPE_CHIP,=0D
+	FAULT_TYPE_UCODE,=0D
+	FAULT_TYPE_MEM_RD_TIMEOUT,=0D
+	FAULT_TYPE_MEM_WR_TIMEOUT,=0D
+	FAULT_TYPE_REG_RD_TIMEOUT,=0D
+	FAULT_TYPE_REG_WR_TIMEOUT,=0D
+	FAULT_TYPE_PHY_FAULT,=0D
+	FAULT_TYPE_MAX=0D
+};=0D
+=0D
+struct fault_event_stats {=0D
+	RTE_ATOMIC(int32_t)chip_fault_stats[22][FAULT_LEVEL_MAX];=0D
+	RTE_ATOMIC(int32_t)fault_type_stat[FAULT_TYPE_MAX];=0D
+	RTE_ATOMIC(int32_t)pcie_fault_stats;=0D
+};=0D
+=0D
+struct hinic3_hw_stats {=0D
+	RTE_ATOMIC(int32_t)heart_lost_stats;=0D
+	struct link_event_stats link_event_stats;=0D
+	struct fault_event_stats fault_event_stats;=0D
+};=0D
+=0D
+#define HINIC3_CHIP_FAULT_SIZE (110 * 1024)=0D
+#define MAX_DRV_BUF_SIZE       4096=0D
+=0D
+struct nic_cmd_chip_fault_stats {=0D
+	u32 offset;=0D
+	u8 chip_fault_stats[MAX_DRV_BUF_SIZE];=0D
+};=0D
+=0D
+struct hinic3_board_info {=0D
+	u8 board_type;=0D
+	u8 port_num;=0D
+	u8 port_speed;=0D
+	u8 pcie_width;=0D
+	u8 host_num;=0D
+	u8 pf_num;=0D
+	u16 vf_total_num;=0D
+	u8 tile_num;=0D
+	u8 qcm_num;=0D
+	u8 core_num;=0D
+	u8 work_mode;=0D
+	u8 service_mode;=0D
+	u8 pcie_mode;=0D
+	u8 boot_sel;=0D
+	u8 board_id;=0D
+	u32 cfg_addr;=0D
+	u32 service_en_bitmap;=0D
+	u8 scenes_id;=0D
+	u8 cfg_template_id;=0D
+	u16 rsvd0;=0D
+};=0D
+=0D
+struct hinic3_hwdev {=0D
+	void *dev_handle; /**< Pointer to hinic3_nic_dev. */=0D
+	void *pci_dev;	  /**< Pointer to rte_pci_device. */=0D
+	void *eth_dev;	  /**< Pointer to rte_eth_dev. */=0D
+=0D
+	uint16_t port_id;=0D
+=0D
+	u32 wq_page_size;=0D
+=0D
+	struct hinic3_hwif *hwif;=0D
+	struct cfg_mgmt_info *cfg_mgmt;=0D
+=0D
+	struct hinic3_cmdqs *cmdqs;=0D
+	struct hinic3_aeqs *aeqs;=0D
+	struct hinic3_mbox *func_to_func;=0D
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;=0D
+	struct hinic3_hw_stats hw_stats;=0D
+	u8 *chip_fault_stats;=0D
+=0D
+	struct hinic3_board_info board_info;=0D
+	char mgmt_ver[MGMT_VERSION_MAX_LEN];=0D
+=0D
+	u16 max_vfs;=0D
+	u16 link_status;=0D
+};=0D
+=0D
+bool hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *rte_dev);=0D
+=0D
+int vf_handle_pf_comm_mbox(void *handle, __rte_unused void *pri_handle,=0D
+			   __rte_unused u16 cmd, __rte_unused void *buf_in,=0D
+			   __rte_unused u16 in_size, __rte_unused void *buf_out,=0D
+			   __rte_unused u16 *out_size);=0D
+=0D
+/**=0D
+ * Handle management communication events for the PF.=0D
+ *=0D
+ * Processes the event based on the command, and calls the corresponding=0D
+ * handler if supported.=0D
+ *=0D
+ * @param[in] handle=0D
+ * Pointer to the hardware device context.=0D
+ * @param[in] cmd=0D
+ * Command associated with the management event.=0D
+ * @param[in] buf_in=0D
+ * Input buffer containing event data.=0D
+ * @param[in] in_size=0D
+ * Size of the input buffer.=0D
+ * @param[out] buf_out=0D
+ * Output buffer to store event response.=0D
+ * @param[out] out_size=0D
+ * Size of the output buffer.=0D
+ */=0D
+void pf_handle_mgmt_comm_event(void *handle, __rte_unused void *pri_handle=
,=0D
+			       u16 cmd, void *buf_in, u16 in_size,=0D
+			       void *buf_out, u16 *out_size);=0D
+=0D
+int hinic3_init_hwdev(struct hinic3_hwdev *hwdev);=0D
+=0D
+void hinic3_free_hwdev(struct hinic3_hwdev *hwdev);=0D
+=0D
+const struct rte_memzone *=0D
+hinic3_dma_zone_reserve(const void *dev, const char *ring_name,=0D
+			uint16_t queue_id, size_t size, unsigned int align,=0D
+			int socket_id);=0D
+=0D
+int hinic3_memzone_free(const struct rte_memzone *mz);=0D
+=0D
+#endif /* _HINIC3_HWDEV_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

