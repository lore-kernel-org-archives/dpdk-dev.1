Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E8DCCD199
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 22:10:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB56A427B6;
	Fri, 17 Oct 2025 00:10:06 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 6943440A89
 for <dev@dpdk.org>; Fri, 17 Oct 2025 00:10:05 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-33bb090aa78so1069615a91.3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760652604;
 x=1761257404; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qjw8B+dVOq93pSpA4ZVDH2QJq8WWbTlXqSJ5OTl9G34=;
 b=EYgdNLf6GRtVMy5a825w9OgVnsUDBe+KIPn43roqP5LBVv1eUiASkuNDHPsO/AxLc7
 +AO8YFgr6bUn5SYQzl//HWhz67ROejj3UwcCvnhWqZAVx+tQYpyjp7XHgHSb8uBLBWzG
 H9XMrNYzJMOjHwOz4kgijCULiIyl4cNaUUB2Tz/6U6QiYxtwKfPWPV0ckWgsRMX3WK55
 cXK8GnCoeHXnVe22B05MLM2zoi7qFDO1S4xAVTyqfDKCoyTPlaxsrHUv+OUkMMiOeOb1
 4O54LVY+ffQ9yKN06Cqh20jzB90E2dMk7IgnWmld+X55/zCT7jGkjMBI5XsO6D+fxIez
 B9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760652604; x=1761257404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qjw8B+dVOq93pSpA4ZVDH2QJq8WWbTlXqSJ5OTl9G34=;
 b=VMR9ZM2DBbfKHYjdQZ3jBEF/y2NktdHS2EtGmtqk3bK2IGkYcuvkoqtda0u1BDKRpl
 W2a4+i0vq7iJOqG7alNNj7Rnvx34wpPNvKXlLAHTd+hSY4S/yuPfAQINvOpC/074jUvr
 4wx6lQyQr0FWWymAioOOM8fzxMMcRDMm2t8Fxxdd2dHpMVk9NXFKCixL0TYxQC9fTYE5
 TI7PBovMpZcJ+Z5sxbmux0P3fe+nTJtPLwik7sOGXepOeb08kNEoMQHrMT4qPf3hYd41
 lxj6rHYyujhIcEeU2Qq63Iw0m/TmRqymAMh5Fx8XHDMIinrBf/e1g3fGSy+PmDLxdz/A
 jEkA==
X-Gm-Message-State: AOJu0Yys3tBm17+KC1u1CEX4Mc3JDI786QnYKz10BKJ2HaNKLH/1PKvN
 ariYdZ4NpuQ2mYKqVhM6QNwy/bN7wsI94BBg7OVVINpWCDhK3BgyLO/Qu5fvA9ktKpfWnoCcllH
 EM4ONp/U=
X-Gm-Gg: ASbGncsk2iLV2l8Is255zlh5eq8eaJrbzG/9mwtozZIf5eKVZGSAyD5LiuCGPzRHSv3
 npkUJ2c+YLd3+0XA/duCWp+G138Mm2tbDYNqLKtFBA4SnVVM8gtKe/GKzP37sduEZ+Ipp0GSgZD
 MobLyODK4LmBPAdK7dLAckMBu582owJxMetMJw3NqLercsWGQ57SWCyye03cq+MlKueUkbj+e5L
 DOKFCdGwlzwfRg8YJFYyC8Exke+WcwLUrBQJ9qPXl02Ey32bTuzyUg/bRXI2R0leFCGMQuPSgdK
 U4WCuvUWCWNa+TEo52QKwhNo9AyMkILyB1K3KHk6AcGjb/Sck0mlJyd021/Azya0tynuJAPdDgx
 205NxlI9VM2uaXiOPsbCNZVyFQ/bMQh/yOqE8MsIEysd886ctrUioywR8Nkt0Xqo5CBK7SILWu8
 BK2ixp9xauTk4crBDUBeYu8km457X0GVLDhvI7J8CJmBPSuZo0QkeU1dYo23Oz
X-Google-Smtp-Source: AGHT+IGFedRZYZuKwqR8CgLqxw1hcx9HUXlQVvvy8ENLQ+rQGijlQVLa7aRPPT+GeI4myVw1Jg2tjQ==
X-Received: by 2002:a17:90b:4fc6:b0:330:6d5e:f17e with SMTP id
 98e67ed59e1d1-33bcf8faaeamr1451226a91.24.1760652604569; 
 Thu, 16 Oct 2025 15:10:04 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bae2a4e03sm1731259a91.4.2025.10.16.15.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 15:10:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 2/3] net/dpaa2: make local array static
Date: Thu, 16 Oct 2025 15:09:02 -0700
Message-ID: <20251016220959.15671-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016220959.15671-1-stephen@networkplumber.org>
References: <20251015230933.875860-1-stephen@networkplumber.org>
 <20251016220959.15671-1-stephen@networkplumber.org>
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

The table wriop_bytecode can be static to avoid name conflicts.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_sparser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_sparser.c b/drivers/net/dpaa2/dpaa2_sparser.c
index 0b3e9f1920..6c3e6eb573 100644
--- a/drivers/net/dpaa2/dpaa2_sparser.c
+++ b/drivers/net/dpaa2/dpaa2_sparser.c
@@ -23,7 +23,7 @@
 #include <stdint.h>
 #include <inttypes.h>
 
-uint8_t wriop_bytecode[] = {
+static uint8_t wriop_bytecode[] = {
 	0x00, 0x04, 0x29, 0x42, 0x03, 0xe0, 0x12, 0x00, 0x29, 0x02,
 	0x18, 0x00, 0x87, 0x3c, 0x00, 0x02, 0x18, 0x00, 0x00, 0x00
 };
-- 
2.47.3

