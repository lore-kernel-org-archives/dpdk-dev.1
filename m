Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C95C55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B97540B8C;
	Tue,  4 Aug 2026 17:46:10 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 61ECC4069D
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:08 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ce87c7e3bbso50940485ad.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858367;
 x=1786463167; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0tUNCYzVgqrrLbgYnBcIB8HErUcvP9w7FvhthlGkA1g=;
 b=rjBTvM8mVhoAprQKemjIHboihei49SES9+d+a8Ipdm1GnzfpKvCgpSzi3bH3dz1sPe
 ohxMYAdcsl/7w2f7WCG10VwBsFzgkkd+0Z55ErPplUbl99DWZehnZ5yQFMhslvojC3cZ
 6MGWXSSUHTYUO3oykunsg/w9+DzolXltJe573iGFRkmEhjY8cPfKnV1J5EOj+nac1n9i
 JIzj1r0oLFKSOdG43++42DPY9FHrsQ2dfgpN0ncFhMRHslNbzwFiYqT19sZjDnmcMyfK
 wAdmZgfRt71J3oDui9D0TRR5BP3zMFl89hNk0VXChXLUWutaZMTiJqlHE7JTMMEsCbKc
 EP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858367; x=1786463167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0tUNCYzVgqrrLbgYnBcIB8HErUcvP9w7FvhthlGkA1g=;
 b=T9/pSbedSBzkzmR6XLsZvR63Gb++idiE3NEeZv6Dwzw06ufWMJ9f5pfMAefE13emzr
 dcfkC4Rk+LK+3iUWlLVqx7uaEMTmy79E8B+Lp71zj14QzstcnZC+TDFOSEorIg6U0yoY
 pCQrC8VR6TFH6kqjSaPxRnEkOtu7/JN1bRQ0gLDrUgUXMvN9Z1NaVJKzg/bIVbH+biI4
 GOorXgmLyh4OKjuRVPI1wNvySIwu7nHrObLkicHqj1VtLJho1vnYGvIumEl70IE+eSoL
 640+KZ4wHUAWPC7+BkzCMzs2kEGAUzVx4HNirpajZ9o32YZzJLGiduqwriC4wTWvHi0R
 TgHA==
X-Gm-Message-State: AOJu0YyImXv95IR+xA+wpF73svRf06sVMLWm9sxnIu3FJ3iYFJHdE/KR
 GuG2IJJ6FJYljQwfT5tNNhV7nzjHK+QFHVXj9e8tEu2Nr3knaQXzcbFXqil5rsOJUgOsJLDVQZx
 o7ggs
X-Gm-Gg: AR+sD10Q2eiVBinltZtBBll+qUdv6eRb4is9azb8sVIcoVSN04UfCdnKGnvTlH/LDRO
 InnnqFtASObG3qzeQvjfJKjh+lqX3ACOMq/8cp3h6FPwXuP8qph4JIsqZOwtKFDkU7wP1MxkFce
 gB2BksdfMcSESRGsNaDgzeXniNkrBGCiEiesB16yRSDQ1L4UunRoIzUOlEwZnrl8aF/4p4TcALF
 gCDcI8k2kJlMlNU7JgPtqgux76lK82nrX/6UWBep1UI3RZe6Cjd1N4ddZPao6Y0KVuQJRGSxS1t
 oFAvol5HSVposobLFoPAgH53GMiFKz0GVTNLXuxD9q0cRo3FmsFmCjLSFahC7qNMVTTBDHhKofN
 3R1ZTMUv1iO9X1txbLmpp4fmilnMmZ8cc9NvouaoS5eZjd0pDRc8EA1rruR613kgRWA+/zIZR4/
 lRuU2oba3pykveBCUBxNL6ce0p0HdLPg4N2g8C8/UqhajiNAU0e8koAKEPbTC/JyuYEpXXNUdZT
 WQxKRnf4b+9w3bn51j83KFlQAs=
X-Received: by 2002:a17:903:3810:b0:2cf:b23a:3e6e with SMTP id
 d9443c01a7336-2d0524740cfmr157091865ad.40.1785858367437; 
 Tue, 04 Aug 2026 08:46:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Joshua Washington <joshwash@google.com>,
 Jeroen de Borst <jeroendb@google.com>
Subject: [PATCH v3 10/23] net/gve: include UDP, SCTP and TCP headers
Date: Tue,  4 Aug 2026 08:44:58 -0700
Message-ID: <20260804154549.148691-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804154549.148691-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
 <20260804154549.148691-1-stephen@networkplumber.org>
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

