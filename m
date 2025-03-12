Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071D2C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:27:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFFCB40E0C;
	Thu, 13 Mar 2025 00:27:52 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2056B40144
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:27:51 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-22435603572so6781485ad.1
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741822070;
 x=1742426870; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RXMbx2y/r1ctlGMALWX9za6/pUMfLUazmGEPGFA3Fhg=;
 b=TxQwMwMLMlDyuFOc3384RnTSIi0qXfvmYl5qUSC1viGVT/LNw0mKnmF6mUTG+moo6R
 JR3zMOpANbGW5ojztaOYzD8DhcK2k+Z907Bfk8pVjWix46iwNZEHCglY1A0sPDbamI3f
 iq9TEbAcLWkWrGCn1x21+FPOK6vADNmpMAiybqP3TPqb+aQDugU23Np+fnQO9WooXiWX
 L/7uO/C+nLWFwL0kBRY5ds97Q2ENtnAeG4H9dq0Q0v/ll00ftEc4/vOCUTho1gm7nOmF
 Ex1t1PZTKnPZaW/AOIvKFtDjKCYBC4n1osSJRlt4barhKdIdHaBcdfvHUhRh9WBy+oyr
 vVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822070; x=1742426870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RXMbx2y/r1ctlGMALWX9za6/pUMfLUazmGEPGFA3Fhg=;
 b=T6ebMw/ie5aHB66vrEQSQ1v0bsTd3zqcEvyo/6NKGZnBvseSrWgR45KE9G7eFgK92f
 BbOWmZGxJzPua7KK8zWgTKUWq+shLpBww5ZfsB6UV3ufJ48ALg+XYi5/I7XzPpT6lI97
 Ed59ZqRwc3rb3sjn7blTaUdS9Mx/IxnGbpuoqKM6VU3ZHHOKnZ85FM63lj+h8I0qYCh7
 yl3AEsL1j5YPIgN3Ht+R7DBblc7M8otC7E0xJrXSiwuWmA9aXivJ1RCDIN6W69imUxU2
 /FUfJLnzsjlXMoHA56XlFuoZOhhdugtPd167kwn4rqurnRGcbljFvgWYW1S2iJYcy2Ie
 rTvg==
X-Gm-Message-State: AOJu0YzkhUsCMT7eUGq/IQMINP2NwAi6GMLlW0m8aByKeG2S7RH4I2Ec
 WzdannkEUK199h+I2x6IgIxJbXR3YeW8m44NuUm9UoTKiwxgtkVmaq1blvuHi7t6zMX9nljLlqa
 k
X-Gm-Gg: ASbGncsJoM456Ozv6oHzHrSqCmI7goTEgFZIByznuaItp6r+14uYHrxKsdShLXTtu9T
 s6rt4mXfcXsZ3IQn/Gnr3miMMkvRHE3MiODGyXR0MdrTyiJ3F2xvAe1fW91DL98yTN6QYjlmIEl
 2b67wqTjxgIpkTqy7OBKiaa/b8a2X0tLOwC7/hzhNyi1yR2aEJrtaELu1sOEeRNgtu/X07oE84C
 qDwHsA8nnadWBgZ+7DQ0+ud0uwDJhqlCcZ5OaP/ruvrTEw+jlVQ3R60rKvQe6qCHfkHQOwO7r1b
 ZWqSyi7+4uQyUOzvekoZxwf67P4fPrLE7yjzzS3lNIPDRdA8LUauTLJUEfaEpHDSKFGL5CYt5SB
 6OTzRQ1FrVx4IW4+dYtXdZw==
X-Google-Smtp-Source: AGHT+IHNvvIgijtCh3BirT+dtsWtkN7kJ2MLrNeXsUP0KZYTeLw38eG87fV0C0WM8rKlOVy1EuMV2Q==
X-Received: by 2002:a05:6a20:549c:b0:1f5:93b1:6a58 with SMTP id
 adf61e73a8af0-1f593b16d38mr11684196637.8.1741822069071; 
 Wed, 12 Mar 2025 16:27:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea95651sm111917a12.73.2025.03.12.16.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:27:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 0/7] avoid unnecessary use of comma op
Date: Wed, 12 Mar 2025 16:26:57 -0700
Message-ID: <20250312232739.228295-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

This series was motivated by recent thread on netdev
about build with -Wcomma

Stephen Hemminger (7):
  eal: replace unnecessary comma operator
  ipsec: replace unnecessary comma operator
  graph: replace unnecessary comma operator
  net/mlx4: replace unnecessary comma operators
  net/mlx5: replace unnecessary comma operators
  test: replace unnecessary comma operators
  app/testpmd: replace comma operator with bracket

 app/test-pmd/cmdline_flow.c          |  6 ++++--
 app/test/test_compressdev.c          |  4 ++--
 app/test/test_link_bonding_rssconf.c |  2 +-
 app/test/test_thash.c                |  2 +-
 drivers/net/mlx4/mlx4_rxtx.c         |  2 +-
 drivers/net/mlx5/linux/mlx5_os.c     |  4 ++--
 drivers/net/mlx5/linux/mlx5_verbs.c  |  2 +-
 drivers/net/mlx5/mlx5_flow.c         | 12 ++++++------
 drivers/net/mlx5/mlx5_flow_dv.c      |  2 +-
 drivers/net/mlx5/mlx5_nta_split.c    |  4 ++--
 lib/eal/common/rte_malloc.c          |  4 ++--
 lib/eal/linux/eal_alarm.c            |  6 ++++--
 lib/graph/graph_stats.c              |  2 +-
 lib/ipsec/misc.h                     |  3 ++-
 14 files changed, 30 insertions(+), 25 deletions(-)

-- 
2.47.2

