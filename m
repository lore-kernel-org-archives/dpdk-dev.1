Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92327D2FEFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 00:04:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C61C402C5;
	Wed, 28 Jan 2026 01:04:24 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 1D5A5402C4
 for <dev@dpdk.org>; Wed, 28 Jan 2026 01:04:22 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48049955f7fso54323005e9.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 16:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769558662;
 x=1770163462; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjklfWOo82U6BSBZIhBe3XPIMjWEHz9RfxV45LMBnc0=;
 b=iXFUqIpzYkX9T2RNoZEXEAICePG0D0RuUgbU9Vj1tPwMAssSp7DK0fTEtfCu6kJ59b
 lb9uovPta/L2fku3MNjEItEMz9+Xd26DxzV6o9DfPUH8hqjwaUOJc3M+NpnRslrDoL4H
 YrnY8jdl1NXPMJ78Ad5fehFwkIskVczXKl1x1P9Ev6Qrx7jZCTFge1nLY17SvfF6FCoP
 vEvHgsL8o9/BHkr8JBiJJ+ngnCm1wii1Rv9+55rNw86xcwH5XWs/7R3b2muHbSQzMj3y
 lOfpi5UPG7nso3MAHmbnJ3cVIPI21bAqZy5QJMuF7PvDTmyCQDNuXGQv40UHaaO9v+Xj
 40uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769558662; x=1770163462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zjklfWOo82U6BSBZIhBe3XPIMjWEHz9RfxV45LMBnc0=;
 b=QcGvETHZlus864RZkS+KbLCA5SYYZ6UgZ++HpPR2ZGKI9docwHQKu8ZJGmxO11cZmq
 is3lTnl16R4oP2wdqqjRpdMJ9QbPgMy9xx0RCTM2LYYsfSac+aqWovkPhapbzanLVrj/
 pS5aLB3I2bhOxNeoterm1D2BgYMdcP1a5O4ljLpim32Wkx9y+MS6wL/5rpWmV0nFeHoJ
 dHAkW6v+VLXp5IyPpoUoE5vh4nqIiS/zvGN8RAj4Q/1sQnArJjM34Nakj2UZf7zzKpMB
 CYVITbiRJOzWu5bDB8Y8ulNv+wM2ayAdQFJNvEsdlYo7CddtqCa4qFBBTypDtuaoBQ5z
 UDnw==
X-Gm-Message-State: AOJu0YyNcryrp2tZNhCH5vDOSmfvvSi7tVjL19ITA8AUZbcoFHTKUUYk
 loGnFguHOivMSBp6mdQy+BvLLb5yUX4crKZsTRFv967eXJag7tcOQIeUzomuhYDgtI+5thw2Byl
 W7Vuq
X-Gm-Gg: AZuq6aJQEFH6lW1Nlc5HFKDROOeTGceiFqaAw0cFbEtRLRirVQ8SKabVrEaVOcLLQ53
 j3xkMYl18dz1rG9DKKa/y6BT2qmGwIlPJQLixpDbpjlVYhDQ8msPsXb/749bG3FnvfPl2wLHD9D
 59rgx94L0MFJIKN5HUXYzzjpjeMyq8FqA/qWfC5YWyOYOHXGb9MFQ69SszXLwAEs1K0BqBXWvU9
 jN0lmRdZm4fpTS0o0+c0/oFztbvAdJksl+majKgKXaHat1Xe/2aIczZTnslxi0w7qA1SZlx6Xc4
 K3ewQKhU2s+9cLkloFwe6VSihBwGIlKzaOaykkQdUiVpo/eqTU6uZZhAF7+RG30CicMB9Kt11CP
 xFlv/sz1YjnQOMjkXwZ8mrFbMJdZwOEDop6Fcce4YjYL6RnU6nh0DNmPcLqOWXLgdFPWqZ3u840
 sHGYOH3R9NywNX4nmxPIZhbn4S1LO0yn4bzVrhO3sHeFOFKt0aXbTG
X-Received: by 2002:a05:600c:3b96:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-48069c60317mr50257125e9.33.1769558662446; 
 Tue, 27 Jan 2026 16:04:22 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806e2a0657sm4367585e9.6.2026.01.27.16.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 16:04:22 -0800 (PST)
Date: Tue, 27 Jan 2026 16:04:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cliff Burdick <cburdick@nvidia.com>
Cc: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH 0/2] support dmabuf
Message-ID: <20260127160415.05d07d56@phoenix.local>
In-Reply-To: <20260127174429.1504288-1-cburdick@nvidia.com>
References: <20260127174429.1504288-1-cburdick@nvidia.com>
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

On Tue, 27 Jan 2026 17:44:07 +0000
Cliff Burdick <cburdick@nvidia.com> wrote:

> Add support for kernel dmabuf feature and integrate it in the mlx5 driver. 
> This feature is needed to support GPUDirect on newer kernels.
> 
> Cliff Burdick (2):
>   eal: support dmabuf
>   common/mlx5: support dmabuf
> 
>  .mailmap                                      |   1 +
>  drivers/common/mlx5/linux/meson.build         |   2 +
>  drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 ++++-
>  drivers/common/mlx5/linux/mlx5_glue.c         |  19 ++
>  drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
>  drivers/common/mlx5/mlx5_common.c             |  28 ++-
>  drivers/common/mlx5/mlx5_common_mr.c          | 108 ++++++++++-
>  drivers/common/mlx5/mlx5_common_mr.h          |  17 +-
>  drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
>  drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
>  drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
>  lib/eal/common/eal_common_memory.c            | 168 ++++++++++++++++++
>  lib/eal/common/eal_memalloc.h                 |  21 +++
>  lib/eal/common/malloc_heap.c                  |  27 +++
>  lib/eal/common/malloc_heap.h                  |   5 +
>  lib/eal/include/rte_memory.h                  | 125 +++++++++++++
>  16 files changed, 576 insertions(+), 8 deletions(-)
> 

Build fails (on MSVC) fix and resubmit.

"cl" "-Ilib\librte_eal.a.p" "-Ilib" "-I..\lib" "-Ilib\eal\common" "-I..\lib\eal\common" "-I." "-I.." "-Iconfig" "-I..\config" "-Ilib\eal\include" "-I..\lib\eal\include" "-Ilib\eal\windows\include" "-I..\lib\eal\windows\include" "-Ilib\eal\x86\include" "-I..\lib\eal\x86\include" "-Ilib\eal" "-I..\lib\eal" "-Ilib\argparse" "-I..\lib\argparse" "-Ilib\log" "-I..\lib\log" "-Ilib\kvargs" "-I..\lib\kvargs" "/MD" "/nologo" "/showIncludes" "/utf-8" "/W3" "/WX" "/std:c11" "/O2" "/Gw" "/wd4244" "/wd4267" "/wd4146" "/experimental:c11atomics" "/d1experimental:typeof" "/experimental:statementExpressions" "/FI" "rte_config.h" "-D_GNU_SOURCE" "-D_WIN32_WINNT=0x0A00" "-DALLOW_EXPERIMENTAL_API" "-DALLOW_INTERNAL_API" "-DABI_VERSION=\"26.1\"" "-DRTE_LOG_DEFAULT_LOGTYPE=lib.eal" "/Fdlib\librte_eal.a.p\eal_common_eal_common_memory.c.pdb" /Folib/librte_eal.a.p/eal_common_eal_common_memory.c.obj "/c" ../lib/eal/common/eal_common_memory.c
../lib/eal/common/eal_common_memory.c(56): error C2143: syntax error: missing ']' before '...'
../lib/eal/common/eal_common_memory.c(56): error C2059: syntax error: '...'
../lib/eal/common/eal_common_memory.c(57): error C2059: syntax error: '}'
