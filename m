Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5031C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 21:52:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43B4D402E5;
	Thu, 13 Mar 2025 22:52:11 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 0D82D402E4
 for <dev@dpdk.org>; Thu, 13 Mar 2025 22:52:07 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-22409077c06so39599525ad.1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741902726;
 x=1742507526; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmWO406VyN9Lqu1KSkQIemKCMrrUnJ8C6PWwYByac3c=;
 b=OlQkczS4MoIBehZhfk0j8lruMjdB69gV/ZFFvd2WESfTKhFgC0n/C1WhrfN5V3PRxm
 ilWp/pnr4QskKE59scCS1TKcnxwg5vBKpXli4nEj622n3viX2ABkjjkV1x1aYpsmgQwo
 ubfv26mn9O+X4KvAmQoVOLUvV7zW6cVF4InZYvcfj8IqUndz1Iyhnq0PnJo3VAPHlrdC
 Ux2u2t+3LcXnbD4wXQXGwvTfKb857TvMRHtGsiMjOTjMAWUehFu6NxmhbfysbaslBGLS
 abQNtUhL+yWAHTv8hfg55Gi1ZK/o1q4BBrM9OrPy8lBQyphQfFkcOd9Pqcm04IJbbAkJ
 vSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741902726; x=1742507526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmWO406VyN9Lqu1KSkQIemKCMrrUnJ8C6PWwYByac3c=;
 b=jFkKda/rH4hPcaTX8vDAZTEgzC1d3DgEVh5P72zB066W5gMw4BnORgpYLSbwC3qjDU
 FqC5Tk+0TS86SUfgL2w7O+XaRZ59YFVM9iHKxOeltSaJC1sJ3etC0nFnvDp3clpYWBCX
 SXuGUX5PE4ltCrZJfhBdLkEdbS90OHDOyHybc+jT5n+IDNdc8N4otM40Fa33EINE+vHB
 KyXK4h2yLuItt3+8IyFJIOlz1HbnoVzLA3eFMxKkVSRojZ5AQ2e38g9CyDPPIkK/KYBI
 KfbyLjjq3XHjGEQ3PGn1QKW/e/WDIcOKyc2OkopQcV8N1QaHFyvt1gn3sW3vjrfRbAKx
 HbrQ==
X-Gm-Message-State: AOJu0YxnItDhNt3PNqsziA0NYPDlUZWzfbT54DXDwDd1t7vJc0Y2Gj/B
 7wfRnrRtlACSiSmTvXhFjMxedweYSMaAX7WXeUwqOG6qOfw3tTFm6UgXdH6inrWZjvv7l3ZLDGL
 I
X-Gm-Gg: ASbGncvW/LdPGWIZ2nqbf+iFIKr5rSOxyUFYhpSgzqk8NqYh0lALDnWSrmoyC7dPthP
 mS7Y5qZZBIMtZgdvF0n/99V8tM8qga9nXAeVjvTOZme7yrHkePZ+QsIqCXOARKwew6F6IQUgPGa
 14HzZ2Kvstuxh/kFQstPFuUlAOK/FYl7WRiyK5jiIpHzK4fKy+ut4IjtCJl8BVlGpjp1wvEp4Mz
 2MFb1ouqR1h6oZkPLNaRNEhYbFgc3kPl0h1tMlBogptipG8TeXHKxpi7y4fz3jXrTwnzetoAPGv
 qTyJPtFT8TlXbmAcibGEDNbNDu5nBkuOfTlrRPBro5fNxkYkEUB+cKVjjJqmLr45zXoUM6FUkBD
 1OrOOVIp0pReBg8YH8+hMlQ==
X-Google-Smtp-Source: AGHT+IFyqVcGwDp7HLnQLP97BT0gOLHHBs8JvY+5QiCjtbNky1kygpA9UIS88+AGXFXwKfRiToC+kQ==
X-Received: by 2002:a17:903:41c9:b0:224:1c41:a4bc with SMTP id
 d9443c01a7336-225e0a361aemr2488305ad.12.1741902726288; 
 Thu, 13 Mar 2025 14:52:06 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd3d5bsm18337775ad.217.2025.03.13.14.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 14:52:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 04/10] net/ioring: implement management functions
Date: Thu, 13 Mar 2025 14:50:55 -0700
Message-ID: <20250313215151.292944-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313215151.292944-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250313215151.292944-1-stephen@networkplumber.org>
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

