Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBFDC55182
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:53:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 091CC4064A;
	Mon,  3 Aug 2026 18:53:12 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 9BE71402CC
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:10 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ced3386430so36221135ad.1
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785775990;
 x=1786380790; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9SEd10dZejZ4JZxUwmdm9mOezE2U4jT3yrs4Cg2ehgg=;
 b=rUldUUG88J7b82+NCEigXL8oiqCm3JcOHodz/3XouIGnTVYi6Phu+wvR9McmmBKldH
 q8nBYEum3pLMj2FrOXCVK4PG3RmZhlvuSJMQamzzboIqoq2A+c9DjmhdcRsPLUY/na5x
 pmD8EW8S/zuA6FI8KDdHeScN4NkP0u6SaKRulITafetTg14f/E6cUpmr+G6q1D+YTO6L
 t9rCWi2CQexPjHO1J3wgdIJDX3RnzDiHEqDUMJMnzEScS0x/R9VOEAHW/lUFvy69M2zo
 jKQ0oXGjatW5sssESHVgcPMs0gIu7WTZ0W4yxHtRFw+YfKkiIoEZMkT/1crW1DE/GiUd
 LE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785775990; x=1786380790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9SEd10dZejZ4JZxUwmdm9mOezE2U4jT3yrs4Cg2ehgg=;
 b=FG0fKzcI6smL8v/DaGLRqYwk0miuc9+zZOgAlRhyvu0YC8N+WlcOkrPyi5wZyBHaKr
 Nfx0Bj7fF/i8bNP+fvtWVMJWfkQ1w1qHIkYdTRggx0eZFsHtz3uHYZftqHuIq5I84r1t
 eWn90D0c07LGJYN2SSPPOIfJYKmhNAQpCoDyWv7/fXhe7ZC43n44Psz84eyOX2hmEuAC
 6z65S3tWjc+6udroFmZ7pf1Xm5ggFMvcKTeg8uzDTKIdnGRk+GSG45Fm3P2VRHsiGL2z
 SNHEPAm7LVuEYdTke//9uvyQYEGvo1f1ocOyuGeRfeu97/sNLOuDWLrT8FVNjqM/QW5O
 oY3A==
X-Gm-Message-State: AOJu0YxFmAl+oaYwUdCa7fxvWnaCTeP8sZ8jeYxrQ5wC6uq0PfqQbLxf
 IkY7Bl+6jKlXxS6xr8t9dn4wRonFyIFycRcCfQa2fct/XjM43t15yuaN/yNPH7lJK/3YWgUwjRL
 4hIhT
X-Gm-Gg: AR+sD11SyM4axbaghuU0X14/77L/r7JJQRaaQW9ZZeKWWa8cbTSxvWIxhxjxzpkNb9y
 PWb6ShiqLMroWZBuoMSIPl9Udx35i164nV4ypgHj4J2/SiNyYtVZ9BJnqvw6kwW6mF9ih6TWnlv
 YLjjvopEVLDpPe85oArAuH6cm7n598Lbmxq1nf35lrR1QIlsji2famJljBZh7Ub/65kA7BuSXx9
 bZrqsBfmZJyC5i8M7o/eNMW0NZ8T1anhAw9w/+2kxfgalX8gKJ2vn+D2Gl/dFIhA3+dk7+CVXMa
 SoPUPS9NV1MqzBTAuGFm5WcsOSJfHwyOohtkU27VI3FH33lLiqwl/I6wAAo3ZqCwYKBAIwn2lzz
 nOplicC9F7Mz7pvz0h3ZQjbH5OGXNpThQlsKaXDFWFvVu5Mc9ZjS9K1wCWSjMD0KcQiKNexRdiR
 vpECA8HgMDSNAAIVJnLxj5KvrzkLFn/i0D2poCzN5LmCs5Hs/TbW0TpYlhJ/5S6kFTdml+vlcSK
 VrKrQ4mUGNzzPjHgpisNvjn5gU=
X-Received: by 2002:a05:6a21:700a:b0:3bf:6237:b1b3 with SMTP id
 adf61e73a8af0-3c92a85cd62mr9946919637.42.1785775989033; 
 Mon, 03 Aug 2026 09:53:09 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 02/22] ethdev: use DPDK byte order conversion
Date: Mon,  3 Aug 2026 09:51:48 -0700
Message-ID: <20260803165304.289869-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803165304.289869-1-stephen@networkplumber.org>
References: <20260803165304.289869-1-stephen@networkplumber.org>
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

DPDK has its own byte order macros which are preferred
over the POSIX/libc ones in arpa/inet.h
This resolves issue where this code was inheriting the
inclusion of arpa/inet.h from rte_ethdev.h -> rte_eth_ctrl.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/sff_8472.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index 97f231854c..acbbcee210 100644
--- a/lib/ethdev/sff_8472.c
+++ b/lib/ethdev/sff_8472.c
@@ -4,6 +4,7 @@
  */
 
 #include <stdio.h>
+#include <rte_byteorder.h>
 
 #include "sff_common.h"
 
@@ -176,7 +177,7 @@ static float befloattoh(const uint32_t *source)
 		float dst;
 	} converter;
 
-	converter.src = ntohl(*source);
+	converter.src = rte_be_to_cpu_32(*source);
 	return converter.dst;
 }
 
-- 
2.53.0

