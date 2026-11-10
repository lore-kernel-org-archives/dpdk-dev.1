Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1182606A326
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=g1o5hbf9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JKhtcnEX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A59A40281;
	Tue, 10 Nov 2026 12:17:26 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTPS id 16EBF4027C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 12:17:25 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1DF8D140014D
 for <dev@dpdk.org>; Tue, 10 Nov 2026 06:17:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Tue, 10 Nov 2026 06:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794309444;
 x=1794395844; bh=wS5wWQZWHnHLlrKPbBuVN5EPSDHXt2DTznUw5oZMt3g=; b=
 g1o5hbf9fmMl6BuC+LaTb+rlGZZ9qUGl7nVM0rkfCZoIhxVKVwfW2H+1WNNcSAhD
 Ib46ourxCOOL7RRUmSo6nKU8O13pwkEbBNAwiKZ+SMgOmt4pIgLAB7xREhLbsP6B
 SXOcQGvP6TNjZKt7hhV7mZaTG7pR2WlwV2apYsBlmh4FQCcj0BOc+aJrh64jaoCk
 0Wy6Q8reMQuZGkrk0P3XJ+eno6m4V6xuz5O64R7AWZvhgyU/HT0vUDBFWuZ4g7XE
 GiON1VkjFg3pLkrlXp86NrFB3cgToPR16o08/qorhQxtCrgwjALrhAJDJei1jjOV
 lDHPBD2c1ryK4EJq6mgtyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794309444; x=
 1794395844; bh=wS5wWQZWHnHLlrKPbBuVN5EPSDHXt2DTznUw5oZMt3g=; b=J
 KhtcnEXlo44DSHDqao6hw5KdjE7XJdCUQLkJRdgXT0MHikaQsnpPh9W91GZ5s+Pz
 5YAQi+YoHXAtfxAny3MKVYiIz6oDi8XAeC9+Zbk4KOzJwuYaAaGvypszzndpHcae
 vl2vRKM+u672SWq32OxNfA6ZwWJWyG210arLbh2n2OZDjlMiS/P5uIn7UaG7WKcN
 qcX2PQzl2x7Ezym3zakG9mMLXgewv9utEG9ySgOcs6+cPd8TAaehP/3AGo/7H1EE
 7VlDSIdf7n4R3aC01haHzsj9cr+a86tuipXW2/E9wVJ9trKYmA+gmp8D7RXTNjLD
 y6i0VX64iRWiGlSTe1Wkw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794309444; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:UfKSS4PX0bWzMwryVXxWjc3oHztNnVkyi45CZ+b9MkHXAgK
 G0A9HvWSPVKVeym/HbqYSqHJ5vq92J/1I5VcGOyYsNiU+PlPhh/43e+Hk3txhEDt
 E8nmUu5sHh9SbNVpNox8Y+gM/4PtrV9jnocqPyhfBSKxrMnrWsXeGxM2ZSB3U0d1
 55MMlM7obgWF+w/KKcDgZXXxZ7O3Pj91y9lsylrq+/+xjFJORQ/hT98UCJTjGkYa
 apRsEEu7Hs0ViEtcKqp7+rWfFS7XTYIqOFbkoR4yTUvivXpFwBjszzv96GvqWsR9
 omuZnLo9zZVQKD1UX/BG6kAcLtFSqHR4ocDrqfA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:tLIrYCctlTdpk4PNFX4nrTJSXddLBkhqRJJT+xBxkwU=:4CiaLTdT9a1SNMLZ2yrt0ZlBiFfd0QF5zyZJUEspueY=;
X-ME-Sender: <xms:Q_3yaiz4Pq5q0ih5Pyv2edycPfEEXyIkEgMl0USAnvNYMLMubHvTWw>
 <xme:Q_3yaoWSpAYUDBYbGKPdhshW8RPOgV5J_9Rm3B9BBHR1zCGiqj7WGOYhxDsD6ze_X
 TtUfXPJQ5xtx7PwAUkSco3olWMM472eWNRTqtV8Q7_ESG0fZd73QE0>
X-ME-Received: <xmr:Q_3yakM8LIzDshwY9CGPFzCYeKgPqQInuYGxOeYDooWrQmIM9NNH3_hlUgvPqG63DaU4ZAcv3AGvuAyT4AgJoSM>
X-ME-Proxy-Cause: dmFkZTFaEjdvrkSyFaMfQiC2VDIQxykSoLMoaOxT3zI7yXXJoaMLNvfqPDZnj1x6fUW61Q
 /uM8ElDC+3WQj9OKzVAC4lNgrqkrxg+eLYdYCfoYjMo+b7O0N/AAAYZCbRZWF5LvhGPES/
 yA5UZndnZmUyJsFQaw+p9vctiE18fELwlEmsF+ECnm3OCXBuf6FaYKG3D0Y0LpDmWMSMw4
 2kz1wX2cXffs/0zN9jnPx1Yvy1gBKoPtj4KPwoSxObzkqGol1BAHG7IjkO+Ik1uFcejWnN
 qUI1DNsp3S4obZU3+3EpVqDIJ/HFPkYiiFAb/P5+dLNDEVxXS70INwuTV8DDVAXTtTUZO2
 UwqVYf11++MBRb4MoEHasYPNN/cLhJs1eOpG3BBU5G5Lx5SPzJj87KqotfuUYyvcDFhqdD
 W859LY7+8iSU30//nQsciYfbzv6Mix1RzKmbTccDNwikaw9Kh2gJUFPl4WdILUIzk5xjaN
 176Zd1e+fPEuFldSw7M+roLqmSUA4U9FvgvVgUxhusmTl9Ikin7dtWsE84+RQtEApQIqsk
 lL5J1YDLS9LdDO5VDgDocleHKRt8lUojnkZCwnhzL3QzBkUnWMYky7KPhMOxYiF552MJhZ
 NqwkWoS8VdEW2x/72lVacivLfhIunLBFNm+LUeq5g8FVDeAxjT1CDTmrYwvA
X-ME-Proxy: <xmx:Q_3yaqDVJqNr202acj3EcUUaiHDY5IQRBt0ryU7D9z2TZ-YtiodXPw>
 <xmx:Q_3yahdzg55UP4wNmkfEzNx0PUHQ9HKeUicJB9VidsPhFLvlVGE8Tw>
 <xmx:Q_3yapPIexfXp2dRKdchQyyB2-boyBLCo5xG8fClUYJnJvlWqW76SQ>
 <xmx:Q_3yahIHq7_qh3dSFacGz3SVkX5n4YeWTnqLTf62fK_aurYeLNsMVQ>
 <xmx:RP3yarGLHDS3mhWnYIw7_WoEZP_hsT1gB3XWA4EzXjc8jxA_CsBRf2RL>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 06:17:21 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: anatoly.burakov@intel.com
Cc: dish@amicon.ru, dev@dpdk.org, dmitry.kozliuk@gmail.com, rrv@amicon.ru,
 sdl.dpdk@linuxtesting.org, stable@dpdk.org, Daniil Iskhakov <dish@amicon.ru>
Subject: Re: [PATCH v2] fbarray: check file lock downgrade failure
Date: Tue, 10 Nov 2026 12:17:20 +0100
Message-ID: <KiTfZTlxR3mGymlfwz1rsg@monjalon.net>
In-Reply-To: <20261026093320.858280-1-dish@amicon.ru>
References: <20260928150025.593474-1-dish@amicon.ru>
 <20261026093320.858280-1-dish@amicon.ru>
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

Anatoly, this patch is waiting for your review please.


26/10/2026 10:33, Daniil Iskhakov:
> Hello!
> Just a gentle ping regarding the patch. Is there anything I can do to
> help move its review along?
> 
> Best regards,
> Daniil




