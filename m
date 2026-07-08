Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA259C43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 00:38:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DFB940264;
	Wed,  8 Jul 2026 02:38:09 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id BFB2640041
 for <dev@dpdk.org>; Wed,  8 Jul 2026 02:38:07 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=wzDZlS22F7ZxO12KiDORnFwXcZC1YtgW49RnX2uuGLw=;
 b=LcOx50zv3+Q42U0hLVhdjshg/MNyfY3Si85YFY09m5GZyl/LJZG9vr6Wac5JO8ou8aSbqG2bO
 OD9QYf8KGco84Ry30ZSdKiumJNwQYCbJWP4rT4iZqjCtoN4GdL6Ula7hwkYLeYFjF3wOe7Bezwt
 MfQafUUCtMwdCMLEfrfDh5g=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gvzVB5Y3Cz1cyP2;
 Wed,  8 Jul 2026 08:28:50 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 276984057A;
 Wed,  8 Jul 2026 08:38:03 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 8 Jul 2026 08:38:02 +0800
Message-ID: <149a8bf9-84f9-4ad6-8a08-fe4eec8dde0f@huawei.com>
Date: Wed, 8 Jul 2026 08:38:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dev: fix hotplug notification to secondary
To: David Marchand <david.marchand@redhat.com>, <dev@dpdk.org>
References: <20260706145510.680077-1-david.marchand@redhat.com>
 <20260707115551.967336-1-david.marchand@redhat.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260707115551.967336-1-david.marchand@redhat.com>
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

On 7/7/2026 7:55 PM, David Marchand wrote:
> There was a logical error when making some last minute change.
> Fix the no_shconf evaluation.
> 
> Bugzilla ID: 1963
> Fixes: 1a2e26d8701d ("dev: skip multi-process in hotplug")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
> Changes since v1:
> - separated the unit test from the fix,
> 
> ---
>  lib/eal/common/eal_common_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/eal/common/eal_common_dev.c b/lib/eal/common/eal_common_dev.c
> index 9ed62a20e0..b43b0a4bb3 100644
> --- a/lib/eal/common/eal_common_dev.c
> +++ b/lib/eal/common/eal_common_dev.c
> @@ -269,7 +269,7 @@ rte_dev_probe(const char *devargs)
>  {
>  	const struct internal_config *internal_conf =
>  		eal_get_internal_configuration();
> -	bool do_mp = !!internal_conf->no_shconf;
> +	bool do_mp = internal_conf->no_shconf == 0;
>  	struct eal_dev_mp_req req;
>  	struct rte_device *dev;
>  	int ret;
> @@ -428,7 +428,7 @@ rte_dev_remove(struct rte_device *dev)
>  {
>  	const struct internal_config *internal_conf =
>  		eal_get_internal_configuration();
> -	bool do_mp = !!internal_conf->no_shconf;
> +	bool do_mp = internal_conf->no_shconf == 0;
>  	struct eal_dev_mp_req req;
>  	char *devargs;
>  	int ret;

