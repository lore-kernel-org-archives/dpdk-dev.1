Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887FE606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=ycKd+GiQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ywh0SXqv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F307402D6;
	Thu, 19 Nov 2026 18:28:48 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTPS id 91C8F400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 18:28:46 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 939447A02C2
 for <dev@dpdk.org>; Thu, 19 Nov 2026 12:28:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 12:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795109325;
 x=1795195725; bh=zV4U+IlVldYJlNJtmhCgsbMxprZlhfJ9x+GHh7CwrY4=; b=
 ycKd+GiQwZJweAsTea5YRxoPXfR93rbzp/FhA1W8SZfnpWNh9YZwWxP0m2GfcpeZ
 85IeSV3VGl8tAEiG6j8NpFoKbOP7G07cAw+49PYoCehyZWJ90Ku3s5rNmS+1h8VU
 pJEucQ3APgpI0gzGkQrXRZZlEsKdvzoRPrV9kfbPnaGJ8UCYzTzamMCSz/7Em3EC
 ugrXV99VRSFmtTsLL/bMzT/bI5Vim7gazoW9LuLyjg8mZw9Si5pTzk4ykOCfm+Jc
 cqfy/7o/KXHnXp8VB9X7claG8rdKKxb3G5Cl6JVFwVV8aLLX+1XJUr8HvZ47hY5m
 hslimMaRdUUunINdjoPJWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795109325; x=
 1795195725; bh=zV4U+IlVldYJlNJtmhCgsbMxprZlhfJ9x+GHh7CwrY4=; b=y
 wh0SXqvZJZwap7N2or2/Na6j+xcCqmE6uUPK8C0zwCND6xtTAKqCUl+6JQTtBBwf
 4bcmwSGe4tOzuJDUq1wug3kmKBhVvOrLddaaWNzUwXmjtHD4lOiEBpqqGSzLwyUk
 gUAA0BEzfTzcMScTToGN/ND+VaKv+aG35JhEYTFRZsBtx/thfyHrMd6u80hzm0KH
 dPEJG/yefygheliHmd2lWZfmiYpCbFky0ScNHRuyov6/TibN57fX32YJ3i9PvXwJ
 9mTCOHvoBMJd2Xau3Hc8Q3Vqpc3zfGJdqqAslMv5Zu2RmkNPLLel4hxgbHpPNiQu
 M3ouZGlUiM1xjz9rboQeA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795109325; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:iFXiyNZy3Qt4RgW7QwvILcLF3bVafCZTPYGLcBCyDrf+YIY
 tNt1qL1SDEpYWUO6RH4QqLMr7tBHUDDNXbuV4I1ww5nkDB/mKbjpwDiQpV+WVtqO
 X2+oMBZx/EaMAT56hndZvZfKpz/dxotiOQhItohwcmT22X0noKFnQZqSePFtb5/7
 DkybdPc/uOcGRMQHglkL0IzPaK8uJgT383RO9Ai1LPyzD8AJJ5WzTytx6YKJRgQH
 sl/mhDtiimLfVG7bV4I+cZIKvsuxgduL58rfXOFhr6NLPRS6R3/NXVobFS/xaO8l
 EVLri1rAjD7Gj24zFXJG6vEghoFMufVnMf68WZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:JFTVF571aj+rkIZig5uM2mC6abm9gQBZp/zcWgRwBXU=:zV4U+IlVldYJlNJtmhCgsbMxprZlhfJ9x+GHh7CwrY4=;
X-ME-Sender: <xms:zTH_aoyw_E4E28I6sFIMLDz6yxFMq1VBT3FYh_E9Y6MpzD_gDrng_g>
 <xme:zTH_aiST2KnChyC-h3Xs7enAn7Cq8gG3t2Ha5ldATJZp1PWz5wlds9NJfHzZCXbw9
 Z03v7PSQNJE9TZX-QppsJYLaL6OGlMNMLVlsjkueedo9xNybM2VyFc>
X-ME-Received: <xmr:zTH_an_04fYLKr5IzszV-TmHzB_NfmRqyuUdC7JUf0ZDjycY0k22oMD2oPeMs3uLmC3kTZAXhmQuB1dfhSEWug0>
X-ME-Proxy-Cause: dmFkZTGHyqgWeeODNoETm2TGaTN1/aEgWAAxiUSjoQ94ctDCLVKglYA3R1bReNzyZk5/rA
 jHXTk7nZmlpDpc6uENA/QPmZ4FRxleg7AAV8q3NfSEzhaDiT/KMiNV8FNqbVUW0ABu19YF
 jEg22bOhBTI6XYMc0HkStHobh/evuK/M6saB5RTH4zyl/tywmaJ1L9RZctwawhJObd6+RD
 YsnyxbB8ERF/AlUOgHrSUt0hEnADVOO/QDqai1odd9zQKYs/NWnLEt6FK3bDjsBjupkLuV
 dfVynW2U7y+w6bGao4OVM38GjZgjmXyaFt/FdtxtjnVi8P9GX7XgdDK8K3thYtujS2d+R6
 woqQ52T3SZknUs10jHog0Brap8cRQ4E0m28UYe7J5XmXDEM4okC/lY4MyfqBezvcey/DSw
 6IB5YSOj4Dzy45XYzXRdC9lQ4A9CY4YNXf3FdAgIEVB+X2Sqm+BBv794EuNTwsAewwUH0t
 iH0a6rZQLCppGU/3xQC0Q0mXEiOgf+evCihPT5BcAb1lmSpPytPCO5l+3iJearERKzBcZy
 IVaDdGiYAB+EUSWVaHX5KRPgUbVn36uOR7h3i0QSrBpQASFEUdS0MSVza8U3KIwZMjNU3k
 qK0uyzPVF0+q/2x6sXbd8pwTYhmxFqhVsP5Sq7DdDPE/7n7/05/Vg2vx7ZKQ
X-ME-Proxy: <xmx:zTH_ahp9zc5NOLZiSWGRwtBIt22P9HxedTmZv_PgDd0pl5belE8c-w>
 <xmx:zTH_askdonW5UAINPl66oM5jSAH_wpE33qyBYSpomLuqlUp657Gi3Q>
 <xmx:zTH_agIwrR3QkNzh7PgSS-Z3u43DRYPIWkc9de9GlY04Q5acl-oX2g>
 <xmx:zTH_apzvSxViHHFD_Mv4_V7fPu0RIUILPqI8QkfzmvoNRSyQN1P8tw>
 <xmx:zTH_ap2KtklsiJ20JC49QAk-nNzZAhh4Vbdxz7w6YpgcyN1gyekVRQNt>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 12:28:44 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Riley Fletcher <rileyf@linux.ibm.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: Power11 results for tested platforms
Date: Thu, 19 Nov 2026 18:28:43 +0100
Message-ID: <uilMAV5USPmM8LBSVcEv1g@monjalon.net>
In-Reply-To: <20261119154604.281229-1-rileyf@linux.ibm.com>
References: <20261119154604.281229-1-rileyf@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

I have a question about the wording.

Should we write Power or POWER?
With a whitespace before the number or not?

19/11/2026 16:46, Riley Fletcher:
> Power11 testing results for 26.11 release notes
[...]
> +* IBM Power 11 platforms with NVIDIA\ |reg| NICs combinations



