Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C5C55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:20:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54B5440C35;
	Sun,  2 Aug 2026 20:19:05 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3FD8E406BA
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:56 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2cc73e322dbso23973815ad.1
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694735;
 x=1786299535; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E8iT7jOEtB+sAdMt5K9i839hfknnDrnS6p4x8qwtnQ8=;
 b=WHJsSdx1Q5PenblJKdaqay44IIPfYRDMnZ0LhibEAwTNhjL071xQvwCHw72U5IuK4h
 GQqxOIUYfluk1uAr8mekBn37z90SrmVig9eoFJ6Df61dhO8FaqkIAvz5JO7BunVXQnIV
 /76ssuUGy0lk6NCbMfk5cpBy2+XRHjFuXns0hk2CcB0xggpxnren65bIPaTOetr5ETib
 KnzbRmm1fkeg6axRWMRcvIdvFkn794HC99HYCGlB4G/YQgET3ourrvN8JwAW8oVN5qPg
 RF4x3E8R95q8newnOmMCJAj3fUiuNBMxbNmg9m2Dpgfe566K99UZZH57fm4qSzJ6y0xK
 FSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694735; x=1786299535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E8iT7jOEtB+sAdMt5K9i839hfknnDrnS6p4x8qwtnQ8=;
 b=kfOAWovwI2IFlKIH7pYBQX5ok3VWpwTu/POy4yhgE7Y1WBg6JqrovyA6m9gDawAL1m
 uIXPjm7jalwFKJ+D0L67psF88flfYwt1AtIMGunc/KdS1yGPsRhbyy/FTJDo3TpjRCy1
 mOEw/FFsBJYpjv2zQH2LSK019oTZLLp+Ws6cnFKJSNfg5o95OfslcaJECXyuZ7GXbg9i
 Cvtoz2BCEfAK7BhkNbpW26ToLlBzuDPgyZkNOOxipVEOBliS/T202a1jiGcEO+vLABLq
 DBEIcHfwcKzFL0UFrEziIlRNkVvWaMilNar9s8O23kafHcAZyVTAHSYi+xF36hZwRW/B
 sraQ==
X-Gm-Message-State: AOJu0YxaAg6pwB6NehUlNt5SmoBN6X2tgNaxu3tz5QrxrgkE9bFkdzFg
 uGJDYpm6E69jIfPs1PwJn+qvFYCcy3AzMh5YcvvvVaxgfCMFgIiukC/TzBWgnvIG7vqkiYkOjUc
 CfFyF
X-Gm-Gg: AR+sD11MAEBR2/47KkNBlp5ZXflb0bXzo4T3LWa23K7T76OGNQAOUPFhWAQSM9/Ms0X
 RbTo8siaEUdAaeY8HDxdhzrSqbvqJt45XR61j1C9EJUQKhmtvFQQ+kyYBcw5AzVhDbHjECiuYhL
 9LqNvTRw7EjwCitSnTijx/Fw6FAvhg0nGKdtKDl/mLZDFomS82PrEUzLihZ6T7WqzOIz1kqI+Zt
 MrSGKMUj+WNeXjSg/AM6g7LWOpUirP5dUVgxE20aI7UoxPRJiVqzW+CNxUPKktBGuTdolwblJVB
 93tQcozvjm95EqTwCLKsP+pUuPZAYyTUnUsQrS/y/+TmxTUhmDhw7C2/d5uHnrxRl3f6/KK6xcL
 s+A6XnXVVpmuJJLE4d7NGBHTfJP/MmmoRDHb8zsEOaRAYw7X2NaORt/jJtAzkH/r34ZZcowiHAN
 BAd3hCLxySqcRzRtDoWegqThiWH+qrik/FwHwN2/Q6HlpX1UoMdjbhryQfopbFJYTxBDtIhLtgf
 fZfi9rAtK20LG7eIj+hPUr61PibhitVC9kj3Rc=
X-Received: by 2002:a05:6300:6705:b0:3c3:c687:a3b9 with SMTP id
 adf61e73a8af0-3c92a8588a3mr7461889637.48.1785694735413; 
 Sun, 02 Aug 2026 11:18:55 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: [RFC 16/21] examples: include network headers
Date: Sun,  2 Aug 2026 11:15:21 -0700
Message-ID: <20260802181835.476887-17-stephen@networkplumber.org>
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

Don't depend on network protocol headers getting indirectly
included via rte_ethdev.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-macsec/main.c | 2 ++
 examples/l3fwd-graph/main.c  | 1 +
 examples/l3fwd/l3fwd.h       | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/examples/l2fwd-macsec/main.c b/examples/l2fwd-macsec/main.c
index 059f8a2170..e07769bd57 100644
--- a/examples/l2fwd-macsec/main.c
+++ b/examples/l2fwd-macsec/main.c
@@ -33,9 +33,11 @@
 #include <rte_debug.h>
 #include <rte_ether.h>
 #include <rte_ethdev.h>
+#include <rte_flow.h>
 #include <rte_mempool.h>
 #include <rte_mbuf.h>
 #include <rte_security.h>
+#include <rte_macsec.h>
 #include <rte_string_fns.h>
 
 static volatile bool force_quit;
diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 5f89286dce..79dee4d103 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -36,6 +36,7 @@
 #include <rte_per_lcore.h>
 #include <rte_string_fns.h>
 #include <rte_vect.h>
+#include <rte_ip.h>
 
 #include <cmdline_parse.h>
 #include <cmdline_parse_etheraddr.h>
diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 349fc37c79..db7b746f59 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -8,6 +8,8 @@
 #include <rte_ethdev.h>
 #include <rte_vect.h>
 #include <rte_acl.h>
+#include <rte_ip.h>
+
 
 #define DO_RFC_1812_CHECKS
 
-- 
2.53.0

