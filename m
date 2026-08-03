Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE3CC55182
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 16:54:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45B4740DC9;
	Mon,  3 Aug 2026 18:53:33 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 4069540A76
 for <dev@dpdk.org>; Mon,  3 Aug 2026 18:53:26 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so4249661b3a.2
 for <dev@dpdk.org>; Mon, 03 Aug 2026 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785776005;
 x=1786380805; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tGcdyLJjY6iR2dMv1Ft9l27CE1TMIf13cnrW33wlgcY=;
 b=YN/phJ6sAvsrAsCddFD+s1OAK7EU6495VnexTDX673k1PLWx0hHh3C1s2w3e8DzjLy
 tVhhaMvsgRTTkbalxQZNN99Pa4aXyw+fr7N9cUHlwwWjEUbSabFd1nHzspiIw+gvpzcK
 eZXfKFUzEmixrdzRYXLu+dUYoNrJOdUu/rv34AR/kOnsErIsVmNDNYEkP7t1BmRbWkrs
 egzy3IRJKDkRZKfToJyO+AiukCjgsHKB29EyaqqVhs1Ua4eOUB88+ZiE8lP4iup40o/G
 swMlyZ6EhzwBcSiUJu9VdrcPgbHRaPMjg3BQDTwrlIGGb2sRgQw8104BkJlQx8wEYEGa
 fgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785776005; x=1786380805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tGcdyLJjY6iR2dMv1Ft9l27CE1TMIf13cnrW33wlgcY=;
 b=ZbV75hu0yJ+aaNqO0lrexSb5mdaxEXskBmObpLoM/uLrALdQaGuT/qohNOknuNehzj
 7NUhIXDjyTIB4EwnnmhqgqnB68WCtRJTaSXHTw4SIw8WxYqy3UVUpLDO5fSsJm/xNXwQ
 9Xil5RgJfM47YmYuc+84wpu4F2gex7Q3vvDNHuVH71B3VaI0p+5nlLw9Z+E6lRt0EDQ0
 BCd8nwztk+Qi0wOyX/2LvQEGP1jdJGGgTsm3wTgCCaEN4TvjJ+82ENpC4hDV0adkwyKK
 j3nnNBjKPj+7KnHEtStM8Oq7ZFULMJwSXNx0j8+JHIJeMkDxmrzgfiMjuPWF4PSG3rUZ
 i3ww==
X-Gm-Message-State: AOJu0YybHBmYkFHMIM9zAMivTGVnbjE2j67onOeTBSVhhgscWM+DOsq2
 SOv9BAWhd1rgFigppGBzhqXWLFzTR5ywk4zqSbmVQ3uiXFwnG4K3GMvikHG7yAXMpBAx4SInJJn
 CzUlD
X-Gm-Gg: AR+sD10GElT74SCnUvSsf7MaEC35fbrnsrvd+KCAm/ohnDhmUdnGnztCyalYGuqyWBB
 mbWYHJOMGhYPvOPsrGsXfZA/UNVBawh8wV35e+zvRu9saX/4pCYlIqiMYmEvg4Jqr4EQvnvr/3h
 f0HJvaMdY7rCfW6pSBcaJ2VMErNvuH5RNsN2L/cp3nBJHbxAZlpR1xN+o+iaa0gDGeB9vnSk2aB
 JDyDqBR3TC94gEjn03MxiUIjOrg9rvTvByZFJ5eUNLC3QYPqSwJ3ZJnTvXykBD4fYYpH7cZrw2g
 0rLvOSent1CinKgB4shkHmOMnKEzGGdTLGgspBF9eQoKrG7Z5ZcsqVXfziqrnFophOlD7NXPlk3
 xzuLvdkPmFWELoyusccLaqY/7j+ECxpig19gQtwII+Ll41EMpbX8kPHlT04MJvi4OH15cWxfkcB
 A/6tMmB5Z76ye8OE7rToRttxwDBRlgDO5knlPpFkxggfR9oOAdoXwAIgMxAxedHnXPG6tWCr+TR
 GZ7dDZtw11NSA60NQfdWYBOKTF9sY8sBaF08Q==
X-Received: by 2002:a05:6a20:c891:b0:3bf:6c08:fb85 with SMTP id
 adf61e73a8af0-3c92a8897d6mr10990211637.53.1785776005428; 
 Mon, 03 Aug 2026 09:53:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e5b0sm37711635eec.1.2026.08.03.09.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:53:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 18/22] net/sfc: include rte_flow
Date: Mon,  3 Aug 2026 09:52:04 -0700
Message-ID: <20260803165304.289869-19-stephen@networkplumber.org>
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

This driver was depending on rte_ethdev.h doing inclusion
of rte_flow.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sfc/sfc_dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/sfc/sfc_dp.c b/drivers/net/sfc/sfc_dp.c
index 7e2a20e4dc..c867c2c2ff 100644
--- a/drivers/net/sfc/sfc_dp.c
+++ b/drivers/net/sfc/sfc_dp.c
@@ -15,6 +15,7 @@
 #include <rte_ethdev.h>
 #include <rte_log.h>
 #include <rte_mbuf_dyn.h>
+#include <rte_flow.h>
 
 #include "efx.h"
 
-- 
2.53.0

