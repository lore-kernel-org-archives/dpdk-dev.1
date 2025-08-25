Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43722CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:43:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F76940A67;
	Mon, 25 Aug 2025 05:42:41 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 04AD740612
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:29 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45a1b0bde14so20686465e9.2
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093348;
 x=1756698148; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAOWm3PjowMSvBqyMP8SpnFUiVY+b4TjoTd23X3UJpk=;
 b=KV19GiFEhPcYAGAPzClEMMJS7BCHjL5cZrvQc6VBI0NJ4msm5oNUCfQCDSAigAYQHn
 uiaz4tsD6bqDIJLKwU7zSpxZR41Lqr+vbPsmRS1HrwuRjOdDz0NUcs9Aehq/E1bkJLLX
 N+Bb2WCr2XE4L7O6meyD2JyQEEAHo9rMlbzS7w26f64Mx7v8NRdlKeZh9h69GklmREEy
 wa+d4l0xwnm6T60ElBTeAnVN9O/VAXROvh9e0+B2XTFF1SveqVk+kBhk4j4A8+CcAYW0
 r41gefneiiJZ/8HyqcVHSnWD+GjktY5OGglgFs0YTSGB8097CyGChwvFUiZntH3LHbiH
 1H9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093348; x=1756698148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAOWm3PjowMSvBqyMP8SpnFUiVY+b4TjoTd23X3UJpk=;
 b=ua7LyGUKEq1fky1k/GmHrKjFGl806nds3cpK3Lygd/NY+hzp6xCVK//UXWW9F3tTDJ
 WOOiUhVLx6rAtgiluSt71okteBMIs9rBIRTHwi0C2f2W12dW7AIKOHZ4hCypTe1fpjU/
 H+5WGzf2B0gzgNZzolvpLZZIn6+bQ93+yj8bRQBOfIiJRdKnHcW4KL9p4vcOTIwF+CbQ
 D9BXJHQnblZEyf0PxfR/TRqZb04c2jR6f5of2/W6Dj2o+StE0CuvmcgyWzEhTyQ9LQg9
 cACWRLXxIOaalhRtTDOANEcBzzb/zAeQmAkvZOZfdyLjQhdLY8DxC8eq6Pace1xTIX1X
 OATw==
X-Gm-Message-State: AOJu0YyMsi0YWkckbtSeVg045aN7GLyejimshOrCOYHuZExPPKeKNXiV
 JkZO1p9uJcCiiZXU6U6niWblvfcZ0jNw+MM0UECavDtCTIt+B+xrrJt7a9gFCdv2sdcP74KNsHR
 xGcoq
X-Gm-Gg: ASbGncvK7gDiBCIyjoTp7SFXgFXSyocZnHQi8rMg46m0bie2CwrHO3CFP5npdF/wwpT
 97blrvhSIPftk5y9ujClc8bNy8laf96wrTMW8dVMYWX3cyiqY98EeyxoXZw4rFFi8vD6jR6O8yg
 q05LiMcTHQsGe2SibGfbLJN2t8Iel2mAPzCZ6FjqAsLmueOv7ZsntlovG1YlLmJ82pNfLQp9Wp7
 H3C7Qq+Ac2sG8RweCXYREoCDh4QPFzrpW7Pa4532JjYdIMGujtZdXbaNfKJT5Xm5yu1jy2S9Sq0
 SlHiB8zT8pc4h0PlHoMKaDv2vAfKzkPT7F3PrfZjaH4i+7XNwoPxLe1FXoXjRCCDLNAh6ZYk4/5
 yuDozEOu+Dm/OZ3VbDYcYTeXk784Vpjbztg9BBSDzhZz4xxbAMBWvDv4R3p4cDEhCsfOqg8pL
X-Google-Smtp-Source: AGHT+IGhEhRhJkmHZ6mF0x6uzcbzjJdQ3y4XR4nMMbu6wAXkcjZPtc4+MCHt12HAPgdV1ZGU5Cd5vw==
X-Received: by 2002:a05:600c:1f0d:b0:458:bbed:a812 with SMTP id
 5b1f17b1804b1-45b517b961cmr94791265e9.17.1756093348632; 
 Sun, 24 Aug 2025 20:42:28 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 19/43] net/tap: remove unnecessary include of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:32 -0700
Message-ID: <20250825034126.12046-20-stephen@networkplumber.org>
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

The macros in sys/queue.h are not used here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.h | 1 -
 drivers/net/tap/tap_flow.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.h b/drivers/net/tap/rte_eth_tap.h
index ce4322ad04..055a9e9b23 100644
--- a/drivers/net/tap/rte_eth_tap.h
+++ b/drivers/net/tap/rte_eth_tap.h
@@ -6,7 +6,6 @@
 #ifndef _RTE_ETH_TAP_H_
 #define _RTE_ETH_TAP_H_
 
-#include <sys/queue.h>
 #include <sys/uio.h>
 #include <inttypes.h>
 #include <net/if.h>
diff --git a/drivers/net/tap/tap_flow.c b/drivers/net/tap/tap_flow.c
index 373b773e2d..99e0bcf218 100644
--- a/drivers/net/tap/tap_flow.c
+++ b/drivers/net/tap/tap_flow.c
@@ -6,7 +6,6 @@
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/queue.h>
 #include <sys/resource.h>
 
 #include <rte_byteorder.h>
-- 
2.47.2

