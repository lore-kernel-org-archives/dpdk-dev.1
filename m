Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F24CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 13:50:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 929E940296;
	Tue, 19 May 2026 15:50:52 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id C53954025E
 for <dev@dpdk.org>; Tue, 19 May 2026 15:50:50 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-134ac81c445so12468196c88.1
 for <dev@dpdk.org>; Tue, 19 May 2026 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779198650;
 x=1779803450; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDPnIgmrq0z6vGtsACF3FMSwx4pYgC5LQFGHmYMztL4=;
 b=MpXo8s0GdsG8sFRen65C3HGDxVMk5O+6tDWyMey4Fz8NT1iWbtfZrviEC5lE5zNZ3g
 +4ZF0XhzWbf0zSJsnzqowGQZN/1JthWExitWVqwtbfonK0MgpzIgWNA2Lr20NqztFjcB
 l04KJGTfvJUeMZhg3uthuxyin0+I7V9ptRc7mO4v/CKYFGWqmMp30P0/a8rZDKIv2uy0
 qJHJy563J8VE54dJZlILx38T8IbuArabdcX3zulmMMIONJAyr1vR/ucu9PZtWZKWnbub
 KD1IQLXFpMQp+GhwSCgEiJ9LwNB+bdOoVg3Q472nYzBJhblw/k7lw2Lvr1db/20hVeYf
 KsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779198650; x=1779803450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WDPnIgmrq0z6vGtsACF3FMSwx4pYgC5LQFGHmYMztL4=;
 b=qxzM3hNaXg2YtK3QXG+MRi0Ev14rzexTvliIycyRHeYOAE9JrkGNWTuuRvJF+/w1Dw
 yGO+D8Ywwoy/gpFz/W6szlR7SVRG+4b2tYcgFkE0wWApydahgJr6Kh5VwtR2/Gth76mX
 499PNVPzZQAZLCTAQn475UsBWZPWLDXJ4f7uMHUHpbtFg4eN2VFNv6Ubjkszxu2pCQYa
 JmTY/6ssNa1NFjlc5a5kb6ZiP9lBchZqNpk1z0j01Q/qh73w+tO1dkwwKlXCIZ3zYHXQ
 sV0fiTPaZGVuHH9R85h4kIOu0BIyHhwKXg/E5aVs96RUW/hEflOraKuF1zz1Dbo7Eunt
 gmTA==
X-Gm-Message-State: AOJu0YxS/xuzCCW583Lh/MKaQpzXQelC7ZMNBu6U+ul5qK4uYxy+hxAp
 F+BZxCbam8Gp7IauNnu9SeIGqRtawM7yTHjUT8GBLYx5qoSxymfTSbQnUaSRdAhYRi0d1rkDdY8
 cCm8C
X-Gm-Gg: Acq92OE+G1BWJCD5Cnc5CEScxAEeKxUwUdOTgIZnPV7xenH6qfUFEt5l0ZZwgvJvRlV
 b+7SAf+sGVzIZ0kPK9N8QS+9/J88KniG5ixzv7AiKU2nRZDzNAALlxHGTCibOFM2e9QWYENK4yv
 fEd/rxz0bXsROugckBbW8wLytDMnzYglSjT0hU0swltjJsF1Bfk7zshMWpO2P1qrQNuKQB6uAx0
 Msx1qG1C9evAwew1NATNcnhKX/TlXxCj3I54CJGs8Wk3xPOjQLYMWwHS0a9jNO74IOmmygr8qV3
 a/oTlUtSYBvHuNvCOOWm8j0Ryf+ZfKbVLiU02xYfrsjG9B+QrzSJYGREX+n5Azr9epHy+lVDnsu
 xdQt1NjAbGrSWGCE765ZhPLqFX2Ne4sdfEEuHQ/aF0JXSuqIDse3fhAvQVt3cz1hktGGbgjgUtW
 LJUEk2iDZ0lkeUq3nLTW2PVa+o0EWBzV7x
X-Received: by 2002:a05:7022:6727:b0:132:5d42:55bc with SMTP id
 a92af1059eb24-1350451fd8fmr8775796c88.18.1779198649570; 
 Tue, 19 May 2026 06:50:49 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb93f3sm24222675c88.3.2026.05.19.06.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:50:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>, Gavin Hu <gahu@nvidia.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Subject: [PATCH v2] eal: silence -Wconstant-logical-operand in
 RTE_IS_POWER_OF_2
Date: Tue, 19 May 2026 06:49:01 -0700
Message-ID: <20260519135046.367128-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518163401.580696-1-stephen@networkplumber.org>
References: <20260518163401.580696-1-stephen@networkplumber.org>
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

Newer GCC warns when a non-boolean constant is an operand of &&, which
trips whenever RTE_IS_POWER_OF_2 is used in a static_assert with a
power-of-two literal. Make the zero check explicit.

Fixes: 7c872b96983a ("hash: validate hash bucket entries while compiling")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
---
v2 - use suggestion to make both sides comparisons

Note: AI incorrectly complains about multiple evaluations in this macro
      but that has always been the case, and has to be macro
      for use with static assert.

 lib/eal/include/rte_bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_bitops.h b/lib/eal/include/rte_bitops.h
index aa6ac73abb..b170447714 100644
--- a/lib/eal/include/rte_bitops.h
+++ b/lib/eal/include/rte_bitops.h
@@ -1299,7 +1299,7 @@ rte_fls_u64(uint64_t x)
 /**
  * Macro to return 1 if n is a power of 2, 0 otherwise
  */
-#define RTE_IS_POWER_OF_2(n) ((n) && !(((n) - 1) & (n)))
+#define RTE_IS_POWER_OF_2(n) ((n) != 0 && (((n) - 1) & (n)) == 0)
 
 /**
  * Returns true if n is a power of 2
-- 
2.53.0

