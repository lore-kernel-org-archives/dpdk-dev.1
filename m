Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C818C98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:18:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05DE4432B4;
	Thu, 24 Sep 2026 18:15:04 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id CDBC543276
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:15:00 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-86212a185dcso66111b3a.1
 for <dev@dpdk.org>; Thu, 24 Sep 2026 09:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790266500;
 x=1790871300; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5AhEpF0AAIfedKR8oJ6ZcQBcFjhSKD+NkeVFS+9SwLI=;
 b=Zl7zIAgzfXVhDmMKIXpwjo/Web/VB1DnnUSei6cBx8fh7sAVpQ/W09IpV9FCRBT/yK
 ROEK2pj96JY6WY0dHEgNA9X6Z2hEdXjTPBKr9QO3WbuZjM/z2zaTWPKIfGa6S4EkOq6V
 irayauoBLFkoVnyinCwixSZQMFqzQUed2u7ZtM/lltuPYTd5vys+2nLN2jRGdSoFw+bm
 gPTQoVQwr6+5p0KNusU2RB5dJAU+0xfyIO7+kxA8K1cho8N7F+tSQZUTr0Rtn1o7oNh4
 YG8nWelVEUNTOd6K79d/nXvk+HwuhAASaPk4vo7NDQcUTHObKJVRwa2DCtrLpeV4R0qO
 vzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790266500; x=1790871300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5AhEpF0AAIfedKR8oJ6ZcQBcFjhSKD+NkeVFS+9SwLI=;
 b=xN7iYBo2/xIt4oan+ZjpdSyFndsd9FLZYuhThSa7aoKuAKGzNhntPDNngb51PX/ncj
 GlfoMFnEjBV+ICgXM066tUdvhmysgNJ/ZZcIFA5IwXatLFy4EyS+qnjgWHK6kNUP1O2i
 2Wu+dcqtbJV1dSVPWXw5dd1deFUPntkK4THcYxXJ8aGdbcXi2KCK8aYmyPHNJLR1adCb
 QydLEsMk7+T0q/ZkJITK3TmwexWJIvy4GnCQXl84Hv29UZwO9vlfGpcMH+PiNywtt7wI
 Ra4PQyUHM2Abf5jwL26W7E8K82rqWdd1C/QJriYKjXQpxUgun7yXlRwf7N0RRl44roMZ
 TsDw==
X-Gm-Message-State: AFuF++mO/BzcN2f91VDW5NOOsG5by+PNn/HjXopmOuZq39RIj63ArEud
 VC/UUEHcjY4p5eQqNMH2yEVQxQIqBlpcKa1gGa7Y0pvp8aZODwYPClVYu3bddlNpza5ee9gdUy4
 +Y/m1hh4=
X-Gm-Gg: AYBFou1V+2kvv2/w72EF+SiEyYx1YOmKbhPCXzza1ppAkewafL7GzqrMs8bdgFxyWZc
 GucASRKclhWXZa/Ez7+MXeSM9ViuDF0ituiLYYohFlU88byzQyo2M5Cfou+34Iwh5wuACaCQ4Bq
 vyU0JkekqFwHGZlviRfGjC7ZpmjXoc6rcU+4YmBSlTeQYACyH9SckykArCVbShy/5/5Ns74hbko
 IaGxKSqioQypefYFgAW1VK8v0tjvnwvvf+9qMs7wdwtONlwm8s+Qu8hnRbNnhvxWIiHxAEZfI+j
 JHKm5CxQTgPDBn7xBseoZOGpVfmAzxpoWAor+2J2iVymAaI1QZT35cz9BhTf24BgiD9fTr/dS19
 qLvn6NzUtWujcdFBjXmjrqOFDOYtaiFwlBEE0oqEeXq/w+4kp4bTu+YE37mPuyVjZHSti+ygAtX
 glcx1KMMiHTq32svyhj/Sy//U17x4nwfgpxEOG7oyS4zPX3pykcYTLoM+np3IrErd1MTBxZWxCx
 nmgvtd103gWvZeLxbbi/HSay634cBNH8l7/Ig==
X-Received: by 2002:a05:6a00:4c07:b0:878:3783:8a88 with SMTP id
 d2e1a72fcca58-87e9f62c5dbmr2600481b3a.52.1790266499801; 
 Thu, 24 Sep 2026 09:14:59 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1d5c163bsm3367534b3a.28.2026.09.24.09.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 09:14:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH 2/2] net/cnxk: remove redundant IP reassembly conf get stubs
Date: Thu, 24 Sep 2026 09:09:24 -0700
Message-ID: <20260924161104.335111-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924161104.335111-1-stephen@networkplumber.org>
References: <20260924161104.335111-1-stephen@networkplumber.org>
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

cn10k_nix_reassembly_conf_get() and cn20k_nix_reassembly_conf_get() only
return -ENOTSUP, and they are the only writers of
cnxk_eth_dev_ops.ip_reassembly_conf_get in the tree. The field has no
initialiser in cnxk_eth_dev_ops, so dropping the assignments leaves it
NULL and rte_eth_ip_reassembly_conf_get() returns -ENOTSUP as before.

The sibling ip_reassembly_conf_set and ip_reassembly_capability_get ops
are real implementations and are left alone.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cnxk/cn10k_ethdev.c | 10 ----------
 drivers/net/cnxk/cn20k_ethdev.c | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/drivers/net/cnxk/cn10k_ethdev.c b/drivers/net/cnxk/cn10k_ethdev.c
index bcf4e23286..3f987a8195 100644
--- a/drivers/net/cnxk/cn10k_ethdev.c
+++ b/drivers/net/cnxk/cn10k_ethdev.c
@@ -645,15 +645,6 @@ cn10k_nix_reassembly_capability_get(struct rte_eth_dev *eth_dev,
 	return rc;
 }
 
-static int
-cn10k_nix_reassembly_conf_get(struct rte_eth_dev *eth_dev,
-		struct rte_eth_ip_reassembly_params *conf)
-{
-	RTE_SET_USED(eth_dev);
-	RTE_SET_USED(conf);
-	return -ENOTSUP;
-}
-
 static int
 cn10k_nix_reassembly_conf_set(struct rte_eth_dev *eth_dev,
 			      const struct rte_eth_ip_reassembly_params *conf)
@@ -883,7 +874,6 @@ nix_eth_dev_ops_override(void)
 		cn10k_nix_timesync_read_tx_timestamp;
 	cnxk_eth_dev_ops.ip_reassembly_capability_get =
 			cn10k_nix_reassembly_capability_get;
-	cnxk_eth_dev_ops.ip_reassembly_conf_get = cn10k_nix_reassembly_conf_get;
 	cnxk_eth_dev_ops.ip_reassembly_conf_set = cn10k_nix_reassembly_conf_set;
 	cnxk_eth_dev_ops.eth_rx_descriptor_dump = cn10k_rx_descriptor_dump;
 }
diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 9fac027650..c1a7916e6f 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -629,15 +629,6 @@ cn20k_nix_reassembly_capability_get(struct rte_eth_dev *eth_dev,
 	return 0;
 }
 
-static int
-cn20k_nix_reassembly_conf_get(struct rte_eth_dev *eth_dev,
-			      struct rte_eth_ip_reassembly_params *conf)
-{
-	RTE_SET_USED(eth_dev);
-	RTE_SET_USED(conf);
-	return -ENOTSUP;
-}
-
 static int
 cn20k_nix_reassembly_conf_set(struct rte_eth_dev *eth_dev,
 			      const struct rte_eth_ip_reassembly_params *conf)
@@ -928,7 +919,6 @@ nix_eth_dev_ops_override(void)
 	cnxk_eth_dev_ops.timesync_disable = cn20k_nix_timesync_disable;
 	cnxk_eth_dev_ops.timesync_read_tx_timestamp = cn20k_nix_timesync_read_tx_timestamp;
 	cnxk_eth_dev_ops.ip_reassembly_capability_get = cn20k_nix_reassembly_capability_get;
-	cnxk_eth_dev_ops.ip_reassembly_conf_get = cn20k_nix_reassembly_conf_get;
 	cnxk_eth_dev_ops.ip_reassembly_conf_set = cn20k_nix_reassembly_conf_set;
 	cnxk_eth_dev_ops.eth_rx_descriptor_dump = cn20k_rx_descriptor_dump;
 }
-- 
2.53.0

