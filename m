Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DEAFB5E8B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 01:23:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E38C402D6;
	Tue, 17 Mar 2026 02:23:40 +0100 (CET)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id AD0A540270;
 Tue, 17 Mar 2026 02:23:36 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=vDhda+S/R7YbnKjh/gYY1KhhTqfXbTOTJk9VZWBCMzc=;
 b=AVAP5CGmoDwo6QJc/2RLYu16eBwEe2IImBgpcfgZSSV4eF5lxNPY45iehXfJOkwwVw92aPTM8
 BtewjlPu8UH2btbULrcLf5Tdk6CvPrh87aDNuBKzZFPhyDwKnbV+DfyB6XNHY65N3FkoeXQLmVE
 wHnfmxhbwAtXVF5NBayaw44=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fZYxL5fDGz1T4FW;
 Tue, 17 Mar 2026 09:18:14 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 2C64E40569;
 Tue, 17 Mar 2026 09:23:34 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Mar 2026 09:23:33 +0800
Message-ID: <ee1ff3fc-32c2-4b6c-8790-83451f6a15e9@huawei.com>
Date: Tue, 17 Mar 2026 09:23:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] app/testpmd: fix DCB forwarding TC mask and queue guard
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>, <dev@dpdk.org>, 
 <bruce.richardson@intel.com>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
CC: <shaiq.wani@intel.com>, <stable@dpdk.org>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
 <20260316062118.1508009-1-chaitanyababux.talluri@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260316062118.1508009-1-chaitanyababux.talluri@intel.com>
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

On 3/16/2026 2:21 PM, Talluri Chaitanyababu wrote:
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
> 
> Additionally, the existing VMDQ pool guard in dcb_fwd_config_setup() only
> checks RX queue counts, missing the case where the TX port has zero queues
> for a given pool/TC combination. When nb_tx_queue is 0, the expression
> "j % nb_tx_queue" triggers a SIGFPE (integer division by zero).
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

Why this commit?

> Cc: stable@dpdk.org
> 
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
> 
> v3: Removed old email address.
> 
> v2:
> * Used res->num_tcs to derive dcb_fwd_tc_mask.
> * Removed redundant rte_eth_dev_get_dcb_info().
> ---
>  app/test-pmd/cmdline.c | 3 +++
>  app/test-pmd/config.c  | 9 ++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> index e9a1331071..a53af7e72b 100644
> --- a/app/test-pmd/cmdline.c
> +++ b/app/test-pmd/cmdline.c
> @@ -3682,6 +3682,9 @@ cmd_config_dcb_parsed(void *parsed_result,
>  		return;
>  	}
>  
> +	/* Update forwarding TC mask to match the configured number of TCs. */
> +	dcb_fwd_tc_mask = (1u << res->num_tcs) - 1;

This is just configure, please don't modify it when run command.
Combined with your detail steps last email, I may guest your problem:

1. port stop all
2. port config 0 dcb vt off 8 pfc on
3. port config 1 dcb vt off 8 pfc on
4. port start all
5. port stop all
6. port config 0 dcb vt off 4 pfc on

When the step6 executed, the port 0 has 4 TC, but the port 1 still has 8 TC which was configured in step3
If start forward after step6, the TC was mismatch, it may lead to multiple thread operators the same Tx queues.

So you want to make sure only forward 4 TC in both port0 and port1 in step6 ?

> +
>  	fwd_config_setup();
>  
>  	cmd_reconfig_device_queue(port_id, 1, 1);
> diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
> index f9f3c542a6..9b201ac241 100644
> --- a/app/test-pmd/config.c
> +++ b/app/test-pmd/config.c
> @@ -5450,7 +5450,8 @@ dcb_fwd_config_setup(void)
>  			/* if the nb_queue is zero, means this tc is
>  			 * not enabled on the POOL
>  			 */
> -			if (rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue == 0)
> +			if (rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue == 0 ||
> +			    txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue == 0)
>  				break;
>  			k = fwd_lcores[lc_id]->stream_nb +
>  				fwd_lcores[lc_id]->stream_idx;
> @@ -5458,6 +5459,12 @@ dcb_fwd_config_setup(void)
>  						dcb_fwd_tc_cores;
>  			nb_tx_queue = txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue /
>  						dcb_fwd_tc_cores;
> +			/* guard against integer truncation to zero (e.g.
> +			 * nb_queue=1, dcb_fwd_tc_cores=2) to prevent SIGFPE
> +			 * from "j % nb_tx_queue" below.
> +			 */
> +			if (nb_rx_queue == 0 || nb_tx_queue == 0)
> +				break;

This could add in dcb_fwd_check_cores_per_tc():
	for (port = 0; port < nb_fwd_ports; port++) {
		(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[port], &dcb_info);
		for (tc = 0; tc < dcb_info.nb_tcs; tc++) {
			for (vmdq_idx = 0; vmdq_idx < RTE_ETH_MAX_VMDQ_POOL; vmdq_idx++) {
				if (dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue == 0)
					break;
				/* make sure nb_rx_queue can be divisible. */
				if (dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue %
					dcb_fwd_tc_cores)
					return -1;
				/* make sure nb_tx_queue can be divisible. */
				if (dcb_info.tc_queue.tc_txq[vmdq_idx][tc].nb_queue %
					dcb_fwd_tc_cores)
					return -1;
			--------/// please add here!
			}
		}
	}


>  			rxq = rxp_dcb_info.tc_queue.tc_rxq[i][tc].base + nb_rx_queue * sub_core_idx;
>  			txq = txp_dcb_info.tc_queue.tc_txq[i][tc].base + nb_tx_queue * sub_core_idx;
>  			for (j = 0; j < nb_rx_queue; j++) {

