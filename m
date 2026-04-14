Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F4EF45A1C
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 05:26:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADFDF4042F;
	Tue, 14 Apr 2026 07:26:09 +0200 (CEST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54]) by mails.dpdk.org (Postfix) with ESMTP id 9DD1D402EA
 for <dev@dpdk.org>; Tue, 14 Apr 2026 07:26:08 +0200 (CEST)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso4708287a34.3
 for <dev@dpdk.org>; Mon, 13 Apr 2026 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776144367;
 x=1776749167; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MduX+wyd6uK/clSrw2PeT51nOgylx4nPcuyLPj8+eYw=;
 b=svfiCpcRiSG70aP9n7sYpB/VbDWBKqxlInfnNPPv+Ez3OtN2Pg4LqbTwCCnTxy+aKa
 ueRjDMiDQnWs4rT3JesAaLZO7aRSmDd84ihcAaXC61+UehM+zp0a3Vt1vLAZwa9adBWA
 gGD5SlKx724VBlalbtvFkVYcG5654rWpOZ22/dGV8ib43bZJy6mdFUYiE2296OVSh2ea
 hEYzI+FuJ9sXnRW0T5LItoGpRQB8lv6gQHLpkpQtI2qM0ONJKqdSllb75KXW/cSFwo9F
 6UH8vUDfei9NfRXBAi8zY2Oj3c1sb3pWSGoEFkgukMrreS/vROtol2MXejt51lzIuDf/
 uMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776144367; x=1776749167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MduX+wyd6uK/clSrw2PeT51nOgylx4nPcuyLPj8+eYw=;
 b=BSNCDEQzE0TenGUJIfHJNwG8p6Eof2Mt2EBsL+zo/UFsObGdtQrx5HGG5aYiUIYGuM
 asUVppQB3PavpxsWXe2zC4uBtUXCe4LJB5qdLN7+DmgYj7RAiR+Mx+nfCXBBaMRn0I/r
 myIEJKG5K3LiSOx6kopMZE955NsuQCNhuZ5y1NOLHX8hDDfmdhbi1de5XSImB7FrG0nn
 iyV9M8EP7uGMjlFCl2TOSL1TOpJdkymMqOyDctGpFGbKxaqNgbbUIS+imiZ/pwkrKt9A
 703IUrIUzHT4LC2c2QRfZT7CviUbZaHh5+th+sbfzayJ7+61pR9xk4yUpICEmQ2ng/ac
 9qrw==
X-Gm-Message-State: AOJu0YzNGL8R266PratIj22MFuM4Ne1GDc1ITd2HDGZ3Oo2dJGXFpnHJ
 NCDPRDNMhxuwefbls84H5y1+ppPO6hStvagxjAuQtUVsmXGe83vk3gPpu9NEYNQvOKgRyhswi6l
 1p0VP
X-Gm-Gg: AeBDievipCj4h7xaN5G43wKpMpqTG67kRKA9Oncx+LhKJw0uT/0+QO3HyPmHIdGPPA4
 OAckIzx6dRdVwbMqcU4NZo+JnUPiolUBSx0ZFHPtkMxIkrMbE3X1OcDh2B8x8aFdl1Bkeyi90+7
 ZJvii+WmrgmN6094r0HY7VM57OTOzYae/9zLgBcGkqbIQep3nCb431fUOBDg1pHbCXGNj9z8H3p
 jOGTk5xvyDQrdAdAt7JCr8jjf0jRJnkfj7lJGg/msn0Dtx7V38wyDKIvqJbkjlhRPwABhXBWrZL
 dG7gpjF/2bvFVSK5JD9+2ZHVbpP22LthYNXew2nn3kxo7OX4uWNkI+vSWhnamrj5y9iJ5JIdTqF
 Jb+ADX1KFzdgHd1J/+hSzduBt22PK9pYG9ttQZzia2igEEfbiHZIzZtOKobTnh/h/XgIoTYeWww
 dwPzC06bTQBcZwRgLjvVVCPeeL5QBIrxE6abuiLA2O/yA=
X-Received: by 2002:a05:6830:81fa:b0:7d7:f5c6:9fa3 with SMTP id
 46e09a7af769-7dc27e2e2admr11397816a34.8.1776144367532; 
 Mon, 13 Apr 2026 22:26:07 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc3959099fsm7386762a34.9.2026.04.13.22.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 22:26:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/i40e: reduce debug messages
Date: Mon, 13 Apr 2026 22:26:02 -0700
Message-ID: <20260414052603.201114-1-stephen@networkplumber.org>
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

The driver logs normal things like choice of AVX at NOTICE level.
This shows up as unnecessary noise to regular users.

Bugzilla ID: 1936
Fixes: 3f24891594c1 ("net/i40e: use common Rx path selection infrastructure")
Fixes: 8d57c1788806 ("net/i40e: use common Tx path selection infrastructure")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index c5ac75e0f0..d00548ac89 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3042,7 +3042,7 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 
 out:
 	dev->rx_pkt_burst = i40e_rx_path_infos[ad->rx_func_type].pkt_burst;
-	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
 			i40e_rx_path_infos[ad->rx_func_type].info, dev->data->port_id);
 }
 
@@ -3124,7 +3124,7 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 					 i40e_tx_path_infos[ad->tx_func_type].pkt_burst;
 	dev->tx_pkt_prepare = i40e_tx_path_infos[ad->tx_func_type].pkt_prep;
 
-	PMD_DRV_LOG(NOTICE, "Using %s (port %d).",
+	PMD_DRV_LOG(DEBUG, "Using %s (port %d).",
 		i40e_tx_path_infos[ad->tx_func_type].info, dev->data->port_id);
 
 	if (ad->tx_func_type == I40E_TX_SCALAR_SIMPLE ||
-- 
2.53.0

