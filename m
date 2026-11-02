Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36926606A905
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=FN1vWCwW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ykrWYWIo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4799E402E3;
	Mon,  2 Nov 2026 18:07:47 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTPS id 1838A4028D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 18:07:46 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E57887A012D
 for <dev@dpdk.org>; Mon,  2 Nov 2026 12:07:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 12:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793639264;
 x=1793725664; bh=Z3HC2A+AwuUcqmmhrHbHz7WwAdP2e2JVcwNCh0GsnK8=; b=
 FN1vWCwWkTc6tvE2KaTC6h+HFnAAoSo22K1QhYHDmvbZWiuognfFmv0nx/Gx5znI
 I5glUCenfBGvGq6wGfkGumGARahMdWYCuG3ZIri7LrOk81zzMp4US1B2pdUMl0zO
 XSsy2nIAjhY9SIerED8ptXszSs7iLQqbwVVw1L+6qmvi9PqUjdVeWYZ2qlYOCQAt
 fA6X28/khB11iWEWNKTA34NyuXaDMAd6eMoemWu2vA7EO6Cd75BaoOdd6wCif6qP
 Ov6H0BlMGhsXk42G7DpzE/7p7/kn/Ge1RsXUMPyrgdZz92PxVZ4jRaxTpOeH8LTh
 uVz9ZYkzeIMQxQ6ZzwmUhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793639264; x=
 1793725664; bh=Z3HC2A+AwuUcqmmhrHbHz7WwAdP2e2JVcwNCh0GsnK8=; b=y
 krWYWIoH5wr72s+tKWbhvmPJO9Q2lDz3ZpugYqv1ZAXiWoqA9eBa1+uekVWKKgUZ
 aG1ExYmg/bLXVKVCLMjDzlSZVtk5HZjNW7HbPsd4hg88AE87vPlP55J3QXdBKfKn
 jqB0kzKiA5fExYI9XJedMYeJsO9mTl53nfExO/LP0wueFIVNq8/sarGKuQTJkW4F
 DbAe2jiTFBfINFF8QlBcGxVMWWT4Zz8qPvmz5bLuRGIMUjN3FTkW+5XpFw0W4oPr
 Bvx9rSpfcWHTE0eNooAu2V3b8ifkOO+eePuQISuugtJQ6w4lFXCh8rnAUGeu4FR4
 4f0N4kj5hTW3qaz/huIvg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793639264; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:U7dNNdKS0aT8H2NopofvhjPuEujTj5ezn2JLGtZSCteiyVo
 hiBA9OFJi8ac/C7a3bdq2BCu92lV53Mxot0aIUILBdM1EZVeZFFjJFJTQ6/D3rsO
 Ji8l7G+Be/tnjVXEp5cXktf1s4EgdQVthLWVkLNly7JAcd0ZQViPjiIs4ZVJ0xLR
 GrCbdSgONAa23Bc4aCGamVvgLIMBXdsBjrZYBIIztonShiQOVbXZg9lfuCwPF+6S
 ix2CGCLWx79OCzFjVbhh0LzfdHyycNbhqtzXJ6qcS1Wn4rRzLw9YNrDtCXsjwAwy
 PrRWYZtC8JpVYcaSYfGTa7Awfq4HhC3QMCa3kcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:of/uWI1etF8QGTktzXTj/pSRa5f0GIGN5nYuiUKqoaU=:Z3HC2A+AwuUcqmmhrHbHz7WwAdP2e2JVcwNCh0GsnK8=;
X-ME-Sender: <xms:YMPoav3w17kwgs8fBIOIhehBUTt-R8eZwKtE4oqcXf1CHHNTn6y9pA>
 <xme:YMPoauNqQr22vw-t9nhjRbC6pi9wth2Ppo22pzSMlD8ykuE2-kNjELBIYpLRhAuej
 W6_FMOWL6grq4rCuBqkM8RSc_JSpLchMGfd7UqmL0U-QNsdfZZLbZY>
X-ME-Received: <xmr:YMPoan1-ZhIFWt6G0nvSQypty7ReqDh0ceE8d7fbFmWmfh8jjiY5MUO0SzdrdjBNJ50Y2v0fRVfcX4hvlKS3CKI>
X-ME-Proxy-Cause: dmFkZTFdIrzqH5WY4XQMBI2Xt0oNq7SS+vrButsz7Bkqx43q3OfwqL94NZVxccLySO/0Vd
 pgTKWBdGG9M+3hGBi3ruix+Nt+b6sMTsx4MWJg7IsCv4sl3Q8tkknEaaFGPQb35Xchq0+T
 ZU5eGwxJo8sR+y7requP424ew/7AatoDyKKC4k7cUBBj55+6gaqfSqpQZUfXZrMUESUHmg
 GqCkc5/MPwOq5/033RuUvkRd3UNB8v8/6C0tzeAyzqt6HF+FOsnXsC9PpgRdyDFHMut0et
 SUwDaiBAJHA0qNI8wI5J38vmQP0SDmf5qbmSa5qb/u5/yEFU62lTlMRDC1VRMlJXEBsnS9
 0eTxHwNepspAee4YbtdZytwmPo2HLPUHuNUEwmq1UeY+p7Dk5EoMO133ohCTfzvKuHCx+x
 B6H1g1B8eD206rhJyEqXZLfo+Qiaw1h3uW3c0xIzE9aheyjzHtXVd0ivowtavdgzKrupzb
 Q3N9EqD/7/uLMiaQVYePy6gRkNLygVm+oC+b7YmTYrDlK0jWx8oFjWr40N3uGAjleAJQMD
 J5FTPg6mJNNBpCsHDAwQ0jMH5WMLKPcfICgSPzOt//mktmcdHVKddg9O7BpIIw+pro/AOq
 MJQdM37tq9rmDDMqha1QJ6/dTWlVIVLbblP+M8d8USZ9A6OoEEGa696fIOAg
X-ME-Proxy: <xmx:YMPoatHpsk_o5AsXBH11QXKVAs02jY5q7LwM8zlsRlYI-iBRVJcfqw>
 <xmx:YMPoas5h1eUO6nu4F9-Jl74mhiGEOfJ5OqzQNpya2sM452dMfl0_zw>
 <xmx:YMPoarvGwThzBJT9vAJiHbQ5mhmLrowVIDGORToQeD-OTk45DXCahA>
 <xmx:YMPoal7Vsk4gf2w3nWbSfSuJRZNlqi6fVdkTJsvN-ItkQxFc_4W-9g>
 <xmx:YMPoar-uUx3FC9GfY4HhWthcXe0eePMvcpjAmLLLh-zhVdMNjoHMCfTo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 12:07:43 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev <dev@dpdk.org>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v3 0/9] consolidate sysfs access
Date: Mon, 02 Nov 2026 18:07:41 +0100
Message-ID: <fKza-eV-SI6WeOnGQFC4kQ@monjalon.net>
In-Reply-To: <CAOaVG14kRvQjQLANeGU_mJMc0Lz74i8XEuC7_qdNcMw6gM6dyA@mail.gmail.com>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <tR3-FNBgRxOW6UbyTMi5jA@monjalon.net>
 <CAOaVG14kRvQjQLANeGU_mJMc0Lz74i8XEuC7_qdNcMw6gM6dyA@mail.gmail.com>
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

02/11/2026 16:58, Stephen Hemminger:
> On Mon, Nov 2, 2026, 15:49 Thomas Monjalon <thomas@monjalon.net> wrote:
> > > Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
> > >
> > > I double-checked this v3 again (as with v2) by running the unit tests
> > > against a device using idxd driver which reads parameters from sysfs. No
> > > issues seen.
> >
> > Why is it marked as rejected in patchwork?
> >
> There were just so many other patches for 26.11 and didn't want to rebase
> this one of mine

So I can mark it Deffered.


