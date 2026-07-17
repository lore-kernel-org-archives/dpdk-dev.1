Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0451C44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:42:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02D0940DDD;
	Fri, 17 Jul 2026 11:42:44 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 311B940270
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:42:42 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=AlTsNYgIpv49PLoXwWhXYjPbLwyZx/eVI0Dn++DikSM=;
 b=l1VYILv7/DT8YH0ITN4c2TuDXZuzDeNA+cd4arHiH6qL0/gY2LVm/BAc/HzWDD0KVZKghdNhA
 SmcjecTDPEugg82gS8MSATioHPdv8sckhIjLo1Gluk6+GStgJw5mMAPnaDmCE5tru/eiycxxtKb
 jd1pcMRG7KomaOyj3c8f0mg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h1l8F5mbRzKm9T
 for <dev@dpdk.org>; Fri, 17 Jul 2026 17:33:17 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id E06F14055B
 for <dev@dpdk.org>; Fri, 17 Jul 2026 17:42:39 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Jul 2026 17:42:39 +0800
Message-ID: <7bfdca40-f163-4b2d-89fb-36e2cee4a16a@huawei.com>
Date: Fri, 17 Jul 2026 17:42:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] doc: clean-up links in guides
To: <dev@dpdk.org>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
 <20260716103632.711164-1-thomas@monjalon.net>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260716103632.711164-1-thomas@monjalon.net>
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

Series-acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 7/16/2026 6:31 PM, Thomas Monjalon wrote:
> Links and references to other guide sections had multiple issues,
> all solved in this series.
> 
> The important metric in cleanups is having more deletions than additions:
>  278 files changed, 1054 insertions(+), 1700 deletions(-)
> meaning it should be easier to maintain.
> 
> 
> David Marchand (1):
>   doc: remove unused labels from guides
> 
> Nandini Persad (1):
>   doc: add prefixes to guide labels
> 
> Thomas Monjalon (6):
>   doc: adjust heading underline lengths
>   doc: replace vague references with precise links
>   doc: shorten page references in guides
>   doc: link whole-guide references to pages
>   doc: remove redundant link captions
>   doc: avoid numbered guide references
