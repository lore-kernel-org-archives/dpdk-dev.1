Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748E4C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8D0D40A87;
	Thu,  6 Aug 2026 07:10:29 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id C12D940B98
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:27 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so19181485ad.1
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993027;
 x=1786597827; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MQb/CF9igHUM7uYdyMSjXJMn+wtS+0YFBodnyIpnVKs=;
 b=I0LUFGjuOLtXAQ7whdLx0sRg7cx/tUYgkeoGWiicJZqCLRLtGQ4nH69OdvX9SFsErT
 t4TeLm1V9Gdb7hIseAa0AkUxcyDvUA/NxOxOgTedYVSIxNjPIfnDeK6cDyjnLCb7UMOL
 5ddrc1l2GpbR0QD0jWiR7+AcaHV6sEtEQ1Zzcq4ZgoShXAUIbsTP7kkYyQwXazFr99nf
 dxjxv7tBKAoUDJcdHn3sfmLFTGxBSUqJWL5JZPCtjXZFwKGf0LT5znLLCY5uzVg4RsGK
 MYyiouFfSiDDA+OFnTy9xlVgj4lDqA95JlEESe6TiW/RZKggBmGy59KabLJE2/GyVad+
 hW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993027; x=1786597827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MQb/CF9igHUM7uYdyMSjXJMn+wtS+0YFBodnyIpnVKs=;
 b=YKB9/5cF5p582yKbIZXARcwYJSs8c5a/BwjTb9elfUYR7bg/+O5EMjWb5GqmdT8CSR
 tX6j0n5Ige9iXY+N0miOBUyE8fOLG78A9jRdpWbedaZJsg9kHYd10x+UzvmSvD/aCGel
 rUirjCDUBuac2WytyXchHFIwvvLk0uvJJR38D3g0TIm0YJ+P+a0HiezPvy/7hC5AlIUJ
 sH/8EJxFmnagrzqI3Wxn4hUz74hCC7L35t4VaoTPf3gjKrfERznd0Bmracsn8RbhBEup
 mgFvWyEwrNalYW9j3kgi7yJi5NNDMYB4oeCRFMca42HtPsWfeLgbscEuzSxv0YZ+ZaZP
 c+Tg==
X-Gm-Message-State: AOJu0YxjESmMjm9rEtxoPyBMD+mmmb0JDr8JNczH8rt9XiWeDNv2gZIP
 rdGwbxWp7XQmMwwbZz7fL50MiB5gqrmfleLnAib8ktI5+zMLA2WsMXTeiQ+NKDgHQ24kXGf6C9Q
 GuBxQOYs=
X-Gm-Gg: AR+sD13jNE2zFidIViwYzLUzeCSGn/v/QRl3yfrMFN4NN5uLIWqORzULbCV7JcHmcPJ
 W5SlzKf7bHTxObhXB/flxD3Uds4+FSPn6+CkuVay6vm57DOY2Ro4210I5iwaunkd3bJDkrXY35i
 3teNS+Yx+oxQWb1p5ro+ZrcR6F629DTZk6eosdi0lfCg7FLoDcK3PdnF5kLg9IoFNdaqv+yB9OF
 +IR4lPM7RA0q4BbSuRsi3OFJx2S7TXXABuaCdJbKfHVXO5sLLgqijjT4pT9mianPEejnW+p/5/c
 x+vURe1vQOHGGL56UXuE0XocY3Aacp7ZNbeCyZnb7c96Watp19ojyPp83gHZhl33pB+B2kcKV+x
 N/89IvpKTlxbn13hm34WcrNiWbsgNSgzAdHShlg3Q3UloU5dPrOHHXobNkxv1PDY040uABypeHQ
 xNV+3xlFjdLHP8w1L3FcsjH9ITv30JPVHU36HO5Mhxe5DE8SCLAHVJS6iaC2S+oThh2cAvuFJzp
 fR95C+v553VRXnLr30HRc4+IC0=
X-Received: by 2002:a05:6a21:6446:b0:3bf:b84c:2984 with SMTP id
 adf61e73a8af0-3cb8a4ade7emr11547600637.11.1785993026932; 
 Wed, 05 Aug 2026 22:10:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 12/23] net/mana: include used network headers
Date: Wed,  5 Aug 2026 22:09:06 -0700
Message-ID: <20260806051004.166778-13-stephen@networkplumber.org>
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

This driver was getting definition of IP, UDP, and TCP headers
implicitly via rte_ethdev.h. That will be changing so instead
include the required headers directly.

Use include-what-you-use (iwyu) to add headers that are
being used in this driver to avoid future issues.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Long Li <longli@microsoft.com>
---
 drivers/net/mana/mana.c | 26 +++++++++++++++++++++++---
 drivers/net/mana/tx.c   |  3 +++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 0b72f711a1..89f6033517 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -2,24 +2,44 @@
  * Copyright 2022 Microsoft Corporation
  */
 
+#include <stdio.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <dirent.h>
 #include <fcntl.h>
+#include <errno.h>
+#include <time.h>
+#include <string.h>
+#include <inttypes.h>
 #include <sys/mman.h>
+#include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <net/if.h>
+#include <netinet/in.h>
 
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
-#include <rte_kvargs.h>
+#include <rte_atomic.h>
+#include <rte_debug.h>
+#include <rte_dev.h>
+#include <rte_devargs.h>
+#include <rte_eal.h>
 #include <rte_eal_paging.h>
+#include <rte_errno.h>
+#include <rte_ether.h>
+#include <rte_interrupts.h>
+#include <rte_kvargs.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_memory.h>
+#include <rte_memzone.h>
+#include <rte_pause.h>
 #include <rte_pci.h>
+#include <rte_spinlock.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/manadv.h>
 
-#include <assert.h>
-
 #include "mana.h"
 
 /* Shared memory between primary/secondary processes, per driver */
diff --git a/drivers/net/mana/tx.c b/drivers/net/mana/tx.c
index 10f2212b5d..9517b033dc 100644
--- a/drivers/net/mana/tx.c
+++ b/drivers/net/mana/tx.c
@@ -3,6 +3,9 @@
  */
 
 #include <ethdev_driver.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/manadv.h>
-- 
2.53.0

