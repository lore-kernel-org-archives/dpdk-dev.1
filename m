Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC733CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 19:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23CCD402DE;
	Thu, 23 Oct 2025 21:09:31 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 7E9E940144;
 Thu, 23 Oct 2025 21:09:29 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id E15B9EC0128;
 Thu, 23 Oct 2025 15:09:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Thu, 23 Oct 2025 15:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761246568;
 x=1761332968; bh=Jqjq1H23yAMaz/ChS37gHL9ycCDNtA/Dv3hs0wVPJ2w=; b=
 MzMtMZHJBb/iL0c1iWsGYod4J0j5UzWuIdsQnvngxtKp+sik1LxfTdugsUKIe2j8
 Z4amJA7XD8quypJQcjpoof1wK72R5/HdS/8wCsIp+f9yxvP9aMBcufKZvF1cqpFP
 tRvywVriMx1eMap2S8WjNlyDrz/NJIinN3spAPS/psDeFGhXlEpKd6XCPzAnhkEb
 GQaK9xouj7jeziimznFaWLx7MiYypjBDP64tpCtoTshtMxm8iTW5/b6du3N0iuiD
 5XA3HpxdDc62e8x8WYYGcm8SLTiYbDxwCIu4e0pwAV1DC1wzobGJSuGksznwX+Cx
 A/3jQ6Nu9UPsIN7KiyQACw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761246568; x=
 1761332968; bh=Jqjq1H23yAMaz/ChS37gHL9ycCDNtA/Dv3hs0wVPJ2w=; b=Z
 rLGoQwWd+FFn4sam7AIjbaxlWfKVdPPZfxA+9kWMX7iuVO/kjQOz0jlq7vSNIGnQ
 wD8VazzNO2nd1HZ6w5x8yX1I7ltSUqN6JQ6g1iQAHyQZjg/aScAZx6YsnevI2y5k
 pNzaySepQznI/W8zVqS4sMBRdNhTB0DmkuMYwXXGE/y4dd3hYfd4AmO35GuDVIaU
 JWsEJaoV9udctK0M2XlDtR7ZU9cT2G2NlX3MvvPc2+oybQnAeGnWHTYpwzcumk6P
 XCo9KNlsyGJvPz1IfTLx6taClt83VQTLjycyB+EZ+BCFzedAt9wHuXXuxeczFgWR
 gRPQ4MOQT0mLGYB2E1Sqg==
X-ME-Sender: <xms:aH36aP4HbArA3CvQocnfIvxC6rLoy3DUjDvXDvDIg_sV8-EQGtplxg>
 <xme:aH36aAXp628uKyhlGdjWrOp6XnakZRss66Qf5SHjXtot-_V9sZfN9ePSeXi8iFxpX
 1tEy26XB-doRr73T58RfIm1E58rID487GKTXtWL2C2ayciP8mv3Ytg>
X-ME-Received: <xmr:aH36aJ_IU0lWnSlThWfvEXuSO5t1ihWYVgs5nZc8QE-szXjg2L1zPmce4RKCZvfOLAbJjaQR7PAa2xcGYoFtPrK0dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghirdgtohhmpdhrtghpthhtohepsg
 hruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshht
 rggslhgvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:aH36aEksrG59TMmRhFHEUh8c4mwU2_fLBiOwGNe-RBmLzdVf4hgV3A>
 <xmx:aH36aPUDd5NzSckINGgaUN46EPUq4PdlQRft6IFN_Ogp7YoOO50zVQ>
 <xmx:aH36aJH3t1jTyZq5tXlWdySJUVf3JorSMX7pqtTyUkKnCxLy8ol_bw>
 <xmx:aH36aLdrgjvVaaJ4pQK_3Iy4EoUgvDbTBaoqWqy5cOIFi6vnlOYFFg>
 <xmx:aH36aBx3vmfRd5QIFY3_d-k01m4D_5yAT5c7DXZ3cM_3qO7aV9ssLt5O>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 15:09:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: Re: [PATCH v4] test/argparse: change initialization to workaround LTO
Date: Thu, 23 Oct 2025 21:09:26 +0200
Message-ID: <34408313.aRNtrjHk3s@thomas>
In-Reply-To: <20250909135010.345224-1-stephen@networkplumber.org>
References: <20250627162305.340042-1-stephen@networkplumber.org>
 <20250909135010.345224-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

09/09/2025 15:49, Stephen Hemminger:
> When compiled with Link Time Optimization, the existing code
> generated an error, because the compiler was unable to intuit
> that there was space in the flexible array.
>=20
> In function =E2=80=98test_argparse_copy=E2=80=99,
>     inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/test/=
test_argparse.c:108:2,
>     inlined from =E2=80=98test_argparse_opt_callback_parse_int_of_no_val=
=E2=80=99 at ../app/test/test_argparse.c:490:8:
> ../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 writ=
ing 56 bytes into a region of size 0 overflows the destination [-Wstringop-=
overflow=3D]
>    96 |                 memcpy(&dst->args[i], &src->args[i], sizeof(src->=
args[i]));
>=20
> Initializing a structure with flexible array is special case
> and compiler expands the structure to fit. But inside the copy
> function it no longer knew that.
>=20
> The workaround is to put the copy inside the same function
> and use structure assignment. Also macro should be upper case.
>=20
> Fixes: 6c5c6571601c ("argparse: verify argument config")
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Cc stable

Applied, thanks.



