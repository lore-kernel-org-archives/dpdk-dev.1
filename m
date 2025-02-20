Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096DBC021AD
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 07:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4EB4A4014F;
	Thu, 20 Feb 2025 08:09:25 +0100 (CET)
Received: from shelob.oktetlabs.ru (shelob.oktetlabs.ru [91.220.146.113])
 by mails.dpdk.org (Postfix) with ESMTP id 746A740041
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:09:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 shelob.oktetlabs.ru 9C05344
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oktetlabs.ru;
 s=default; t=1740035363;
 bh=9gMMCr/tgPS3utNGSGFhnJsvb/4991eyT9dxXSkX1U4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GRT1tRwGLb2lE9+iA064RkkIZUVWkIOodAOh4iTUItqZ3cLMvLXmC9wZMPY4f7k2S
 iV0iNK2sgXIC6oMDMslLNkhNty1w7kAP9pTscfS8DzVJoTdnRQXIJuo1Z+CfRmAAN5
 rbphB9O1S3MSL9MPUsb/rzgeB7FFz/j5/LWg5Ie0=
Received: from [192.168.38.17] (aros.oktetlabs.ru [192.168.38.17])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by shelob.oktetlabs.ru (Postfix) with ESMTPSA id 9C05344;
 Thu, 20 Feb 2025 10:09:23 +0300 (MSK)
Message-ID: <2786d5f9-2f14-4af6-a4fe-ed3827c24f0d@oktetlabs.ru>
Date: Thu, 20 Feb 2025 10:09:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] ethdev: remove unnecessary deref on function
 pointers
To: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
 <20250220023509.630569-2-stephen@networkplumber.org>
Content-Language: en-US
From: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Organization: OKTET Labs
In-Reply-To: <20250220023509.630569-2-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2/20/25 05:32, Stephen Hemminger wrote:
> The expression *dev->dev_ops->rx_queue_start and
> dev->dev_ops->rx_queue_start are equivalent.
> Remove the unnecessary asterisk and parenthesis.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>

one nit below

> @@ -6995,11 +6966,11 @@ rte_eth_ip_reassembly_capability_get(uint16_t port_id,
>   		return -EINVAL;
>   	}
>   
> -	if (*dev->dev_ops->ip_reassembly_capability_get == NULL)
> +	if (dev->dev_ops->ip_reassembly_capability_get == NULL)
>   		return -ENOTSUP;
>   	memset(reassembly_capa, 0, sizeof(struct rte_eth_ip_reassembly_params));
>   
> -	ret = eth_err(port_id, (*dev->dev_ops->ip_reassembly_capability_get)
> +	ret = eth_err(port_id, (dev->dev_ops->ip_reassembly_capability_get)

Why are parenthesis kept above instead of moving to the next line and
remove parenthesis as it is done in the rest of cases?

>   					(dev, reassembly_capa));
>   
>   	rte_eth_trace_ip_reassembly_capability_get(port_id, reassembly_capa,

