Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EAAD2502E
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 15:00:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6B0140281;
	Sun, 11 Jan 2026 16:00:51 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3C87740276
 for <dev@dpdk.org>; Sun, 11 Jan 2026 16:00:50 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8b2ed01b95dso619426285a.0
 for <dev@dpdk.org>; Sun, 11 Jan 2026 07:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768143649; x=1768748449; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MJ7PwmiC3I4q9GOiVO1XO5Fhr3C1J23CvbvQl+R13jo=;
 b=WAPixx8Dxp4DaZenFknTw6u0nTAMdOEmcYIeuIA43pDzIrm5dS0kc7iLSD7jGH29Tc
 735JuU+oVJmiPc80H5hqpBs/xVPgEkHKSRCAJzkFiLoT8w6yB4GDYKpG9MkGZG7hXdaQ
 v3d96DoJ0PyibPOtSINpYd/GB9ch+KOaYr7AJgjlHMcSdwZaObIheSpcqEmwhiDUye1s
 MJJGPAeelsHHRTdLdvBqSCl+XOiOaqg2xPqWQWmyUw+GJu3khZONXbiuuBMTHm1RJxTs
 DS4hHI8HeTqon1ZAvaRhTXxJDbetnQfsFHP6DI72/sS0l4jqAnw8GGKqyijCgrN3ib91
 i3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768143649; x=1768748449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJ7PwmiC3I4q9GOiVO1XO5Fhr3C1J23CvbvQl+R13jo=;
 b=N4o9Gjq0CRSx/OWcLGDd9PuA0ctWl7TAxgQnDHf+JvF2I3MgDVDh/bNaXU8y0sOumb
 PkDvvlEB9Bj9Bi2efdW09iPuua2kOEJYoVayESBzOeZAIO2yCPX3Dy02fZD6kKxzckyc
 ta1A5ZMfJKfnwkVi8tveSaXLvaOAdu+HVlpX2+OaXI/kyFnEwCdbOoO5wSal2TC8lvgd
 aGGVx/gJAKSfNnR/PSBZ40VhmGysIhGBM6VI5432Vt89mhf3Z+ppu0h2KEvqECqUnN7N
 z1/3imI3Ef+miX6H2u+nLraYrMyysulIb4VciMEfSok/fUXC41AwAvpfjMNcWLbIWU7u
 TKeA==
X-Gm-Message-State: AOJu0Yz7E34TXusR514LjNPwhb2l9RC1WEOPvbt35cl7UxDLUQdWnm+v
 cXgFX/VEgwe8VqFrr6MQ9pn+zh3Wf96oySoPLFgzq261V5II9NW/TS8x1VaLUQ==
X-Gm-Gg: AY/fxX4fIc6PbDhZpOAqFk4dMNEtMWo7luHKlHKkmif13bjChSm/pMtTN7+/vFxcPQZ
 iHQUbz7YD+dt3y23uI95nkU3N5g3ZnUnOn50+KrZlmZVP7+iFPBTnSBWhz4R3GrIdDmSf7mxu3E
 X7oPonEHMAIk9KfJbcZrb9xWB8t2JdaQwdWfotgn3mgbKsjNR4IW1Ekxeh+7IfwtBGkt3iGHALR
 /cemp8322i3swDz2xhnfb+1gF0MMjtXRwCxk8qKC2Mqp1o3AC6qT3P/WcHyOgRmzdg1s64pfQME
 ASuhxRorls6YB1mK82/AJo8G/+w6detyVvFCQt12MGs7bgiwdniai2LFLPW2faxAySOn5hIAWGU
 Bv3z/rjQFleHrUWDZ5Le4jHwjnzAboT+Kjvj2Yds3cDVLk4u/j7DAJo0x2xdW1N5l5vbMYF/mIl
 9cpVIIZbKu/lBNpvKczYqBaogh9hC/3Q2haw/0Sd6VsgIOkGyUbzvQynlYtKqTLJvRJg==
X-Google-Smtp-Source: AGHT+IH47lgz9JYZ7VOsbfdWBeciYx9u/xYUS2Yiwr2d/pZmvAQ4BceytGMVimpXNz2SGDzIxGkHGQ==
X-Received: by 2002:a05:620a:c55:b0:8b2:74e5:b13 with SMTP id
 af79cd13be357-8c38939ceddmr2023599585a.32.1768143649214; 
 Sun, 11 Jan 2026 07:00:49 -0800 (PST)
Received: from st57p01nt-relayp01.apple.com
 ([2600:1000:b19c:b9d9:b0a4:2ee1:3986:5e9d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89077234d08sm119361056d6.28.2026.01.11.07.00.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jan 2026 07:00:48 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH 0/2] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Sun, 11 Jan 2026 10:00:31 -0500
Message-Id: <20260111150033.81760-1-scott.k.mitch1@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Scott Mitchell <scott.k.mitch1@gmail.com>

This series optimizes RTE_PTR_ADD and RTE_PTR_SUB by using char* pointer
arithmetic instead of uintptr_t casts when operating on pointer types.
This enables better compiler optimization, particularly for Clang which
can now recognize simple pointer patterns and apply vectorization, loop
unrolling, and improved assembly.

The implementation uses C11 _Generic to dispatch based on input type,
maintaining full API compatibility while enabling ~40-8x performance
improvements in checksum operations.

The second patch adds a .mailmap entry for consistent git attribution.

Scott Mitchell (2):
  eal: RTE_PTR_ADD/SUB char* for compiler optimizations
  mailmap: add Scott Mitchell

 .mailmap                     |   1 +
 app/test/meson.build         |   1 +
 app/test/test_ptr_add_sub.c  | 190 +++++++++++++++++++++++++++++++++++
 lib/eal/include/rte_common.h |  76 ++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 app/test/test_ptr_add_sub.c

-- 
2.39.5 (Apple Git-154)

