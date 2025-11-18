Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EAECE8D6B
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 00:22:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B099A40280;
	Tue, 18 Nov 2025 01:22:22 +0100 (CET)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id A20314027D;
 Tue, 18 Nov 2025 01:22:20 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=15CCrro500jMXHiRE9KZa7S2RiM0/+2V9o8giUdWGwY=;
 b=A36VE7T3AN0ZxWNNMNquNxYxWeC4o6oqp9c0hJUZwNQF8uGBvOTo9EeLiqZfVdrAyb72GiuKZ
 rppR9X5orQV0Apzc5jYjtXG6OPrYqRt5gr8cQqxzfUoMVn7dtzmR1qcp9xMlqCCVF1ansHwgJSg
 qIAgpq3a9NVuzYZ8Tswt+/8=
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d9QHk6F9mzKm4Z;
 Tue, 18 Nov 2025 08:20:34 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 65619180042;
 Tue, 18 Nov 2025 08:22:18 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 08:22:17 +0800
Message-ID: <3f13c88a-5120-4852-942c-adde6fe0941d@huawei.com>
Date: Tue, 18 Nov 2025 08:22:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] app/testpmd: fix the IPv6 extension offset
To: Mingjin Ye <mingjinx.ye@intel.com>, <dev@dpdk.org>, Stephen Hemminger
 <stephen@networkplumber.org>
CC: <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
References: <20251105024724.830304-1-mingjinx.ye@intel.com>
 <20251105024724.830304-3-mingjinx.ye@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251105024724.830304-3-mingjinx.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

On 11/5/2025 10:47 AM, Mingjin Ye wrote:
> The skip ipv6 extension must be offset after the IPv6 header.
> 
> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
> ---
>  app/test-pmd/csumonly.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
> index d355dbd8c0..4b24bde190 100644
> --- a/app/test-pmd/csumonly.c
> +++ b/app/test-pmd/csumonly.c
> @@ -559,6 +559,7 @@ parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
>  
>  		if ((ptype & RTE_PTYPE_INNER_L3_MASK) ==
>  				RTE_PTYPE_INNER_L3_IPV6_EXT) {
> +			off += sizeof(struct rte_ipv6_hdr);
>  			ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);

As patch [1/2] said, this logic has problem, consider following case:

  ether + ipv6-with-option + tcp

and enable TSO offload.

It will not do TSO really, because the ptype is 0x1C1 which the INNER_L3 was not set,
then the parse_l4_proc could not identify is ipv6-with-option, it can't identify this
packet is TCP, then it will don't do TCP on this packet.

>  			if (ret < 0)
>  				return 0;

