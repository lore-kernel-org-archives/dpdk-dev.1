Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D136EC369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 16:32:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2A2E402E7;
	Wed, 16 Apr 2025 18:31:59 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 809FF4025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 18:31:58 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-223fd89d036so87159865ad.1
 for <dev@dpdk.org>; Wed, 16 Apr 2025 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744821117;
 x=1745425917; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MleYNryIrTF3K0vwukYFwnwc6u9pyOipGVm94pMBlA=;
 b=m3btX5RXNT6PMURgezliyNddC8s8iOUpuj9xIaNr0My5L57RV/UAzUx7WVrGSsiTSV
 oXFbPT8FhKoOqlIJID1qGxNXv537MgpIZKRILD90HgbGBnczDuPQsWjEpcq7UoGT7AQH
 wrNAgv7SGZPaGqkCPPQ7KxLfrrUyPSdhym1IyoZhD5xpcOKxpAKW4MkkKKBAI+2nwGEA
 l7e4oJopCYRJlA/L9qyyMHxAxKxMOQPEBTDjS3ycgdsCvb5cgN+uwhW+ace8pphQq2Po
 3R5adYuB/ozaf0AGzPB3Zc7QOv/UCNIsHn8QMlufzZHYsh5/SXWnzR+P/fH0bwC55jwd
 omCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744821117; x=1745425917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MleYNryIrTF3K0vwukYFwnwc6u9pyOipGVm94pMBlA=;
 b=JaiXy6bt5oqrZ4PjFSA3q8t0gLwDYG3flQCOAqlY/Vx4TZMYYRmopKx3dKhdpX1UfT
 3p8rm1cu/zyYrwfMUHz01PVHQSjFBlKG5Hrff3Yg/srww+rgwiU0WI6XIHeUhWR+PaFi
 +N5sgP4fgOs0i2asRVmVHk2yRjWe/16fkjTC6HdEFn+UX5G9icG2+DxAYER7akYaUYZH
 CO5juy0NQPWc8xGsOmuSud8NdlAO/RPJMU9j/hnzk4DBT5+24CDGfQI23mp3k306TMcN
 7WDJA0f+gVQehhndiaXA4GG0d1eDcFeQdCcoZ2fIWTHiNnxFwlQsS4yfyU0JGwcIZ/m8
 98TA==
X-Gm-Message-State: AOJu0YytRC9lBSgznpLxXpum//uIwDPTlVhLZKf55TpxxMcKEyytCxdm
 cYAKYCTB0qGJyoKsZIjyGkY3febmbMfBkFioiEWVdxhj6fzti/ozsr8tTYRQLLM=
X-Gm-Gg: ASbGnctHaHmsO3DzVjKvcElrW04U4/eCtmRRUeC4Eo/Rozrua6jtn7dkv/nzelz3w3P
 o9dv83P3kB0PaWg7esc6oAKXYz4rAz/xDIDtnd+4oNRNNB5PiC920p1Pp/vhLolhM1b0r631oSP
 4fr+BOi1QGz1Fd/m26FvJ1VTKQJKJw8GVlMX0EeuU/HQG3kufqubGqedWPbFOt4FuSKt20U+Txj
 teOWqfQy1luDEWZl1antnmcj1SsZRfdENjF0Q2SXnFIS9rqWEYektCRN6LGyWiwGJbEouGu2xST
 drIWAqp7AG+bGzWtxAjxt36LVtmexhs0JsRuMpPUl2uppTrsiBiBec2cDFiL/nphSBLSgS3CNGY
 8FD1G9K1gCZvuLH5RaEXLdL3+sNE=
X-Google-Smtp-Source: AGHT+IEcws86CI/awgTWR1bW1KBlcVPdtP00aoJ5YhZ8dgDBF97zxHI39dZ2xRwoIYhQxXPDczR7vA==
X-Received: by 2002:a17:902:ef44:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-22c35990b95mr42150125ad.50.1744821117249; 
 Wed, 16 Apr 2025 09:31:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f8850sm10572077b3a.87.2025.04.16.09.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 09:31:57 -0700 (PDT)
Date: Wed, 16 Apr 2025 09:31:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Denis
 Pryazhennikov <denis.pryazhennikov@arknetworks.am>, Andy Moreton
 <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 00/46] Support AMD Solarflare X45xx adaptors
Message-ID: <20250416093154.3c858f54@hermes.local>
In-Reply-To: <e3a33af7-c896-c3ec-c46d-0f64fe182999@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250416081454.6c9ea0e2@hermes.local>
 <e3a33af7-c896-c3ec-c46d-0f64fe182999@arknetworks.am>
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

On Wed, 16 Apr 2025 19:38:58 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> On Wed, 16 Apr 2025, Stephen Hemminger wrote:
> 
> > On Wed, 16 Apr 2025 17:59:30 +0400
> > Ivan Malov <ivan.malov@arknetworks.am> wrote:
> >  
> >> New X4522 (dual port SFP56) and X4542 (dual port QSFP56) adaptors are
> >> Medford4 (X4) chips that are based on EF10 architecture. An X4 NIC
> >> supports multiple network engine types. This series provides support
> >> only for the Medford2-alike, 'full-feature' (FF) network engine. This
> >> shall not be confused with the concept of 'datapath FW variants': the
> >> FF network engine supports both 'full-feature' and 'ultra-low-latency'
> >> datapath FW variants, with corresponding Medford2-alike feature sets.
> >>
> >> The first part of the series provides general support for the adaptors,
> >> whilst the second one adds support for the new management controller
> >> interface for configuration of network port features (netport MCDI).
> >>
> >> For now, only support for physical functions (PFs) is concerned. There
> >> is a small number of TODO and FIXME markings in the code. Those are
> >> normal at this development stage and will be removed by future patches
> >> when VF support has fleshed out.
> >>
> >>
> >> Andy Moreton (3):
> >>   common/sfc_efx/base: update X4 BAR layout and PCI IDs
> >>   net/sfc: add Medford4 with only full feature datapath engine
> >>   common/sfc_efx/base: add port mode for 8 port hardware
> >>
> >> Denis Pryazhennikov (15):
> >>   common/sfc_efx/base: add Medford4 PCI IDs to common code
> >>   common/sfc_efx/base: add efsys option for Medford4
> >>   common/sfc_efx/base: add Medford4 support to NIC module
> >>   common/sfc_efx/base: add Medford4 support to EV module
> >>   common/sfc_efx/base: add Medford4 support to FILTER module
> >>   common/sfc_efx/base: add Medford4 support to INTR module
> >>   common/sfc_efx/base: add Medford4 support to MAC module
> >>   common/sfc_efx/base: add Medford4 support to PHY module
> >>   common/sfc_efx/base: add Medford4 support to TUNNEL module
> >>   common/sfc_efx/base: add Medford4 support to MCDI module
> >>   common/sfc_efx/base: add Medford4 support to Rx module
> >>   common/sfc_efx/base: add Medford4 support to Tx module
> >>   drivers: enable support for AMD Solarflare X4 adapter family
> >>   common/sfc_efx/base: add new X4 port mode
> >>   common/sfc_efx/base: extend list of supported X4 port modes
> >>
> >> Ivan Malov (28):
> >>   common/sfc_efx/base: update MCDI headers
> >>   common/sfc_efx/base: provide a stub for basic netport attach
> >>   common/sfc_efx/base: provide defaults on netport attach path
> >>   common/sfc_efx/base: obtain assigned netport handle from NIC
> >>   common/sfc_efx/base: allow for const in MCDI struct accessor
> >>   common/sfc_efx/base: get netport fixed capabilities on probe
> >>   common/sfc_efx/base: decode netport link state on probe path
> >>   common/sfc_efx/base: fill in loopback modes on netport probe
> >>   common/sfc_efx/base: introduce Medford4 stub for PHY methods
> >>   common/sfc_efx/base: refactor EF10 link mode decoding helper
> >>   common/sfc_efx/base: provide PHY link get method on Medford4
> >>   common/sfc_efx/base: implement PHY link control for Medford4
> >>   common/sfc_efx/base: introduce Medford4 stub for MAC methods
> >>   common/sfc_efx/base: add MAC reconfigure method for Medford4
> >>   common/sfc_efx/base: fill in software LUT for MAC statistics
> >>   common/sfc_efx/base: fill in MAC statistics mask on Medford4
> >>   common/sfc_efx/base: support MAC statistics on Medford4 NICs
> >>   common/sfc_efx/base: implement MAC PDU controls for Medford4
> >>   common/sfc_efx/base: correct MAC PDU calculation on Medford4
> >>   net/sfc: make use of generic EFX MAC PDU calculation helpers
> >>   common/sfc_efx/base: ignore legacy link events on new boards
> >>   common/sfc_efx/base: add link event processing on new boards
> >>   net/sfc: query link status on link change events on new NICs
> >>   common/sfc_efx/base: subscribe to netport link change events
> >>   net/sfc: offer support for 200G link ability on new adaptors
> >>   common/sfc_efx/base: support controls for netport lane count
> >>   net/sfc: add support for control of physical port lane count
> >>   doc: advertise support for AMD Solarflare X45xx adapters
> >>
> >>  .mailmap                                      |    3 +-
> >>  doc/guides/nics/sfc_efx.rst                   |    9 +-
> >>  doc/guides/rel_notes/release_25_07.rst        |    4 +
> >>  drivers/common/sfc_efx/base/ef10_ev.c         |   39 +
> >>  drivers/common/sfc_efx/base/ef10_impl.h       |   19 +
> >>  drivers/common/sfc_efx/base/ef10_nic.c        |   98 +-
> >>  drivers/common/sfc_efx/base/ef10_phy.c        |   43 +-
> >>  drivers/common/sfc_efx/base/ef10_tlv_layout.h |    9 +-
> >>  drivers/common/sfc_efx/base/efx.h             |   98 +-
> >>  drivers/common/sfc_efx/base/efx_check.h       |   24 +-
> >>  drivers/common/sfc_efx/base/efx_ev.c          |    6 +
> >>  drivers/common/sfc_efx/base/efx_filter.c      |    6 +
> >>  drivers/common/sfc_efx/base/efx_impl.h        |  115 +-
> >>  drivers/common/sfc_efx/base/efx_intr.c        |    6 +
> >>  drivers/common/sfc_efx/base/efx_mac.c         |   56 +-
> >>  drivers/common/sfc_efx/base/efx_mcdi.c        |   18 +-
> >>  drivers/common/sfc_efx/base/efx_mcdi.h        |    2 +-
> >>  drivers/common/sfc_efx/base/efx_nic.c         |   60 +
> >>  drivers/common/sfc_efx/base/efx_np.c          | 1625 +++++
> >>  drivers/common/sfc_efx/base/efx_phy.c         |   88 +-
> >>  drivers/common/sfc_efx/base/efx_port.c        |    1 +
> >>  drivers/common/sfc_efx/base/efx_regs_mcdi.h   | 5868 ++++++++++++++++-
> >>  drivers/common/sfc_efx/base/efx_rx.c          |    6 +
> >>  drivers/common/sfc_efx/base/efx_tunnel.c      |   18 +-
> >>  drivers/common/sfc_efx/base/efx_tx.c          |   33 +
> >>  drivers/common/sfc_efx/base/medford4_impl.h   |  110 +
> >>  drivers/common/sfc_efx/base/medford4_mac.c    |  299 +
> >>  drivers/common/sfc_efx/base/medford4_phy.c    |  156 +
> >>  drivers/common/sfc_efx/base/meson.build       |    3 +
> >>  drivers/common/sfc_efx/efsys.h                |    2 +
> >>  drivers/common/sfc_efx/sfc_base_symbols.c     |    2 +
> >>  drivers/net/sfc/sfc.c                         |    5 +-
> >>  drivers/net/sfc/sfc.h                         |    4 +
> >>  drivers/net/sfc/sfc_dp_tx.h                   |    3 +
> >>  drivers/net/sfc/sfc_ef10_tx.c                 |   13 +-
> >>  drivers/net/sfc/sfc_ethdev.c                  |  186 +-
> >>  drivers/net/sfc/sfc_ev.c                      |   51 +-
> >>  drivers/net/sfc/sfc_port.c                    |   27 +-
> >>  drivers/net/sfc/sfc_repr.c                    |    7 +-
> >>  drivers/net/sfc/sfc_repr.h                    |    1 +
> >>  drivers/net/sfc/sfc_tx.c                      |    2 +
> >>  41 files changed, 9000 insertions(+), 125 deletions(-)
> >>  create mode 100644 drivers/common/sfc_efx/base/efx_np.c
> >>  create mode 100644 drivers/common/sfc_efx/base/medford4_impl.h
> >>  create mode 100644 drivers/common/sfc_efx/base/medford4_mac.c
> >>  create mode 100644 drivers/common/sfc_efx/base/medford4_phy.c
> >>  
> >
> > Overall looks good but:
> >  - need to fix build on FreeBSD, you are using an errno not available there.
> >  - can you address some of the checkpatch warnings in the base code.
> >  
> 
> I can fix the errno, yes. Thanks for catching this.
> 
> As for the checkpatch warnings in the base code -- unfortunately, that part does
> not follow DPDK style in general and has always triggered such warnings in DPDK.
> Should I try to fix some anyway? Which, for instance?

Mostly it is the use of BSD style parens on returns that clutters the warnings.
I.e
	return (0);
