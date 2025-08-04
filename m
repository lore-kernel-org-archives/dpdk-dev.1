Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEA0C87FDA
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 07:16:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C41F04025D;
	Mon,  4 Aug 2025 09:15:59 +0200 (CEST)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
 by mails.dpdk.org (Postfix) with ESMTP id 211284025D
 for <dev@dpdk.org>; Mon,  4 Aug 2025 09:15:56 +0200 (CEST)
X-QQ-mid: Yeas9t1754291752t956t52093
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [60.177.96.13])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 575958433637024161
To: "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>,
	<dev@dpdk.org>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-1-zaiyuwang@trustnetic.com>
 <20250625125047.18072-10-zaiyuwang@trustnetic.com>
In-Reply-To: <20250625125047.18072-10-zaiyuwang@trustnetic.com>
Subject: RE: [PATCH v2 09/15] net/txgbe: add TX head Write-Back mode for
 Amber-Lite NICs
Date: Mon, 4 Aug 2025 15:15:52 +0800
Message-ID: <073701dc050f$9c77d6a0$d56783e0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKiC98C7jrCga9wsmi8xZSIVafTeAFw0qYVAsroYYKypChrkA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NWLpwLZrMWrI7X7gmnUraP3tTSrIa1HRBa9ie3EAdI9HguYVof0vb12v
 vIghO008ynIdhQMSUb2Qx7cruxtJ1HYkes7ydBJLlg8srOBFfNlrNlPxoVcPGNvatEHt5og
 64UHFH5rf4DpjJv/X9HNaZU3IN5oAk7P/xrN4repT6lDUpf81wULkcuB4JnYdMt9bLe4QDR
 hPeVmfzPuiPHvYE4lmInNIW0xcFhz4JvCsd/xSMSBzv5o+1to+emENpkFjuxWV/bxxe5xj5
 K6DQ8B7AuXJP38yzVuLqvg7QT9tJkl5VPdIHpdfJyOw6r3gobRumTLkmfp6w+3EQzsmmjKv
 +r6WZUJevUMk7jCWkT4KU+HeYrAfyPPDe83HIFW4QB0Vk/99JOtpKTuqDkn7khQoEiYkjQK
 /b4BpiATGS6c13H6nBn1+fULfOvgsFSzxXiQnx5UplOl6DA7NNWhHdUsod2nfI59so93Mgp
 /0kIdPgZe58LjpT/xZwaFvOH6fDw7mfL5hr1k8VTECyEm1s9qSooQn2QeMNW6LslVwPZATJ
 cJthOblKIK2pDWhRGalB+8mdvNxvMdYZgR70MI2XUhJg6zTUZQAx8z4F5vIaGEy/uoghvC7
 vDWauyUPlvAWT0lvZP96kT6C0VDUwGsb3GfHXypn2d2RKd3YzgxbL+Hq3Q01y0ijU3x36YH
 aEYs09GqE8jhHZur/w3xP/IJQoc6UAtfWEetg/AianI9B5jvvbvf11J6zkAqog8tYVWsbRB
 kFC73btO74v76FGAhu/LbeWAjeFAPS2gfxM69iHSxxpJ1GRMrANRGFIeI31Q0s58g9/On++
 i9G7AOgjGvo+98q8nJV6y/73ZTQAuPJgx5MJjI/BLrg3Ko0FZJghwhhvSX++kxjoaVJa6h+
 V+oj+FgiFaWXaOMPdIhGJWCXSsw66eUdPiGk+/VpgY4KNsBAEyBcnNAMwxxDwhUPxLweYoo
 NxJZi3wLvm2h0Ae6Zg5n0+OVOGk287OoclZliC9i1dUR1FS0OSDXi+mBbzoLBoRc99UNWVW
 38IINPu9fLakpw/MnX
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
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

> diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
> index 8005283a26..5692883f60 100644
> --- a/drivers/net/txgbe/base/txgbe_type.h
> +++ b/drivers/net/txgbe/base/txgbe_type.h
> @@ -723,6 +723,8 @@ struct txgbe_phy_info {
>  #define TXGBE_DEVARG_FFE_MAIN		"ffe_main"
>  #define TXGBE_DEVARG_FFE_PRE		"ffe_pre"
>  #define TXGBE_DEVARG_FFE_POST		"ffe_post"
> +#define TXGBE_DEVARG_TX_HEAD_WB		"tx_headwb"
> +#define TXGBE_DEVARG_TX_HEAD_WB_SIZE	"tx_headwb_size"
> 
>  static const char * const txgbe_valid_arguments[] = {
>  	TXGBE_DEVARG_BP_AUTO,
> @@ -733,6 +735,8 @@ static const char * const txgbe_valid_arguments[] = {
>  	TXGBE_DEVARG_FFE_MAIN,
>  	TXGBE_DEVARG_FFE_PRE,
>  	TXGBE_DEVARG_FFE_POST,
> +	TXGBE_DEVARG_TX_HEAD_WB,
> +	TXGBE_DEVARG_TX_HEAD_WB_SIZE,
>  	NULL
>  };
> 
> @@ -783,6 +787,8 @@ struct txgbe_devargs {
>  	u16 poll;
>  	u16 present;
>  	u16 sgmii;
> +	u16 tx_headwb;
> +	u16 tx_headwb_size;
>  };
> 
>  struct txgbe_hw {
> diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
> index a854b40b9f..ed84594105 100644
> --- a/drivers/net/txgbe/txgbe_ethdev.c
> +++ b/drivers/net/txgbe/txgbe_ethdev.c
> @@ -513,6 +513,9 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
>  	u16 ffe_main = 27;
>  	u16 ffe_pre = 8;
>  	u16 ffe_post = 44;
> +	/* New devargs for amberlite config */
> +	u16 tx_headwb = 1;
> +	u16 tx_headwb_size = 16;
> 
>  	if (devargs == NULL)
>  		goto null;
> @@ -537,6 +540,10 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
>  			   &txgbe_handle_devarg, &ffe_pre);
>  	rte_kvargs_process(kvlist, TXGBE_DEVARG_FFE_POST,
>  			   &txgbe_handle_devarg, &ffe_post);
> +	rte_kvargs_process(kvlist, TXGBE_DEVARG_TX_HEAD_WB,
> +			   &txgbe_handle_devarg, &tx_headwb);
> +	rte_kvargs_process(kvlist, TXGBE_DEVARG_TX_HEAD_WB_SIZE,
> +			   &txgbe_handle_devarg, &tx_headwb_size);
>  	rte_kvargs_free(kvlist);
> 
>  null:
> @@ -544,6 +551,8 @@ txgbe_parse_devargs(struct txgbe_hw *hw, struct rte_devargs *devargs)
>  	hw->devarg.poll = poll;
>  	hw->devarg.present = present;
>  	hw->devarg.sgmii = sgmii;
> +	hw->devarg.tx_headwb = tx_headwb;
> +	hw->devarg.tx_headwb_size = tx_headwb_size;
>  	hw->phy.ffe_set = ffe_set;
>  	hw->phy.ffe_main = ffe_main;
>  	hw->phy.ffe_pre = ffe_pre;

Add the strings into RTE_PMD_REGISTER_PARAM_STRING().

> diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
> index 558ffbf73f..9846ce3c56 100644
> --- a/drivers/net/txgbe/txgbe_rxtx.c
> +++ b/drivers/net/txgbe/txgbe_rxtx.c
> @@ -92,14 +92,29 @@ txgbe_tx_free_bufs(struct txgbe_tx_queue *txq)
>  	int i, nb_free = 0;
>  	struct rte_mbuf *m, *free[RTE_TXGBE_TX_MAX_FREE_BUF_SZ];
> 
> -	/* check DD bit on threshold descriptor */
> -	status = txq->tx_ring[txq->tx_next_dd].dw3;
> -	if (!(status & rte_cpu_to_le_32(TXGBE_TXD_DD))) {
> -		if (txq->nb_tx_free >> 1 < txq->tx_free_thresh)
> -			txgbe_set32_masked(txq->tdc_reg_addr,
> -				TXGBE_TXCFG_FLUSH, TXGBE_TXCFG_FLUSH);
> -		return 0;
> -	}
> +	if (txq->headwb_mem) {
> +		uint16_t tx_last_dd = txq->nb_tx_desc +
> +				      txq->tx_next_dd - txq->tx_free_thresh;
> +		if (tx_last_dd >= txq->nb_tx_desc)
> +			tx_last_dd -= txq->nb_tx_desc;
> +
> +		volatile uint16_t head = (uint16_t)*(txq->headwb_mem);
> +
> +		if (txq->tx_next_dd > head && head > tx_last_dd)
> +			return 0;
> +		else if (tx_last_dd > txq->tx_next_dd &&
> +				(head > tx_last_dd || head < txq->tx_next_dd))
> +			return 0;
> +	} else {
> +		/* check DD bit on threshold descriptor */
> +		status = txq->tx_ring[txq->tx_next_dd].dw3;
> +		if (!(status & rte_cpu_to_le_32(TXGBE_TXD_DD))) {
> +			if (txq->nb_tx_free >> 1 < txq->tx_free_thresh)
> +				txgbe_set32_masked(txq->tdc_reg_addr,
> +					TXGBE_TXCFG_FLUSH, TXGBE_TXCFG_FLUSH);
> +			return 0;
> +		}
> +}

TAB
 

