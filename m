Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FEFCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44F7B40E0B;
	Mon,  3 Nov 2025 17:50:06 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id E6DC740E1B
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:01 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b550eff972eso3219869a12.3
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188601;
 x=1762793401; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTapQFEAoeO/8oxjeez6TESRp6yHCQHzsLcSQ/gXyds=;
 b=oM68UPjrO0FhygWyIBcr/MpUHS9sKtfxK2W9QJ13rMU/WsD806ZIQQdsms0v0ZZY3p
 Lm4cAcBFIEQJJtby+0OcMRz/XW3Bxsv51eTOfu/quogbwpgVTRPez0FaVM2R0fJV3D2z
 XI88YOR0D6jA9TVSSrlMZyN+uyR0Z+UG7BkISPk7BA3FlLYXbi/tKlhHjYwNVE7hkI4e
 58z2mqHX9vL1M4mrQev51zhg5bnR/iHdKyyGprW8wthvuVgZRUJZI+RLyO/EBo3wyPJP
 +NUKvyNgxR7khgQlVnO8GRRvVo74aE3hI6flEskTSmAziL+nJgqamsX3iAguAPtZD+wu
 4oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188601; x=1762793401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTapQFEAoeO/8oxjeez6TESRp6yHCQHzsLcSQ/gXyds=;
 b=LWJOmEZosPMuXsdfudD/VbiHWEQXD7VluJVL1VBVDocz4JSUf8VwjKkxX5vjRywhXu
 T6WNPWXmBuozSzv0OVOoa6Nl5Lryuh0ZGYEBWsju3BPU4hYZ5Md3vdRLYUbB1y0/zxnH
 upNj+eV0rFHKOfk7+17XUmmZ910qg318YkPmmbnhjZ2bwwxM6vXpMDpuGkzxxygHF1Qw
 IS7NfD66K4HkMzyzePBgBi0zPnB/0+bbuF0AatSC85SWJ1r7alV9ndKbJnikbkZgAplK
 u8SCbeE+LfzuVsGM5EKPMCFo1VaTn6Ge/2W22uviZ4V519rGEUDvnR/2qB+zABCc5pF9
 ypxg==
X-Gm-Message-State: AOJu0YwVLIv+3aYkPbolNWCoYfL1vJeJDNA7LFjfgCLQRbaxs6TGQxx1
 8hJu7Caop2xOWsIqm0HgrC41pIwqgqpKM9GYf2nKkpZDfEXRCjpKeayW04KaEINxZidW0uutA+v
 hyTmE
X-Gm-Gg: ASbGncucvmnxFaPGFdAkbn/RMy8aXKwtvr3WmPS3hEpUBw+Cp92HVkaZIYJNgAmQwn3
 elqAta+eDxRtYIpHHCMX51X0DDlkw3JKYGtsnloeeYgRES066ayEGyL5G/EQ8lIjZjCs1HFhFcs
 srqtt0uqo+rOsTQGHNI1nyqKpfpTLcnxgwEGMeIXHfwo8Unotsem4IymDS5iPnqh3/qozdSr4N/
 qGRWrRdbI2cCX6+YimP58CHMcSlpQiMjTies9jiAXHFZQrbGUO+I3TvDEYvjsGUw0b+/k2gQZxu
 tG/YUkF2xHmcx/Hr5qchJg5aB1NmOlfde6RrjaFC8dEKKjBmLCgn3sr+CkU5mYQCCGFWcrHFCvv
 63eTaWtxIwYpl/pFNhtb5KMTg2aNmzxYHk/Aj3N0+TMFw+bduDJTD5XvktQyu60K70WKvxB1fh5
 k/nKITZePxHWej1fYXrydty1MrUxXXdb+m4/7dxoWfR4BV9F3k/w==
X-Google-Smtp-Source: AGHT+IFfNnOlkzCVBbsZGleS1EsUnQ1QKey2wQfVq3815fWO8JWD5eDCFkhyAMQSBprxRtppaSJ/4g==
X-Received: by 2002:a17:903:41cc:b0:295:7806:1d64 with SMTP id
 d9443c01a7336-29578062796mr94009545ad.25.1762188600808; 
 Mon, 03 Nov 2025 08:50:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Jian Wang <jianwang@trustnetic.com>,
 Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v3 32/44] net/txgbe: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:37 -0800
Message-ID: <20251103164915.101713-33-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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
 drivers/net/txgbe/txgbe_ethdev_vf.c | 1 -
 drivers/net/txgbe/txgbe_fdir.c      | 2 +-
 drivers/net/txgbe/txgbe_flow.c      | 2 +-
 drivers/net/txgbe/txgbe_rxtx.c      | 1 -
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index 4be7c5d659..b7d0bf81f7 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 0efd43b59a..c1c6e3625f 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -7,7 +7,7 @@
 #include <stdint.h>
 #include <stdarg.h>
 #include <errno.h>
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <rte_malloc.h>
 
 #include "txgbe_logs.h"
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 31af3593ed..660f479adf 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3,7 +3,7 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <bus_pci_driver.h>
 #include <rte_malloc.h>
 #include <rte_flow.h>
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 167bda8019..0bbbf19791 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.51.0

