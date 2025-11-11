Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CCFCCFA13
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 01:51:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 177C84026D;
	Tue, 11 Nov 2025 02:51:59 +0100 (CET)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id 8BB104026A;
 Tue, 11 Nov 2025 02:51:57 +0100 (CET)
X-QQ-mid: Yeas8t1762825909t979t64354
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com
 [125.120.180.10])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17596435647893977700
To: "'Thomas Monjalon'" <thomas@monjalon.net>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, <zaiyuwang@trustnetic.com>,
 "'Stephen Hemminger'" <stephen@networkplumber.org>, <dev@dpdk.org>,
 <stable@dpdk.org>, <zaiyuwang@trustnetic.com>,
 "'Stephen Hemminger'" <stephen@networkplumber.org>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
 <20251027031542.10512-9-jiawenwu@trustnetic.com> <4063720.8FI41Ny9JD@thomas>
 <006b01dc52ad$033b4cb0$09b1e610$@trustnetic.com>
In-Reply-To: <006b01dc52ad$033b4cb0$09b1e610$@trustnetic.com>
Subject: RE: [PATCH 08/19] net/txgbe: add device arguments for FDIR
Date: Tue, 11 Nov 2025 09:51:49 +0800
Message-ID: <006c01dc52ad$be5c92b0$3b15b810$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLtdPOLvvCVkFWK70Jhe0nQEI34bgF4CjiAAx2CgpUB0Dt/+rKXQraw
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NBEEf3D6WWSiOvziFXHAuMh0TrYdTdq/8wgTPx8isCSW9UJp4fsfIZiw
 PTch0UsZqj2X9q0wSagEBAxWm8n6ztKkdmqSJnGoQaB2XpmTdz+onF+3/sed/ts8gEj/AoD
 bc6oHjI8AHXOtTTQupzQN14J3Fkwou9g5MAnC295YQCKxdw1WQiI1foMLQ1Aa1UnS/uKdnJ
 6ByEjt6ntELwen9tqhlMWVe/tKKNG+soeTX7s/z4YPydsGPunNeY0qWsMovl3on7/1rtn5Y
 y0svv57DDC2rn03JkbRA037SXx5NbOUlsY3CEKKnFkKtIOknMbAaYxdfwmTjMh0MPEu4MWd
 2fcuITyeqk85KSo+cUtvszHBoXjmzOlx32HqnwlqJUUDPyTQKZK7Qqi4jiiuueeC2eDzG0h
 lLDNlG4NPn7s7cTAhq0QJD7ShJzL/1evETuEvDRoRqs6UOCWJ7bvbyiM59UG+O44hYB47oQ
 SYJG1Yu1fdHYmvBTLDLGGPxrbzTLWfMBFxZlq9T+iNLyTBTacRg7bjAyo5WoGPYm7CUd0fo
 c6/rJE/IlOy2LZ6ijfCc3B1Wa3HLmMuez4a3sH5u3OWHvVlNiIFrLifgCE2yjL/tPoQYVhj
 Izdz0wP/kkrxSpAnXmxl7cX72GIhHrRCqwxfv7U67ikUKX9rSzWTx3M0ArFB/TAUWFG+Z8W
 /9ZVr/prTATrgJD3D1cZ8Ati+tnb52OcHgh5ZjgKPdVUIQ+xNgrWDmAurmp8sGwD1dS/yhR
 O6kD6A3y0bf9NJGPJu4cynzcCNnsDbJ7IAwoL0UxfJgW/z8OWWhAQGyntEJrE04M2ihROvR
 ttpD5unHh55bohH3vKCQMkGNC+f51UrckXQ8XORQVOkhP1tCIPIGLdz8jRr7wQm/xGCSJnY
 3KS1C1HtGKGYCgvOkKmsfD8g6IaqbIC+Co6RcUOzRS6aBzyjry7R7F9EyvDIkqK/NP+2BP1
 SyVXJmSdUoCgrDremetDqw36ZkcbyzCSDa/4guEXyMQGnsxsJkbd18yN9MBzUWJnC4S3Y58
 NxX6hnhLvvWvdxmvuCNHf/dQtujwvNmsvup1srEw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

> > > Since FDIR configuration is deprecated in generic ethdev device
> > > configuration and move it into the device private data, there is no way
> > > to configure the FDIR parameters.
> > >
> > > Two device arguments "pkt-filter-size" and "pkt-filter-drop-queue" are
> > > added, they just continue to use the previous naming convention.
> > >
> > > Fixes: 5007ac13189d ("ethdev: remove deprecated Flow Director configuration")
> > > Cc: stable@dpdk.org
> > > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > > ---
> > >  drivers/net/txgbe/base/txgbe_type.h |  4 ++++
> > >  drivers/net/txgbe/txgbe_ethdev.c    | 20 ++++++++++++++++++--
> > >  2 files changed, 22 insertions(+), 2 deletions(-)
> >
> > You forgot to update the documentation.
> 
> I'll add it in v2 set, thanks.

Set v1 has been  merged, I'll separately provide a patch for it.

