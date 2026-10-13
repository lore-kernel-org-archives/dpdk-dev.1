Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6ECCC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 07:46:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD7A94028D;
	Tue, 13 Oct 2026 09:46:09 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 25D3F400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 09:46:08 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 828247A00FC
 for <dev@dpdk.org>; Tue, 13 Oct 2026 03:46:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 03:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791877567;
 x=1791963967; bh=gvj6qY4l8o2R6kzllTWo8FIeHdHFAnHnR3Bf74JJMtY=; b=
 U3QC7R8ZUGKzmS4F4QmdwPojvWnq6Cd6sNpnNeEOTJ/tG1zbjQln6P8qXzjXOL4Z
 21OwM5N/qX+ZMyblGKSYm7mR7VxGl+lD1JlNc9iythY+zOzBjvFgY8kN5RGbEUgP
 BB8pruJ03hzSJTIaqUscg0ZA+DLQsGgV257PrSYaf69espbJledB7xScqwapqZ+R
 KkXlVHMHMVQE7xFMhpuckHhwkkPoK7EgsyMKC78xReyt/JkPLWU+B1l0xRoatONV
 aInc9wpBfzFK6+7lOdrd10TY/Vj2tcn0g3u+S0aGSmgdiQ2KMo0qB950O3b1NKJ6
 B9lab7knqhH/nrV1yKtnaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791877567; x=
 1791963967; bh=gvj6qY4l8o2R6kzllTWo8FIeHdHFAnHnR3Bf74JJMtY=; b=f
 q1gKrjGQFsTM6RKC/rie0lMhgyJmDZpFEWqy1Tv4KdrRTo3DNTb1jEoFxzaWKHr0
 QkgOfm5zxkLGBL+OQDaoIR+HAln5My/YLzQjhmt9D3FTYS8zbCjPd21nvBjlF97W
 khOuZRAYMXWYFpEUY1usZvKaBv2pAZmheOC9xrTfz3YVY9a3r9mFF70zNIUYGlvX
 KxDXyIjIrKo0qvvVrYADs1jX7TiwRRm+jYcW8X9ZH6TmeBIjuvadTbibVJitk3iM
 MIfnwUn6uQqnV7XYHe5PhNfznqYZMTcc2N3pnX/rIIfw+vYF3CDsopnsGdZ/WGob
 xvC53oOyaQs9CGiVUog8Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791877567; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:K0eltk84ZUHgZLyDpFd5F6n5WEkL9RQFAYDJPqoBleN0I3F
 NJww07jwCZ47K8nn3RRLK+2Tvoo8Y8mg5yPkHw/6yojpIlBVv6zgoD8/s1jm1cH8
 hvJOMmylDT9MxWEM0WjtHKTYopDnYAC7VZxA/Enu/bImMiEp/U+3H3JxoI3Qcp+z
 hz190bb19BmQJOD6Kimbbg4xZ5bvcyVXWhWh2gSxPwVP6gE30mQsCn70ZAs+PNHd
 mOwJpis42gg1hQVnaMTnSLWAfJNEjkBZAl/a4NsvR3VLCE0f6y4y6x9PiHIsOQvM
 Zf9yX7E7tfieITNxz89/L8TGkN+HxC6bWQiLHQw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:Pm4WfEdtmakg4dAnd0zUliVwptHDwvx4nYxcNj2xdgA=:gvj6qY4l8o2R6kzllTWo8FIeHdHFAnHnR3Bf74JJMtY=;
X-ME-Sender: <xms:v-HNagBkEgCRzKzQdYVGeeNKjw1gzjcYwlXINVgf52xtZJ_siaNQzg>
 <xme:v-HNam1_RFsTJCVnvQ3NRDFLNcGgoCLQt71oXBYO8Ifhex7cSocUGx-meWrFBv9Fz
 4K_g5KBx9nK0uicWiTpiGdLFC952aPKybnTDWwATjpfeTj1wilRiJQ>
X-ME-Received: <xmr:v-HNaivitkC7L0znCZNKHXCFRZxrlLGe9TzupgmXR9GOZH_Oxk4lrCaY7zxu-Bl3hHEWUJuev5gySamZI8STO18>
X-ME-Proxy-Cause: dmFkZTGa9Ug8doaqyhKU7FPqFRRgygr2T0WSzZL0Sov/Rt74qv1rdU4nSV732Td6LyVu+Z
 TPOhL3IEdJ3ft//LFlxQatPQBX6FZConKaHwARZJ0sjykATbsr+lzB/xwaO1R8LEM+PT0I
 +OGBwZUpeTw5WZ9Zhioi1R4LFERWCh5Gs3/hMoIHQHsxFE3Fa9ltLw+UZok76KaFKP9GSl
 hAePukuhT4mgiEwFFdJQslMXcS1WN5KP+MV+lUyZ6H7udJEgAcATnoFqN85VgEFmt6tqdk
 JnOzDEjOmHUVL7EjX1VV6AFIA4iXE6iMVv2PhPJ2yF3NgfbeqZnRl799faZbNpNicsERA/
 AZbY7i7ueIN0uz9MqjhluVIwITiB5aEOHx+OlNydmAoDDyoCWIFxZHudoURSt+h5vp2gzV
 +m7uL1/nclrFofO5ca+vF5BS+FtgQUmFtNzevdOob0uAoJtYvZ7I5Hn6wvNPsDIzHoGE4I
 aGQF4/R9khU5yzft/eSH53NvroyM6BLLCCdYM0Gox6WW3LknjkI4FPT03O8yIzC35Tcvz8
 WytbkslO1cee4LEBkuRp53Tw7PLSa067MuvfTCvarQ2A/sYBwFKRXGdXR8KVzss0uGFsXD
 owXnvqCA9TENrap06/Wi1F99MSvN/mZfib/SDj1krL+uCx72hAoA5v7rvPtg
X-ME-Proxy: <xmx:v-HNau7lhlhnvK5CqyfedgU6ln5tOdWZoqX-NTpf9uZkoAPy5XkxZA>
 <xmx:v-HNarLC6XO02B7QhaqYdxUwPiDM7YTPWkBWxHPpgEITOnFJ0m1MvQ>
 <xmx:v-HNam5VViDttBvpTEn2oEsN3vMOXu9iSiG_BgAFW3tvctOAl5zp9A>
 <xmx:v-HNamyvTOUc5EeeYsV-MiZNrp0NOTvOgPCKuKIY4u21tks7Mbuo2w>
 <xmx:v-HNaqPkCphOI4SyBsK92fEGmUfyBpQ17ZmuqpWeDSV3MA9D3QsvLFSS>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:46:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] stack: improve source code readability
Date: Tue, 13 Oct 2026 09:46:04 +0200
Message-ID: <x9VW9oFbSESonugkbjgkCw@monjalon.net>
In-Reply-To: <20260811084835.7ca64d35@phoenix.local>
References: <20260811121727.1706225-1-mb@smartsharesystems.com>
 <20260811084835.7ca64d35@phoenix.local>
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

11/08/2026 17:48, Stephen Hemminger:
> On Tue, 11 Aug 2026 12:17:27 +0000
> Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
>=20
> > Fixed misleading local variable names in the standard stack,
> > for improved source code readability.
> > No functional change.
> >=20
> > Fixes: 05d3b5283cc1 ("stack: introduce stack library")
> >=20
> > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> > ---
>=20
> Makes sense, but drop Fixes since that implies it is a bug fix.
> Cleanups don't need fixes.
>=20
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Applied without Fixes line, thanks.



