Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA725C369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 16:11:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED7AA402E7;
	Wed, 16 Apr 2025 18:11:18 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id DE4814025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 18:11:17 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so892885b3a.0
 for <dev@dpdk.org>; Wed, 16 Apr 2025 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744819877;
 x=1745424677; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6yKSJ2H+1CSeqPep2yVGxVKqXOjWmIP4zA8rgBiDKc=;
 b=wEwOvS9EcUagn5GHTtmHyz7mp8hspi0xrB6lTXrH0aVez3Ve/MWbbMX6Mv3DmBJK7B
 s3ZlRObF4BHv81uw3aKM8wz8kExsi3OQ2x65nP3VM71EQr8rIbJ9TxuqLvD1uhIazAdX
 d6jOn6HeeWPne89ws5EF7/VOvXP2TBi8opkkGwbb1Wjb74MdlsZvGG0Hp2TUi9T5jJy4
 gJA+Q9y21/uCsqb7LBxTG+Y4W9e71QkqlcmVsmKdD3yqkDf0UN5La3+qUa94eHYYSbQz
 Ccy2Xk4oKO838OmPli4Nkmir7Q/qzJkFRxS/uq0ByfYQHObI4urpu2SD18FXnuvR8g/I
 0yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744819877; x=1745424677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6yKSJ2H+1CSeqPep2yVGxVKqXOjWmIP4zA8rgBiDKc=;
 b=k2qA2MW44s24LLgt5V5jIRKokJ+5RI0ZEfI41i01MU0RrOtuJgVPWR66HOmAti3Ywj
 Zud54ZpAS2CWay7yt1uCywhLwrAxjTSIMR5KJuHYPbWSJRB39MgRinMQPhf37DnTnAbx
 MbRhx3tmK3j9364z9cC3aPG1ql44yZeioJVDp6ATB/bk6gAcgUE6ahvI0OsdChAViI5K
 kEPoxwXqR34mKYybgG93Gl4/RdxBdV7XXzfsgIVod0flJ59ltaBPYSez5O26ZDdI4T45
 6yJ3uz11vbDz1IDUrb9t89vGe3PlKjAqwcAQJFQ6rJlkUqBbfvKSONn0ilCYBWj3AHMP
 d6LA==
X-Gm-Message-State: AOJu0YyVrzKNRaQCUBIq25IdYn/J20cN10Liz0vY5TxHMkntfziydj0M
 ZbkGmEC5i7W0JKnz+MUU11WqPReyDHUVFYL5k1SPLiI+ha1MZVWcl0tDuGSUyT93C3Utoq/IruP
 emwc=
X-Gm-Gg: ASbGncvEy+e3I5dt1bHJR0TptikAvHSrT4zYnxlNi8VRtXwWwU0snUDcPlM3X2ph4kE
 7bk+WCZxOWzg2iE1IuOIz+nj9C3YIlrJzNAyED9oBaNX61phjw++wgEXi6BKiy33SmNQnkSYlKC
 K4+52yxmA8BweDmoS8gwnJvmvUf0wMTpbOSwTly4tHy1wVJUFR+ir0Yml8EhynsNhdScaRfrsjz
 uNE6yocJCIZYbbdlh5EkBlZtaUo5tfvoiIHz5z0hgPjZItTz/7TX21dJwaj9iDX7dzQ3DPkf1N3
 V812urpQZJgy9pMhXbPf96zbcgKiqm2XahMPdTaL9NMR1TR8fCmOGXOeyLTSXbhMEehan7XcoCK
 4FU0/9o3lAGrzhXB8
X-Google-Smtp-Source: AGHT+IE0eZw5jh28hOpSqLCVKtEgicYfUpl5CLUZx+vABO4hPf34Q98WqzKpRnISkSiFuvMwT3KCVg==
X-Received: by 2002:a17:90b:5150:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-3086d989d5cmr154930a91.3.1744819876704; 
 Wed, 16 Apr 2025 09:11:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-308611f3f31sm1803612a91.16.2025.04.16.09.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 09:11:16 -0700 (PDT)
Date: Wed, 16 Apr 2025 08:27:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liwencheng <liwencheng@phytium.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 0/3] net/macb: updated net macb driver.
Message-ID: <20250416082742.0d99c75c@hermes.local>
In-Reply-To: <1744093147-313646-1-git-send-email-liwencheng@phytium.com.cn>
References: <1744093147-313646-1-git-send-email-liwencheng@phytium.com.cn>
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

On Tue,  8 Apr 2025 06:19:07 +0000
liwencheng <liwencheng@phytium.com.cn> wrote:

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
> 
> Wencheng Li (3):
>   net/macb: add new poll mode driver
>   net/macb: add NEON vectorized Rx/Tx
>   net/macb: add necessary docs and update related files
> 
>  .mailmap                               |    1 +
>  MAINTAINERS                            |    6 +
>  doc/guides/nics/features/macb.ini      |   27 +
>  doc/guides/nics/index.rst              |    1 +
>  doc/guides/nics/macb.rst               |   26 +
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
>  24 files changed, 7494 insertions(+)
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

When using Developer's Certificate of Origin, it is important to use
you legal name rather just the mail alias. If you send a follow up
use:
    Signed-off-by: Wencheng Li <liwencheng@phytium.com.cn>

not:
    Signed-off-by: liwencheng <liwencheng@phytium.com.cn>

That is what is causing some check-git-log.sh warnings.
