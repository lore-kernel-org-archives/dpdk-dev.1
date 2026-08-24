Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0588C5DF97
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 02:43:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E78A4027C;
	Mon, 24 Aug 2026 04:43:08 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 9873940270
 for <dev@dpdk.org>; Mon, 24 Aug 2026 04:43:06 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=trPyGiSnZxHLzlnXMY5PqlpqumkIpVYYvLVrzyA5cXk=;
 b=sFm4q4wfmPzWMVt1CIF+dEwDKlOct+fnFXQxjxFFvOr/F7pg9W8rSBHxFyIacExu0b9h/OleZ
 n+hoFCwfJnDWJs4+pJiQZyONQepTAsHC23EEqiySel1CUAGaKoR7vIqSFZd1Ya8d+0bI29Z2eOA
 TrVP6ZHZQmaXqSpR/svt5kU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hSw0V5wYQzpSvB;
 Mon, 24 Aug 2026 10:31:54 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 2B5BA40538;
 Mon, 24 Aug 2026 10:42:59 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 10:42:58 +0800
Message-ID: <3d4c22da-06b4-4dd9-b956-f1b14c016bad@huawei.com>
Date: Mon, 24 Aug 2026 10:42:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/68] net/hns3: replace use of rte_memcpy
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Xingui Yang <yangxingui@huawei.com>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-38-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260821192646.146382-38-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>

On 8/22/2026 3:24 AM, Stephen Hemminger wrote:
> Don't need rte_memcpy for fixed size value.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/hns3/hns3_fdir.c | 2 +-
>  drivers/net/hns3/hns3_flow.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/hns3/hns3_fdir.c b/drivers/net/hns3/hns3_fdir.c
> index 50572ae430..86dba4eb2e 100644
> --- a/drivers/net/hns3/hns3_fdir.c
> +++ b/drivers/net/hns3/hns3_fdir.c
> @@ -1066,7 +1066,7 @@ int hns3_fdir_filter_program(struct hns3_adapter *hns,
>  		return -ENOMEM;
>  	}
>  
> -	rte_memcpy(&node->fdir_conf, rule, sizeof(struct hns3_fdir_rule));
> +	memcpy(&node->fdir_conf, rule, sizeof(struct hns3_fdir_rule));
>  	ret = hns3_insert_fdir_filter(hw, fdir_info, node);
>  	if (ret < 0) {
>  		rte_free(node);
> diff --git a/drivers/net/hns3/hns3_flow.c b/drivers/net/hns3/hns3_flow.c
> index f2d1e4ec3a..f7e4d339d3 100644
> --- a/drivers/net/hns3/hns3_flow.c
> +++ b/drivers/net/hns3/hns3_flow.c
> @@ -2588,8 +2588,8 @@ hns3_flow_query(struct rte_eth_dev *dev, struct rte_flow *flow,
>  			}
>  			rss_conf = (struct rte_flow_action_rss *)data;
>  			rss_rule = (struct hns3_rss_conf_ele *)flow->rule;
> -			rte_memcpy(rss_conf, &rss_rule->filter_info.conf,
> -				   sizeof(struct rte_flow_action_rss));
> +			memcpy(rss_conf, &rss_rule->filter_info.conf,
> +			       sizeof(struct rte_flow_action_rss));
>  			break;
>  		default:
>  			return rte_flow_error_set(error, ENOTSUP,

