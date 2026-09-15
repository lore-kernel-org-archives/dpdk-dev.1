Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D6C88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:22:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E6384025F;
	Tue, 15 Sep 2026 21:22:15 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 7DABE4003C
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:14 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso131583a91.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500133;
 x=1790104933; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3NTE49/+hPIEy9ojOKV3bTaqlgdqlGt48BmwlWB0Oys=;
 b=WMAyLUMntb08b6QkHHTRMd4be5kLGYlzxk5dQauNvCsTDGMSdlZVGFSC4lXiD+AvGx
 7vC85WFZZ8xvlsiU8Q3au6QBk3oAr7hdoft0GKagY5fLqwgy4A6MvetUlTeFkSsI1x1d
 c22oBkd2bVT8JKsXb5Od6rDf44KdRjcf79h8wPHobzMRrjoRHMR02snhT1WY1mguuDy2
 b5onA/Bz51spo2ipAzOnolmUxxbtsBelcC8wDnKsn9+ulsrZOuBY6zfrbhIibqKDTOFH
 WHrBVXxq9vsvjvv5ORY71qmCEBiTUXCRwmo+Iy44vkbGYwjGq1G5zCnbDi8B8PASLAY5
 7NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500133; x=1790104933;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3NTE49/+hPIEy9ojOKV3bTaqlgdqlGt48BmwlWB0Oys=;
 b=uVVA47kcyMibiFY7uYrhu0t7mquT44dfyBu4zrmLbQOjshcliVir9tLN+907p3myXx
 1g1WpTsfhgs7lp7JB1rgCR345iqI6hgrD21OcTYCpe1ax/0+muFMIlFzRf8eJaIlcDFQ
 IhEX+Sb4T2v+s8LxNYLttXhDWxkNfKra1VYPDFl5RvKp125sLYDJiEnFQuCdGHO0+qnF
 URW1D7UDN1yGFEenvOFtamGl07K/1cFx982vFV4dLl3+l5HS2FeLTSWTwwP44UzJu0aL
 hRRSdzRuzuEEulQKxHg9qZtpUtSqMdq/+DYeNmfoognKBV4GyUTtWjQg6T9hWstHNhYH
 mryw==
X-Gm-Message-State: AFuF++ldw17VXQ1/5q2iBo6u8cexJIcCoW6nM0ycMBL5vxhCGQ6VTm+O
 Nfe3oEhHuojr064J1FnDDSpPa22mgETWW3FqcnWHEonQQae3pl5zcKkxuhgegccSl9Prj6ywswZ
 nXlqc7MiDyg==
X-Gm-Gg: AYBFou2NmSQILgFkmoL9TtF4aMvI4tvD/4LmOaI2OTnwbMET3fWLKGF6PfRitz7LY4G
 3TmmU8GhUSX5wDqZApwlS8OVZt4AyZWdIQEk1q0hez843wEf5BM74J//XIEM4atdwm33PgiSmT1
 sxbm+yPnL4iw64drU9VbAA2fVOgEKfomZ9t2AwVbH4OkHWtiMD31zTU7CF9rS9tZOnvF25JflKy
 AuSkvdPRVSyG0fc2I8mMJ5Vs00m04Z/ryxN0FaRo/ZPZSI2zhLeYPY0mHZVAEnvwR7Cz/7NAc2N
 xQX3KPgceLu1aI7/pYGRE6x/SD+elYoln3o0ttUUvtpgamWOvGXz0ENOy3H+z/qqneLjbfIJKOR
 CFuah8I83EV/Bi26HZlBDdODzaXto6HzlkXGe8QMzhYwq06eszgc+0okFe1gp1/XZ3mPckhLWYT
 fjTNUpxyGfqm8WdwET3besGgDEM0/0BhOmyuFE3Xp/YqVeoE3lyI4eS0EigpD8FLjNh/se8h2rb
 OkLg4q3gim9tQhdqzzkdTGnZS8tGLAx5xgfog==
X-Received: by 2002:a17:90b:1642:b0:39e:b7:cbef with SMTP id
 98e67ed59e1d1-39e00b7d25bmr10361104a91.25.1789500133258; 
 Tue, 15 Sep 2026 12:22:13 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/18] random number generator improvements
Date: Tue, 15 Sep 2026 12:20:58 -0700
Message-ID: <20260915192207.3926217-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

DPDK random number generator has some issues that are worth addressing
in this release. There are seeding related issues, and the current
random number generator is weak and seed could be derived.

The seeding issue is caused by build detection of getentropy()
not working; which results in use of TSC on many systems.
The fix is to always use getentropy().

The security sensitive values (RSS and Toeplitz hash keys,
the IPsec SAD hash seed, an IPsec salt and random MAC addresses)
were generated with rte_rand(), whose internal state can be recovered
from a handful of outputs. The fix is to introduce a DPDK
wrapper around the more secure kernel getrandom() API.

Also found that the sched RED was rolling its own very
simplistic PRNG. The fix is to just use existing rte_rand().
This does drop an inline function in header (rte_fast_rand)
which should never have been exposed.

For Windows build, shims for both getentropy() and getrandom()
are provided.

A couple of other improvements to rte_rand:
  - seeding uses the whole 64 bits passed to rte_srand().
  - helper function for when only 32 bits are needed rte_rand32().
  - test infrastructure now supports seeding for repeatability.
  - unit tests for rte_random_bytes() and rte_rand32().

Stephen Hemminger (18):
  eal/windows: add getentropy shim
  random: always use getentropy
  eal: add 32 bit random number function
  sched: fix data race in RED random number generation
  eal/windows: add getrandom shim
  eal: add function to get random bytes
  hash: use secure random for Toeplitz hash key
  pipeline: use secure random for IPsec salt
  net: use secure random for random MAC address
  ipsec: use secure random for SAD hash seed
  net/intel: use secure random for default RSS key
  random: use all 64 bits of the seed
  drivers/net: use secure random for RSS key
  drivers/net: use common random MAC address helper
  random: remove RDSEED fallback for initial seed
  test: allow setting random seed for tests
  test: add random number generator tests
  doc: recommend secure random for unpredictable values

 AGENTS.md                              |   6 +-
 app/test/meson.build                   |   1 +
 app/test/test.c                        |  48 ++++
 app/test/test_random.c                 | 297 +++++++++++++++++++++++++
 doc/guides/contributing/unit_test.rst  |  15 ++
 doc/guides/rel_notes/release_26_11.rst |  29 ++-
 drivers/net/axgbe/axgbe_dev.c          |  16 +-
 drivers/net/bnx2x/bnx2x.c              |  11 +-
 drivers/net/enetc/enetc4_vf.c          |  22 +-
 drivers/net/enetfec/enet_ethdev.c      |  16 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c   |   5 +-
 drivers/net/intel/iavf/iavf_ethdev.c   |   8 +-
 drivers/net/intel/ice/ice_dcf.c        |  10 +-
 drivers/net/intel/ice/ice_ethdev.c     |  11 +-
 drivers/net/intel/idpf/idpf_ethdev.c   |   5 +-
 lib/eal/common/rte_random.c            | 148 +++++++-----
 lib/eal/include/rte_random.h           |  89 ++++++--
 lib/eal/meson.build                    |   3 -
 lib/eal/windows/include/rte_os_shim.h  |  64 ++++++
 lib/eal/windows/meson.build            |   6 +-
 lib/hash/rte_thash.c                   |  46 +++-
 lib/hash/rte_thash.h                   |   4 +-
 lib/ipsec/ipsec_sad.c                  |   7 +-
 lib/net/rte_ether.c                    |  13 +-
 lib/net/rte_ether.h                    |   5 +
 lib/pipeline/rte_swx_ipsec.c           |   3 +-
 lib/sched/rte_red.c                    |   9 +-
 lib/sched/rte_red.h                    |  26 +--
 28 files changed, 753 insertions(+), 170 deletions(-)
 create mode 100644 app/test/test_random.c

-- 
2.53.0

