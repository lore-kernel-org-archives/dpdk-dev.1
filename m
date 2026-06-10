Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E348CD8CB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 01:42:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0353D40E20;
	Wed, 10 Jun 2026 03:40:17 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id E47044026D
 for <dev@dpdk.org>; Wed, 10 Jun 2026 03:39:55 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=toDoo+h1z/GZ4IzyZ/l6KmOSpEFsKy4427NFU5bwNDg=;
 b=nDTF2A6NdBckmReh9O5KrLJrXrF3DG+XHH78Oq2kaORsvhSmd7G5oTuu0Fl3TbHkiU8UK3WDH
 hDngweBTsxVQLFiXsOhJYUgbuMOCfQ5vTmOgvtntkEMMgLU5HrIqMY9lh+OqqdNMs6+cq2suDaA
 yIBBbvvunZjoAcKe3Jdwf20=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gZpD13GgGz1cyP6
 for <dev@dpdk.org>; Wed, 10 Jun 2026 09:32:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 44B8740573
 for <dev@dpdk.org>; Wed, 10 Jun 2026 09:39:54 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 09:39:53 +0800
Message-ID: <97afe9be-41c0-44da-b144-0fddeb7374e5@huawei.com>
Date: Wed, 10 Jun 2026 09:39:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] extend interactive telemetry script
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
 <20260609161400.3661268-1-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260609161400.3661268-1-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 6/10/2026 12:13 AM, Bruce Richardson wrote:
> To simplify interactive telemetry script for general use, i.e. not from
> other scripts, we can add two new features to it:
> 
> 1. Support for FOREACH to allow gathering a set of output values across
>    a list of ports or devices, e.g. ethdevs or rawdevs.
> 2. Support having predefined aliases in a file in the user's home
>    directory to simplify the use of more complicated FOREACH commands.
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
> ---
> v3: updated based on review feedback from Chengwen:
>     - added arg to override alias file
>     - printed one-line summary of alias count loaded
>     - improved doc for "help" command
>     - added "help alias" to list aliases.
> v2: added third patch with "help" command giving more details on
>     how to use the various commands.
> 
> Bruce Richardson (3):
>   usertools/telemetry: add a FOREACH command
>   usertools/telemetry: support using aliases for long commands
>   usertools/telemetry: add help support
> 
>  doc/guides/howto/telemetry.rst | 106 ++++++++++++-
>  usertools/dpdk-telemetry.py    | 278 ++++++++++++++++++++++++++++++++-
>  2 files changed, 373 insertions(+), 11 deletions(-)
> 
> --
> 2.53.0
> 
> 

