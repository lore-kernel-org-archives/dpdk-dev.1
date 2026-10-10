Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBF9CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35B6540A67;
	Sat, 10 Oct 2026 16:45:27 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 9A074402DC
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=A7fvlXYQ3JcIingTMugcy7WFCr9BQiNUHxYxY1VgESY=;
 b=E59PyXexhqIwgjeBVXU3dnBB68qBuuKLQ4nrn6WspmtKjP8HGsr/5K6H1mnne1
 cP/c5DsrJtA7NHA/6Kx1lHH8p+6DgCjhA96V5wlHeJSkDfCRG+XwmeBJfaqdo3Is
 FriuRuS+11Se7EIPWCKqSENeqr9wCDROJ9lOChYb4sYWY=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 09/17] net/hinic3: refactor flow rule parsing
Date: Sat, 10 Oct 2026 22:45:00 +0800
Message-ID: <20261010144509.2731-10-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S11
X-Coremail-Antispam: 1Uf129KBjvAXoWfKFW7CryUZw4xJw18JF47urg_yoW7uFykWo
 WfXr4rtr1rtr4fCw4j9rWxAasrX3yq9a1rtFWagwsFqa1Ut34rtFs3JF4rA3yj93y5JrnI
 yFy8Jan8tFsrX3Z5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2SdgDUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNB1ASmrKT30stAAA3p
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

The flow rule parser was based on a fixed hardcoded pattern table that was=
=0D
hard to extend. Replace it with a simpler protocol-graph classifier, and=0D
add IP-in-IP and Geneve tunnel patterns.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h |   2 +-=0D
 drivers/net/hinic3/hinic3_ethdev.h       |  12 +=0D
 drivers/net/hinic3/hinic3_fdir.c         | 158 ++++--=0D
 drivers/net/hinic3/hinic3_fdir.h         |  19 +-=0D
 drivers/net/hinic3/hinic3_flow.c         | 581 +++++++++++++++++------=0D
 drivers/net/hinic3/hinic3_flow.h         | 196 --------=0D
 6 files changed, 573 insertions(+), 395 deletions(-)=0D
 delete mode 100644 drivers/net/hinic3/hinic3_flow.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/=
base/hinic3_nic_cfg.h=0D
index ecd410785f..ef139b25b9 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
@@ -938,7 +938,7 @@ struct hinic3_set_fdir_ethertype_rule {=0D
 	uint8_t pkt_type_en;=0D
 	uint8_t pkt_type;=0D
 	uint8_t qid;=0D
-	uint8_t rsvd2;=0D
+	uint8_t flags;=0D
 };=0D
 =0D
 struct hinic3_cmd_set_rq_flush {=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index b38853f556..34c74f95d9 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -107,6 +107,13 @@ enum nic_feature_cap {=0D
 TAILQ_HEAD(hinic3_ethertype_filter_list, rte_flow);=0D
 TAILQ_HEAD(hinic3_fdir_rule_filter_list, rte_flow);=0D
 =0D
+enum nic_type {=0D
+	NIC_SP620 =3D 0,=0D
+	NIC_SP560 =3D 1,=0D
+	NIC_SP230 =3D 2,=0D
+	NIC_UNKNOWN =3D 3,=0D
+};=0D
+=0D
 struct hinic3_nic_dev {=0D
 	struct hinic3_hwdev *hwdev; /**< Hardware device. */=0D
 	struct hinic3_txq **txqs;=0D
@@ -156,12 +163,17 @@ struct hinic3_nic_dev {=0D
 	struct hinic3_nic_rx_ops *rx_ops;=0D
 	struct hinic3_nic_tx_ops *tx_ops;=0D
 	uint32_t fec_mode;  /**< Current FEC mode for ethdev. */=0D
+	enum nic_type nic_type; /**< NIC type. */=0D
 =0D
 };=0D
 =0D
 #define SELECT_OTHER_COS_ID(cos_id) ((cos_id) ^ 4)=0D
 #define ODD_NUMBER_QUEUE_ID(q_id) ((q_id) & 1)=0D
 =0D
+#define HINIC3_IS_SP620_NIC(nic_dev) ((nic_dev)->nic_type =3D=3D NIC_SP620=
)=0D
+#define HINIC3_IS_SP560_NIC(nic_dev) ((nic_dev)->nic_type =3D=3D NIC_SP560=
)=0D
+#define HINIC3_IS_SP230_NIC(nic_dev) ((nic_dev)->nic_type =3D=3D NIC_SP230=
)=0D
+=0D
 extern const struct rte_flow_ops hinic3_flow_ops;=0D
 =0D
 /**=0D
diff --git a/drivers/net/hinic3/hinic3_fdir.c b/drivers/net/hinic3/hinic3_f=
dir.c=0D
index 71d50a3d22..baa86c0c81 100644=0D
--- a/drivers/net/hinic3/hinic3_fdir.c=0D
+++ b/drivers/net/hinic3/hinic3_fdir.c=0D
@@ -77,8 +77,6 @@ hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *rul=
e,=0D
 	/* Fill type of ip. */=0D
 	tcam_key->key_mask.ip_type =3D HINIC3_UINT1_MAX;=0D
 	tcam_key->key_info.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
-	tcam_key->key_mask.vlan_flag =3D HINIC3_UINT1_MAX;=0D
-	tcam_key->key_info.vlan_flag =3D 0;=0D
 =0D
 	/* Fill src IPv4. */=0D
 	tcam_key->key_mask.sipv4_h =3D=0D
@@ -101,8 +99,9 @@ hinic3_fdir_tcam_ipv4_init(struct hinic3_fdir_filter *ru=
le,=0D
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv4.dst_ip);=0D
 }=0D
 =0D
-static void hinic3_fdir_ipv6_tcam_key_init_sip(struct hinic3_fdir_filter *=
rule,=0D
-					       struct hinic3_tcam_key *tcam_key)=0D
+static inline void=0D
+hinic3_fdir_ipv6_tcam_key_init_sip(struct hinic3_fdir_filter *rule,=0D
+				   struct hinic3_tcam_key *tcam_key)=0D
 {=0D
 	tcam_key->key_mask_ipv6.sipv6_key0 =3D=0D
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.src_ip[0]);=0D
@@ -138,8 +137,9 @@ static void hinic3_fdir_ipv6_tcam_key_init_sip(struct h=
inic3_fdir_filter *rule,=0D
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.src_ip[0x3]);=0D
 }=0D
 =0D
-static void hinic3_fdir_ipv6_tcam_key_init_dip(struct hinic3_fdir_filter *=
rule,=0D
-					       struct hinic3_tcam_key *tcam_key)=0D
+static inline void=0D
+hinic3_fdir_ipv6_tcam_key_init_dip(struct hinic3_fdir_filter *rule,=0D
+				   struct hinic3_tcam_key *tcam_key)=0D
 {=0D
 	tcam_key->key_mask_ipv6.dipv6_key0 =3D=0D
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.ipv6.dst_ip[0]);=0D
@@ -175,8 +175,9 @@ static void hinic3_fdir_ipv6_tcam_key_init_dip(struct h=
inic3_fdir_filter *rule,=0D
 		HINIC3_32_LOWER_16_BITS(rule->key_spec.ipv6.dst_ip[0x3]);=0D
 }=0D
 =0D
-static void hinic3_fdir_ipv6_tcam_key_init(struct hinic3_fdir_filter *rule=
,=0D
-					   struct hinic3_tcam_key *tcam_key)=0D
+static void=0D
+hinic3_fdir_ipv6_tcam_key_init(struct hinic3_fdir_filter *rule,=0D
+			       struct hinic3_tcam_key *tcam_key)=0D
 {=0D
 	hinic3_fdir_ipv6_tcam_key_init_sip(rule, tcam_key);=0D
 	hinic3_fdir_ipv6_tcam_key_init_dip(rule, tcam_key);=0D
@@ -189,8 +190,6 @@ hinic3_fdir_tcam_ipv6_init(struct hinic3_fdir_filter *r=
ule,=0D
 	/* Fill type of ip. */=0D
 	tcam_key->key_mask_ipv6.ip_type =3D HINIC3_UINT1_MAX;=0D
 	tcam_key->key_info_ipv6.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
-	tcam_key->key_mask_ipv6.vlan_flag =3D HINIC3_UINT1_MAX;=0D
-	tcam_key->key_info_ipv6.vlan_flag =3D 0;=0D
 =0D
 	hinic3_fdir_ipv6_tcam_key_init(rule, tcam_key);=0D
 }=0D
@@ -240,15 +239,11 @@ hinic3_fdir_tcam_notunnel_init(struct rte_eth_dev *de=
v,=0D
 }=0D
 =0D
 static void=0D
-hinic3_fdir_tcam_vxlan_ipv4_init(struct hinic3_fdir_filter *rule,=0D
+hinic3_fdir_tcam_vxlan_geneve_ipv4_init(struct hinic3_fdir_filter *rule,=0D
 				 struct hinic3_tcam_key *tcam_key)=0D
 {=0D
-	/* Fill type of ip. */=0D
 	tcam_key->key_mask.ip_type =3D HINIC3_UINT1_MAX;=0D
 	tcam_key->key_info.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
-	tcam_key->key_mask.vlan_flag =3D HINIC3_UINT1_MAX;=0D
-	tcam_key->key_info.vlan_flag =3D 0;=0D
-=0D
 	/* Fill src ipv4. */=0D
 	tcam_key->key_mask.sipv4_h =3D=0D
 		HINIC3_32_UPPER_16_BITS(rule->key_mask.inner_ipv4.src_ip);=0D
@@ -271,14 +266,12 @@ hinic3_fdir_tcam_vxlan_ipv4_init(struct hinic3_fdir_f=
ilter *rule,=0D
 }=0D
 =0D
 static void=0D
-hinic3_fdir_tcam_vxlan_ipv6_init(struct hinic3_fdir_filter *rule,=0D
+hinic3_fdir_tcam_vxlan_geneve_ipv6_init(struct hinic3_fdir_filter *rule,=0D
 				 struct hinic3_tcam_key *tcam_key)=0D
 {=0D
 	/* Fill type of ip. */=0D
 	tcam_key->key_mask_vxlan_ipv6.ip_type =3D HINIC3_UINT1_MAX;=0D
 	tcam_key->key_info_vxlan_ipv6.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
-	tcam_key->key_mask_vxlan_ipv6.vlan_flag =3D HINIC3_UINT1_MAX;=0D
-	tcam_key->key_info_vxlan_ipv6.vlan_flag =3D 0;=0D
 =0D
 	/* Use inner dst ipv6 to fill the dst ipv6 of tcam_key. */=0D
 	tcam_key->key_mask_vxlan_ipv6.dipv6_key0 =3D=0D
@@ -359,7 +352,7 @@ hinic3_fdir_tcam_ipv6_vxlan_init(struct rte_eth_dev *de=
v,=0D
  * Pointer to the TCAM key.=0D
  */=0D
 static void=0D
-hinic3_fdir_tcam_vxlan_init(struct rte_eth_dev *dev,=0D
+hinic3_fdir_tcam_vxlan_geneve_init(struct rte_eth_dev *dev,=0D
 			    struct hinic3_fdir_filter *rule,=0D
 			    struct hinic3_tcam_key *tcam_key)=0D
 {=0D
@@ -416,10 +409,10 @@ hinic3_fdir_tcam_vxlan_init(struct rte_eth_dev *dev,=
=0D
 					 HINIC3_UINT15_MAX;=0D
 =0D
 	if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV4)=0D
-		hinic3_fdir_tcam_vxlan_ipv4_init(rule, tcam_key);=0D
+		hinic3_fdir_tcam_vxlan_geneve_ipv4_init(rule, tcam_key);=0D
 =0D
 	else if (rule->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV6)=0D
-		hinic3_fdir_tcam_vxlan_ipv6_init(rule, tcam_key);=0D
+		hinic3_fdir_tcam_vxlan_geneve_ipv6_init(rule, tcam_key);=0D
 }=0D
 =0D
 static void=0D
@@ -432,7 +425,7 @@ hinic3_fdir_tcam_info_init(struct rte_eth_dev *dev,=0D
 	if (rule->tunnel_type =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL)=0D
 		hinic3_fdir_tcam_notunnel_init(dev, rule, tcam_key);=0D
 	else=0D
-		hinic3_fdir_tcam_vxlan_init(dev, rule, tcam_key);=0D
+		hinic3_fdir_tcam_vxlan_geneve_init(dev, rule, tcam_key);=0D
 =0D
 	/* Set the queue index. */=0D
 	fdir_tcam_rule->data.qid =3D rule->rq_index;=0D
@@ -693,6 +686,16 @@ hinic3_fdir_tcam_info_htn_init(struct rte_eth_dev *dev=
,=0D
 	tcam_key_calculate(tcam_key, fdir_tcam_rule);=0D
 }=0D
 =0D
+static void hinic3_fdir_tcam_key_get(struct rte_eth_dev *dev,=0D
+				     struct hinic3_fdir_filter *rule,=0D
+				     struct hinic3_tcam_key *tcam_key)=0D
+{=0D
+	if (rule->tunnel_type =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL)=0D
+		hinic3_fdir_tcam_notunnel_init(dev, rule, tcam_key);=0D
+	else=0D
+		hinic3_fdir_tcam_vxlan_geneve_init(dev, rule, tcam_key);=0D
+}=0D
+=0D
 /**=0D
  * Find filter in given ethertype filter list.=0D
  *=0D
@@ -841,7 +844,7 @@ hinic3_dynamic_lookup_tcam_filter(struct hinic3_nic_dev=
 *nic_dev,=0D
 	 * capacity of dynamic TCAM blocks.=0D
 	 */=0D
 	if (rule_nums >=3D block_cnt * HINIC3_TCAM_DYNAMIC_BLOCK_SIZE) {=0D
-		if (block_cnt >=3D (HINIC3_TCAM_DYNAMIC_MAX_FILTERS /=0D
+		if (block_cnt >=3D (HINIC3_TCAM_DYNAMIC_MAX_FILTERS(nic_dev) /=0D
 				  HINIC3_TCAM_DYNAMIC_BLOCK_SIZE)) {=0D
 			PMD_DRV_LOG(ERR,=0D
 				"Dynamic tcam block is full, alloc failed!");=0D
@@ -992,6 +995,10 @@ hinic3_set_fdir_ethertype_filter(void *hwdev, uint8_t =
pkt_type, void *filter, ui=0D
 	ethertype_cmd.pkt_type_en =3D en;=0D
 	ethertype_cmd.index =3D index;=0D
 	ethertype_cmd.qid =3D (uint8_t)ethertype_filter->queue;=0D
+	if (en =3D=3D 0)=0D
+		ethertype_cmd.flags =3D 0;=0D
+	else=0D
+		ethertype_cmd.flags =3D (uint8_t)ethertype_filter->flags;=0D
 =0D
 	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,=0D
 				     HINIC3_NIC_CMD_SET_FDIR_STATUS,=0D
@@ -1001,6 +1008,9 @@ hinic3_set_fdir_ethertype_filter(void *hwdev, uint8_t=
 pkt_type, void *filter, ui=0D
 		PMD_DRV_LOG(ERR,=0D
 			    "set fdir ethertype rule failed, err: %d, status: 0x%x, out size: 0=
x%x, func_id %d",=0D
 			    err, ethertype_cmd.head.status, out_size, ethertype_cmd.func_id);=0D
+		if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) !=3D 0 && en !=
=3D 0)=0D
+			hinic3_tcam_index_free(nic_dev, HINIC3_TCAM_GET_INDEX_IN_BLOCK(index),=
=0D
+				HINIC3_TCAM_GET_DYNAMIC_BLOCK_INDEX(index));=0D
 		return -EIO;=0D
 	}=0D
 	if ((hinic3_get_driver_feature(nic_dev) & NIC_F_HTN_FDIR) !=3D 0) {=0D
@@ -1213,24 +1223,16 @@ hinic3_flow_add_del_fdir_filter(struct rte_eth_dev =
*dev,=0D
 	else=0D
 		hinic3_fdir_tcam_info_htn_init(dev, fdir_filter, &tcam_key, &fdir_tcam_r=
ule);=0D
 =0D
-	/* Search for a filter. */=0D
-	tcam_filter =3D=0D
-		hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_key,=0D
-					  HINIC3_ACTION_ADD, HINIC3_INVALID_INDEX);=0D
-	if (tcam_filter !=3D NULL && add) {=0D
-		PMD_DRV_LOG(ERR, "Filter exists.");=0D
-		return -EEXIST;=0D
-	}=0D
-	if (tcam_filter =3D=3D NULL && !add) {=0D
-		PMD_DRV_LOG(ERR, "Filter doesn't exist.");=0D
-		return -ENOENT;=0D
-	}=0D
-=0D
-	/*=0D
-	 * If the value of Add is true, the system performs the adding=0D
-	 * operation.=0D
-	 */=0D
 	if (add) {=0D
+		/* Search for a filter. */=0D
+		tcam_filter =3D=0D
+			hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_key,=0D
+						  HINIC3_ACTION_ADD, HINIC3_INVALID_INDEX);=0D
+		if (tcam_filter !=3D NULL) {=0D
+			PMD_DRV_LOG(ERR, "Filter exists.");=0D
+			return -EEXIST;=0D
+		}=0D
+=0D
 		ret =3D hinic3_add_tcam_filter(dev, &tcam_key, &fdir_tcam_rule);=0D
 		if (ret)=0D
 			goto cfg_tcam_filter_err;=0D
@@ -1594,6 +1596,11 @@ hinic3_flow_add_del_ethertype_filter(struct rte_eth_=
dev *dev,=0D
 	/* Get dev private info. */=0D
 	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
 	int ret;=0D
+=0D
+	if (!ethertype_filter) {=0D
+		PMD_DRV_LOG(ERR, "ethertype_filter is NULL");=0D
+		return -EINVAL;=0D
+	}=0D
 	/* Add or remove an Ethernet type filter rule. */=0D
 	ret =3D hinic3_flow_add_del_ethertype_filter_rule(dev, ethertype_filter, =
add);=0D
 =0D
@@ -1641,3 +1648,74 @@ hinic3_flow_add_del_ethertype_filter(struct rte_eth_=
dev *dev,=0D
 	hinic3_flow_add_del_ethertype_filter_rule(dev, ethertype_filter, !add);=0D
 	return ret;=0D
 }=0D
+=0D
+int=0D
+hinic3_flow_query_fdir_filter(struct rte_eth_dev *dev, struct hinic3_fdir_=
filter *fdir_filter,=0D
+			      __rte_unused uint64_t *hits, __rte_unused uint64_t *bytes_count)=
=0D
+{=0D
+	struct hinic3_tcam_info	  *tcam_info =3D=0D
+		HINIC3_DEV_PRIVATE_TO_TCAM_INFO(dev->data->dev_private);=0D
+	struct hinic3_nic_dev	  *nic_dev   =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(=
dev);=0D
+	struct hinic3_tcam_filter *tcam_filter;=0D
+	struct hinic3_tcam_key	   tcam_key;=0D
+=0D
+	memset((void *)&tcam_key, 0, sizeof(struct hinic3_tcam_key));=0D
+	hinic3_fdir_tcam_key_get(dev, fdir_filter, &tcam_key);=0D
+	tcam_filter =3D hinic3_tcam_filter_lookup(&tcam_info->tcam_list, &tcam_ke=
y,=0D
+						HINIC3_ACTION_NOT_ADD, fdir_filter->tcam_index);=0D
+	if (tcam_filter =3D=3D NULL) {=0D
+		PMD_DRV_LOG(ERR, "Filter doesn't exist.");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	if (fdir_filter->ip_type =3D=3D HINIC3_FDIR_IP_TYPE_IPV4) {=0D
+		PMD_DRV_LOG(INFO, "fdir ipv4 flow get:");=0D
+		PMD_DRV_LOG(INFO, "glb index:%d", fdir_filter->tcam_index);=0D
+		PMD_DRV_LOG(INFO, "ether_type mask: 0x%x", fdir_filter->key_mask.ether_t=
ype);=0D
+		PMD_DRV_LOG(INFO, "ether_type spec: 0x%x", fdir_filter->key_spec.ether_t=
ype);=0D
+		PMD_DRV_LOG(INFO, "protocol mask: 0x%x", fdir_filter->key_mask.ipv4.prot=
o);=0D
+		PMD_DRV_LOG(INFO, "protocol spec: 0x%x", fdir_filter->key_spec.ipv4.prot=
o);=0D
+		PMD_DRV_LOG(INFO, "src_ip mask: 0x%x", fdir_filter->key_mask.ipv4.src_ip=
);=0D
+		PMD_DRV_LOG(INFO, "src_ip spec: 0x%x", fdir_filter->key_spec.ipv4.src_ip=
);=0D
+		PMD_DRV_LOG(INFO, "dst_ip mask: 0x%x", fdir_filter->key_mask.ipv4.dst_ip=
);=0D
+		PMD_DRV_LOG(INFO, "dst_ip spec: 0x%x", fdir_filter->key_spec.ipv4.dst_ip=
);=0D
+		PMD_DRV_LOG(INFO, "src_port mask: 0x%x", fdir_filter->key_mask.src_port)=
;=0D
+		PMD_DRV_LOG(INFO, "src_port spec: 0x%x", fdir_filter->key_spec.src_port)=
;=0D
+		PMD_DRV_LOG(INFO, "dst_port mask: 0x%x", fdir_filter->key_mask.dst_port)=
;=0D
+		PMD_DRV_LOG(INFO, "dst_port spec: 0x%x", fdir_filter->key_spec.dst_port)=
;=0D
+		PMD_DRV_LOG(INFO, "rule_nums: 0x%x", nic_dev->tcam_rule_nums);=0D
+		PMD_DRV_LOG(INFO, "mark_id: 0x%x", fdir_filter->rq_index);=0D
+	} else {=0D
+		PMD_DRV_LOG(INFO, "fdir ipv6 flow get:");=0D
+		PMD_DRV_LOG(INFO, "glb index:%d", fdir_filter->tcam_index);=0D
+		PMD_DRV_LOG(INFO, "protocol mask: 0x%x", fdir_filter->key_mask.ipv6.prot=
o);=0D
+		PMD_DRV_LOG(INFO, "protocol spec: 0x%x", fdir_filter->key_spec.ipv6.prot=
o);=0D
+		PMD_DRV_LOG(INFO, "src_ip mask: 0x%08x:%08x:%08x:%08x",=0D
+			    fdir_filter->key_mask.ipv6.src_ip[0],=0D
+			    fdir_filter->key_mask.ipv6.src_ip[1],=0D
+			    fdir_filter->key_mask.ipv6.src_ip[2],=0D
+			    fdir_filter->key_mask.ipv6.src_ip[3]);=0D
+		PMD_DRV_LOG(INFO, "src_ip spec: 0x%08x:%08x:%08x:%08x",=0D
+			    fdir_filter->key_spec.ipv6.src_ip[0],=0D
+			    fdir_filter->key_spec.ipv6.src_ip[1],=0D
+			    fdir_filter->key_spec.ipv6.src_ip[2],=0D
+			    fdir_filter->key_spec.ipv6.src_ip[3]);=0D
+		PMD_DRV_LOG(INFO, "dst_ip mask: 0x%08x:%08x:%08x:%08x",=0D
+			    fdir_filter->key_mask.ipv6.dst_ip[0],=0D
+			    fdir_filter->key_mask.ipv6.dst_ip[1],=0D
+			    fdir_filter->key_mask.ipv6.dst_ip[2],=0D
+			    fdir_filter->key_mask.ipv6.dst_ip[3]);=0D
+		PMD_DRV_LOG(INFO, "dst_ip spec: 0x%08x:%08x:%08x:%08x",=0D
+			    fdir_filter->key_spec.ipv6.dst_ip[0],=0D
+			    fdir_filter->key_spec.ipv6.dst_ip[1],=0D
+			    fdir_filter->key_spec.ipv6.dst_ip[2],=0D
+			    fdir_filter->key_spec.ipv6.dst_ip[3]);=0D
+		PMD_DRV_LOG(INFO, "src_port mask: 0x%x", fdir_filter->key_mask.src_port)=
;=0D
+		PMD_DRV_LOG(INFO, "src_port spec: 0x%x", fdir_filter->key_spec.src_port)=
;=0D
+		PMD_DRV_LOG(INFO, "dst_port mask: 0x%x", fdir_filter->key_mask.dst_port)=
;=0D
+		PMD_DRV_LOG(INFO, "dst_port spec: 0x%x", fdir_filter->key_spec.dst_port)=
;=0D
+		PMD_DRV_LOG(INFO, "rule_nums: 0x%x", nic_dev->tcam_rule_nums);=0D
+		PMD_DRV_LOG(INFO, "mark_id: 0x%x", fdir_filter->rq_index);=0D
+	}=0D
+	return 0;=0D
+}=0D
diff --git a/drivers/net/hinic3/hinic3_fdir.h b/drivers/net/hinic3/hinic3_f=
dir.h=0D
index 277d89d4fd..73600788fe 100644=0D
--- a/drivers/net/hinic3/hinic3_fdir.h=0D
+++ b/drivers/net/hinic3/hinic3_fdir.h=0D
@@ -1,5 +1,5 @@=0D
 /* SPDX-License-Identifier: BSD-3-Clause=0D
- * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ * Copyright (c) 2025-2026 Huawei Technologies Co., Ltd=0D
  */=0D
 =0D
 #ifndef _HINIC3_FDIR_H_=0D
@@ -8,8 +8,13 @@=0D
 #define HINIC3_FLOW_MAX_PATTERN_NUM 16=0D
 =0D
 #define HINIC3_TCAM_DYNAMIC_BLOCK_SIZE 16=0D
+#define HINIC3_TCAM_DYNAMIC_MAX_FILTERS(nic_dev)         \=0D
+		(HINIC3_IS_SP230_NIC(nic_dev)            \=0D
+		? HINIC3_TCAM_DYNAMIC_MAX_FILTERS_HTN    \=0D
+		: HINIC3_TCAM_DYNAMIC_MAX_FILTERS_STN)=0D
 =0D
-#define HINIC3_TCAM_DYNAMIC_MAX_FILTERS 1024=0D
+#define HINIC3_TCAM_DYNAMIC_MAX_FILTERS_STN 2048=0D
+#define HINIC3_TCAM_DYNAMIC_MAX_FILTERS_HTN 1024=0D
 =0D
 #define HINIC3_PKT_TCAM_DYNAMIC_INDEX_START(block_index) \=0D
 	(HINIC3_TCAM_DYNAMIC_BLOCK_SIZE * (block_index))=0D
@@ -22,6 +27,8 @@=0D
 =0D
 #define HINIC3_TCAM_INVALID_INDEX 0xFFFF=0D
 =0D
+#define HINIC3_RSS_QUEUE_BUF 128=0D
+=0D
 enum hinic3_ether_type {=0D
 	HINIC3_PKT_TYPE_ARP =3D 1,=0D
 	HINIC3_PKT_TYPE_ARP_REQ,=0D
@@ -71,6 +78,7 @@ struct hinic3_fdir_filter {=0D
 struct hinic3_ethertype_filter {=0D
 	int tcam_index[HINIC3_PKT_TYPE_BUTT];=0D
 	uint16_t ether_type;	/**< Ether type to match */=0D
+	uint16_t flags;=0D
 	uint16_t queue;		/**< Queue assigned to when match*/=0D
 };=0D
 =0D
@@ -96,6 +104,7 @@ enum hinic3_fdir_tunnel_mode {=0D
 	HINIC3_FDIR_TUNNEL_MODE_GENEVE =3D 5,=0D
 	HINIC3_FDIR_TUNNEL_MODE_NSH    =3D 6,=0D
 	HINIC3_FDIR_TUNNEL_MODE_IPIP   =3D 7,=0D
+	HINIC3_FDIR_TUNNEL_MODE_MAX    =3D 8,=0D
 };=0D
 =0D
 enum hinic3_fdir_ip_type {=0D
@@ -186,7 +195,7 @@ struct hinic3_tcam_key_mem_htn {=0D
 	uint32_t rsvd0 : 16;=0D
 	uint32_t ip_proto : 8;=0D
 	uint32_t tunnel_type : 3;=0D
-	uint32_t function_id_h: 5;=0D
+	uint32_t function_id_h : 5;=0D
 =0D
 	uint32_t function_id_l : 5;=0D
 	uint32_t ip_type : 2;=0D
@@ -250,7 +259,7 @@ struct hinic3_tcam_key_mem_htn {=0D
 	uint32_t rsvd8 : 16;=0D
 =0D
 	uint32_t sport : 16;=0D
-	uint32_t dipv4_l :16;=0D
+	uint32_t dipv4_l : 16;=0D
 =0D
 	uint32_t rsvd9 : 16;=0D
 	uint32_t dport : 16;=0D
@@ -668,6 +677,8 @@ int hinic3_flow_add_del_fdir_filter(struct rte_eth_dev =
*dev,=0D
 int hinic3_flow_add_del_ethertype_filter(struct rte_eth_dev *dev,=0D
 					 struct hinic3_ethertype_filter *ethertype_filter,=0D
 					 bool add);=0D
+int hinic3_flow_query_fdir_filter(struct rte_eth_dev *dev, struct hinic3_f=
dir_filter *fdir_filter,=0D
+				  __rte_unused uint64_t *hits, __rte_unused uint64_t *bytes_count);=0D
 void hinic3_free_fdir_filter(struct rte_eth_dev *dev);=0D
 int hinic3_enable_rxq_fdir_filter(struct rte_eth_dev *dev, uint32_t queue_=
id,=0D
 				  uint32_t able);=0D
diff --git a/drivers/net/hinic3/hinic3_flow.c b/drivers/net/hinic3/hinic3_f=
low.c=0D
index 5c255619e3..e88787452d 100644=0D
--- a/drivers/net/hinic3/hinic3_flow.c=0D
+++ b/drivers/net/hinic3/hinic3_flow.c=0D
@@ -8,7 +8,6 @@=0D
 #include "base/hinic3_hwdev.h"=0D
 #include "base/hinic3_nic_cfg.h"=0D
 #include "hinic3_ethdev.h"=0D
-#include "hinic3_flow.h"=0D
 =0D
 #define HINIC3_UINT8_MAX 0xff=0D
 =0D
@@ -19,12 +18,6 @@ typedef int (*hinic3_parse_filter_t)(struct rte_eth_dev =
*dev,=0D
 				     struct rte_flow_error *error,=0D
 				     struct hinic3_filter_t *filter);=0D
 =0D
-/* Indicate valid filter mode . */=0D
-struct hinic3_valid_pattern {=0D
-	enum rte_flow_item_type *items;=0D
-	hinic3_parse_filter_t parse_filter;=0D
-};=0D
-=0D
 static int hinic3_flow_parse_fdir_filter(struct rte_eth_dev *dev,=0D
 					 const struct rte_flow_attr *attr,=0D
 					 const struct rte_flow_item pattern[],=0D
@@ -39,65 +32,12 @@ static int hinic3_flow_parse_ethertype_filter(struct rt=
e_eth_dev *dev,=0D
 					      struct rte_flow_error *error,=0D
 					      struct hinic3_filter_t *filter);=0D
 =0D
-static int hinic3_flow_parse_fdir_vxlan_filter(struct rte_eth_dev *dev,=0D
-					       const struct rte_flow_attr *attr,=0D
-					       const struct rte_flow_item pattern[],=0D
-					       const struct rte_flow_action actions[],=0D
-					       struct rte_flow_error *error,=0D
-					       struct hinic3_filter_t *filter);=0D
-=0D
-/*=0D
- * Define a supported pattern array, including the matching patterns of=0D
- * various network protocols and corresponding parsing functions.=0D
- */=0D
-static const struct hinic3_valid_pattern hinic3_supported_patterns[] =3D {=
=0D
-	/* Support ethertype. */=0D
-	{pattern_ethertype, hinic3_flow_parse_ethertype_filter},=0D
-	/* Support ipv4 but not tunnel, and any field can be masked. */=0D
-	{pattern_ipv4, hinic3_flow_parse_fdir_filter},=0D
-	{pattern_ipv4_any, hinic3_flow_parse_fdir_filter},=0D
-	/* Support ipv4 + l4 but not tunnel, and any field can be masked. */=0D
-	{pattern_ipv4_udp, hinic3_flow_parse_fdir_filter},=0D
-	{pattern_ipv4_tcp, hinic3_flow_parse_fdir_filter},=0D
-	/* Support ipv4 + icmp not tunnel, and any field can be masked. */=0D
-	{pattern_ipv4_icmp, hinic3_flow_parse_fdir_filter},=0D
-=0D
-	/* Support ipv4 + l4 but not tunnel, and any field can be masked. */=0D
-	{pattern_ethertype_udp, hinic3_flow_parse_fdir_filter},=0D
-	{pattern_ethertype_tcp, hinic3_flow_parse_fdir_filter},=0D
-=0D
-	/* Support ipv4 + vxlan + any, and any field can be masked. */=0D
-	{pattern_ipv4_vxlan, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	/* Support ipv4 + vxlan + ipv4, and any field can be masked. */=0D
-	{pattern_ipv4_vxlan_ipv4, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	/* Support ipv4 + vxlan + ipv4 + l4, and any field can be masked. */=0D
-	{pattern_ipv4_vxlan_ipv4_tcp, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	{pattern_ipv4_vxlan_ipv4_udp, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	/* Support ipv4 + vxlan + ipv6, and any field can be masked. */=0D
-	{pattern_ipv4_vxlan_ipv6, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	/* Support ipv4 + vxlan + ipv6 + l4, and any field can be masked. */=0D
-	{pattern_ipv4_vxlan_ipv6_tcp, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	{pattern_ipv4_vxlan_ipv6_udp, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	/* Support ipv4 + vxlan + l4, and any field can be masked. */=0D
-	{pattern_ipv4_vxlan_tcp, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	{pattern_ipv4_vxlan_udp, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	{pattern_ipv4_vxlan_any, hinic3_flow_parse_fdir_vxlan_filter},=0D
-=0D
-	/* Support ipv6 but not tunnel, and any field can be masked. */=0D
-	{pattern_ipv6, hinic3_flow_parse_fdir_filter},=0D
-	/* Support ipv6 + l4 but not tunnel, and any field can be masked. */=0D
-	{pattern_ipv6_udp, hinic3_flow_parse_fdir_filter},=0D
-	{pattern_ipv6_tcp, hinic3_flow_parse_fdir_filter},=0D
-=0D
-	/* Support ipv6 + vxlan + any, and any field can be masked. */=0D
-	{pattern_ipv6_vxlan, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	{pattern_ipv6_vxlan_any, hinic3_flow_parse_fdir_vxlan_filter},=0D
-=0D
-	/* Support ipv6 + vxlan + l4, and any field can be masked. */=0D
-	{pattern_ipv6_vxlan_tcp, hinic3_flow_parse_fdir_vxlan_filter},=0D
-	{pattern_ipv6_vxlan_udp, hinic3_flow_parse_fdir_vxlan_filter},=0D
-=0D
-};=0D
+static int hinic3_flow_parse_fdir_vxlan_geneve_filter(struct rte_eth_dev *=
dev,=0D
+						      const struct rte_flow_attr *attr,=0D
+						      const struct rte_flow_item pattern[],=0D
+						      const struct rte_flow_action actions[],=0D
+						      struct rte_flow_error *error,=0D
+						      struct hinic3_filter_t *filter);=0D
 =0D
 static inline void=0D
 net_addr_to_host(uint32_t *dst, const uint32_t *src, size_t len)=0D
@@ -107,30 +47,243 @@ net_addr_to_host(uint32_t *dst, const uint32_t *src, =
size_t len)=0D
 		dst[i] =3D rte_be_to_cpu_32(src[i]);=0D
 }=0D
 =0D
-static bool=0D
-hinic3_match_pattern(enum rte_flow_item_type *item_array,=0D
-		     const struct rte_flow_item *pattern)=0D
-{=0D
-	const struct rte_flow_item *item =3D pattern;=0D
+/* IPINIP and GPE are split out due to chip support differences. */=0D
+enum hinic3_flow_filter_kind {=0D
+	HINIC3_FLOW_KIND_ETHERTYPE,	/* [ETH]. */=0D
+	HINIC3_FLOW_KIND_NON_TUNNEL,	/* single L3/L4 or ethertype L4. */=0D
+	HINIC3_FLOW_KIND_VXLAN_GENEVE,	/* vxlan/geneve. */=0D
+	HINIC3_FLOW_KIND_GPE,		/* vxlan-gpe. */=0D
+	HINIC3_FLOW_KIND_IPINIP,	/* ip-in-ip. */=0D
+	HINIC3_FLOW_KIND_INVALID,=0D
+};=0D
 =0D
-	/* skip the first void item. */=0D
+/*=0D
+ * The pattern is parsed as a small protocol graph. Every supported patter=
n=0D
+ * starts with ETH and then follows one of the supported encapsulation pat=
hs=0D
+ * (plain L3/L4, tunneled, or ip-in-ip). VOID items are transparent.=0D
+ */=0D
+=0D
+/* Peek at the next non-VOID item type. */=0D
+static enum rte_flow_item_type=0D
+hinic3_flow_next(const struct rte_flow_item *item)=0D
+{=0D
 	while (item->type =3D=3D RTE_FLOW_ITEM_TYPE_VOID)=0D
 		item++;=0D
 =0D
-	/* Find no void item. */=0D
-	while (((*item_array =3D=3D item->type) &&=0D
-		(*item_array !=3D RTE_FLOW_ITEM_TYPE_END)) ||=0D
-	       (item->type =3D=3D RTE_FLOW_ITEM_TYPE_VOID)) {=0D
-		if (item->type =3D=3D RTE_FLOW_ITEM_TYPE_VOID) {=0D
-			item++;=0D
-		} else {=0D
-			item_array++;=0D
-			item++;=0D
+	return item->type;=0D
+}=0D
+=0D
+/* Consume the next non-VOID item when it matches @p type. */=0D
+static bool=0D
+hinic3_flow_take(const struct rte_flow_item **item,=0D
+		 enum rte_flow_item_type type)=0D
+{=0D
+	while ((*item)->type =3D=3D RTE_FLOW_ITEM_TYPE_VOID)=0D
+		(*item)++;=0D
+=0D
+	if ((*item)->type !=3D type)=0D
+		return false;=0D
+=0D
+	(*item)++;=0D
+	return true;=0D
+}=0D
+=0D
+/* Return true when only the END item remains. */=0D
+static bool=0D
+hinic3_flow_at_end(const struct rte_flow_item *item)=0D
+{=0D
+	return hinic3_flow_next(item) =3D=3D RTE_FLOW_ITEM_TYPE_END;=0D
+}=0D
+=0D
+/* Finish a branch, which is valid only when END is reached. */=0D
+static enum hinic3_flow_filter_kind=0D
+hinic3_flow_finish(const struct rte_flow_item *item,=0D
+		   enum hinic3_flow_filter_kind kind)=0D
+{=0D
+	return hinic3_flow_at_end(item) ? kind : HINIC3_FLOW_KIND_INVALID;=0D
+}=0D
+=0D
+/* Classify an inner L3 (IPv4/IPv6) with an optional L4, returning @p kind=
. */=0D
+static enum hinic3_flow_filter_kind=0D
+hinic3_flow_classify_inner(const struct rte_flow_item **item,=0D
+			   enum hinic3_flow_filter_kind kind,=0D
+			   enum rte_flow_item_type outer_ip)=0D
+{=0D
+	enum rte_flow_item_type next =3D hinic3_flow_next(*item);=0D
+=0D
+	if (next !=3D RTE_FLOW_ITEM_TYPE_IPV4 &&=0D
+	    next !=3D RTE_FLOW_ITEM_TYPE_IPV6)=0D
+		return HINIC3_FLOW_KIND_INVALID;=0D
+=0D
+	/*=0D
+	 * An outer IPv6 plus any inner L3 does not fit in the TCAM, so only=0D
+	 * an IPv4 outer (or no outer at all) may carry an inner L3.=0D
+	 */=0D
+	if (outer_ip =3D=3D RTE_FLOW_ITEM_TYPE_IPV6)=0D
+		return HINIC3_FLOW_KIND_INVALID;=0D
+=0D
+	hinic3_flow_take(item, next);=0D
+=0D
+	switch (hinic3_flow_next(*item)) {=0D
+	case RTE_FLOW_ITEM_TYPE_END:=0D
+		return kind;=0D
+	case RTE_FLOW_ITEM_TYPE_TCP:=0D
+	case RTE_FLOW_ITEM_TYPE_UDP:=0D
+		hinic3_flow_take(item, hinic3_flow_next(*item));=0D
+		return hinic3_flow_finish(*item, kind);=0D
+	default:=0D
+		return HINIC3_FLOW_KIND_INVALID;=0D
+	}=0D
+}=0D
+=0D
+/* Consume a tunnel header and classify the payload that follows it. */=0D
+static enum hinic3_flow_filter_kind=0D
+hinic3_flow_classify_tunnel(const struct rte_flow_item **item,=0D
+			    enum rte_flow_item_type tunnel_type,=0D
+			    enum rte_flow_item_type outer_ip)=0D
+{=0D
+	enum hinic3_flow_filter_kind kind =3D=0D
+		tunnel_type =3D=3D RTE_FLOW_ITEM_TYPE_VXLAN_GPE ?=0D
+			HINIC3_FLOW_KIND_GPE : HINIC3_FLOW_KIND_VXLAN_GENEVE;=0D
+	enum rte_flow_item_type next;=0D
+=0D
+	if (!hinic3_flow_take(item, tunnel_type))=0D
+		return HINIC3_FLOW_KIND_INVALID;=0D
+=0D
+	next =3D hinic3_flow_next(*item);=0D
+=0D
+	/* A bare tunnel with nothing after the header is valid. */=0D
+	if (next =3D=3D RTE_FLOW_ITEM_TYPE_END)=0D
+		return kind;=0D
+=0D
+	/* GPE: an optional inner ETH (which may be terminal), then an L3(+L4). *=
/=0D
+	if (tunnel_type =3D=3D RTE_FLOW_ITEM_TYPE_VXLAN_GPE) {=0D
+		if (next =3D=3D RTE_FLOW_ITEM_TYPE_ETH) {=0D
+			hinic3_flow_take(item, RTE_FLOW_ITEM_TYPE_ETH);=0D
+			if (hinic3_flow_at_end(*item))=0D
+				return kind;=0D
 		}=0D
+		return hinic3_flow_classify_inner(item, kind, outer_ip);=0D
 	}=0D
 =0D
-	return (*item_array =3D=3D RTE_FLOW_ITEM_TYPE_END &&=0D
-		item->type =3D=3D RTE_FLOW_ITEM_TYPE_END);=0D
+	/* vxlan/geneve: a bare L4/ANY, or an inner L3(+L4). */=0D
+	switch (next) {=0D
+	case RTE_FLOW_ITEM_TYPE_TCP:=0D
+	case RTE_FLOW_ITEM_TYPE_UDP:=0D
+	case RTE_FLOW_ITEM_TYPE_ANY:=0D
+		hinic3_flow_take(item, next);=0D
+		return hinic3_flow_finish(*item, kind);=0D
+	case RTE_FLOW_ITEM_TYPE_ETH:=0D
+	case RTE_FLOW_ITEM_TYPE_IPV4:=0D
+	case RTE_FLOW_ITEM_TYPE_IPV6:=0D
+		if (next =3D=3D RTE_FLOW_ITEM_TYPE_ETH) {=0D
+			hinic3_flow_take(item, RTE_FLOW_ITEM_TYPE_ETH);=0D
+			break;=0D
+		}=0D
+		/* Geneve accepts a bare inner L3; vxlan requires the inner ETH. */=0D
+		if (tunnel_type !=3D RTE_FLOW_ITEM_TYPE_GENEVE)=0D
+			return HINIC3_FLOW_KIND_INVALID;=0D
+		break;=0D
+	default:=0D
+		return HINIC3_FLOW_KIND_INVALID;=0D
+	}=0D
+=0D
+	return hinic3_flow_classify_inner(item, kind, outer_ip);=0D
+}=0D
+=0D
+/* Classify the payload that follows the outer L3. */=0D
+static enum hinic3_flow_filter_kind=0D
+hinic3_flow_classify_ip(const struct rte_flow_item **item,=0D
+			enum rte_flow_item_type ip_type)=0D
+{=0D
+	enum rte_flow_item_type next =3D hinic3_flow_next(*item);=0D
+=0D
+	switch (next) {=0D
+	case RTE_FLOW_ITEM_TYPE_END:=0D
+		return HINIC3_FLOW_KIND_NON_TUNNEL;=0D
+	case RTE_FLOW_ITEM_TYPE_TCP:=0D
+		hinic3_flow_take(item, RTE_FLOW_ITEM_TYPE_TCP);=0D
+		return hinic3_flow_finish(*item, HINIC3_FLOW_KIND_NON_TUNNEL);=0D
+	case RTE_FLOW_ITEM_TYPE_UDP:=0D
+		hinic3_flow_take(item, RTE_FLOW_ITEM_TYPE_UDP);=0D
+		next =3D hinic3_flow_next(*item);=0D
+		switch (next) {=0D
+		case RTE_FLOW_ITEM_TYPE_END:=0D
+			return HINIC3_FLOW_KIND_NON_TUNNEL;=0D
+		case RTE_FLOW_ITEM_TYPE_VXLAN:=0D
+		case RTE_FLOW_ITEM_TYPE_GENEVE:=0D
+		case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:=0D
+			return hinic3_flow_classify_tunnel(item, next, ip_type);=0D
+		default:=0D
+			return HINIC3_FLOW_KIND_INVALID;=0D
+		}=0D
+	case RTE_FLOW_ITEM_TYPE_ICMP:=0D
+	case RTE_FLOW_ITEM_TYPE_ANY:=0D
+		/* ICMP and ANY are valid only right after an IPv4 outer. */=0D
+		if (ip_type !=3D RTE_FLOW_ITEM_TYPE_IPV4)=0D
+			return HINIC3_FLOW_KIND_INVALID;=0D
+		hinic3_flow_take(item, next);=0D
+		return hinic3_flow_finish(*item, HINIC3_FLOW_KIND_NON_TUNNEL);=0D
+	case RTE_FLOW_ITEM_TYPE_IPV4:=0D
+	case RTE_FLOW_ITEM_TYPE_IPV6:=0D
+		/* Ip-in-ip: a second L3 with an optional L4 (or ANY). */=0D
+		hinic3_flow_take(item, next);=0D
+		switch (hinic3_flow_next(*item)) {=0D
+		case RTE_FLOW_ITEM_TYPE_END:=0D
+			return HINIC3_FLOW_KIND_IPINIP;=0D
+		case RTE_FLOW_ITEM_TYPE_TCP:=0D
+		case RTE_FLOW_ITEM_TYPE_UDP:=0D
+		case RTE_FLOW_ITEM_TYPE_ANY:=0D
+			hinic3_flow_take(item, hinic3_flow_next(*item));=0D
+			return hinic3_flow_finish(*item, HINIC3_FLOW_KIND_IPINIP);=0D
+		default:=0D
+			return HINIC3_FLOW_KIND_INVALID;=0D
+		}=0D
+	default:=0D
+		return HINIC3_FLOW_KIND_INVALID;=0D
+	}=0D
+}=0D
+=0D
+/* Classify a pattern into one of the supported filter kinds. */=0D
+static enum hinic3_flow_filter_kind=0D
+hinic3_flow_classify(const struct rte_flow_item *pattern)=0D
+{=0D
+	const struct rte_flow_item *item =3D pattern;=0D
+	enum rte_flow_item_type next;=0D
+=0D
+	if (!hinic3_flow_take(&item, RTE_FLOW_ITEM_TYPE_ETH))=0D
+		return HINIC3_FLOW_KIND_INVALID;=0D
+=0D
+	switch (hinic3_flow_next(item)) {=0D
+	case RTE_FLOW_ITEM_TYPE_END:=0D
+		return HINIC3_FLOW_KIND_ETHERTYPE;=0D
+	case RTE_FLOW_ITEM_TYPE_TCP:=0D
+		hinic3_flow_take(&item, RTE_FLOW_ITEM_TYPE_TCP);=0D
+		return hinic3_flow_finish(item, HINIC3_FLOW_KIND_NON_TUNNEL);=0D
+	case RTE_FLOW_ITEM_TYPE_UDP:=0D
+		hinic3_flow_take(&item, RTE_FLOW_ITEM_TYPE_UDP);=0D
+		next =3D hinic3_flow_next(item);=0D
+		switch (next) {=0D
+		case RTE_FLOW_ITEM_TYPE_END:=0D
+			return HINIC3_FLOW_KIND_NON_TUNNEL;=0D
+		case RTE_FLOW_ITEM_TYPE_VXLAN:=0D
+		case RTE_FLOW_ITEM_TYPE_GENEVE:=0D
+		case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:=0D
+			/* No outer IP: pass END so classify_inner allows it. */=0D
+			return hinic3_flow_classify_tunnel(&item, next,=0D
+							    RTE_FLOW_ITEM_TYPE_END);=0D
+		default:=0D
+			return HINIC3_FLOW_KIND_INVALID;=0D
+		}=0D
+	case RTE_FLOW_ITEM_TYPE_IPV4:=0D
+		hinic3_flow_take(&item, RTE_FLOW_ITEM_TYPE_IPV4);=0D
+		return hinic3_flow_classify_ip(&item, RTE_FLOW_ITEM_TYPE_IPV4);=0D
+	case RTE_FLOW_ITEM_TYPE_IPV6:=0D
+		hinic3_flow_take(&item, RTE_FLOW_ITEM_TYPE_IPV6);=0D
+		return hinic3_flow_classify_ip(&item, RTE_FLOW_ITEM_TYPE_IPV6);=0D
+	default:=0D
+		return HINIC3_FLOW_KIND_INVALID;=0D
+	}=0D
 }=0D
 =0D
 /**=0D
@@ -142,20 +295,28 @@ hinic3_match_pattern(enum rte_flow_item_type *item_ar=
ray,=0D
  * Matched resolution filter. If no resolution filter is found, return NUL=
L.=0D
  */=0D
 static hinic3_parse_filter_t=0D
-hinic3_find_parse_filter_func(const struct rte_flow_item *pattern)=0D
+hinic3_find_parse_filter_func(struct rte_eth_dev *dev,=0D
+			      const struct rte_flow_item *pattern)=0D
 {=0D
-	hinic3_parse_filter_t parse_filter =3D NULL;=0D
-	uint8_t i;=0D
-	/* Traverse all supported patterns. */=0D
-	for (i =3D 0; i < RTE_DIM(hinic3_supported_patterns); i++) {=0D
-		if (hinic3_match_pattern(hinic3_supported_patterns[i].items, pattern)) {=
=0D
-			parse_filter =3D=0D
-				hinic3_supported_patterns[i].parse_filter;=0D
-			break;=0D
-		}=0D
-	}=0D
+	struct hinic3_nic_dev *nic_dev =3D HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev)=
;=0D
 =0D
-	return parse_filter;=0D
+	switch (hinic3_flow_classify(pattern)) {=0D
+	case HINIC3_FLOW_KIND_ETHERTYPE:=0D
+		return hinic3_flow_parse_ethertype_filter;=0D
+	case HINIC3_FLOW_KIND_NON_TUNNEL:=0D
+		return hinic3_flow_parse_fdir_filter;=0D
+	case HINIC3_FLOW_KIND_VXLAN_GENEVE:=0D
+		return hinic3_flow_parse_fdir_vxlan_geneve_filter;=0D
+	case HINIC3_FLOW_KIND_GPE:=0D
+		return HINIC3_IS_SP620_NIC(nic_dev) ?=0D
+		hinic3_flow_parse_fdir_vxlan_geneve_filter : NULL;=0D
+	case HINIC3_FLOW_KIND_IPINIP:=0D
+		return HINIC3_IS_SP620_NIC(nic_dev) ?=0D
+		hinic3_flow_parse_fdir_filter :=0D
+		hinic3_flow_parse_fdir_vxlan_geneve_filter;=0D
+	default:=0D
+		return NULL;=0D
+	}=0D
 }=0D
 =0D
 /**=0D
@@ -182,12 +343,29 @@ hinic3_flow_parse_action(struct rte_eth_dev *dev,=0D
 	const struct rte_flow_action_queue *act_q;=0D
 	const struct rte_flow_action *act =3D actions;=0D
 =0D
-	/* skip the first void item. */=0D
-	while (act->type =3D=3D RTE_FLOW_ACTION_TYPE_VOID)=0D
-		act++;=0D
+	/* Find the last non-VOID action before END */=0D
+	const struct rte_flow_action *last_act =3D NULL;=0D
+	for (act =3D actions; act->type !=3D RTE_FLOW_ACTION_TYPE_END; act++) {=0D
+		if (act->type !=3D RTE_FLOW_ACTION_TYPE_VOID)=0D
+			last_act =3D act;=0D
+	}=0D
+	if (last_act =3D=3D NULL) {=0D
+		rte_flow_error_set(error, EINVAL,=0D
+				   RTE_FLOW_ERROR_TYPE_ACTION, actions,=0D
+				   "No valid action.");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	act =3D last_act;=0D
 =0D
 	switch (act->type) {=0D
 	case RTE_FLOW_ACTION_TYPE_QUEUE:=0D
+		if (act->conf =3D=3D NULL) {=0D
+			rte_flow_error_set(error, EINVAL,=0D
+					   RTE_FLOW_ERROR_TYPE_ACTION,=0D
+					   act, "Invalid action queue config.");=0D
+			return -rte_errno;=0D
+		}=0D
 		act_q =3D (const struct rte_flow_action_queue *)act->conf;=0D
 		filter->fdir_filter.rq_index =3D act_q->index;=0D
 		if (filter->fdir_filter.rq_index >=3D dev->data->nb_rx_queues) {=0D
@@ -230,6 +408,14 @@ hinic3_flow_fdir_ipv4(const struct rte_flow_item *flow=
_item,=0D
 =0D
 	mask_ipv4 =3D (const struct rte_flow_item_ipv4 *)flow_item->mask;=0D
 	spec_ipv4 =3D (const struct rte_flow_item_ipv4 *)flow_item->spec;=0D
+=0D
+	filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+	filter->fdir_filter.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
+=0D
+	/* When both L3 mask and spec are empty, return 0, then proceed to evalua=
te L4. */=0D
+	if (!mask_ipv4 && !spec_ipv4)=0D
+		return 0;=0D
+=0D
 	if (!mask_ipv4 || !spec_ipv4) {=0D
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,=0D
 				   flow_item,=0D
@@ -251,9 +437,6 @@ hinic3_flow_fdir_ipv4(const struct rte_flow_item *flow_=
item,=0D
 		return -rte_errno;=0D
 	}=0D
 =0D
-	/* Set the filter information. */=0D
-	filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
-	filter->fdir_filter.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
 	filter->fdir_filter.key_mask.ipv4.src_ip =3D=0D
 		rte_be_to_cpu_32(mask_ipv4->hdr.src_addr);=0D
 	filter->fdir_filter.key_spec.ipv4.src_ip =3D=0D
@@ -277,6 +460,14 @@ hinic3_flow_fdir_ipv6(const struct rte_flow_item *flow=
_item,=0D
 =0D
 	mask_ipv6 =3D (const struct rte_flow_item_ipv6 *)flow_item->mask;=0D
 	spec_ipv6 =3D (const struct rte_flow_item_ipv6 *)flow_item->spec;=0D
+=0D
+	filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+	filter->fdir_filter.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
+=0D
+	/* When both L3 mask and spec are empty, return 0, then proceed to evalua=
te L4. */=0D
+	if (!mask_ipv6 && !spec_ipv6)=0D
+		return 0;=0D
+=0D
 	if (!mask_ipv6 || !spec_ipv6) {=0D
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,=0D
 				   flow_item,=0D
@@ -293,9 +484,6 @@ hinic3_flow_fdir_ipv6(const struct rte_flow_item *flow_=
item,=0D
 		return -rte_errno;=0D
 	}=0D
 =0D
-	/* Set the filter information. */=0D
-	filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
-	filter->fdir_filter.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
 	net_addr_to_host(filter->fdir_filter.key_mask.ipv6.src_ip,=0D
 			 (const uint32_t *)mask_ipv6->hdr.src_addr.a, 4);=0D
 	net_addr_to_host(filter->fdir_filter.key_spec.ipv6.src_ip,=0D
@@ -639,6 +827,12 @@ hinic3_flow_parse_ethertype_pattern(__rte_unused struc=
t rte_eth_dev *dev,=0D
 			case RTE_ETHER_TYPE_LLDP:=0D
 				break;=0D
 =0D
+			case RTE_ETHER_TYPE_CNM:=0D
+				break;=0D
+=0D
+			case RTE_ETHER_TYPE_ECP:=0D
+				break;=0D
+=0D
 			default:=0D
 				rte_flow_error_set(error, EINVAL,=0D
 						   RTE_FLOW_ERROR_TYPE_ITEM,=0D
@@ -686,14 +880,15 @@ static int=0D
 hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *error,=0D
 			     struct hinic3_filter_t *filter,=0D
 			     const struct rte_flow_item *flow_item,=0D
-			     enum hinic3_fdir_tunnel_mode tunnel_mode)=0D
+			     enum hinic3_fdir_tunnel_mode *tunnel_mode)=0D
 {=0D
 	const struct rte_flow_item_ipv4 *spec_ipv4, *mask_ipv4;=0D
 	mask_ipv4 =3D (const struct rte_flow_item_ipv4 *)flow_item->mask;=0D
 	spec_ipv4 =3D (const struct rte_flow_item_ipv4 *)flow_item->spec;=0D
 =0D
-	if (tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
+	if (*tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_MAX) {=0D
 		filter->fdir_filter.outer_ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+		*tunnel_mode =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
 =0D
 		if (!mask_ipv4 && !spec_ipv4)=0D
 			return 0;=0D
@@ -702,7 +897,7 @@ hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *err=
or,=0D
 			rte_flow_error_set(error, EINVAL,=0D
 					   RTE_FLOW_ERROR_TYPE_ITEM,=0D
 					   flow_item,=0D
-					   "Invalid fdir filter, vxlan outer ipv4 mask or spec");=0D
+					   "Invalid fdir filter, vxlan/geneve outer ipv4 mask or spec");=0D
 			return -rte_errno;=0D
 		}=0D
 =0D
@@ -718,7 +913,7 @@ hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *err=
or,=0D
 		    mask_ipv4->hdr.next_proto_id ||=0D
 		    mask_ipv4->hdr.hdr_checksum) {=0D
 			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, flow_item,=
=0D
-				"Not supported by fdir filter, vxlan outer ipv4 only support src ip, d=
st ip");=0D
+				"Not supported by fdir filter, vxlan/geneve outer ipv4 only support sr=
c ip,dst ip");=0D
 			return -rte_errno;=0D
 		}=0D
 =0D
@@ -733,6 +928,10 @@ hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *er=
ror,=0D
 			rte_be_to_cpu_32(spec_ipv4->hdr.dst_addr);=0D
 	} else {=0D
 		filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV4;=0D
+		if (*tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
+			*tunnel_mode =3D HINIC3_FDIR_TUNNEL_MODE_IPIP;=0D
+			filter->fdir_filter.tunnel_type =3D *tunnel_mode;=0D
+		}=0D
 =0D
 		if (!mask_ipv4 && !spec_ipv4)=0D
 			return 0;=0D
@@ -741,7 +940,7 @@ hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *err=
or,=0D
 			rte_flow_error_set(error, EINVAL,=0D
 					   RTE_FLOW_ERROR_TYPE_ITEM,=0D
 					   flow_item,=0D
-					   "Invalid fdir filter, vxlan inner ipv4 mask or spec");=0D
+					   "Invalid fdir filter, vxlan/geneve inner ipv4 mask or spec");=0D
 			return -rte_errno;=0D
 		}=0D
 =0D
@@ -758,7 +957,7 @@ hinic3_flow_fdir_tunnel_ipv4(struct rte_flow_error *err=
or,=0D
 			rte_flow_error_set(error, EINVAL,=0D
 					   RTE_FLOW_ERROR_TYPE_ITEM,=0D
 					   flow_item,=0D
-					   "Not supported by fdir filter, vxlan inner ipv4 only support src i=
p, dst ip, proto");=0D
+					   "Not supported by fdir filter, vxlan/geneve inner ipv4 only suppor=
t src ip,dst ip, proto");=0D
 			return -rte_errno;=0D
 		}=0D
 =0D
@@ -783,15 +982,16 @@ static int=0D
 hinic3_flow_fdir_tunnel_ipv6(struct rte_flow_error *error,=0D
 			     struct hinic3_filter_t *filter,=0D
 			     const struct rte_flow_item *flow_item,=0D
-			     enum hinic3_fdir_tunnel_mode tunnel_mode)=0D
+			     enum hinic3_fdir_tunnel_mode *tunnel_mode)=0D
 {=0D
 	const struct rte_flow_item_ipv6 *spec_ipv6, *mask_ipv6;=0D
 =0D
 	mask_ipv6 =3D (const struct rte_flow_item_ipv6 *)flow_item->mask;=0D
 	spec_ipv6 =3D (const struct rte_flow_item_ipv6 *)flow_item->spec;=0D
 =0D
-	if (tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
+	if (*tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_MAX) {=0D
 		filter->fdir_filter.outer_ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
+		*tunnel_mode =3D HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
 =0D
 		if (!mask_ipv6 && !spec_ipv6)=0D
 			return 0;=0D
@@ -822,7 +1022,10 @@ hinic3_flow_fdir_tunnel_ipv6(struct rte_flow_error *e=
rror,=0D
 				 (const uint32_t *)spec_ipv6->hdr.dst_addr.a, 4);=0D
 	} else {=0D
 		filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_IPV6;=0D
-=0D
+		if (*tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
+			*tunnel_mode =3D HINIC3_FDIR_TUNNEL_MODE_IPIP;=0D
+			filter->fdir_filter.tunnel_type =3D *tunnel_mode;=0D
+		}=0D
 		if (!mask_ipv6 && !spec_ipv6)=0D
 			return 0;=0D
 =0D
@@ -869,7 +1072,7 @@ hinic3_flow_fdir_tunnel_tcp(struct rte_flow_error *err=
or,=0D
 	if (tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,=0D
 				   flow_item,=0D
-				   "Not supported by fdir filter, vxlan only support inner tcp");=0D
+				   "Not supported by fdir filter, vxlan/geneve only support inner tcp"=
);=0D
 		return -rte_errno;=0D
 	}=0D
 =0D
@@ -894,7 +1097,7 @@ hinic3_flow_fdir_tunnel_tcp(struct rte_flow_error *err=
or,=0D
 	    mask_tcp->hdr.tcp_urp) {=0D
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,=0D
 				   flow_item,=0D
-				   "Not supported by fdir filter, vxlan inner tcp only support src por=
t,dst port");=0D
+				   "Not supported by fdir filter, vxlan/geneve inner tcp only support =
src port,dst port");=0D
 		return -rte_errno;=0D
 	}=0D
 =0D
@@ -921,7 +1124,8 @@ hinic3_flow_fdir_tunnel_udp(struct rte_flow_error *err=
or,=0D
 	mask_udp =3D (const struct rte_flow_item_udp *)flow_item->mask;=0D
 	spec_udp =3D (const struct rte_flow_item_udp *)flow_item->spec;=0D
 =0D
-	if (tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
+	if (tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_MAX ||=0D
+	    tunnel_mode =3D=3D HINIC3_FDIR_TUNNEL_MODE_NORMAL) {=0D
 		/*=0D
 		 * UDP is used to describe protocol,=0D
 		 * spec and mask should be NULL.=0D
@@ -942,7 +1146,7 @@ hinic3_flow_fdir_tunnel_udp(struct rte_flow_error *err=
or,=0D
 			rte_flow_error_set(error, EINVAL,=0D
 					   RTE_FLOW_ERROR_TYPE_ITEM,=0D
 					   flow_item,=0D
-					   "Invalid fdir filter vxlan inner udp mask or spec");=0D
+					   "Invalid fdir filter vxlan/geneve inner udp mask or spec");=0D
 			return -rte_errno;=0D
 		}=0D
 =0D
@@ -960,53 +1164,74 @@ hinic3_flow_fdir_tunnel_udp(struct rte_flow_error *e=
rror,=0D
 	return 0;=0D
 }=0D
 =0D
+static inline enum hinic3_fdir_tunnel_mode=0D
+hinic3_flow_tunnel_mode(enum rte_flow_item_type type)=0D
+{=0D
+	switch (type) {=0D
+	case RTE_FLOW_ITEM_TYPE_GENEVE:=0D
+		return HINIC3_FDIR_TUNNEL_MODE_GENEVE;=0D
+	case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:=0D
+		return HINIC3_FDIR_TUNNEL_MODE_GPE;=0D
+	default:=0D
+		return HINIC3_FDIR_TUNNEL_MODE_VXLAN;=0D
+	}=0D
+}=0D
+=0D
 static int=0D
-hinic3_flow_fdir_vxlan(struct rte_flow_error *error,=0D
-		       struct hinic3_filter_t *filter,=0D
-		       const struct rte_flow_item *flow_item)=0D
+hinic3_flow_fdir_vxlan_geneve(struct rte_flow_error	  *error,=0D
+			      struct hinic3_filter_t	  *filter,=0D
+			      enum hinic3_fdir_tunnel_mode tunnel_mode,=0D
+			      const struct rte_flow_item  *flow_item)=0D
 {=0D
 	const struct rte_flow_item_vxlan *spec_vxlan, *mask_vxlan;=0D
 	uint32_t vxlan_vni_id =3D 0;=0D
+	uint32_t vxlan_vni_id_mask =3D 0;=0D
 =0D
 	spec_vxlan =3D (const struct rte_flow_item_vxlan *)flow_item->spec;=0D
 	mask_vxlan =3D (const struct rte_flow_item_vxlan *)flow_item->mask;=0D
 =0D
-	filter->fdir_filter.tunnel_type =3D HINIC3_FDIR_TUNNEL_MODE_VXLAN;=0D
+	filter->fdir_filter.tunnel_type =3D tunnel_mode;=0D
 =0D
 	if (!spec_vxlan && !mask_vxlan) {=0D
 		return 0;=0D
 	} else if (filter->fdir_filter.outer_ip_type =3D=3D HINIC3_FDIR_IP_TYPE_I=
PV6) {=0D
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,=0D
 				   flow_item,=0D
-				   "Invalid fdir filter vxlan mask or spec, ipv6 vxlan, don't support =
vni");=0D
+				   "Invalid fdir filter vxlan/geneve mask or spec, ipv6 vxlan/geneve, =
don't support vni");=0D
 		return -rte_errno;=0D
 	}=0D
 =0D
 	if (!spec_vxlan || !mask_vxlan) {=0D
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,=0D
 				   flow_item,=0D
-				   "Invalid fdir filter vxlan mask or spec");=0D
+				   "Invalid fdir filter vxlan/geneve mask or spec");=0D
 		return -rte_errno;=0D
 	}=0D
 =0D
 	memcpy(((uint8_t *)&vxlan_vni_id + 1), spec_vxlan->vni, 3);=0D
-	filter->fdir_filter.key_mask.tunnel.tunnel_id =3D=0D
-		rte_be_to_cpu_32(vxlan_vni_id);=0D
+	filter->fdir_filter.key_spec.tunnel.tunnel_id =3D rte_be_to_cpu_32(vxlan_=
vni_id);=0D
+	memcpy(((uint8_t *)&vxlan_vni_id_mask + 1), mask_vxlan->vni, 3);=0D
+	filter->fdir_filter.key_mask.tunnel.tunnel_id =3D rte_be_to_cpu_32(vxlan_=
vni_id_mask);=0D
 	return 0;=0D
 }=0D
 =0D
 static int=0D
-hinic3_flow_parse_fdir_vxlan_pattern(__rte_unused struct rte_eth_dev *dev,=
=0D
-				     const struct rte_flow_item *pattern,=0D
-				     struct rte_flow_error *error,=0D
-				     struct hinic3_filter_t *filter)=0D
+hinic3_flow_parse_fdir_vxlan_geneve_pattern(__rte_unused struct rte_eth_de=
v *dev,=0D
+					    const struct rte_flow_item *pattern,=0D
+					    struct rte_flow_error *error,=0D
+					    struct hinic3_filter_t *filter)=0D
 {=0D
 	const struct rte_flow_item *flow_item =3D pattern;=0D
-	enum hinic3_fdir_tunnel_mode tunnel_mode =3D=0D
-		HINIC3_FDIR_TUNNEL_MODE_NORMAL;=0D
+	enum hinic3_fdir_tunnel_mode tunnel_mode =3D HINIC3_FDIR_TUNNEL_MODE_MAX;=
=0D
 	enum rte_flow_item_type type;=0D
 	int err;=0D
 =0D
+	if (pattern =3D=3D NULL) {=0D
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM, NULL,=0D
+				   "Invalid pattern");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
 	/* Inner and outer ip type, set it to any by default */=0D
 	filter->fdir_filter.ip_type =3D HINIC3_FDIR_IP_TYPE_ANY;=0D
 	filter->fdir_filter.outer_ip_type =3D HINIC3_FDIR_IP_TYPE_ANY;=0D
@@ -1034,14 +1259,14 @@ hinic3_flow_parse_fdir_vxlan_pattern(__rte_unused s=
truct rte_eth_dev *dev,=0D
 =0D
 		case RTE_FLOW_ITEM_TYPE_IPV4:=0D
 			err =3D hinic3_flow_fdir_tunnel_ipv4(error,=0D
-				filter, flow_item, tunnel_mode);=0D
+				filter, flow_item, &tunnel_mode);=0D
 			if (err)=0D
 				return -rte_errno;=0D
 			break;=0D
 =0D
 		case RTE_FLOW_ITEM_TYPE_IPV6:=0D
 			err =3D hinic3_flow_fdir_tunnel_ipv6(error,=0D
-				filter, flow_item, tunnel_mode);=0D
+				filter, flow_item, &tunnel_mode);=0D
 			if (err)=0D
 				return -rte_errno;=0D
 			break;=0D
@@ -1061,10 +1286,12 @@ hinic3_flow_parse_fdir_vxlan_pattern(__rte_unused s=
truct rte_eth_dev *dev,=0D
 			break;=0D
 =0D
 		case RTE_FLOW_ITEM_TYPE_VXLAN:=0D
-			err =3D hinic3_flow_fdir_vxlan(error, filter, flow_item);=0D
+		case RTE_FLOW_ITEM_TYPE_GENEVE:=0D
+		case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:=0D
+			tunnel_mode =3D hinic3_flow_tunnel_mode(type);=0D
+			err =3D hinic3_flow_fdir_vxlan_geneve(error, filter, tunnel_mode, flow_=
item);=0D
 			if (err)=0D
 				return -rte_errno;=0D
-			tunnel_mode =3D HINIC3_FDIR_TUNNEL_MODE_VXLAN;=0D
 			break;=0D
 =0D
 		default:=0D
@@ -1095,16 +1322,16 @@ hinic3_flow_parse_fdir_vxlan_pattern(__rte_unused s=
truct rte_eth_dev *dev,=0D
  * 0 on success, non-zero on failure.=0D
  */=0D
 static int=0D
-hinic3_flow_parse_fdir_vxlan_filter(struct rte_eth_dev *dev,=0D
-				    const struct rte_flow_attr *attr,=0D
-				    const struct rte_flow_item pattern[],=0D
-				    const struct rte_flow_action actions[],=0D
-				    struct rte_flow_error *error,=0D
-				    struct hinic3_filter_t *filter)=0D
+hinic3_flow_parse_fdir_vxlan_geneve_filter(struct rte_eth_dev *dev,=0D
+					   const struct rte_flow_attr *attr,=0D
+					   const struct rte_flow_item pattern[],=0D
+					   const struct rte_flow_action actions[],=0D
+					   struct rte_flow_error *error,=0D
+					   struct hinic3_filter_t *filter)=0D
 {=0D
 	int ret;=0D
 =0D
-	ret =3D hinic3_flow_parse_fdir_vxlan_pattern(dev, pattern, error, filter)=
;=0D
+	ret =3D hinic3_flow_parse_fdir_vxlan_geneve_pattern(dev, pattern, error, =
filter);=0D
 	if (ret)=0D
 		return ret;=0D
 =0D
@@ -1149,11 +1376,25 @@ hinic3_flow_parse(struct rte_eth_dev *dev, const st=
ruct rte_flow_attr *attr,=0D
 	hinic3_parse_filter_t parse_filter;=0D
 	uint32_t pattern_num =3D 0;=0D
 	int ret =3D 0;=0D
-	/* Check whether the parameter is valid. */=0D
-	if (!pattern || !actions || !attr) {=0D
+=0D
+	if (!pattern) {=0D
+		rte_flow_error_set(error, EINVAL,=0D
+				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,=0D
+				   NULL, "Pattern is NULL.");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	if (!actions) {=0D
+		rte_flow_error_set(error, EINVAL,=0D
+				   RTE_FLOW_ERROR_TYPE_ACTION,=0D
+				   NULL, "Actions is NULL.");=0D
+		return -rte_errno;=0D
+	}=0D
+=0D
+	if (!attr) {=0D
 		rte_flow_error_set(error, EINVAL,=0D
-				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,=0D
-				   "NULL param.");=0D
+				   RTE_FLOW_ERROR_TYPE_ATTR,=0D
+				   NULL, "Attr is NULL.");=0D
 		return -rte_errno;=0D
 	}=0D
 =0D
@@ -1170,7 +1411,7 @@ hinic3_flow_parse(struct rte_eth_dev *dev, const stru=
ct rte_flow_attr *attr,=0D
 	 * The corresponding filter is returned. If the filter is not found,=0D
 	 * NULL is returned.=0D
 	 */=0D
-	parse_filter =3D hinic3_find_parse_filter_func(pattern);=0D
+	parse_filter =3D hinic3_find_parse_filter_func(dev, pattern);=0D
 	if (!parse_filter) {=0D
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,=0D
 				   pattern, "Unsupported pattern");=0D
@@ -1299,9 +1540,7 @@ hinic3_flow_create(struct rte_eth_dev *dev, const str=
uct rte_flow_attr *attr,=0D
 				   NULL, "Unsupported filter type.");=0D
 		goto free_flow;=0D
 	}=0D
-=0D
 	return flow;=0D
-=0D
 free_flow:=0D
 	rte_free(flow);=0D
 	rte_free(filter_rules);=0D
@@ -1332,10 +1571,6 @@ hinic3_flow_destroy(struct rte_eth_dev *dev, struct =
rte_flow *flow,=0D
 			&rules->ethertype_filter, false);=0D
 		if (!ret)=0D
 			TAILQ_REMOVE(&nic_dev->filter_ethertype_list, flow, node);=0D
-=0D
-		flow->rule =3D rules;=0D
-		flow->filter_type =3D rules->filter_type;=0D
-		TAILQ_REMOVE(&nic_dev->filter_ethertype_list, flow, node);=0D
 		break;=0D
 =0D
 	case RTE_ETH_FILTER_FDIR:=0D
@@ -1467,10 +1702,48 @@ hinic3_flow_flush(struct rte_eth_dev *dev, struct r=
te_flow_error *error)=0D
 	return ret;=0D
 }=0D
 =0D
-/* Structure for managing flow table operations. */=0D
+static int=0D
+hinic3_flow_query(struct rte_eth_dev *dev, struct rte_flow *flow,=0D
+		  __rte_unused const struct rte_flow_action *actions,=0D
+		  void *data, struct rte_flow_error *error)=0D
+{=0D
+	int ret =3D -EINVAL;=0D
+	enum rte_filter_type filter_type;=0D
+	struct hinic3_filter_t *filter_rules =3D NULL;=0D
+	struct rte_flow_query_count *flow_count =3D NULL;=0D
+=0D
+	if (!flow || !data) {=0D
+		PMD_DRV_LOG(ERR, "Invalid flow parameter!");=0D
+		return -EPERM;=0D
+	}=0D
+=0D
+	flow_count =3D (struct rte_flow_query_count *)data;=0D
+	filter_type =3D flow->filter_type;=0D
+	switch (filter_type) {=0D
+	case RTE_ETH_FILTER_ETHERTYPE:=0D
+		PMD_DRV_LOG(ERR, "Ethertype type %d, current not to process", filter_typ=
e);=0D
+		break;=0D
+	case RTE_ETH_FILTER_FDIR:=0D
+		filter_rules =3D (struct hinic3_filter_t *)flow->rule;=0D
+		ret =3D hinic3_flow_query_fdir_filter(dev, &filter_rules->fdir_filter,=0D
+			&flow_count->hits, &flow_count->bytes);=0D
+		break;=0D
+	default:=0D
+		PMD_DRV_LOG(ERR, "Filter type %d not support to query", filter_type);=0D
+		ret =3D -EINVAL;=0D
+		break;=0D
+	}=0D
+=0D
+	if (ret)=0D
+		rte_flow_error_set(error, -ret, RTE_FLOW_ERROR_TYPE_HANDLE, NULL, "Faile=
d to query flow.");=0D
+=0D
+	return ret;=0D
+}=0D
+=0D
 const struct rte_flow_ops hinic3_flow_ops =3D {=0D
 	.validate =3D hinic3_flow_validate,=0D
 	.create =3D hinic3_flow_create,=0D
 	.destroy =3D hinic3_flow_destroy,=0D
 	.flush =3D hinic3_flow_flush,=0D
+	.query =3D hinic3_flow_query,=0D
 };=0D
diff --git a/drivers/net/hinic3/hinic3_flow.h b/drivers/net/hinic3/hinic3_f=
low.h=0D
deleted file mode 100644=0D
index c4b38e44e7..0000000000=0D
--- a/drivers/net/hinic3/hinic3_flow.h=0D
+++ /dev/null=0D
@@ -1,196 +0,0 @@=0D
-/* SPDX-License-Identifier: BSD-3-Clause=0D
- * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
- */=0D
-=0D
-#ifndef _HINIC3_FLOW_H_=0D
-#define _HINIC3_FLOW_H_=0D
-=0D
-#include <rte_flow.h>=0D
-=0D
-/* Indicate the type of the IPv4 ICPM matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_icmp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_ICMP,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 any protocol matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_any[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_ANY,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the Ether matching pattern. */=0D
-static enum rte_flow_item_type pattern_ethertype[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the TCP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ethertype_tcp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_TCP,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the UDP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ethertype_udp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_UDP,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 vxlan matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_vxlan[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 vxlan any protocol matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_vxlan_any[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_ANY, RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 vxlan TCP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_vxlan_tcp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 vxlan UDP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_vxlan_udp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 vxlan IPv4 matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 vxlan IPv4 TCP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4_tcp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 vxlan IPv4 UDP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv4_udp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 vxlan IPv6 matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 vxlan IPv6 TCP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6_tcp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,=0D
-	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 vxlan IPv6 UDP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_vxlan_ipv6_udp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 UDP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_udp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_UDP,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv4 TCP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv4_tcp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_IPV4,=0D
-	RTE_FLOW_ITEM_TYPE_TCP,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv6 matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv6[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_IPV6,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv6 UDP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv6_udp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_IPV6,=0D
-	RTE_FLOW_ITEM_TYPE_UDP,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv6 TCP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv6_tcp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH,=0D
-	RTE_FLOW_ITEM_TYPE_IPV6,=0D
-	RTE_FLOW_ITEM_TYPE_TCP,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv6 TCP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv6_vxlan[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv6 VXLAN any protocol matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv6_vxlan_any[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_ANY, RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv6 VXLAN TCP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv6_vxlan_tcp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_TCP, RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-/* Indicate the type of the IPv6 VXLAN UDP matching pattern. */=0D
-static enum rte_flow_item_type pattern_ipv6_vxlan_udp[] =3D {=0D
-	RTE_FLOW_ITEM_TYPE_ETH, RTE_FLOW_ITEM_TYPE_IPV6,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_VXLAN,=0D
-	RTE_FLOW_ITEM_TYPE_UDP, RTE_FLOW_ITEM_TYPE_END,=0D
-};=0D
-=0D
-#endif /**< _HINIC3_FLOW_H_ */=0D
-- =0D
2.33.0=0D
=0D

