Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D4DCC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:01:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2244740608;
	Tue, 13 Oct 2026 16:01:21 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 129D4402F2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 16:01:20 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3ac451e128cso427549a91.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791900079; x=1792504879; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=20b1XjJ0sjvZZy3AHHAz0YTDM+rPlMQVLcyLB/ACZmU=;
 b=hT0k7YNu3arzqSXmMb3aTUDYgxOi7rdxbSgRwkgnb9E3Hv76FYqvnIH0YxUeFUoOBE
 waswu1jqkfEFFSJ3IVvo73adQAkuAcSioEI2ojBCK/cNoNEAMfsinz/q5ZO5MdckJkLP
 yVeIbGdanOd0gNh3OyLwYEhSDBGtrnJ0ivocAS8kIgJknV0tzS4wI5h9lUk4lxs6LyPy
 4KItuBtAxs0YV2Rn0VRwzVL5KG1pciuOemksfUlwhqj5rpFI13rD5XHlNya57brrd3xU
 6v6i9QZwq3J33zRXcEwUHSIDJOA7vgtKyUJcU91KEDQhOPliNu714uLnY7XwahrWmuOo
 n28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791900079; x=1792504879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=20b1XjJ0sjvZZy3AHHAz0YTDM+rPlMQVLcyLB/ACZmU=;
 b=oW3ZzKd1ImNRo5N/22VXq7H5QjtWhdjaJQ9y88GE69VgCrxo0dcxbvV9S18e14+ROQ
 HaQ3BPFIvnnnXjCNEdSiClgkwy9hvop6Ae+jNVxujIgcgbEZ8biGueCigUNtxrBubGad
 ITvvTtMeC6k0yBZYC5icaPyb5t0u0LVuUQE91V7ZlALI8wCUO9KI66/5ZRMN0CZfnaP5
 hw1m7qLRvXM8KrFPoep3voOveLJv/kyyFJd4BovTaGp5DKj9BwPeigkMp2+Kx1KyNTXO
 qT76OgNizBmIGHon9xagJSZqvZ7x2/YvKyoUxnOgIcD7TAJRId4D+GwKOPjVr9aVevuR
 huNA==
X-Gm-Message-State: AFq9FYLqm+MQNU0hXhCnG40ArVtrpsiM2BHj8BEvueUqM/TabPx9w2UP
 gIehl/wASHJdD2Q740tZSIWPHJmXOvZT7Hkl05XK95ih213+sxkRLVmAY5lS+iWy
X-Gm-Gg: AYBFou0DAQ6CmnjxZtRxgFU3KmsHPp4aXzek/BStkMk8Lv9LhysLomVpqnIPUceNzJv
 qgbg7xTL0VOVA+e13IFE9HMaEQi8RFToU9MiL3MBONToN4yXG6eya4DaVT1ZpIj7A5/5RcVr7H8
 yiUQZ0KO0UkrNsdc5P3QjtoJ8gjN9c/j+W6fXjRcmW63E4VfkEo3sHKw8zTUY5L+MbPHt42fd2W
 DmuEFk4oD5xg1xF/WoMihpp8I2TfwgOZwpuisw/SJklCw5DxB23aMBp9xwbfo425f94aXCld0+V
 vNo3gcbbANfgRwSHbqcxyHXGlBtExb8etET7bqguQCMDrOeDriho4rJ1TLPTC3N0M1ErPVfxiH4
 7dww/WdKzvbGYemsRhrPj7i3j0eZAAZpOnHbAeEGAqUzz8ESuayFM7APEsTgJTjHniVDEz+JAxQ
 zYPZ0JB6xuQbBBLIgtvYzs0PvDeRTz67Git7S0fNDN3orqrRGPXe3/JG3dD31uImIAzA5w57/7C
 BKyXdU=
X-Received: by 2002:a17:90b:1a82:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-3ab3a35a068mr10533114a91.9.1791900078851; 
 Tue, 13 Oct 2026 07:01:18 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371c32cesm20733947a91.16.2026.10.13.07.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:01:17 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Zhang Tengfei <zhtfdev@gmail.com>,
 jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com, stable@dpdk.org
Subject: [PATCH 1/3] net/txgbe: fix Rx packet buffer size with flow director
Date: Tue, 13 Oct 2026 22:00:17 +0800
Message-ID: <5ae97e7c44c3c9272417ecfd838154188cd616d4.1791898970.git.zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791898970.git.zhtfdev@gmail.com>
References: <cover.1791898970.git.zhtfdev@gmail.com>
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

Enabling Flow Director reduces PBRXSIZE(0) to reserve packet buffer
memory for the filter table. The new size was computed from the
current register value, but the FDIR mode is reset to none when the
last rule is destroyed, on flush, or when enabling FDIR fails, without
restoring the buffer. The next FDIR rule created or validated then
enabled FDIR again and reduced the buffer a second time, until the
size underflowed.

Compute PBRXSIZE(0) from the default packet buffer size instead.

Fixes: ea230dda16ad ("net/txgbe: configure flow director filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_fdir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 67f586ffc7..cee38a42b8 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -390,11 +390,10 @@ txgbe_fdir_configure(struct rte_eth_dev *dev)
 
 	/*
 	 * Before enabling Flow Director, the Rx Packet Buffer size
-	 * must be reduced.  The new value is the current size minus
+	 * must be reduced.  The new value is the default size minus
 	 * flow director memory usage size.
 	 */
-	pbsize = rd32(hw, TXGBE_PBRXSIZE(0));
-	pbsize -= TXGBD_FDIRCTL_BUF_BYTE(fdirctrl);
+	pbsize = (hw->mac.rx_pb_size << 10) - TXGBD_FDIRCTL_BUF_BYTE(fdirctrl);
 	wr32(hw, TXGBE_PBRXSIZE(0), pbsize);
 
 	/*
-- 
2.53.0

