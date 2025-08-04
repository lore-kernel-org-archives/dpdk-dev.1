Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53C0C87FD3
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 07:07:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 182524025D;
	Mon,  4 Aug 2025 09:07:36 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 77DC3400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 09:07:31 +0200 (CEST)
X-QQ-mid: Yeas5t1754291243t637t37060
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [60.177.96.13])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 2348240248684731415
To: "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>,
	<dev@dpdk.org>
Cc: "'Jian Wang'" <jianwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-7-zaiyuwang@trustnetic.com>
In-Reply-To: <20250626080221.22488-7-zaiyuwang@trustnetic.com>
Subject: RE: [PATCH v3 06/15] net/txgbe: add RX&TX support for Amber-Lite NICs
Date: Mon, 4 Aug 2025 15:07:22 +0800
Message-ID: <073601dc050e$6ce9b990$46bd2cb0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKiC98C7jrCga9wsmi8xZSIVafTeAMcNZ41AZG9qMmyoJJEUA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MtunAI3jkh/Hk/aflyqukou6j7EYJQI5jXePM3rQnAPV/udMPi/l2EYY
 8eRlyyixRhQcUrPZUmuheVgRuuI9ZQuB/GMommCtVnTdYS1JX65dDVHs9JzQwt9vqMd0FZD
 NXlI3TLTrks9P9v8sFhQJ2Ju2MQXYfw3CdnPpjS8bVviXe31yo5Am7JgSqiQ6F+7mHuUuq5
 rWN0xST5ZuOC1igwh+kkJiKpVy20svM6NDZ1BuLHp9nbbmrm5AZIbHq3AmQGx/2PAquvXI3
 ZEYrKq4NEmIN3uUPKFxj0LF1/ywzUQc9Lje4YROB94tOZi67m65Ya5Oyc7GXfiLo0OcAEou
 YNUdASpl+9n3aaZk5NfJ9KgXJnBRcjxnpRTQhpZEtQXmhU8OHKUfG3USHbjSRMq47srdAGZ
 pxfUiohp8NE9D0pneILfliguxs4MmJ6sussV5PXFZ+Y62HrW7UJMxs4bE2BBRoC0evJlrEZ
 fhMdFh6G8CpLP5d/9VPBgclYvOJBJ3glNhyrucxFrAPbluU2XLOAiWuzQz+3nt9sS9gMk72
 sWwmCTHHGAnfSPTzTJgmghfGAu7EErwFsyL6Lp65bZbqBcFzqb1ILR+z5/MhSQbp6CcL3Y9
 JFx/pBfaPdTcJC8C2GrEf3IPL8uwDn4uH1NiZssu4KVi1RFGYLhQZ5I15NGjXLSEyC5ZHAV
 Yc8o/s+pnwBikjPdpp1IQACAFyzXrLynZxJb4eWNCZiImaFckNMabXb2uiIaNs2zdLvWtcX
 RCP6yq/dUXRqiVLpn0XJVXZ1/Oj3BMHOrXBhqlYF7j+EYLpt+EwpchNF7Enui3ysIYSttxF
 5c8YvWjoNMTyjw4x5FWtL6bl6Reqb+Hcvq5tGr3p383a6aXc0D402D159EBmxkfBGB7Vjf+
 LmBHXnByj4zNBmku+8EnF98VGwI5wOlDkMmx0BzSIciBaZIGVP+yXR4yAMEo9skcVXnLAsW
 7yZSQQ/ajVsJmyEjGtwca4dTKtUtyFAtrIj/WoFlgRkbOAl9ijofPkZTTn+KIJ17+/9Wj4J
 2dznZBFPYjuDBzJeuWFUSDl5FvXvru31Xlg5Ls+P/l4VdaR7sxPZWoseg+PX8=
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

> diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
> index 4777b0335b..7830abac7b 100644
> --- a/drivers/net/txgbe/base/txgbe_regs.h
> +++ b/drivers/net/txgbe/base/txgbe_regs.h
> @@ -318,12 +318,18 @@
>  #define   TXGBE_LEDCTL_1G		MS(2, 0x1)
>  #define   TXGBE_LEDCTL_100M		MS(3, 0x1)
>  #define   TXGBE_LEDCTL_ACTIVE		MS(4, 0x1)
> +#define TXGBE_LINKUP_FILTER             0x014428
>  #define TXGBE_TAGTPID(i)                (0x014430 + (i) * 4) /* 0-3 */
>  #define   TXGBE_TAGTPID_LSB_MASK        MS(0, 0xFFFF)
>  #define   TXGBE_TAGTPID_LSB(v)          LS(v, 0, 0xFFFF)
>  #define   TXGBE_TAGTPID_MSB_MASK        MS(16, 0xFFFF)
>  #define   TXGBE_TAGTPID_MSB(v)          LS(v, 16, 0xFFFF)
> 
> +/*AML LINK STATUS OVERWRITE*/
> +#define TXGBE_AML_EPCS_MISC_CTL         0x13240
> +#define TXGBE_AML_LINK_STATUS_OVRD_EN   0x00000020
> +#define TXGBE_AML_LINK_STATUS_OVRD_VAL  0x00000010

Improve readability and be consistent, use MS() here.

> 
> +#define TXGBE_MAC_TX_CFG_AML_SPEED_MASK     0x78000000U
> +#define TXGBE_MAC_TX_CFG_AML_SPEED_50G      0x20000000U
> +#define TXGBE_MAC_TX_CFG_AML_SPEED_40G      0x00000000U
> +#define TXGBE_MAC_TX_CFG_AML_SPEED_25G      0x10000000U
> +#define TXGBE_MAC_TX_CFG_AML_SPEED_10G      0x40000000U
> +#define TXGBE_MAC_TX_CFG_AML_SPEED_1G       0x70000000U

Ditto.

> @@ -4712,11 +4702,18 @@ txgbe_dev_rxtx_start(struct rte_eth_dev *dev)
>  	for (i = 0; i < dev->data->nb_tx_queues; i++) {
>  		txq = dev->data->tx_queues[i];
>  		/* Setup Transmit Threshold Registers */
> -		wr32m(hw, TXGBE_TXCFG(txq->reg_idx),
> -		      TXGBE_TXCFG_HTHRESH_MASK |
> -		      TXGBE_TXCFG_WTHRESH_MASK,
> -		      TXGBE_TXCFG_HTHRESH(txq->hthresh) |
> -		      TXGBE_TXCFG_WTHRESH(txq->wthresh));
> +		if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40)
> +			wr32m(hw, TXGBE_TXCFG(txq->reg_idx),
> +			      TXGBE_TXCFG_HTHRESH_MASK |
> +			      TXGBE_TXCFG_WTHRESH_MASK_AML,
> +			      TXGBE_TXCFG_HTHRESH(txq->hthresh) |
> +			      TXGBE_TXCFG_WTHRESH(txq->wthresh));
> +		else
> +			wr32m(hw, TXGBE_TXCFG(txq->reg_idx),
> +			      TXGBE_TXCFG_HTHRESH_MASK |
> +			      TXGBE_TXCFG_WTHRESH_MASK,
> +			      TXGBE_TXCFG_HTHRESH(txq->hthresh) |
> +			      TXGBE_TXCFG_WTHRESH(txq->wthresh));
>  	}


These...

#define   TXGBE_TXCFG_WTHRESH_MASK      MS(16, 0x7F)
#define   TXGBE_TXCFG_WTHRESH_MASK_AML  MS(16, 0x1FF)
#define   TXGBE_TXCFG_WTHRESH(v)        LS(v, 16, 0x7F)

How to deal with txq->wthresh is greater than 0x7F for aml?
 

