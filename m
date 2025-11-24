Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15C2CFD369
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Nov 2025 23:35:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 066A8402D6;
	Tue, 25 Nov 2025 00:35:51 +0100 (CET)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 03B2D402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 00:35:49 +0100 (CET)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so5516965b3a.1
 for <dev@dpdk.org>; Mon, 24 Nov 2025 15:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764027349;
 x=1764632149; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqE/9pbg3yexzU54MSMlKH7VvUu8O298bIpVzLT/zPM=;
 b=gi+O+HnUMEytCcwPNyiTjtFn/A9A4zT/qyo4HmfCF67y6ASDr1WJmIn51rIbl8Jl3B
 NIqHT9mSot36DklHtVXVeQApMX4WNmVLsHbYIlci/Yk9rUnF2NwkFk+/FHfT5b/wn+AV
 RIocQb6nDkMojShcrRSwEkx680sV1eAwwUT10+nP16qi6wIppKNKdaKXSEPb+JQB0CLM
 H6y2c1AB4RL2VYYgJVwTnwokawrJcV0TwsQzAEu2Dw62jCZzx3N1r58o542mw0ZHpe/P
 9BXrqMDSYaT9YITdvGVANrkFXm50XSD6PzSejjYDEJtqI1jFRnWFtl6gARtzW/7iCmag
 R6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764027349; x=1764632149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jqE/9pbg3yexzU54MSMlKH7VvUu8O298bIpVzLT/zPM=;
 b=mV3dImuwodjI0/XC2zoNfoYIkElceSL/6EsPw8y8aswWvrzlvO4JjtPF7nviCwQ5Ne
 Jx8GiGpuO3WhtrQPoUmMgwewZKreD2Iv59f819EBW9DMGBalzng/UBDeChj+WOXIl1oG
 RwAsFNLciojlgJuuqy6hbEv6D4PggrpmHz1MfsytRPo2dGwOjxze8qr0PAICR0svSV/x
 wrk6OR9Vy65C1bZZzK2s6DqxYgf6KhstHOGLxmeqYaHjCPC7I1ugV9shzfMHWt38HLf5
 ANbQ66xgT/qtTbqd2vWABVU4c8EzUjAQHNfa8Ht6fJeNpgtAE86HH8C7xvlEtZtAvYQa
 Ss6A==
X-Gm-Message-State: AOJu0YytS5Mqbga/u/myFXnEM2dWvCLWzVQ3hEkGGEqvLM5zSjUrouvH
 RUIm8ktSNVyN77Vb/UEkT7NkkJffvdCfMjKc7vyjcfVGuL33rqJp7thlbDBa6D475/zeKxcU2zH
 PE9Iy
X-Gm-Gg: ASbGnctL4DO+idDm23GSx9j1vU6LK7nZwMc48lTPzfac5Vtqx8kO8FRaZDT6jN25kNh
 df31TYXS0Ui4rljqvMYCJxRehalyp4K85gV0DaHkxqkrxtkrNmWCCLPgegoCcPO/5ZLhaMcscSU
 v2VVpHySkUFa58tQwUxATcyStymCfV3BzAKw9Ei/q7W7AhLLZnxW+0vvB5NYt93ugTWYW975DrH
 o+0CkM7LZgKCaMMlMQtoHdTAC7abJtl8vUlGJkdfO3PNhOe+j9mqWYIJrxkXi8ctFKgJ5yXQj1T
 blYT5HWFqAksQ/YZX1bFqJ473ThrEaT1L3g/zvngRf+8WDyoBemgik/BFxO09dSDz0BhWhQ5Y//
 LWLCqP1t9IynIPYGJH8py+XGBF3Cin2BCMMagzC7uc1Oss4hoQImzQFZCuYw77Np2Jy6vPv6GWw
 lBoYrvh/0I82J1C8YY5p6E3JUIvubeEiFCJP5mtw0IqR0WuOjB5rg9gHJrI+FdSQ8=
X-Google-Smtp-Source: AGHT+IEJF1lpUMpV8Ah97tzVgAvYsoDE4yq6+lWivGKB8b0V6trIVjlCkwtq5RVKbHfVPHS+/Sf7Pw==
X-Received: by 2002:a05:7022:440c:b0:11b:ca88:c4f7 with SMTP id
 a92af1059eb24-11c9d863ae0mr9163680c88.40.1764027348663; 
 Mon, 24 Nov 2025 15:35:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e6dbc8sm76668740c88.10.2025.11.24.15.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 15:35:48 -0800 (PST)
Date: Mon, 24 Nov 2025 15:35:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: add VLAN offload set interface
Message-ID: <20251124153545.7123c338@phoenix.local>
In-Reply-To: <20251124034026.3680873-2-dimon.zhao@nebula-matrix.com>
References: <20251111113144.3567291-1-dimon.zhao@nebula-matrix.com>
 <20251124034026.3680873-1-dimon.zhao@nebula-matrix.com>
 <20251124034026.3680873-2-dimon.zhao@nebula-matrix.com>
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

On Sun, 23 Nov 2025 19:40:26 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> The rte_eth_dev_set_vlan_offload function internally calls
> the vlan_offload_set interface, so we must implement this function.
> Otherwise, an error will occur when
> executing the vlan set strip on command.
> 
> Fixes: 9d7757dce874 ("net/nbl: simulate VLAN offload")
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> ---
>  drivers/net/nbl/nbl_dev/nbl_dev.c | 5 +++++
>  drivers/net/nbl/nbl_dev/nbl_dev.h | 1 +
>  drivers/net/nbl/nbl_ethdev.c      | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
> index 58eb1c6231..923de2e9d0 100644
> --- a/drivers/net/nbl/nbl_dev/nbl_dev.c
> +++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
> @@ -758,6 +758,11 @@ int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev)
>  	return 0;
>  }
>  
> +int nbl_vlan_offload_set(__rte_unused struct rte_eth_dev *dev, __rte_unused int mask)
> +{
> +	return 0;
> +}

This seems broken in handling VLAN.
The intention is that the driver changes how vlans handled based on the mask
in the API call. 

The driver is not advertising RTE_ETH_VLAN_STRIP_OFFLOAD in the offload flags.
Same for QINQ or FILTER flags.

What is the intention? How is the hardware handling VLAN tags? Does it
have the capability to do this in hardware? Can it be enabled and disabled?



