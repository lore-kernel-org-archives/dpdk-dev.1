Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A87BF01837
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:32:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E95A4427C6;
	Fri,  6 Mar 2026 14:31:18 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id EC2DA427BF
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:31:17 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso80364675e9.3
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803877; x=1773408677; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78DYjsmaT1ZurMg5DZkZddBJF7SyjyIMpEbp6it0up0=;
 b=RFYr3SAwA3CeuL6ceO43hg2dZTw1zkoxdNFoahu89YXTiyxZO2YA1aqgRB1aJE9cuC
 N2JWDyAV9evVWaDwBmSxftGKvVOGC3nwqDt15pP13c+cyxg9XIjeOXsbunSMnbQjRj/5
 itYokekN1H1nBRAmqyGJLnLjpMGV/8360YvfxtOWXVdA9zjPFoOaWODWV7IA98mgXFyC
 hIW+hNakQKxdOipJe15Fyhx+yahOv1FEttKqMImHTYxNG4/kgFY5IHOEnlMSGcJab9lv
 vWKRYKFL+mMvfT2MZvhwO7iDWX2gLKXaBewjng8vK2kMkBLkNcIh+xdVu/vd9p3fZT/T
 0l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803877; x=1773408677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=78DYjsmaT1ZurMg5DZkZddBJF7SyjyIMpEbp6it0up0=;
 b=RzMl/Qsf7x/Icx3wGOO9bF+bb+QjbJtC5naGlU0eDlmsaIkAvbzGZXiWCQv5gR6w5S
 gQZY2aZlg+WHkhpPyGS8oSkzP4dUdcn1Hq4Umh12AbKpeD38tEZSnK/wkgFNzFYsnUFv
 /pliWa+eg0Q4xdxfMlDQ+HfiiEuMZzZDO3qa0+4632MlWRdHBkRrtb3KkmX3ufzU3VFK
 qhgXwrrFVtwA6q0+f6EAMA4Mg1p3aFrmvM9EVakvvBtmP3xB8Ny5N1mVo1KZi2TiAxPL
 whckK5O2Gplni+1244NNFonhPw5n2bMOE19HEurdOaxsh0ErX3D7Gm5D94n/5MiCytwH
 RHsA==
X-Gm-Message-State: AOJu0Yz1hZ0tNR5/i6SAD4F9UX3a12Sqw3DBFZh5eOU9QULUf2Fojf+D
 Tf2fpvl6Id+al+0BAyFsW2bMg09ViZGY9RbKMZyxsBtChU0rfBNHXkhE8Ede6oXj
X-Gm-Gg: ATEYQzwZzkQZa3Snwz43xnAz7JtUUCwdi6U5Dl7jp5z6QRBjD4YT4tBYTmFB1itCdtR
 Z+WUxSH5vjD2+xaMuvEBWjUiUph5liAewxc3iGOmM5P2s8dC0NaavKCck/3he6znfR+UNRIf8Tz
 ymHaXTXBWZth9hU49I/KbSm1uIMW9uz+dTC5ELuZ5clih3nOw9pJfl51wso2unN/fOKiUXtuDoX
 POWvIIzPqxEN59Tgttdch0ACNUHNc7shdMFhwR8iy0F0U5dMd8vD7NF63JScAuHilD0J8ePlz/T
 iOLWGDUxanzRAURoMtRda/UT3WPxRf1KF+rbd3xrIESxCE/LyTWH7s+LpSpVdylskG3z/1VqF5O
 tIRz66bp4TcwylTjpE0Z1RS1Hq/Wdgq1F/t2F5ODe/RR/wXl3MWV6qvZOLV4lE+X05oTCnHzeUu
 bFAR41xZrCHVWwSUmlC3U59z3PMls=
X-Received: by 2002:a05:600c:1e2a:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-4852695d227mr31383685e9.25.1772803877418; 
 Fri, 06 Mar 2026 05:31:17 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae538bsm155399705e9.7.2026.03.06.05.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:31:16 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>
Subject: [PATCH v3 15/17] net/dpaa2: use check interval macro in link down path
Date: Fri,  6 Mar 2026 14:30:33 +0100
Message-ID: <20260306133035.179709-16-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226143341.282188-1-maxime@leroys.fr>
References: <20260226143341.282188-1-maxime@leroys.fr>
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

Replace hardcoded rte_delay_us(100 * 1000) with
rte_delay_ms(CHECK_INTERVAL) for consistency with the rest of the
driver.

No functional change.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index d5e30ce5fb..a70e6895c8 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2305,7 +2305,7 @@ dpaa2_dev_set_link_down(struct rte_eth_dev *dev)
 		}
 		if (dpni_enabled)
 			/* Allow the MC some slack */
-			rte_delay_us(100 * 1000);
+			rte_delay_ms(CHECK_INTERVAL);
 	} while (dpni_enabled && --retries);
 
 	if (!retries) {
-- 
2.43.0

