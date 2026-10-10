Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A188CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B88640B99;
	Sat, 10 Oct 2026 16:45:32 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 90E8D40679
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=2DRhZUtvypylOQpq3pPpnAQ3Bt5O9vqXMCLaVt3V4qM=;
 b=kv5PixqGj+j+UE07qxUvm8NK3QBN7xqFXjftyCp3gTKxp6FMqHHZTWYm8WQ5fH
 dfB2EPrYFd+nF0vDvDkU/bc8kBYiBc3vKBHjM7VvuqxVMaxdcGuRq8nr2iQuu5bv
 Uj6/BqYIPLolFb8Yl1EmR2szM1oh/6I+05gnt/RZv6Trk=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 17/17] net/hinic3: add mbox count telemetry support
Date: Sat, 10 Oct 2026 22:45:08 +0800
Message-ID: <20261010144509.2731-18-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S19
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFWftr4UKFW5XF18ArW3GFg_yoW7CFW3pF
 Wrur95urWDta1xGwn3C3ZrZF45Zws5u342kF9rC3W5ur18Ar18uay8KFy8Z3W7trW7t3W7
 Za1YgrZFgF4qgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0ZXOUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQBBS2rKT4AvmAAA3n
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

Expose a telemetry command reporting per-function mbox send/ack counters so=
=0D
mailbox activity can be observed for diagnosis.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 doc/guides/rel_notes/release_26_11.rst |   1 +=0D
 drivers/net/hinic3/hinic3_telemetry.c  | 104 +++++++++++++++++++++++++=0D
 drivers/net/hinic3/hinic3_telemetry.h  |  25 ++++++=0D
 drivers/net/hinic3/meson.build         |   1 +=0D
 4 files changed, 131 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/hinic3_telemetry.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_telemetry.h=0D
=0D
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst=0D
index 216f2b297e..8280d24750 100644=0D
--- a/doc/guides/rel_notes/release_26_11.rst=0D
+++ b/doc/guides/rel_notes/release_26_11.rst=0D
@@ -103,6 +103,7 @@ New Features=0D
   * Added a compact CQE receive data path.=0D
   * Extended TCP segmentation offload (TSO) to 255 segments.=0D
   * Added a compact CQE transmit data path.=0D
+  * Added a mailbox count telemetry endpoint.=0D
 =0D
 * **Updated Intel iavf driver.**=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_telemetry.c b/drivers/net/hinic3/hin=
ic3_telemetry.c=0D
new file mode 100644=0D
index 0000000000..63180aaf85=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_telemetry.c=0D
@@ -0,0 +1,104 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) 2025-2026 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_os.h>=0D
+#include <rte_telemetry.h>=0D
+#include "base/hinic3_compat.h"=0D
+#include "base/hinic3_mgmt.h"=0D
+#include "base/hinic3_hwdev.h"=0D
+#include "base/hinic3_mbox.h"=0D
+#include "hinic3_ethdev.h"=0D
+#include "hinic3_telemetry.h"=0D
+=0D
+static int=0D
+hinic3_get_mbox_info(struct rte_eth_dev *eth_dev, struct mbox_cnt_info *mb=
ox_cnt)=0D
+{=0D
+	struct rte_pci_device *pci_dev =3D RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_=
dev);=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_=
dev);=0D
+	uint32_t i;=0D
+=0D
+	if (pci_dev =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "Get pci device failed.");=0D
+		return -1;=0D
+	}=0D
+=0D
+	if (nic_dev =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "Get nic device failed.");=0D
+		return -1;=0D
+	}=0D
+=0D
+	i =3D mbox_cnt->func_num;=0D
+	mbox_cnt->func_num++;=0D
+	snprintf(mbox_cnt->func_info[i].bus_info,=0D
+		 sizeof(mbox_cnt->func_info[i].bus_info), "%.4x_%.2x_%.2x_%x",=0D
+		 pci_dev->addr.domain, pci_dev->addr.bus,=0D
+		 pci_dev->addr.devid, pci_dev->addr.function);=0D
+=0D
+	mbox_cnt->func_info[i].send_cnt =3D nic_dev->hwdev->func_to_func->mbox_se=
nd_cnt;=0D
+	mbox_cnt->func_info[i].ack_cnt =3D nic_dev->hwdev->func_to_func->mbox_ack=
_cnt;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_telemetry_info(const char *cmd __rte_unused, const char *params __r=
te_unused,=0D
+		      struct rte_tel_data *d)=0D
+{=0D
+	struct rte_eth_dev *eth_dev =3D NULL;=0D
+	struct rte_tel_data *i_data =3D NULL;=0D
+	struct rte_tel_data *func_data =3D NULL;=0D
+	struct mbox_cnt_info mbox_cnt;=0D
+	uint32_t i;=0D
+	int err;=0D
+=0D
+	memset(&mbox_cnt, 0, sizeof(struct mbox_cnt_info));=0D
+=0D
+	for (i =3D 0; i < RTE_MAX_ETHPORTS; i++) {=0D
+		/* Skip if port is unused */=0D
+		if (!rte_eth_dev_is_valid_port(i))=0D
+			continue;=0D
+=0D
+		eth_dev =3D &rte_eth_devices[i];=0D
+		if (eth_dev) {=0D
+			err =3D hinic3_get_mbox_info(eth_dev, &mbox_cnt);=0D
+			if (err) {=0D
+				PMD_DRV_LOG(ERR, "Get mbox info failed.");=0D
+				return -1;=0D
+			}=0D
+		}=0D
+	}=0D
+=0D
+	rte_tel_data_start_dict(d);=0D
+	rte_tel_data_add_dict_int(d, "func_num", mbox_cnt.func_num);=0D
+=0D
+	i_data =3D rte_tel_data_alloc();=0D
+	if (i_data =3D=3D NULL)=0D
+		return -ENOMEM;=0D
+=0D
+	rte_tel_data_start_dict(i_data);=0D
+=0D
+	for (i =3D 0; i < mbox_cnt.func_num; i++) {=0D
+		func_data =3D rte_tel_data_alloc();=0D
+		if (func_data =3D=3D NULL) {=0D
+			rte_tel_data_free(i_data);=0D
+			return -ENOMEM;=0D
+		}=0D
+=0D
+		rte_tel_data_start_dict(func_data);=0D
+		rte_tel_data_add_dict_int(func_data, "send_cnt", mbox_cnt.func_info[i].s=
end_cnt);=0D
+		rte_tel_data_add_dict_int(func_data, "ack_cnt", mbox_cnt.func_info[i].ac=
k_cnt);=0D
+		rte_tel_data_add_dict_container(i_data, mbox_cnt.func_info[i].bus_info,=
=0D
+						func_data, 0);=0D
+	}=0D
+=0D
+	rte_tel_data_add_dict_container(d, "func_info", i_data, 0);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+RTE_INIT(hinic3_init_telemetry)=0D
+{=0D
+	rte_telemetry_register_cmd("/hinic3/mbox_cnt", hinic3_telemetry_info,=0D
+				   "Returns mbox send and ack count information");=0D
+}=0D
diff --git a/drivers/net/hinic3/hinic3_telemetry.h b/drivers/net/hinic3/hin=
ic3_telemetry.h=0D
new file mode 100644=0D
index 0000000000..8751082061=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_telemetry.h=0D
@@ -0,0 +1,25 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright (c) 2025-2026 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_TELEMETRY_H_=0D
+#define _HINIC3_TELEMETRY_H_=0D
+=0D
+#include <stdint.h>=0D
+=0D
+#define HINIC_PF_MAX_SIZE 16=0D
+#define HINIC_VF_MAX_SIZE 4096=0D
+#define BUSINFO_LEN	  32=0D
+=0D
+struct func_mbox_cnt_info {=0D
+	char bus_info[BUSINFO_LEN];=0D
+	uint64_t send_cnt;=0D
+	uint64_t ack_cnt;=0D
+};=0D
+=0D
+struct mbox_cnt_info {=0D
+	struct func_mbox_cnt_info func_info[HINIC_PF_MAX_SIZE + HINIC_VF_MAX_SIZE=
];=0D
+	uint32_t func_num;=0D
+};=0D
+=0D
+#endif /* _HINIC3_TELEMETRY_H_ */=0D
diff --git a/drivers/net/hinic3/meson.build b/drivers/net/hinic3/meson.buil=
d=0D
index 3ce5a68fb2..400c4f1a53 100644=0D
--- a/drivers/net/hinic3/meson.build=0D
+++ b/drivers/net/hinic3/meson.build=0D
@@ -23,6 +23,7 @@ sources =3D files(=0D
         'hinic3_flow.c',=0D
         'hinic3_rx.c',=0D
         'hinic3_tx.c',=0D
+        'hinic3_telemetry.c',=0D
 )=0D
 =0D
 includes +=3D include_directories('base')=0D
-- =0D
2.33.0=0D
=0D

