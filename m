Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987DFC55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05B1D40DC9;
	Tue,  4 Aug 2026 17:46:13 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id B557040B92
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:10 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so3992159a12.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858370;
 x=1786463170; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MQb/CF9igHUM7uYdyMSjXJMn+wtS+0YFBodnyIpnVKs=;
 b=ywRrOQCu0dKOqbXs6cWkOUncZJ3l0PrAF9z3CyXgfmP+SY8BhMgSq9xh/8/gDVQ055
 HI8dEA4Nyy5ymJzjAB6DTRIuCec1YA0B51qQ7/Tm9NEGqWmIS76G6yDntk71Gk3OS11L
 zVk+ZJBbFJ5DU/kzIypjeE2Rx5WG7ArzRXpYinRVhoQNeBg84UvuL5yQLDEQYtZ494fN
 PFeGSgedUhDEviQZlgXUsQb1cXCb2Lfp5vwC/inSEWcpXWu+GI4l6VII9llRVZLvyCb1
 ZGEFimNLa16FDNnrdMaA4WA4lj/0H7dov6sO19xPk/G/9epg4CLA5l5BACduz/iiF/Rk
 XUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858370; x=1786463170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MQb/CF9igHUM7uYdyMSjXJMn+wtS+0YFBodnyIpnVKs=;
 b=iDyrWSU4+g64Pjweh3QQyuy7YKqx0VdI/qpa+Vh2DplVkKdZL39myfvieQV9TIoKWJ
 g/FZhi/dLTXVrTfqrhuCX7n3qKJ/7sp6Ro/Tqlkxnqp+yZTNFb7pqFCPP23IUDmWTOoW
 TlSxZqBOFJcl2r9f29KaE2Dv23U88yJ0l7UF2i/dUCbXq8XDQVFVywR1f5y33A06bo20
 rmA9TtmITSNG1RTqz5rY7ZqlWg+GZOo73sLody3tyK8t8SS/Mu8Ktv2M2S64fv1APf+2
 /ZhZLaEcRlQHyYvvMqVV5/hV9SA9yumWEl3y9CwSAPq3+JIq+GB3eBQhYE6AVJoDLRKb
 SofA==
X-Gm-Message-State: AOJu0YztlReHH8Emad2JKoNus6kGZnf/l6zhIcILx6gwJQhv5KWDWxHi
 d/cJP68mKtoeQLAPMSChoqmeCPSUpNbVvP1ePPImx6WD///nhD9kywj/vcilZ+Z88D4eF6qkAxk
 PZlt1
X-Gm-Gg: AR+sD11NX7IlbP9I0Lh5c9CRYChb1I05iIKfu5D90bT483vnozle/xUMSERaFyTMBfH
 S0wjOccRdJBIFlS0rNliQYs30Q6rK/do5wbrpa/OT7NP9lfix6bhj7SEC2Upbt00ievJuumeaIN
 Q3FM8EgtfZ+7rKdkpEQ+mCdMAkdLTESaf8ndLR5hkGJMKrncY6D998fFEkPVPTWCkgqvVIdMfkK
 4bseYWh6WgUkPvL9jpYHe/Z/MbdMDBJs8vX4u+hKdAPsZbx+Gai05UKtcvYoiKeZDUWzHg7rxG5
 fcJdjyXhxbDhbBsn0z9hFP8zav4NMn67TrW0WVMn066fbNB+AjurR5UwyNMWa6hv2Kj7HuTKL/2
 8IKYWqYLG3SVfwYGF68ZmjJZzwb4XdUaOfyd3gncsi9CSqc2TH3Dxj3jv1ZHOnNn5LrVUE3BGNJ
 bRQeOz2RNirbT/9yUsQXbEFzjjLwZDcGlPRRw+6Bi9hcvc98y0uZ/uQmNKGBiv0z94WjF8/anuA
 DMcOBnf7a64Hv0qAZhdETsVNqQb60ogpDdrjQ==
X-Received: by 2002:a17:903:120d:b0:2cc:e620:e307 with SMTP id
 d9443c01a7336-2d0521e9225mr140195385ad.20.1785858369830; 
 Tue, 04 Aug 2026 08:46:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 12/23] net/mana: include used network headers
Date: Tue,  4 Aug 2026 08:45:00 -0700
Message-ID: <20260804154549.148691-13-stephen@networkplumber.org>
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

