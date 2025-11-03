Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E351DCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:53:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDD1240E5A;
	Mon,  3 Nov 2025 17:50:10 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 1CB9340A4B
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:50:06 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-340bb1cb9ddso2199584a91.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188605;
 x=1762793405; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qza14c0m22EZPAReYOwEvyIbeCgenlJFAbbi/kqwyrc=;
 b=oxKjvcCQw0zU8Q9rJnYIjB6cMr6WBrajzoS1xGM/Rk9c/s6adwtji2dU8mFLo33ioT
 W+Lv2RKfdLOHCXrNPqhr2HmbCtckDP8j9jlhvjuE+1KvcUNYs+CkB8nVzill/2n/zkLy
 aPRR8hUXjek9YpcWbMWCELkukDDqN85EHTy7/TH3uCouL8XqKkx8NodTsv12XRBv8tDz
 Tr287T4wBxNgt9Q3NxdzYM91/1nwV4KZJK6yn15E8ceFwhARE1Rx7NBNvO1Yc1l+2QVW
 ZGR5U84aCA4UVHrr3xs6zSvfHdcoCbzuPbuGIJ8cl95LbilH0kgVe6DSuKLXb0r6dLf9
 GLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188605; x=1762793405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qza14c0m22EZPAReYOwEvyIbeCgenlJFAbbi/kqwyrc=;
 b=QKbCj7kLVSzu7+KTtTCavT4HhvqTNQ9HqQa/QYSw7EhUvSXpjng138f/4EK1Y5j/6h
 3v7ETLUZNieuvUA+IJnRi8oomgfREC+v7P4ksrsrACHtzk1BJkXJ4j9MD/1t2uMrVsCZ
 MtTepUL0Bf0Q7wA5S2BkElk7Djt631v0gNCo29DKF+uhvQKdf5iObkaGIRJe6O3sLQ74
 KRAkW4doorrPErkAtMy0h77klbJN30zfAmt4xN14mMUA25XNK0KtIXP0i1Uw53WXTSov
 3EyQhlKLC5jAr+lpqoOnwpBgK5WiZSDOBzW2pbEtTbQRj2Jbz/Eoj2+oYOCUIJHK8hRy
 lpmQ==
X-Gm-Message-State: AOJu0Yw3UEIBSCt60Ffvih/YZ1hhpG4Xod8e+7m+VdfpbQgQvufXdK0M
 NokPch8LNuLzHPD8b3uR5yQvwwBwQP2xvJh4pLuxhLtjpYpigIkuflXztgh/ixrlgxv7wkKPcuc
 V69cS
X-Gm-Gg: ASbGncthjkudIqNSmT0uvJmPJeAMK9TGlRgOfw608+s02wOk1GIj7n5keV5IFlnRqqu
 11roknhQD1dpIqgHE45j12q3RcQ86zpqDsFI5il/3SX2S6LJO+6Y+S2024QMc5JFqV9ktq5MKth
 KEcidNDWbyK2hM5dpgqsXhwbxgIzBIIkVhxd1HDUFN/LW8O7L2e8ZDO6uDZQ7juWrqyPaYxkA66
 UvxQc40z9PxwGD5JXiyO3nWgKGJ8xUU5sZgPE4xFu7hBYgOmGGUqNyCN6bOAdhUnENZZkrKo5tx
 jukAXRGOFBexPhjGWlV4NvgQrcFuEuJzQH3P1vjASKyZSv/5xjxumfrMfJyk1VCMWerUSfB5djS
 /+yWs1dr8c8SEEeZTkF3qXTk7RCMMpkVqfJlq4zYqucHkrtlwGTXV4usASrN51zUes1iaqPgmwW
 WHmCAzhWcLG9JlzoENRTLvdkzgddYqYwBNko8VzNM=
X-Google-Smtp-Source: AGHT+IHCXdQxCeA3J8kW4YBVsRi6AjXrbYoy+tiiMNxPzJ4UA98QpfnSmyZZ56jREJnXDUx4D1ui/w==
X-Received: by 2002:a17:90b:2b83:b0:340:29ce:f7fa with SMTP id
 98e67ed59e1d1-34082fa9452mr18210143a91.7.1762188605312; 
 Mon, 03 Nov 2025 08:50:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:50:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 36/44] net/dpaa2: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:41 -0800
Message-ID: <20251103164915.101713-37-stephen@networkplumber.org>
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
 drivers/net/dpaa2/dpaa2_flow.c | 1 -
 drivers/net/dpaa2/dpaa2_mux.c  | 1 -
 drivers/net/dpaa2/dpaa2_ptp.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 2e44bff766..925c65fa64 100644
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
index 9bb1bbca38..ad3a3b35e2 100644
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
2.51.0

