Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F01C021B5
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 02:44:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9038E402D7;
	Sun, 23 Feb 2025 03:43:49 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 97B4E402AE
 for <dev@dpdk.org>; Sun, 23 Feb 2025 03:43:47 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-22185cddbffso71042665ad.1
 for <dev@dpdk.org>; Sat, 22 Feb 2025 18:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740278627;
 x=1740883427; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGJc6yZ83F6n8UFFNNPkBEnMlhU1wS2mc2izZ3el3Ns=;
 b=dK4NDSdY8lHLeLVBm1KJ5O1Kl6OSuiFlyES1Pw8nWPFzmIsHGGOnFBnP8QCXnyadp1
 vPJSrJgFE8ovxXdP04531LKiLE+XzUO1tgLgwWCCxGJ4Ttgy/yYw6fLaEx0ubS6296Z2
 J1Kjbi4ZmhBqhmS31BuDLhkU9fq+i737Uod5oXUgNBQ/n/ULgvy+z8kYNOv0h0pxkPpu
 GiVavw8I2quPQVrowivRYqMHkcnbu5qSvi1W7JMSLxL1bjG20ny4Ie8Ot784yO62jOxW
 58N61Qyg62pEye17Yko328K5UObPRM1YDMc9JTbZkft9ONTpun/gIT6d6Z2gdTxaykzO
 IlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740278627; x=1740883427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGJc6yZ83F6n8UFFNNPkBEnMlhU1wS2mc2izZ3el3Ns=;
 b=U2ucTfRr9XO7sk5SMVc79jqv0dTtj+ngHjxI6BXThynLU5hROiWqObzh0uYiYkxx5v
 AD18Gf2ZSA//Z55geKI1wgegJPITV4bGM2VwGb/l8H25vK3xzJkD22mETTFTNHgJSQty
 oKLre7jkhZ6BK4psaQzwnnnI7agl1wa0IASF7XTATA7ZGtKJ7JMRpzvUEMtbeGruOprA
 zXZYQIEYuvXid4sSl+8SJ63avGxrGcjJnKFOh767fwNhVLH72OX3bnyobG2wDNqQMBOs
 +5RsWrYX+c+eJPPQ5tXgJgco+NIhgAcSiWBT3wvikFcXLxFBXeKruqMFiWB+rS1xSv4p
 iSTw==
X-Gm-Message-State: AOJu0Yz95FVJ0ysaZxNbLu1xyNN8eSujfjXb5iHpibXbiJj3WcVCXXY5
 VYJBMVJiE/a+o0o8OvxArTxKPq4lgrKpHVSH0HbGUGYe46YpWZrzU/gjOG+HOgysA2IqfyjNeEu
 J
X-Gm-Gg: ASbGnctLE/3I+nnEYezr0qAUbIDi23PME3crae36nD6cnshtlySENatDSZRpKSRn+M6
 V9DJe1Th18z6b17/3/gTQ22vsqDlJQjdt7RBgooSv8NqV6KrIrLrCuIassHzmPDfNjM6UnZj6OQ
 cTfSVEwKJasxrUBorhKEDR5ZDiHxwqm0IgTBMI+GEzI2HWg32fAE/0jA/aZ7FrRVv9vgRFk7JCg
 bPpXOFcEV1AV08HA4qcewjVP9iFbozueOQiTLww4MAdp1qKAhIl6gkiZHekOgNZwNXHFRAPxYmf
 t2JwkQss/XVUNZOdh9jKuml45QdVlkdSWNiVwaOg22/aDPPrusXayPosQ5rG0LuIvq4JC7cvirX
 IgWc=
X-Google-Smtp-Source: AGHT+IEUmq2+PxGit3knbp8d/BtqPb75fercrX7y23m8bEAwvBvk7k1stL3qbYEKmFc2+weiJM4hWg==
X-Received: by 2002:a17:903:2311:b0:21f:5063:d3ca with SMTP id
 d9443c01a7336-2218c5575dbmr216078165ad.16.1740278626740; 
 Sat, 22 Feb 2025 18:43:46 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536443fsm156112955ad.66.2025.02.22.18.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 18:43:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [RFC 2/5] net/zxdh: remove __rte_unused attribute
Date: Sat, 22 Feb 2025 18:42:21 -0800
Message-ID: <20250223024334.1216477-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250223024334.1216477-1-stephen@networkplumber.org>
References: <20250223024334.1216477-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These are all function arguments that are used but incorrectly
labeled as unused.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_ethdev.c     |  2 +-
 drivers/net/zxdh/zxdh_ethdev_ops.c |  2 +-
 drivers/net/zxdh/zxdh_msg.c        | 20 ++++++++------------
 drivers/net/zxdh/zxdh_mtr.c        |  2 +-
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
index cbda0615db..d444bc2484 100644
--- a/drivers/net/zxdh/zxdh_ethdev.c
+++ b/drivers/net/zxdh/zxdh_ethdev.c
@@ -1465,7 +1465,7 @@ zxdh_agent_comm(struct rte_eth_dev *eth_dev, struct zxdh_hw *hw)
 }
 
 static inline int
-zxdh_dtb_dump_res_init(struct zxdh_hw *hw __rte_unused, ZXDH_DEV_INIT_CTRL_T *dpp_ctrl)
+zxdh_dtb_dump_res_init(struct zxdh_hw *hw, ZXDH_DEV_INIT_CTRL_T *dpp_ctrl)
 {
 	int ret = 0, i;
 
diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_ethdev_ops.c
index 12ad3f8d2c..2b02734c62 100644
--- a/drivers/net/zxdh/zxdh_ethdev_ops.c
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
@@ -564,7 +564,7 @@ zxdh_dev_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
 	return 0;
 }
 
-void zxdh_dev_mac_addr_remove(struct rte_eth_dev *dev __rte_unused, uint32_t index __rte_unused)
+void zxdh_dev_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 {
 	struct zxdh_hw *hw	= dev->data->dev_private;
 	struct zxdh_msg_info msg_info = {0};
diff --git a/drivers/net/zxdh/zxdh_msg.c b/drivers/net/zxdh/zxdh_msg.c
index e5b5f53c64..5a47b4fde6 100644
--- a/drivers/net/zxdh/zxdh_msg.c
+++ b/drivers/net/zxdh/zxdh_msg.c
@@ -1245,8 +1245,7 @@ zxdh_vf_promisc_uninit(struct zxdh_hw *hw, union zxdh_virport_num vport)
 
 static int
 zxdh_vf_port_init(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
-		struct zxdh_msg_reply_body *res_info __rte_unused,
-		uint16_t *res_len __rte_unused)
+		  struct zxdh_msg_reply_body *res_info, uint16_t *res_len)
 {
 	struct zxdh_port_attr_table port_attr = {0};
 	union zxdh_virport_num port = {.vport = vport};
@@ -1312,8 +1311,7 @@ zxdh_mac_clear(struct zxdh_hw *hw, union zxdh_virport_num vport)
 static int
 zxdh_vf_port_uninit(struct zxdh_hw *pf_hw,
 		uint16_t vport, void *cfg_data __rte_unused,
-		struct zxdh_msg_reply_body *res_info __rte_unused,
-		uint16_t *res_len __rte_unused)
+		struct zxdh_msg_reply_body *res_info, uint16_t *res_len)
 {
 	char str[ZXDH_MSG_REPLY_BODY_MAX_LEN] = "uninit";
 	struct zxdh_port_attr_table port_attr = {0};
@@ -1674,7 +1672,7 @@ zxdh_vf_rss_table_get(struct zxdh_hw *hw, uint16_t vport, void *cfg_data __rte_u
 
 static int
 zxdh_vf_port_attr_set(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
-	struct zxdh_msg_reply_body *res_info __rte_unused, uint16_t *res_len __rte_unused)
+	      struct zxdh_msg_reply_body *res_info, uint16_t *res_len)
 {
 	RTE_ASSERT(!cfg_data || !pf_hw);
 	if (res_info)
@@ -1735,10 +1733,8 @@ zxdh_vf_port_attr_set(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
 }
 
 static int
-zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
-		void *cfg_data __rte_unused,
-		struct zxdh_msg_reply_body *res_info __rte_unused,
-		uint16_t *res_len __rte_unused)
+zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport, void *cfg_data,
+		struct zxdh_msg_reply_body *res_info, uint16_t *res_len)
 {
 	struct zxdh_np_stats_updata_msg *np_stats_query =
 			 (struct zxdh_np_stats_updata_msg  *)cfg_data;
@@ -1876,7 +1872,7 @@ zxdh_vf_np_stats_update(struct zxdh_hw *pf_hw, uint16_t vport,
 }
 
 static int
-zxdh_vf_mtr_hw_stats_get(struct zxdh_hw *pf_hw __rte_unused,
+zxdh_vf_mtr_hw_stats_get(struct zxdh_hw *pf_hw,
 	uint16_t vport, void *cfg_data,
 	struct zxdh_msg_reply_body *res_info,
 	uint16_t *res_len)
@@ -1908,7 +1904,7 @@ zxdh_vf_mtr_hw_stats_get(struct zxdh_hw *pf_hw __rte_unused,
 }
 
 static int
-zxdh_vf_mtr_hw_profile_add(struct zxdh_hw *pf_hw __rte_unused,
+zxdh_vf_mtr_hw_profile_add(struct zxdh_hw *pf_hw,
 	uint16_t vport,
 	void *cfg_data,
 	struct zxdh_msg_reply_body *res_info,
@@ -2111,7 +2107,7 @@ zxdh_config_process_callback(struct zxdh_hw *hw, struct zxdh_msg_info *msg_info,
 
 static int
 pf_recv_bar_msg(void *pay_load, uint16_t len, void *reps_buffer,
-	uint16_t *reps_len, void *eth_dev __rte_unused)
+	uint16_t *reps_len, void *eth_dev)
 {
 	struct zxdh_msg_info *msg_info = (struct zxdh_msg_info *)pay_load;
 	struct zxdh_msg_reply_body *reply_body = reps_buffer;
diff --git a/drivers/net/zxdh/zxdh_mtr.c b/drivers/net/zxdh/zxdh_mtr.c
index c36170b23f..2df5f1cd88 100644
--- a/drivers/net/zxdh/zxdh_mtr.c
+++ b/drivers/net/zxdh/zxdh_mtr.c
@@ -1192,7 +1192,7 @@ zxdh_meter_ops_get(struct rte_eth_dev *dev __rte_unused, void *arg)
 }
 
 void
-zxdh_mtr_release(struct rte_eth_dev *dev __rte_unused)
+zxdh_mtr_release(struct rte_eth_dev *dev)
 {
 	struct zxdh_hw *priv = dev->data->dev_private;
 	struct zxdh_meter_profile *profile;
-- 
2.47.2

