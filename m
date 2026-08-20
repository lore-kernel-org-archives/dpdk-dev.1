Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0FBC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:26:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DBDE40BA4;
	Thu, 20 Aug 2026 07:25:14 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7007A40E17
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:25:11 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cbee846deecso1893388a12.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203510;
 x=1787808310; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ApwXg1fY958MgDJ6f5jI5muRT87vpJitviEaFOMcNfM=;
 b=kCGscGOZsliZRTGPZBdLuUCXvYYXIU7IkNIU6qkkcF71+imvw1j5vNUSNNi88CjREe
 p4uyfBFGbwk7v5DMxrjA/EoAapRFUTsk9mfMQs7Bf7+85O4/EC5cnniMuq8F6vM0YiWj
 V4QfgABRQvGxFyJMWVQ8iBqJP+wHH7bEBua8R6kzb5/Kgr3MxjiqCvuuyK6AVSXbbM/J
 nfBvQsA8ipOlKn3knHOCud3e/bSwVMdP3ibCA5cprn0mjQKS9lhR6IBB5Brmjx40qwMh
 bWvI4SBHBcC7DH8HyM0os9YtMx1+2K8B/MtCTbwJzath6LnrY3EzxaJEuahYBgma9mjp
 ppbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203510; x=1787808310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ApwXg1fY958MgDJ6f5jI5muRT87vpJitviEaFOMcNfM=;
 b=Dk8JvWOpF+K8oyG1w9eYNWr0xjZGiyzpYT69NdjcLMWJmIxjytgBns5lnf68dsza8F
 9NMZ15HBYkasjeSWYtBf7XpRDm87brhDdejkQvrcF3n+0etmQxvkKTn9+b+NL6FHY8CH
 CGrDE7EOttt23nyW0aTbplu1MwObBhlPpCCfMfKJZgjM0WtF5Gvv2D9FYGpp/+n8fXSo
 KX1aDfFoMtyGPJdTr0woZGlel8DiQ+SxksdcUxdskXED6BmTq3BvTVT1GgeTYQFuK7Rv
 StyKtL+84xBVsY3I0DARsU72wkAe03HmBDMuMwwZ2N17dsuVJzn2dfMuhYpl00LDezcn
 jiJQ==
X-Gm-Message-State: AOJu0YwaiAa02ymgHKpO9tOufosD2xKrZ4HKm/7WzHhNOtah/sUUvV/1
 x3WLfwx2a/xBhoh4RGFNTd9eyYBViG5CyR4pn7O6JJARgErWAXlrIjCaDkqUvDs1wP8e9xRWUrk
 Wr4EC
X-Gm-Gg: AR+sD13f1TemXoOwBAwrBzGywfAKoov8LV1q3wEGq3HldG4+HWDW12pO1XxT4SWHbLb
 +BNLmkOWGtkY4sCO1Ag1vcBKAugf2E1+5gvf2lyBLlhdUuKRDH6Zv8ya8jzaVht42mMvbYydmlV
 zjYKKygl54jtirDnx1OApf4l8mnmcJN5A1ruC6cKpgUnT5/Fn6dK2eR/J0RgOXPhBC+r6KQnakH
 rnpwaKSTTPy4ARfJPewihIkiSfnd0DMcytBp4OQHkVy9+iPfqzzlEsdiMIsX+UTpZsow6znMVGa
 6iYOpH1VTOaKXfzBC5VcFiW1mY2udPUU1cvS26L+x8oOhL4KZzjfxrkLyKz/AkA2kIgjNoZbY0y
 PYxvW4V+AmCcVnx/Jy8LXXlNa3Qd9z6K0zYvrdzR9ydk9R9kKO8G2sOH9xmZFrhJuIC3CHRXKGT
 1Y9QBoaEB1lqhVUgrb3gYcpGBm1IWF5HjyD5eMD/wyr3qSTmKu6X1CHPmDXDv0NNKdDGDNKrE0u
 mSJ9R72Agd6oyv3SLeT48cVuj4=
X-Received: by 2002:a05:6a20:a127:b0:3cc:ebeb:3efe with SMTP id
 adf61e73a8af0-3cd010d3831mr18254322637.9.1787203510564; 
 Wed, 19 Aug 2026 22:25:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:25:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH 35/61] net/ngbe: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:25 -0700
Message-ID: <20260820052251.1453273-36-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

