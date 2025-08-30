Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE71CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3FAF4064A;
	Sat, 30 Aug 2025 14:40:52 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 8481E402DC
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=/hmCGk+8sGR5PXNhwqzAbuMraBx48qlZC9kTTGDfMX8=;
 b=akjs1FBGgV7XZ/d0wOxCD4MHupV+EfheS+6jwiNDK9dWVxJiOkz6Pc6rbRn3kA
 t8l3Ez7tYKFzwRcEOr3DutTZQtDPGhbHD3SO9lrg23NQ4IJ+f/+6FjaZubm+CNIb
 YmuxpArR5Y9/KSvUch3cCtUjLU14BJFIpv2q8LCiT4TB8=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S6;
 Sat, 30 Aug 2025 20:40:48 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 02/18] net/hinic3: add basic header files
Date: Sat, 30 Aug 2025 20:39:14 +0800
Message-ID: <20250830123942.5037-3-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S6
X-Coremail-Antispam: 1Uf129KBjvAXoWfJw4DAryrZr43Ww18ZrW5Jrb_yoW8CFyrJo
 W5uF43tr4fXryjka1q9397tFW8Zrs5Zr15t3y5CayIvFsrKry8J3y3Jw47XrWfXw4DXry3
 Cry5JF4Du3yFyrn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2wIDUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiBAO5CmiyePi7KwAAs+
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

From: Xin Wang <wangxin679@h-partners.com>=0D

Add HW registers definition header file for SP series NIC.=0D
Add some headers that define commands and basic defines for=0D
use in the code.=0D
=0D
Signed-off-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_cmd.h    | 231 ++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_compat.h | 266 ++++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_csr.h    | 108 ++++++++++=0D
 3 files changed, 605 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_cmd.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_compat.h=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_csr.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_cmd.h b/drivers/net/hinic3/base=
/hinic3_cmd.h=0D
new file mode 100644=0D
index 0000000000..f0e200a944=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_cmd.h=0D
@@ -0,0 +1,231 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_CMD_H_=0D
+#define _HINIC3_CMD_H_=0D
+=0D
+#define NIC_RSS_TEMP_ID_TO_CTX_LT_IDX(tmp_id)	tmp_id=0D
+/* Begin of one temp tbl. */=0D
+#define NIC_RSS_TEMP_ID_TO_INDIR_LT_IDX(tmp_id)	((tmp_id) << 4)=0D
+/* 4 ctx in one entry. */=0D
+#define NIC_RSS_CTX_TBL_ENTRY_SIZE		0x10=0D
+/* Entry size =3D 16B, 16 entry/template. */=0D
+#define NIC_RSS_INDIR_TBL_ENTRY_SIZE		0x10=0D
+/* Entry size =3D 16B, so entry_num =3D 256B/16B. */=0D
+#define NIC_RSS_INDIR_TBL_ENTRY_NUM		0x10=0D
+=0D
+#define NIC_UP_RSS_INVALID_TEMP_ID		0xFF=0D
+#define NIC_UP_RSS_INVALID_FUNC_ID		0xFFFF=0D
+#define NIC_UP_RSS_INVALID			0x00=0D
+#define NIC_UP_RSS_EN				0x01=0D
+#define NIC_UP_RSS_INVALID_GROUP_ID		0x7F=0D
+=0D
+#define NIC_RSS_CMD_TEMP_ALLOC			0x01=0D
+#define NIC_RSS_CMD_TEMP_FREE			0x02=0D
+=0D
+#define HINIC3_RSS_TYPE_VALID_SHIFT		23=0D
+#define HINIC3_RSS_TYPE_TCP_IPV6_EXT_SHIFT	24=0D
+#define HINIC3_RSS_TYPE_IPV6_EXT_SHIFT		25=0D
+#define HINIC3_RSS_TYPE_TCP_IPV6_SHIFT		26=0D
+#define HINIC3_RSS_TYPE_IPV6_SHIFT		27=0D
+#define HINIC3_RSS_TYPE_TCP_IPV4_SHIFT		28=0D
+#define HINIC3_RSS_TYPE_IPV4_SHIFT		29=0D
+#define HINIC3_RSS_TYPE_UDP_IPV6_SHIFT		30=0D
+#define HINIC3_RSS_TYPE_UDP_IPV4_SHIFT		31=0D
+#define HINIC3_RSS_TYPE_SET(val, member)	\=0D
+	(((u32)(val) & 0x1) << HINIC3_RSS_TYPE_##member##_SHIFT)=0D
+=0D
+#define HINIC3_RSS_TYPE_GET(val, member)	\=0D
+	(((u32)(val) >> HINIC3_RSS_TYPE_##member##_SHIFT) & 0x1)=0D
+=0D
+/* NIC CMDQ MODE. */=0D
+typedef enum hinic3_ucode_cmd {=0D
+	HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX =3D 0,=0D
+	HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT,=0D
+	HINIC3_UCODE_CMD_ARM_SQ,=0D
+	HINIC3_UCODE_CMD_ARM_RQ,=0D
+	HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE,=0D
+	HINIC3_UCODE_CMD_SET_RSS_CONTEXT_TABLE,=0D
+	HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE,=0D
+	HINIC3_UCODE_CMD_GET_RSS_CONTEXT_TABLE,=0D
+	HINIC3_UCODE_CMD_SET_IQ_ENABLE,=0D
+	HINIC3_UCODE_CMD_SET_RQ_FLUSH =3D 10,=0D
+	HINIC3_UCODE_CMD_MODIFY_VLAN_CTX,=0D
+} cmdq_nic_subtype_e;=0D
+=0D
+/* Commands between NIC to MPU. */=0D
+enum hinic3_nic_cmd {=0D
+	/* Only for PFD and VFD. */=0D
+	HINIC3_NIC_CMD_VF_REGISTER =3D 0,=0D
+=0D
+	/* FUNC CFG */=0D
+	HINIC3_NIC_CMD_SET_FUNC_TBL =3D 5,=0D
+	HINIC3_NIC_CMD_SET_VPORT_ENABLE,=0D
+	HINIC3_NIC_CMD_SET_RX_MODE,=0D
+	HINIC3_NIC_CMD_SQ_CI_ATTR_SET,=0D
+	HINIC3_NIC_CMD_GET_VPORT_STAT,=0D
+	HINIC3_NIC_CMD_CLEAN_VPORT_STAT,=0D
+	HINIC3_NIC_CMD_CLEAR_QP_RESOURCE,=0D
+	HINIC3_NIC_CMD_CFG_FLEX_QUEUE,=0D
+	/* LRO CFG */=0D
+	HINIC3_NIC_CMD_CFG_RX_LRO,=0D
+	HINIC3_NIC_CMD_CFG_LRO_TIMER,=0D
+	HINIC3_NIC_CMD_FEATURE_NEGO,=0D
+=0D
+	/* MAC & VLAN CFG */=0D
+	HINIC3_NIC_CMD_GET_MAC =3D 20,=0D
+	HINIC3_NIC_CMD_SET_MAC,=0D
+	HINIC3_NIC_CMD_DEL_MAC,=0D
+	HINIC3_NIC_CMD_UPDATE_MAC,=0D
+	HINIC3_NIC_CMD_GET_ALL_DEFAULT_MAC,=0D
+=0D
+	HINIC3_NIC_CMD_CFG_FUNC_VLAN,=0D
+	HINIC3_NIC_CMD_SET_VLAN_FILTER_EN,=0D
+	HINIC3_NIC_CMD_SET_RX_VLAN_OFFLOAD,=0D
+=0D
+	/* SR-IOV */=0D
+	HINIC3_NIC_CMD_CFG_VF_VLAN =3D 40,=0D
+	HINIC3_NIC_CMD_SET_SPOOPCHK_STATE,=0D
+	/* RATE LIMIT */=0D
+	HINIC3_NIC_CMD_SET_MAX_MIN_RATE,=0D
+=0D
+	/* RSS CFG */=0D
+	HINIC3_NIC_CMD_RSS_CFG =3D 60,=0D
+	HINIC3_NIC_CMD_RSS_TEMP_MGR,=0D
+	HINIC3_NIC_CMD_GET_RSS_CTX_TBL,=0D
+	HINIC3_NIC_CMD_CFG_RSS_HASH_KEY,=0D
+	HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE,=0D
+	HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC,=0D
+=0D
+	/* FDIR */=0D
+	HINIC3_NIC_CMD_ADD_TC_FLOW =3D 80,=0D
+	HINIC3_NIC_CMD_DEL_TC_FLOW,=0D
+	HINIC3_NIC_CMD_GET_TC_FLOW,=0D
+	HINIC3_NIC_CMD_FLUSH_TCAM,=0D
+	HINIC3_NIC_CMD_CFG_TCAM_BLOCK,=0D
+	HINIC3_NIC_CMD_ENABLE_TCAM,=0D
+	HINIC3_NIC_CMD_GET_TCAM_BLOCK,=0D
+=0D
+	HINIC3_NIC_CMD_SET_FDIR_STATUS =3D 91,=0D
+=0D
+	/* PORT CFG */=0D
+	HINIC3_NIC_CMD_SET_PORT_ENABLE =3D 100,=0D
+	HINIC3_NIC_CMD_CFG_PAUSE_INFO,=0D
+=0D
+	HINIC3_NIC_CMD_SET_PORT_CAR,=0D
+	HINIC3_NIC_CMD_SET_ER_DROP_PKT,=0D
+=0D
+	HINIC3_NIC_CMD_VF_COS,=0D
+	HINIC3_NIC_CMD_SETUP_COS_MAPPING,=0D
+	HINIC3_NIC_CMD_SET_ETS,=0D
+	HINIC3_NIC_CMD_SET_PFC,=0D
+=0D
+	/* MISC */=0D
+	HINIC3_NIC_CMD_BIOS_CFG =3D 120,=0D
+	HINIC3_NIC_CMD_SET_FIRMWARE_CUSTOM_PACKETS_MSG,=0D
+=0D
+	/* DFX */=0D
+	HINIC3_NIC_CMD_GET_SM_TABLE =3D 140,=0D
+	HINIC3_NIC_CMD_RD_LINE_TBL,=0D
+=0D
+	HINIC3_NIC_CMD_SET_VHD_CFG =3D 161,=0D
+=0D
+	HINIC3_NIC_CMD_GET_PORT_STAT =3D 200,=0D
+	HINIC3_NIC_CMD_CLEAN_PORT_STAT,=0D
+=0D
+	HINIC3_NIC_CMD_MAX =3D 256=0D
+};=0D
+=0D
+/* COMM commands between driver to MPU. */=0D
+enum hinic3_mgmt_cmd {=0D
+	HINIC3_MGMT_CMD_FUNC_RESET =3D 0,=0D
+	HINIC3_MGMT_CMD_FEATURE_NEGO,=0D
+	HINIC3_MGMT_CMD_FLUSH_DOORBELL,=0D
+	HINIC3_MGMT_CMD_START_FLUSH,=0D
+	HINIC3_MGMT_CMD_SET_FUNC_FLR,=0D
+	HINIC3_MGMT_CMD_SET_FUNC_SVC_USED_STATE =3D 7,=0D
+=0D
+	HINIC3_MGMT_CMD_CFG_MSIX_NUM =3D 10,=0D
+=0D
+	HINIC3_MGMT_CMD_SET_CMDQ_CTXT =3D 20,=0D
+	HINIC3_MGMT_CMD_SET_VAT,=0D
+	HINIC3_MGMT_CMD_CFG_PAGESIZE,=0D
+	HINIC3_MGMT_CMD_CFG_MSIX_CTRL_REG,=0D
+	HINIC3_MGMT_CMD_SET_CEQ_CTRL_REG,=0D
+	HINIC3_MGMT_CMD_SET_DMA_ATTR,=0D
+=0D
+	HINIC3_MGMT_CMD_GET_MQM_FIX_INFO =3D 40,=0D
+	HINIC3_MGMT_CMD_SET_MQM_CFG_INFO,=0D
+	HINIC3_MGMT_CMD_SET_MQM_SRCH_GPA,=0D
+	HINIC3_MGMT_CMD_SET_PPF_TMR,=0D
+	HINIC3_MGMT_CMD_SET_PPF_HT_GPA,=0D
+	HINIC3_MGMT_CMD_SET_FUNC_TMR_BITMAT,=0D
+=0D
+	HINIC3_MGMT_CMD_GET_FW_VERSION =3D 60,=0D
+	HINIC3_MGMT_CMD_GET_BOARD_INFO,=0D
+	HINIC3_MGMT_CMD_SYNC_TIME,=0D
+	HINIC3_MGMT_CMD_GET_HW_PF_INFOS,=0D
+	HINIC3_MGMT_CMD_SEND_BDF_INFO,=0D
+=0D
+	HINIC3_MGMT_CMD_UPDATE_FW =3D 80,=0D
+	HINIC3_MGMT_CMD_ACTIVE_FW,=0D
+	HINIC3_MGMT_CMD_HOT_ACTIVE_FW,=0D
+	HINIC3_MGMT_CMD_HOT_ACTIVE_DONE_NOTICE,=0D
+	HINIC3_MGMT_CMD_SWITCH_CFG,=0D
+	HINIC3_MGMT_CMD_CHECK_FLASH,=0D
+	HINIC3_MGMT_CMD_CHECK_FLASH_RW,=0D
+	HINIC3_MGMT_CMD_RESOURCE_CFG,=0D
+	HINIC3_MGMT_CMD_UPDATE_BIOS,=0D
+=0D
+	HINIC3_MGMT_CMD_FAULT_REPORT =3D 100,=0D
+	HINIC3_MGMT_CMD_WATCHDOG_INFO,=0D
+	HINIC3_MGMT_CMD_MGMT_RESET,=0D
+	HINIC3_MGMT_CMD_FFM_SET,=0D
+=0D
+	HINIC3_MGMT_CMD_GET_LOG =3D 120,=0D
+	HINIC3_MGMT_CMD_TEMP_OP,=0D
+	HINIC3_MGMT_CMD_EN_AUTO_RST_CHIP,=0D
+	HINIC3_MGMT_CMD_CFG_REG,=0D
+	HINIC3_MGMT_CMD_GET_CHIP_ID,=0D
+	HINIC3_MGMT_CMD_SYSINFO_DFX,=0D
+	HINIC3_MGMT_CMD_PCIE_DFX_NTC,=0D
+};=0D
+=0D
+enum mag_cmd {=0D
+	SERDES_CMD_PROCESS =3D 0,=0D
+=0D
+	MAG_CMD_SET_PORT_CFG      =3D 1,=0D
+	MAG_CMD_SET_PORT_ADAPT    =3D 2,=0D
+	MAG_CMD_CFG_LOOPBACK_MODE =3D 3,=0D
+=0D
+	MAG_CMD_GET_PORT_ENABLE   =3D 5,=0D
+	MAG_CMD_SET_PORT_ENABLE   =3D 6,=0D
+	MAG_CMD_GET_LINK_STATUS   =3D 7,=0D
+	MAG_CMD_SET_LINK_FOLLOW   =3D 8,=0D
+	MAG_CMD_SET_PMA_ENABLE    =3D 9,=0D
+	MAG_CMD_CFG_FEC_MODE      =3D 10,=0D
+=0D
+	/* PHY */=0D
+	MAG_CMD_GET_XSFP_INFO        =3D 60,=0D
+	MAG_CMD_SET_XSFP_ENABLE      =3D 61,=0D
+	MAG_CMD_GET_XSFP_PRESENT     =3D 62,=0D
+	/* sfp/qsfp single byte read/write, for equipment test. */=0D
+	MAG_CMD_SET_XSFP_RW          =3D 63,=0D
+	MAG_CMD_CFG_XSFP_TEMPERATURE =3D 64,=0D
+=0D
+	MAG_CMD_WIRE_EVENT        =3D 100,=0D
+	MAG_CMD_LINK_ERR_EVENT    =3D 101,=0D
+=0D
+	MAG_CMD_EVENT_PORT_INFO   =3D 150,=0D
+	MAG_CMD_GET_PORT_STAT     =3D 151,=0D
+	MAG_CMD_CLR_PORT_STAT     =3D 152,=0D
+	MAG_CMD_GET_PORT_INFO     =3D 153,=0D
+	MAG_CMD_GET_PCS_ERR_CNT   =3D 154,=0D
+	MAG_CMD_GET_MAG_CNT       =3D 155,=0D
+	MAG_CMD_DUMP_ANTRAIN_INFO =3D 156,=0D
+=0D
+	MAG_CMD_MAX =3D 0xFF=0D
+};=0D
+=0D
+#endif /* _HINIC3_CMD_H_ */=0D
diff --git a/drivers/net/hinic3/base/hinic3_compat.h b/drivers/net/hinic3/b=
ase/hinic3_compat.h=0D
new file mode 100644=0D
index 0000000000..76ce5b83c6=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_compat.h=0D
@@ -0,0 +1,266 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_COMPAT_H_=0D
+#define _HINIC3_COMPAT_H_=0D
+=0D
+#include <stdint.h>=0D
+#include <stdbool.h>=0D
+#include <sys/time.h>=0D
+#include <unistd.h>=0D
+#include <sys/syscall.h>=0D
+#include <pthread.h>=0D
+#include <ethdev_pci.h>=0D
+#include <eal_interrupts.h>=0D
+#include <rte_io.h>=0D
+#include <rte_atomic.h>=0D
+#include <rte_byteorder.h>=0D
+#include <rte_common.h>=0D
+#include <rte_config.h>=0D
+#include <rte_cycles.h>=0D
+#include <rte_log.h>=0D
+#include <rte_malloc.h>=0D
+#include <rte_memcpy.h>=0D
+#include <rte_memzone.h>=0D
+#include <rte_spinlock.h>=0D
+=0D
+typedef uint8_t  u8;=0D
+typedef int8_t   s8;=0D
+typedef uint16_t u16;=0D
+typedef uint32_t u32;=0D
+typedef int32_t  s32;=0D
+typedef uint64_t u64;=0D
+=0D
+#ifndef BIT=0D
+#define BIT(n) (1U << (n))=0D
+#endif=0D
+=0D
+#define upper_32_bits(n) ((u32)(((n) >> 16) >> 16))=0D
+#define lower_32_bits(n) ((u32)(n))=0D
+=0D
+#define HINIC3_MEM_ALLOC_ALIGN_MIN 1=0D
+=0D
+extern int hinic3_logtype;=0D
+#define RTE_LOGTYPE_NET_HINIC3 hinic3_logtype=0D
+=0D
+#define PMD_DRV_LOG(level, ...) RTE_LOG_LINE(level, NET_HINIC3, __VA_ARGS_=
_)=0D
+=0D
+/* Bit order interface. */=0D
+#define cpu_to_be16(o) rte_cpu_to_be_16(o)=0D
+#define cpu_to_be32(o) rte_cpu_to_be_32(o)=0D
+#define cpu_to_be64(o) rte_cpu_to_be_64(o)=0D
+#define cpu_to_le32(o) rte_cpu_to_le_32(o)=0D
+#define be16_to_cpu(o) rte_be_to_cpu_16(o)=0D
+#define be32_to_cpu(o) rte_be_to_cpu_32(o)=0D
+#define be64_to_cpu(o) rte_be_to_cpu_64(o)=0D
+#define le32_to_cpu(o) rte_le_to_cpu_32(o)=0D
+=0D
+#ifdef HW_CONVERT_ENDIAN=0D
+/* If csrs to enable endianness converting are configured, hw will do the=
=0D
+ * endianness converting for stateless SQ ci, the fields less than 4B for=
=0D
+ * doorbell, the fields less than 4B in the CQE data.=0D
+ */=0D
+#define hinic3_hw_be32(val)  (val)=0D
+#define hinic3_hw_cpu32(val) (val)=0D
+#define hinic3_hw_cpu16(val) (val)=0D
+#else=0D
+#define hinic3_hw_be32(val)  cpu_to_be32(val)=0D
+#define hinic3_hw_cpu32(val) be32_to_cpu(val)=0D
+#define hinic3_hw_cpu16(val) be16_to_cpu(val)=0D
+#endif=0D
+=0D
+#define ARRAY_LEN(arr) ((int)(sizeof(arr) / sizeof((arr)[0])))=0D
+=0D
+static inline void=0D
+hinic3_hw_be32_len(void *data, int len)=0D
+{=0D
+	int i, chunk_sz =3D sizeof(u32);=0D
+	u32 *mem =3D data;=0D
+=0D
+	if (!data)=0D
+		return;=0D
+=0D
+	len =3D len / chunk_sz;=0D
+=0D
+	for (i =3D 0; i < len; i++) {=0D
+		*mem =3D hinic3_hw_be32(*mem);=0D
+		mem++;=0D
+	}=0D
+}=0D
+=0D
+static inline int=0D
+hinic3_get_bit(int nr, volatile RTE_ATOMIC(u64) *addr)=0D
+{=0D
+	RTE_ASSERT(nr < 0x20);=0D
+=0D
+	uint32_t mask =3D UINT32_C(1) << nr;=0D
+	return (*addr) & mask;=0D
+}=0D
+=0D
+static inline void=0D
+hinic3_set_bit(unsigned int nr, volatile RTE_ATOMIC(u64) *addr)=0D
+{=0D
+	rte_atomic_fetch_or_explicit(addr, (1UL << nr),=0D
+				     rte_memory_order_seq_cst);=0D
+}=0D
+=0D
+static inline void=0D
+hinic3_clear_bit(int nr, volatile RTE_ATOMIC(u64) *addr)=0D
+{=0D
+	rte_atomic_fetch_and_explicit(addr, ~(1UL << nr),=0D
+				      rte_memory_order_seq_cst);=0D
+}=0D
+=0D
+static inline int=0D
+hinic3_test_and_clear_bit(int nr, volatile RTE_ATOMIC(u64) *addr)=0D
+{=0D
+	unsigned long mask =3D (1UL << nr);=0D
+=0D
+	return (int)(rte_atomic_fetch_and_explicit(addr, ~mask,=0D
+						   rte_memory_order_seq_cst) &=0D
+		     mask);=0D
+}=0D
+=0D
+static inline int=0D
+hinic3_test_and_set_bit(int nr, volatile RTE_ATOMIC(u64) *addr)=0D
+{=0D
+	unsigned long mask =3D (1UL << nr);=0D
+=0D
+	return (int)(rte_atomic_fetch_or_explicit(addr, mask,=0D
+						  rte_memory_order_seq_cst) &=0D
+		     mask);=0D
+}=0D
+=0D
+#ifdef CLOCK_MONOTONIC_RAW /**< Defined in glibc bits/time.h . */=0D
+#define CLOCK_TYPE CLOCK_MONOTONIC_RAW=0D
+#else=0D
+#define CLOCK_TYPE CLOCK_MONOTONIC=0D
+#endif=0D
+=0D
+#define HINIC3_MUTEX_TIMEOUT 10=0D
+#define HINIC3_S_TO_MS_UNIT  1000=0D
+#define HINIC3_S_TO_NS_UNIT  1000000=0D
+=0D
+static inline unsigned long=0D
+clock_gettime_ms(void)=0D
+{=0D
+	struct timespec tv;=0D
+=0D
+	clock_gettime(CLOCK_TYPE, &tv);=0D
+=0D
+	return (unsigned long)tv.tv_sec * HINIC3_S_TO_MS_UNIT +=0D
+	       (unsigned long)tv.tv_nsec / HINIC3_S_TO_NS_UNIT;=0D
+}=0D
+=0D
+#define jiffies		      clock_gettime_ms()=0D
+#define msecs_to_jiffies(ms)  (ms)=0D
+#define time_before(now, end) ((now) < (end))=0D
+=0D
+/**=0D
+ * Convert data to big endian 32 bit format.=0D
+ *=0D
+ * @param data=0D
+ * The data to convert.=0D
+ * @param len=0D
+ * Length of data to convert, must be Multiple of 4B.=0D
+ */=0D
+static inline void=0D
+hinic3_cpu_to_be32(void *data, int len)=0D
+{=0D
+	int i, chunk_sz =3D sizeof(u32);=0D
+	u32 *mem =3D data;=0D
+=0D
+	if (!data)=0D
+		return;=0D
+=0D
+	len =3D len / chunk_sz;=0D
+=0D
+	for (i =3D 0; i < len; i++) {=0D
+		*mem =3D cpu_to_be32(*mem);=0D
+		mem++;=0D
+	}=0D
+}=0D
+=0D
+/**=0D
+ * Convert data from big endian 32 bit format.=0D
+ *=0D
+ * @param data=0D
+ * The data to convert.=0D
+ * @param len=0D
+ * Length of data to convert, must be Multiple of 4B.=0D
+ */=0D
+static inline void=0D
+hinic3_be32_to_cpu(void *data, int len)=0D
+{=0D
+	int i, chunk_sz =3D sizeof(u32);=0D
+	u32 *mem =3D data;=0D
+=0D
+	if (!data)=0D
+		return;=0D
+=0D
+	len =3D len / chunk_sz;=0D
+=0D
+	for (i =3D 0; i < len; i++) {=0D
+		*mem =3D be32_to_cpu(*mem);=0D
+		mem++;=0D
+	}=0D
+}=0D
+=0D
+static inline u16=0D
+ilog2(u32 n)=0D
+{=0D
+	u16 res =3D 0;=0D
+=0D
+	while (n > 1) {=0D
+		n >>=3D 1;=0D
+		res++;=0D
+	}=0D
+=0D
+	return res;=0D
+}=0D
+=0D
+static inline int=0D
+hinic3_mutex_init(pthread_mutex_t *pthreadmutex,=0D
+		  const pthread_mutexattr_t *mattr)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D pthread_mutex_init(pthreadmutex, mattr);=0D
+	if (unlikely(err))=0D
+		PMD_DRV_LOG(ERR, "Initialize mutex failed, error: %d", err);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static inline int=0D
+hinic3_mutex_destroy(pthread_mutex_t *pthreadmutex)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D pthread_mutex_destroy(pthreadmutex);=0D
+	if (unlikely(err))=0D
+		PMD_DRV_LOG(ERR, "Destroy mutex failed, error: %d", err);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static inline int=0D
+hinic3_mutex_lock(pthread_mutex_t *pthreadmutex)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D pthread_mutex_lock(pthreadmutex);=0D
+	if (err)=0D
+		PMD_DRV_LOG(ERR, "Mutex lock failed, err: %d", err);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static inline void=0D
+hinic3_mutex_unlock(pthread_mutex_t *pthreadmutex)=0D
+{=0D
+	pthread_mutex_unlock(pthreadmutex);=0D
+}=0D
+=0D
+#endif /* _HINIC3_COMPAT_H_ */=0D
diff --git a/drivers/net/hinic3/base/hinic3_csr.h b/drivers/net/hinic3/base=
/hinic3_csr.h=0D
new file mode 100644=0D
index 0000000000..f0dd690bf8=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_csr.h=0D
@@ -0,0 +1,108 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_CSR_H_=0D
+#define _HINIC3_CSR_H_=0D
+=0D
+#ifdef CONFIG_SP_VID_DID=0D
+#define PCI_VENDOR_ID_SPNIC    0x1F3F=0D
+#define HINIC3_DEV_ID_STANDARD 0x9020=0D
+#define HINIC3_DEV_ID_VF       0x9001=0D
+#else=0D
+#define PCI_VENDOR_ID_HUAWEI   0x19e5=0D
+#define HINIC3_DEV_ID_STANDARD 0x0222=0D
+#define HINIC3_DEV_ID_VF       0x375F=0D
+#endif=0D
+=0D
+/*=0D
+ * Bit30/bit31 for bar index flag.=0D
+ * 00: bar0=0D
+ * 01: bar1=0D
+ * 10: bar2=0D
+ * 11: bar3=0D
+ */=0D
+#define HINIC3_CFG_REGS_FLAG 0x40000000=0D
+=0D
+#define HINIC3_MGMT_REGS_FLAG 0xC0000000=0D
+=0D
+#define HINIC3_REGS_FLAG_MASK 0x3FFFFFFF=0D
+=0D
+#define HINIC3_VF_CFG_REG_OFFSET 0x2000=0D
+=0D
+#define HINIC3_HOST_CSR_BASE_ADDR   (HINIC3_MGMT_REGS_FLAG + 0x6000)=0D
+#define HINIC3_CSR_GLOBAL_BASE_ADDR (HINIC3_MGMT_REGS_FLAG + 0x6400)=0D
+=0D
+/* HW interface registers. */=0D
+#define HINIC3_CSR_FUNC_ATTR0_ADDR (HINIC3_CFG_REGS_FLAG + 0x0)=0D
+#define HINIC3_CSR_FUNC_ATTR1_ADDR (HINIC3_CFG_REGS_FLAG + 0x4)=0D
+#define HINIC3_CSR_FUNC_ATTR2_ADDR (HINIC3_CFG_REGS_FLAG + 0x8)=0D
+#define HINIC3_CSR_FUNC_ATTR3_ADDR (HINIC3_CFG_REGS_FLAG + 0xC)=0D
+#define HINIC3_CSR_FUNC_ATTR4_ADDR (HINIC3_CFG_REGS_FLAG + 0x10)=0D
+#define HINIC3_CSR_FUNC_ATTR5_ADDR (HINIC3_CFG_REGS_FLAG + 0x14)=0D
+#define HINIC3_CSR_FUNC_ATTR6_ADDR (HINIC3_CFG_REGS_FLAG + 0x18)=0D
+=0D
+#define HINIC3_FUNC_CSR_MAILBOX_DATA_OFF       0x80=0D
+#define HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF    (HINIC3_CFG_REGS_FLAG + 0x0=
100)=0D
+#define HINIC3_FUNC_CSR_MAILBOX_INT_OFFSET_OFF (HINIC3_CFG_REGS_FLAG + 0x0=
104)=0D
+#define HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF   (HINIC3_CFG_REGS_FLAG + 0x0=
108)=0D
+#define HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF   (HINIC3_CFG_REGS_FLAG + 0x0=
10C)=0D
+=0D
+#define HINIC3_PPF_ELECTION_OFFSET 0x0=0D
+#define HINIC3_MPF_ELECTION_OFFSET 0x20=0D
+=0D
+#define HINIC3_CSR_PPF_ELECTION_ADDR \=0D
+	(HINIC3_HOST_CSR_BASE_ADDR + HINIC3_PPF_ELECTION_OFFSET)=0D
+=0D
+#define HINIC3_CSR_GLOBAL_MPF_ELECTION_ADDR \=0D
+	(HINIC3_HOST_CSR_BASE_ADDR + HINIC3_MPF_ELECTION_OFFSET)=0D
+=0D
+#define HINIC3_CSR_DMA_ATTR_TBL_ADDR	   (HINIC3_CFG_REGS_FLAG + 0x380)=0D
+#define HINIC3_CSR_DMA_ATTR_INDIR_IDX_ADDR (HINIC3_CFG_REGS_FLAG + 0x390)=
=0D
+=0D
+/* MSI-X registers. */=0D
+#define HINIC3_CSR_MSIX_INDIR_IDX_ADDR	(HINIC3_CFG_REGS_FLAG + 0x310)=0D
+#define HINIC3_CSR_MSIX_CTRL_ADDR	(HINIC3_CFG_REGS_FLAG + 0x300)=0D
+#define HINIC3_CSR_MSIX_CNT_ADDR	(HINIC3_CFG_REGS_FLAG + 0x304)=0D
+#define HINIC3_CSR_FUNC_MSI_CLR_WR_ADDR (HINIC3_CFG_REGS_FLAG + 0x58)=0D
+=0D
+#define HINIC3_MSI_CLR_INDIR_RESEND_TIMER_CLR_SHIFT 0=0D
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_SET_SHIFT	    1=0D
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_CLR_SHIFT	    2=0D
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_SET_SHIFT	    3=0D
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_CLR_SHIFT	    4=0D
+#define HINIC3_MSI_CLR_INDIR_SIMPLE_INDIR_IDX_SHIFT 22=0D
+=0D
+#define HINIC3_MSI_CLR_INDIR_RESEND_TIMER_CLR_MASK 0x1U=0D
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_SET_MASK	   0x1U=0D
+#define HINIC3_MSI_CLR_INDIR_INT_MSK_CLR_MASK	   0x1U=0D
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_SET_MASK	   0x1U=0D
+#define HINIC3_MSI_CLR_INDIR_AUTO_MSK_CLR_MASK	   0x1U=0D
+#define HINIC3_MSI_CLR_INDIR_SIMPLE_INDIR_IDX_MASK 0x3FFU=0D
+=0D
+#define HINIC3_MSI_CLR_INDIR_SET(val, member)           \=0D
+	(((val) & HINIC3_MSI_CLR_INDIR_##member##_MASK) \=0D
+	 << HINIC3_MSI_CLR_INDIR_##member##_SHIFT)=0D
+=0D
+/* EQ registers. */=0D
+#define HINIC3_AEQ_INDIR_IDX_ADDR (HINIC3_CFG_REGS_FLAG + 0x210)=0D
+=0D
+#define HINIC3_AEQ_MTT_OFF_BASE_ADDR (HINIC3_CFG_REGS_FLAG + 0x240)=0D
+=0D
+#define HINIC3_CSR_EQ_PAGE_OFF_STRIDE 8=0D
+=0D
+#define HINIC3_AEQ_HI_PHYS_ADDR_REG(pg_num) \=0D
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR +     \=0D
+	 (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE)=0D
+=0D
+#define HINIC3_AEQ_LO_PHYS_ADDR_REG(pg_num) \=0D
+	(HINIC3_AEQ_MTT_OFF_BASE_ADDR +     \=0D
+	 (pg_num) * HINIC3_CSR_EQ_PAGE_OFF_STRIDE + 4)=0D
+=0D
+#define HINIC3_CSR_AEQ_CTRL_0_ADDR	    (HINIC3_CFG_REGS_FLAG + 0x200)=0D
+#define HINIC3_CSR_AEQ_CTRL_1_ADDR	    (HINIC3_CFG_REGS_FLAG + 0x204)=0D
+#define HINIC3_CSR_AEQ_CONS_IDX_ADDR	    (HINIC3_CFG_REGS_FLAG + 0x208)=0D
+#define HINIC3_CSR_AEQ_PROD_IDX_ADDR	    (HINIC3_CFG_REGS_FLAG + 0x20C)=0D
+#define HINIC3_CSR_AEQ_CI_SIMPLE_INDIR_ADDR (HINIC3_CFG_REGS_FLAG + 0x50)=
=0D
+=0D
+#endif /* _HINIC3_CSR_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

