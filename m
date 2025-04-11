Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8183DC369A9
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 09:54:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 217F440A67;
	Fri, 11 Apr 2025 11:54:30 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id A916C406B6
 for <dev@dpdk.org>; Fri, 11 Apr 2025 11:54:28 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZYsN62QCSz2TS9h;
 Fri, 11 Apr 2025 17:49:26 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
 by mail.maildlp.com (Postfix) with ESMTPS id 1FCB21A0188;
 Fri, 11 Apr 2025 17:54:26 +0800 (CST)
Received: from [10.67.121.175] (10.67.121.175) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Apr 2025 17:54:25 +0800
Message-ID: <46aee538-0e2e-63f6-3b35-a15419cb74d6@huawei.com>
Date: Fri, 11 Apr 2025 17:54:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] net: fix GTP packet parsing
To: Dengdui Huang <huangdengdui@huawei.com>, <dev@dpdk.org>
CC: <jasvinder.singh@intel.com>, <stephen@networkplumber.org>,
 <thomas@monjalon.net>, <mb@smartsharesystems.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
References: <20250411084303.770040-1-huangdengdui@huawei.com>
From: Jie Hai <haijie1@huawei.com>
In-Reply-To: <20250411084303.770040-1-huangdengdui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.175]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500004.china.huawei.com (7.202.181.242)
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

Good job!

Acked-by: Jie Hai <haijie1@huawei.com>

On 2025/4/11 16:43, Dengdui Huang wrote:
> After parsing the GTP packet header, the next protocol type should
> be converted from RTE_GTP_TYPE_IPV4/IPV6 to RTE_ETHER_TYPE_IPV4/IPV6.
> Otherwise, the next protocol cannot be parsed.
> 
> Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> ---
>   lib/net/rte_net.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index be24690fdf..1771588a09 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -231,7 +231,13 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>   		 */
>   		if (gh->msg_type == 0xff) {
>   			ip_ver = *(const uint8_t *)((const char *)gh + gtp_len);
> -			*proto = (ip_ver) & 0xf0;
> +			ip_ver = (ip_ver) & 0xf0;
> +			if (ip_ver == RTE_GTP_TYPE_IPV4)
> +				*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
> +			else if (ip_ver == RTE_GTP_TYPE_IPV6)
> +				*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
> +			else
> +				*proto = 0;
>   		} else {
>   			*proto = 0;
>   		}
