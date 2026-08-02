Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E414FC55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:20:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 327C640BA2;
	Sun,  2 Aug 2026 20:19:04 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0D29640691
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:55 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so1532975a12.0
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694734;
 x=1786299534; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FaUYF577o7UkqTKmAHkrQOb6/ySmR7AldvO1oGh/KFU=;
 b=kZiyb+v1nIReOhxtWpmu5rv8+IJhsLUdClrMgYGKhsuKz7VNTSUeH0W1D1Izk3DkXj
 j0f+UAAxh9OOHIvAU0gFBbUps5IZA2iB0tsbAUY7Y5Je3jkthEdwXLIxzpESpAalOg57
 c1fV6MdzbAvtEM+OIguPbjmwSKFKJ04Zi6YS31PTV8mW13lQS5GzUYZVxEBNu4ogXbhb
 iaUyb9y5g5ThE08qvrEgB4GVmJjUhryOpfsbxKyzIMNBAERNQB7Je8wy5qW8oDHYjtvL
 Q4yjBMaytAqM61v95djGJfdjBmnGwOXoWW2a+OXOuqWxYCIxZRhzxa2fkXIagSkXATGi
 zU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694734; x=1786299534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FaUYF577o7UkqTKmAHkrQOb6/ySmR7AldvO1oGh/KFU=;
 b=hax/k3dhZuL4jWZMa5hT0RSt4FXZaQKSvFGQcgF7vKFPu9mEwG+7PbOwQ35YA/YRyL
 DFAxFowla33p/MyDQlXKfY0ev0S/4W6SnNzPuW2TMAzXwQTmtKf43mkqT4d8YjvFFiA1
 JTQaJGsLAP+viVkmmQI8G5W/8pzC9kGFGRgPPwEgi02R1NvR7NKzY0sCJ6KQ76Et3pN+
 VGuoD+yP0XpBfsTYhzT1QDCzdeXCLemymondt0E1Bn/4g4QO6eC88iekrg5bZ7RMD9Zr
 BW/51T/SpV1RqhzHjhq958N5xv9pzTm1SazxHepPuZjS72cKBDxzIjzuAV7I2V+VwBxT
 6o2A==
X-Gm-Message-State: AOJu0YyqejJNGP3wtITMp+u+gvjWIZePbxsHGZF70pxuBs/CARLe5M0Q
 /S5rJg9W2b/wGWYxu7RKGuUYh0iY57+zezC8/wlZLfhwwJI26PAfBaCAaaAC2qUK33Mu4htuswm
 pvmwy
X-Gm-Gg: AR+sD12cuUnSYsLv6xWdWZpsAJZJ2+M+zl8rJnS5jvP2LozcwFgaPmkdHCSOk0h0ZGp
 pfbnNQk811EHiemsrAGfbNiGZT4zYT34vey80UMOA6Nd83HNVduJD0ImANN9ETs+klLkz139yfd
 drVZYxI3ddVH9pRSAqDPaWpy7QjQskpaTua9pncV9EBa2dsqQX0iQuAwB/xs0Le695J/A2dRqUL
 +p6g/U+yI9QjjuNL9z76hTd7+3vChbny8kTqh3kdXJ4WJj/17pC/uq1sZERU23YpHrM2paXap3R
 38o8rdSQjuJP+DNq9XrevC/CYn3roJy2WxdrubTOJq34lAkKkjsQ9Z8C/Xv2kwoBVKbX60lJuXr
 +berbLqki4oo8XJcJsnTiLEPscJTOQze3EdmJ6GK5sKP8RbQjH+knFznt6PIivTMuaNrGt6ZcQt
 pUx75KSTnrVYFZmcKy4INV3RpctddojWc4HHKWtgORNUhGtSbonbWSaHRlRdRHwZfQx65BzLlcO
 S1734KEELuXf9HWx1M3pTtDCRTolZHRzgY9JmI=
X-Received: by 2002:a05:6a21:3995:b0:398:76d4:c7e9 with SMTP id
 adf61e73a8af0-3c91a9e7a5amr9050021637.35.1785694734211; 
 Sun, 02 Aug 2026 11:18:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [RFC 15/21] net/ngbe: include network protocol headers
Date: Sun,  2 Aug 2026 11:15:20 -0700
Message-ID: <20260802181835.476887-16-stephen@networkplumber.org>
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

Do not depend on network protocol headers getting included
via rte_ethdev.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ngbe/ngbe_rxtx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index a1389de9c0..fee984c396 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -11,6 +11,10 @@
 #include <rte_malloc.h>
 #include <rte_net.h>
 #include <rte_vect.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_tcp.h>
+#include <rte_sctp.h>
 
 #include "ngbe_logs.h"
 #include "base/ngbe.h"
-- 
2.53.0

