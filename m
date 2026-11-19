Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7BF606A32F
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=0rW0EL9B;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EmkC05E0
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1CE7402EA;
	Thu, 19 Nov 2026 01:00:08 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTPS id E1A46402DA
 for <dev@dpdk.org>; Thu, 19 Nov 2026 01:00:07 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id E77F4EC05CD
 for <dev@dpdk.org>; Wed, 18 Nov 2026 19:00:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 19:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795046406;
 x=1795132806; bh=UPQidNgdnFv8C8vtzbKfCEcuOBXNnuRldz1S2LhbAH8=; b=
 0rW0EL9BQs05VCEqdJM6keLGPu7wW6PWH4bmHVglP1DAJge2B/QGaF7oQyaQDd1e
 Dt365xTpds74fURubkx9n5vogpR9sPhqFM+nFAygR61RluTd35jRjB3MBW66SLU8
 w7PPeab4f7gwmmFTsNW83KsJzm/k/XOaBhCCvj8AEXCztCF7U+X8Dc1qaWxGTRMP
 4SMwjUMK7PwLzwR12dRL015yYHJLkeDMzgaS24q4ho1dKbGbfNtgLlm9+0dvRU9F
 Q/UR493DtEtuStcEqj1IxPb4SoWJdLb6FQxtQYDFP65nrnhxsIc5xWooH/NrBUJz
 U0UxkU/rm078TaYDR8zhnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795046406; x=
 1795132806; bh=UPQidNgdnFv8C8vtzbKfCEcuOBXNnuRldz1S2LhbAH8=; b=E
 mkC05E0ppUCLimniH8CUplpPLCMPOD6iLDnD/XnuJrm88MhDizHPDDY8aQEE9JaN
 Oz1m6agtCJkGeuBW+gqGQDGwwUBbq2kyw2gd1+u43IHorXFNKgMHuGssQhJjqmV3
 G9k6JNLxtLiio4grFSTJyKAgaaFKB0VluOA05laWnHrKdyJox6hXrS3MMKVx1jJk
 uYwWoeAtihxmHwOa2l275YefccFHZF54BaM/9nAyq/zipc50d98L8gPrpWKDv1gp
 oE3ZiA2iQEvdVlv+HL6eKK+rRu9Bl4WH892oRM8An4ryomNS+ikN65tydeQUIi4l
 AjLsGIfa/xIvXqUENSunw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795046406; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:KTYtEFwz8GiJK8ur/mpDBFGpUzwlgNYbOdi2V9iAPpGzpFr
 EMIe7iOplJLa53N+FFcJvn3J8viAtpjTgtaurUO9TjU3ppD+XZ0sfaDxdxXz0UBr
 8OECPnm+WH9PbUL4ljNIco4+DH0nyLiK+RmuIpggzt5rTpXCZyMHkLxSHl2MO6d+
 kMnC3Ti/XeEy+VlZdxV3yUJygPtouk8BTln0naaAu33QLBhnbutiKOIADt7OEAVs
 OdR9/oa/MsJXK8A68ZY24xoOMz9uQCpx30CBeZEcOhNrx6+NoHAZUZGHuq8NWWjI
 uECqTfHYmviZa/u0M3BWqhi+6a6yDRQWhIhwwyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:vCHs48DXznZCsKIbw90qpLXe4SVj+W+8Jc0i0ozqh7I=:UPQidNgdnFv8C8vtzbKfCEcuOBXNnuRldz1S2LhbAH8=;
X-ME-Sender: <xms:BTz-avDE-1Zy1crbeBJbYia1QGhVxlF0I1oLdhpSOJEzf_CPuDlSKQ>
 <xme:BTz-aviXS14TRh0GaCBAofr_Xy7l12KuAAIjYrD-ZWjMakjF9mHETcmtHM77EDHNI
 zxGu891kCswNSy8zE2dEdrtPt42tKciTJ09E5M3miH6Pzf8H5r1wA>
X-ME-Received: <xmr:BTz-ahMTl2EWvM9DUw4zGYkeI-uDLzhkIRt4LWaYXJpHhKM8e-_O3U9Dqd9LHKrzvGxIcI39qfRFkg37cDKv9VA>
X-ME-Proxy-Cause: dmFkZTElbQnHJ/utrr5xrVwu5PESXUIqREIsKiyXV8gL4ZtO30B2D5+i8vPNDtI8F6/Nkt
 ff9uaAV+6VX8sVCVJjhanhmaoKuEgH2Bt0MfpvLBVTfoWMAbixTq+V43MwO5hCNZZ1UysI
 18q2P8UnYcZauz8gk4q52CwmdRZNvIRcjfLRENXYMQfbegRYNa8FlsndxV6+TPm7YxM95j
 OEFlbCNtq+arSdPZjWqKlMRMq8RfVN5opVQQL6qy2GHYgnXBADpXZKdRVoUJuXGTD+jQyo
 Z80OcualEZnU5KRd2CuQAtgeQAbp26lQMMQaDxjMexzNLb/pDHuLrQdn4vErbf+PfJikAu
 lHDmQq7ubVvJOR4i7N8Hy3aJJHCh4tBGJImrUvlswl/ecPbBgTvyJwUhH5187xAS4AjAH7
 GK1ePEpiw0K/8fCZlKRtC7VNRc+3mU7LvLkozwGHHWkoBrj/bDd6EWTf8mV2bbl4A/1Xwk
 Njn1C0b4ZcFKBCtgd+Veqi8eC8af/BJgyMlmtjU7aA0oxD74tJjfrPtYaKdMBu5oZceOG9
 eu/gY96qjyv5DuqeipnnanOuMJ1u3ASJQwnbFu+hO1SVTKcc4DVL05D91HS23iLFfTDw5I
 zoz2SJQqGFzNB1MhjFEoixIFgiKfPy07KSfQhM3Db1HnnjoUKOkZo+qUL+yw
X-ME-Proxy: <xmx:BTz-av8usjjejd6ehLpsOu5W2QQ9-AcU4WqT-kEYl5ucMrJPlWfxOQ>
 <xmx:BTz-aidt7jFtFCNzHWCjkYdYMPJPgR0EOWuHWiHkdv7ADaKxGPJX5w>
 <xmx:BTz-auxjPR1YjVQ90Hu6pWgcoiAcvjyzD9CJrmndL7k0OEDKQ8_k_g>
 <xmx:BTz-anJol-dQEkwC73TwDmIPhoC1RjTYRoDUJpwU2RcLw0G-MxgEYg>
 <xmx:Bjz-ar7D9Gh0ThcZpFLxdRZMpURR0BNdCLOBCIfzGUkkvg0Kj6r9lWlv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 19:00:04 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, dev@dpdk.org, stable@dpdk.org,
 Mark Bulatov <ms.bulatov7@gmail.com>
Subject: Re: [PATCH v3] bitops: document max input value for rte_align[32,
 64]pow2
Date: Thu, 19 Nov 2026 01:00:01 +0100
Message-ID: <ppCZkCpFSy2hiYv6SI2Now@monjalon.net>
In-Reply-To: <20261116143759.51525-1-jack.bond-preston@foss.arm.com>
References: <20261113141307.4727-1-ms.bulatov7@gmail.com>
 <20261116143759.51525-1-jack.bond-preston@foss.arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

16/11/2026 15:37, Jack Bond-Preston:
> rte_align32pow2 and rte_align62pow2 will overflow and return incorrect
> values for input values exceeding 1<<31 and 1<<63, respectively. There
> is no way to return a valid result here: the next power of two above
> these values is unrepresentable with 32/64 bit unsigned integers.
>=20
> Adjust the documentation for these functions to clarify that input
> values above these limits will return invalid results, and thus should
> not be provided to these functions. Additionally, document an existing
> edge case of the implementation: when the input is 0, it returns 0 (not
> a power of 2).
>=20
> Fixes: 7253e3d2a5b6 ("bitops: move bit count functions")
> Cc: stable@dpdk.org
>=20
> Reported-by: Mark Bulatov <ms.bulatov7@gmail.com>
> Signed-off-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.



