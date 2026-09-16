Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F0C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFC7642F45;
	Wed, 16 Sep 2026 15:12:11 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 1D1A54279F
 for <dev@dpdk.org>; Wed, 16 Sep 2026 15:12:10 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-853e2610bb4so1324212b3a.0
 for <dev@dpdk.org>; Wed, 16 Sep 2026 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789564329; x=1790169129; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MB66SY8IdemztYHhupX1LT3PfGSSXKF+PG/3tpwQw3k=;
 b=Y7cGRKZYC1vii+xfsTlkB7NXXzsd8VAmwAU0JzvgblbQstyJqsKezzKoHWDsF6CSaU
 8wILNlt/++PDKsQxb8mgqcFnogY5zBEmf0qPLEsQ3k/8FFGSxxmsLCCY7pArjgF5wu3a
 JRfuTLIDWWLwr+yJwEOSk0sYGoUlFxDWWkwbBPmDlITRegTnABKXQDFBG3Le2d39yC50
 S586N7oqztnnDU6fkCAP6ENMfBwrVv2drVWhY7cQ0ZhLlbrif0EbzxHSkdRU6iEGMeL7
 boLsDo4BmU+6nz+v82W0J95ha9+odUDv/Rq51UwmunEm+f6eeA3+a5taen0GGvd9Aaxp
 kgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564329; x=1790169129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MB66SY8IdemztYHhupX1LT3PfGSSXKF+PG/3tpwQw3k=;
 b=Kf4cvYj1U8wW+MQLizwBLmBRqJHNAzFsa30DCRiNgFsfyQE8U/87SskeOmmZ1Fz8Ss
 9fTdGf7Mh1+dNyMSnxH6WFGEnxO60SZxHyX6ofanp95YT56DhnSiookfRbSyZzxee5nC
 1sQ4r8syWsFvz6G7qmxO5wd7GL8ch5YB0PmOHBlj1JbrYc8m0YRN4q/zhvOU/44ks4lG
 ZKjo2TyHPfUpop+04CYR46pmp46IRRB1DCkFJLEW53FYb/xpHqghj3zLOpXurHajqOmf
 SCzTVFluPzQQhuotmEKS2Q96pl6o9vletG+SrM0NK7qUCb3vBiyJJ78Nis/ySW5ZDelx
 QSaA==
X-Gm-Message-State: AFuF++lM6pOVUpF0cBZ0lAGD1IC5oz+gTkTBhqCcH2s1YqdzD4r6NcB5
 FNm6hRUdp7+vJY9d8aSodpPrrq/lw6hCcjR5Zp7Bg1QfYx2/3MC8mF3ew0HaUYN9
X-Gm-Gg: AYBFou1j22rw/3Ej0TcU5tfOLKCR0mIbxsVwllGUmflLOcuLms9OYz6/jKBr6sWz1Un
 hX2pr2XMDHT06r6a+yA9DjW6Ipf59sSH36yhE1d/7hjhjLUNam1NnKsVmsUVoqCTFtx8xfpc/4B
 sLRvgU2r8Oin2zbj045ndz7K7Xw1mJaJvq0gnzlUtJDsHq5HHKBVxe4nIMrcaISmPdohoDLywsa
 7GxZLiacx5JQtqx88AQZi6JSHn7HzDIHCqwBVuksrX/W4PUNmN2qKMXN8KGHEu8TWJsW6npwQWQ
 C0Y4y7YTgnNiwZ5qPmsRLyh07vN1gqUnQJ5P1WjP9+2EOrpUYrSIgQRByBFskNBdpUuzwB9bfBb
 vTIwNi1oAZaCBB8R9WFkMHbTwsWqOiQ9mWRl3IlL8tJxpWxk3aYX6NaVu1dw7pzFFb+Y+yRqHvT
 gwqMCpwrc9n2XfQA7/B46IW7aj7eMjOEY5U1W4cCehVXoqpN9i6obuaw0tl6EAd3EFu7bjeh0uj
 OJtVrlGljoOlcXsmQ==
X-Received: by 2002:a05:6a00:138c:b0:869:31b1:4ce3 with SMTP id
 d2e1a72fcca58-87089e0a240mr10091118b3a.9.1789564329162; 
 Wed, 16 Sep 2026 06:12:09 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-872025dd04csm1224882b3a.60.2026.09.16.06.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:08 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org
Subject: [PATCH v2 1/3] net/txgbe: fix L2 tunnel error on flow create
Date: Wed, 16 Sep 2026 21:11:03 +0800
Message-ID: <20260916131106.105667-2-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916131106.105667-1-zhtfdev@gmail.com>
References: <20260915152436.67378-1-zhtfdev@gmail.com>
 <20260916131106.105667-1-zhtfdev@gmail.com>
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

txgbe_flow_create() continues to RSS parsing when L2 tunnel filter
add fails. An E-tag VF/PF rule cannot match RSS, so the original
error is overwritten.

Return immediately on L2 add failure, same as ntuple, ethertype and
SYN.

Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index eaeb973c91..76191a7c2d 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3449,6 +3449,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
 			return flow;
 		}
+		goto out;
 	}
 
 	memset(&rss_conf, 0, sizeof(struct txgbe_rte_flow_rss_conf));
-- 
2.53.0

