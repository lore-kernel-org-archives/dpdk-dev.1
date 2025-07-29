Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BEFC87FCA
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 04:28:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38BEB40668;
	Tue, 29 Jul 2025 06:28:45 +0200 (CEST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 221DE40647
 for <dev@dpdk.org>; Tue, 29 Jul 2025 06:28:44 +0200 (CEST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3b78294a233so1827412f8f.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 21:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753763324;
 x=1754368124; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ucfkb9chndaXFAazs77u3Qw3Fz60c2mXDmTeYc7xL5A=;
 b=wPj7pA7xLjiD8X57bBAPIICtAuGHBOlYMsFkRKe1Hb16aPPeCPcdjsHeHD9A6/UVso
 ZF8x0Eko/r6g8qYENOCZ27Uy9iinWyfBZQcXCzPC50clCgnN1HkplTm5iEC15yRMU8WR
 YK02s7dAxfIstHls78snp9Ft8M+73u8MV+u6ZA4iiwhb4hxo/k0xm+xYIK8iMPu84bA+
 iuz2h9avXjQlw1MOF+n1e4BiOuAje2URS22YXBtEbmbsloxKXYbZ8B4zlIsDnxCsdHGx
 7UZn0koHGa9HhOUFZiQVZFlt+PRhv0OxmgDoJX/BpOCsEBvg3Z3b0Vn5iiRH/4pCW00J
 770w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753763324; x=1754368124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ucfkb9chndaXFAazs77u3Qw3Fz60c2mXDmTeYc7xL5A=;
 b=P0MRzafYytHUh9tt9iLUCTol+yQqSFVyylgDROQ43/SMp2RkUTmbqdGNKcJFn3BCvk
 pelplp/scLwRQZaVjqx06v4DNiYOzpAPQvY8NtlFjtde/8h+ldx26hhmAmG+Ol54/h8r
 W6cMj57I3xkFVzXnwppuXjFshI7km+hmw4ySu2WebZh7Y1CeMsx97GkM5PbkC8HC3veJ
 zis6n8Z/KNkUVpi6zxDVNq9Ckjy0qYc33xauVcLLaDN28xkctdNLibDltrA2wPoHoBkr
 HUMwB4lE7vdHgYe8fPwkNhDaddZjkrpwjlABzYw4X1t82prD6UIhoKUe0gZ0GVjXdIhc
 CD9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUPVPFEarh6rTYw7QQL+QJjVpIyBj3DKyHUESIsDfSUHsXnr8/N7s0UXzv41ydyMFjzRg=@dpdk.org
X-Gm-Message-State: AOJu0YzxsTT42sHlzV23B3Q7TKv+tK/CfGu9XxfYw0GW3fAyM/LCrfVo
 TaT+8JNTd62dYeGBV7cG15th9v9HiZoyQTdq1MzPlu1ByQPguudRGk19DKPnlZ/PDYI=
X-Gm-Gg: ASbGncsnGM1S8D/20E7H1JlkI5y6JzY+p2yAz53M5QNpvT1pX01X9DR6hsUtDow/rNI
 vI4OpdyNuL3miJAwuwlw3YjxyMi6FthpAU/Nb7PsXk7T/DQc+eZQ2GPz6bgK7K0mYN7q3QAh82M
 y4ab6zlfMRUWc+1y8bHJM17ccJtD/atxqRKRQgS40a5Z97+Vj6qJTO/yMvZm81r0uEdZdw3TFPv
 SWvOwP9fZ9oY5e6OPdldszUZmiL2hjgjM/uvyGW2pejXjvPfEXrf3n3Yr4nE3nNzibfHdfYY3zS
 Hqg2HX7nwtEM53utnW56QfE411mEgD+Kvcx5saULYxwChat/21zPxMTJ6W/nbv2lei9849IoYcH
 htuqiJlm++YVxJ+7jxAplde2H4hrBIkIkwo4bWrHGs9HqL2sM9mezBrYYAD31TGXTZ8ynIYHefS
 g=
X-Google-Smtp-Source: AGHT+IFq1Eqn2FSEDak8UvjIOmTAc7rKecTRXR8Iq6sebKZ63LsltQ3/cXTZs4ptb/witR/oZ1aeTA==
X-Received: by 2002:a05:6000:2411:b0:3a4:bfda:1e9 with SMTP id
 ffacd0b85a97d-3b77678ba22mr11251643f8f.46.1753763323309; 
 Mon, 28 Jul 2025 21:28:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7908161e3sm925755f8f.37.2025.07.28.21.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 21:28:42 -0700 (PDT)
Date: Mon, 28 Jul 2025 21:28:30 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Shepard Siegel <shepard.siegel@atomicrules.com>, Ed Czeck
 <ed.czeck@atomicrules.com>, John Miller <john.miller@atomicrules.com>,
 "Igor Russkikh" <irusskikh@marvell.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Satha Rao <skoteshwar@marvell.com>, "Harman
 Kalra" <hkalra@marvell.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 "Sachin Saxena" <sachin.saxena@nxp.com>, John Daley <johndale@cisco.com>,
 "Hyong Youb Kim" <hyonkim@cisco.com>, Jie Hai <haijie1@huawei.com>, Ian
 Stokes <ian.stokes@intel.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Long Li
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Chaoyong He
 <chaoyong.he@corigine.com>, Jiawen Wu <jiawenwu@trustnetic.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, Jerin Jacob
 <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>, "Jian Wang"
 <jianwang@trustnetic.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, Jochen Behrens
 <jochen.behrens@broadcom.com>, Thomas Monjalon <thomas@monjalon.net>,
 "Ferruh Yigit" <ferruh.yigit@amd.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] ethdev: remove unnecessary type conversion
Message-ID: <20250728212830.172fba10@hermes.local>
In-Reply-To: <20250512150732.65743-1-skori@marvell.com>
References: <20250429181132.2544771-1-skori@marvell.com>
 <20250512150732.65743-1-skori@marvell.com>
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

On Mon, 12 May 2025 20:37:19 +0530
<skori@marvell.com> wrote:

> From: Sunil Kumar Kori <skori@marvell.com>
> 
> As rte_eth_rx_queue_count() returns signed value to represent
> the error cases but internally invoked callback is returning
> unsigned value. Hence unnecessary type conversion is done.
> 
> To avoid this typecasting from signed to unsigned, fixed
> return type of callback functions.
> 
> Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> ---
>  drivers/net/ark/ark_ethdev_rx.c        | 2 +-
>  drivers/net/ark/ark_ethdev_rx.h        | 2 +-
>  drivers/net/atlantic/atl_ethdev.h      | 2 +-
>  drivers/net/atlantic/atl_rxtx.c        | 2 +-
>  drivers/net/bnxt/bnxt_ethdev.c         | 2 +-
>  drivers/net/cnxk/cnxk_ethdev.h         | 2 +-
>  drivers/net/cnxk/cnxk_ethdev_ops.c     | 2 +-
>  drivers/net/dpaa/dpaa_ethdev.c         | 2 +-
>  drivers/net/dpaa2/dpaa2_ethdev.c       | 2 +-
>  drivers/net/enic/enic_ethdev.c         | 2 +-
>  drivers/net/hns3/hns3_rxtx.c           | 2 +-
>  drivers/net/hns3/hns3_rxtx.h           | 2 +-
>  drivers/net/intel/e1000/e1000_ethdev.h | 4 ++--
>  drivers/net/intel/e1000/em_rxtx.c      | 2 +-
>  drivers/net/intel/e1000/igb_rxtx.c     | 2 +-
>  drivers/net/intel/e1000/igc_txrx.c     | 2 +-
>  drivers/net/intel/e1000/igc_txrx.h     | 2 +-
>  drivers/net/intel/fm10k/fm10k.h        | 2 +-
>  drivers/net/intel/fm10k/fm10k_rxtx.c   | 2 +-
>  drivers/net/intel/i40e/i40e_rxtx.c     | 2 +-
>  drivers/net/intel/i40e/i40e_rxtx.h     | 2 +-
>  drivers/net/intel/iavf/iavf_rxtx.c     | 2 +-
>  drivers/net/intel/iavf/iavf_rxtx.h     | 2 +-
>  drivers/net/intel/ice/ice_rxtx.c       | 2 +-
>  drivers/net/intel/ice/ice_rxtx.h       | 2 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.h | 2 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c   | 2 +-
>  drivers/net/mlx5/mlx5_rx.c             | 4 ++--
>  drivers/net/mlx5/mlx5_rx.h             | 2 +-
>  drivers/net/netvsc/hn_rxtx.c           | 2 +-
>  drivers/net/netvsc/hn_var.h            | 2 +-
>  drivers/net/nfp/nfp_rxtx.c             | 2 +-
>  drivers/net/nfp/nfp_rxtx.h             | 2 +-
>  drivers/net/ngbe/ngbe_ethdev.h         | 2 +-
>  drivers/net/ngbe/ngbe_rxtx.c           | 2 +-
>  drivers/net/sfc/sfc_ethdev.c           | 2 +-
>  drivers/net/thunderx/nicvf_rxtx.c      | 2 +-
>  drivers/net/thunderx/nicvf_rxtx.h      | 2 +-
>  drivers/net/txgbe/txgbe_ethdev.h       | 2 +-
>  drivers/net/txgbe/txgbe_rxtx.c         | 2 +-
>  drivers/net/vhost/rte_eth_vhost.c      | 2 +-
>  drivers/net/vmxnet3/vmxnet3_ethdev.h   | 2 +-
>  drivers/net/vmxnet3/vmxnet3_rxtx.c     | 2 +-
>  lib/ethdev/rte_ethdev.h                | 2 +-
>  lib/ethdev/rte_ethdev_core.h           | 2 +-
>  45 files changed, 47 insertions(+), 47 deletions(-)

Was going to apply this for 25.11 (next-net).
But the Intel drivers got rearranged and no longer applies.
Would prefer that you rebase and resubmit, instead of me trying to patch a patch for this.
