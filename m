Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BABC56205
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:11:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A49B540DD7;
	Thu,  6 Aug 2026 07:10:33 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 50EEA40DD0
 for <dev@dpdk.org>; Thu,  6 Aug 2026 07:10:32 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so1615773a91.2
 for <dev@dpdk.org>; Wed, 05 Aug 2026 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785993031;
 x=1786597831; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fihoI0uIHwuXDRKVh1jaOjZtWk22yK5mMjKdo9Fw+tc=;
 b=VtHWpaZeVxeVMF9C0l7gjfnbHn5vjrPvjXwiq77pId0EF6FNXtOYJ8hNrFulJxuuoB
 r4ZFlklhw+jkBEXMS25rZu8wuykl4XBRQLajhoYE1s5FipGc49MtsgrI2hQn2xpN35fw
 dyD/u7pMIOlWMiPuwoUdPBG1qhYwil+YPX0bfFVWY6IBLJnc28gooqcLruqSEzj6hZ6O
 vnVmQrT9K4Fsw7pq4pb83ej/lQ1llvSlTmKz3nIWjRlpiVX4bib6zuNJFN5Vvz7pvXMX
 bhPH2G6lmjlmFjJAru94vbGHpSomIu0Xg6Kj0+Fh9cy8YN7kN2i+BgZ3jzeJQ5dom+9a
 /RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785993031; x=1786597831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fihoI0uIHwuXDRKVh1jaOjZtWk22yK5mMjKdo9Fw+tc=;
 b=L78C6JeRJ1+EXihSieTUTxv5axwSrbnYMTMBbPUNGG5d2NABVPK5uNePCqsOnT7wDn
 JSJfxVXDH69ZKv+3E4zuW8RElXlOSBcPklk/Q73dfGA9Ef8InP+a31yDM7Pdg82K7FA8
 vqp58Djy4LhTQ/MbDLVHP+ZHjRiwYJLld2bABvKYadlEy75aQNxIFb2GI/jOL5qiIgMN
 nwXPiRJfNrbtcUAhexFXsMdvt0WMpKCeuFnNna3UqIOeB7t8UgZqxCyXwQVh3woU1GiV
 ZBpdIOrGx6EukLdclYTwxepiHF/sTgZhQXTCYIZUdr5JW3GL2T2vmPC998lt07XTy84h
 fwbw==
X-Gm-Message-State: AOJu0Yx8xw5K5LBWwH6bRdXqfJb8fYPxcdLhKT11kvKNAeXeSb4+Am7q
 UUaP3YtIrdKvaG+gfPrKffEmx5xu95V7C4r0+paI3CeIckUNRNzTO7x8MfYNHjvdGfVsrQTTVz8
 LYZDjKCw=
X-Gm-Gg: AR+sD10Rdh7+q9sNQoqmUGxkMacPwoP8rq2d3+cWbbE8OC7bx8A5DmSqvaHk5JWgtP/
 EQ//q3nZkntoMhHFOhkxZMZguobgiEhYM+Tcd7L83Eq/cuKn/n6yPl8qjor8qXhg9dlDuONEQSJ
 VaUe3pYOkzyznodtufK/vZfqAzxz9hTg96mdygrEzK92PoMKwis0wG8VHx8XsQCXrfJ6Zzfv2I0
 tq44jX0zFyPIGc/tWc5OzzKFR85G7mJrZDD4OTRAOZ4ipdZvcWSXZN396vmzBmc4FTpifQCoRf6
 W5Z08HVuNPo81aUX9XQ0pf6Ls7hq4pUmik5At5kztyEHgEsmbds+kXDZAfiR3r1SzbIQO0FdX/P
 1YkOyWOly3CU9dtw8ydW0v9+JnOso/5LT+pGoYD+sgAYB9q6JjpnkAYTv8VsWCg3tNuBT+o24IU
 4JD+ZL7qnHufgihCRda6wGBcLRjxMw8IghmUMt5oWa2wwd5dGdz47M1UXrhhBPNl29tRmkaiTZZ
 ZHaAWtRtergrloizy50Ksol5zbsD8tflUfi3w==
X-Received: by 2002:a17:90a:ec8b:b0:38f:aab1:5148 with SMTP id
 98e67ed59e1d1-3903c5d313bmr12909819a91.13.1785993031391; 
 Wed, 05 Aug 2026 22:10:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315ae6c1fd4sm392780eec.14.2026.08.05.22.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 22:10:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v4 16/23] net/ngbe: include network protocol headers
Date: Wed,  5 Aug 2026 22:09:10 -0700
Message-ID: <20260806051004.166778-17-stephen@networkplumber.org>
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

Do not depend on network protocol headers getting included
via rte_ethdev.h.

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

