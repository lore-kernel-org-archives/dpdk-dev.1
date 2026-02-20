Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9C4C5AD48
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 18:43:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 686E240658;
	Fri, 20 Feb 2026 19:43:03 +0100 (CET)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46]) by mails.dpdk.org (Postfix) with ESMTP id 30F53402EB
 for <dev@dpdk.org>; Fri, 20 Feb 2026 19:43:01 +0100 (CET)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-40ed9a23aaeso784294fac.1
 for <dev@dpdk.org>; Fri, 20 Feb 2026 10:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771612980;
 x=1772217780; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VEI/rBuJ3h+WsVNZdFN6dJuakWNc6yaQbOVrWpWUaXk=;
 b=ibpNyitieqwOxms4Z8pQe6vw/EdJKaD/FMo0sIfHY2nsIj1rxR/8wJi7p2L226P8KZ
 NjbgoqlkppTgTi+Hfo0g0Y+eFPEwYpzBwTtT0IvvIYw1IxjZkGKqG4rDjr3J99aUwG2U
 Hiq5EEmboApNvaNVRjLa9k4bTCHxSfQz082llt3o6zHtqc28zu1yxHStUG8K1IUsYbvp
 mGTop1784LgL8NPedQ1S9suqpisNNYeKSr4vWo7dc9/RXDYjuVCdfVpbAXSQqkH7GqgW
 hQE9+tujFGanN3B+cQyTwN7NYHQcIuUrCXcI11ioKiNxbMaswb5CikETqrWTQeVWXJ43
 BV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771612980; x=1772217780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VEI/rBuJ3h+WsVNZdFN6dJuakWNc6yaQbOVrWpWUaXk=;
 b=p6fTn2bgtWYX75szcHSnZ1VJ3OVRqB8PJ08treisP34KDK6WPR5EDYSoAa9LG1+v+x
 habnvEvP+z0Ya6xiRM5EiBf0e+RmI3lniFNqCD4lfjZxWF4cPzb3gnNWUZt6371LwnWt
 6kFw3SkNCSCRoAmWEF0yfl9dLsUKqWiT/qKcLbXmgzI/G4vBfbAQYQi67PryPyC9k6B7
 69JGHIvovtNwTDT6VblmZ6tunxtjnl/mR2MyGwKoLQVdktjxJDGC7Ytndp5iuNF8w6PV
 UltsdDgRx4D1imzLHENWJ4oIC94xjmpH1byJn4DsBdgAmaspe2Jo6YQfVP0e/l1S8Z1C
 VR6g==
X-Gm-Message-State: AOJu0Yw96UgtenimB8+5xzHou5mrji/32iaA7bwoToYfQUjrtq7b67BG
 piodTlAj41AmvWr+Qnod1C4410mIefk7PoZvboltNwknVRIEM7ssNq+8TmhRGMu/oS0K1EAsuBy
 bhZxH
X-Gm-Gg: AZuq6aKw5P+oDfHwmdxclIhgZykfRxSZgsuml5kYCQ5erJapUz+/nnK2Av0kmK7ooAw
 dmHebtz94RuO9F+Xi+ACcNBSvl4R/NyuQnhgpeaY86Dc1BqbBtDA1qwCchgTaC1QPU72lbXWgG8
 Y15r7GLBWZW1eTKGqMieQvnTKXeS1RW2BySg05O1g7lWiJRjx+eIZxrDigvq5GHabfsk+Y0nhpN
 EDHS4yCUmbREtB3FbNUKR/jGW2itCNpU9JbP088Nqk1SaGe3tDioY9kpLoiNtiEWfZWninetTQ/
 2CmQPTxfu6u9eoLsHJprPC+dzCSmnJFsf1dprRxq8twOkUe9gp7kF527RcJktdiuulBNSnrjCPm
 iKkOeFvTiXQXhOD9/d51Ir9q0kZ+K2Bcf1EHjH0fuaLNEl6jCLZuasfPTCQV20eRdKhvLiYIslj
 0CYgDis4MaCHjq2oBzy6gtoKylKkv3ZjEXMl/cby+AzZgNuq/omlmigu716d2LvA==
X-Received: by 2002:a05:6820:81d2:b0:679:a650:cc11 with SMTP id
 006d021491bc7-679c44cd9c1mr548262eaf.48.1771612980512; 
 Fri, 20 Feb 2026 10:43:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm250876fac.4.2026.02.20.10.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 10:43:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 2/2] pcapng: handle packets copied before file open
Date: Fri, 20 Feb 2026 10:41:56 -0800
Message-ID: <20260220184255.306368-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220184255.306368-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
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

Either through misuse of the API, or races it might happen
that rte_pcapng_copy() is called before rte_pcapng_fdopen().

Simplest solution to handle this is to modify the logic for
TSC to nanosecond epoch conversion to handle the case where
the difference is negative.

Bugzilla ID: 1291
Fixes: 166591931b72 ("pcapng: modify timestamp calculation")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pcapng/rte_pcapng.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b93af418aa..1a1935e876 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -155,13 +155,16 @@ tsc_clock_init(struct tsc_clock *clk)
 static inline uint64_t
 tsc_to_ns_epoch(const struct tsc_clock *clk, uint64_t tsc)
 {
-	uint64_t delta, ns;
-
-	delta = tsc - clk->tsc_base;
-	ns = (delta >> clk->shift) * NSEC_PER_SEC;
-	ns = rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
-
-	return clk->ns_base + ns;
+	int64_t delta = tsc - clk->tsc_base;
+	uint64_t ns;
+
+	if (unlikely(delta < 0)) {
+		ns = (-delta >> clk->shift) * NSEC_PER_SEC;
+		return clk->ns_base - rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
+	} else {
+		ns = (delta >> clk->shift) * NSEC_PER_SEC;
+		return clk->ns_base + rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
+	}
 }
 
 /* length of option including padding */
-- 
2.51.0

