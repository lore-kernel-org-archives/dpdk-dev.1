Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447E2D2502E
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 16:01:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6BC8402E5;
	Sun, 11 Jan 2026 17:01:03 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3CB1D4028F
 for <dev@dpdk.org>; Sun, 11 Jan 2026 17:01:03 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8b2d32b9777so849133785a.2
 for <dev@dpdk.org>; Sun, 11 Jan 2026 08:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768147262; x=1768752062; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bPTJNRLSRYZ9VyJ3hrWlxNWd/jv/NyMvVMi2hMCWawk=;
 b=fZZWxlhVObljX+Dlq4A+osLIMBf1WvTokyrF3UgdPwUaUNrhTwrc0rsGhtwPtevN0l
 5OYD8zU4rnhqGyVtj/idmBlDee1sikeB/y4Hkiv2MxsOev+UjmzPsCt2jgzSNI8/PEEL
 lhUDDAU6wNnhFJNr2ourZuUynOQnbqCw/0OHqQ9qZeXeaZjwtb01iXY+4QKIGbHixMiO
 eXVWUVZwrBaAw5vP5konsMq9FcxQ//4Lln0APeYEmEEfekZp9d//bTaztJKDJlpaW2rC
 NAPuV+2zrxJjSE6kGDFWAgV5MVvOotlKXfVg7uEUffKm4t40aav7fIk5YOHPpupZHEau
 kqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768147262; x=1768752062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPTJNRLSRYZ9VyJ3hrWlxNWd/jv/NyMvVMi2hMCWawk=;
 b=meMWesGGGWb3yI0lG9rYW0dzfBHhhKi1XtjCovni0in+vde53wrE286wvygogQoxKz
 uAtdIOySEnboodxWEwd7n1C6fM6jtBrDkaN1cqyJHgm7jmlgr6bmYmd4hTzwjQj+XL9P
 7TtdPIV1YNblIN2lzuoEghSMnFEhBpkAA2lSetimODbjsXGeHCD+gMlvqvVRIxJM0Su/
 u+8ymMUzNTiyXyrj9ZaKwGAJjE3FUYT29pQBNT2CF+A+6UUY5tbtZRNkavgYy1WoE6DW
 shqu0xN06SmSh8wyp40QdM+SYb9vzk9VxTBpCiPBhjemBQSyPqcElduVASGx2RkH2GZN
 FdBQ==
X-Gm-Message-State: AOJu0Yx8bSUvKwEimYQuCCqhJFky3Cl8/Uc8AslFpQ/Y/YGiHTUqmE1s
 n37V8LNvgqAj9D/n6OBrzfW/JD2QV6QTksAKiATCPvFrZ2kTCoYP1vnflkRurA==
X-Gm-Gg: AY/fxX4RvpziCqec62kwFCbVDPzk62Qrwft7cVU2hp9khuwBjMN9BBzrexUa8PsteZo
 7CkrPviYK1ZKbkkGT6EAuvjjbX4AdjC8Nx6iohDZ1z5VNesZx2nYsbWzgjpLPcO/JHX0AZZ7yeo
 rUof0djRkTouyMKYPQ/6w0lNTD27W0s8vveddcxEM1Ih/nzW+PS6LvTkRqH+LgWkP2tG2Fkba0i
 2fMXjzaGc/lqsRpGWQChvW98Sk3FH7Ry6nJBoFDBEG9I8zGO2ZQt9U0rsg61UsPxCySL0uh38KA
 JPjbRL+UA9V5zOr7s6kPwzCLgM5NKkzLAnwMolyO2A/OXQL0MDyYoNFuGtv4F8f1sAyN6ZcmHP0
 2GTocBMZpRRv2QAYJCh6Ley0jYJU27IrQMsOxEPlkLpshFhjVuafrEIRQdW1paY/b/Ekr2P+8eJ
 xtHXo9BTIIotL3QmEl/p/TGCaDIVH2QuuYN5a+bgSCZzEbN4HN+166VNvqeHqp
X-Google-Smtp-Source: AGHT+IGUBOvZodOTbKicy9E+1r1cJNBcPgb/lPNbWmI0ZkoxIPKCTWfUGzrhb9akHc2II7wigOUx1w==
X-Received: by 2002:a05:620a:40d1:b0:8b2:f9ac:a896 with SMTP id
 af79cd13be357-8c38939d000mr2036464985a.32.1768147262362; 
 Sun, 11 Jan 2026 08:01:02 -0800 (PST)
Received: from st57p01nt-relayp04.apple.com
 ([2600:1000:b19c:b9d9:b0a4:2ee1:3986:5e9d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890772681desm120304066d6.51.2026.01.11.08.01.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jan 2026 08:01:02 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v3 0/2] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Sun, 11 Jan 2026 11:00:57 -0500
Message-Id: <20260111160059.293-1-scott.k.mitch1@gmail.com>
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

