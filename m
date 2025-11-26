Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CFFD1037E
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 06:28:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A882A4064F;
	Wed, 26 Nov 2025 07:28:13 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id D08394026F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 07:28:10 +0100 (CET)
X-QQ-mid: Yeas2t1764138480t488t43272
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [36.20.107.59])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17670433720732771141
To: "'Stephen Hemminger'" <stephen@networkplumber.org>,
 "'Thomas Monjalon'" <thomas@monjalon.net>
Cc: <dev@dpdk.org>,
	<zaiyuwang@trustnetic.com>
References: <A4E8D8476CBBC191+20251119085624.73210-1-jiawenwu@trustnetic.com>
 <20251119214756.6642de30@phoenix.local>
 <026101dc59e6$5f908850$1eb198f0$@trustnetic.com>
 <001701dc5ce6$7757aba0$660702e0$@trustnetic.com>
In-Reply-To: <001701dc5ce6$7757aba0$660702e0$@trustnetic.com>
Subject: RE: [PATCH] net/txgbe: fix the missing old mailbox interface calls
Date: Wed, 26 Nov 2025 14:27:59 +0800
Message-ID: <011a01dc5e9d$cf400cf0$6dc026d0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQC9elXKL3qDM07uIHFB8npHaJETJgEpr90PAbZufrkCEQ49hrcau9Dg
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OFFjJVuQBI5NyaDJwPFJw0igMH8OWKGoF8m+ki/COP/eHq9SNyqVSaQo
 Ziq1YE0pH7SSkMgxujS2SAq2odh2wWMxsSCQVDH0fOTktUpjRQRMaVQEjNEFRJyUSyCKv07
 //Ezep0wXN2JxY4Wpg4xwTpNbtznjfjsTDO23x822xTBV31DfpYjbYNR1UHqiiRLngQwPDA
 26e22AXQzodTYqT/L0i0KlD3B/e/XPogCuXvpfTG5428FWiJ/gyqZdzERS2YTqFdAXAK45R
 07RiAFr5kwjeVUfmoaCrqQCPzFNlonWGKi4fCfliNEd3GCCc6cLuSb3nEu8kGr1nTSnFCDW
 2cBuCeqhjBGJTU6SEBCfmA2L2b8zAmn9ksnCd++txhYjbVAwPr8OUXYRLI5r8qPnBXa9a6s
 4PuCfiOzJQxknyPKhPssngn1KHa/rwVDiH88R5xAKXLxwb7FZKMmrCpSv2YxEVM0qRPDVrb
 2P+XIDiodwVtanrwotTFMavsOA3ejd9RK4BMiSP4wSQygiyJPeQj/1CSK/Cnh1P/q6B3QuX
 CceHEi10Mq7jl30/sdWSJy+l1/Azo81tPULkUO1kSxgoeoElSBRq4PXwUQkssJGtXA+3ljr
 3Fr5EYA81hB+/bE9rMIkAmLtKC9NT1hk7m+TDYDvdPgoC74sr/IN7HntnizEFwB2fxtVujt
 XBNfaqxoxexukAflIhzWqgP2LJ5kggMwJqwqub2hl7GR5Yz7xLp/lXbQssX54PUYH7wjMuu
 PpoBb0dxbUT6jzZEn/v1ZTgTh2l95qTC2XGOy360G6BIDqX/HtLw2GGlVF/m7si3lt1HN/v
 lSvQjbGuWEvs1gcibLWHdbPgkfsjCZS065fSCPLNaCytdjWKtkOMwKGGroxbc9u3otpjXq0
 ZyXbmhSgaauTavxP+ml28D/uixGs6pwjLV04mz9k1Df0iRPL0Xz+BXGC/uo1QY2ScAEt+t4
 gDZudwZx/FLpfP1gWlq64HNa6qAqJVfB+daeBN4kk82jJpngHlsKW1MMxStNynWxM4QqrxV
 A8itFz+BlJMxlyzkUq
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

Hi, this fix patch is crucial for the new merged feature in this release.

> -----Original Message-----
> From: Jiawen Wu <jiawenwu@trustnetic.com>
> Sent: Monday, November 24, 2025 10:03 AM
> To: 'Stephen Hemminger' <stephen@networkplumber.org>
> Cc: dev@dpdk.org; zaiyuwang@trustnetic.com
> Subject: RE: [PATCH] net/txgbe: fix the missing old mailbox interface calls
> 
> On Thu, Nov 20, 2025 2:25 PM, Jiawen Wu wrote:
> > On Thu, Nov 20, 2025 1:48 PM, Stephen Hemminger wrote:
> > > On Wed, 19 Nov 2025 16:56:24 +0800
> > > Jiawen Wu <jiawenwu@trustnetic.com> wrote:
> > >
> > > > @@ -28,6 +29,9 @@ void txgbe_init_ops_aml40(struct txgbe_hw *hw)
> > > >  	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml40;
> > > >  	mac->get_link_capabilities = txgbe_get_link_capabilities_aml40;
> > > >  	mac->check_link = txgbe_check_mac_link_aml40;
> > > > +
> > > > +	/* MAILBOX */
> > > > +	mbx->host_interface_command = txgbe_host_interface_command_aml;
> > > >  }
> > >
> > > Maybe that comment means something to you, but it seems like something
> > > the next maintainer would not know what it means. Could you explain it more?
> >
> > For different devices, the mailbox flow between software and firmware is
> > different. There are several mailbox command in the txgbe driver, but only
> > txgbe_hic_sr_read() was changed to use the new flow in commit
> > 6a139ade82e7 ("net/txgbe: add new SW-FW mailbox interface"). Because
> > this function invoke the txgbe_hic_unlocked() directly without SW-FW
> > semaphore, I guess.
> >
> > It lead to other mailbox commands timeout for Amber-Lite devices, which
> > is required to use the new flow. So this patch fills in the missing part.
> >
> > For the sake of code tidy, txgbe_hic_sr_read() should change to use the
> > locked function txgbe_host_interface_command(), and this function could
> > be change to pointer in struct txgbe_mbx_info for different devices.
> 
> Hi Stephen Hemminger,
> 
> Does this explanation is sufficient? Should I send v2 patch with these logs?
 

