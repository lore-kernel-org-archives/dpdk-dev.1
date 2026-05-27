Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AF9CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:07:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A07240285;
	Wed, 27 May 2026 13:07:04 +0200 (CEST)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by mails.dpdk.org (Postfix) with ESMTP id 7D7834026C
 for <dev@dpdk.org>; Wed, 27 May 2026 13:07:01 +0200 (CEST)
X-QQ-mid: Yeas1t1779880016t583t46524
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [122.231.28.113])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 4420622659791102530
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-1-zaiyuwang@trustnetic.com>	<20260511103604.19724-4-zaiyuwang@trustnetic.com>
 <20260517163740.52739478@phoenix.local>
In-Reply-To: <20260517163740.52739478@phoenix.local>
Subject: RE: [PATCH v4 03/20] net/ngbe: add missing CDR config for YT PHY
Date: Wed, 27 May 2026 19:06:55 +0800
Message-ID: <00ba01dcedc8$edfc4f90$c9f4eeb0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIzGrJ934oa1ka+Tuv/tXGR6pozcwG6Z/2aAVQ3yQwCEgrc8LVCqmpA
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NSXtYWcyD5KOCHI8l3Lci+RMIONX6rGSs51Ymt8f+c2u+pcqr02DFkeb
 jDPZgY76WkBEMcnWy4dG62EbVl+pjaOmJMysUm47bs1cOWiUQtiLSrTdYZORaJlwOF7Pg4o
 80G66Z72woewbKnzvVE2OVIkxfxvs4Hk67G/YbhtIP6Y/A9cKNf/wYzV7xz0vA0MBtlGAOc
 Ep9olAclRLwFpDeaBjaU1iomgp67r8wxkfi6Q4Z1kAd+IT8ANm4VFhkFUrQeyDXYShhegdK
 iO+Ed2FQlVePpBLPsKIfwDy/SThfXgWiaPc5E4vq5dUAiTzDejmEmVYNZZEbpJDR67NZlYU
 gar3pNu/xWuP8wQUobwvnPkZ70fXP8DX3cPlJ9k4jekcQLDjMeJj7iiFwSVq6FH4Qf6+XwM
 WDAZdclx2NP88lffPOkwBUHlPpiwnL2BCmN2xYfmHRhnYvNg3JYWe58mBv23B+CIWX8x38C
 xutGfmNqpfcjS/QS7/VFdUUYZ6VdH5tIf46fe+12bLIwuKsZNSBilXl1nJaTZcEit4ufNlh
 1J4D7sNy7I2RAnn8IAILvF+BSWb7ikMaotNb+pgcJ0q3BUvph+J9XEEC2RHLesWrb1E1N3A
 D8H18oHRzs+bPGKHMEG1r36WoopgrBwUs2iP+e/YF67d3SdYSSrGAi+vFV9KvKkk2Lvvd/w
 BC0F67ZgTBnfz3c7pgDI/KEr5YJEsVJl2VJPUcS2Trhpd6DJ9Tvvg/8L4komkLCGMgIX6Pv
 D5fHoFetqsF1Ai6KV5Les2zWnH3kx7lh7JL5Qo1lxs1cq/IU86mCK24RqHzw7a9e8Mv4+FG
 D2Dorl75HEwy/NTd7R9mOfIEdx+45qoLqe1ZCUD5vPiY7mXN3vfZGfLMyJ/GerGh91UQ711
 ccQUkVQSDfJNDXRDddBprWNV33UDkyfEozaIvmdQ4diBfkSKxOEjad/1sI/d2xLu4bkIxxL
 ltmfLFyoSWuaIifJ8xvhBFBBcPPLTAf2jIhfPvALm3TGpg1uSVtWAbZtZpayyibYNHwDJyx
 ccSYujYQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

> Semi-automated AI review feedback.
Thank you for the review. Based on the feedback, I have made the following adjustments:
> 
> # DPDK Patch Review - net/ngbe: add missing CDR config for YT PHY
> ## WARNINGS
> 
> ### 1. Missing error checks on PHY register writes
No code change.
In the long-term operation of the Wangxun Emerald Gigabit Ethernet controllers supported
by the ngbe driver, PHY register read/write failures are virtually never observed.
Consequently, ngbe_write_phy_reg_sds_ext_yt() effectively always returns 0.
We currently have no plan to add return value checks for PHY register access routines, and
we believe the existing approach is sufficiently robust in practice.
> ---
> 
> ## INFO
> 
> ### 1. Magic numbers in PHY register writes
No code change.
These values were provided by the PHY vendor (Motorcomm) and the bit definitions are not
documented in publicly available register description. 
Replacing them with macros such as YT_CONFIG_REG_XXX would merely introduce meaningless
names without improving understandability. Therefore we prefer to keep the raw vendor
values as they are.

