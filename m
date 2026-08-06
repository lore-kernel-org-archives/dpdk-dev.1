Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C66C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF8BF4027E;
	Thu,  6 Aug 2026 19:16:42 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 3A86340262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:16:42 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-8f256eaedf8so24047816d6.2
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786036601; x=1786641401; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dnVIPLWrRdlYkoYOPfnJYVjfwqppW6450oDQhFc3VDE=;
 b=ji23u45jdsNnG3w1NDI6dexMcfZhnSNmyz3FdRYHD0qVCbDw9znlCN6OVURTwSCzxf
 iKtU1I2gZZj+6o0NMqDJIivueqo6Jj2ZmymmjuJ4ipWlK5ijiwGVGGlITwvmEuzFGGiu
 wx2XiEyxXsk31wnn3iL1EaNHb606oI6iFBw7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036601; x=1786641401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dnVIPLWrRdlYkoYOPfnJYVjfwqppW6450oDQhFc3VDE=;
 b=s5CVtFGyEfCwyQ7474C9Nv8RLXzfCQSbui6plQ+L9V4o9DF/Bqzt8lGZbHGMWmn6LS
 GGvLao7Xc+hh/xyuLh7XSaLlEIIYArZJqwnL3dGFVTnP4nT/W8EgDVbgog2fwyEcjGNL
 UyRiww6x3YXa8r6GmRkq5C7tbutnsv4Vhz0MUzeI+pG52Ul7F0eR/IYpboRXhsEPUxkY
 OseUHHwrVYMk69OfuCEESkrXxgi7bhb3x9aFh7dKz4QxVasFrH/ZQzhj5zPLe/AwS5bN
 D47J2E3Ta4RGgdLrbncMXtmzqLpXYTkGykIhWca6PCIela6Z6h7ZuyfEkDoi1sMnfb6r
 SX4w==
X-Gm-Message-State: AOJu0YzLbE04lsSUJSFfBzaYIYaG32ORFKeF/sUqZKogLRSN2GosNIYr
 PpN5BPhY1hPLfY2Z+gD1vqs9uj2LcM9n2IrOVEgP1LRZWa8wk31bLWNCqW+zc1t3n+585AO7bq6
 eRzQ8J0/IM+IcDrL3ii4BQkbMMjwAiF1ewqkfh07k/0LRqEPFpNGnfkiNq9EvM5hkEe/gCmxme6
 XvIRuX+wi1q+kzl1YPrqJRJav4k4o=
X-Gm-Gg: AR+sD10RumwQr47mvODH1MoHH7TyNn8SDhs8/x4DX6e+sG0MSlgTDOV3rLBxSrwSiTt
 I+pBqrnzbLa+7yFYjp+2AlMRDCq0YZAdcXn9wPsfkQ/iixsNBb84U+PtgmZ53X6RkCu0TbvGfoa
 wZZp8NzDZFQvI9ceHgpeuxjfE9vq2PsVQHcvBgqWxTFvlBZF3tn8fc7Up5bNhNKfVUK0mtGHFkN
 dn+LvKsjNqRyjhwC4bx8jFg1rYcs78X4m1PMvBKBuH6/NVylFBxWv8sPAKLj/qH/ghLP0G12SiC
 IXIxaFp0J3RA+fSBFetmTUqrGB3I7sc1xV4FgsJwqIJ/ALrMjSJHR8eu9QjPah49TpaRJ7ZdTeN
 2DC3REifohmw7YuUHEGc0iTs/0EJW4mpKMpCCShyTfKkhqcl95G4CJa1InkxtMRo3tjHk9rX2vC
 lOgtarX4oUQOrWQR/6i/U4abawXHVmmVhWc3g6bHKdmlaqTUn9sBQZjC+j0ViDtpy1QPNy9ami9
 f/AZC2wwizC0C1CWuExEF7895iHOwxzzi4u3Gfk7i4UziDteV20
X-Received: by 2002:a05:6214:5712:b0:8f2:4723:d88d with SMTP id
 6a1803df08f44-9088107322dmr215901996d6.4.1786036601414; 
 Thu, 06 Aug 2026 10:16:41 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ffb8f76sm59934006d6.11.2026.08.06.10.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:16:40 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 0/7] dts: remove imports from framework in test suites
Date: Thu,  6 Aug 2026 13:16:29 -0400
Message-ID: <20260806171636.656181-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806135346.568766-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
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

This series takes action to make modules accessible from api that were
only in framework before. This greatly cleans up the majority of test
suites, ridding them of almost all framework imports.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

---

v5:
 * Resolved merge conflicts and rebased to main.
 * Removed additional framework imports from test suites.
v6:
 * Included missing linux_session py file
 * Included missing linux_session rst file

Bruce Richardson (1):
  doc: improve 26.07 release notes

Chengwen Feng (1):
  dmadev: fix incomplete configuration validation

Dariusz Sosnowski (2):
  ethdev: remove flow metadata symbol aliases
  net/mlx5: remove versioned symbols aliases

David Marchand (1):
  version: 26.11.0-rc0

Robin Jarry (1):
  lib: remove ICMP and IPv6 deprecated functions and macros

Thomas Monjalon (1):
  version: 26.07.0

 .github/workflows/build.yml            |   4 +-
 ABI_VERSION                            |   2 +-
 VERSION                                |   2 +-
 app/test/test_dmadev_api.c             | 186 ++++++++++++++++++++++--
 devtools/libabigail.abignore           |   7 -
 doc/guides/rel_notes/index.rst         |   1 +
 doc/guides/rel_notes/release_26_07.rst | 193 +++++--------------------
 doc/guides/rel_notes/release_26_11.rst | 145 +++++++++++++++++++
 drivers/net/mlx5/meson.build           |   2 -
 drivers/net/mlx5/mlx5_driver_event.c   |  22 +--
 drivers/net/mlx5/mlx5_flow.c           |  18 +--
 lib/dmadev/rte_dmadev.c                | 156 ++++++++++++++------
 lib/ethdev/meson.build                 |   2 -
 lib/ethdev/rte_flow.c                  |  13 +-
 lib/fib/rte_fib6.h                     |   5 -
 lib/lpm/rte_lpm6.h                     |   4 -
 lib/net/rte_icmp.h                     |   4 -
 lib/rib/rte_rib6.h                     |  74 ----------
 lib/table/rte_table_lpm_ipv6.h         |   3 -
 19 files changed, 489 insertions(+), 354 deletions(-)
 create mode 100644 doc/guides/rel_notes/release_26_11.rst

--
2.55.0

