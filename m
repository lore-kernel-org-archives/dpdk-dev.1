Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB290C3DA7A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:39:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3B9B4069F;
	Wed, 14 Oct 2026 18:39:47 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id F083D4068E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:39:45 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3ab3260b35dso2748295a91.1
 for <dev@dpdk.org>; Wed, 14 Oct 2026 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791995985; x=1792600785; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=20b1XjJ0sjvZZy3AHHAz0YTDM+rPlMQVLcyLB/ACZmU=;
 b=H3zS6UzfYHXaDdMhIe69g2mdZx5O8hkAzNJzwqy5B41D/MEHMj7G5zKpQB4NPIn7Qz
 c5sDYmQqFEu3Aa6LOyEeUvF3GU6McWFwSeVnAAa7BQy3liq4o7T2HLBOfXfQvEivLde5
 DukphDWYwRS5zDhiWkWOqXkoDDzsysmJT+h0H/NJfqFvxmyIww9D04bXXbhZD27+obl9
 crWRjChuUfVh5e+L1yFrdq/iiZyOb2jfQEjybgU6DzW41wKvu/eCJIwjkpvdHGcUdMRI
 EVAfx4xZVaYPQCA4FDIIkM8NxFpfqLKrOejTqBmFJr+HlpdJx6RLjPL9HPpEearrSxSG
 khAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791995985; x=1792600785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=20b1XjJ0sjvZZy3AHHAz0YTDM+rPlMQVLcyLB/ACZmU=;
 b=1wNadpfa8j/3qh5O7ljQr2gkD/xCj6RF7+DAXMUisPQEP+aGLntcoAM9NLjyoZ1C62
 LXbaG8jNg256HKBaZEvAuYBzyKoy4xTu1yKuaCEQ0Y02b1/9YcXMSaB1okHmzV1oXQ73
 BRkzlmeaYWy9K5GoM/dntNxIUVFb+4peXoJyv5ZJhjY3aINNp3icCIkXF5umGuiOiKlI
 5cmJmqIaXtU1RhjhnPBWC73xJsyh7GjOe4UsbjyhBkrwQUFT+tpJEVhBtsVwTWIcq0Ar
 jbZkZv/IyrtWyMPdV6FBZK5bt/uxCxZy1XLBoWq44A/OHlT7hm2sYmFiF11n2ueE22aw
 yrXw==
X-Gm-Message-State: AFq9FYLAjRcsVwZK2GUCd0lHkpndWANpqW0VaW4eVoRdS+SNuWIMCtpR
 5u0AIcuDWygakT8KDO8lowoUuLBs2QbpbRE8wcOZj4ZokM0obo2AoPBZnid41PpL
X-Gm-Gg: AYBFou0AnXi+miRujmpOKng0aOH8bGxeLko094qrLcEHlLC/95IWPEvIDnmvgAur+0y
 +hF9NPl4hvnE1JF2mjI2mOc1rYGNnP1Ew3ox//LPXkmwD7yy14z85P31uCVZUQ4HLjo5r4vEbj9
 QVZFHhwi8aqEyBEQTriEmv5vKWcQCiTS/aSViuZ3OZ8esJZHfgAqozklUkmL7F3QIZ9ZynY7/Y6
 D4W8MQYC+6k7D1DQ9uh1XULYfeZKCl+8hHOoSxJh3CJzdQZBESVekxoUas+jFWm4F8Io2X39CLd
 OaX00806pHj5LN+SI6CVnRDlrBfLtA1R3TQYLrzk6A6hl4bLJ64KbrG7va9QLXuM/TqArKU7RVB
 o8XQ7LClIVv3Pukucn4ChisL/uAZcClVhcw1typughO+ZVGBUfAXXF2J7OmYb1Qnuoq81roS5Em
 TjKL52iG7tf9s2sS1+sdvnST4ZgqO+0pAB4DR349wC5pIrLVhkMaP8MuKgr5cXoIfRD5hbH2eYe
 TDxUJw=
X-Received: by 2002:a17:90a:d2ce:b0:3a4:97ea:f0da with SMTP id
 98e67ed59e1d1-3ab3a735fbcmr13335291a91.17.1791995984906; 
 Wed, 14 Oct 2026 09:39:44 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635cd3b34sm83677a12.28.2026.10.14.09.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:39:44 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: Zhang Tengfei <zhtfdev@gmail.com>, jiawenwu@trustnetic.com,
 zaiyuwang@trustnetic.com, stephen@networkplumber.org, stable@dpdk.org
Subject: [PATCH v2 1/3] net/txgbe: fix Rx packet buffer size with flow director
Date: Thu, 15 Oct 2026 00:39:22 +0800
Message-ID: <5ae97e7c44c3c9272417ecfd838154188cd616d4.1791995192.git.zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791995192.git.zhtfdev@gmail.com>
References: <cover.1791995192.git.zhtfdev@gmail.com>
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

