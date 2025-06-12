Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F3C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 03:10:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2966340A73;
	Thu, 12 Jun 2025 05:10:01 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id CB0484021F
 for <dev@dpdk.org>; Thu, 12 Jun 2025 05:09:59 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7d0a2220fb0so57813185a.3
 for <dev@dpdk.org>; Wed, 11 Jun 2025 20:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749697799;
 x=1750302599; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woNWuB12r02XpFz+Jbqh8Q871tGqJ6uAz4w3P10kU5Q=;
 b=ipCaWLQYSbfUxv2V2fw6ldwMt8N07N3E65TVjz8jn1EvXE9G3svfdR8iNprM8I3Cse
 Br3kqHMUMJowQmukXkV3Qoq8tCwW5FPbTbT/uEdSfsMAE/uum1we4t2Rs4yvSLXcPUKt
 nRzzwDDEVxPoPP7dUcn8IAnih0CTiX17WjGWUjN6hppCpRZMkAtTV110g/Be2Y5s4jnY
 IkHX5grAPnXBBkDYPx33Pf5xjvyUDf1MVJKl15YgzIOrPCIIZLOapWO81V+FbxXn8Qax
 Zx0sNdB5hrOxZvIxsDTa04ULieQwvGVazo5e7KiOyx5qyzyzPE2bL+zR+I+7BFLZMjNy
 l46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749697799; x=1750302599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=woNWuB12r02XpFz+Jbqh8Q871tGqJ6uAz4w3P10kU5Q=;
 b=R7iM2IPIsRrEJHff2t1/kWFaMz36Es27Wwe0VgSxXLRzlFHVk/jYt5v1NNGTt7tXlu
 +uilifsBzOtuU3xWG6RE/EP+Lx8SQvoe59keZH4oJw8qQqMb9Zq5L2q+xUWinmma5o+V
 404X1XZOGFRMmbHDmTuwW+tnzFd8QKZ7Nf1im1fQqp3kK3SssG0qzq5xrfUK+XBTumgK
 dxaKbzWGh4MJSUsNWZm5A5AHhCDJY+Als7iXyH+afTr6wQiarZpTbtLGKt5QradJ1+0y
 G5KmPzFaNBZ8cyqjtwamdg54bA1ProOVwtIDT9eQoJJx8RX0hLygB3WkswOost+XCY7o
 LGTQ==
X-Gm-Message-State: AOJu0YxxsypsgtEGih3QVE5QqHLGvn2kXuFKA5aS1pqo8qDm0fMNf4y5
 WN2tHYnqJQ9Ucuj76sRdqQBj0iirjaJ3CtRnJeIiNF3F1eIEjj9QHjBEIlDCElkv+wVYhbAG/te
 fQYdF
X-Gm-Gg: ASbGncvTE1uK56rlBviNfjzfwDYoSwMpICfQrzSEyXnIu6G22P3PPRvxZB6qdktqJ8g
 CegYvuvuCOEvXH3e6IQJGksv0PYvuCSATsYq1skdU6K3098WWfPa9UxgYa8PWAptzanEKi5kRkE
 xtx35XgQVaHHwQpISTlJpBO3ZvoR+W4QtIX0z9DYiQusvUACOGGcbCfr6vWPdvMXANQCY6RoMAP
 FexS+gneqqGw6uKPlxstAIOo1mzaPgH8tRnWxRzlnwm8i5pZ9KOPM9RwwX26ZlhYyoL+8vmADO2
 u1QsXdFnq/tljCKZoWLf6I+5AkRiIhlz+8oUZ7wZBUsDL2cmvrH4JWOWb9PI2IPsQ48osVkHeM7
 MMbCqQPRV1d8nXV/RrBhZEchCm4QGCpemD79/m9eQKhxe0/Y=
X-Google-Smtp-Source: AGHT+IFIiISxDfjJR0YihRQWo6Emz5czXZPlWA84M/tQToMM8KJawwpmZfQP5bXqsGZcU76Rxqj/fQ==
X-Received: by 2002:a05:620a:a91a:b0:7d3:96ba:8561 with SMTP id
 af79cd13be357-7d3b35c8a63mr220258785a.8.1749697798920; 
 Wed, 11 Jun 2025 20:09:58 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d3b527db71sm58095385a.79.2025.06.11.20.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 20:09:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH] more replace memcpy with structure assignment
Date: Wed, 11 Jun 2025 20:08:51 -0700
Message-ID: <20250612030952.611893-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <5311136.0WQXIW03uk@thomas>
References: <5311136.0WQXIW03uk@thomas>
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

Prefer using simple structure assignment instead of memcpy.
Using a structure assignment preserves type information and
compiler checks types already.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
Reran cocci script against -rc1 and did minor replacement of "*&"

 drivers/common/sfc_efx/base/efx_mae.c | 2 +-
 drivers/net/zxdh/zxdh_ethdev_ops.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_mae.c b/drivers/common/sfc_efx/base/efx_mae.c
index 1429e7dd0a..4533e5cae6 100644
--- a/drivers/common/sfc_efx/base/efx_mae.c
+++ b/drivers/common/sfc_efx/base/efx_mae.c
@@ -1353,7 +1353,7 @@ efx_mae_match_spec_clone(
 		goto fail1;
 	}
 
-	memcpy(clone, orig, sizeof (efx_mae_match_spec_t));
+	*clone = *orig;
 
 	*clonep = clone;
 
diff --git a/drivers/net/zxdh/zxdh_ethdev_ops.c b/drivers/net/zxdh/zxdh_ethdev_ops.c
index f8e8d26c50..268f78900c 100644
--- a/drivers/net/zxdh/zxdh_ethdev_ops.c
+++ b/drivers/net/zxdh/zxdh_ethdev_ops.c
@@ -444,7 +444,7 @@ zxdh_dev_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 	} else {
 		struct zxdh_mac_filter *mac_filter = &msg_info.data.mac_filter_msg;
 		mac_filter->filter_flag = ZXDH_MAC_UNFILTER;
-		memcpy(&mac_filter->mac, addr, sizeof(struct rte_ether_addr));
+		mac_filter->mac = *addr;
 		zxdh_msg_head_build(hw, ZXDH_MAC_ADD, &msg_info);
 		ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(msg_info), NULL, 0);
 		if (ret) {
@@ -460,7 +460,7 @@ zxdh_dev_mac_addr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 
 		mac_filter->filter_flag = ZXDH_MAC_UNFILTER;
 		mac_filter->mac_flag = true;
-		memcpy(&mac_filter->mac, old_addr, sizeof(struct rte_ether_addr));
+		mac_filter->mac = *old_addr;
 		zxdh_msg_head_build(hw, ZXDH_MAC_DEL, &msg_info);
 		ret = zxdh_vf_send_msg_to_pf(dev, &msg_info, sizeof(msg_info), NULL, 0);
 		if (ret) {
@@ -532,7 +532,7 @@ zxdh_dev_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
 		struct zxdh_mac_filter *mac_filter = &msg_info.data.mac_filter_msg;
 
 		mac_filter->filter_flag = ZXDH_MAC_FILTER;
-		memcpy(&mac_filter->mac, mac_addr, sizeof(struct rte_ether_addr));
+		mac_filter->mac = *mac_addr;
 		zxdh_msg_head_build(hw, ZXDH_MAC_ADD, &msg_info);
 		if (rte_is_unicast_ether_addr(mac_addr)) {
 			if (hw->uc_num < ZXDH_MAX_UC_MAC_ADDRS) {
@@ -614,7 +614,7 @@ void zxdh_dev_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 		struct zxdh_mac_filter *mac_filter = &msg_info.data.mac_filter_msg;
 
 		mac_filter->filter_flag = ZXDH_MAC_FILTER;
-		memcpy(&mac_filter->mac, mac_addr, sizeof(struct rte_ether_addr));
+		mac_filter->mac = *mac_addr;
 		zxdh_msg_head_build(hw, ZXDH_MAC_DEL, &msg_info);
 		if (rte_is_unicast_ether_addr(mac_addr)) {
 			if (hw->uc_num <= ZXDH_MAX_UC_MAC_ADDRS) {
-- 
2.47.2

