Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D2DC88E77
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 11:29:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A506427BA;
	Wed, 16 Sep 2026 13:29:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 92B504067D
 for <dev@dpdk.org>; Wed, 16 Sep 2026 13:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789558165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tx/VPGrb+6YhrflN0G9J3s2ncjKWFooZwKhuqFvSg1A=;
 b=Rqt8VakLi+lK6EN7MXjF0+Y2hcE5XzEuSD+GT4r+oMDzuFQbv2fpaduyNH8WC2q2zzvNgW
 p3KWiMmL0TI5+38KiNNzfkZmtT9kcXw0rPThzMhbxbUda0GlcjGoGPlRg1lbH9hIA0Yyfh
 ZTjosPC+PDQUkcA9ef4vKq1iz1WnFes=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-qr2Dl-mMPkq8bVsOBj7_Eg-1; Wed, 16 Sep 2026 07:29:21 -0400
X-MC-Unique: qr2Dl-mMPkq8bVsOBj7_Eg-1
X-Mimecast-MFC-AGG-ID: qr2Dl-mMPkq8bVsOBj7_Eg_1789558160
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a4b6a1f50eso26902041fa.3
 for <dev@dpdk.org>; Wed, 16 Sep 2026 04:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789558160; x=1790162960;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tx/VPGrb+6YhrflN0G9J3s2ncjKWFooZwKhuqFvSg1A=;
 b=SLhziQL53pKdCLU9Ts20A1iB0KJTo/r6F6FE+ivCZ10/VsPwBhlSjUP8UN8iAknCi2
 PS23qUw88XK44+Mrl1lGcpg13r0/+sDbwlmIp4uqVVeV5i1X4TmPYprnZMNPI0T6eraR
 0nwyGW1ptO+5jJE5YacaqbX2fL4XRKnOtqUaVFs3DFaUW0tuhMmNnYv8GV2L5DBvtzFg
 LS+V/vWFuZXNOLcAsu4iB7iFRKvvtTqcB5PCycmp6gkneVrkvqcLy5AOf5eX5G2Gcq+u
 Ztbv6DWVwOSWYiNSR4lOydczUP3lf2e0VSd0X4YztYPUQlh4GSC+7shsvqtKOtcILwqq
 HgYA==
X-Gm-Message-State: AFuF++kisLWtJfv5tTDJfngYeadjzGwhjmtDV6ttXFuWS9eJYiDVV+Wt
 doZPcTC4utQ0r+TC5Acp4zrwLtxHHlas7bhhJQQgVRI7ciiiFmaX6KdUosdise0eOffW6afGyZo
 sVdbiR2CO5hxCaO4+QC7UWX4MUk1t6q5IsKrEjiPBS4HhKaCZ08KdCC066GRNAQInBAKJh8XuA6
 FDXRMsKuN8nefr/RRzzdA=
X-Gm-Gg: AYBFou0r+DiaPOqU5teQFBQkgNSkFvAgr0DSww3ExKYa6umIKdbOz7ziQ5I29s3eGI4
 zeaeUSOfecVir/itV0jaVXLEo8KhOlGTIH3VhLqB0qLiwj88r2SC7xijWzyvN1iCCemuNtDESyL
 Ks76z4XhSzYczwhV+WZAbyIaLDW8h90qQDu4NuXq1ZVbVFibgeAN+ryEoBJKX2JBpFiuCXG7/QD
 SycWPBQ8nIn1jTKs2hLbNJgK3rH6b5riRsxM4egYcl6/9sf
X-Received: by 2002:a2e:be1d:0:b0:3a5:defc:81d4 with SMTP id
 38308e7fff4ca-3a5defc87a0mr3162891fa.10.1789558160040; 
 Wed, 16 Sep 2026 04:29:20 -0700 (PDT)
X-Received: by 2002:a2e:be1d:0:b0:3a5:defc:81d4 with SMTP id
 38308e7fff4ca-3a5defc87a0mr3162701fa.10.1789558159415; Wed, 16 Sep 2026
 04:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
In-Reply-To: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 16 Sep 2026 13:29:07 +0200
X-Gm-Features: AcwNN1XdGGK3Nk69whcSuxUWFAhBx0krvWjQfNy44DQu38z_oZU0WjQt8eF66dI
Message-ID: <CAJFAV8wJKYoid=NnVkT81K0A-3v160xvrsstDj8bhAKaK3Ankg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] raw/ntb: add AMD NTB support
To: jingjing.wu@intel.com
Cc: dev@dpdk.org, rjarry@redhat.com, thomas@monjalon.net, 
 selwin.sebastian@amd.com, bhagyada.modali@amd.com, 
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 "Mcnamara, John" <john.mcnamara@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uNOoaAtX20Gccn3zger1s0z_90gbBw9rds8zUo7vVv4_1789558160
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello Jingjing,

On Sun, 23 Aug 2026 at 16:07, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
>
> This series adds support for the Non-Transparent Bridge (NTB) endpoints
> integrated in AMD EPYC Embedded "Turin", "Genoa" and "Siena" processors
> to the raw/ntb driver.
>
> The NTB rawdev framework was originally written around the Intel
> back-to-back topology and the built-in scratchpad handshake protocol.
> Patch 1 generalizes it with a few vendor-neutral hooks so other vendors
> can reuse the common code; the Intel driver is unaffected since the new
> hooks fall back to the built-in paths when NULL. Patch 2 adds the AMD
> hardware driver, and patch 3 documents the new support.
>
> A few AMD-specific hardware details worth noting for reviewers:
>
> - Primary/secondary topology. One endpoint enumerates as the primary
>   (device ID 0x14c0) and the other as the secondary (0x14c3), rather
>   than the Intel back-to-back model.
>
> - Packed scratchpad handshake. The hardware exposes a single shared
>   16-register scratchpad bank split into two disjoint 8-register sets
>   (one per side), so the driver uses a packed handshake layout that
>   fits in 8 registers, plugged in through the dev_handshake and
>   read_peer_config hooks.
>
> - Outbound translation window. AMD NTB uses an outbound translation
>   window: a write to a BARxx memory-window offset is forwarded to
>   (xlat_base | offset) in the peer's memory rather than
>   (xlat_base + offset). The translation base must therefore be aligned
>   to a power of two >= the window length so that no offset bit collides
>   with a set bit in the base. This is reported to applications through a
>   new mw_addr_align field in struct ntb_dev_info and honoured by the ntb
>   example when reserving the memory window memzone.
>
> - Secondary-side link status. On the secondary side the device's own
>   PCIe link status does not reflect the true inter-host link, so the
>   speed and width are read from the upstream switch port via sysfs.
>
> Tested on a two-node setup (primary + secondary EPYC Embedded hosts)
> with the dpdk-ntb example: the link comes up at the expected speed and
> width on both sides, and file transfers are byte-correct end to end for
> both small and large files.
>
> Raghavendra Ningoji (3):
>   raw/ntb: generalize framework for multiple vendors
>   raw/ntb: add AMD NTB support
>   doc: add AMD NTB support
>
>  MAINTAINERS                            |   1 +
>  doc/guides/rawdevs/ntb.rst             |  18 +-
>  doc/guides/rel_notes/release_26_11.rst |   8 +
>  drivers/raw/ntb/meson.build            |   3 +-
>  drivers/raw/ntb/ntb.c                  | 115 ++--
>  drivers/raw/ntb/ntb.h                  |  18 +
>  drivers/raw/ntb/ntb_hw_amd.c           | 709 +++++++++++++++++++++++++
>  drivers/raw/ntb/ntb_hw_amd.h           | 114 ++++
>  drivers/raw/ntb/rte_pmd_ntb.h          |  10 +
>  examples/ntb/ntb_fwd.c                 |  22 +-
>  usertools/dpdk-devbind.py              |   4 +-
>  11 files changed, 985 insertions(+), 37 deletions(-)
>  create mode 100644 drivers/raw/ntb/ntb_hw_amd.c
>  create mode 100644 drivers/raw/ntb/ntb_hw_amd.h

We need a review on this series to make sure nothing gets broken by
those additions.

In terms of timeline, such updates are welcome in rc1, but this can
slide to rc2 window.
https://core.dpdk.org/roadmap/#dates

Thank you.


-- 
David Marchand

