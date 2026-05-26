Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A78CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 13:15:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF398402D7;
	Tue, 26 May 2026 15:15:06 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 5F0FB402AC
 for <dev@dpdk.org>; Tue, 26 May 2026 15:15:05 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-130c9dcbd25so6371133c88.1
 for <dev@dpdk.org>; Tue, 26 May 2026 06:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779801304;
 x=1780406104; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MO22EbWmTdw6VbVlh/xakDwk410BsK712T+lJZ/iPpY=;
 b=fVD+SMulo3tw4zsWPUvWQuKkS8nOTCp7kE3LclaWN6VlmRDBwOxWo4R6/iLkZMUfBY
 ndApp97zZ/7PV2J6Dky2XGryk4Z/lXLP7paYN8nU65O8CILI9Gi1xLUyTHxrM+KezGh8
 inaMp/oJk3A0uY+c/1CZhPgGNg9vYfsF0ROZmrxV8XH8ApggVM/ZgDTcnNeXqPhGdel1
 6lsZqsQb96yKPvr1NgelenZbauGr2r1xuBhYvuvRfWwgNxS9jdxAs7FyMbMJWLlWDTtf
 r1Vy49nK9IGn9S+5GM1aRxVKvK6B71jLaIKAdD2vhV7MnnrmPeI8aE9MsZKQe+TfdhvP
 CJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801304; x=1780406104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MO22EbWmTdw6VbVlh/xakDwk410BsK712T+lJZ/iPpY=;
 b=O+J9m8nzs7Ty2uIIJ3TA2KP8wydffMCeI3ijWBijYedNkQZme3SsLPQuWzfTv7s6vH
 2g12VumwwHFAVxxnEk7JMG7kyDdNa+ir4krJAP4lAiHNLJ6tu4MWx68Iqj61WlYBEIJS
 nSSeBxvIDwMQ7krWFjPFT5mYuEvCkiVUkMoaYcAXbwDqqDDg+BdmF9Vgp8o+fu/uvkbI
 akKze1ZMQ7XXVtOoyUhkDbN+VtT7+32iatPl8vQ8dlAka2hvipXHa9N2Rvbp3K/7JkTt
 E8L1p3u2jEJ8pvRKejGPmwCSNW9P9zx5a/e0ik/pd/yvew/Cl2KnMpMrY0P/IXjklb7o
 JATA==
X-Gm-Message-State: AOJu0YxlI4juqoGA8jrAhFPzhUNrJKB12LytPQbcVNIotOPGm3xUuC4L
 I3Y+IEgR2MHjKH/Eof4kdgbeWGLVC8dTXMUCvVCKz+NiUXQ9hW72TMbCpE9Np/Cm+bQ=
X-Gm-Gg: Acq92OH5P+zipTB0Ka9lCpnvL+mddaBONLUJbBycLKHZE3HE6qIoIganh9uiPPX4s9X
 /iVWaqIX+oIBaVlKhv/4OVt0Kg0qFbXHQ7wyo+8p8PvLZfyq179RZ2odp9mx4Lwp/IFa5OC49xH
 pwUTqEiIMzFiHEcPebTUCdjvKeu6sl/8vTx4A/CW9vDDQnqWSyYOWQc5+QCMuG1Pzx1fiA35SOD
 czOSIDDfu791YK4TWJNohIU5RB8i65NWiQAMOLJlZjtW7m1+B6l8F4tYPtGRbJRHpoOIKsd4GYC
 iTyuyIQltjcqu9mWzgHhi2xSLCCCLLNKsB3WiT/yB2LZVbH6kougANLA7q/yyAo4CqGhgOfcEO5
 BJFJKU0ZpNNecZZUcEGzmXHC701es6/TdM0Uo3LhYl3PfmM1TRD+qLJQEq55EBSCPLUvWswIDXU
 xp23SbFneRLz8mJubBvVmc0rG/EGFQde55CA0YaC2pA3bVnm1JGA78fdPmgknpPsst/A5xLaE4G
 fw=
X-Received: by 2002:a05:7300:478d:b0:2be:17b1:e49f with SMTP id
 5a478bee46e88-304304f77d6mr9614048eec.4.1779801303991; 
 Tue, 26 May 2026 06:15:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm10136485eec.14.2026.05.26.06.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:15:03 -0700 (PDT)
Date: Tue, 26 May 2026 06:15:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [v4 1/1] net/hinic3: Fix VXLAN TSO issue
Message-ID: <20260526061501.697245e4@phoenix.local>
In-Reply-To: <20260526121820.1093-2-wff_light@vip.163.com>
References: <20260520065817.931-2-wff_light@vip.163.com>
 <20260526121820.1093-1-wff_light@vip.163.com>
 <20260526121820.1093-2-wff_light@vip.163.com>
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

On Tue, 26 May 2026 20:18:18 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> From: Feifei Wang <wangfeifei40@huawei.com>
> 
> VXLAN TSO lacks a flag bit, causing the processing function
> to determine that the hardware does not support it, leading
> to improper handling.
> 
> Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>

If this is a bug fix, it needs Fixes: tag and should
have Cc: stable@dpdk.org

> ---
>  drivers/net/hinic3/hinic3_ethdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
> index f4eb788..4776bc1 100644
> --- a/drivers/net/hinic3/hinic3_ethdev.c
> +++ b/drivers/net/hinic3/hinic3_ethdev.c
> @@ -652,8 +652,12 @@ hinic3_dev_configure(struct rte_eth_dev *dev)
>  static void
>  hinic3_dev_tnl_tso_support(struct rte_eth_dev_info *info, struct hinic3_nic_dev *nic_dev)
>  {
> +	if (HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev))
> +		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO;
> +
>  	if (HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev))
>  		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
> +
>  	if (HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))
>  		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO;
>  }
> @@ -698,7 +702,6 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
>  		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
>  		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
>  		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
> -	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)
>  		hinic3_dev_tnl_tso_support(info, nic_dev);

If you remove the if here, then you need to fix indentation on
the line below.
