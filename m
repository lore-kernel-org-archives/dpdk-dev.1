Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A60C9EC7A
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 12:04:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C3D740C35;
	Mon, 12 Jan 2026 13:04:17 +0100 (CET)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id A84C340A6C
 for <dev@dpdk.org>; Mon, 12 Jan 2026 13:04:15 +0100 (CET)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-8c305b7c472so429428885a.0
 for <dev@dpdk.org>; Mon, 12 Jan 2026 04:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768219455; x=1768824255; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uxwc7CTHh4Z+aO2QRVelIxhf6n5kgjqMfrzzJi37RKg=;
 b=IYjsdNsjxKuVqgEI++GMqzsxV1wiyUAU18SoRY2Rdjk3EY1J8m4uUDSiyHtPPoIn4r
 mI1TSKCsGkg25iCXG75ZkN/YlCaRMezARMW4ISSTHkoAN1HuCm8y0Vts8B6W6huSllw+
 PpxYJE3u3kV79cPJeiXpAd3PnW+W/5AYrpiGTG56tFoTrgM3JvQstO6mxnYseCPI+Ag8
 AOZmEBdtRGQdZbcmg6igj0CaD+Ee9K7oEfikypHgOpLKi/htnouW/LzWKBbMRsdg1+OR
 6RDprkJEre8srxsSlvolUNebXn8+wNLo8FcC9vc5AmEu8wr0hEsv45kDsaeV1q9SjMAR
 /lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768219455; x=1768824255;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uxwc7CTHh4Z+aO2QRVelIxhf6n5kgjqMfrzzJi37RKg=;
 b=TAPglFXntyAjLuotfaGI6M8mCIBB6oAXYUls3SRJPSba1cA9RYo7Ym6l+IV0PIF78B
 wM9srdMc9eYj0wRVh7T41ynib7wZgXy1D5CI9Y/b+aTt8gvsylrJSnAExIMrEXUPhhcO
 wJ0t3cMstpJSrcGwbTEPam+Ry2+3SPnzO4fSpW6+9PYiVPckYADmKGWAslAOrr6I4D+f
 K3bGYtIOuevGQ0d/g4vVMjeJlgo1U8n0569nDF13AwcuI5/gHX40HoCQctgN9etllkCb
 eFv+iy/98lX88bY5YqElQ30H3Q4hJUenyfMyeqTWXj5PrGRJYUyUGXhs1+n5fin7trE4
 YNOw==
X-Gm-Message-State: AOJu0YzqBIXLifzAMCitCGcJtA5iQBCbMDDDfy3Qo97zlmW8YcJmq+j2
 rIBweCZKLiuxubMHkOTkRWbRoesApccJlNBiK2kkMSS6rTNmOkiuo6W7yqMtzA==
X-Gm-Gg: AY/fxX7NtsZKgLB6dfw1FZmJ+bzZqVVbZ/NO+1KidtErCpljr1M3PlKGEz3irZwfZiA
 3pnTe9tO2ssqHyoTOg8eljfp+IUsS4/r+3Vo9QlgMiv5VdXVlRoC5+9PD171Y1ZiGzeIOG9cvuK
 G6NZ5JAOl5+P4Sg4v8hUleTvUEjfwaEgd6ojpCTcjXi3OmSHlC+Qrl1uSFsBt6bgF3ZMEcnYqtK
 wXQFiqAUPDTBaZrhJeKtOl43GZgVJhna8Av3LITAtAgCXMz1tj/K5OcCy2NHPiarpOrQVz2p8jQ
 t++D2eipLceuG7LqChSAmAWdBMUss7euOz2TdVHvAiWLbP6qdFnDRkQpfm3hxjHnlMbQqf9cy+E
 YgaIaV7b7MBNDL3IlMN4H3sur37broYaSqeMV07BwoieM49IewNKuAabKmrZ0JvkWF9GPRbNKSQ
 sgjlz2196ERfQHE0CpcdATh8X1FGzA91y4YXDT3Fzl/Q==
X-Google-Smtp-Source: AGHT+IFvt4Yb9SKq22t9OYFOAr+T95kcVjST/4FvStakHL2g6flK9v5zk+Xz1S73XP4A3p6nNlQyTQ==
X-Received: by 2002:a05:620a:7087:b0:8c0:cdbd:e09c with SMTP id
 af79cd13be357-8c3893cd9dbmr2324559285a.45.1768219454695; 
 Mon, 12 Jan 2026 04:04:14 -0800 (PST)
Received: from st47p01nt-relayp04.apple.com ([2620:149:13c1:500::12])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f5433c6sm1547713885a.52.2026.01.12.04.04.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 04:04:14 -0800 (PST)
From: scott.k.mitch1@gmail.com
To: dev@dpdk.org
Cc: mb@smartsharesystems.com, stephen@networkplumber.org,
 Scott Mitchell <scott.k.mitch1@gmail.com>
Subject: [PATCH v14 0/2] net: optimize __rte_raw_cksum
Date: Mon, 12 Jan 2026 07:04:09 -0500
Message-Id: <20260112120411.27314-1-scott.k.mitch1@gmail.com>
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

This series optimizes __rte_raw_cksum by replacing memcpy with direct
pointer access, enabling compiler vectorization on both GCC and Clang.

Patch 1 adds __rte_may_alias to unaligned typedefs to prevent a GCC
strict-aliasing bug where struct initialization is incorrectly elided.

Patch 2 uses the improved unaligned_uint16_t type in __rte_raw_cksum
to enable compiler optimizations while maintaining correctness across
all architectures (including strict-alignment platforms).

Performance results show significant improvements (40% for small buffers,
up to 8x for larger buffers) on Intel Xeon with Clang 18.1.

Changes in v14:
- Split into two patches: EAL typedef fix and checksum optimization
- Use unaligned_uint16_t directly instead of wrapper struct
- Added __rte_may_alias to unaligned typedefs to prevent GCC bug

Scott Mitchell (2):
  eal: add __rte_may_alias to unaligned typedefs
  net: __rte_raw_cksum pointers enable compiler optimizations

 app/test/meson.build         |   1 +
 app/test/test_cksum_fuzz.c   | 240 +++++++++++++++++++++++++++++++++++
 app/test/test_cksum_perf.c   |   2 +-
 lib/eal/include/rte_common.h |  34 ++---
 lib/net/rte_cksum.h          |  14 +-
 5 files changed, 266 insertions(+), 25 deletions(-)
 create mode 100644 app/test/test_cksum_fuzz.c

--
2.39.5 (Apple Git-154)

