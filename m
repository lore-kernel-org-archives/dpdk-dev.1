Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0396606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=fJZripTu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kyJ10K+w
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47951427DD;
	Thu, 12 Nov 2026 21:09:07 +0100 (CET)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTPS id 4AAEC427C8
 for <dev@dpdk.org>; Thu, 12 Nov 2026 21:09:05 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 28A211D0048F
 for <dev@dpdk.org>; Thu, 12 Nov 2026 15:09:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 12 Nov 2026 15:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794514143;
 x=1794600543; bh=2we3u4rWCF+Gw1EmipOO/KXEPHK2eop5d8vcUsBQxf0=; b=
 fJZripTuXr3aYZdLStikxIYChGV0OYUnZT8d1o8h6P3+iXb0zBq2RvynY6HwCItq
 102uuZbp+5cWrgzRT7gLi2tH2iwZqCBPOzKOrxNFqm7R03bmblJVJd7EDcl4iWhZ
 hPWZl1La8YogN/jQZVy43cPy6k3SyHOS8Ma4YJZgeGbmOe7DMz5cjqXmjjkMoC6h
 eqB+5QtOiOjdbogSowYhbTTHz5ZgCbreHV1RzLRFcauP20Zd1kEhVOdfE9favL9x
 PAPKmbNov9PGNKOW2kGjoY3R6SGb0ltPYQtz5Rw+Dsjg1708IwLMnTXZ/UiPQm81
 Ha0zS2G3WrJnK+1SFOQ4BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794514143; x=
 1794600543; bh=2we3u4rWCF+Gw1EmipOO/KXEPHK2eop5d8vcUsBQxf0=; b=k
 yJ10K+wKNg//LB7k7uChLYUjx58a/SGBuOTrLb7N3PYM5qqAUmIP82NWWGm1Lote
 HlmjMCYVsGea9/N0o8K+V4oppwYS8+5gMuueoEKiSwTDtUfDJZbgEsmdejOoLWYN
 Y6x0Si10a1eVoxD+hQ63e9mr4gib2blHO2z2JjEQ8gRqgzooGy8PKGyYrdDuFB+u
 PzquJ2Ob5fjqphIJlf3rNa6a5Dq1dQ24/sQetpIqk6Pu5XKUIHpC99/6Iy4L3PrE
 cfv7cVI/6ljHUSC863+lcY18tlIkKzAwQ/+L0NVqZXIwaeezxhvDau5UP3yPfmB4
 xsYzEQMKfeKH85Ec8NdyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794514143; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:Vw8shUM9n2ztz2ukv/HqYN9Dk6fA/VjQO+8/ILllEaRohQu
 54seF0nvAmKPSG/z/x0jtRfKWmdeSD2H9cAx7TUl20YCod36PBwjtdd6i5zuNTPe
 jjRUEa95q/7hzsQx3XPgbmSv6ezmkr7QmS2iDoSnqXjssGYYTF/leUVdi2c+7mlo
 FD8g26bnOZD32G67kQhK+E0aPrKUvlmUfcxcBM8R5bD4SuE9EUcVSR1EpP0t3rHj
 6kY8aF3718qWwGwz2fkNEGMqceC+L9HPi+o+6h+ln6tLI2DIvUWJsAK2mePz5mOj
 Uti3vFNfLoPd+wJ842NTDkt1wGf7OYIOlnrWh9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:bkXkVALrpHRoKImgwCRBJPd7CT8waTBT+i1UO1UaUk0=:avEaMgguEGPkUQHm/vIjOhTYlNWwTwbLoPgdtxp/C0Q=;
X-ME-Sender: <xms:3xz2aidAFLydyMvJs2mKABc2b0MK9XPG8uEdPTMql6_b0BVIoTJJ2g>
 <xme:3xz2aghGztk2ygby2sHgn2j_TUfya1ryj_9LSUWbitJbonFs7CdtZAWlzAlFUBy0D
 4rHGipbbyjuORQnQuybKuAwI3sI1ApFnXzFqn-iyhjhCLteQM4M7Q>
X-ME-Received: <xmr:3xz2aiq0s2oHUepX8auelEWiZosEf0CqKsY4pLBi6Mwu7__cz7sVtEeZbcWH-YRY9uCWrBzqsovMUpVQQXfTrAs>
X-ME-Proxy-Cause: dmFkZTFpHCy6bcm3VndzKLPZj6mLojnuhGSdfkSOJrHhNEK8LjFnrcXfjw/ZiPeaTNZ0CK
 RfwAcwiQzfoDfSZmfrNGfBToSbjIbuEtMkZPTttpdwGpDSyEslPWdKOHQxKo7OhXxurZ9m
 kIVib6oennPmsu6fG9j8kfg4vOfDzICrRT+q+Ce5jxM3RadBjR8Oyp45Emo1vvR+K6IovC
 uTjYp8MjAJ4jJLHlFdj1hAWhUV7DCJWEi/0qz8gtnlnUQCY12mxT/DvX1/+7FoUQAzmlok
 AYL2b7bA1KQp3g48MOoa6pU6BL/jLcoWvDEc6HIPy7RdXbwe8ASBK5NnBIKKGaLgdOGbX3
 VI1LicwA2GeY9/qa/J53orkiVAnlV0S7zmEUTCKG4qsl4QSh+6wG98vzDGtm6KsLdPSVlW
 gawG59Q6M/mlh4WWST7HBg9mnIsn/HCxJl9r9cl48E10qxcGqh+nML/AdAdpDAbbuSjnHQ
 Wgp0jFtRPl2rnS60pMf0BgOwgA7+JxDqKgP+fRrYqnh/DN41tha/ZFOiwzYGmSIXl8Cra4
 fUWORWNc8FavzLdFDd6OCzvTs+cKm31OAD9laTnVen7OHVtsPT3N0G6VN55+JxwsGaQkpB
 /0RIsn6pj9FFsgJZ+0UonfZCmKAoRGtU6c4PxkK26qn3IPr2+nFaJlpEn0Mg
X-ME-Proxy: <xmx:3xz2aoFp6xZRCKyXxLhAOtk3IVtCJdOJV5taJGzfpDwQmJ4XlI_0xw>
 <xmx:3xz2aknab5i0ervZ6pB0Wp01mZqF0U0PzNcz29xBjSqdh3ibNj2jNw>
 <xmx:3xz2arkK1NdoF8i_tXQgozXQcoZLSppkQMwxxBMGy15BNaut4zI5kg>
 <xmx:3xz2altC2CFb482uLCj_tKImZliq9ZcDnTp84XkXWfufJCWBQCm_NA>
 <xmx:3xz2akjzyl_2nAKmWI2i1aEaLRIvIp9IEjxispeARwYagr986vX6cvqe>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 15:09:02 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yang Xiaoliang <xiaoliangyang69@gmail.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Marat Khalili <marat.khalili@huawei.com>
Subject: Re: [PATCH] doc: fix typo in ipsec_secgw sample app guide
Date: Thu, 12 Nov 2026 21:09:01 +0100
Message-ID: <3nabVowwQFee0AdJJgWy6Q@monjalon.net>
In-Reply-To: <4fdbb0dac20f4c4988d1de1266081859@huawei.com>
References: <20260808135031.18134-1-xiaoliangyang69@gmail.com>
 <4fdbb0dac20f4c4988d1de1266081859@huawei.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > Fix "depeneds" typo, should be "depends".
> > 
> > Signed-off-by: Yang Xiaoliang <xiaoliangyang69@gmail.com>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>

Applied, thanks.



