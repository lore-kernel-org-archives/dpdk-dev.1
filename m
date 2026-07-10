Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43160C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 13:46:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 747F840671;
	Fri, 10 Jul 2026 15:46:56 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 32C404029B
 for <dev@dpdk.org>; Fri, 10 Jul 2026 15:46:55 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so8504625e9.0
 for <dev@dpdk.org>; Fri, 10 Jul 2026 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783691215; x=1784296015; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cs+ieZBQCCxWelooV1ODfwhKbHTxsulr2hOp37B5Uo8=;
 b=GF3xGBZeACueT3gl6zcqXjYtQ6BqPw2T57nYqyk1eBeJwqV6XpBsgTuvfRxM/QhWdY
 t45BXLTM9KPLvfQF+JqxPysTS4yxbrwKSAnirUCBQui9y6WDyNnHG8amBNbVPwFqXyoR
 mKm1tV9zkwOMS69muv5mhutSdMC14sUkpCscxSeBoN3D5MWA+Hj/Vsads4kNf+HmPe2r
 6YlUUa5LWwtq3tdJ0/CtnSaDqA4W1nFqrGnvfT5KcAT93B680yrg2lUmbwLzBHygK1L9
 0vT5TXNIShRxwnBoZDdxAWHEKsAu7VrkQHaB4Lw+Z4vi1RWUE+NmtmQGw2+Ci81hpH44
 GbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783691215; x=1784296015;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cs+ieZBQCCxWelooV1ODfwhKbHTxsulr2hOp37B5Uo8=;
 b=KTiyc2rTibQEBx7FraAVaZXeibv6KhjtPrB8FxmAfnVBXJTnJlVyiAVWEPK98yJM/O
 61y77PE+jewJTNorS/4Ht0UgTlCfRi3Xohlh+JSh7qdqf/2L6x/c98polyMMXAzHpKRG
 gsI5ouPT55uAvIuLi4hVnLzq7uWGaFBbWedjc9YugCN4jEXQk13Psd9aseRYo01UXBeq
 IanNJYVF4yAMcMd6vGTgwP638BTSd4183Y/f/zakJlre8XayD7EdINo1rNyr3+0q9N7m
 Fw+ejgGHe12OAY1PqmrMvUD7V6ZwRuTdIgFkHuN6/Ea02iiqtcTIhy6rF83LMLKGNrUC
 3mMA==
X-Gm-Message-State: AOJu0YxdEy7djIFZ8h836YCFLsBGN2viKgT+jCNV4sLw6tJcEN2v3nxH
 Ys077phnuaQISNqaVi4otsH+RLS71jgfVpTbI+Bc575azFdl8uu4au7WCccefLk+
X-Gm-Gg: AfdE7ckTIBxhSQAzEVvgGo+oi3TVVPggAM56P33MazO1n/npHiLDckiZx7P8u3K/v7x
 BYr9U/xG4zdp2J1YRrfSZpIhmlwYBEIGtDgpeW2kf8Sv13shXo/ytWADjB8S1SmLN+ennrnlz0Y
 jwm68EV4ABhZykPx0fHgeyU4wwcKJ0vqoCIOrF46aDiIOIHVnbEYAeAoMpG/Voox+SQqaXtqC25
 E3AJZklpE+CUH9fQG4OW6srUkSGLhTqz8OrtmKJWDk4pRaq/XGEyTm1sCamgYt8XXiJ3vnGugth
 wyn2DfxOt+TMWQz6CIXuxwzeX1mJvCCLyrZwE7LNlFcRFG07I0jWrPxsJXmo35xtGuYZB+pZrjd
 Ju1IHqdipuMQnaPSawPQzJ5ZR/nKVtZUyg+TR76nIYdFIhPriihoasFO+l6V2raIRh8OF3w66qz
 V2dJo5qk6GxEYKOknSYWMczf3eFcnEMzOn+d2wZU3RN9qzcdDwuK/g85991p+0/FLxyCluq9DpT
 3a/ogNRdUybGeJiMCVCcKTWB/UV9wR9SPPU8Q==
X-Received: by 2002:a05:600c:4e03:b0:493:f262:cc4c with SMTP id
 5b1f17b1804b1-493f262cccamr43537155e9.23.1783691214386; 
 Fri, 10 Jul 2026 06:46:54 -0700 (PDT)
Received: from ll-cherrati.online.lan (gw-online.ijclab.in2p3.fr.
 [134.158.76.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74835esm154557295e9.14.2026.07.10.06.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:46:53 -0700 (PDT)
From: SidAli CHERRATI <scherrati1@gmail.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 SidAli CHERRATI <scherrati1@gmail.com>, stable@dpdk.org
Subject: [PATCH 1/2] net/i40e: fix return value of close operation
Date: Fri, 10 Jul 2026 15:46:38 +0200
Message-Id: <20260710134639.108129-1-scherrati1@gmail.com>
X-Mailer: git-send-email 2.34.1
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

rte_intr_callback_unregister() returns the number of unregistered
callbacks on success. Since the close operation started returning
the ret variable instead of 0, this positive value leaks as the
return value of i40e_dev_close(), so applications checking
rte_eth_dev_close() != 0 treat a successful close as a failure.

Fixes: 62024eb82756 ("ethdev: change stop operation callback to return int")
Cc: stable@dpdk.org
Signed-off-by: SidAli CHERRATI <scherrati1@gmail.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b6b2d291ee..2fe6b1e118 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -2764,6 +2764,7 @@ i40e_dev_close(struct rte_eth_dev *dev)
 		ret = rte_intr_callback_unregister(intr_handle,
 				i40e_dev_interrupt_handler, dev);
 		if (ret >= 0 || ret == -ENOENT) {
+			ret = 0;
 			break;
 		} else if (ret != -EAGAIN) {
 			PMD_INIT_LOG(ERR,
-- 
2.34.1

