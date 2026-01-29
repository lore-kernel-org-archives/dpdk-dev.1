Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570D2D46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:35:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76302402C4;
	Thu, 29 Jan 2026 02:35:39 +0100 (CET)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 7720040297
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:35:38 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=eVnS8kZzIuSGBFospvGWqTMOQzNdSyO5PnN3jGpXAs8=;
 b=gYMJdBEc9QQgcKAUFZtb6XHsfJWCr93zsATXEhv5HhIiQcXj//rJCSXdKuDPBH6jMm6pwsM44
 BM8N+vzYVSBXP5UVjA78TmClold6ICac68nU9OBBzQoMUtf46ZwQVrScRLOLNfZqMWzEnymymct
 MxjHhoHmIwYql9EiqbNLxbc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4f1hT20zkCz1prLc;
 Thu, 29 Jan 2026 09:32:06 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 656F940569;
 Thu, 29 Jan 2026 09:35:36 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 09:35:35 +0800
Message-ID: <b5e6bceb-dddd-458f-9bb7-70ff08efbec1@huawei.com>
Date: Thu, 29 Jan 2026 09:35:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] argparse: fix minsize build
To: Thomas Monjalon <thomas@monjalon.net>, <dev@dpdk.org>
CC: <david.marchand@redhat.com>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260128120005.2777473-1-thomas@monjalon.net>
 <20260128120005.2777473-3-thomas@monjalon.net>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260128120005.2777473-3-thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 1/28/2026 7:58 PM, Thomas Monjalon wrote:
> This error is seen in build of type "minsize":
> 
> In function 'parse_args', lib/argparse/rte_argparse.c:764:31: error:
> 'arg_idx' may be used uninitialized [-Werror=maybe-uninitialized]
>   764 |                 if (arg_parsed[arg_idx] && !arg_attr_flag_multi(arg)) {
>       |                               ^
> 
> It looks to be a compiler issue because we are not supposed
> to reach this point in case of find_option_arg() failure.
> 
> The variable is initialized to allow compiling with "minsize" option.
> 
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>


