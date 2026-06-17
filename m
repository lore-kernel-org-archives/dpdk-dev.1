Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255E6CD98F2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 15:57:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4410140276;
	Wed, 17 Jun 2026 17:57:57 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 42B6040268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 17:57:56 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-137ec563a95so6872421c88.0
 for <dev@dpdk.org>; Wed, 17 Jun 2026 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781711875;
 x=1782316675; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40FMBoCXmSn5F5HmoKP0ssOHedj8ETiJtATXZmgmCZw=;
 b=JP66hKZV80sjGLWR/JttLmaTWxMu6UauwuUVKaNGPGUCLNXRVj0hNOkzV5hN8MJyEk
 U2911rx/VrT71L4NPE/wtWMEgbDUYcX/ISK4eDS6QjjN66muqkORPUOgIUkqSD5vUqvL
 7PdJyCSgoTHTmL4qS6MKucdTGrd093dtyIBj6LyPQNJaUFoTAx0+VygOGvpftnUS37Gz
 07ZZhJ6d5ScMaIrQiGXNkFVO1WmCLgsNyARCK5C0x5zkYsro6A6OzltAaHp8W//h8NF4
 PfrOPbauxn07ZTrMHAuZgIQmkzpB2pxMFMp/u7AGlZTCVTRC8ADMLbHnS6qzQWd36Pu6
 evvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781711875; x=1782316675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=40FMBoCXmSn5F5HmoKP0ssOHedj8ETiJtATXZmgmCZw=;
 b=AXs6qaSt5eVi+YNFuR+sOmKsZ1SAHA5zmZS7HYvnlpBTUinWrUWeU8A5rTZophX7b3
 XwuP/DQBGp6RlXwe2hZIk+MGbkEI9xcn/w8LWyeJ+Ll8D/4C8hCr6ggjYjumZu+isJvB
 CD3OLcR7COr4E2QqtMxArvkRVMf4nUO6j1zOY+iS3Jw4/RZOs4ZJ8+uiMaHssY0+qF1F
 KBu6pc/f0A7ijkUoEcR2c9Cv/IZ02jb+RYuvl7I4GikE2FoStd9u7Aa1SHblOELOAgn/
 oNcip7vlg+WX+lILQe001faL6zKZ37ngJTZnsteQft67782Hcl+zZnZ0mLPtXKY66XJM
 osBw==
X-Gm-Message-State: AOJu0YxdrQGsHfQOiOHMNr75T0svhRym19RiaHuUmk7taQq7OuP7NAnR
 9Mn7Np+ObX8P9EieHcm3jdA3Z6wk43HVtQW4wBuamHVHERtRf1n0onYteqFZE4H6+AqXGOIMqEs
 BfyOZ
X-Gm-Gg: AfdE7clULxfI9+kk6nzBC64roCCAonX6FdIr9yUzgFgJUVkzIXFrgGBxyeex2HFWnRH
 Ho1cRboHceWuN30QQ1xSpvi2+k5VpNFEKzQrfYsRtZ0lLTHbe4fN2wPrTjbupXoGwr2KRxkRbRg
 JOW7OXG921btgwCaH5w3XJBSKVcp0Y7UzC7Ln3c1xY/tfbOePbEtND++sx5jUt9j7ZtWO/du4c/
 MZBrXLEUwHbVqZMFsF480m5Qcg1EXUueTo5Mpw5JKSA2IKa3S2MctCcLaeKmpRpLen4Z8eC4WS9
 DRJaH+MgnzzkR8TcJ7C3/pEqoCmzuBSEq+b7+dvBY8k39o5eD6W5iZI25uzlbwgh5fHP7vmX6cE
 AMLl3EXHjQ3eHm/iC/y5iep8RmsgnHQJ7JODDsmxITwy7qveWqdFXxC0csNstWSLlwWRlC5/0Hu
 9DfavlkeqjkaPkPoAklzQZsdWKbmAynkYwhdQ7yxttvs67OephhzLIJQ==
X-Received: by 2002:a05:7300:7483:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-30bc9cd91f5mr2283328eec.2.1781711874868; 
 Wed, 17 Jun 2026 08:57:54 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95450sm29367199eec.28.2026.06.17.08.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:57:54 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:57:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 00/21] Wangxun Fixes
Message-ID: <20260617085751.10b6b4ba@phoenix.local>
In-Reply-To: <20260617081309.19124-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 17 Jun 2026 16:12:47 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series fixes several issues found on Wangxun Emerald, Sapphire and
> Amber-lite NICs, with a focus on link-related problems.
> ---
> v8:
> - Fixed compilation error by replacing RTE_ETH_DEV_TO_PCI with RTE_CLASS_TO_BUS_DEVICE
> ---
> v7:
> - Fixed inverted semantics of is_flat_mem to match SFF8636
> ---
> v6:
> - Fixed more issues identified by AI review
> ---
> v5:
> - Fixed issues identified by AI review
> ---
> v4:
> - Fixed issues identified by devtools scripts
> ---
> v3:
> - Addressed Stephen's comments
> ---
> v2:
> - Fixed compilation error and code style issues
> ---
> 
> Zaiyu Wang (21):
>   net/txgbe: remove duplicate xstats counters
>   net/ngbe: remove duplicate xstats counters
>   net/ngbe: add missing CDR config for YT PHY
>   net/ngbe: fix VF promiscuous and allmulticast
>   net/txgbe: fix inaccuracy in Tx rate limiting
>   net/txgbe: fix link status check condition
>   net/txgbe: fix Tx desc free logic
>   net/txgbe: fix link flow control registers for Amber-Lite
>   net/txgbe: fix link flow control config for Sapphire
>   net/txgbe: fix a mass of unknown interrupts
>   net/txgbe: fix traffic class priority configuration
>   net/txgbe: fix link stability for 25G NIC
>   net/txgbe: fix link stability for 40G NIC
>   net/txgbe: fix link stability for Amber-Lite backplane mode
>   net/txgbe: fix FEC mode configuration on 25G NIC
>   net/txgbe: fix SFP module identification
>   net/txgbe: fix get module info operation
>   net/txgbe: fix get EEPROM operation
>   net/txgbe: fix to reset Tx write-back pointer
>   net/txgbe: fix to enable Tx desc check
>   net/txgbe: fix temperature track for AML NIC
> 
>  drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
>  drivers/net/ngbe/ngbe_ethdev.c            |    5 -
>  drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
>  drivers/net/txgbe/base/meson.build        |    2 +
>  drivers/net/txgbe/base/txgbe.h            |    2 +
>  drivers/net/txgbe/base/txgbe_aml.c        |  185 +-
>  drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
>  drivers/net/txgbe/base/txgbe_aml40.c      |  114 +-
>  drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
>  drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
>  drivers/net/txgbe/base/txgbe_e56.c        | 3773 +++++++++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56.h        | 1753 ++++++++++
>  drivers/net/txgbe/base/txgbe_e56_bp.c     | 2597 ++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56_bp.h     |  282 ++
>  drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
>  drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
>  drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
>  drivers/net/txgbe/base/txgbe_phy.c        |  362 +-
>  drivers/net/txgbe/base/txgbe_phy.h        |   46 +-
>  drivers/net/txgbe/base/txgbe_regs.h       |   13 +-
>  drivers/net/txgbe/base/txgbe_type.h       |   43 +-
>  drivers/net/txgbe/txgbe_ethdev.c          |  472 ++-
>  drivers/net/txgbe/txgbe_ethdev.h          |    7 +-
>  drivers/net/txgbe/txgbe_rxtx.c            |  109 +-
>  drivers/net/txgbe/txgbe_rxtx.h            |   36 +
>  drivers/net/txgbe/txgbe_rxtx_vec_common.h |   17 +-
>  26 files changed, 9464 insertions(+), 444 deletions(-)
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h
> 


Please fix several checkpatch errors  and resubmit.

Although this is a false positive:
WARNING:TYPO_SPELLING: 'tread' may be misspelled - perhaps 'thread'?
#2647: FILE: drivers/net/txgbe/base/txgbe_e56_bp.c:2303:
+	BP_LOG("\tread 7001b data %0x\n", rd32_epcs(hw, 0x7001b));

It is still a bad idea to put control characters like tab in the log.
The log is often going via syslog/journal on production systems and
tabs don't do what you expect there.
