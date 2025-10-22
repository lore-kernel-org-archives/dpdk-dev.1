Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C610CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 13:32:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1D734029D;
	Wed, 22 Oct 2025 15:32:49 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 686B04025D
 for <dev@dpdk.org>; Wed, 22 Oct 2025 15:32:48 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-782bfd0a977so5095554b3a.3
 for <dev@dpdk.org>; Wed, 22 Oct 2025 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761139967; x=1761744767; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wEyte0nOF4Xh9c7ES3RPQa2L1UQt/wIOWrjQvo7AuI=;
 b=djeiHvkmItDvcRu8KhMqK9OFscw7e/iXlpM5HfXrZ+MSFqGpja4DJTKJEkuF/Rz+pG
 iZh/Rl/yu5vwcVnuYmQl8Zb5sMgPP5axlzWsn4qhrMpVYckHy6gabUlTQtnroK5HoNrF
 LHKHSHOTIvKTdRwiOunc+x3/YHmD3nBLZ6SdY2Ie4G2aX4vBQ/DbTB3De4XZ+zY9ttZL
 F66BSxmY57q7WOXxEc5XcgGhEgiFxUg8JxEZoryA0zppA868ts+0uDTwAfwD8u7usLdf
 VTsSgJ4V7yu3RRpEFQj/zZcjt0JxnHIpujeeK3meJfZQD/MPkC+cr0aNOyVd3+7Uj2tB
 QJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761139967; x=1761744767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wEyte0nOF4Xh9c7ES3RPQa2L1UQt/wIOWrjQvo7AuI=;
 b=mOTsdr+i76FiyYeGy1l2rxazhJVYJ22vAj14xlFMmSXYIpXm+oDf/L/18Y50LwJxEs
 UvUXjTwp8OqY+4EX4Q+yx0ifXO/J+GQKcuK+s35PyhhhoXGWBcOlunwZgrWQkOcOvr0l
 oWOpL53f7TkxLN15LoUBwEzRdVLe+o/8IQAJqOEDwkUqRbdw5xCbG4U7ft/ePOFmpnwa
 23BB4sbTJPvxPef6toCXHS/s2D9Yzmd3s6tEwtTaOyvZOs25IbWzyShIhLNAtmOQlIQ6
 xfW57B0PlhqFEfA/5MauqDB/b2hWRAGvuoTiKyj3KWifIHfy4KaGybU6v6IrcBv4qnir
 Gq3Q==
X-Gm-Message-State: AOJu0YwYMznTDVy2putWTib/gkE+EbqxN0fIKFHXNAZFLsZY2lM1Evkj
 BnHz4fKF3zVhQxQ7WMSxXMfSI/elSojQhFom22qVtdbDvM09HF1UzCqo2YffXQ==
X-Gm-Gg: ASbGnctdbbNwEmK3EBziT7CAKod4eTBwoF6sIwkr1jvrmPV+mk4RZIbwh+C+A87gC2K
 lL/81fH5QQz5A5dw5399sX7nbvMIs9SPTzUvogz7rLrSmW4z/jOFXY01XzYGvkMCgKhCbjiNwGE
 z5PhbKuobCRhGB95PAsvoI87mcVIplSH5KgIfyO+K1YCa2m++iaPmhHo6r+GiPWeXxIFq8nwxVe
 ycIDXrQ1FqCMSF/BqlpldYDZ0vHEzRntvtpmQZM6H/QeNGJlZlWEoPWSXMv2CRz4eI6vAnMpmK0
 3EEXZ015NRmfOvq2iu6iBpeO1ULbkMwurfoeZ9ClVw9MDaPPW7p2WORJ6Wk2+OQgzPkN0ldEAAH
 XYkabk2zRz8Z9Ssc2ONF+5JmN9ff2nmzr0A6RF9l2bsIe8MfIe/NItq8cKdN74af9MDWo/80PFE
 mLQ6yjw0Qt2Kbic1e9gLZ1/snyh+QTbHf5jPTluQi72bbxr9Njy8Ycb174hfP/PDWXaPrh
X-Google-Smtp-Source: AGHT+IGh5riGfMMdnM9cj1d1gVzeRbjtdZwO7lMoLRf3/TKXJhh7U2Dxy57rG+18IGF0hWoNFVUbhA==
X-Received: by 2002:a05:6a00:99a:b0:781:802:45b7 with SMTP id
 d2e1a72fcca58-7a220a5836dmr25174896b3a.12.1761139966853; 
 Wed, 22 Oct 2025 06:32:46 -0700 (PDT)
Received: from amiya73TMT9m.aristanetworks.com
 ([2402:e280:2162:53:50bb:5301:cacd:1307])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a26ba99366sm1374432b3a.55.2025.10.22.06.32.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Oct 2025 06:32:45 -0700 (PDT)
From: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
To: dev@dpdk.org
Cc: amiyaranjan.mohakud@gmail.com,
	stable@dpdk.org
Subject: [PATCH] net/vmxnet3: disable RSS for single queue configuration for
 ESX8.0+ versions
Date: Wed, 22 Oct 2025 19:02:32 +0530
Message-Id: <20251022133232.6896-1-amiyaranjan.mohakud@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251022125844.6187-1-amiyaranjan.mohakud@gmail.com>
References: <20251022125844.6187-1-amiyaranjan.mohakud@gmail.com>
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

It fixes the issue of v4 RSS configuration failure in
vmxnet3_v4_rss_configure() whilw writing to BAR register. It's very
specific to single queue configuration.

https://mails.dpdk.org/archives/users/2025-April/008236.html

Bugzilla ID:1789
Cc: stable@dpdk.org

Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
---
 drivers/net/vmxnet3/vmxnet3_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index f4cdb1bb31..3c0ddba80c 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -534,6 +534,12 @@ vmxnet3_dev_configure(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	/* Disabling RSS for single queue pair */
+	if (dev->data->nb_rx_queues == 1) {
+		dev->data->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_NONE;
+		PMD_INIT_LOG(ERR, "WARN: Disabling RSS for single Rx queue");
+	}
+
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
 		dev->data->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 
-- 
2.39.5 (Apple Git-154)

