Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8569ECCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C41140A71;
	Mon,  3 Nov 2025 17:49:44 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id F02DD40A4B
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:40 +0100 (CET)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-7aab7623f42so1671441b3a.2
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188580;
 x=1762793380; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6IqIdwLc2GiobJizkwwzKimM6aYkEynMbTwu5BbBFc=;
 b=UoYEkkV31VdukdUCkjqDyauSFdnsZB0yep40feRhPxJ88sz86WgT8txWO6lmhmMKD7
 DOKB3F4m2fSzoG+vsJ59jjv7hFu37osH/Hpvlc2r5ai9xmw3HG/jJjDOsmx0pv9ntnG3
 W0eNffr5KFuzchhpXbOsR5bOS4NiyzsP4S9zWyttM8m5nKENFsDSd0Xos5X4DXS1OVz/
 WYq5bDaPmp7QG3TcHh36QkkWQQSTYiKCC2kOJ1dj4uWoEf1DanAhdzYYWREsEpUpz4zM
 Ah4Q4lwj8+Tv3oFGOujoSIwF5ZgQFvIooaJnu+f9q71EoZuZVVOaKMYI+hqHIIBHtskb
 RmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188580; x=1762793380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G6IqIdwLc2GiobJizkwwzKimM6aYkEynMbTwu5BbBFc=;
 b=qFIXM5SgmGRcuhpd26JPWL6rrBfzDuUagYmnkjDHdkK1X0N46u0fm83BH44Zl5uXZR
 ELGRCRcSqQEIdtBAQGEmOHXM+qime1Tslbs70tCdTOp6DCsyQ0T0ybqWtcHKAgMwqGfe
 WzGYICVYX1fh4I2IoLrtQzIHjVybf79lYOOnpaWcxXboaJ21JM98tFOfL3/gc7Zm+3j6
 oQjHvSyDUEhE6ydjDu/mmm3swGUETeXUYym/1Z0ptUJixiXjQCrWiric0rqjuebRpJ+C
 bTzX3/OdaaLSXUahyCuEO32//dFH7ypSRP0izWB5YQmiJZIVp6yshYBpYEsyifpqyTUI
 jQmg==
X-Gm-Message-State: AOJu0YyOfLqytNkI26yvR2aKYLT2gNHcCznR9jeAZfZy3sDIFiEfgpTV
 NV8Od31zaNJuVQEzsgV3G2M9Tzz1Z/LXCx+UaWrc6bWRlb0+hD8bX4pjXjTOTJ9ok8zluAGD1cP
 k8hSm
X-Gm-Gg: ASbGncsYLCFv5Iyt39bOwecoGisp56OE4sAaIXmX5uVh2t/1b6q8fdFbnturPN/rm1F
 yPa0nrpx9o8g4PKzcnEp5Tvtbu7hoIGKv/qakiQAVyWz0xJ/gF9rcUbwDZ1tHdV/5MI3QuaFRcA
 r9PVVJ+7f3RHMP5ycg6ZaOgkkh2zYyjRHSowV/jSQLdWRl9t/CGYOpeYbYEZEqS61mqq4IV+kcC
 nec7ynYQ9Os/dFm4WYeXGXNzGjXa6SESaw2a0A8b7C5vyZ1OhoCEj5sGg3BG8Y1CJfSCkxcgdd/
 5OQQSwMHtaXwhFBNu4sATxiM4m1BHQEGumS0o2cj2tNtgArhPsLuxEobh7FrSVGbd/F/RJfOblI
 JCDd+yIt5AMcLcRcQ7RQQZqSNk4vfuCYJ5k0Wn5U+ALQwq9eWbZ7V5e3sg8mh5XBBNK8MPTOD3o
 YPNFECxyEyxreoJqgxsuI35dS0Dzjn/XmR19TdnHo=
X-Google-Smtp-Source: AGHT+IFYiarZ5vL3kI5mKIJQgVU/4r9rD3cxihn/GCZLT7jDTjpTLVuwn+cZEPW65Wd8Y14a5I0dCw==
X-Received: by 2002:a17:90b:5288:b0:32e:5cba:ae26 with SMTP id
 98e67ed59e1d1-340830747a7mr14542048a91.23.1762188580025; 
 Mon, 03 Nov 2025 08:49:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Subject: [PATCH v3 14/44] net/qede: use rte_bsd_queue.h
Date: Mon,  3 Nov 2025 08:47:19 -0800
Message-ID: <20251103164915.101713-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

The BSD version has the needed SLIST_FOREACH_SAFE already.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_ethdev.h | 3 +--
 drivers/net/qede/qede_filter.c | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/qede/qede_ethdev.h b/drivers/net/qede/qede_ethdev.h
index 3015c18504..87fbd07ed6 100644
--- a/drivers/net/qede/qede_ethdev.h
+++ b/drivers/net/qede/qede_ethdev.h
@@ -8,8 +8,7 @@
 #ifndef _QEDE_ETHDEV_H_
 #define _QEDE_ETHDEV_H_
 
-#include <sys/queue.h>
-
+#include <rte_bsd_queue.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
diff --git a/drivers/net/qede/qede_filter.c b/drivers/net/qede/qede_filter.c
index cecb58c997..958ab558f3 100644
--- a/drivers/net/qede/qede_filter.c
+++ b/drivers/net/qede/qede_filter.c
@@ -12,12 +12,6 @@
 
 #include "qede_ethdev.h"
 
-#ifndef SLIST_FOREACH_SAFE
-#define	SLIST_FOREACH_SAFE(var, head, field, tvar)			\
-	for ((var) = SLIST_FIRST((head));				\
-	    (var) && ((tvar) = SLIST_NEXT((var), field), 1);		\
-	    (var) = (tvar))
-#endif
 
 /* VXLAN tunnel classification mapping */
 const struct _qede_udp_tunn_types {
-- 
2.51.0

