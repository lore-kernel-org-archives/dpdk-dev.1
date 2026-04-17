Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0B5F436BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 16:55:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 088704066E;
	Fri, 17 Apr 2026 18:55:41 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 2118A4066B
 for <dev@dpdk.org>; Fri, 17 Apr 2026 18:55:38 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2e622a9da9cso115043eec.0
 for <dev@dpdk.org>; Fri, 17 Apr 2026 09:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776444937;
 x=1777049737; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qjXWpw02ox++PKHv07yxq2Qz+ai0GWVcXF5rcgOBBK4=;
 b=MYhWUGdcjPEBPqjucn95FlVPhU+C7w+mRBIKWvwknVShAUHMB2UXNtS9ZFDPKAgzgr
 /Fgvq6H35hiTt8IoShxWDzAyuX465ewKRYicHZf5ATfEwFY2C4wDmxLlUtpPtphx/HYC
 MaHBtruvRg1sGoJ42cnsujzlyblIP/0v3jsO6xCPppBYikEiwrRh/DQzvrCsvBTQT4A9
 k1r9CjvJAL6Rkb0i0vNSLaNHJpDJvv2etGjqWVSVtjXd+TATX9l2x0MGlH6UXpOAbDcz
 oz8L1GSkaRHdglInR4b7EE8t0JZsXt7FnOe2bZS+8Gv+v3bC5xSblJAagR6HB04ZATun
 lqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444937; x=1777049737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qjXWpw02ox++PKHv07yxq2Qz+ai0GWVcXF5rcgOBBK4=;
 b=Wk1lK71yfzOkY7nFCLBMq8g1zfRVv4MNQtxIvHzUvNv4ZZ/OZMQ55x51bu2DaSwM//
 D4Wbk0ggkYCgYF96ii7Lfoi9sT4xdR2OD8iUJg2I/C3PmxX2Wcp3wF8kDumReZnzUgfm
 FxyvD9c9+fzwATudNAoNZbLUbKw226pK/iltBur2Xulj4gj0pCgKZmbJgKzbpU9z+DwJ
 Vs3WfQ3g7NCxNUfmZLW4p/LbiAM+y9GZCoaMdG7K7XiH82Yw2Ly8sxn0mRJa/0vbpwYT
 9BqSzEJy66qe+TdHjohIiYEuGUvNyWRfgWS5Qjj8lt9QTkjze3xb+9uhhMfclnSaaFRS
 Eqxw==
X-Gm-Message-State: AOJu0YzOmkHVjDo2FjK4ms/NRkgvWqQ5IkGdU6x/sWNKUbykbHOgnZMh
 ljBpxom7Z4s9D/C3/XMs8RX3n39ZSErEMkqM65vPvzzJcg78bsCz7MPtw/dSu4iI5PgpncNA9I+
 C/D5J
X-Gm-Gg: AeBDiesMILQmLiE3aagNGZXqoknK7lf68E3i7NpNvDQqNn6v1j9TMj3YwWj8rQhrK6z
 v4qz+6IgQSqz4N2hzfbYhm18pP7JNvc/ramcrsVeWfvArMrEYGk9MXcO6PKXJD6UFFLzdoswfYC
 gyxod+DxF+yFGC/P3EpXCelgRzDTVA+wk3sBLLZUnEFCsjCmMJlzQwuiUfimgB48THH9rfngxfq
 zgvCW8SlFmbUYvVmfWs3XuvImKvy5vJYu/1qvQkNpJ5+TmUOvOT/IQVsuCxEAW+iwz+gj5fDxmE
 Lz+55/2Avhb+BoDedSnnvvlNSsabb22ozEhpO7ox55GrbxlXcet/RAgHwRUVn5jCu64uwTFbGba
 yObprCc6qaYLwTF6h65cUggOcSUWtwcLhemJXzhZR60hTO4bbS8SPXKRz1hBjoJLxqiNmb6sRzB
 I1IaIBWipj9tI4df+JST8PPhKehFhIi8uz90j2lakOkjE=
X-Received: by 2002:a05:7301:9f10:b0:2d4:532e:7e45 with SMTP id
 5a478bee46e88-2e47930fdf6mr1926158eec.23.1776444937069; 
 Fri, 17 Apr 2026 09:55:37 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa6134sm2891264eec.3.2026.04.17.09.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:55:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH 3/3] net/bonding: remove redundant function names from log
Date: Fri, 17 Apr 2026 09:51:37 -0700
Message-ID: <20260417165530.653328-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417165530.653328-1-stephen@networkplumber.org>
References: <20260417165530.653328-1-stephen@networkplumber.org>
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

The function name is already printed as part of RTE_BOND_LOG().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_api.c |  4 ++--
 drivers/net/bonding/rte_eth_bond_pmd.c | 23 ++++++++++-------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index 9e5df67c18..78361e73d4 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -485,8 +485,8 @@ __eth_bond_member_add_lock_free(uint16_t bonding_port_id, uint16_t member_port_i
 	ret = rte_eth_dev_info_get(member_port_id, &dev_info);
 	if (ret != 0) {
 		RTE_BOND_LOG(ERR,
-			"%s: Error during getting device (port %u) info: %s",
-			__func__, member_port_id, strerror(-ret));
+			"Error during getting device (port %u) info: %s",
+			member_port_id, strerror(-ret));
 
 		return ret;
 	}
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 6a42257d2b..e2819c931b 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -210,8 +210,8 @@ bond_ethdev_8023ad_flow_verify(struct rte_eth_dev *bond_dev,
 	int ret = rte_flow_validate(member_port, &flow_attr_8023ad,
 			flow_item_8023ad, actions, &error);
 	if (ret < 0) {
-		RTE_BOND_LOG(ERR, "%s: %s (member_port=%d queue_id=%d)",
-				__func__, error.message, member_port,
+		RTE_BOND_LOG(ERR, "%s (member_port=%u queue_id=%u)",
+				error.message, member_port,
 				internals->mode4.dedicated_queues.rx_qid);
 		return -1;
 	}
@@ -219,8 +219,8 @@ bond_ethdev_8023ad_flow_verify(struct rte_eth_dev *bond_dev,
 	ret = rte_eth_dev_info_get(member_port, &member_info);
 	if (ret != 0) {
 		RTE_BOND_LOG(ERR,
-			"%s: Error during getting device (port %u) info: %s",
-			__func__, member_port, strerror(-ret));
+			"Error during getting device (port %u) info: %s",
+			member_port, strerror(-ret));
 
 		return ret;
 	}
@@ -228,8 +228,8 @@ bond_ethdev_8023ad_flow_verify(struct rte_eth_dev *bond_dev,
 	if (member_info.max_rx_queues < bond_dev->data->nb_rx_queues ||
 			member_info.max_tx_queues < bond_dev->data->nb_tx_queues) {
 		RTE_BOND_LOG(ERR,
-			"%s: Member %d capabilities doesn't allow allocating additional queues",
-			__func__, member_port);
+			"Member %u capabilities doesn't allow allocating additional queues",
+			member_port);
 		return -1;
 	}
 
@@ -249,9 +249,8 @@ bond_8023ad_slow_pkt_hw_filter_supported(uint16_t port_id) {
 		ret = rte_eth_dev_info_get(bond_dev->data->port_id, &bond_info);
 		if (ret != 0) {
 			RTE_BOND_LOG(ERR,
-				"%s: Error during getting device (port %u) info: %s",
-				__func__, bond_dev->data->port_id,
-				strerror(-ret));
+				"Error during getting device (port %u) info: %s",
+				bond_dev->data->port_id, strerror(-ret));
 
 			return ret;
 		}
@@ -2347,10 +2346,8 @@ bond_ethdev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 			ret = rte_eth_dev_info_get(member.port_id, &member_info);
 			if (ret != 0) {
 				RTE_BOND_LOG(ERR,
-					"%s: Error during getting device (port %u) info: %s",
-					__func__,
-					member.port_id,
-					strerror(-ret));
+					"Error during getting device (port %u) info: %s",
+					member.port_id, strerror(-ret));
 
 				return ret;
 			}
-- 
2.53.0

