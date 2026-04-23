Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174BEF99344
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 07:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD53D40272;
	Thu, 23 Apr 2026 09:54:07 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 76C9640270;
 Thu, 23 Apr 2026 09:54:04 +0200 (CEST)
X-QQ-mid: Yeas3t1776930842t068t45114
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [115.220.225.180])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 3416191575930411949
To: "'Zaiyu Wang'" <zaiyuwang@trustnetic.com>,
	<dev@dpdk.org>
Cc: <stable@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260423034024.14404-9-zaiyuwang@trustnetic.com>
In-Reply-To: <20260423034024.14404-9-zaiyuwang@trustnetic.com>
Subject: RE: [PATCH 08/18] net/txgbe: fix link flow control registers for
 Amber-Lite
Date: Thu, 23 Apr 2026 15:54:00 +0800
Message-ID: <025901dcd2f6$58e1e7e0$0aa5b7a0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwIWF43StS8GcVA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NV9lVvsB36OpHeBCehCBIyTF7p/dMikxuexb5gopXqjGGebq98GeAbFX
 42L2Vuw0nkkLLWVNN9MIsPVC1cSVEPv0B2oPRs8BDMhi0lCGSE2PzeFeRpLDc5uRekJkuKZ
 SsCY8Xq5IFg4f5M8X7RsCmc9jhZfWQKPHFceb7TQdwjQEHpgl4f/BkucAZUtLgbuMcg+FnH
 kGo/BMewYDS++NiiY8+ikgXoS1HlKzXVXW0QBBHkZEG8aP9A7E6K08QzlSp6Y/0EQT93TeY
 RoJjqNia0y0//p5DrP7reb5A5U6BF3W70oeRD2tIeLOrrTKs4Xx9SgLF3vE4JRO6RNL3OIv
 PfvFpmUXTU+aMMMwbmZ1WNDJracxDdxHuT6nlYCwxfsG+mCB8h6zPEChXxvzdglURyeyeXL
 8Sk1QNMwjANCj96qw0UBJbqxGg1MpfHJ2TtyrGQE469w3etOjUAW6Ul70XtVfjfXmEw4i21
 dBIsd74dGQz7u/ZiVT3IlMHTTk9+k7SevN9rw6ocYQxcXjo1hhuvZtqDz9wje4CVwALgqMZ
 0e1egaJitLv1NSXkx1KTvQLseXtnNcaQUhmtAJmf8CcGNn/0ABX7jtUid2tWclqYqGWhljV
 /Uh5zLdmEr8wHuEjKTUbxidOcakSGvg7m4d28U2y5rxQKzDCZIP/BJuJ1aMCAnC49Gq4qtb
 ycYbBxzbsnJ4rfvGvoKtwPH1V1UcmEIlXtbofSVNyqGE/5A4c7IDJuftlJb56LBMlBcXWWv
 o0AQrbQDwHt9TquP/XCdjJCDMZxc47edGGZeW7wT55KECTYQ9L9IONftaB6natxbiLnircq
 OE4i6ceeYjLqmDa3ZMXS8WIohNKfEi13OLgTY9D34adrkOJsFzIhB5P7VEyGQs1FD6TkZfD
 ASSHgt0MXwUEZ0c/I/ew6c2VyE1ioWykdfdXWhq7MIFLZH2/JtvXuFjdOGmtOT/KdmeyU1L
 pIB0LkUWesjlk8FP1Q0BXQzRtiUoHVwMGG6ygAytugqjpyMNIJIp469/JF8IENPfXvPRrv+
 54KoLNclNx6wn99kCeDM/ZSD3F5qXmv1eaMN10A7gvClCgp9Cw8fNskolsdfuvCNyWVG2NC
 nT+DbrGAKvKvY3LAN7fG9o=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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



> -----Original Message-----
> From: Zaiyu Wang <zaiyuwang@trustnetic.com>
> Sent: Thursday, April 23, 2026 11:40 AM
> To: dev@dpdk.org
> Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>; stable@dpdk.org; Jiawen Wu <jiawenwu@trustnetic.com>
> Subject: [PATCH 08/18] net/txgbe: fix link flow control registers for Amber-Lite
> 
> The flow control counter registers on AML NICs differ from those on SP
> NICs. Update the register offsets accordingly to ensure the counters
> work correctly.
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---
>  drivers/net/txgbe/base/txgbe_hw.c   |  5 +++++
>  drivers/net/txgbe/base/txgbe_regs.h |  2 ++
>  drivers/net/txgbe/txgbe_ethdev.c    | 10 ++++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
> index 0f3db3a1ad..52fead6171 100644
> --- a/drivers/net/txgbe/base/txgbe_hw.c
> +++ b/drivers/net/txgbe/base/txgbe_hw.c
> @@ -394,6 +394,11 @@ s32 txgbe_clear_hw_cntrs(struct txgbe_hw *hw)
>  	rd32(hw, TXGBE_PBTXLNKXON);
>  	rd32(hw, TXGBE_PBTXLNKXOFF);
> 
> +	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
> +		wr32(hw, TXGBE_PBRXLNKXON_AML, 0);
> +		wr32(hw, TXGBE_PBRXLNKXOFF_AML, 0);
> +	}
> +
>  	/* DMA Stats */
>  	rd32(hw, TXGBE_DMARXPKT);
>  	rd32(hw, TXGBE_DMATXPKT);
> diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
> index 060757323a..de382601c9 100644
> --- a/drivers/net/txgbe/base/txgbe_regs.h
> +++ b/drivers/net/txgbe/base/txgbe_regs.h
> @@ -1085,6 +1085,8 @@ enum txgbe_5tuple_protocol {
>  #define TXGBE_PBRXDROP                    0x019068
>  #define TXGBE_PBRXLNKXOFF                 0x011988
>  #define TXGBE_PBRXLNKXON                  0x011E0C
> +#define TXGBE_PBRXLNKXOFF_AML             0x011F80
> +#define TXGBE_PBRXLNKXON_AML              0x011F84
>  #define TXGBE_PBRXUPXON(up)               (0x011E30 + (up) * 4)
>  #define TXGBE_PBRXUPXOFF(up)              (0x011E10 + (up) * 4)
> 
> diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
> index 414107d7a7..e3492c9cd7 100644
> --- a/drivers/net/txgbe/txgbe_ethdev.c
> +++ b/drivers/net/txgbe/txgbe_ethdev.c
> @@ -2331,8 +2331,14 @@ txgbe_read_stats_registers(struct txgbe_hw *hw,
>  		hw_stats->up[i].rx_up_dropped +=
>  				rd32(hw, TXGBE_PBRXMISS(i));
>  	}
> -	hw_stats->rx_xon_packets += rd32(hw, TXGBE_PBRXLNKXON);
> -	hw_stats->rx_xoff_packets += rd32(hw, TXGBE_PBRXLNKXOFF);
> +
> +	if (hw->mac.type == txgbe_mac_aml || hw->mac.type == txgbe_mac_aml40) {
> +		hw_stats->rx_xon_packets = rd32(hw, TXGBE_PBRXLNKXON_AML);
> +		hw_stats->rx_xoff_packets = rd32(hw, TXGBE_PBRXLNKXOFF_AML);

What happens to these counters after .stats_reset()?

> +	} else {
> +		hw_stats->rx_xon_packets += rd32(hw, TXGBE_PBRXLNKXON);
> +		hw_stats->rx_xoff_packets += rd32(hw, TXGBE_PBRXLNKXOFF);
> +	}
>  	hw_stats->tx_xon_packets += rd32(hw, TXGBE_PBTXLNKXON);
>  	hw_stats->tx_xoff_packets += rd32(hw, TXGBE_PBTXLNKXOFF);
> 
> --
> 2.21.0.windows.1
> 

