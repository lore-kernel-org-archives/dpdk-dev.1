Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2684CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B667406B6;
	Sat, 10 Oct 2026 16:45:26 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id C24684028C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=t3zxqEn5u+gVkiVFFH3K+SqNRS0HuCHUhl6By28yfHE=;
 b=NoNRNxyVxGugtEckiQHHkFfxj+e2eR9/Cu9/NpYP8DOlwW5kPLaROSSBXi8Amp
 snHg7E4RlNDKgMCEKbvtiCTUKl9zj7l4rXCoZAdDTnC1EQejjdv7wJUUlp4lJRir
 fG7p7HYm7bypVkhRJnsfA7Dd4QSECnMsqf02MPwuHHQpQ=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 08/17] net/hinic3: update RSS hash type configuration
Date: Sat, 10 Oct 2026 22:44:59 +0800
Message-ID: <20261010144509.2731-9-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S10
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF13WF4rtr4UArWktw1kKrg_yoW7tF47p3
 y8G3y7JrWDtrWrXwn5Xa1UCa15Zw4kC3yIgw12q3sYkF4kZr18Aa45Cay8Arn0gFWxX3W2
 v3yrZ3s8K3WYy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMGQgUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNBxASmrKT3wssgAA3v
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

The aggregated compact CQE does not expose a readable RSS hash flags field.=
=0D
To keep the same behavior as the normal CQE, always enable ipv6_ext and=0D
tcp_ipv6_ext (every tile supports them) and save the configured RSS hash=0D
flags in software state.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 doc/guides/rel_notes/release_26_11.rst   |  1 +=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h | 21 +++++++++++++--------=0D
 drivers/net/hinic3/hinic3_ethdev.c       | 17 +++++------------=0D
 drivers/net/hinic3/hinic3_ethdev.h       |  2 ++=0D
 drivers/net/hinic3/hinic3_rx.c           | 12 ++++--------=0D
 5 files changed, 25 insertions(+), 28 deletions(-)=0D
=0D
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst=0D
index e1132b379a..80530ac25d 100644=0D
--- a/doc/guides/rel_notes/release_26_11.rst=0D
+++ b/doc/guides/rel_notes/release_26_11.rst=0D
@@ -97,6 +97,7 @@ New Features=0D
   * Added CIR drop statistics and VF link aggregation (LAG) support.=0D
   * Added FEC mode get and set support.=0D
   * Added Class of Service (COS) mask and map support.=0D
+  * Updated RSS hash type configuration.=0D
 =0D
 * **Updated Intel iavf driver.**=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/=
base/hinic3_nic_cfg.h=0D
index 42a7b7010d..ecd410785f 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
@@ -73,14 +73,19 @@=0D
 	HINIC3_SUPPORT_FEATURE(dev, IPXIP_OFFLOAD)=0D
 =0D
 struct hinic3_rss_type {=0D
-	uint8_t tcp_ipv6_ext;=0D
-	uint8_t ipv6_ext;=0D
-	uint8_t tcp_ipv6;=0D
-	uint8_t ipv6;=0D
-	uint8_t tcp_ipv4;=0D
-	uint8_t ipv4;=0D
-	uint8_t udp_ipv6;=0D
-	uint8_t udp_ipv4;=0D
+	union {=0D
+		struct {=0D
+			uint8_t tcp_ipv6_ext;=0D
+			uint8_t ipv6_ext;=0D
+			uint8_t tcp_ipv6;=0D
+			uint8_t ipv6;=0D
+			uint8_t tcp_ipv4;=0D
+			uint8_t ipv4;=0D
+			uint8_t udp_ipv6;=0D
+			uint8_t udp_ipv4;=0D
+		};=0D
+		uint64_t val;=0D
+	};=0D
 };=0D
 =0D
 enum hinic3_rss_hash_type {=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index d7dbd945bc..9adfe7db41 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -2671,19 +2671,14 @@ hinic3_rss_hash_update(struct rte_eth_dev *dev,=0D
 	rss_type.tcp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;=0D
 	rss_type.udp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;=0D
 	rss_type.udp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;=0D
-=0D
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {=0D
-		rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
-		rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
-	} else {=0D
-		rss_type.ipv6_ext =3D 0;=0D
-		rss_type.tcp_ipv6_ext =3D 0;=0D
-	}=0D
+	rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
+	rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
 =0D
 	err =3D hinic3_set_rss_type(nic_dev->hwdev, rss_type);=0D
 	if (err)=0D
 		PMD_DRV_LOG(ERR, "Set RSS type failed");=0D
 =0D
+	nic_dev->rss_type =3D rss_type;=0D
 	return err;=0D
 }=0D
 =0D
@@ -2739,10 +2734,8 @@ hinic3_rss_conf_get(struct rte_eth_dev *dev, struct =
rte_eth_rss_conf *rss_conf)=0D
 	rss_conf->rss_hf |=3D rss_type.tcp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_TCP : =
0;=0D
 	rss_conf->rss_hf |=3D rss_type.udp_ipv4 ? RTE_ETH_RSS_NONFRAG_IPV4_UDP : =
0;=0D
 	rss_conf->rss_hf |=3D rss_type.udp_ipv6 ? RTE_ETH_RSS_NONFRAG_IPV6_UDP : =
0;=0D
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {=0D
-		rss_conf->rss_hf |=3D rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;=0D
-		rss_conf->rss_hf |=3D rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : =
0;=0D
-	}=0D
+	rss_conf->rss_hf |=3D rss_type.ipv6_ext ? RTE_ETH_RSS_IPV6_EX : 0;=0D
+	rss_conf->rss_hf |=3D rss_type.tcp_ipv6_ext ? RTE_ETH_RSS_IPV6_TCP_EX : 0=
;=0D
 =0D
 	return 0;=0D
 }=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 57f46aa850..b38853f556 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -9,6 +9,7 @@=0D
 #include <rte_ethdev_core.h>=0D
 =0D
 #include "hinic3_fdir.h"=0D
+#include "base/hinic3_nic_cfg.h"=0D
 =0D
 #define HINIC3_PMD_DRV_VERSION "B106"=0D
 =0D
@@ -124,6 +125,7 @@ struct hinic3_nic_dev {=0D
 	uint16_t num_rss; /**< Number of RSS queues. */=0D
 =0D
 	uint32_t rx_mode;=0D
+	struct hinic3_rss_type rss_type;=0D
 	uint8_t rx_queue_list[HINIC3_MAX_QUEUE_NUM];=0D
 	rte_spinlock_t queue_list_lock;=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_rx.c b/drivers/net/hinic3/hinic3_rx.=
c=0D
index ed753ba4ec..57e50590cd 100644=0D
--- a/drivers/net/hinic3/hinic3_rx.c=0D
+++ b/drivers/net/hinic3/hinic3_rx.c=0D
@@ -437,16 +437,11 @@ hinic3_init_rss_type(struct hinic3_nic_dev *nic_dev,=
=0D
 	rss_type.tcp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP) ? 1 : 0;=0D
 	rss_type.udp_ipv4 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP) ? 1 : 0;=0D
 	rss_type.udp_ipv6 =3D (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP) ? 1 : 0;=0D
-=0D
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ) {=0D
-		rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
-		rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
-	} else {=0D
-		rss_type.ipv6_ext =3D 0;=0D
-		rss_type.tcp_ipv6_ext =3D 0;=0D
-	}=0D
+	rss_type.ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_EX) ? 1 : 0;=0D
+	rss_type.tcp_ipv6_ext =3D (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX) ? 1 : 0;=0D
 =0D
 	err =3D hinic3_set_rss_type(nic_dev->hwdev, rss_type);=0D
+	nic_dev->rss_type =3D rss_type;=0D
 	return err;=0D
 }=0D
 =0D
@@ -1056,6 +1051,7 @@ hinic3_rx_get_compact_cqe_info(struct hinic3_rxq *rxq=
, volatile struct hinic3_rq=0D
 	cqe_info->pkt_len =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PKT_LEN);=0D
 	cqe_info->ts_flag =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, TS_FLAG);=0D
 	cqe_info->ptype =3D HINIC3_RQ_COMPACT_CQE_STATUS_GET(dw0, PTYPE);=0D
+	cqe_info->rss_type =3D (rxq->nic_dev->rss_type.val !=3D 0) ? 1 : 0;=0D
 	cqe_info->rss_hash_value =3D dw1;=0D
 =0D
 	if (cqe_info->cqe_len =3D=3D HINIC3_RQ_COMPACT_CQE_16BYTE) {=0D
-- =0D
2.33.0=0D
=0D

