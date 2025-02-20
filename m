Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D1C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:57:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C312440656;
	Thu, 20 Feb 2025 17:57:08 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id B34C040292
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:05 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so30851935ad.3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070625;
 x=1740675425; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9I8PM/z8wRp2I5Kq3HdGCBAX5XaOt0FbtXtzgwEhM70=;
 b=LeC2qxAYlmjLk8Z9V2wS+UL3tgg59SD1lfNNhhG6J2elBTZvCP8nRW/8ZXFON4zgiO
 7THt3DaDBIih1VDPmMmEj1bU/V75cd9BnhEfE2u7DynW4kzmNKwu0xt0+ThrOursyB5L
 DJT0rCTNMVqjybvWr7czINw2L7tITDN34LWpjp0NGz074GnwK4q+KFXfV0+KnFw3MkR7
 h1xkA4XhHeimMWy/GdBgG0fOV0iL5lxQkbIKObW1nzL02GPynujkKAIcfJAE3n5zv1sN
 s5oq6w/CuxrVg3i9D41SdgjzDg0twrvFQsoQQ6F3vT4iFOOkOdpLHVTAG0biabYlWaBZ
 J5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070625; x=1740675425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9I8PM/z8wRp2I5Kq3HdGCBAX5XaOt0FbtXtzgwEhM70=;
 b=SW7x0HqUnsRLiENSfnYiDVT9PWAQEeAUvCOatvORvaogUk/u/W98/B1CKpmfBdtRwp
 5ql18GXUpc/M6lHAUnyXUPjdy//eYJwbz/1ovdee1KxBiMiSRUCRQltc7maG5UFxotn5
 wRq9iVfwr5OA4fsLxhJf/BSy5Ow+geBguwM93CBOxcDbjBqe+DHhLRcZWzHQ8vnkclvf
 X3620gpuUOdlZk4cdeqHH07GItsAvkYgXk4S7A/0FF0BKg35gHQN0r0Zi5KFNK+4jwxT
 FuMHNx2hRZxUnrOaqP6aBhnP1SmMqvl2T9grLj3WxMr3RzjJ08ByTovgUpCw9bc+RswG
 mG1g==
X-Gm-Message-State: AOJu0YyhGI+zrgnB29lozPAUUrEL/JR3bbgwy2x/X/6/NNsTgVNPx8bn
 wlaMrMWh61HG4o37EEkXocwpRS7gWCVt2gPUg+54qhNr2/DHiQXB8JfPc5sKhmsjaBV2p4/twa+
 Z
X-Gm-Gg: ASbGnctYdGVXmZ5A7nU2Qk97tQ6fK/G23+AiqyYxffttHuJJrWJMPcRiwYpBKwCXM/Y
 FjgcuJDFHB5M4zwSkpaxqmWnUkPNOWFf1UwvNactPFDCD+kJzyd2gZCruqqIcUxnimtL3RdQh0l
 kFCIGpsey0Q/yEdbqmKcGQbN9F+qlgJdqrUOFrUTMEVik2RNVHnc+odXRMJv2uxgc72z1+9sqkR
 +8/CbW8FsuzuP4KIUphEToc2AMIQDgsNo5X7Nlwq+ZuM3pmFSe/yrVPfC5111ImWq79x82BKdRx
 m9tnXRg78x/heLgLGQnaEvYzhR73BJXOu9wlAz3XzQOYQnhsiR4j3A2SAf4yWmjt6QuA
X-Google-Smtp-Source: AGHT+IG4zCgb4urxRpeyMYNFBdLoVciYkx+Ol9bXFvSXXL8Fv5tWDkOuBWtt3wwNrA9vQ65+FrKvlQ==
X-Received: by 2002:a17:902:e5d2:b0:220:ef79:ac95 with SMTP id
 d9443c01a7336-221040ab9c2mr322817125ad.37.1740070624884; 
 Thu, 20 Feb 2025 08:57:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Chas Williams <chas3@att.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v3 03/14] net/bonding: remove unnecessary deref of function
 pointers
Date: Thu, 20 Feb 2025 08:55:17 -0800
Message-ID: <20250220165644.16421-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220165644.16421-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

