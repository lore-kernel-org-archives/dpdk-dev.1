Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B99C79FBD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 17:40:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73FA14067D;
	Wed,  9 Sep 2026 19:40:04 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 171324067A
 for <dev@dpdk.org>; Wed,  9 Sep 2026 19:40:03 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2d6fe26ef1cso64282725ad.2
 for <dev@dpdk.org>; Wed, 09 Sep 2026 10:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788975602; x=1789580402; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GQAkjnOLLsKVQs2SAz9+KsG8K/yetRBPAQnMWuHxicc=;
 b=IHRhShbtQsOYSHFGC+hMvFWLw88kYzPmorhIvQatRFeng28xBhzMALmZOUL11TwRRS
 bRcNqNNBaw83z8zmeUvWdUnTrnvwWM1nnXrtyCSdjzpOyy6Rf9qVWPKbfGGFlZdDvJXX
 ioKfSnRfhZEgdaFypugFGBN7OCd6E1TgzI6opJKjEnfupSEysl21x+P4NXn+IqUMFW24
 pYF7AHvx5Z5HuLBSnrHeR8XNTmEk0Y48ZHI2v8GPymUiGfkwKK1hJn9/4s1tqfPuko+1
 52hqmJbSO4OPTQpMZyy4a/Nr0ILRHea+ont00dNpHDRCnTxbpzStlHpd9/oMAAJxigct
 NteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788975602; x=1789580402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GQAkjnOLLsKVQs2SAz9+KsG8K/yetRBPAQnMWuHxicc=;
 b=UdmMszSYlMf8bKEPr9CW09oEcGX7KPuP5PUmNH/oyeHLT1pNuBef0NqdAQAfZlQwr5
 ukN9KZsn4lyFnhTTeRP3upvSP7RasVFrmED8F3Bft1O35KJmKu+FIcyVAD1AJ40FXhYy
 +PpdHx/qYU54w74Y5w1DTqFlV+rmWemADHAP687teC9yOUzvbVF7QaKi52ag1mSfiXgJ
 ckPKbGUA7Q90u0dvGv89ZM4oVVrVxpERy1nCgBKycRacG7llKYGj7XcnUP1/XrnN5CEg
 VAApORsgacjNIU33cmwZM8tCT+53jOUdVQg6qA0j2exVV2UgIjb/sCmN7dEwxxfxZkPn
 rGDg==
X-Gm-Message-State: AFuF++nTIiW5+9BLxwjsrCDopcZZQNeizGYUeAkt/a7QG9hC2pXOKX5J
 Pm4nqLyFitj7tyZdBTucvLiAlD5t/4b8x1H6OuBVfhAT/KFeGwgGq92G
X-Gm-Gg: AYBFou2q99XiKrVoUFQivQYJ03VOWyhZLrKvj/2WnXBu2Ol7L2eJ/quE6LnqhUP9dQV
 n1x143fuQ2rbbHAZjiZMtA1GsFh7h8mUH+F4V0f+gN5W7jkcVVPN01bp4DPZvZ7r8G2zoyWKGhY
 LT+f1jDKjUWWxcpLMQep67Xtt+vOFxFbzbL3iqBRs7sVRlQuSDAnyfjs+VOSBPhbNvCbrRM3pQP
 Vk804jlFrNFvEmsm17yjgYF6eLKz8fhBU9vUdxIXlM+WAUdRK4PwZyioY5wpf4UvVP1NWG2Hd4P
 t+YhP5EGcs9AWWQH9wUqtEzam21Qf2WuwswrGd1sVL4SxkgWAKhJbt8anH1nsoG/vQYdAfOomC1
 ikbCJJ03D6PCzZNFlUsHw8LK54L8rSw4nTUwAcbE2sc6W7ssTxSsdLl+owzhXYdHxPRkB+6jo3o
 aXbYtrTrjqeimK0b71s1Txk+0ZwL1P3WfhuYndp3ClbEsH2ag/dvsyNMZnLTPD3fqocNMfo86wf
 qYV
X-Received: by 2002:a17:903:1107:b0:2d0:cc92:f7c2 with SMTP id
 d9443c01a7336-2db122ec102mr486318315ad.1.1788975601600; 
 Wed, 09 Sep 2026 10:40:01 -0700 (PDT)
Received: from fedora (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db149cd817sm77263995ad.72.2026.09.09.10.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 10:40:00 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH] net/txgbe: fix FDIR devarg integer width
Date: Thu, 10 Sep 2026 01:39:46 +0800
Message-ID: <20260909173946.16645-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.55.0
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

txgbe_handle_devarg() stores a uint16_t through extra_args, but
pballoc and drop_queue were u8. Setting pkt-filter-size overwrote
the adjacent drop_queue default.

Fixes: 7e18be9beef2 ("net/txgbe: add device arguments for FDIR")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 4d2746371b..814840b3f5 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -533,8 +533,8 @@ txgbe_parse_devargs(struct rte_eth_dev *dev)
 	u16 ffe_pre = 8;
 	u16 ffe_post = 44;
 	/* FDIR args */
-	u8 pballoc = 0;
-	u8 drop_queue = 127;
+	u16 pballoc = 0;
+	u16 drop_queue = 127;
 	/* New devargs for amberlite config */
 	u16 tx_headwb = 1;
 	u16 tx_headwb_size = 16;
-- 
2.55.0

