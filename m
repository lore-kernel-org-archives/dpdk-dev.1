Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B7606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 10:41:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6710440DCA;
	Wed, 28 Oct 2026 11:40:45 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTPS id BD20A406BB
 for <dev@dpdk.org>; Wed, 28 Oct 2026 11:40:42 +0100 (CET)
X-QQ-mid: tivesync7t1793184036t11dd0556
Received: from 0F57A7141CBF4D1588B97A6ED8A17143 (zaiyuwang@trustnetic.com
 [115.204.251.223])
X-QQ-SSF: 0000000000000000000000000000000
From: =?utf-8?b?WmFpeXUgV2FuZw==?= <zaiyuwang@trustnetic.com>
X-BIZMAIL-ID: 1095136539143772265
To: "'Stephen Hemminger'" <stephen@networkplumber.org>
Cc: <dev@dpdk.org>,
	"'Jiawen Wu'" <jiawenwu@trustnetic.com>
References: <31C12A7AAC7E19F2+20260827114309.10530-1-zaiyuwang@trustnetic.com>	<20261027114218.9724-1-zaiyuwang@trustnetic.com>	<7DFF83FB89E01083+20261027114218.9724-17-zaiyuwang@trustnetic.com>
 <20261027064855.1b35835a@phoenix.local>
In-Reply-To: <20261027064855.1b35835a@phoenix.local>
Subject: RE: [PATCH v12 16/17] net/txgbe: respect manual link-down on
 Amber-Lite
Date: Wed, 28 Oct 2026 18:40:51 +0800
Message-ID: <00db01dd66c8$cd7b11b0$68713510$@trustnetic.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ8QNehdnXO5ExpIOsSsHb9Qgxp5wL+qHTpAs7fQK0BzxYt4bWYKojQ
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MySCFnuRsZlGrAmeCi0lo3b6Ciko4TUuyYCwsOS5xetDqLzefVyRca/O
 6Cef1ryeb17vIXTHOiToyJ6y9Sbhkv2VA97rHIDecCIBbKrgJwPNCNh0tYmlloNmQN46fHj
 03y+GKWsAuYfkJR9Nlg8xgpGdkl+ZNtKisL8akTsafQzOo03ZHEzCK1sK3wMPI32ay/IfuH
 HqwvhisIR/44bpvq3IAlPtK8UmMakpHR4BI8CnZ5QwAVULuQbPjiyN3cIlgOP8P5ePjGaZU
 B991FZBGnchCUDKvXTB44v2nfaKZb+WMvCyk3UxaarEHyaSCBOISBPkNE4nYRevQv3jQuR5
 Y1WkiKu+9EeDFoZ6L+yVpbyfzdxKIcnWfInCpxXDWYdx5HC/UUU2QbAJTKdBeFKvu0L4Bxn
 8MC4u3EmEpWerK33thFFts82ccKak7UXdNYHYZhntMPIyLn1bwtcyqQaLdN6OuoA+s2JuHW
 pyJOyeQe6og6qXwTgNgMeFUYpTuJ1OQacDqQV0HV2FS5lQUVde5MVeXJELZG0Ykr5zAnn/a
 2fi10osNuitM+dyoFMatjhH+Qf3NEzaiRHbnoToXT6t0uCnBT5Cgtz5/6a9tKy7CHsOtZVU
 OvaISlBFDdJQ+o8HAK0f5/UtzjwoqoOcTpPoAdI5OM/Fupnk4CZL6aG9Df7viU/HCYizSln
 fmKZHv4Kflkvuka3jJKe7cJWIZGs5pXNe2AgYO+P7RmU7OelOXnbQ1L2ABVQpxjVPN8y50N
 47jo3G1SvKcENVNB6GSLPzp1n9A+uLo32Mp0N87jUa84TjgbyK27yRufSsl2poPQE6a67Kj
 7n/6kHTYfJhfqXX43vBxlc79IaQsBbeLcXqYuHmDlauR8jUFiipjUcMQvZZHZrgbkLqPgGE
 gv+eDTf+gbcIHErdNImM43BA50V5nS9EM7al9MT/wfzT6T8/CxEykvtb6Dqtjwvl2eXdfOp
 TuGK0FFJFdqI8O0QcRyH02K2p/VeDyP9fywnffzJ8N/c4hmkODamHUxRjqLhT7z8x+1W8HC
 ZXCVSb9K0I9t2Zm6z5tPnI+mzjTt9Mh5pTNTEvPtX8htbhpbw0pIfwTX/8dhmuxdML2Fbil
 jArblb5egmei09hJknPxqcwZolUIWQYQ8BO+2tVUim5u8E7xkAGgoGtpWRfmFx/pqevfxoh
 fguJiTPL8nK8wGI=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> -----Original Message-----
> The only valid warning left on AI review of this series is:
> 
> Subject: Re: [PATCH v12 00/17] Wangxun fixes and new features
> 
> Series applies to main and every commit builds with -Dwerror=true.
> v12 addresses the v11 comments on 05, 12, 13, 15 and 16.
> 
> Warnings
> --------
> 
> Patch 16/17 (net/txgbe: respect manual link-down on Amber-Lite)

Hi Stephen,

Thanks for the review. I confirmed the issue and fixed it as suggested. v13 has been submitted.

Zaiyu Wang

