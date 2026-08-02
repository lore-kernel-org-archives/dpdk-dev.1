Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02985C55162
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:19:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE115406A2;
	Sun,  2 Aug 2026 20:18:55 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 4825540653
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:47 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38101f85591so2692332a91.1
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694726;
 x=1786299526; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n9hw+M6eRVed4boVcugzYoR9TdG+QylMmS7ERWW1X1k=;
 b=ordkTvXh2vEs5mD15NgN3VT6Oe6e1OxxFUEkoa8kn3bB6zrUeP5kMCE5+jxGEiHVSF
 SjVS4mGgd9OkIjHtVCqJYPKvvQcnpG6MKVi4vrGLI1vrkRopuDiNM8shSteqSUeW2Grl
 JXRXS1r8DlHpiB9dz1sYqz/M+sQUSZ9aAkkN2C+sQXaHsYbxzxds3eBmZhPkESsrdyNz
 589vqP8XDuIh0DBO1n7OXI9hLPxk4GwCSKITKI2M6nkdwey4Z9FibQU7TgIcWzsA+g5X
 CDPHXIYFiVu7JDv4jb68MuqfFD2wd7QksIf2N2hge89EG7IF0HL25zumPQva/wTf0sSU
 oqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694726; x=1786299526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n9hw+M6eRVed4boVcugzYoR9TdG+QylMmS7ERWW1X1k=;
 b=YQWrcjlm+1yxP6dnSlb3X6f/Kf3m/ZWgPMJrupyCd6pEJY3aMYbC5V6eeIJGLTBHZy
 p2yz/84BnValRThp3CMsOH+fDXkF8ypQ5mvIGomnOsnSPByX3OI7+ofeUgd3mrlsucx9
 5Oc4XWW9JA/DEhXUc2fwX5WryqFHkFNvEqACiYWX6je7VB3Pm6kw7MIeDOq4fQJ6PxW6
 FnVJVj1ry9Go0RXyXotWRYLAboiUEMHbanCcMXupI9PkGyDvQenOZEgiorfbxMw5u2Ck
 bWU4ZVTx7MdMImgNAcv+4003RhciVGnoRufZcpQb29E/DxqjgTg7enbuJ96aA7uMPCa0
 t4iA==
X-Gm-Message-State: AOJu0Yy40Uv3A4Qi4nr2Obe12Tn32oZ3J/5Pqm8QYUPTPc8ZONq1iq7o
 ptDpeultsrdWQp6nWFjayDkLCyEEU3KXeJJj00ipKCQcp2R30m32nXa/iIrA6CanJgaunsi3DiX
 jQ4LN
X-Gm-Gg: AR+sD12vtyPdGXmv/uUnKvyRsjenmxBVipjBxDhm5Rl0AMe3SSVivm3fwxuxrC1upvt
 YbWw9HbmYo0j++Hg9uV5TljLsQKnrzExw8LXI84sKczoD7AdUcoMbfXmy59HabGXNNAzkfk1/Lw
 qEL6IyAft9HRI8PHanOJ0fQt5kF+dkfDpNvSbN+ufYHEeNeCpgqYXd6XjjwTYA7UVkZIQ4YELWO
 KOfp04vSKqGKRoQphNYUH8/Xkfxj+jOOqCN0+cSnJvKd8nRonCUUO+7WnpWbU8aAQ2CfvSdyEt9
 BBdyixCmA1Yp/TcXAsLUE0VWim4ixrAylelB6IpAHu+PcWZWcJXXk/yKzYo6fnwJD7O/QMDPCdy
 /Gb090xfkh8049stUD+kBBPRgH+vJiVlz/uaKiV/jIhox4LiHSTQRB5TGH3Jhc0ALsr0a0Xuk8c
 5alIoalLGTk2nY123tVchQ0Z/wcZVcUjoX78cXGs786NItXV2YoHblKJF1nwOKXhSXDRVNpWFZo
 j4aZVtlJ543taErP1/3FkKFwmZlJTgY4z/PrFZebRdk4pJAOA==
X-Received: by 2002:a17:90a:fb81:b0:38f:cfe2:fd3a with SMTP id
 98e67ed59e1d1-38fcfe2fddbmr2216697a91.15.1785694726445; 
 Sun, 02 Aug 2026 11:18:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chaoyong He <chaoyong.he@corigine.com>
Subject: [RFC 08/21] net/nfp: break implicit dependency on rte_eth_ctrl.h
Date: Sun,  2 Aug 2026 11:15:13 -0700
Message-ID: <20260802181835.476887-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

This driver was using UINT64_BIT which was getting defined
via deprecated rte_eth_ctrl.h. Replace with local definition.

Also include rte_flow.h instead of depending on indirect
inclusion from rte_ethdev.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/nfp/nfp_ethdev.c     | 6 ++++--
 drivers/net/nfp/nfp_net_common.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/nfp/nfp_ethdev.c b/drivers/net/nfp/nfp_ethdev.c
index d2da18013c..25be1de080 100644
--- a/drivers/net/nfp/nfp_ethdev.c
+++ b/drivers/net/nfp/nfp_ethdev.c
@@ -6,6 +6,7 @@
  */
 
 #include <unistd.h>
+#include <limits.h>
 
 #include <eal_firmware.h>
 #include <rte_alarm.h>
@@ -32,6 +33,7 @@
 
 /* 64-bit per app capabilities */
 #define NFP_NET_APP_CAP_SP_INDIFF       RTE_BIT64(0) /* Indifferent to port speed */
+#define NFP_UINT64_BIT (CHAR_BIT * sizeof(uint64_t))
 
 #define NFP_PF_DRIVER_NAME net_nfp_pf
 #define NFP_PF_FORCE_RELOAD_FW   "force_reload_fw"
@@ -2060,8 +2062,8 @@ nfp_net_speed_capa_get_real(struct nfp_eth_media_buf *media_buf,
 
 	for (i = 0; i < RTE_DIM(media_buf->supported_modes); i++) {
 		supported_modes = media_buf->supported_modes[i];
-		offset = i * UINT64_BIT;
-		for (j = 0; j < UINT64_BIT; j++) {
+		offset = i * NFP_UINT64_BIT;
+		for (j = 0; j < NFP_UINT64_BIT; j++) {
 			if (supported_modes == 0)
 				break;
 
diff --git a/drivers/net/nfp/nfp_net_common.h b/drivers/net/nfp/nfp_net_common.h
index 2bd2d54028..a479a7fbd4 100644
--- a/drivers/net/nfp/nfp_net_common.h
+++ b/drivers/net/nfp/nfp_net_common.h
@@ -8,6 +8,7 @@
 
 #include <bus_pci_driver.h>
 #include <ethdev_driver.h>
+#include <rte_flow.h>
 #include <nfp_common.h>
 #include <nfp_dev.h>
 #include <rte_spinlock.h>
-- 
2.53.0

