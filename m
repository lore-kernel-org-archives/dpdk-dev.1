Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EC4C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8378040B8D;
	Thu,  6 Aug 2026 07:10:27 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id AB820406B8
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:25 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so1823676a12.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993025;
 x=1786597825; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0tUNCYzVgqrrLbgYnBcIB8HErUcvP9w7FvhthlGkA1g=;
 b=Wsv3Uxvo78dVV3lx8o+g2Rxo8dSDRwBdWbRY03HNU/IAAOFyCNzbKgq1tGmBbCB3UO
 XSx0dpdbOoKph/6Xpm+TgYqIRmQZ7TGi2SHKouK1uHwQyjnI/HhqdxQIObQ4ltn8bH9C
 3TjuM0c0EI+LM4g+NBMBCSjIcNmQC9bxKiTfffxqS8Wh2GPfpr+3SlD683nZB7of/tPZ
 sZ2Z3E0sBqRpV40LFiqPuwEiBq638xkOWNZ6Ef+oB8sUu+iDn5+4fl4AiCOcBePv5epz
 08ZVJUJ5DCt/MtzGVSWi96RrH3woc3rrDvDnWwm9lZV12D2MJVzU2shrVp45zBfUx255
 d+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993025; x=1786597825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0tUNCYzVgqrrLbgYnBcIB8HErUcvP9w7FvhthlGkA1g=;
 b=O/UoXWe/UGPupimoFahM9g3zZ2G+eeBH5RxUX7hjZlRI9BDV5JpUHlnHh5/A6ADhXg
 SffZ1qSnpkqU0Ct+kM7FFSWOW+QnJT2QhqZod/Kv10Y3MxNBTGSuc4A6NyzdAXVBcVy3
 AtWyQg7p9wNTGbOVmfBRSVwgP9GCyhPJGDtimXoLNXNWV4QnFBhKMHsWV7GD+gg+rZFC
 qiXHt3MHfJaKD1ermevvLkzFy8OdApqkTVFt+x7IANjc4R15MXGGYx6K5FkA+s6WvACA
 K3f0EOsSEDeZMLFVBk3g4BQkbFg+hlg3aYpVDo5vBZ0vrXXOy7LUhzE8E64+Ji8iR1v2
 3k4w==
X-Gm-Message-State: AOJu0YywTCJ87LQ+2sXgs9b/LRHMDJuQNDM8wXjutIa+fVeIExINTGE0
 rnSUqiECe5oPYfCsEl5rWL1yUiLuU1k0LfJGPOcHbUFfa/mnNLe954Kse+b/EnV7DnZPLNueW1x
 96RZxssw=
X-Gm-Gg: AR+sD12bMuUwLphptXATl+yDtL5MtqqDqIPER+/QZQhrS1jbRnhnJOFtz/ltDk9x1ZI
 kmeRH2YK9+vYqq2dyGwAAepLCjUoam4r/P3xiVCikGShdD4n9GsaUw5BveKkqKsReKTRqf2pGFM
 2a4Du3tNf9s5xBagR1HtsAfa9v8RC8KQMhliUXQL9GLUFv/Xb2T0F5+Cc6Dy5FBPHN38auWXr5X
 n8qLyaFGdR4cZmsAqvzQzTFFoHzCmrjtsAeQYNKXSqka7JDf7unVjwohmHwCdPYGcHpMTHdDDwl
 7jZ17Jrvnclcu/yBLalOuzCmzCeCwMVo8LoUVhUCkQIiCzwaHFpQrk8ZNMCbdihWyxRAKGFGEMl
 bm5N5NPOIiP3VBFgiq2lTN6d0KMn1H/dO/0MJwzYgJm/01NIsgMqEYHB8Ln1PgOCdl2a5XtxoIS
 hdQR2m+cuGkGkcEGBdcHdwujbS+XKR+AQwXv+TBrfFPsQt5QS/w3PSBZm4gdtiDxpalRlpKLAcY
 naO/5c6U7IpDcl93hAV/ExrtyFK2Y9I9GsI6So=
X-Received: by 2002:a05:6a20:a122:b0:3c0:e6c3:224a with SMTP id
 adf61e73a8af0-3cb85f4fae7mr12996281637.37.1785993024838; 
 Wed, 05 Aug 2026 22:10:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Joshua Washington <joshwash@google.com>,
 Jeroen de Borst <jeroendb@google.com>
Subject: [PATCH v4 10/23] net/gve: include UDP, SCTP and TCP headers
Date: Wed,  5 Aug 2026 22:09:04 -0700
Message-ID: <20260806051004.166778-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806051004.166778-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260806051004.166778-1-stephen@networkplumber.org>
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

This driver was getting rte_udp.h, rte_tcp.h and rte_sctp.h
implicitly through rte_ethdev.h -> rte_eth_ctrl.h -> rte_flow.h.
Since rte_eth_ctrl.h is deprecated, better to not depend
on that.

Use iwyu to make sure all used includes are here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_ethdev.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index c9a176ff17..95b32420b4 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -5,15 +5,26 @@
 #ifndef _GVE_ETHDEV_H_
 #define _GVE_ETHDEV_H_
 
+#include <stdbool.h>
+#include <stdint.h>
+#include <pthread.h>
+#include <sys/queue.h>
+
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
 #include <rte_alarm.h>
+#include <rte_atomic.h>
+#include <rte_stdatomic.h>
+#include <rte_bitops.h>
+#include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_pci.h>
-#include <pthread.h>
 #include <rte_bitmap.h>
 #include <rte_memzone.h>
 #include <rte_thread.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_sctp.h>
 
 #include "base/gve.h"
 
-- 
2.53.0

