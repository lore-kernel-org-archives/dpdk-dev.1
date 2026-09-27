Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8C0C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Sep 2026 05:00:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CB4640274;
	Sun, 27 Sep 2026 06:59:59 +0200 (CEST)
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by mails.dpdk.org (Postfix) with ESMTP id 3B59F40274
 for <dev@dpdk.org>; Sun, 27 Sep 2026 06:59:58 +0200 (CEST)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0dc47fee0so414371a91.1
 for <dev@dpdk.org>; Sat, 26 Sep 2026 21:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790485197; x=1791089997; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+13kzs3/lOOghciX+rN6ME3Rq31oM1zLE++m7H5LP50=;
 b=eCQBFx2EkVjVz1xmFEx6gAsTBnS/pzqur0VDdT0WE+jL2WO4yRCvhMeDItTAEFI0PC
 Xy49Cyna1xOOyHNFDxstRfcTwVpxgZNSmHO7nKevJtwg6KQ9YgOYoqCNqHTcbXPeSh7I
 LOMthkWtYrpbzcAvSFVeetaco6h9eA1fSXXugxg/3H1IiYSSgDoeSdqCIuVQVAfVV68B
 JVpuULr3d848C8KhO9Lwm/yVyNJEenW1BN+aU7qDwp/z1LxxI+S361EC70UU6MWhFBRw
 rjiZt0uJjHSPvLaGtT+4AMjuwyIS1dtp042mplSYoaKYl35Fq6QaWmkHuuAULgwlXUtT
 6pfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790485197; x=1791089997;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+13kzs3/lOOghciX+rN6ME3Rq31oM1zLE++m7H5LP50=;
 b=YQN9/RvHx1UQebmvmtLrUIRZ3CH7IwI3D4iaDNAxpiZrsScFgPmpXMpq6XBLHHRDl8
 9/HiJ1hEHK0T7+mItIP3cIdQeXa9A6cV9bO+P2ldK3idVmtvYSaSCoqa38mrINeQrxpU
 jvIrAlvvMKNUArcJBuMZj9NqYNr9EQJjuml0xLyJtzwYMd26acbE6TFMGB+6uRSqjUH4
 c/BLOrr0ULFYGAoMWgeT0pxiPkwTcfaAwPFYtp8xxNfWTb9mozXmaKKjaN+dti+AdRtN
 4fR5uKcs+IoE4mZToVJIy/RGSXmByARumXfkKzEWuu7a7FCVpBiRyjTN0nvh4r0yIw4D
 TmVQ==
X-Gm-Message-State: AFq9FYLvX3lrqCsM4B+f5zp4Ym6oSpG0uW/ySNk+fBMJtstTDwLZOxow
 CcSu3UYBbgFwJC3bYoyJhEg27whhN1vdP6Hm859WiJg5cPXmVYZ4qoGB
X-Gm-Gg: AYBFou233Bjbug8SGNHdN5Y35oKJ1yRAYEvr9k8ikWz5gGGKXBaWTWe1giAymhX19ng
 DsAQy15ckKkRd6uAbQDzNDx2OitEgwM7J7sEKi4gPrdZqvXqTyomR6k87AeXlIDXwouAVlG6MDn
 UdN2M/L2wdwJ3kD5IvAbaLhdQhOb8gx2EIVmOlRdLt950btWG5SPmMJ2n7Cq/CxKE2axpnalICB
 VkZaFeXJY3UjYw0F9MUsNICiR1352Kz9WY1XJxYh/sKcQFHFjaogznKSrTyZkvI2mOJDJSrOnPA
 c2X0DcdvbnY1k+Y57HZSR/CimyOICe36Pyp1M77QhulCUQ8yf5y+8krjF4j4yN8kBtYNBqiqYu8
 u8NXhHkvwVBXqdNliZ2Iek1bOfe/DVaBg3EsgrjZQkx+duIJxI7CbUNCD9w+tFBQWCY1+QZsTr2
 Xb0DXTTYfo0VpX4n8rZrkh2vUY/gUe9EFek/91/kNxQHyeWva5/da2f+E30maWhMAEXRiw+JE6O
 ZDfAdQ=
X-Received: by 2002:a17:90b:55cb:b0:3a2:a185:aad6 with SMTP id
 98e67ed59e1d1-3a2a185b31bmr1028837a91.23.1790485197122; 
 Sat, 26 Sep 2026 21:59:57 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm6096817a91.13.2026.09.26.21.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 21:59:56 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: anatoly.burakov@intel.com,
	vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	Zhang Tengfei <zhtfdev@gmail.com>,
	stable@dpdk.org
Subject: [PATCH] net/ixgbe: fix DCB Rx buffer size on X540 and E610
Date: Sun, 27 Sep 2026 12:59:43 +0800
Message-ID: <20260927045943.58541-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
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

DCB programs RXPBSIZE from a hardcoded total, 384 KB for X550
and 512 KB for every other MAC. The base driver records 384 KB
in hw->mac.rx_pb_size for X540, and E610 inherits that through
the X540 init ops. X540 and E610 reset also write 384 KB.

Use hw->mac.rx_pb_size for the split, including the PFC
watermarks derived from it. 82598, 82599 and X550 are unchanged.

Fixes: b7fcd13c90a3 ("ixgbe: fix X550 DCB")
Fixes: 316637762a5f ("net/ixgbe/base: enable E610 device")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 60222693fe..890289f27f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -3835,8 +3835,6 @@ ixgbe_rss_configure(struct rte_eth_dev *dev)
 }
 
 #define NUM_VFTA_REGISTERS 128
-#define NIC_RX_BUFFER_SIZE 0x200
-#define X550_RX_BUFFER_SIZE 0x180
 
 static void
 ixgbe_vmdq_dcb_configure(struct rte_eth_dev *dev)
@@ -3863,18 +3861,10 @@ ixgbe_vmdq_dcb_configure(struct rte_eth_dev *dev)
 
 	/*
 	 * RXPBSIZE
-	 * split rx buffer up into sections, each for 1 traffic class
+	 * Split the MAC Rx packet buffer equally across traffic classes.
+	 * hw->mac.rx_pb_size is the total size in KB.
 	 */
-	switch (hw->mac.type) {
-	case ixgbe_mac_X550:
-	case ixgbe_mac_X550EM_x:
-	case ixgbe_mac_X550EM_a:
-		pbsize = (uint16_t)(X550_RX_BUFFER_SIZE / nb_tcs);
-		break;
-	default:
-		pbsize = (uint16_t)(NIC_RX_BUFFER_SIZE / nb_tcs);
-		break;
-	}
+	pbsize = (uint16_t)(hw->mac.rx_pb_size / nb_tcs);
 	for (i = 0; i < nb_tcs; i++) {
 		uint32_t rxpbsize = IXGBE_READ_REG(hw, IXGBE_RXPBSIZE(i));
 
@@ -4394,16 +4384,7 @@ ixgbe_dcb_hw_configure(struct rte_eth_dev *dev,
 		}
 	}
 
-	switch (hw->mac.type) {
-	case ixgbe_mac_X550:
-	case ixgbe_mac_X550EM_x:
-	case ixgbe_mac_X550EM_a:
-		rx_buffer_size = X550_RX_BUFFER_SIZE;
-		break;
-	default:
-		rx_buffer_size = NIC_RX_BUFFER_SIZE;
-		break;
-	}
+	rx_buffer_size = (uint16_t)hw->mac.rx_pb_size;
 
 	if (config_dcb_rx) {
 		/* Set RX buffer size */
-- 
2.53.0

