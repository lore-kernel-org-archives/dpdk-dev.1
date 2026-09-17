Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3737FC88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D68343254;
	Thu, 17 Sep 2026 22:11:40 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 1DA9942FCB
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:35 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2dd88a115c1so253755ad.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675894;
 x=1790280694; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Or7aLtWbqQHyNepzPSea/OqwWMvM9wSeyG/InoiHdOg=;
 b=vcfeq5hFBlePlmMuN052vBBch99ez2yJ2f4EnDkjmsCearPpqKwvCCUrJg1aDz2yBe
 6ZkZfCjz6VxfrM67CCsmuKNdzXax2nm7qBSnkbE0qWi9DBQKyKYf4zGh9YjDd8TOCsSu
 mVU/q+vxi40RVKxKmaG0Z5goK8XA3bWg9Ho3vDA4QHcFpJA+xscvQ2WYG1CGpHW7mY5q
 4JsOdvJ45UtyyTazIDs5PaA2EdbFg4NiQ4ZnSWK9/jUxVHtThmnwlNbFnfm4OymiJxDj
 OFrREfYT5iUV5BDAdpyizCktfqWxjY2WiHOnpUb5yjhnIWAWB53hwKRF2E53I9HBcclo
 bmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675894; x=1790280694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Or7aLtWbqQHyNepzPSea/OqwWMvM9wSeyG/InoiHdOg=;
 b=x8K38Vpwd7ymDeLQRNzkQCBlXv7xTY7bdLUiy6AOpaHpiGmYG2MA0gi215rZv3FbpZ
 LA8z2PKj0ySrFo+bSXNEHqVGjWQvliL9vKoxpxb2VLsZy/65YNwK52lWernvziSNDQh5
 f6B1ykbZJRU2MbuGWG3zr95D9NtRhaaSICI8ohHvDHCZSCqwxzJaAP/EmHbykyCV5lyb
 fKNBMFHcp2OuQiEoK/4hZA3lY5IFUpC2p1QngM76XFVOJ3hj0wF+CFE8+ChTn5MB3Gcn
 KIgCpQy7E/Fgp6rQSG6VXkniCigzw3jL+jw8UNh3L9bGYA79AkkVzcqSyq9NejdjXcmS
 cjeQ==
X-Gm-Message-State: AFuF++kG2jRmpN9f5KwJhJoUQucP2vApAJ6uV+D4zfbZb8DYZx79uHyV
 KctfiTw5J6sFCZQxTx2DUCQ4cq84/cnz5j8kupyamFBnMA+1uTqDqOWuv3BkH7eSCT5ECazOL0b
 lckXJ
X-Gm-Gg: AYBFou25VoHvzAvyF+KSuCs2IDw/PlUf+tFbvn0/7Vlhsx8ROHM/GmGN6z90Whb/pyf
 78luh6ZAZCSizjT1qKAVo44uqbjlLKkVLSi/MoqyjhzJgwu5iq7zh9YwcRSWRstjPRYfiACzv8b
 YN1Ef3izlSngikFiKbkeE4W9pVNsO0BU6QTDzAVzva4R8yJHMBsHP9G4CNQ5Rf/9etqTvWb6VZr
 K0J0UJZWyUiXdaRDecqfrn8dDh/SLvpjf/u88E3sX/dDIjVxNIjTlyc9Rx5allt7vy/i0hFwxPI
 WnezCl8/gD9lKKFRj5tFQKZ0UigmIO9vZvTXAk/8IsvBjPTGk/q6aJRHc7ZI5zOxdP2yG6XOMx8
 z1IYWhlIxEpeR9pwSPJrWohiZiJefVPVvjuL+Okn0lVLMdWISwTTFkfbOPXzrtlVawNlunVjmsK
 mZZdYiZaWfFS9gvbWasI39sTZjHQXpjts1LGj+7zOmHYgRAszmnCMA6myl4LzOkXMvZlAceAUD/
 4ZZxqBo7UgJDxboxtbrj/FJywEMVhBWlGyo2Q==
X-Received: by 2002:a17:902:d2cc:b0:2dd:ad73:c982 with SMTP id
 d9443c01a7336-2ddb1ba0faamr4634225ad.26.1789675894227; 
 Thu, 17 Sep 2026 13:11:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v8 13/25] common/dpaax: remove unused atomic wrappers
Date: Thu, 17 Sep 2026 13:10:17 -0700
Message-ID: <20260917201119.2168234-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

This driver defined Linux compatibility wrappers but never
used them in current code base; remove them.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/common/dpaax/compat.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/common/dpaax/compat.h b/drivers/common/dpaax/compat.h
index d0635255da..580620caf0 100644
--- a/drivers/common/dpaax/compat.h
+++ b/drivers/common/dpaax/compat.h
@@ -365,20 +365,6 @@ static inline unsigned long get_zeroed_page(gfp_t __foo __rte_unused)
 #define spin_lock_irqsave(x, f) spin_lock_irq(x)
 #define spin_unlock_irqrestore(x, f) spin_unlock_irq(x)
 
-#define atomic_t                rte_atomic32_t
-#define atomic_read(v)          rte_atomic32_read(v)
-#define atomic_set(v, i)        rte_atomic32_set(v, i)
-
-#define atomic_inc(v)           rte_atomic32_add(v, 1)
-#define atomic_dec(v)           rte_atomic32_sub(v, 1)
-
-#define atomic_inc_and_test(v)  rte_atomic32_inc_and_test(v)
-#define atomic_dec_and_test(v)  rte_atomic32_dec_and_test(v)
-
-#define atomic_inc_return(v)    rte_atomic32_add_return(v, 1)
-#define atomic_dec_return(v)    rte_atomic32_sub_return(v, 1)
-#define atomic_sub_and_test(i, v) (rte_atomic32_sub_return(v, i) == 0)
-
 /* Interface name len*/
 #define IF_NAME_MAX_LEN 16
 
-- 
2.53.0

