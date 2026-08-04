Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5631BC55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD42B40E0B;
	Tue,  4 Aug 2026 17:46:19 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id D101B40DFD
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:18 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ced3386430so48042625ad.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858378;
 x=1786463178; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tGcdyLJjY6iR2dMv1Ft9l27CE1TMIf13cnrW33wlgcY=;
 b=Yf6xdY3WsPpAs4iPQDiEouBPzzcv9Qxnhb2KIqCiWnaa1ZOfl4kS/NLoWPxS1LnhJX
 iIkkfZ3CUtm4QjFfxyY/T1GF8a+85NPmV2wZ1ddbcVPNHe086z7UDjQuFAugzeKp0CPx
 AJ/20hcnjHsRCi4dVYrlDzDNrKV4sq4osuRy4U2ZF5SUySW1BRLBYkm93Ps3l1G/PJUc
 ZuPi6q/Y4UxhpkTlTYLIxmed9N5lisbbV/xjpEC99tCrL4mnFDU+4wLZ6fT6APqIYmOe
 q4bfaXCBi3QzSAKNBUWez1bK/JZsBUUOGUdMw816GGGlHVqAxnJKQcBvAFQa2CqfwQ/0
 U0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858378; x=1786463178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tGcdyLJjY6iR2dMv1Ft9l27CE1TMIf13cnrW33wlgcY=;
 b=a10Cyn88lnGUv0y8RzzcEsCJ8XMIl1EX5P5wyDuVTC+QAStKOfF7kON2EZemGefnwx
 8FJr6a638fET2ctUd3lWmK8FYeGFIk3SjPjHNzDuvUvu6KlFkS4aFtrNFiynts58EMbU
 ylxkZ7dmCbvwmUPlk3FY4l3+2R3x/xiJ8PwdCKWYeiXIYj6VNZ1G/BJLuo3WO8rLpNeT
 to6kkIbB3UQwQKMhCyhxGdSXS0tqjwh6x1PF0Bd/Bg6uy9R0AsgxZxi+7YEnL8QkEPxO
 PVprpNh4ZUWH6xs1VUBxZ5qb0SlAs57RZRvQ3yFF7XA3yL38Gl4GhvZiAW3iK68z7QyX
 /5Fw==
X-Gm-Message-State: AOJu0YyZWS7clzFeLEyNf4TfHNDpiCtFdQEo3fDiCAJCDwGDZAhCpbUv
 +JxOvSVoMDKeS3PbQSSfPJ9ArmRhFFrYTL/yvkPZ/ZMN9aGz7f4rE/9247K5b111gL56Vmw5fjN
 Zk/FJ
X-Gm-Gg: AR+sD13QiPzhrTmxcgyzQ1VzBcV8q9DWpaDjXz19h9rb0R7simaBYjQywU9NBhFDI3u
 /c0CrzruuL4e2O7xY2113iYos1bIHhsy9gmmWbgfZEz6fDQ6y0LYPKpGQ9FgvGgJ0WQioVcEBly
 pHubwNjtsx32cZD/X5Oh5JMz0UH+qb5sxXgPW8k0gxXP5oSke7JnHQ4Y+gkve8PzDrJKUHoScJ2
 aUgKAl8oFpKemUUmZeCh/07G5a8WfYBH+l387XCQk60vfvykr2i1YGKG2OCRi7AzTg/5cpCr+Yr
 JqmkepjbTOaQrX/nyU2x8BTcEnC5KJAYXvU8tzt/voiKzyilGi8dUXVHjSw8QRiQboOwIAzJu5K
 9975YiJktCvUdzCfPvUKZLf6c1CgqYZwDxW8c9sd9SMnljHSTWg3Eren5eQNJWLDeli9MUui7vj
 TJQwnSGjJ9pXmYKjVlE+fNKSnixYmlhSZFDrXhv6NIWaM2PlsTUjD+DtJZmamFk0Foj4V9z3tdl
 vmjsLHEWfir7OzdZ7vyokpKRVU=
X-Received: by 2002:a17:903:2ca:b0:2ca:6d87:cda0 with SMTP id
 d9443c01a7336-2d0521a5716mr149979095ad.6.1785858378039; 
 Tue, 04 Aug 2026 08:46:18 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 19/23] net/sfc: include rte_flow
Date: Tue,  4 Aug 2026 08:45:07 -0700
Message-ID: <20260804154549.148691-20-stephen@networkplumber.org>
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

