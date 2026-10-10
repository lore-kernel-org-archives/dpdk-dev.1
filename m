Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39679CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0440E40A76;
	Sat, 10 Oct 2026 16:45:28 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 4B5834026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=7jHV//IamQ9S5lm1IJIIjbYIzwbP+72AjC7B9/2wDrs=;
 b=EWspO/h97M1yKOze4FVUY3U6gob+PQ8GyAUsQm+umBCTLkffL+KhEHvyIfqt+0
 8gKY+Dq5+JCK8jztf5C4M0Zh/C5H2P40HwHaHLxCdIL3KX3JRe9GBhS2ZlVV4HFn
 NlPTLWSzb5n6j8C2Gke3QrEgefWvRXJcANiHK6eVjr09k=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 10/17] net/hinic3: add SP560 NIC type identification and
 handling
Date: Sat, 10 Oct 2026 22:45:01 +0800
Message-ID: <20261010144509.2731-11-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S12
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cr1xJF1UGrWkCw45ZFyDGFg_yoW8GF4xAo
 Z3Ar1fKF1rtr4xG34qgrs7tFsrXas7ZFs5J390kFnIgay2q34UXF9xJw48Ja4rZr4rCrW3
 Aa48Ja1vyanrJ34Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUw_-PDUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMh1ASmrKT30nxQAA3V
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

Identify the new SP560 NIC through its PCI device ID and select NIC-type=0D
specific operations, and add 400G/800G line rate support. At init, read=0D
the receive WQE type from the kernel module parameter to decide whether=0D
the SP560 uses the normal or compact CQE data path.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 doc/guides/rel_notes/release_26_11.rst     |   1 +=0D
 drivers/net/hinic3/base/hinic3_csr.h       |   8 +-=0D
 drivers/net/hinic3/base/hinic3_hwif.c      |   4 +-=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h   |   4 +=0D
 drivers/net/hinic3/base/hinic3_nic_event.c |  72 +++++++++++--=0D
 drivers/net/hinic3/hinic3_ethdev.c         | 111 ++++++++++++++++++++-=0D
 drivers/net/hinic3/hinic3_rx.c             |  19 ++++=0D
 7 files changed, 206 insertions(+), 13 deletions(-)=0D
=0D
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst=0D
index 80530ac25d..2e8e1e082a 100644=0D
--- a/doc/guides/rel_notes/release_26_11.rst=0D
+++ b/doc/guides/rel_notes/release_26_11.rst=0D
@@ -98,6 +98,7 @@ New Features=0D
   * Added FEC mode get and set support.=0D
   * Added Class of Service (COS) mask and map support.=0D
   * Updated RSS hash type configuration.=0D
+  * Added support for the SP560 NIC.=0D
 =0D
 * **Updated Intel iavf driver.**=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base=
/hinic3_csr.h=0D
index eceb34e9fd..fba2f6838a 100644=0D
--- a/drivers/net/hinic3/base/hinic3_csr.h=0D
+++ b/drivers/net/hinic3/base/hinic3_csr.h=0D
@@ -8,13 +8,17 @@=0D
 #define PCI_VENDOR_ID_HUAWEI	0x19e5=0D
 =0D
 #define HINIC3_DEV_ID_SP620	0x0222=0D
-#define HINIC3_DEV_ID_VF_SP620	0x375F=0D
+#define HINIC3_DEV_ID_VF_SP620	0x375f=0D
 =0D
 #define HINIC3_DEV_ID_SP230	0x0229=0D
-#define HINIC3_DEV_ID_VF_SP230	0x3750=0D
+#define HINIC3_DEV_ID_VF_SP230	0x022a=0D
 =0D
 #define HINIC3_DEV_ID_SP920	0x0224=0D
 =0D
+#define HINIC3_DEV_ID_SP560		0x0230=0D
+#define HINIC3_DEV_ID_VF_SP560		0x0231=0D
+#define HINIC3_DEV_ID_HYPER_VF_SP560	0x0232=0D
+=0D
 /*=0D
  * Bit30/bit31 for bar index flag.=0D
  * 00: bar0=0D
diff --git a/drivers/net/hinic3/base/hinic3_hwif.c b/drivers/net/hinic3/bas=
e/hinic3_hwif.c=0D
index c82b223fa0..af1dddabf4 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hwif.c=0D
+++ b/drivers/net/hinic3/base/hinic3_hwif.c=0D
@@ -141,7 +141,9 @@=0D
 static inline bool hinic3_is_vf_dev(const struct rte_pci_device *pdev)=0D
 {=0D
 	return pdev->id.device_id =3D=3D HINIC3_DEV_ID_VF_SP620 ||=0D
-	       pdev->id.device_id =3D=3D HINIC3_DEV_ID_VF_SP230;=0D
+	       pdev->id.device_id =3D=3D HINIC3_DEV_ID_VF_SP230 ||=0D
+	       pdev->id.device_id =3D=3D HINIC3_DEV_ID_VF_SP560 ||=0D
+	       pdev->id.device_id =3D=3D HINIC3_DEV_ID_HYPER_VF_SP560;=0D
 }=0D
 =0D
 uint32_t=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/=
base/hinic3_nic_cfg.h=0D
index ef139b25b9..0de8179c19 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
@@ -127,6 +127,8 @@ enum nic_speed_level {=0D
 	LINK_SPEED_50GB,=0D
 	LINK_SPEED_100GB,=0D
 	LINK_SPEED_200GB,=0D
+	LINK_SPEED_400GB,=0D
+	LINK_SPEED_800GB,=0D
 	LINK_SPEED_LEVELS,=0D
 };=0D
 =0D
@@ -181,6 +183,8 @@ enum mag_cmd_port_speed {=0D
 	PORT_SPEED_50GB    =3D 7,=0D
 	PORT_SPEED_100GB   =3D 8,=0D
 	PORT_SPEED_200GB   =3D 9,=0D
+	PORT_SPEED_400GB   =3D 10,=0D
+	PORT_SPEED_800GB   =3D 11,=0D
 	PORT_SPEED_UNKNOWN=0D
 };=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_event.c b/drivers/net/hinic=
3/base/hinic3_nic_event.c=0D
index 2f2d6aa75b..131acc47dd 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_event.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_event.c=0D
@@ -15,6 +15,7 @@ static const char *g_hw_to_char_fec[HILINK_FEC_MAX_TYPE] =
=3D {=0D
 static const char *g_hw_to_speed_info[PORT_SPEED_UNKNOWN] =3D {=0D
 	"not set", "10MB", "100MB", "1GB",   "10GB",=0D
 	"25GB",	   "40GB", "50GB",  "100GB", "200GB",=0D
+	"400GB",   "800GB",=0D
 };=0D
 static const char *g_hw_to_an_state_info[PORT_CFG_AN_OFF + 1] =3D {=0D
 	"not set", "on", "off",=0D
@@ -25,6 +26,37 @@ struct port_type_table {=0D
 	const char *port_type_name;=0D
 };=0D
 =0D
+/*=0D
+ * Hardware cable speed modes.=0D
+ *=0D
+ * The firmware reports the cable speed mode as a uint8_t value. Speeds wh=
ose raw=0D
+ * Gbps value cannot be represented in 8 bits (notably 400G and 800G) are=
=0D
+ * therefore encoded with indirection codes instead, and must be translate=
d=0D
+ * back to their real speeds through speed_mode_map[] below.=0D
+ */=0D
+enum {=0D
+	HW_CABLE_SPEED_MODE_200G =3D 200,=0D
+	HW_CABLE_SPEED_MODE_400G =3D 201,=0D
+	HW_CABLE_SPEED_MODE_800G =3D 202,=0D
+};=0D
+=0D
+/* Real cable speeds in Gbps, as exposed to the upper layer. */=0D
+enum {=0D
+	REAL_CABLE_SPEED_400G    =3D 400,=0D
+	REAL_CABLE_SPEED_800G    =3D 800,=0D
+};=0D
+=0D
+/* Mapping between a cable speed mode (uint8_t) and its real speed in Gbps=
. */=0D
+struct speed_mode_map_entry {=0D
+	uint8_t speed_mode;=0D
+	uint32_t real_speed;=0D
+};=0D
+=0D
+static const struct speed_mode_map_entry speed_mode_map[] =3D {=0D
+	{HW_CABLE_SPEED_MODE_400G, REAL_CABLE_SPEED_400G},=0D
+	{HW_CABLE_SPEED_MODE_800G, REAL_CABLE_SPEED_800G},=0D
+};=0D
+=0D
 void=0D
 hinic3_get_link_port_info(struct hinic3_hwdev *hwdev, uint8_t link_state,=
=0D
 	      struct rte_eth_link *link)=0D
@@ -35,6 +67,7 @@ hinic3_get_link_port_info(struct hinic3_hwdev *hwdev, uin=
t8_t link_state,=0D
 		RTE_ETH_SPEED_NUM_10G,	RTE_ETH_SPEED_NUM_25G,=0D
 		RTE_ETH_SPEED_NUM_40G,	RTE_ETH_SPEED_NUM_50G,=0D
 		RTE_ETH_SPEED_NUM_100G, RTE_ETH_SPEED_NUM_200G,=0D
+		RTE_ETH_SPEED_NUM_400G, RTE_ETH_SPEED_NUM_800G=0D
 	};=0D
 	struct nic_port_info port_info =3D {0};=0D
 	int err;=0D
@@ -53,6 +86,13 @@ hinic3_get_link_port_info(struct hinic3_hwdev *hwdev, ui=
nt8_t link_state,=0D
 			link->link_duplex =3D RTE_ETH_LINK_FULL_DUPLEX;=0D
 			link->link_autoneg =3D RTE_ETH_LINK_FIXED;=0D
 		} else {=0D
+			if (port_info.speed >=3D LINK_SPEED_LEVELS) {=0D
+				PMD_DRV_LOG(WARNING,=0D
+					"Invalid port speed %u reported by firmware, reset to %u",=0D
+					port_info.speed,=0D
+					port_info.speed % LINK_SPEED_LEVELS);=0D
+			}=0D
+=0D
 			link->link_speed =3D=0D
 				port_speed[port_info.speed % LINK_SPEED_LEVELS];=0D
 			link->link_duplex =3D port_info.duplex;=0D
@@ -176,6 +216,22 @@ get_port_temperature_power(struct mag_cmd_event_port_i=
nfo *info, char *str)=0D
 	return 0;=0D
 }=0D
 =0D
+static uint32_t=0D
+get_real_cable_speed(uint8_t speed)=0D
+{=0D
+	uint32_t i;=0D
+=0D
+	if (speed <=3D HW_CABLE_SPEED_MODE_200G)=0D
+		return speed;=0D
+	for (i =3D 0; i < RTE_DIM(speed_mode_map); i++) {=0D
+		if (speed_mode_map[i].speed_mode =3D=3D speed)=0D
+			return speed_mode_map[i].real_speed;=0D
+	}=0D
+=0D
+	PMD_DRV_LOG(ERR, "unsupported cable speed mode: 0x%x", speed);=0D
+	return speed;=0D
+}=0D
+=0D
 static void=0D
 print_cable_info(struct mag_cmd_event_port_info *port_info)=0D
 {=0D
@@ -201,9 +257,9 @@ print_cable_info(struct mag_cmd_event_port_info *port_i=
nfo)=0D
 	memcpy(vendor, port_info->vendor_name,=0D
 	       sizeof(port_info->vendor_name));=0D
 	snprintf(str, CAP_INFO_MAX_LEN - 1,=0D
-		     "Vendor: %s, %s, length: %um, max_speed: %uGbps",=0D
-		     vendor, port_type, port_info->cable_length,=0D
-		     port_info->max_speed);=0D
+	     "Vendor: %s, %s, length: %um, max_speed: %uGbps",=0D
+	     vendor, port_type, port_info->cable_length,=0D
+	     get_real_cable_speed(port_info->max_speed));=0D
 =0D
 	if (port_info->port_type =3D=3D LINK_PORT_OPTICAL_MM ||=0D
 	    port_info->port_type =3D=3D LINK_PORT_AOC) {=0D
@@ -282,9 +338,13 @@ port_info_event_printf(struct hinic3_hwdev *hwdev, str=
uct hinic3_handler_info *h=0D
 	struct mag_cmd_event_port_info *port_info =3D handler_info->buf_in;=0D
 	((struct mag_cmd_event_port_info *)(handler_info->buf_out))->head.status =
=3D 0;=0D
 	enum hinic3_nic_event_type type =3D port_info->event_type;=0D
-	if (type < RTE_ETH_LINK_DOWN || type > RTE_ETH_LINK_UP) {=0D
-		PMD_DRV_LOG(ERR, "Invalid hilink info report, type: %d", type);=0D
-		return;=0D
+	struct hinic3_nic_dev *nic_dev =3D ((struct hinic3_hwdev *)hwdev)->dev_ha=
ndle;=0D
+=0D
+	if (HINIC3_IS_SP620_NIC(nic_dev)) {=0D
+		if (type < RTE_ETH_LINK_DOWN || type > RTE_ETH_LINK_UP) {=0D
+			PMD_DRV_LOG(ERR, "Invalid hilink info report, type: %d", type);=0D
+			return;=0D
+		}=0D
 	}=0D
 =0D
 	print_port_info(hwdev, port_info, type);=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index 9adfe7db41..603330846e 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -472,6 +472,67 @@ hinic3_pf_get_default_cos(struct hinic3_hwdev *hwdev, =
uint8_t *cos_id)=0D
 	return 0;=0D
 }=0D
 =0D
+static int=0D
+hinic3_parse_sysfs_value(const char *filename, unsigned long *val)=0D
+{=0D
+	FILE *f;=0D
+	char buf[BUFSIZ];=0D
+	char *end =3D NULL;=0D
+=0D
+	f =3D fopen(filename, "r");=0D
+	if (f =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "Cannot open sysfs value %s", filename);=0D
+		return -1;=0D
+	}=0D
+=0D
+	if (fgets(buf, sizeof(buf), f) =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "Cannot read sysfs value %s", filename);=0D
+		fclose(f);=0D
+		return -1;=0D
+	}=0D
+	*val =3D strtoul(buf, &end, 0);=0D
+	if ((buf[0] =3D=3D '\0') || end =3D=3D NULL || (*end !=3D '\n')) {=0D
+		PMD_DRV_LOG(ERR, "Cannot parse sysfs value %s", filename);=0D
+		fclose(f);=0D
+		return -1;=0D
+	}=0D
+	fclose(f);=0D
+	return 0;=0D
+}=0D
+=0D
+/*=0D
+ * Try to read sysfs parameter from kernel module.=0D
+ * SP620 NIC uses "hinic3" kernel driver, other NICs (e.g. BP/SP560/SP230)=
=0D
+ * use "hinic5" kernel driver.=0D
+ * The module name could be either "driver_name" or "driver_name_nic".=0D
+ * Returns 0 on success, -1 on failure.=0D
+ */=0D
+static int=0D
+hinic3_read_module_param(struct hinic3_nic_dev *nic_dev, const char *param=
_name,=0D
+			 unsigned long *val)=0D
+{=0D
+	const char *driver_name =3D HINIC3_IS_SP620_NIC(nic_dev) ?=0D
+				  "hinic3" : "hinic5";=0D
+	char path[PATH_MAX];=0D
+	int ret;=0D
+=0D
+	snprintf(path, sizeof(path), "/sys/module/%s/parameters/%s",=0D
+		 driver_name, param_name);=0D
+	ret =3D hinic3_parse_sysfs_value(path, val);=0D
+	if (ret =3D=3D 0)=0D
+		return 0;=0D
+=0D
+	snprintf(path, sizeof(path), "/sys/module/%s_nic/parameters/%s",=0D
+		 driver_name, param_name);=0D
+	ret =3D hinic3_parse_sysfs_value(path, val);=0D
+	if (ret =3D=3D 0)=0D
+		return 0;=0D
+=0D
+	PMD_DRV_LOG(ERR, "Failed to read parameter %s from module %s or %s_nic",=
=0D
+		    param_name, driver_name, driver_name);=0D
+	return -1;=0D
+}=0D
+=0D
 static void=0D
 hinic3_get_cos_mask(struct hinic3_hwdev *hwdev, uint8_t *cos_mask)=0D
 {=0D
@@ -539,6 +600,26 @@ hinic3_init_default_cos(struct hinic3_nic_dev *nic_dev=
)=0D
 	return 0;=0D
 }=0D
 =0D
+static enum nic_type=0D
+hinic3_get_nic_type(struct rte_pci_device *pci_dev)=0D
+{=0D
+	switch (pci_dev->id.device_id) {=0D
+	case HINIC3_DEV_ID_SP620:=0D
+	case HINIC3_DEV_ID_VF_SP620:=0D
+	case HINIC3_DEV_ID_SP920: /* SP920 is the DPU card of SP620. */=0D
+		return NIC_SP620;=0D
+	case HINIC3_DEV_ID_SP560:=0D
+	case HINIC3_DEV_ID_VF_SP560:=0D
+	case HINIC3_DEV_ID_HYPER_VF_SP560:=0D
+		return NIC_SP560;=0D
+	case HINIC3_DEV_ID_SP230:=0D
+	case HINIC3_DEV_ID_VF_SP230:=0D
+		return NIC_SP230;=0D
+	default:=0D
+		return NIC_UNKNOWN;=0D
+	}=0D
+}=0D
+=0D
 /**=0D
  * Get cmdq ops for the given NIC device.=0D
  *=0D
@@ -551,10 +632,18 @@ hinic3_init_default_cos(struct hinic3_nic_dev *nic_de=
v)=0D
 const struct hinic3_nic_cmdq_ops *=0D
 hinic3_cmdq_get_ops(struct hinic3_nic_dev *nic_dev)=0D
 {=0D
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)=0D
-		return &hinic3_htn_cmdq_ops;=0D
-	else=0D
-		return &hinic3_stn_cmdq_ops;=0D
+	static const struct hinic3_nic_cmdq_ops *cmdq_ops[] =3D {=0D
+		[NIC_SP620]  =3D &hinic3_stn_cmdq_ops,=0D
+		[NIC_SP560]  =3D &hinic3_stn_cmdq_ops,=0D
+		[NIC_SP230]  =3D &hinic3_htn_cmdq_ops,=0D
+		[NIC_UNKNOWN] =3D &hinic3_stn_cmdq_ops,=0D
+	};=0D
+	static const struct hinic3_nic_cmdq_ops *cached_ops;=0D
+=0D
+	if (cached_ops =3D=3D NULL)=0D
+		cached_ops =3D cmdq_ops[nic_dev->nic_type];=0D
+=0D
+	return cached_ops;=0D
 }=0D
 =0D
 /**=0D
@@ -3652,6 +3741,7 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 	struct hinic3_tcam_info *tcam_info =3D NULL;=0D
 	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
 	struct rte_pci_device *pci_dev =3D NULL;=0D
+	unsigned long compact_cqe =3D 0;=0D
 	int err;=0D
 =0D
 	pci_dev =3D RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);=0D
@@ -3666,6 +3756,7 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 =0D
 	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
 	memset(nic_dev, 0, sizeof(*nic_dev));=0D
+	nic_dev->nic_type =3D hinic3_get_nic_type(pci_dev);=0D
 	snprintf(nic_dev->dev_name, sizeof(nic_dev->dev_name),=0D
 		"dbdf-%.4x:%.2x:%.2x.%x", pci_dev->addr.domain,=0D
 		pci_dev->addr.bus, pci_dev->addr.devid,=0D
@@ -3750,6 +3841,15 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 =0D
 	hinic3_nic_tx_rx_ops_init(nic_dev);=0D
 =0D
+	/* Read wqe type from kernel parameter. */=0D
+	if (hinic3_read_module_param(nic_dev, "rq_wqe_type", &compact_cqe) !=3D 0=
) {=0D
+		err =3D -EINVAL;=0D
+		goto get_cap_fail;=0D
+	}=0D
+=0D
+	if (compact_cqe =3D=3D 1)=0D
+		nic_dev->feature_cap &=3D ~(NIC_F_RX_SW_COMPACT_CQE | NIC_F_RX_HW_COMPAC=
T_CQE);=0D
+=0D
 	err =3D hinic3_init_sw_rxtxqs(nic_dev);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Init sw rxqs or txqs failed, dev_name: %s",=0D
@@ -3899,6 +3999,9 @@ static const struct rte_pci_id pci_id_hinic3_map[] =
=3D {=0D
 	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP230)},=0D
 =0D
 	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP920)},=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_SP560)},=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_VF_SP560)},=0D
+	{RTE_PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, HINIC3_DEV_ID_HYPER_VF_SP560)},=0D
 =0D
 	{.vendor_id =3D 0},=0D
 };=0D
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.=
c=0D
index 57e50590cd..493855b431 100644=0D
--- a/drivers/net/hinic3/hinic3_rx.c=0D
+++ b/drivers/net/hinic3/hinic3_rx.c=0D
@@ -634,6 +634,25 @@ hinic3_poll_integrated_cqe_rq_empty(struct hinic3_rxq =
*rxq)=0D
 	rq_ci.dw1.value =3D hinic3_hw_cpu32(val);=0D
 	hw_ci =3D rq_ci.dw1.bs.hw_ci;=0D
 =0D
+	if (HINIC3_IS_SP560_NIC(rxq->nic_dev)) {=0D
+		uint16_t sw_pi =3D hinic3_get_rq_local_pi(rxq);=0D
+		uint64_t end;=0D
+=0D
+		end =3D cycles + msecs_to_cycles(HINIC3_FLUSH_QUEUE_TIMEOUT);=0D
+		do {=0D
+			val =3D rte_read32(&rxq->rq_ci->dw1.value);=0D
+			rq_ci.dw1.value =3D hinic3_hw_cpu32(val);=0D
+			hw_ci =3D rq_ci.dw1.bs.hw_ci;=0D
+			if (sw_pi =3D=3D hw_ci)=0D
+				break;=0D
+=0D
+			rte_delay_us(1);=0D
+		} while (time_before(cycles, end));=0D
+=0D
+		if (sw_pi !=3D hw_ci)=0D
+			return -EFAULT;=0D
+	}=0D
+=0D
 	while (sw_ci !=3D hw_ci) {=0D
 		rx_info =3D &rxq->rx_info[sw_ci];=0D
 		rte_pktmbuf_free(rx_info->mbuf);=0D
-- =0D
2.33.0=0D
=0D

