Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAA7C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 14:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F28B402E0;
	Tue, 27 May 2025 16:27:37 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 296644028D
 for <dev@dpdk.org>; Tue, 27 May 2025 16:27:36 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-442ed8a275fso46545195e9.2
 for <dev@dpdk.org>; Tue, 27 May 2025 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1748356056;
 x=1748960856; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oZyQDk7sJ22N2k1U6fe8D3tmNw9xJjRx3KnCCXj9y0=;
 b=l+tGGj6ioi/hTbbXvZYSpZAAmAR+1hdI3ug0ykpfWnyluANEf4cUVrL9Z5AtcBmcVa
 JBztbiuRbXb0oXrpwn6URlQvO3UNcas4zEZTBB/HDmxr6+8GfzJWdSp49PxoHQKRzXyF
 JfiI3yPNoWFIWeaWHzi1S+3pHOTxzCV1edhN9tlrlqCkwtF3JoMcWuZg4j0yJ2nbUmOZ
 ess3NISM/yW2RbGoFC+GNQG/mGJ0iw5J8YDK7pwuTOyQioHnR6h23vUmZ+ejzFVff1W3
 uAcKxTFRpfszargQbjyhnF7wiitVoVbCk/DZdfU2993hhhE2SzNHSvU9G6te0xJ/LACY
 ncTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748356056; x=1748960856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9oZyQDk7sJ22N2k1U6fe8D3tmNw9xJjRx3KnCCXj9y0=;
 b=NJz8omweRwZCrNKFs/sujKD7B+sLCJg0XviELOYFRAKFlOVGbiCLeL5AAGhFgixKFR
 dPJf05BJLmEHBG1SpevyQNd+685o+wO8A9AFIus6FZaVNvqFsF451GirAjIlwUxLRh/L
 FMUHvxkaj81WIdbxH76HvcPSgjkgvoKn5ZyMy7Y/UVJjPGc/C3niSpRaau1k9BSEeHNR
 46LBWCSpPTltmVWP7X6T8YVbE0reeBgtn5Zc7IicUCWcR2XIalntuUO9+oNfCLZV8XwS
 QC7pueP2Yyn8ksSvUf5OShy3KS64/yxueACaJY0lIzbv8bNd//97MH/A2QKfvl2XtQep
 i+rQ==
X-Gm-Message-State: AOJu0YxURtcfj1APLu66m0xKBxRgTxY171iX8wVW3xdviZ5xTctNd784
 XjVnKiXmJASOQYJR0YxDcR5eLrETMPRjyH0sCQq550XDhYaeWd5JQMfeJB8CGqmxno38cjyx8+6
 sOiw1PvU=
X-Gm-Gg: ASbGncv54N/Nk5lc5/SIc9EEJ4G2l7ZCxNkCVsAuSER1itq0W3cw7j6UXTH01Pgbr8I
 BNybh1ER/bxc5fFZ2uxPV/Sz+U6NM1BGvYjGqhLtnS+KWjIGDFj5lIbX5oRTWJuQ/Bt6sGw2X9M
 fHnah59BxrQxMqlgreP/aaoaxHviFcyX07Mqy5nBABGScLwlgmA8ivKnO46TVwSMG12hWySHGMs
 ovsdaX51jYLKYPUrj1Gz9jb+eLDwZMnXFhonVAvLBdpa0/Pu5ij56+aBjEMnIhguI/9tCrTktO3
 hm64h/5IfZ0s89DzZsSoMJZblxtsoVaigMm627Bw5s4O6Bx1tQSCI7YSs0jA2AExVib+yLEx68l
 s9oyCEFCqZlR24B8qB3yJ0c6GHKHb
X-Google-Smtp-Source: AGHT+IEq7mlpM+5Nja1wZXtn0nQC4OSRpx9n51Q3EiH1mQzVhN2RX8i66Sx+RI0EnHtUx9qQYlmbmA==
X-Received: by 2002:a05:600c:4e0c:b0:442:faa3:fadb with SMTP id
 5b1f17b1804b1-44c917f3ea8mr138017935e9.2.1748356055303; 
 Tue, 27 May 2025 07:27:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b29548sm285152185e9.4.2025.05.27.07.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 07:27:35 -0700 (PDT)
Date: Tue, 27 May 2025 07:27:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wencheng Li <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 0/3] net/macb: updated net macb driver
Message-ID: <20250527072729.5e96c551@hermes.local>
In-Reply-To: <1744946674-31765-1-git-send-email-liwencheng@phytium.com.cn>
References: <1744093147-313646-1-git-send-email-liwencheng@phytium.com.cn>
 <1744946674-31765-1-git-send-email-liwencheng@phytium.com.cn>
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

On Fri, 18 Apr 2025 03:24:34 +0000
Wencheng Li <liwencheng@phytium.com.cn> wrote:

> v7:
> - Use a legal name instead of an email alias.
> - Do not use additional __rte_cold.
> - Replace unsigned long with standard uint64_t.
> - Describe the devargs used by the driver in the documentation.
> - Update macb.ini.
> 
> v6:
> - Fixed build failures across different OS.
> 
> v5:
> - Putting __rte_unused after the declaration.
> - Correct RX-bytes and TX-bytes statistics.
> - Initialize the mbuf_initializer.
> - Add driver based on 25.07.
> - Fixed some code style issues.
> 
> v4:
> - Fix tab errors in meson.build file.
> - Use RTE_LOG_LINE instead of rte_log.
> - Replace %l with %PRI*64.
> - Replace rte_smp_[r/w]mb with rte_[r/w]mb.
> - Do not use variadic arguments in macros.
> - Do not use variable-length array pkts[nb_bufs].
> - Use __rte_cache_aligned only for struct or union types alignment.
> - Support hardware Rx/Tx checksum offload.
> - Fixed some code style issues.
> v3:
> - Changed functions that always return 0 and whose return value
> is unused to void type, improving code simplicity and readability.
> - Fixed the implicit conversion issues in the
> macb_usxgmii_pcs_check_for_link and
> macb_usxgmii_pcs_check_for_link functions.
> - Added the missing SPDX license tags.
> - Added the missing mailmap entry.
> - Updated the MAINTAINERS file to include the missing information.
> 
> v2:
> - Split the driver into three logically independent patches,
> rather than one large patch.
> - Added conditional compilation to address the issue of
> macb_rxtx_vec_neon.c failing to compile in certain modes.
> - Fixed some code style issues.
> 
> v1:
> - updated net macb driver.
> 
> *** BLURB HERE ***

This part is supposed to be removed when sending the commit message.

> 
> Wencheng Li (3):
>   net/macb: add new poll mode driver
>   net/macb: add NEON vectorized Rx/Tx
>   net/macb: add necessary docs and update related files
> 
>  .mailmap                               |    1 +
>  MAINTAINERS                            |    6 +
>  doc/guides/nics/features/macb.ini      |   19 +
>  doc/guides/nics/index.rst              |    1 +
>  doc/guides/nics/macb.rst               |  180 +++
>  doc/guides/rel_notes/release_25_07.rst |    4 +
>  drivers/net/macb/base/generic_phy.c    |  271 +++++
>  drivers/net/macb/base/generic_phy.h    |  202 ++++
>  drivers/net/macb/base/macb_common.c    |  670 ++++++++++++
>  drivers/net/macb/base/macb_common.h    |  253 +++++
>  drivers/net/macb/base/macb_errno.h     |   58 +
>  drivers/net/macb/base/macb_hw.h        | 1138 +++++++++++++++++++
>  drivers/net/macb/base/macb_type.h      |   23 +
>  drivers/net/macb/base/macb_uio.c       |  351 ++++++
>  drivers/net/macb/base/macb_uio.h       |   50 +
>  drivers/net/macb/base/meson.build      |   25 +
>  drivers/net/macb/macb_ethdev.c         | 1861 ++++++++++++++++++++++++++++++++
>  drivers/net/macb/macb_ethdev.h         |   91 ++
>  drivers/net/macb/macb_log.h            |   19 +
>  drivers/net/macb/macb_rxtx.c           | 1394 ++++++++++++++++++++++++
>  drivers/net/macb/macb_rxtx.h           |  325 ++++++
>  drivers/net/macb/macb_rxtx_vec_neon.c  |  675 ++++++++++++
>  drivers/net/macb/meson.build           |   22 +
>  drivers/net/meson.build                |    1 +
>  24 files changed, 7640 insertions(+)
>  create mode 100644 doc/guides/nics/features/macb.ini
>  create mode 100644 doc/guides/nics/macb.rst
>  create mode 100644 drivers/net/macb/base/generic_phy.c
>  create mode 100644 drivers/net/macb/base/generic_phy.h
>  create mode 100644 drivers/net/macb/base/macb_common.c
>  create mode 100644 drivers/net/macb/base/macb_common.h
>  create mode 100644 drivers/net/macb/base/macb_errno.h
>  create mode 100644 drivers/net/macb/base/macb_hw.h
>  create mode 100644 drivers/net/macb/base/macb_type.h
>  create mode 100644 drivers/net/macb/base/macb_uio.c
>  create mode 100644 drivers/net/macb/base/macb_uio.h
>  create mode 100644 drivers/net/macb/base/meson.build
>  create mode 100644 drivers/net/macb/macb_ethdev.c
>  create mode 100644 drivers/net/macb/macb_ethdev.h
>  create mode 100644 drivers/net/macb/macb_log.h
>  create mode 100644 drivers/net/macb/macb_rxtx.c
>  create mode 100644 drivers/net/macb/macb_rxtx.h
>  create mode 100644 drivers/net/macb/macb_rxtx_vec_neon.c
>  create mode 100644 drivers/net/macb/meson.build
> 

Noticed that this driver is resetting the log level values.
This doesn't follow pattern of other drivers.

 $ git grep rte_log_set_level
macb/macb_ethdev.c:     rte_log_set_level(macb_logtype, rte_log_get_global_level());
macb/macb_ethdev.c:             rte_log_set_level(macb_logtype, RTE_LOG_NOTICE);

Noticed that driver has option where it needs to link with external
phy library. That should be documented more; what is the library, how to get it etc.

You are using eth0, eth1, etc in the doc but not clear what relationship if any
is with kernel driver.

I would also leave out any non-driver specific options to test-pmd in macb.rst.
These might change in the future, and are not specific to this device.
The default test-pmd values for rxq, txq, rxd, txd should be good enough.

Since macb requires out of tree kernel module.
Where is source for kernel module, what is its license?
If it is not going to be submitted to kernel as GPLv2 then this needs discussion
and approval by Technical Board.

Out of tree kernel modules are a real negative. It is hard to write good, safe, and correct
kernel code for UIO. That is why DPDK abandoned igb_uio and kni. They were buggy,
hard to support and prone to failure.



