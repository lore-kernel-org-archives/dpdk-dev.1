Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19353CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 902CE40BA5;
	Mon, 25 Aug 2025 05:42:56 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id D7F1640A87
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:48 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so22369275e9.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093368;
 x=1756698168; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JN8xjKcWPi0AVP5Tv6xzdkGKJOoQg4lXq3oOkm95hDk=;
 b=eaUNNPgoFkvOFK1E4G4J+P+SZ/2hvV4JrXrbarEqfXg7XQlmMICFEmJZFxUF/sMi49
 0j5CyOQZiTZqCqfa+ejPxRTImpVXfilr5HTpXgl+tCrPOK+OlkU8/14ptxKddHneBZqF
 xD+E47c7jdqulrBor/GqEBuv8YMdmFcDrShTd6to2uXA2MwZuNc58w4eDP4tkevdpwgU
 HgHcVtWxNPDCmJP5N1cFTQQDHKoFHKHyOodwjsYiQiQ5M2VZ7xpkRJ8gfI8F1NEK+fH8
 SUxrF5Cir+FT33ewNG5wEvGqzcq716zGdD3MdJC37iwRNDroaZ/jRACrYYvl+NXEgstV
 Srnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093368; x=1756698168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JN8xjKcWPi0AVP5Tv6xzdkGKJOoQg4lXq3oOkm95hDk=;
 b=ghnkbecDEiXYuIC4ZuJ+rFz4/R4nNx4Geae6F1r8UhXV7LnfWUGEA1So/UPZysX0wn
 N//VJuuAHSRmmRVOg3hLLBMgI0KAHl37Fto5ZL0Zbzvp1hXSSHEW42t7Lk++JOjfHr9X
 C5ZEgaihpz0+MsNbKWN+QDhDFuemwhttT8jlSeBfF/R1dDrPwviFpTtUnHztFU5J/fTW
 VooSC8HmkncSSd8GlYeALxtnriMhZ/ZLW9AMqXCo9wHzYsnZwwHvEr1mQwz5c5ch06U9
 l6Xp969UdlQ1KEj7saUrIjfuCNFKMnDkJ8ufPnOSdoBnQq30rRosu3vhHNemi6GlFw+J
 4rgQ==
X-Gm-Message-State: AOJu0Yxt/7nXWGWNP3ZTckgQen7uHeypuTYanexkgFMacMEtOhXq+uqx
 FAvu2bqpRzAu+0WpQX5ekTk94FvS1YrkJz0cJc/XPw8xpO78cwhAVyxDM7kE7ikaazL4v1ob+LU
 UkmKT
X-Gm-Gg: ASbGnct64hlRC5oWPTcrMLSgk2W7LtsUf2cxX5Oxq9r1qzGhR+HGKTN62Vq2JZQniBd
 dwpuXmiMCQ2jE+zvzjOuoX9et395bVp1DZduOJOlFJoMckAYXOp/d1q9N01k1itjsW/jABkVvWC
 ZgS2yiLu+TeCbII3F/Cpe9gxeWh1Z0XWQCSL0KLCzNxVfEaXVwHRua15U0GXnWWeSecxGWof+31
 cf8zX9ssaVSZjchx1w0nmGOe6tasLZYHif2L/iWmoWT5fL9v3K10D/dNpa2L/fXyUChPTc8GXjs
 I3q2kZJd7EwFO/NKmsn4haHKK6iaxVuXnxfKFZhzhCrRcJzYJmpla58X7s/3DXUqrVYsUHdIcbA
 2edmjA+aP9gknTec7dk3POsivnYmjsKJSzaeNQfhUu53Z/csDMS9Xb0I3K80hyxktX+iiwU3I
X-Google-Smtp-Source: AGHT+IFH4ylBdHvFv8Hp4Ga5R0+SQImg8lOyBij56SKQD0j5rkYgm9I1xQxYng2IB0i00ixLkcG4Cw==
X-Received: by 2002:a05:600c:3b22:b0:456:2212:46b8 with SMTP id
 5b1f17b1804b1-45b517dd798mr76660545e9.28.1756093368498; 
 Sun, 24 Aug 2025 20:42:48 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 29/43] net/sfc: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:42 -0700
Message-ID: <20250825034126.12046-30-stephen@networkplumber.org>
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
 drivers/net/sfc/sfc_dp.c | 2 +-
 drivers/net/sfc/sfc_dp.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/sfc/sfc_dp.c b/drivers/net/sfc/sfc_dp.c
index 7e2a20e4dc..66ff2ed789 100644
--- a/drivers/net/sfc/sfc_dp.c
+++ b/drivers/net/sfc/sfc_dp.c
@@ -7,7 +7,7 @@
  * for Solarflare) and Solarflare Communications, Inc.
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdalign.h>
 #include <string.h>
 #include <errno.h>
diff --git a/drivers/net/sfc/sfc_dp.h b/drivers/net/sfc/sfc_dp.h
index 545f0f32bf..6f61b20a0f 100644
--- a/drivers/net/sfc/sfc_dp.h
+++ b/drivers/net/sfc/sfc_dp.h
@@ -11,7 +11,6 @@
 #define _SFC_DP_H
 
 #include <stdbool.h>
-#include <sys/queue.h>
 
 #include <rte_pci.h>
 
-- 
2.47.2

