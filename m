Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C32E83840
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:05:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA5A540430;
	Tue, 17 Feb 2026 00:04:50 +0100 (CET)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66]) by mails.dpdk.org (Postfix) with ESMTP id BDB6440616
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:04:47 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id
 ffacd0b85a97d-43767807cf3so2718099f8f.1
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283087;
 x=1771887887; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QoeCKh+oi72zMTrFwuM28at55S466RG7Q9BDFLcGKqs=;
 b=L5qOTT1M+36JfQr2y6J5tLfnJbPXB3IWFijzliQYOuQv7pZaiyg9QjPPI0n4qF8X3d
 plN5JtRUTNGIrWOT6pG+0788SYbl63CIED+Yn6IBZh4K47nZLl60S2D34+AIAEjNO0SC
 1sPNBTB1fg61SEVUOuP7VqjxsmL5qJedMlDJEpIH7czs11QMZv8O0HJdEyBMnlyZQnlV
 ezitLfq5U1NNCRYdPShGG+JyzKn3f6U6jQEFhNxmO27F3nlcla3TVjnJVp8x1mnOQ/Es
 dn1SHozIP8Yd2u4hTmiKHLk6QjtGSBhqJQ5NePt/MB0dPL4bB8Pb+h86vPshLyKGSXMk
 XVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283087; x=1771887887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QoeCKh+oi72zMTrFwuM28at55S466RG7Q9BDFLcGKqs=;
 b=VbRHFKc/HxIRFnTKcOQ4Ecc+V/FugvppzoeHY291BsYjDmoWd1k5JT2NwZyYmsxFgk
 RhKjJjd2gS5sL1mKTRSgSNBjQp5XhlIpAEYhjps8L9goYGjXITDaKKA9DqbKFCmQLAWY
 MEhJkAbxZmqXB9WYQtxfRes2GZUVDWG9Fc2RMgm/k5Hb+4/YalQFV5eiMJjWNFsQnnip
 wQsw7dOaH2B5H2UfmyB7/MH2Ql2LqaU7Xa9dSuLDkCboFkduJY15C3MYV6JY+7xrwALw
 cMB83v0Js0nlSdmvcLgBNWvBu/0bxK6l1mTP7v0gFQrtEhIDpElQ+grH7H6W8HDe4ofM
 OW3A==
X-Gm-Message-State: AOJu0YxACBwFlmKIJZT3USHqyEzS7NsIFtUdL4TOdUzgYb2Ngu1Ece1o
 g1VHZs1Hc9cBc/rz5g9sIw3F49PvE5T12TeUayrYESxMFueldkK2uIIRaeed0Po9o++1XbdpUCT
 /cBgn5ztPrA==
X-Gm-Gg: AZuq6aKc/HYsKjV6+LXOZhrjAM44zr6nqAdKtjjLID5RmeDxzLjOWpeN7Mxihyivdg0
 m7Gk3875v/+a+8J3v+X6Ff/2NobjRL0x8iRDekhTgEpf0Inz2Mh/+IiXy5fP1rRjJTv58UbJ3O2
 bDV/PIkj1c2EfPNbDz/30JBSM6EzSij+NQ5pvz0sI1Bo18EoyBjgKD9WVdd6R9Nb5+/rOKeeJy5
 l323oY/UKKpEew2ezInPnXmaboSCxYoxKTeeu5+vl6gOCCjpv5pr1hT5e0KazewsJQ2EBmJXsyl
 QKAWgZp5fmshTC/Bd6/lvsVBGAjJEn3pL/NlOWNymPz0IqzwOKKhy7PyFr7W7NMPKgPhXHTJNgW
 hUNf+dM4Af3kGJms667caTWVL7RJbrloCzFMC+MsxpCnu+xZ4hoGVYZ2H9iZpjpkPUbF9e/B+Oh
 xuQPJS/8Vk1vSx8/UuGbcrHugnscydkhD3u5/fcrYcr4zltNYEjaZ++4cMGUlf3A==
X-Received: by 2002:a05:6000:3107:b0:431:a50:6e97 with SMTP id
 ffacd0b85a97d-4379db8ced2mr16896710f8f.34.1771283087348; 
 Mon, 16 Feb 2026 15:04:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:04:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 03/11] net/tap: clarify TUN/TAP flag assignment
Date: Mon, 16 Feb 2026 15:02:27 -0800
Message-ID: <20260216230437.847578-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216230437.847578-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
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

Add parentheses in the ternary expression that relied on operator
precedence between '?:' and '|'. No functional change.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index aa236cf967..e06e1ca079 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -155,7 +155,8 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 	 * to check if a received packet has been truncated.
 	 */
 	ifr.ifr_flags = (pmd->type == ETH_TUNTAP_TYPE_TAP) ?
-		IFF_TAP : IFF_TUN | IFF_POINTOPOINT;
+		IFF_TAP : (IFF_TUN | IFF_POINTOPOINT);
+
 	strlcpy(ifr.ifr_name, pmd->name, IFNAMSIZ);
 
 	fd = open(TUN_TAP_DEV_PATH, O_RDWR);
-- 
2.51.0

