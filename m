Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E904CD5BAB
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 00:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A8194029F;
	Fri, 22 May 2026 02:45:00 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 438FF40287
 for <dev@dpdk.org>; Fri, 22 May 2026 02:44:59 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=UkPRYdD4X4D8xxEPLBbEjrgFEhgzcl3G6LYn1SLJdwQ=;
 b=xKDYUvGkvKoTLZmaowaY0w01HkZWTRXKiofqeKYiEFWnfFWreDgaV09gFYlFOLxf5ORrzuDvY
 G/ZPfh5rDiMi/d3QYwsoX5vltQiWcsqdkxlRZwRM3O5hUj28BbOhYAY2z71scVCCyP2G63QsYX3
 88rGW1R6a2z0qB9iZRAK2QA=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gM5vb3zfNz1cyNp
 for <dev@dpdk.org>; Fri, 22 May 2026 08:37:15 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B07CF402AB
 for <dev@dpdk.org>; Fri, 22 May 2026 08:44:56 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 08:44:56 +0800
Message-ID: <628f817f-7f6a-41c5-b21f-e7b28224fb51@huawei.com>
Date: Fri, 22 May 2026 08:44:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] extend interactive telemetry script
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260521153913.82634-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

On 5/21/2026 11:39 PM, Bruce Richardson wrote:
> To simplify interactive telemetry script for general use, i.e. not from
> other scripts, we can add two new features to it:
> 
> 1. Support for FOREACH to allow gathering a set of output values across
>    a list of ports or devices, e.g. ethdevs or rawdevs.
> 2. Support having predefined aliases in a file in the user's home
>    directory to simplify the use of more complicated FOREACH commands.

+1
How about add help command to introducing above FOREACH and aliases?

> 
> Putting these together, we can create new commands such as "eth_names".
> 
>   bruce@host:$ cat ~/.dpdk_telemetry_aliases
>   eth_names=FOREACH index /ethdev/list /ethdev/info,$index .name
> 
>   bruce@host:$ echo eth_names | ./usertools/dpdk-telemetry.py | jq
>   [
>     {
>       "index": 0,
>       "name": "0000:16:00.0"
>     },
>     {
>       "index": 1,
>       "name": "0000:16:00.1"
>     }
>   ]
> 
> Bruce Richardson (2):
>   usertools/telemetry: add a FOREACH command
>   usertools/telemetry: support using aliases for long commands
> 
>  doc/guides/howto/telemetry.rst |  76 +++++++++++++
>  usertools/dpdk-telemetry.py    | 201 ++++++++++++++++++++++++++++++++-
>  2 files changed, 271 insertions(+), 6 deletions(-)
> 
> --
> 2.53.0
> 

