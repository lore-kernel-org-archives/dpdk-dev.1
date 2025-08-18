Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEE9CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F93040A6D;
	Tue, 19 Aug 2025 01:33:19 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id DA048409FA
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:17 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45a1b00f187so20993295e9.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559997;
 x=1756164797; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcFbO3H5TbnH3HVFM5Hx/BMbzDuY0XCiqFr2i6MPmUw=;
 b=3W6pnsib2a/PQW4dGBoW9e0TRz0T2BQthx7Mc6/jQvoCV8AiiZEfUElL1JMMDOnKWE
 mmpxZDpCTEP6ZhrDDmPIZhBPaxLaRTbGVfX9pTTXZHw+6uqVhkbot38RkzAiBmRaeHWp
 g6S53RH2xd+eUL+ClWFJfh2FEhljGZREMFqR3AtqxNlG+Z1wGWqAC8/D2g+TL9jXm00E
 9Gum4l0KGtsY1wAijUmQf/2wuVdD0Zt4z6qCJuGLu7Ft8+9kv0+k+EFfy8zQ95SQxink
 ZauDNSvZGrqPi6z8ERgN5WxxQSydLeKqRjzeio7PqKQAC9i4yUAUqQJzBV2c8u37IEoQ
 ASkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559997; x=1756164797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hcFbO3H5TbnH3HVFM5Hx/BMbzDuY0XCiqFr2i6MPmUw=;
 b=PjYNk2yXNGG5NOWKOOlqDgVM3VL2MPnbRFnTK9h50OkbR98FAST19qqHQ4QY8XIBQI
 gR3kj8RlrT9/M+Fpy8p6AzMAYb9nAxrN+TzzcT/RvXx4GnelIlKzZ3xcjrMF8bFdYusZ
 3Vzi3D4sDDiyqc72WwI/3yfgwnHfXTYWzbnnBOaJdZr0NaHhmhxo4wcWfUwwq7dYdlCW
 xCQy3nwQpgSX83StvJEocx9w5ZvdWBZ9HXoxgv9Lb9ILgCyMntUMUuJXKWwRcWA1n8Mj
 vkj6bTxRnNkJWBXD2UAaiMcXubtZdMRlJl68jRhbjnRVXrFox7ZIvagjjFezUnF92Kl4
 +ZKA==
X-Gm-Message-State: AOJu0Yx+91jMhJeFGz/fLxbC79C9DyDcMn+b6IeHKPUMRpRZEBTMmNqH
 JDCRQvYs5zGey89qDP62drN/KpbzWcH61QFcKV2Q5NNWLSa15P5jSyzQQ/XJKq16Ddkf0D18Pe8
 L0DRl
X-Gm-Gg: ASbGnctfzQsR6rVEt5/RzrXEHdNk3tiPD56lcbsUnG/z4v9bPn5BphO3Gykt7qeZ1j6
 PAJvYiLGD+sX9C6sKK8L1/nwQUMrS96v8xynrueyDCg3k29gIT1sbUuXXXRnaE8Nair6fihrsFF
 T96iOEXrpMI0VWE5Rr5GsvIn06qqtVLNUKCtQdnSuEG0IfUcke2BB9TsCmF1HP82IpDeD26j33U
 E30aSNwzI6sT3ZKsmGCCuZcK7gaNXrN3IJKVoc0QtV6xy4+QIqBcSiEhrapsthwFFAWl2/SdOZn
 EWhpsftxFW7Pjsca78y3exO2byRrSWIvejFACYyUC3FrqRfuu2ye1ognwQlcPv54HBImqadGjyS
 egmU2dhWhV3Zd3saK8eCZx/cbtD3I0CHv0l+vXeVNK1+IoHVXiYWzfhdxZvU8Pb89ChJZjcF/
X-Google-Smtp-Source: AGHT+IE+7JThZLQMzW5sG/t8Ht7hSUi5j8nkF7UChTkaXVP2oB4cR59ZALtwc4lefiuRSNkxYldgIw==
X-Received: by 2002:a05:600c:3592:b0:43d:42b:e186 with SMTP id
 5b1f17b1804b1-45b43db69ccmr3180695e9.8.1755559997475; 
 Mon, 18 Aug 2025 16:33:17 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC 16/47] ethdev: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:27 -0700
Message-ID: <20250818233102.180207-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Use bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_private.h | 3 +--
 lib/ethdev/rte_ethdev.c     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
index b07b1b4c42..a994833760 100644
--- a/lib/ethdev/ethdev_private.h
+++ b/lib/ethdev/ethdev_private.h
@@ -5,8 +5,7 @@
 #ifndef _ETH_PRIVATE_H_
 #define _ETH_PRIVATE_H_
 
-#include <sys/queue.h>
-
+#include <bsd_queue.h>
 #include <rte_eal_memconfig.h>
 #include <rte_malloc.h>
 #include <rte_os_shim.h>
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..42561a01b8 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -9,8 +9,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 
+#include <bsd_queue.h>
 #include <bus_driver.h>
 #include <eal_export.h>
 #include <rte_log.h>
-- 
2.47.2

