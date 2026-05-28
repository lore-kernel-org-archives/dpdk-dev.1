Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5929ECD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 00:02:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 088D24066B;
	Fri, 29 May 2026 02:02:09 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 3A6634027F
 for <dev@dpdk.org>; Fri, 29 May 2026 02:02:06 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso9279424eec.0
 for <dev@dpdk.org>; Thu, 28 May 2026 17:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780012925;
 x=1780617725; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uzPYDmwWuRq0BNB5H1gJxiuB1S1wFXR6EmwQgtErfI=;
 b=sbn3C6UexvAo91VdP3krrgQ35NzG/oAf4H5i7DlSM60KOb5rr4S1l8d26Dg9oWTpN7
 OUvget/w7lPaqQEi3svozx84W0Zh3nm9cJFPfvHXyWLdel0fvKDs021kINvg8baSz5jo
 kfTZSnDGkR/QjCBYvFiCqcloDReojbVWYc6luoUBr6Hq55vJ/YOIxXRNSDDmxcNFSc9n
 Loi+DXsTmYY0tBk4emoN3/1NUkm13ULz5uezv03TgmTE+M5jJkM6PrcTimDqFBOQvsG/
 oaCq5b1OxF74u2qfwzzwsCXAEwwcBIJAseALoaWtFeXlzeVcM8alq8I2XFOAFVYAiD65
 EJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780012925; x=1780617725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/uzPYDmwWuRq0BNB5H1gJxiuB1S1wFXR6EmwQgtErfI=;
 b=owDgozZJaSinhG+eO5c0vKh2E6NjMl5PEDIBGQLhgC9FZyTuvUJDciL0TQImoWDt/t
 9wMOdZOj+5g996TubT31ZJVPxaAeYOTglf4j79yiPJR56mMdkgPI4wBIXWXO+2tE2MYD
 h3gBicV8rWEyTs74OqiEhR3QTWwe48WfZfF+9zPdOvBj/i0nLbXuFHGsNtLKyXpNOigr
 cyDr+P5sHBsaKdGycagzqwR4oswehZsOcGLcWJI19szAgD+O0YyNzo/EGPsiyZ5zMYZV
 6eGPrO3HgS1/0TTOlvRnHZMz+X+NVCs0/a6D8GXvDa5YRVJe18uwLvN/4atk9kb4QKGv
 HzOA==
X-Gm-Message-State: AOJu0YyjQtY2DTOYu/i7xi2VhtBkNF0K3laxy9NPgu05R/u6lrRhP4Mk
 tMFxnkNjhwaDVOihshPXAMBJ5TiTXBvItLqhlkGSPibsF+NYSEgU7Kq1YWb3S39dnU/l+LBBQsq
 DvfKy
X-Gm-Gg: Acq92OFaxTIU5Sudzk6F2p+budPNaHqmm5ZZgAQKF/ymmU2OLCb8SM3JoROI4J/RPdq
 RfZ3AW+DsMvkVLWHcViX2bOPa1a+YREPdEmivo5Jz8sPVjcFER13T9Ka8T/h2OZ2uSjrLHmuf+f
 6bXgHzNaNWvq6oqv9JA4gUGjP2BhbQvq1XjqSYDFSQCOQhsazutlMzUun11J2ZC0USJigAjsGDc
 FMy/fFk1jiqom4vCI/I8GyWT4InKzgSBnU9dApZSo+8GDRleT/9kIw1SluL5aMDiUr6bLgIb4Yw
 rQnvvAmGJgOT/eI9UIapthncqH2ktV3u9dKwbS9+fJ51vg2ks2pwgHt1hP+7oXvE60qc+3N+qBZ
 w2m4LmHeiqN3m+a5/3XSoL/NvXj7/xoEvrvkYDGQB8BjfQbIXjD02icCNOWcEt0/1hLGWtkFKDV
 KgFAbtmZP4wGihLkQum41vuScaKWfkRdl595yNmQvprKzFK1Eid2Mje2ywaKbrxwmwCIIUhQUR
X-Received: by 2002:a05:7300:7313:b0:304:13f3:ecdd with SMTP id
 5a478bee46e88-304eaccee98mr276924eec.0.1780012925170; 
 Thu, 28 May 2026 17:02:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5d5385sm53076eec.28.2026.05.28.17.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 17:02:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v2 4/4] net/bonding: remove redundant function names from log
Date: Thu, 28 May 2026 16:59:16 -0700
Message-ID: <20260529000157.235931-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529000157.235931-1-stephen@networkplumber.org>
References: <20260417165530.653328-1-stephen@networkplumber.org>
 <20260529000157.235931-1-stephen@networkplumber.org>
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
Fix grammar in log messages.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_api.c |  4 ++--
 drivers/net/bonding/rte_eth_bond_pmd.c | 23 ++++++++++-------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index 9e5df67c18..d9b6f1c417 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -485,8 +485,8 @@ __eth_bond_member_add_lock_free(uint16_t bonding_port_id, uint16_t member_port_i
 	ret = rte_eth_dev_info_get(member_port_id, &dev_info);
 	if (ret != 0) {
 		RTE_BOND_LOG(ERR,
-			"%s: Error during getting device (port %u) info: %s",
-			__func__, member_port_id, strerror(-ret));
+			"Error getting device (port %u) info: %s",
+			member_port_id, strerror(-ret));
 
 		return ret;
 	}
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 8a9c329fb8..6a4f997b5a 100644
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
+			"Error getting device (port %u) info: %s",
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
+				"Error getting device (port %u) info: %s",
+				bond_dev->data->port_id, strerror(-ret));
 
 			return ret;
 		}
@@ -2346,10 +2345,8 @@ bond_ethdev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 			ret = rte_eth_dev_info_get(member.port_id, &member_info);
 			if (ret != 0) {
 				RTE_BOND_LOG(ERR,
-					"%s: Error during getting device (port %u) info: %s",
-					__func__,
-					member.port_id,
-					strerror(-ret));
+					"Error getting device (port %u) info: %s",
+					member.port_id, strerror(-ret));
 
 				return ret;
 			}
-- 
2.53.0

