Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5171FC021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:57:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D55F940616;
	Thu, 20 Feb 2025 17:57:11 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id BB2E0402ED
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:07 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-220d601886fso18504235ad.1
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070627;
 x=1740675427; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bn/J6b8F3kE/tw0cvtq20PM+X9pVfJDhgLgx/D+6yyo=;
 b=VZUI5S+osZybtYUrgnznEJmvUmxAgf9mshjXi0Hqfsd3hmaD7Yj3VKuwVEuCN9wm4Q
 Va7qCvHfuU1Gs0Bun85OSA1Sa7SaxzVYWTsdqJqkh0S+N5DyxlBC/lMMjin3fKe65Fvk
 MvA2TulXpbXtLKxmz7JSwCrXUeoVfIAJmYQjJ33HTcNHWBcd8hzomYsQgfc7gKjDzvqF
 QVgAgzwRx7MrnXLrGzbTml6xVt+L4L09cN/aqbI4iE4jNcAQe1qASEWquNSrYWtAm0Fc
 PB6Z68wQpLUar7rmMlpXxtYZcfFghlPu5cUT4uui9p9bx1nwTtjerVxB66WvQhCGs+Fa
 Mz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070627; x=1740675427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bn/J6b8F3kE/tw0cvtq20PM+X9pVfJDhgLgx/D+6yyo=;
 b=lznhJPbWxD1TlkHPHdjTDZrDIxYFCo8Rk8TnUnSGYaGmY9Tby+mPjMJQHE+d4yvg6G
 wJZXYZF9p53N5qUtcoHnRqubTo2/WVKaD96vjXaVcl4U1wCjP3Gfwg8VOAeX8vwXFgA8
 6crHC94ZV8p3O6ftwrS0ACT4uaZ51D/HMquYvbZVKF45/zRotFzabpyURMogaexSF1Is
 4Z5YE/uHsSkm2LIRTCNFRvKjOBhkXJvfVEhVr5n8LADHT5IVf24uLJxKPduYp2XRXVqi
 Xj2imfJdKzC7kkHRM1Km+6PtNQ38qELsCVa4CgGGUFxphaS5ubQXVlP5xqe/Uo0CJaJv
 uMcA==
X-Gm-Message-State: AOJu0YykIV/wY+f2kCte+gHKhJXiKRfPAneLU6B3k3fLlsebF4hdpVfn
 3s0fB8ilNj3SP2FydOb5WGaP5Ca7cpBgjVEoZyHfThkrdRRz93dTqce4HvWYAf0yHHqqU3K4VyC
 n
X-Gm-Gg: ASbGncvK9fT0aw0BPOG3rGhQ6o5tQjQg69r2p3IEXYlw9LPbvc+6/DRw8BaOHI3rc5j
 aVckPcACMuS2UTCKaiiIWL+fDG4BE+n0wXW8GKK4odGJ1KFXKhBu6SfCSUDjGtDQbjIIA5g1hJq
 UyUBkLzaAkAvM+13sQNeMKNGaFxegzWnkGIZzRB4QBEnqpVIL5x9oF2nRbq2TdT3Iketkeb8Xqh
 tdS3xtu6bcdtogcV1o1oMgoHjp2KbctgEoe1rhlZqEGYqU7pYBS3pCpXBym2pQUkiJ1dm5QsVzz
 Wc1GykdrShLHPzT6eOh36/8ZjuZVLTzvx4riShzRJ6GFLihFYyUG1OKfGdfDZ6k81ZRz
X-Google-Smtp-Source: AGHT+IE9xFLSAoybA7zB6HBQh+GwbuzUigEg7QqOdjJ4Vo7QuuMKyzI5U2wDnSkB2znJXHXFFSNNqQ==
X-Received: by 2002:a17:902:e550:b0:220:d078:eb16 with SMTP id
 d9443c01a7336-221040bf81dmr341832925ad.37.1740070626989; 
 Thu, 20 Feb 2025 08:57:06 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Rosen Xu <rosen.xu@intel.com>
Subject: [PATCH v3 05/14] net/ipn3ke: remove unnecessary dereference
Date: Thu, 20 Feb 2025 08:55:19 -0800
Message-ID: <20250220165644.16421-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220165644.16421-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since it is a function pointer, the expression *hw->f_mac_read and
hw->f_mac_read are equivalent in C.

Remove excession indentation here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.c | 27 +++++-------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
index baae80d661..c8f06a06cb 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
@@ -229,34 +229,17 @@ ipn3ke_mtu_set(struct ipn3ke_hw *hw, uint32_t mac_num,
 	uint32_t rx;
 	uint32_t tmp;
 
-	if (!(*hw->f_mac_read) || !(*hw->f_mac_write))
+	if (!hw->f_mac_read || !hw->f_mac_write)
 		return;
 
-	(*hw->f_mac_read)(hw,
-			&tx,
-			txaddr,
-			mac_num,
-			eth_group_sel);
+	hw->f_mac_read(hw, &tx, txaddr, mac_num, eth_group_sel);
 
-	(*hw->f_mac_read)(hw,
-			&rx,
-			rxaddr,
-			mac_num,
-			eth_group_sel);
+	hw->f_mac_read(hw, &rx, rxaddr, mac_num, eth_group_sel);
 
 	tmp = ipn3ke_mtu_cal(tx, rx);
 
-	(*hw->f_mac_write)(hw,
-			tmp,
-			txaddr,
-			mac_num,
-			eth_group_sel);
-
-	(*hw->f_mac_write)(hw,
-			tmp,
-			rxaddr,
-			mac_num,
-			eth_group_sel);
+	hw->f_mac_write(hw, tmp, txaddr, mac_num, eth_group_sel);
+	hw->f_mac_write(hw, tmp, rxaddr, mac_num, eth_group_sel);
 }
 
 static void
-- 
2.47.2

