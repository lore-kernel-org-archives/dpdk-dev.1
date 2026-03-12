Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9D8105A593
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 12:37:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E770E402C9;
	Thu, 12 Mar 2026 13:37:49 +0100 (CET)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 63C12402AC;
 Thu, 12 Mar 2026 13:37:46 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=lB5P0Zy1Yr/JF48yAbzkeDHp9EiGRVb/WcsSMIdTMsE=;
 b=cRH+2EjEak7iI29xeL8k6BLhZMvCEnqcJGv/2lyqMexvRBVt7mPVngJ/pV59oweCW4A+XfENn
 PEVhVrmjoDED3/E8hMEVstgtcA4bsj4evLDvSvDt1tbj2wvhtgbN+5D8biOS5V/GtGG6BlPpYyh
 OrIXLj15CeOsxmAXyBgx0es=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fWn7x4B0Kz1prLv;
 Thu, 12 Mar 2026 20:32:45 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id D865040363;
 Thu, 12 Mar 2026 20:37:43 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Mar 2026 20:37:43 +0800
Message-ID: <51026e44-1045-47ef-add5-7a98c3ad4eac@huawei.com>
Date: Thu, 12 Mar 2026 20:37:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] app/testpmd: check for no arguments
To: Kevin Traynor <ktraynor@redhat.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Aman Singh <aman.deep.singh@intel.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
 <20260312103606.702617-4-ktraynor@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260312103606.702617-4-ktraynor@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

Hi Kevin,

On 3/12/2026 6:36 PM, Kevin Traynor wrote:
> For the case where token is NULL, there are no arguments
> and split_str[0] is used uninitialized.

In which case the token is NULL, if there are no arguments, the cmdline's
callback won't be invoke.

Thanks

> 
> Check counter to ensure there is a token and return error if not.
> 
> Fixes: 601576ae6699 ("app/testpmd: add prio-tc map in DCB command")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>
> ---
>  app/test-pmd/cmdline.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index c33c66f327..ab85f4e0ad 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -3570,4 +3570,9 @@ parse_dcb_token_value(char *token_str,
>  	} while (1);
>  
> +	if (split_num == 0) {
> +		fprintf(stderr, "Bad Argument: no arguments provided\n");
> +		return -1;
> +	}
> +
>  	/* parse fixed parameter "pfc-en" first. */
>  	token = split_str[0];

