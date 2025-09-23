Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDF6CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 16:02:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C53040615;
	Tue, 23 Sep 2025 18:02:21 +0200 (CEST)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43]) by mails.dpdk.org (Postfix) with ESMTP id 1D128402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 18:02:19 +0200 (CEST)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-6352c8b683eso2811750d50.2
 for <dev@dpdk.org>; Tue, 23 Sep 2025 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758643338;
 x=1759248138; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKz+9D8BvGwCmzY9wBmXVj8X7/tGldhpazoRjGw0dLs=;
 b=QK8GUOxk3edRaB4nv4riBYegHP3xm2DW0aMZtDSQtJU3Z28YyHge3YtNfwr0P4HCdu
 Wks6zN2LBXDv6sI4fa1XSVXNnhfno+yZ+0xFfqwOLvnriXOxrdNLksrTAVCc7N5wJcnL
 z8U85k6Rup91zDGSIYXwrvD8BznqYgPmf2wcV33RIjUoWDhfOkRf1E5Y19f23yy2JJ2i
 qralFr8ugi+7DA6XgAo/bo6Gj1x0CXHd/fZm8SCisu8NozGshLYz5O7qzOcKdJr+2FtQ
 C576P5oBoWJdf8lTFC4kgffm8bgo6haXEJWMR+dSg1fM6kF6ypt1u9ZVrK66eTeIVR6/
 hwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758643338; x=1759248138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKz+9D8BvGwCmzY9wBmXVj8X7/tGldhpazoRjGw0dLs=;
 b=ijWbalfQEcw0ciOuaSa81mnLgZfBRjOJQ+xlknWHrUMOa9WUXsat4J9g6IS/Mf1/rw
 3caXfUS7lQkLNLPDHwBm38rHf1oq+YjgedquoI88cSQiVLoXVn8zZ4Ep/xzMj0Afu5RY
 fz6QnzqCeZK94IJMQqJCzVtGeiEfJrACHnevo6rgW1oZhluMlSoHEsFd4FAlVlxYWvM2
 nBf6LZwblVd0BJbxiKkMR5EBYdSNwDxzkMNplLF05p3rFVoVrHkJUIsYeScco/htSE63
 iO67N5hwLH9r3et7pGyZuw+1cEW3180kr84NLnYr87M5JMgIyIGz9wTjwo85dre88MCN
 i+7g==
X-Gm-Message-State: AOJu0Yy4DMr7yxJytuGHf0vdudmKVJFrZs2oIYuLn5fVHBXOtJGV0Fem
 6LxCi11puBPaCgYIw9tFb1+8KN3dS3ZL17GC6i5yviHqN/+y/TcqoBsWcGGgnv+QGGI=
X-Gm-Gg: ASbGncv8YWO7k8vwFrngGOQKhLAP28CHE/Kb9WOp9jwrIcYN6NBvazSx5Y+6RRVk8kw
 RJYh2bKMZdKbc5o+4rvZ5Jm3MrzbtEVp1KR3o2cKE7FY3RpdwYeDd0MupDdjrl6cz40j22e5UHu
 eI9jxfjKyAGSokRaP3qctMp3Pw/UMq82a+QDc0iHlmmSZS8COkSq9wSHvg3VYTNN9wHPF/dxiPC
 x6Eac3G9iH4/cr68j4rd/q8TIE2+pVYsCwGz6jmKEMgbuM+ICNBmOiHpNJHYMbt3aZqDkoZBRKV
 1oJBno7s8XSATD8vyoora9r4UzYgbfGsg5uA+C0M9emjjmN7zYzUmoPzvhyEA2E4Xq6BH535Gl2
 Jc+gEBTk3AGNDMtACBCC+E4vmWsUPTv/MR5dxwxcswOiCNm8n4MY9ow/mCcRz3E9WwNKd1lXS3E
 4Nt4AGFTzl7mooK8vNvA==
X-Google-Smtp-Source: AGHT+IGQtwbK0GkE/Y/wnGN2aKpDstMcaI5RwnqIPSyL5k4w6oDAdt6fuE8OduTxNCRelbbB017i7Q==
X-Received: by 2002:a53:eb91:0:b0:632:e9f0:768c with SMTP id
 956f58d0204a3-6360463d061mr1941701d50.24.1758643336614; 
 Tue, 23 Sep 2025 09:02:16 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-83631a7fb5esm981956385a.55.2025.09.23.09.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 09:02:16 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:02:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com
Subject: Re: [PATCH v1 00/16] refactoring naming the for exported symbols
Message-ID: <20250923090212.521acb23@hermes.local>
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
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

On Fri, 19 Sep 2025 11:14:45 +0200
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> This patch series dedicates to align the naming if the exported symbols in order to avoid
> potential conflicts with other application and libraries.
> The main change is to add the prefix "nthw_".
> 
> Serhii Iliushyk (16):
>   net/ntnic: single file function as static
>   net/ntnic: remove unused functions
>   net/ntnic: move nthw_ to prefix
>   net/ntnic: change prefix hw_ to prefix nthw_
>   net/ntnic: modify prefix flow_ with prefix nthw_
>   net/ntnic: change prefix flm_ to prefix nthw_flm_
>   net/ntnic: change prefix nt_ to prefix nthw_
>   net/ntnic: change prefix ntlog_ to prefix nthw_log
>   net/ntnic: change prefix km_ to prefix nthw_km_
>   net/ntnic: change prefix set_ to prefix nthw_set_
>   net/ntnic: rename common hash and flow functions
>   net/ntnic: rename register ops function
>   net/ntnic: rename get ops functions
>   net/ntnic: rename ops_init functions
>   net/ntnic: rename nim agx setup function
>   net/ntnic: rename table id functions
> 
>  drivers/net/ntnic/adapter/nt4ga_adapter.c     |   14 +-
>  .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |   10 +-
>  drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |   54 +-
>  drivers/net/ntnic/include/create_elements.h   |    9 -
>  drivers/net/ntnic/include/flow_api.h          |   10 +-
>  drivers/net/ntnic/include/flow_api_engine.h   |   18 +-
>  drivers/net/ntnic/include/hw_mod_backend.h    |  281 ++--
>  drivers/net/ntnic/include/ntnic_dbs.h         |   22 +-
>  .../link_mgmt/link_100g/nt4ga_link_100g.c     |   14 +-
>  .../link_agx_100g/nt4ga_agx_link_100g.c       |   22 +-
>  drivers/net/ntnic/link_mgmt/nt4ga_link.c      |    2 +-
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
>  drivers/net/ntnic/nthw/core/nthw_pcie3.c      |   86 --
>  .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   |    5 -
>  drivers/net/ntnic/nthw/core/nthw_phy_tile.c   |   51 +-
>  drivers/net/ntnic/nthw/core/nthw_rpf.c        |   14 -
>  .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |    2 +-
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
>  .../profile_inline/flow_api_profile_inline.c  |  596 ++++----
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
>  drivers/net/ntnic/ntnic_ethdev.c              |  108 +-
>  drivers/net/ntnic/ntnic_filter/ntnic_filter.c |   49 +-
>  drivers/net/ntnic/ntnic_mod_reg.c             |   96 +-
>  drivers/net/ntnic/ntnic_mod_reg.h             |  142 +-
>  drivers/net/ntnic/ntnic_vfio.c                |   18 +-
>  drivers/net/ntnic/ntnic_vfio.h                |   12 +-
>  drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c |    4 +-
>  drivers/net/ntnic/ntutil/nt_util.c            |   73 +-
>  drivers/net/ntnic/ntutil/nt_util.h            |   21 +-
>  118 files changed, 4434 insertions(+), 4887 deletions(-)
> 

Looks good but I ended up pulling out the ntnic driver service changes
because of the error detected on build with fortify (string format overflow).

When you resubmit the ntnic driver you can either merge these
changes into that, or just add these patches as after thought.

