Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC11091914
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 09:38:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DFF5402E6;
	Fri, 20 Mar 2026 10:38:15 +0100 (CET)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 963B340272;
 Fri, 20 Mar 2026 10:38:13 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XbZaoJA/S74uaB3eH64nMt3fOyq9NLOQyMjwgpe+rgc=;
 b=wvo8DIVrL/c95/9v3GqtPEKNhc8Cq5QonaqB+Dv7HiLGCsN7Dmjz6DSwTmoRPgIK7EhiglKMz
 r/EoA4em9hCOHtzxXsMMLGihWzUDpjx3ylsXFyhlfjncJBnRHgYNynO7XsLVSHO4dUcNat2jb1n
 5pTDFN/QrB6HUYaRHCbxrE8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fccmS5PMWznTVg;
 Fri, 20 Mar 2026 17:32:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 4BB5A40565;
 Fri, 20 Mar 2026 17:38:11 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Mar 2026 17:38:10 +0800
Message-ID: <b463bf74-3a03-408c-9e14-a452c1f4fcc0@huawei.com>
Date: Fri, 20 Mar 2026 17:38:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] app/testpmd: fix DCB forwarding TC mismatch handling
To: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>, <dev@dpdk.org>, 
 <bruce.richardson@intel.com>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
CC: <shaiq.wani@intel.com>, <stable@dpdk.org>
References: <20260311083751.1107404-1-chaitanyababux.talluri@intel.com>
 <20260320062954.2042887-1-chaitanyababux.talluri@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260320062954.2042887-1-chaitanyababux.talluri@intel.com>
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

On 3/20/2026 2:29 PM, Talluri Chaitanyababu wrote:
> Fix DCB forwarding failed when the number of TCs on ports is inconsistent.
> 
> When ports have asymmetric TC configurations (e.g. 2 ports, port0 has
> 4 TCs and port1 has 8 TCs), the forwarding logic iterates based only
> on the Rx port TC count.
> This can lead to accessing invalid Tx TC entries and incorrect queue
> mapping, which will result in a SIGFPE exception.
> 
> Additionally, the existing VMDq pool guard in dcb_fwd_config_setup()
> only checks RX queue counts and does not consider the case where the TX
> port has no queues for a given pool/TC combination.
> 
> Fix this by:
> 1. Introducing an effective TC count using RTE_MIN() of Rx and Tx TC
>    values, ensuring forwarding only operates on valid TCs supported by
>    both ports.
> 2. Updating the loop condition to use the effective TC count instead of
>    only the Rx TC count.
> 3. Extending the queue validation in dcb_fwd_config_setup() to ensure
>    both Rx and Tx queues are valid for a given TC.
> 
> Testpmd command to reproduce:
> 
> x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-20 -n 4 \
> -a 0000:31:00.0 -a 0000:4b:00.0 \
> --file-prefix=testpmd1 -- -i --rxq=256 --txq=256 \
> --nb-cores=16 --total-num-mbufs=600000
> 
> port stop all
> port config 0 dcb vt off 8 pfc on
> port config 1 dcb vt off 8 pfc on
> port start all
> port stop all
> port config 0 dcb vt off 4 pfc on
> 
> This ensures correct queue mapping and avoids issues when switching
> between different DCB configurations across ports.
> 
> Fixes: 1a572499beb6 ("app/testpmd: setup DCB forwarding based on traffic class")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
> Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
> ---
> 
> v5:
> * Updated commit message as per review comments.
> * Added reproduction steps and SIGFPE explanation.
> * Updated Fixes tag.
> 
> v4:
> * Removed runtime update of dcb_fwd_tc_mask as per review comments.
> * Used effective TC count (RTE_MIN of RX/TX) to handle asymmetric configs.
> * Moved queue validation to dcb_fwd_check_cores_per_tc().
> 
> v3: Removed old email address.
> 
> v2:
> * Used res->num_tcs to derive dcb_fwd_tc_mask.
> * Removed redundant rte_eth_dev_get_dcb_info().
> ---
>  app/test-pmd/config.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
> index f9f3c542a6..052e8b7c24 100644
> --- a/app/test-pmd/config.c
> +++ b/app/test-pmd/config.c
> @@ -5377,6 +5377,7 @@ dcb_fwd_config_setup(void)
>  	uint16_t nb_rx_queue, nb_tx_queue;
>  	uint16_t i, j, k, sm_id = 0;
>  	uint16_t sub_core_idx = 0;
> +	uint8_t effective_nb_tcs;
>  	uint16_t total_tc_num;
>  	struct rte_port *port;
>  	uint8_t tc = 0;
> @@ -5442,6 +5443,7 @@ dcb_fwd_config_setup(void)
>  	dcb_fwd_tc_update_dcb_info(&rxp_dcb_info);
>  	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
>  	dcb_fwd_tc_update_dcb_info(&txp_dcb_info);
> +	effective_nb_tcs = RTE_MIN(rxp_dcb_info.nb_tcs, txp_dcb_info.nb_tcs);
>  
>  	for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++) {
>  		fwd_lcores[lc_id]->stream_nb = 0;
> @@ -5450,7 +5452,8 @@ dcb_fwd_config_setup(void)
>  			/* if the nb_queue is zero, means this tc is
>  			 * not enabled on the POOL
>  			 */
> -			if (rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue == 0)
> +			if (rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue == 0 ||
> +			    txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue == 0)
>  				break;
>  			k = fwd_lcores[lc_id]->stream_nb +
>  				fwd_lcores[lc_id]->stream_idx;
> @@ -5480,7 +5483,7 @@ dcb_fwd_config_setup(void)
>  
>  		sub_core_idx = 0;
>  		tc++;
> -		if (tc < rxp_dcb_info.nb_tcs)
> +		if (tc < effective_nb_tcs)
>  			continue;
>  		/* Restart from TC 0 on next RX port */
>  		tc = 0;
> @@ -5497,6 +5500,8 @@ dcb_fwd_config_setup(void)
>  		dcb_fwd_tc_update_dcb_info(&rxp_dcb_info);
>  		rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
>  		dcb_fwd_tc_update_dcb_info(&txp_dcb_info);
> +
> +		effective_nb_tcs = RTE_MIN(rxp_dcb_info.nb_tcs, txp_dcb_info.nb_tcs);
>  	}
>  }
>  

