Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3B7CDB46B
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 03:15:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE3B34014F;
	Tue, 23 Jun 2026 05:15:33 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by mails.dpdk.org (Postfix) with ESMTP id 35D384003C
 for <dev@dpdk.org>; Tue, 23 Jun 2026 05:15:31 +0200 (CEST)
X-QQ-mid: Yeas1t1782184526t627t47460
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.204.248.247])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 12785984934236929195
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260617081309.19124-1-zaiyuwang@trustnetic.com>	<20260617081309.19124-13-zaiyuwang@trustnetic.com>	<20260617085355.0a87d7ee@phoenix.local>	<006c01dd0237$9a737e60$cf5a7b20$@trustnetic.com>
 <20260622075323.276cb2de@phoenix.local>
In-Reply-To: <20260622075323.276cb2de@phoenix.local>
Subject: RE: [PATCH v8 12/21] net/txgbe: fix link stability for 25G NIC
Date: Tue, 23 Jun 2026 11:15:25 +0800
Message-ID: <006f01dd02be$88f1e960$9ad5bc20$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwEDHC/7AhwDFsMB1WhqkQK57XesAbxwF0y1U/AtgA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MDGUoPnBmw7s5kN9y2jzlLUASw/L6Jt9/lsfBpio98a0lTZ7xzPFiwtT
 ucCbNG6vuojYQ3ky2nVkjaZoseZ9llLoIcj4CJwYwV1TWZ8gWMeQ7GOK09nofdwO0s3Yo5q
 ccb888GhAAwKDG2jXaScl7xF6Cpgy3CPPhDrXjJCXNAOAagnZRdiA3P7rtm6pAn5/C0TFgY
 7goH8Yj77/7tXpCIrepxj5HPEPeM2bhqBoCGKZkiSaexMT17jRNWJqJyQfJ93xMCiYvru2V
 f3qAt5tv8ewKsV86m3A9Of6iK3n9WagHoc0wJLctCWLROUxZ6q1qe4VTyNOD4kk/1AViupL
 7zLmK5GHPPznbXnvg+lQ5gqP9BstAswzm0tBWHwTzOq4C7el+Q+zHb4vrghD/HmGvOWFtKJ
 EIU+41opDwhC3X5eIQ/4dslsCGJDmcju4ThGeomfjq1NtRu016iyBn2nFkwx+UGr8hSo4ui
 Teb0OO3vkXrD5GvM8IuwQ6pAeYTfDiZXBzmxlxubuuIpFeaXVoO+vLYjS8YFgoNdlBM6wXe
 rSTaB0j8awHDubAKpk4P3qdVnJsd6ZGK0lR1+3IP2o7Ggs0OI360cm4Kqb4lk04b/x65jyL
 qloKRF79imRjdOFXxKY6r3v0DnNimD6DbXLtuc/bPwF1n6IBohpqxdcT/1qBO72pNeC+oSJ
 kFQp+ozF4XxjVqAx4ct8THzQSwjya0n5I76xWBGqBAI/Vlq3fBjRYqgoY6YzY8tcr9MykKK
 ojQRwFK4/WcaRhgJI5sWTNdyXAl96BcD/rbulcxySHvoR8YExMJQBlJmVpvcezONPTsxtCM
 7tbmmJEUsT1UNfYKI2DaWrIV7MWx1Pa1H0DPj/N6SVDRjVe0Rvf9qXdqQ4YciSyHwIj3bOA
 ujhvxAs6nPIXOGqckh31vUIMO2gizGzwvhcCbUY9DmJV+05C9UOgBN8HyqwVD+Q/A3/HRvl
 qaZRhQ2SIXD8dqSlSWX/KKLasDV/Gyd4qHNbzzvjDLY579Z1snm+y7eYLpUJiOJ7f9X2YsD
 tSS0whbJhiA3REKkYabOabZ8rJEz4=
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
> From: Stephen Hemminger <stephen@networkplumber.org>
> Sent: Monday, June 22, 2026 10:53 PM
> To: Zaiyu Wang <zaiyuwang@trustnetic.com>; Zaiyu Wang <zaiyuwang@trustnetic.com>
> Cc: dev@dpdk.org; dev@dpdk.org
> Subject: Re: [PATCH v8 12/21] net/txgbe: fix link stability for 25G NIC
> 
> On Mon, 22 Jun 2026 19:09:32 +0800
> Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:
> 
> > > > +void
> > > > +set_fields_e56(unsigned int *src_data, unsigned int bit_high,
> > > > +	       unsigned int bit_low, unsigned int set_value) {
> > >
> > > Function could be static here?
> >
> > Hi Stephen,
> > Thanks for your time. This function is used in both txgbe_e56.c (for
> > general PHY
> > configuration) and txgbe_e56_bp.c (for backplane mode configuration).
> > Therefore, making it static would not be feasible?
> > I have also fixed the other issues you pointed out, including the
> > spelling corrections, replacing tabs with spaces in log messages, and removing the
term "master"
> from comments.
> >
> > Best regards,
> > Zaiyu
> 
> 
> Why I noticed was that it is a global function not following naming conventions.
> Either make it inline in a header or rename.
> 
Thank you for the clarification.
I agree that renaming it would be a better approach.

