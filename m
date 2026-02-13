Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB70EF99C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 18:22:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F59F402C0;
	Fri, 13 Feb 2026 19:22:07 +0100 (CET)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 211FD402B2;
 Fri, 13 Feb 2026 19:22:06 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 3B0571D000C0;
 Fri, 13 Feb 2026 13:22:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 13:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771006924;
 x=1771093324; bh=VYcbDcJbmcIbZL+rXcAg3hTxTXsGnbA20b/Pe1KZklI=; b=
 gzx/SbrdJy0Xp2pV1QKBUWsGTkw1LN7UN2ySnSKjgGNyr3N5dc+mdNHwPwRPfsLB
 X+TWLckgp4Dh9p2mtuSZNkQJ3e4dnbx7WM3wF8slV0bpXuSQVlT3w3lEFobhLkte
 RCRGU+Kh9XWL47b7X0GNCXaFWN8n4ckhpRSWMdO+RDbWoi+K8xaeX884MMKrXOJB
 acv7j1fGDxyRrEUNS1B7RUFWNt1Yvj1egh62hlH+vtYoTHHl2I70SD6vMivLZlYU
 IyhzBmlODc0ja2xuTFotRfmxbxUo/BX1nRAX0OCR2XRPVIOGRwLDzLTL2NkWsOdd
 k2FQLNPvblPNRChFdJ2vwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771006924; x=
 1771093324; bh=VYcbDcJbmcIbZL+rXcAg3hTxTXsGnbA20b/Pe1KZklI=; b=O
 KMICupjlzrrmK8Z3zZE80nDZ1IaHS9E44sCyiw+pjp2QUSDxtF0JwR6++VXLNTYP
 Dny4LHtJp5Oh/NAyG/WluAY4ZhR9eIhNzHvx1PmwwHYMMO6XnUJE2Y+Q3zWypTpX
 s8rY6daTFXx8FE081ASkZ+fsj/7bgCeLNkx/kdt6JCnV0EFiQ3EvVVoxvFPFkdQU
 s27yE59p7LlI8Hvtm9qPlNKeYJerzh2VJsBJXorS/AQtaiMgieQH3QlknnkELc7Q
 AVNkvOJof6Xt+chTWTX8svw9npNgaPEorey1m3VmNq996jhkxaFCuSA9bkFyzuEa
 4Wzp81UQAfA8yKX1/qR5A==
X-ME-Sender: <xms:zGuPaWixdduEs5CEAoCYMYIvFysqmrtJDPoh7o5R0JGZw352hgbadA>
 <xme:zGuPaSdH9jhvfzkiPDix89MgFrOMyR9YRGz6bJplsug1iBD8PWMMkVkVMCyMvOSSA
 pVZfe3yf2MibJ8u0exIl5vlUUveYapy_UWYvryqbb41kqjG9b3KYQ>
X-ME-Received: <xmr:zGuPaRlpqHazNGHxfYIkG3Psnw3L-eEhuzDUGYMpwYS6bA_WgKWLKQ78D9GY2lEcCetWsStmiLYeGcK9E4s2TpG20w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekleeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehvlhgrughimhhirhdrmhgvughvvggukhhinhesihhnthgvlhdrtghomhdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepshhtrggslhgvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:zGuPaTscWoATFUeLYeTmF5kzGFt8SwbNEl_PGUKIchiJz7gy-DIS8w>
 <xmx:zGuPaf-ZMW-kPDamNv5H8UoNqkw81EdyP0jiE7YD1NuY9RZpt7rB_Q>
 <xmx:zGuPadPVLoc1q1Cz7X17pLhdM9HY9jPtHsEP_VZ8d719al8iNFMLvQ>
 <xmx:zGuPadFZpvCwWFOIP-LXK4e7gJkDZYYnFZAAoROq7Ic7OtnFnNpw8w>
 <xmx:zGuPadm26qt4q94t8xuHSZOOEsHROyAtg66ZgumU6wzpMz-gCJws7I20>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 13:22:03 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, vladimir.medvedkin@intel.com,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org
Subject: Re: [PATCH] hash: fix maybe-uninitialized warnings on build
Date: Fri, 13 Feb 2026 19:22:01 +0100
Message-ID: <4193989.RQLdHFEMZ3@thomas>
In-Reply-To: <CAJFAV8xteqCnX7LKqPWFSmvbBz-rQVCRUuSmHLaHdG-BckhAqA@mail.gmail.com>
References: <20260212162705.3923717-1-bruce.richardson@intel.com>
 <CAJFAV8xteqCnX7LKqPWFSmvbBz-rQVCRUuSmHLaHdG-BckhAqA@mail.gmail.com>
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

12/02/2026 17:54, David Marchand:
> On Thu, 12 Feb 2026 at 17:27, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > Following recent changes to the test-meson-build.sh script[1] to use mo=
re
> > build-types warnings are seen in the hash library GFNI code about values
> > possibly being uninitialized.
> >
> > In function =E2=80=98_mm512_mask_permutexvar_epi8=E2=80=99,
> >     inlined from =E2=80=98__rte_thash_gfni=E2=80=99 at ../lib/hash/rte_=
thash_x86_gfni.h:150:6:
> > /usr/lib/gcc/x86_64-linux-gnu/15/include/avx512vbmiintrin.h:97:20: erro=
r: =E2=80=98tuple_bytes_2=E2=80=99 may be used uninitialized [-Werror=3Dmay=
be-uninitialized]
> >
> > These all appear to be a false positive, but fix these by explicitly
> > zero-initializing the offending values.
> >
> > [1] 177acaf5cf75 ("devtools: test different build types")
> >
> > Fixes: 4fd8c4cb0de1 ("hash: add new Toeplitz hash implementation")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> Too bad Intel CI did not catch it.
>=20
> Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.



