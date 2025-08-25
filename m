Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE9DCA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:42:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4D3A40612;
	Mon, 25 Aug 2025 05:42:29 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 1BF504064A
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:03 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-45b629c8035so444045e9.3
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093323;
 x=1756698123; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEMBnoo69teO9KWn3LG0wB+AjiTXpfGgAdNTvx3PXfk=;
 b=MGTVYOcCjw5fgdKeTAh2QWKgEGJ4y6lnn+p71WIpPzlcS1jShSqa6pMZIE/41xCCeU
 xEJ29g0+loDKjSSHJMbtR/AmY+T+1ciMp2HcMADEJrfRZT3/lZ77CkqyIXaIeOd1pWAs
 XI9bnZ/IJ/wOYBB+zPPzesdl+dKpaSl/tCLvoRWAGq0mbZGAg/1aUkT1IbSvzRGLu34x
 ker8ueextXE5xzOuMPllZTc/rc2oN4aNsIi6gS2zZKLS4Muv3lmn5i71GLGA8d9Dgqs1
 n5icHdy5Kdf6eoQyR3xBY+8D0rvGTSB8LjuUrlwCdWcrzpZYkoMIZkwndlb3AaSnhIlD
 eS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093323; x=1756698123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEMBnoo69teO9KWn3LG0wB+AjiTXpfGgAdNTvx3PXfk=;
 b=XjnrBpJQKcTdC0B/r2t7ckTWwzs/OQywhW0V+vSqYOQdikubYeGdGg9aHnoz7cjpmA
 6ekscsrjlkvxK+lPhgSjVXgLdHs8zC0cXkkt8eS7sT1yZ5wwGEEajaEW7y/yawMUC08i
 jBjvqw1P1SsSQh5NvocGHrKMGQtQh4m9+mVXph42O8fyA59nVt88qnGLmrhbH69VX6Pi
 IZKw8l1f0NKDqFKZ1uA1LXAbUlxqwzTfN2QOrUWRR9FU6xlKPDw1y9DvuEhHnXWKHZEA
 L2/JOH8z/2mf2ftZFGZU8l/3G1VVLVXFaxJDb4PlZ1Y5LvhV7tLU67N1/1KiwPkxPIKY
 J24w==
X-Gm-Message-State: AOJu0YyhSgvsgEwGKxh509LjGEAE2x9XIOOQb/RwOeQ9gpv84wMesiCh
 WOYhQ7yvH/mZffmRSDq2csXLx5nbpRTryJTbyfwJfu58qW3GCk9QJqvDCZvNozjL4ZyokGx6/RQ
 vS9Qv
X-Gm-Gg: ASbGncsNzm+iqiJm8viXA70PjyPakoJUs6UCYHRQEv8fWKEEKMDtzMw1wKVf8Ct6wFT
 4n2AWYmTSpIvSkKA/Zb7k43LZozTGOX0rHe9kJLGcLCy3CYsQ99HtdWXJsBHhvlrQZyHl4v1qAB
 AJhyqT0R6SxAyXJBxzTAL7z2g2x0CkfmvsCNJnqZZe5dkWbgoVwrhBr8Ru8aCp3mfHS9znVw4j+
 XSHWSF0SlAkHpoiLwY3t2IKtBzGyeLs3FPqkHga5fiZ9C5ODS6ddkXfbn2Y8RhXiUHgo2GO7Sii
 nPERdcB1GGtMhWweRooIfDlrp3t1+eVd9x4gkN2ANNhHgltDH1CCcyDxSletqRpmg2mW2jz7s9q
 sy+dxrS47+dPGgGUsbuFsEFHDa6eJ+5avmKw7PUnT8+pw2B20sFjpSc68C0pnPh74CkQthLW3
X-Google-Smtp-Source: AGHT+IGz4qMYLhYk+bBKpd/a7TDel5CdYMQI73zRZALYLxFuSVM8MYtmlFi6sKFvPlI2YGzOnKnFUQ==
X-Received: by 2002:a05:600c:1d1e:b0:456:1b93:76b with SMTP id
 5b1f17b1804b1-45b5179f516mr86467895e9.4.1756093322695; 
 Sun, 24 Aug 2025 20:42:02 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 10/43] ethdev: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:23 -0700
Message-ID: <20250825034126.12046-11-stephen@networkplumber.org>
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

Use rte_bsd_queue.h instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_private.h | 3 +--
 lib/ethdev/rte_ethdev.c     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
index b07b1b4c42..6f10cff474 100644
--- a/lib/ethdev/ethdev_private.h
+++ b/lib/ethdev/ethdev_private.h
@@ -5,8 +5,7 @@
 #ifndef _ETH_PRIVATE_H_
 #define _ETH_PRIVATE_H_
 
-#include <sys/queue.h>
-
+#include <rte_bsd_queue.h>
 #include <rte_eal_memconfig.h>
 #include <rte_malloc.h>
 #include <rte_os_shim.h>
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..1e16a2825a 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -9,8 +9,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include <bus_driver.h>
 #include <eal_export.h>
 #include <rte_log.h>
-- 
2.47.2

