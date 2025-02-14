Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7CAC021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35DB440665;
	Fri, 14 Feb 2025 18:21:46 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 6E5B640651
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:21:45 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so30477495ad.3
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739553704;
 x=1740158504; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zTfmAz05xLH5y2BqvFr6H7FDtpFap58k37NhIXSGU8=;
 b=d4Lrdx7/skc4qGwh602heymEUmmzvUNEprv19VkkkGpnYvPB728mvCw5soCDjO7S9y
 /ceJLynzZpuj5F4aa1KioMjfyWOmDi/wpTArF8emC4iEKTIgUn98qKnkxGE/gwfV7dvn
 EwHDtzCsLKBsRUF9DEOELBSuWL4CSShXxWekd0mQGDSD4Nmjy38EGFMRczcy/xlwEw8Q
 Z5RBK2Jh3oH1x75RvNrNoZyqEiAShDtphSJ7sXaG7UDcBRwKudioLTaH7dfyjNrS48a/
 oklnSBkdEqkrv3Xu4Q6jEseQ1bLHyWmFDQAY8QVEshSTjpZ1CnoAhdDWyGYIBuaUlbrq
 YjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739553704; x=1740158504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zTfmAz05xLH5y2BqvFr6H7FDtpFap58k37NhIXSGU8=;
 b=gEEqn7ugWugE61x219uCHBo6ig7ZfmbSHtw+aCrXQGYs/FmERULfirPWGP6kpW5Q/O
 dkzS2RaeLBrFPCmTbSBlcuQNVjIcMnJBs4naTy0M3ssa+UUHoYzJcyOZjvZydb/T+I/T
 D177NZ/WJycIrEBvGKKI6YfwN8Gs3oTmWloR9IaNpjt4VKBoY9mBN8atgeYHMOD4hHI8
 Km4mOADtmAj9eC9+NC+1OEKaSRH37NARy9wh8O1ceuuFwM+a7IdY603LWJDvyFG4ngQ6
 SzHmnllpvYWgmbdKpj2uXlvgw56s7ZAAhg5DYvETWy5O0pP6fq3xq24HYdPU8j9iAqFI
 4+Ag==
X-Gm-Message-State: AOJu0YxtAZVuYOx8ah+P9PjIxQF1zQrqEoUJwXGyPetLG4h6db4e7qMT
 YY6S5jCBcgqguVcNwHGsAFlFF8H/LYTDFsSOWwyjLmG2R1nuUXrjRV4Xdv6g3ZprIGOjBEU/PCf
 EKv0=
X-Gm-Gg: ASbGnctqyIP7UO6EfB9y2nkMsIjZNFuEatp6f8HkkquHha1pCg6jyCDyXNvMNBT//Kv
 h5qGJmdbu9z4TufWykuPRuImDpFdP25WuvLCzgqOC8PvttpekmT/5P9o/HLea7rc9foIenOMKYp
 w4tsVjFt1/iCTfhC4BjdJJYlXkZK0FM0vJ9s/4/noJ2FGGd1uCF9EWfSS5aJ6UD6vH+uh1/9Fwq
 O3LCb8REftVnZqgYXDkDk8+U0blkV0aUvXRHnnn+qhF3lD7kx6sTMwjec9erGyAqPjdjwvpfh3h
 ciMz7WvsUDxzVphZCuuyFR8zfqVXxQ8rbFGVHtF/U6PfYXR055bahfuAhtKfG4SgjIes
X-Google-Smtp-Source: AGHT+IEtODX7z/uhq4pAinFL4CM0KhR11kAInUS9fFDDLw9Jv5wsCf8yW6O+0sz8EKuoL0ZCnJb+2A==
X-Received: by 2002:a05:6a21:33a9:b0:1ee:69c8:8d03 with SMTP id
 adf61e73a8af0-1ee8cc07bf6mr492825637.36.1739553704450; 
 Fri, 14 Feb 2025 09:21:44 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a52af8bsm3134264a12.50.2025.02.14.09.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:21:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/7] Introduce FOREACH_SAFE macros
Date: Fri, 14 Feb 2025 09:20:08 -0800
Message-ID: <20250214172134.73908-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250127180842.97907-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
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

This series adds common macros for safe iteration over lists.
It is a subset copy of the macros from FreeBSD that are
missing from the Linux header sys/queue.h

Chose this over several other options:
  - let each driver define their own as needed.
    One Intel driver got it wrong, others will as well.
  - rename all the queue macros to RTE_XXX variants.
    Seems like useless renaming and confusion.
  - Several distros have libbsd package with the correct macros.
    But adding yet another dependency to DPDK would be annoying
    for something this basic.

There are more macros in FreeBSD header that could be useful,
but we can add those later as needed here.

v2 - rebase after Intel PMD reorg

Stephen Hemminger (7):
  eal: add queue macro extensions from FreeBSD
  net/qede: fix use after free
  bus/fslmc: fix use after free
  net/bnxt: fix use after free
  net/iavf: replace local version of TAILQ_FOREACH_SAFE
  vhost: replace open coded TAILQ_FOREACH_SAFE
  raw/ifpga: use EAL version of TAILQ_FOREACH_SAFE

 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |   5 +-
 drivers/net/bnxt/bnxt_filter.c           |   8 +-
 drivers/net/intel/iavf/iavf_vchnl.c      |   8 +-
 drivers/net/qede/qede_ethdev.h           |   3 +-
 drivers/net/qede/qede_filter.c           |  13 +-
 drivers/raw/ifpga/base/opae_osdep.h      |   1 +
 lib/eal/include/meson.build              |   3 +-
 lib/eal/include/rte_queue.h              | 174 +++++++++++++++++++++++
 lib/vhost/socket.c                       |  11 +-
 9 files changed, 193 insertions(+), 33 deletions(-)
 create mode 100644 lib/eal/include/rte_queue.h

-- 
2.47.2

