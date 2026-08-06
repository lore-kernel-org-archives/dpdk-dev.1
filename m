Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0492C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:26:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D85A240A76;
	Thu,  6 Aug 2026 05:26:01 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 6989B406B8
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:59 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso1639607a12.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986758;
 x=1786591558; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oXfyXLy6OUjoEhM8oMb1wm6XoMDgVHDHJy8P9wKoggo=;
 b=ClMzXw9tAxu6HKB7GR6XFo7bdZH+OZQFqnApblcXE4EqXWBE4ci1a6YiAmeKi3XT6O
 PRhOtHBNO22+C1EbbPaHHAuQjOmAGKHsjO8nSfSHQPxeoJNbagx5wg74CYMB2DYlutV/
 CaNXfBwlQzsphocd6hTaQVv4BKeQevM3wgUgu56lo4QLcd3g34ZYFpFISuGcijElsRPp
 Rp+mdx2PJHPQCrCyO0FglLgM2zD8CdMjZC9wnJvd6w7NOgSoN0M251cVPqv8CeBJQaAn
 TZYEqZuQ6paGHWTXFBKZVXBLfMAe6FO2P2upGzZK3c73Cg+DkPPgHmoUAH77DbAF47Pe
 9Wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986758; x=1786591558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oXfyXLy6OUjoEhM8oMb1wm6XoMDgVHDHJy8P9wKoggo=;
 b=Rq8ItQgf4nTOQPwD1fnh9B6zuOFdGRjzhe5cxtdylSgb58QoR+zt9GV6jgXiDWVMVP
 3EinlaVrlJcUu3+hIUUuyIoxE/iMOB8MsY1kb7UJZMcTQgXHM+CNqeMqPaR8uJBciyo8
 S9GU1NXPQVfkc4P8PMKTS/ve2uKy9CEt6quleVr9DPErjqcIT+Ibm7lHcu5wI32i/et7
 CKueHtCnTGAvlBncOGRQHNqec5cwv4YPS3wo5Lw7bzmBPI/QubjHPlCRKtLWN+J72xIo
 O4TP/5LDJKsyl8Ktoi80NwUeHYuoSj3V0bpUmsevidenNYHD5kJFkB5zQhs+5/nxL/+1
 sjmw==
X-Gm-Message-State: AOJu0YzPvDNTP31TjaTqIyWp9wcaovagVV8zHwBRjqbJ9B+maR/Na9PB
 d0OsSGwJLqAIRj5gbUHcZ/ctGksGNEDqNvab5H+1bPYStjEIJ/XhRKARB1AMGAILGOlUvWfZ0kq
 GBM+/q+k=
X-Gm-Gg: AR+sD12/KnYkScaqQ+jlW9rlLXIuLUgkWA/uhKEUdcZXA3k2a/fB+vzSezHTL7pizEy
 MchtMHLUJVtaT3eJroRQn28a80j8hFaQ2HaiFr8KxwTyHEdU3BG62aNrQxu6JsBqnjGukS42rQL
 //8bB7E1CYYNstMJZRi/xcQZmcsGg0SbOfdAfm7qHWxDqTMovwT2tvAs7FOobzJOfDUDWsAjqab
 x6h7htW0bb43lqslMrl+zwlav4f1htL6PvV1aK5H8Ia8nbLSH2Sn5vGpsc1d0VJm8buwd91qyG0
 3EOUgtNALGwNeAky7/vDoewvtHKjNIZLqKrOKCPAbhT/iYp2vrB7mK8J7/ChWEu9zztZrIluxNZ
 Q2Tkxg6aPc7foIsDX2N1JN6higoaLKqhCJoxw2jhGt09KyO6ksP9dJyaCEfpefXnIchOc4H8E9w
 Hj7RPrNY7vBfuNueUMrR938pdk7vxe9QfnO4SGOWHa5x8JiKBPC9U8q6dAkruR9bHXX+BpT5J3I
 vVuoKcf3ENdBXuvhS9XQfM931JFWq2AaGPLgQ==
X-Received: by 2002:a05:6a21:6112:b0:3b7:aefe:4367 with SMTP id
 adf61e73a8af0-3cb85f509e2mr14251975637.33.1785986758532; 
 Wed, 05 Aug 2026 20:25:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v7 10/24] bus/dpaa: replace rte_atomic16 with stdatomic
Date: Wed,  5 Aug 2026 20:23:02 -0700
Message-ID: <20260806032544.21337-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

This is simple inuse flag which can be done with stdatomic
exchange logic.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/dpaa/base/qbman/qman.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index d289df2d33..ff56f7b1ab 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -11,6 +11,7 @@
 #include <rte_eventdev.h>
 #include <rte_byteorder.h>
 #include <rte_dpaa_logs.h>
+#include <rte_stdatomic.h>
 #include <eal_export.h>
 #include <dpaa_bits.h>
 
@@ -683,7 +684,7 @@ qman_init_portal(struct qman_portal *portal,
 
 #define MAX_GLOBAL_PORTALS 8
 static struct qman_portal global_portals[MAX_GLOBAL_PORTALS];
-static rte_atomic16_t global_portals_used[MAX_GLOBAL_PORTALS];
+static RTE_ATOMIC(bool) global_portals_used[MAX_GLOBAL_PORTALS];
 
 struct qman_portal *
 qman_alloc_global_portal(struct qm_portal_config *q_pcfg)
@@ -691,7 +692,8 @@ qman_alloc_global_portal(struct qm_portal_config *q_pcfg)
 	unsigned int i;
 
 	for (i = 0; i < MAX_GLOBAL_PORTALS; i++) {
-		if (rte_atomic16_test_and_set(&global_portals_used[i])) {
+		if (!rte_atomic_exchange_explicit(&global_portals_used[i], true,
+						  rte_memory_order_acquire)) {
 			global_portals[i].config = q_pcfg;
 			return &global_portals[i];
 		}
@@ -708,7 +710,8 @@ qman_free_global_portal(struct qman_portal *portal)
 
 	for (i = 0; i < MAX_GLOBAL_PORTALS; i++) {
 		if (&global_portals[i] == portal) {
-			rte_atomic16_clear(&global_portals_used[i]);
+			rte_atomic_store_explicit(&global_portals_used[i], false,
+						  rte_memory_order_release);
 			return 0;
 		}
 	}
-- 
2.53.0

