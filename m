Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C602DCF8545
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 06:25:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B22CD4026F;
	Thu, 20 Nov 2025 07:25:00 +0100 (CET)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id BA50740262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 07:24:56 +0100 (CET)
X-QQ-mid: Yeas8t1763619890t480t62887
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [122.231.28.133])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4138255220388691164
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	<zaiyuwang@trustnetic.com>
References: <A4E8D8476CBBC191+20251119085624.73210-1-jiawenwu@trustnetic.com>
 <20251119214756.6642de30@phoenix.local>
In-Reply-To: <20251119214756.6642de30@phoenix.local>
Subject: RE: [PATCH] net/txgbe: fix the missing old mailbox interface calls
Date: Thu, 20 Nov 2025 14:24:49 +0800
Message-ID: <026101dc59e6$5f908850$1eb198f0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQC9elXKL3qDM07uIHFB8npHaJETJgEpr90Pty+EB+A=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MX0ofXk2LYQC1xtFW8n6x3ot0GeksNXzpZJh83HaFcxduM9yss7RZAvh
 +tPpqHPJbz6UVY9JZVMj1A8rVl5Z2Kt7pEDW340PsBNYTX/9VUDEr+Tn9HIJKE3nj+X8RPf
 Mi0nOiPlIgWom8XqAnDn4TmROq41RHvyAcQ2iRJYVFP60kg2iEk9M4MEt1w1jC28QcETuwN
 3KNZz5Zmud3hM5ahU/MaA/m7dvsnczrD4b4i4naqeSm7WGqCaugVvVQFAbMsgxDxMTPHN09
 zMHlMGZW7j1tMNYYzGdi/U29CaZsqu6VanExH9pngaALVKL+tBr9OZMlKBV7Ariwg/y3pQc
 8qOL820fsKAiyLRiLT/jrVXzdcyso4Q6yqLCAxeXsUmM2JXjA+ef3n382G/S+uZhgwB8/yX
 YGCtKpBs3w9grr/MD4Wn0ryfF+6hz0UsRawiQSdKJQkXQtBsXJotKYw9HJVYeWun/HRfgce
 NA/Z3NicSs0rG1dr1ikW/LyCUXCVl//+46NFLFlBl61F/PvDDCGE3grF7mZBPCwH3NMPlGp
 /t9fjw8CdxuLTTA1Wb7UUlpl3h3j8AN+IhXzybJy39tQLX2iG7GXEqFmRw4I6+kPXGLjiM8
 jCXVwBtEkRfuZ++PoxmwLSxRhILHiAfDvFSkEqN16KglNlqeXy2F65X3m28GhFTpmTKXzt+
 xmxFVDU/KwzHEVBojZaV60wDic0IBOL1yavt3x2SjKJb1PDIW+W6Lb7ZMztGhN8DZmRtN4Z
 vLs5TbgM6AkTLn38nnLXy76B+tY7N4EzycapBw/osHWUa7Dr1+bfJmhDxj9IQ8rOZCXsF1b
 gNdlum2kbaMRos42VdaClyDMmummMaEZzrl/IalIwjE45uwFZRwNOpzKHWWhWusCj25rsEQ
 vwsBzr9KwtNt96/pSRCqskhZz5cBrBW/eFnTXbsRZ3a9EavnFgq2KuXjK+2hvugFaeIN2Gf
 Z+xqWoXiJmqe5upklqHPsF48PLvQa5Tmdor8lu2el9IFvaBYo7HeTKbU4EMeWwBXPS4jz85
 En1pp1rKL5sMO5l0vn8K9wqlv762O2LiHu9XBhIw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

On Thu, Nov 20, 2025 1:48 PM, Stephen Hemminger wrote:
> On Wed, 19 Nov 2025 16:56:24 +0800
> Jiawen Wu <jiawenwu@trustnetic.com> wrote:
> 
> > @@ -28,6 +29,9 @@ void txgbe_init_ops_aml40(struct txgbe_hw *hw)
> >  	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml40;
> >  	mac->get_link_capabilities = txgbe_get_link_capabilities_aml40;
> >  	mac->check_link = txgbe_check_mac_link_aml40;
> > +
> > +	/* MAILBOX */
> > +	mbx->host_interface_command = txgbe_host_interface_command_aml;
> >  }
> 
> Maybe that comment means something to you, but it seems like something
> the next maintainer would not know what it means. Could you explain it more?

For different devices, the mailbox flow between software and firmware is
different. There are several mailbox command in the txgbe driver, but only
txgbe_hic_sr_read() was changed to use the new flow in commit
6a139ade82e7 ("net/txgbe: add new SW-FW mailbox interface"). Because
this function invoke the txgbe_hic_unlocked() directly without SW-FW
semaphore, I guess.

It lead to other mailbox commands timeout for Amber-Lite devices, which
is required to use the new flow. So this patch fills in the missing part.

For the sake of code tidy, txgbe_hic_sr_read() should change to use the
locked function txgbe_host_interface_command(), and this function could
be change to pointer in struct txgbe_mbx_info for different devices.


