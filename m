Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B265CCFA13
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 00:57:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA4DF4021F;
	Fri,  7 Nov 2025 01:57:35 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 8CA834013F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 01:57:34 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=pzx30jVcGKh4fDixmKNlXDIAwX87w1RBq29xSdZocgE=;
 b=jKGNuiJzOpJeBONVkO6MKupNPROxTkub+uMAT4BSd+CdbTTK2oy42yhwWRiEmUjTq2UeALlkv
 yaipQQI6jtpl4Dpjy9+/WkX/E0y/zSHLlsgqfHlj5lmirM0r2Sp9xCyCqxDu6zpF5Nh7fiOuwBJ
 Dgd947I0WtClxwJ5TGzBpL4=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d2gbc1kX4z1cyPs;
 Fri,  7 Nov 2025 08:55:56 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C804C140159;
 Fri,  7 Nov 2025 08:57:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 08:57:32 +0800
Message-ID: <5885fb7e-9aed-49ca-b035-207009057279@huawei.com>
Date: Fri, 7 Nov 2025 08:57:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] app/testpmd: support specify TCs when DCB forward
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <thomas@monjalon.net>, <dev@dpdk.org>, <aman.deep.singh@intel.com>,
 <liuyonglong@huawei.com>, <yangxingui@huawei.com>, <lihuisong@huawei.com>
References: <20251104040916.25864-1-fengchengwen@huawei.com>
 <20251106124959.2592-1-fengchengwen@huawei.com>
 <20251106112447.7b13d440@phoenix>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20251106112447.7b13d440@phoenix>
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

On 11/7/2025 3:24 AM, Stephen Hemminger wrote:
> On Thu, 6 Nov 2025 20:49:59 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> +static void
>> +dcb_forward_tc_update_dcb_info(struct rte_eth_dcb_info *org_dcb_info)
>> +{
>> +	struct rte_eth_dcb_info dcb_info = {0};
>> +	uint32_t i, vmdq_idx;
>> +	uint32_t tc = 0;
>> +
>> +	if (dcb_fwd_tc_mask == DEFAULT_DCB_FWD_TC_MASK)
>> +		return;
>> +
>> +	/*
>> +	 * Use compress scheme to update dcb-info.
>> +	 * E.g. If org_dcb_info->nb_tcs is 4 and dcb_fwd_tc_mask is 0x8, it
>> +	 *      means only enable TC3, then the new dcb-info's nb_tcs is set to
>> +	 *      1, and also move corresponding tc_rxq and tc_txq info to new
>> +	 *      index.
>> +	 */
>> +	for (i = 0; i < org_dcb_info->nb_tcs; i++) {
>> +		if (!(dcb_fwd_tc_mask & (1u << i)))
>> +			continue;
>> +		for (vmdq_idx = 0; vmdq_idx < RTE_ETH_MAX_VMDQ_POOL; vmdq_idx++) {
>> +			dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].base =
>> +				org_dcb_info->tc_queue.tc_rxq[vmdq_idx][i].base;
>> +			dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue =
>> +				org_dcb_info->tc_queue.tc_rxq[vmdq_idx][i].nb_queue;
>> +			dcb_info.tc_queue.tc_txq[vmdq_idx][tc].base =
>> +				org_dcb_info->tc_queue.tc_txq[vmdq_idx][i].base;
>> +			dcb_info.tc_queue.tc_txq[vmdq_idx][tc].nb_queue =
>> +				org_dcb_info->tc_queue.tc_txq[vmdq_idx][i].nb_queue;
>> +		}
>> +		tc++;
>> +	}
>> +	dcb_info.nb_tcs = tc;
>> +	memcpy(org_dcb_info, &dcb_info, sizeof(struct rte_eth_dcb_info));
> 
> Prefer direct structure assignment over memcpy() here.
> 	*org_dcb_info = dcb_info;
> 
> This makes sure types are the same, and compiler generates same code.

Thanks Stephen, the V4 already sent to fix it.

