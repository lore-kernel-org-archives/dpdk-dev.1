Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE9EF584D
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 23:48:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2714E4065C;
	Sun, 15 Feb 2026 00:47:45 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id DC33F402F1
 for <dev@dpdk.org>; Sun, 15 Feb 2026 00:47:40 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so15845585e9.2
 for <dev@dpdk.org>; Sat, 14 Feb 2026 15:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771112860;
 x=1771717660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJhB8vI+IAzIb3BWWUFTq83tZT/LHU4O7MEIqrby2+w=;
 b=ultL+t+xZsc8LhNVOvBsI3VyPgRFVxBFnq3HTUqJZC7SWaqq+3rISPK2FB2Ore+Kjc
 kZllsDMWyNKzZkaXyPYVc0DuXn19DnCF22hyJkx6ZQqsCprULFmHWSjAyAkNwmbzoMSc
 RF/yR3yO0sxbc/7pIm2WrsDeQb9z9lLZ9xlimSE/fJr7dFxQCZlDSBwNElK1cuYsXrOJ
 x/c7oZONEzDO1yZGcOOA0I9zWD4XZgUxcarPxlHjYozEGXLq2uKvDpoApAzqlokpcqXS
 UiN1rxin26cjXKFvOzppxOWNUmlinMXdrQIHSP/ClKW/imOidACZ/nYk/tQ1AJ4+w92Q
 /WPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771112860; x=1771717660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SJhB8vI+IAzIb3BWWUFTq83tZT/LHU4O7MEIqrby2+w=;
 b=ZXcW6XSMTKteqEAaTxjpBye0MEQ9BgQjIG/csryB7gb0DaWGskdMqFUKMLM3ikwG6P
 0fX/HWK/Jhxu2/bVT2dgR9kEIYrw7weal5WRF4xSGCWfnFrhu9ldPpIXQNoS0TjA+SUH
 pTeP59YyszC6pvJRTouiHIdg5CMUP+pbEPDJzyJgI+Mc8ezLmeByolwn2y5FruC1AcEM
 othZmIvqrYhabfc/9HCECysqlQ4czeFgOMr/aZwQO9okm+vo9/5BuzgUhmnNN56aqP/X
 7peA5vSMZUqD/CceQ67L0Gtnvy4S2Lt12MFG5iiei4UuBAKi+4RmpUYMpq8fVClelROR
 zhFg==
X-Gm-Message-State: AOJu0YxMn5DLwspK+8Rg0NLEbqKFlEAJKEsy12Fj1fUr3+OcT/55q7vU
 Kj/2WTuudlbCpYANrUpGzGXHMWreUtkoJYINkPiGRxHx/X1WLUpdc2i7oIigOsqfyaqfxbvSBGq
 A3YVO
X-Gm-Gg: AZuq6aLTediJjmbEa/FZ0LowjXPaOYJKIgtAYvlYkLYhg3RTFpyvg9sDZdiplyj1YN+
 9zrvPDCI0Jx6IonEuNkjyW4b+eoQWAwC3XroiQ7uJiQPpOdTctUMkfpR0L8Tdafb290rz/LNwrA
 Qoz/yMx2FtcoGkRmgjBhagSzr12qlvNcwP31viMI6fn+t4h0iF9NPBxDkh2pNfQVAvE8FF22eO1
 VE0nCI2PdPWlp00vOjiyAiHiMxzS6TGTjENADCQVye7DBqRdUbWueo6KW7A6oAP4uhK7kC6yPWA
 TR+lFvW4pdVKXONF0mZ6bx2qyTYNn3bqrfFVtbkDJash9s7sYZDfDkwjFfgSPhY73sSUsEGJ3Gu
 rso6v57iC60ZMibGKzts35JAheCx80nLgHsv6QD2z3aMU7KVX/HIC+2PpyzzbhF1WRjLRbti57j
 wigkzWnzwK0eeqUtrGxtpZp6J4Pu9Hktgxufm6SBRlKWcBeRaZaWJGCn07fx9Ssp2H
X-Received: by 2002:a05:600c:8189:b0:483:6de6:37b8 with SMTP id
 5b1f17b1804b1-48373a61afdmr103305365e9.34.1771112860458; 
 Sat, 14 Feb 2026 15:47:40 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm394921485e9.6.2026.02.14.15.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 15:47:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 05/11] net/rtap: add link and device management operations
Date: Sat, 14 Feb 2026 15:44:14 -0800
Message-ID: <20260214234726.188947-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214234726.188947-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260214234726.188947-1-stephen@networkplumber.org>
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

Add device management operations via netlink:
  - Link up/down control
  - Link status query (checks IFF_UP and IFF_RUNNING)
  - Promiscuous mode enable/disable
  - All-multicast mode enable/disable
  - MTU configuration
  - MAC address configuration

All operations use the persistent netlink socket (pmd->nlsk_fd)
and ifindex for stable interface identification across renames
and namespace moves.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |   4 ++
 drivers/net/rtap/rtap.h           |   1 +
 drivers/net/rtap/rtap_ethdev.c    | 102 ++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index 9bef9e341d..ce0804d795 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -4,6 +4,10 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+MTU update           = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
 Scattered Rx         = P
 Basic stats          = Y
 Stats per queue      = Y
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index abfde20e60..aeda7f3f25 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -69,6 +69,7 @@ struct rtap_pmd {
 /* rtap_ethdev.c */
 int rtap_queue_open(struct rte_eth_dev *dev, uint16_t queue_id);
 void rtap_queue_close(struct rte_eth_dev *dev, uint16_t queue_id);
+int rtap_link_update(struct rte_eth_dev *dev, int wait_to_complete);
 
 /* rtap_netlink.c */
 int rtap_nl_open(unsigned int groups);
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index 888f8e7f39..b6c6421e3d 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -108,9 +108,100 @@ rtap_tap_open(const char *name, struct ifreq *ifr, uint8_t persist)
 	return -1;
 }
 
+static int
+rtap_set_link_up(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	return rtap_nl_change_flags(pmd->nlsk_fd, pmd->if_index, IFF_UP, IFF_UP);
+}
+
+static int
+rtap_set_link_down(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	return rtap_nl_change_flags(pmd->nlsk_fd, pmd->if_index, 0, IFF_UP);
+}
+
+static int
+rtap_promiscuous_enable(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	return rtap_nl_change_flags(pmd->nlsk_fd, pmd->if_index, IFF_PROMISC, IFF_PROMISC);
+}
+
+static int
+rtap_promiscuous_disable(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	return rtap_nl_change_flags(pmd->nlsk_fd, pmd->if_index, 0, IFF_PROMISC);
+}
+
+static int
+rtap_allmulticast_enable(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	return rtap_nl_change_flags(pmd->nlsk_fd, pmd->if_index, IFF_ALLMULTI, IFF_ALLMULTI);
+}
+
+static int
+rtap_allmulticast_disable(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	return rtap_nl_change_flags(pmd->nlsk_fd, pmd->if_index, 0, IFF_ALLMULTI);
+}
+
+int
+rtap_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	struct rte_eth_link link = {
+		.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN,
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_autoneg = RTE_ETH_LINK_FIXED,
+		.link_status = RTE_ETH_LINK_DOWN,
+	};
+	unsigned int flags = 0;
+
+	if (rtap_nl_get_flags(pmd->nlsk_fd, pmd->if_index, &flags) < 0)
+		return -1;
+
+	if ((flags & IFF_UP) && (flags & IFF_RUNNING))
+		link.link_status = RTE_ETH_LINK_UP;
+
+	rte_eth_linkstatus_set(dev, &link);
+	return 0;
+}
+
+static int
+rtap_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	return rtap_nl_set_mtu(pmd->nlsk_fd, pmd->if_index, mtu);
+}
+
+static int
+rtap_macaddr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	return rtap_nl_set_mac(pmd->nlsk_fd, pmd->if_index, addr);
+}
+
 static int
 rtap_dev_start(struct rte_eth_dev *dev)
 {
+	int ret = rtap_set_link_up(dev);
+
+	if (ret != 0)
+		return ret;
+
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
@@ -127,6 +218,8 @@ rtap_dev_stop(struct rte_eth_dev *dev)
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
+	rtap_set_link_down(dev);
+
 	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
@@ -365,6 +458,15 @@ static const struct eth_dev_ops rtap_ops = {
 	.dev_configure		= rtap_dev_configure,
 	.dev_infos_get		= rtap_dev_info,
 	.dev_close		= rtap_dev_close,
+	.link_update		= rtap_link_update,
+	.dev_set_link_up	= rtap_set_link_up,
+	.dev_set_link_down	= rtap_set_link_down,
+	.mac_addr_set		= rtap_macaddr_set,
+	.mtu_set		= rtap_mtu_set,
+	.promiscuous_enable	= rtap_promiscuous_enable,
+	.promiscuous_disable	= rtap_promiscuous_disable,
+	.allmulticast_enable	= rtap_allmulticast_enable,
+	.allmulticast_disable	= rtap_allmulticast_disable,
 	.stats_get		= rtap_stats_get,
 	.stats_reset		= rtap_stats_reset,
 	.rx_queue_setup		= rtap_rx_queue_setup,
-- 
2.51.0

