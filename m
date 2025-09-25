Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6BACAC5A7
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 17:59:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 526CA40663;
	Thu, 25 Sep 2025 19:59:20 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id CFC2D4065E
 for <dev@dpdk.org>; Thu, 25 Sep 2025 19:59:19 +0200 (CEST)
Received: from debian (unknown [78.109.77.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id DEBFFE050B;
 Thu, 25 Sep 2025 21:59:17 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am DEBFFE050B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1758823158;
 bh=0ONlXE+ONV/uGc6J7w7MizYg6r7rxbmFWDic2jL/GcM=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=c1XQ6w5RO412nZghvlVhq9wPitgOqW+Ylagz17HzaPYj0jlftRiIy4hrf+bSAJeUS
 pfMeLSVc5fgbJvqM9eqaK7IPfjxvkZa06q/vxZhYnmgxJPsdUKWxeBwKWeL+1TVdXS
 8AQg30fI/d3JF9Fz5hUffmTLg+9xOvgJz44pvfCfQJz0i7MqbjJhLBbwQiIOvvyyxp
 QP52J3d/4yIOUUVyD0tbP5igfBkoIKenE8HJ2/QX4eTX8n/75qiTfCSHc2ZHz6H8Be
 IiPf9w9sMWEFYmQOnRUeGK5w9T40hWJkvjwjNLrM0wWr8sCUWP67SMr7yn1WHzkeO5
 c1U1aw1Jiee2g==
Date: Thu, 25 Sep 2025 21:59:16 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com, 
 thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru, 
 stephen@networkplumber.org
Subject: Re: [RFC PATCH 4/6] ethdev: extend VMDq/DCB configuration with queue
 mapping
In-Reply-To: <20250830171706.428977-5-vladimir.medvedkin@intel.com>
Message-ID: <4c1c74c5-5d03-7a00-9dc3-c837a2ec47d2@arknetworks.am>
References: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
 <20250830171706.428977-5-vladimir.medvedkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hi Vladimir,

On Sat, 30 Aug 2025, Vladimir Medvedkin wrote:

> Currently DCB Traffic Class queue mapping is only used when calling get
> DCB info API, while setting up queue mappings is up to each individual
> driver. Use the tc queue mapping structure to enable setting up custom
> mapping explicitly.
>

snip

> -/**
> - * A structure used to get the information of queue and
> - * TC mapping on both Tx and Rx paths.
> - */
> -struct rte_eth_dcb_tc_queue_mapping {
> -	/** Rx queues assigned to tc per Pool */
> -	struct {
> -		uint16_t base;
> -		uint16_t nb_queue;
> -	} tc_rxq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
> -	/** Rx queues assigned to tc per Pool */
> -	struct {
> -		uint16_t base;
> -		uint16_t nb_queue;
> -	} tc_txq[RTE_ETH_MAX_VMDQ_POOL][RTE_ETH_DCB_NUM_TCS];
> -};

May I clarify: is 'tc_rxq' structure supposed to facilitate the use case where:
- VLAN ID (VID) of the packet selects a 'pool' containing some entries;
- VLAN UP (priority) selects an entry in the 'pool' (gives 'base', 'nb_queue);
- if 'nb_queue' is 1, we send the packet to a specific queue ('base');
- if 'nb_queue > 1', we perform RSS across 'nb_queue' relative to 'base'?

I'm slightly confused, as [3/6] seems to remove 'rte_eth_vmdq_dcb_conf' and
the 'pool_map' (with 'vlan_id') and I'm not sure where it should resurface.

Thank you.
