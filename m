Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A462C71135
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 01:42:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 677BC4021F;
	Thu, 12 Jun 2025 03:42:49 +0200 (CEST)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id 8FB6740156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 03:42:45 +0200 (CEST)
X-QQ-mid: Yeas1t1749692557t655t38530
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [36.20.60.58])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 6547120649275524767
To: "'Thomas Monjalon'" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, <zaiyuwang@trustnetic.com>,
 "'Stephen Hemminger'" <stephen@networkplumber.org>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
 <2430F12A7223B66B+20250606080117.183198-3-jiawenwu@trustnetic.com>
 <11711540.2WqB4rESCP@thomas>
In-Reply-To: <11711540.2WqB4rESCP@thomas>
Subject: RE: [PATCH 02/12] net/txgbe: refactor FDIR filter to improve
 functionality
Date: Thu, 12 Jun 2025 09:42:34 +0800
Message-ID: <055701dbdb3b$44eedda0$cecc98e0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKcOkot4Hv3i7HE8LJegtCggB47KgHqGKjDAl4ms0qyW77QQA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NrhUYXQRCKQm11q5uGBa1YI+V7OYAvII92asSF9RG3A9UhY0Kitl2man
 Dmo6pQLloIOKaC5ocOWmh1VCzvm0uyNbPP4tdXHqLM55aH2pigH9mq/juEX6DxCeGZOZ064
 PrdSYC2JwxASG40Fe3tzhqwk56l5bNlC7vnZAyCXSKQk4eaK0CC89mn0a7nZ1fdcmayM5Hm
 SZYdk/NxFfOAAbrG64rJgTMNy47H6aXbmjJwP9Px632dNd6Jg3J1pFitjuye9MIy7BvP2x3
 02M+y0JfXIrq7BRGc93d1yZ/HRENjcq/EuLvihTlgxFB7TUjl8so5J1XNIKTFdPtxJIBOfs
 mwEf/SpTphv066hPzMWr3U0xswinVCfGKP5uDwTf3IFAPNQ0YBmK01HRh3V/ktadDDb/RNs
 ucuhYn6MOU5h20SVZG3ym/4z3LwfuWrsitFDosuvOAFvq0U908d8w1dymhwt3/F9vyDhsn5
 4RJKo2MOPdTV5Vh2CTm+qLTkEiLniun13K7Cx9A7i767rbJQkWUtyIin2jSLpAdzdIrBYqp
 EZS7TJKIkXsypxFzrA99emtYjUKvXeBPE6Rx5jPLaak+7yZ0vlWMgl9ESZxRoIActE+VLZX
 4b3eEGJY8xKKUWE9MwLQnsZxmy0rn9hMzFhEd66vw19EPiIo2qm2wKJW1WMttbsA9chJNcz
 FI0H2Thah6WWuBQSlZn819cEEaxZhHBidc0i5qnMqgSxjUEo87WNW9uQwC5puS5XmS+6BGV
 2ITLZvvi4lf4c8j8oCrpJ9dEcAtGpUAEhzo3eueJaPS0Llim0NOL+/VWk7tM+neaGmFkVMX
 o10/5F08M9lf9iXoFAp/4UDgfVey3ej7p5ddXpw8EXK/9dxvJKqbJKX1IglLVD8qr1cPCmL
 eHsjQeQFUl5Uhaf/AcVKwwFKVxHnr+XyaR1l9SLBz4YBTl49aCIbZ09OhkspGa6KDf4H9Kt
 V3ae2cw12xjJz7v6ANLLJeua4nfvOXtviid3SxQ+/BrJyuc3jux9qp5bwgCBiiww7vs6pJt
 5qPply2q03hEAlvElAyaPkSWL3anj9NcuCvwNfam4foMcVcVor
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

> -----Original Message-----
> From: Thomas Monjalon <thomas@monjalon.net>
> Sent: Thursday, June 12, 2025 8:30 AM
> To: Jiawen Wu <jiawenwu@trustnetic.com>
> Cc: dev@dpdk.org; zaiyuwang@trustnetic.com; Stephen Hemminger <stephen@networkplumber.org>
> Subject: Re: [PATCH 02/12] net/txgbe: refactor FDIR filter to improve functionality
> 
> 06/06/2025 10:01, Jiawen Wu:
> > There were some defects in the original configuration for flow director
> > filter. Now make the following improvements:
> >
> > 1) Fix incorrect parsing to ntuple filter when set the pattern likes:
> >    flow create ... ipv4 / udp dst is ... / raw ... / end actions ... / end
> > 2) Fix flex offset base to set item RAW relative = 1, and convert RAW
> >    pattern string to hex bytes to match the hardware identification.
> > 3) Fix to create FDIR rules for VXLAN/GRE/NVGRE/GENEVE packets, they will
> >    match the rules in the inner layers.
> > 4) Support IPv6 perfect mode.
> > 5) Add packet type mask to match more types of packets if the pattern is
> >    default.
> 
> That's a lot of various changes for a single patch.
> Please could you split it?

I'll try to do it.
Should I send v3 patches for the whole series? Or just these split patches.

