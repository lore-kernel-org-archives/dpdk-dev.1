Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3859FC021AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61DC6402E1;
	Thu, 20 Feb 2025 03:35:27 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1EB0C402D3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:24 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-220d132f16dso6171315ad.0
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018923;
 x=1740623723; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eLLWAV7Y11vT1ruiyiL0yrL68ZlPVZ0P8SC1SS9qq4=;
 b=In4J6vgX9RO5UiA5rj4V1+U0rqjqx9C6tRUn2aEoqtS9ZbddfMGMoJLs4guMiZW8GI
 NcIBKzrijM3eH50eVyQTxqevOpjWrhGq3U7hv02WwAxu4H7Gb/fEzycEQ4uXzfGWEDHw
 9Dguz5fmwBAWIbh/1P4NdoUTsC79orhCyR+zzgTYWrC5uadekk2cjiFeLmteXOWcR57K
 kIJ5uoEVYuAFpXAi40FYRoJ5Q9zcCCLavv+P7IZRxrCDeB+YGxiTmeg9Py6JUDzie/n5
 ntm4QeCTOVzyug37cTKiOh+o0FGRzBmY3CduhxZdNDJ16Mrk4S7g/0bi72xoo3nlIuzl
 IIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018923; x=1740623723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eLLWAV7Y11vT1ruiyiL0yrL68ZlPVZ0P8SC1SS9qq4=;
 b=qbRCDJDEvJD2cTQglFNJtulaMa9L1gBTJ3lQ/kM8pb7GMOe3vCno1axN179ApXWIrK
 83QspvYYsFs6c3peItcRB7l6b/QNark0Ivgtsfg8SmczT5VNaxMOqpVSZhhWXGY5uJQk
 9oCXRLYAEjQJ2Jg68Lf8wbuIaPxY/Lfkb0TotRoLaD0nHcHjVf95qISeH/DkWhSIbRC9
 TkFNXxvZsw9eFkMu3jhA2iTi9gxHvdE6nAwoMqATjMMG17EkpJuHaspnT8KbtUQjR/Zp
 Bl6WXIzasgpemP5Axqto1eKfe6AdhVsVH3t2NrWKRNB8WxW4VGZakPjQquLBAP91lTP0
 ed1g==
X-Gm-Message-State: AOJu0Yytg/u6ClnKqJKH03xYVkHWwXeRj8ZIxUMGA/jvIZLjxp22+qdJ
 X5HmcPAXflN2MMx1ISEfpkZz8rZlILQhX9Ueou/YNj+0q2HnLCN5LJiGI9YBbNDmfyJ2q021AS+
 0f8k=
X-Gm-Gg: ASbGnct97VD3g4RRqkGjd8yDQY6qsxcclLcksYGcprCf/uPCmfyg3NKWVJ5Zo3XvF9O
 ///QysraGhOP0gj4kR95A9ZDNUpNuScGYT3Eu7oBhmfgRDFNhiMFB5as+ZKaFQZuYCoNS/pcIJW
 Ql20JGUcbtExqp8MuviOZGbFMWJRy/kXPruUhd/BD+Jw0/XVbFvF7U7IhoAaW3v99F4H0nnyITs
 Dg4UDQjOiWQQSlgZz0Ioy4fOzFEYfP3fcbiJPjQYfY5Fd0l+PZs6BXcxb3UwgXkoxTNKykzsnDO
 Bm3JMnlQq+MZeD7FV50CqAN1LrYhuyFHV5uKChW8WgsVvDc7G2KocAg25Js4K9dWR7hk
X-Google-Smtp-Source: AGHT+IEt+t39VYLZAa4+/wnCND5xRU/ZSLv+O76WzxsZu3Ia3TplzDBavbHYq2DFeL2yh+PGhTvI1A==
X-Received: by 2002:a17:902:ce05:b0:220:e991:480a with SMTP id
 d9443c01a7336-221707755b4mr106702095ad.15.1740018923260; 
 Wed, 19 Feb 2025 18:35:23 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <chas3@att.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v2 03/14] net/bonding: remove unnecessary deref of function
 pointers
Date: Wed, 19 Feb 2025 18:32:07 -0800
Message-ID: <20250220023509.630569-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220023509.630569-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
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

The expression *dev->dev_ops->dev_info_get and
dev->dev_ops->dev_info_get are equivalent in C.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 467f7fe7ea..b742f538fb 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -2493,8 +2493,8 @@ bond_ethdev_member_link_status_change_monitor(void *cb_arg)
 			polling_member_found = 1;
 
 			/* Update member link status */
-			(*member_ethdev->dev_ops->link_update)(member_ethdev,
-					internals->members[i].link_status_wait_to_complete);
+			member_ethdev->dev_ops->link_update(member_ethdev,
+					      internals->members[i].link_status_wait_to_complete);
 
 			/* if link status has changed since last checked then call lsc
 			 * event callback */
@@ -3275,7 +3275,7 @@ bond_ethdev_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 
 	for (i = 0; i < internals->member_count; i++) {
 		member_eth_dev = &rte_eth_devices[internals->members[i].port_id];
-		if (*member_eth_dev->dev_ops->mtu_set == NULL) {
+		if (member_eth_dev->dev_ops->mtu_set == NULL) {
 			rte_spinlock_unlock(&internals->lock);
 			return -ENOTSUP;
 		}
@@ -3325,8 +3325,8 @@ bond_ethdev_mac_addr_add(struct rte_eth_dev *dev,
 
 	for (i = 0; i < internals->member_count; i++) {
 		member_eth_dev = &rte_eth_devices[internals->members[i].port_id];
-		if (*member_eth_dev->dev_ops->mac_addr_add == NULL ||
-			 *member_eth_dev->dev_ops->mac_addr_remove == NULL) {
+		if (member_eth_dev->dev_ops->mac_addr_add == NULL ||
+		    member_eth_dev->dev_ops->mac_addr_remove == NULL) {
 			ret = -ENOTSUP;
 			goto end;
 		}
@@ -3361,7 +3361,7 @@ bond_ethdev_mac_addr_remove(struct rte_eth_dev *dev, uint32_t index)
 
 	for (i = 0; i < internals->member_count; i++) {
 		member_eth_dev = &rte_eth_devices[internals->members[i].port_id];
-		if (*member_eth_dev->dev_ops->mac_addr_remove == NULL)
+		if (member_eth_dev->dev_ops->mac_addr_remove == NULL)
 			goto end;
 	}
 
-- 
2.47.2

