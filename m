Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8F2CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:15:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C5C84028A;
	Wed, 27 May 2026 13:15:01 +0200 (CEST)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 2FC8340285
 for <dev@dpdk.org>; Wed, 27 May 2026 13:14:58 +0200 (CEST)
X-QQ-mid: Yeas8t1779880494t400t06145
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [122.231.28.113])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 11302817978982181214
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-21-zaiyuwang@trustnetic.com>
 <20260517165533.20cdb300@phoenix.local>
In-Reply-To: <20260517165533.20cdb300@phoenix.local>
Subject: RE: [PATCH v4 20/20] net/txgbe: fix to enable Tx desc check
Date: Wed, 27 May 2026 19:14:52 +0800
Message-ID: <00c001dcedca$0ad76fe0$20864fa0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAfhA79sCE4zvKLU8CCUQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MTDLVpTOglk4bote6IwxVz9mDkltN1/NeKfJ+UcciSVqllr/u1Yd/If/
 XGwUq9X8VGrCEWEunwWZ5U+hpLzfno3wRh1f1z5QJllaTm7nuit1uoPso/aToB0FZ2sb6hf
 wHZcbwpza9pbKZD3hWqCKHY6wukHM49rxbLR8ieyNVNPjXCw9pBi/cctrkKT37/G1Fzo8Qh
 aIx+X+fdWsYWmiN3BzSuKxOpalF9DxNWU38/g+3PjMNu1xXOUeNynQN8uZnkTAyTemPWuT6
 tbB+WYJhxFCC1bDg9iU61U7w9FjeuEZ2HIx+l4/cr9qxGB4W/Bzi/RFNLTy61AscfMPuvKc
 xGVLqvj/2ZF3mbrIN2izfEpLp6HvJZrUiF/LirNrW4VKOipqPFnOSACbGlqfZLD3nfewx1j
 jpc9C3YrZnXMc/Q9pBu4FV+58GmpQywSBGDA+1IgK4zrgc2vjRurh2toyqV8jAjXiW8HDIi
 tw5/8hiXFBATfz69QvFVPw18+bzDSWTMdanSW1ojvbl95Tyzzuh4K7PwoaL9HkzWcWfJZov
 9yPeMXI9g92GEAyFQLFsXVQ18TV3cEBwuCEv67HNd+jIOLlhOT6HTtb5rZvo32SVNpFlBVx
 Nx88nx3ofIf39VfHgOx9HyUJO+SiBhcp7s6YqMcuMUx8g2O1rCwPyZceu22YVwxKc4vD2n7
 X1lYbYqCT16TMLmYH/THHWquQI2akar2x45q9qLRahE655X833yHv7w3v29OTge3Qs/omGe
 +dY7LF453HCndWVRhpcbA1D1aITAl5mfgcSxc+sGbDohMRtFWJgYCr8U1QiNMrFKewGRyoW
 KGaSXy/3MraJNXmNtJkSTYmXftVubC3ZY8Rzk6PnemM+YXzVwMqdr/HFBXaFj0dsiWh6jBF
 Uz4UT8ix8FjYnuOvXvBLH56e87f9eCv4HO8I5a+6G2xCWvFyVds76OK00Db/yjlepiY+WfP
 yH0KrCmQg3hDxUjSfRHyrs0Xqge94kZ01/iySnAKsK4gwsYow72jCnM+r+upH+ohwkCJVFk
 HtPjjWeBkOF5rBoGkxH2ZJDPuoy/7MhhzE45BtaTorNBia+l6D
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


> Minor AI stuff here:
Thank you for the review. Based on the feedback, I have made the following adjustments:
> ## WARNINGS
> 
> ### 1. Bit manipulation should use RTE_BIT32() macro
Fixed.

> ### 2. Conditional compilation without corresponding documentation update
No code change
This patch does not change the intended behavior of Tx desc check. Due to hardware
limitation, IPsec and desc check cannot be enabled at the same time; the original design
was to enable desc check by default when IPsec is not in use. The previous code had a bug
that prevented this from working correctly, and this patch simply fixes that. Therefore a
separate document update is not needed.
> 
> ## INFO
> 
> ### 1. Potential logic optimization
No code change
I chose not to extract the bitmask into a separate variable to keep the change minimal and
the code concise.
> 
> ### 2. Parentheses around `using_ipsec` unnecessary
Fixed.
 

