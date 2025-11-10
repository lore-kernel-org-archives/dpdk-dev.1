Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B97CCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 01:00:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 849A9402B0;
	Mon, 10 Nov 2025 02:00:00 +0100 (CET)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id D0315400D6;
 Mon, 10 Nov 2025 01:59:58 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=FS9YElJN5L04auiF15n9IPU1j1b83nzZ8rta9LrxDY8=;
 b=QCuvwOo0i7JOEdyJjOmEt/bFWhKVsN99M5VcnPPWzCH8LNTGuyQMh8nAq0rMeDQZVZ96Y7NhG
 z2ikMvrU96cdsl/dFATFYWa3CPiIAH3avWzAFPM7/agcgQnJxEV6kPByB07tNjOkGfuFFXqjjb/
 WWteckUbvWlzEtLGsKTB7xs=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4d4WW43P5cz12LDD;
 Mon, 10 Nov 2025 08:58:24 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 52EFC140156;
 Mon, 10 Nov 2025 08:59:57 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 08:59:56 +0800
Message-ID: <97f3afc3-3613-4c45-bf0d-9a047271e30e@huawei.com>
Date: Mon, 10 Nov 2025 08:59:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/33] eal: fix variable shadowing
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
CC: <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Tyler Retzlaff <roretzla@linux.microsoft.com>, Jerin
 Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Anatoly
 Burakov <anatoly.burakov@intel.com>, David Marchand
 <david.marchand@redhat.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
 <20251107155034.436809-3-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251107155034.436809-3-bruce.richardson@intel.com>
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

Acked-by: Chengwen Feng <fengchengwen@huawei.com>

On 11/7/2025 11:49 PM, Bruce Richardson wrote:
> Fix a range of variable shadowing issues flagged by -Wshadow:
> 
> * In tracing code, rename local variables to remove shadowing in the
>   code.  The file-level variable "trace" is kept as-is, but the shorter
>   name "t" is used for function-local vars.
> * In options code, rename the "args" variable to "out_args" in the
>   telemetry callback, to fix shadowing issues there.
> * In malloc code, remove the redefinition of aligned_end, and just use
>   the already-defined local variable in the last block of code in the
>   function.
> 
> Bugzilla ID: 1742
> Bugzilla ID: 1743
> Fixes: 29d985cad8db ("trace: implement memory allocation")
> Fixes: f330b01df996 ("eal: define the parameters in argparse format")
> Fixes: 4d8bdd8b56a1 ("malloc: fix ASan handling for unmapped memory")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

