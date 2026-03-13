Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9B1FED2F5
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 00:19:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AEEA040279;
	Fri, 13 Mar 2026 01:19:29 +0100 (CET)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id C3B754026C;
 Fri, 13 Mar 2026 01:19:27 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JyUXCmTVZjQwIsQhL8bKaDa138CofOGeFr0/VlP1rbg=;
 b=flotL3kXdyqDVj6ITYWl5YTQD+Zl/R3enu7ru7d87q3droRR3ewi19t8bC8rEkznX9t40VPjF
 Wp3yv0XdfLvYu+b1cztPePwyfAVHMgw6yG66KNgMivJwMHyCJvib9VNGIEA/TTF4Jbs81/i6vjY
 DUCjXKBtvv/e8/hhscyuEik=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fX4jd3dsdzRhQS;
 Fri, 13 Mar 2026 08:14:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 0A89540561;
 Fri, 13 Mar 2026 08:19:25 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 08:19:24 +0800
Message-ID: <4fd815c8-4ce1-4182-af8b-57b7b92291a8@huawei.com>
Date: Fri, 13 Mar 2026 08:19:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] app/testpmd: fix DCB forwarding TC mask and queue guard
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>, <dev@dpdk.org>, 
 <bruce.richardson@intel.com>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
CC: <shaiq.wani@intel.com>, <stable@dpdk.org>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
 <20260312103615.1282874-1-chaitanyababux.talluri@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260312103615.1282874-1-chaitanyababux.talluri@intel.com>
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

On 3/12/2026 6:36 PM, Talluri Chaitanyababu wrote:
> Update forwarding TC mask based on configured traffic classes to properly
> handle both 4 TC and 8 TC modes. The bitmask calculation (1u << nb_tcs) - 1
> correctly creates masks for all available traffic classes (0xF for 4 TCs,
> 0xFF for 8 TCs).
> 
> When the mask is not updated after a TC configuration change, it stays at
> the default 0xFF, which causes dcb_fwd_tc_update_dcb_info() to skip the
> compress logic entirely (early return when mask ==
> DEFAULT_DCB_FWD_TC_MASK).
> This can lead to inconsistent queue allocations.

Sorry, I cannot understand your question. Could you please provide some steps
to reproduce the issue and the problem phenomenon?

> 
> Additionally, the existing VMDQ pool guard in dcb_fwd_config_setup() only
> checks RX queue counts, missing the case where the TX port has zero queues
> for a given pool/TC combination. When nb_tx_queue is 0, the expression
> "j % nb_tx_queue" triggers a SIGFPE (integer division by zero).

The dcb_fwd_check_cores_per_tc() check this case. So please provide the steps.

> 
> Fix this by:
> 1. Updating dcb_fwd_tc_mask after port DCB reconfiguration using the
>    user requested num_tcs value, so fwd_config_setup() sees the correct
>    mask.
> 2. Extending the existing pool guard to also check TX queue counts.
> 3. Adding a defensive break after the division by dcb_fwd_tc_cores to
>    catch integer truncation to zero.
> 
> Fixes: 0ecbf93f5001 ("app/testpmd: add command to disable DCB")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
