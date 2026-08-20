Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F50C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:23:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED84A402D1;
	Thu, 20 Aug 2026 07:23:25 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id C8AE74026A
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:24 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2ceab75934dso21674195ad.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203404;
 x=1787808204; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uI8PmimZGxw2wNA/g1huhW0zP0b2UE5DalbWUB4CMGk=;
 b=0nwe2rW7JBX5PA9Xp4H2+c2j4+I20wmCRky8juHcfagt1w4and9q82LhZxe0ufeYQm
 /oi7TycavlzKPxSa5B5crUlheKa4MnkymuvYtZANAzIH8TNXaLscfEKRuWr+XfQc/fDM
 SQT4iogTzN9TK58/FZe7542vRY5Ys8L1bZCeGXJwTOObgBnyE+a46D5Jhqn1kVD3sfE+
 FONAhaecK4+iwICNLJguOhLuQmHQxiKsZt6I/06Cc9o2Xvt8DS6XjjhNDlSxV8l7w83C
 qdaPS2r7rUcYOXReojh4Xcy3lT3VMgZdAv3KWVgcdIScSnCxX7mxSXlMSC7qB/lrWyI8
 MKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203404; x=1787808204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uI8PmimZGxw2wNA/g1huhW0zP0b2UE5DalbWUB4CMGk=;
 b=M4oZMlSSP4SYHmxGsSv3DaG7O/uzoiVbSxXPhx2GXRNCm0/73AXHeFJLwGuVro0owB
 E3aaoU3nj3jOc+036rGJJ67eQGCGCrMds/WqV5kK7/Yq6vE6a2wsoB1rp9ry2baC3IVl
 mmLYw9JaplkjGzLmoeAzTnIMVXTfl3kp+3Pv2OeVoJDUNK8Xr6DK6c8FVuMMcpXYWooF
 +MUwvmgawWWGqb5WHhqxS1tuZ21obsQMrbPgbL/sXjd5ySWpo2yPrQdOggsR5y1WkJ6L
 AQzLZbE0/Hh6JG6EEi6ELcpRUngQc8tqpKJiLSoiMS069jWCWwVld6ISKUivJkU1YnIZ
 VDMw==
X-Gm-Message-State: AFuF++nBrKducipRmhuElLhyFJWq3bgcMk1F3JbOnqPr5blm30+LAAFn
 VnHCLZBCrhCfULisaByAOljAGk3BAnuP/aGPaWpAjD4uWc6MG+uy9GValivLoJi2vpdl3XtV81m
 QCidc
X-Gm-Gg: AR+sD10xq68K7UeSsniI/c9CT4x6gcwAu+Um2kDM8iPaHGmFjEYeD9TNOWSKYRYv9Fv
 GqXOmORwKHr3ZzKGSZ83Vt4XhixF18B8TYf7i9Zfp/wkyoUsoCCSQIXg04RXotxEEVLC+ftPpB3
 32yAUG3x1SOc9EmQIJZrIKF98TvFjCyKafUlpDhnYkDke0oDAymd0gdxEI5muhjOW76qyWRyjPy
 //6zeLWdAtyVaLv9+uBemuUKzcEkGD5WfUnsRSYqeLfU4ks1h89A43oJiIYLX3MrPlY0swmu99S
 IWigrmvsdcKZv9dxpl2X0G6y+uzKOzPOzwBwCqUVf9mR4eKBtO+Oe7cxW1F162jmg5b5I3LWzrv
 h6AuY2haf4P85VzdDAw+YhYzmFeOzZbqlzKCyiHoscdHHrylPP9AI0qaJ18PKLVPflleeUwIGrE
 uRLZ9zu/Bf6ZDi8N0bqLKnqncHzoXiCkwqZ6XQrBvnPCo1yPaz0YcQINZxCempyVg27eOzOc5Uy
 43LbWJTyyiP8Hfq2Te01/CrsSU=
X-Received: by 2002:a17:90b:544f:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-39580f0943emr20330446a91.5.1787203403913; 
 Wed, 19 Aug 2026 22:23:23 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH 05/61] lpm: remove unnecessary include of rte_memcpy.h
Date: Wed, 19 Aug 2026 22:11:55 -0700
Message-ID: <20260820052251.1453273-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

No longer used.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/lpm/rte_lpm6.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index e23c886766..c3fb795c59 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -12,7 +12,6 @@
 #include <rte_log.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
-#include <rte_memcpy.h>
 #include <rte_eal_memconfig.h>
 #include <rte_string_fns.h>
 #include <rte_errno.h>
-- 
2.53.0

