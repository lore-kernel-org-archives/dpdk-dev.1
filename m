Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A64C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 19:55:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 225984026C;
	Wed,  4 Jun 2025 21:55:11 +0200 (CEST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id ED1D24025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 21:55:09 +0200 (CEST)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-6fadd3ad18eso3440246d6.2
 for <dev@dpdk.org>; Wed, 04 Jun 2025 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749066909;
 x=1749671709; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pSGupSrpvYXmQ6PzhGxR84Y9HJZAyrPU4pAzF0phcw=;
 b=tVOulT7ARgLhz5FELjyqdsdsvlt8SvSmSXHi3wnaaK9l+/N/S0kdrtPX6dDyyeW9jP
 VGT2ENe0sycZkLzvMlOkKvQQqfv43AdjQ8jrx/aBu4oApr5xoRe8u8nb15l3YBwoLFyr
 DApwjENknaxzZgpStR/fneKnjlU5+mMYmruAkmtoJmAqwRPGUszu/crNebOYrGDqeli3
 RheODsraIyu7MFbosi9ovEOONUrDgmH21Nz+7kK2r1xAeVfEpQoYi0G4GFY1Jit5WgjN
 zTArVhg60lfxa7dT1D8a4VnPv63FEFDR0sBwO4KJh+sKaGDtJo5f2KbCLibDy87mmUYw
 NL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749066909; x=1749671709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1pSGupSrpvYXmQ6PzhGxR84Y9HJZAyrPU4pAzF0phcw=;
 b=aKo93vbygDjKl4sZj1bEDyGj+DEnKxR31iuwCjTtz1LfowiNgRVRcDa8TZPVxWPry9
 tmj3WfL8MGiTxkPODpexfAKaN1RK0aqSrbXakM7RWmNWtZTsk1lbFXVK38k2MgwD4Kc2
 mxlNknhcwy8lUsXuhhCrYIgyJ23Ig7JXLqxyfCtpL+FhHL4OZViRZafnltHHnuXnEWeW
 8XKA3ceTuVRjZRWJDUgSmeJ77TIK1S04bUkzVLJojfspmOrF8vHBEaFRnyUPXEE4+VX6
 crOzC8vwu6BKd5pPRXGQKyzmtQBBPY1NsFR7Zv1X/smTE/9SpgrEE5zWQ5ZiafIvL06K
 y6JA==
X-Gm-Message-State: AOJu0YyzTBsE0Yj2qpojqtNOQxYBYps4vWJOvy020S3NiuRFMjc28zEm
 EV+Y+zNIhu6pcQCzbruy3rGOT5g4O+kSoOUgCDrbNnSkJhzagbs4R+c1sh3wXjIZGFc=
X-Gm-Gg: ASbGnctouOJY5A1iJ98gOLEm6Z/eJfgSE7bksdjCQgpjIYeMgqaZJ0457l+Zw0OvjdL
 1KpCydakztWWASCiePU9Y0bZab92PtlN8EP5gztRApDO5hILvGL2tQ5BniNUiFqYGvg0TGyJ0h3
 XmqdF3LXCvmzwW0vz8ziW/Mr/VPUMVPzu0Qd3/WyH8ZFGVDBy+Yhi9z+5WES4l0Tfn2K6AF2Qkd
 YeUodsuuh7eUUsGAix2e70PHZ9L2oeXtMtzlzKVT2tgtbfg9fSbJlkL3oTjsA1RbJgjo8iYol/+
 rgsras09W2yzmQzqMyl/lRABkuuadYJtnh/RQP9fNY15yOXyAufmK+GOv08zhuCIEf+B7HlpFHy
 PG0Sj6sqsTMKSja65DahmkQvbqPhn
X-Google-Smtp-Source: AGHT+IHSCvT5ZzkbIMgYm9kshJV26pJSAx3y8m1HfuZypm7ETmlHVUyc+GkkcCUkV2AP8kA8pTKN2Q==
X-Received: by 2002:ad4:5ce2:0:b0:6fa:bb44:fddf with SMTP id
 6a1803df08f44-6faf6e87e98mr62041376d6.16.1749066909186; 
 Wed, 04 Jun 2025 12:55:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fafbfb2834sm9690316d6.109.2025.06.04.12.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 12:55:09 -0700 (PDT)
Date: Wed, 4 Jun 2025 12:54:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: uk7b@foxmail.com
Cc: dev@dpdk.org, sunyuechi <sunyuechi@iscas.ac.cn>, Stanislaw Kardach
 <stanislaw.kardach@gmail.com>, Bruce Richardson
 <bruce.richardson@intel.com>
Subject: Re: [PATCH v2 1/3] config/riscv: detect V extension
Message-ID: <20250604125459.6291fde2@hermes.local>
In-Reply-To: <tencent_530B1E13D57A8BD821C26287B971ACE9B007@qq.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
 <tencent_530B1E13D57A8BD821C26287B971ACE9B007@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed,  4 Jun 2025 19:49:16 +0800
uk7b@foxmail.com wrote:

> From: sunyuechi <sunyuechi@iscas.ac.cn>
> 
> This patch is derived from "config/riscv: detect presence of Zbc
> extension with modifications".
> 
> The RISC-V C api defines architecture extension test macros
> These let us detect whether the V extension is supported on the
> compiler and -march we're building with. The C api also defines V
> intrinsics we can use rather than inline assembly on newer versions of
> GCC (14.1.0+) and Clang (18.1.0+).
> 
> If the V extension and intrinsics are both present and we can detect
> the V extension at runtime, we define a flag, RTE_RISCV_FEATURE_V.
> 
> Signed-off-by: sunyuechi <sunyuechi@iscas.ac.cn>


Need entry in .mailmap as first patch, we keep track of contributions.

Since Signed-off-by has legal meaning you need to use full legal name.
By giving Signed-off-by you are saying that "yes, I have full legal right
to open source this".

