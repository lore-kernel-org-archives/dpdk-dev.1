Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9499D2F346
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 17:02:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A80940678;
	Tue, 13 Jan 2026 18:01:56 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id BD9BA40669
 for <dev@dpdk.org>; Tue, 13 Jan 2026 18:01:54 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso2953225e9.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 09:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768323714;
 x=1768928514; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oq2cBJmWupHi6uL4R80gerW6VK4UxCh3Lu/XdCH7Mrw=;
 b=PLnrSWVqGUucAbWBVniXLHzta31OEpepam7/Q1K2+hiRzCImUmGDNi1Kqcdk9t+WwX
 iNibLVAuovkE2W9FWiTkS7Q2FHvoipRm1x7+DH3wwUTy3EF8soESsTMnbVCMGV5k927Z
 vJPLBhbwn29Hb8bh0nCgNa47Mvm2SXIP69nonIM2En+Hx6ySowW5KZrUkhxnBx9caXg9
 25SWcbP/yeaz6Fi7Xe0+s/zbmKyxkTY+oS6+yLKGkrHX6YF4NryGg+sVEOfR33iWD+kV
 2R5/7KYV0q5wbrgce94F4bzy93UjkIARa3FLxwsJZtymzNLJBEspdZzNmB5ryOC/kVR3
 YnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768323714; x=1768928514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oq2cBJmWupHi6uL4R80gerW6VK4UxCh3Lu/XdCH7Mrw=;
 b=P4UQVFPlp8f/gHFZKscgjhO0Gz0KdQKM66nTIc7+zV3xErsDDyZOZKQ8wHtEeG2mCG
 nAk3XObYXMEU/Z6QMEvugOv9o/MZk75TP1Z+7TP/+jFJ+mRVoa7X1VRiFvdCXQRRvili
 qqQOLP5S9Y/6s13Mnqhq+O70u9EQTltnSh+IqFAawNMRA4IBCPXAlAgvuSKXgbyU6EjM
 /F8LJbepWY00d5twq0Y5HThNG2fOhHffT6ONF8n2JcZQlZEnAXr/a8OtJg8meRUO073B
 MN5VpnG+MMIu6A3lTkBfoqDd83bE0J/NtuJmIYCCCP46MjjQ0u6dV3vTLAPouL38/Pq+
 YF2w==
X-Gm-Message-State: AOJu0YxN3IIVUWSa25vZchChxJvovaJw8ZFRJEPIaVl63K+CLSxRCOy7
 mb2M0ZRcEMnaqYYHBfeWjAKAHYrRp3YuhYYTk7pLTy9sNIvSAn+8GOKsZscFzrEQN6cxKIHquL4
 f4IIT
X-Gm-Gg: AY/fxX4lSwOxYWWvMKhZu01vMaIhvX3AMe+P0p5D/SxTsA6PA+uZTS5kz2IfRGpuuMN
 YaNNVmODOZIxDflte2glgFS8TWIUHWS7Qno4TPyTo9K5jLVOb1oArAoR3wSQ02QCyaG8/CND0Ua
 j0HzfOtrBd94ROy+xN2M0ZArBlqrW9J5ldFWIGUTn9qFCCAIvWaG3MS+Z64CDTVHnx4EGHT2gt5
 iIn4iktHlZwyswg0G9JERX0luro600N19UoMmApFN6ZuZdDyi5i7PJmGC86dIZg59ioZvmmIBpc
 Si/TCoT5LlEmjGHLJiktxAIvDlaWX6280e5LThyJy1hFK9Vxh/rq6WipWa9iezCIMjYNW6hy90z
 6RSfu/H70bg+2rAPVfbfsJU9Vxw8Z/RMVXK79wnOC/LPf9anfbZzMqCQ8LOEWaTBsinjqsnmbRI
 vUtanainjGhUqtAcCb6hLAYfPA6gHgvNOJsFOaYG4+77MXkvqwvQ==
X-Google-Smtp-Source: AGHT+IHmKKhj0cFRdCAlzCqgfkTJUYBKBrGrJoLl0kHQ/Lk0U8vAaGvrmRm3q9Fpk2g/NvuDHmEJpQ==
X-Received: by 2002:a05:600c:3b90:b0:471:9da:5248 with SMTP id
 5b1f17b1804b1-47d84b39890mr252200375e9.26.1768323714121; 
 Tue, 13 Jan 2026 09:01:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee117e607sm4282985e9.3.2026.01.13.09.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 09:01:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Madhuker Mythri <madhukar.mythri@gmail.com>
Subject: [RFT 2/2] net/netvsc: fix link status RNDIS command concurrency issue
Date: Tue, 13 Jan 2026 08:58:07 -0800
Message-ID: <20260113170143.70873-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113170143.70873-1-stephen@networkplumber.org>
References: <20260113101820.60611-1-madhukar.mythri@gmail.com>
 <20260113170143.70873-1-stephen@networkplumber.org>
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

The hn_dev_link_update() function issues RNDIS queries for link status
and link speed on every call. Since this function can be called from
multiple threads concurrently, it triggers the same RNDIS command
concurrency issue where only one request can be pending at a time.

Remove the hn_rndis_get_linkstatus() and hn_rndis_get_linkspeed()
functions and modify hn_dev_link_update() to use the cached values
directly. The link status and speed are already:

1. Queried once during device attach in hn_rndis_attach()
2. Updated via RNDIS status indications (MEDIA_CONNECT/DISCONNECT
   and LINK_SPEED_CHANGE) handled in hn_rndis_link_status()

This matches the Linux netvsc driver behavior where link status is
queried once in rndis_filter_device_add() and then tracked via
status indications.

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org

Reported-by: Madhuker Mythri <madhukar.mythri@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_ethdev.c | 13 ++++---
 drivers/net/netvsc/hn_rndis.c  | 65 ++++++++++++++++++++++++++--------
 drivers/net/netvsc/hn_rndis.h  |  2 --
 3 files changed, 57 insertions(+), 23 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 6584819f4f..c4580d0bb3 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -246,16 +246,15 @@ hn_dev_link_update(struct rte_eth_dev *dev,
 {
 	struct hn_data *hv = dev->data->dev_private;
 	struct rte_eth_link link, old;
-	int error;
 
 	old = dev->data->dev_link;
 
-	error = hn_rndis_get_linkstatus(hv);
-	if (error)
-		return error;
-
-	hn_rndis_get_linkspeed(hv);
-
+	/*
+	 * Use cached link_status and link_speed which are set during
+	 * device attach and updated via RNDIS status indications
+	 * (MEDIA_CONNECT/DISCONNECT and LINK_SPEED_CHANGE).
+	 * This avoids RNDIS queries which are not thread-safe.
+	 */
 	link = (struct rte_eth_link) {
 		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
 		.link_autoneg = RTE_ETH_LINK_SPEED_FIXED,
diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c
index ed053ee905..c85953af34 100644
--- a/drivers/net/netvsc/hn_rndis.c
+++ b/drivers/net/netvsc/hn_rndis.c
@@ -299,6 +299,7 @@ static void hn_rndis_link_alarm(void *arg)
 void hn_rndis_link_status(struct rte_eth_dev *dev, const void *msg)
 {
 	const struct rndis_status_msg *indicate = msg;
+	struct hn_data *hv = dev->data->dev_private;
 
 	hn_rndis_dump(msg);
 
@@ -311,11 +312,41 @@ void hn_rndis_link_status(struct rte_eth_dev *dev, const void *msg)
 		break;
 
 	case RNDIS_STATUS_LINK_SPEED_CHANGE:
+		/*
+		 * Update link speed from the status buffer.
+		 * This matches the Linux netvsc driver behavior.
+		 */
+		if (indicate->stbuflen >= sizeof(uint32_t)) {
+			const uint8_t *p = (const uint8_t *)msg;
+			uint32_t offset = RNDIS_STBUFOFFSET_ABS(indicate->stbufoffset);
+
+			if (offset + sizeof(uint32_t) <= indicate->len) {
+				uint32_t speed;
+
+				memcpy(&speed, p + offset, sizeof(speed));
+				hv->link_speed = speed;
+				PMD_DRV_LOG(DEBUG, "link speed changed to %u",
+					    speed);
+			}
+		}
+		if (dev->data->dev_conf.intr_conf.lsc)
+			rte_eal_alarm_set(10, hn_rndis_link_alarm, dev);
+		break;
+
 	case RNDIS_STATUS_MEDIA_CONNECT:
+		hv->link_status = NDIS_MEDIA_STATE_CONNECTED;
+		PMD_DRV_LOG(INFO, "link connected");
+		if (dev->data->dev_conf.intr_conf.lsc)
+			rte_eal_alarm_set(10, hn_rndis_link_alarm, dev);
+		break;
+
 	case RNDIS_STATUS_MEDIA_DISCONNECT:
+		hv->link_status = NDIS_MEDIA_STATE_DISCONNECTED;
+		PMD_DRV_LOG(INFO, "link disconnected");
 		if (dev->data->dev_conf.intr_conf.lsc)
 			rte_eal_alarm_set(10, hn_rndis_link_alarm, dev);
 		break;
+
 	default:
 		PMD_DRV_LOG(NOTICE, "unknown RNDIS indication: %#x",
 			    indicate->status);
@@ -1095,20 +1126,6 @@ hn_rndis_get_mtu(struct hn_data *hv, uint32_t *mtu)
 			       mtu, sizeof(uint32_t));
 }
 
-int
-hn_rndis_get_linkstatus(struct hn_data *hv)
-{
-	return hn_rndis_query(hv, OID_GEN_MEDIA_CONNECT_STATUS, NULL, 0,
-			      &hv->link_status, sizeof(uint32_t));
-}
-
-int
-hn_rndis_get_linkspeed(struct hn_data *hv)
-{
-	return hn_rndis_query(hv, OID_GEN_LINK_SPEED, NULL, 0,
-			      &hv->link_speed, sizeof(uint32_t));
-}
-
 int
 hn_rndis_attach(struct hn_data *hv)
 {
@@ -1133,6 +1150,26 @@ hn_rndis_attach(struct hn_data *hv)
 		return error;
 	}
 
+	/*
+	 * Query initial link status and speed. These will be updated
+	 * via RNDIS status indications (MEDIA_CONNECT/DISCONNECT and
+	 * LINK_SPEED_CHANGE) rather than being re-queried each time.
+	 * This matches the Linux netvsc driver behavior.
+	 */
+	error = hn_rndis_query(hv, OID_GEN_MEDIA_CONNECT_STATUS, NULL, 0,
+			       &hv->link_status, sizeof(hv->link_status));
+	if (error) {
+		PMD_DRV_LOG(ERR, "failed to query link status: %d", error);
+		return error;
+	}
+
+	error = hn_rndis_query(hv, OID_GEN_LINK_SPEED, NULL, 0,
+			       &hv->link_speed, sizeof(hv->link_speed));
+	if (error) {
+		PMD_DRV_LOG(ERR, "failed to query link speed: %d", error);
+		return error;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/netvsc/hn_rndis.h b/drivers/net/netvsc/hn_rndis.h
index 7f40f6221d..26854f45a4 100644
--- a/drivers/net/netvsc/hn_rndis.h
+++ b/drivers/net/netvsc/hn_rndis.h
@@ -11,8 +11,6 @@ int	hn_rndis_attach(struct hn_data *hv);
 void	hn_rndis_detach(struct hn_data *hv);
 int	hn_rndis_get_eaddr(struct hn_data *hv, uint8_t *eaddr);
 int	hn_rndis_get_mtu(struct hn_data *hv, uint32_t *mtu);
-int	hn_rndis_get_linkstatus(struct hn_data *hv);
-int	hn_rndis_get_linkspeed(struct hn_data *hv);
 int	hn_rndis_set_rxfilter(struct hn_data *hv, uint32_t filter);
 void	hn_rndis_rx_ctrl(struct hn_data *hv, const void *data,
 			 int dlen);
-- 
2.51.0

