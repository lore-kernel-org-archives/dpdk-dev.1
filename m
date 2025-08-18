Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB3CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 934184060B;
	Tue, 19 Aug 2025 01:32:50 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 3F3E7402E4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:32:49 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45a1b04f8b5so23411305e9.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559969;
 x=1756164769; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wqNwuX6nf9Yw8inVXnG7RymGbbGLmPkUaTnb+0uI2g=;
 b=RAxKDWZt05Zqw8wSiMzMcYorVPWRDEQkdCdsA4usXQFfWw4+FHDzbzIo4aD1A2kLIN
 Ze0JCYw/PX2ammrSgHYwCRJAH7cfFhEunzDqSyfqZmpJXw1C6hQLwldELgexEiUacYqu
 Ypt1HzbAqiasIQpkeHHkAzopkokOYcPXhdCgyu2D/GNbdLIy1nsIloUQ5vuTSrJ0P8rc
 15r/p8Nro3XTSr9yGJlsPIBfs9K9zgnvDtVdHZk1d3pld7XDQ8JwNAZ8s3Gaie0IepRs
 zbtj4py34pr4NVS6nGjQX2g7lgo2nsvAlSClebspxUGF3YVIR7bJSKYRDi8SXd70YppS
 drOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559969; x=1756164769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6wqNwuX6nf9Yw8inVXnG7RymGbbGLmPkUaTnb+0uI2g=;
 b=sGlgHiRsgfA0CSvcgsD4JWQ085zqGmTZOY3GXMAHzoTTWXbeMm+dssYIOdTxXeDE57
 Rs+twEndJSSkvfd2bNyL29A/3Ah14exWMIaek22jCAw/qlHHIV9cOXn6E1IdwOucdypf
 O6sAboULyADI5pT9152SkgkD4J5AKpZQr+XtwQorarKpl/qT3sGwqo8RVMQviYoTajpP
 hXhsPwXWGVhzgAzARmODGNpYIEpbxctYmwqEky6p/z6pdxIvO/BOm7stHuNryxx4JNNx
 ezqDqwPSgLpa/3S0Jk3MV0xvMwYBE2wIa9XWKyXuAY28oVmLyxAuWeYZPMoU2VGaqtMS
 UYAw==
X-Gm-Message-State: AOJu0YzYjCFo5f3zm5WBwxYNM451W/fQkQJakbTUWWoDS03HSXp6PcB6
 2LVSYbcytLTFrY/SZ6iAaKaz3ax4shJNTQBYbPyFy479jVtjwp6MB/ZY2riwTfGB4MKYUCST10L
 IAAvs
X-Gm-Gg: ASbGncsheWyAi/YvqpT4kM1s0gLG/A17lTiCJ3Nky4hZ9FZeT/vgh5rpGnfa9Cyk+BM
 d/9mSc8aIur5f0rI1C6cZM2i9I080W4nQGS5Y/5d/DbYFK3/Q9ak289xYtuEyBRPNZwNydlwxNH
 UZBN6vT3w2yY19PmPLHC1TSZFDcsMge/bFjT1L7B2VlexNLCzjEHWuL/Y64FxUhumM3e74PgTV4
 +kxS32WOYdP+sQSug+pPB3Dbux2pDUKJoP2qe2Ka8AZlvinf6c4MkblPMw4jTAwqFOfM2updM9W
 NSxEME2ZPkx5g78yerRMGF9zih/JYIaoUA1CmiVFV38yykJzyapScsCPfK98DbRJ5lAWQ8IWFCf
 1prkVGkbBFHCkcUVj1IHu475Y41slWXuotXxGeiA2FOvyehzx8cI4GjDI9PLbrgFnHWKNpt3E
X-Google-Smtp-Source: AGHT+IGebYusBVdLydeVOzESyl0z1WAIfoNY5fwF/PM7PWW8KMiqkqCR4y5bs/QTcETvkVimXd2a8g==
X-Received: by 2002:a05:6000:22c5:b0:3b7:970d:a565 with SMTP id
 ffacd0b85a97d-3c0ecc3210dmr236312f8f.46.1755559968786; 
 Mon, 18 Aug 2025 16:32:48 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:32:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [RFC 06/47] dumpcap: use bsd_queue.h
Date: Mon, 18 Aug 2025 16:27:17 -0700
Message-ID: <20250818233102.180207-7-stephen@networkplumber.org>
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

Use DPDK not system version.
Not really a requirement but better to avoid any possible conflict.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 3d3c0dbc66..f28392d6cd 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -17,12 +17,12 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 #include <sys/types.h>
 #include <sys/utsname.h>
 #include <time.h>
 #include <unistd.h>
 
+#include <bsd_queue.h>
 #include <rte_alarm.h>
 #include <rte_bitops.h>
 #include <rte_bpf.h>
-- 
2.47.2

