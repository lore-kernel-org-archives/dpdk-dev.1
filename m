Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DABE9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 16:43:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FB1940657;
	Wed, 18 Feb 2026 17:43:35 +0100 (CET)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id 8493940661
 for <dev@dpdk.org>; Wed, 18 Feb 2026 17:43:31 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d4c65d744cso37143a34.3
 for <dev@dpdk.org>; Wed, 18 Feb 2026 08:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771433011;
 x=1772037811; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0sghJ6J2LwmBzBXgoQIXapkbZstMz1H2wXU0UYSpE4=;
 b=z3a64Uc42AJ/SDItlS+3Ngwg33g5CXHuhSxznEkv4TsUkxVGue2bh72azoBHNFjv/u
 BggCRhpQ0Pt1DBYD2GSDgwil3ZeJf42g9AiGxqmqQSxLkOwBRf85f+tTVtzNfMkEylYV
 575+2XQ0zQTiZH7K96fX3K79dsLGSxw98xw07eyMNwdTvM+65Iufhts21VCQ+Ue+3kya
 BJOFe20YHcc0PVak1Ld5dr83554+a7AhcCTT4hMpL+PAsL/netiKNU3tFYOwsP7yjr5s
 /UPojrdAGEHsVCM6vhx6OIOwfTXZBuZz+bkuBa8uCXT3hUwNBpSrQJCVzWHU4QILS5Jt
 BeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771433011; x=1772037811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o0sghJ6J2LwmBzBXgoQIXapkbZstMz1H2wXU0UYSpE4=;
 b=R1P7623XKuizowvwPaWciCvXyD9bWso6af+N7x/IbaUsb0MYkFHZ2ll+s7SbaJUW5Y
 TafX5kYvR5dWEucQF1sAhSKfY7bSu7e358/Cy/Md8FXO3OL7zQ6Cg0zg5SKsx06tzD7y
 B1rEe8JO42ew9qK1oYE0YYNXOz3M7kjQaw0ImA1QR4oXvYCTE4WStCid9fXBg016ytnH
 iWR7e4h8LlV8PHN4dmJL/i32nJohhrO6sAc/Aoc5DPT1ZfKGcj+5R8641pjYmFqasnav
 Qkge4e65vykTlhmzWjOf+UYrYfSdA722lXbDBtl8gsJyH7c0c72y6j2fQN6H395hF4PV
 R6RQ==
X-Gm-Message-State: AOJu0YzPDmguRc+/emqADY7JKTes5dB/jZqAvWAwYUjstmZhYRL/N4ns
 DFm/eU037v9kynh1HOq6gLJg0lK74yyR8dqHMM5n7Z1bVAyFtj4Aly6HzrN7X70PG8+7uEnJpmc
 NTNir
X-Gm-Gg: AZuq6aJKsqtOAqzUWmNpCWwaP4RxUo3FeGnXn0/ck11sPXxg/eD7R6QgIF52CCDwH5L
 EkyqTWOYFg9P5N3J+Vj6OK8NloqlJyaKFFrDg95Ey4QqJDE4olYhbr/UGH3XgR5HeUEJRqofzHc
 rsEV/yhM7iRDHRPHvyqck4CaPyQ8jiOJcdz82TimJgp8B0JG0O05rwKdJH0ICEcOyR0SDbl7A+X
 fmy43VQVnBtYLVmU1REGIz5TyoLZGdHXKNUcJ36KJGe/4nYEUPYC14n4m9mzT33BU7ymkgsCsur
 3dcF6y9xyIWwdim1gT8MWuYOCGQyCJ9VilkolkpLLxz3Yax8+es0jKOVlCsCwO8pxV2wkKj+pnx
 cCdQGG5/hOOKDJLXCv1pdMSVH8FPhTDkexpgmE/I/nBk4SY77d6g0CO0uDdcBjgOLeiVlbR4Gdk
 sfKG0SK7vWg0xGC60jRMZn5SC7hoQOohgeMKD4zVCwJpoJx3U8RtYAVI1cGU+BIw==
X-Received: by 2002:a05:6830:67d7:b0:7cf:d213:7ecf with SMTP id
 46e09a7af769-7d505e38fddmr1330891a34.32.1771433010751; 
 Wed, 18 Feb 2026 08:43:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4c6727752sm12878313a34.23.2026.02.18.08.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 08:43:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Selwin Sebastian <selwin.sebastian@amd.com>
Subject: [PATCH 3/4] net/axgbe: destroy mutexes on device close
Date: Wed, 18 Feb 2026 08:41:01 -0800
Message-ID: <20260218164324.915065-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218164324.915065-1-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
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

Four pthread mutexes (xpcs_mutex, i2c_mutex, an_mutex, phy_mutex)
are initialized in eth_axgbe_dev_init() but never destroyed in
axgbe_dev_close(). This leaks kernel resources on every device
close/reopen cycle.

Add pthread_mutex_destroy() calls to the close path.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 709a52acc8..c8414998b4 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -2482,6 +2482,11 @@ axgbe_dev_close(struct rte_eth_dev *eth_dev)
 	/* Disable all interrupts in the hardware */
 	XP_IOWRITE(pdata, XP_INT_EN, 0x0);
 
+	pthread_mutex_destroy(&pdata->xpcs_mutex);
+	pthread_mutex_destroy(&pdata->i2c_mutex);
+	pthread_mutex_destroy(&pdata->an_mutex);
+	pthread_mutex_destroy(&pdata->phy_mutex);
+
 	return 0;
 }
 
-- 
2.51.0

