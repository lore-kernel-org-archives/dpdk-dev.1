Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1638CC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:43:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C64E40671;
	Thu, 20 Feb 2025 17:42:23 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id E34F54066C
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:16 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-220c8f38febso24483165ad.2
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069736;
 x=1740674536; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4njUr5dkOHDc4bLiHbc9hRxitSjOZs14bwKzJu4y3NM=;
 b=uMnd76f9YZExWg9B0tnBGpyh+k44hroFnVw9qbLQDYnhpEiNA3Y6MXhy4f8bIFbdpz
 uESiieQywaOUclOBQVAZU2MJZmzl3PHRW9gA8tdx9i7WlhMb6VPjfgNAhJPzYs/7z1OF
 awkME8hIcvcdTsJ5AuVae0jmB+Rz9qO0muUmTBXpg8qh166+aE2PvCCTSNGdc68mm67m
 1aG20VSKP1yX/1PvRiT23HHdaOkKyf0/DMD6fu2iaEXsm46YjOb0CNUkbtqPOgXWBRuS
 HWR+lrof6K2jwOcebeQLfym0Tb2d7sWeU9z4iXqSrGpUgDxIF3Qyi477JZznCDOKCU2T
 MhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069736; x=1740674536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4njUr5dkOHDc4bLiHbc9hRxitSjOZs14bwKzJu4y3NM=;
 b=rgLS2DNwSaLRArqvj/nue7PvywXTvKCFcdsnIhWaPmESrO7nmIdWTfzE5Mbynbi2z3
 oMBLY0gJtY73j+vHTnqgnb6wQTEC4+MbvCi7Pm80wd6LP006gHcyjta38Xr7MHtcWDTt
 QH792AP8CiBBfmxrR8ihYcC3rAHVLy4D72KZYINO2QAQaNuHHc7sCLYfYYk4Ya7YobnP
 ynbs92PC9NVAUNAMQD/5uQDqSN2Z/Lhp5+50GuRwkLowzVU997kBlzyZnkFO5Habp/0U
 KMxE42681VNeomoZmRUPprnxiOlG0rCHm1nGVdmOeVA01p1nPqPuRg/YiWOVIgwy/1Tk
 t2rw==
X-Gm-Message-State: AOJu0YxJyUq0NrxL+BdrMGxEmnzXYhrV+OL/o2ydcpeoONkZfr/66ZD+
 rUz0+pEoUY984CerK+ZMnR5tnD19uPTg7Su1PD1KMqpDg2Mj1avN2eUF3/jNRLvfbJsqTR+eUQ8
 h
X-Gm-Gg: ASbGncubZ8EsT3hQIkCRbbHjJuDlA1AO+an6mwZhGwgT6kERCubzeo3J58zvL+VCJWh
 rdi9PVyg6fI1i+L3I9gx9XjL2g1CfZbQ/9y0tNmPeLksnapCzIF9lJ0XT0pGwmAWaXDV/19E+Mq
 q6Ehe31ZhlOqMa2aA3MZENEMZf/Xwou7LRLqYN72gV0JJontstlI9pbOkZ2guIrunKpLSUKSIB7
 vtlGXEMeyQdl74qf4z8Ay1AN1SfMN8cP0co5su6c6f2MYEaSlyuGOcSG+MbF7mvSPSIsVuFmb7R
 bPpvwhZkTQD3kdK3mSObJ+TvZ4q2xtA+8R6LPC6XB0D0b/Q5hdRShnO8JZ8b6kSvwH2P
X-Google-Smtp-Source: AGHT+IH2Tqnmm41d2ZumUXnvGT6SO2V4qDSr9bIo/+fQ+IDJqDjTCBKREMmP6Z5L+8VAwCV+FqeVsA==
X-Received: by 2002:a17:902:fc86:b0:216:7ee9:2227 with SMTP id
 d9443c01a7336-22190690168mr57657205ad.36.1740069736155; 
 Thu, 20 Feb 2025 08:42:16 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 15/15] devtools/cocci: add script to find problematic memset
Date: Thu, 20 Feb 2025 08:27:21 -0800
Message-ID: <20250220164151.9606-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
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

Script that converts memset before free into rte_memset_sensitive
and memset before rte_free into rte_free_sensitive

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/cocci/memset_free.cocci | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 devtools/cocci/memset_free.cocci

diff --git a/devtools/cocci/memset_free.cocci b/devtools/cocci/memset_free.cocci
new file mode 100644
index 0000000000..96334dc8c0
--- /dev/null
+++ b/devtools/cocci/memset_free.cocci
@@ -0,0 +1,9 @@
+// Replace calls to memset before free
+@@
+expression E, size;
+@@
+(
+- memset(E, 0, size);
+- rte_free(E);
++ rte_free_sensitive(E);
+)
-- 
2.47.2

