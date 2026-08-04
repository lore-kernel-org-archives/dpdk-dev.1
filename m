Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A220DC55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D66F540DCE;
	Tue,  4 Aug 2026 17:46:15 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id DCE1D406BA
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:13 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso14040665ad.0
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858373;
 x=1786463173; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B1w/wvj4V5eo8Pj+nw3M09LHtB3ROR9sNnP5+nUvfeY=;
 b=lzguN5jrMsc2F0MKtOsi7mMb6NxwTV6WU2WltJm9PEYEj4LiNnPPAp8XXCWtiLLIjp
 NnO5wPe68j44sseCGniniKs6IQPe0aWo+X+rb+WMG1Pevqy9ocWZHgnA64VZygh4Vs+l
 Oqx2+0qfrj5w9w16EOTmjQpan91htUGoln+jAZr8KejgvPpSTWDoA7qd9IQ1JMO4KMn1
 HkdPtUaKAMtn5TIwW2iWPccCe2a+l0rQu9L/9Zb23kpEDIVCbl62iait6aS9vkClJM54
 sQlPNCuBtZ/M4bxSfGpZAGmyiS/fe2w/REfNnVhMvcqKKp9mMmHbcM3OmO7Hob+whepk
 YQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858373; x=1786463173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=B1w/wvj4V5eo8Pj+nw3M09LHtB3ROR9sNnP5+nUvfeY=;
 b=KgEf/rkMFnIXFxz1qQQbSC66mna4/VlophDZoAColyhzv24K/UhfXquER6/Bkk6yd4
 VrT31zJpfeG9cPbojBSDxpnKXb9BW4CkzzgjoR0ZUS2vHvlQyHiHdYNkABqs4u7oApTt
 EMfW4EombFB4kGr7JQn6L2o367osNdNTm3hkrGbAnQEnK3H9C5p5pEuTUjOYNAncvQDP
 MqT6YZfOJtludyl7zLTOHHO/7YvNGcijSttMQtWjWo2qDK5J3WX8PiqreQX2FCc4a8o1
 +crhfg4TLGO1FsUEOPZWsj13jbRfs4/LrJ5MelR7pYmgYFoIZApr63l2LQWpSnaAtH8I
 nLXA==
X-Gm-Message-State: AOJu0Yza2JrBv8WJv862lUa1Rc+09tdE2BuDoZ/aAEcx/ovOTBnD/9Mu
 zogH20/RttGlo797jezswM/XUYf1wNM1VAMuw7xGp8AMLB+OBx/Ch6hGXHAHF8IgHao6ckihOBV
 TjWHT
X-Gm-Gg: AR+sD13LmjSM/rG1sPBQeW+Sa7iWmWQ208nxEB3XOo9NjCzkUNxAvhQ9PZ9eBJFMCDf
 6KeTm+QxX2eP0k/pEIzRBckPwL3yMwA4ywTBYTDzIW7lth6Tv6p+ZcvHOfD/1vTlWgdgro4uNYk
 mhivmGUuosSZSXWfur8W/EFAo5x7pCrCPHNFd9d41Yp5YMOPRN4lQ8ZJ0A0FAbe6IZhtSOku81E
 NW7b5jpxtMz96qaTHf59KUUgMYNSrKVnFv5Juqj9IkhVI9SY9lRyB8stA/8KqVZFjuqA361u5P+
 NJY781ja4q+K4wp8WeHqf9yOrEl6p4nEzaZKUe6j33kkKI2bn4V0syDPwVV9aodKffcpGkFkvGC
 NoOxqV3HiaPqv3wwiAt5Dpgi6tysa0QigcOfGTjUWp7R1JqKuSkjJU6DbumBvIhEyEz9HefK3Br
 5JDRyVuOqfCinZ/rZ1uNcadBpa2u4KO0Y81iKp4EuTBXAAIm+xPMZ8VRmzajY/DhX3GKyWZEn5s
 9Xl6JHse0I7EAzUt6iMwpOMhwQ=
X-Received: by 2002:a05:6a21:329d:b0:3bf:9bd9:cf60 with SMTP id
 adf61e73a8af0-3cb6c752f11mr4538203637.6.1785858373131; 
 Tue, 04 Aug 2026 08:46:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Howard Wang <howard_wang@realsil.com.cn>, Chunhao Lin <hau@realtek.com>,
 Xing Wang <xing_wang@realsil.com.cn>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH v3 15/23] net/r8169: get network headers
Date: Tue,  4 Aug 2026 08:45:03 -0700
Message-ID: <20260804154549.148691-16-stephen@networkplumber.org>
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

This driver was getting network protocol headers indirectly
via rte_ethdev.h. Use iwyu to update to full list of includes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/r8169/r8169_rxtx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/r8169/r8169_rxtx.c b/drivers/net/r8169/r8169_rxtx.c
index 00de0471f4..750ddd20db 100644
--- a/drivers/net/r8169/r8169_rxtx.c
+++ b/drivers/net/r8169/r8169_rxtx.c
@@ -5,21 +5,29 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
-
-#include <rte_eal.h>
+#include <stdbool.h>
+#include <string.h>
+#include <arpa/inet.h>
 
 #include <rte_common.h>
-#include <rte_interrupts.h>
+#include <rte_atomic.h>
 #include <rte_byteorder.h>
 #include <rte_debug.h>
-#include <rte_pci.h>
+#include <rte_log.h>
 #include <bus_pci_driver.h>
 #include <rte_ether.h>
+#include <rte_ethdev.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
-#include <rte_memory.h>
+#include <rte_bitops.h>
+#include <rte_memzone.h>
 #include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_prefetch.h>
+#include <rte_random.h>
+#include <rte_stdatomic.h>
 #include <dev_driver.h>
+#include <rte_udp.h>
 
 #include "r8169_ethdev.h"
 #include "r8169_hw.h"
-- 
2.53.0

