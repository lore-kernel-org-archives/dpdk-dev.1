Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE9AC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7368B40289;
	Thu, 13 Mar 2025 00:17:27 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 4564640144
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:17:26 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-22403cbb47fso7494325ad.0
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741821445;
 x=1742426245; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cGqUmywTBHo9l74/5er8l86n2fBpZGGrB/Q3n1Bj5M0=;
 b=SfBJxrILylu/FrZobJ7OLC0LnSpZbBS/x3+FyV0MO1b7wPGXMKl3e3sSg3p8CmEcxx
 vdRIug0HaWigRqPTspFMeqthIzjL2fYBexQducK+IuwHt44pYVF/zV3gciMhyyPXyaWk
 rIziiSJqrIe+I+PrPgZN36J93/sWgBoDs21wSPLui2Z1c61dFqcDyehD63to3ys+nAiM
 ZDeXHVo3PH2E4x6vFB24b2Z8xgnHWUdoJU1nPiES9s0rbPiz91GMfF8pb/ebfAxIKsXK
 kcbgkjwxRD1GYC3mss5tiO3xFLGFiCVehirwMrdJ0sPFrff3HTc7AQ11Iki2z/QyHjL5
 z36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821445; x=1742426245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGqUmywTBHo9l74/5er8l86n2fBpZGGrB/Q3n1Bj5M0=;
 b=S0gVMDaaNx7hpV+0m4KiD/IZNSfNLPfhZt9rdAFwgPlC1FzjzRBSV6gQvs0QBCJwBR
 QYWj022SIRluPNyzeW35w0P/1moqps3wL4xcv8xcaH1HYOcoZC0X9CWV8dUGwyyXV4ja
 t1zMyksF3KCCAxFNsoe429JWFrwYBaY5gdPV5HjmiyjOw38gqeuoY6dKNuS08esvrSI2
 f03o6uRPntstyseqqermZ1Uyh2Mjy0XMXB0l3pS3UDQO05MW3DmhqsEWsbYFKtauiskQ
 prFs6J8nmco8ig5O/gCa5jUMvTR4b74DNbztgjYGXmcK9bcH6eNc+zxI86xB/agAeLI0
 SSEQ==
X-Gm-Message-State: AOJu0YzaBuVsC3hTU5uijSF9yp7ZhAfMe9XD8lpYgHLOli3yI4+ZTtxf
 0Y6b75WMPqcxIJ/G7qx9/lt3pev22qbj/dyBJcLlzZb0eArbQRQg6wGi+pYJiVj40UDzqhNyYnV
 J
X-Gm-Gg: ASbGnctiWm1oOrNFedv7U55vsztNwQ3y+3emEqzdhaMkDyN9pJFt8ocRr+rsIzxpGb1
 V1133oZ7a2fWwwJ4Tp6gLtnmt9Ov0wapRlVxiQ15xKIzULI+3SexYhBRernP5haIIGty/G1N25p
 zYX+sPmpnC0Q0bEhk+dGMkAPtwBxFDUAyot3MoKUImtBe5ZfjeqnDWQhAxy7r9fKxqfIKh7427y
 y7oh9g+n0pLXftBBVNduVXSh1Q4epyATaRj9D52c7XPWjnNJZCSqhQQtFQEb0igvZTAblf1d80l
 wgTqD4OHfXu+/ypKY0drBMxtn9r1S2LA//Ss6A/a9Pto+yHGDUxilVLwDFTSO6qMJKl0LFBEeSY
 E4+gi8S4NKZO1G2EfCPogYA==
X-Google-Smtp-Source: AGHT+IEU8nimF1r6QGepPBSskK9ZCk+N11Ytz9AuQch1IwM5POSv+jg/hYAqloAzSUj/LOMPZR6BRQ==
X-Received: by 2002:a17:902:ec92:b0:218:a43c:571e with SMTP id
 d9443c01a7336-22428a8aa35mr418342485ad.28.1741821445368; 
 Wed, 12 Mar 2025 16:17:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f38sm1028305ad.129.2025.03.12.16.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:17:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/9] introduce common FOREACH_SAFE macros
Date: Wed, 12 Mar 2025 16:15:29 -0700
Message-ID: <20250312231715.222149-1-stephen@networkplumber.org>
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

v3 - add a few more open coded loops that can use a macro

Stephen Hemminger (9):
  eal: add queue macro extensions from FreeBSD
  net/qede: fix use after free
  bus/fslmc: fix use after free
  net/bnxt: fix use after free
  net/iavf: replace local version of TAILQ_FOREACH_SAFE
  vhost: replace open coded TAILQ_FOREACH_SAFE
  raw/ifpga: use EAL version of TAILQ_FOREACH_SAFE
  net/i40e: replace open coded version of LIST_FOREACH_SAFE
  net/ice: replace open coded version of LIST_FOREACH_SAFE

 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c |   5 +-
 drivers/net/bnxt/bnxt_filter.c           |   8 +-
 drivers/net/intel/i40e/i40e_ethdev.c     |   9 +-
 drivers/net/intel/iavf/iavf_vchnl.c      |   8 +-
 drivers/net/intel/ice/ice_ethdev.c       |   9 +-
 drivers/net/qede/qede_ethdev.h           |   3 +-
 drivers/net/qede/qede_filter.c           |  13 +-
 drivers/raw/ifpga/base/ifpga_enumerate.c |   4 +-
 drivers/raw/ifpga/base/opae_osdep.h      |   1 +
 lib/eal/include/meson.build              |   3 +-
 lib/eal/include/rte_queue.h              | 174 +++++++++++++++++++++++
 lib/vhost/socket.c                       |  11 +-
 12 files changed, 200 insertions(+), 48 deletions(-)
 create mode 100644 lib/eal/include/rte_queue.h

-- 
2.47.2

