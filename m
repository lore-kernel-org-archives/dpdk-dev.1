Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C4CD6E6E
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 00:48:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 108A3402D6;
	Fri,  5 Jun 2026 02:48:31 +0200 (CEST)
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com
 [209.85.222.99]) by mails.dpdk.org (Postfix) with ESMTP id 1C08A402AC
 for <dev@dpdk.org>; Fri,  5 Jun 2026 02:48:29 +0200 (CEST)
Received: by mail-ua1-f99.google.com with SMTP id
 a1e0cc1a2514c-963d7e5ffddso832304241.2
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780620508; x=1781225308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9MZNkTUlJg8R9yC710HnvepqQVYXMIXCvEO+DtZ1yW4=;
 b=HNajbAchgr3k+iuz1Jh6OTIZNASFUOnbWXQb9KRCADlXtUIhwGyNqWWigUqVQs/v0p
 ARSynnDgmqwAnikS0qIwhNtkkg75XN3SjhGkIEGIMBUSrLYjcLiDRNDD+4Qzo6x+ZXEP
 LDnM1VimEuNOdd/Sx6cWvABkCiiYryzAZzZLEtvGnbtVP2S2un58kmiAux3xZSpdLLn5
 dG8mRIEHbyXGbPsPLJ77p5rxsGAJuLlN5fNOEvOezT5AGmKOaKc9VPZkCLzph/IkTRsr
 +GR7/rH5e8TUB6QMBU9ry41TH2Fb81M5b3ov/0q9ZNzan0509O5AchK9dBmjZ8P4mkAh
 aQkw==
X-Gm-Message-State: AOJu0Yz+S3x552g6oG5Dgp6Q+2oAnyBuOaSZ+Y2ccWFGInPG1WAu2wuX
 Rv/vGw14kc9FXIWOZ5NX4CwScvikp3uNjahqI55XNP+9U/3UT4lio8pHQhGdKTw0SIqC4+GGmNT
 xFmPFjccoZVFJBlDeJUE+QYqIxGxYs0CYgmOJGm0VwaIfiOBJDMcK7ElT1yK+K9vnAVpnuthLEX
 66pwfl9XrO3TdO0NxcD443LQ8LfpP3JtNW8MYnA2NEaP/ii9FdwFD7uRIBnTfmSgRq1G5wEIkp4
 4c/+4mKUWXu
X-Gm-Gg: Acq92OGkCBRQ6d1EQ7yCASsQVtB6ZxyU5rbJf16jB/KzOoxZkGfdldjQobo3Zp+znYl
 ene0pms0b4hvOI/LhzUzisWVrWhU/4xiVNHkx22MI0ZnOnNHUHci+wxcrvXMm2Lu75tpZTjLfPL
 ZlmRwvuDE1xCag58dMBCPMNxqf+SZjyPUj8JAapX9OJ8RXI8JrFyIAMdvZ/Sb9s1illRetP/NyC
 Ph6wjo8v6XQX8iZfyVKzmDgnxonUvC0KGoAnYhZHIG65vMrU3bxvqgLxak3SIvBX0Kyt+nHJjMJ
 wHViGlNR5tBijVv4Gun2NboQXribHZa7IahDfsEdhJk3snaq245A3Sy4Qk0Pv32tJtDKEz/SjpQ
 ngU4+bX32r6VmbCGaYJTwhDsWsC8H52iLfgdmgAzbg3AZ9whGBV6F4oDKPv7aUxdlFzpC7OIkKB
 u04prDtEGqwOK2p+HbIvK7IntLweUUJUm0tpsJPCejdwg1MdPmxrG54lpPaNrWNDXkTN/vQ7ZED
 ftRCOrvNDg3
X-Received: by 2002:a05:6102:2922:b0:6ef:dc8c:9367 with SMTP id
 ada2fe7eead31-6feed1a226bmr649658137.5.1780620508067; 
 Thu, 04 Jun 2026 17:48:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-6eb6420a3c2sm477357137.18.2026.06.04.17.48.27
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 17:48:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5176d949c58so36481251cf.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780620507; x=1781225307; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MZNkTUlJg8R9yC710HnvepqQVYXMIXCvEO+DtZ1yW4=;
 b=gfw9+8dAvfxtTu38ryJ/YFRxjKmWh+SlFntlP9uqCsVO3IT5vn+GUm6wHfMT6H23X5
 Ow4L3TYYgTMXsXrfjXxqAbpCGxjGxREyyrPjjQplJT8ahGfuut36vJExENEqU3JpDacu
 58zQfxX/84tS9nhFTg4FL6nqdcY2CynmCuS74=
X-Received: by 2002:a05:622a:650:b0:50b:4a84:aa94 with SMTP id
 d75a77b69052e-517959d5610mr21941011cf.7.1780620507090; 
 Thu, 04 Jun 2026 17:48:27 -0700 (PDT)
X-Received: by 2002:a05:622a:650:b0:50b:4a84:aa94 with SMTP id
 d75a77b69052e-517959d5610mr21940631cf.7.1780620506590; 
 Thu, 04 Jun 2026 17:48:26 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0556c0sm67187396d6.25.2026.06.04.17.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 17:48:26 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 0/5] net/bnxt: interrupt handling,
 external mbuf and stability fixes
Date: Thu,  4 Jun 2026 18:50:11 -0600
Message-ID: <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Changes in v2:
 - Patch 1/5: replace printf() with PMD_DRV_LOG_LINE() (DPDK logging standard)
 - Patch 2/5: replace custom bnxt_mbuf_buf_addr() with rte_pktmbuf_mtod_offset()

Ajit Khaparde (2):
  net/bnxt: use buf address for external mbuf
  net/bnxt: prevent a potential segfault

Keegan Freyhof (2):
  net/bnxt: fix NQ/CQ processing for interrupt handling
  net/bnxt: fix for segmentation fault that would occur on exit

Mohammad Shuab Siddique (1):
  net/bnxt: fix IOVA range check for external mbuf head node

 drivers/net/bnxt/bnxt.h        |  2 +
 drivers/net/bnxt/bnxt_cpr.c    | 100 ++++++++++++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_cpr.h    |  34 +++++++++++-
 drivers/net/bnxt/bnxt_ethdev.c |   3 ++
 drivers/net/bnxt/bnxt_hwrm.c   |   3 ++
 drivers/net/bnxt/bnxt_ring.c   |  11 +++-
 drivers/net/bnxt/bnxt_rxq.c    |  47 +++++++++++++++-
 drivers/net/bnxt/bnxt_rxr.c    |   2 +-
 drivers/net/bnxt/bnxt_stats.c  |  17 +++---
 drivers/net/bnxt/bnxt_txr.c    |  19 +++++--
 10 files changed, 223 insertions(+), 15 deletions(-)

-- 
2.47.3

