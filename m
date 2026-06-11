Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E189CD98C7
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:50:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBB224335A;
	Thu, 11 Jun 2026 17:50:26 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 431C243357
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:50:26 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-45eeea039ebso4456925f8f.1
 for <dev@dpdk.org>; Thu, 11 Jun 2026 08:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781193026; x=1781797826; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9Tqydf0WP7QPy6fGrWKmAsnklX5h4vMU7DNZLmLHyE=;
 b=XEys27ImRKWgk7nmu17ZVf97+sNtNphY73mI45Bne+MP3xFrl1SvDCO6zcOidhRjSO
 aqu17JB46OVYFmSaBbG8B7tSpUJYD2HJBJvXSGQ+JIMuJIC2D2SuSbjGcCzfGHxzi01s
 0YHnWogf9ruoF3fnmWm+7t65XZJJ7e8QayYx6LUxKt5dE/HAWv6LzruWQN0XGpudDm42
 iT9UIImlNK/Sg47Z0HnW8WTAHj4+mflhSrCFNoVhnUf3bvMPVn/vZbUy3l1Nc+vnL1Xz
 nWCSg4rmES0kZRpxs+WVR9MgDEsvql9fTMMKVV1zFtoTxLn3MXLXsZlqXe/UeXouQpAK
 jQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781193026; x=1781797826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n9Tqydf0WP7QPy6fGrWKmAsnklX5h4vMU7DNZLmLHyE=;
 b=GU1kDXH/88yTrTpL3NNW0wUtVMo8GE1Z/Ne29TNG7nIv9KtYGgEFzmayamdGKOHcY3
 uHuRDaABh4QIlixFIX5Y5ZakxWDDTArZWN77w58yAWmvY2/uS1/UfJQNEBHI17OoxvOU
 tb+Mmh0oxsv6ZXb62re6KYoG7f/0EscpUDnBU/z1TxNiO3VD+8iDPKEsaOUx7DBGJufD
 9qbl3F+6wSXibBxfp8QouPSlSWuCuHZhK9QFGnkOjchg1B7k5QL928zttcnQ3o1igvo1
 7whafeaetPhchAJ+uQ9cJKy4rnTPu+GTkIu4O0XunFX5+c0lWIq/ZzC9JWB7cGhXkq4f
 2fig==
X-Gm-Message-State: AOJu0YzD5GHx9o+0WSDBiOjhLUtd5s5VwwR6NuqB5SGlFvuzEZ6OEXHm
 aNSdWg7su6EqIpKjIZY8D8W6A4QMNRPJc/UHoCMIn3iQxblowAKhrRmDeBxP6mgI
X-Gm-Gg: Acq92OH8vvmFSdAsizojSEAUNJT9uW/g8d+TgGAFS1KRl/Hwe7z1eEoes+fitRz9LBv
 HsSgQbTxgNH5IXOazTRgGh9MEv5XzVWE9XvWRN5txr4ZeYcnuBurRXyFAwoubu9xpVcZtXrTJDO
 yjXiQglnzNTDh7Q9sok/4m3bOGNX/IPKqbiPdxMqeucJse2KnH5mNdbTfW2Vp1/otO+EpSeuBY0
 0yat+rlk/LFf52Wqke7oS2VceejC5ZlAsVtYCAibyYhDV9BJqU6qrhtGQT4+BJ3xdKIMSLxihct
 xxGCorDI/PGXnUovhCaGkzjRa/dPP1E22cuSaHciqongyNSU5BVbK9AyK4NZzR7xB0Dasf8XFmw
 hsIgtYkR7WszKkufXXWIXre3gPtwLYIH5G8G35mvQDeoQyrpKIDvtfwNJ0B+hGRrwatrmKk5mY9
 hucd8gCILG0TKqSsfEw21NjwD6wrUIL1tJMSt6o8HtPoJNwuFtWRMWJNdgj5YdeMI=
X-Received: by 2002:a5d:584a:0:b0:45f:f142:d56f with SMTP id
 ffacd0b85a97d-460675835b7mr5466668f8f.12.1781193025825; 
 Thu, 11 Jun 2026 08:50:25 -0700 (PDT)
Received: from freepad.iliad.local (free-mobile.vlq16.iliad.fr. [213.36.7.11])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35133csm78844890f8f.25.2026.06.11.08.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 08:50:25 -0700 (PDT)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: hemant.agrawal@nxp.com,
	sachin.saxena@nxp.com
Cc: dev@dpdk.org, Maxime Leroy <maxime@leroys.fr>, stable@dpdk.org,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH 7/9] net/dpaa2: fix Rx queue count for primary process
Date: Thu, 11 Jun 2026 17:49:22 +0200
Message-ID: <20260611154926.392670-8-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611154926.392670-1-maxime@leroys.fr>
References: <20260611154926.392670-1-maxime@leroys.fr>
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

The rx_queue_count callback was only assigned on the secondary process
path of dpaa2_dev_init(), leaving eth_dev->rx_queue_count NULL for the
primary process. The fast-path rte_eth_rx_queue_count() performs an
unguarded indirect call in non-debug builds, so invoking it on a
primary-process dpaa2 port dereferences a NULL function pointer and
crashes.

Assign the callback once before the process-type split so both the
primary and secondary paths set it.

Fixes: cbfc6111b557 ("ethdev: move inline device operations")
Cc: stable@dpdk.org
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 7ca454eaae..fb117e761f 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3617,6 +3617,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	eth_dev->dev_ops = &dpaa2_ethdev_ops;
+	eth_dev->rx_queue_count = dpaa2_dev_rx_queue_count;
 
 	if (dpaa2_get_devargs(dev->devargs, DRIVER_LOOPBACK_MODE)) {
 		eth_dev->rx_pkt_burst = dpaa2_dev_loopback_rx;
-- 
2.43.0

