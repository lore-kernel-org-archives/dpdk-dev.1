Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA52C3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 06:02:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92CAE4026D;
	Tue,  6 May 2025 08:02:54 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id D864340150
 for <dev@dpdk.org>; Tue,  6 May 2025 08:02:52 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Zs74Y0qmzzQkSs;
 Tue,  6 May 2025 13:58:53 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 2C53A180B61;
 Tue,  6 May 2025 14:02:50 +0800 (CST)
Received: from [10.67.121.193] (10.67.121.193) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 14:02:49 +0800
Message-ID: <2aad9361-59b9-461b-8a50-a02f9d907c00@huawei.com>
Date: Tue, 6 May 2025 14:02:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fix GTP packet parsing
From: huangdengdui <huangdengdui@huawei.com>
To: <dev@dpdk.org>, <songx.jiale@intel.com>
CC: <jasvinder.singh@intel.com>, <thomas@monjalon.net>,
 <mb@smartsharesystems.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
References: <20250411084303.770040-1-huangdengdui@huawei.com>
 <20250417123739.2291519-1-huangdengdui@huawei.com>
Content-Language: en-US
In-Reply-To: <20250417123739.2291519-1-huangdengdui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.193]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

Hi, Jiale, this patch can solve the issues[1] you reported. Can you review this patch and add a Tested-by tag?

[1]
https://bugs.dpdk.org/show_bug.cgi?id=1672

On 2025/4/17 20:37, Dengdui Huang wrote:
> After parsing the GTP packet header, the next protocol type should
> be converted from RTE_GTP_TYPE_IPV4/IPV6 to RTE_ETHER_TYPE_IPV4/IPV6.
> Otherwise, the next protocol cannot be parsed.
> 
> Bugzilla ID: 1672
> Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> Acked-by: Jie Hai <haijie1@huawei.com>
> ---
>  lib/net/rte_net.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index be24690fdf..1771588a09 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -231,7 +231,13 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
>  		 */
>  		if (gh->msg_type == 0xff) {
>  			ip_ver = *(const uint8_t *)((const char *)gh + gtp_len);
> -			*proto = (ip_ver) & 0xf0;
> +			ip_ver = (ip_ver) & 0xf0;
> +			if (ip_ver == RTE_GTP_TYPE_IPV4)
> +				*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
> +			else if (ip_ver == RTE_GTP_TYPE_IPV6)
> +				*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
> +			else
> +				*proto = 0;
>  		} else {
>  			*proto = 0;
>  		}
