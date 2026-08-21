Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808B5C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:31:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 168E840E3F;
	Fri, 21 Aug 2026 21:30:29 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id DAE5E40DCA
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:27 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso1082069a12.1
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340627;
 x=1787945427; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ApwXg1fY958MgDJ6f5jI5muRT87vpJitviEaFOMcNfM=;
 b=v+BzEY4VLxrd6lfS+TV/gvUmVmdjJdCKu9sK1q6uefyVCXPKfYCj/N3ogTXNsVbPlf
 vBZjMH9PF+3yRpceDPB3aOKFbs3wqsCw9pRdcJRUb5h4MLcROZ99iDAlBWkPas77CXUe
 mehW78HK6zwrz/jB04qhp2vdJxKq9jMMaBGThZSNNSniei7pSHN9OZvaVQ9wth3ooCEE
 IamrLElXR93U+EHTQIROwpWqT/jYy1ZdAHm9LqOTdKMQlDzfXtNA29+nBbSoJFADg7Iv
 2B93rnRCBuGmEk+XamVnUe0Q0+FUmcawDZU6CX8oaLWU9NfB7yogsBgoXAZdDKouGv5V
 c2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340627; x=1787945427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ApwXg1fY958MgDJ6f5jI5muRT87vpJitviEaFOMcNfM=;
 b=WGkbeArtB4YV6FgzmZ+hjWLpCIo++3Ozx9m0ZOgViq7Jvo3aypaSZVL2f3y1sGaHqj
 8Jig1uHsya7NyvHgCJwCJKKZsrKD4t0Zvjlpc0Q+LEXCQz+cYWRd8OaMzE3rlTxGWu3V
 Lx9A1UtkUucoF25j+A6jzQPT8Wg+jKQKfLYgaK7r6GwXho9B1jea23ZDNvnj5ls6tQoD
 FUa6hLvbWv2g7JlzCciCSdeKkEmor5tgVeV5LbAQETIaHZiBOxwWAd1Y0o8ui6DMGva5
 YxpbitU2joMON2WEbFtUMlMVnkAR/OC0N1l/tz93VQVYBuGTYnea+1Qx/y0iHs39fzaT
 pBXg==
X-Gm-Message-State: AFuF++mHljj/dkH0fouP2/cXoK42GlUFHbn9lzMT+dykvuHi8UTc4Wbo
 xztH0gCt4gxAHzp+Ov+DNL15EknelOlKG/VZb1fX4zhJ/WNsRoC5ZlWXO3aXbWbtq1bPnoio1du
 A43VUqrs=
X-Gm-Gg: AR+sD101Tz4b5iIJU1OuNQUam5bmbOkei81t4g/74tkRRBTUvvKk5l0qLJmoc5F2D2m
 Ip0Fh4M4JQxe7hRiFTI9ry+pQ3qXUOzQB0DX55ObQBHU/fSYH1/ezno39Vn4OD2VZeJPoskDvsm
 yunmFmGNlY5TAR2tg6A7dmQGC+YHeBIQyX2aqtWfPEC94gzbFOrbejiBlEy6uFf4PJd756QwEYb
 cbqtYN7+FV7NmjR7DlkebZOi6AMCMELIQPidiItWWM7Sl4C5U/VG7mlzINxmIwx/49dZ2ZZMM7g
 cFK5QxIRQvSIMbzALy7Staj8Z2QR56P4/ySjsqxcBZUGFoZnnIlIV4OSm/mWVrmFqk1RzTFK6zk
 VLjGbMRqbfqgpI/A/t2otFpbAYdWEh3X8Ga98KS9JmaJRBcNRCjMfVbyJ4HBlDK8t8KD6IgKhbX
 CGSuF82p8bR16vD7wMNHA5j85cF0652npm0zj19urc332IOFUV/i1iEwNpSVK2IgVCE8Ce83wo7
 9neFy6l+uTMeHJeJyAA48XOnMw=
X-Received: by 2002:a05:6a21:7d02:b0:3c3:a3fd:db0a with SMTP id
 adf61e73a8af0-3cd3013e240mr18890633637.16.1787340626883; 
 Fri, 21 Aug 2026 12:30:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v2 42/68] net/ngbe: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:37 -0700
Message-ID: <20260821192646.146382-43-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ngbe/ngbe_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_pf.c b/drivers/net/ngbe/ngbe_pf.c
index db2384e28c..5f33aaff5f 100644
--- a/drivers/net/ngbe/ngbe_pf.c
+++ b/drivers/net/ngbe/ngbe_pf.c
@@ -347,7 +347,7 @@ ngbe_vf_reset(struct rte_eth_dev *eth_dev, uint16_t vf, uint32_t *msgbuf)
 
 	/* reply to reset with ack and vf mac address */
 	msgbuf[0] = NGBE_VF_RESET | NGBE_VT_MSGTYPE_ACK;
-	rte_memcpy(new_mac, vf_mac, RTE_ETHER_ADDR_LEN);
+	memcpy(new_mac, vf_mac, RTE_ETHER_ADDR_LEN);
 	/*
 	 * Piggyback the multicast filter type so VF can compute the
 	 * correct vectors
@@ -369,7 +369,7 @@ ngbe_vf_set_mac_addr(struct rte_eth_dev *eth_dev,
 	struct rte_ether_addr *ea = (struct rte_ether_addr *)new_mac;
 
 	if (rte_is_valid_assigned_ether_addr(ea)) {
-		rte_memcpy(vfinfo[vf].vf_mac_addresses, new_mac, 6);
+		memcpy(vfinfo[vf].vf_mac_addresses, new_mac, 6);
 		return hw->mac.set_rar(hw, rar_entry, new_mac, vf, true);
 	}
 	return -1;
-- 
2.53.0

