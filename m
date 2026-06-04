Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32976CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:37:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82A7640671;
	Thu,  4 Jun 2026 18:37:01 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id A4675402D3
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:36:59 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-304cf518c9dso1097619eec.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780591019;
 x=1781195819; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Plc0dwSFKee9yStiXQftSPj5iC1E0byzBvQKHKzHBa4=;
 b=mGFkb3FnbIXJ/4OWS66QuStziv92HmVnt/GH8EFyQZVWQpOtUCOO1wN0aJ+mK/uAr1
 jHC1Zkl3y2uBL1Mm45qzMD0ikvWa6eZXgUfL+ZYseeWDGcg0KFuALI2CGdzS/mimckQE
 3Z2MZJDaOQwVjGwOeKHMR8I2QoYKRVEp5qSfux8BzWYkc/Ivm8JqSBueccg8ZQzn4OS5
 Do3hM3RarY21UCVe20BIbUv/Q+G9jzfDW8XJEOOhawM6qOhtO+7TnmH/UQGDq0bp72Zd
 bwGuBBxpph8GrxsO+0oW3/L9EQ9NcMUKxqwFew4xTiHUBTK+FhGuuRF+8ixEt9HeLYaE
 oUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780591019; x=1781195819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Plc0dwSFKee9yStiXQftSPj5iC1E0byzBvQKHKzHBa4=;
 b=pUpKCnkvOgJa72zn3O2b1c1ytSlOe1twY0wzdNQ7ei2sMMKzrFro2tKxr8ZkDh8VIN
 FAz/1cMEfrh+5f/zxdX648fLLwqWMB5R3jiKqAT3NNTmirJT7ZyxgkplccmHL1laTPBw
 hdD32RKfAxyoyTQ6ZSjkD+aTU9T4WD+njB7dzOXRB6O7jPZeIEy0S5n0DRbNvXm6IycJ
 oeOKZZ1yiEWpFuyKUGmZKSk5gIVbPDh03pJgHbDHq00ejN0rDS1m6QOOy2t2v8HFjN3Z
 NaPZ6N7nWgAgwrGcxfDv+yeSm0Tw/qHFlqyPBC7MC3PrUQW6Smq+fNnh9mMfVsHtbTKf
 PdFA==
X-Gm-Message-State: AOJu0Yytq/hHoygq+F7/3o2GTH7wyzZ5omPEiIveGw7deJwI19mbf5rn
 b5C6/6eA2Tp3yg76HzdzacGFotdCCS/pwvqyKwr67ABAfoxd1nynPwxqCcxwwbJIas4waJ500np
 DcDfc
X-Gm-Gg: Acq92OFoTFlxe1WsRGY84ggS+ekXhLqez0OBgIUDNNuB26yBeGlBWaZ/iLq+i9rrBeh
 TGhXIe7Ngc3NoPpnEGECnYLEXrK/PTSj2f5m6w2kv6+NuH0RHFoy6FO9LQabFbKvq0TnlEeuh+q
 KOAbDubyJ4SEFUfaA3/7mOsSPOF5ZBuzULAp98oXy07+RoHtrlle798LzvqhjNB7qxsut5fSk/G
 B95BJraadmnUDXYGq5PnjoZ1FJm3/25sxwe9M9XmM6/sEZrMhclaRECZGXrDTfXplk7g4XCWfFJ
 m5VY4LUnp0e6RRlC+zzPKfIgP1iaU95UOQUcNOyhhKSLiNo6FOpPqmBEYUFUrsJr9kYxQR1Oo9t
 cLsaysMQL9nUErBiRHVTb6A2NTdprql6XQzMH2VNSG1v5mOiAL1MUl1QLgylNHWPjZ91dwHdxEu
 r5p8yIW+RBOMA959D+ANP+alE+qN53T1RiDT05i2jZV/EUnF0JjKRhCDIhcgy+jHpLRxRJlyhZ
X-Received: by 2002:a05:693c:25c5:b0:2ed:e14:7f5c with SMTP id
 5a478bee46e88-3074fc2c6fcmr4634275eec.32.1780591018570; 
 Thu, 04 Jun 2026 09:36:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db56697sm5427951eec.2.2026.06.04.09.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 09:36:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] ring: convert to C11 atomics where practical
Date: Thu,  4 Jun 2026 09:32:25 -0700
Message-ID: <20260604163656.1226902-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602171552.686349-1-stephen@networkplumber.org>
References: <20260602171552.686349-1-stephen@networkplumber.org>
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

This is split out from the atomic deprecation series. It converts lib/ring
off rte_atomic32 and onto the C11 memory model, except where the C11 version
has a noticeable performance drop on x86 with GCC.

The pre-existing C11 and GCC-builtin paths lived in separate headers with
substantial duplication. After this series, only the MP head CAS
(__rte_ring_headtail_move_head_mt) retains separate implementations;
everything else is shared. Patch 2 documents the reason for keeping the GCC
builtin on the MP head CAS.

The default RTE_USE_C11_MEM_MODEL selection per architecture is unchanged.

v2 - consolidate cleanup patches
   - fix the memory order on first load in _st case.
     it was going back/forth across the patches

Stephen Hemminger (3):
  ring: split single thread vs multi-thread cases
  ring: use GCC builtin as alternative to rte_atomic32
  ring: cleanup the C11 code

 lib/ring/meson.build                          |   2 +-
 lib/ring/rte_ring_c11_pvt.h                   |  62 +++-------
 lib/ring/rte_ring_elem_pvt.h                  | 116 ++++++++++++++++--
 ..._ring_generic_pvt.h => rte_ring_gcc_pvt.h} |  58 +++------
 lib/ring/rte_ring_hts_elem_pvt.h              |   8 +-
 lib/ring/soring.c                             |  34 ++---
 6 files changed, 159 insertions(+), 121 deletions(-)
 rename lib/ring/{rte_ring_generic_pvt.h => rte_ring_gcc_pvt.h} (65%)

-- 
2.53.0

