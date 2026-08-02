Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B3EC55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:19:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 063C640A6E;
	Sun,  2 Aug 2026 20:18:58 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 53AAC40653
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:49 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso2015749a12.3
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694728;
 x=1786299528; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YjnajrOePcfvggJtet5xfeP2QmzueniswsXSgllCQyw=;
 b=jJiFoAu6DEMCBQ/sev2zvSdXUIGTpb35ObLWYRv4LqP2pHKuQrGvSIMRvQ8dC81dSQ
 oBcML9tZeIQ3ovOar2U8FjIjmwCX7x2LOtUVyCHjl6QnMeP0UwnpsR7LZLiay46njWsD
 cgJm38dorKhJpSNC0QOVhyu9mqZroKN9PZgK6q4K9wybiQ+l8Ds8Jteo8/AIy7QZzDQs
 aYeBD5omimZwJkjOpTSfXIn/iQF3f2DJyniKlRd2nGanJdvOz+s1JpZdlUvV9QhZB5lf
 YU5LU/kzYYklBo4YEYS4XlSC0RebWxhPufyraDpNe2z57t55FIIkJbfMGfqWyHBSgSXn
 kyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694728; x=1786299528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YjnajrOePcfvggJtet5xfeP2QmzueniswsXSgllCQyw=;
 b=MaWuZ/Nc2DBU730Vk9QIIALVWw1RGovo7grUhvwC5/C+mBniRvqjOdxOrDMpQy6oVr
 oR2nkzRmsIWvDXlPEGXN89UXRegSi5Nn+biFHaQQqKS8Phb4gmsrGXUyTHmZM6XZtSCZ
 U2UzFygVG89LYbwvM6Xi4cIwYtCHoeVIgZGwi+qsWhWg5oGU9sN1lH6TeSlYNCmGXp9D
 1yCzAQJQd+JaK6gp4e6Mes1HpxUy6OTU8FvJCja/7xKI+KRnmp9MkuUkvR83EaJI1pIk
 gXI0kt8ilc7oXLxKxoJHy07+ZYLDY2btB2u+aPnQWquQeSNH1/CcOz65ACtM2zG28w4N
 3vrQ==
X-Gm-Message-State: AOJu0Yww5mq6e/vMaGW+RPkOh92sjkMCjK5DL2ebCPZtVCEDIBP3TNMi
 3VAu8W+PsE7u3WHiqk/Xnb1jJ08YvY7d1Nue8S1FATj78TAmilkpMVtLmOr5Xt7Jt7nW66Mil8n
 f4e3O
X-Gm-Gg: AR+sD104UmKlpsGUF3zPHfknIMDg3l19bvVCgwnxAkFkn1rKMZ3Un/q3nQGkIT+4T4l
 p//nyWY4J2mxbjiIH7grcE9bGnqoZ0KiHZQ4fs61MoFSnnCNPfuwXulcoXTtCYx3Yf94CmKYUTE
 AJe606tU/7/U//I3HvGRGUOlWr5HlD3M6Zlv/GeIw4n/CD4JIVCycMLqew6mdDT7jc9jkkGFkSO
 Da9djwmNhIhAJABxgTrWfOBC8vRcLuFJx7ooD//f27fd0FchPCZOQ/GeGpeOmFT0TjHIA/u+QfF
 HH3Kpx9Pji5Lf6nGzomZ7nDrDSf10VSEwvyspbtkiT1qkCOIOFx0z7DmgED9c9+m9l7MrA4DS16
 SLLSsGWUp/cvUe/qADa9z4Dfa3ZuykUoHyBRH10irwidgliecavVAkt58/KHvkXD3Aj4kzxtV1+
 aPwXqCHzNeyttEt49cZIL5QU1unePgERLTqJuQclwYayOpAh1lxmNRptHYUkR5pvZdyHT3/G6s9
 uoVmCODYNA2LjKxuvuRDGuA084ZmZNu1VEioQ==
X-Received: by 2002:a05:6a20:43a9:b0:3c6:61c6:8970 with SMTP id
 adf61e73a8af0-3c92a4d749emr6659576637.14.1785694728489; 
 Sun, 02 Aug 2026 11:18:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiayu Hu <hujiayu.hu@foxmail.com>
Subject: [RFC 10/21] gro: include headers directly
Date: Sun,  2 Aug 2026 11:15:15 -0700
Message-ID: <20260802181835.476887-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

The gro library was getting header such as vxlan implicitly
via rte_ethdev.h. That will change so get the headers where
used instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/gro/gro_tcp4.c       | 1 +
 lib/gro/gro_vxlan_tcp4.c | 4 +++-
 lib/gro/gro_vxlan_udp4.c | 1 +
 lib/gro/rte_gro.c        | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/gro/gro_tcp4.c b/lib/gro/gro_tcp4.c
index 855cc7a71d..d8f3227c92 100644
--- a/lib/gro/gro_tcp4.c
+++ b/lib/gro/gro_tcp4.c
@@ -5,6 +5,7 @@
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_ip.h>
 
 #include "gro_tcp4.h"
 #include "gro_tcp_internal.h"
diff --git a/lib/gro/gro_vxlan_tcp4.c b/lib/gro/gro_vxlan_tcp4.c
index 29d4a2e13d..653c7ea585 100644
--- a/lib/gro/gro_vxlan_tcp4.c
+++ b/lib/gro/gro_vxlan_tcp4.c
@@ -5,7 +5,9 @@
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
-#include <rte_udp.h>
+#include <rte_vxlan.h>
+#include <rte_ip.h>
+#include <rte_tcp.h>
 
 #include "gro_vxlan_tcp4.h"
 
diff --git a/lib/gro/gro_vxlan_udp4.c b/lib/gro/gro_vxlan_udp4.c
index ca8cee270d..47262bcc32 100644
--- a/lib/gro/gro_vxlan_udp4.c
+++ b/lib/gro/gro_vxlan_udp4.c
@@ -5,6 +5,7 @@
 #include <rte_malloc.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <rte_vxlan.h>
 #include <rte_udp.h>
 
 #include "gro_vxlan_udp4.h"
diff --git a/lib/gro/rte_gro.c b/lib/gro/rte_gro.c
index 578cc9b801..d6b27bf8fb 100644
--- a/lib/gro/rte_gro.c
+++ b/lib/gro/rte_gro.c
@@ -6,6 +6,7 @@
 #include <rte_malloc.h>
 #include <rte_cycles.h>
 #include <rte_ethdev.h>
+#include <rte_vxlan.h>
 
 #include "rte_gro.h"
 #include "gro_tcp4.h"
-- 
2.53.0

