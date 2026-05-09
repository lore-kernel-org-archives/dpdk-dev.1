Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627E7CD3445
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 17:07:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CAC840269;
	Sat,  9 May 2026 19:07:26 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 73A0040151
 for <dev@dpdk.org>; Sat,  9 May 2026 19:07:24 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12c19d23b19so5220163c88.0
 for <dev@dpdk.org>; Sat, 09 May 2026 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778346443;
 x=1778951243; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfulkF19we67JkmwiAM+fMvhn6EZizcmXkMg2TJHCKU=;
 b=ie5jDYtqu9y4iwFAZMcS9FM5aJdKMBoMylxnsvdZXPg3A+z/rFfQ3ePORS+GGMaqVN
 bsaE/ODKb/sUlNFdY75FdQszXSwV9Rj0d6ojxlMGhN8CyXhon1AqT5SFRU0bAUvgWhk4
 eELitWA7h8Q522A3LRmkC+qQ7+GIcE+g7lEtmJ92zZVcQ13qhpT64KUGjyg//sV+mVk8
 KTkT7d7xUpeUDscc7zG8cva7QqBLc+z9ECSrfpexOy+CcjefH4lQuE/IFgJE3WePa5vg
 hB/H/YqenV9vKdLYvQnGXObv9kl1Xy/M3BxMfnI9bZrpgHGztXF9nEluZGGXC991izsR
 Pd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778346443; x=1778951243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SfulkF19we67JkmwiAM+fMvhn6EZizcmXkMg2TJHCKU=;
 b=UT9rGO5mWLNJm/b0koL29RDYruKkzdVRa9qRPe2/sP40yVe/pJyZ3qz4e0kysL6eXA
 jpWqob60uo0YmQNuChvIOyK7CpWSP4HVW6rQOIBiw8qPGiXswF3ll8TCKlf031lJO7gB
 mZFqOjywIQKxjSaHtC6UkQs99S5t8bOxQT9Y3qs/upb48fZqGXUN+DHDDWkG52CgSz+S
 34eCMEjlYl6v03+K1mBI5zDj9dkM5KYK/OcF/jYxDPkk9wNTi7vd8WvAQvRImh2qNJs/
 305qGRx9athMF8hNZyNfLGDvA1077HXtEZX2b+bYLCYYTHG8fW6Diacb5r2bZyKGz6Cr
 64AA==
X-Gm-Message-State: AOJu0YyTRGfnJttaNgCotXK5/d5ELnzouq3tIFFPGVA5gNz2LDlNoTNr
 saHaQLGit8VvFuLf7dLZnnu7nkk++kSS/2MFDWA+dEzG3ZYY9csZkA9BeiHLvy88ZjM4Y1MudmL
 dSqek
X-Gm-Gg: Acq92OFtA40mxQpwAGFPOFypwouy68AukDKNktsAu0Wn0HkKDkTToPWddWkCOfeqXwM
 nmodPcYY1QFq2L7oA8ve+cFIHlpA1h8xsv1B4BvJCwnIRuE9AYWHAIffin9vWkQpMHvhTJlugHS
 v+I8OHI8sitkCJ08Y+GaBtCEF1sPmm2t3eFMEAW1p4h/CNBkWCx6jHqKenhESik9K2HscamlvqZ
 Lx1o6kdxwzW05ejdMJlgXyZjb5iaWffh55tw2yTQ7pNi8UQQ4tK9eZiTANoUKa5TmWl92hucv0i
 IlQtnfmYFwz392g/jfMEQFeS+xFyrCB7Geao7aQfOty+R8CXQxyGg9op0rQD2z7Kp9NtFxMdjEe
 tjpmy4lrm6JDjzCitDXd1tnxC8y6IbCuqZk/nQbKooi/q+ITMt/m0FJzwD9WmVNqlI2Jl2z8EIL
 DwfuuajgzAvayr4d+O0KFGETtR/bY+fbwyGTc=
X-Received: by 2002:a05:7022:f417:b0:12c:4931:c2c1 with SMTP id
 a92af1059eb24-1319cc24ff4mr8533749c88.17.1778346443173; 
 Sat, 09 May 2026 10:07:23 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-132781103e7sm8544463c88.1.2026.05.09.10.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 10:07:22 -0700 (PDT)
Date: Sat, 9 May 2026 10:07:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 00/20] Wangxun Fixes
Message-ID: <20260509100720.15b37bfb@phoenix.local>
In-Reply-To: <20260509112823.7728-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260509112823.7728-1-zaiyuwang@trustnetic.com>
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

On Sat,  9 May 2026 19:28:02 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series fixes several issues found on Wangxun Emerald, Sapphire and
> Amber-lite NICs, with a focus on link-related problems.
> ---
> v3:
> - Addressed Stephen's comments
> ---
> v2:
> - Fixed compilation error and code style issues
> ---
> 
> Zaiyu Wang (20):
>   net/txgbe: remove duplicate xstats counters
>   net/ngbe: remove duplicate xstats counters
>   net/ngbe: add missing CDR config for YT PHY
>   net/ngbe: fix VF promiscuous and allmulticast
>   net/txgbe: fix inaccuracy in TX rate limiting
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
>   net/txgbe: fix get eeprom operation
>   net/txgbe: fix to reset Tx write-back pointer
>   net/txgbe: fix to enable Tx desc check
> 
>  drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
>  drivers/net/ngbe/ngbe_ethdev.c            |    5 -
>  drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
>  drivers/net/txgbe/base/meson.build        |    2 +
>  drivers/net/txgbe/base/txgbe.h            |    2 +
>  drivers/net/txgbe/base/txgbe_aml.c        |  187 +-
>  drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
>  drivers/net/txgbe/base/txgbe_aml40.c      |  113 +-
>  drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
>  drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
>  drivers/net/txgbe/base/txgbe_e56.c        | 3774 +++++++++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56.h        | 1744 ++++++++++
>  drivers/net/txgbe/base/txgbe_e56_bp.c     | 2593 ++++++++++++++
>  drivers/net/txgbe/base/txgbe_e56_bp.h     |  278 ++
>  drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
>  drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
>  drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
>  drivers/net/txgbe/base/txgbe_phy.c        |  360 +-
>  drivers/net/txgbe/base/txgbe_phy.h        |   45 +-
>  drivers/net/txgbe/base/txgbe_regs.h       |   11 +-
>  drivers/net/txgbe/base/txgbe_type.h       |   43 +-
>  drivers/net/txgbe/txgbe_ethdev.c          |  414 ++-
>  drivers/net/txgbe/txgbe_ethdev.h          |    6 +-
>  drivers/net/txgbe/txgbe_rxtx.c            |  102 +-
>  drivers/net/txgbe/txgbe_rxtx.h            |    1 +
>  drivers/net/txgbe/txgbe_rxtx_vec_common.h |   14 +-
>  26 files changed, 9350 insertions(+), 434 deletions(-)
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
>  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h
> 

New files missing SPDX headers must fix.
