Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEFAEDF17D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:03:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7755F40430;
	Fri, 13 Feb 2026 18:03:42 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 6208F402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:03:40 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so10521735e9.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002220;
 x=1771607020; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yk+631P5Co64lrub6paWOcw3XksPlNHKKmYRESnsQsk=;
 b=foGxGDp5eND1ZLUm3nF3kXqkUvOEDVs0V1zV0tB08mGxwmOxukF5DoTIL723VqTEQp
 zosPFmphDUpAenRQiw6WSd4TZ2s9ABrtyt+yjSyUjjtMhb3oJ6zh/HN+gb20d4NYFz0w
 qLJmxXR3WFS655ZqMrfHd9lxPBbAlh9owAT2kBzGpPptdZ4KFZg7vHpqPhcRRazen0rU
 2DXe35WNdyKoajRrx99HZCwH6/nnza7eU/9owr6wafLn1gwU84TRIw4xEb2EiNh+myCA
 mRF3mw3651Mxnhy8Uq7C9J+eDG9GThY4EjhwWkDpiigleFmCMEKwl3up8r8kuwotLf6h
 62jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002220; x=1771607020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yk+631P5Co64lrub6paWOcw3XksPlNHKKmYRESnsQsk=;
 b=WEgz9HCAb3FQzg/LrYm5t5Vop/u+Jx7hVU+DFGmC/RbDrKhDGIZZ4L1g9cMhrB61KG
 2nnTxXEo7529bsjNCV55jXcvubh+BTAhZt9P9OI73GscuAtHoVnUkRyHK5CM7w96ntZu
 xu4kJJrN7gz4ALgbOUJthqi9Qa8+CdWHSuO77QNGOeycGM40tZoMKGf9ZZRxYGrluZ9k
 rBcZ9d1KE97xco3aIJJ+84ws5/JDQxMkxQA6eCzGs2G2ane/aZsjuDJnTdwt/XoKpoXw
 RlTfzDfSLLT4yHW7YlA+P/DD7Owrgl1uuGbflJIE2pY268lL6arU0ULICUbj3ex04446
 a/4w==
X-Gm-Message-State: AOJu0YzpZ2QScL8TmTwuvqCMB1+Qj+toyDJFLOwaUdalj8Md2eANtC0e
 ts8OTP2RER6IsF74XZzy/qtXuHwfPt3RomgahGr2AJFvbKnzRnwm75zrcJU+sPxl74Go/oIANnG
 RQvBV
X-Gm-Gg: AZuq6aL7u46720zPpfJ2Gjk8FzlKhBTt8CxN52wEiWyNpNK6qYDu2Hfcv3I89+/VXWE
 9sJDIkTQauviuqDFBae1NqXLNktNFv/x9Pm5F3Zu5iuvqrR/rB6zy2uyoc0QE7Z0im1Oseuf08x
 vwVoPKktvAgjKG20JwINEPtjqNWQwYcSsKA/ZDHkRaFTZIIt14z2kDSiUx8JdoEKLxD07L8G8PR
 ZZFG/ABYhSHRKtqZhkISg5Ld0R8LpZeirKZPhS4bP95b7/WVo/z9o/D6ciU2oMLq0UMlQ9TZy4B
 UE1RkS7bxKrK/gldVepspAsBVzZl2qKT3+LxWPxMKf2gkJrlyz0z8LTeFYxRgQbL+Kg2+tv1YeA
 FuD4TcHNbzJb9EvnDyfZAAaQj5lMh4y8GsBSKhe7MQ7E+CjJSJtr/ApebSsDtLOTA4+uHb8SOfc
 6Zdy1kqv9u1VUayAD4byhqWl2VMQGvkZLNbRw8J+/149KMerxoRLEQUWl9Pj6J3A==
X-Received: by 2002:a05:600c:1e1d:b0:477:9814:6882 with SMTP id
 5b1f17b1804b1-48373a15f3cmr39833635e9.5.1771002219862; 
 Fri, 13 Feb 2026 09:03:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:03:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v15 01/18] maintainers: update for pcap driver
Date: Fri, 13 Feb 2026 09:01:24 -0800
Message-ID: <20260213170333.40089-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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

Nominate myself to take care of this since already doing pcapng
and pdump code.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25fb109ef4..9a9a7d85c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1118,6 +1118,7 @@ F: doc/guides/nics/zxdh.rst
 F: doc/guides/nics/features/zxdh.ini
 
 PCAP PMD
+M: Stephen Hemminger <stephen@networkplumber.org>
 F: drivers/net/pcap/
 F: doc/guides/nics/pcap.rst
 F: doc/guides/nics/features/pcap.ini
-- 
2.51.0

