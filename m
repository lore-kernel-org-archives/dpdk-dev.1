Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB2DCA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:42:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF68240430;
	Mon, 25 Aug 2025 05:41:57 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 02681402AE
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:41:49 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b0cbbbaso32968525e9.3
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093309;
 x=1756698109; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/mJKJk3fu5DPJYgYw953wgZhl21dyAKOFZQMmvJXVc=;
 b=pn3bSX3az4947zijUlKClhEhKv9vuCPmWiIoh88CquhttnDAZ8MH1MYaVBnXJXSS3m
 yPpQot+OQ7B2rD8G0R8htvJz4mROXZZs3pHYrCSmB+CSRTFKX1E7I0hVliGdWULWCW7T
 sQTtjcTvTndI4P3oMN+2nTJhK58AfW/iVolJzGj45EScO3ld1VRSc/lyZXBTQEt1vGdE
 Bbfa6i9qAHjseABMLCy+VMcKdSTfhOv3wet6eNHzN1NNfY48w9OSy7Ig+MVJz0GlXwGV
 CPNFt9IMVS4x9xekpZTJXdbDTuOHTm5ELJFRYIhLVE4UTYMg/8pnat6PbftbeH3hsYI4
 YUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093309; x=1756698109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/mJKJk3fu5DPJYgYw953wgZhl21dyAKOFZQMmvJXVc=;
 b=ZSYMDqun9ercfXwb1WzjZSpDh+fhzBzgmvHTAW8Nszw3hUpuBJSW9J2a52S2YelIVx
 Tc+06A3ie2QjOZZuIDfex0U0PKZmu7+O2Mfi0dUUXp7rEUhWyAEgcfzHuhOoMSApoOVt
 wgC80MTpGq2ZbCayrrRBZ7yOorgS1IcfytH5s0slaZV0vq8GRRSmtyG8mqzpBvywhORk
 JR+AQYDLFWr9S+20h/YCtc7UvMLQw7UXr2V06qpodKlrHHEe1eJDxxMFN7lxkIhnPCI3
 TuHU4YN+y1qjozAUdv18t5E3gy5LWSa0UB9ON77GRpjyCrL3M+D9TR5fMzUtEwNGsvES
 d6XQ==
X-Gm-Message-State: AOJu0YyLVT5DRlWXS2NDcywfGr/DxbE6l7w2gl7x7KN6f6go/nYyXMVh
 V/vPih701T/oVDGBdfVaTrflLTdrHcDAoAhfk6e352uFlvG+i0SgBezRak+reR+DFIHncHSqPpY
 42s2g
X-Gm-Gg: ASbGnctOUvPSe3s4mlAECCCs/4eSi8Kw7vke32RoVNaKh+OO25oIldwMselFeeyulX7
 zCaj9Nhu7Fo9kufp0Tnis/E9+vLoSr5EAbMt7fYV1aftOswVcdblY+jUU3ni6MD5LZ7bTCIy2mm
 ootNT8vwO2oU7/gevj8FWF22eVXGDZAwU8Fk1fMum0Cbl6RB7bvTcz6UKv5AqkJeWOEhw6pAzIH
 bHgVl6u8VwqHX/f3Cw4JVOhusImrRptH/tdg2WCaetmfVrb5DWfyhiqn3jy/GYcQVzWDNcRiF/j
 IBiDb3vUqqdrbWEPzDn6tItrEA88P41JZp2HReGfYb4iMtEWe9fJSPSvghhALycCIiyouVE462z
 0BNGdawcaUCTlVxgSrskHQ2ojNkX1+gqFN9DBGac7YuujW7KLGqGFK6hp7tRs/KMcBvcYgv0R
X-Google-Smtp-Source: AGHT+IH5U3aDDAYJjJcTQfgbJvb6pLluwEF3SyqLG52ZPC15T1cEsb/RVYLcSGKCMnf6FwS/0RhcCw==
X-Received: by 2002:a05:6000:400b:b0:3c9:8e80:da00 with SMTP id
 ffacd0b85a97d-3c98e80ddd9mr843557f8f.19.1756093309604; 
 Sun, 24 Aug 2025 20:41:49 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:41:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>
Subject: [PATCH v2 06/43] test-bbdev, test-cmdline,
 test-mldev: don't use sys/queue.h
Date: Sun, 24 Aug 2025 20:38:19 -0700
Message-ID: <20250825034126.12046-7-stephen@networkplumber.org>
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

No need for direct inclusion here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-bbdev/main.h           | 1 -
 app/test-cmdline/cmdline_test.c | 1 -
 app/test-mldev/ml_test.h        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/app/test-bbdev/main.h b/app/test-bbdev/main.h
index dc10a505d1..67a10e7a9c 100644
--- a/app/test-bbdev/main.h
+++ b/app/test-bbdev/main.h
@@ -6,7 +6,6 @@
 #define _MAIN_H_
 
 #include <stddef.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 #include <rte_hexdump.h>
diff --git a/app/test-cmdline/cmdline_test.c b/app/test-cmdline/cmdline_test.c
index 89f4260cbf..3927381f81 100644
--- a/app/test-cmdline/cmdline_test.c
+++ b/app/test-cmdline/cmdline_test.c
@@ -10,7 +10,6 @@
 #include <errno.h>
 #include <termios.h>
 #include <ctype.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 
diff --git a/app/test-mldev/ml_test.h b/app/test-mldev/ml_test.h
index f35fa8aadb..a2de5b3a31 100644
--- a/app/test-mldev/ml_test.h
+++ b/app/test-mldev/ml_test.h
@@ -8,7 +8,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 
 #include <rte_common.h>
 
-- 
2.47.2

