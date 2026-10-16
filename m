Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E1BCC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 15:39:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAD31402F2;
	Fri, 16 Oct 2026 17:39:54 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 0A9EB40291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 17:39:53 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2e5d0ee1951so42795375ad.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792165192;
 x=1792769992; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HuldiREGwIgW0ZXXXm1bvgoI+F5x2DapbOFP5TGPXE4=;
 b=T/PN8oxeQw3zlTDI+SGhVorgR4gIEYxzkvWniD0va2z4g1UAs1f4MtDSLLB91IgKdM
 Mcc+BOoykjx0Aml88hWUcspsiuS5hZ8PKQ4ZYXv+sg+/eYvPw9F2eV8xUxOwsbUoldA1
 viIDIL8Q7XduP58WKh0DwFLCGK5XZZo1daNZel6Edk6R/M4Jh4jsE7OXDNUOV9bbDGus
 rM+4ChZfzPiIEoiVg3si7fZMddpNQBRhjJ8uOgKB1BlZyBWCKl5pEWHd5CwSHUYthKBX
 DKjuHN14vDUDMsARNfBPFv7bh4lV9bZzNMhrpx1q4Ao6HUC4vIyXkogQZLMU0TBdJYMj
 guXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792165192; x=1792769992;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HuldiREGwIgW0ZXXXm1bvgoI+F5x2DapbOFP5TGPXE4=;
 b=MCcv/3wUBZ9QpWFn89v5RFILibM39laeLc7ZmSGPQLCrteTcZom2iwVlxb4yOl+Z2t
 eX2408ZmbFTEMch9bkexrZB8uBtuqBJCJVq2YE6LEyNlVaK3B3OgH2IamH0frD1vAzyK
 pSn/VNWsWYH7UQkO7rYGU0BgBeJXVfniHyJXsOLq4dFBrH4TmgQBjcORg2CaZDEIm+5D
 tWOkGLP908Ht/Om2AsqWqvUbSxVIbhFnOFU4f/gLz9S5INPv2HQ0CpqW2My4DGlZ0oGm
 Wk+zfx7l8jdmEf2zBoTKwxSrVPpIzCEjv1Ki0mmCUbFDiilUv8mDkkwkWuPI3r/jqhsg
 9e6Q==
X-Gm-Message-State: AFq9FYIeFItVGZ0j+kdjvo4NcxNdvYdqlYgjbY4Ed5Ar2kAEeqk5PHwE
 0LXLNqce6gMnkA1J+yIG4Wcx+kM14+lzmL+CphS/GbzahiPPI16BqYvpKyc1ASkvfSqUA8pakt3
 w874e63c=
X-Gm-Gg: AYBFou1AC2ZWV3Wx1P9cgcUSCp2mcjADncjn/ZdZudK9GMofxwP+/3LJ1q8bgCix8RR
 VSFDM/lg3MeW1pgL2I0Ndn8CpDYWTTks1/K0gQWOEau4n0DPbypst/FqD5khG8PcOzgmnF1mhny
 9zX59vJULvwL2fcd7/jym1mxKT+yJ9JRX9B5U8hbdSVrSsYMmGpMrefJ4msNPcn2saqGyDyF7FT
 wBbX5bwL8hHq14ryLtAiFDHj3oJ9blhLYQuXrADe1+VQsnpapP9tt1eMyDF5oY+zB0i/fyw0u+U
 d3+SvQ3C0i+cQNhxTtMksdvHS4zKmeoTW9cTk5lYz/kxnbVX7SPowDm6V/GC0x2Jf37J/oofx0O
 uI2FATK1Qnc/3oXNZwOD0NX4giAKP38yb73aTo9+wdUgr3XuQm9Uv8Ru26xh32i9YCKueLfT7iG
 PkYk57DHi6mtHzNtuuW1dnIFXO53b4d44fue/NFT14ChvLCPoGUjscqk+Oxrbi0Je2ZftVV442W
 pKwj0Pzod6MAqf34nRch+DunAYyVE/XsQjlIw==
X-Received: by 2002:a17:903:1111:b0:2e9:4f7b:affd with SMTP id
 d9443c01a7336-2e9a6846609mr3771715ad.6.1792165192006; 
 Fri, 16 Oct 2026 08:39:52 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e804cf3sm12214445ad.25.2026.10.16.08.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 08:39:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/3] increase memzone name size and fix rib/fib prefix
Date: Fri, 16 Oct 2026 08:38:42 -0700
Message-ID: <20261016153949.2965592-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921215733.404686-1-stephen@networkplumber.org>
References: <20260921215733.404686-1-stephen@networkplumber.org>
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

This series increases memzone name size and also incorporates
the patch to check FIB and RIB namesizes.

Memzone names are limited to 31 characters, and ring, mempool and stack
names lose the length of their prefixes on top of that.

Patches:
1. fixes hardcoded 32 size in crypto-perf app.
2. increases RTE_MEMZONE_NAMESIZE to 64 and reorders slightly.
3. Anurag Mandal's "fib, rib: fix name prefixes" v2, rebased.

v3 - rebase to 26.11-rc1

Anurag Mandal (1):
  fib, rib: fix name prefixes

Stephen Hemminger (2):
  app/crypto-perf: fix asymmetric op pool name size
  eal: increase memzone name size to 64

 app/test-crypto-perf/cperf_test_common.c |  4 +--
 doc/guides/rel_notes/release_26_11.rst   | 36 ++++++++++++++++++++++++
 lib/eal/include/rte_memzone.h            |  2 +-
 lib/fib/rte_fib.c                        | 16 +++++++++--
 lib/fib/rte_fib6.c                       | 16 +++++++++--
 lib/mempool/rte_mempool.h                | 30 +++++++++++---------
 lib/rib/rte_rib.c                        | 14 +++++++--
 lib/rib/rte_rib6.c                       | 14 +++++++--
 lib/ring/rte_ring_core.h                 |  9 +++---
 9 files changed, 109 insertions(+), 32 deletions(-)

-- 
2.53.0

