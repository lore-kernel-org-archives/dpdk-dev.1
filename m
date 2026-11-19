Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE978606A33C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=Ee7nONRi;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MbR/TkxR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0993F402D6;
	Thu, 19 Nov 2026 15:08:21 +0100 (CET)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTPS id CECA8400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 15:08:19 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id AE0871D00234
 for <dev@dpdk.org>; Thu, 19 Nov 2026 09:08:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 09:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795097298;
 x=1795183698; bh=5AVS9NQIkcvYH1tCoAkEwGRxYKB7V5z4JieApBctgGU=; b=
 Ee7nONRi1hjIMvTXV/bCL0HzVgGIaRk3zHUzCmjy9kH9rWaJnkQr4rQoTvx2zx3Q
 NRLIKkupPmNrILFHKIm/NNwxeCQRbe1DwZ30g4HhqnHynIiavHRwzuECnU/RYsDP
 8sJCBfCGvQByJAs0JCJF1laEklQRkvJ0si8LoCE8GNFt/DxmV6+o9t7xnxTNydHp
 2OqJB55DGEIZ2sH5Eonhh6GOl2FdbcIv3VcwH9mf1xLYBMfJV1dPmCNTLLGu/Yi7
 p+UU/CdwSxQhjOWtQ47TXydUfVmgdvxrjtfFEPeTN3EuSe6lYPVosGSHDIjVbUGB
 +0S3+myZhbC6oCa3Ij3eSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795097298; x=
 1795183698; bh=5AVS9NQIkcvYH1tCoAkEwGRxYKB7V5z4JieApBctgGU=; b=M
 bR/TkxR9rslUmCXQZCn17Gszr/441AL6x6YMdVCgjzfrSqU1Bq9x5JogMc31RvkA
 dge57L3I0zz25SM4nnahhuVdZX5x2TBCgQnxQAawI3jBFzWsTBI/nrlkrKqP5ZqV
 tpwqRjA/9cHKzzCQHhMfZXbSjOGUbVgmhx17UVqLiV1RyLlTTCiuTBm9HZeXroXN
 eYCWHWGhEb+/Kc/jB/ruDzjB7NNDRQQ0ZmV5BkcioloLDpdOr7v11M7PEBpPA+7T
 vqg7GU4OEP7Lnffxd35k1GqviJejulsR0CiXhW1vuSsXPseeFbIimcJ8D3GKtpQh
 lNGet2O0dVGe33JbGFaQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795097298; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:i5ohnA3YorDoscgIPyvsW9evcM+iF2PD0DuvinctiJZUxYl
 T8ip3A9Ifv0I7zPbwrABf8NXRb/Lq6hHgIqugkJYpSPOeoMlOrcYTzFQ1O6tKYlj
 LFANmBcKvzrKstq7FYq+lW8vJkx68FOnMuliWEtH1GZgtCXoXVMgX62XMj+xssxN
 ROLUiCocqwBcABQtWymJ5hTubhcGGJEB8ofw/88Fxa34F7FVv+1xWtW5gaYcQwSF
 7EP1pI6AF3bCAtCFA1xIzEc8BRqisl7ib+moudWAB2eCWgoL9PHMwO4ZU6/MCofx
 J27++DfZegoZhXed/B4mNmKFvSv48KGEBxOuI6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:loZzlenVkyMoCyhZ6eIe2j3hyaqy0yvQvCMosIkUVD0=:jxzWmH+DVvqBNEQtLA1n3CHy0pZbD6oNydzY7FiCbRI=;
X-ME-Sender: <xms:0QL_at3wxlzHIoHAYu1MG8pUCRD73rGQftKMvyL8AipFVU-wy0jBxg>
 <xme:0QL_auJ7JEElWeqce3HdPcXEXvfK2pOdkX6TxTLZBTxyRVT252D7D7oC4PxebyeQX
 xwkltWZNX3EOA6CfZ8DfgvKvUw2LxZHr7NGyp33IUFlw2ARlyflN0A>
X-ME-Received: <xmr:0QL_atwmCCgSpYefiXGLZYzR4FjRkX1sJXcjbPFL1jsodKa7HOOInjqDuHDzebnrY017dvegHG98KFszzDsrMQE>
X-ME-Proxy-Cause: dmFkZTGzDWqRH4Epeaz73niC4mTs18ixMWvD7u5k9xldoKT3Pw1q7BHtM3+34bdg555s+U
 o54RL39DshoSppfNP5uCvy52MKCKUhMuRbW233qs2a0gwLxocwVVMbZNl1uBJ12PwDDPlq
 ki/buGCnNDKrCSQz2Nl8ZdTHu38WlQBs+BNwMpR/CaxcCwFgeyWnEHO7T5Lrbp9xXp44MB
 KBwldZ5Ywb7T9VtcZ5SXe9SSe0Omp1PpqXG4Z3DC/8YyDDKuLDBCau/wCidi5K6Nf8H/fe
 Z60IqKhqa6LwtrdWXGwdx064TRudOorOA5pIkxvEWM0+IYb5KBvaXj2y9x7y7PZuRoeTl9
 3qajlMFkTE04UWWmTTrXdnBRy1WfR8PltPrXbjBzNHiebVL4eoISexUAP87xeHjS/2tOnT
 Cijsd1AikIBXOX0wBNFsaHldJWi1WIcikmHN7p0UAaI7B1xWf3F//jXLKwKxO/UWceCyvp
 M4oXvmwrj5Ilzy/MDz6SDih4mRkjC7tbFZxmNXKdqM30Bvidb5/gRGT9T3a3Xb1EtSxI88
 0vsoGdNrtDQwJ3ZebJcywAsP0QcZnfSy7XQfHWv1I5XyQr2tRgEA58O89UL3LUDLNt5HFM
 4yyC+kbSQV8nRF2rO8rFB7D9iRN76LghClahQeuo9W6iMernuiir8NyUS1XQ
X-ME-Proxy: <xmx:0QL_asUum4es5kpxb71uCjAOqGtwCRjA6LxhZRQL4Pkhk3JeAk6MXg>
 <xmx:0QL_atilQLC5297LdduZOiuyNirzwyNKTwGoHg1Sx8iN3twdKeyzqA>
 <xmx:0QL_asDKj8hrMVii9B0VjIFEAgsSQSOZrXSOdkgd4u2ChbgHOYD7Fw>
 <xmx:0QL_ajtioCaXXLhzoXVOP9n-jdvYBm16qCP2kfbJC5cLZqqKqH1avQ>
 <xmx:0gL_akmmllh1oiLFdB5Q3c5t4PGzoP8c4GMwZfFcxqJjgaxeSyRZFhLa>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 09:08:15 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robert Sanford <rsanford@akamai.com>, Robert Sanford <rsanford2@gmail.com>
Cc: dev@dpdk.org, andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v4 2/3] mempool: fix dump of unpopulated pool
Date: Thu, 19 Nov 2026 15:08:13 +0100
Message-ID: <eexnNMGcSbWMwzjgikVLXw@monjalon.net>
In-Reply-To: <20261112154342.1484709-3-rsanford2@gmail.com>
References: <20261109144054.3784583-1-rsanford2@gmail.com>
 <20261112154342.1484709-1-rsanford2@gmail.com>
 <20261112154342.1484709-3-rsanford2@gmail.com>
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

12/11/2026 16:43, Robert Sanford:
> +* **Added function to check if a mempool is created.**
> +
> +  Added the ``rte_mempool_is_created()`` function
> +  to check whether the store of a mempool has been created.
> +  ``rte_mempool_walk()`` callbacks can use it to skip mempools
> +  that are not populated yet before querying the mempool driver.

If usage is internal, why exposing this function publicly?

[...]
> +bool rte_mempool_is_created(const struct rte_mempool *mp);

Any new API must enter in an experimental first.
But here we may not need to expose it as an API?



