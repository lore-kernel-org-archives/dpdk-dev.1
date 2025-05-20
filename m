Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A191C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 15:17:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AECA40A4B;
	Tue, 20 May 2025 17:17:17 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id DBF13402AE
 for <dev@dpdk.org>; Tue, 20 May 2025 17:17:15 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-6f8a87f0c0fso54843236d6.0
 for <dev@dpdk.org>; Tue, 20 May 2025 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747754235;
 x=1748359035; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GUcX6uA99ik54k3QoCs7iR+2aKoaRoqURTAFjEM6vyQ=;
 b=08dGyXVZppKzIgn7e4meUgHVC7gY1Xoul30xeZvzcr2VWOpB9Kko7E5PrSFwkYP+J8
 jNNoyA8qPScxiULH+je7+pgrtFUajSihZTdQKJGY7hX8XbnF30Ped4ZlhRCfpJd+Qh47
 YUkLVWL2wzMWg/eGeZ963J0/7uTZkPpUs1I3mXLvv+QmYUgKYTDyV7Mn36qghmX+3Hm9
 XYg5BPJ1C2gKK2EcyIu8g1ctxyIy6HIQGF+QnSCwE84MDhhBrEu6WdyJPl9EDGHtxu2d
 OARTqniTOnFk0QSdYnG80PkTkzgIpq4F8MluOkuZ6g8Obq5X/9ryi3coNT9+p/8aNKSU
 EUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747754235; x=1748359035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GUcX6uA99ik54k3QoCs7iR+2aKoaRoqURTAFjEM6vyQ=;
 b=ayAjibCQZ05d3LJv93YvE/BH0fuSe1NCgM+aQKHvOzDApDiv4oUWg+7MXhDd3iOl2F
 9Vz53xpgn0gRmXIfcmAHBKciy6xpzpOvsDdwjfdaMjNLbfp7ABcT6iCEHnKAh9+eK7H4
 7kLw5Bec+RvT84Th+ePs+20ZR9OBc606oligcNvVwi02o3bQuAqgYUQuUhTbt+iHCAl2
 QexdPSwuV/EAy/DsuR123G+HDny5iRPSI5w60Y6q+eJHLuP6/7ZqBVfpDYs4ZVScmhx5
 M9Ocng5EqsFqZLczRtUGXTbbX5vDRs48oewet48Zso4tPfHi1fjT/wT7HA44SbxheLpj
 9kfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCOGNFiOrIzMeztxBJ5ZMx/p9mDL+dwG38648474Z0+aUSTzvURW93LH53XFYfvOc/nkU=@dpdk.org
X-Gm-Message-State: AOJu0YzsrEd1ZXo4blAB1dnUwdszN0MXmMLDS1bHcO8Cwq51m9SMGMS4
 BBEhCtppimmLihYHYz20+dRqt2sOXe+nfS5M8mBPUlVCJz9SE69eJK1pbUv/d+b1cEA=
X-Gm-Gg: ASbGncsh6OVHhjWxcuglQwdGVRoF1tRPOPWj/Nyg943zd9Nt/AE7smbz+NNXrXCYQ69
 n9X/oc6RhrJeTlEoARrPdnrbnE6GESK1sycjNybZ9sbSfgxfb/7FKF7FFT5St9MI4lcU6Nw/mHy
 cIabxVOiCHdgddTaT1FoEQV82ZXNIqV5Adf41Boqo2zOi0ezTUC5IiE48Jsr75EKyelEOE7bK3W
 RVHcI4C8sJlVKo0H+eCP38Q1HJXw06uisfOi86hHGOdHrSX2pqtMfm6Y80t0/8rFd7jGqMcZUqd
 jgAbesgkxM50OHcTUpx+VgUdV/Kr5ZIoxngKIDsig5+ZMSqzTOJqqM0F5n5DT1uLWQ07UexoLI3
 uwtxzx+3RJOcNbzNNf8Q8cIpMQDLl
X-Google-Smtp-Source: AGHT+IG0wssVqN2mckgXhrTyAlNzQk04xUJMc1ueJV58uAD3xxUbD3b3UJtzrZC2rN/fFH/gwbNEmg==
X-Received: by 2002:a05:6214:cc1:b0:6f8:d223:3c14 with SMTP id
 6a1803df08f44-6f8d2233e2amr159079106d6.25.1747754234926; 
 Tue, 20 May 2025 08:17:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b0965823sm72481166d6.88.2025.05.20.08.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:17:14 -0700 (PDT)
Date: Tue, 20 May 2025 08:17:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <kirankumark@marvell.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, Thomas Monjalon
 <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>, Andrew
 Rybchenko <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>
Subject: Re: [PATCH v6 1/2] ethdev: support RSS based on RoCEv2 header
Message-ID: <20250520081709.105c8b84@hermes.local>
In-Reply-To: <20250505055717.3697335-1-kirankumark@marvell.com>
References: <20250505053304.3288290-1-kirankumark@marvell.com>
 <20250505055717.3697335-1-kirankumark@marvell.com>
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

On Mon, 5 May 2025 11:27:15 +0530
<kirankumark@marvell.com> wrote:
> @@ -149,6 +151,7 @@ const struct rss_type_info rss_type_table[] = {
>  	{ "l3-dst-only", RTE_ETH_RSS_L3_DST_ONLY },
>  	{ "l3-src-only", RTE_ETH_RSS_L3_SRC_ONLY },
>  	{ "ipv6-flow-label", RTE_ETH_RSS_IPV6_FLOW_LABEL },
> +	{ "ib_bth", RTE_ETH_RSS_IB_BTH },

Please follow convention of other options. Use minus instead of underscore.
Consistency matters.

> diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
> index 093b85d206..d1293893be 100644
> --- a/doc/guides/rel_notes/release_25_07.rst
> +++ b/doc/guides/rel_notes/release_25_07.rst
> @@ -55,6 +55,10 @@ New Features
>       Also, make sure to start the actual text at the margin.
>       =======================================================
>  
> +* **Added new RSS offload types for IB_BTH in RSS flow.**
> +
> +     Added ``RTE_ETH_RSS_IB_BTH`` macro so that the IB BTH header can be used as input set for RSS.
> +

Please add reference to the relevant standard and expand the acronym
at least one place in the documentation.


> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index ea7f8c4a1a..edcd6b75b5 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -602,6 +602,7 @@ struct rte_eth_rss_conf {
>  
>  #define RTE_ETH_RSS_L2TPV2             RTE_BIT64(36)
>  #define RTE_ETH_RSS_IPV6_FLOW_LABEL    RTE_BIT64(37)
> +#define RTE_ETH_RSS_IB_BTH		RTE_BIT64(38)
>  

Why is the acronym IB_BTH rather than ROCEV2?
Wouldn't it be clearer if it followed convention?
