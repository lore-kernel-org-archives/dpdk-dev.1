Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9129CEA7950
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 01:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59B754028E;
	Thu,  5 Feb 2026 02:41:49 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 2D87940264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 02:41:48 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so267141f8f.1
 for <dev@dpdk.org>; Wed, 04 Feb 2026 17:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770255708;
 x=1770860508; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3G4BJCMIKt951PLpn1Cu/Vs4mi1IVAO7ACwIYcTtvs=;
 b=Ig3VeKJ5M93llwfKsRGkVWNbw1MSY4lXQ95SK7DKRVzmf0MrhOOhnNXjOxV/lt7BTB
 zOzmoQynVpPpxU0sEv+BYv6zZWGCMhb3AwQIhQWCLCx/q4AqzRI3XP4dVv84Ej4kzbJ0
 8aVzLjejYoroZQpHzstFlqS9NSaEh+ILm9BHSDRlPRLw/Q54id003Nh0sQQkIXjBUKkH
 g9EzO8hpTPFPEYYq9NFMbYZf5AndLbgWODrInHVmmFdpd0tRLu7aZD7omj/LzhNx1hqu
 uWkH32OCGBMHfYFLUmhOxYewy9Vw4wyDd3GSE26d7Vp7NoFSpMlTRmm2Tr189yROa+C8
 2tnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770255708; x=1770860508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s3G4BJCMIKt951PLpn1Cu/Vs4mi1IVAO7ACwIYcTtvs=;
 b=tMQaDqleTN+Z3hhWANQzHBwK6Guv5eFdWbVx2Rp/IeTAGGZCy77XQZeTtKf+59PxpO
 onvihOTJ7T2IyeLhyY3QESg0yLysb1LzeJkUwr7QrWEO15p4RK+yjxbTqo56Kjo8ePRM
 7trNnn1nl8eCbVcsHEk7lSjE2LyRZdAcDmGZ43Dxe5I+nE7D3VYDpehy2gLLsgiZr98X
 ImMiAgwNf9Qf3tCxQ24+8TN+77TivDuciUml2f8LTrv5EcAcL+hUSdlwSi4uuk7coR33
 GHuvqZLrZLd5cqHK6r6JNmbNDWZDaPnTvm2kIlmeWBiEBsjAxcwnAo5ST+Wg4L/r8g4x
 uKIg==
X-Gm-Message-State: AOJu0YwAJPer5NbDG5OC8XeXWL3dfOxz6wCvhM+vwsd39xVmIN5JwZjd
 5Wtk4GCa/9JatlcfL/N6NXXeZwPwsia3/X/pLiqSQ4YyHzUbDe51Ny1rvXySZU2EtgvRbfcjwS7
 lXS44
X-Gm-Gg: AZuq6aKRjr5e8JzsgUSk8GlDQFRsqsjQoaQPjr9A7vEzpkD9PFot1tcX2/lVuy15hQC
 emhSvlOZqbnwsevlpIURoPCl4wno73C5PJj02hRHsEspmI03k4Rb731WM6ls2xhZTFkS34M8450
 MXbaY8hQOkvUNmC2klJ64Bjh+RvTYQ9AQhZRa+9isnNHOC6wtNrlpbKTqFiOUenXqZl3H/6W3bp
 h/IY/2tNU3/dIif7NHiB/z5V6jhClEvtyq/hlByVmQqGyASp6XOg4z8w8raEK0Q2kV+2vWDL9lQ
 5ZuNnvd31HXl9A49bcgINI4Qf0pU4wgc/Gvbx1ePHzS3jblcuLTKUux+Ck1T+RnFVXqiTJPFlEq
 TugADTmBga55l6q3ujJVXkJcLoPmlpyJhVNLQv/qTMgc+B74VVVyLDvKQ4uLxRQ5HY85Y/GJTZP
 1j8xR+3z6J1dwCe0HLHrGsMmrMryupwkvkrJvfStyAQXri0wUHBinD
X-Received: by 2002:a05:6000:2210:b0:435:932e:f932 with SMTP id
 ffacd0b85a97d-436213d78eamr1775913f8f.7.1770255707647; 
 Wed, 04 Feb 2026 17:41:47 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e250bdsm10520084f8f.2.2026.02.04.17.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 17:41:47 -0800 (PST)
Date: Wed, 4 Feb 2026 17:41:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/2] standardize SPDX tag
Message-ID: <20260204174140.39e39ec1@phoenix.local>
In-Reply-To: <20260204204945.3893117-1-thomas@monjalon.net>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <20260204204945.3893117-1-thomas@monjalon.net>
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

On Wed,  4 Feb 2026 21:46:04 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> SPDX lines are fixed to be more standard,
> and the checker is improved to detect some of the fixed issues.
> For readability, the script changes are in a separate patch,
> but for the sake of atomicity, the patches should be squashed.
> 
> v2: update the script and README, and remove useless parentheses
> v3: keep Linux uAPI imported file untouched
> 
> Thomas Monjalon (2):
>   license: standardize SPDX tag
>   devtools: check SPDX syntax
> 
>  devtools/check-spdx-tag.sh                    | 33 +++++++++++++++++--
>  doc/guides/contributing/patches.rst           |  2 +-
>  doc/guides/eventdevs/dpaa.rst                 |  2 +-
>  drivers/bus/dpaa/base/fman/fman.c             |  2 +-
>  drivers/bus/dpaa/base/fman/netcfg_layer.c     |  2 +-
>  drivers/bus/dpaa/base/qbman/bman.c            |  2 +-
>  drivers/bus/dpaa/base/qbman/bman.h            |  2 +-
>  drivers/bus/dpaa/base/qbman/bman_driver.c     |  2 +-
>  drivers/bus/dpaa/base/qbman/bman_priv.h       |  2 +-
>  drivers/bus/dpaa/base/qbman/dpaa_alloc.c      |  2 +-
>  drivers/bus/dpaa/base/qbman/dpaa_sys.c        |  2 +-
>  drivers/bus/dpaa/base/qbman/dpaa_sys.h        |  2 +-
>  drivers/bus/dpaa/base/qbman/process.c         |  2 +-
>  drivers/bus/dpaa/base/qbman/qman.c            |  2 +-
>  drivers/bus/dpaa/base/qbman/qman.h            |  2 +-
>  drivers/bus/dpaa/base/qbman/qman_driver.c     |  2 +-
>  drivers/bus/dpaa/base/qbman/qman_priv.h       |  2 +-
>  drivers/bus/dpaa/include/fman.h               |  2 +-
>  drivers/bus/dpaa/include/fsl_bman.h           |  2 +-
>  drivers/bus/dpaa/include/fsl_fman.h           |  2 +-
>  drivers/bus/dpaa/include/fsl_fman_crc64.h     |  2 +-
>  drivers/bus/dpaa/include/fsl_qman.h           |  2 +-
>  drivers/bus/dpaa/include/fsl_usd.h            |  2 +-
>  drivers/bus/dpaa/include/netcfg.h             |  2 +-
>  drivers/bus/dpaa/include/process.h            |  2 +-
>  drivers/bus/fslmc/mc/dpbp.c                   |  2 +-
>  drivers/bus/fslmc/mc/dpci.c                   |  2 +-
>  drivers/bus/fslmc/mc/dpcon.c                  |  2 +-
>  drivers/bus/fslmc/mc/dpio.c                   |  2 +-
>  drivers/bus/fslmc/mc/dpmng.c                  |  2 +-
>  drivers/bus/fslmc/mc/dprc.c                   |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpbp.h               |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpbp_cmd.h           |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpci.h               |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpci_cmd.h           |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpcon.h              |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpcon_cmd.h          |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpio.h               |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpio_cmd.h           |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpmng.h              |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpmng_cmd.h          |  2 +-
>  drivers/bus/fslmc/mc/fsl_dpopr.h              |  2 +-
>  drivers/bus/fslmc/mc/fsl_dprc.h               |  2 +-
>  drivers/bus/fslmc/mc/fsl_dprc_cmd.h           |  2 +-
>  drivers/bus/fslmc/mc/fsl_mc_cmd.h             |  2 +-
>  drivers/bus/fslmc/mc/fsl_mc_sys.h             |  2 +-
>  drivers/bus/fslmc/mc/mc_sys.c                 |  2 +-
>  drivers/common/dpaax/caamflib.c               |  2 +-
>  drivers/common/dpaax/caamflib/compat.h        |  2 +-
>  drivers/common/dpaax/caamflib/desc.h          |  2 +-
>  drivers/common/dpaax/caamflib/desc/algo.h     |  2 +-
>  drivers/common/dpaax/caamflib/desc/common.h   |  2 +-
>  drivers/common/dpaax/caamflib/desc/ipsec.h    |  2 +-
>  drivers/common/dpaax/caamflib/desc/pdcp.h     |  2 +-
>  drivers/common/dpaax/caamflib/rta.h           |  2 +-
>  .../dpaax/caamflib/rta/fifo_load_store_cmd.h  |  2 +-
>  .../common/dpaax/caamflib/rta/header_cmd.h    |  2 +-
>  drivers/common/dpaax/caamflib/rta/jump_cmd.h  |  2 +-
>  drivers/common/dpaax/caamflib/rta/key_cmd.h   |  2 +-
>  drivers/common/dpaax/caamflib/rta/load_cmd.h  |  2 +-
>  drivers/common/dpaax/caamflib/rta/math_cmd.h  |  2 +-
>  drivers/common/dpaax/caamflib/rta/move_cmd.h  |  2 +-
>  drivers/common/dpaax/caamflib/rta/nfifo_cmd.h |  2 +-
>  .../common/dpaax/caamflib/rta/operation_cmd.h |  2 +-
>  .../common/dpaax/caamflib/rta/protocol_cmd.h  |  2 +-
>  .../dpaax/caamflib/rta/sec_run_time_asm.h     |  2 +-
>  .../dpaax/caamflib/rta/seq_in_out_ptr_cmd.h   |  2 +-
>  .../common/dpaax/caamflib/rta/signature_cmd.h |  2 +-
>  drivers/common/dpaax/caamflib/rta/store_cmd.h |  2 +-
>  drivers/common/dpaax/compat.h                 |  2 +-
>  drivers/common/dpaax/dpaa_of.c                |  2 +-
>  drivers/common/dpaax/dpaa_of.h                |  2 +-
>  drivers/common/qat/qat_adf/adf_pf2vf_msg.h    |  2 +-
>  .../qat/qat_adf/adf_transport_access_macros.h |  2 +-
>  .../adf_transport_access_macros_gen4.h        |  2 +-
>  .../adf_transport_access_macros_gen4vf.h      |  2 +-
>  .../adf_transport_access_macros_gen_lce.h     |  2 +-
>  .../adf_transport_access_macros_gen_lcevf.h   |  2 +-
>  drivers/common/qat/qat_adf/icp_qat_fw.h       |  2 +-
>  drivers/common/qat/qat_adf/icp_qat_fw_comp.h  |  2 +-
>  drivers/common/qat/qat_adf/icp_qat_fw_la.h    |  2 +-
>  drivers/common/qat/qat_adf/icp_qat_hw.h       |  2 +-
>  .../common/qat/qat_adf/icp_qat_hw_gen4_comp.h |  2 +-
>  .../qat/qat_adf/icp_qat_hw_gen4_comp_defs.h   |  2 +-
>  drivers/crypto/dpaa2_sec/mc/dpseci.c          |  2 +-
>  drivers/crypto/dpaa2_sec/mc/fsl_dpseci.h      |  2 +-
>  drivers/crypto/dpaa2_sec/mc/fsl_dpseci_cmd.h  |  2 +-
>  drivers/crypto/qat/qat_sym_session.c          |  2 +-
>  drivers/event/dpaa/dpaa_eventdev.c            |  2 +-
>  drivers/event/dpaa/dpaa_eventdev.h            |  2 +-
>  drivers/net/atlantic/atl_hw_regs.c            |  5 +--
>  drivers/net/atlantic/atl_hw_regs.h            |  5 +--
>  drivers/net/atlantic/hw_atl/hw_atl_b0.c       |  5 +--
>  drivers/net/atlantic/hw_atl/hw_atl_b0.h       |  5 +--
>  .../net/atlantic/hw_atl/hw_atl_b0_internal.h  |  5 +--
>  drivers/net/atlantic/hw_atl/hw_atl_llh.c      |  5 +--
>  drivers/net/atlantic/hw_atl/hw_atl_llh.h      |  5 +--
>  .../net/atlantic/hw_atl/hw_atl_llh_internal.h |  5 +--
>  drivers/net/atlantic/hw_atl/hw_atl_utils.c    |  5 +--
>  drivers/net/atlantic/hw_atl/hw_atl_utils.h    |  5 +--
>  .../net/atlantic/hw_atl/hw_atl_utils_fw2x.c   |  5 +--
>  drivers/net/avp/rte_avp_common.h              |  2 +-
>  drivers/net/avp/rte_avp_fifo.h                |  2 +-
>  drivers/net/bnxt/bnxt_nvm_defs.h              |  2 +-
>  drivers/net/dpaa/fmlib/dpaa_integration.h     |  2 +-
>  drivers/net/dpaa/fmlib/ncsw_ext.h             |  2 +-
>  drivers/net/dpaa/fmlib/net_ext.h              |  2 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c              |  8 ++---
>  drivers/net/dpaa2/dpaa2_recycle.c             |  6 ++--
>  drivers/net/dpaa2/dpaa2_sparser.h             |  4 +--
>  drivers/net/dpaa2/mc/dpdmux.c                 |  2 +-
>  drivers/net/dpaa2/mc/dpkg.c                   |  2 +-
>  drivers/net/dpaa2/mc/dpni.c                   |  2 +-
>  drivers/net/dpaa2/mc/dprtc.c                  |  2 +-
>  drivers/net/dpaa2/mc/fsl_dpdmux.h             |  2 +-
>  drivers/net/dpaa2/mc/fsl_dpdmux_cmd.h         |  2 +-
>  drivers/net/dpaa2/mc/fsl_dpkg.h               |  2 +-
>  drivers/net/dpaa2/mc/fsl_dpmac.h              |  2 +-
>  drivers/net/dpaa2/mc/fsl_dpni.h               |  2 +-
>  drivers/net/dpaa2/mc/fsl_dpni_cmd.h           |  2 +-
>  drivers/net/dpaa2/mc/fsl_dprtc.h              |  2 +-
>  drivers/net/dpaa2/mc/fsl_dprtc_cmd.h          |  2 +-
>  drivers/net/dpaa2/mc/fsl_net.h                |  2 +-
>  drivers/net/mlx5/mlx5_flow_meter.c            |  3 +-
>  lib/eal/include/rte_pci_dev_feature_defs.h    |  2 +-
>  lib/eal/include/rte_pci_dev_features.h        |  2 +-
>  license/README                                |  4 +--
>  127 files changed, 183 insertions(+), 150 deletions(-)
> 


LGTM.
Maybe spdx check script would be easier to manage in python?
Could also use it to flag anything outside the expected.
