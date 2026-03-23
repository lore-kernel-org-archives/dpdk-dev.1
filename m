Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B2ED58CDC
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 05:43:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E6F140268;
	Mon, 23 Mar 2026 06:43:48 +0100 (CET)
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by mails.dpdk.org (Postfix) with ESMTP id 918654025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 06:43:47 +0100 (CET)
Received: by mail-pf1-f194.google.com with SMTP id
 d2e1a72fcca58-82a7ebc729dso1623993b3a.3
 for <dev@dpdk.org>; Sun, 22 Mar 2026 22:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774244626; x=1774849426; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPGUt93sj4i64AUmSSdp0ZCW2DNwBywFRMmDxGOWRwk=;
 b=dU6KZKZf3UFC9stbksqNrC8vY6JfXGhB6/EAqQNxP9s9uvpc+z5LMrkpKK6+kLlzrq
 4PRYfUT9wyTyWXvFpXXoVgBnHt+rEZkhrboGswp2y5yCKFxyN9sRdDkF/wiOcfhUMrNf
 Lmf2nGwAQ0rGzluR9ra6KmSGWJb/1UCRViklRjpkKFvRjUkuq/mrvPjn4ZRITXmuobV5
 EKKaxeOCN/gPzoMFnU2qyxCmb4l9LF7d8J9HSgB/w+kDUGK73UFqrQA2ymPcoAaZWx2C
 7Vle4pGrjhU1Cbbls4D20Hr8wBWX42J1q4UEHmA8nZwCETa4E0cHlt5bHaYVAS/82zRv
 8GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774244626; x=1774849426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lPGUt93sj4i64AUmSSdp0ZCW2DNwBywFRMmDxGOWRwk=;
 b=rS0uSn46X653HOz4SZT5XJtzomEiIqX92xAvoh50uHEokD9Wdxm899Vj5F8GJekvp4
 cM1u1T3Z3LPePJA8+KTyV09pQdPfOBl2X8OYZWj7ODs7anIeR0xENdNwVD0Z5PMqZGrt
 wpn0p23weVQuEVF+P2DrG24IVZTobW7OdNmEKDM4XNZmnfIQfY7Uirb+qmIG7V7SExBW
 io+JaU5vlM13s6NhiAN2yGIrh6X+VfXLkcH+lUbNsDUpiIf6gp9IDS2A2uaNtzOYjeP1
 Hi8cDEA8p2sbZQCjGIm+JlBMtvJtwe0VQ9WzUCGaO44tIWk12n5zKBGon/Suvn3Ihhcr
 NeOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKf7bvQ4NQ4+YurtEq49sNyFlxxV008BwZWqwdWD3XheEnUlTD1rlT4EGX5Kw3usAO3Ew=@dpdk.org
X-Gm-Message-State: AOJu0Yx5VtYC3HeWIEJEMv4UVz1BaAslxbtwuMLcw9i8JAi/J+QZ8Vkb
 ZPfrv12t8cuqj6zSshZnGP3Q/KiR7lBLpgpDBP/PCjSJjb/a3CqSpD6z
X-Gm-Gg: ATEYQzwVkkJPur2HuDKS/t4pMWGfdsDNx0rey00PSKEZgZfFtrOyrC8IZz1Fv4Pl596
 DQHmY/8WtgcoqwQDTsiMGquBCgAOB9ahCVqd9vwU1C+w52XuQJY+pi1fWIXJPt5z2sv7Tpzgg7B
 edGChZ4tH6CNPTRjbifW8vSp8a4hbKpcNkjsoAPOk5q7WDKUZvwG212fQoRGeGMaQE4Yjd+jfzP
 PYt86fLksj6oieNsvMBDNTTA1s9ZtupWl9lMvy9YK+jqh6cbuW8huhLcvT8gd1W0ENgbfovc+/G
 43MTuFGsRDXrvBpF838VihVyjnTXWzwW3TGvVg6F7jmn7BIHoMw8MDwdezlLXf2UhoGr6YQOv9e
 bkzMiWz/wCfhYs0olPN2156hrCYDPRUpTc/PBAsJeN6qUC+S541qQsMXdvC9HtNkVeZDB6LUQ01
 47fy26RaO7j03EmI6w0yXSPcdAGk+qdakGRdc9KTmLw2Sf4ZREnyeRcQ==
X-Received: by 2002:a05:6a00:1255:b0:81f:ac78:ed22 with SMTP id
 d2e1a72fcca58-82a8c3469dfmr8354112b3a.37.1774244626493; 
 Sun, 22 Mar 2026 22:43:46 -0700 (PDT)
Received: from localhost.localdomain ([180.101.235.28])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b040da438sm8297620b3a.43.2026.03.22.22.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 22:43:46 -0700 (PDT)
From: dangshiwei <1138222970gg@gmail.com>
To: code@danielg0.com,
	stanislaw.kardach@gmail.com
Cc: dangshiwei <1138222970gg@gmail.com>, dev@dpdk.org,
 punit.agrawal@bytedance.com, liangma@liangbit.com,
 wangpengcheng.pp@bytedance.com, fengchunsong@bytedance.com,
 daniel.gregory@bytedance.com, sunyuechi@iscas.ac.cn
Subject: Re: [PATCH v4 00/10] riscv: implement accelerated crc using zbc
Date: Mon, 23 Mar 2026 13:42:17 +0800
Message-ID: <20260323054217.7195-1-1138222970gg@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1771772598.git.code@danielg0.com>
References: <cover.1771772598.git.code@danielg0.com>
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

Hi Daniel,

I noticed that my recent patch [1] overlaps with your patch 01/10 -- both
modify rte_cpuflags.c and rte_cpuflags.h to add hwprobe-based Z
sub-extension detection.

The key differences are:

 * Scope: my patch adds infrastructure for all Z sub-extensions currently
   defined in Linux hwprobe.h; your patch 01/10 adds only ZBC as required
   by the CRC series.

 * Caching: my patch calls hwprobe once at EAL init via RTE_INIT and
   caches the result; your patch currently appears to call it on every
   invocation of rte_cpu_get_features().

 * FEAT_DEF semantics: my patch keeps the existing convention where the
   third argument is a bit index; your patch changes it to a mask value
   and updates rte_cpu_get_flag_enabled() accordingly. Mixing the two
   would produce silent incorrect results, so this needs to be resolved
   regardless of merge order.

 * Enum naming: I use RTE_CPUFLAG_RISCV_ZBC; you use
   RTE_CPUFLAG_RISCV_EXT_ZBC.

Regardless of which patch lands first, the other can be simplified:

 * If mine lands first, your patch 01/10 can drop the hwprobe
   infrastructure and keep only the meson build-time detection logic
   (RTE_RISCV_FEATURE_ZBC). Your CRC patches (02/10 onwards) would be
   unaffected in substance -- they would just reference
   RTE_CPUFLAG_RISCV_ZBC instead of RTE_CPUFLAG_RISCV_EXT_ZBC.

 * If yours lands first, I will rebase on top of it and align with your
   FEAT_DEF semantics and enum naming.

On naming: I prefer the flat style (RTE_CPUFLAG_RISCV_ZBC) since it is
consistent with the existing RTE_CPUFLAG_RISCV_ISA_* entries, but I will
follow whatever the maintainer decides.

I would be happy to coordinate on any of the above. Please let me know
your thoughts.

[1] https://patchwork.dpdk.org/patch/162581/

Best regards,
dangshiwei
