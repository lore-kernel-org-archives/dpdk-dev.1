Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B243F01832
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 13:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6381F41153;
	Fri,  6 Mar 2026 14:30:54 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id B0FF441143
 for <dev@dpdk.org>; Fri,  6 Mar 2026 14:30:52 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so58367255e9.0
 for <dev@dpdk.org>; Fri, 06 Mar 2026 05:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772803852; x=1773408652; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRPH6vpFoQVJz5/wx2skp5qzpIe9crg1cbFFpYMoAFE=;
 b=SFxVxet4YQ//UPDD6Gyc37El4r2s7GHqZvHswRKg7QGX7sIFJdYAx3Q7vFuGfHZJaj
 dh0PBMEuhO3Oa8H1elI3USArXdmpQCbhRJu3HM+qyk7BrM0Z8N14WIGZjUSp9UiMqlox
 0JWOdvzJPjg4X0L//9RabA/GZeDYjHMe9/fX1NkNEDsQNKOF8qa2LU1tzrDVNavqRJyj
 6wquNBoX0g78sMyxcJxyaB3qpZaxgsc/ECg91lBrJ6IpP7iOlQharIrJvynmJFN7fXu4
 UEafgAR9ZF2rxx5smpjhDvje4ne0E788wT6vc4uAtUI3m2Wkbr53D/yqgJCdBJZ3/Ll5
 70CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803852; x=1773408652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KRPH6vpFoQVJz5/wx2skp5qzpIe9crg1cbFFpYMoAFE=;
 b=GF3AR5SslvdI2Z9lDSIB1WwB+VgMjGxxzejeMaDaj7YtDX0n9wtJNrM8nwbEoaIYmQ
 XE3nrvUzQQGfSpv19yc1gqDCcmk1YNAsZuUurvtkIya1Vwyutf3H02QIUVZfMpIrSLoL
 juVs0FniOadne1JXbhsv8snQzpNA3zq4j5OEV6PN29364amLf5u3YZfk8IL2zYq3zrgs
 MiiPka7W3GVUevdJhOQRmgiSdDqjOu2SLbTiwjKSMz7VTnyfTOHhWrFt9eHI1XYNzp4p
 r5u0bazWDPNvk/RTkbKHgU1+HdJkX3377NOOMDSgqdmfZ8L2SEz2TJ55UTT/XWJksuhD
 GTKg==
X-Gm-Message-State: AOJu0Yw/84OBzGdZBrkiVqy3c0LAQGgvzGLMN6KrEOZtrcSFJ41grP2Y
 NAsmFKAMJbgQ9ueFc3RJ+DZI3Z5x/E6c9x9AkmZKWDwPUZg7D/VWuBVgWEwI4XGD
X-Gm-Gg: ATEYQzx6HkXvt0LHtcX3yAuUL3/J6Css9lQj3AbtIS5M6M9XLLZ4ykOT7IDbu3aGkQr
 npgflRZ2e7zgh0vbEZ0v0uvFvZ46qT1s5jleQ1YDsDVI/gQLIMjdtNMY70xRdxtE0Ls1lWZdwl3
 FsDgdMri2zF9jX8fxHqjtTx/Cgul2uGKiOU23k7PcaUVOlPIrfANoyoNG035AbgzvKJu9NXo2NH
 pqPX4/aD3JDvj7tQLokmrZDu0m1T321jvs5qpo6cfvLiapPuIj+0RQ94jzAvhXOmTK0Ki79gjZy
 azPm2rLAYL6gWzso4fVdSQ8dXjJij0/ymUBp2yL2sV8f4IlRPh9KzayyTyppvhFfLBxKlP13+lY
 40PIoKHqXJFZT/xIetHvYgbHb/zKHCDrIUjypETPY5BWC+8KYrIbe/5KnTK7ajxyYb/wZ6pi8me
 xmrmkQGLnNH/MB0uzhcjnuyVShmShBEvPKYoSazw==
X-Received: by 2002:a05:600c:c87:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-485268bd533mr37791265e9.0.1772803851941; 
 Fri, 06 Mar 2026 05:30:51 -0800 (PST)
Received: from freepad.iliad.local ([213.36.9.102])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527648a19sm35837055e9.0.2026.03.06.05.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 05:30:51 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stephen@networkplumber.org,
 david.marchand@redhat.com, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org
Subject: [PATCH v3 04/17] net/dpaa2: fix resource leak on softparser failure
Date: Fri,  6 Mar 2026 14:30:22 +0100
Message-ID: <20260306133035.179709-5-maxime@leroys.fr>
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

When soft parser loading or enabling fails during probe, the error
path returns directly instead of going through the init_err label.
This skips dpaa2_dev_close() and leaks all resources allocated during
probe (queues, MAC addresses, extract params).

Fixes: 72ec7a678e70 ("net/dpaa2: add soft parser driver")
Cc: stable@dpdk.org

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 61dcfafff6..3658e24dd2 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3164,7 +3164,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		if (ret < 0) {
 			DPAA2_PMD_ERR(" Error(%d) in loading softparser",
 				      ret);
-			return ret;
+			goto init_err;
 		}
 
 		ret = dpaa2_eth_enable_wriop_soft_parser(priv,
@@ -3172,7 +3172,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		if (ret < 0) {
 			DPAA2_PMD_ERR(" Error(%d) in enabling softparser",
 				      ret);
-			return ret;
+			goto init_err;
 		}
 	}
 
-- 
2.43.0

