Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31592C55822
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED3C440A89;
	Tue,  4 Aug 2026 17:46:13 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id EFE0E40BA2
 for <dev@dpdk.org>; Tue,  4 Aug 2026 17:46:11 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so4364970a12.0
 for <dev@dpdk.org>; Tue, 04 Aug 2026 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785858371;
 x=1786463171; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fQc6JIWWyUbGqEhygW9Tx0U/jyGNDQqqyHu+3M6GVIA=;
 b=CwuP7Zj81iiVjRJ6ZejwNNDJFLHte7BqUNhoYgTbZXcrw3IgtGHNYrtPYxqwdwFMDf
 +0PWK3Uz5hVT8KIo5sIUe776DoemkFkOZKs5hi35tforQk01xdVTStD9ZVJYOmVUonx2
 munygFmk13kM+yUkbM/TMXr8Qq05NCqMmx120sWCYH4lAup3k6kgX74uccYlD0+fhL1d
 9/AfQ2L8IgZnpwtOE88bxc06qL//Q8hnuJpO0T+UXmm8c5K2ekDPInN2qSi8pgXTu9Bm
 p1a6iC2vsplAzOy5BaOhfy/jP4LINnVNH1gxjrDMYdRHV2l3RPEN4c0CqLmMA/MBq7iK
 PDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858371; x=1786463171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fQc6JIWWyUbGqEhygW9Tx0U/jyGNDQqqyHu+3M6GVIA=;
 b=lRY9FiQipCTMLyS9pZqHJ/lIKyfpMgJEL8RpsTIb5OtjfBOSDOSnHQNk6xaDp17A3S
 xL9VnX2ls6anWlej+uL0irDgMeuw2JCHq1obdur4J+X0cNBzGGq8mJpdC8HykHMPOUil
 tScwoTXmEaw27rs5YM+lV7JY97iJl0jacZ4KXGG0R4uMrOZ8MHTYQKKCLkFM2+iRnDpi
 z/YRhwb9MIhFI41otgppqU0f84Lw4mnhbhLUy3dVpc6GxfVvtiaRmBCOkyXeI+ieYP87
 VO0lu5Tdx+8TgZN7ot0NUO3JJl9ulM1Lmq9vhD4oqKfap8NT+kwfYbK1gey4JMmzwmh7
 T0lQ==
X-Gm-Message-State: AOJu0YyFZxZ1iNAvAjSNiOZ2ei73oflp29sTT4parLzGzur8ZbK0qqFc
 cfQB+dkeigv1335hpp3Y4QbRbnAQuZ4VO8f9aSrKo47vYTNtqUwI4j/ITkTbrueEKunJZw2tRoL
 lXhqP
X-Gm-Gg: AR+sD136oeFLxXta4uPxm7W/jp+22P2wNV9bSV+8M0C74FSvXEZNXcIjUIFGieMN2+6
 Z27/brmiXOFpnPrEbq+x41IDcx4BOk9tdniR0Cz/r9zit2bXAtQ6yVeeIRddRV1HiKOdqy3gPvW
 0kg0xuHAHaEXRLQuKDZV6I12jqCvu5ZUovDOPdLdew2EugM1UKkCEcwhc10bakkTE4/wo2Exd+o
 MidnPs+rMnPrijMhdZrZoeNX7wYsj3t6TgE74eZQVz9kP2igI5W+iV2lwYa+fzahFylnDjwMGYH
 JeqQimBIbcVS/F0BQh2anyXd8TQjC6te8PZwHVlmt+o0nwHwEl1jKBs71FaS6Cqj89iw58ts57v
 cXlEhk7M+nkl6fjmeF0Oc/e8i5y24cetJDZNn7gmZca/t8XZez00c+cOZsCwD26q6pEzsDfTRRa
 NADvu58y4KvtVcasupY8I5cIcqlU3g/KyAWe5cTSvPQoqWItY9v/UdJLqXym0np5O8LO7lzvHh7
 OE6ck1lXpr5HDj+XnyQga4sMKA=
X-Received: by 2002:a17:903:28d:b0:2cf:4339:aaa with SMTP id
 d9443c01a7336-2d05221ef80mr144086775ad.12.1785858370960; 
 Tue, 04 Aug 2026 08:46:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158644a195sm5613894eec.13.2026.08.04.08.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 08:46:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH v3 13/23] node: get UDP header
Date: Tue,  4 Aug 2026 08:45:01 -0700
Message-ID: <20260804154549.148691-14-stephen@networkplumber.org>
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

This library was getting UDP header indirectly via rte_ethdev.h
Use iwyu to update includes to match usage.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/node/udp4_input.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index 5a74e28c85..02a8284982 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -2,20 +2,21 @@
  * Copyright(C) 2023 Marvell International Ltd.
  */
 
-#include <arpa/inet.h>
-#include <sys/socket.h>
+#include <stdio.h>
+#include <stdint.h>
 
 #include <eal_export.h>
-#include <rte_ethdev.h>
+#include <rte_common.h>
+#include <rte_byteorder.h>
+#include <rte_errno.h>
 #include <rte_ether.h>
 #include <rte_graph.h>
-#include <rte_graph_worker.h>
-#include <rte_ip.h>
-#include <rte_lpm.h>
 #include <rte_hash.h>
-#include <rte_fbk_hash.h>
+#include <rte_ip.h>
 #include <rte_jhash.h>
-#include <rte_hash_crc.h>
+#include <rte_log.h>
+#include <rte_memcpy.h>
+#include <rte_udp.h>
 
 #include "rte_node_udp4_input_api.h"
 
-- 
2.53.0

