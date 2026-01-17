Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103B9C98338
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 21:07:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D09D342DE9;
	Sat, 17 Jan 2026 22:07:29 +0100 (CET)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by mails.dpdk.org (Postfix) with ESMTP id B76854025E
 for <dev@dpdk.org>; Sat, 17 Jan 2026 22:07:28 +0100 (CET)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-56367b39e3eso2939448e0c.1
 for <dev@dpdk.org>; Sat, 17 Jan 2026 13:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768684048; x=1769288848; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vh0fKLeNv4Y12gHCejCvgEuhuEhHGCF3OjAIZA7+ZS0=;
 b=lZqoRZpcUSU0it2qSiT+NIvASqsWSNykMik2iukXjUH2t7+eTl1hGL65gUxwpNvDIM
 x7Mdy+j5SAIqQci7dQ58IvP/HRyNAYNbWeleY2Bb0wjJl1kElYq1TaEL3jqAbqoFOM5J
 /hApV4OfxIEVrSn2oicu3vE4RUefhN/wjgNatDofyivMKbqorwGGwMLJ082NmjQnJVnt
 Kt9AJwDWaDvqJsodzuBIbiBF40Rd3ns59F7qlPwPkf2Pr2BNIEyG4zxtk680/ALwxvgl
 Y0vNJCXbtOmISo8KLdVIevUbpTkFkEKydAyyEq0KqOzf9NXGrvejkqyNP1jL1RDwAw3n
 xOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768684048; x=1769288848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vh0fKLeNv4Y12gHCejCvgEuhuEhHGCF3OjAIZA7+ZS0=;
 b=SyEHbrI1BMPR2DQ3vXPO5aeEJBRKHyxkxg6zfTv5n6fAZ1vxThRBCAUx83R1irI+QZ
 fVUKRkhMv+9MRuNFEvOdsarrhl3Ch8nC24DVf7YXQ1R4RrFQy0diuV3Hkm0ZlpwOlaTp
 r/pHyMKqcv1W9mg8CkC77BbnMcVcQwI9Ybu8XU5AOBzssbv/hans0q6yBGaIPcHAqNyo
 loJ6qk5X913k230XNvgtfeNfx+sOMsf73QnukFl1KTjMRTrXvrrG6xETCTht/NKg4IF/
 0PZOk6Ga/HfsRLu9D7FjDJDV4EV116aWYw9RnkqZuliFsN6eUkb66TepqY94IuFNu9L2
 piYg==
X-Gm-Message-State: AOJu0Ywus0af1ATZmQQxMfS/Li6QkbkM/wHwSf0hC7SeRA7Mg7EEhYU7
 lS+GSGyvm2J0nZTo38RnyUCf/ZioZ4OnYc6Sia0gmgguJ58Syh1gtIChIqsbGca5S8kJvGOfsht
 PY9i+vbAci6QyqVnloyOHF5SMThNJ13EbFZpbeAs=
X-Gm-Gg: AY/fxX72nQ8fGqn8On8KvZD8JzwsuU3575NaJY51WmeZ+R5Jv24zW+l7hEgPqIYoHK7
 OYe/eI2xE++irDkaeWvH67IFGryF6thEGiaIg9R/FIJhdsngZAXAP8g9em3yyMeLfvVl38+EO2+
 aZ0FJlXIIPAQRjmGqsGZa3prSf3DOHqBLZckd625Ar3CxOQsdFvqRmxkDZSLJ5wecmS5mbbIt40
 mv0L6+dj66MWPBDyAvUy2fkz9SkgG+Uv2B49An/VgwQlXy0ndvI/nIGWDwfjASzegWPNwU=
X-Received: by 2002:a05:6122:1a8f:b0:563:74af:9cb1 with SMTP id
 71dfb90a1353d-563aa8be3b4mr2409198e0c.2.1768684047704; Sat, 17 Jan 2026
 13:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20260114215648.47820-1-scott.k.mitch1@gmail.com>
 <20260116231907.13895-1-scott.k.mitch1@gmail.com>
 <20260116184428.49e45dd4@phoenix.local>
In-Reply-To: <20260116184428.49e45dd4@phoenix.local>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sat, 17 Jan 2026 13:07:16 -0800
X-Gm-Features: AZwV_Qh_8SvDtQP4Om_te-87HVwc3aAWiqyMxwYuKHcAt3hFUDdJGUHaVj7YGWQ
Message-ID: <CAFn2buDBCOLaues6J5Gx+SZ4CPgcGLzbbv0qSqpHoyOyJd07dg@mail.gmail.com>
Subject: Re: [PATCH v8] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, mb@smartsharesystems.com, bruce.richardson@intel.com
Content-Type: text/plain; charset="UTF-8"
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

> Looks good to me and not too complex.
>
> AI code review had some additional comments.

I fixed the import order, the build failure (due to recent changes in
REGISTER_FAST_TEST), and submitted v9. Please let me know if you feel
any of the other items are blocking and must be resolved. I held off
on release notes for now as I would also like to get
https://patches.dpdk.org/project/dpdk/patch/20260112120411.27314-3-scott.k.mitch1@gmail.com/
merged which makes unaligned typedefs safe for general use and direct
pointer arithmetic (less risk of PTR ADD/SUB macros confusing
compilers as Morten also found).
