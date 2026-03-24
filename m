Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC83F532CB
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 03:32:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6936C402D6;
	Tue, 24 Mar 2026 04:32:01 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 337744027C
 for <dev@dpdk.org>; Tue, 24 Mar 2026 04:32:00 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12a80c36350so2158886c88.1
 for <dev@dpdk.org>; Mon, 23 Mar 2026 20:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774323119;
 x=1774927919; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVADlrMPBhsAQ6xeAxC5O6C1DyfrqXMsdEj1V7NLY5E=;
 b=t8LhaHQHFYR5s534Klz6u9we2wW3W7lg22VCQN5UZ6W6tSpK9rMDuaxiIyxP6NlLHa
 CvkJxWaz7gaI0PZm90eOiudr/vHASIXJ/EXUDIFxkFscmgQ5iGdNzf722qb0KJYuMDAa
 AjdeSIL8svchxDmGntIBsY1TsAlGcNz+EnSjVMVw0OcgONgNAVDbIHtajX5n4vs5BRcn
 GTZO4zwU53Zp2c56kt0LUtl1iwXU4Cn5vY4coSibuqIWKOXo8iFkK5Dw7g0ZfTDHK4h4
 boGJ47arfDiYWBXr3Jyzht5DmrCSLlhNBhnVRSdrsQXyVPITTjsCYxHI26VRbuMsVafg
 b7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774323119; x=1774927919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mVADlrMPBhsAQ6xeAxC5O6C1DyfrqXMsdEj1V7NLY5E=;
 b=Q09dtd4lhL8rH6X0e7Rkj0+lSMOIJviANLx34g2hzAwN2P+S6kbfLP/YCYMu3pRZNn
 iqP0NdORmI+mxZcH2qBVD8F4aOdpe8ORWyjhHlVFzgzKq7tnETcmwEkJQQRyWHq90wKC
 vAhjtiU2aEM/sYij3OdvlqUfC3FclH3rSO6JRqTGT1tHQoKbjne9qSyDscAXK40J3jxR
 Iazc3GM+h99TdNUy5NMvk/v0aAXKsUNBLsf8HBbIfWeBRHpTGwHeQJ28fm15hhLCL14L
 Hd5zkj7KAIBPpMNl6RFPnelxzK8M6kwVpDiQ6lvgGN7mEoir40LS0rn5JvB1ahBINVUt
 NPAQ==
X-Gm-Message-State: AOJu0YzoOwQyR8JzUAFjMsw+p8P3aI7hcZer429pShkwbk/C16BkkE1f
 r100Elqv45e2+purImDSARflSyWWGmjLFJSWCop9bA1lzGf5lvCqWFikV32pq/5VnOA=
X-Gm-Gg: ATEYQzwlcACG3N7yUUEHzU05GdwxCKr07KPdzeRPfs48JnmCXz9jD4XEDc22R0fvDtv
 HmSYjcW/tI+/8rbhw7DgSRBX8BluVfikO1msIdQH2GCTi95cFZCpdoL3bMEdnSqV6hF/EwJa4QA
 Dk8RYgJEoXou5yfikB0zTj5gZ8wcdUz81McdqVwr/voZabu8HVV40ZCU6zVP4ZHI7i/cRNC/IhL
 GXpSzR/wtxlF/4JU3NdsjoxXKMDl1RcrtXAnJKLnPEzZxP57yl0fzu1YpUKZAAVPb7poxCP2icX
 gAN0LPhGf3rPv9WvmM6GPoJT8DbahUefgo5Vg+uOLvWIyEoRsbSFv1E0hBdC3XOw/ghLxcq63jh
 dsiVCF/qv8Uvkz/PJKfDR9x2d0I3iHmiE3fhnFIvFu8bqiDYMJsZIuEl7d7GsDdkMCqvFTraj8R
 4aPQrE1DiXSuHycLG4eidhYMi9vJDSHji1Htw=
X-Received: by 2002:a05:7022:6292:b0:123:330b:398 with SMTP id
 a92af1059eb24-12a726b28e2mr6248628c88.19.1774323119015; 
 Mon, 23 Mar 2026 20:31:59 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a733dd8c0sm10463371c88.5.2026.03.23.20.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 20:31:58 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:31:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [PATCH v8 0/7] hinic3 change for support new SPx NIC
Message-ID: <20260323203153.4262c1aa@phoenix.local>
In-Reply-To: <20260324015516.201-1-wff_light@vip.163.com>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260324015516.201-1-wff_light@vip.163.com>
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

On Tue, 24 Mar 2026 09:55:03 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Feifei Wang <wangfeifei40@huawei.com>
> 
> Change hinic3 driver to support Huawei new SPx series NIC.
> 
> v2:
> --fix build issues
> 
> v3:
> --fix community review comments and err reports
> 
> v4:
> --fix rss type assignment error
> 
> v5:
> --fix community ubuntu-22.04-clang err
> 
> v6:
> --fix atomic compilation error
> 
> v6:
> --fix community review comments
> 
> v7:
> --fix htn/stn ops function name error
> --update doc/guides for hinic3 driver
> 
> v8:
> --fix guides grammar issue
> --fix rss_type.ipv6_ext = 0 error
> 
> Feifei Wang (7):
>   net/hinic3: add support for new SPx series NIC
>   net/hinic3: add enhance cmdq support for new SPx series NIC
>   net/hinic3: use different callback func to split new/old cmdq
>     operations
>   net/hinic3: add fun init ops to support Compact CQE
>   net/hinic3: add rx ops to support Compact CQE
>   net/hinic3: add tx ops to support Compact CQE
>   net/hinic3: use different callback func to support htn fdir
> 
>  doc/guides/nics/features/hinic3.ini           |  11 +-
>  doc/guides/nics/hinic3.rst                    |   5 +-
>  doc/guides/rel_notes/release_26_03.rst        |   8 +
>  drivers/net/hinic3/base/hinic3_cmd.h          |  80 ++-
>  drivers/net/hinic3/base/hinic3_cmdq.c         | 370 ++++------
>  drivers/net/hinic3/base/hinic3_cmdq.h         | 112 ++-
>  drivers/net/hinic3/base/hinic3_cmdq_enhance.c | 111 +++
>  drivers/net/hinic3/base/hinic3_cmdq_enhance.h | 125 ++++
>  drivers/net/hinic3/base/hinic3_csr.h          |  18 +-
>  drivers/net/hinic3/base/hinic3_hw_comm.c      |  15 +-
>  drivers/net/hinic3/base/hinic3_hw_comm.h      |  31 +-
>  drivers/net/hinic3/base/hinic3_hwdev.c        |  13 +-
>  drivers/net/hinic3/base/hinic3_hwdev.h        |  18 +
>  drivers/net/hinic3/base/hinic3_hwif.c         |  10 +-
>  drivers/net/hinic3/base/hinic3_mgmt.c         |   5 +-
>  drivers/net/hinic3/base/hinic3_mgmt.h         |   2 +
>  drivers/net/hinic3/base/hinic3_nic_cfg.c      | 182 ++---
>  drivers/net/hinic3/base/hinic3_nic_cfg.h      |  98 ++-
>  drivers/net/hinic3/base/meson.build           |   1 +
>  drivers/net/hinic3/hinic3_ethdev.c            | 275 ++++++--
>  drivers/net/hinic3/hinic3_ethdev.h            | 120 ++--
>  drivers/net/hinic3/hinic3_fdir.c              | 657 +++++++++++++-----
>  drivers/net/hinic3/hinic3_fdir.h              | 361 ++++++++--
>  drivers/net/hinic3/hinic3_nic_io.c            | 525 ++++++--------
>  drivers/net/hinic3/hinic3_nic_io.h            | 163 ++++-
>  drivers/net/hinic3/hinic3_rx.c                | 267 +++++--
>  drivers/net/hinic3/hinic3_rx.h                | 182 ++++-
>  drivers/net/hinic3/hinic3_tx.c                | 456 ++++++------
>  drivers/net/hinic3/hinic3_tx.h                | 154 +++-
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 167 +++++
>  .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  63 ++
>  drivers/net/hinic3/htn_adapt/meson.build      |   7 +
>  drivers/net/hinic3/meson.build                |   8 +-
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 151 ++++
>  .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  46 ++
>  drivers/net/hinic3/stn_adapt/meson.build      |   7 +
>  36 files changed, 3379 insertions(+), 1445 deletions(-)
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.c
>  create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.h
>  create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
>  create mode 100644 drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
>  create mode 100644 drivers/net/hinic3/htn_adapt/meson.build
>  create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
>  create mode 100644 drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
>  create mode 100644 drivers/net/hinic3/stn_adapt/meson.build
> 

Here is list of places identified by AI that use rte_zmalloc but
may not need to.

Places where rte_zmalloc is used but not needed in hinic3 driver.

rte_zmalloc allocates from hugepage memory. It should only be used
when the memory will be accessed by DMA, shared between primary and
secondary DPDK processes, or requires specific NUMA node placement.
For ordinary control-plane data structures, standard calloc/free
is faster and does not consume limited hugepage resources.

The following allocations are pure software bookkeeping and do not
require hugepage memory:

Temporary buffers (allocated and freed in the same function):
  hinic3_rx.c: hinic3_refill_indir_rqid() - indir_tbl array
  hinic3_nic_cfg.c: hinic3_get_phy_port_stats() - port_stats struct

Command queue bookkeeping:
  hinic3_cmdq.c: hinic3_alloc_cmd_buf() - cmd_buf wrapper struct
  hinic3_cmdq.c: init_cmdq() - cmdq->errcode array
  hinic3_cmdq.c: init_cmdq() - cmdq->cmd_infos array
  hinic3_cmdq.c: hinic3_init_cmdqs() - cmdqs struct
  hinic3_cmdq.c: hinic3_init_cmdqs() - cmdqs->saved_wqs array

Event queue tracking arrays (track DMA pages but are not DMA'd):
  hinic3_eqs.c: alloc_eq_pages() - eq->dma_addr array
  hinic3_eqs.c: alloc_eq_pages() - eq->virt_addr array
  hinic3_eqs.c: alloc_eq_pages() - eq->eq_mz array
  hinic3_eqs.c: hinic3_aeqs_init() - aeqs struct

Mailbox and management channel buffers:
  hinic3_mbox.c: init_mbox_info() - mbox_info->mbox buffer
  hinic3_mbox.c: init_mbox_info() - mbox_info->buf_out buffer
  hinic3_mbox.c: hinic3_func_to_func_init() - func_to_func struct
  hinic3_mgmt.c: alloc_recv_msg() - recv_msg->msg buffer (x2)
  hinic3_mgmt.c: alloc_msg_buf() - mgmt_ack_buf buffer
  hinic3_mgmt.c: hinic3_pf_to_mgmt_init() - pf_to_mgmt struct

Configuration and control structs:
  hinic3_hw_cfg.c: init_cfg_mgmt() - cfg_mgmt struct
  hinic3_hwdev.c: hinic3_init_comm_ch() - chip_fault_stats buffer
  hinic3_hwif.c: hinic3_hwif_res_init() - hwif struct
  hinic3_ethdev.c: hinic3_init_sw_rxtxqs() - txqs pointer array
  hinic3_ethdev.c: hinic3_init_sw_rxtxqs() - rxqs pointer array
  hinic3_ethdev.c: hinic3_func_init() - hwdev struct
  hinic3_ethdev.c: hinic3_func_init() - mc_list MAC address array
  hinic3_ethdev.c: hinic3_enable_interrupt() - intr_vec array

Flow director and flow API:
  hinic3_fdir.c: hinic3_alloc_dynamic_block_resource() - tcam block
  hinic3_fdir.c: hinic3_add_tcam_filter() - tcam_filter struct
  hinic3_flow.c: hinic3_flow_create() - filter_rules struct
  hinic3_flow.c: hinic3_flow_create() - flow struct

New allocations added by this patch series:
  hinic3_ethdev.c: hinic3_func_init() - cmdq_ops table
  hinic3_ethdev.c: hinic3_func_init() - rx_ops table
  hinic3_ethdev.c: hinic3_func_init() - tx_ops table

Note: eth_dev->data->mac_addrs must remain rte_zmalloc because the
ethdev framework frees it with rte_free. The rte_zmalloc_socket
calls for rxq, txq, rx_info, and tx_info are correct because those
are hot-path queue structures that benefit from NUMA-local placement.
