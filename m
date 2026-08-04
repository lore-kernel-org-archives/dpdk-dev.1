Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89A2C55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD79F40DD2;
	Tue,  4 Aug 2026 17:46:16 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 31DAE40BA6
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:15 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-38fdeaed181so2310692a91.1
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858374;
 x=1786463174; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fihoI0uIHwuXDRKVh1jaOjZtWk22yK5mMjKdo9Fw+tc=;
 b=ItcnNazNld3HPoJrM0r4Rxh0vTbHR/BD9DNziCXk8mlJVEJFpYehc8v35jwHw6qcaO
 v470A7UUKpe35DyUnvZp+VQ8GUa3/uW8LhBo91VDvffzvBsbYJiQStkzfdb04sDZrC9T
 ATZdGe91F2SAiL8OWGAKBcHf7q4T9iU1F5wpJLDI/e9NQu0EkRexWm39JnDWFlSgZCEu
 zV2hEYoFBpwugZTo4VwGKzpaJb4FP3CxFz9+ew0BF/YbmlimCWdZawcWNkDksaLHd77O
 FWqh58BDLoq+O9/CbQ4QJyqpTtq6/aBJrvUIDQvLLY9DSkC1X7egswBBtpdVKKJL5X+a
 PmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858374; x=1786463174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fihoI0uIHwuXDRKVh1jaOjZtWk22yK5mMjKdo9Fw+tc=;
 b=MewFcRpgYbtvthZ0B0geeMN2fjKbnOrdIFACxwMlLT2/q1wwrchYArvUuPyucxYxyn
 4s2iOjZgbxT6PE97V4cbHkMfXx7teSWVxYIbJdZhdeGQIrwEbtq0dTcryqD19M4hOUyz
 9cX/s3Tst8UUTJ+hyitgLWZ2HUrEWLaUoF5HDkCYGClPhDvbTA+TQLHvtI4LxvymJeOQ
 eBYcvVfZWhrCu8Cew4ME5fxSZMp59FHtNsjaTQb+6CxTOQTva2mjZMzO4DYuoVel20Ix
 6Ely8dJ/tXpTNOV7ZzgU+jx9SSvfJHnIiCk8l5KNYf9vsh1iWMPJS5x5MWuMaJlIinR2
 1Mdw==
X-Gm-Message-State: AOJu0YxPgAlSDtdjsGpeABEEsKOoFWCp9ndN6ZsBn8kykP6ViIHBzMuC
 4U4BAD4kd5c01bGN/flHVFH01nQj7JTQ6HMDMqzk/G1u2EqOQmQ9Y+JOAO7kaUonCc0zP5l0AtV
 1K99/
X-Gm-Gg: AR+sD12bawqO6M/HtV0J+ni/kN3Atf/Qa7q978sOCSkz/XwlglKD0Ksz4E09faRWVhp
 0s3/90/VnqtRqPLBo0HXTx3BWuLnj2g8okKtK/7JKv4hxHsgH4KG5sp2LCsTZPqijgcTx4pG/Um
 h/YTvom/LquZJcEN6M0IZBUb8owalj6XRTu9xUgNWPQTRe4TRQmIf1qDBj5yAUHlxBqvjJ4ccNk
 mreVH4UveLILDrOKUQ8AZirCECCOPr9sHddIzVGkCwUjTUMKjxjrlVqWoPHQw3MlV8vcH0JnVBt
 EqKkAWIMNeS6rereTD0amfoXwFjambWr0mo7j1HDPjUlGyUjaLU2zQegXrgIyQmTGpGiiPG2iy9
 B7VfDtXzl0kaPzNXVCSKQBc5NOV7lwLnlVaDsfGwcfZc63+XSqM3chdPrjcuSod5Ex9nwctX0ec
 sDggO8JPyyiS2s4Wx2aItyD79BYMESBBnEGLWFUrw978u5HjtVnj8vqigIksiYMByYHk9aCOmQd
 579DKvQBxB68qSRY+xYjfsMEgg=
X-Received: by 2002:a17:902:ccc4:b0:2c9:ff29:3f73 with SMTP id
 d9443c01a7336-2d0523f92f8mr151058385ad.28.1785858374327; 
 Tue, 04 Aug 2026 08:46:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [PATCH v3 16/23] net/ngbe: include network protocol headers
Date: Tue,  4 Aug 2026 08:45:04 -0700
Message-ID: <20260804154549.148691-17-stephen@networkplumber.org>
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

