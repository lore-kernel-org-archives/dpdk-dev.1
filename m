Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B704ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 16:05:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 041C3402E3;
	Fri,  7 Nov 2025 17:05:20 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 47168402E3
 for <dev@dpdk.org>; Fri,  7 Nov 2025 17:05:19 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7aca3e4f575so796655b3a.2
 for <dev@dpdk.org>; Fri, 07 Nov 2025 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762531518;
 x=1763136318; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioHbhk7cQHzQCDFvelQUkjJU/IvqzTC4uDiM7pb3kCw=;
 b=jxxLYKnos3vlJKXr6Z9f0umWvNRS7GJMdHXz2QcNBEZSJBuvT2ibYNWitb+xLMhajx
 UWqHX8WYoBMMMIRpW2w1J3XPJFGXM6W4TSfHjx+frjSgVgOP+WxbIxdcaRWRnhcp7J/Q
 v0BS1fTAsVHe57gXdyFCr24wTSPDMmJCPZZP+LJLhLI+lhqewWMQvchi2I6o3ws6IB7R
 yQvuz9c5za8ZHNUIG18959IVcfWBdfpPfhjUdy9jF7kwSLj/0kVn9nNJQTBHLZ1VqXsT
 1otBcjbmx2w+crhWZ0nnEEAZYNKvHErxANmNt1p4HJVUlrNw0Z1asPYRJYzVyRxojhyu
 HFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531518; x=1763136318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ioHbhk7cQHzQCDFvelQUkjJU/IvqzTC4uDiM7pb3kCw=;
 b=AYTXzsQQ+/MzYGoiNqyVhkE0jQaqtMZkOEuh+6H+eYOmeSAu91/ptXm47AwAJGiUws
 yMFjdV7DS1VhxZEPZ1IaOQIJKKchlVHc1u9KpswHH4aWdnfGWtJ0QCUc2kR9lNqUhsNq
 cBpgCs1SX5/FJ/NEyBfdatsXE9fUeWOM7KdlRliJ4mm/MHVo8gBnAA+WMb140vnuhuNV
 MIIcLi4EFgAYA8w3uAR2T7g3vC8bLIMGPtKgv08/dauyNm7banYaVtusjQccINIj1Gxt
 gKdYxcr2dap3W6ys1CGcqj+ve/CjD3OEWHsYj/MG0zPMx0uOZcgw7RQxwtXWMkK0XmmV
 Q9KA==
X-Gm-Message-State: AOJu0YyStEMctf+TOASogY7M8yky7KMLibd7T86aBhcqZRcICYp6ky/5
 ByioDMREanJ+GO6nzQe+iBtLep75VdYtvDqCtZsRXzZAXfHXFYq1ntQKgzB7emdv82b+XgoV26m
 eEUi7
X-Gm-Gg: ASbGncsjNi/EZphD9gJSuEV7FMs6HMMCAf49VxL76Vz+AivK2jsTJe8oXn/IaVJDr5b
 XL2/ncJ93l3A9vt411JT7T57J8uZWlz9QHr9QKVAkIUs6T4HlQQ06YaJ4xFi5f7ofJmNarmY3qD
 Tjd2zQ3lbcyPajd6er2i8163d5qc1lD9pAOhX2CsQyelaZoy9dq1e6nV2g+Rvk/sums73tpo5be
 YFtXeEYBSqe2cAMHOdaYrrHSlEdlYbViKJ9bjuYeao5KgqcnSnzmVo/yLIpriFpqrfR2FJ2UX9m
 OS5uaWPPfEU5tazQXizFvez0N+nkLz/ySK+pPK0OWg4GqSqTTiVgIUfS8jXZJryfIyvwVnblxT2
 vxuFwXY1f5c4kXayWKUl6mhPvqEdmZDFTzwv5fh0jRTIlEPlHxq8SKL2wsJMca0aETDv8hDM5HL
 JB8IAZ3/7KPE0rRQCoSLhorQ/p4fPG7QR0EA==
X-Google-Smtp-Source: AGHT+IEpsV56+0wOV2bBD0niWcGPOo5RB8npYh74qk9alK1X4Gy57lP2sTmSBSyt7Eb+qGsT7brOLg==
X-Received: by 2002:a05:6a00:3d4f:b0:7ac:6c3e:e918 with SMTP id
 d2e1a72fcca58-7b0bbb0a58fmr4785608b3a.11.1762531518254; 
 Fri, 07 Nov 2025 08:05:18 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0c9ff74bfsm3405761b3a.27.2025.11.07.08.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 08:05:18 -0800 (PST)
Date: Fri, 7 Nov 2025 08:05:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Alvin Wang <alvin.wang@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 3/4] net/nbl: add support for imissed stats
Message-ID: <20251107080515.0f9b86db@phoenix>
In-Reply-To: <20251107073459.3532524-4-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
 <20251107073459.3532524-4-dimon.zhao@nebula-matrix.com>
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

On Thu,  6 Nov 2025 23:34:58 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +static int nbl_dev_update_hw_stats(struct rte_eth_dev *eth_dev)
> +{
> +	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
> +	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
> +	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
> +	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
> +	u32 *uvn_stat_pkt_drop;
> +	int i = 0;
> +	int ret = 0;
> +
> +	if (!net_dev->hw_stats_inited)
> +		return 0;
> +	uvn_stat_pkt_drop = rte_zmalloc("nbl_uvn_stat_pkt_drop",
> +				sizeof(*uvn_stat_pkt_drop) * (eth_dev->data->nb_rx_queues), 0);

Since the lifetime of this array is only for this function, please use standard pool.
	uvn_stat_pkt_drop = calloc(eth_dev->data->nb_rx_queues, sizeof(u32));

