Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF16CCD18E
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 09:34:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6F91402AE;
	Tue, 14 Oct 2025 11:34:57 +0200 (CEST)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 by mails.dpdk.org (Postfix) with ESMTP id 7FDEA402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 11:34:54 +0200 (CEST)
X-QQ-mid: Yeas6t1760434489t525t47152
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [36.27.111.193])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 939140110284822884
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>, "'Jiawen Wu'" <jiawenwu@trustnetic.com>,
 "'Jian Wang'" <jianwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>	<20250626080221.22488-1-zaiyuwang@trustnetic.com>	<20250626080221.22488-5-zaiyuwang@trustnetic.com>
 <20250803094255.18afa192@hermes.local>
In-Reply-To: <20250803094255.18afa192@hermes.local>
Subject: RE: [PATCH v3 04/15] net/txgbe: add basic link configuration for
 Amber-Lite NICs
Date: Tue, 14 Oct 2025 17:34:48 +0800
Message-ID: <000c01dc3ced$c8aed910$5a0c8b30$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKiC98C7jrCga9wsmi8xZSIVafTeAMcNZ41AuUP7TwA9C0hobL+FVaw
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: OI/LFjtEDwi4s5+eDq+o8O2eVjDDWS86bW0zY+uw4OqOoH4lE6Pb0f8g
 I33deD6E1rBQKaUpH+QxeDvNOxVqrbeU8zVFB3APT2lNaaGoaOZBVJFDEyJT3p7ZJunhTa1
 IBePwAap3GBbaY1mpILFFAB+vN28SuSSrzw6G/PJqJ8tLhcC2hZGmeOlDLEc7w0PAeAETLK
 BIRFkMMzJE91ukIyLwtQoWVSzNLdfbhPiEi1/Hzp59+hxMA/sUQ4LKznUJ4wDGmK6yORHjx
 MXJGh7jQDGI0ctut/UvoZ7oHmxj/6ZSdcZBdqBC40J2CSUWLcL9lD7IcJMI8Ap2RkBAexrT
 U41qrk4wPUR4epIhsR2e1jYDqRUjo7Wj4qCzNbpd7hx3UFgVFSPsIScmbVQ/y9Ryslr7pJ6
 1FmYq36KYp0BHcpFxPhe1JzmTFJB4pfZLqh1TiYew2EcNU/8nwBUl/b642CV0dUHTk171or
 tT0MmWawFuX5d21LeFZYYyq/Y2M5ge7mS13KnCXj3qOiE0V9TY12ioYqEbG1AE2UM2eLigH
 z/qFbL8LlCnFNEO7RZOV4FDDpk+kL/TnqO56Ea9VGYjsgUwegT8Gjt2ua3HHjY1IduH4MMN
 OkemyqGCi2uW0iOUOSYAJzdbEqIpzLIFtKmyEVGoOo72UhzzoyUYOLAcsFxdQ+K2caLevhz
 hsQbbNZMn08yX9H06y/7QrkzKEn+DAcKBo8eCoEbem2JXngz6qDAhXHVy25oLK0TwmImqGQ
 HXWys+Iv1AXSnoYDFILRGDbf5sVumy1Jy7d7ySN7t4LYVvTibn3asj4P6MkxuPKWoi+y+Y1
 yeo9CWNte0AmUpIa1mGnG+f1HyGCoBcQRbDN07qqU3iZdsCT5pM/NwAAXuWYE0pJYBMxcVZ
 6n2B2mmO0V0sP/dlDrQMwhWS/fKRz+33luNY1cFZvzXNHS/rOu2G2TDtTDe11Lh3mRZxtng
 PtfchBIpfWWQtnvBK7nVsWinPr+Hbh1fZf9HMNd1Eaki+JXXYK4aNo5qV2sC9A+Z5lc71Y2
 HT2IRBLHwFrEKNa3L3
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, August 4, 2025 12:43 AM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; Jiawen Wu <jiawenwu@trustnetic.com>; Jian Wang
> <jianwang@trustnetic.com>
> Subject: Re: [PATCH v3 04/15] net/txgbe: add basic link configuration for
> Amber-Lite NICs
> 
> On Thu, 26 Jun 2025 16:02:09 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > Due to Amber-Lite's significant differences from our 10G NICs, we
> > split link configuration components (setup_link, check_link, etc.)
> > into new files.
> >
> > Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> > ---
> 
> This does not apply cleanly to current main (or next-net) branch.
> Looks like there is some fuzz (file offset) changes.
> 
> Rather than me trying to fix, and potentially breaking the driver; please
resubmit.
> 
Hi Stephen,

My apologies for the late follow-up on my previous patchset.

I've addressed the fuzz issue as well as the other review comments, and
resubmitted a new version of the patchset two weeks ago. It now applies
cleanly to the main branch.

Could you please take a look when you have a moment? We would really
appreciate if it could be considered for the 25.11 release.

Thanks for your time and consideration.

