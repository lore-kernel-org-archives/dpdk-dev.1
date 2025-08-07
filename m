Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A1C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 11:06:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A47C402E8;
	Thu,  7 Aug 2025 13:06:56 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id DA4D6402E0
 for <dev@dpdk.org>; Thu,  7 Aug 2025 13:06:54 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2401b855635so5927885ad.2
 for <dev@dpdk.org>; Thu, 07 Aug 2025 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754564814;
 x=1755169614; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZdYIBd5XkZ6XJiTMyLbJtsRL2ZRhP332XVR+wbiPrY=;
 b=NHLah3OtVbEvuE3MR0lne53BLXF5I0ZCcXH8ZQ+JorH3iqsOeoc7nJ3KGW3WJ1vAfk
 kDZ9oHacyEl6GQ4ja3F/tMd9JEDxGgdm22FNiidfIUzbwnaOSutH5p1v7KqXQB3l7Pwa
 a7dmKYhTLXtrwqvCA+kfB8/ryakqIGAW83H1ghvzO+J5X7RumOhqOojsUF94gXhCi0/7
 nId/QxyVoA3rP4BzgDgNkVunx0NpdfXbvPobPUt4UyZmdfHJYvrnS9qrH8Me4jiKLQyk
 b1ISjWe7bn+BSbNz5GyqA/PmLl7sXUbXIiZKOlN+zSUojzD5C6IS37tueMf3KDrVivRO
 aQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754564814; x=1755169614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZdYIBd5XkZ6XJiTMyLbJtsRL2ZRhP332XVR+wbiPrY=;
 b=DwbHr/Nt2hJe8HMQviozcsRzh4RS5U64cTomQuuCKSnjnRHYbBSQWwHPs020VAjwm5
 nT5j2CjtIIMSKdCQ3LEoCgDSdmND5wP1GO7fIJt0WheXgOUBuefK+rSUO3P+p69ZtCPQ
 l0FklH6xTzAjjgbsfhbs2stzFgspxDP/xBasSPko8Plxass1FZW0nzuQD362GBG6ZxQv
 6egeqCNu1V4JGAy5U/98t/p7uQPpYB22iGzmdbUI/EB6ds+WCzitbKM+mXLWJBiKzxIV
 EEIRUiXcL/ZhXWKWt2RzojaYiZFCZnyK4nHDJxP09Q9EAxmu07SA/ouA79IxC1RUV4d3
 0CcQ==
X-Gm-Message-State: AOJu0YxxtDi1nEtUobhYpEDwgctN2TfL2I2guleX8D5zzsqdY55L/oi+
 okBda4DtBduq2nilOhen+MQ/xqdYMpfVDArqCbDs6y/HNEPQ4EXfwkTqvhgpcBNRmVg=
X-Gm-Gg: ASbGncug7+b9/uwTL5H8ORkILRNl04RyeGT8RmffcS+5lU4BXwLOr+kEyF+P+SYh/iE
 bcZGSgbt0VcNwt1jOVu+g4koEPdyTffd95TxT0mETUFcl4BvSP8zDQ8Aw8c+rFb+OJjCctoIkga
 vCK9XHkvpj6LUZwfn4QFuUlG2JNyLhH1zyDqCBddSGvujt2RkBpr7gaAGCcROjAjtBtkJTZUglI
 MCfBGOgb74iF+diq9kY7GVsoXOjKcVHAIAT8bOh9uZTMy3THgw8vQxH8My9uhOrTTvhhL0cpNOR
 XGRLi1ecaPozRJdMbnl3b9ihu3h9B7YEUsxC+Lx/sUfP2ag96Vgg0XsOhuQw9obdYxhImGsqvVC
 zkHccZRErE9aWqpg5cRfsBsBeUNzbNcyWw0kCdEdgtsdCOMhF
X-Google-Smtp-Source: AGHT+IEya7BRxTJhrIaBCm4Q6ScnxnFNHHQOQkdAf3Wy6TYMz4v+wMrhXpayhwszCr1z45gKLL3grQ==
X-Received: by 2002:a17:902:e783:b0:240:49e8:1d3c with SMTP id
 d9443c01a7336-2429f51cd7emr91577575ad.35.1754564813864; 
 Thu, 07 Aug 2025 04:06:53 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef674bsm181668055ad.17.2025.08.07.04.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 04:06:53 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] app/graph: fix overrun error (destination buffer too small)
Date: Thu,  7 Aug 2025 07:06:40 -0400
Message-ID: <20250807110640.1094029-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
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

Some memory locations will be written with incorrect values,
possibly corrupting data structures or data integrity.
Size of destination buffer is smaller than the size
argument specified.

Coverity issue: 415430
Fixes: 3850cb06ab9c ('app/graph: add ethdev commands')
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/graph/ethdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/graph/ethdev.c b/app/graph/ethdev.c
index 2f4cf65c96..f6d4bce9ab 100644
--- a/app/graph/ethdev.c
+++ b/app/graph/ethdev.c
@@ -663,11 +663,12 @@ cmd_ethdev_parsed(void *parsed_result, __rte_unused struct cmdline *cl, void *da
 	struct cmd_ethdev_result *res = parsed_result;
 	struct ethdev_config config;
 	int rc;
-
+	size_t len;
 	memset(&config, 0, sizeof(struct ethdev_config));
 	config.rx.n_queues = res->nb_rxq;
 	config.rx.queue_size = ETHDEV_RX_DESC_DEFAULT;
-	memcpy(config.rx.mempool_name, res->mempool, strlen(res->mempool));
+	len = strnlen(res->mempool, sizeof(config.rx.mempool_name));
+	memcpy(config.rx.mempool_name, res->mempool, len);
 
 	config.tx.n_queues = res->nb_txq;
 	config.tx.queue_size = ETHDEV_TX_DESC_DEFAULT;
-- 
2.43.0

