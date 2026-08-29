Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18CDC61DD6
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 15:47:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CC1F40268;
	Sat, 29 Aug 2026 17:47:18 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id D1AF04025A
 for <dev@dpdk.org>; Sat, 29 Aug 2026 17:47:16 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc1e1ff659bso1761943a12.0
 for <dev@dpdk.org>; Sat, 29 Aug 2026 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788018435;
 x=1788623235; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I+mTWCswsvV/t1xUFOMBIRjoF5cAL8lskk/PSi2+YH8=;
 b=NZgzyNd95eFx7jlwL6K3edM16Uy38bchu8ODAzoBzBTbubP4SwK79b9SN6C7nSupEZ
 w5sYuAymGgxc89njqHcZMXhVLcqH5vXuN50eu1m0DJXfJuVrBePPa15bi34o5WEKYAom
 GMW6ONgKXyrzUzu9dG33eVAjysSLx4W2lRelipoG6+f+4xJTWiJm+hlU0RgDcNGRCFbB
 DU/SvsFMqBeYZ03iLfaexBx2syQISCZDtS1jPvIOcKfn7qHGuYj0xPJjXNgybTQcFNdC
 9uJJXENz0MlTMCsJQFs2eXvEuUQG8Ldv7ssxaxRNa2BkLdJPa7fl//pjfhGItR+gmmfr
 mR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788018435; x=1788623235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I+mTWCswsvV/t1xUFOMBIRjoF5cAL8lskk/PSi2+YH8=;
 b=JuX9tXGaDM0WYsZ7BEVA1shhShrIp7EVeEFZQpkEb6NV/K3HjOPSa1eL8TuZE4o1Se
 dMEQyLX1o9b/AmVkEqcuLowfExwTzArtI/Y/4hzuIZRApo4O3aKWJaf6gRg0T69V2uiK
 2HGUzTJlbfdPraX6+UbEr5WdUFlZhhu0Zg9ZpyV/JwGnlYvp0/P+MD9uBiulAOD3qN0H
 f48hfSY+AsynmXKhZ6gnSH6MhW+u/uRGBZQxlB7w48vyGUhLbbqY/MRPvjKPytpA1Hxj
 KEmgHPMcigXe58MLjPMwJfeBprrXs6AnJTFOj2sR8NdgUtcTHOAlDcXafH6bWBBHpEt0
 IySw==
X-Gm-Message-State: AFuF++miCqn022YDKMP7cJdO3t2Zb4Q4S/53xVFvGACJwqdSVEVNqxSU
 XMpysEGo9uP/+2becPYKph04tONCHrrtDwnyDrZBcP4SZ6L6r4j9gHuVt6QG10+PNNAnMpSRptx
 6RD1r
X-Gm-Gg: AYBFou0NBW+J7+V7JQwJ4g2A4Gn4y3fsdgna86UNc1RgyaiAH/xo3kbubVWoVPJNwyq
 /hPVid+JbYoxJrJL0fHdeGQVlJuu3Yfs2fZFr3Bw3bAT5PTB9lfhsVbH/sFxBZrIPkpHgi0Hr8a
 rXtZPH6GD3X5MjmzBB5NwOG1jw3sT5lmlYyNE9DDjQrx5uIDv1obJj/OkHExJYug/8crFGYvBI3
 saQqCJQJBDu5RZtb7JK88c2oB8ChTMoifsVOGXzJjR2hCO8zTxHJaT9zqgVSRsN+wz/dJxvzel5
 pwB0CZbmvCxspx7PKM6Sq6VeJC1jnJE3GnqzyWs483Q7MuFPVlP+w8aT7BUKR762Cue8yk5in7Z
 NrIO0MbK2nB/VSnJs35me1VFEk2t6F34ex7lzq1uHoT95d27VhJFWWZfJLflmqXXiVskChAsVli
 btEOqDbTotvwvkfyXvGAmjdbNLZGsUxCW7rshHNxPuNHv7epqcXrXF72bmWd9z3eaSP2/y5hrG9
 zByMFfK+PyuzCkSX26gvBXa284=
X-Received: by 2002:a17:90b:3c45:b0:398:c292:ac80 with SMTP id
 98e67ed59e1d1-398c292b6b2mr1599133a91.10.1788018435516; 
 Sat, 29 Aug 2026 08:47:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e41837c6sm13221356c88.11.2026.08.29.08.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 08:47:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 0/4] fix clang 23 unused but set warnings
Date: Sat, 29 Aug 2026 08:44:44 -0700
Message-ID: <20260829154706.52169-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826235933.194681-1-stephen@networkplumber.org>
References: <20260826235933.194681-1-stephen@networkplumber.org>
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

Clang 23 adds -Wunused-but-set-global, which reports file scope
variables that are assigned but never read. It is enabled by -Wall and
does not appear with gcc or with clang 20 through 22.

Three of these are dead variables and are simply removed. The fourth,
'alive' in dpaa_of.c, is a real debug aid: it is only read by
DPAAX_HWWARN, which discards its condition when RTE_LIBRTE_DPAAX_DEBUG
is not defined. That one is fixed by making the empty expansion consume
its argument, which keeps the condition compiled in both builds and
covers every other DPAAX_HWWARN user as well.

v2 - remove more unused code as suggested.

Stephen Hemminger (4):
  common/dpaax: fix unused variable warning in non-debug build
  bus/dpaa: remove unused qman_clk variable
  common/zsda: remove unused device counter
  net/qede: remove unused app version variable

 drivers/bus/dpaa/base/qbman/qman_driver.c |  4 ----
 drivers/common/dpaax/dpaax_logs.h         |  3 ++-
 drivers/common/zsda/zsda_device.c         |  5 -----
 drivers/net/qede/qede_debug.c             | 20 --------------------
 4 files changed, 2 insertions(+), 30 deletions(-)

-- 
2.53.0

