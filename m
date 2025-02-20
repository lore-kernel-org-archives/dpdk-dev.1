Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F76C021B0
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:35:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42B7B4014F;
	Thu, 20 Feb 2025 03:35:21 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id B2DF740041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:20 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2211acda7f6so7565165ad.3
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018920;
 x=1740623720; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2kxMVvLybSA1jYMRytHzWM2czK6BKwxQa3bboFKWdo=;
 b=lCdr6KhnPflQipbbLRX5iPpZkcs5/R8jWk99tiOCaSMMXPGWglUUuEq/d51jXHBzqo
 N0TdpGKhw/28/HU/Dg+JZ4aGDgkzVWGfNOozKyu5HItXgSvpOj/MNHM4DsQKZeiuEHPJ
 d1mDGvO+8/wtsxtjECicdCQWkLAY+RYkVMRu/8ot6N/x7PcHOSVZc0H0jw1S/c8hJGlA
 8SLHZ9OEq3AIHAQNugzSfvaShCxfR29hv2QFOQPUJ51Ccrx3ajcL7vdBL+tPm44sOXCw
 3YtFBbOsnvchYGesXAZaTZgz5gxkgPaatUt1jCoZZvkLeo4vbk3RO1funwDzZp1lFfh/
 RN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018920; x=1740623720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2kxMVvLybSA1jYMRytHzWM2czK6BKwxQa3bboFKWdo=;
 b=avaBRHUAAQ4V88PzRUmlptkReytQr9Wel2vGW148AkBO5NH3ndaw9ly4Y0+K9JeYiV
 gLn6B5SXtfaSRZv1leuK6SRE6pjrZ0FGr9RtVnS44RmZkkPpxsM6akx7W+rFqw8HWzBZ
 SWwhGK0L3cl6ufwmA2/AIU7PWmXYHjvgMq1RgQLZxJadQqEAEXBqZ3bPMPBWLuYYG/If
 YBHWNmFtYa68YNcEyIieBBt/sb0OXMhZI3nd+Ns612ZN+GFcqYUX8YfRIftMD8mr65kw
 53IcoXUe/SM6Sikd55ONfEu0MnpC1gy8Th8OWFGcYvmqLS5YVfCP+3lMMQ1w8wxj0otr
 1AfA==
X-Gm-Message-State: AOJu0YzGaDkUQc4HzqGbdcGyz7+EE5AA8YJcuNmwOFOUffyppvwHOll6
 k4zqm4iPtjqlA2yf0dBBxVdNmhM7s/lMEnNctz2ZlQe1441Ni797v6//6DW2+fmfhegfHxnsulg
 dAgk=
X-Gm-Gg: ASbGncu9bT7HDKOUQ0MIfE1p3AFERRvtjuS22c9ME0u3ScbQhFU+S+kYMDmO2KRjD8e
 iBmhVFCxUmXv9LyKhuulF2ypsZ0DLEzMS/U37yp/C8gCUSe6SK7/UXEdRKDMGIIUKvOK+mTcbFp
 b0Orw69O7AgyLFwdyYf0SGUeqNFB+zVij4IpivADzE/1SB0/y9WUfhZidadm1u0+Dfo8hZvrl3Z
 x1oxNaaDXdHv+jd7p4Uh/stUmEIR7PPfpLjU5NNdov9dY33pqubrolbcY39tRnQflAkNNiJOKA7
 hHjkpHbOfazC3FXzO/tDfI4b4Zactl1RB2cMmoGLoryaSWMDCgv1kn9ZXNHdT7iK0peC
X-Google-Smtp-Source: AGHT+IGokoyDXhho3QbiqNhTDYJA66m2K7id7UhLnqtKkgiHr6jaYEpxWSTIDAd0PEjTtGVSww7Gjw==
X-Received: by 2002:a17:902:f547:b0:216:282d:c69b with SMTP id
 d9443c01a7336-221711c80eemr100369095ad.50.1740018919750; 
 Wed, 19 Feb 2025 18:35:19 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 00/14] Remove unnecessary function pointer deref
Date: Wed, 19 Feb 2025 18:32:04 -0800
Message-ID: <20250220023509.630569-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217185743.169778-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
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

This fixes all instances of PVS Studio checker warning:
 https://pvs-studio.com/en/docs/warnings/v516/

This leads to a large number of warnings marked as High severity.
This patchset simplifies the source and gets rid of these warnings.

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
 lib/ethdev/rte_ethdev.c                       | 492 ++++++++----------
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
 22 files changed, 612 insertions(+), 700 deletions(-)

-- 
2.47.2

