Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032BE1088E58
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 01:36:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8F2E402AC;
	Thu, 19 Mar 2026 02:36:00 +0100 (CET)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 8F776402A7;
 Thu, 19 Mar 2026 02:35:59 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=PFPvTFwcWyYnno0GsJwKpMcdpmwEYTwBOl35FES/RHU=;
 b=GIC+wIxFPXDhh1eGh7E3/Vyn/K+4xR5IQk3RmViHwOIdH0U7cDaAw49XqvBmywg8eV+4VlO5q
 lQ12fJbIhisFZ8i07VHSfdpnnRmA2vygYtFL5Pq27G3BD7XzJSnQfzgZlNox4C7jfA0ZK9cUNJN
 KZ7eRXQgsvLiKSYhwmOiUtw=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fbp744JdtzmV65;
 Thu, 19 Mar 2026 09:30:56 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 8514F402AB;
 Thu, 19 Mar 2026 09:35:57 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Mar 2026 09:35:57 +0800
Message-ID: <93153650-162e-40ca-ab72-82c0faf4a3a1@huawei.com>
Date: Thu, 19 Mar 2026 09:35:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] app/testpmd: fix DCB forwarding TC mismatch handling
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>, <dev@dpdk.org>, 
 <bruce.richardson@intel.com>, <aman.deep.singh@intel.com>
CC: <shaiq.wani@intel.com>, <stable@dpdk.org>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
 <20260318061720.1885589-1-chaitanyababux.talluri@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260318061720.1885589-1-chaitanyababux.talluri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Hi,

On 3/18/2026 2:17 PM, Talluri Chaitanyababu wrote:
> Fix DCB forwarding issues when RX and TX ports are configured with
> different numbers of traffic classes (TCs).

Suggest: Fix DCB forwarding failed when the number of TCs on ports is inconsistent.

And RX/TX -> Rx/Tx

> 
> When ports have asymmetric TC configurations (e.g. 4 TCs on RX and 8 TCs
> on TX), the forwarding logic iterates based only on the RX port TC count.

e.g. 4 TCs on RX and 8 TCs on TX
suggest replaced with: e.g. 2 ports, port0 has 4 TCs and port1 has 8 TCs

And suggest add the testpmd command in commit-log like below so that others could reproduce:
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-20 -n 4 -a 0000:31:00.0 -a 0000:4b:00.0 --file-prefix=testpmd1 -- -i --rxq=256 --txq=256 --nb-cores=16 --total-num-mbufs=600000
port stop all
port config 0 dcb vt off 8 pfc on
port config 1 dcb vt off 8 pfc on
port start all
port stop all
port config 0 dcb vt off 4 pfc on

> This can lead to accessing invalid TX TC entries and incorrect queue
> mapping, potentially causing multiple threads to operate on the same
> queues.

Suggest: This can lead to accessing invalid TX TC entries and incorrect queue
 mapping and which will result SIGFPE exception.

> 
> Additionally, the existing VMDq pool guard in dcb_fwd_config_setup()
> only checks RX queue counts and does not consider the case where the TX
> port has no queues for a given pool/TC combination.
> 
> Fix this by:
> 1. Introducing an effective TC count using RTE_MIN() of RX and TX TC
>    values, ensuring forwarding only operates on valid TCs supported by
>    both ports.
> 2. Updating the loop condition to use the effective TC count instead of
>    only the RX TC count.
> 3. Extending validation in dcb_fwd_check_cores_per_tc() to ensure both RX
>    and TX queue counts are divisible by dcb_fwd_tc_cores, preventing
>    invalid configurations.

Suggest 1&2 as one commit, and 3 as another commit.

> 
> This ensures correct queue mapping and avoids issues when switching
> between different DCB configurations across ports.
> 
> Fixes: 945e9be0a803 ("app/testpmd: support multi-cores process one TC")

The SIGFPE error was not introduced by this commit as I pointed out in early reply to v2.
I just suggest you split two commit, the second commit could adds this fix tag, but as the
first commit please find the real commit which introduce the bug.

> Cc: stable@dpdk.org
> 
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---

...
