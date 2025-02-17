Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD670C021A9
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Feb 2025 18:57:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0CE640151;
	Mon, 17 Feb 2025 19:57:56 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id C0E2340151
 for <dev@dpdk.org>; Mon, 17 Feb 2025 19:57:55 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-220c2a87378so64023735ad.1
 for <dev@dpdk.org>; Mon, 17 Feb 2025 10:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739818675;
 x=1740423475; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gg7AZjZD//2/Jk6kIBuPH+IOhLPr5ZreeMzJj+Yl/cE=;
 b=HGvPgdTCUAhPTzXRQbxbA4wqwsNN28U3tJ3ZqMYkuv+tHMKXSO1E0Vi/l5zG7aSdXk
 rJa3p+qT/i982XuVRvLaVzpC3rzRyuUNtZbZKtMxLDMlfBEpY+MD2LwnDLyl7gO1saO/
 We4d0i0TwThiT7KAuPgpzJosE1SjHKiW/QGqzX9VsotgWWnWzxIvGHfdXVauqkP0mqx7
 vlCgQu5EKaxav0XTmPmZlH7MJHnkXY8oj20pel92JBkIzd6v9wks/WM6cw+FS8DhIv+A
 SBxQQ//ewZs1rD/SQXCNUb1Ns7c/AmbtaJZPxigJ8qeEOYXsahO0Q6dEkGU22ZyCPm80
 W65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739818675; x=1740423475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gg7AZjZD//2/Jk6kIBuPH+IOhLPr5ZreeMzJj+Yl/cE=;
 b=L+Mk6ev85DxJ7y0u3mSqCPyZjqaVJshpmERMhL1nX4/TF3a2b3Hz/voiav9i8i6Z+6
 HT9ickBVnwFXrhxIXuVNjP8b8oXaU3JHdKVQEP4O+ac2AN1+4PJhbH4I3soslA2I8wiN
 VtPJ9cc5AD31/cGcQU/OuFUG9fspGtmBxWBBR6RZqpNXOitmQt86j5iXmHRcK9j+bxIU
 DiOMNZrzZUpbG4xFfKTCeQrkU0u8SkZPS1xPj6VItlW0TQ1AeKKsDss7CiybMNvv2F0G
 y8D3SP74LD6moi161Q7nk5bCdcqvBPz7p7rVpVJNMRfQ2M6RtyXTyxxuEFaUz5dw9Sin
 kCtA==
X-Gm-Message-State: AOJu0Yx0p2qSIxq+9VwgjVZKo2Xuzv6KAGKbm1/2QRZZ6c09OLmOEubM
 HtTSK8tLKNSk5VahDJ+fYv0bdntiXDaSQPO7Wkwz4LsSrz8jJZX5NOmvcWd/4gq66A99UngeZyu
 Dyfw=
X-Gm-Gg: ASbGncsU8sv58s+bY9f8qJP2rymv3orOTpc43u9OAfjD+Nk/9HIi+9/N276qEAViDCO
 P2rTW5DJKFK+mPCiU7hdQ1jFZpbTbVboEFuC8wN91ukEQF/sZOFoSHfDKyyvAzkCSc4hPSFVsOL
 G+L459rYT96iNGITTK53iRjhb0K1sq4XjsgOeYBsxuLx2xm6MKZpDe4U6fo4nOf1FwpI8mTueo+
 owp+CfO9CBCEFp85u6Gor6tlpRXBgrdVuSU5Lo1/C1/HW4xEYljWygFu5QAP1ZdPjAoCURKITCE
 Ri2x//H/+peUFncJNYkPBBJdeeR+erZH/F+eHBvPmFmWap5qKQ2kMhieHLTmmmWhcrqo
X-Google-Smtp-Source: AGHT+IHRfUTyCMao1icv7Sry+tXF80UmUiHLpb7Gf+p5AiwCppIJgCnOsGav6JcQXsi7/yoUAU7sAg==
X-Received: by 2002:a05:6a21:7803:b0:1ee:afa2:4e86 with SMTP id
 adf61e73a8af0-1eeafa251cdmr7264766637.28.1739818673465; 
 Mon, 17 Feb 2025 10:57:53 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5dc68sm7815149a12.9.2025.02.17.10.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:57:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 00/11] Fix dev_ops dereferences
Date: Mon, 17 Feb 2025 10:53:59 -0800
Message-ID: <20250217185743.169778-1-stephen@networkplumber.org>
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

A common pattern in DPDK internals is to have an array of function
pointers. When using these pointers an unnecessary derefence is done;
this is allowed in C because of a historical quirk but unnecessary.

The PVS Studio checker flags these as:
 https://pvs-studio.com/en/docs/warnings/v516/

This leads to a large number of warnings marked as High severity.
This patchset simplifies the source and gets rid of these warnings.

It should have no impact on the resulting binary.


Stephen Hemminger (11):
  ethdev: remove unnecessary deref on function pointers
  eventdev: remover unnecessary deref on function pointers
  net/ixgbe: remove unnecessary dereference
  net/memif: remove unnecessary deref of function pointers
  cryptodev: remove unnecessary deref of function pointers
  crypto/scheduler: remove unnecessary dereference
  compressdev: remove unnecessary deref of function pointers
  dmadev: remove unnecessary deref of function pointers
  rawdev: remove unnecessary deref of function pointers
  mldev: remove unnecessary deref of function pointers
  regexdev: remove unnecessary deref of function pointers

 drivers/crypto/scheduler/scheduler_pmd_ops.c |   5 +-
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c      |   5 +-
 drivers/net/memif/rte_eth_memif.c            |   6 +-
 lib/compressdev/rte_compressdev.c            |  56 +--
 lib/cryptodev/rte_cryptodev.c                |  72 ++-
 lib/dmadev/rte_dmadev.c                      |  38 +-
 lib/ethdev/ethdev_driver.c                   |  16 +-
 lib/ethdev/ethdev_private.c                  |   4 +-
 lib/ethdev/rte_ethdev.c                      | 489 +++++++++----------
 lib/ethdev/rte_ethdev_cman.c                 |   8 +-
 lib/eventdev/rte_event_crypto_adapter.c      |  36 +-
 lib/eventdev/rte_event_dma_adapter.c         |  16 +-
 lib/eventdev/rte_event_eth_rx_adapter.c      |  50 +-
 lib/eventdev/rte_eventdev.c                  | 164 +++----
 lib/mldev/rte_mldev.c                        |  88 ++--
 lib/rawdev/rte_rawdev.c                      |  99 ++--
 lib/regexdev/rte_regexdev.c                  |  72 +--
 17 files changed, 575 insertions(+), 649 deletions(-)

-- 
2.47.2

