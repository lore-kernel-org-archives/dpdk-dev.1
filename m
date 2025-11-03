Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0DFCCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:52:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 792FF40E22;
	Mon,  3 Nov 2025 17:50:02 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 0474B409FA
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:57 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-340a5c58bf1so2125726a91.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188596;
 x=1762793396; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CluWMr9N/4VCAtmP64Liofe3YBuTG6qc4Exey6rG7dg=;
 b=q8o74syA7jNpY2up4t/VcPBoaLDJ5s7l6Z4N05hMVJ7K9XnFgYtbNAzJyFjx0prAhy
 zrHpdFIF0ZF41OqS58oh2YTBjPr1Rql+quRtBUUHGr8n/QUo5+jaxxJurKDPpDDyZVnf
 26zNQhuRUbuAMQ3/8nZp5EWkYOxRZj/fbMd7N7cjr4Pji2K4Qvekue753hQ6spSnFOG6
 tOdwjxxOdnZHYpr/1UoNX2S7kZs3kaYBOOYWbtKkkABV6gywcs/IiGe9Ob5zPqIAqksJ
 bTLWth1/Y0u/8Ayb/V4aUhwMxpPW98Gkj3p5x4Rh4aJ2sxKqISGJxzvyrC8sND8o7Fkm
 Vrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188596; x=1762793396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CluWMr9N/4VCAtmP64Liofe3YBuTG6qc4Exey6rG7dg=;
 b=me1VwxY274YMOxK0CEF/iuVu+OSk6d+3mgzJ/Vo9X7p0Sfn0Bj/O5iw/fXf3hbMAiC
 tUsd+scFgGjHXhnRMd0qO3Cc2n/oqmpoV2gEhuFStz4kgsXtmRp/95zZfmCx+A+exYiA
 kFfd2REa2yne59ZKfxE7tlAAZb98RUpr3vg1faRBYQ2uGXHWbLUvo2VqWjQTsDEtL3zL
 S27DYz+AcuTNGfFRrdwKTii9n6jrm1FWlcevZaLE/ZleALEwf213QGnbZpe15G0Oi8US
 VJIDwWPV4JRqAfuYXww4ZGEtzsl3QL6BIB6EOPf6XKhzYkqRVus7x8F7pEls00U85Gkw
 XzKA==
X-Gm-Message-State: AOJu0YwgQtwJQti2r0srXVXCbbyQhKxn34o2EW+iUtBFDTLvlEMRmO6G
 nrpe6Hd75vYkyU8oS1jq3QcpEvfw1dnvDDFWDp/LXlNoaX085M1tqAtea6HW3xsEODcRSVlIH4P
 11iuu
X-Gm-Gg: ASbGncuvbepTy0NIUs7m3IwJVqPAnYOx04VFh1ZO8QwD0TXvq5x+GQA6Bnay//nmsnx
 5/aed8BA8Nly7Sb/cDs5n0OUCXa1gnTYhKmQ0Hjr8MDFyslGE1hURVU/7/zlu53r4NsL7A8I8qr
 n3rBolxEcxugmEFRKEsvqSW/IycUlbuvbYvNx9wN3/RtZAFJ9S7kVmVBjQ6d6siPQTHHBRLlLO0
 RTvyuu0uA9ise3ebEHzsI141SXJ2xgIQjenMttCC9pr2EB062I4Tsv89+fsKqblMbKzaGLITm+5
 P1romB0PFWG/ZCbAX/L+/6Vn0/f5IfPxnR5H2x7DkLN+kXFh/UmH8c2WRLthkuEYGi0alQU02HY
 bmTjMfT7cjYEQxRVhiBl5LUkwd39FSHzHPb2s8yR9MgvolJsOdiq4iUxtbthNPGRdYY/SOg3L0y
 woNnfAle4ZiwfMnbGNQTdom0EjSN7nR04uK62bL/ZIFsTKsP5ZMg==
X-Google-Smtp-Source: AGHT+IEPU9HZJl6BWi0/DQMH7IhXcK3U/pU4luO+IXo0PNDMJx4GdS+Hln/jLfYe2CcxmNf3ukaWiw==
X-Received: by 2002:a17:90b:2b44:b0:340:f05a:3ed3 with SMTP id
 98e67ed59e1d1-340f05a4111mr9018480a91.17.1762188596145; 
 Mon, 03 Nov 2025 08:49:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v3 28/44] net/ntnic: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:33 -0800
Message-ID: <20251103164915.101713-29-stephen@networkplumber.org>
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
 drivers/net/ntnic/ntnic_ethdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index f8a01dc9fc..6e1bc16036 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -14,8 +14,6 @@
 #include <ethdev_pci.h>
 #include <rte_kvargs.h>
 
-#include <sys/queue.h>
-
 #include "rte_spinlock.h"
 #include "ntlog.h"
 #include "ntdrv_4ga.h"
-- 
2.51.0

