Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6A0CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2343640B9E;
	Mon, 25 Aug 2025 05:42:54 +0200 (CEST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 1CD5840A75
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:45 +0200 (CEST)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-3c607029266so1544067f8f.3
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093365;
 x=1756698165; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FA3BAKcq0+ejd8hdkjvgyje8HXemDeuMpXnpAL5emQM=;
 b=hV74y4HovaVTLXSc/aI4eBPXfYKLTHoesHySAY0FYx1fGorBBqhTWMggaiVTVTdSEK
 rMOt2gpHmzX/S7q+tfm6Ys8Yz+bt961S/jGDYJv+4NwmYiPZ0Gp9lghQ+I16/GO0dswt
 L/m/zcMP7r+cjjIy9sVFm3tlgT7Zj3maLTE5hN5u0QVkUUoyPJnAtFbhmgP1JscODHQU
 bgumbP5/Tn++jpEoe4IEGBPc7dZvGnTtfXJBhtp0k94VPaki4G+FGAQgtlg11SqNNPpW
 oVGdDXf0OOXYgFwKYvPkU6KINBLfYESrnJiHdK846wiXsWV8h93/toMwzaB+YGEVs7Uo
 DDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093365; x=1756698165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FA3BAKcq0+ejd8hdkjvgyje8HXemDeuMpXnpAL5emQM=;
 b=EKrYpPe+hcrNWNFIJuw/F74LFmWE7vnsZ+gh94o7dflF7zXeRdmr/eUqdk/cVwxhZZ
 0omSLw7XXUCgGWSZpgfzxDV8H8c7hiu0OsG7J9ZovYxM11z46GtvG4/55faVuGqTlFV8
 +PN+JAPwDBuPNpAPnQqR40SSBGoz/m/H9KrhtmRfjWqKFCCfHM2/O9msi6oFWKo7eozO
 emv+muwBq0STc5gLTxdcFAZT9Tpir1NFR1gLHrRGbUc6wNEFbgye7lGfAoqNJ7YhvYoR
 7mufw70lVRJxY9pSgM596JIzAMNlqiAb/7pr50KaSzvY0gCbrL/ySH/roqEn4wJdg+if
 tDRA==
X-Gm-Message-State: AOJu0YxoVOBPG9/FNvJUol9HH2FlQpptqkTshF6vBoUjgiPxwFiSk0GO
 QztULQWidBVWuBkzh+z3ES2SJ78nnGs/BdnPERjJ2Je6GYQL/nq2OFVSz1r/waf96yWcl9bqWWA
 Jvr1Q
X-Gm-Gg: ASbGnctHfzRaCZHB5I6vADq0UadJAKMinku/4fizVK4l/MpSgWNVNJlJXZ23EHpy0as
 ibRkB1YW5DiyKAji4TIewNotIodmfu9hy7wZJEWNYtPS523fO4sD9EUw8Cugt/3vfhtiKHTqznu
 6cSt+y3hRBPEk450+jCUVEIqoRuVSnkbKaAspw0bN0r4EyOkUTmoF7ImVznjJHtkDdipgC6Eu0Z
 PkYr1yZnTNmLw74S16SVd8W2zTJvPw7uEAepXVeHasY8aPQeUfIE5Z8y3FOaKBJ88iZb+3m10Qx
 nTWbQJHLLvWdRhhg8NqNyaSWvwZ3VAz1l8X4zPrl8vZ9bEU9Cv2tiY+hY+xRIQTXKwwMp+oWLES
 jq7uiObb0OuiIQYMWYXxWkcmIXuFKSLfw8vxUMNGGhRc+HsxrVAAq32WVFyj7cvamGBD8ahUX
X-Google-Smtp-Source: AGHT+IGlfk7eRfwtoNhuRKgwCNj6gV9hXqN0Kj9+8nrUlDKEHMKiNH3Ox67HA2eTJ3mWPPBamtoPLg==
X-Received: by 2002:a05:6000:25c3:b0:3b7:99d4:c967 with SMTP id
 ffacd0b85a97d-3c5dd8aa736mr7124497f8f.40.1756093364725; 
 Sun, 24 Aug 2025 20:42:44 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v2 27/43] net/ngbe: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:40 -0700
Message-ID: <20250825034126.12046-28-stephen@networkplumber.org>
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
 drivers/net/ngbe/ngbe_ethdev_vf.c | 1 -
 drivers/net/ngbe/ngbe_rxtx.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index 846bc981f6..c25acede85 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index 3dd268e5bc..049a9f587c 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdint.h>
 #include <rte_ethdev.h>
-- 
2.47.2

