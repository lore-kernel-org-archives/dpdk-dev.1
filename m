Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BEED2502F
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 15:18:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65C0B40281;
	Sun, 11 Jan 2026 16:18:03 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2767140276
 for <dev@dpdk.org>; Sun, 11 Jan 2026 16:18:02 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4ffbc2b861eso47550891cf.1
 for <dev@dpdk.org>; Sun, 11 Jan 2026 07:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768144681; x=1768749481; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SdCllBSRIPuQow8HBwBlLgAE3o750r5RHILpu2ecD68=;
 b=WfHX+Mjn8nd7CPQPM9qvJVLNtQB5ntgsd/NnAm0s4vt2ZpiWOaEtQuflTSQB+304kt
 7pm+SzVGCHnscOloq5WNhEXdjKnT3HEIETtgENj9znKmkK8dMEfmwV64gpqFCKefcAA+
 gzX/zo7yBdzAfnnRSDDHEPDjqJW/18TfeaPSJnXA4UGoCDiUmKu1yL/WZ40wRhgxbHPV
 aiBkaQQl13RS1FErXsc5m/KzzXcVlg1GQ7zG3U3QnZQewigWqFNeggESibWRU6lXvS97
 SdUvkJ70MErjbZM/edlmPbZt1HmYfgiFjV7uw5brBWmdOLeofqlYWbdo0AjNLQWuQxlo
 4DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768144681; x=1768749481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdCllBSRIPuQow8HBwBlLgAE3o750r5RHILpu2ecD68=;
 b=pCd+f+NAOZK1cX/FoyoFV6EEv+R2ZpOe2gtoWrrD7OKrOmb0914/3ijMD7ZVLU3Grm
 BxMclAjm8JLs6QJOlG3NbVuyOsz2TJ8aqm/4R5s0Ev563T7A49e5NwPKrZE9Rrt9tmr9
 +H3JxR7tUOlNLfKJ5am285nLJ8RNmOSLyRCRro/urxdVpB7TKPaBcEzojerwKAxIM3Wl
 sDyf6QExrYL4vGAtvliBx0Kj+gwEfDMEjXnfI6MpurcZnfJLEb1202SjJ1OlK7tbR5iU
 gdRBEQbmCZz7pOsCgz63EYXd9h1yl6aanjLvP1wQF5q4bCqZVb3UlMcaj7KY1+j2tw/+
 3BwQ==
X-Gm-Message-State: AOJu0YxSLnW7kAsgKJ4BAoBDI1y/yprKstw6kibqt7ySJFtUQa7AKCu3
 A1w/XqzYaB9OxnnJPTIaaxuiUx8W8kdQe9Dtisuk0nRCxrZ+dVVo/zPGtEY9Qw==
X-Gm-Gg: AY/fxX7XLilswv9xOl6lvjXQfYR1ELj0ODbUvzehCVoI7h8/g7pGoHGxwHm09aAdIzK
 AoX5bD2GPy/7MbzbUycWJEtgV2hGFXYz07mC7MTa3mWoy/QgfKPMworrxHDAaZsek5mz5GKVuQD
 lJCeprldt/5fd57BQfvGeTV5a9YSb+Fewk6yM+ynPpcKbm6yZIUvC1S/7cT+sgfCZ6wlL7JYpf0
 Jl/IinMkfz6BtqJFxyvCJKa13fw4PN+BikGxcv+qSLZs/33ws87gSDos6MLVTM7wpRZw/TSrJoI
 mSPtuTAFO5RaTZ+djRS1d4TDhHPl8B3awvlqMIoHcV1x5OetIGMkrpiu+jmX1uBmSov+DJ/cM5R
 qdDFF/l/ODZsj1lC+E52bIH/vaZzWLzuE592NDWDNDU//NQI/nbEVkm6Cz/cKwesGdkxS5w3F+J
 oBsiAAOhwxeM+GltL2a2FhpdmsheSzZ84HrZAlQnvzjcT7Pc3MUuBO7MylljI8/ddhVQ==
X-Google-Smtp-Source: AGHT+IFlu/GDnf7PhhaUEbioZS/ejM3nJ8XqclQbV1Kfmcce0UraJPT9BjoswF1w+pNbFfn0lceBiw==
X-Received: by 2002:ac8:5f0a:0:b0:4e8:af8a:f951 with SMTP id
 d75a77b69052e-4ffb4aed9ffmr217615521cf.83.1768144681248; 
 Sun, 11 Jan 2026 07:18:01 -0800 (PST)
Received: from st47p01nt-relayp01.apple.com
 ([2600:1000:b19c:b9d9:b0a4:2ee1:3986:5e9d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890772346e2sm125909716d6.33.2026.01.11.07.18.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jan 2026 07:18:00 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v2 0/2] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Sun, 11 Jan 2026 10:17:56 -0500
Message-Id: <20260111151758.89015-1-scott.k.mitch1@gmail.com>
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

Note on checkpatch warnings: The patches generate checkpatch warnings due to
C11 _Generic syntax not being fully recognized by checkpatch.pl (designed for
kernel C). The warnings are false positives - the code is valid C11 and
follows the same pattern as existing DPDK code (e.g., __rte_constant macro,
rte_bitops.h). The COMPLEX_MACRO warning is explicitly acknowledged by
checkpatch itself as expected for statement expression macros.

Changes in v2:
- Fixed copyright in test file to Apple Inc. (was Intel Corporation)
- Added checkpatch warning explanation to cover letter

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

