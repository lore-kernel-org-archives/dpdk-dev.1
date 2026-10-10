Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4985CA9EBB
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 02:36:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E008E402B4;
	Sat, 10 Oct 2026 04:36:35 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 6B8254027C
 for <dev@dpdk.org>; Sat, 10 Oct 2026 04:36:33 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=gTrmPEltEsow0TkrPEhzZmvyr03UN2fIaTtpReup1sE=;
 b=pOcUGGlLqkJ2C4wwBDx6asoHchv5/o/T+rRKH5mlr62NX8A9ul6BANwKlTNKHLXPofDsE6h8k
 /hOix7uO4ACrPBmo18IlVN/OR+R0X3RAqPl+1wy0mNs9dUPpJ3TNJg8OaGu1rOeJY7b1ah7WFCP
 cNokGFSEubWz1tG8mvzNiDs=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j1nbv274MzKm4b;
 Sat, 10 Oct 2026 10:24:11 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 55CB94056C;
 Sat, 10 Oct 2026 10:36:30 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 10 Oct 2026 10:36:29 +0800
Message-ID: <cccc85b5-9c7d-4faf-a4c9-5d1f0f2bdb3b@huawei.com>
Date: Sat, 10 Oct 2026 10:36:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 39/65] net/hns3: use kvargs numeric helpers
To: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
CC: Xingui Yang <yangxingui@huawei.com>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
 <20260930224340.58580-40-stephen@networkplumber.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260930224340.58580-40-stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

On 10/1/2026 6:40 AM, Stephen Hemminger wrote:
> hns3_parse_mbx_time_limit() checks neither errno nor the end pointer, so
> a malformed value such as "abc" is taken as zero and then silently
> ignored by the range test that follows.
> 
> The range test is now part of the conversion, which keeps the existing
> behaviour of leaving the default in place when the value is out of
> range.
> 
> The device capability mask parser is converted separately, later in this
> series, since it needs the hexadecimal handler rather than a decimal one.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/hns3/hns3_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_common.c
> index 29b51856d9..c21740ba5e 100644
> --- a/drivers/net/hns3/hns3_common.c
> +++ b/drivers/net/hns3/hns3_common.c
> @@ -231,14 +231,13 @@ hns3_parse_mbx_time_limit(const char *key, const char *value, void *extra_args)
>  	if (value == NULL || extra_args == NULL)
>  		return 0;
>  
> -	val = strtoul(value, NULL, HNS3_CONVERT_TO_DECIMAL);
> -
>  	/*
>  	 * 500ms is empirical value in process of mailbox communication. If
>  	 * the delay value is set to one lower than the empirical value, mailbox
>  	 * communication may fail.
>  	 */
> -	if (val > HNS3_MBX_DEF_TIME_LIMIT_MS && val <= UINT16_MAX)
> +	if (rte_kvargs_to_uint(value, HNS3_MBX_DEF_TIME_LIMIT_MS + 1,
> +			       UINT16_MAX, &val) == 0)

It should be:
if (rte_kvargs_to_uint(value, HNS3_MBX_DEF_TIME_LIMIT_MS,
			       UINT16_MAX, &val) == 0)

Thanks

>  		*(uint16_t *)extra_args = val;
>  
>  	return 0;

