Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F5CD98D2
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 21:42:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0868402E3;
	Tue, 16 Jun 2026 23:42:23 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 7A18140289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 23:42:22 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30bc806fcf8so530910eec.1
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781646141;
 x=1782250941; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHO0vJnL6+rsRhVwiBIffB6MBIUgNZ3R8O7ONfqvrY4=;
 b=IBH1iSgAVF7OIYcGcgqehX1aW03oKvGsxGf/iU23sWI1EK8hYE5UEIIsWoQFf3uCpp
 pkkPQMaCYtttrwEmEvvvhvZW9EN7+7mHbTdlXTrRfd7ZSX2v8Wzjlq9TcBoHT50YEfYN
 6zTsWbpWjou3HKECxqmZQJ3jUFQUhzi+1rLiqQ36xSDgO4dFrw5yVn1+064v/xES5me3
 zhkS71Z/X3ixdoVweRcHXeObbuKNrFDFx7ylzUhDB07bG96h6gCRguMquOu0irCCw0z4
 qSmyt0CTTDjMS6MjE5qO2Htd7M02QzCtmgxqNPJs2rV8hLDdnktqCX7Y5pnlOrneAKX5
 YU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781646141; x=1782250941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MHO0vJnL6+rsRhVwiBIffB6MBIUgNZ3R8O7ONfqvrY4=;
 b=Kk6CbArWZWEZvdYgT4e6gTwXnmbX0O5C6B7Kxw3O6PfP3+Gey3ze13mLs95SnugcBA
 oxfr45LPVKFc0wvgAtBY78+OMPmvtFnzOt1d6cOWkIYPOXK4wciAQDT9s4lAn8P+Nh/B
 rR8Etxvd7qfHwxEwR9l3O1NuryKWSZ0M3R0bNBwRrNzkCJIlNloJdoVbNrBkWD3cbgGc
 oVOvvmgiyR3Yvne4xE1Azs83FA0vEVnam39t3UcQ/M1XRidzNRi+dJtlLEKgKlhgYhrp
 oI8+lhdbh1YvlvgfKtyZsy7jy/APLcAqdHWLmMUgjKbJq2T4Ps07Gozp87Ue/NraFWLs
 X/Lw==
X-Gm-Message-State: AOJu0Yz6g4VxYN/F3Q29gMx06BScLjbxKyMBsZuoa1KKB5q8fv9DFfvL
 RpY3Rhtexc30gd1mJdQ95yz7qkw3WqoRB0MjiGTcYlFDxSTkqXIz2vKAH0gzYG8LNCCQXfcwNzz
 bjlIN
X-Gm-Gg: Acq92OEiDQsz1T4B4Xj6VSQJAm6ddAqbrJT01laW3jEa7Sv9fTdJQSux59Kw1HzuL8D
 yOgUwCZyWJ9h+7kCxjWyyEdNsFh+ynAkR0vbcigUeIn1mOOH764aZ+RHaS1ZwtLMxUtJ+yk4fO9
 Uk8lZB3xKDghE9ifQKkACCmWVWIIRc5AjH1yVWUxG39qnFKEgtqZCLqKQCarvKmANL3HK46Dl+n
 cOyxjeA0QsE0XAyq6j1B6yRzy86dqQrDc5fIPEnCEXy3ddi3iAzJgA/3oh01obuHp8hEO9H7bPz
 qZBwUPJafEg4ds2a2j9veiIIiDXdc9T/v6khYi/KT0ZyAhN59sc9dSsYfOn85LJmnhfFgwDAb8y
 hDYsbueZnIpTH2zsZ4RTw5dwPDxdB/p7JqxbxGy7evVuL5iMuYcPW/1MgMPhIbiQ39kC8P0WDU9
 cSTCk1ztdoN/VoyYunoWbl/eNCUjyiwEPiuG8rjtEH6IIHWRKxNbYYHptjVdjSaK38
X-Received: by 2002:a05:7300:6413:b0:2ed:e12:3769 with SMTP id
 5a478bee46e88-30bcae465c7mr596290eec.31.1781646141126; 
 Tue, 16 Jun 2026 14:42:21 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e920243sm20701708eec.18.2026.06.16.14.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:42:20 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:42:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 00/21] Wangxun Fixes
Message-ID: <20260616144218.3bb7ea85@phoenix.local>
In-Reply-To: <20260616122030.9688-1-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260616122030.9688-1-zaiyuwang@trustnetic.com>
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

On Tue, 16 Jun 2026 20:20:08 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This series fixes several issues found on Wangxun Emerald, Sapphire and
> Amber-lite NICs, with a focus on link-related problems.
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

AI review was mostly clean, do you want to change this one thing?

Review of [PATCH v6 00/21] net/{txgbe,ngbe} fixes from Zaiyu Wang

All findings from the v5 review are addressed:

  - 07/21: Tx desc free now loads the 32-bit headwb_mem atomically and
    casts to uint16_t at the use site, removing the type pun.
  - 14/21: kr_read_poll() switches from usleep() to usec_delay() to
    match the rest of the txgbe base layer.
  - 16/21: stray tab+space indent in txgbe_read_i2c_sff8636() is gone.
  - 17/21: stray tab+space indent in txgbe_get_module_info() is gone.
    TXGBE_SFF_DDM_IMPLEMENTED is now indented as a bit mask under the
    8472_SWAP register definition, which reads correctly.
  - 18/21: page is reset to 0 inside each iteration of the for loop so
    it no longer accumulates across iterations.  The flat-memory check
    is now driven by an explicit read of module byte 2 via
    read_i2c_sff8636() into a local is_flat_mem flag, instead of
    reading data[0x2] out of the caller's output buffer.  databyte is
    cleared to 0 at the top of each loop body so the skipped-read
    branch can no longer leak the previous iteration's value.
  - 20/21: RTE_LIBRTE_SECURITY is corrected to RTE_LIB_SECURITY so the
    !txq->using_ipsec guard is actually preprocessed in.

One small remaining comment on 18/21, not blocking.

Patch 18/21 (net/txgbe: fix get EEPROM operation)

Info: is_flat_mem has inverted semantics relative to its name, which
is going to confuse future maintainers.  SFF-8636 byte 2 bit 2
("Flat_mem") is 1 for flat-memory modules and 0 for paged-memory
modules (this is the same convention ethtool uses).  The new code
treats the bit the opposite way:

  +	bool is_flat_mem = true;
  ...
  +		if (rdata & 0x4)
  +			is_flat_mem = false;
  ...
  +			if (page == 0 || is_flat_mem) {
  +				status = hw->phy.read_i2c_sff8636(hw, page, ...);

So when the module reports flat (bit set), is_flat_mem is set to
false; when paged (bit clear), is_flat_mem stays true.  The condition
'page == 0 || is_flat_mem' reads only page 0 in the flat case and any
page in the paged case, which is the right behavior, but the variable
ends up meaning "paged memory is OK to read" rather than "module is
flat".  Suggest either:

	bool is_flat_mem = false;
	if (rdata & 0x4)
		is_flat_mem = true;
	...
	if (page == 0 || !is_flat_mem) {
		...
	}

or renaming to allow_paged_reads (or similar) and keeping the existing
default and condition.


