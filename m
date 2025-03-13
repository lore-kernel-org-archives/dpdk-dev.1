Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B01C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A190D4114B;
	Thu, 13 Mar 2025 18:17:27 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id F40D141141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:17:25 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-225d66a4839so10210645ad.1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741886245;
 x=1742491045; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EIhFuRlfad1gVH1Z7jgBnYw0wu64PYbySlUZlCf11Eg=;
 b=Vw0TU9egdv9PLOqTH6RX8NqgcH0XJ1g6vMdfx5XYx5OxjNVVof0yBER41NQBMbBJk6
 D5imwpeH9fATKyiYjgnUWAlK5nS9BjB3ySQt5OI30h6wkHLroE2QrjrUmVBsGUrnLngD
 iAW1BQhx6PgL37wfzhuh8z2pDmUhydZ5ivHVL26Z6AbZHdrTkClfKRMK/7mV+CNUyY6d
 JA4Jn1/GH6mXF7IMyhVlSalWsY2jKWk0WcMdWZRo3pK1oyll6RA/s1bEMTvzfeZi2DZp
 LtH4YLwoi2W2gAN3W3ghQIF5EU5aDW1lO4AU23R5Pq/xXeiw2oq9qGg2Cgy9hpoBUH6f
 pnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741886245; x=1742491045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EIhFuRlfad1gVH1Z7jgBnYw0wu64PYbySlUZlCf11Eg=;
 b=n0DOsPLtOrVVwJvUp47xsglpuxofimjWJS+Afh6w4WBRbSEwk9QxGMATS+BjsomYfL
 g9AtXbEoNzuKJW7M8+u98ksh+Kxc+M1mXF0XIl/SdL8SnPSP54sPtOq/vJdWo5GdkXea
 A+rHBWxVyOwuwiM11PImUxiDtcbi6dr9grCPAD47jxvLWjek93k8moigdWuqEWo9Co5L
 gGw39vPz8TklO3z/yd/iWORvZ1akYUY9UuJXSMqM4l6pdmYOXvNnkN4Na3YzcZCwzMCV
 AQdVwtUVwcASjh0GTsiPt+QUhl2Ud8OqGQc3cWZeJuQEYbi9QHaF4ICJmbq7JYwtAvQY
 bDZQ==
X-Gm-Message-State: AOJu0YyR9bgsRX0O7B6Xe5ehWLx5CFW1zoPuy58n4gbwpha2MjqQilS0
 b+h118ygR+ITCm62P+H2fzbczG+y48QIO40aikafPrj6kDnHn0Gp53qWBnKxSHKqdaUE2ifnfPG
 Z
X-Gm-Gg: ASbGncu1dh3lWPhKZHaZUoPozB7b30qlohRfu4bqfWWgNbjHC8y+8D/TxhqOKqa1ap5
 rlvpMJdiRchYmaSEppVrcS6MKJgwsAEMPz4KPXf7ye8tl3mbXzJjHiGEcOPEzevuobZiIC46vVZ
 cp8CpC13xmc7GQjEXXgj8wfJ6jEu4U4ItOxdcaT8hHiWbRvkBCEakbHQfjCA2DqHRU1tGsdrazK
 vo1UuO8BvWngbV4xoGLebuy+4LEsPzyJ2frY8hKaB0DWkzwsm1rdYezMdcpiYA71AksL2IoHGNf
 p7d0CLQstM8DMbdSkEZwkqUXBaHz+esaFFpImCcsV69dkKBzTAYoDinkImWFS2Zj8PnPx4Z1wRE
 79fZxWym6Aaa+faBHo+dV3w==
X-Google-Smtp-Source: AGHT+IF2teXCh7EBgoMtWGwnq4IdqhSJvNQQZ29puZV7D3UXT51gLtVAc8pUOWqpyiqzB3OqASQZ8w==
X-Received: by 2002:a05:6a00:9293:b0:736:491b:5370 with SMTP id
 d2e1a72fcca58-7371073f919mr4575973b3a.10.1741886245018; 
 Thu, 13 Mar 2025 10:17:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371169c3desm1576691b3a.155.2025.03.13.10.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 10:17:24 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:17:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com, thomas@monjalon.net
Subject: Re: [PATCH v1] net/ntnic: fix incorrect initializations
Message-ID: <20250313101723.2d9f154a@hermes.local>
In-Reply-To: <20250313164204.858692-1-sil-plv@napatech.com>
References: <20250313164204.858692-1-sil-plv@napatech.com>
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

On Thu, 13 Mar 2025 17:42:03 +0100
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> Compiling without enabled RTE_ASSERT leads to an error during
> initialization
> Fix incorrect assert conditions
> 
> Fixes: ff04525d90d3 ("net/ntnic: replace assert with RTE assert")
> 
> Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
> ---
>  drivers/net/ntnic/adapter/nt4ga_adapter.c          | 8 +++++---
>  drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c | 6 +++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
> index a9ae1fa3f8..cb80c718c3 100644
> --- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
> +++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
> @@ -85,6 +85,8 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
>  	fpga_info_t *fpga_info = &p_adapter_info->fpga_info;
>  	hw_info_t *p_hw_info = &p_adapter_info->hw_info;
>  
> +	RTE_ASSERT(fpga_info);
> +
>  	/*
>  	 * IMPORTANT: Most variables cannot be determined before nthw fpga model is instantiated
>  	 * (nthw_fpga_init())
> @@ -155,15 +157,15 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
>  	}
>  
>  #ifdef RTE_ENABLE_ASSERT
> -	RTE_ASSERT(fpga_info);
> -	p_fpga = fpga_info->mp_fpga;
> -	RTE_ASSERT(p_fpga);
>  	n_phy_ports = fpga_info->n_phy_ports;
>  	RTE_ASSERT(n_phy_ports >= 1);
>  	n_nim_ports = fpga_info->n_nims;
>  	RTE_ASSERT(n_nim_ports >= 1);
>  #endif

This whole #ifdef is bad idea.
You are depending on implementation and creating side effects.

Better to just put all the expressions in the RTE_ASSERT()

>  
> +	p_fpga = fpga_info->mp_fpga;
> +	RTE_ASSERT(p_fpga);

The RTE_ASSERT() checking for NULL really doesn't add that much safety.
if p_fpga is NULL RTE_ASSERT will crash the application anyway.


>  	/* Nt4ga Init Filter */
>  	nt4ga_filter_t *p_filter = &p_adapter_info->nt4ga_filter;
>  
> diff --git a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
> index 9bae6a32c8..a56d3c5038 100644
> --- a/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
> +++ b/drivers/net/ntnic/nthw/flow_filter/flow_nthw_flm.c
> @@ -685,7 +685,7 @@ int flm_nthw_buf_ctrl_update(const struct flm_nthw *p, uint32_t *lrn_free, uint3
>  	if (ret == 0) {
>  		nthw_rac_rab_read32_dma(rac, bus_id, address_bufctrl, 2, &bc_buf);
>  		ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : -1;
> -		RTE_ASSERT(ret == -1);
> +		RTE_ASSERT(ret != -1);
>  		rte_spinlock_unlock(&rac->m_mutex);
>  
>  		if (ret != 0)
> @@ -785,7 +785,7 @@ int flm_nthw_lrn_data_flush(const struct flm_nthw *p, const uint32_t *data, uint
>  			nthw_rac_rab_read32_dma(rac, bus_id, address_bufctrl, 2, &bc_buf);
>  
>  			int ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : -1;
> -			RTE_ASSERT(ret == -1);
> +			RTE_ASSERT(ret != -1);
>  			rte_spinlock_unlock(&rac->m_mutex);
>  			if (ret != 0)
>  				return -1;
> @@ -847,7 +847,7 @@ int flm_nthw_inf_sta_data_update(const struct flm_nthw *p, uint32_t *inf_data,
>  
>  		nthw_rac_rab_read32_dma(rac, bus_id, address_bufctrl, 2, &bc_buf);
>  		ret = rac->m_dma_active ? nthw_rac_rab_dma_commit(rac) : -1;
> -		RTE_ASSERT(ret == -1);
> +		RTE_ASSERT(ret != -1);
>  		rte_spinlock_unlock(&rac->m_mutex);
>  
>  		if (ret != 0)

