Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8BFCD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 15:37:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BFE4402CC;
	Wed,  3 Jun 2026 17:37:45 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 54766402BC;
 Wed,  3 Jun 2026 17:37:43 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5D33D7A0104;
 Wed,  3 Jun 2026 11:37:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 03 Jun 2026 11:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780501060;
 x=1780587460; bh=7swFsJmAvPe9GPp3U2GtP6/Gh641aYJZNxBe+tJblqc=; b=
 coS8cNa5+G9tAfG1Dvz7bTjyby1SD1x80HsOWeLFBOgD0xL8AdFSstEoT5FfNRh5
 ViW282RVeRU2tO4wKT5jpc/b5kVO+0Jff3twmLicxhRk3YUTuzMcNXCLBdnz8SWK
 PdQzUMuBp2XDeN1/kYrfEBmBVTldYy6sLBYQ4948i5cPssrDYlyuJ6s+B/4sgIGm
 8TS1JGhaieWR00TeoslAfNeaPkj+Do9X44srdPsHT9xx5UeGbUnUtArcHgl+KD5F
 t2ZI3QoG1jm4byKcrGziLA0TW9O8H7dcl3EbofXQmw/k/emLQ58Wq4cV0FnvxpKs
 nfcxpUpMuYrFVz7pHjNQig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780501060; x=
 1780587460; bh=7swFsJmAvPe9GPp3U2GtP6/Gh641aYJZNxBe+tJblqc=; b=G
 7i8CfgioxhT5oNvcB/uOFHPcFcpn41hXPiCsTWn4+g5JxZkTUCRf0aCjfY8nJFKz
 6ZvXg6bGLMJn1kem2YixzALoaGmy7FAD/S3UXxrnfcbkeuWk96Cx3FsdDThpiPZq
 NI54THGBCD/xoRqGSvrG8jFiXKuzX9JpFhBZFvGXsHXDfJVsOhvEelKv9pFj1IbD
 /5U1xbI72ArOqnvBks5uJDUPrb7XyIccHpq4JR+E2UghJofVVlGWG2ReFgA3AOWv
 FS4kROFV9KfkRK3AN8RdLd8HuJFNo12ir/3KXAjZQTP2Cb9CtyZnNUim0vP7B3bn
 TiMHqbJpkEEY5mhMl2fsQ==
X-ME-Sender: <xms:REogalyv_npnIwNSd9DaFcpwitt9nUNXp_es6XoBw2lXa44Atk5hXQ>
 <xme:REogauOryaQQW1KDzulOlQ2IG1bm6-Ee6WAKEMm4uiBWqLqxJAejxEPk7sRJeHSZu
 4rjky2DO5_SnPg50GtzCMhCu6UKscnKMw0W1sgYahgIbBzZ3-MKBA>
X-ME-Received: <xmr:REogaq5pyf9coECnK4adrVrSdumRTssdhZMrsCZ_H2hr5B9mxBXqtnMxkUgU3lKlHIWMhAJf9e4qJdJeGMODK-Jjgg>
X-ME-Proxy-Cause: dmFkZTFtWLwBwuxX9XQ9pQM63mXhfxFDDtNHng4HhYqBPipkBt3lvX72muHfQL7pyFkgUC
 SK3qXqQLeGyiVBd+AfG9O0MiMtmCD5W8Ib0x3wzqUst4kiQ5oiUu6qORWJ8WLKpdTGlpBc
 hDUsgKNEVd8mgdjIZViwHy2W0EJpgN9noxiu9kdcbruRDQViPT0kzxLFyZmJvOk436mU7b
 85xr76h4zTd3bcEEeQ4fnjTwAoTyXo6rbvU9SGG5Bnz2AqtwtemCOyAd+dClH3UPRZFlwx
 OPXj4JwqYgqQ+NRiyB7XfaLbdcYZbcXPc5OWIm0aBL5PWmtq2nzFGPsVhIWj0b0OSUriif
 px2NnzMQT8oK+JAPxnSmehDRJxaV0HBBltFk1GyE4k2++PzYEI8G5ttvz92XTulYSkbfGE
 IkZT0oLw43VwT8qlKsXNxi0A6iDPJKV/T1ooVof5QQhk9ZIb33ZfI6UpWTfvbARUARp0QW
 22OSCuHp/GDsBhEbxcEJplh5ATdMSePwSiym1fbkoH/WNwt1kdsMXTa0KC+xblRJDctfAt
 8zGLCvUGQfHrvtns7uwCWk5de3pD9+HJHMf4/SQLO1rtubgBk7Kj1QaRFYalMsMsId+UHr
 CDAUMDT7lD2Ik98JzE0iZwUJUjqIIIJ2pa24iOslxvdAqrOR/+nFr0bZvR4A
X-ME-Proxy: <xmx:REoganmUjSUC_WugHLdPN8gjdfDHFhs2TpjIPkc4MHvmm8FeGfHXow>
 <xmx:REogajRI_EZYfDn5Yl7bZYr02zS7-vUb1oJL10GkR1PPIufIY0hWyQ>
 <xmx:REogauHlJm47fW-4v6WCESnKofl7pnSIUPHDxoROoJh-gEmIUDjV5g>
 <xmx:REogagHW-UjKmJiZx3a3thyupFEJgwUXCfS_obApiTUHQNxgfu03Vw>
 <xmx:REogarHtGDf7uUgMlxJCIzlY1Nw7e5k880qgWWyhJITDxT-MEkGHnqCu>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 11:37:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH] test/latency: fix intermittent failure on slow platforms
Date: Wed, 03 Jun 2026 17:37:37 +0200
Message-ID: <x6wO5J27RPaQicJ3onvbZQ@monjalon.net>
In-Reply-To: <CAMw=ZnRB+wv7ZN6c5YkF=LfTB328uYcBmf=xCqjTU8hSjzuVZQ@mail.gmail.com>
References: <20260531180118.274308-1-stephen@networkplumber.org>
 <CAMw=ZnRB+wv7ZN6c5YkF=LfTB328uYcBmf=xCqjTU8hSjzuVZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

01/06/2026 12:23, Luca Boccassi:
> On Sun, 31 May 2026 at 19:01, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > The forwarding loop was bounded by a fixed interval of 0.5ms
> > but on slow or emulated platforms with a low-frequency timebase
> > (e.g. RISC-V rdtime) this fails because the loop only ran once.
> > The test needs two iterations to get any samples.
> >
> > Rearrange the forwarding loop so that a minimum number of iterations
> > are required. The loop still has an upper bound on packets and time
> > interval which is expanded to 10 ms.
> >
> > If no samples are collected, mark the test as skipped.
> > Refactor the forwarding loop test so that cleanup happens on
> > failure.
> >
> > Reported-by: Luca Boccassi <bluca@debian.org>
> > Fixes: b34508b9cbcd ("test/latency: update with more checks")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  app/test/test_latencystats.c | 75 ++++++++++++++++++++++--------------
> >  1 file changed, 46 insertions(+), 29 deletions(-)
> 
> Thanks, this has been failing consistently in riscv64 since at least
> 25.11, hopefully this makes it stable.
> 
> Acked-by: Luca Boccassi <luca.boccassi@gmail.com>

Applied, thanks.



