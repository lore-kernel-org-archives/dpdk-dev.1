Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45532F3C997
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:27:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC5C840658;
	Tue, 24 Feb 2026 16:27:35 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 61EBA402EE
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:27:32 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-124afd03fd1so7884833c88.0
 for <dev@dpdk.org>; Tue, 24 Feb 2026 07:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771946851;
 x=1772551651; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpAImIqdiKI3ORDfVNUbCgEJX96HHNq/Se4eWcZHQmo=;
 b=DWHPt+pL/t23/25RYoYveGXFGyEwNTGGkW+J4Ieo5Nbn5Cp6mw3aTWVzw5mzMN14Fv
 Xjl4IBB1dFIjOX5FisjEO6HWpYQRYfb0m81bU6RIgC+uVoi4+boIF2pKOPm5DP9edY9x
 2e907QNQkrwjGDweGKEJnif0v0Nh5yU8SZ6GO0HiC4yYjrkfXX+BzEDfz2GhVL7WF0RI
 geYD9lUivz+CYMPNjcziY+ylVTKnrGDQOft5+Yi4U26b3bJwRpWUTATTDuEDCqDiJe/B
 h8JWzCaHcwSXOH1W7mhFi1aRotqEAwiLsqg7DLWbBc69h46CaIUwVcPvnVDjIazWeyqB
 jI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771946851; x=1772551651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XpAImIqdiKI3ORDfVNUbCgEJX96HHNq/Se4eWcZHQmo=;
 b=MYntoQsgbtRET18foMgMjQdWnBG7DV+GLBc8CFCSDu5GhX1ccmJL0ixt9zc/G+RGCd
 OHj5d6XWo1+iMnBKbQiQqRx/k5Je6PqB+BHNpY9d2wPKTUjrp8e9gDEi+F07/c0Ehj/q
 MH39m5J6dQktaV180t2qE+TDGxCMoywtni/v1sQ4RNjYVG4cxO7r1TK39i7Rf67zs7pK
 R4ym+EJUarHvtNwoe9eL0TNPDSHkSAJ3aFe2Mg/V3rsrHETl46UWfGZCaiIuKtXugsnE
 WjQ7uVIPwjTskiI5RFIATm6wMwEhaPnJ1z2XbV+CMYTky3kKceWnMLgBPogvIRFznTND
 IW8A==
X-Gm-Message-State: AOJu0YymXE/GewDkhSZDsHdDDHSbhgwdH84txRHflpYoLmVtrJr5Plbl
 p4XiboY464cnhu/RkGQb0Q50olexPr1cteZc1iHVd98wNgxhLKQqrZEjf65YbnQyffBNJtcA4t6
 uB+I8
X-Gm-Gg: AZuq6aLl2MlG3WD7cDTI3dJWkDWZ9g5FBdUz5Rqp/1fz83xq/Os2BfbjZrHhanczFyM
 gUwF5SE/dU0JN2S/SjGr+1Z6vENIuFxWg7LTCfXLr60A7zFCqYQRb1u3sPCeH/0/OC2CL/OP2Ny
 gzfjati9uxDlK23mxu0gJhgiJaduB4i2/weJO5s3YlwCvcgDtoh75SaWSUUvApxcbJ8RYTYaLVc
 +GLhOm90VtIvMgccUoQD2oe4/n0ekfHgdOUhFqF1nIPivDeSs+Q4YGzPIpAO/RiMaK6K5xvvgrI
 1LNSbjFi2YfB52zvVHgUNggW63zk+5IP/G6vOalfLCNXfHBTgorwrkNwpvw5gWxrAah91Eph2m1
 lFruTWUvtsZH+xqFnBrin9RaPFfbkSC95cpsG4Zie75tGzfpTh4tDePWKmaKtykriRss+qfXhju
 CX2y20cB5l0EpsYT7n5zSfYaUeJRT4C44AeidY2VOmsl9zjsird5VPIjwMjZNJNg==
X-Received: by 2002:a05:7022:e28:b0:11b:1c6d:98bd with SMTP id
 a92af1059eb24-1276acb80a9mr5349083c88.9.1771946851263; 
 Tue, 24 Feb 2026 07:27:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af7b4c7sm10728774c88.9.2026.02.24.07.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:27:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 2/4] pcapng: handle packets copied before file open
Date: Tue, 24 Feb 2026 07:25:55 -0800
Message-ID: <20260224152726.567604-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260224152726.567604-1-stephen@networkplumber.org>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260224152726.567604-1-stephen@networkplumber.org>
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
 lib/pcapng/rte_pcapng.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/pcapng/rte_pcapng.c b/lib/pcapng/rte_pcapng.c
index b93af418aa..b5d1026891 100644
--- a/lib/pcapng/rte_pcapng.c
+++ b/lib/pcapng/rte_pcapng.c
@@ -157,11 +157,15 @@ tsc_to_ns_epoch(const struct tsc_clock *clk, uint64_t tsc)
 {
 	uint64_t delta, ns;
 
+	if (unlikely(tsc < clk->tsc_base)) {
+		delta = clk->tsc_base - tsc;
+		ns = (delta >> clk->shift) * NSEC_PER_SEC;
+		return clk->ns_base - rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
+	}
+
 	delta = tsc - clk->tsc_base;
 	ns = (delta >> clk->shift) * NSEC_PER_SEC;
-	ns = rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
-
-	return clk->ns_base + ns;
+	return clk->ns_base + rte_reciprocal_divide_u64(ns, &clk->tsc_hz_inv);
 }
 
 /* length of option including padding */
-- 
2.51.0

