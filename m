Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43F7EED632
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Jan 2026 18:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08249402D5;
	Thu,  1 Jan 2026 19:13:57 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id A35A4402D3
 for <dev@dpdk.org>; Thu,  1 Jan 2026 19:13:55 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so123568855e9.2
 for <dev@dpdk.org>; Thu, 01 Jan 2026 10:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767291235;
 x=1767896035; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zKJYMGxHkbborOnAxf6NesmDRa2JYh6o3PqJH5AnDXc=;
 b=PGDAU8bldDlE/D7gx5XyDWZb3zX+fVlpeHv7bvnEkLrUCAoEog9rb0yE3M8v+Bu3dM
 T7tVNlD6u5DG8hUPrLjaEHdPCVjb23ncG5X4waXM/u2igiB47FCDGo1oLAajKzwrO9Hf
 97Ga4JDfqpXV2aVeYaC81OtAB4Jv8YklCifhZ/OehoKtS2vieaG1yW4Rwt2teWzZuCnP
 bAo7Cuw9e/ACU4hJZz0iE995ByBO7ssijjxLGEhxC+5nQ2JjYYNED5yXjqnAT89Cxisd
 YFEgn7vIgxPrOxHm/Yid8J1Xykru/z1Do2hhg7iRYI3ncyQfx0QTds97jy0zLVmKgWLl
 U5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767291235; x=1767896035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zKJYMGxHkbborOnAxf6NesmDRa2JYh6o3PqJH5AnDXc=;
 b=Q1EufRxRBLq1MewXYISfhmnrdNdK2X/ObeGX8PhiRPUBqxkRRDRLSt5q4rTrbmwuoJ
 h7UWmjUGL/PtPjLyrUMnoUw95WenlcegazZrOFH4UFn/hPkx3xXZkji2qx1Nz8+7Rhkf
 zsRT75UcqnL1qS+liB0deiU/FpdsvzposJWJQPtXiFDwXbZo42TQbsykt/1Ez1N4yeYr
 ETzARbvaLYSOIr3/ggvOW7iauteuUF8tvHysOMnPcNc9lsN9gCvP57AJ4dx2ad+dYc1y
 xqb6LLUEKndACP+iBtpeGatbciT6ylwTyEmAabJ68DudWpK0nESDA18r2FS1TO9dg3wl
 Oajg==
X-Gm-Message-State: AOJu0YyvVkaJHGter+86N69oCCPfM0Z9mIFlN60A4G/185LSqphXBDCa
 e+TsR1ljNothv5Y6k1TmxHVDIowHseNE3l5dVfXQ029sHLrreLHLUN9bRtFKlcUMJ/r5/03XEKY
 5RZ/TUwc=
X-Gm-Gg: AY/fxX7CAP+8BxBg9FkEC1I72Kx4+lQmGnvZCu8gSRJV63ao3Ss/ZdVgofDmoQXcnKi
 XXiF7Nhs+/RDnEjBc+Ce2EIfunKSkkWTWbBW5ZeBgbxhMmGFAh/JzZMFNTuAxSJsnKGbTOPeIwk
 0/iyLQtob7UQQ/P53sKW9HdTjcvTGGXoL91SbC3ugB/0HY0+gZWnVRZlPdUVNswPR4szTE0rOXj
 fNB1cQpBQBSb6qjrMRZSb/eOT6YZ5QCqi/EXAIGTvARgUvIFPlbXtuYuuL4m8zCqirNDcXa4HBY
 3iSwQ84YFIMZnJkUpaArjleWGXNXY1BuBapHwk9rBxc0QKIDu3PA3O+POyJ6tP5eKHfpuBESFRQ
 FZIKncLent3bfNpO0EfPjC79ukhVc9LN+BQbAcKeiKSHaJM5sMWIy573oYy4TD9cGFAJVQ61+bW
 NaSDNE/CuUe9wmRLGyj8sY2X8oMfUy3Ko7bqLr90PKzaBS1HcBiQ==
X-Google-Smtp-Source: AGHT+IENMiV7Gvh5Tu+jweLdgEWVGUUUMnTSbuZ164NDASdXRWfWWVErYyqcVRlAAucSvqdU5nSGHg==
X-Received: by 2002:a05:600c:4f4a:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-47d1953b79dmr543352015e9.4.1767291235136; 
 Thu, 01 Jan 2026 10:13:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43264613923sm65738005f8f.26.2026.01.01.10.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jan 2026 10:13:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "John W. Linville" <linville@tuxdriver.com>
Subject: [PATCH 2/2] net/af_packet: remove unused attribute
Date: Thu,  1 Jan 2026 10:13:44 -0800
Message-ID: <20260101181345.201601-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260101181345.201601-1-stephen@networkplumber.org>
References: <20260101181345.201601-1-stephen@networkplumber.org>
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

The device configure callback does use the device argument.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ef11b8fb6b..c0ba3381ea 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -374,7 +374,7 @@ eth_dev_stop(struct rte_eth_dev *dev)
 }
 
 static int
-eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
+eth_dev_configure(struct rte_eth_dev *dev)
 {
 	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
-- 
2.51.0

