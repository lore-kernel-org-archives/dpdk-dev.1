Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A47C5AC67
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 03:33:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67A2C402AC;
	Fri,  7 Aug 2026 05:33:03 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id E7A9D40279
 for <dev@dpdk.org>; Fri,  7 Aug 2026 05:33:01 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=BYR6F4zbyW1rHg0ObEA8Di+jjSPMlyn1fPcx7iGJux4=;
 b=VVCnkN3q2dqD3wWrahoFqfO8KBVwR6UIsk5rZuXKKY4BIEt4WZlTQF1E3StLF4njgwJ67y6RP
 XlzR7qMxh8DxKdfY1mzalssgdAAj8WTvMgSt6frtDK8sFr3xgS0Okjkm5TLE+nqZk3X72REQ5C6
 EqO9n4crZWVJYhpXwrwh1OU=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hGTxh2FGmz1prKd;
 Fri,  7 Aug 2026 11:23:20 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 9C5884057D;
 Fri,  7 Aug 2026 11:32:54 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 11:32:54 +0800
Message-ID: <21ea27ff-513c-425e-8dfd-2a7fc4cee626@huawei.com>
Date: Fri, 7 Aug 2026 11:32:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] devtools: support local opencode agent for patch review
To: Chengwen Feng <chengwen.feng@linux.dev>, <thomas@monjalon.net>,
 <stephen@networkplumber.org>
CC: <aconole@redhat.com>, <dev@dpdk.org>
References: <20260703091902.525837-1-datshan@qq.com>
 <20260807031104.2503404-1-chengwen.feng@linux.dev>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260807031104.2503404-1-chengwen.feng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

On 8/7/2026 11:11 AM, Chengwen Feng wrote:
> From: Chengwen Feng <fengchengwen@huawei.com>
> 
> Currently review-patch.py only supports cloud AI providers
> (Anthropic, OpenAI, xAI, Google) via REST API, requiring API keys.
> 
> Add a --via option that invokes the locally installed opencode CLI as
> the review runner instead of making HTTP calls. opencode reads
> AGENTS.md from the DPDK project directory automatically, needing no
> configuration beyond opencode on PATH.
> 
> The --via and -p/--provider options are independent -- via routes to
> the local agent mode while -p continues to use the cloud API path.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Morten Brørup <mb@smartsharesystems.com>
> ---
> v5: Use linux.dev mailbox to send email and update mailmap
> v4: Fix AI review comments with Claude Opus which provided by Stephen
> v3: Rebase main to fix apply error
> v2: Address comments from Stephen, including: not arise
> FileNotFoundError and more clarify.
> 
> ---
>  .mailmap                            |   2 +-
>  devtools/ai/review-patch.py         | 305 ++++++++++++++++++++++------
>  doc/guides/contributing/patches.rst |  10 +
>  3 files changed, 249 insertions(+), 68 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index fcb3d1bb3f..d86a09b5b3 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -270,7 +270,7 @@ Chengfei Han <han.chengfei@zte.com.cn>
>  Chengfeng Ye <cyeaa@connect.ust.hk>
>  Chenghu Yao <yao.chenghu@zte.com.cn>
>  Chenglian Sun <sunchenglian@loongson.cn>
> -Chengwen Feng <fengchengwen@huawei.com>
> +Chengwen Feng <fengchengwen@huawei.com> <chengwen.feng@linux.dev>

For this new email address:
Acked-by: Chengwen Feng <fengchengwen@huawei.com>


