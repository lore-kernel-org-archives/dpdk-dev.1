Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20F6D2502E
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 16:06:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3CA24060B;
	Sun, 11 Jan 2026 17:06:30 +0100 (CET)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0D9574028F
 for <dev@dpdk.org>; Sun, 11 Jan 2026 17:06:30 +0100 (CET)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4ee257e56aaso51135641cf.0
 for <dev@dpdk.org>; Sun, 11 Jan 2026 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768147589; x=1768752389; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Q29+XNJ3Lyjq2LuC3aTQK6noVtfadZ6xcZ7PVCpkF0=;
 b=a/lD5LOh53khwR4aFeZ9NGv0URC/1mVdX2srtnzCizVRySTkAC3/xIGK4Q5Jesoe6d
 CsuM+6TKp9yKdZ5wLEB20X3GU3JBoWT59+Pd5qtaOvUQ/pIg9XS/p9LVk16kgYTILKHS
 GM9RPeHAUktkj8QbR8Ob/rwcTfxxaIq/PrKpxPI4SnZBgz5TKXZN44iPqoFXimEK7Xs5
 2mGStxqXb+79v5StgVEmBJyDGUs9rQ5ED5XgzTaf5r2sp67WEaQfmcjBk+w5kzV0MhRR
 c9dzmYfDKjNnRk9f01YGH2yenTNErwYR+p1nUpVj6AhjUNAKjbbmn7/e7FM/ycuqfwkG
 0Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768147589; x=1768752389;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Q29+XNJ3Lyjq2LuC3aTQK6noVtfadZ6xcZ7PVCpkF0=;
 b=Wm4IQhUm7wh4xkw9HdTQa4OzlnlPuqCqjqMUqN5xJq9oxMBnbnE+rgUtKQLJIZtk6U
 YUN3H5Equay6pAuiUn3V+7XH4Q73Xu6QpE1w9udqjw9Z7eAxv/YMp70U78oRrajTJFzc
 1LQ1u5TSXpHVTMBhhS/eMuvUgnSGN3MWZig3IwnYnN7ahOzaowZ4/sDfgs8OLtkuw4Up
 tndxRUQEx4gGSYdvACEhwWO1xZtv2h/VJFtYg3dajfN05HZLyGMNNPeer8CoEvvinxjh
 0v42tIDcfNXsINtIczJ8JcPIHRQNjPWCa56wCYHB30Y4V/rXkuoU98peCJU+jlqfvtyT
 2ntQ==
X-Gm-Message-State: AOJu0Yyr92JIk4J8fuz63hql2BazWzH84HkAKxNLDgT3kAXt0dpzzy79
 Ljr9ayCqdU9/Cx7PC0PrjJM2TvvV/bCX+gY5QTTPrZpDduO/BxI2QJue0INeFg==
X-Gm-Gg: AY/fxX7qcdOvUXBiSbyaIBG45jQOGk/k1g+97ufI/d9AyUS2SWc4HoanRzdQ24UN5dF
 +oNDMPxQajyBcyZ3/4OWE3Is+tjDUkaxQEBR+/Iv3gJ2IyebIZySd8TNeTRga2Dg0n/Ea+U4shl
 jIWu9iDB2D3CInvfSI63B9WfgiSdnm22RnlPP+UurHbyLTB6RQkCYy2a7iIZxwwjiuA5dDE7sz5
 9UUxbuO3NsS4MC86fHU8Gp6U41/BV7sN67RnmR4RcByL6Qkxwm76Hl5e/AP3FmoFW/ND5n3MeMF
 08cM0PHcBToVmf/+HXDYuJJHq/tPhzXPklEjulv16ZOQDzlcYEhDhRXqDeE0pewZzMUh3q0ZhZ9
 qgzsXdx9Bl905DIBN9D6N1reemq4wxP3R67yEhUY0jvd9taac8sGTIJ7SOW0jPwgbo3kggH96oU
 9g9/l6bx+H4enBZJyaG9rbvjuye2pNrrh8Ny+zraOjyA1Gkz31c+vHUIWmp7uI
X-Google-Smtp-Source: AGHT+IHjOZvnK7KlkvHMsDkv6NIi9N+WMQwbCPkyXDnllzDedrX0HqTXqd64bv846Up1lg6Yp5mwgQ==
X-Received: by 2002:a05:622a:1307:b0:4ee:1dd0:5a50 with SMTP id
 d75a77b69052e-4ffb3e65dfemr193012671cf.17.1768147589173; 
 Sun, 11 Jan 2026 08:06:29 -0800 (PST)
Received: from st57p01nt-relayp02.apple.com
 ([2600:1000:b19c:b9d9:b0a4:2ee1:3986:5e9d])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8d3d34fsm106575561cf.4.2026.01.11.08.06.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jan 2026 08:06:28 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v4 0/2] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Sun, 11 Jan 2026 11:06:24 -0500
Message-Id: <20260111160626.2103-1-scott.k.mitch1@gmail.com>
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
maintaining full API compatibility while enabling significant performance
improvements in checksum operations (40% for small buffers, up to 8x for
larger buffers).

The first patch contains the core optimization changes and unit tests.
The second patch adds a .mailmap entry for consistent git attribution.

Note on checkpatch warnings: The patches generate checkpatch warnings due to
C11 _Generic syntax not being fully recognized by checkpatch.pl (designed for
kernel C). The warnings are false positives - the code is valid C11 and
follows the same pattern as existing DPDK code (e.g., __rte_constant macro,
rte_bitops.h). The COMPLEX_MACRO warning is explicitly acknowledged by
checkpatch itself as expected for statement expression macros.

Changes in v4:
- Fixed duplicate "v3 v3" in subject line from v3

Changes in v3:
- Fixed CI build failures on GCC
- Simplified const pointer handling: GCC type-checks all _Generic branches
  including unselected ones, causing errors with the nested _Generic/ternary
  approach used in v2. Now uses simple char* cast for all pointer types,
  which compiles on both GCC and Clang while still achieving the optimization
  goal (char* arithmetic enables compiler optimizations vs uintptr_t).
- Removed Clang-specific pragma for -Wconditional-type-mismatch (no longer
  needed without the ternary operator)

Changes in v2:
- Fixed copyright in test file to Apple Inc. (was Intel Corporation)
- Added checkpatch warning explanation to cover letter

Scott Mitchell (2):
  eal: RTE_PTR_ADD/SUB char* for compiler optimizations
  mailmap: add Scott Mitchell

 .mailmap                     |   1 +
 app/test/meson.build         |   1 +
 app/test/test_ptr_add_sub.c  | 190 +++++++++++++++++++++++++++++++++++
 lib/eal/include/rte_common.h |  60 +++++++++++
 4 files changed, 252 insertions(+)
 create mode 100644 app/test/test_ptr_add_sub.c

--
2.39.5 (Apple Git-154)

