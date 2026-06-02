Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE00CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:01:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09448402A9;
	Tue,  2 Jun 2026 12:01:55 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id B543940150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 12:01:53 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CD53F7A0019;
 Tue,  2 Jun 2026 06:01:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 06:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780394512;
 x=1780480912; bh=NaydJY3gKHHO8JM7fKItECbfvIH2s2IAOXvAiC1H3Xk=; b=
 d1jxlRas3sXsLU2hXbQ7tLP3DhGh+Z0z/pRtFzZ5evhYnajSHbQGxyNC9ynXo52x
 sbRYadoqhSqbHY8Y4W52uSwDTpe8XZjOEGEbECsOkTX+/0kLS2Ln1jU2ren9K9iA
 wtyDnA86/pmWi4uYQO7RGCnWfP6i7d7YAcFSC9FL0qFLU9wAQKVBzlyxHTjwF0kN
 F+VMcrPqWcuc2yKT0gU6gE0lEJbRWTNIAPSjgXKHdT2Tr+td6fAZZSb11dyIgydC
 QfHQuAeSSEZg6b9bsHa8YDNjVhsbtPXctfplTbYAsSY7QGzDOFHvgigBgVIORR3c
 eMlbsqNN/6eBTmUVXoD2lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780394512; x=
 1780480912; bh=NaydJY3gKHHO8JM7fKItECbfvIH2s2IAOXvAiC1H3Xk=; b=H
 RvgOFMGknYC18WHI9l1yzgz1HxfO7Rx+mT5XJH9j1DZVE9lfRXwPYrDIMsZ9jiaK
 o1vblgcraXL42cIH/JzQJCaajQ4cCwX8nFeQjVqAAMhxkbKIuuBfmMKkXhXW4d0S
 rhP9cj1cSoupy6ZlLPass+LtUZL1wDzuATKs3Tg068V7icWBD9uT6a1QzdzbfA2W
 kwLRfVVGDaCuZsu0sE8JrI7M5yywFTwYvEEnmVOuNWODe+e9yKDw781LYEldoaFP
 g4GnAim7N4HfHNsKDTNYCHvmyFUZ/et2FT/HPG7zB4FR3jbADK0qoqx7ynbreu6/
 Q6CGkFft6lhFFe6lPPvUw==
X-ME-Sender: <xms:D6oeanUdPKw6gqXRvCfetVqoZkNOoB88Yzr5a-NzSyelMGV2KUanKg>
 <xme:D6oeaj6Ug5NBDt0uz-SIJOzlqZYbPfhZ6xQ6x9zQDtURD3CAmOycL6hkajJ4KrTqy
 Kk9FS6DmImSIGDzIxCIfaGaxmdxmZwusLiUpj9U2LjibgIKNeYZcg>
X-ME-Received: <xmr:D6oeaiiF8k5C9qaSNGHzScRf19bzsoUktdmQxP-9TWvaJx4R3mwFHGeca8YUO6pG-5wG9cZfPOJnxiXA6YCYo0oHwQ>
X-ME-Proxy-Cause: dmFkZTFstBNSnyRqNlaTptn6HUe9+3k2KUvruJXwbz5rPqWbosRuTUkI+RT0z/a07PYbA1
 xI3bHoXbnZaLqMBu8cEboDfhuX4FbLd6mg8nmZ0gDtwajfXibQCeC7pOyJIXMvhLgrYEAV
 D2ak/SlmLxpTLoLq/uBGQx+3n5wZ2UEnK2kLeu+VAqPyFf6bPWA7RF/zgvVc6J5pi0KOtK
 c2Qm9kGfYmkFR2GhydwBHt82kPBVMRVc32tzS4aCdkL9xwBD3IBDzjxeGRIpVocxcqConS
 pRTd+Y8TTtZkjHXx9iXhCprxpTno3LizINzMqzVP1IN74vGvNhvOgZMrwiDH3gQRKcwoJq
 58iqh76L/IYDAco/knE924N73tuseE5qDUkLWFxap7kPlwrK0yhdwFBPMWraNzdjn8iM0K
 hT1yVs1E038sef/gILmRr8+IJQpXOQtD82Nqjg8omrfJB02IiX2ZYtH86LYpR5wrKNPThw
 5qG6HJ6yjwgOIac22jQalOoapX1oeY41QHMfRq5C/LdBVvNH5uJ9GtQrIxQ+rW9SXofP71
 JBTiUdKFnrRbBmeWK4KWUWZxMeHiMNrrDONtKBuPBLke4OTJUVbGvuMaaASuCHDDQKDsUD
 1QVezLelQwH1qWZs7PKv44rQiI6rKI6aSFdn793qBO7BrjH3OBXBJgIZDU1A
X-ME-Proxy: <xmx:D6oeaqeZlqMyR_Dw1OZFjL0voozcm5vhIcAhVmVXZp5TV4BLJw6-Iw>
 <xmx:D6oeand-naEBPpK4vmLFa3C6yITVEQ9fmcPiRccasTDVRTGyQyThPA>
 <xmx:D6oeak9GLAAn74E34zn4fytnqr8dNjFnZPEx-ExleiCLuvgYWzSvIA>
 <xmx:D6oeajllOpcCnoSaBCuhI_H_0b52KyNn-qd8pIZ2vXmgU2EZAbFv8Q>
 <xmx:EKoeaqqX2Iho8uAW0it_3hgXZbXpnXPvcqwNH5OWBXnFrayZr7vopWT5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 06:01:51 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: =?UTF-8?B?6K64546y54eV?= <lingyan.xu@metax-tech.com>
Cc: dev <dev@dpdk.org>, eagostini <eagostini@nvidia.com>
Subject: Re: [PATCH] gpu/metax: add new driver for Metax GPU
Date: Tue, 02 Jun 2026 12:01:49 +0200
Message-ID: <CsAn75rzSb2jiQLRSeXkmQ@monjalon.net>
In-Reply-To: <6c18e957-c1c2-4b43-9b2c-b36424c1e9af.lingyan.xu@metax-tech.com>
References: <6c18e957-c1c2-4b43-9b2c-b36424c1e9af.lingyan.xu@metax-tech.com>
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

Hello,

01/06/2026 07:47, =E8=AE=B8=E7=8E=B2=E7=87=95:
> I am writing to propose a new driver for the Metax GPU,

How do you access the GPU?
Are you using a specific library or kernel module?

> which I believe will significantly enhance our support
> and performance for this hardware.
> The patch attached includes the initial implementation of the driver,
> with key features such as:
>=20
>  * Basic initialization and configuration=20
>  * Memory management and allocation=20
>  * Core functionality for rendering and compute tasks=20

I am familiar with connecting compute tasks of a GPU
with DPDK networking, but I'm surprised by the rendering functionality.
Do you mean graphical rendering of data coming from the network?

> Please review the code and let me know if you have any feedback or sugges=
tions.
> I am more than happy to make any necessary adjustments and improvements.

Thank you for working on this.

I recommend following this guide to introduce a new driver:
https://doc.dpdk.org/guides/contributing/new_driver.html


