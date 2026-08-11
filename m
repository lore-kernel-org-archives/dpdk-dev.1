Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38339C5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 21:05:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 147994025F;
	Tue, 11 Aug 2026 23:05:58 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 894984021E
 for <dev@dpdk.org>; Tue, 11 Aug 2026 23:05:56 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so458743a91.3
 for <dev@dpdk.org>; Tue, 11 Aug 2026 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786482355;
 x=1787087155; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xXr7S9SD4pj2KDcSa4TuAhU5Y17tiE8ykzoQGVrhIes=;
 b=v1Va6+sVjIIn7hNhuw/KPm/DjKpT3rDwPqDI6xP2mkVPNON6CuAO0CUsKq8us5Zl+M
 P9zwRYtmfooC4oTaOlXcfGdEj1G4l1UG1ljnIh5Lit5wKCDPDBWXZrbjSzm8M/l5Wu/i
 vZWWCG4YD7QPE2QjuG22zH3tXWwKC+cnkjNpAqUnYGPxc2Y3bFtxohUq5oaBU7phjzA6
 KqdKiWnaeK0b0vAzuecCwLHkbssNFibAKDL5coX6pE013uPCgmByc7LcFdbMvjgxDfB7
 bilCnXaFBKU3Mlg/u72LRdK/L5AGYEuC1D7inqTn/5kdITq1zaBL+AVc1FbDktk8spml
 tUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786482355; x=1787087155;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xXr7S9SD4pj2KDcSa4TuAhU5Y17tiE8ykzoQGVrhIes=;
 b=fPBEWmeSz+KRSpTrCyEcMef5qx5kQUULDRlkLZ4AIKDFgwZHm8EmNl55eykUhyd57K
 Rr/0OpJW/TE2ivvAGk5iGgwEWfDTfC6wv2kzmDmIbbpVhTvoQPqcVVW5hovRaq/yrPkk
 gqCiLnP8lb2zJ2cne/8tI6a5AWszX0pI6nfab1ow0cElmZkaRdquq01iv5aoORTXSukJ
 FcBh94quYLJB9hLwHUWbX82+e1Wk4M7nQ6ByRUTMUxI6YuGczeav5+IDvxCVZk9i2zA8
 e+l2VHRSQ/N4SeatNnm6hz2I5AU6KWhhS+e/ZzeiYk+GSEnWEakpDGm6a//2lVi7+tUa
 PAmw==
X-Gm-Message-State: AOJu0YxlpF/sjg6vyCG+qO5Mdctjpv9nUwMLLA9K8V+1tUm0cKioTSS6
 baMtjgQblsFEvORgvZN+iSjodsJ/NcTMDZooZIrTyYIOnSGjZP6lgJwWv1XKcy3wQIo=
X-Gm-Gg: AR+sD12mxcHxqX2NmoM9cSBPyBXRWS91DYhhwwKSOL8XgUTu/4wvDIlR1RnO41KVqSp
 u+lob+k84nVNWiME2KcQth7gFqm3xd0dHX1fe9VQvHToTsZc4C/B4I7Uwa3BNTfGwLIIg63N9a4
 GOaUfD30SM0UmJeu0w/N/xDQ5RGkxYRgL+Tpe6Aw7ekw3sIoOUXZMcrj8XSbx1ZTZ7DbxOITNwg
 aZUmTuMC2KfIlWyr0YQOUBJSrBxtuxPJP1rwuonqUhKfsT6RB4TJnOMxK0z6oe2LfJFXYV19qsU
 u9MKvsDDqOIQQCSftSfVXoOmVsb4Cs2Vudtb6CnyV7RyqXQRLX9Rido4iVhtoBildKupSm8hsvv
 WlOY3hqKFH1r9lrMlileRxPndPHZQISc19fovpzf9BAyv9/G+rs9njgLCN9jMp0uYZD97OHMmGS
 Fu5/GCsx36wsfE9jwwA7UivH3WldafOxti6XCKKGU8EKDqywq0gth/4IveHZRe6qVx8pmTTc5+F
 TXbfhUhr1LqPoVk3WR4D4Ly0l4LMw==
X-Received: by 2002:a17:90b:3c8b:b0:38e:f6eb:2b38 with SMTP id
 98e67ed59e1d1-392ec68540amr7130566a91.17.1786482355359; 
 Tue, 11 Aug 2026 14:05:55 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf67912d0sm3815334eec.24.2026.08.11.14.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 14:05:55 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:05:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Andy Moreton <andy.moreton@amd.com>, Viacheslav
 Galaktionov <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 0/6] common/sfc_efx/base: add Medford4 VF support
Message-ID: <20260811140551.7824a762@phoenix.local>
In-Reply-To: <20260811175025.9019-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
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

On Tue, 11 Aug 2026 21:50:19 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> This series enables DPDK to use the sfc driver
> on a Medford4 VF alongside the PF.
> 
> The first patch wires EVB switch operations into the Medford4
> libefx implementation, allowing the PF to manage VFs.
> 
> Starting with MCFW 1.4.0.8, VFs may use the netport MCDI for basic port
> configuration, though several operations remain restricted. The
> remaining four patches address each restriction: dummy fixed
> port properties, suppressed event subscription, denied FCS
> and flow control, and ENOTSUP for periodic MAC stats DMA.
> 
> This series depends on the VADAPTER statistics series.
> 
> Ivan Malov (6):
>   common/sfc_efx/base: let Medford4 PF manage VFs
>   common/sfc_efx/base: indicate dummy netport properties on VF
>   common/sfc_efx/base: skip netport event subscriptions on VFs
>   common/sfc_efx/base: deny tuning FCS and flow control to VFs
>   common/sfc_efx/base: deny periodic MAC stats delivery to VFs
>   doc: announce VF support of AMD Solarflare X45xx family NICs
> 
>  doc/guides/rel_notes/release_26_11.rst |  4 ++
>  drivers/common/sfc_efx/base/efx_evb.c  |  6 ++
>  drivers/common/sfc_efx/base/efx_np.c   | 91 ++++++++++++++++++++++----
>  3 files changed, 89 insertions(+), 12 deletions(-)
> 

Some AI feedback, no real errors

Series: [PATCH 0/6] SFC Medford4 VF support (Ivan Malov)
Reviewed against DPDK main @ c1a46b9; all 6 patches apply with git am.
Full-series build (gcc 13, -Dwerror=true) is clean.

Patch 2/6: common/sfc_efx/base: indicate dummy netport properties on VF

Warning: The dummy capability mask makes the VF report a 1 Gbps port.

  efx_np_get_fixed_port_props() returns only EFX_PHY_CAP_1000FDX as the
  supported link speed. That value flows to epp->ep_phy_cap_mask, then to
  sfc_port_attach() via efx_phy_adv_cap_get(EFX_PHY_CAP_PERM), and finally
  to dev_info.speed_capa in sfc_dev_infos_get(). A VF on an X4522/X4542
  will therefore advertise RTE_ETH_LINK_SPEED_1G and nothing else.

  The consequence is not cosmetic. sfc_check_conf() computes

      sa->port.phy_adv_cap = sfc_phy_cap_from_link_speeds(conf->link_speeds)
                             & sa->port.phy_adv_cap_mask;

  and fails configure with EINVAL if the result is empty. An application
  that requests a specific speed (RTE_ETH_LINK_SPEED_25G, for example)
  rather than autoneg cannot configure the VF at all, and one that reads
  speed_capa to pick a speed will pick 1G.

  efx_np_link_state() is called a few lines later in efx_np_attach() and
  does work on a VF; ls.enls_adv_cap_mask holds the real advertised
  abilities. Suggest deriving the VF capability mask from that instead of
  hardcoding 1000FDX, e.g. fold ls.enls_adv_cap_mask into
  epp->ep_phy_cap_mask for VFs after the efx_np_link_state() call.

Info: sup_cap_rawp and loopback_cap_maskp are left untouched on the VF
  path. This is not a use-of-uninitialised bug -- efx_nic_create() uses
  EFSYS_KMEM_ALLOC, which is rte_zmalloc, so epp->ep_np_cap_data_raw and
  ep_np_loopback_cap_mask are zero. Worth a note in the commit message
  that zero is the intended value, since efx_np_assign_lane_counts() and
  efx_np_assign_loopback_props() both consume them.

Info: The dummy mask sets EFX_PHY_CAP_AN, and efx_np_attach() sets the
  same bit again from ls.enls_an_supported at line 1026. Harmless, but
  one of the two is redundant.

Patch 6/6: doc: announce VF support of AMD Solarflare X45xx family NICs

Warning: Commit message claims work that is not in this series.

  "The Solarflare PMD has been updated to support VADAPTER statistics and
  to let the user attach to the X4 VFs". There is no VADAPTER statistics
  change in this series, and grep finds no vadaptor/VADAPTER reference in
  drivers/net/sfc or in the release notes hunk. Either drop that clause or
  add the corresponding release notes entry.

Warning: doc/guides/nics/sfc_efx.rst is not updated.

  The feature list has "SR-IOV PF" but not VF. The features matrix
  (doc/guides/nics/features/sfc.ini) already has SR-IOV = Y, so only the
  prose list is stale. Since the series makes VF attach work on Medford4,
  the driver guide should say so.
