Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5A31090234
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 14:55:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE993402AC;
	Thu, 19 Mar 2026 15:55:31 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 02EFC4025D
 for <dev@dpdk.org>; Thu, 19 Mar 2026 15:55:30 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8cfc2d1fdbfso37478085a.3
 for <dev@dpdk.org>; Thu, 19 Mar 2026 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773932130; x=1774536930; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gG5zaU77Ykr5EKvAn8iaPU5IXLSzD0+k9d/DMcTEzmA=;
 b=iOoQIETFn3z5u0GNndkf1VO8tu/YUcrb/4dRlkJv7W7HuEEkSAx1D2TrNU3yTyfw2o
 KIvlB/2k5POsYM3/q7iFgwc2J0qxUWgDlaRxR7na5zRXSg5OFmI0vkIHxDu+s6S6wp7U
 JXa85bu8R3/ickGTHCayxqual4B+vfMfooyJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773932130; x=1774536930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gG5zaU77Ykr5EKvAn8iaPU5IXLSzD0+k9d/DMcTEzmA=;
 b=n6/kY5YUFZEblbwbasei4cK3MVG2CAKkyootcUIEsnhHs02Z32ba6987Ra79AWfv6H
 18717NKm9IWYSMeEmpCqWyXIurH8WI+GNxiOjJb3WNVaIyponyfZlvjuHn+Z67cMaY+1
 eBgJhtTeeD5ByB+OdhZiInJLtqguOy8WtdPXOfiXPSPOFz/KAV0oEiSNSeMgBLN+TUFy
 tNmoy2Y4eAFwqR/Tze4URI+DL/6j5a1Wsl0yMkIG3FzSZZc0wtYUbOQAMFmhTL4WeRpu
 w25OHm3IRy6WNwsqezIx8l0DDF/E0dyUGoCULPhxTw/djr2AVZvMIqoSW6qitawP7/f3
 +N3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7DhIPZm+gx5oKV8+mJzOOFVBM7vPcuYAEXBO/Bctx3uagdKUnEQvFF76udYfM5k64+s4=@dpdk.org
X-Gm-Message-State: AOJu0YzJQ3E68fp8Q2VB6q0xNIM1mS5SEgiOt1mKKO0VtCFdD41CYHmW
 VHLdOOPE9bUd40JFm9ei1BLtGHzOs5yOnmk9Aqvt3EOZMQyBIZ4DZyCzFNgLWIOVwO0=
X-Gm-Gg: ATEYQzy+e4HD70Fxr349xtvGZOf/eQ5xJD7e72AJwHzC1RCnDNDSfQVF/nJ6dDrQ7V/
 cDe6lb/y4qX4/9boT9h27TeOUV33Tfb8QOVKHUZsAzpjHTy1H2TlSyZaUvy8C7+ZX85oJAHg5aB
 p+P0HKcqlJhz4fOPh1U4K1OBOlrzlBrH1b7Cu9s0/grao7vWOSJmrVTRdlxY4tlCPXX/4YbkbSh
 y4Z5hYFcHJN3+oUy1CF7oCFRVTrZG6s3Qwbg05w3ij/mlzSIDQd2NCeBAhUSqUQJRQGk5Fj4Nc8
 peIxnE13EBxv2fyGQvv6LVvMg1BHvfO4ZdJb66ZA8mCYzG3NmH3Sk73qLWLMbQP2IhdRGlD1bqM
 6HYWYROxq7m+4XQ8uUHRrUrhppAZNw4TDC0KLwqB3BYpLTo+4geWyMOJlHpjffz8uTd8O5fwyqN
 KAYAyPlYXhJ14sDzty37PUfR9wkp3EQyD2eWpVdZW5ii9Y5XfRNHLATzF/jKvKxpWV
X-Received: by 2002:a05:620a:2256:10b0:8cd:8ee3:5004 with SMTP id
 af79cd13be357-8cfad26f4a3mr745880185a.27.1773932130104; 
 Thu, 19 Mar 2026 07:55:30 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfad168936sm487116385a.26.2026.03.19.07.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 07:55:29 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu,
	luca.vizzarro@arm.com,
	dev@dpdk.org
Cc: dmarx@iol.unh.edu,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: add missing crypto drivers
Date: Thu, 19 Mar 2026 10:55:25 -0400
Message-ID: <20260319145525.294352-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

The recently added crypto throughput test suite was missing a number
of crypto device types. This patch adds these missing drivers.

Fixes: 76e3fdd7b5c6 ("dts: add cryptodev package to DTS")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/api/cryptodev/config.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dts/api/cryptodev/config.py b/dts/api/cryptodev/config.py
index ff4ce25c93..69ff7aa59a 100644
--- a/dts/api/cryptodev/config.py
+++ b/dts/api/cryptodev/config.py
@@ -38,18 +38,27 @@ class DeviceType(StrEnum):
     crypto_aesni_gcm = auto()
     crypto_aesni_mb = auto()
     crypto_armv8 = auto()
+    crypto_bcmfs = auto()
+    crypto_caam_jr = auto()
+    crypto_ccp = auto()
+    crypto_chacha20_poly1305 = auto()
     crypto_cn10k = auto()
     crypto_cn9k = auto()
     crypto_dpaa_sec = auto()
     crypto_dpaa2_sec = auto()
+    crypto_ionic = auto()
     crypto_kasumi = auto()
+    crypto_mlx5 = auto()
     crypto_mvsam = auto()
+    crypto_nitrox = auto()
     crypto_null = auto()
     crypto_octeontx = auto()
     crypto_openssl = auto()
     crypto_qat = auto()
     crypto_scheduler = auto()
     crypto_snow3g = auto()
+    crypto_uadk = auto()
+    crypto_virtio = auto()
     crypto_zuc = auto()
 
 
-- 
2.50.1

