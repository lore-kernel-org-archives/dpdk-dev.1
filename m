Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131FCD4A603
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 06:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AC8D40698;
	Fri, 16 Jan 2026 07:46:54 +0100 (CET)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44]) by mails.dpdk.org (Postfix) with ESMTP id 439014060F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:46:52 +0100 (CET)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so2509064a12.2
 for <dev@dpdk.org>; Thu, 15 Jan 2026 22:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768546012;
 x=1769150812; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJ+fRqM6EolvrK/rNCrRA30zBlYfOHd9NUQ1C9LLADo=;
 b=Wq3dBlZArKIy7jfHk+695fhfrjMckVNyYvkQ6mwH4Cjm8+8A4Cg1iqjT6U86/HtLbg
 XdqwMN5C5fuwigpi53UUv62LmHZaZPVfs1voLo2hreqKMkcQFiVr8ZUOAsb+kHiBL+TQ
 5Bhk/0CmI2SEfhSmia0oLxKQXAtvEcoXHyBWOSY5CkYbPyVto6G7Bb5gyth+T0UTIzVm
 /QPwp4Qzn8+KrCnRh9zdlj6ieqDU0Lg2aKYhow+zxSw0e6mFbFN2VH2vtcVOJRj7tqiV
 3DrbBgUJli1lRvasnjWSXtBHFH3jd5SHVgavNiLB9iOCNRC3yiaZV4waTuNlVHMdqE5m
 i7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768546012; x=1769150812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xJ+fRqM6EolvrK/rNCrRA30zBlYfOHd9NUQ1C9LLADo=;
 b=Pah+hYw7WjFG1AnR+S2ODArvncJj+MB4x9vbHgGvA/B/5nL6QvNx88NtdW5Mk3G35g
 ofv+RNpymurAFp24pmeTzh0w9YHRSk3o4ACBnsCMDT8qo+OT8ATyfgCna+MlpRrJvemA
 A7duDhA7IaJhD57BiOwCmCHoF3Z9IdJNJXGIlaUlQOAuc6Uiupt+CMBSQPMzUQ1HzmFE
 93586kMHYAS8WMPTp+640w2McPDcBA53luL4fTVkWba/GxVvh5b+ED8zAUbNYt6H3XSK
 zzHY8TThjLFTDx1hamiLdmsB91Xl8ghqVmKQI9MIegkoog1u6KeMlY+8a7CaVdq18IgB
 26Ew==
X-Gm-Message-State: AOJu0YyiC3C38Rg9kw0r0ZreQAbFOa0KRVLGmEShbym2e5VqXTi9O9jm
 ZvfkEvpQPE7/69DxTiUB+D8YskTzH7nG73jSNVlJNC+M3vprM+jFFRUZZsATsj0QmOIFrSIplQI
 DWm0W
X-Gm-Gg: AY/fxX6PsxJn/Zh0dneYO62OZVBNfrcl3fFngQebpfXpTWGB2SHcoOf3X8eKDrGbTyO
 7AWjarhO0IKs+oOa1Pa9WgUfURL5qEbog3aQwWNHyswbnb7dk0bOvnOlo22vSzrCQlswWb0s89s
 0N3dQQokakpzoWhbVZRdUKL5roeQIdfljZBzdzpUxYe2yngenQznMlPpSoPWnKQyClUbwyLBFxJ
 CwMR+MYaLRl4zzVAZE0q2mVIYhdusMwrbIGZ33AwVVS6K0OniGq5gDRpqt0W+m/dFJSx85XTwY5
 hpq52Z2nvze6k3JyLpXk8qMiDMofeYEEb/t1nroquZCfDJj3bEKSYE727o7rPnM9qxVAzU27LIX
 ohmu6vSjnG1upAlxFsA3/n77bwQv5mr5cO21VulgPVsPU6hxbbU/ku6GZmIVNssvDyHpQ72W3Tq
 lEqPyCPrawWWllnBxiD+WoeGi5/n5wmI9wtXsYy+RZJwKhXR3gVw==
X-Received: by 2002:a17:907:7201:b0:b87:281b:1453 with SMTP id
 a640c23a62f3a-b879324d5bbmr183583466b.59.1768546011632; 
 Thu, 15 Jan 2026 22:46:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879ae74639sm97172866b.9.2026.01.15.22.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 22:46:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/6] fix GCC warnings when building with LTO
Date: Thu, 15 Jan 2026 22:46:21 -0800
Message-ID: <20260116064646.224254-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023194237.197681-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
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

This series fixes all warnings produced by GCC when building DPDK with
Link Time Optimization (LTO) enabled. LTO performs aggressive cross-
compilation-unit inlining and interprocedural analysis, which exposes
issues that are not visible during normal compilation.

The problems were diagnosed using AI but the fixes all look
very reasonable and consistent with other code.

The fixes fall into three categories:

1. Buffer sizing for static analysis (patches 1, 6)

   When LTO inlines functions across compilation units, GCC's static
   analyzer gains visibility into buffer sizes and all code paths.
   This causes warnings when the analyzer cannot prove that runtime-
   selected code paths stay within buffer bounds. The fixes provide
   either larger buffers or explicit bounds checks to satisfy the
   analyzer.

2. Variable Length Array (VLA) elimination (patches 2, 3, 4)

   VLAs cause -Wvla-larger-than warnings with LTO because the compiler
   cannot determine array bounds at compile time. These patches replace
   VLAs with fixed-size arrays using existing defines, then remove the
   warning suppression flag that was masking the issue.

3. Genuine bug fix (patch 5)

   The LTO analysis uncovered an actual buffer overflow bug where a
   1-byte allocation was being used for an 808-byte structure. This
   is a real memory corruption issue, not just a false positive.

The patches have been tested with GCC 14 using -flto=auto and produce
a clean build with no warnings.

v3 - add all the other stuff necessary to fix all the LTO warnings

Stephen Hemminger (6):
  test/soring: fix buffer overflow warnings with LTO
  common/cnxk: replace variable length state array
  common/cnxk: replace variable length array
  common/cnxk: re-enable vla warnings
  common/cnxk: fix buffer overflow in reassembly SA setup
  net/mlx5/hws: fix LTO false positive stringop-overflow warning

 app/test/test_soring.c               | 29 +++++++++++++++++++++-------
 drivers/common/cnxk/meson.build      |  2 --
 drivers/common/cnxk/roc_aes.c        |  3 ++-
 drivers/common/cnxk/roc_nix_inl.c    |  2 +-
 drivers/common/cnxk/roc_platform.c   |  4 ++--
 drivers/net/mlx5/hws/mlx5dr_action.c | 14 ++++++++++++++
 6 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.51.0

