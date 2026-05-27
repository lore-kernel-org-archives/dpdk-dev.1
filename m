Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8F8CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:11:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADB494028A;
	Wed, 27 May 2026 13:11:13 +0200 (CEST)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id E118B40285
 for <dev@dpdk.org>; Wed, 27 May 2026 13:11:10 +0200 (CEST)
X-QQ-mid: Yeas7t1779880263t813t41153
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [122.231.28.113])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 12350763214044050875
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-10-zaiyuwang@trustnetic.com>
 <20260517164612.4d1c622b@phoenix.local>
In-Reply-To: <20260517164612.4d1c622b@phoenix.local>
Subject: RE: [PATCH v4 09/20] net/txgbe: fix link flow control config for
 Sapphire
Date: Wed, 27 May 2026 19:11:01 +0800
Message-ID: <00be01dcedc9$816595c0$8430c140$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAbJ1z9UBxJRMCLVCXeFQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ORP1oqzHuvxWeiAxrYLIJhFXXhkebxhdeAvnYBWRRHa0PT1WIWGGjoaL
 5Si+vF15R5REtiX7KTGfMPDar/aagMrg0NVt9zv1Q3ROdpLPDs8O1jS1xsUSKlU3LVMDzdn
 J6tCpIPEAg1wjSgKbv7s19EbM342/GZxWI6rS6yDFefkt2a1pEahOwrr7S7NEuZV0JFTnON
 2AJ3iejUDGxKlBbUU/iJtIiVkmiLHnPTQn7cSH/6AfOnujsFhkmNhPGpijbGMbbFUnWFDAJ
 1oTc7AR2fGpOJxU2tnCLiNvM1eWQoQvwi6KqwCYpWMLSkrN63E673j9jzf6gcdE0V/2Gs+D
 +/NyXxKHytYAQQIJ2IM95z6YjLtJuaj/5L21FdnqJC1XBaFIfX3EHe1Pc39KLzHNu6fcG0Z
 j1M9L6L4pyvYha74zXYkJMEGGl5pChTcEUwqER2JUMPvXCesiMW8ltyrLW0wk0hkGjofPHl
 6rozYcZsmrsdpbVhWZniomd8WcV2tNRHIC5VLF1o4+1Cj9n4hc4H9UlYbKOWi0EuTq+e0IC
 5p89MGaDrNhG6XKbwzF6XN4AmwgLmqM72cI87i3iSRRzB0878tAZgRdZJXxVnpZa11JbUQ/
 /7Qkog+kEMSsYU20nXkplJUlcV5UE8Hs2N/TxF+cy7Jatz9kPxeJQTbXkA9X7FCk7jBK9VO
 PfmW2Zd2cjeXM6fA+Ka7f8OPoI4CgWX2K1ViVCfHYQlHslxmtrB3Hy/iurR5G1cWE4wPSMr
 eGsQ/kMvDHx31u2qFNESNvjEVwmTkxf2A8ciO3IYt8dBqZVlaw81Ssz07U4SifIQ5zaBO7V
 I27R2glKFQVfwrAcO1tBwKOBsTtCfHJxhp0BqfooGnyB/2JBSKATq6UFZddxDW/69c8ZmLa
 6gvEC9gjvpWMp7uv+/l88WJhoXSrnL8oLR30SFAcT8TInerZeBq6wAkYFiS26bq3Iv2qbef
 q5/lOxOsnNe4R80CBJleExkITuAkVfEEuQzTIEnQpOIDa43AmAvpRacmXVUGhbYoTHZ8Une
 qwe77dYvCD473BEl8b
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
> Sent: Monday, May 18, 2026 7:46 AM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang
> <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; stable@dpdk.org; Jiawen Wu <jiawenwu@trustnetic.com>;
> Ferruh Yigit <ferruh.yigit@amd.com>; dev@dpdk.org; stable@dpdk.org; Jiawen
> Wu <jiawenwu@trustnetic.com>; Ferruh Yigit <ferruh.yigit@amd.com>
> Subject: Re: [PATCH v4 09/20] net/txgbe: fix link flow control config for Sapphire
> 
> On Mon, 11 May 2026 18:35:51 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > SP chips have a hardware bug preventing XON flow control support, so
> > the driver disables it.
> >
> > Fixes: 69ce8c8a4ce3 ("net/txgbe: support flow control")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> > ---
> 
> Comment vs code mismatch
> 
> 
> # Review of Patch 9/20: net/txgbe: fix link flow control config for Sapphire
> 
> ## Errors
> 
> None.
> 
> ## Warnings
> 
> ### W1: Conditional logic inverted (line 1042-1043)
Fixed.

 
> ### W2: Inconsistent capitalization in comment (line 1042)
Fixed.

 

