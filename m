Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E5CD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:17:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FE99402D6;
	Thu,  4 Jun 2026 05:17:06 +0200 (CEST)
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com
 [209.85.161.98]) by mails.dpdk.org (Postfix) with ESMTP id 9AE8540270
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:04 +0200 (CEST)
Received: by mail-oo1-f98.google.com with SMTP id
 006d021491bc7-69e1eba21a6so178202eaf.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543024; x=1781147824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X/FOFdhB6WTNmrt3L/s+FcPkvolMrXZW9wznteipbtc=;
 b=m9K4sMBrp7ZcpzDZ1O6FyU2lDAXHSXhbR+Csihk+4MHY+u6BRqBHXYAj3QLi98nxNY
 diiNwLRmGls7UIxSHdSIh/hZrtvUG+m6gfaoJ51nHbtGGGoQTpjqUd7vrS30PqCS1OuE
 S+TLlSuIuTZJgd9LZrUDfKd6/J/W8qLEnEvaTj38BY6vcmjxsShs4HioPCx8c5Lm+08C
 fYQnq5rgzghUOdb3TXuY/Edx+MS3GFBjEQi3mttgKlzVMhenGZButC0XqoThYLddBW23
 jBSJBCmpCZuyjVPx7D7f0XZxCf6/ry/L/zJaW7VMF4XHgNWTubHRMXfx9AbQpZD6NDDV
 0pPA==
X-Gm-Message-State: AOJu0YwCJDwSB0pDoqOjYtARd4Z6JShhLRz5vf/eyc7FE3z1Ee3lEuwA
 GCfr9eJHBp39gid65J91NCuQ23O9XHCOZovMEPYf/Nm26suWYlqtJvNYXEvM65jDjO122RDfQCH
 PRVrBpPjbaUWjfd0QucyHkW3lAtWSqesU2FreL97tYG+y8zhadFgkhm1atm4e8Ueg1/YkbWbE6e
 RuQcGQN1xEOvoXLWKZSgr3SsruzNK8bx5B8Zdg+/naXy+gu7Uj534B4gHZnoOBYeTLY0fuPWFYx
 1nfh9xbNigs
X-Gm-Gg: Acq92OGGVlIeRq6FlcC36FCLT7gptdv8vlPX90UbpFz8V+L3iPLWs74Q+tYhv+nhpZP
 7ihmDqNrxpGHpwojMo4x76NlPoxQIjXtSddlFWEOCEQbVvLwD151pMTF0jE0fImb7W/yx4t+pNs
 0eXOmqDfwyZ8E2JzqBGC+6pQOzRSHDEXDuRWznq62XmhnZ+C695eCbS37jtv3tATyfYbyE70+Jm
 HtUXkt0fDm0DtPLjpLKHpIO6DkX0V8bLVYWuUl5YcwBvnMray1cfu4vABZBzZo1wnbK0EJs4XIp
 uoQAVOpMlvVnl+5hIC8NjcnnNyGruGBzvpo7I4uqXFSkiwklBPTFdL7agnQBQFhRD5ezzuM5C1w
 tuVeRqe2d6FZXurrV4LwJzL/W6/H4j24HL6bswrDd2zx1HFzEry4fMI7JbRw7df07VUowOYfYML
 KhB+E3jiyk3VVYO3AxxTHPJSPYjtyVDyhIXc2/pmcBs1RpHz5CQ+WQorp79/LX3oaF9R/yOvpPo
 1jDGrbnrkNl
X-Received: by 2002:a05:6820:55c7:10b0:696:25d4:1e62 with SMTP id
 006d021491bc7-69e47e69ef1mr2265219eaf.2.1780543023585; 
 Wed, 03 Jun 2026 20:17:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-69e462bcafcsm223869eaf.11.2026.06.03.20.17.02
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157d38ab37so29171085a.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543022; x=1781147822; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X/FOFdhB6WTNmrt3L/s+FcPkvolMrXZW9wznteipbtc=;
 b=IT0MJGYcZqPkkQGNVERuf0lSb+2Mi4B1Ega4uN0DLYwQyyvD9tXTzIdYYLaFEllKCD
 F3GGygvzsp2QzFgVOtkzJGcij1p+7FTsaWFhxa8/ahng11J4Yju39nyJDht/VdGwNJDN
 jWgDrN6JYeJZJs9Mx8A329d0U/zqqpKvHjdf0=
X-Received: by 2002:a05:620a:268d:b0:912:c0b3:7d9b with SMTP id
 af79cd13be357-9158a76739emr982202885a.24.1780543022016; 
 Wed, 03 Jun 2026 20:17:02 -0700 (PDT)
X-Received: by 2002:a05:620a:268d:b0:912:c0b3:7d9b with SMTP id
 af79cd13be357-9158a76739emr982199185a.24.1780543021378; 
 Wed, 03 Jun 2026 20:17:01 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:00 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 00/10] net/bnxt: vector mode V3 implementation and AVX2
 improvements
Date: Wed,  3 Jun 2026 21:18:41 -0600
Message-ID: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
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

This series adds vector mode support for BCM5760X (Thor2 / V3 packets)
and fixes several AVX2 path issues:

 - Implement AVX2 vector RX for V3 packet completions with VLAN TCI reporting
 - Fix stale nr_bds values that could cause the producer to lag the consumer
 - Fix incorrect advertisement of LRO offload capability
 - Fix scalar RX path not checking rxcmp flags before setting the PTP mbuf flag
 - Fix missing timestamps for non-PTP traffic when promiscuous timestamping is on
 - Fix Tx ring corruption and burst truncation after an invalid Tx descriptor
 - Optimise the AVX2 RX paths (dead code removal, register reduction for V3)
 - Fix VLAN strip ol_flag being set per-port instead of per-packet for V3
 - Add burst mode info entry for V3 in bnxt_rx_burst_info
 - Fix V3 vector mode defaulting to cksum-good instead of cksum-unknown

Most patches carry Fixes: tags. New functionality (V3 vector mode, AVX2
optimisation) is targeted at 26.07.

Note: this series depends on series "net/bnxt: stability fixes".

Chenna Arnoori (1):
  net/bnxt: fix RX timestamping for non-PTP packets

Damodharam Ammepalli (1):
  net/bnxt: fix advertising RX LRO offload capability

Keegan Freyhof (6):
  net/bnxt: vector mode implementation for V3 packets
  net/bnxt: stale values in nr_bds are cleared
  net/bnxt: optimization of the AVX2 RX paths
  net/bnxt: fix for VLAN stripping being set incorrectly
  net/bnxt: add vector AVX2 burst mode indicator for v3
  net/bnxt: fix v3 vector mode not selecting cksum unknown

Mohammad Shuab Siddique (1):
  net/bnxt: scalar rx path disregarded rxcmp flags for setting ptp mbuf
    flag

Zoe Cheimets (1):
  net/bnxt: fix packet burst truncation after invalid Tx descriptor

 .gitignore                              |   1 +
 drivers/net/bnxt/bnxt.h                 |   1 +
 drivers/net/bnxt/bnxt_ethdev.c          |   6 +-
 drivers/net/bnxt/bnxt_hwrm.c            |   7 +-
 drivers/net/bnxt/bnxt_rxq.c             |   3 +-
 drivers/net/bnxt/bnxt_rxr.c             |  25 +-
 drivers/net/bnxt/bnxt_rxr.h             |  14 +-
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 444 +++++++++++++++++++++++-
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |  37 ++
 drivers/net/bnxt/bnxt_stats.c           |   3 +
 drivers/net/bnxt/bnxt_txr.c             | 170 ++++++++-
 11 files changed, 677 insertions(+), 34 deletions(-)

-- 
2.47.3

