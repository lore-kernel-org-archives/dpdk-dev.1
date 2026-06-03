Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CC1CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 21:12:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8EBA406B4;
	Wed,  3 Jun 2026 23:12:03 +0200 (CEST)
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com
 [74.125.82.225]) by mails.dpdk.org (Postfix) with ESMTP id A79C040696
 for <dev@dpdk.org>; Wed,  3 Jun 2026 23:12:02 +0200 (CEST)
Received: by mail-dy1-f225.google.com with SMTP id
 5a478bee46e88-304f0039c02so488710eec.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780521122; x=1781125922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/RVBu805op7IXaPlBL5/p3X/I/1qy/ZyJ8LOv9Ea8+g=;
 b=VqbPfDln4breZ4blmmpM/s/KBtAZM5PjZqW40Vk9I1/gu99/HTNF1Ic7PPuvZj7fkK
 DKK4zVIp9UiFFKYzinXzPTHugF7jTlqCnHmceEwh3n4iL9sEUhI9rVQ5IKFopSLpUiaj
 ws9XZ5hu26x6POSJmvhMZLwmstI2ILMNGUcTyvVcrMukAkAERDD20kmbtWvcATwX4xGc
 IPkbroR2OOGkGWpMFvx3ax9uODs4xq7kTVunYc9bH6FeiarddEjGyRrDRfk+KKdyc8r8
 8hy29O9RAyvV6/e4jy+ZetBeVaa+sOtD/mO2quONfgXPf23VOeXaWF6TsK0J+dN+5xq7
 SQ8g==
X-Gm-Message-State: AOJu0Yzvsddd2DJ/9BEbA+FB8fodTDjNrxP6OX8wApuS4c2H/a+N+bu1
 qqeMRtE88plS8uPGwbODemYgCBIL7St5CeQLqmqGG1Szhr5mCuMzEEY8PYQetqsZUGVZRIVUu3X
 XuKD/hgja7uT6JpbqDT6tV5MVnyQYkkKfwEMy3i+G7I5nQzbsDit60LZkGjF5dLEWQeEiBW1zaC
 lIXAq5yPPFApj1AQfcqxgvLQ1nfAaE9yYMf+XUY1b9HzW8UxPh4ScjIGjBNhXH+As9MRvIIM9Do
 uWVy4aYYSeL
X-Gm-Gg: Acq92OERsqY/MNRATE1flGm5tP0LTBFt2w2PPlA3VzcQDBAi/DM9Hfk+DpnDjfaLcxQ
 ZsRQiPIMCerTLA1i9Zma/7w0AbKplSFAF5fxYhe+cYy22VLl/HRrkxZlJUyh0vDsQKOABKwO9QC
 K+BER6bcvUVSZAZ9I031+fIhEjiHMGpsoiVPYt3u0PTaWRIjAXo/2FiMrctkDaR8KOrSnP7VsiO
 efwgKanGUPsLBSvAtoEPPq0v8MekrcigEmIfKVH9luTGITzvRN9PXWl0Qe0l5l3gEBWiyJ4jNI6
 83UUwoTwxpVkuipdpaHoJeEMThVckr4GNNTxw6laonwYBdzrUtAEx0GxBd1LwqWBd7Ac9B03F/2
 YHyGcAXw9ULgcBU78HhufbBYe5gBELPV9IYo9Nza8d03yLiokwwAXlxz7zUEz8gA4LiAuyWBlZ7
 yP+NiRVHiuLoj8fYzYl/9Nk8ZW6fwz45Kw6KvvvmuW/dYGWK1HB12gCMQUuPtO0QjIGRYt4ScWa
 UeQbvLcRw==
X-Received: by 2002:a05:7300:5726:b0:304:de28:1b16 with SMTP id
 5a478bee46e88-3074fc07889mr2829053eec.28.1780521113050; 
 Wed, 03 Jun 2026 14:11:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-3074db49bfcsm232284eec.1.2026.06.03.14.11.52
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 14:11:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ccdcd8dd3dso144671906d6.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780521112; x=1781125912; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/RVBu805op7IXaPlBL5/p3X/I/1qy/ZyJ8LOv9Ea8+g=;
 b=dGHAEDvHa1gnQeU/K1NGcqJVJmUeAlKP2YzjaWK/n8iMgcvBmOneTU7mFJRVEc/F4q
 DIZgYsLqzmf4OmdpBK1+2OeXpC3qLZBGIQ3cvmCdawcm4gpWdaoMHXtn+6xt46d1YRWL
 XGX+zalSbxrMOeRSMHYmXSAVcjwxQzE0H8X9E=
X-Received: by 2002:a05:6214:4b07:b0:8c6:4d63:570c with SMTP id
 6a1803df08f44-8cecdc255afmr87200486d6.12.1780521111700; 
 Wed, 03 Jun 2026 14:11:51 -0700 (PDT)
X-Received: by 2002:a05:6214:4b07:b0:8c6:4d63:570c with SMTP id
 6a1803df08f44-8cecdc255afmr87199726d6.12.1780521111207; 
 Wed, 03 Jun 2026 14:11:51 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0520d3sm31665416d6.27.2026.06.03.14.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 14:11:50 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 0/5] net/bnxt: interrupt handling,
 external mbuf and stability fixes
Date: Wed,  3 Jun 2026 15:13:36 -0600
Message-ID: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

This series addresses interrupt handling, external memory, and crash bugs:

 - Fix incorrect completion validation for NQEs and RX completions causing
   excess interrupts
 - Use buf_addr instead of IOVA for mbufs from external memory pools
 - Skip IOVA range check for external mbuf head nodes to avoid false failures
 - Add null checks to prevent segfaults when accessing uninitialized structures
 - Fix segfault on exit when bonded ports are present, by checking whether
   ethdev has already freed the RX/TX queue arrays

All patches carry Fixes: tags and Cc: stable@dpdk.org.

Note: this series depends on series "net/bnxt: ULP stats timer and PTP".

Ajit Khaparde (2):
  net/bnxt: use buf address for external mbuf
  net/bnxt: prevent a potential segfault

Keegan Freyhof (2):
  net/bnxt: fix NQ/CQ processing for interrupt handling
  net/bnxt: fix for segmentation fault that would occur on exit

Mohammad Shuab Siddique (1):
  net/bnxt: fix IOVA range check for external mbuf head node

 drivers/net/bnxt/bnxt.h        |  2 +
 drivers/net/bnxt/bnxt_cpr.c    | 99 ++++++++++++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_cpr.h    | 34 +++++++++++-
 drivers/net/bnxt/bnxt_ethdev.c |  3 ++
 drivers/net/bnxt/bnxt_hwrm.c   |  3 ++
 drivers/net/bnxt/bnxt_ring.c   | 11 +++-
 drivers/net/bnxt/bnxt_rxq.c    | 47 +++++++++++++++-
 drivers/net/bnxt/bnxt_rxr.c    |  2 +-
 drivers/net/bnxt/bnxt_stats.c  | 17 +++---
 drivers/net/bnxt/bnxt_txr.c    | 19 +++++--
 drivers/net/bnxt/bnxt_txr.h    |  6 +++
 11 files changed, 228 insertions(+), 15 deletions(-)

-- 
2.47.3

