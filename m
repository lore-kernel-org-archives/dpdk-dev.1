Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B3BFF4927
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Mar 2026 23:24:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 790B440269;
	Mon, 30 Mar 2026 01:24:21 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 0DEE8400D6
 for <dev@dpdk.org>; Mon, 30 Mar 2026 01:24:19 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-35d9923eec5so655546a91.2
 for <dev@dpdk.org>; Sun, 29 Mar 2026 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774826658;
 x=1775431458; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/dEpNWE/1gOBE/RZugA/Fcv0PaDUONoRAHe+TtdSPE=;
 b=GtlfwERoV90H1YBTWdWVwz/w8vmFuBqNx+tPiM0mymuKKBLP9Z0VxJG/WhCs5W6gbD
 8TUYAxIAO7qxtlSxI0kDNgdLO+olf2WyFPbuFAdhFwo4EknKg2zAbmzIU02h3swZCjnM
 S5+7NI8SQu1FrlRX0zE/W39uabgvzbRj9qIruTh/gDKuceCyXogITvL8730bjWn2SvH4
 RMQm/ywZPHmG9k1s2fqmxRar+wUFAIwwS+yYfcdzy5RFYkvX/3caPrZwFYGLvF8pB9KA
 S4WeUt2oJbKOStkZ7KRQPWs1jAxEw7Bv2bTx2Nk4ZTsvVDpQiBtfYGXQBkjlF7+tLu3g
 ckbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774826658; x=1775431458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L/dEpNWE/1gOBE/RZugA/Fcv0PaDUONoRAHe+TtdSPE=;
 b=MjjZrUpR5yyLO5yd708t26OgNdJHsGbfTaDq5E6iLTCTPu+FZvY2S8SFOMYvhm58pI
 p8c1oOHUdhhZwkAbdVWpOgADlgtAv6wmRAU2IS7+3um/sJESbjLnQlEnc7lte7AGLnrT
 eB+l+1DsTYLipiS3io53P1oBOOIRTAlLGUeqfGz7X810HGoZPXUBiKR/vTgOrYdFIKto
 t0GwFsEx0KPGGnAcHW0W491zvdCMCLmC8aBrpMxSs8vadfHnS6A0trf9iiIQl8Gw8m2W
 CjZUt3Y2yt0yvqk2iPiehmIlIedqWEVIFHEc7BAw2QD97rV2sjwgO+ctHvwdl+TOXx5A
 yTkQ==
X-Gm-Message-State: AOJu0Yxm/rPU49+obHGpMzlYc9NxJHYZgnPzx6k3spd75jox/xBkI20c
 I/Ee7zmXXDRixmD1kckVC2oKpQzFE+yeM5dEROCpLRV6iBnUOzZ19t9dMwd9EGXS6A7YpNJ8SxQ
 +vWsy
X-Gm-Gg: ATEYQzw8ayotu9+uwrkm+6d7hPT6P+b7VzgbuJE4f8jxDTgClFEEjJzxDWK4o2IT8yD
 uv66jvtABFt/D7SqiC9c2tClLNjUUsWYltr6zXTHra+IrBUk6leziLErdIijP6donvkljMN1K5G
 Yla4R/FSvYZxRyQJUY8UtxcBZbpeIzp54CPGyzqJzukOuPTF+KFmom6IJFKe2EgNvRLZ3uY0TFw
 FtfyETl+Kcb5vimLqiX5hxYSU9xrNSCmtiEWpCGOqAikkj6qXqv7knwIm9PpQcym0Z4pKRasZlk
 9rmxUzozn3cKLkgRSpbEGan0MWQbwpzFWQn0lmSLSmauwW7uPMy8LFTXHpcN+U5RE5+N8kEqjzv
 lLdHPabV6TESCgMVPP6aBVaYoe7dgP0KAY25K9g1uOvlgXg556Y1Qwfc0y/IlVw1CSiePP9MfXN
 apmKpdmB9WLptnT7Bn0rWBRt7xCEq2zkDl
X-Received: by 2002:a17:90a:588:b0:35d:9dc8:7191 with SMTP id
 98e67ed59e1d1-35d9dc8734dmr2776114a91.14.1774826658100; 
 Sun, 29 Mar 2026 16:24:18 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22b9fc96sm10295401a91.7.2026.03.29.16.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 16:24:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/7] Cuckoo hash optimization for small key sizes
Date: Sun, 29 Mar 2026 16:22:34 -0700
Message-ID: <20260329232409.205940-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series improves the hash library's key comparison performance
and portability. The main goals are:

 - Hide internal implementation details to prevent future ABI breakage
 - Enable optimized key comparisons on all architectures (not just
   x86 and ARM64)
 - Add specialized compare functions for common small key sizes
   (2-20 bytes) to avoid memcmp overhead
 - Improve test coverage and code quality

v6 - rebase to main integrate the recent rcu test

Stephen Hemminger (7):
  hash: move table of hash compare functions out of header
  hash: use static_assert
  hash: remove spurious warnings in CRC32 init
  hash: simplify key comparison across architectures
  hash: add support for common small key sizes
  app/test: convert hash test to use test suite runner
  test/hash: add test for key compare functions

 app/test/test_hash.c       | 253 ++++++++++++++++++++++---------
 lib/hash/rte_cmp_arm64.h   |  62 +-------
 lib/hash/rte_cmp_generic.h |  35 +++++
 lib/hash/rte_cmp_x86.h     |  62 +-------
 lib/hash/rte_cuckoo_hash.c | 301 ++++++++++++++++++++++++++++++++-----
 lib/hash/rte_cuckoo_hash.h |  84 +----------
 lib/hash/rte_hash_crc.c    |   8 +-
 7 files changed, 491 insertions(+), 314 deletions(-)
 create mode 100644 lib/hash/rte_cmp_generic.h

-- 
2.53.0

