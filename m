Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D05C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 20:01:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C2CB4025E;
	Thu, 24 Apr 2025 22:01:03 +0200 (CEST)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 47CEC400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 22:01:01 +0200 (CEST)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso1232870b3a.1
 for <dev@dpdk.org>; Thu, 24 Apr 2025 13:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745524860;
 x=1746129660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IuX0Vu3GOuO1bOZwzRhX/fglu1XpA+gL9Obh3u8C5g=;
 b=TwQQ6jPBsOIvU6mQgI4nQ6SydpqkS42FXHMGFA81ae5m3KsRl/u3OGp0pqClKh07mS
 0uQ0zPrPEY87aAqkP89X1sKGcO3Wz2+CTBJMKj2PNo/noLkUo+v4jQRV2NiL9qlly4XK
 87vpL3EFvwPSl5/D8ujubhq3wMeXmRTF/3yQxWmAeNExupDy0jj9O8SYOESi+gqu8abF
 iEs5/q2N5mRkIskie9k6uKVRJrKh32I84Hz344DANFpM0/Cl9/I+0/TW7CB4aO/8xzpd
 roQ01/XCwJD5AmIfnAUYlI71nAVab/jXRRwGYSc+tY6vCRCaMqpa9cH52/GeCYOriVrn
 nw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745524860; x=1746129660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IuX0Vu3GOuO1bOZwzRhX/fglu1XpA+gL9Obh3u8C5g=;
 b=gS24EluoOWYpRhH4D9oQxX/iNt0P+lx0qSs1PlieIeO82+qPR7v0pv7BxUuq1Yw3Oq
 88xY37cEj4n9iGzuXsUlFJRVJwcC/ZoXbwTa1LUOnk64Me02Z3zPs5E9tslBnI06AAkI
 XX1Xx5G9w2nR6am4cDK2oPSIXooJRvHoJS1jRCQ2wwBMOtz1oJkpkzMTLBdluO7mv6Vj
 iA/L83mDxQMzIkDKqh2PrTzNJKtpMtfomVgi3pwj7ESPvc0lu39G8yX0yjjyABiJ/ksi
 wk+qJ5NIkQbZolI6cHHoccGZ01S8JKL+ofTSel8iBuGZ+/dVaXB6p0xB3+ofSgN2FIbG
 tKjA==
X-Gm-Message-State: AOJu0Yx1dMZBDpvqnr5JKAuj3YCoBMX0e7jQtGXYnkINPdYpk4j+E6m1
 LI0sd7/ry+7nhL3mFpa6mfDC0vEf7h4Iyt2pNO+Z8lDIJVR7E1diI/SbD2JM9/g=
X-Gm-Gg: ASbGncuSm3Zz9g3LyZ3brzOVYnNbdB4uu7vlAHXkRYN/e502J1RY2D6QYFIjWh0pqmv
 x+Kh1F0pWVPNy8QnX90I5P5apZB7MO+eXwAUJStfS6LNECG2OccZYO/N9ttZ6QFLz/S6GgzMCqd
 3tQMawMMH6PTIrb0rCnSwD8QfLP6hkOvUTDU7BBld+OT6AHoZj3vxy16sXp0k+ZDofTAh2B2fUb
 y23Lw/Vbt2rLiadyMlKQoyWyyQt/I1ri+NS0uyfIKPlpBak7dhgMYP1JsRoDSdlEcrcsX3AuUjg
 rRlMvos93KW5HGbJIGh8sSWhiutaNVhCmVB84nnBOdARQyxqFzqXvqFE6WOAqc1/bdl8Ym+4b07
 SOE9Ml+DbOrpemrWDBjnlv8VMCmk=
X-Google-Smtp-Source: AGHT+IE4B/fyCm1DcMjZSNx8u2gnRfTeS6bP2uT7IObftNAqxHIIOIVQ3RlDV1iqm90xSahlHCkCBw==
X-Received: by 2002:a05:6a00:6f26:b0:736:bced:f4cf with SMTP id
 d2e1a72fcca58-73e2661a103mr5364751b3a.0.1745524860024; 
 Thu, 24 Apr 2025 13:01:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259134e0sm1822285b3a.20.2025.04.24.13.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 13:00:59 -0700 (PDT)
Date: Thu, 24 Apr 2025 13:00:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, Andy
 Moreton <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH v2 00/45] Support AMD Solarflare X45xx adaptors
Message-ID: <20250424130058.06a2a0d8@hermes.local>
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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

On Wed, 23 Apr 2025 19:59:17 +0400
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
> v2:
> - squashed respective parts of commit [1] into commits [2] and [3]
> - dropped irrelevant TODO and FIXME markings from the patches
> - applied review notes and tested build in FreeBSD14-64
> 
> [1] https://mails.dpdk.org/archives/dev/2025-April/317109.html
> [2] https://mails.dpdk.org/archives/dev/2025-April/317096.html
> [3] https://mails.dpdk.org/archives/dev/2025-April/317098.html
> 
> 
> Andy Moreton (2):
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
>  drivers/common/sfc_efx/base/ef10_nic.c        |   93 +-
>  drivers/common/sfc_efx/base/ef10_phy.c        |   43 +-
>  drivers/common/sfc_efx/base/ef10_tlv_layout.h |    9 +-
>  drivers/common/sfc_efx/base/efx.h             |   98 +-
>  drivers/common/sfc_efx/base/efx_check.h       |   25 +-
>  drivers/common/sfc_efx/base/efx_ev.c          |    6 +
>  drivers/common/sfc_efx/base/efx_filter.c      |    6 +
>  drivers/common/sfc_efx/base/efx_impl.h        |  115 +-
>  drivers/common/sfc_efx/base/efx_intr.c        |    6 +
>  drivers/common/sfc_efx/base/efx_mac.c         |   56 +-
>  drivers/common/sfc_efx/base/efx_mcdi.c        |   18 +-
>  drivers/common/sfc_efx/base/efx_mcdi.h        |    2 +-
>  drivers/common/sfc_efx/base/efx_nic.c         |   60 +
>  drivers/common/sfc_efx/base/efx_np.c          | 1591 +++++
>  drivers/common/sfc_efx/base/efx_phy.c         |   88 +-
>  drivers/common/sfc_efx/base/efx_port.c        |    1 +
>  drivers/common/sfc_efx/base/efx_regs_mcdi.h   | 5868 ++++++++++++++++-
>  drivers/common/sfc_efx/base/efx_rx.c          |    6 +
>  drivers/common/sfc_efx/base/efx_tunnel.c      |   18 +-
>  drivers/common/sfc_efx/base/efx_tx.c          |   33 +
>  drivers/common/sfc_efx/base/medford4_impl.h   |  105 +
>  drivers/common/sfc_efx/base/medford4_mac.c    |  286 +
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
>  41 files changed, 8944 insertions(+), 125 deletions(-)
>  create mode 100644 drivers/common/sfc_efx/base/efx_np.c
>  create mode 100644 drivers/common/sfc_efx/base/medford4_impl.h
>  create mode 100644 drivers/common/sfc_efx/base/medford4_mac.c
>  create mode 100644 drivers/common/sfc_efx/base/medford4_phy.c
> 

Applied to next-net.

Resisted the urge to just squash all the patches together..
