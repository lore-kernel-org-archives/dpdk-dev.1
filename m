Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF878C28B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 23:55:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DC0C4065F;
	Wed, 12 Mar 2025 00:54:47 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 74F6640616
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:54:43 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-224341bbc1dso82840305ad.3
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741737282;
 x=1742342082; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmWO406VyN9Lqu1KSkQIemKCMrrUnJ8C6PWwYByac3c=;
 b=mDaifYdstL65LRO8JXFK2SriRLz2SYSg6WAcFpuQcYRDknLTAaKR/MbJAszFZtrtnH
 71SIIUdAR5G+GTYaAEp/HJUhAPV9obsw1Q68u4qJxMuzXuj3e80jIcYaXQllXaSYUWhE
 e2P28+dT5uV3C1DWS973CYBOR+RONAI38lmeQOr6XPYbwMkayt9cHnkg1yVTYL8AWRWy
 VdHPUbJIcT4Svj+Dh8HguJZu/nr6kADslGr3HE+qbQjV+i3ibHMHhVOzt7k4xSfc/mYl
 pIs6WFuaSD9dOVEM5TUgigwoEEVc/b8Vq7PzKxWba70XtYUmUmiaKbfs08RrwI8Roi5w
 Morw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737282; x=1742342082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmWO406VyN9Lqu1KSkQIemKCMrrUnJ8C6PWwYByac3c=;
 b=RhM9DaREZNz6x8toDDP4kwZrOLill6VZYNSElqLOtfnck8LMULHLyh1A3e869mLBtj
 l51X1bqnWCvpI0kElvWsfWCE9wyeIsBhV8oe3bLbtMrEPynKbBZ03Bgnyhsz/mQ3/UX4
 2+jEq2XewtMefyp9ffDd8QdU/hyrPxgUW9H1y4hqm2IlU221Gqp4iEfcw5hpeki68RH4
 LXxCNBtQ2e0pMRs999j+Dm5vdFUotrIy8SXtGAoAqm9q3cDCoiCZ4L2b4dQk7toONR+h
 LtV7uTeXQgr/YTvr6GJ/BWCC7IpJxtsTT6eC6crol+cE4tp3pAqCJmM2x2fu01gSfRTu
 c+Sw==
X-Gm-Message-State: AOJu0Yzn9zx2JJRZjv1xeHY5yggC3HHHJ2sUhTf1t6xw8T2aJpdgSwKf
 gF0AyzLJO47ahCUiSoEDzyQfjU/voPPfhVfsmya+HKUazLB+2tFowesKsxsWRUUr947TlUwJNb4
 o
X-Gm-Gg: ASbGncunzIeMO7jCrN4P8KRDVB5OyftCeP0WR1wHdK77YUnpOL/Nwal//ur6F7zIanC
 zEoe9/i3rKCqKO2zpF6UZab9g6u7MlThTHmaomQiCK5j10kHlvNeGLOkgvKpxUtJxVbweKv6Eva
 ylb2QaA9A5rnttrYy+YRXtJPUaKcG9aP30z6y3GA+V60188MCPIPnWan5hEGdK23olY+enAHqnP
 csKtl5m0huBBRtnof7+MrHICPUMCrH9K45hrRYNFxGG44MZ3mjE+7eQe4HbJuYZnYS5opsnuahe
 M2r1qjLY5wH+kgTL73lCitcQdkE2IJB7dz4Kcd5+CX1vE7Y56lIxLsk/AsWvTA0kqHbWjkUksMp
 dwMfslinmTJoqsiB1FqMBmg==
X-Google-Smtp-Source: AGHT+IFzXWssKK2PdypmPd7cqI+lOmmD882vbrA0NG7DtbMnMcvwNvYCbvNHbpQrdJfTzXy+In0kJg==
X-Received: by 2002:a17:902:e745:b0:223:3bf6:7e6a with SMTP id
 d9443c01a7336-22592e2c969mr81110245ad.12.1741737282668; 
 Tue, 11 Mar 2025 16:54:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cf4sm103734145ad.200.2025.03.11.16.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 16:54:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 4/9] net/ioring: implement management functions
Date: Tue, 11 Mar 2025 16:51:22 -0700
Message-ID: <20250311235424.172440-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311235424.172440-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250311235424.172440-1-stephen@networkplumber.org>
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

Add start, stop, configure and info functions.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ioring/rte_eth_ioring.c | 72 ++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
index fe3c72098c..b5b5ffdee3 100644
--- a/drivers/net/ioring/rte_eth_ioring.c
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -212,12 +212,16 @@ static int
 eth_dev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
+
+	int sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return -errno;
+
 	struct ifreq ifr = { .ifr_mtu = mtu };
-	int ret;
 
 	strlcpy(ifr.ifr_name, pmd->ifname, IFNAMSIZ);
 
-	ret = ioctl(pmd->ctl_sock, SIOCSIFMTU, &ifr);
+	int ret = ioctl(sock, SIOCSIFMTU, &ifr);
 	if (ret < 0) {
 		PMD_LOG(ERR, "ioctl(SIOCSIFMTU) failed: %s", strerror(errno));
 		ret = -errno;
@@ -230,14 +234,17 @@ static int
 eth_dev_macaddr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 {
 	struct pmd_internals *pmd = dev->data->dev_private;
-	struct ifreq ifr = { };
-	int ret;
 
+	int sock = socket(AF_INET, SOCK_DGRAM, 0);
+	if (sock < 0)
+		return -errno;
+
+	struct ifreq ifr = { };
 	strlcpy(ifr.ifr_name, pmd->ifname, IFNAMSIZ);
 	ifr.ifr_hwaddr.sa_family = ARPHRD_ETHER;
 	memcpy(ifr.ifr_hwaddr.sa_data, addr, sizeof(*addr));
 
-	ret = ioctl(pmd->ctl_sock, SIOCSIFHWADDR, &ifr);
+	int ret = ioctl(sock, SIOCSIFHWADDR, &ifr);
 	if (ret < 0) {
 		PMD_LOG(ERR, "ioctl(SIOCSIFHWADDR) failed: %s", strerror(errno));
 		ret = -errno;
@@ -246,6 +253,56 @@ eth_dev_macaddr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 	return ret;
 }
 
+static int
+eth_dev_start(struct rte_eth_dev *dev)
+{
+	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+	eth_dev_set_link_up(dev);
+
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
+
+	return 0;
+}
+
+static int
+eth_dev_stop(struct rte_eth_dev *dev)
+{
+	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+	eth_dev_set_link_down(dev);
+
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	return 0;
+}
+
+static int
+eth_dev_configure(struct rte_eth_dev *dev)
+{
+	/* rx/tx must be paired */
+	if (dev->data->nb_rx_queues != dev->data->nb_tx_queues)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int
+eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	dev_info->if_index = if_nametoindex(pmd->ifname);
+	dev_info->max_mac_addrs = 1;
+	dev_info->max_rx_pktlen = RTE_ETHER_MAX_LEN;
+
+	return 0;
+}
+
 static int
 eth_dev_close(struct rte_eth_dev *dev)
 {
@@ -263,11 +320,14 @@ eth_dev_close(struct rte_eth_dev *dev)
 		close(pmd->keep_fd);
 		pmd->keep_fd = -1;
 	}
-
 	return 0;
 }
 
 static const struct eth_dev_ops ops = {
+	.dev_start		= eth_dev_start,
+	.dev_stop		= eth_dev_stop,
+	.dev_configure		= eth_dev_configure,
+	.dev_infos_get		= eth_dev_info,
 	.dev_close		= eth_dev_close,
 	.link_update		= eth_link_update,
 	.dev_set_link_up	= eth_dev_set_link_up,
-- 
2.47.2

