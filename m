Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264BC9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB32142E91;
	Sun, 18 Jan 2026 20:14:49 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id B5B9840670
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:48 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b87cc82fd85so73166966b.2
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763688;
 x=1769368488; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hf1gW+IUE2O+EqSoQva4KQXjUshOIIk81dNoVfbFJc=;
 b=Ju/BlpPj5Nf+mtR8+09SGRjFTM0wPAPBuKpwYllIjXUFDJEWZaxn35Eep0sCYIVo+i
 WeraAceTHFKp1wGzXfJPliWsXDZeKdyhFUeRyLRlYlSrpTYe/QiRven+ZPN1YFKtbbKw
 fKZPKQR0FPH05WZUlVTVVD6i/IAg6VHV9s6TkTE5vtwQlCfvdm50nK5NNSf9PTe7OeXd
 cUVGMxzcDfS3T+auCK90VAV+MOcHmWYIIIUzJiHHqI6UQpNk7OTfmKj4DrTXUC4lJ0k2
 7ZqIGBsQIt9OlK+UZqGEq5v0EIvbtOWGQpNGzV/pWKoE8BXbtYTKzPu1wfeEc+d4w3jR
 ttbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763688; x=1769368488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+hf1gW+IUE2O+EqSoQva4KQXjUshOIIk81dNoVfbFJc=;
 b=vEfe/htql3mZXdVERV7KacFbB5sYZUNwTSANiIU3RQ+O1Iz7wp4vv8Ueh4wPHESEoD
 dOBfxOR86fJ5cqr/fsOLVDo8MOfHFcVkhgv8jrXocESORBrH/RBdR7CAHle/SSQ/mBw2
 PkCu2RNSrfEch+uFl02Ne/XK0pW3M11sQq4LSW2n99L57dSgl/IupMcqcE0pYZNPGMEl
 x+LwLjBTh3IRedLNrumTLbevYJvGeAJBOA9sOT7xJYqw1osiz1MqFbQQ5+fao6pGw8kF
 qhe/WuUBmwNnP3ZYtTUMDeiooHo1PTQWaWVaVLubtJvuOiaJcQDA23FgH4lhKzCwypTh
 CjWA==
X-Gm-Message-State: AOJu0YxKRqZmlRQduyetsBAScL4Q/56i2MLj6BWXngRPnuPHm8xSfyiG
 VAF1GaakKwn2BIDIstGnV9sD1YUTQCJIsZS52xH+GOg+DyjG+n1ARingtlcgHGXx+APtKqNOH5F
 b1aUI
X-Gm-Gg: AY/fxX69tysU4pwN3PcMJZnTukj6OcrqRQq2u+ia/Gu5xvJENUIz2CErzYqagCuJdpn
 A6SQWnyslzkKBpuUnspw33xPleOtPJsjz4haoINAPP65RDPS1AxFwpGNk2ydTuYRiKwA0RjaX3O
 tFRpsilClhEATxCLx93ovw375L0uUpvGXae8ZEiMbnFNFgdhjLRaDAJenRYUybjN65H6FrrspuV
 QfdZ1uNl6DObV1g/wmdh+7GSeipgjwsVDOcBRKW6fVERC38R/1XGOP4Ih6EWzt+PqnCKk5rSKyw
 yQt5R06fM1xALhHlx5Ro0ueJ7RNAXBZg/Cem3NyCz4J76dRe4nOplLr226nbpEUhMLb93y0aGDs
 b1p7LMBbcqk0SDH0UIsQ0nqH6WqOfvV/9mYSjvwXAG+uJvqdOsOCduLHm7TNBnnTxQK3HK+lExS
 YVvh3kiR7/nYkTnJAYcGbqEwuWM4SRDG99gEyZwz1ROcpk2ECTRw==
X-Received: by 2002:a17:907:dac:b0:b87:15a7:85ee with SMTP id
 a640c23a62f3a-b8796b7a7a0mr748802266b.47.1768763688290; 
 Sun, 18 Jan 2026 11:14:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 52/54] doc: correct errors in toeplitz hash library guide
Date: Sun, 18 Jan 2026 11:10:55 -0800
Message-ID: <20260118191323.241013-53-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct sentence fragment "Could be used" to "They can be used".
Correct typo in code example: rte_thash_get_compliment should be
  rte_thash_get_complement to match the actual API

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/toeplitz_hash_lib.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/prog_guide/toeplitz_hash_lib.rst b/doc/guides/prog_guide/toeplitz_hash_lib.rst
index 61eaafd169..cc22236836 100644
--- a/doc/guides/prog_guide/toeplitz_hash_lib.rst
+++ b/doc/guides/prog_guide/toeplitz_hash_lib.rst
@@ -40,7 +40,7 @@ The ``rte_softrss_be`` function is a faster implementation,
 but it expects ``rss_key`` to be converted to the host byte order.
 
 The last two functions are vectorized implementations using
-Galois Fields New Instructions. Could be used if ``rte_thash_gfni_supported`` is true.
+Galois Fields New Instructions. They can be used if ``rte_thash_gfni_supported`` is true.
 They expect the tuple to be in network byte order.
 
 ``rte_thash_gfni()`` calculates the hash value for a single tuple, and
@@ -306,7 +306,7 @@ collision. This is shown in the code below.
    uint32_t rev_hash = rte_softrss((uint32_t *)&rev_tuple, RTE_THASH_V4_L4_LEN, new_key);
 
    /* Get the adjustment bits for the src port to get a new port. */
-   uint32_t adj = rte_thash_get_compliment(h, rev_hash, orig_hash);
+   uint32_t adj = rte_thash_get_complement(h, rev_hash, orig_hash);
 
    /* Adjust the source port bits. */
    uint16_t new_sport = tuple.v4.sport ^ adj;
-- 
2.51.0

