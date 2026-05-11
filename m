Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB60CD37AC
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 10:28:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7494402D9;
	Mon, 11 May 2026 12:28:55 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 91373402D5
 for <dev@dpdk.org>; Mon, 11 May 2026 12:28:53 +0200 (CEST)
X-QQ-mid: Yeas5t1778495322t603t01172
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.204.251.157])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 5414428083236913882
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260509112823.7728-1-zaiyuwang@trustnetic.com>
 <20260509100720.15b37bfb@phoenix.local>
In-Reply-To: <20260509100720.15b37bfb@phoenix.local>
Subject: RE: [PATCH v3 00/20] Wangxun Fixes
Date: Mon, 11 May 2026 18:28:41 +0800
Message-ID: <001501dce130$f01aa4b0$d04fee10$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG2sORXAmtOI2q1Oxv/QA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N2K7JO7TcIoEGmd4jT7JBnqWyLkQOVwOcuiA/Ae6bL/EB0KTOcC+zJK+
 Kci39TdysILpmC+BT5s+Wq4HBuVvZzWk/eYt0zvykoFYh8XddGUrDDWQ0S7ziL0S8ZX5tTB
 BKL/6Y5JyilXtixGQ/50ZcNsRgQLyKSHzb8la3/kG+iM1W3zBavL63ohqfu23IbBtITlef5
 AYNNED4Ln83DZQDMR0k4vIKveT/+gFOIT4sL/nHtecmPZ17Xl6tU9oTUsxieD65uobUzRVO
 uHkvDHW0/Ia+rP3wo7rEsrWUpYGEKtDfYcOX5DI2mqqx5hrGO3gEPNnTcTVAbvAJmQFdql2
 3KktE7/FBEOW+rgX4eJh9DvlbFs4jc97yaAt4oJITqmpZ80TAZik+sM7JJJbSSz9nNHuA1U
 bSzRzqKMJrk8Q7hYby1Ty4tSwD90F+ahdzFWzyb0BW+QIx0x3lPvmiOsWEbjIwy8bb9icPO
 MYxH6ab2PYP7dkjoZcgK1L8EKg8sFEAo929R2TOFfjxhT4I6uCF53CeVMubYMTTXR9L6pDk
 1q8o+iRi2CYgjBZHzlCN4LzTyifKZW1W4RSzgEzTqj0Rjj0W/gTwbgW1YMwQLBtCPpEFxPL
 /YBoYin/xGWEU6DK0cClBLJc21xwzxmqSwLIsEfY4QR33B3zQdiU0R5psttoE6r4M7y0eUW
 p2r1LUd3NtE3AGm9hLmDikI77Hu+poQefcKsBFy6MSYZVBgSYndtv695ZdclDuE4whrlIjh
 EH2IhjC8dl0g+1S4KwMpDdqB3HTDcdIUdXu5/pyW+sXAXropusL/H8xDIgCZ+icPfL+wsEz
 AkVchVChLKJgAaV55qsHEVsRAqkOeM/0jMK5DzzWWgzC7Sr+UiRrWI/hLpH24NnmDSuZQ57
 8jai8qKlyuU+zibKqo4I7Pdm2tjDtWxNKllUiFajHyI2iamRzp5hp+PQE6M5Fjw2XJCepF/
 FGP0LZfZBkuLooZ3AyMbIM4wHZQsIpa8Nmyf2azBbNlF5cDRsTpO8/dhN5SQ2d3DnGxavUA
 6UpUzuJwYHRSYFWD7C4y7uKGIG3Ls=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Sunday, May 10, 2026 1:07 AM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang
> <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; dev@dpdk.org
> Subject: Re: [PATCH v3 00/20] Wangxun Fixes
> 
> On Sat,  9 May 2026 19:28:02 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > This series fixes several issues found on Wangxun Emerald, Sapphire
> > and Amber-lite NICs, with a focus on link-related problems.
> > ---
> > v3:
> > - Addressed Stephen's comments
> > ---
> > v2:
> > - Fixed compilation error and code style issues
> > ---
> >
> > Zaiyu Wang (20):
> >   net/txgbe: remove duplicate xstats counters
> >   net/ngbe: remove duplicate xstats counters
> >   net/ngbe: add missing CDR config for YT PHY
> >   net/ngbe: fix VF promiscuous and allmulticast
> >   net/txgbe: fix inaccuracy in TX rate limiting
> >   net/txgbe: fix link status check condition
> >   net/txgbe: fix Tx desc free logic
> >   net/txgbe: fix link flow control registers for Amber-Lite
> >   net/txgbe: fix link flow control config for Sapphire
> >   net/txgbe: fix a mass of unknown interrupts
> >   net/txgbe: fix traffic class priority configuration
> >   net/txgbe: fix link stability for 25G NIC
> >   net/txgbe: fix link stability for 40G NIC
> >   net/txgbe: fix link stability for Amber-Lite backplane mode
> >   net/txgbe: fix FEC mode configuration on 25G NIC
> >   net/txgbe: fix SFP module identification
> >   net/txgbe: fix get module info operation
> >   net/txgbe: fix get eeprom operation
> >   net/txgbe: fix to reset Tx write-back pointer
> >   net/txgbe: fix to enable Tx desc check
> >
> >  drivers/net/ngbe/base/ngbe_phy_yt.c       |    3 +
> >  drivers/net/ngbe/ngbe_ethdev.c            |    5 -
> >  drivers/net/ngbe/ngbe_ethdev_vf.c         |   11 +-
> >  drivers/net/txgbe/base/meson.build        |    2 +
> >  drivers/net/txgbe/base/txgbe.h            |    2 +
> >  drivers/net/txgbe/base/txgbe_aml.c        |  187 +-
> >  drivers/net/txgbe/base/txgbe_aml.h        |    6 +-
> >  drivers/net/txgbe/base/txgbe_aml40.c      |  113 +-
> >  drivers/net/txgbe/base/txgbe_aml40.h      |    6 +-
> >  drivers/net/txgbe/base/txgbe_dcb_hw.c     |    2 +-
> >  drivers/net/txgbe/base/txgbe_e56.c        | 3774
> +++++++++++++++++++++
> >  drivers/net/txgbe/base/txgbe_e56.h        | 1744 ++++++++++
> >  drivers/net/txgbe/base/txgbe_e56_bp.c     | 2593 ++++++++++++++
> >  drivers/net/txgbe/base/txgbe_e56_bp.h     |  278 ++
> >  drivers/net/txgbe/base/txgbe_hw.c         |   54 +-
> >  drivers/net/txgbe/base/txgbe_hw.h         |    4 +-
> >  drivers/net/txgbe/base/txgbe_osdep.h      |    4 +
> >  drivers/net/txgbe/base/txgbe_phy.c        |  360 +-
> >  drivers/net/txgbe/base/txgbe_phy.h        |   45 +-
> >  drivers/net/txgbe/base/txgbe_regs.h       |   11 +-
> >  drivers/net/txgbe/base/txgbe_type.h       |   43 +-
> >  drivers/net/txgbe/txgbe_ethdev.c          |  414 ++-
> >  drivers/net/txgbe/txgbe_ethdev.h          |    6 +-
> >  drivers/net/txgbe/txgbe_rxtx.c            |  102 +-
> >  drivers/net/txgbe/txgbe_rxtx.h            |    1 +
> >  drivers/net/txgbe/txgbe_rxtx_vec_common.h |   14 +-
> >  26 files changed, 9350 insertions(+), 434 deletions(-)  create mode
> > 100644 drivers/net/txgbe/base/txgbe_e56.c
> >  create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
> >  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
> >  create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h
> >
> 
> New files missing SPDX headers must fix.
> 
Hi Stephen,
Thanks for catching this. Apologies for the oversight.
I've now gone through the relevant devtools checks and an updated patch set
will be sent shortly.

