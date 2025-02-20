Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE22C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:57:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7479402B2;
	Thu, 20 Feb 2025 17:57:03 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 7B1E540292
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:02 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-220c8eb195aso24706765ad.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070621;
 x=1740675421; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lWYsoNnhhp4+OPp/dErLZJLy7f8gVbOIqc70zkzbuI=;
 b=v5ROd2eRp+g88PaUTEtCCFp9qP5HtWmsZ4pRZEzQGASH/KNyeGkQImjRacgZlCtGJe
 IGgIwLAoM26emNusvt0zYQKHQ/fETUZMrd6B9+azZkD2lMPztKNVzaSpQ1HQc4Iv0R4+
 3Mq1znmRcIjSuHHXXhaIAyN8hzac6M44nO4aemvRBxDaxn8GIHu7sCtuaRkEtt/awZG1
 DcDhPgw7FxdM3jMePcqMJOjO/sEWNKoO9lvx84R9EzymUSzF022LcI6ZzmC0UFllBkRI
 6I1bDWVdrqlav4I5vbhZfyt+yF4PsW/+ibkN2v4eu1a6BQsPa/NUljG6ELxLzYse20tm
 C4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070621; x=1740675421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lWYsoNnhhp4+OPp/dErLZJLy7f8gVbOIqc70zkzbuI=;
 b=pBWO3xHzcvf0I0xR5yoBlK1EejM9lDf4Iv2/ejaMuzzPpGcnFgjZ3+wbhdYCzpDYkF
 qmb2jwqlaNoFjOrBn1ypelkxUOmtDwjkoOQUcHW2X045bCDCTFBD4th3AgD8/QiISl0K
 zo8bpeW1PWgnH95jzZbVpog3ToXrIRm4rSQcRCCJSiNiEd32qQ9OPT7pxJThdiMZ/Hou
 jmZ6gpbrRyF60+ww82FSa1grONTvuIj1Ss4Scle5/W/mUGwQhHahk7TlhnYi+XMt/xnb
 XrQR8/hviCQtISoOaV7pWQpjA1W4CFCYbHlyRBrWsSxvHp/Sp7xaMm9LMojNrg5QQQjT
 yyKg==
X-Gm-Message-State: AOJu0Yyuf5bVc8UycXERiCPsVmFEi3NWmRnGkNnFZCGU9XzNlOuZrHaY
 +2IYFAWLtvCWIkuRwfAW6Z9CU2UwX0+BRb6mZcIewveRON2ROngplMKT6+p7LA3SluNqaDPuk8E
 9
X-Gm-Gg: ASbGncvEQKkaVcUbKLNAg2p03RQX3T8rYDgE6Hk30HcjLESZqi3MOam0XUsXJUWb3YU
 FYfi3TrGrG2jnXc/sZjPsvQwVKwQqpNQlCtwK0sQKZ6OcBl8yBOWgzzOkoMuGRYaaQXHclnF4S3
 yu81R/ixWd2JxJegnAf+aj5CX1ZDElN29p1GAt38lUJntQ1BKyMfBMou+15xBjzuCsTym3vYfwZ
 3u3w1P9uMLl4JQ1LswaaEMYAfIUjy9GxzsldavoqmLIdhJEaTmQF7hIYEf8qAJeiwHvcnkftUYx
 4j2+t7xz2NFjvVSFQZjekNeOcKjuV7yIgWlqLHyYYy+2V6IXwGOVbVpE8MBMGbIaeqbH
X-Google-Smtp-Source: AGHT+IFxBxaK3OgSLzkAVZouLMp6NKi7att6GMHVO6jSsSus9Sob+Cjr4MIZ4z2HVarBlyw/lvvSrw==
X-Received: by 2002:a17:902:e744:b0:21b:b3c9:38ff with SMTP id
 d9443c01a7336-2217119d40fmr121405475ad.37.1740070621527; 
 Thu, 20 Feb 2025 08:57:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/14] Remove unnecessary function pointer deref
Date: Thu, 20 Feb 2025 08:55:14 -0800
Message-ID: <20250220165644.16421-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217185743.169778-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
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

A common pattern in DPDK internals is to have an array of function
pointers. When using these pointers an unnecessary derefence is done;
this is allowed in C because of a historical quirk but unnecessary.

This fixes all instances of PVS Studio checker warning:
 https://pvs-studio.com/en/docs/warnings/v516/

This leads to a large number of warnings marked as High severity.
This patchset simplifies the source and gets rid of these warnings.

v3 - remove unnecessary paren in ethdev ip_reassembly capability

Stephen Hemminger (14):
  ethdev: remove unnecessary deref on function pointers
  eventdev: remover unnecessary deref on function pointers
  net/bonding: remove unnecessary deref of function pointers
  net/ixgbe: remove unnecessary dereference
  net/ipn3ke: remove unnecessary dereference
  net/memif: remove unnecessary deref of function pointers
  cryptodev: remove unnecessary deref of function pointers
  crypto/scheduler: remove unnecessary dereference
  compressdev: remove unnecessary deref of function pointers
  dmadev: remove unnecessary deref of function pointers
  rawdev: remove unnecessary deref of function pointers
  mldev: remove unnecessary deref of function pointers
  regexdev: remove unnecessary deref of function pointers
  security: remove unnecessary dereference

 .../scheduler/rte_cryptodev_scheduler.c       |   8 +-
 drivers/crypto/scheduler/scheduler_pmd_ops.c  |  25 +-
 drivers/net/bonding/rte_eth_bond_pmd.c        |  12 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.c      |  27 +-
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c       |   5 +-
 drivers/net/memif/rte_eth_memif.c             |   6 +-
 lib/compressdev/rte_compressdev.c             |  56 +-
 lib/cryptodev/rte_cryptodev.c                 |  72 ++-
 lib/dmadev/rte_dmadev.c                       |  38 +-
 lib/ethdev/ethdev_driver.c                    |  16 +-
 lib/ethdev/ethdev_private.c                   |   4 +-
 lib/ethdev/rte_ethdev.c                       | 494 ++++++++----------
 lib/ethdev/rte_ethdev.h                       |  12 +-
 lib/ethdev/rte_ethdev_cman.c                  |   8 +-
 lib/eventdev/rte_event_crypto_adapter.c       |  37 +-
 lib/eventdev/rte_event_dma_adapter.c          |  16 +-
 lib/eventdev/rte_event_eth_rx_adapter.c       |  50 +-
 lib/eventdev/rte_eventdev.c                   | 164 +++---
 lib/mldev/rte_mldev.c                         |  88 ++--
 lib/rawdev/rte_rawdev.c                       |  99 ++--
 lib/regexdev/rte_regexdev.c                   |  72 +--
 lib/security/rte_security.c                   |   5 +-
 22 files changed, 613 insertions(+), 701 deletions(-)

-- 
2.47.2

