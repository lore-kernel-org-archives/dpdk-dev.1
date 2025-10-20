Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73943CCD1A2
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 21:38:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58346402DB;
	Mon, 20 Oct 2025 23:38:09 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1230B40151
 for <dev@dpdk.org>; Mon, 20 Oct 2025 23:38:07 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b67684e2904so3396953a12.2
 for <dev@dpdk.org>; Mon, 20 Oct 2025 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760996287;
 x=1761601087; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCubG0FwC2mexrsm29rEMt65deG3smu1LkNfhlJeAlI=;
 b=Er33h9hPHC+NIiOGdqSaVN8WiLn9hvqrgY3WRBidGkGpX8I0pbhcXns9Cx3HwA512U
 cXPypzjUePNfV8v7SoPUbFgMMqSOtW824XWG4hQctppW2n8RGDqI0B1RfBCVPwtoMuzZ
 y4A/faSjCyMuaYXNEARodRrgxUkfOW7Oy9EJ4GPkFGk/+4efLJq5tjTpHfA/AIPiD2FD
 qZH9fx30PY1k3YtGffOE/QpoWooYGgeU+5WVFZVv1eAhk/AVpQniWuUfb3Sf510li5vt
 led3k/uimp/HmkGF4eKSHVtQPN/7GzE0kjnsMfQt6iyKw4SVvTRETpaxKOdvKqT5un/K
 0xXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760996287; x=1761601087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCubG0FwC2mexrsm29rEMt65deG3smu1LkNfhlJeAlI=;
 b=TmZvzf596WWGRjXrodQi2hEYmbpuXNjjWRaTRdBwKRAxpgCPpz6kUhYuq2ERrSPM9g
 DokEiBMDVZ4nrAHWJU9aN9Qt3q5+GS8qreQ0g3NqLcYT63KWRQirPGSNth/nl2PD8AcG
 +RaRKMNIFZp+YlcMdz6Fe1KuQR1l1Y9LEaTJ7BF97AP2jQ66+NNz5CCdh+QL7rYzMIw7
 AvlGz3MydvrCsStYW+J/jLCiSyV8Gh6h3lPVRDNsAB04z+2boEk1u2AOc9N4e2nHc37c
 xorY5t7HRPOK9Dq1vBFgYFzHGwVZnExO2hIFKBDACDIlb0kukCJpY4JnCldz9ETC/9Qs
 B/Xw==
X-Gm-Message-State: AOJu0YwlchzilYAO+c/ldR4tw4NKe+2R1pw+Qa27ZfXFqQRCwJpgAgN1
 s2wGqs6D5xFFhbuR8I41LxLfZGFbaYWV+dVyYv4nt8FKyPVxi371Tkjjr6UWglHvifk=
X-Gm-Gg: ASbGncsTOXoEbnvZe0xQhOrq1iAGA3SCsDsTneJvJHfoovnEYOOCcE/1/TSwxtrsaz7
 rEr0Mhz8SeZyfgzoJRbbTN5WUnPGmJ/GmikHY2QzjBp9oD5WayjpwtWf4aTFdu/KJf9sewdvXSO
 kfFus2arLhVuzk1jgzrCZ54omCxEuT3tOliiwEt9WaHrlrrQ5do7Jaqi8jEh30lX/0onIPafrnK
 wGxFYx+Z5e08KC+pkE5h8j27zqFjLUPAaBgyhQQw1sSCaHY1D30e4M+ftmOXqkj2hSZhY6OzG3F
 Tl6Dyi+GdpDCZiink9Z3jffttpBq/R/8vvr2m4fV2A2IVmLJIiQaHA1ZazmEulBLLnvfcAXhtzL
 zcj4z/g1uJrtIrzjBMuDVDBK+MZ+hqDXSw4VE57w4oTpgYuGM3vZ3qrsb860xdEj1e9e4PLchu3
 nDmWsav7rDo7FvzBxKf4o9pudY989BzwYpA1zhWdhz5eyK68BilsnzsZ9m5Y2u
X-Google-Smtp-Source: AGHT+IE4kC0rXDrwbvsMxtPSn/fKFqwXWmd61DSNRcysReKccRcRahl2FVGmmrmBzB0sbE6xDy2/Xg==
X-Received: by 2002:a17:90b:2415:b0:32b:d089:5c12 with SMTP id
 98e67ed59e1d1-33bcf90f96fmr16548856a91.33.1760996286815; 
 Mon, 20 Oct 2025 14:38:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de7c0b7sm8926593a91.16.2025.10.20.14.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 14:38:06 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:38:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 00/24] Migrate threads to the DPDK service framework
 and refactor naming for exported symbols
Message-ID: <20251020143803.246bfe4e@phoenix.lan>
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
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

On Mon, 20 Oct 2025 18:35:51 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This modification provides better resource (CPU) management for NTNIC PMD.
> 
> The following threads are migrated:
>         * FLM update thread
>         * Statistic thread
>         * Port event thread
>         * Adapter monitoring thread
> Additionally, a warning is added to inform users about the importance of
> dedicating lcores to the DPDK service framework when using the NTNIC PMD.
> The code is also cleaned up to use pthreads and rte_thread APIs.
> 
> After this patch series, an each application using NTNIC PMD should
> dedicate at least five(5) cores for DPDK service framework to ensure
> proper operation of the NTNIC PMD.
> 
> The service cores can be dedicated by EAL options:
>         * s SERVICE COREMASK Hexadecimal bitmask of cores to be used as service cores
>         * S SERVICE CORELIST List of cores to run services on
> Or with a special API by the application itself.
>         * rte_pmd_ntnic_service_set_lcore to map a service to a specific lcore
>         * rte_pmd_ntnic_service_get_id to get a service ID.
> 
> This patch series also includes aligning the naming of the exported symbols to avoid
> potential conflicts with other applications and libraries.
> The main change is to add the prefix "nthw_".
> 
> Serhii Iliushyk (24):
>   net/ntnic: introduce service API for NTNIC PMD
>   net/ntnic: migrate flm update thread to service
>   net/ntnic: migrate statistic thread to service
>   net/ntnic: migrate port event thread to service
>   net/ntnic: migrate adapter mon thread to service
>   net/ntnic: add warning about service cores
>   net/ntnic: avoid using thread API
>   net/ntnic: fix potential format overflow
>   net/ntnic: single file function as static
>   net/ntnic: remove unused functions
>   net/ntnic: move nthw to prefix part
>   net/ntnic: change prefix hw to prefix nthw
>   net/ntnic: modify prefix flow with prefix nthw
>   net/ntnic: change prefix flm to prefix nthw
>   net/ntnic: change prefix nt to prefix nthw
>   net/ntnic: change prefix ntlog to prefix nthw
>   net/ntnic: change prefix km to prefix nthw
>   net/ntnic: change prefix set to prefix nthw
>   net/ntnic: rename common hash and flow functions
>   net/ntnic: rename register ops function
>   net/ntnic: rename get ops functions
>   net/ntnic: rename ops init functions
>   net/ntnic: rename nim agx setup function
>   net/ntnic: rename table ID functions
> 
>  doc/guides/nics/ntnic.rst                     |  112 ++
>  drivers/net/ntnic/adapter/nt4ga_adapter.c     |   41 +-
>  .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |   10 +-
>  drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |   54 +-
>  .../net/ntnic/include/common_adapter_defs.h   |   15 -
>  drivers/net/ntnic/include/create_elements.h   |    9 -
>  drivers/net/ntnic/include/flow_api.h          |   10 +-
>  drivers/net/ntnic/include/flow_api_engine.h   |   18 +-
>  drivers/net/ntnic/include/hw_mod_backend.h    |  281 ++--
>  drivers/net/ntnic/include/nt4ga_adapter.h     |    4 -
>  drivers/net/ntnic/include/ntdrv_4ga.h         |    4 -
>  drivers/net/ntnic/include/ntnic_dbs.h         |   22 +-
>  drivers/net/ntnic/include/ntnic_stat.h        |    2 +-
>  drivers/net/ntnic/include/ntos_drv.h          |    4 +-
>  .../link_mgmt/link_100g/nt4ga_link_100g.c     |  315 ++--
>  .../link_agx_100g/nt4ga_agx_link_100g.c       |  326 ++--
>  drivers/net/ntnic/link_mgmt/nt4ga_link.c      |    2 +-
>  drivers/net/ntnic/meson.build                 |    2 +
>  drivers/net/ntnic/nim/i2c_nim.c               |   10 +-
>  drivers/net/ntnic/nim/i2c_nim.h               |    2 +-
>  .../net/ntnic/nthw/core/include/nthw_fpga.h   |   14 +-
>  .../net/ntnic/nthw/core/include/nthw_hif.h    |   12 -
>  .../net/ntnic/nthw/core/include/nthw_iic.h    |    9 -
>  .../ntnic/nthw/core/include/nthw_mac_pcs.h    |    9 -
>  .../net/ntnic/nthw/core/include/nthw_pcie3.h  |   13 -
>  .../nthw/core/include/nthw_pcm_nt400dxx.h     |    1 -
>  .../ntnic/nthw/core/include/nthw_phy_tile.h   |    2 -
>  .../net/ntnic/nthw/core/include/nthw_rpf.h    |    2 -
>  .../net/ntnic/nthw/core/include/nthw_si5340.h |    2 -
>  .../clock_profiles/nthw_fpga_clk9563.c        |    4 +-
>  .../nthw/core/nt200a0x/nthw_fpga_nt200a0x.c   |    8 +-
>  .../core/nt200a0x/reset/nthw_fpga_rst9563.c   |    8 +-
>  .../nt200a0x/reset/nthw_fpga_rst_nt200a0x.c   |    6 +-
>  .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |    8 +-
>  .../core/nt400dxx/reset/nthw_fpga_rst9574.c   |   22 +-
>  .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |   36 +-
>  drivers/net/ntnic/nthw/core/nthw_fpga.c       |   22 +-
>  drivers/net/ntnic/nthw/core/nthw_hif.c        |   90 --
>  drivers/net/ntnic/nthw/core/nthw_i2cm.c       |    4 +-
>  drivers/net/ntnic/nthw/core/nthw_igam.c       |    4 +-
>  drivers/net/ntnic/nthw/core/nthw_iic.c        |  240 +--
>  drivers/net/ntnic/nthw/core/nthw_mac_pcs.c    |   67 +-
>  drivers/net/ntnic/nthw/core/nthw_pca9532.c    |    2 -
>  drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  |    1 -
>  drivers/net/ntnic/nthw/core/nthw_pcie3.c      |   86 --
>  .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   |    5 -
>  drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |   51 +-
>  drivers/net/ntnic/nthw/core/nthw_rpf.c        |   14 -
>  .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |    3 +-
>  drivers/net/ntnic/nthw/core/nthw_si5340.c     |    6 +-
>  drivers/net/ntnic/nthw/core/nthw_spi_v3.c     |   12 +-
>  drivers/net/ntnic/nthw/dbs/nthw_dbs.c         |   22 +-
>  drivers/net/ntnic/nthw/flow_api/flow_api.c    |  253 ++--
>  .../nthw/flow_api/flow_backend/flow_backend.c | 1342 ++++++++---------
>  drivers/net/ntnic/nthw/flow_api/flow_filter.c |    4 +-
>  .../net/ntnic/nthw/flow_api/flow_hsh_cfg.c    |   46 +-
>  .../net/ntnic/nthw/flow_api/flow_hsh_cfg.h    |    2 +-
>  .../net/ntnic/nthw/flow_api/flow_id_table.c   |   10 +-
>  .../net/ntnic/nthw/flow_api/flow_id_table.h   |   10 +-
>  drivers/net/ntnic/nthw/flow_api/flow_kcc.c    |    2 +-
>  drivers/net/ntnic/nthw/flow_api/flow_km.c     |  134 +-
>  .../nthw/flow_api/hw_mod/hw_mod_backend.c     |   18 +-
>  .../ntnic/nthw/flow_api/hw_mod/hw_mod_cat.c   |  356 ++---
>  .../ntnic/nthw/flow_api/hw_mod/hw_mod_flm.c   |   70 +-
>  .../ntnic/nthw/flow_api/hw_mod/hw_mod_hsh.c   |   14 +-
>  .../ntnic/nthw/flow_api/hw_mod/hw_mod_km.c    |  107 +-
>  .../ntnic/nthw/flow_api/hw_mod/hw_mod_pdb.c   |   40 +-
>  .../ntnic/nthw/flow_api/hw_mod/hw_mod_qsl.c   |   32 +-
>  .../nthw/flow_api/hw_mod/hw_mod_slc_lr.c      |   14 +-
>  .../ntnic/nthw/flow_api/hw_mod/hw_mod_tpe.c   |   80 +-
>  .../flow_api/profile_inline/flm_age_queue.c   |   22 +-
>  .../flow_api/profile_inline/flm_age_queue.h   |   20 +-
>  .../flow_api/profile_inline/flm_lrn_queue.c   |   12 +-
>  .../flow_api/profile_inline/flm_lrn_queue.h   |   12 +-
>  .../profile_inline/flow_api_hw_db_inline.c    | 1138 +++++++-------
>  .../profile_inline/flow_api_hw_db_inline.h    |   99 +-
>  .../profile_inline/flow_api_profile_inline.c  |  598 ++++----
>  .../profile_inline/flow_api_profile_inline.h  |   49 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_cat.c    |  230 +--
>  .../ntnic/nthw/flow_filter/flow_nthw_cat.h    |  230 +--
>  .../ntnic/nthw/flow_filter/flow_nthw_csu.c    |   22 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_csu.h    |   24 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_flm.c    |  278 ++--
>  .../ntnic/nthw/flow_filter/flow_nthw_flm.h    |  278 ++--
>  .../ntnic/nthw/flow_filter/flow_nthw_hfu.c    |   58 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_hfu.h    |   58 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_hsh.c    |   60 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_hsh.h    |   60 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_ifr.c    |   30 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_ifr.h    |   30 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_info.c   |   88 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_info.h   |   88 +-
>  .../net/ntnic/nthw/flow_filter/flow_nthw_km.c |  160 +-
>  .../net/ntnic/nthw/flow_filter/flow_nthw_km.h |  162 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_pdb.c    |   54 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_pdb.h    |   56 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_qsl.c    |   68 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_qsl.h    |   68 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.c |   32 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_rpp_lr.h |   32 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.c |   28 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_slc_lr.h |   28 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.c |   22 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_tx_cpy.h |   22 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.c |   20 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_tx_ins.h |   20 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.c |   42 +-
>  .../ntnic/nthw/flow_filter/flow_nthw_tx_rpl.h |   46 +-
>  .../net/ntnic/nthw/model/nthw_fpga_model.c    |  577 +++----
>  .../net/ntnic/nthw/model/nthw_fpga_model.h    |   28 -
>  drivers/net/ntnic/nthw/nthw_platform.c        |    2 +-
>  drivers/net/ntnic/nthw/nthw_platform_drv.h    |    2 +-
>  drivers/net/ntnic/nthw/nthw_rac.c             |   28 +-
>  .../net/ntnic/nthw/ntnic_meter/ntnic_meter.c  |   20 +-
>  .../nthw/supported/nthw_fpga_mod_str_map.c    |    2 +-
>  .../nthw/supported/nthw_fpga_mod_str_map.h    |    2 +-
>  drivers/net/ntnic/ntlog/ntlog.c               |    6 +-
>  drivers/net/ntnic/ntlog/ntlog.h               |    6 +-
>  drivers/net/ntnic/ntnic_ethdev.c              |  617 ++++----
>  drivers/net/ntnic/ntnic_filter/ntnic_filter.c |   66 +-
>  drivers/net/ntnic/ntnic_mod_reg.c             |   96 +-
>  drivers/net/ntnic/ntnic_mod_reg.h             |  142 +-
>  drivers/net/ntnic/ntnic_vfio.c                |   18 +-
>  drivers/net/ntnic/ntnic_vfio.h                |   12 +-
>  drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c |    4 +-
>  drivers/net/ntnic/ntutil/nt_service.c         |  127 ++
>  drivers/net/ntnic/ntutil/nt_service.h         |   62 +
>  drivers/net/ntnic/ntutil/nt_util.c            |   75 +-
>  drivers/net/ntnic/ntutil/nt_util.h            |   21 +-
>  drivers/net/ntnic/rte_pmd_ntnic.c             |  104 ++
>  drivers/net/ntnic/rte_pmd_ntnic.h             |   26 +
>  131 files changed, 5500 insertions(+), 5449 deletions(-)
>  delete mode 100644 drivers/net/ntnic/include/common_adapter_defs.h
>  create mode 100644 drivers/net/ntnic/ntutil/nt_service.c
>  create mode 100644 drivers/net/ntnic/ntutil/nt_service.h
>  create mode 100644 drivers/net/ntnic/rte_pmd_ntnic.c

Updated to this version in next-net
