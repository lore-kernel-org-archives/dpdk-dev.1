Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648BBD2ECF5
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 22:46:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42FDB4025E;
	Mon, 19 Jan 2026 23:46:01 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id D6EE74025D
 for <dev@dpdk.org>; Mon, 19 Jan 2026 23:45:59 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so29029115e9.3
 for <dev@dpdk.org>; Mon, 19 Jan 2026 14:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768862759;
 x=1769467559; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lr/mFHPIKK8xaZh/dFmEbWUubUErKLQhmFqp4f2gypM=;
 b=Rreycse2CzPauMq4CEuJj3/L17j8KlkCXEzs3VVKsQAl86pvsEZJkiCqUOEGAyd4kY
 /Y7BlblQd8prqGyUJBsDpI/zEhZUQk80Dm3mQ0MHHPVtGKjsjOTf66W3KF6+ysVYvkMg
 owWmeuZCUO8Wr3WufeQLNv1IGb0ma7SY3b38FHzVmtyPHVijkc8t/woPwkYSWJHdRVpb
 UY/zoAIuZV9HmYaN242Ud/0CQccyKtdHcjGAChuNpEP40DGFQpIXZWRR7heiCZdQ8D9a
 Efe32vpbuuvvhpvb1MGG1bKOnrZdghvMVb3TXwqHBlKFU5pv6dDADOL7IC3Qjx+X7s+f
 Ba6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768862759; x=1769467559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lr/mFHPIKK8xaZh/dFmEbWUubUErKLQhmFqp4f2gypM=;
 b=OPr/6wQklE+WdB1qOUxNVgNKNN0CVKQhCSyn7hlQVZw+AfRqDPnmm5uXYlAv+0exmE
 MNeW8z1cl4nEKWMlxspIFrTn/58smJsNRMTvXfWi5TryNVt5STibDJG+XSx3X00ZFl8d
 Wzuo6cEaxqmh5HBWjTWarzqH6IIfUlxN/8wcopfb7pB0Tp8eG1UoYW0azmBp3xDQOxBD
 D++hda1cM5baZRm6vmljFN5CCG1UIOm0w62Id6G+GKbJMKauzpkY3ChJySbu3Ej0JMJK
 4t1fNXMSEGABAMBHunp66DbCRilNuT0Ep+PrxeYMia4gLrXWQAfqgIhkhUA3nQs4ylYe
 eCRg==
X-Gm-Message-State: AOJu0Yzz5DUMqsz1NO4SAhf+SM/+k8GyTAGQI5zFFMkrgPA9Vs6+yghk
 EYLv20FU07igQ33CNm/EI7riZuTr6Dqt+3lfpI1FdlbJ1T5ELiy6YEjyRYuz5bFaQgjXaNzbxx2
 Yn9+h
X-Gm-Gg: AY/fxX5/V+C1uiZF6M6qN+GIJCW/G/U9rZ2BbPHK2otSplpIqJ4zBTegqZuoDnrTQ41
 LLrHENmlYhvzp9tuS7Q4IZYxZAeSpdXJwJqW5TUNn1TpqKGgRdRomL0HtGjYf4koTF1BqqP2tLh
 r7Z98RAlMCWYrPVvwd5JCLIfVOHRb0YBNP48RHOgJA5Tk4AbSoevFPuVm/ZPQ3OO+urnJ5URmyt
 nHWnP+t4sQ8eubziQpVv+88jGc50JZlmyRbrShGE49zpiGR8JsynPvDqf3OF2GxHMrRa3ZI9Fca
 bqHVasH7kTP4urPFYrlJphG4TNj2FYVvcJlQAqJUwOoT1yc4S9xJRAAA48iCLxViPL8Rs4LVeG5
 FoeOsBO9TXjhMdgXG2iZkJ3dZamOS91YGrrhiryz1Q6MMVN/y2mFLWrLmWbGntZkc9bnE47yq8J
 LsoXHhm9Z13vtxEy21s9jKHbwu4E6+ShHXX1Fus33S4lCh3o+2zlgpXPWXuwhi
X-Received: by 2002:a05:600c:4f90:b0:480:3b76:6b92 with SMTP id
 5b1f17b1804b1-4803b766c41mr30520385e9.29.1768862758865; 
 Mon, 19 Jan 2026 14:45:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2b936sm88180485e9.11.2026.01.19.14.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 14:45:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 0/6] fix build failures with LTO enabled
Date: Mon, 19 Jan 2026 14:44:07 -0800
Message-ID: <20260119224553.226243-1-stephen@networkplumber.org>
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

This series addresses build failures and warnings that occur when
compiling DPDK with Link Time Optimization (LTO) enabled. LTO performs
aggressive cross-compilation-unit inlining, which allows GCC's static
analyzer to detect both real bugs and generate false positive warnings
that are not visible without LTO.

The series fixes:
- Real bugs: buffer overflow in cnxk reassembly SA setup (heap corruption)
- Variable-length arrays that trigger warnings with LTO
- False positive warnings where compiler cannot prove bounds safety

v4
  - add Fixes tags where appropriate
  - Bugzilla ID's for existing bugs

The cnxk patches (1-4) should be applied together as they eliminate
all VLAs from common/cnxk and re-enable VLA warnings. The remaining
patches (5-6) address warnings in other subsystems.

Stephen Hemminger (6):
  common/cnxk: replace variable length state array
  common/cnxk: replace variable length array
  common/cnxk: re-enable vla warnings
  common/cnxk: fix buffer overflow in reassembly SA setup
  net/mlx5: fix LTO false positive stringop-overflow warning
  test/soring: fix stringop-overflow warning with LTO

 app/test/test_soring.c               | 18 ++++++++++++------
 drivers/common/cnxk/meson.build      |  2 --
 drivers/common/cnxk/roc_aes.c        |  3 ++-
 drivers/common/cnxk/roc_nix_inl.c    |  2 +-
 drivers/common/cnxk/roc_platform.c   |  4 ++--
 drivers/net/mlx5/hws/mlx5dr_action.c | 14 ++++++++++++++
 6 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.51.0

