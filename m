Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73E9C369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 15:15:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6965402E7;
	Wed, 16 Apr 2025 17:15:04 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0FC5A4025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 17:15:02 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso6550472b3a.1
 for <dev@dpdk.org>; Wed, 16 Apr 2025 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744816502;
 x=1745421302; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HfKWLDhEnp5rt5DDlElYMp7VWeZej1BbafdZUlJI8G8=;
 b=B/kljEyW6i2cW3hZO8508WRN3QcEpyFsIfBHbhLeMD2xcBPy85NtsDTkfBvvnjMUl5
 9GFF4SbGRvqqBS2JYb6thmRVUbEm2/XHNIRqwbK/DtbuQqe1fbdHb6qcEQ5lnGZQDJwu
 eS7GZQbVQwb/eNhUMSp2S5HyxItoBH84e7hsmH/WZKpHryJSNl2DGU6mp23dXWuxWtbB
 WcqEIsUOfZ6MKDQVj2dLSMmHpHDcq/QzgyQpMMdRUxzfJfTKhi1r+m+OUKdYXnYnNYxn
 UGdne7GaY5Tu4GCSahr1+bSK1/msstRGHYV0OnEs1t8U3oyou6MUmHbh+ESfmSPg1xrm
 n2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744816502; x=1745421302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HfKWLDhEnp5rt5DDlElYMp7VWeZej1BbafdZUlJI8G8=;
 b=B3cBS0Yjp+VxJVbs3QQ70BmYp0CxdZA8yM8VCnnn7kT0siUMODHzOO1f5pgt+KXaKs
 kPMzoP5+GYu14fDVq8CFMFW6moaK3KufPN9Wq6h5/PhCZV84U9uhyr98wrTwtoUdR4sW
 haaJxFpI2SAZ6PplTHKt/RHhiVwc3fJt0HKEYr93wo0705xm+FtaX954X1le7lqZjp3C
 MH1RS+C9Z2dM40BSXbX0BBTQI6hZRG78JPc5ylJwGS9/FdCpqCTkPqyyQcck6uL8+8Ex
 dIfEOZX7lRJeJbni0W4qA2ZR8H4qAQm0WNOLWV5ccJHJNW5Mg8u/fHhmJhiEyiqEB/bf
 O81A==
X-Gm-Message-State: AOJu0YzJ6fe0VDDNfZxQ6nQEaw2W+S2NjTG84Itby5+fE1TJH70qBokS
 /+BOEq3aVYUPNl6vWmG/w3SrjISVuJgHYBZEC2NOZO3ezBgA+1lCW+ErNCOfx+4=
X-Gm-Gg: ASbGncvkRdeDJ8YvpQ+7vDQJ+WyGrIlXUQhYUWIE6nWQmc/4Pbm/5oC0VS/ApmUzzSD
 pA7jRc3qtQz4o3XIr4x5diRrwhDMY33byTUURijnow22duVLZ9sQ1B1RMelnpjt572i+lEsES/6
 AewE0pJvZnE43jzIqTdPjePbs64qPK7pBlLtUXlgjPG/nd2UlfdwFz3edqCgF8E9M00Fg+OaPn/
 V/BkLLbu+TauC/tCs4l/FZeOB3spD03+I+DakctjJC/I4MqX/8qNwZyL1cyaeoU2KNF2bL4r/Qx
 7N/1XKsbNwWzS0rrv/rnAfXQ9ZMM8F2a+x4JoCL3sA6qTUT2PNPXNVCUrBYuWuqJv20Q9q2BmQL
 sKG2HUPcma/9l8Zz+cWcX4rKMUDo=
X-Google-Smtp-Source: AGHT+IGC130QKqk4mXNC3CMydzNaRVJItL8m0028lJRU0NjK2uulzUat4NeRGr9xcpPZGWg9i5AqIg==
X-Received: by 2002:a05:6a00:ac0b:b0:732:535d:bb55 with SMTP id
 d2e1a72fcca58-73c266b9b1bmr2931997b3a.4.1744816501889; 
 Wed, 16 Apr 2025 08:15:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220aa948sm1406992a12.10.2025.04.16.08.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 08:15:01 -0700 (PDT)
Date: Wed, 16 Apr 2025 08:14:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Denis
 Pryazhennikov <denis.pryazhennikov@arknetworks.am>, Andy Moreton
 <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 00/46] Support AMD Solarflare X45xx adaptors
Message-ID: <20250416081454.6c9ea0e2@hermes.local>
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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

On Wed, 16 Apr 2025 17:59:30 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> New X4522 (dual port SFP56) and X4542 (dual port QSFP56) adaptors are
> Medford4 (X4) chips that are based on EF10 architecture. An X4 NIC
> supports multiple network engine types. This series provides support
> only for the Medford2-alike, 'full-feature' (FF) network engine. This
> shall not be confused with the concept of 'datapath FW variants': the
> FF network engine supports both 'full-feature' and 'ultra-low-latency'
> datapath FW variants, with corresponding Medford2-alike feature sets.
> 
> The first part of the series provides general support for the adaptors,
> whilst the second one adds support for the new management controller
> interface for configuration of network port features (netport MCDI).
> 
> For now, only support for physical functions (PFs) is concerned. There
> is a small number of TODO and FIXME markings in the code. Those are
> normal at this development stage and will be removed by future patches
> when VF support has fleshed out.
> 
> 
> Andy Moreton (3):
>   common/sfc_efx/base: update X4 BAR layout and PCI IDs
>   net/sfc: add Medford4 with only full feature datapath engine
>   common/sfc_efx/base: add port mode for 8 port hardware
> 
> Denis Pryazhennikov (15):
>   common/sfc_efx/base: add Medford4 PCI IDs to common code
>   common/sfc_efx/base: add efsys option for Medford4
>   common/sfc_efx/base: add Medford4 support to NIC module
>   common/sfc_efx/base: add Medford4 support to EV module
>   common/sfc_efx/base: add Medford4 support to FILTER module
>   common/sfc_efx/base: add Medford4 support to INTR module
>   common/sfc_efx/base: add Medford4 support to MAC module
>   common/sfc_efx/base: add Medford4 support to PHY module
>   common/sfc_efx/base: add Medford4 support to TUNNEL module
>   common/sfc_efx/base: add Medford4 support to MCDI module
>   common/sfc_efx/base: add Medford4 support to Rx module
>   common/sfc_efx/base: add Medford4 support to Tx module
>   drivers: enable support for AMD Solarflare X4 adapter family
>   common/sfc_efx/base: add new X4 port mode
>   common/sfc_efx/base: extend list of supported X4 port modes
> 
> Ivan Malov (28):
>   common/sfc_efx/base: update MCDI headers
>   common/sfc_efx/base: provide a stub for basic netport attach
>   common/sfc_efx/base: provide defaults on netport attach path
>   common/sfc_efx/base: obtain assigned netport handle from NIC
>   common/sfc_efx/base: allow for const in MCDI struct accessor
>   common/sfc_efx/base: get netport fixed capabilities on probe
>   common/sfc_efx/base: decode netport link state on probe path
>   common/sfc_efx/base: fill in loopback modes on netport probe
>   common/sfc_efx/base: introduce Medford4 stub for PHY methods
>   common/sfc_efx/base: refactor EF10 link mode decoding helper
>   common/sfc_efx/base: provide PHY link get method on Medford4
>   common/sfc_efx/base: implement PHY link control for Medford4
>   common/sfc_efx/base: introduce Medford4 stub for MAC methods
>   common/sfc_efx/base: add MAC reconfigure method for Medford4
>   common/sfc_efx/base: fill in software LUT for MAC statistics
>   common/sfc_efx/base: fill in MAC statistics mask on Medford4
>   common/sfc_efx/base: support MAC statistics on Medford4 NICs
>   common/sfc_efx/base: implement MAC PDU controls for Medford4
>   common/sfc_efx/base: correct MAC PDU calculation on Medford4
>   net/sfc: make use of generic EFX MAC PDU calculation helpers
>   common/sfc_efx/base: ignore legacy link events on new boards
>   common/sfc_efx/base: add link event processing on new boards
>   net/sfc: query link status on link change events on new NICs
>   common/sfc_efx/base: subscribe to netport link change events
>   net/sfc: offer support for 200G link ability on new adaptors
>   common/sfc_efx/base: support controls for netport lane count
>   net/sfc: add support for control of physical port lane count
>   doc: advertise support for AMD Solarflare X45xx adapters
> 
>  .mailmap                                      |    3 +-
>  doc/guides/nics/sfc_efx.rst                   |    9 +-
>  doc/guides/rel_notes/release_25_07.rst        |    4 +
>  drivers/common/sfc_efx/base/ef10_ev.c         |   39 +
>  drivers/common/sfc_efx/base/ef10_impl.h       |   19 +
>  drivers/common/sfc_efx/base/ef10_nic.c        |   98 +-
>  drivers/common/sfc_efx/base/ef10_phy.c        |   43 +-
>  drivers/common/sfc_efx/base/ef10_tlv_layout.h |    9 +-
>  drivers/common/sfc_efx/base/efx.h             |   98 +-
>  drivers/common/sfc_efx/base/efx_check.h       |   24 +-
>  drivers/common/sfc_efx/base/efx_ev.c          |    6 +
>  drivers/common/sfc_efx/base/efx_filter.c      |    6 +
>  drivers/common/sfc_efx/base/efx_impl.h        |  115 +-
>  drivers/common/sfc_efx/base/efx_intr.c        |    6 +
>  drivers/common/sfc_efx/base/efx_mac.c         |   56 +-
>  drivers/common/sfc_efx/base/efx_mcdi.c        |   18 +-
>  drivers/common/sfc_efx/base/efx_mcdi.h        |    2 +-
>  drivers/common/sfc_efx/base/efx_nic.c         |   60 +
>  drivers/common/sfc_efx/base/efx_np.c          | 1625 +++++
>  drivers/common/sfc_efx/base/efx_phy.c         |   88 +-
>  drivers/common/sfc_efx/base/efx_port.c        |    1 +
>  drivers/common/sfc_efx/base/efx_regs_mcdi.h   | 5868 ++++++++++++++++-
>  drivers/common/sfc_efx/base/efx_rx.c          |    6 +
>  drivers/common/sfc_efx/base/efx_tunnel.c      |   18 +-
>  drivers/common/sfc_efx/base/efx_tx.c          |   33 +
>  drivers/common/sfc_efx/base/medford4_impl.h   |  110 +
>  drivers/common/sfc_efx/base/medford4_mac.c    |  299 +
>  drivers/common/sfc_efx/base/medford4_phy.c    |  156 +
>  drivers/common/sfc_efx/base/meson.build       |    3 +
>  drivers/common/sfc_efx/efsys.h                |    2 +
>  drivers/common/sfc_efx/sfc_base_symbols.c     |    2 +
>  drivers/net/sfc/sfc.c                         |    5 +-
>  drivers/net/sfc/sfc.h                         |    4 +
>  drivers/net/sfc/sfc_dp_tx.h                   |    3 +
>  drivers/net/sfc/sfc_ef10_tx.c                 |   13 +-
>  drivers/net/sfc/sfc_ethdev.c                  |  186 +-
>  drivers/net/sfc/sfc_ev.c                      |   51 +-
>  drivers/net/sfc/sfc_port.c                    |   27 +-
>  drivers/net/sfc/sfc_repr.c                    |    7 +-
>  drivers/net/sfc/sfc_repr.h                    |    1 +
>  drivers/net/sfc/sfc_tx.c                      |    2 +
>  41 files changed, 9000 insertions(+), 125 deletions(-)
>  create mode 100644 drivers/common/sfc_efx/base/efx_np.c
>  create mode 100644 drivers/common/sfc_efx/base/medford4_impl.h
>  create mode 100644 drivers/common/sfc_efx/base/medford4_mac.c
>  create mode 100644 drivers/common/sfc_efx/base/medford4_phy.c
> 

Overall looks good but:
  - need to fix build on FreeBSD, you are using an errno not available there.
  - can you address some of the checkpatch warnings in the base code.
