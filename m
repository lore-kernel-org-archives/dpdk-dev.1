Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8B1CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:42:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 738F540B91;
	Sat, 30 Aug 2025 14:41:08 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 0D891406BC
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=RSJX5pG6UHL3HltOJSRJiulJqQY70QbbEiTHcKcwYZo=;
 b=m6aG9WCS9hFhcX80x6BE7Z2qRM7HJG7KVBl+V/kun32LowH/JCXsbJQbgu4J1m
 kfTeLtMrrY0uKacVhK2wC6ldF3Yvx0LHNmg5wNKL750OJWMfH5ewr0nwHhR7ZX3k
 BIRZtKzLc5eLnAKKybTLw8jD+rajIkKtXhIFnuq/+m21U=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S17;
 Sat, 30 Aug 2025 20:41:01 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Xin Wang <wangxin679@h-partners.com>, Yi Chen <chenyi221@huawei.com>
Subject: [V5 13/18] net/hinic3: add dev ops
Date: Sat, 30 Aug 2025 20:39:25 +0800
Message-ID: <20250830123942.5037-14-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S17
X-Coremail-Antispam: 1Uf129KBjvtXoWkKFyfWw4rXr4fXw15ZF4fXwb_yoW8WF43Kr
 c_ury0vw1qgw1UCan8t3yvkF1ftryIgF92qrnYqa1IkryxAr15Xws3ZF4DWr9rW390ga42
 9F1a9wsF9w1kXrn5WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-
 sFnT9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbAnY7UUUUU==
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHgC5Cmiy3cEimAAAsR
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

From: Feifei Wang <wangfeifei40@huawei.com>=0D

Add ops related function codes.=0D
=0D
Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>=0D
Signed-off-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Yi Chen <chenyi221@huawei.com>=0D
---=0D
 drivers/net/hinic3/hinic3_ethdev.c | 2918 +++++++++++++++++++++++++++-=0D
 drivers/net/hinic3/hinic3_nic_io.c |  828 ++++++++=0D
 drivers/net/hinic3/hinic3_nic_io.h |  169 ++=0D
 drivers/net/hinic3/hinic3_rx.c     |  814 ++++++++=0D
 drivers/net/hinic3/hinic3_rx.h     |  356 ++++=0D
 drivers/net/hinic3/hinic3_tx.c     |  274 +++=0D
 drivers/net/hinic3/hinic3_tx.h     |  314 +++=0D
 7 files changed, 5656 insertions(+), 17 deletions(-)=0D
 create mode 100644 drivers/net/hinic3/hinic3_nic_io.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_nic_io.h=0D
 create mode 100644 drivers/net/hinic3/hinic3_rx.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_rx.h=0D
 create mode 100644 drivers/net/hinic3/hinic3_tx.c=0D
 create mode 100644 drivers/net/hinic3/hinic3_tx.h=0D
=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index e6666a4d87..d9bca3aeb3 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -21,42 +21,2917 @@=0D
 #include "base/hinic3_hw_comm.h"=0D
 #include "base/hinic3_nic_cfg.h"=0D
 #include "base/hinic3_nic_event.h"=0D
+#include "hinic3_pmd_nic_io.h"=0D
+#include "hinic3_pmd_tx.h"=0D
+#include "hinic3_pmd_rx.h"=0D
 #include "hinic3_ethdev.h"=0D
 =0D
+#define HINIC3_MIN_RX_BUF_SIZE 1024=0D
+=0D
+#define HINIC3_DEFAULT_BURST_SIZE 32=0D
+#define HINIC3_DEFAULT_NB_QUEUES  1=0D
+#define HINIC3_DEFAULT_RING_SIZE  1024=0D
+#define HINIC3_MAX_LRO_SIZE	  65536=0D
+=0D
+#define HINIC3_DEFAULT_RX_FREE_THRESH 32=0D
+#define HINIC3_DEFAULT_TX_FREE_THRESH 32=0D
+=0D
+#define HINIC3_RX_WAIT_CYCLE_THRESH 500=0D
+=0D
+/**=0D
+ * Get the 32-bit VFTA bit mask for the lower 5 bits of the VLAN ID.=0D
+ *=0D
+ * Vlan_id is a 12 bit number. The VFTA array is actually a 4096 bit array=
,=0D
+ * 128 of 32bit elements. 2^5 =3D 32. The val of lower 5 bits specifies th=
e bit=0D
+ * in the 32bit element. The higher 7 bit val specifies VFTA array index.=
=0D
+ */=0D
+#define HINIC3_VFTA_BIT(vlan_id) (1 << ((vlan_id) & 0x1F))=0D
+/**=0D
+ * Get the VFTA index from the upper 7 bits of the VLAN ID.=0D
+ */=0D
+#define HINIC3_VFTA_IDX(vlan_id) ((vlan_id) >> 5)=0D
+=0D
+#define HINIC3_LRO_DEFAULT_TIME_LIMIT 16=0D
+#define HINIC3_LRO_UNIT_WQE_SIZE      1024 /**< Bytes. */=0D
+=0D
+#define HINIC3_MAX_RX_PKT_LEN(rxmod) ((rxmod).mtu)=0D
+int hinic3_logtype; /**< Driver-specific log messages type. */=0D
+=0D
+/**=0D
+ * The different receive modes for the NIC.=0D
+ *=0D
+ * The receive modes are represented as bit flags that control how the=0D
+ * NIC handles various types of network traffic.=0D
+ */=0D
+enum hinic3_rx_mod {=0D
+	/* Enable unicast receive mode. */=0D
+	HINIC3_RX_MODE_UC =3D 1 << 0,=0D
+	/* Enable multicast receive mode. */=0D
+	HINIC3_RX_MODE_MC =3D 1 << 1,=0D
+	/* Enable broadcast receive mode. */=0D
+	HINIC3_RX_MODE_BC =3D 1 << 2,=0D
+	/* Enable receive mode for all multicast addresses. */=0D
+	HINIC3_RX_MODE_MC_ALL =3D 1 << 3,=0D
+	/* Enable promiscuous mode, receiving all packets. */=0D
+	HINIC3_RX_MODE_PROMISC =3D 1 << 4,=0D
+};=0D
+=0D
+#define HINIC3_DEFAULT_RX_MODE \=0D
+	(HINIC3_RX_MODE_UC | HINIC3_RX_MODE_MC | HINIC3_RX_MODE_BC)=0D
+=0D
+struct hinic3_xstats_name_off {=0D
+	char name[RTE_ETH_XSTATS_NAME_SIZE];=0D
+	u32 offset;=0D
+};=0D
+=0D
+#define HINIC3_FUNC_STAT(_stat_item)                                      =
 \=0D
+	{                                                                  \=0D
+		.name =3D #_stat_item,                                       \=0D
+		.offset =3D offsetof(struct hinic3_vport_stats, _stat_item), \=0D
+	}=0D
+=0D
+static const struct hinic3_xstats_name_off hinic3_vport_stats_strings[] =
=3D {=0D
+	HINIC3_FUNC_STAT(tx_unicast_pkts_vport),=0D
+	HINIC3_FUNC_STAT(tx_unicast_bytes_vport),=0D
+	HINIC3_FUNC_STAT(tx_multicast_pkts_vport),=0D
+	HINIC3_FUNC_STAT(tx_multicast_bytes_vport),=0D
+	HINIC3_FUNC_STAT(tx_broadcast_pkts_vport),=0D
+	HINIC3_FUNC_STAT(tx_broadcast_bytes_vport),=0D
+=0D
+	HINIC3_FUNC_STAT(rx_unicast_pkts_vport),=0D
+	HINIC3_FUNC_STAT(rx_unicast_bytes_vport),=0D
+	HINIC3_FUNC_STAT(rx_multicast_pkts_vport),=0D
+	HINIC3_FUNC_STAT(rx_multicast_bytes_vport),=0D
+	HINIC3_FUNC_STAT(rx_broadcast_pkts_vport),=0D
+	HINIC3_FUNC_STAT(rx_broadcast_bytes_vport),=0D
+=0D
+	HINIC3_FUNC_STAT(tx_discard_vport),=0D
+	HINIC3_FUNC_STAT(rx_discard_vport),=0D
+	HINIC3_FUNC_STAT(tx_err_vport),=0D
+	HINIC3_FUNC_STAT(rx_err_vport),=0D
+};=0D
+=0D
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))=0D
+=0D
+#define HINIC3_VPORT_XSTATS_NUM ARRAY_SIZE(hinic3_vport_stats_strings)=0D
+=0D
+#define HINIC3_PORT_STAT(_stat_item)                                      =
 \=0D
+	{                                                                  \=0D
+		.name =3D #_stat_item,                                       \=0D
+		.offset =3D offsetof(struct mag_phy_port_stats, _stat_item), \=0D
+	}=0D
+=0D
+static const struct hinic3_xstats_name_off hinic3_phyport_stats_strings[] =
=3D {=0D
+	HINIC3_PORT_STAT(mac_tx_fragment_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_undersize_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_undermin_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_64_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_65_127_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_128_255_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_256_511_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_512_1023_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_1024_1518_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_1519_2047_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_2048_4095_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_4096_8191_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_8192_9216_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_9217_12287_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_12288_16383_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_1519_max_bad_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_1519_max_good_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_oversize_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_jabber_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_bad_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_bad_oct_num),=0D
+	HINIC3_PORT_STAT(mac_tx_good_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_good_oct_num),=0D
+	HINIC3_PORT_STAT(mac_tx_total_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_total_oct_num),=0D
+	HINIC3_PORT_STAT(mac_tx_uni_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_multi_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_broad_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_pause_num),=0D
+	HINIC3_PORT_STAT(mac_tx_pfc_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_pfc_pri0_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_pfc_pri1_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_pfc_pri2_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_pfc_pri3_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_pfc_pri4_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_pfc_pri5_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_pfc_pri6_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_pfc_pri7_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_control_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_err_all_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_from_app_good_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_tx_from_app_bad_pkt_num),=0D
+=0D
+	HINIC3_PORT_STAT(mac_rx_fragment_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_undersize_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_undermin_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_64_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_65_127_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_128_255_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_256_511_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_512_1023_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_1024_1518_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_1519_2047_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_2048_4095_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_4096_8191_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_8192_9216_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_9217_12287_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_12288_16383_oct_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_1519_max_bad_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_1519_max_good_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_oversize_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_jabber_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_bad_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_bad_oct_num),=0D
+	HINIC3_PORT_STAT(mac_rx_good_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_good_oct_num),=0D
+	HINIC3_PORT_STAT(mac_rx_total_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_total_oct_num),=0D
+	HINIC3_PORT_STAT(mac_rx_uni_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_multi_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_broad_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_pause_num),=0D
+	HINIC3_PORT_STAT(mac_rx_pfc_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_pfc_pri0_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_pfc_pri1_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_pfc_pri2_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_pfc_pri3_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_pfc_pri4_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_pfc_pri5_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_pfc_pri6_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_pfc_pri7_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_control_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_sym_err_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_fcs_err_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_send_app_good_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_send_app_bad_pkt_num),=0D
+	HINIC3_PORT_STAT(mac_rx_unfilter_pkt_num),=0D
+};=0D
+=0D
+#define HINIC3_PHYPORT_XSTATS_NUM ARRAY_SIZE(hinic3_phyport_stats_strings)=
=0D
+=0D
+#define HINIC3_RXQ_STAT(_stat_item)                                      \=
=0D
+	{                                                                \=0D
+		.name =3D #_stat_item,                                     \=0D
+		.offset =3D offsetof(struct hinic3_rxq_stats, _stat_item), \=0D
+	}=0D
+=0D
+/**=0D
+ * The name and offset field of RXQ statistic items.=0D
+ *=0D
+ * The inclusion of additional statistics depends on the compilation flags=
:=0D
+ * - `HINIC3_XSTAT_RXBUF_INFO` enables buffer-related stats.=0D
+ * - `HINIC3_XSTAT_PROF_RX` enables performance timing stats.=0D
+ * - `HINIC3_XSTAT_MBUF_USE` enables memory buffer usage stats.=0D
+ */=0D
+static const struct hinic3_xstats_name_off hinic3_rxq_stats_strings[] =3D =
{=0D
+	HINIC3_RXQ_STAT(rx_nombuf),=0D
+	HINIC3_RXQ_STAT(burst_pkts),=0D
+	HINIC3_RXQ_STAT(errors),=0D
+	HINIC3_RXQ_STAT(csum_errors),=0D
+	HINIC3_RXQ_STAT(other_errors),=0D
+	HINIC3_RXQ_STAT(empty),=0D
+=0D
+#ifdef HINIC3_XSTAT_RXBUF_INFO=0D
+	HINIC3_RXQ_STAT(rx_mbuf),=0D
+	HINIC3_RXQ_STAT(rx_avail),=0D
+	HINIC3_RXQ_STAT(rx_hole),=0D
+#endif=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_RX=0D
+	HINIC3_RXQ_STAT(app_tsc),=0D
+	HINIC3_RXQ_STAT(pmd_tsc),=0D
+#endif=0D
+=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+	HINIC3_RXQ_STAT(rx_alloc_mbuf_bytes),=0D
+	HINIC3_RXQ_STAT(rx_free_mbuf_bytes),=0D
+	HINIC3_RXQ_STAT(rx_left_mbuf_bytes),=0D
+#endif=0D
+};=0D
+=0D
+#define HINIC3_RXQ_XSTATS_NUM ARRAY_SIZE(hinic3_rxq_stats_strings)=0D
+=0D
+#define HINIC3_TXQ_STAT(_stat_item)                                      \=
=0D
+	{                                                                \=0D
+		.name =3D #_stat_item,                                     \=0D
+		.offset =3D offsetof(struct hinic3_txq_stats, _stat_item), \=0D
+	}=0D
+=0D
+/**=0D
+ * The name and offset field of TXQ statistic items.=0D
+ *=0D
+ * The inclusion of additional statistics depends on the compilation flags=
:=0D
+ * - `HINIC3_XSTAT_PROF_TX` enables performance timing stats.=0D
+ * - `HINIC3_XSTAT_MBUF_USE` enables memory buffer usage stats.=0D
+ */=0D
+static const struct hinic3_xstats_name_off hinic3_txq_stats_strings[] =3D =
{=0D
+	HINIC3_TXQ_STAT(tx_busy),=0D
+	HINIC3_TXQ_STAT(offload_errors),=0D
+	HINIC3_TXQ_STAT(burst_pkts),=0D
+	HINIC3_TXQ_STAT(sge_len0),=0D
+	HINIC3_TXQ_STAT(mbuf_null),=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_TX=0D
+	HINIC3_TXQ_STAT(app_tsc),=0D
+	HINIC3_TXQ_STAT(pmd_tsc),=0D
+#endif=0D
+=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+	HINIC3_TXQ_STAT(tx_left_mbuf_bytes),=0D
+#endif=0D
+};=0D
+=0D
+#define HINIC3_TXQ_XSTATS_NUM ARRAY_SIZE(hinic3_txq_stats_strings)=0D
+=0D
+static int=0D
+hinic3_xstats_calc_num(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	if (HINIC3_IS_VF(nic_dev->hwdev)) {=0D
+		return (HINIC3_VPORT_XSTATS_NUM +=0D
+			HINIC3_RXQ_XSTATS_NUM * nic_dev->num_rqs +=0D
+			HINIC3_TXQ_XSTATS_NUM * nic_dev->num_sqs);=0D
+	} else {=0D
+		return (HINIC3_VPORT_XSTATS_NUM + HINIC3_PHYPORT_XSTATS_NUM +=0D
+			HINIC3_RXQ_XSTATS_NUM * nic_dev->num_rqs +=0D
+			HINIC3_TXQ_XSTATS_NUM * nic_dev->num_sqs);=0D
+	}=0D
+}=0D
+=0D
+#define HINIC3_MAX_QUEUE_DEPTH 16384=0D
+#define HINIC3_MIN_QUEUE_DEPTH 128=0D
+#define HINIC3_TXD_ALIGN       1=0D
+#define HINIC3_RXD_ALIGN       1=0D
+=0D
+static const struct rte_eth_desc_lim hinic3_rx_desc_lim =3D {=0D
+	.nb_max =3D HINIC3_MAX_QUEUE_DEPTH,=0D
+	.nb_min =3D HINIC3_MIN_QUEUE_DEPTH,=0D
+	.nb_align =3D HINIC3_RXD_ALIGN,=0D
+};=0D
+=0D
+static const struct rte_eth_desc_lim hinic3_tx_desc_lim =3D {=0D
+	.nb_max =3D HINIC3_MAX_QUEUE_DEPTH,=0D
+	.nb_min =3D HINIC3_MIN_QUEUE_DEPTH,=0D
+	.nb_align =3D HINIC3_TXD_ALIGN,=0D
+};=0D
+=0D
+static void hinic3_deinit_mac_addr(struct rte_eth_dev *eth_dev);=0D
+=0D
+static int hinic3_copy_mempool_init(struct hinic3_nic_dev *nic_dev);=0D
+=0D
+static void hinic3_copy_mempool_uninit(struct hinic3_nic_dev *nic_dev);=0D
+=0D
+/**=0D
+ * Interrupt handler triggered by NIC for handling specific event.=0D
+ *=0D
+ * @param[in] param=0D
+ * The address of parameter (struct rte_eth_dev *) registered before.=0D
+ */=0D
+static void=0D
+hinic3_dev_interrupt_handler(void *param)=0D
+{=0D
+	struct rte_eth_dev *dev =3D param;=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	if (!hinic3_get_bit(HINIC3_DEV_INTR_EN, &nic_dev->dev_status)) {=0D
+		PMD_DRV_LOG(WARNING,=0D
+			    "Intr is disabled, ignore intr event, "=0D
+			    "dev_name: %s, port_id: %d",=0D
+			    nic_dev->dev_name, dev->data->port_id);=0D
+		return;=0D
+	}=0D
+=0D
+	/* Aeq0 msg handler. */=0D
+	hinic3_dev_handle_aeq_event(nic_dev->hwdev, param);=0D
+}=0D
+=0D
+/**=0D
+ * Do the config for TX/Rx queues, include queue number, mtu size and RSS.=
=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_configure(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	nic_dev->num_sqs =3D dev->data->nb_tx_queues;=0D
+	nic_dev->num_rqs =3D dev->data->nb_rx_queues;=0D
+=0D
+	if (nic_dev->num_sqs > nic_dev->max_sqs ||=0D
+	    nic_dev->num_rqs > nic_dev->max_rqs) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "num_sqs: %d or num_rqs: %d larger than "=0D
+			    "max_sqs: %d or max_rqs: %d",=0D
+			    nic_dev->num_sqs, nic_dev->num_rqs,=0D
+			    nic_dev->max_sqs, nic_dev->max_rqs);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	/* The range of mtu is 384~9600. */=0D
+=0D
+	if (HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) <=0D
+		    HINIC3_MIN_FRAME_SIZE ||=0D
+	    HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) >=0D
+		    HINIC3_MAX_JUMBO_FRAME_SIZE) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Max rx pkt len out of range, max_rx_pkt_len: %d, "=0D
+			    "expect between %d and %d",=0D
+			    HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode),=0D
+			    HINIC3_MIN_FRAME_SIZE, HINIC3_MAX_JUMBO_FRAME_SIZE);=0D
+		return -EINVAL;=0D
+	}=0D
+	nic_dev->mtu_size =3D=0D
+		(u16)HINIC3_PKTLEN_TO_MTU(HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmo=
de));=0D
+	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)=0D
+		dev->data->dev_conf.rxmode.offloads |=3D=0D
+			RTE_ETH_RX_OFFLOAD_RSS_HASH;=0D
+=0D
+	/* Clear fdir filter. */=0D
+	hinic3_free_fdir_filter(dev);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Get information about the device.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[out] info=0D
+ * Info structure for ethernet device.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *inf=
o)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+=0D
+	info->max_rx_queues =3D nic_dev->max_rqs;=0D
+	info->max_tx_queues =3D nic_dev->max_sqs;=0D
+	info->min_rx_bufsize =3D HINIC3_MIN_RX_BUF_SIZE;=0D
+	info->max_rx_pktlen =3D HINIC3_MAX_JUMBO_FRAME_SIZE;=0D
+	info->max_mac_addrs =3D HINIC3_MAX_UC_MAC_ADDRS;=0D
+	info->min_mtu =3D HINIC3_MIN_MTU_SIZE;=0D
+	info->max_mtu =3D HINIC3_MAX_MTU_SIZE;=0D
+	info->max_lro_pkt_size =3D HINIC3_MAX_LRO_SIZE;=0D
+=0D
+	info->rx_queue_offload_capa =3D 0;=0D
+	info->rx_offload_capa =3D=0D
+		RTE_ETH_RX_OFFLOAD_VLAN_STRIP | RTE_ETH_RX_OFFLOAD_IPV4_CKSUM |=0D
+		RTE_ETH_RX_OFFLOAD_UDP_CKSUM | RTE_ETH_RX_OFFLOAD_TCP_CKSUM |=0D
+		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM | RTE_ETH_RX_OFFLOAD_VLAN_FILTER |=0D
+		RTE_ETH_RX_OFFLOAD_SCATTER | RTE_ETH_RX_OFFLOAD_TCP_LRO |=0D
+		RTE_ETH_RX_OFFLOAD_RSS_HASH;=0D
+=0D
+	info->tx_queue_offload_capa =3D 0;=0D
+	info->tx_offload_capa =3D=0D
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT | RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |=0D
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM |=0D
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |=0D
+		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |=0D
+		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;=0D
+=0D
+	info->hash_key_size =3D HINIC3_RSS_KEY_SIZE;=0D
+	info->reta_size =3D HINIC3_RSS_INDIR_SIZE;=0D
+	info->flow_type_rss_offloads =3D HINIC3_RSS_OFFLOAD_ALL;=0D
+=0D
+	info->rx_desc_lim =3D hinic3_rx_desc_lim;=0D
+	info->tx_desc_lim =3D hinic3_tx_desc_lim;=0D
+=0D
+	/* Driver-preferred rx/tx parameters. */=0D
+	info->default_rxportconf.burst_size =3D HINIC3_DEFAULT_BURST_SIZE;=0D
+	info->default_txportconf.burst_size =3D HINIC3_DEFAULT_BURST_SIZE;=0D
+	info->default_rxportconf.nb_queues =3D HINIC3_DEFAULT_NB_QUEUES;=0D
+	info->default_txportconf.nb_queues =3D HINIC3_DEFAULT_NB_QUEUES;=0D
+	info->default_rxportconf.ring_size =3D HINIC3_DEFAULT_RING_SIZE;=0D
+	info->default_txportconf.ring_size =3D HINIC3_DEFAULT_RING_SIZE;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw=
_size)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	char mgmt_ver[MGMT_VERSION_MAX_LEN] =3D {0};=0D
+	int err;=0D
+=0D
+	err =3D hinic3_get_mgmt_version(nic_dev->hwdev, mgmt_ver,=0D
+				      HINIC3_MGMT_VERSION_MAX_LEN);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Get fw version failed");=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	if (fw_size < strlen((char *)mgmt_ver) + 1)=0D
+		return (strlen((char *)mgmt_ver) + 1);=0D
+=0D
+	snprintf(fw_version, fw_size, "%s", mgmt_ver);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Set ethernet device link state up.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_set_link_up(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int err;=0D
+=0D
+	/*=0D
+	 * Vport enable will set function valid in mpu.=0D
+	 * So dev start status need to be checked before vport enable.=0D
+	 */=0D
+	if (hinic3_get_bit(HINIC3_DEV_START, &nic_dev->dev_status)) {=0D
+		err =3D hinic3_set_vport_enable(nic_dev->hwdev, true);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Enable vport failed, dev_name: %s",=0D
+				    nic_dev->dev_name);=0D
+			return err;=0D
+		}=0D
+	}=0D
+=0D
+	/* Link status follow phy port status, mpu will open pma. */=0D
+	err =3D hinic3_set_port_enable(nic_dev->hwdev, true);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Set MAC link up failed, dev_name: %s, port_id: %d",=0D
+			    nic_dev->dev_name, dev->data->port_id);=0D
+		return err;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Set ethernet device link state down.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_set_link_down(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_set_vport_enable(nic_dev->hwdev, false);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Disable vport failed, dev_name: %s",=0D
+			    nic_dev->dev_name);=0D
+		return err;=0D
+	}=0D
+=0D
+	/* Link status follow phy port status, mpu will close pma. */=0D
+	err =3D hinic3_set_port_enable(nic_dev->hwdev, false);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			"Set MAC link down failed, dev_name: %s, port_id: %d",=0D
+			nic_dev->dev_name, dev->data->port_id);=0D
+		return err;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Get device physical link information.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] wait_to_complete=0D
+ * Wait for request completion.=0D
+ *=0D
+ * @return=0D
+ * 0 : Link status changed=0D
+ * -1 : Link status not changed.=0D
+ */=0D
+static int=0D
+hinic3_link_update(struct rte_eth_dev *dev, int wait_to_complete)=0D
+{=0D
+#define CHECK_INTERVAL	10  /**< 10ms. */=0D
+#define MAX_REPEAT_TIME 100 /**< 1s (100 * 10ms) in total. */=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct rte_eth_link link;=0D
+	u8 link_state;=0D
+	unsigned int rep_cnt =3D MAX_REPEAT_TIME;=0D
+	int ret;=0D
+=0D
+	memset(&link, 0, sizeof(link));=0D
+	do {=0D
+		/* Get link status information from hardware. */=0D
+		ret =3D hinic3_get_link_state(nic_dev->hwdev, &link_state);=0D
+		if (ret) {=0D
+			link.link_status =3D RTE_ETH_LINK_DOWN;=0D
+			link.link_speed =3D RTE_ETH_SPEED_NUM_NONE;=0D
+			link.link_duplex =3D RTE_ETH_LINK_HALF_DUPLEX;=0D
+			link.link_autoneg =3D RTE_ETH_LINK_FIXED;=0D
+			goto out;=0D
+		}=0D
+=0D
+		get_port_info(nic_dev->hwdev, link_state, &link);=0D
+=0D
+		if (!wait_to_complete || link.link_status)=0D
+			break;=0D
+=0D
+		rte_delay_ms(CHECK_INTERVAL);=0D
+	} while (rep_cnt--);=0D
+=0D
+out:=0D
+	return rte_eth_linkstatus_set(dev, &link);=0D
+}=0D
+=0D
+/**=0D
+ * Reset all RX queues (RXQs).=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ */=0D
+static void=0D
+hinic3_reset_rx_queue(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	int q_id =3D 0;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
+=0D
+	for (q_id =3D 0; q_id < nic_dev->num_rqs; q_id++) {=0D
+		rxq =3D nic_dev->rxqs[q_id];=0D
+=0D
+		rxq->cons_idx =3D 0;=0D
+		rxq->prod_idx =3D 0;=0D
+		rxq->delta =3D rxq->q_depth;=0D
+		rxq->next_to_update =3D 0;=0D
+	}=0D
+}=0D
+=0D
+/**=0D
+ * Reset all TX queues (TXQs).=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ */=0D
+static void=0D
+hinic3_reset_tx_queue(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+	int q_id =3D 0;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
+=0D
+	for (q_id =3D 0; q_id < nic_dev->num_sqs; q_id++) {=0D
+		txq =3D nic_dev->txqs[q_id];=0D
+=0D
+		txq->cons_idx =3D 0;=0D
+		txq->prod_idx =3D 0;=0D
+		txq->owner =3D 1;=0D
+=0D
+		/* Clear hardware ci. */=0D
+		*txq->ci_vaddr_base =3D 0;=0D
+	}=0D
+}=0D
+=0D
+/**=0D
+ * Create the receive queue.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] qid=0D
+ * Receive queue index.=0D
+ * @param[in] nb_desc=0D
+ * Number of descriptors for receive queue.=0D
+ * @param[in] socket_id=0D
+ * Socket index on which memory must be allocated.=0D
+ * @param[in] rx_conf=0D
+ * Thresholds parameters (unused_).=0D
+ * @param[in] mp=0D
+ * Memory pool for buffer allocations.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_rx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_d=
esc,=0D
+		      unsigned int socket_id,=0D
+		      __rte_unused const struct rte_eth_rxconf *rx_conf,=0D
+		      struct rte_mempool *mp)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	const struct rte_memzone *rq_mz =3D NULL;=0D
+	const struct rte_memzone *cqe_mz =3D NULL;=0D
+	const struct rte_memzone *pi_mz =3D NULL;=0D
+	u16 rq_depth, rx_free_thresh;=0D
+	u32 queue_buf_size;=0D
+	void *db_addr =3D NULL;=0D
+	int wqe_count;=0D
+	u32 buf_size;=0D
+	int err;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
+=0D
+	/* Queue depth must be power of 2, otherwise will be aligned up. */=0D
+	rq_depth =3D (nb_desc & (nb_desc - 1))=0D
+			   ? ((u16)(1U << (ilog2(nb_desc) + 1)))=0D
+			   : nb_desc;=0D
+=0D
+	/*=0D
+	 * Validate number of receive descriptors.=0D
+	 * It must not exceed hardware maximum and minimum.=0D
+	 */=0D
+	if (rq_depth > HINIC3_MAX_QUEUE_DEPTH ||=0D
+	    rq_depth < HINIC3_MIN_QUEUE_DEPTH) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "RX queue depth is out of range from %d to %d,"=0D
+			    "(nb_desc: %d, q_depth: %d, port: %d queue: %d)",=0D
+			    HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_QUEUE_DEPTH,=0D
+			    (int)nb_desc, (int)rq_depth,=0D
+			    (int)dev->data->port_id, (int)qid);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	/*=0D
+	 * The RX descriptor ring will be cleaned after rxq->rx_free_thresh=0D
+	 * descriptors are used or if the number of descriptors required=0D
+	 * to transmit a packet is greater than the number of free RX=0D
+	 * descriptors.=0D
+	 * The following constraints must be satisfied:=0D
+	 * - rx_free_thresh must be greater than 0.=0D
+	 * - rx_free_thresh must be less than the size of the ring minus 1.=0D
+	 * When set to zero use default values.=0D
+	 */=0D
+	rx_free_thresh =3D (u16)((rx_conf->rx_free_thresh)=0D
+				       ? rx_conf->rx_free_thresh=0D
+				       : HINIC3_DEFAULT_RX_FREE_THRESH);=0D
+	if (rx_free_thresh >=3D (rq_depth - 1)) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "rx_free_thresh must be less than the number "=0D
+			    "of RX descriptors minus 1, rx_free_thresh: %u "=0D
+			    "port: %d queue: %d)",=0D
+			    (unsigned int)rx_free_thresh,=0D
+			    (int)dev->data->port_id, (int)qid);=0D
+=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	rxq =3D rte_zmalloc_socket("hinic3_rq", sizeof(struct hinic3_rxq),=0D
+				 RTE_CACHE_LINE_SIZE, (int)socket_id);=0D
+	if (!rxq) {=0D
+		PMD_DRV_LOG(ERR, "Allocate rxq[%d] failed, dev_name: %s", qid,=0D
+			    dev->data->name);=0D
+=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	/* Init rq parameters. */=0D
+	rxq->nic_dev =3D nic_dev;=0D
+	nic_dev->rxqs[qid] =3D rxq;=0D
+	rxq->mb_pool =3D mp;=0D
+	rxq->q_id =3D qid;=0D
+	rxq->next_to_update =3D 0;=0D
+	rxq->q_depth =3D rq_depth;=0D
+	rxq->q_mask =3D rq_depth - 1;=0D
+	rxq->delta =3D rq_depth;=0D
+	rxq->cons_idx =3D 0;=0D
+	rxq->prod_idx =3D 0;=0D
+	rxq->rx_free_thresh =3D rx_free_thresh;=0D
+	rxq->rxinfo_align_end =3D rxq->q_depth - rxq->rx_free_thresh;=0D
+	rxq->port_id =3D dev->data->port_id;=0D
+	rxq->wait_time_cycle =3D HINIC3_RX_WAIT_CYCLE_THRESH;=0D
+=0D
+	/* If buf_len used for function table, need to translated. */=0D
+	u16 rx_buf_size =3D=0D
+		rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HEADROOM;=0D
+	err =3D hinic3_convert_rx_buf_size(rx_buf_size, &buf_size);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Adjust buf size failed, dev_name: %s",=0D
+			    dev->data->name);=0D
+		goto adjust_bufsize_fail;=0D
+	}=0D
+=0D
+	if (buf_size >=3D HINIC3_RX_BUF_SIZE_4K &&=0D
+	    buf_size < HINIC3_RX_BUF_SIZE_16K)=0D
+		rxq->wqe_type =3D HINIC3_EXTEND_RQ_WQE;=0D
+	else=0D
+		rxq->wqe_type =3D HINIC3_NORMAL_RQ_WQE;=0D
+=0D
+	rxq->wqebb_shift =3D HINIC3_RQ_WQEBB_SHIFT + rxq->wqe_type;=0D
+	rxq->wqebb_size =3D (u16)BIT(rxq->wqebb_shift);=0D
+=0D
+	rxq->buf_len =3D (u16)buf_size;=0D
+	rxq->rx_buff_shift =3D ilog2(rxq->buf_len);=0D
+=0D
+	pi_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_rq_pi", qid, RTE_PGSIZE_4K=
,=0D
+					RTE_CACHE_LINE_SIZE, (int)socket_id);=0D
+	if (!pi_mz) {=0D
+		PMD_DRV_LOG(ERR, "Allocate rxq[%d] pi_mz failed, dev_name: %s",=0D
+			    qid, dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_pi_mz_fail;=0D
+	}=0D
+	rxq->pi_mz =3D pi_mz;=0D
+	rxq->pi_dma_addr =3D pi_mz->iova;=0D
+	rxq->pi_virt_addr =3D pi_mz->addr;=0D
+=0D
+	err =3D hinic3_alloc_db_addr(nic_dev->hwdev, &db_addr, HINIC3_DB_TYPE_RQ)=
;=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Alloc rq doorbell addr failed");=0D
+		goto alloc_db_err_fail;=0D
+	}=0D
+	rxq->db_addr =3D db_addr;=0D
+=0D
+	queue_buf_size =3D BIT(rxq->wqebb_shift) * rq_depth;=0D
+	rq_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_rq_mz", qid,=0D
+					queue_buf_size, RTE_PGSIZE_256K,=0D
+					(int)socket_id);=0D
+	if (!rq_mz) {=0D
+		PMD_DRV_LOG(ERR, "Allocate rxq[%d] rq_mz failed, dev_name: %s",=0D
+			    qid, dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_rq_mz_fail;=0D
+	}=0D
+=0D
+	memset(rq_mz->addr, 0, queue_buf_size);=0D
+	rxq->rq_mz =3D rq_mz;=0D
+	rxq->queue_buf_paddr =3D rq_mz->iova;=0D
+	rxq->queue_buf_vaddr =3D rq_mz->addr;=0D
+=0D
+	rxq->rx_info =3D rte_zmalloc_socket("rx_info",=0D
+					  rq_depth * sizeof(*rxq->rx_info),=0D
+					  RTE_CACHE_LINE_SIZE, (int)socket_id);=0D
+	if (!rxq->rx_info) {=0D
+		PMD_DRV_LOG(ERR, "Allocate rx_info failed, dev_name: %s",=0D
+			    dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_rx_info_fail;=0D
+	}=0D
+=0D
+	cqe_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_cqe_mz", qid,=0D
+					 rq_depth * sizeof(*rxq->rx_cqe),=0D
+					 RTE_CACHE_LINE_SIZE, (int)socket_id);=0D
+	if (!cqe_mz) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cqe mem zone failed, dev_name: %s",=0D
+			    dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_cqe_mz_fail;=0D
+	}=0D
+	memset(cqe_mz->addr, 0, rq_depth * sizeof(*rxq->rx_cqe));=0D
+	rxq->cqe_mz =3D cqe_mz;=0D
+	rxq->cqe_start_paddr =3D cqe_mz->iova;=0D
+	rxq->cqe_start_vaddr =3D cqe_mz->addr;=0D
+	rxq->rx_cqe =3D (struct hinic3_rq_cqe *)rxq->cqe_start_vaddr;=0D
+=0D
+	wqe_count =3D hinic3_rx_fill_wqe(rxq);=0D
+	if (wqe_count !=3D rq_depth) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Fill rx wqe failed, wqe_count: %d, dev_name: %s",=0D
+			    wqe_count, dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto fill_rx_wqe_fail;=0D
+	}=0D
+	/* Record rxq pointer in rte_eth rx_queues. */=0D
+	dev->data->rx_queues[qid] =3D rxq;=0D
+=0D
+	return 0;=0D
+=0D
+fill_rx_wqe_fail:=0D
+	hinic3_memzone_free(rxq->cqe_mz);=0D
+alloc_cqe_mz_fail:=0D
+	rte_free(rxq->rx_info);=0D
+=0D
+alloc_rx_info_fail:=0D
+	hinic3_memzone_free(rxq->rq_mz);=0D
+=0D
+alloc_rq_mz_fail:=0D
+alloc_db_err_fail:=0D
+	hinic3_memzone_free(rxq->pi_mz);=0D
+=0D
+alloc_pi_mz_fail:=0D
+adjust_bufsize_fail:=0D
+	rte_free(rxq);=0D
+	nic_dev->rxqs[qid] =3D NULL;=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Create the transmit queue.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] queue_idx=0D
+ * Transmit queue index.=0D
+ * @param[in] nb_desc=0D
+ * Number of descriptors for transmit queue.=0D
+ * @param[in] socket_id=0D
+ * Socket index on which memory must be allocated.=0D
+ * @param[in] tx_conf=0D
+ * Tx queue configuration parameters (unused_).=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_d=
esc,=0D
+		      unsigned int socket_id,=0D
+		      __rte_unused const struct rte_eth_txconf *tx_conf)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	struct hinic3_hwdev *hwdev;=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+	const struct rte_memzone *sq_mz =3D NULL;=0D
+	const struct rte_memzone *ci_mz =3D NULL;=0D
+	void *db_addr =3D NULL;=0D
+	u16 sq_depth, tx_free_thresh;=0D
+	u32 queue_buf_size;=0D
+	int err;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
+	hwdev =3D nic_dev->hwdev;=0D
+=0D
+	/* Queue depth must be power of 2, otherwise will be aligned up. */=0D
+	sq_depth =3D (nb_desc & (nb_desc - 1))=0D
+			   ? ((u16)(1U << (ilog2(nb_desc) + 1)))=0D
+			   : nb_desc;=0D
+=0D
+	/*=0D
+	 * Validate number of transmit descriptors.=0D
+	 * It must not exceed hardware maximum and minimum.=0D
+	 */=0D
+	if (sq_depth > HINIC3_MAX_QUEUE_DEPTH ||=0D
+	    sq_depth < HINIC3_MIN_QUEUE_DEPTH) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "TX queue depth is out of range from %d to %d,"=0D
+			    "(nb_desc: %d, q_depth: %d, port: %d queue: %d)",=0D
+			    HINIC3_MIN_QUEUE_DEPTH, HINIC3_MAX_QUEUE_DEPTH,=0D
+			    (int)nb_desc, (int)sq_depth,=0D
+			    (int)dev->data->port_id, (int)qid);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	/*=0D
+	 * The TX descriptor ring will be cleaned after txq->tx_free_thresh=0D
+	 * descriptors are used or if the number of descriptors required=0D
+	 * to transmit a packet is greater than the number of free TX=0D
+	 * descriptors.=0D
+	 * The following constraints must be satisfied:=0D
+	 * - tx_free_thresh must be greater than 0.=0D
+	 * - tx_free_thresh must be less than the size of the ring minus 1.=0D
+	 * When set to zero use default values.=0D
+	 */=0D
+	tx_free_thresh =3D (u16)((tx_conf->tx_free_thresh)=0D
+				       ? tx_conf->tx_free_thresh=0D
+				       : HINIC3_DEFAULT_TX_FREE_THRESH);=0D
+	if (tx_free_thresh >=3D (sq_depth - 1)) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "tx_free_thresh must be less than the number of tx "=0D
+			    "descriptors minus 1, tx_free_thresh: %u port: %d "=0D
+			    "queue: %d",=0D
+			    (unsigned int)tx_free_thresh,=0D
+			    (int)dev->data->port_id, (int)qid);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	txq =3D rte_zmalloc_socket("hinic3_tx_queue", sizeof(struct hinic3_txq),=
=0D
+				 RTE_CACHE_LINE_SIZE, (int)socket_id);=0D
+	if (!txq) {=0D
+		PMD_DRV_LOG(ERR, "Allocate txq[%d] failed, dev_name: %s", qid,=0D
+			    dev->data->name);=0D
+		return -ENOMEM;=0D
+	}=0D
+	nic_dev->txqs[qid] =3D txq;=0D
+	txq->nic_dev =3D nic_dev;=0D
+	txq->q_id =3D qid;=0D
+	txq->q_depth =3D sq_depth;=0D
+	txq->q_mask =3D sq_depth - 1;=0D
+	txq->cons_idx =3D 0;=0D
+	txq->prod_idx =3D 0;=0D
+	txq->wqebb_shift =3D HINIC3_SQ_WQEBB_SHIFT;=0D
+	txq->wqebb_size =3D (u16)BIT(txq->wqebb_shift);=0D
+	txq->tx_free_thresh =3D tx_free_thresh;=0D
+	txq->owner =3D 1;=0D
+	txq->cos =3D nic_dev->default_cos;=0D
+=0D
+	ci_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_sq_ci", qid,=0D
+					HINIC3_CI_Q_ADDR_SIZE,=0D
+					HINIC3_CI_Q_ADDR_SIZE, (int)socket_id);=0D
+	if (!ci_mz) {=0D
+		PMD_DRV_LOG(ERR, "Allocate txq[%d] ci_mz failed, dev_name: %s",=0D
+			    qid, dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_ci_mz_fail;=0D
+	}=0D
+	txq->ci_mz =3D ci_mz;=0D
+	txq->ci_dma_base =3D ci_mz->iova;=0D
+	txq->ci_vaddr_base =3D (volatile u16 *)ci_mz->addr;=0D
+=0D
+	queue_buf_size =3D BIT(txq->wqebb_shift) * sq_depth;=0D
+	sq_mz =3D hinic3_dma_zone_reserve(dev, "hinic3_sq_mz", qid,=0D
+					queue_buf_size, RTE_PGSIZE_256K,=0D
+					(int)socket_id);=0D
+	if (!sq_mz) {=0D
+		PMD_DRV_LOG(ERR, "Allocate txq[%d] sq_mz failed, dev_name: %s",=0D
+			    qid, dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_sq_mz_fail;=0D
+	}=0D
+	memset(sq_mz->addr, 0, queue_buf_size);=0D
+	txq->sq_mz =3D sq_mz;=0D
+	txq->queue_buf_paddr =3D sq_mz->iova;=0D
+	txq->queue_buf_vaddr =3D sq_mz->addr;=0D
+	txq->sq_head_addr =3D (u64)txq->queue_buf_vaddr;=0D
+	txq->sq_bot_sge_addr =3D txq->sq_head_addr + queue_buf_size;=0D
+=0D
+	err =3D hinic3_alloc_db_addr(hwdev, &db_addr, HINIC3_DB_TYPE_SQ);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Alloc sq doorbell addr failed");=0D
+		goto alloc_db_err_fail;=0D
+	}=0D
+	txq->db_addr =3D db_addr;=0D
+=0D
+	txq->tx_info =3D rte_zmalloc_socket("tx_info",=0D
+					  sq_depth * sizeof(*txq->tx_info),=0D
+					  RTE_CACHE_LINE_SIZE, (int)socket_id);=0D
+	if (!txq->tx_info) {=0D
+		PMD_DRV_LOG(ERR, "Allocate tx_info failed, dev_name: %s",=0D
+			    dev->data->name);=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_tx_info_fail;=0D
+	}=0D
+=0D
+	/* Record txq pointer in rte_eth tx_queues. */=0D
+	dev->data->tx_queues[qid] =3D txq;=0D
+=0D
+	return 0;=0D
+=0D
+alloc_tx_info_fail:=0D
+alloc_db_err_fail:=0D
+	hinic3_memzone_free(txq->sq_mz);=0D
+=0D
+alloc_sq_mz_fail:=0D
+	hinic3_memzone_free(txq->ci_mz);=0D
+=0D
+alloc_ci_mz_fail:=0D
+	rte_free(txq);=0D
+	return err;=0D
+}=0D
+=0D
+static void=0D
+hinic3_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)=0D
+{=0D
+	if (dev =3D=3D NULL || dev->data =3D=3D NULL || dev->data->rx_queues =3D=
=3D NULL) {=0D
+		PMD_DRV_LOG(WARNING, "rx queue is null when release");=0D
+		return;=0D
+	}=0D
+	if (queue_id >=3D dev->data->nb_rx_queues) {=0D
+		PMD_DRV_LOG(WARNING, "eth_dev: %s, rx queue id: %u is illegal",=0D
+			    dev->data->name, queue_id);=0D
+		return;=0D
+	}=0D
+	struct hinic3_rxq *rxq =3D dev->data->rx_queues[queue_id];=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+=0D
+	if (!rxq) {=0D
+		PMD_DRV_LOG(WARNING, "Rxq is null when release");=0D
+		return;=0D
+	}=0D
+=0D
+	nic_dev =3D rxq->nic_dev;=0D
+=0D
+	hinic3_free_rxq_mbufs(rxq);=0D
+=0D
+	hinic3_memzone_free(rxq->cqe_mz);=0D
+=0D
+	rte_free(rxq->rx_info);=0D
+	rxq->rx_info =3D NULL;=0D
+=0D
+	hinic3_memzone_free(rxq->rq_mz);=0D
+=0D
+	hinic3_memzone_free(rxq->pi_mz);=0D
+=0D
+	nic_dev->rxqs[rxq->q_id] =3D NULL;=0D
+	rte_free(rxq);=0D
+	dev->data->rx_queues[queue_id] =3D NULL;=0D
+}=0D
+=0D
+static void=0D
+hinic3_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)=0D
+{=0D
+	if (dev =3D=3D NULL || dev->data =3D=3D NULL || dev->data->tx_queues =3D=
=3D NULL) {=0D
+		PMD_DRV_LOG(WARNING, "tx queue is null when release");=0D
+		return;=0D
+	}=0D
+	if (queue_id >=3D dev->data->nb_tx_queues) {=0D
+		PMD_DRV_LOG(WARNING, "eth_dev: %s, tx queue id: %u is illegal",=0D
+			    dev->data->name, queue_id);=0D
+		return;=0D
+	}=0D
+	struct hinic3_txq *txq =3D dev->data->tx_queues[queue_id];=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+=0D
+	if (!txq) {=0D
+		PMD_DRV_LOG(WARNING, "Txq is null when release");=0D
+		return;=0D
+	}=0D
+	PMD_DRV_LOG(INFO, "%s txq_idx:%d queue release.",=0D
+		    txq->nic_dev->dev_name, txq->q_id);=0D
+	nic_dev =3D txq->nic_dev;=0D
+=0D
+	hinic3_free_txq_mbufs(txq);=0D
+=0D
+	rte_free(txq->tx_info);=0D
+	txq->tx_info =3D NULL;=0D
+=0D
+	hinic3_memzone_free(txq->sq_mz);=0D
+=0D
+	hinic3_memzone_free(txq->ci_mz);=0D
+=0D
+	nic_dev->txqs[txq->q_id] =3D NULL;=0D
+	rte_free(txq);=0D
+	dev->data->tx_queues[queue_id] =3D NULL;=0D
+}=0D
+=0D
+/**=0D
+ * Start RXQ and enables flow director (fdir) filter for RXQ.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] rq_id=0D
+ * RX queue ID to be started.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_rx_queue_start(__rte_unused struct rte_eth_dev *dev,=0D
+			  __rte_unused uint16_t rq_id)=0D
+{=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	int rc;=0D
+=0D
+	if (rq_id < dev->data->nb_rx_queues) {=0D
+		rxq =3D dev->data->rx_queues[rq_id];=0D
+=0D
+		rc =3D hinic3_start_rq(dev, rxq);=0D
+		if (rc) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Start rx queue failed, eth_dev:%s, "=0D
+				    "queue_idx:%d",=0D
+				    dev->data->name, rq_id);=0D
+			return rc;=0D
+		}=0D
+=0D
+		dev->data->rx_queue_state[rq_id] =3D RTE_ETH_QUEUE_STATE_STARTED;=0D
+	}=0D
+	rc =3D hinic3_enable_rxq_fdir_filter(dev, (u32)rq_id, (u32)true);=0D
+	if (rc) {=0D
+		PMD_DRV_LOG(ERR, "Failed to enable rq : %d fdir filter.",=0D
+			    rq_id);=0D
+		return rc;=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Stop RXQ and disable flow director (fdir) filter for RXQ.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] rq_id=0D
+ * RX queue ID to be stopped.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_rx_queue_stop(__rte_unused struct rte_eth_dev *dev,=0D
+			 __rte_unused uint16_t rq_id)=0D
+{=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	int rc;=0D
+=0D
+	if (rq_id < dev->data->nb_rx_queues) {=0D
+		rxq =3D dev->data->rx_queues[rq_id];=0D
+=0D
+		rc =3D hinic3_stop_rq(dev, rxq);=0D
+		if (rc) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Stop rx queue failed, eth_dev:%s, "=0D
+				    "queue_idx:%d",=0D
+				    dev->data->name, rq_id);=0D
+			return rc;=0D
+		}=0D
+=0D
+		dev->data->rx_queue_state[rq_id] =3D RTE_ETH_QUEUE_STATE_STOPPED;=0D
+	}=0D
+	rc =3D hinic3_enable_rxq_fdir_filter(dev, (u32)rq_id, (u32)false);=0D
+	if (rc) {=0D
+		PMD_DRV_LOG(ERR, "Failed to disable rq : %d fdir filter.",=0D
+			    rq_id);=0D
+		return rc;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_dev_tx_queue_start(__rte_unused struct rte_eth_dev *dev,=0D
+			  __rte_unused uint16_t sq_id)=0D
+{=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+=0D
+	PMD_DRV_LOG(INFO, "Start tx queue, eth_dev:%s, queue_idx:%d",=0D
+		    dev->data->name, sq_id);=0D
+=0D
+	txq =3D dev->data->tx_queues[sq_id];=0D
+	HINIC3_SET_TXQ_STARTED(txq);=0D
+	dev->data->tx_queue_state[sq_id] =3D RTE_ETH_QUEUE_STATE_STARTED;=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_dev_tx_queue_stop(__rte_unused struct rte_eth_dev *dev,=0D
+			 __rte_unused uint16_t sq_id)=0D
+{=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+	int rc;=0D
+=0D
+	if (sq_id < dev->data->nb_tx_queues) {=0D
+		txq =3D dev->data->tx_queues[sq_id];=0D
+		rc =3D hinic3_stop_sq(txq);=0D
+		if (rc) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Stop tx queue failed, eth_dev:%s, "=0D
+				    "queue_idx:%d",=0D
+				    dev->data->name, sq_id);=0D
+			return rc;=0D
+		}=0D
+=0D
+		HINIC3_SET_TXQ_STOPPED(txq);=0D
+		dev->data->tx_queue_state[sq_id] =3D RTE_ETH_QUEUE_STATE_STOPPED;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id=
)=0D
+{=0D
+	struct rte_pci_device *pci_dev =3D RTE_ETH_DEV_TO_PCI(dev);=0D
+	struct rte_intr_handle *intr_handle =3D PCI_DEV_TO_INTR_HANDLE(pci_dev);=
=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u16 msix_intr;=0D
+=0D
+	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)=0D
+		return 0;=0D
+=0D
+	if (queue_id >=3D dev->data->nb_rx_queues)=0D
+		return -EINVAL;=0D
+=0D
+	msix_intr =3D (u16)intr_handle->intr_vec[queue_id];=0D
+	hinic3_set_msix_auto_mask_state(nic_dev->hwdev, msix_intr,=0D
+					HINIC3_SET_MSIX_AUTO_MASK);=0D
+	hinic3_set_msix_state(nic_dev->hwdev, msix_intr, HINIC3_MSIX_ENABLE);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_i=
d)=0D
+{=0D
+	struct rte_pci_device *pci_dev =3D RTE_ETH_DEV_TO_PCI(dev);=0D
+	struct rte_intr_handle *intr_handle =3D PCI_DEV_TO_INTR_HANDLE(pci_dev);=
=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u16 msix_intr;=0D
+=0D
+	if (!rte_intr_dp_is_en(intr_handle) || !intr_handle->intr_vec)=0D
+		return 0;=0D
+=0D
+	if (queue_id >=3D dev->data->nb_rx_queues)=0D
+		return -EINVAL;=0D
+=0D
+	msix_intr =3D (u16)intr_handle->intr_vec[queue_id];=0D
+	hinic3_set_msix_auto_mask_state(nic_dev->hwdev, msix_intr,=0D
+					HINIC3_CLR_MSIX_AUTO_MASK);=0D
+	hinic3_set_msix_state(nic_dev->hwdev, msix_intr, HINIC3_MSIX_DISABLE);=0D
+	hinic3_misx_intr_clear_resend_bit(nic_dev->hwdev, msix_intr,=0D
+					  MSIX_RESEND_TIMER_CLEAR);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static uint32_t=0D
+hinic3_dev_rx_queue_count(__rte_unused void *rx_queue)=0D
+{=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_dev_rx_descriptor_status(__rte_unused void *rx_queue,=0D
+				__rte_unused uint16_t offset)=0D
+{=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_dev_tx_descriptor_status(__rte_unused void *tx_queue,=0D
+				__rte_unused uint16_t offset)=0D
+{=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_set_lro(struct hinic3_nic_dev *nic_dev, struct rte_eth_conf *dev_co=
nf)=0D
+{=0D
+	bool lro_en;=0D
+	int max_lro_size, lro_max_pkt_len;=0D
+	int err;=0D
+=0D
+	/* Config lro. */=0D
+	lro_en =3D dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO ? true=
=0D
+									: false;=0D
+	max_lro_size =3D (int)(dev_conf->rxmode.max_lro_pkt_size);=0D
+	/* `max_lro_size` is divisible by `HINIC3_LRO_UNIT_WQE_SIZE`. */=0D
+	lro_max_pkt_len =3D max_lro_size / HINIC3_LRO_UNIT_WQE_SIZE=0D
+				  ? max_lro_size / HINIC3_LRO_UNIT_WQE_SIZE=0D
+				  : 1;=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "max_lro_size: %d, rx_buff_len: %d, lro_max_pkt_len: %d",=0D
+		    max_lro_size, nic_dev->rx_buff_len, lro_max_pkt_len);=0D
+	PMD_DRV_LOG(INFO, "max_rx_pkt_len: %d",=0D
+		    HINIC3_MAX_RX_PKT_LEN(dev_conf->rxmode));=0D
+	err =3D hinic3_set_rx_lro_state(nic_dev->hwdev, lro_en,=0D
+				      HINIC3_LRO_DEFAULT_TIME_LIMIT,=0D
+				      lro_max_pkt_len);=0D
+	if (err)=0D
+		PMD_DRV_LOG(ERR, "Set lro state failed, err: %d", err);=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+hinic3_set_vlan(struct rte_eth_dev *dev, struct rte_eth_conf *dev_conf)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	bool vlan_filter, vlan_strip;=0D
+	int err;=0D
+=0D
+	/* Config vlan filter. */=0D
+	vlan_filter =3D dev_conf->rxmode.offloads &=0D
+		      RTE_ETH_RX_OFFLOAD_VLAN_FILTER;=0D
+=0D
+	err =3D hinic3_set_vlan_filter(nic_dev->hwdev, vlan_filter);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Config vlan filter failed, device: %s, port_id: "=0D
+			    "%d, err: %d",=0D
+			    nic_dev->dev_name, dev->data->port_id, err);=0D
+		return err;=0D
+	}=0D
+=0D
+	/* Config vlan stripping. */=0D
+	vlan_strip =3D dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP;=
=0D
+=0D
+	err =3D hinic3_set_rx_vlan_offload(nic_dev->hwdev, vlan_strip);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Config vlan strip failed, device: %s, port_id: "=0D
+			    "%d, err: %d",=0D
+			    nic_dev->dev_name, dev->data->port_id, err);=0D
+	}=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Configure RX mode, checksum offload, LRO, RSS, VLAN and initialize the =
RXQ=0D
+ * list.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_set_rxtx_configure(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct rte_eth_conf *dev_conf =3D &dev->data->dev_conf;=0D
+	struct rte_eth_rss_conf *rss_conf =3D NULL;=0D
+	int err;=0D
+=0D
+	/* Config rx mode. */=0D
+	err =3D hinic3_set_rx_mode(nic_dev->hwdev, HINIC3_DEFAULT_RX_MODE);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set rx_mode: 0x%x failed",=0D
+			    HINIC3_DEFAULT_RX_MODE);=0D
+		return err;=0D
+	}=0D
+	nic_dev->rx_mode =3D HINIC3_DEFAULT_RX_MODE;=0D
+=0D
+	/* Config rx checksum offload. */=0D
+	if (dev_conf->rxmode.offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM)=0D
+		nic_dev->rx_csum_en =3D HINIC3_DEFAULT_RX_CSUM_OFFLOAD;=0D
+=0D
+	err =3D hinic3_set_lro(nic_dev, dev_conf);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set lro failed");=0D
+		return err;=0D
+	}=0D
+	/* Config RSS. */=0D
+	if ((dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) &&=0D
+	    nic_dev->num_rqs > 1) {=0D
+		rss_conf =3D &dev_conf->rx_adv_conf.rss_conf;=0D
+		err =3D hinic3_update_rss_config(dev, rss_conf);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Set rss config failed, err: %d", err);=0D
+			return err;=0D
+		}=0D
+	}=0D
+=0D
+	err =3D hinic3_set_vlan(dev, dev_conf);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set vlan failed, err: %d", err);=0D
+		return err;=0D
+	}=0D
+=0D
+	hinic3_init_rx_queue_list(nic_dev);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Disable RX mode and RSS, and free associated resources.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ */=0D
+static void=0D
+hinic3_remove_rxtx_configure(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u8 prio_tc[HINIC3_DCB_UP_MAX] =3D {0};=0D
+=0D
+	hinic3_set_rx_mode(nic_dev->hwdev, 0);=0D
+=0D
+	if (nic_dev->rss_state =3D=3D HINIC3_RSS_ENABLE) {=0D
+		hinic3_rss_cfg(nic_dev->hwdev, HINIC3_RSS_DISABLE, 0, prio_tc);=0D
+		hinic3_rss_template_free(nic_dev->hwdev);=0D
+		nic_dev->rss_state =3D HINIC3_RSS_DISABLE;=0D
+	}=0D
+}=0D
+=0D
+static bool=0D
+hinic3_find_vlan_filter(struct hinic3_nic_dev *nic_dev, uint16_t vlan_id)=
=0D
+{=0D
+	u32 vid_idx, vid_bit;=0D
+=0D
+	vid_idx =3D HINIC3_VFTA_IDX(vlan_id);=0D
+	vid_bit =3D HINIC3_VFTA_BIT(vlan_id);=0D
+=0D
+	return (nic_dev->vfta[vid_idx] & vid_bit) ? true : false;=0D
+}=0D
+=0D
+static void=0D
+hinic3_store_vlan_filter(struct hinic3_nic_dev *nic_dev, u16 vlan_id, bool=
 on)=0D
+{=0D
+	u32 vid_idx, vid_bit;=0D
+=0D
+	vid_idx =3D HINIC3_VFTA_IDX(vlan_id);=0D
+	vid_bit =3D HINIC3_VFTA_BIT(vlan_id);=0D
+=0D
+	if (on)=0D
+		nic_dev->vfta[vid_idx] |=3D vid_bit;=0D
+	else=0D
+		nic_dev->vfta[vid_idx] &=3D ~vid_bit;=0D
+}=0D
+=0D
+static void=0D
+hinic3_remove_all_vlanid(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int vlan_id;=0D
+	u16 func_id;=0D
+=0D
+	func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+=0D
+	for (vlan_id =3D 1; vlan_id < RTE_ETHER_MAX_VLAN_ID; vlan_id++) {=0D
+		if (hinic3_find_vlan_filter(nic_dev, vlan_id)) {=0D
+			hinic3_del_vlan(nic_dev->hwdev, vlan_id, func_id);=0D
+			hinic3_store_vlan_filter(nic_dev, vlan_id, false);=0D
+		}=0D
+	}=0D
+}=0D
+=0D
+static void=0D
+hinic3_disable_interrupt(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct rte_pci_device *pci_dev =3D RTE_ETH_DEV_TO_PCI(dev);=0D
+=0D
+	if (!hinic3_get_bit(HINIC3_DEV_INIT, &nic_dev->dev_status))=0D
+		return;=0D
+=0D
+	/* Disable rte interrupt. */=0D
+	rte_intr_disable(PCI_DEV_TO_INTR_HANDLE(pci_dev));=0D
+	rte_intr_callback_unregister(PCI_DEV_TO_INTR_HANDLE(pci_dev),=0D
+				     hinic3_dev_interrupt_handler, (void *)dev);=0D
+}=0D
+=0D
+static void=0D
+hinic3_enable_interrupt(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct rte_pci_device *pci_dev =3D RTE_ETH_DEV_TO_PCI(dev);=0D
+=0D
+	if (!hinic3_get_bit(HINIC3_DEV_INIT, &nic_dev->dev_status))=0D
+		return;=0D
+=0D
+	/* Enable rte interrupt. */=0D
+	rte_intr_enable(PCI_DEV_TO_INTR_HANDLE(pci_dev));=0D
+	rte_intr_callback_register(PCI_DEV_TO_INTR_HANDLE(pci_dev),=0D
+				   hinic3_dev_interrupt_handler, (void *)dev);=0D
+}=0D
+=0D
+#define HINIC3_RX_VEC_START RTE_INTR_VEC_RXTX_OFFSET=0D
+=0D
+/** Dp interrupt msix attribute. */=0D
+#define HINIC3_TXRX_MSIX_PENDING_LIMIT	  2=0D
+#define HINIC3_TXRX_MSIX_COALESC_TIMER	  2=0D
+#define HINIC3_TXRX_MSIX_RESEND_TIMER_CFG 7=0D
+=0D
+static int=0D
+hinic3_init_rxq_msix_attr(void *hwdev, u16 msix_index)=0D
+{=0D
+	struct interrupt_info info =3D {0};=0D
+	int err;=0D
+=0D
+	info.lli_set =3D 0;=0D
+	info.interrupt_coalesc_set =3D 1;=0D
+	info.pending_limt =3D HINIC3_TXRX_MSIX_PENDING_LIMIT;=0D
+	info.coalesc_timer_cfg =3D HINIC3_TXRX_MSIX_COALESC_TIMER;=0D
+	info.resend_timer_cfg =3D HINIC3_TXRX_MSIX_RESEND_TIMER_CFG;=0D
+=0D
+	info.msix_index =3D msix_index;=0D
+	err =3D hinic3_set_interrupt_cfg(hwdev, info);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set msix attr failed, msix_index %d",=0D
+			    msix_index);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void=0D
+hinic3_deinit_rxq_intr(struct rte_eth_dev *dev)=0D
+{=0D
+	struct rte_intr_handle *intr_handle =3D dev->intr_handle;=0D
+=0D
+	rte_intr_efd_disable(intr_handle);=0D
+	if (intr_handle->intr_vec) {=0D
+		rte_free(intr_handle->intr_vec);=0D
+		intr_handle->intr_vec =3D NULL;=0D
+	}=0D
+}=0D
+=0D
+/**=0D
+ * Initialize RX queue interrupts by enabling MSI-X, allocate interrupt ve=
ctors,=0D
+ * and configure interrupt attributes for each RX queue.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, negative error code on failure.=0D
+ * - -ENOTSUP if MSI-X interrupts are not supported.=0D
+ * - Error code if enabling event file descriptors fails.=0D
+ * - -ENOMEM if allocating interrupt vectors fails.=0D
+ */=0D
+static int=0D
+hinic3_init_rxq_intr(struct rte_eth_dev *dev)=0D
+{=0D
+	struct rte_intr_handle *intr_handle =3D NULL;=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	u32 nb_rx_queues, i;=0D
+	int err;=0D
+=0D
+	intr_handle =3D dev->intr_handle;=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
+	if (!dev->data->dev_conf.intr_conf.rxq)=0D
+		return 0;=0D
+=0D
+	if (!rte_intr_cap_multiple(intr_handle)) {=0D
+		PMD_DRV_LOG(ERR, "Rx queue interrupts require MSI-X interrupts"=0D
+				 " (vfio-pci driver)");=0D
+		return -ENOTSUP;=0D
+	}=0D
+=0D
+	nb_rx_queues =3D dev->data->nb_rx_queues;=0D
+	err =3D rte_intr_efd_enable(intr_handle, nb_rx_queues);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			"Failed to enable event fds for Rx queue interrupts");=0D
+		return err;=0D
+	}=0D
+=0D
+	intr_handle->intr_vec =3D=0D
+		rte_zmalloc("hinic_intr_vec", nb_rx_queues * sizeof(int), 0);=0D
+	if (intr_handle->intr_vec =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "Failed to allocate intr_vec");=0D
+		rte_intr_efd_disable(intr_handle);=0D
+		return -ENOMEM;=0D
+	}=0D
+	intr_handle->vec_list_size =3D nb_rx_queues;=0D
+	for (i =3D 0; i < nb_rx_queues; i++)=0D
+		intr_handle->intr_vec[i] =3D (int)(i + HINIC3_RX_VEC_START);=0D
+=0D
+	for (i =3D 0; i < dev->data->nb_rx_queues; i++) {=0D
+		rxq =3D dev->data->rx_queues[i];=0D
+		rxq->dp_intr_en =3D 1;=0D
+		rxq->msix_entry_idx =3D (u16)intr_handle->intr_vec[i];=0D
+=0D
+		err =3D hinic3_init_rxq_msix_attr(nic_dev->hwdev,=0D
+						rxq->msix_entry_idx);=0D
+		if (err) {=0D
+			hinic3_deinit_rxq_intr(dev);=0D
+			return err;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_init_sw_rxtxqs(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	u32 txq_size;=0D
+	u32 rxq_size;=0D
+=0D
+	/* Allocate software txq array. */=0D
+	txq_size =3D nic_dev->max_sqs * sizeof(*nic_dev->txqs);=0D
+	nic_dev->txqs =3D=0D
+		rte_zmalloc("hinic3_txqs", txq_size, RTE_CACHE_LINE_SIZE);=0D
+	if (!nic_dev->txqs) {=0D
+		PMD_DRV_LOG(ERR, "Allocate txqs failed");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	/* Allocate software rxq array. */=0D
+	rxq_size =3D nic_dev->max_rqs * sizeof(*nic_dev->rxqs);=0D
+	nic_dev->rxqs =3D=0D
+		rte_zmalloc("hinic3_rxqs", rxq_size, RTE_CACHE_LINE_SIZE);=0D
+	if (!nic_dev->rxqs) {=0D
+		/* Free txqs. */=0D
+		rte_free(nic_dev->txqs);=0D
+		nic_dev->txqs =3D NULL;=0D
+=0D
+		PMD_DRV_LOG(ERR, "Allocate rxqs failed");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void=0D
+hinic3_deinit_sw_rxtxqs(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	rte_free(nic_dev->txqs);=0D
+	nic_dev->txqs =3D NULL;=0D
+=0D
+	rte_free(nic_dev->rxqs);=0D
+	nic_dev->rxqs =3D NULL;=0D
+}=0D
+=0D
+static void=0D
+hinic3_disable_queue_intr(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct rte_intr_handle *intr_handle =3D dev->intr_handle;=0D
+	int msix_intr;=0D
+	int i;=0D
+=0D
+	if (intr_handle->intr_vec =3D=3D NULL)=0D
+		return;=0D
+=0D
+	for (i =3D 0; i < nic_dev->num_rqs; i++) {=0D
+		msix_intr =3D intr_handle->intr_vec[i];=0D
+		hinic3_set_msix_state(nic_dev->hwdev, (u16)msix_intr,=0D
+				      HINIC3_MSIX_DISABLE);=0D
+		hinic3_misx_intr_clear_resend_bit(nic_dev->hwdev,=0D
+						  (u16)msix_intr,=0D
+						  MSIX_RESEND_TIMER_CLEAR);=0D
+	}=0D
+}=0D
+=0D
+/**=0D
+ * Start the device.=0D
+ *=0D
+ * Initialize function table, TXQ and TXQ context, configure RX offload, a=
nd=0D
+ * enable vport and port to prepare receiving packets.=0D
+ *=0D
+ * @param[in] eth_dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_start(struct rte_eth_dev *eth_dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+	u64 nic_features;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	int i;=0D
+	int err;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
+	err =3D hinic3_copy_mempool_init(nic_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Create copy mempool failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto init_mpool_fail;=0D
+	}=0D
+	hinic3_update_msix_info(nic_dev->hwdev->hwif);=0D
+	hinic3_disable_interrupt(eth_dev);=0D
+	err =3D hinic3_init_rxq_intr(eth_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init rxq intr fail, eth_dev:%s",=0D
+			    eth_dev->data->name);=0D
+		goto init_rxq_intr_fail;=0D
+	}=0D
+=0D
+	hinic3_get_func_rx_buf_size(nic_dev);=0D
+	err =3D hinic3_init_function_table(nic_dev->hwdev, nic_dev->rx_buff_len);=
=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init function table failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto init_func_tbl_fail;=0D
+	}=0D
+=0D
+	nic_features =3D hinic3_get_driver_feature(nic_dev);=0D
+	/*=0D
+	 * You can update the features supported by the driver according to the=0D
+	 * scenario here.=0D
+	 */=0D
+	nic_features &=3D DEFAULT_DRV_FEATURE;=0D
+	hinic3_update_driver_feature(nic_dev, nic_features);=0D
+=0D
+	err =3D hinic3_set_feature_to_hw(nic_dev->hwdev, &nic_dev->feature_cap,=0D
+				       1);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Failed to set nic features to hardware, err %d",=0D
+			    err);=0D
+		goto get_feature_err;=0D
+	}=0D
+=0D
+	/* Reset rx and tx queue. */=0D
+	hinic3_reset_rx_queue(eth_dev);=0D
+	hinic3_reset_tx_queue(eth_dev);=0D
+=0D
+	/* Init txq and rxq context. */=0D
+	err =3D hinic3_init_qp_ctxts(nic_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init qp context failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto init_qp_fail;=0D
+	}=0D
+=0D
+	/* Set default mtu. */=0D
+	err =3D hinic3_set_port_mtu(nic_dev->hwdev, nic_dev->mtu_size);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set mtu_size[%d] failed, dev_name: %s",=0D
+			    nic_dev->mtu_size, eth_dev->data->name);=0D
+		goto set_mtu_fail;=0D
+	}=0D
+	eth_dev->data->mtu =3D nic_dev->mtu_size;=0D
+=0D
+	/* Set rx configuration: rss/checksum/rxmode/lro. */=0D
+	err =3D hinic3_set_rxtx_configure(eth_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set rx config failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto set_rxtx_config_fail;=0D
+	}=0D
+=0D
+	/* Enable dev interrupt. */=0D
+	hinic3_enable_interrupt(eth_dev);=0D
+	err =3D hinic3_start_all_rqs(eth_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set rx config failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto start_rqs_fail;=0D
+	}=0D
+=0D
+	hinic3_start_all_sqs(eth_dev);=0D
+=0D
+	/* Open virtual port and ready to start packet receiving. */=0D
+	err =3D hinic3_set_vport_enable(nic_dev->hwdev, true);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Enable vport failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto en_vport_fail;=0D
+	}=0D
+=0D
+	/* Open physical port and start packet receiving. */=0D
+	err =3D hinic3_set_port_enable(nic_dev->hwdev, true);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Enable physical port failed, dev_name: %s",=0D
+			    eth_dev->data->name);=0D
+		goto en_port_fail;=0D
+	}=0D
+=0D
+	/* Update eth_dev link status. */=0D
+	if (eth_dev->data->dev_conf.intr_conf.lsc !=3D 0)=0D
+		hinic3_link_update(eth_dev, 0);=0D
+=0D
+	hinic3_set_bit(HINIC3_DEV_START, &nic_dev->dev_status);=0D
+=0D
+	return 0;=0D
+=0D
+en_port_fail:=0D
+	hinic3_set_vport_enable(nic_dev->hwdev, false);=0D
+=0D
+en_vport_fail:=0D
+	/* Flush tx && rx chip resources in case of setting vport fake fail. */=0D
+	hinic3_flush_qps_res(nic_dev->hwdev);=0D
+	rte_delay_ms(DEV_START_DELAY_MS);=0D
+	for (i =3D 0; i < nic_dev->num_rqs; i++) {=0D
+		rxq =3D nic_dev->rxqs[i];=0D
+		hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);=0D
+		hinic3_free_rxq_mbufs(rxq);=0D
+		hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);=0D
+		eth_dev->data->rx_queue_state[i] =3D RTE_ETH_QUEUE_STATE_STOPPED;=0D
+		eth_dev->data->tx_queue_state[i] =3D RTE_ETH_QUEUE_STATE_STOPPED;=0D
+	}=0D
+start_rqs_fail:=0D
+	hinic3_remove_rxtx_configure(eth_dev);=0D
+=0D
+set_rxtx_config_fail:=0D
+set_mtu_fail:=0D
+	hinic3_free_qp_ctxts(nic_dev->hwdev);=0D
+=0D
+init_qp_fail:=0D
+get_feature_err:=0D
+init_func_tbl_fail:=0D
+	hinic3_deinit_rxq_intr(eth_dev);=0D
+init_rxq_intr_fail:=0D
+	hinic3_copy_mempool_uninit(nic_dev);=0D
+init_mpool_fail:=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Look up or creates a memory pool for storing packet buffers used in cop=
y=0D
+ * operations.=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * `-ENOMEM`: Memory pool creation fails.=0D
+ */=0D
+static int=0D
+hinic3_copy_mempool_init(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	nic_dev->cpy_mpool =3D rte_mempool_lookup(HINCI3_CPY_MEMPOOL_NAME);=0D
+	if (nic_dev->cpy_mpool =3D=3D NULL) {=0D
+		nic_dev->cpy_mpool =3D rte_pktmbuf_pool_create(HINCI3_CPY_MEMPOOL_NAME,=
=0D
+			HINIC3_COPY_MEMPOOL_DEPTH, HINIC3_COPY_MEMPOOL_CACHE,=0D
+			0, HINIC3_COPY_MBUF_SIZE, (int)rte_socket_id());=0D
+		if (nic_dev->cpy_mpool =3D=3D NULL) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Create copy mempool failed, errno: %d, "=0D
+				    "dev_name: %s",=0D
+				    rte_errno, HINCI3_CPY_MEMPOOL_NAME);=0D
+			return -ENOMEM;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Clear the reference to the copy memory pool without freeing it.=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
+ */=0D
+static void=0D
+hinic3_copy_mempool_uninit(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	nic_dev->cpy_mpool =3D NULL;=0D
+}=0D
+=0D
+/**=0D
+ * Stop the device.=0D
+ *=0D
+ * Stop phy port and vport, flush pending io request, clean context config=
ure=0D
+ * and free io resourece.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ */=0D
+static int=0D
+hinic3_dev_stop(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	struct rte_eth_link link;=0D
+	int err;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
+	if (!hinic3_test_and_clear_bit(HINIC3_DEV_START,=0D
+				       &nic_dev->dev_status)) {=0D
+		PMD_DRV_LOG(INFO, "Device %s already stopped",=0D
+			    nic_dev->dev_name);=0D
+		return 0;=0D
+	}=0D
+=0D
+	/* Stop phy port and vport. */=0D
+	err =3D hinic3_set_port_enable(nic_dev->hwdev, false);=0D
+	if (err)=0D
+		PMD_DRV_LOG(WARNING,=0D
+			    "Disable phy port failed, error: %d, "=0D
+			    "dev_name: %s, port_id: %d",=0D
+			    err, dev->data->name, dev->data->port_id);=0D
+=0D
+	err =3D hinic3_set_vport_enable(nic_dev->hwdev, false);=0D
+	if (err)=0D
+		PMD_DRV_LOG(WARNING,=0D
+			    "Disable vport failed, error: %d, "=0D
+			    "dev_name: %s, port_id: %d",=0D
+			    err, dev->data->name, dev->data->port_id);=0D
+=0D
+	/* Clear recorded link status. */=0D
+	memset(&link, 0, sizeof(link));=0D
+	rte_eth_linkstatus_set(dev, &link);=0D
+=0D
+	/* Disable dp interrupt. */=0D
+	hinic3_disable_queue_intr(dev);=0D
+	hinic3_deinit_rxq_intr(dev);=0D
+=0D
+	/* Flush pending io request. */=0D
+	hinic3_flush_txqs(nic_dev);=0D
+=0D
+	/* After set vport disable 100ms, no packets will be send to host. */=0D
+	rte_delay_ms(DEV_STOP_DELAY_MS);=0D
+=0D
+	hinic3_flush_qps_res(nic_dev->hwdev);=0D
+=0D
+	/* Clean RSS table and rx_mode. */=0D
+	hinic3_remove_rxtx_configure(dev);=0D
+=0D
+	/* Clean root context. */=0D
+	hinic3_free_qp_ctxts(nic_dev->hwdev);=0D
+=0D
+	/* Free all tx and rx mbufs. */=0D
+	hinic3_free_all_txq_mbufs(nic_dev);=0D
+	hinic3_free_all_rxq_mbufs(nic_dev);=0D
+=0D
+	/* Free mempool. */=0D
+	hinic3_copy_mempool_uninit(nic_dev);=0D
+	return 0;=0D
+}=0D
+=0D
+static void=0D
+hinic3_dev_release(struct rte_eth_dev *eth_dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D=0D
+		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
+	struct rte_pci_device *pci_dev =3D RTE_ETH_DEV_TO_PCI(eth_dev);=0D
+	int qid;=0D
+=0D
+	/* Release io resource. */=0D
+	for (qid =3D 0; qid < nic_dev->num_sqs; qid++)=0D
+		hinic3_tx_queue_release(eth_dev, qid);=0D
+=0D
+	for (qid =3D 0; qid < nic_dev->num_rqs; qid++)=0D
+		hinic3_rx_queue_release(eth_dev, qid);=0D
+=0D
+	hinic3_deinit_sw_rxtxqs(nic_dev);=0D
+=0D
+	hinic3_deinit_mac_addr(eth_dev);=0D
+	rte_free(nic_dev->mc_list);=0D
+=0D
+	hinic3_remove_all_vlanid(eth_dev);=0D
+=0D
+	hinic3_clear_bit(HINIC3_DEV_INTR_EN, &nic_dev->dev_status);=0D
+	hinic3_set_msix_state(nic_dev->hwdev, 0, HINIC3_MSIX_DISABLE);=0D
+	rte_intr_disable(PCI_DEV_TO_INTR_HANDLE(pci_dev));=0D
+	rte_intr_callback_unregister(PCI_DEV_TO_INTR_HANDLE(pci_dev),=0D
+					   hinic3_dev_interrupt_handler,=0D
+					   (void *)eth_dev);=0D
+=0D
+	/* Destroy rx mode mutex. */=0D
+	hinic3_mutex_destroy(&nic_dev->rx_mode_mutex);=0D
+=0D
+	hinic3_free_nic_hwdev(nic_dev->hwdev);=0D
+	hinic3_free_hwdev(nic_dev->hwdev);=0D
+=0D
+	eth_dev->rx_pkt_burst =3D NULL;=0D
+	eth_dev->tx_pkt_burst =3D NULL;=0D
+	eth_dev->dev_ops =3D NULL;=0D
+	eth_dev->rx_queue_count =3D NULL;=0D
+	eth_dev->rx_descriptor_status =3D NULL;=0D
+	eth_dev->tx_descriptor_status =3D NULL;=0D
+=0D
+	rte_free(nic_dev->hwdev);=0D
+	nic_dev->hwdev =3D NULL;=0D
+}=0D
+=0D
+/**=0D
+ * Close the device.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_close(struct rte_eth_dev *eth_dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D=0D
+		HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
+	int ret;=0D
+=0D
+	if (hinic3_test_and_set_bit(HINIC3_DEV_CLOSE, &nic_dev->dev_status)) {=0D
+		PMD_DRV_LOG(WARNING, "Device %s already closed",=0D
+			    nic_dev->dev_name);=0D
+		return 0;=0D
+	}=0D
+=0D
+	ret =3D hinic3_dev_stop(eth_dev);=0D
+=0D
+	hinic3_dev_release(eth_dev);=0D
+	return ret;=0D
+}=0D
+=0D
+static int=0D
+hinic3_dev_reset(__rte_unused struct rte_eth_dev *dev)=0D
+{=0D
+	return 0;=0D
+}=0D
+=0D
+#define MIN_RX_BUFFER_SIZE	      256=0D
+#define MIN_RX_BUFFER_SIZE_SMALL_MODE 1518=0D
+=0D
+static int=0D
+hinic3_dev_set_mtu(struct rte_eth_dev *dev, uint16_t mtu)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int err =3D 0;=0D
+=0D
+	PMD_DRV_LOG(INFO, "Set port mtu, port_id: %d, mtu: %d, max_pkt_len: %d",=
=0D
+		    dev->data->port_id, mtu, HINIC3_MTU_TO_PKTLEN(mtu));=0D
+=0D
+	if (mtu < HINIC3_MIN_MTU_SIZE || mtu > HINIC3_MAX_MTU_SIZE) {=0D
+		PMD_DRV_LOG(ERR, "Invalid mtu: %d, must between %d and %d", mtu,=0D
+			    HINIC3_MIN_MTU_SIZE, HINIC3_MAX_MTU_SIZE);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	err =3D hinic3_set_port_mtu(nic_dev->hwdev, mtu);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set port mtu failed, err: %d", err);=0D
+		return err;=0D
+	}=0D
+=0D
+	/* Update max frame size. */=0D
+	HINIC3_MAX_RX_PKT_LEN(dev->data->dev_conf.rxmode) =3D=0D
+		HINIC3_MTU_TO_PKTLEN(mtu);=0D
+	nic_dev->mtu_size =3D mtu;=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Add or delete vlan id.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] vlan_id=0D
+ * Vlan id is used to filter vlan packets.=0D
+ * @param[in] enable=0D
+ * Disable or enable vlan filter function.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int enab=
le)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int err =3D 0;=0D
+	u16 func_id;=0D
+=0D
+	if (vlan_id >=3D RTE_ETHER_MAX_VLAN_ID)=0D
+		return -EINVAL;=0D
+=0D
+	if (vlan_id =3D=3D 0)=0D
+		return 0;=0D
+=0D
+	func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+=0D
+	if (enable) {=0D
+		/* If vlanid is already set, just return. */=0D
+		if (hinic3_find_vlan_filter(nic_dev, vlan_id)) {=0D
+			PMD_DRV_LOG(INFO, "Vlan %u has been added, device: %s",=0D
+				    vlan_id, nic_dev->dev_name);=0D
+			return 0;=0D
+		}=0D
+=0D
+		err =3D hinic3_add_vlan(nic_dev->hwdev, vlan_id, func_id);=0D
+	} else {=0D
+		/* If vlanid can't be found, just return. */=0D
+		if (!hinic3_find_vlan_filter(nic_dev, vlan_id)) {=0D
+			PMD_DRV_LOG(INFO,=0D
+				    "Vlan %u is not in the vlan filter list, "=0D
+				    "device: %s",=0D
+				    vlan_id, nic_dev->dev_name);=0D
+			return 0;=0D
+		}=0D
+=0D
+		err =3D hinic3_del_vlan(nic_dev->hwdev, vlan_id, func_id);=0D
+	}=0D
+=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "%s vlan failed, func_id: %d, vlan_id: %d, err: %d",=0D
+			    enable ? "Add" : "Remove", func_id, vlan_id, err);=0D
+		return err;=0D
+	}=0D
+=0D
+	hinic3_store_vlan_filter(nic_dev, vlan_id, enable);=0D
+=0D
+	PMD_DRV_LOG(INFO, "%s vlan %u succeed, device: %s",=0D
+		    enable ? "Add" : "Remove", vlan_id, nic_dev->dev_name);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Enable or disable vlan offload.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] mask=0D
+ * Definitions used for VLAN setting, vlan filter of vlan strip.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_vlan_offload_set(struct rte_eth_dev *dev, int mask)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct rte_eth_rxmode *rxmode =3D &dev->data->dev_conf.rxmode;=0D
+	bool on;=0D
+	int err;=0D
+=0D
+	/* Enable or disable VLAN filter. */=0D
+	if (mask & RTE_ETH_VLAN_FILTER_MASK) {=0D
+		on =3D (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_FILTER)=0D
+			     ? true=0D
+			     : false;=0D
+		err =3D hinic3_set_vlan_filter(nic_dev->hwdev, on);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "%s vlan filter failed, device: %s, "=0D
+				    "port_id: %d, err: %d",=0D
+				    on ? "Enable" : "Disable",=0D
+				    nic_dev->dev_name, dev->data->port_id, err);=0D
+			return err;=0D
+		}=0D
+=0D
+		PMD_DRV_LOG(INFO,=0D
+			    "%s vlan filter succeed, device: %s, port_id: %d",=0D
+			    on ? "Enable" : "Disable", nic_dev->dev_name,=0D
+			    dev->data->port_id);=0D
+	}=0D
+=0D
+	/* Enable or disable VLAN stripping. */=0D
+	if (mask & RTE_ETH_VLAN_STRIP_MASK) {=0D
+		on =3D (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP) ? true=0D
+									: false;=0D
+		err =3D hinic3_set_rx_vlan_offload(nic_dev->hwdev, on);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "%s vlan strip failed, device: %s, "=0D
+				    "port_id: %d, err: %d",=0D
+				    on ? "Enable" : "Disable",=0D
+				    nic_dev->dev_name, dev->data->port_id, err);=0D
+			return err;=0D
+		}=0D
+=0D
+		PMD_DRV_LOG(INFO,=0D
+			    "%s vlan strip succeed, device: %s, port_id: %d",=0D
+			    on ? "Enable" : "Disable", nic_dev->dev_name,=0D
+			    dev->data->port_id);=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Enable allmulticast mode.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_allmulticast_enable(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u32 rx_mode;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_mutex_lock(&nic_dev->rx_mode_mutex);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	rx_mode =3D nic_dev->rx_mode | HINIC3_RX_MODE_MC_ALL;=0D
+=0D
+	err =3D hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);=0D
+	if (err) {=0D
+		hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);=0D
+		PMD_DRV_LOG(ERR, "Enable allmulticast failed, error: %d", err);=0D
+		return err;=0D
+	}=0D
+=0D
+	nic_dev->rx_mode =3D rx_mode;=0D
+=0D
+	hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "Enable allmulticast succeed, nic_dev: %s, port_id: %d",=0D
+		    nic_dev->dev_name, dev->data->port_id);=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Disable allmulticast mode.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_allmulticast_disable(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u32 rx_mode;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_mutex_lock(&nic_dev->rx_mode_mutex);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	rx_mode =3D nic_dev->rx_mode & (~HINIC3_RX_MODE_MC_ALL);=0D
+=0D
+	err =3D hinic3_set_rx_mode(nic_dev->hwdev, rx_mode);=0D
+	if (err) {=0D
+		hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);=0D
+		PMD_DRV_LOG(ERR, "Disable allmulticast failed, error: %d", err);=0D
+		return err;=0D
+	}=0D
+=0D
+	nic_dev->rx_mode =3D rx_mode;=0D
+=0D
+	hinic3_mutex_unlock(&nic_dev->rx_mode_mutex);=0D
+=0D
+	PMD_DRV_LOG(INFO,=0D
+		    "Disable allmulticast succeed, nic_dev: %s, port_id: %d",=0D
+		    nic_dev->dev_name, dev->data->port_id);=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Get device generic statistics.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[out] stats=0D
+ * Stats structure output buffer.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats)=
=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct hinic3_vport_stats vport_stats;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+	int i, err, q_num;=0D
+	u64 rx_discards_pmd =3D 0;=0D
+=0D
+	err =3D hinic3_get_vport_stats(nic_dev->hwdev, &vport_stats);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Get vport stats from fw failed, nic_dev: %s",=0D
+			    nic_dev->dev_name);=0D
+		return err;=0D
+	}=0D
+=0D
+	dev->data->rx_mbuf_alloc_failed =3D 0;=0D
+=0D
+	/* Rx queue stats. */=0D
+	q_num =3D (nic_dev->num_rqs < RTE_ETHDEV_QUEUE_STAT_CNTRS)=0D
+			? nic_dev->num_rqs=0D
+			: RTE_ETHDEV_QUEUE_STAT_CNTRS;=0D
+	for (i =3D 0; i < q_num; i++) {=0D
+		rxq =3D nic_dev->rxqs[i];=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+		rxq->rxq_stats.rx_left_mbuf_bytes =3D=0D
+			rxq->rxq_stats.rx_alloc_mbuf_bytes -=0D
+			rxq->rxq_stats.rx_free_mbuf_bytes;=0D
+#endif=0D
+		rxq->rxq_stats.errors =3D rxq->rxq_stats.csum_errors +=0D
+					rxq->rxq_stats.other_errors;=0D
+=0D
+		stats->q_ipackets[i] =3D rxq->rxq_stats.packets;=0D
+		stats->q_ibytes[i] =3D rxq->rxq_stats.bytes;=0D
+		stats->q_errors[i] =3D rxq->rxq_stats.errors;=0D
+=0D
+		stats->ierrors +=3D rxq->rxq_stats.errors;=0D
+		rx_discards_pmd +=3D rxq->rxq_stats.dropped;=0D
+		dev->data->rx_mbuf_alloc_failed +=3D rxq->rxq_stats.rx_nombuf;=0D
+	}=0D
+=0D
+	/* Tx queue stats. */=0D
+	q_num =3D (nic_dev->num_sqs < RTE_ETHDEV_QUEUE_STAT_CNTRS)=0D
+			? nic_dev->num_sqs=0D
+			: RTE_ETHDEV_QUEUE_STAT_CNTRS;=0D
+	for (i =3D 0; i < q_num; i++) {=0D
+		txq =3D nic_dev->txqs[i];=0D
+		stats->q_opackets[i] =3D txq->txq_stats.packets;=0D
+		stats->q_obytes[i] =3D txq->txq_stats.bytes;=0D
+		stats->oerrors +=3D (txq->txq_stats.tx_busy +=0D
+				   txq->txq_stats.offload_errors);=0D
+	}=0D
+=0D
+	/* Vport stats. */=0D
+	stats->oerrors +=3D vport_stats.tx_discard_vport;=0D
+=0D
+	stats->imissed =3D vport_stats.rx_discard_vport + rx_discards_pmd;=0D
+=0D
+	stats->ipackets =3D=0D
+		(vport_stats.rx_unicast_pkts_vport +=0D
+		 vport_stats.rx_multicast_pkts_vport +=0D
+		 vport_stats.rx_broadcast_pkts_vport - rx_discards_pmd);=0D
+=0D
+	stats->opackets =3D (vport_stats.tx_unicast_pkts_vport +=0D
+			   vport_stats.tx_multicast_pkts_vport +=0D
+			   vport_stats.tx_broadcast_pkts_vport);=0D
+=0D
+	stats->ibytes =3D (vport_stats.rx_unicast_bytes_vport +=0D
+			 vport_stats.rx_multicast_bytes_vport +=0D
+			 vport_stats.rx_broadcast_bytes_vport);=0D
+=0D
+	stats->obytes =3D (vport_stats.tx_unicast_bytes_vport +=0D
+			 vport_stats.tx_multicast_bytes_vport +=0D
+			 vport_stats.tx_broadcast_bytes_vport);=0D
+	return 0;=0D
+}=0D
+=0D
 /**=0D
- * Interrupt handler triggered by NIC for handling specific event.=0D
+ * Clear device generic statistics.=0D
  *=0D
- * @param[in] param=0D
- * The address of parameter (struct rte_eth_dev *) registered before.=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_stats_reset(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+	int qid;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_clear_vport_stats(nic_dev->hwdev);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	for (qid =3D 0; qid < nic_dev->num_rqs; qid++) {=0D
+		rxq =3D nic_dev->rxqs[qid];=0D
+		memset(&rxq->rxq_stats, 0, sizeof(struct hinic3_rxq_stats));=0D
+	}=0D
+=0D
+	for (qid =3D 0; qid < nic_dev->num_sqs; qid++) {=0D
+		txq =3D nic_dev->txqs[qid];=0D
+		memset(&txq->txq_stats, 0, sizeof(struct hinic3_txq_stats));=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Get device extended statistics.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[out] xstats=0D
+ * Pointer to rte extended stats table.=0D
+ * @param[in] n=0D
+ * The size of the stats table.=0D
+ *=0D
+ * @return=0D
+ * positive: Number of extended stats on success and stats is filled.=0D
+ * negative: Failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstat=
s,=0D
+		      unsigned int n)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	struct mag_phy_port_stats port_stats;=0D
+	struct hinic3_vport_stats vport_stats;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	struct hinic3_rxq_stats rxq_stats;=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+	struct hinic3_txq_stats txq_stats;=0D
+	u16 qid;=0D
+	u32 i;=0D
+	int err, count;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);=0D
+	count =3D hinic3_xstats_calc_num(nic_dev);=0D
+	if ((int)n < count)=0D
+		return count;=0D
+=0D
+	count =3D 0;=0D
+=0D
+	/* Get stats from rxq stats structure. */=0D
+	for (qid =3D 0; qid < nic_dev->num_rqs; qid++) {=0D
+		rxq =3D nic_dev->rxqs[qid];=0D
+=0D
+#ifdef HINIC3_XSTAT_RXBUF_INFO=0D
+		hinic3_get_stats(rxq);=0D
+#endif=0D
+=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+		rxq->rxq_stats.rx_left_mbuf_bytes =3D=0D
+			rxq->rxq_stats.rx_alloc_mbuf_bytes -=0D
+			rxq->rxq_stats.rx_free_mbuf_bytes;=0D
+#endif=0D
+		rxq->rxq_stats.errors =3D rxq->rxq_stats.csum_errors +=0D
+					rxq->rxq_stats.other_errors;=0D
+=0D
+		memcpy((void *)&rxq_stats, (void *)&rxq->rxq_stats,=0D
+		       sizeof(rxq->rxq_stats));=0D
+=0D
+		for (i =3D 0; i < HINIC3_RXQ_XSTATS_NUM; i++) {=0D
+			xstats[count].value =3D *(uint64_t *)(((char *)&rxq_stats) +=0D
+					    hinic3_rxq_stats_strings[i].offset);=0D
+			xstats[count].id =3D count;=0D
+			count++;=0D
+		}=0D
+	}=0D
+=0D
+	/* Get stats from txq stats structure. */=0D
+	for (qid =3D 0; qid < nic_dev->num_sqs; qid++) {=0D
+		txq =3D nic_dev->txqs[qid];=0D
+		memcpy((void *)&txq_stats, (void *)&txq->txq_stats,=0D
+		       sizeof(txq->txq_stats));=0D
+=0D
+		for (i =3D 0; i < HINIC3_TXQ_XSTATS_NUM; i++) {=0D
+			xstats[count].value =3D *(uint64_t *)(((char *)&txq_stats) +=0D
+					    hinic3_txq_stats_strings[i].offset);=0D
+			xstats[count].id =3D count;=0D
+			count++;=0D
+		}=0D
+	}=0D
+=0D
+	/* Get stats from vport stats structure. */=0D
+	err =3D hinic3_get_vport_stats(nic_dev->hwdev, &vport_stats);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	for (i =3D 0; i < HINIC3_VPORT_XSTATS_NUM; i++) {=0D
+		xstats[count].value =3D=0D
+			*(uint64_t *)(((char *)&vport_stats) +=0D
+				      hinic3_vport_stats_strings[i].offset);=0D
+		xstats[count].id =3D count;=0D
+		count++;=0D
+	}=0D
+=0D
+	if (HINIC3_IS_VF(nic_dev->hwdev))=0D
+		return count;=0D
+=0D
+	/* Get stats from phy port stats structure. */=0D
+	err =3D hinic3_get_phy_port_stats(nic_dev->hwdev, &port_stats);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	for (i =3D 0; i < HINIC3_PHYPORT_XSTATS_NUM; i++) {=0D
+		xstats[count].value =3D=0D
+			*(uint64_t *)(((char *)&port_stats) +=0D
+				      hinic3_phyport_stats_strings[i].offset);=0D
+		xstats[count].id =3D count;=0D
+		count++;=0D
+	}=0D
+=0D
+	return count;=0D
+}=0D
+=0D
+/**=0D
+ * Clear device extended statistics.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_dev_xstats_reset(struct rte_eth_dev *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_dev_stats_reset(dev);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	if (hinic3_func_type(nic_dev->hwdev) !=3D TYPE_VF) {=0D
+		err =3D hinic3_clear_phy_port_stats(nic_dev->hwdev);=0D
+		if (err)=0D
+			return err;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Retrieve names of extended device statistics.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[out] xstats_names=0D
+ * Buffer to insert names into.=0D
+ *=0D
+ * @return=0D
+ * Number of xstats names.=0D
+ */=0D
+static int=0D
+hinic3_dev_xstats_get_names(struct rte_eth_dev *dev,=0D
+			    struct rte_eth_xstat_name *xstats_names,=0D
+			    __rte_unused unsigned int limit)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	int count =3D 0;=0D
+	u16 i, q_num;=0D
+=0D
+	if (xstats_names =3D=3D NULL)=0D
+		return hinic3_xstats_calc_num(nic_dev);=0D
+=0D
+	/* Get pmd rxq stats name. */=0D
+	for (q_num =3D 0; q_num < nic_dev->num_rqs; q_num++) {=0D
+		for (i =3D 0; i < HINIC3_RXQ_XSTATS_NUM; i++) {=0D
+			snprintf(xstats_names[count].name,=0D
+				 sizeof(xstats_names[count].name),=0D
+				 "rxq%d_%s_pmd", q_num,=0D
+				 hinic3_rxq_stats_strings[i].name);=0D
+			count++;=0D
+		}=0D
+	}=0D
+=0D
+	/* Get pmd txq stats name. */=0D
+	for (q_num =3D 0; q_num < nic_dev->num_sqs; q_num++) {=0D
+		for (i =3D 0; i < HINIC3_TXQ_XSTATS_NUM; i++) {=0D
+			snprintf(xstats_names[count].name,=0D
+				 sizeof(xstats_names[count].name),=0D
+				 "txq%d_%s_pmd", q_num,=0D
+				 hinic3_txq_stats_strings[i].name);=0D
+			count++;=0D
+		}=0D
+	}=0D
+=0D
+	/* Get vport stats name. */=0D
+	for (i =3D 0; i < HINIC3_VPORT_XSTATS_NUM; i++) {=0D
+		snprintf(xstats_names[count].name,=0D
+			 sizeof(xstats_names[count].name), "%s",=0D
+			 hinic3_vport_stats_strings[i].name);=0D
+		count++;=0D
+	}=0D
+=0D
+	if (HINIC3_IS_VF(nic_dev->hwdev))=0D
+		return count;=0D
+=0D
+	/* Get phy port stats name. */=0D
+	for (i =3D 0; i < HINIC3_PHYPORT_XSTATS_NUM; i++) {=0D
+		snprintf(xstats_names[count].name,=0D
+			 sizeof(xstats_names[count].name), "%s",=0D
+			 hinic3_phyport_stats_strings[i].name);=0D
+		count++;=0D
+	}=0D
+=0D
+	return count;=0D
+}=0D
+=0D
+/**=0D
+ * Function used to get supported ptypes of an Ethernet device.=0D
+ *=0D
+ * @param[in] dev=0D
+ * ethdev handle of port.=0D
+ * @param[out] no_of_elements=0D
+ * number of ptypes elements. Must be initialized to 0.=0D
+ *=0D
+ * @return=0D
+ * Success, array of ptypes elements and valid no_of_elements > 0.=0D
+ * Failures, NULL.=0D
  */=0D
+static const uint32_t *=0D
+hinic3_dev_supported_ptypes_get(__rte_unused struct rte_eth_dev *dev,=0D
+				__rte_unused size_t *no_of_elements)=0D
+{=0D
+	return 0;=0D
+}=0D
+=0D
 static void=0D
-hinic3_dev_interrupt_handler(void *param)=0D
+hinic3_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,=0D
+		    struct rte_eth_rxq_info *rxq_info)=0D
+{=0D
+	struct hinic3_rxq *rxq =3D dev->data->rx_queues[queue_id];=0D
+=0D
+	rxq_info->mp =3D rxq->mb_pool;=0D
+	rxq_info->nb_desc =3D rxq->q_depth;=0D
+}=0D
+=0D
+static void=0D
+hinic3_txq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,=0D
+		    struct rte_eth_txq_info *txq_qinfo)=0D
+{=0D
+	struct hinic3_txq *txq =3D dev->data->tx_queues[queue_id];=0D
+=0D
+	txq_qinfo->nb_desc =3D txq->q_depth;=0D
+}=0D
+=0D
+/**=0D
+ * Update MAC address.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] addr=0D
+ * Pointer to MAC address.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_set_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)=
=0D
 {=0D
-	struct rte_eth_dev *dev =3D param;=0D
 	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	char mac_addr[RTE_ETHER_ADDR_FMT_SIZE];=0D
+	u16 func_id;=0D
+	int err;=0D
 =0D
-	if (!hinic3_get_bit(HINIC3_DEV_INTR_EN, &nic_dev->dev_status)) {=0D
-		PMD_DRV_LOG(WARNING,=0D
-			    "Intr is disabled, ignore intr event, "=0D
-			    "dev_name: %s, port_id: %d",=0D
-			    nic_dev->dev_name, dev->data->port_id);=0D
+	if (!rte_is_valid_assigned_ether_addr(addr)) {=0D
+		rte_ether_format_addr(mac_addr, RTE_ETHER_ADDR_FMT_SIZE, addr);=0D
+		PMD_DRV_LOG(ERR, "Set invalid MAC address %s", mac_addr);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+	err =3D hinic3_update_mac(nic_dev->hwdev,=0D
+				nic_dev->default_addr.addr_bytes,=0D
+				addr->addr_bytes, 0, func_id);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	rte_ether_addr_copy(addr, &nic_dev->default_addr);=0D
+	rte_ether_format_addr(mac_addr, RTE_ETHER_ADDR_FMT_SIZE,=0D
+			      &nic_dev->default_addr);=0D
+=0D
+	PMD_DRV_LOG(INFO, "Set new MAC address %s", mac_addr);=0D
+	return 0;=0D
+}=0D
+=0D
+/**=0D
+ * Remove a MAC address.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] index=0D
+ * MAC address index.=0D
+ */=0D
+static void=0D
+hinic3_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u16 func_id;=0D
+	int err;=0D
+=0D
+	if (index >=3D HINIC3_MAX_UC_MAC_ADDRS) {=0D
+		PMD_DRV_LOG(INFO, "Remove MAC index(%u) is out of range",=0D
+			    index);=0D
 		return;=0D
 	}=0D
 =0D
-	/* Aeq0 msg handler. */=0D
-	hinic3_dev_handle_aeq_event(nic_dev->hwdev, param);=0D
+	func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+	err =3D hinic3_del_mac(nic_dev->hwdev,=0D
+			     dev->data->mac_addrs[index].addr_bytes, 0,=0D
+			     func_id);=0D
+	if (err)=0D
+		PMD_DRV_LOG(ERR, "Remove MAC index(%u) failed", index);=0D
+}=0D
+=0D
+/**=0D
+ * Add a MAC address.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] mac_addr=0D
+ * MAC address to register.=0D
+ * @param[in] index=0D
+ * MAC address index.=0D
+ * @param[in] vmdq=0D
+ * VMDq pool index to associate address with (unused_).=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac_ad=
dr,=0D
+		    uint32_t index, __rte_unused uint32_t vmdq)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	unsigned int i;=0D
+	u16 func_id;=0D
+	int err;=0D
+=0D
+	if (!rte_is_valid_assigned_ether_addr(mac_addr)) {=0D
+		PMD_DRV_LOG(ERR, "Add invalid MAC address");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	if (index >=3D HINIC3_MAX_UC_MAC_ADDRS) {=0D
+		PMD_DRV_LOG(ERR, "Add MAC index(%u) is out of range", index);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	/* Make sure this address doesn't already be configured. */=0D
+	for (i =3D 0; i < HINIC3_MAX_UC_MAC_ADDRS; i++) {=0D
+		if (rte_is_same_ether_addr(mac_addr,=0D
+					   &dev->data->mac_addrs[i])) {=0D
+			PMD_DRV_LOG(ERR, "MAC address is already configured");=0D
+			return -EADDRINUSE;=0D
+		}=0D
+	}=0D
+=0D
+	func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+	err =3D hinic3_set_mac(nic_dev->hwdev, mac_addr->addr_bytes, 0, func_id);=
=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	return 0;=0D
 }=0D
 =0D
+/**=0D
+ * Delete all multicast MAC addresses from the NIC device.=0D
+ *=0D
+ * This function iterates over the list of multicast MAC addresses and rem=
oves=0D
+ * each address from the NIC device by calling `hinic3_del_mac`. After eac=
h=0D
+ * deletion, the address is reset to zero.=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
+ */=0D
 static void=0D
-hinic3_deinit_sw_rxtxqs(struct hinic3_nic_dev *nic_dev)=0D
+hinic3_delete_mc_addr_list(struct hinic3_nic_dev *nic_dev)=0D
 {=0D
-	rte_free(nic_dev->txqs);=0D
-	nic_dev->txqs =3D NULL;=0D
+	u16 func_id;=0D
+	u32 i;=0D
 =0D
-	rte_free(nic_dev->rxqs);=0D
-	nic_dev->rxqs =3D NULL;=0D
+	func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+=0D
+	for (i =3D 0; i < HINIC3_MAX_MC_MAC_ADDRS; i++) {=0D
+		if (rte_is_zero_ether_addr(&nic_dev->mc_list[i]))=0D
+			break;=0D
+=0D
+		hinic3_del_mac(nic_dev->hwdev, nic_dev->mc_list[i].addr_bytes,=0D
+			       0, func_id);=0D
+		memset(&nic_dev->mc_list[i], 0, sizeof(struct rte_ether_addr));=0D
+	}=0D
+}=0D
+=0D
+/**=0D
+ * Set multicast MAC address.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[in] mc_addr_set=0D
+ * Pointer to multicast MAC address.=0D
+ * @param[in] nb_mc_addr=0D
+ * The number of multicast MAC address to set.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_set_mc_addr_list(struct rte_eth_dev *dev,=0D
+			struct rte_ether_addr *mc_addr_set, uint32_t nb_mc_addr)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	char mac_addr[RTE_ETHER_ADDR_FMT_SIZE];=0D
+	u16 func_id;=0D
+	int err;=0D
+	u32 i;=0D
+=0D
+	func_id =3D hinic3_global_func_id(nic_dev->hwdev);=0D
+=0D
+	/* Delete old multi_cast addrs firstly. */=0D
+	hinic3_delete_mc_addr_list(nic_dev);=0D
+=0D
+	if (nb_mc_addr > HINIC3_MAX_MC_MAC_ADDRS)=0D
+		return -EINVAL;=0D
+=0D
+	for (i =3D 0; i < nb_mc_addr; i++) {=0D
+		if (!rte_is_multicast_ether_addr(&mc_addr_set[i])) {=0D
+			rte_ether_format_addr(mac_addr, RTE_ETHER_ADDR_FMT_SIZE,=0D
+					      &mc_addr_set[i]);=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Set mc MAC addr failed, addr(%s) invalid",=0D
+				    mac_addr);=0D
+			return -EINVAL;=0D
+		}=0D
+	}=0D
+=0D
+	for (i =3D 0; i < nb_mc_addr; i++) {=0D
+		err =3D hinic3_set_mac(nic_dev->hwdev, mc_addr_set[i].addr_bytes,=0D
+				     0, func_id);=0D
+		if (err) {=0D
+			hinic3_delete_mc_addr_list(nic_dev);=0D
+			return err;=0D
+		}=0D
+=0D
+		rte_ether_addr_copy(&mc_addr_set[i], &nic_dev->mc_list[i]);=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_get_reg(__rte_unused struct rte_eth_dev *dev,=0D
+	       __rte_unused struct rte_dev_reg_info *regs)=0D
+{=0D
+	return 0;=0D
 }=0D
 =0D
+static const struct eth_dev_ops hinic3_pmd_ops =3D {=0D
+	.dev_configure                 =3D hinic3_dev_configure,=0D
+	.dev_infos_get                 =3D hinic3_dev_infos_get,=0D
+	.fw_version_get                =3D hinic3_fw_version_get,=0D
+	.dev_set_link_up               =3D hinic3_dev_set_link_up,=0D
+	.dev_set_link_down             =3D hinic3_dev_set_link_down,=0D
+	.link_update                   =3D hinic3_link_update,=0D
+	.rx_queue_setup                =3D hinic3_rx_queue_setup,=0D
+	.tx_queue_setup                =3D hinic3_tx_queue_setup,=0D
+	.rx_queue_release              =3D hinic3_rx_queue_release,=0D
+	.tx_queue_release              =3D hinic3_tx_queue_release,=0D
+	.rx_queue_start                =3D hinic3_dev_rx_queue_start,=0D
+	.rx_queue_stop                 =3D hinic3_dev_rx_queue_stop,=0D
+	.tx_queue_start                =3D hinic3_dev_tx_queue_start,=0D
+	.tx_queue_stop                 =3D hinic3_dev_tx_queue_stop,=0D
+	.rx_queue_intr_enable          =3D hinic3_dev_rx_queue_intr_enable,=0D
+	.rx_queue_intr_disable         =3D hinic3_dev_rx_queue_intr_disable,=0D
+	.dev_start                     =3D hinic3_dev_start,=0D
+	.dev_stop                      =3D hinic3_dev_stop,=0D
+	.dev_close                     =3D hinic3_dev_close,=0D
+	.dev_reset                     =3D hinic3_dev_reset,=0D
+	.mtu_set                       =3D hinic3_dev_set_mtu,=0D
+	.vlan_filter_set               =3D hinic3_vlan_filter_set,=0D
+	.vlan_offload_set              =3D hinic3_vlan_offload_set,=0D
+	.allmulticast_enable           =3D hinic3_dev_allmulticast_enable,=0D
+	.allmulticast_disable          =3D hinic3_dev_allmulticast_disable,=0D
+	.stats_get                     =3D hinic3_dev_stats_get,=0D
+	.stats_reset                   =3D hinic3_dev_stats_reset,=0D
+	.xstats_get                    =3D hinic3_dev_xstats_get,=0D
+	.xstats_reset                  =3D hinic3_dev_xstats_reset,=0D
+	.xstats_get_names              =3D hinic3_dev_xstats_get_names,=0D
+	.dev_supported_ptypes_get      =3D hinic3_dev_supported_ptypes_get,=0D
+	.rxq_info_get                  =3D hinic3_rxq_info_get,=0D
+	.txq_info_get                  =3D hinic3_txq_info_get,=0D
+	.mac_addr_set                  =3D hinic3_set_mac_addr,=0D
+	.mac_addr_remove               =3D hinic3_mac_addr_remove,=0D
+	.mac_addr_add                  =3D hinic3_mac_addr_add,=0D
+	.set_mc_addr_list              =3D hinic3_set_mc_addr_list,=0D
+	.get_reg                       =3D hinic3_get_reg,=0D
+};=0D
+=0D
+static const struct eth_dev_ops hinic3_pmd_vf_ops =3D {=0D
+	.dev_configure                 =3D hinic3_dev_configure,=0D
+	.dev_infos_get                 =3D hinic3_dev_infos_get,=0D
+	.fw_version_get                =3D hinic3_fw_version_get,=0D
+	.rx_queue_setup                =3D hinic3_rx_queue_setup,=0D
+	.tx_queue_setup                =3D hinic3_tx_queue_setup,=0D
+	.rx_queue_intr_enable          =3D hinic3_dev_rx_queue_intr_enable,=0D
+	.rx_queue_intr_disable         =3D hinic3_dev_rx_queue_intr_disable,=0D
+=0D
+	.rx_queue_start                =3D hinic3_dev_rx_queue_start,=0D
+	.rx_queue_stop                 =3D hinic3_dev_rx_queue_stop,=0D
+	.tx_queue_start                =3D hinic3_dev_tx_queue_start,=0D
+	.tx_queue_stop                 =3D hinic3_dev_tx_queue_stop,=0D
+=0D
+	.dev_start                     =3D hinic3_dev_start,=0D
+	.link_update                   =3D hinic3_link_update,=0D
+	.rx_queue_release              =3D hinic3_rx_queue_release,=0D
+	.tx_queue_release              =3D hinic3_tx_queue_release,=0D
+	.dev_stop                      =3D hinic3_dev_stop,=0D
+	.dev_close                     =3D hinic3_dev_close,=0D
+	.mtu_set                       =3D hinic3_dev_set_mtu,=0D
+	.vlan_filter_set               =3D hinic3_vlan_filter_set,=0D
+	.vlan_offload_set              =3D hinic3_vlan_offload_set,=0D
+	.allmulticast_enable           =3D hinic3_dev_allmulticast_enable,=0D
+	.allmulticast_disable          =3D hinic3_dev_allmulticast_disable,=0D
+	.stats_get                     =3D hinic3_dev_stats_get,=0D
+	.stats_reset                   =3D hinic3_dev_stats_reset,=0D
+	.xstats_get                    =3D hinic3_dev_xstats_get,=0D
+	.xstats_reset                  =3D hinic3_dev_xstats_reset,=0D
+	.xstats_get_names              =3D hinic3_dev_xstats_get_names,=0D
+	.rxq_info_get                  =3D hinic3_rxq_info_get,=0D
+	.txq_info_get                  =3D hinic3_txq_info_get,=0D
+	.mac_addr_set                  =3D hinic3_set_mac_addr,=0D
+	.mac_addr_remove               =3D hinic3_mac_addr_remove,=0D
+	.mac_addr_add                  =3D hinic3_mac_addr_add,=0D
+	.set_mc_addr_list              =3D hinic3_set_mc_addr_list,=0D
+};=0D
+=0D
 /**=0D
  * Init mac_vlan table in hardwares.=0D
  *=0D
@@ -319,6 +3194,15 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 	nic_dev->max_sqs =3D hinic3_func_max_sqs(nic_dev->hwdev);=0D
 	nic_dev->max_rqs =3D hinic3_func_max_rqs(nic_dev->hwdev);=0D
 =0D
+	if (HINIC3_FUNC_TYPE(nic_dev->hwdev) =3D=3D TYPE_VF)=0D
+		eth_dev->dev_ops =3D &hinic3_pmd_vf_ops;=0D
+	else=0D
+		eth_dev->dev_ops =3D &hinic3_pmd_ops;=0D
+=0D
+	eth_dev->rx_queue_count =3D hinic3_dev_rx_queue_count;=0D
+	eth_dev->rx_descriptor_status =3D hinic3_dev_rx_descriptor_status;=0D
+	eth_dev->tx_descriptor_status =3D hinic3_dev_tx_descriptor_status;=0D
+=0D
 	err =3D hinic3_init_nic_hwdev(nic_dev->hwdev);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Init nic hwdev failed, dev_name: %s",=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3=
_nic_io.c=0D
new file mode 100644=0D
index 0000000000..2d5a60efe5=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.c=0D
@@ -0,0 +1,828 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_atomic.h>=0D
+#include <rte_bus_pci.h>=0D
+#include <rte_config.h>=0D
+#include <rte_errno.h>=0D
+#include <rte_ether.h>=0D
+#include <rte_io.h>=0D
+#include <rte_malloc.h>=0D
+#include <rte_mbuf.h>=0D
+#include <rte_mempool.h>=0D
+#include <rte_pci.h>=0D
+=0D
+#include "base/hinic3_compat.h"=0D
+#include "base/hinic3_cmd.h"=0D
+#include "base/hinic3_cmdq.h"=0D
+#include "base/hinic3_hw_comm.h"=0D
+#include "base/hinic3_nic_cfg.h"=0D
+#include "hinic3_ethdev.h"=0D
+#include "hinic3_nic_io.h"=0D
+#include "hinic3_rx.h"=0D
+#include "hinic3_tx.h"=0D
+=0D
+#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT   3=0D
+#define HINIC3_DEAULT_TX_CI_COALESCING_TIME 16=0D
+#define HINIC3_DEAULT_DROP_THD_ON	    0xFFFF=0D
+#define HINIC3_DEAULT_DROP_THD_OFF	    0=0D
+=0D
+#define WQ_PREFETCH_MAX	      6=0D
+#define WQ_PREFETCH_MIN	      1=0D
+#define WQ_PREFETCH_THRESHOLD 256=0D
+=0D
+#define HINIC3_Q_CTXT_MAX \=0D
+	((u16)(((HINIC3_CMDQ_BUF_SIZE - 8) - RTE_PKTMBUF_HEADROOM) / 64))=0D
+=0D
+enum hinic3_qp_ctxt_type {=0D
+	HINIC3_QP_CTXT_TYPE_SQ,=0D
+	HINIC3_QP_CTXT_TYPE_RQ,=0D
+};=0D
+=0D
+struct hinic3_qp_ctxt_header {=0D
+	u16 num_queues;=0D
+	u16 queue_type;=0D
+	u16 start_qid;=0D
+	u16 rsvd;=0D
+};=0D
+=0D
+struct hinic3_sq_ctxt {=0D
+	u32 ci_pi;=0D
+	u32 drop_mode_sp;    /**< Packet drop mode and special flags. */=0D
+	u32 wq_pfn_hi_owner; /**< High PFN and ownership flag. */=0D
+	u32 wq_pfn_lo;	     /**< Low bits of work queue PFN. */=0D
+=0D
+	u32 rsvd0;	  /**< Reserved field 0. */=0D
+	u32 pkt_drop_thd; /**< Packet drop threshold. */=0D
+	u32 global_sq_id;=0D
+	u32 vlan_ceq_attr; /**< VLAN and CEQ attributes. */=0D
+=0D
+	u32 pref_cache;	       /**< Cache prefetch settings for the queue. */=0D
+	u32 pref_ci_owner;     /**< Prefetch settings for CI and ownership. */=0D
+	u32 pref_wq_pfn_hi_ci; /**< Prefetch settings for high PFN and CI. */=0D
+	u32 pref_wq_pfn_lo;    /**< Prefetch settings for low PFN. */=0D
+=0D
+	u32 rsvd8;	     /**< Reserved field 8. */=0D
+	u32 rsvd9;	     /**< Reserved field 9. */=0D
+	u32 wq_block_pfn_hi; /**< High bits of work queue block PFN. */=0D
+	u32 wq_block_pfn_lo; /**< Low bits of work queue block PFN. */=0D
+};=0D
+=0D
+struct hinic3_rq_ctxt {=0D
+	u32 ci_pi;=0D
+	u32 ceq_attr;		  /**< Completion event queue attributes. */=0D
+	u32 wq_pfn_hi_type_owner; /**< High PFN, WQE type and ownership flag. */=
=0D
+	u32 wq_pfn_lo;		  /**< Low bits of work queue PFN. */=0D
+=0D
+	u32 rsvd[3];	 /**< Reserved field. */=0D
+	u32 cqe_sge_len; /**< CQE scatter/gather element length. */=0D
+=0D
+	u32 pref_cache;	       /**< Cache prefetch settings for the queue. */=0D
+	u32 pref_ci_owner;     /**< Prefetch settings for CI and ownership. */=0D
+	u32 pref_wq_pfn_hi_ci; /**< Prefetch settings for high PFN and CI. */=0D
+	u32 pref_wq_pfn_lo;    /**< Prefetch settings for low PFN. */=0D
+=0D
+	u32 pi_paddr_hi;     /**< High 32-bits of PI DMA address. */=0D
+	u32 pi_paddr_lo;     /**< Low 32-bits of PI DMA address. */=0D
+	u32 wq_block_pfn_hi; /**< High bits of work queue block PFN. */=0D
+	u32 wq_block_pfn_lo; /**< Low bits of work queue block PFN. */=0D
+};=0D
+=0D
+struct hinic3_sq_ctxt_block {=0D
+	struct hinic3_qp_ctxt_header cmdq_hdr;=0D
+	struct hinic3_sq_ctxt sq_ctxt[HINIC3_Q_CTXT_MAX];=0D
+};=0D
+=0D
+struct hinic3_rq_ctxt_block {=0D
+	struct hinic3_qp_ctxt_header cmdq_hdr;=0D
+	struct hinic3_rq_ctxt rq_ctxt[HINIC3_Q_CTXT_MAX];=0D
+};=0D
+=0D
+struct hinic3_clean_queue_ctxt {=0D
+	struct hinic3_qp_ctxt_header cmdq_hdr;=0D
+	u32 rsvd;=0D
+};=0D
+=0D
+#define SQ_CTXT_SIZE(num_sqs)                         \=0D
+	((u16)(sizeof(struct hinic3_qp_ctxt_header) + \=0D
+	       (num_sqs) * sizeof(struct hinic3_sq_ctxt)))=0D
+=0D
+#define RQ_CTXT_SIZE(num_rqs)                         \=0D
+	((u16)(sizeof(struct hinic3_qp_ctxt_header) + \=0D
+	       (num_rqs) * sizeof(struct hinic3_rq_ctxt)))=0D
+=0D
+#define CI_IDX_HIGH_SHIFH 12=0D
+=0D
+#define CI_HIGN_IDX(val) ((val) >> CI_IDX_HIGH_SHIFH)=0D
+=0D
+#define SQ_CTXT_PI_IDX_SHIFT 0=0D
+#define SQ_CTXT_CI_IDX_SHIFT 16=0D
+=0D
+#define SQ_CTXT_PI_IDX_MASK 0xFFFFU=0D
+#define SQ_CTXT_CI_IDX_MASK 0xFFFFU=0D
+=0D
+#define SQ_CTXT_CI_PI_SET(val, member) \=0D
+	(((val) & SQ_CTXT_##member##_MASK) << SQ_CTXT_##member##_SHIFT)=0D
+=0D
+#define SQ_CTXT_MODE_SP_FLAG_SHIFT  0=0D
+#define SQ_CTXT_MODE_PKT_DROP_SHIFT 1=0D
+=0D
+#define SQ_CTXT_MODE_SP_FLAG_MASK  0x1U=0D
+#define SQ_CTXT_MODE_PKT_DROP_MASK 0x1U=0D
+=0D
+#define SQ_CTXT_MODE_SET(val, member)           \=0D
+	(((val) & SQ_CTXT_MODE_##member##_MASK) \=0D
+	 << SQ_CTXT_MODE_##member##_SHIFT)=0D
+=0D
+#define SQ_CTXT_WQ_PAGE_HI_PFN_SHIFT 0=0D
+#define SQ_CTXT_WQ_PAGE_OWNER_SHIFT  23=0D
+=0D
+#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK 0xFFFFFU=0D
+#define SQ_CTXT_WQ_PAGE_OWNER_MASK  0x1U=0D
+=0D
+#define SQ_CTXT_WQ_PAGE_SET(val, member)           \=0D
+	(((val) & SQ_CTXT_WQ_PAGE_##member##_MASK) \=0D
+	 << SQ_CTXT_WQ_PAGE_##member##_SHIFT)=0D
+=0D
+#define SQ_CTXT_PKT_DROP_THD_ON_SHIFT  0=0D
+#define SQ_CTXT_PKT_DROP_THD_OFF_SHIFT 16=0D
+=0D
+#define SQ_CTXT_PKT_DROP_THD_ON_MASK  0xFFFFU=0D
+#define SQ_CTXT_PKT_DROP_THD_OFF_MASK 0xFFFFU=0D
+=0D
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)       \=0D
+	(((val) & SQ_CTXT_PKT_DROP_##member##_MASK) \=0D
+	 << SQ_CTXT_PKT_DROP_##member##_SHIFT)=0D
+=0D
+#define SQ_CTXT_GLOBAL_SQ_ID_SHIFT 0=0D
+=0D
+#define SQ_CTXT_GLOBAL_SQ_ID_MASK 0x1FFFU=0D
+=0D
+#define SQ_CTXT_GLOBAL_QUEUE_ID_SET(val, member) \=0D
+	(((val) & SQ_CTXT_##member##_MASK) << SQ_CTXT_##member##_SHIFT)=0D
+=0D
+#define SQ_CTXT_VLAN_TAG_SHIFT	       0=0D
+#define SQ_CTXT_VLAN_TYPE_SEL_SHIFT    16=0D
+#define SQ_CTXT_VLAN_INSERT_MODE_SHIFT 19=0D
+#define SQ_CTXT_VLAN_CEQ_EN_SHIFT      23=0D
+=0D
+#define SQ_CTXT_VLAN_TAG_MASK	      0xFFFFU=0D
+#define SQ_CTXT_VLAN_TYPE_SEL_MASK    0x7U=0D
+#define SQ_CTXT_VLAN_INSERT_MODE_MASK 0x3U=0D
+#define SQ_CTXT_VLAN_CEQ_EN_MASK      0x1U=0D
+=0D
+#define SQ_CTXT_VLAN_CEQ_SET(val, member)       \=0D
+	(((val) & SQ_CTXT_VLAN_##member##_MASK) \=0D
+	 << SQ_CTXT_VLAN_##member##_SHIFT)=0D
+=0D
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT 0=0D
+#define SQ_CTXT_PREF_CACHE_MAX_SHIFT	   14=0D
+#define SQ_CTXT_PREF_CACHE_MIN_SHIFT	   25=0D
+=0D
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK 0x3FFFU=0D
+#define SQ_CTXT_PREF_CACHE_MAX_MASK	  0x7FFU=0D
+#define SQ_CTXT_PREF_CACHE_MIN_MASK	  0x7FU=0D
+=0D
+#define SQ_CTXT_PREF_CI_HI_SHIFT 0=0D
+#define SQ_CTXT_PREF_OWNER_SHIFT 4=0D
+=0D
+#define SQ_CTXT_PREF_CI_HI_MASK 0xFU=0D
+#define SQ_CTXT_PREF_OWNER_MASK 0x1U=0D
+=0D
+#define SQ_CTXT_PREF_WQ_PFN_HI_SHIFT 0=0D
+#define SQ_CTXT_PREF_CI_LOW_SHIFT    20=0D
+=0D
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK 0xFFFFFU=0D
+#define SQ_CTXT_PREF_CI_LOW_MASK    0xFFFU=0D
+=0D
+#define SQ_CTXT_PREF_SET(val, member)           \=0D
+	(((val) & SQ_CTXT_PREF_##member##_MASK) \=0D
+	 << SQ_CTXT_PREF_##member##_SHIFT)=0D
+=0D
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT 0=0D
+=0D
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK 0x7FFFFFU=0D
+=0D
+#define SQ_CTXT_WQ_BLOCK_SET(val, member)           \=0D
+	(((val) & SQ_CTXT_WQ_BLOCK_##member##_MASK) \=0D
+	 << SQ_CTXT_WQ_BLOCK_##member##_SHIFT)=0D
+=0D
+#define RQ_CTXT_PI_IDX_SHIFT 0=0D
+#define RQ_CTXT_CI_IDX_SHIFT 16=0D
+=0D
+#define RQ_CTXT_PI_IDX_MASK 0xFFFFU=0D
+#define RQ_CTXT_CI_IDX_MASK 0xFFFFU=0D
+=0D
+#define RQ_CTXT_CI_PI_SET(val, member) \=0D
+	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)=0D
+=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_SHIFT	21=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_SHIFT 30=0D
+#define RQ_CTXT_CEQ_ATTR_EN_SHIFT	31=0D
+=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK     0x3FFU=0D
+#define RQ_CTXT_CEQ_ATTR_INTR_ARM_MASK 0x1U=0D
+#define RQ_CTXT_CEQ_ATTR_EN_MASK       0x1U=0D
+=0D
+#define RQ_CTXT_CEQ_ATTR_SET(val, member)           \=0D
+	(((val) & RQ_CTXT_CEQ_ATTR_##member##_MASK) \=0D
+	 << RQ_CTXT_CEQ_ATTR_##member##_SHIFT)=0D
+=0D
+#define RQ_CTXT_WQ_PAGE_HI_PFN_SHIFT   0=0D
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_SHIFT 28=0D
+#define RQ_CTXT_WQ_PAGE_OWNER_SHIFT    31=0D
+=0D
+#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK   0xFFFFFU=0D
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK 0x3U=0D
+#define RQ_CTXT_WQ_PAGE_OWNER_MASK    0x1U=0D
+=0D
+#define RQ_CTXT_WQ_PAGE_SET(val, member)           \=0D
+	(((val) & RQ_CTXT_WQ_PAGE_##member##_MASK) \=0D
+	 << RQ_CTXT_WQ_PAGE_##member##_SHIFT)=0D
+=0D
+#define RQ_CTXT_CQE_LEN_SHIFT 28=0D
+=0D
+#define RQ_CTXT_CQE_LEN_MASK 0x3U=0D
+=0D
+#define RQ_CTXT_CQE_LEN_SET(val, member) \=0D
+	(((val) & RQ_CTXT_##member##_MASK) << RQ_CTXT_##member##_SHIFT)=0D
+=0D
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_SHIFT 0=0D
+#define RQ_CTXT_PREF_CACHE_MAX_SHIFT	   14=0D
+#define RQ_CTXT_PREF_CACHE_MIN_SHIFT	   25=0D
+=0D
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK 0x3FFFU=0D
+#define RQ_CTXT_PREF_CACHE_MAX_MASK	  0x7FFU=0D
+#define RQ_CTXT_PREF_CACHE_MIN_MASK	  0x7FU=0D
+=0D
+#define RQ_CTXT_PREF_CI_HI_SHIFT 0=0D
+#define RQ_CTXT_PREF_OWNER_SHIFT 4=0D
+=0D
+#define RQ_CTXT_PREF_CI_HI_MASK 0xFU=0D
+#define RQ_CTXT_PREF_OWNER_MASK 0x1U=0D
+=0D
+#define RQ_CTXT_PREF_WQ_PFN_HI_SHIFT 0=0D
+#define RQ_CTXT_PREF_CI_LOW_SHIFT    20=0D
+=0D
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK 0xFFFFFU=0D
+#define RQ_CTXT_PREF_CI_LOW_MASK    0xFFFU=0D
+=0D
+#define RQ_CTXT_PREF_SET(val, member)           \=0D
+	(((val) & RQ_CTXT_PREF_##member##_MASK) \=0D
+	 << RQ_CTXT_PREF_##member##_SHIFT)=0D
+=0D
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_SHIFT 0=0D
+=0D
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK 0x7FFFFFU=0D
+=0D
+#define RQ_CTXT_WQ_BLOCK_SET(val, member)           \=0D
+	(((val) & RQ_CTXT_WQ_BLOCK_##member##_MASK) \=0D
+	 << RQ_CTXT_WQ_BLOCK_##member##_SHIFT)=0D
+=0D
+#define SIZE_16BYTES(size) (RTE_ALIGN((size), 16) >> 4)=0D
+=0D
+#define WQ_PAGE_PFN_SHIFT  12=0D
+#define WQ_BLOCK_PFN_SHIFT 9=0D
+=0D
+#define WQ_PAGE_PFN(page_addr)	((page_addr) >> WQ_PAGE_PFN_SHIFT)=0D
+#define WQ_BLOCK_PFN(page_addr) ((page_addr) >> WQ_BLOCK_PFN_SHIFT)=0D
+=0D
+/**=0D
+ * Prepare the command queue header and converted it to big-endian format.=
=0D
+ *=0D
+ * @param[out] qp_ctxt_hdr=0D
+ * Pointer to command queue context header structure to be initialized.=0D
+ * @param[in] ctxt_type=0D
+ * Type of context (SQ/RQ) to be set in header.=0D
+ * @param[in] num_queues=0D
+ * Number of queues.=0D
+ * @param[in] q_id=0D
+ * Starting queue ID for this context.=0D
+ */=0D
+static void=0D
+hinic3_qp_prepare_cmdq_header(struct hinic3_qp_ctxt_header *qp_ctxt_hdr,=0D
+			      enum hinic3_qp_ctxt_type ctxt_type,=0D
+			      u16 num_queues, u16 q_id)=0D
+{=0D
+	qp_ctxt_hdr->queue_type =3D ctxt_type;=0D
+	qp_ctxt_hdr->num_queues =3D num_queues;=0D
+	qp_ctxt_hdr->start_qid =3D q_id;=0D
+	qp_ctxt_hdr->rsvd =3D 0;=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+=0D
+	hinic3_cpu_to_be32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));=0D
+}=0D
+=0D
+/**=0D
+ * Initialize context structure for specified TXQ by configuring various q=
ueue=0D
+ * parameters (e.g., ci, pi, work queue page addresses).=0D
+ *=0D
+ * @param[in] sq=0D
+ * Pointer to TXQ structure.=0D
+ * @param[in] sq_id=0D
+ * ID of TXQ being configured.=0D
+ * @param[out] sq_ctxt=0D
+ * Pointer to structure that will hold TXQ context.=0D
+ */=0D
+static void=0D
+hinic3_sq_prepare_ctxt(struct hinic3_txq *sq, u16 sq_id,=0D
+		       struct hinic3_sq_ctxt *sq_ctxt)=0D
+{=0D
+	u64 wq_page_addr, wq_page_pfn, wq_block_pfn;=0D
+	u32 wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo;=0D
+	u16 pi_start, ci_start;=0D
+=0D
+	ci_start =3D sq->cons_idx & sq->q_mask;=0D
+	pi_start =3D sq->prod_idx & sq->q_mask;=0D
+=0D
+	/* Read the first page from hardware table. */=0D
+	wq_page_addr =3D sq->queue_buf_paddr;=0D
+=0D
+	wq_page_pfn =3D WQ_PAGE_PFN(wq_page_addr);=0D
+	wq_page_pfn_hi =3D upper_32_bits(wq_page_pfn);=0D
+	wq_page_pfn_lo =3D lower_32_bits(wq_page_pfn);=0D
+=0D
+	/* Use 0-level CLA. */=0D
+	wq_block_pfn =3D WQ_BLOCK_PFN(wq_page_addr);=0D
+	wq_block_pfn_hi =3D upper_32_bits(wq_block_pfn);=0D
+	wq_block_pfn_lo =3D lower_32_bits(wq_block_pfn);=0D
+=0D
+	sq_ctxt->ci_pi =3D SQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |=0D
+			 SQ_CTXT_CI_PI_SET(pi_start, PI_IDX);=0D
+=0D
+	sq_ctxt->drop_mode_sp =3D SQ_CTXT_MODE_SET(0, SP_FLAG) |=0D
+				SQ_CTXT_MODE_SET(0, PKT_DROP);=0D
+=0D
+	sq_ctxt->wq_pfn_hi_owner =3D SQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) =
|=0D
+				   SQ_CTXT_WQ_PAGE_SET(1, OWNER);=0D
+=0D
+	sq_ctxt->wq_pfn_lo =3D wq_page_pfn_lo;=0D
+=0D
+	sq_ctxt->pkt_drop_thd =3D=0D
+		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_ON, THD_ON) |=0D
+		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);=0D
+=0D
+	sq_ctxt->global_sq_id =3D=0D
+		SQ_CTXT_GLOBAL_QUEUE_ID_SET(sq_id, GLOBAL_SQ_ID);=0D
+=0D
+	/* Insert c-vlan in default. */=0D
+	sq_ctxt->vlan_ceq_attr =3D SQ_CTXT_VLAN_CEQ_SET(0, CEQ_EN) |=0D
+				 SQ_CTXT_VLAN_CEQ_SET(1, INSERT_MODE);=0D
+=0D
+	sq_ctxt->rsvd0 =3D 0;=0D
+=0D
+	sq_ctxt->pref_cache =3D=0D
+		SQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |=0D
+		SQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |=0D
+		SQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);=0D
+=0D
+	sq_ctxt->pref_ci_owner =3D=0D
+		SQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |=0D
+		SQ_CTXT_PREF_SET(1, OWNER);=0D
+=0D
+	sq_ctxt->pref_wq_pfn_hi_ci =3D=0D
+		SQ_CTXT_PREF_SET(ci_start, CI_LOW) |=0D
+		SQ_CTXT_PREF_SET(wq_page_pfn_hi, WQ_PFN_HI);=0D
+=0D
+	sq_ctxt->pref_wq_pfn_lo =3D wq_page_pfn_lo;=0D
+=0D
+	sq_ctxt->wq_block_pfn_hi =3D=0D
+		SQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI);=0D
+=0D
+	sq_ctxt->wq_block_pfn_lo =3D wq_block_pfn_lo;=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+=0D
+	hinic3_cpu_to_be32(sq_ctxt, sizeof(*sq_ctxt));=0D
+}=0D
+=0D
+/**=0D
+ * Initialize context structure for specified RXQ by configuring various q=
ueue=0D
+ * parameters (e.g., ci, pi, work queue page addresses).=0D
+ *=0D
+ * @param[in] rq=0D
+ * Pointer to RXQ structure.=0D
+ * @param[out] rq_ctxt=0D
+ * Pointer to structure that will hold RXQ context.=0D
+ */=0D
+static void=0D
+hinic3_rq_prepare_ctxt(struct hinic3_rxq *rq, struct hinic3_rq_ctxt *rq_ct=
xt)=0D
+{=0D
+	u64 wq_page_addr, wq_page_pfn, wq_block_pfn;=0D
+	u32 wq_page_pfn_hi, wq_page_pfn_lo, wq_block_pfn_hi, wq_block_pfn_lo;=0D
+	u16 pi_start, ci_start;=0D
+	u16 wqe_type =3D rq->wqebb_shift - HINIC3_RQ_WQEBB_SHIFT;=0D
+	u8 intr_disable;=0D
+=0D
+	/* RQ depth is in unit of 8 Bytes. */=0D
+	ci_start =3D (u16)((rq->cons_idx & rq->q_mask) << wqe_type);=0D
+	pi_start =3D (u16)((rq->prod_idx & rq->q_mask) << wqe_type);=0D
+=0D
+	/* Read the first page from hardware table. */=0D
+	wq_page_addr =3D rq->queue_buf_paddr;=0D
+=0D
+	wq_page_pfn =3D WQ_PAGE_PFN(wq_page_addr);=0D
+	wq_page_pfn_hi =3D upper_32_bits(wq_page_pfn);=0D
+	wq_page_pfn_lo =3D lower_32_bits(wq_page_pfn);=0D
+=0D
+	/* Use 0-level CLA. */=0D
+	wq_block_pfn =3D WQ_BLOCK_PFN(wq_page_addr);=0D
+	wq_block_pfn_hi =3D upper_32_bits(wq_block_pfn);=0D
+	wq_block_pfn_lo =3D lower_32_bits(wq_block_pfn);=0D
+=0D
+	rq_ctxt->ci_pi =3D RQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |=0D
+			 RQ_CTXT_CI_PI_SET(pi_start, PI_IDX);=0D
+=0D
+	/* RQ doesn't need ceq, msix_entry_idx set 1, but mask not enable. */=0D
+	intr_disable =3D rq->dp_intr_en ? 0 : 1;=0D
+	rq_ctxt->ceq_attr =3D RQ_CTXT_CEQ_ATTR_SET(intr_disable, EN) |=0D
+			    RQ_CTXT_CEQ_ATTR_SET(0, INTR_ARM) |=0D
+			    RQ_CTXT_CEQ_ATTR_SET(rq->msix_entry_idx, INTR);=0D
+=0D
+	/* Use 32Byte WQE with SGE for CQE in default. */=0D
+	rq_ctxt->wq_pfn_hi_type_owner =3D=0D
+		RQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |=0D
+		RQ_CTXT_WQ_PAGE_SET(1, OWNER);=0D
+=0D
+	switch (wqe_type) {=0D
+	case HINIC3_EXTEND_RQ_WQE:=0D
+		/* Use 32Byte WQE with SGE for CQE. */=0D
+		rq_ctxt->wq_pfn_hi_type_owner |=3D=0D
+			RQ_CTXT_WQ_PAGE_SET(0, WQE_TYPE);=0D
+		break;=0D
+	case HINIC3_NORMAL_RQ_WQE:=0D
+		/* Use 16Byte WQE with 32Bytes SGE for CQE. */=0D
+		rq_ctxt->wq_pfn_hi_type_owner |=3D=0D
+			RQ_CTXT_WQ_PAGE_SET(2, WQE_TYPE);=0D
+		rq_ctxt->cqe_sge_len =3D RQ_CTXT_CQE_LEN_SET(1, CQE_LEN);=0D
+		break;=0D
+	default:=0D
+		PMD_DRV_LOG(INFO, "Invalid rq wqe type: %u", wqe_type);=0D
+	}=0D
+=0D
+	rq_ctxt->wq_pfn_lo =3D wq_page_pfn_lo;=0D
+=0D
+	rq_ctxt->pref_cache =3D=0D
+		RQ_CTXT_PREF_SET(WQ_PREFETCH_MIN, CACHE_MIN) |=0D
+		RQ_CTXT_PREF_SET(WQ_PREFETCH_MAX, CACHE_MAX) |=0D
+		RQ_CTXT_PREF_SET(WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);=0D
+=0D
+	rq_ctxt->pref_ci_owner =3D=0D
+		RQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |=0D
+		RQ_CTXT_PREF_SET(1, OWNER);=0D
+=0D
+	rq_ctxt->pref_wq_pfn_hi_ci =3D=0D
+		RQ_CTXT_PREF_SET(wq_page_pfn_hi, WQ_PFN_HI) |=0D
+		RQ_CTXT_PREF_SET(ci_start, CI_LOW);=0D
+=0D
+	rq_ctxt->pref_wq_pfn_lo =3D wq_page_pfn_lo;=0D
+=0D
+	rq_ctxt->pi_paddr_hi =3D upper_32_bits(rq->pi_dma_addr);=0D
+	rq_ctxt->pi_paddr_lo =3D lower_32_bits(rq->pi_dma_addr);=0D
+=0D
+	rq_ctxt->wq_block_pfn_hi =3D=0D
+		RQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI);=0D
+=0D
+	rq_ctxt->wq_block_pfn_lo =3D wq_block_pfn_lo;=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+=0D
+	hinic3_cpu_to_be32(rq_ctxt, sizeof(*rq_ctxt));=0D
+}=0D
+=0D
+/**=0D
+ * Allocate a command buffer, prepare context for each SQ queue by setting=
=0D
+ * various parameters, send context data to hardware. It processes SQ queu=
es in=0D
+ * batches, with each batch not exceeding `HINIC3_Q_CTXT_MAX` SQ contexts.=
=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, a negative error code on failure.=0D
+ * - -ENOMEM if the memory allocation for the command buffer fails.=0D
+ * - -EFAULT if the hardware returns an error while processing the context=
 data.=0D
+ */=0D
+static int=0D
+init_sq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	struct hinic3_sq_ctxt_block *sq_ctxt_block =3D NULL;=0D
+	struct hinic3_sq_ctxt *sq_ctxt =3D NULL;=0D
+	struct hinic3_cmd_buf *cmd_buf =3D NULL;=0D
+	struct hinic3_txq *sq =3D NULL;=0D
+	u64 out_param =3D 0;=0D
+	u16 q_id, curr_id, max_ctxts, i;=0D
+	int err =3D 0;=0D
+=0D
+	cmd_buf =3D hinic3_alloc_cmd_buf(nic_dev->hwdev);=0D
+	if (!cmd_buf) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmd buf for sq ctx failed");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	q_id =3D 0;=0D
+	while (q_id < nic_dev->num_sqs) {=0D
+		sq_ctxt_block =3D cmd_buf->buf;=0D
+		sq_ctxt =3D sq_ctxt_block->sq_ctxt;=0D
+=0D
+		max_ctxts =3D (nic_dev->num_sqs - q_id) > HINIC3_Q_CTXT_MAX=0D
+				    ? HINIC3_Q_CTXT_MAX=0D
+				    : (nic_dev->num_sqs - q_id);=0D
+=0D
+		hinic3_qp_prepare_cmdq_header(&sq_ctxt_block->cmdq_hdr,=0D
+					      HINIC3_QP_CTXT_TYPE_SQ, max_ctxts,=0D
+					      q_id);=0D
+=0D
+		for (i =3D 0; i < max_ctxts; i++) {=0D
+			curr_id =3D q_id + i;=0D
+			sq =3D nic_dev->txqs[curr_id];=0D
+			hinic3_sq_prepare_ctxt(sq, curr_id, &sq_ctxt[i]);=0D
+		}=0D
+=0D
+		cmd_buf->size =3D SQ_CTXT_SIZE(max_ctxts);=0D
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+		err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
+					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,=0D
+					      cmd_buf, &out_param, 0);=0D
+		if (err || out_param !=3D 0) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Set SQ ctxts failed, "=0D
+				    "err: %d, out_param: %" PRIu64,=0D
+				    err, out_param);=0D
+=0D
+			err =3D -EFAULT;=0D
+			break;=0D
+		}=0D
+=0D
+		q_id +=3D max_ctxts;=0D
+	}=0D
+=0D
+	hinic3_free_cmd_buf(cmd_buf);=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Initialize context for all RQ in device.=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, a negative error code on failure.=0D
+ * - -ENOMEM if the memory allocation for the command buffer fails.=0D
+ * - -EFAULT if the hardware returns an error while processing the context=
 data.=0D
+ */=0D
+static int=0D
+init_rq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	struct hinic3_rq_ctxt_block *rq_ctxt_block =3D NULL;=0D
+	struct hinic3_rq_ctxt *rq_ctxt =3D NULL;=0D
+	struct hinic3_cmd_buf *cmd_buf =3D NULL;=0D
+	struct hinic3_rxq *rq =3D NULL;=0D
+	u64 out_param =3D 0;=0D
+	u16 q_id, curr_id, max_ctxts, i;=0D
+	int err =3D 0;=0D
+=0D
+	cmd_buf =3D hinic3_alloc_cmd_buf(nic_dev->hwdev);=0D
+	if (!cmd_buf) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmd buf for rq ctx failed");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	q_id =3D 0;=0D
+	while (q_id < nic_dev->num_rqs) {=0D
+		rq_ctxt_block =3D cmd_buf->buf;=0D
+		rq_ctxt =3D rq_ctxt_block->rq_ctxt;=0D
+=0D
+		max_ctxts =3D (nic_dev->num_rqs - q_id) > HINIC3_Q_CTXT_MAX=0D
+				    ? HINIC3_Q_CTXT_MAX=0D
+				    : (nic_dev->num_rqs - q_id);=0D
+=0D
+		hinic3_qp_prepare_cmdq_header(&rq_ctxt_block->cmdq_hdr,=0D
+					      HINIC3_QP_CTXT_TYPE_RQ, max_ctxts,=0D
+					      q_id);=0D
+=0D
+		for (i =3D 0; i < max_ctxts; i++) {=0D
+			curr_id =3D q_id + i;=0D
+			rq =3D nic_dev->rxqs[curr_id];=0D
+			hinic3_rq_prepare_ctxt(rq, &rq_ctxt[i]);=0D
+		}=0D
+=0D
+		cmd_buf->size =3D RQ_CTXT_SIZE(max_ctxts);=0D
+		rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+		err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
+					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,=0D
+					      cmd_buf, &out_param, 0);=0D
+		if (err || out_param !=3D 0) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Set RQ ctxts failed, "=0D
+				    "err: %d, out_param: %" PRIu64,=0D
+				    err, out_param);=0D
+			err =3D -EFAULT;=0D
+			break;=0D
+		}=0D
+=0D
+		q_id +=3D max_ctxts;=0D
+	}=0D
+=0D
+	hinic3_free_cmd_buf(cmd_buf);=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Allocate memory for command buffer, construct related command request, =
send a=0D
+ * command to hardware to clean up queue offload context.=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
+ * @param[in] ctxt_type=0D
+ * The type of queue context to clean.=0D
+ * The queue context type that determines which queue type to clean up.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,=0D
+			 enum hinic3_qp_ctxt_type ctxt_type)=0D
+{=0D
+	struct hinic3_clean_queue_ctxt *ctxt_block =3D NULL;=0D
+	struct hinic3_cmd_buf *cmd_buf;=0D
+	u64 out_param =3D 0;=0D
+	int err;=0D
+=0D
+	cmd_buf =3D hinic3_alloc_cmd_buf(nic_dev->hwdev);=0D
+	if (!cmd_buf) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmd buf for LRO/TSO space failed");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	/* Construct related command request. */=0D
+	ctxt_block =3D cmd_buf->buf;=0D
+	/* Assumed max_rqs must be equal to max_sqs. */=0D
+	ctxt_block->cmdq_hdr.num_queues =3D nic_dev->max_sqs;=0D
+	ctxt_block->cmdq_hdr.queue_type =3D ctxt_type;=0D
+	ctxt_block->cmdq_hdr.start_qid =3D 0;=0D
+	/*=0D
+	 * Add a memory barrier to ensure that instructions are not out of order=
=0D
+	 * due to compilation optimization.=0D
+	 */=0D
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
+=0D
+	hinic3_cpu_to_be32(ctxt_block, sizeof(*ctxt_block));=0D
+=0D
+	cmd_buf->size =3D sizeof(*ctxt_block);=0D
+=0D
+	/* Send a command to hardware to clean up queue offload context. */=0D
+	err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
+				      HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT,=0D
+				      cmd_buf, &out_param, 0);=0D
+	if ((err) || (out_param)) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Clean queue offload ctxts failed, "=0D
+			    "err: %d, out_param: %" PRIu64,=0D
+			    err, out_param);=0D
+		err =3D -EFAULT;=0D
+	}=0D
+=0D
+	hinic3_free_cmd_buf(cmd_buf);=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+clean_qp_offload_ctxt(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	/* Clean LRO/TSO context space. */=0D
+	return (clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_SQ) ||=0D
+		clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_RQ));=0D
+}=0D
+=0D
+void=0D
+hinic3_get_func_rx_buf_size(void *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D (struct hinic3_nic_dev *)dev;=0D
+	struct hinic3_rxq *rxq =3D NULL;=0D
+	u16 q_id;=0D
+	u16 buf_size =3D 0;=0D
+=0D
+	for (q_id =3D 0; q_id < nic_dev->num_rqs; q_id++) {=0D
+		rxq =3D nic_dev->rxqs[q_id];=0D
+=0D
+		if (rxq =3D=3D NULL)=0D
+			continue;=0D
+=0D
+		if (q_id =3D=3D 0)=0D
+			buf_size =3D rxq->buf_len;=0D
+=0D
+		buf_size =3D buf_size > rxq->buf_len ? rxq->buf_len : buf_size;=0D
+	}=0D
+=0D
+	nic_dev->rx_buff_len =3D buf_size;=0D
+}=0D
+=0D
+int=0D
+hinic3_init_qp_ctxts(void *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+	struct hinic3_hwdev *hwdev =3D NULL;=0D
+	struct hinic3_sq_attr sq_attr;=0D
+	u32 rq_depth =3D 0;=0D
+	u32 sq_depth =3D 0;=0D
+	u16 q_id;=0D
+	int err;=0D
+=0D
+	if (!dev)=0D
+		return -EINVAL;=0D
+=0D
+	nic_dev =3D (struct hinic3_nic_dev *)dev;=0D
+	hwdev =3D nic_dev->hwdev;=0D
+=0D
+	err =3D init_sq_ctxts(nic_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init SQ ctxts failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D init_rq_ctxts(nic_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init RQ ctxts failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D clean_qp_offload_ctxt(nic_dev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Clean qp offload ctxts failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	if (nic_dev->num_rqs !=3D 0)=0D
+		rq_depth =3D ((u32)nic_dev->rxqs[0]->q_depth)=0D
+			   << nic_dev->rxqs[0]->wqe_type;=0D
+=0D
+	if (nic_dev->num_sqs !=3D 0)=0D
+		sq_depth =3D nic_dev->txqs[0]->q_depth;=0D
+=0D
+	err =3D hinic3_set_root_ctxt(hwdev, rq_depth, sq_depth,=0D
+				   nic_dev->rx_buff_len);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Set root context failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	/* Configure CI tables for each SQ. */=0D
+	for (q_id =3D 0; q_id < nic_dev->num_sqs; q_id++) {=0D
+		sq_attr.ci_dma_base =3D nic_dev->txqs[q_id]->ci_dma_base >> 0x2;=0D
+		sq_attr.pending_limit =3D HINIC3_DEAULT_TX_CI_PENDING_LIMIT;=0D
+		sq_attr.coalescing_time =3D HINIC3_DEAULT_TX_CI_COALESCING_TIME;=0D
+		sq_attr.intr_en =3D 0;=0D
+		sq_attr.intr_idx =3D 0; /**< Tx doesn't need interrupt. */=0D
+		sq_attr.l2nic_sqn =3D q_id;=0D
+		sq_attr.dma_attr_off =3D 0;=0D
+		err =3D hinic3_set_ci_table(hwdev, &sq_attr);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Set ci table failed");=0D
+			goto set_cons_idx_table_err;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+set_cons_idx_table_err:=0D
+	hinic3_clean_root_ctxt(hwdev);=0D
+	return err;=0D
+}=0D
+=0D
+void=0D
+hinic3_free_qp_ctxts(void *hwdev)=0D
+{=0D
+	if (!hwdev)=0D
+		return;=0D
+=0D
+	hinic3_clean_root_ctxt(hwdev);=0D
+}=0D
+=0D
+void=0D
+hinic3_update_driver_feature(void *dev, u64 s_feature)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+=0D
+	if (!dev)=0D
+		return;=0D
+=0D
+	nic_dev =3D (struct hinic3_nic_dev *)dev;=0D
+	nic_dev->feature_cap =3D s_feature;=0D
+=0D
+	PMD_DRV_LOG(INFO, "Update nic feature to 0x%" PRIx64,=0D
+		    nic_dev->feature_cap);=0D
+}=0D
+=0D
+u64=0D
+hinic3_get_driver_feature(void *dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+=0D
+	nic_dev =3D (struct hinic3_nic_dev *)dev;=0D
+=0D
+	return nic_dev->feature_cap;=0D
+}=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3=
_nic_io.h=0D
new file mode 100644=0D
index 0000000000..774247dc56=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.h=0D
@@ -0,0 +1,169 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_NIC_IO_H_=0D
+#define _HINIC3_NIC_IO_H_=0D
+=0D
+#define HINIC3_SQ_WQEBB_SHIFT 4=0D
+#define HINIC3_RQ_WQEBB_SHIFT 3=0D
+=0D
+#define HINIC3_SQ_WQEBB_SIZE  BIT(HINIC3_SQ_WQEBB_SHIFT)=0D
+#define HINIC3_CQE_SIZE_SHIFT 4=0D
+=0D
+/* Ci addr should RTE_CACHE_SIZE(64B) alignment for performance. */=0D
+#define HINIC3_CI_Q_ADDR_SIZE 64=0D
+=0D
+#define CI_TABLE_SIZE(num_qps, pg_sz) \=0D
+	(RTE_ALIGN((num_qps) * HINIC3_CI_Q_ADDR_SIZE, pg_sz))=0D
+=0D
+#define HINIC3_CI_VADDR(base_addr, q_id) \=0D
+	((volatile u8 *)(base_addr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)=0D
+=0D
+#define HINIC3_CI_PADDR(base_paddr, q_id) \=0D
+	((base_paddr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)=0D
+=0D
+enum hinic3_rq_wqe_type {=0D
+	HINIC3_COMPACT_RQ_WQE,=0D
+	HINIC3_NORMAL_RQ_WQE,=0D
+	HINIC3_EXTEND_RQ_WQE=0D
+};=0D
+=0D
+enum hinic3_queue_type {=0D
+	HINIC3_SQ,=0D
+	HINIC3_RQ,=0D
+	HINIC3_MAX_QUEUE_TYPE,=0D
+};=0D
+=0D
+/* Doorbell info. */=0D
+struct hinic3_db {=0D
+	u32 db_info;=0D
+	u32 pi_hi;=0D
+};=0D
+=0D
+#define DB_INFO_QID_SHIFT	 0=0D
+#define DB_INFO_NON_FILTER_SHIFT 22=0D
+#define DB_INFO_CFLAG_SHIFT	 23=0D
+#define DB_INFO_COS_SHIFT	 24=0D
+#define DB_INFO_TYPE_SHIFT	 27=0D
+=0D
+#define DB_INFO_QID_MASK	0x1FFFU=0D
+#define DB_INFO_NON_FILTER_MASK 0x1U=0D
+#define DB_INFO_CFLAG_MASK	0x1U=0D
+#define DB_INFO_COS_MASK	0x7U=0D
+#define DB_INFO_TYPE_MASK	0x1FU=0D
+#define DB_INFO_SET(val, member) \=0D
+	(((u32)(val) & DB_INFO_##member##_MASK) << DB_INFO_##member##_SHIFT)=0D
+=0D
+#define DB_PI_LOW_MASK	      0xFFU=0D
+#define DB_PI_HIGH_MASK	      0xFFU=0D
+#define DB_PI_LOW(pi)	      ((pi) & DB_PI_LOW_MASK)=0D
+#define DB_PI_HI_SHIFT	      8=0D
+#define DB_PI_HIGH(pi)	      (((pi) >> DB_PI_HI_SHIFT) & DB_PI_HIGH_MASK)=
=0D
+#define DB_INFO_UPPER_32(val) (((u64)(val)) << 32)=0D
+=0D
+#define DB_ADDR(db_addr, pi) ((u64 *)(db_addr) + DB_PI_LOW(pi))=0D
+#define SRC_TYPE	     1=0D
+=0D
+/* Cflag data path. */=0D
+#define SQ_CFLAG_DP 0=0D
+#define RQ_CFLAG_DP 1=0D
+=0D
+#define MASKED_QUEUE_IDX(queue, idx) ((idx) & (queue)->q_mask)=0D
+=0D
+#define NIC_WQE_ADDR(queue, idx)                           \=0D
+	({                                                 \=0D
+		typeof(queue) __queue =3D (queue);           \=0D
+		(void *)((u64)(__queue->queue_buf_vaddr) + \=0D
+			 ((idx) << __queue->wqebb_shift)); \=0D
+	})=0D
+=0D
+/**=0D
+ * Write send queue doorbell.=0D
+ *=0D
+ * @param[in] db_addr=0D
+ * Doorbell address.=0D
+ * @param[in] q_id=0D
+ * Send queue id.=0D
+ * @param[in] cos=0D
+ * Send queue cos.=0D
+ * @param[in] cflag=0D
+ * Cflag data path.=0D
+ * @param[in] pi=0D
+ * Send queue pi.=0D
+ */=0D
+static inline void=0D
+hinic3_write_db(void *db_addr, u16 q_id, int cos, u8 cflag, u16 pi)=0D
+{=0D
+	u64 db;=0D
+=0D
+	/* Hardware will do endianness coverting. */=0D
+	db =3D DB_PI_HIGH(pi);=0D
+	db =3D DB_INFO_UPPER_32(db) | DB_INFO_SET(SRC_TYPE, TYPE) |=0D
+	     DB_INFO_SET(cflag, CFLAG) | DB_INFO_SET(cos, COS) |=0D
+	     DB_INFO_SET(q_id, QID);=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_release); /**< Write all before =
the doorbell. */=0D
+=0D
+	rte_write64(*((u64 *)&db), DB_ADDR(db_addr, pi));=0D
+}=0D
+=0D
+/**=0D
+ * Get minimum RX buffer size for device.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ */=0D
+void hinic3_get_func_rx_buf_size(void *dev);=0D
+=0D
+/**=0D
+ * Initialize qps contexts, set SQ ci attributes, arm all SQ.=0D
+ *=0D
+ * Function will perform following steps:=0D
+ * - Initialize SQ contexts.=0D
+ * - Initialize RQ contexts.=0D
+ * - Clean QP offload contexts of SQ and RQ.=0D
+ * - Set root context for device.=0D
+ * - Configure CI tables for each SQ.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int hinic3_init_qp_ctxts(void *dev);=0D
+=0D
+/**=0D
+ * Free queue pair context.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ */=0D
+void hinic3_free_qp_ctxts(void *hwdev);=0D
+=0D
+/**=0D
+ * Update driver feature capabilities.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ * @param[out] s_feature=0D
+ * s_feature driver supported.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+void hinic3_update_driver_feature(void *dev, u64 s_feature);=0D
+=0D
+/**=0D
+ * Get driver feature capabilities.=0D
+ *=0D
+ * @param[in] dev=0D
+ * Pointer to ethernet device structure.=0D
+ *=0D
+ * @return=0D
+ * Feature capabilities of driver.=0D
+ */=0D
+u64 hinic3_get_driver_feature(void *dev);=0D
+=0D
+#endif /* _HINIC3_NIC_IO_H_ */=0D
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.=
c=0D
new file mode 100644=0D
index 0000000000..6fe565984b=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_rx.c=0D
@@ -0,0 +1,814 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_atomic.h>=0D
+#include <rte_ether.h>=0D
+#include <rte_mbuf.h>=0D
+=0D
+#include "base/hinic3_compat.h"=0D
+#include "base/hinic3_pmd_hwif.h"=0D
+#include "base/hinic3_pmd_hwdev.h"=0D
+#include "base/hinic3_pmd_wq.h"=0D
+#include "base/hinic3_pmd_nic_cfg.h"=0D
+#include "hinic3_pmd_nic_io.h"=0D
+#include "hinic3_pmd_ethdev.h"=0D
+#include "hinic3_pmd_tx.h"=0D
+#include "hinic3_pmd_rx.h"=0D
+=0D
+/**=0D
+ * Get wqe from receive queue.=0D
+ *=0D
+ * @param[in] rxq=0D
+ * Receive queue.=0D
+ * @param[out] rq_wqe=0D
+ * Receive queue wqe.=0D
+ * @param[out] pi=0D
+ * Current pi.=0D
+ */=0D
+static inline void=0D
+hinic3_get_rq_wqe(struct hinic3_rxq *rxq, struct hinic3_rq_wqe **rq_wqe,=0D
+		  u16 *pi)=0D
+{=0D
+	*pi =3D MASKED_QUEUE_IDX(rxq, rxq->prod_idx);=0D
+=0D
+	/* Get only one rxq wqe. */=0D
+	rxq->prod_idx++;=0D
+	rxq->delta--;=0D
+=0D
+	*rq_wqe =3D NIC_WQE_ADDR(rxq, *pi);=0D
+}=0D
+=0D
+/**=0D
+ * Put wqe into receive queue.=0D
+ *=0D
+ * @param[in] rxq=0D
+ * Receive queue.=0D
+ * @param[in] wqe_cnt=0D
+ * Wqebb counters.=0D
+ */=0D
+static inline void=0D
+hinic3_put_rq_wqe(struct hinic3_rxq *rxq, u16 wqe_cnt)=0D
+{=0D
+	rxq->delta +=3D wqe_cnt;=0D
+	rxq->prod_idx -=3D wqe_cnt;=0D
+}=0D
+=0D
+/**=0D
+ * Get receive queue local pi.=0D
+ *=0D
+ * @param[in] rxq=0D
+ * Receive queue.=0D
+ * @return=0D
+ * Receive queue local pi.=0D
+ */=0D
+static inline u16=0D
+hinic3_get_rq_local_pi(struct hinic3_rxq *rxq)=0D
+{=0D
+	return MASKED_QUEUE_IDX(rxq, rxq->prod_idx);=0D
+}=0D
+=0D
+/**=0D
+ * Update receive queue hardware pi.=0D
+ *=0D
+ * @param[in] rxq=0D
+ * Receive queue=0D
+ * @param[in] pi=0D
+ * Receive queue pi to update=0D
+ */=0D
+static inline void __rte_unused=0D
+hinic3_update_rq_hw_pi(struct hinic3_rxq *rxq, u16 pi)=0D
+{=0D
+	*rxq->pi_virt_addr =3D=0D
+		(u16)cpu_to_be16((pi & rxq->q_mask) << rxq->wqe_type);=0D
+}=0D
+=0D
+u16=0D
+hinic3_rx_fill_wqe(struct hinic3_rxq *rxq)=0D
+{=0D
+	struct hinic3_rq_wqe *rq_wqe =3D NULL;=0D
+	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
+	rte_iova_t cqe_dma;=0D
+	u16 pi =3D 0;=0D
+	u16 i;=0D
+=0D
+	cqe_dma =3D rxq->cqe_start_paddr;=0D
+	for (i =3D 0; i < rxq->q_depth; i++) {=0D
+		hinic3_get_rq_wqe(rxq, &rq_wqe, &pi);=0D
+		if (!rq_wqe) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Get rq wqe failed, rxq id: %d, wqe id: %d",=0D
+				    rxq->q_id, i);=0D
+			break;=0D
+		}=0D
+=0D
+		if (rxq->wqe_type =3D=3D HINIC3_EXTEND_RQ_WQE) {=0D
+			/* Unit of cqe length is 16B. */=0D
+			hinic3_set_sge(&rq_wqe->extend_wqe.cqe_sect.sge,=0D
+				       cqe_dma,=0D
+				       HINIC3_CQE_LEN >> HINIC3_CQE_SIZE_SHIFT);=0D
+			/* Use fixed len. */=0D
+			rq_wqe->extend_wqe.buf_desc.sge.len =3D=0D
+				nic_dev->rx_buff_len;=0D
+		} else {=0D
+			rq_wqe->normal_wqe.cqe_hi_addr =3D upper_32_bits(cqe_dma);=0D
+			rq_wqe->normal_wqe.cqe_lo_addr =3D lower_32_bits(cqe_dma);=0D
+		}=0D
+=0D
+		cqe_dma +=3D sizeof(struct hinic3_rq_cqe);=0D
+=0D
+		hinic3_hw_be32_len(rq_wqe, rxq->wqebb_size);=0D
+	}=0D
+=0D
+	hinic3_put_rq_wqe(rxq, i);=0D
+=0D
+	return i;=0D
+}=0D
+=0D
+static struct rte_mbuf *=0D
+hinic3_rx_alloc_mbuf(struct hinic3_rxq *rxq, rte_iova_t *dma_addr)=0D
+{=0D
+	struct rte_mbuf *mbuf =3D NULL;=0D
+=0D
+	if (unlikely(rte_pktmbuf_alloc_bulk(rxq->mb_pool, &mbuf, 1) !=3D 0))=0D
+		return NULL;=0D
+=0D
+	*dma_addr =3D rte_mbuf_data_iova_default(mbuf);=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+	rxq->rxq_stats.rx_alloc_mbuf_bytes++;=0D
+#endif=0D
+	return mbuf;=0D
+}=0D
+=0D
+#ifdef HINIC3_XSTAT_RXBUF_INFO=0D
+static void=0D
+hinic3_rxq_buffer_done_count(struct hinic3_rxq *rxq)=0D
+{=0D
+	u16 sw_ci, avail_pkts =3D 0, hit_done =3D 0, cqe_hole =3D 0;=0D
+	RTE_ATOMIC(u32) status;=0D
+	volatile struct hinic3_rq_cqe *rx_cqe;=0D
+=0D
+	for (sw_ci =3D 0; sw_ci < rxq->q_depth; sw_ci++) {=0D
+		rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
+=0D
+		/* Check current ci is done. */=0D
+		status =3D rx_cqe->status;=0D
+		if (!HINIC3_GET_RX_DONE(status)) {=0D
+			if (hit_done) {=0D
+				cqe_hole++;=0D
+				hit_done =3D 0;=0D
+			}=0D
+			continue;=0D
+		}=0D
+=0D
+		avail_pkts++;=0D
+		hit_done =3D 1;=0D
+	}=0D
+=0D
+	rxq->rxq_stats.rx_avail =3D avail_pkts;=0D
+	rxq->rxq_stats.rx_hole =3D cqe_hole;=0D
+}=0D
+=0D
+void=0D
+hinic3_get_stats(struct hinic3_rxq *rxq)=0D
+{=0D
+	rxq->rxq_stats.rx_mbuf =3D rxq->q_depth - hinic3_get_rq_free_wqebb(rxq);=
=0D
+=0D
+	hinic3_rxq_buffer_done_count(rxq);=0D
+}=0D
+#endif=0D
+=0D
+u16=0D
+hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)=0D
+{=0D
+	struct hinic3_rq_wqe *rq_wqe =3D NULL;=0D
+	struct hinic3_rx_info *rx_info =3D NULL;=0D
+	struct rte_mbuf *mb =3D NULL;=0D
+	rte_iova_t dma_addr;=0D
+	u16 i, free_wqebbs;=0D
+=0D
+	free_wqebbs =3D rxq->delta - 1;=0D
+	for (i =3D 0; i < free_wqebbs; i++) {=0D
+		rx_info =3D &rxq->rx_info[rxq->next_to_update];=0D
+=0D
+		mb =3D hinic3_rx_alloc_mbuf(rxq, &dma_addr);=0D
+		if (!mb) {=0D
+			PMD_DRV_LOG(ERR, "Alloc mbuf failed");=0D
+			break;=0D
+		}=0D
+=0D
+		rx_info->mbuf =3D mb;=0D
+=0D
+		rq_wqe =3D NIC_WQE_ADDR(rxq, rxq->next_to_update);=0D
+=0D
+		/* Fill buffer address only. */=0D
+		if (rxq->wqe_type =3D=3D HINIC3_EXTEND_RQ_WQE) {=0D
+			rq_wqe->extend_wqe.buf_desc.sge.hi_addr =3D=0D
+				hinic3_hw_be32(upper_32_bits(dma_addr));=0D
+			rq_wqe->extend_wqe.buf_desc.sge.lo_addr =3D=0D
+				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
+		} else {=0D
+			rq_wqe->normal_wqe.buf_hi_addr =3D=0D
+				hinic3_hw_be32(upper_32_bits(dma_addr));=0D
+			rq_wqe->normal_wqe.buf_lo_addr =3D=0D
+				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
+		}=0D
+=0D
+		rxq->next_to_update =3D (rxq->next_to_update + 1) & rxq->q_mask;=0D
+	}=0D
+=0D
+	if (likely(i > 0)) {=0D
+#ifndef HINIC3_RQ_DB=0D
+		hinic3_write_db(rxq->db_addr, rxq->q_id, 0, RQ_CFLAG_DP,=0D
+				(u16)(rxq->next_to_update << rxq->wqe_type));=0D
+		/* Init rxq contxet used, need to optimization. */=0D
+		rxq->prod_idx =3D rxq->next_to_update;=0D
+#else=0D
+		rte_atomic_thread_fence(rte_memory_order_release);=0D
+		rxq->prod_idx =3D rxq->next_to_update;=0D
+		hinic3_update_rq_hw_pi(rxq, rxq->next_to_update);=0D
+#endif=0D
+		rxq->delta -=3D i;=0D
+	} else {=0D
+		PMD_DRV_LOG(ERR, "Alloc rx buffers failed, rxq_id: %d",=0D
+			    rxq->q_id);=0D
+	}=0D
+=0D
+	return i;=0D
+}=0D
+=0D
+void=0D
+hinic3_free_rxq_mbufs(struct hinic3_rxq *rxq)=0D
+{=0D
+	struct hinic3_rx_info *rx_info =3D NULL;=0D
+	int free_wqebbs =3D hinic3_get_rq_free_wqebb(rxq) + 1;=0D
+	volatile struct hinic3_rq_cqe *rx_cqe =3D NULL;=0D
+	u16 ci;=0D
+=0D
+	while (free_wqebbs++ < rxq->q_depth) {=0D
+		ci =3D hinic3_get_rq_local_ci(rxq);=0D
+=0D
+		rx_cqe =3D &rxq->rx_cqe[ci];=0D
+=0D
+		/* Clear done bit. */=0D
+		rx_cqe->status =3D 0;=0D
+=0D
+		rx_info =3D &rxq->rx_info[ci];=0D
+		rte_pktmbuf_free(rx_info->mbuf);=0D
+		rx_info->mbuf =3D NULL;=0D
+=0D
+		hinic3_update_rq_local_ci(rxq, 1);=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+		rxq->rxq_stats.rx_free_mbuf_bytes++;=0D
+#endif=0D
+	}=0D
+}=0D
+=0D
+void=0D
+hinic3_free_all_rxq_mbufs(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	u16 qid;=0D
+=0D
+	for (qid =3D 0; qid < nic_dev->num_rqs; qid++)=0D
+		hinic3_free_rxq_mbufs(nic_dev->rxqs[qid]);=0D
+}=0D
+=0D
+static u32=0D
+hinic3_rx_alloc_mbuf_bulk(struct hinic3_rxq *rxq, struct rte_mbuf **mbufs,=
=0D
+			  u32 exp_mbuf_cnt)=0D
+{=0D
+	u32 avail_cnt;=0D
+	int err;=0D
+=0D
+	err =3D rte_pktmbuf_alloc_bulk(rxq->mb_pool, mbufs, exp_mbuf_cnt);=0D
+	if (likely(err =3D=3D 0)) {=0D
+		avail_cnt =3D exp_mbuf_cnt;=0D
+	} else {=0D
+		avail_cnt =3D 0;=0D
+		rxq->rxq_stats.rx_nombuf +=3D exp_mbuf_cnt;=0D
+	}=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+	rxq->rxq_stats.rx_alloc_mbuf_bytes +=3D avail_cnt;=0D
+#endif=0D
+	return avail_cnt;=0D
+}=0D
+=0D
+static int=0D
+hinic3_rearm_rxq_mbuf(struct hinic3_rxq *rxq)=0D
+{=0D
+	struct hinic3_rq_wqe *rq_wqe =3D NULL;=0D
+	struct rte_mbuf **rearm_mbufs;=0D
+	u32 i, free_wqebbs, rearm_wqebbs, exp_wqebbs;=0D
+	rte_iova_t dma_addr;=0D
+	u16 pi;=0D
+	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
+=0D
+	/* Check free wqebb cnt fo rearm. */=0D
+	free_wqebbs =3D hinic3_get_rq_free_wqebb(rxq);=0D
+	if (unlikely(free_wqebbs < rxq->rx_free_thresh))=0D
+		return -ENOMEM;=0D
+=0D
+	/* Get rearm mbuf array. */=0D
+	pi =3D hinic3_get_rq_local_pi(rxq);=0D
+	rearm_mbufs =3D (struct rte_mbuf **)(&rxq->rx_info[pi]);=0D
+=0D
+	/* Check rxq free wqebbs turn around. */=0D
+	exp_wqebbs =3D rxq->q_depth - pi;=0D
+	if (free_wqebbs < exp_wqebbs)=0D
+		exp_wqebbs =3D free_wqebbs;=0D
+=0D
+	/* Alloc mbuf in bulk. */=0D
+	rearm_wqebbs =3D hinic3_rx_alloc_mbuf_bulk(rxq, rearm_mbufs, exp_wqebbs);=
=0D
+	if (unlikely(rearm_wqebbs =3D=3D 0))=0D
+		return -ENOMEM;=0D
+=0D
+	/* Rearm rxq mbuf. */=0D
+	rq_wqe =3D NIC_WQE_ADDR(rxq, pi);=0D
+	for (i =3D 0; i < rearm_wqebbs; i++) {=0D
+		dma_addr =3D rte_mbuf_data_iova_default(rearm_mbufs[i]);=0D
+=0D
+		/* Fill buffer address only. */=0D
+		if (rxq->wqe_type =3D=3D HINIC3_EXTEND_RQ_WQE) {=0D
+			rq_wqe->extend_wqe.buf_desc.sge.hi_addr =3D=0D
+				hinic3_hw_be32(upper_32_bits(dma_addr));=0D
+			rq_wqe->extend_wqe.buf_desc.sge.lo_addr =3D=0D
+				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
+			rq_wqe->extend_wqe.buf_desc.sge.len =3D=0D
+				nic_dev->rx_buff_len;=0D
+		} else {=0D
+			rq_wqe->normal_wqe.buf_hi_addr =3D=0D
+				hinic3_hw_be32(upper_32_bits(dma_addr));=0D
+			rq_wqe->normal_wqe.buf_lo_addr =3D=0D
+				hinic3_hw_be32(lower_32_bits(dma_addr));=0D
+		}=0D
+=0D
+		rq_wqe =3D=0D
+			(struct hinic3_rq_wqe *)((u64)rq_wqe + rxq->wqebb_size);=0D
+	}=0D
+	rxq->prod_idx +=3D rearm_wqebbs;=0D
+	rxq->delta -=3D rearm_wqebbs;=0D
+=0D
+#ifndef HINIC3_RQ_DB=0D
+	hinic3_write_db(rxq->db_addr, rxq->q_id, 0, RQ_CFLAG_DP,=0D
+			((pi + rearm_wqebbs) & rxq->q_mask) << rxq->wqe_type);=0D
+#else=0D
+	/* Update rxq hw_pi. */=0D
+	rte_atomic_thread_fence(rte_memory_order_release);=0D
+	hinic3_update_rq_hw_pi(rxq, pi + rearm_wqebbs);=0D
+#endif=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_init_rss_key(struct hinic3_nic_dev *nic_dev,=0D
+		    struct rte_eth_rss_conf *rss_conf)=0D
+{=0D
+	u8 default_rss_key[HINIC3_RSS_KEY_SIZE] =3D {=0D
+			 0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,=0D
+			 0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,=0D
+			 0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,=0D
+			 0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,=0D
+			 0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa};=0D
+	u8 hashkey[HINIC3_RSS_KEY_SIZE] =3D {0};=0D
+	int err;=0D
+=0D
+	if (rss_conf->rss_key =3D=3D NULL ||=0D
+	    rss_conf->rss_key_len > HINIC3_RSS_KEY_SIZE)=0D
+		memcpy(hashkey, default_rss_key, HINIC3_RSS_KEY_SIZE);=0D
+	else=0D
+		memcpy(hashkey, rss_conf->rss_key, rss_conf->rss_key_len);=0D
+=0D
+	err =3D hinic3_rss_set_hash_key(nic_dev->hwdev, hashkey,=0D
+				      HINIC3_RSS_KEY_SIZE);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	memcpy(nic_dev->rss_key, hashkey, HINIC3_RSS_KEY_SIZE);=0D
+	return 0;=0D
+}=0D
+=0D
+void=0D
+hinic3_add_rq_to_rx_queue_list(struct hinic3_nic_dev *nic_dev, u16 queue_i=
d)=0D
+{=0D
+	u8 rss_queue_count =3D nic_dev->num_rss;=0D
+=0D
+	RTE_ASSERT(rss_queue_count <=3D (RTE_DIM(nic_dev->rx_queue_list) - 1));=0D
+=0D
+	nic_dev->rx_queue_list[rss_queue_count] =3D (u8)queue_id;=0D
+	nic_dev->num_rss++;=0D
+}=0D
+=0D
+void=0D
+hinic3_init_rx_queue_list(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	nic_dev->num_rss =3D 0;=0D
+}=0D
+=0D
+static void=0D
+hinic3_fill_indir_tbl(struct hinic3_nic_dev *nic_dev, u32 *indir_tbl)=0D
+{=0D
+	u8 rss_queue_count =3D nic_dev->num_rss;=0D
+	int i =3D 0;=0D
+	int j;=0D
+=0D
+	if (rss_queue_count =3D=3D 0) {=0D
+		/* Delete q_id from indir tbl. */=0D
+		for (i =3D 0; i < HINIC3_RSS_INDIR_SIZE; i++)=0D
+			/* Invalid value in indir tbl. */=0D
+			indir_tbl[i] =3D 0xFFFF;=0D
+	} else {=0D
+		while (i < HINIC3_RSS_INDIR_SIZE)=0D
+			for (j =3D 0; (j < rss_queue_count) &&=0D
+				    (i < HINIC3_RSS_INDIR_SIZE); j++)=0D
+				indir_tbl[i++] =3D nic_dev->rx_queue_list[j];=0D
+	}=0D
+}=0D
+=0D
+int=0D
+hinic3_refill_indir_rqid(struct hinic3_rxq *rxq)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
+	u32 *indir_tbl;=0D
+	int err;=0D
+=0D
+	indir_tbl =3D rte_zmalloc(NULL, HINIC3_RSS_INDIR_SIZE * sizeof(u32), 0);=
=0D
+	if (!indir_tbl) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Alloc indir_tbl mem failed, "=0D
+			    "eth_dev:%s, queue_idx:%d",=0D
+			    nic_dev->dev_name, rxq->q_id);=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	/* Build indir tbl according to the number of rss queue. */=0D
+	hinic3_fill_indir_tbl(nic_dev, indir_tbl);=0D
+=0D
+	err =3D hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir_tbl,=0D
+				       HINIC3_RSS_INDIR_SIZE);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			"Set indrect table failed, eth_dev:%s, queue_idx:%d",=0D
+			nic_dev->dev_name, rxq->q_id);=0D
+		goto out;=0D
+	}=0D
+=0D
+out:=0D
+	rte_free(indir_tbl);=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+hinic3_init_rss_type(struct hinic3_nic_dev *nic_dev,=0D
+		     struct rte_eth_rss_conf *rss_conf)=0D
+{=0D
+	struct hinic3_rss_type rss_type =3D {0};=0D
+	u64 rss_hf =3D rss_conf->rss_hf;=0D
+	int err;=0D
+=0D
+	rss_type.ipv4 =3D (rss_hf & (RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4)) ?=
 1 : 0;=0D
+	rss_type.tcp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP) ? 1 : 0;=0D
+	rss_type.ipv6 =3D (rss_hf & (RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6)) ?=
 1 : 0;=0D
+	rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
+	rss_type.tcp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;=0D
+	rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
+	rss_type.udp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;=0D
+	rss_type.udp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;=0D
+=0D
+	err =3D hinic3_set_rss_type(nic_dev->hwdev, rss_type);=0D
+	return err;=0D
+}=0D
+=0D
+int=0D
+hinic3_update_rss_config(struct rte_eth_dev *dev,=0D
+			 struct rte_eth_rss_conf *rss_conf)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
+	u8 prio_tc[HINIC3_DCB_UP_MAX] =3D {0};=0D
+	u8 num_tc =3D 0;=0D
+	int err;=0D
+=0D
+	if (rss_conf->rss_hf =3D=3D 0) {=0D
+		rss_conf->rss_hf =3D HINIC3_RSS_OFFLOAD_ALL;=0D
+	} else if ((rss_conf->rss_hf & HINIC3_RSS_OFFLOAD_ALL) =3D=3D 0) {=0D
+		PMD_DRV_LOG(ERR, "Does't support rss hash type: %" PRIu64,=0D
+			    rss_conf->rss_hf);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	err =3D hinic3_rss_template_alloc(nic_dev->hwdev);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Alloc rss template failed, err: %d", err);=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D hinic3_init_rss_key(nic_dev, rss_conf);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init rss hash key failed, err: %d", err);=0D
+		goto init_rss_fail;=0D
+	}=0D
+=0D
+	err =3D hinic3_init_rss_type(nic_dev, rss_conf);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init rss hash type failed, err: %d", err);=0D
+		goto init_rss_fail;=0D
+	}=0D
+=0D
+	err =3D hinic3_rss_set_hash_engine(nic_dev->hwdev,=0D
+					 HINIC3_RSS_HASH_ENGINE_TYPE_TOEP);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Init rss hash function failed, err: %d", err);=0D
+		goto init_rss_fail;=0D
+	}=0D
+=0D
+	err =3D hinic3_rss_cfg(nic_dev->hwdev, HINIC3_RSS_ENABLE, num_tc,=0D
+			     prio_tc);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Enable rss failed, err: %d", err);=0D
+		goto init_rss_fail;=0D
+	}=0D
+=0D
+	nic_dev->rss_state =3D HINIC3_RSS_ENABLE;=0D
+	return 0;=0D
+=0D
+init_rss_fail:=0D
+	if (hinic3_rss_template_free(nic_dev->hwdev))=0D
+		PMD_DRV_LOG(WARNING, "Free rss template failed");=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Search given queue array to find possition of given id.=0D
+ * Return queue pos or queue_count if not found.=0D
+ */=0D
+static u8=0D
+hinic3_find_queue_pos_by_rq_id(u8 *queues, u8 queues_count, u8 queue_id)=0D
+{=0D
+	u8 pos;=0D
+=0D
+	for (pos =3D 0; pos < queues_count; pos++) {=0D
+		if (queue_id =3D=3D queues[pos])=0D
+			break;=0D
+	}=0D
+=0D
+	return pos;=0D
+}=0D
+=0D
+void=0D
+hinic3_remove_rq_from_rx_queue_list(struct hinic3_nic_dev *nic_dev,=0D
+				    u16 queue_id)=0D
+{=0D
+	u8 queue_pos;=0D
+	u8 rss_queue_count =3D nic_dev->num_rss;=0D
+=0D
+	queue_pos =3D hinic3_find_queue_pos_by_rq_id(nic_dev->rx_queue_list,=0D
+						   rss_queue_count,=0D
+						   (u8)queue_id);=0D
+	/*=0D
+	 * If queue was not at the end of the list,=0D
+	 * shift started queues up queue array list.=0D
+	 */=0D
+	if (queue_pos < rss_queue_count) {=0D
+		rss_queue_count--;=0D
+		memmove(nic_dev->rx_queue_list + queue_pos,=0D
+			nic_dev->rx_queue_list + queue_pos + 1,=0D
+			(rss_queue_count - queue_pos) *=0D
+				sizeof(nic_dev->rx_queue_list[0]));=0D
+	}=0D
+=0D
+	RTE_ASSERT(rss_queue_count < RTE_DIM(nic_dev->rx_queue_list));=0D
+	nic_dev->num_rss =3D rss_queue_count;=0D
+}=0D
+=0D
+static void=0D
+hinic3_rx_queue_release_mbufs(struct hinic3_rxq *rxq)=0D
+{=0D
+	u16 sw_ci, ci_mask, free_wqebbs;=0D
+	u16 rx_buf_len;=0D
+	u32 vlan_len, pkt_len;=0D
+	RTE_ATOMIC(u32) status;=0D
+	u32 pkt_left_len =3D 0;=0D
+	u32 nr_released =3D 0;=0D
+	struct hinic3_rx_info *rx_info;=0D
+	volatile struct hinic3_rq_cqe *rx_cqe;=0D
+=0D
+	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+	rx_info =3D &rxq->rx_info[sw_ci];=0D
+	rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
+	free_wqebbs =3D hinic3_get_rq_free_wqebb(rxq) + 1;=0D
+	status =3D rx_cqe->status;=0D
+	ci_mask =3D rxq->q_mask;=0D
+=0D
+	while (free_wqebbs < rxq->q_depth) {=0D
+		rx_buf_len =3D rxq->buf_len;=0D
+		if (pkt_left_len !=3D 0) {=0D
+			/* Flush continues jumbo rqe. */=0D
+			pkt_left_len =3D (pkt_left_len <=3D rx_buf_len)=0D
+					       ? 0=0D
+					       : (pkt_left_len - rx_buf_len);=0D
+		} else if (HINIC3_GET_RX_FLUSH(status)) {=0D
+			/* Flush one released rqe. */=0D
+			pkt_left_len =3D 0;=0D
+		} else if (HINIC3_GET_RX_DONE(status)) {=0D
+			/* Flush single packet or first jumbo rqe. */=0D
+			vlan_len =3D hinic3_hw_cpu32(rx_cqe->vlan_len);=0D
+			pkt_len =3D HINIC3_GET_RX_PKT_LEN(vlan_len);=0D
+			pkt_left_len =3D (pkt_len <=3D rx_buf_len)=0D
+					       ? 0=0D
+					       : (pkt_len - rx_buf_len);=0D
+		} else {=0D
+			break;=0D
+		}=0D
+		rte_pktmbuf_free(rx_info->mbuf);=0D
+=0D
+		rx_info->mbuf =3D NULL;=0D
+		rx_cqe->status =3D 0;=0D
+		nr_released++;=0D
+		free_wqebbs++;=0D
+=0D
+		/* Update ci to next cqe. */=0D
+		sw_ci++;=0D
+		sw_ci &=3D ci_mask;=0D
+		rx_info =3D &rxq->rx_info[sw_ci];=0D
+		rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
+		status =3D rx_cqe->status;=0D
+	}=0D
+=0D
+	hinic3_update_rq_local_ci(rxq, (u16)nr_released);=0D
+}=0D
+=0D
+int=0D
+hinic3_poll_rq_empty(struct hinic3_rxq *rxq)=0D
+{=0D
+	unsigned long timeout;=0D
+	int free_wqebb;=0D
+	int err =3D -EFAULT;=0D
+=0D
+	timeout =3D msecs_to_jiffies(HINIC3_FLUSH_QUEUE_TIMEOUT) + jiffies;=0D
+	do {=0D
+		free_wqebb =3D hinic3_get_rq_free_wqebb(rxq) + 1;=0D
+		if (free_wqebb =3D=3D rxq->q_depth) {=0D
+			err =3D 0;=0D
+			break;=0D
+		}=0D
+		hinic3_rx_queue_release_mbufs(rxq);=0D
+		rte_delay_us(1);=0D
+	} while (time_before(jiffies, timeout));=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+void=0D
+hinic3_dump_cqe_status(struct hinic3_rxq *rxq, u32 *cqe_done_cnt,=0D
+		       u32 *cqe_hole_cnt, u32 *head_ci, u32 *head_done)=0D
+{=0D
+	u16 sw_ci;=0D
+	u16 avail_pkts =3D 0;=0D
+	u16 hit_done =3D 0;=0D
+	u16 cqe_hole =3D 0;=0D
+	RTE_ATOMIC(u32) status;=0D
+	volatile struct hinic3_rq_cqe *rx_cqe;=0D
+=0D
+	sw_ci =3D hinic3_get_rq_local_ci(rxq);=0D
+	rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
+	status =3D rx_cqe->status;=0D
+	*head_done =3D HINIC3_GET_RX_DONE(status);=0D
+	*head_ci =3D sw_ci;=0D
+=0D
+	for (sw_ci =3D 0; sw_ci < rxq->q_depth; sw_ci++) {=0D
+		rx_cqe =3D &rxq->rx_cqe[sw_ci];=0D
+=0D
+		/* Check current ci is done. */=0D
+		status =3D rx_cqe->status;=0D
+		if (!HINIC3_GET_RX_DONE(status) ||=0D
+		    !HINIC3_GET_RX_FLUSH(status)) {=0D
+			if (hit_done) {=0D
+				cqe_hole++;=0D
+				hit_done =3D 0;=0D
+			}=0D
+=0D
+			continue;=0D
+		}=0D
+=0D
+		avail_pkts++;=0D
+		hit_done =3D 1;=0D
+	}=0D
+=0D
+	*cqe_done_cnt =3D avail_pkts;=0D
+	*cqe_hole_cnt =3D cqe_hole;=0D
+}=0D
+=0D
+int=0D
+hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
+	u32 cqe_done_cnt =3D 0;=0D
+	u32 cqe_hole_cnt =3D 0;=0D
+	u32 head_ci, head_done;=0D
+	int err;=0D
+=0D
+	/* Disable rxq intr. */=0D
+	hinic3_dev_rx_queue_intr_disable(eth_dev, rxq->q_id);=0D
+=0D
+	/* Lock dev queue switch. */=0D
+	rte_spinlock_lock(&nic_dev->queue_list_lock);=0D
+=0D
+	if (nic_dev->num_rss =3D=3D 1) {=0D
+		err =3D hinic3_set_vport_enable(nic_dev->hwdev, false);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "%s Disable vport failed, rc:%d",=0D
+				    nic_dev->dev_name, err);=0D
+		}=0D
+	}=0D
+	hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);=0D
+=0D
+	/*=0D
+	 * If RSS is enable, remove q_id from rss indir table.=0D
+	 * If RSS is disable, no mbuf in rq, pakcet will be dropped.=0D
+	 */=0D
+	if (nic_dev->rss_state =3D=3D HINIC3_RSS_ENABLE) {=0D
+		err =3D hinic3_refill_indir_rqid(rxq);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Clear rq in indirect table failed, "=0D
+				    "eth_dev:%s, queue_idx:%d",=0D
+				    nic_dev->dev_name, rxq->q_id);=0D
+			hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);=0D
+			goto set_indir_failed;=0D
+		}=0D
+	}=0D
+=0D
+	/* Unlock dev queue list switch. */=0D
+	rte_spinlock_unlock(&nic_dev->queue_list_lock);=0D
+=0D
+	/* Send flush rxq cmd to device. */=0D
+	err =3D hinic3_set_rq_flush(nic_dev->hwdev, rxq->q_id);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Flush rq failed, eth_dev:%s, queue_idx:%d",=0D
+			    nic_dev->dev_name, rxq->q_id);=0D
+		goto rq_flush_failed;=0D
+	}=0D
+=0D
+	err =3D hinic3_poll_rq_empty(rxq);=0D
+	if (err) {=0D
+		hinic3_dump_cqe_status(rxq, &cqe_done_cnt, &cqe_hole_cnt,=0D
+				       &head_ci, &head_done);=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Poll rq empty timeout, eth_dev:%s, queue_idx:%d, "=0D
+			    "mbuf_left:%d, "=0D
+			    "cqe_done:%d, cqe_hole:%d, cqe[%d].done=3D%d",=0D
+			    nic_dev->dev_name, rxq->q_id,=0D
+			    rxq->q_depth - hinic3_get_rq_free_wqebb(rxq),=0D
+			    cqe_done_cnt, cqe_hole_cnt, head_ci, head_done);=0D
+		goto poll_rq_failed;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+poll_rq_failed:=0D
+rq_flush_failed:=0D
+	rte_spinlock_lock(&nic_dev->queue_list_lock);=0D
+set_indir_failed:=0D
+	hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);=0D
+	if (nic_dev->rss_state =3D=3D HINIC3_RSS_ENABLE)=0D
+		hinic3_refill_indir_rqid(rxq);=0D
+	rte_spinlock_unlock(&nic_dev->queue_list_lock);=0D
+	hinic3_dev_rx_queue_intr_enable(eth_dev, rxq->q_id);=0D
+	return err;=0D
+}=0D
+=0D
+int=0D
+hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D rxq->nic_dev;=0D
+	int err =3D 0;=0D
+=0D
+	/* Lock dev queue switch.  */=0D
+	rte_spinlock_lock(&nic_dev->queue_list_lock);=0D
+	hinic3_add_rq_to_rx_queue_list(nic_dev, rxq->q_id);=0D
+=0D
+	if (nic_dev->rss_state =3D=3D HINIC3_RSS_ENABLE) {=0D
+		err =3D hinic3_refill_indir_rqid(rxq);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Refill rq to indrect table failed, "=0D
+				    "eth_dev:%s, queue_idx:%d err:%d",=0D
+				    nic_dev->dev_name, rxq->q_id, err);=0D
+			hinic3_remove_rq_from_rx_queue_list(nic_dev, rxq->q_id);=0D
+		}=0D
+	}=0D
+	hinic3_rearm_rxq_mbuf(rxq);=0D
+	if (rxq->nic_dev->num_rss =3D=3D 1) {=0D
+		err =3D hinic3_set_vport_enable(nic_dev->hwdev, true);=0D
+		if (err)=0D
+			PMD_DRV_LOG(ERR, "%s enable vport failed, err:%d",=0D
+				    nic_dev->dev_name, err);=0D
+	}=0D
+=0D
+	/* Unlock dev queue list switch. */=0D
+	rte_spinlock_unlock(&nic_dev->queue_list_lock);=0D
+=0D
+	hinic3_dev_rx_queue_intr_enable(eth_dev, rxq->q_id);=0D
+=0D
+	return err;=0D
+}=0D
diff --git a/drivers/net/hinic3/hinic3_rx.h b/drivers/net/hinic3/hinic3_rx.=
h=0D
new file mode 100644=0D
index 0000000000..02e5cc61f1=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_rx.h=0D
@@ -0,0 +1,356 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_RX_H_=0D
+#define _HINIC3_RX_H_=0D
+=0D
+#include "hinic3_wq.h"=0D
+#include "hinic3_nic_io.h"=0D
+=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_SHIFT    0=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_UMBCAST_SHIFT 19=0D
+#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_SHIFT     21=0D
+#define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_SHIFT    24=0D
+=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK    0xFFFU=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_UMBCAST_MASK 0x3U=0D
+#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_MASK     0x1U=0D
+#define RQ_CQE_OFFOLAD_TYPE_RSS_TYPE_MASK    0xFFU=0D
+=0D
+#define DPI_EXT_ACTION_FILED (1ULL << 32)=0D
+=0D
+#define RQ_CQE_OFFOLAD_TYPE_GET(val, member)               \=0D
+	(((val) >> RQ_CQE_OFFOLAD_TYPE_##member##_SHIFT) & \=0D
+	 RQ_CQE_OFFOLAD_TYPE_##member##_MASK)=0D
+=0D
+#define HINIC3_GET_RX_PKT_TYPE(offload_type) \=0D
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_TYPE)=0D
+=0D
+#define HINIC3_GET_RX_PKT_UMBCAST(offload_type) \=0D
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_UMBCAST)=0D
+=0D
+#define HINIC3_GET_RX_VLAN_OFFLOAD_EN(offload_type) \=0D
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, VLAN_EN)=0D
+=0D
+#define HINIC3_GET_RSS_TYPES(offload_type) \=0D
+	RQ_CQE_OFFOLAD_TYPE_GET(offload_type, RSS_TYPE)=0D
+=0D
+#define RQ_CQE_SGE_VLAN_SHIFT 0=0D
+#define RQ_CQE_SGE_LEN_SHIFT  16=0D
+=0D
+#define RQ_CQE_SGE_VLAN_MASK 0xFFFFU=0D
+#define RQ_CQE_SGE_LEN_MASK  0xFFFFU=0D
+=0D
+#define RQ_CQE_SGE_GET(val, member) \=0D
+	(((val) >> RQ_CQE_SGE_##member##_SHIFT) & RQ_CQE_SGE_##member##_MASK)=0D
+=0D
+#define HINIC3_GET_RX_VLAN_TAG(vlan_len) RQ_CQE_SGE_GET(vlan_len, VLAN)=0D
+=0D
+#define HINIC3_GET_RX_PKT_LEN(vlan_len) RQ_CQE_SGE_GET(vlan_len, LEN)=0D
+=0D
+#define RQ_CQE_STATUS_CSUM_ERR_SHIFT  0=0D
+#define RQ_CQE_STATUS_NUM_LRO_SHIFT   16=0D
+#define RQ_CQE_STATUS_LRO_PUSH_SHIFT  25=0D
+#define RQ_CQE_STATUS_LRO_ENTER_SHIFT 26=0D
+#define RQ_CQE_STATUS_LRO_INTR_SHIFT  27=0D
+=0D
+#define RQ_CQE_STATUS_BP_EN_SHIFT     30=0D
+#define RQ_CQE_STATUS_RXDONE_SHIFT    31=0D
+#define RQ_CQE_STATUS_DECRY_PKT_SHIFT 29=0D
+#define RQ_CQE_STATUS_FLUSH_SHIFT     28=0D
+=0D
+#define RQ_CQE_STATUS_CSUM_ERR_MASK  0xFFFFU=0D
+#define RQ_CQE_STATUS_NUM_LRO_MASK   0xFFU=0D
+#define RQ_CQE_STATUS_LRO_PUSH_MASK  0X1U=0D
+#define RQ_CQE_STATUS_LRO_ENTER_MASK 0X1U=0D
+#define RQ_CQE_STATUS_LRO_INTR_MASK  0X1U=0D
+#define RQ_CQE_STATUS_BP_EN_MASK     0X1U=0D
+#define RQ_CQE_STATUS_RXDONE_MASK    0x1U=0D
+#define RQ_CQE_STATUS_FLUSH_MASK     0x1U=0D
+#define RQ_CQE_STATUS_DECRY_PKT_MASK 0x1U=0D
+=0D
+#define RQ_CQE_STATUS_GET(val, member)               \=0D
+	(((val) >> RQ_CQE_STATUS_##member##_SHIFT) & \=0D
+	 RQ_CQE_STATUS_##member##_MASK)=0D
+=0D
+#define HINIC3_GET_RX_CSUM_ERR(status) RQ_CQE_STATUS_GET(status, CSUM_ERR)=
=0D
+=0D
+#define HINIC3_GET_RX_DONE(status) RQ_CQE_STATUS_GET(status, RXDONE)=0D
+=0D
+#define HINIC3_GET_RX_FLUSH(status) RQ_CQE_STATUS_GET(status, FLUSH)=0D
+=0D
+#define HINIC3_GET_RX_BP_EN(status) RQ_CQE_STATUS_GET(status, BP_EN)=0D
+=0D
+#define HINIC3_GET_RX_NUM_LRO(status) RQ_CQE_STATUS_GET(status, NUM_LRO)=0D
+=0D
+#define HINIC3_RX_IS_DECRY_PKT(status) RQ_CQE_STATUS_GET(status, DECRY_PKT=
)=0D
+=0D
+#define RQ_CQE_SUPER_CQE_EN_SHIFT  0=0D
+#define RQ_CQE_PKT_NUM_SHIFT	   1=0D
+#define RQ_CQE_PKT_LAST_LEN_SHIFT  6=0D
+#define RQ_CQE_PKT_FIRST_LEN_SHIFT 19=0D
+=0D
+#define RQ_CQE_SUPER_CQE_EN_MASK  0x1=0D
+#define RQ_CQE_PKT_NUM_MASK	  0x1FU=0D
+#define RQ_CQE_PKT_FIRST_LEN_MASK 0x1FFFU=0D
+#define RQ_CQE_PKT_LAST_LEN_MASK  0x1FFFU=0D
+=0D
+#define RQ_CQE_PKT_NUM_GET(val, member) \=0D
+	(((val) >> RQ_CQE_PKT_##member##_SHIFT) & RQ_CQE_PKT_##member##_MASK)=0D
+#define HINIC3_GET_RQ_CQE_PKT_NUM(pkt_info) RQ_CQE_PKT_NUM_GET(pkt_info, N=
UM)=0D
+=0D
+#define RQ_CQE_SUPER_CQE_EN_GET(val, member) \=0D
+	(((val) >> RQ_CQE_##member##_SHIFT) & RQ_CQE_##member##_MASK)=0D
+=0D
+#define HINIC3_GET_SUPER_CQE_EN(pkt_info) \=0D
+	RQ_CQE_SUPER_CQE_EN_GET(pkt_info, SUPER_CQE_EN)=0D
+=0D
+#define RQ_CQE_PKT_LEN_GET(val, member) \=0D
+	(((val) >> RQ_CQE_PKT_##member##_SHIFT) & RQ_CQE_PKT_##member##_MASK)=0D
+=0D
+#define RQ_CQE_DECRY_INFO_DECRY_STATUS_SHIFT  8=0D
+#define RQ_CQE_DECRY_INFO_ESP_NEXT_HEAD_SHIFT 0=0D
+=0D
+#define RQ_CQE_DECRY_INFO_DECRY_STATUS_MASK  0xFFU=0D
+#define RQ_CQE_DECRY_INFO_ESP_NEXT_HEAD_MASK 0xFFU=0D
+=0D
+#define RQ_CQE_DECRY_INFO_GET(val, member)               \=0D
+	(((val) >> RQ_CQE_DECRY_INFO_##member##_SHIFT) & \=0D
+	 RQ_CQE_DECRY_INFO_##member##_MASK)=0D
+=0D
+#define HINIC3_GET_DECRYPT_STATUS(decry_info) \=0D
+	RQ_CQE_DECRY_INFO_GET(decry_info, DECRY_STATUS)=0D
+=0D
+#define HINIC3_GET_ESP_NEXT_HEAD(decry_info) \=0D
+	RQ_CQE_DECRY_INFO_GET(decry_info, ESP_NEXT_HEAD)=0D
+=0D
+/* Rx cqe checksum err */=0D
+#define HINIC3_RX_CSUM_IP_CSUM_ERR      BIT(0)=0D
+#define HINIC3_RX_CSUM_TCP_CSUM_ERR     BIT(1)=0D
+#define HINIC3_RX_CSUM_UDP_CSUM_ERR     BIT(2)=0D
+#define HINIC3_RX_CSUM_IGMP_CSUM_ERR    BIT(3)=0D
+#define HINIC3_RX_CSUM_ICMP_V4_CSUM_ERR BIT(4)=0D
+#define HINIC3_RX_CSUM_ICMP_V6_CSUM_ERR BIT(5)=0D
+#define HINIC3_RX_CSUM_SCTP_CRC_ERR     BIT(6)=0D
+#define HINIC3_RX_CSUM_HW_CHECK_NONE    BIT(7)=0D
+#define HINIC3_RX_CSUM_IPSU_OTHER_ERR   BIT(8)=0D
+=0D
+#define HINIC3_DEFAULT_RX_CSUM_OFFLOAD 0xFFF=0D
+#define HINIC3_CQE_LEN		       32=0D
+=0D
+#define HINIC3_RSS_OFFLOAD_ALL (         \=0D
+	RTE_ETH_RSS_IPV4 |               \=0D
+	RTE_ETH_RSS_FRAG_IPV4 |          \=0D
+	RTE_ETH_RSS_NONFRAG_IPV4_TCP |   \=0D
+	RTE_ETH_RSS_NONFRAG_IPV4_UDP |   \=0D
+	RTE_ETH_RSS_NONFRAG_IPV4_OTHER | \=0D
+	RTE_ETH_RSS_IPV6 |               \=0D
+	RTE_ETH_RSS_FRAG_IPV6 |          \=0D
+	RTE_ETH_RSS_NONFRAG_IPV6_TCP |   \=0D
+	RTE_ETH_RSS_NONFRAG_IPV6_UDP |   \=0D
+	RTE_ETH_RSS_NONFRAG_IPV6_OTHER | \=0D
+	RTE_ETH_RSS_IPV6_EX |            \=0D
+	RTE_ETH_RSS_IPV6_TCP_EX |        \=0D
+	RTE_ETH_RSS_IPV6_UDP_EX)=0D
+=0D
+struct hinic3_rxq_stats {=0D
+	u64 packets;=0D
+	u64 bytes;=0D
+	u64 errors;=0D
+	u64 csum_errors;=0D
+	u64 other_errors;=0D
+	u64 unlock_bp;=0D
+	u64 dropped;=0D
+=0D
+	u64 rx_nombuf;=0D
+	u64 rx_discards;=0D
+	u64 burst_pkts;=0D
+	u64 empty;=0D
+	u64 tsc;=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+	u64 rx_alloc_mbuf_bytes;=0D
+	u64 rx_free_mbuf_bytes;=0D
+	u64 rx_left_mbuf_bytes;=0D
+#endif=0D
+=0D
+#ifdef HINIC3_XSTAT_RXBUF_INFO=0D
+	u64 rx_mbuf;=0D
+	u64 rx_avail;=0D
+	u64 rx_hole;=0D
+#endif=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_RX=0D
+	u64 app_tsc;=0D
+	u64 pmd_tsc;=0D
+#endif=0D
+};=0D
+=0D
+struct __rte_cache_aligned hinic3_rq_cqe {=0D
+	RTE_ATOMIC(u32) status;=0D
+	u32 vlan_len;=0D
+=0D
+	u32 offload_type;=0D
+	u32 hash_val;=0D
+	u32 mark_id_0;=0D
+	u32 mark_id_1;=0D
+	u32 mark_id_2;=0D
+	u32 pkt_info;=0D
+};=0D
+=0D
+/**=0D
+ * Attention: please do not add any member in hinic3_rx_info=0D
+ * because rxq bulk rearm mode will write mbuf in rx_info.=0D
+ */=0D
+struct hinic3_rx_info {=0D
+	struct rte_mbuf *mbuf;=0D
+};=0D
+=0D
+struct hinic3_sge_sect {=0D
+	struct hinic3_sge sge;=0D
+	u32 rsvd;=0D
+};=0D
+=0D
+struct hinic3_rq_extend_wqe {=0D
+	struct hinic3_sge_sect buf_desc;=0D
+	struct hinic3_sge_sect cqe_sect;=0D
+};=0D
+=0D
+struct hinic3_rq_normal_wqe {=0D
+	u32 buf_hi_addr;=0D
+	u32 buf_lo_addr;=0D
+	u32 cqe_hi_addr;=0D
+	u32 cqe_lo_addr;=0D
+};=0D
+=0D
+struct hinic3_rq_wqe {=0D
+	union {=0D
+		struct hinic3_rq_normal_wqe normal_wqe;=0D
+		struct hinic3_rq_extend_wqe extend_wqe;=0D
+	};=0D
+};=0D
+=0D
+struct __rte_cache_aligned hinic3_rxq {=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+=0D
+	u16 q_id;=0D
+	u16 q_depth;=0D
+	u16 q_mask;=0D
+	u16 buf_len;=0D
+=0D
+	u32 rx_buff_shift;=0D
+=0D
+	u16 rx_free_thresh;=0D
+	u16 rxinfo_align_end;=0D
+	u16 wqebb_shift;=0D
+	u16 wqebb_size;=0D
+=0D
+	u16 wqe_type;=0D
+	u16 cons_idx;=0D
+	u16 prod_idx;=0D
+	u16 delta;=0D
+=0D
+	u16 next_to_update;=0D
+	u16 port_id;=0D
+=0D
+	const struct rte_memzone *rq_mz;=0D
+	void *queue_buf_vaddr; /**< rxq dma info */=0D
+	rte_iova_t queue_buf_paddr;=0D
+=0D
+	const struct rte_memzone *pi_mz;=0D
+	u16 *pi_virt_addr;=0D
+	void *db_addr;=0D
+	rte_iova_t pi_dma_addr;=0D
+=0D
+	struct hinic3_rx_info *rx_info;=0D
+	struct hinic3_rq_cqe *rx_cqe;=0D
+	struct rte_mempool *mb_pool;=0D
+=0D
+	const struct rte_memzone *cqe_mz;=0D
+	rte_iova_t cqe_start_paddr;=0D
+	void *cqe_start_vaddr;=0D
+	u8 dp_intr_en;=0D
+	u16 msix_entry_idx;=0D
+=0D
+	unsigned long status;=0D
+	u64 wait_time_cycle;=0D
+=0D
+	struct hinic3_rxq_stats rxq_stats;=0D
+#ifdef HINIC3_XSTAT_PROF_RX=0D
+	uint64_t prof_rx_end_tsc; /**< Performance profiling. */=0D
+#endif=0D
+};=0D
+=0D
+u16 hinic3_rx_fill_wqe(struct hinic3_rxq *rxq);=0D
+=0D
+u16 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq);=0D
+=0D
+void hinic3_free_rxq_mbufs(struct hinic3_rxq *rxq);=0D
+=0D
+void hinic3_free_all_rxq_mbufs(struct hinic3_nic_dev *nic_dev);=0D
+=0D
+int hinic3_update_rss_config(struct rte_eth_dev *dev,=0D
+			     struct rte_eth_rss_conf *rss_conf);=0D
+=0D
+int hinic3_poll_rq_empty(struct hinic3_rxq *rxq);=0D
+=0D
+void hinic3_dump_cqe_status(struct hinic3_rxq *rxq, u32 *cqe_done_cnt,=0D
+			    u32 *cqe_hole_cnt, u32 *head_ci, u32 *head_done);=0D
+=0D
+int hinic3_stop_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq);=0D
+=0D
+int hinic3_start_rq(struct rte_eth_dev *eth_dev, struct hinic3_rxq *rxq);=
=0D
+=0D
+u16 hinic3_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkt=
s);=0D
+=0D
+void hinic3_add_rq_to_rx_queue_list(struct hinic3_nic_dev *nic_dev,=0D
+				    u16 queue_id);=0D
+=0D
+int hinic3_refill_indir_rqid(struct hinic3_rxq *rxq);=0D
+=0D
+void hinic3_init_rx_queue_list(struct hinic3_nic_dev *nic_dev);=0D
+=0D
+void hinic3_remove_rq_from_rx_queue_list(struct hinic3_nic_dev *nic_dev,=0D
+					 u16 queue_id);=0D
+int hinic3_start_all_rqs(struct rte_eth_dev *eth_dev);=0D
+=0D
+#ifdef HINIC3_XSTAT_RXBUF_INFO=0D
+void hinic3_get_stats(struct hinic3_rxq *rxq);=0D
+#endif=0D
+=0D
+/**=0D
+ * Get receive queue local ci.=0D
+ *=0D
+ * @param[in] rxq=0D
+ * Pointer to receive queue structure.=0D
+ * @return=0D
+ * Receive queue local ci.=0D
+ */=0D
+static inline u16=0D
+hinic3_get_rq_local_ci(struct hinic3_rxq *rxq)=0D
+{=0D
+	return MASKED_QUEUE_IDX(rxq, rxq->cons_idx);=0D
+}=0D
+=0D
+static inline u16=0D
+hinic3_get_rq_free_wqebb(struct hinic3_rxq *rxq)=0D
+{=0D
+	return rxq->delta - 1;=0D
+}=0D
+=0D
+/**=0D
+ * Update receive queue local ci.=0D
+ *=0D
+ * @param[in] rxq=0D
+ * Pointer to receive queue structure.=0D
+ * @param[out] wqe_cnt=0D
+ * Wqebb counters.=0D
+ */=0D
+static inline void=0D
+hinic3_update_rq_local_ci(struct hinic3_rxq *rxq, u16 wqe_cnt)=0D
+{=0D
+	rxq->cons_idx +=3D wqe_cnt;=0D
+	rxq->delta +=3D wqe_cnt;=0D
+}=0D
+=0D
+#endif /* _HINIC3_RX_H_ */=0D
diff --git a/drivers/net/hinic3/hinic3_tx.c b/drivers/net/hinic3/hinic3_tx.=
c=0D
new file mode 100644=0D
index 0000000000..6f8c42e0c3=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_tx.c=0D
@@ -0,0 +1,274 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_ether.h>=0D
+#include <rte_io.h>=0D
+#include <rte_mbuf.h>=0D
+=0D
+#include "base/hinic3_compat.h"=0D
+#include "base/hinic3_nic_cfg.h"=0D
+#include "base/hinic3_hwdev.h"=0D
+#include "hinic3_nic_io.h"=0D
+#include "hinic3_ethdev.h"=0D
+#include "hinic3_tx.h"=0D
+=0D
+#define HINIC3_TX_TASK_WRAPPED	  1=0D
+#define HINIC3_TX_BD_DESC_WRAPPED 2=0D
+=0D
+#define TX_MSS_DEFAULT 0x3E00=0D
+#define TX_MSS_MIN     0x50=0D
+=0D
+#define HINIC3_MAX_TX_FREE_BULK 64=0D
+=0D
+#define MAX_PAYLOAD_OFFSET 221=0D
+=0D
+#define HINIC3_TX_OUTER_CHECKSUM_FLAG_SET    1=0D
+#define HINIC3_TX_OUTER_CHECKSUM_FLAG_NO_SET 0=0D
+=0D
+#define HINIC3_TX_OFFLOAD_MASK \=0D
+	(HINIC3_TX_CKSUM_OFFLOAD_MASK | HINIC3_PKT_TX_VLAN_PKT)=0D
+=0D
+#define HINIC3_TX_CKSUM_OFFLOAD_MASK                          \=0D
+	(HINIC3_PKT_TX_IP_CKSUM | HINIC3_PKT_TX_TCP_CKSUM |   \=0D
+	 HINIC3_PKT_TX_UDP_CKSUM | HINIC3_PKT_TX_SCTP_CKSUM | \=0D
+	 HINIC3_PKT_TX_OUTER_IP_CKSUM | HINIC3_PKT_TX_TCP_SEG)=0D
+=0D
+static inline u16=0D
+hinic3_get_sq_free_wqebbs(struct hinic3_txq *sq)=0D
+{=0D
+	return ((sq->q_depth -=0D
+		 (((sq->prod_idx - sq->cons_idx) + sq->q_depth) & sq->q_mask)) -=0D
+		1);=0D
+}=0D
+=0D
+static inline void=0D
+hinic3_update_sq_local_ci(struct hinic3_txq *sq, u16 wqe_cnt)=0D
+{=0D
+	sq->cons_idx +=3D wqe_cnt;=0D
+}=0D
+=0D
+static inline u16=0D
+hinic3_get_sq_local_ci(struct hinic3_txq *sq)=0D
+{=0D
+	return MASKED_QUEUE_IDX(sq, sq->cons_idx);=0D
+}=0D
+=0D
+static inline u16=0D
+hinic3_get_sq_hw_ci(struct hinic3_txq *sq)=0D
+{=0D
+	return MASKED_QUEUE_IDX(sq, hinic3_hw_cpu16(*sq->ci_vaddr_base));=0D
+}=0D
+=0D
+int=0D
+hinic3_start_all_sqs(struct rte_eth_dev *eth_dev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D NULL;=0D
+	struct hinic3_txq *txq =3D NULL;=0D
+	int i;=0D
+=0D
+	nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(eth_dev);=0D
+=0D
+	for (i =3D 0; i < nic_dev->num_sqs; i++) {=0D
+		txq =3D eth_dev->data->tx_queues[i];=0D
+		HINIC3_SET_TXQ_STARTED(txq);=0D
+		eth_dev->data->tx_queue_state[i] =3D RTE_ETH_QUEUE_STATE_STARTED;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static inline void=0D
+hinic3_free_cpy_mbuf(struct hinic3_nic_dev *nic_dev __rte_unused,=0D
+		     struct rte_mbuf *cpy_skb)=0D
+{=0D
+	rte_pktmbuf_free(cpy_skb);=0D
+}=0D
+=0D
+/**=0D
+ * Cleans up buffers (mbuf) in the send queue (txq) and returns these buff=
ers to=0D
+ * their memory pool.=0D
+ *=0D
+ * @param[in] txq=0D
+ * Point to send queue.=0D
+ * @param[in] free_cnt=0D
+ * Number of mbufs to be released.=0D
+ * @return=0D
+ * Number of released mbufs.=0D
+ */=0D
+static int=0D
+hinic3_xmit_mbuf_cleanup(struct hinic3_txq *txq, u32 free_cnt)=0D
+{=0D
+	struct hinic3_tx_info *tx_info =3D NULL;=0D
+	struct rte_mbuf *mbuf =3D NULL;=0D
+	struct rte_mbuf *mbuf_temp =3D NULL;=0D
+	struct rte_mbuf *mbuf_free[HINIC3_MAX_TX_FREE_BULK];=0D
+=0D
+	int nb_free =3D 0;=0D
+	int wqebb_cnt =3D 0;=0D
+	u16 hw_ci, sw_ci, sq_mask;=0D
+	u32 i;=0D
+=0D
+	hw_ci =3D hinic3_get_sq_hw_ci(txq);=0D
+	sw_ci =3D hinic3_get_sq_local_ci(txq);=0D
+	sq_mask =3D txq->q_mask;=0D
+=0D
+	for (i =3D 0; i < free_cnt; ++i) {=0D
+		tx_info =3D &txq->tx_info[sw_ci];=0D
+		if (hw_ci =3D=3D sw_ci ||=0D
+		    (((hw_ci - sw_ci) & sq_mask) < tx_info->wqebb_cnt))=0D
+			break;=0D
+		/*=0D
+		 * The cpy_mbuf is usually used in the arge-sized package=0D
+		 * scenario.=0D
+		 */=0D
+		if (unlikely(tx_info->cpy_mbuf !=3D NULL)) {=0D
+			hinic3_free_cpy_mbuf(txq->nic_dev, tx_info->cpy_mbuf);=0D
+			tx_info->cpy_mbuf =3D NULL;=0D
+		}=0D
+		sw_ci =3D (sw_ci + tx_info->wqebb_cnt) & sq_mask;=0D
+=0D
+		wqebb_cnt +=3D tx_info->wqebb_cnt;=0D
+		mbuf =3D tx_info->mbuf;=0D
+=0D
+		if (likely(mbuf->nb_segs =3D=3D 1)) {=0D
+			mbuf_temp =3D rte_pktmbuf_prefree_seg(mbuf);=0D
+			tx_info->mbuf =3D NULL;=0D
+			if (unlikely(mbuf_temp =3D=3D NULL))=0D
+				continue;=0D
+=0D
+			mbuf_free[nb_free++] =3D mbuf_temp;=0D
+			/*=0D
+			 * If the pools of different mbufs are different,=0D
+			 * release the mbufs of the same pool.=0D
+			 */=0D
+			if (unlikely(mbuf_temp->pool !=3D mbuf_free[0]->pool ||=0D
+				     nb_free >=3D HINIC3_MAX_TX_FREE_BULK)) {=0D
+				rte_mempool_put_bulk(mbuf_free[0]->pool,=0D
+						     (void **)mbuf_free,=0D
+						     (nb_free - 1));=0D
+				nb_free =3D 0;=0D
+				mbuf_free[nb_free++] =3D mbuf_temp;=0D
+			}=0D
+		} else {=0D
+			rte_pktmbuf_free(mbuf);=0D
+			tx_info->mbuf =3D NULL;=0D
+		}=0D
+	}=0D
+=0D
+	if (nb_free > 0)=0D
+		rte_mempool_put_bulk(mbuf_free[0]->pool, (void **)mbuf_free,=0D
+				     nb_free);=0D
+=0D
+	hinic3_update_sq_local_ci(txq, wqebb_cnt);=0D
+=0D
+	return i;=0D
+}=0D
+=0D
+static inline void=0D
+hinic3_tx_free_mbuf_force(struct hinic3_txq *txq __rte_unused,=0D
+			  struct rte_mbuf *mbuf)=0D
+{=0D
+	rte_pktmbuf_free(mbuf);=0D
+}=0D
+=0D
+/**=0D
+ * Release the mbuf and update the consumer index for sending queue.=0D
+ *=0D
+ * @param[in] txq=0D
+ * Point to send queue.=0D
+ */=0D
+void=0D
+hinic3_free_txq_mbufs(struct hinic3_txq *txq)=0D
+{=0D
+	struct hinic3_tx_info *tx_info =3D NULL;=0D
+	u16 free_wqebbs;=0D
+	u16 ci;=0D
+=0D
+	free_wqebbs =3D hinic3_get_sq_free_wqebbs(txq) + 1;=0D
+=0D
+	while (free_wqebbs < txq->q_depth) {=0D
+		ci =3D hinic3_get_sq_local_ci(txq);=0D
+=0D
+		tx_info =3D &txq->tx_info[ci];=0D
+		if (unlikely(tx_info->cpy_mbuf !=3D NULL)) {=0D
+			hinic3_free_cpy_mbuf(txq->nic_dev, tx_info->cpy_mbuf);=0D
+			tx_info->cpy_mbuf =3D NULL;=0D
+		}=0D
+		hinic3_tx_free_mbuf_force(txq, tx_info->mbuf);=0D
+		hinic3_update_sq_local_ci(txq, (u16)(tx_info->wqebb_cnt));=0D
+=0D
+		free_wqebbs =3D (u16)(free_wqebbs + tx_info->wqebb_cnt);=0D
+		tx_info->mbuf =3D NULL;=0D
+	}=0D
+}=0D
+=0D
+void=0D
+hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	u16 qid;=0D
+	for (qid =3D 0; qid < nic_dev->num_sqs; qid++)=0D
+		hinic3_free_txq_mbufs(nic_dev->txqs[qid]);=0D
+}=0D
+=0D
+int=0D
+hinic3_tx_done_cleanup(void *txq, u32 free_cnt)=0D
+{=0D
+	struct hinic3_txq *tx_queue =3D txq;=0D
+	u32 try_free_cnt =3D !free_cnt ? tx_queue->q_depth : free_cnt;=0D
+=0D
+	return hinic3_xmit_mbuf_cleanup(tx_queue, try_free_cnt);=0D
+}=0D
+=0D
+int=0D
+hinic3_stop_sq(struct hinic3_txq *txq)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D txq->nic_dev;=0D
+	unsigned long timeout;=0D
+	int err =3D -EFAULT;=0D
+	int free_wqebbs;=0D
+=0D
+	timeout =3D msecs_to_jiffies(HINIC3_FLUSH_QUEUE_TIMEOUT) + jiffies;=0D
+	do {=0D
+		hinic3_tx_done_cleanup(txq, 0);=0D
+		free_wqebbs =3D hinic3_get_sq_free_wqebbs(txq) + 1;=0D
+		if (free_wqebbs =3D=3D txq->q_depth) {=0D
+			err =3D 0;=0D
+			break;=0D
+		}=0D
+=0D
+		rte_delay_us(1);=0D
+	} while (time_before(jiffies, timeout));=0D
+=0D
+	if (err)=0D
+		PMD_DRV_LOG(WARNING,=0D
+			    "%s Wait sq empty timeout, queue_idx: %u, "=0D
+			    "sw_ci: %u, hw_ci: %u, sw_pi: %u, free_wqebbs: %u, "=0D
+			    "q_depth:%u",=0D
+			    nic_dev->dev_name, txq->q_id,=0D
+			    hinic3_get_sq_local_ci(txq),=0D
+			    hinic3_get_sq_hw_ci(txq),=0D
+			    MASKED_QUEUE_IDX(txq, txq->prod_idx), free_wqebbs,=0D
+			    txq->q_depth);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Stop all sending queues (SQs).=0D
+ *=0D
+ * @param[in] txq=0D
+ * Point to send queue.=0D
+ */=0D
+void=0D
+hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	u16 qid;=0D
+	int err;=0D
+=0D
+	for (qid =3D 0; qid < nic_dev->num_sqs; qid++) {=0D
+		err =3D hinic3_stop_sq(nic_dev->txqs[qid]);=0D
+		if (err)=0D
+			PMD_DRV_LOG(ERR, "Stop sq%d failed", qid);=0D
+	}=0D
+}=0D
diff --git a/drivers/net/hinic3/hinic3_tx.h b/drivers/net/hinic3/hinic3_tx.=
h=0D
new file mode 100644=0D
index 0000000000..f4c61ea1b1=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/hinic3_tx.h=0D
@@ -0,0 +1,314 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_TX_H_=0D
+#define _HINIC3_TX_H_=0D
+=0D
+#define MAX_SINGLE_SGE_SIZE		 65536=0D
+#define HINIC3_NONTSO_PKT_MAX_SGE	 38 /**< non-tso max sge 38. */=0D
+#define HINIC3_NONTSO_SEG_NUM_VALID(num) ((num) <=3D HINIC3_NONTSO_PKT_MAX=
_SGE)=0D
+=0D
+#define HINIC3_TSO_PKT_MAX_SGE		127 /**< tso max sge 127. */=0D
+#define HINIC3_TSO_SEG_NUM_INVALID(num) ((num) > HINIC3_TSO_PKT_MAX_SGE)=0D
+=0D
+/* Tx offload info. */=0D
+struct hinic3_tx_offload_info {=0D
+	u8 outer_l2_len;=0D
+	u8 outer_l3_type;=0D
+	u16 outer_l3_len;=0D
+=0D
+	u8 inner_l2_len;=0D
+	u8 inner_l3_type;=0D
+	u16 inner_l3_len;=0D
+=0D
+	u8 tunnel_length;=0D
+	u8 tunnel_type;=0D
+	u8 inner_l4_type;=0D
+	u8 inner_l4_len;=0D
+=0D
+	u16 payload_offset;=0D
+	u8 inner_l4_tcp_udp;=0D
+	u8 rsvd0; /**< Reserved field. */=0D
+};=0D
+=0D
+/* Tx wqe ctx. */=0D
+struct hinic3_wqe_info {=0D
+	u8 around; /**< Indicates whether the WQE is bypassed. */=0D
+	u8 cpy_mbuf_cnt;=0D
+	u16 sge_cnt;=0D
+=0D
+	u8 offload;=0D
+	u8 rsvd0; /**< Reserved field 0. */=0D
+	u16 payload_offset;=0D
+=0D
+	u8 wrapped;=0D
+	u8 owner;=0D
+	u16 pi;=0D
+=0D
+	u16 wqebb_cnt;=0D
+	u16 rsvd1; /**< Reserved field 1. */=0D
+=0D
+	u32 queue_info;=0D
+};=0D
+=0D
+/* Descriptor for the send queue of wqe. */=0D
+struct hinic3_sq_wqe_desc {=0D
+	u32 ctrl_len;=0D
+	u32 queue_info;=0D
+	u32 hi_addr;=0D
+	u32 lo_addr;=0D
+};=0D
+=0D
+/* Describes the send queue task. */=0D
+struct hinic3_sq_task {=0D
+	u32 pkt_info0;=0D
+	u32 ip_identify;=0D
+	u32 pkt_info2;=0D
+	u32 vlan_offload;=0D
+};=0D
+=0D
+/* Descriptor that describes the transmit queue buffer. */=0D
+struct hinic3_sq_bufdesc {=0D
+	u32 len;     /**< 31-bits Length, L2NIC only use length[17:0]. */=0D
+	u32 rsvd;    /**< Reserved field. */=0D
+	u32 hi_addr; /**< Upper address. */=0D
+	u32 lo_addr; /**< Lower address. */=0D
+};=0D
+=0D
+/* Compact work queue entry that describes the send queue (SQ). */=0D
+struct hinic3_sq_compact_wqe {=0D
+	struct hinic3_sq_wqe_desc wqe_desc;=0D
+};=0D
+=0D
+/* Extend work queue entry that describes the send queue (SQ). */=0D
+struct hinic3_sq_extend_wqe {=0D
+	struct hinic3_sq_wqe_desc wqe_desc;=0D
+	struct hinic3_sq_task task;=0D
+	struct hinic3_sq_bufdesc buf_desc[];=0D
+};=0D
+=0D
+struct hinic3_sq_wqe {=0D
+	union {=0D
+		struct hinic3_sq_compact_wqe compact_wqe;=0D
+		struct hinic3_sq_extend_wqe extend_wqe;=0D
+	};=0D
+};=0D
+=0D
+struct hinic3_sq_wqe_combo {=0D
+	struct hinic3_sq_wqe_desc *hdr;=0D
+	struct hinic3_sq_task *task;=0D
+	struct hinic3_sq_bufdesc *bds_head;=0D
+	u32 wqe_type;=0D
+	u32 task_type;=0D
+};=0D
+=0D
+enum sq_wqe_data_format {=0D
+	SQ_NORMAL_WQE =3D 0,=0D
+};=0D
+=0D
+/* Indicates the type of a WQE. */=0D
+enum sq_wqe_ec_type {=0D
+	SQ_WQE_COMPACT_TYPE =3D 0,=0D
+	SQ_WQE_EXTENDED_TYPE =3D 1,=0D
+};=0D
+=0D
+#define COMPACT_WQE_MAX_CTRL_LEN 0x3FFF=0D
+=0D
+/* Indicates the type of tasks with different lengths. */=0D
+enum sq_wqe_tasksect_len_type {=0D
+	SQ_WQE_TASKSECT_46BITS =3D 0,=0D
+	SQ_WQE_TASKSECT_16BYTES =3D 1,=0D
+};=0D
+=0D
+/** Setting and obtaining queue information */=0D
+#define SQ_CTRL_BD0_LEN_SHIFT	   0=0D
+#define SQ_CTRL_RSVD_SHIFT	   18=0D
+#define SQ_CTRL_BUFDESC_NUM_SHIFT  19=0D
+#define SQ_CTRL_TASKSECT_LEN_SHIFT 27=0D
+#define SQ_CTRL_DATA_FORMAT_SHIFT  28=0D
+#define SQ_CTRL_DIRECT_SHIFT	   29=0D
+#define SQ_CTRL_EXTENDED_SHIFT	   30=0D
+#define SQ_CTRL_OWNER_SHIFT	   31=0D
+=0D
+#define SQ_CTRL_BD0_LEN_MASK	  0x3FFFFU=0D
+#define SQ_CTRL_RSVD_MASK	  0x1U=0D
+#define SQ_CTRL_BUFDESC_NUM_MASK  0xFFU=0D
+#define SQ_CTRL_TASKSECT_LEN_MASK 0x1U=0D
+#define SQ_CTRL_DATA_FORMAT_MASK  0x1U=0D
+#define SQ_CTRL_DIRECT_MASK	  0x1U=0D
+#define SQ_CTRL_EXTENDED_MASK	  0x1U=0D
+#define SQ_CTRL_OWNER_MASK	  0x1U=0D
+=0D
+#define SQ_CTRL_SET(val, member) \=0D
+	(((u32)(val) & SQ_CTRL_##member##_MASK) << SQ_CTRL_##member##_SHIFT)=0D
+#define SQ_CTRL_GET(val, member) \=0D
+	(((val) >> SQ_CTRL_##member##_SHIFT) & SQ_CTRL_##member##_MASK)=0D
+#define SQ_CTRL_CLEAR(val, member) \=0D
+	((val) & (~(SQ_CTRL_##member##_MASK << SQ_CTRL_##member##_SHIFT)))=0D
+=0D
+#define SQ_CTRL_QUEUE_INFO_PKT_TYPE_SHIFT  0=0D
+#define SQ_CTRL_QUEUE_INFO_PLDOFF_SHIFT	   2=0D
+#define SQ_CTRL_QUEUE_INFO_UFO_SHIFT	   10=0D
+#define SQ_CTRL_QUEUE_INFO_TSO_SHIFT	   11=0D
+#define SQ_CTRL_QUEUE_INFO_TCPUDP_CS_SHIFT 12=0D
+#define SQ_CTRL_QUEUE_INFO_MSS_SHIFT	   13=0D
+#define SQ_CTRL_QUEUE_INFO_SCTP_SHIFT	   27=0D
+#define SQ_CTRL_QUEUE_INFO_UC_SHIFT	   28=0D
+#define SQ_CTRL_QUEUE_INFO_PRI_SHIFT	   29=0D
+=0D
+#define SQ_CTRL_QUEUE_INFO_PKT_TYPE_MASK  0x3U=0D
+#define SQ_CTRL_QUEUE_INFO_PLDOFF_MASK	  0xFFU=0D
+#define SQ_CTRL_QUEUE_INFO_UFO_MASK	  0x1U=0D
+#define SQ_CTRL_QUEUE_INFO_TSO_MASK	  0x1U=0D
+#define SQ_CTRL_QUEUE_INFO_TCPUDP_CS_MASK 0x1U=0D
+#define SQ_CTRL_QUEUE_INFO_MSS_MASK	  0x3FFFU=0D
+#define SQ_CTRL_QUEUE_INFO_SCTP_MASK	  0x1U=0D
+#define SQ_CTRL_QUEUE_INFO_UC_MASK	  0x1U=0D
+#define SQ_CTRL_QUEUE_INFO_PRI_MASK	  0x7U=0D
+=0D
+#define SQ_CTRL_QUEUE_INFO_SET(val, member)                \=0D
+	(((u32)(val) & SQ_CTRL_QUEUE_INFO_##member##_MASK) \=0D
+	 << SQ_CTRL_QUEUE_INFO_##member##_SHIFT)=0D
+#define SQ_CTRL_QUEUE_INFO_GET(val, member)               \=0D
+	(((val) >> SQ_CTRL_QUEUE_INFO_##member##_SHIFT) & \=0D
+	 SQ_CTRL_QUEUE_INFO_##member##_MASK)=0D
+#define SQ_CTRL_QUEUE_INFO_CLEAR(val, member)          \=0D
+	((val) & (~(SQ_CTRL_QUEUE_INFO_##member##_MASK \=0D
+		    << SQ_CTRL_QUEUE_INFO_##member##_SHIFT)))=0D
+=0D
+/* Setting and obtaining task information */=0D
+#define SQ_TASK_INFO0_TUNNEL_FLAG_SHIFT	    19=0D
+#define SQ_TASK_INFO0_ESP_NEXT_PROTO_SHIFT  22=0D
+#define SQ_TASK_INFO0_INNER_L4_EN_SHIFT	    24=0D
+#define SQ_TASK_INFO0_INNER_L3_EN_SHIFT	    25=0D
+#define SQ_TASK_INFO0_INNER_L4_PSEUDO_SHIFT 26=0D
+#define SQ_TASK_INFO0_OUT_L4_EN_SHIFT	    27=0D
+#define SQ_TASK_INFO0_OUT_L3_EN_SHIFT	    28=0D
+#define SQ_TASK_INFO0_OUT_L4_PSEUDO_SHIFT   29=0D
+#define SQ_TASK_INFO0_ESP_OFFLOAD_SHIFT	    30=0D
+#define SQ_TASK_INFO0_IPSEC_PROTO_SHIFT	    31=0D
+=0D
+#define SQ_TASK_INFO0_TUNNEL_FLAG_MASK	   0x1U=0D
+#define SQ_TASK_INFO0_ESP_NEXT_PROTO_MASK  0x3U=0D
+#define SQ_TASK_INFO0_INNER_L4_EN_MASK	   0x1U=0D
+#define SQ_TASK_INFO0_INNER_L3_EN_MASK	   0x1U=0D
+#define SQ_TASK_INFO0_INNER_L4_PSEUDO_MASK 0x1U=0D
+#define SQ_TASK_INFO0_OUT_L4_EN_MASK	   0x1U=0D
+#define SQ_TASK_INFO0_OUT_L3_EN_MASK	   0x1U=0D
+#define SQ_TASK_INFO0_OUT_L4_PSEUDO_MASK   0x1U=0D
+#define SQ_TASK_INFO0_ESP_OFFLOAD_MASK	   0x1U=0D
+#define SQ_TASK_INFO0_IPSEC_PROTO_MASK	   0x1U=0D
+=0D
+#define SQ_TASK_INFO0_SET(val, member)                \=0D
+	(((u32)(val) & SQ_TASK_INFO0_##member##_MASK) \=0D
+	 << SQ_TASK_INFO0_##member##_SHIFT)=0D
+#define SQ_TASK_INFO0_GET(val, member)               \=0D
+	(((val) >> SQ_TASK_INFO0_##member##_SHIFT) & \=0D
+	 SQ_TASK_INFO0_##member##_MASK)=0D
+=0D
+#define SQ_TASK_INFO1_SET(val, member)           \=0D
+	(((val) & SQ_TASK_INFO1_##member##_MASK) \=0D
+	 << SQ_TASK_INFO1_##member##_SHIFT)=0D
+#define SQ_TASK_INFO1_GET(val, member)               \=0D
+	(((val) >> SQ_TASK_INFO1_##member##_SHIFT) & \=0D
+	 SQ_TASK_INFO1_##member##_MASK)=0D
+=0D
+#define SQ_TASK_INFO3_VLAN_TAG_SHIFT	   0=0D
+#define SQ_TASK_INFO3_VLAN_TYPE_SHIFT	   16=0D
+#define SQ_TASK_INFO3_VLAN_TAG_VALID_SHIFT 19=0D
+=0D
+#define SQ_TASK_INFO3_VLAN_TAG_MASK	  0xFFFFU=0D
+#define SQ_TASK_INFO3_VLAN_TYPE_MASK	  0x7U=0D
+#define SQ_TASK_INFO3_VLAN_TAG_VALID_MASK 0x1U=0D
+=0D
+#define SQ_TASK_INFO3_SET(val, member)           \=0D
+	(((val) & SQ_TASK_INFO3_##member##_MASK) \=0D
+	 << SQ_TASK_INFO3_##member##_SHIFT)=0D
+#define SQ_TASK_INFO3_GET(val, member)               \=0D
+	(((val) >> SQ_TASK_INFO3_##member##_SHIFT) & \=0D
+	 SQ_TASK_INFO3_##member##_MASK)=0D
+=0D
+/* Defines the TX queue status. */=0D
+enum hinic3_txq_status {=0D
+	HINIC3_TXQ_STATUS_START =3D 0,=0D
+	HINIC3_TXQ_STATUS_STOP,=0D
+};=0D
+=0D
+/* Setting and obtaining status information. */=0D
+#define HINIC3_TXQ_IS_STARTED(txq)  ((txq)->status =3D=3D HINIC3_TXQ_STATU=
S_START)=0D
+#define HINIC3_TXQ_IS_STOPPED(txq)  ((txq)->status =3D=3D HINIC3_TXQ_STATU=
S_STOP)=0D
+#define HINIC3_SET_TXQ_STARTED(txq) ((txq)->status =3D HINIC3_TXQ_STATUS_S=
TART)=0D
+#define HINIC3_SET_TXQ_STOPPED(txq) ((txq)->status =3D HINIC3_TXQ_STATUS_S=
TOP)=0D
+=0D
+#define HINIC3_FLUSH_QUEUE_TIMEOUT 3000=0D
+=0D
+/* Txq info. */=0D
+struct hinic3_txq_stats {=0D
+	u64 packets;=0D
+	u64 bytes;=0D
+	u64 tx_busy;=0D
+	u64 offload_errors;=0D
+	u64 burst_pkts;=0D
+	u64 sge_len0;=0D
+	u64 mbuf_null;=0D
+	u64 cpy_pkts;=0D
+	u64 sge_len_too_large;=0D
+=0D
+#ifdef HINIC3_XSTAT_PROF_TX=0D
+	u64 app_tsc;=0D
+	u64 pmd_tsc;=0D
+#endif=0D
+=0D
+#ifdef HINIC3_XSTAT_MBUF_USE=0D
+	u64 tx_left_mbuf_bytes;=0D
+#endif=0D
+};=0D
+=0D
+/* Structure for storing the information sent. */=0D
+struct hinic3_tx_info {=0D
+	struct rte_mbuf *mbuf;=0D
+	struct rte_mbuf *cpy_mbuf;=0D
+	int wqebb_cnt;=0D
+};=0D
+=0D
+/* Indicates the sending queue of information. */=0D
+struct __rte_cache_aligned hinic3_txq {=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	u16 q_id;=0D
+	u16 q_depth;=0D
+	u16 q_mask;=0D
+	u16 wqebb_size;=0D
+	u16 wqebb_shift;=0D
+	u16 cons_idx;=0D
+	u16 prod_idx;=0D
+	u16 status;=0D
+=0D
+	u16 tx_free_thresh;=0D
+	u16 owner;=0D
+	void *db_addr;=0D
+	struct hinic3_tx_info *tx_info;=0D
+=0D
+	const struct rte_memzone *sq_mz;=0D
+	void *queue_buf_vaddr;=0D
+	rte_iova_t queue_buf_paddr;=0D
+=0D
+	const struct rte_memzone *ci_mz;=0D
+	volatile u16 *ci_vaddr_base;=0D
+	rte_iova_t ci_dma_base;=0D
+	u64 sq_head_addr;=0D
+	u64 sq_bot_sge_addr;=0D
+	u32 cos;=0D
+	struct hinic3_txq_stats txq_stats;=0D
+#ifdef HINIC3_XSTAT_PROF_TX=0D
+	uint64_t prof_tx_end_tsc;=0D
+#endif=0D
+};=0D
+=0D
+void hinic3_flush_txqs(struct hinic3_nic_dev *nic_dev);=0D
+void hinic3_free_txq_mbufs(struct hinic3_txq *txq);=0D
+void hinic3_free_all_txq_mbufs(struct hinic3_nic_dev *nic_dev);=0D
+int hinic3_stop_sq(struct hinic3_txq *txq);=0D
+int hinic3_start_all_sqs(struct rte_eth_dev *eth_dev);=0D
+int hinic3_tx_done_cleanup(void *txq, uint32_t free_cnt);=0D
+#endif /**< _HINIC3_TX_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

