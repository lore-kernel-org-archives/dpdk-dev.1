Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FB4C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:00:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F9264065E;
	Mon, 29 Jun 2026 21:00:38 +0200 (CEST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id 124C240650
 for <dev@dpdk.org>; Mon, 29 Jun 2026 21:00:36 +0200 (CEST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-80b9993928dso40518427b3.0
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782759635;
 x=1783364435; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jy8Z2BhJnojHCrEVaR4znBck24tp2Bm2LT7FG3ghUuM=;
 b=Wp4Lm8OQKiWQSZ36hxN61Np2QOK9nSlZAEnUVWbqAamoXctSv24uJGM7ySKbpuEsRR
 vHC5UlmzsxNjmrjABKsv4dPhd0XXtHYbdPa2bEQL22ofz/ENspp91t8bkCDp3A89NIST
 bAMEkIzmFHhkk4jFhj2RCRjB0XVj5chb2fqhphAuMu6O/ObnALxON7S1kfWLWqvHhy/J
 e4paKWtdyPuIBqTQpYBGy6lDDrJk08ZBzmM6freORGhFueFO+fIqYVNkpQ5chLPbNrWZ
 kwrDOopZt/9zaSjbRVcARM+el7XX9rDUfl3c/rWzYpVo+OLSYS4/9T9LwFM5ABo/ShqW
 EHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782759635; x=1783364435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jy8Z2BhJnojHCrEVaR4znBck24tp2Bm2LT7FG3ghUuM=;
 b=cvjcz+2KyeR1KNJgkvIy4FL0kk+uu+qC4fv23upxama+VlZUa+JGIWX1vll/+V4ZLw
 QxRFPbCTih9huymf6OfNPNPs/528sEut4MeRT+CDcxSyh5i1lAHJT5b3yu+Zm9U60CDX
 qAT+e10hew6aVBbLSoLkpopVXS3JEDKmVvD/cuWKauy38rOnS1avruqRAi8m1HgBShzp
 ifGVVmJ9lwNdTNAs6/7J/4TJDMGa153wcNdj/JWYk3rUS4ERPoVBlfaAXszjt8svWs2f
 jFQvcHEs0rl/BX6LccQ4kxRHXk3kBMvbZbEznrj0HbEWhMu5cVsmhQ0LYnYfqrv2dq40
 W7WQ==
X-Gm-Message-State: AOJu0Yy3+K5rtGCt2Yn5ZtCZ2N9oKss5DwbKXe0JHAPDKXNDEEWRKZ2G
 e9C8k7DBApKIzxdiKt/xyGmd7Bz3mQe3iqsJ3g1XxZxr2qI2chViAO2WizoWo75ZyHdrS9jb+8W
 P6yZI
X-Gm-Gg: AfdE7ckZxUfHujOgRrjgFc40BsVUNdapxdzBmzlMz5VPW73SsAtN0IafMWJsHVi1TxY
 VKs+wpoL/nMeu7nPVYiqKxhiJ5ezx1rElDQK3C46YL0xhlDyAxbkkkYRh2VeZhpVIo5DvkfyYwj
 pjO5xi5X4TYVCmJCEgu/PEW4Aq+HXxR6ghyAkVE3124XPVwhG9zIx/sCPaOUGNFQFpsZb8FiQZg
 1dLw6/TVzlVEyVHLubJK+NbuSpc3+2JXr0P2/dk5h2mfbq0vtMdcMAtkAQ7vCIdppBadyS/vULZ
 JIhkdxp8MdtEvf82hUKm1ZrB4yCLBPkipoXjA8ApTF3lHIAb28gPIiH+ENEMr5aQ1mQAW3fAzP5
 wQuo/s/f30u+sQOu9rPfkT3DwNUo0LQlwIe4IXzKNZk9z8qOrKGJiB0lPHOM4LH2lXtz0ivHNpA
 rD+MWEjy4H+Ycn8tJeIvlEs6j09KYGFKKJ1ekGcr/sonoZKGr8fw4=
X-Received: by 2002:a05:690c:6802:b0:80c:85e5:8754 with SMTP id
 00721157ae682-810da30a9f8mr8267107b3.61.1782759630626; 
 Mon, 29 Jun 2026 12:00:30 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-810e728a009sm1747287b3.5.2026.06.29.12.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:00:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/6] crypto: use timing-safe digest comparison
Date: Mon, 29 Jun 2026 11:59:23 -0700
Message-ID: <20260629190027.2071745-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625160200.24170-1-stephen@networkplumber.org>
References: <20260625160200.24170-1-stephen@networkplumber.org>
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

Timing attacks in DPDK crypto were fixed earlier but
several drivers did not use the new timing safe comparison
operation.

First patch drops the experimental flag off rte_memeq_timingsafe().
The function is a static inline with no exported symbol, no ABI change.
This avoids having to turn on experimental flag in other drivers.

The rest convert the digest verify comparisons in the uadk, ccp,
armv8 and cnxk PMDs.

This problem was reported for several drivers and for those
the Reported-by was added.

v2 - pick up a couple of other memcmp() locations

Stephen Hemminger (6):
  eal: take experimental flag off of rte_memeq_timingsafe
  crypto/uadk: use timing-safe digest comparison
  crypto/ccp: use timing-safe digest comparison
  crypto/armv8: use timing-safe digest comparison
  crypto/cnxk: use timing-safe digest comparison
  crypto/octeontx: use timing-safe RSA signature verification

 doc/guides/rel_notes/release_26_07.rst      | 4 ++++
 drivers/crypto/armv8/rte_armv8_pmd.c        | 4 ++--
 drivers/crypto/ccp/ccp_crypto.c             | 8 ++++----
 drivers/crypto/cnxk/cnxk_ae.h               | 4 +++-
 drivers/crypto/cnxk/cnxk_se.h               | 2 +-
 drivers/crypto/octeontx/otx_cryptodev_ops.c | 3 ++-
 drivers/crypto/uadk/uadk_crypto_pmd.c       | 4 ++--
 lib/eal/include/rte_memory.h                | 4 ----
 8 files changed, 18 insertions(+), 15 deletions(-)

-- 
2.53.0

