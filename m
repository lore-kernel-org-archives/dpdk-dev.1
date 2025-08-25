Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697F1CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:45:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51A3D40E11;
	Mon, 25 Aug 2025 05:43:04 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id BD40640E0F
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:43:03 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3c68ac7e1c4so954465f8f.2
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093383;
 x=1756698183; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEN+w7Ms9Nb7SYKKJzAnNUNVeA4whtgIK6K63agbYa8=;
 b=wk3NufhVKEWqyKDTi6KnHaiVdbLK6aeFitvhxYnbBksYXeNGBH1wKpUjipyMshbjdt
 4PbZ9fCS/ztkY6PPhx49bQz/eD6uwe4A7PcOx/hZiSGPp3UriarI8QXucc15y3RuCPFT
 JWg9krSKLhGYm+XTKUSIL3uOc7o7MRi55WwGdSZZ92LF1lXMY8GUMJHSFaoOllEbf8hJ
 EvzrRc8A8nUoiKs9wvoj/sufutpgLoYXSASRy6g4yeE8onskoS/disKgHfvLv2d1HMFY
 8BW0Y1EsuCStjXRbf37RumWt/V31bDNV2gmGMLCluWLNvWENjwnLkDCe8Nqq7qkOSEjP
 e1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093383; x=1756698183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEN+w7Ms9Nb7SYKKJzAnNUNVeA4whtgIK6K63agbYa8=;
 b=RybmWppff/eg27EBkM4jo88cy+LpDbbQSDC9eNcEoyQwBuaVR/xvmzZly8VDjVhKWY
 9qF0G3EQ5FJRpmAXRyz/mLIEv16kUQJRRmavh4CQzNGwZwigUf1htzfWdn3TQvc5onHk
 93WmB6gJABq6Fgn3RTxQvW8hgcZabXPgACDLLtWdU3tPWwEMZkRIZ/bye5y+t22xcmn/
 iRKVf7p8ft1gjJovvJricMCrnQpmB75Zgzhwf6XXP7yDrwO0vA+CUsdaYY2sspRM8Nuk
 LJbWST/OgkA2x6kKQm2I1HOcRawudTIsQzKK7eebq8m1ll0qwRSKwmUmAyZnMgLCpnPq
 z2/g==
X-Gm-Message-State: AOJu0Yy5Nc39JAodJ8jXRI6ptCQOcb10QNS/Lb1i3x8tbNLLuFVK5cAc
 f3ZXcUGIGxuJkNG7drLo0ZZzLw0tAXLicPDMW6dIF03jlazNhegJdGeexVEOGy1xBQqNSezhrBn
 eCdZb
X-Gm-Gg: ASbGnctluqGSXaA3gMNYsmY8MYY8rdKb8gQRldGQmN8ZN+0mhCp+SAohCT9NxcjV8iT
 IxTB5/mK1ED2rUc6HfUhd0dhlzzlTu9WjzhW1uPLOPklnz3VvDTmOPEUvEPJEH9ZlXMVf/4lfGH
 4Dw8fynlanYYBl/Jl11Ru2tO1s5LZfwaC2KkTH1FrA55CDLI8ypUrKtvAsN8BtqOevQe5J0amBU
 b31cU8DVP5aWyfHhTNe/rco9vHO7uri0DKjZ9K7CzMN58wHTcOPYHyK85h811SWQfaVzrYXVJEG
 jpHvW6nwCLmkY4OdqHK1cg0BKsUkLh0DALKZtFzH+meICDWNIzwdH4LBkGuTU3xokuQ7xRKwDHm
 YOcMsVf+y0yU3G0vI5QMVdd6N3M9gVgomllSnzA+5S0vIn7qsenXzSMI8iArmxqNs8h8L+RpvB6
 41a4ivsnU=
X-Google-Smtp-Source: AGHT+IGikhQz0ILVe4wQNHgnlfzxfQhdEd91Y1Ftma58HYGdMdIuE/7uV0eW3ERG06yIK+6MEUTLFA==
X-Received: by 2002:a05:6000:288a:b0:3b9:1109:7064 with SMTP id
 ffacd0b85a97d-3c5daefc5ffmr8139444f8f.15.1756093383358; 
 Sun, 24 Aug 2025 20:43:03 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:43:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 36/43] net/dpaa2: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:49 -0700
Message-ID: <20250825034126.12046-37-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/dpaa2/dpaa2_flow.c | 1 -
 drivers/net/dpaa2/dpaa2_mux.c  | 1 -
 drivers/net/dpaa2/dpaa2_ptp.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 299c50dcdf..96e58b85fe 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -2,7 +2,6 @@
  * Copyright 2018-2022 NXP
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
index 1908d1e865..f956d5d5b2 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -2,7 +2,6 @@
  * Copyright 2018-2021,2023 NXP
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 751e558c73..b55aa195ea 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -2,7 +2,6 @@
  * Copyright 2019, 2023 NXP
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
-- 
2.47.2

