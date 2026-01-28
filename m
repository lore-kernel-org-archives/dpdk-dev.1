Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AED5D35693
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 10:10:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 453A240274;
	Wed, 28 Jan 2026 11:10:32 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id C796E400D7;
 Wed, 28 Jan 2026 11:10:30 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 65D15EC0012;
 Wed, 28 Jan 2026 05:10:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 28 Jan 2026 05:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1769595030;
 x=1769681430; bh=m8wcjfnBAvDRRxudWUYwAZ/sOkNv1+Bt10dCsZ/cn0k=; b=
 HYzsiMlygI/Kx627q9BfEb6YA6GBKXL7xPZZuqU3GZZne+rsDE0PhYJksiKJLfh7
 ynl33x35vSNglgQawZKiKNol3FG1GOE6FUspvRQ8qD5NRdDFNSJVU9VwysmgSbbP
 c0hHT5Lgqrv2NPFIvTJlyuZoJmuKy5EE3JeuwiekB6ltoa/dKM+AMYWBICT5Pdk+
 Nvf02cJdcQHu0Ffuj3gOx+Mm61AHWs7ux56+VP2oPPxGqU//V6QYHpaJpFLVzZsI
 wMkILOOf+FvA/qMoClQDoYXFY32bb9zTmYEMWLYuRFLMvAOMP+rtxa3LP8/cIsZ4
 osfgHLxA6NcmtOUW6t3iSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769595030; x=
 1769681430; bh=m8wcjfnBAvDRRxudWUYwAZ/sOkNv1+Bt10dCsZ/cn0k=; b=X
 wFCrddfZmtFJUuWFfYa3SJHO/pjrYZT0UF9nsFiTgYFsmZptUUzMnE0YNJqqP/E/
 58I2a8j78ryntLXXhYvehzoJGDxqK4151xNk4kCygs/zYesNRmPsz8cTBVlgCEfq
 h1S9As1LllxaAWTxVyrtOfzc9sc3csRkQBnJJJJRCtCJAl/gfSPlAbiX5cAeykNm
 X6PPM8ohcqqDPrcnaJMjn+oa0JVJEJJnj4SLycfsaYeUR9GD7X0HoUoe6tr8772U
 FSuSBLmONHsCsHSkKzihRugQjRj6e0HGyTg8YTJ+AYBJCiBLcgeqz01c7B2S5RaD
 Zp4EVZ8pRM/X35z7sBgvg==
X-ME-Sender: <xms:luB5aWCcI-q8Tf1bKYN-lza_DIJ1sCuUhTJTFqPapz9Qf0xxHkyu_g>
 <xme:luB5ab8ivmZDSFjmfUBkgEvZjGlROL9omAnnHdswZlCfLM53YshKT9Zt9l8VvXrer
 lmjNnszqsUPy5XZ-ZXffrlM6olr44YMqyxCE_0XihgDRyfscB48cw>
X-ME-Received: <xmr:luB5adF4K8SHu73e7NfyVKPKo0ov7gojyr3ZfNIx6t-VrVXr1wSYb3hwXTI_rdMsxe6JsK7FZtlO4wk3ED33KXMkUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeftdelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeifrghthhhsrghlrgdrvhhithhhrghnrg
 hgvgesrghrmhdrtghomhdprhgtphhtthhopehhohhnnhgrphhprgdrnhgrghgrrhgrhhgr
 lhhlihesrghrmhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehtvggthhgsohgrrhguseguphgukhdrohhrghdprhgtphhtthhopehnugesrghr
 mhdrtghomh
X-ME-Proxy: <xmx:luB5aZMd5045uB0vlVYoBY97HQoR2ZZrrbd3_F_zNExIONIvFbrTJw>
 <xmx:luB5aXc8kJ3Slk1xCyYSj9usJoksjn3_MfKL8egHjkSniHTu_lm1Xw>
 <xmx:luB5aevSESJbs16pmMNE88Mb2OJosv7iMu1PaWTrX96VwZPP0YXpsQ>
 <xmx:luB5aQmtz_SIYIYdbZFXAe0UsCqsqK2k7fPXIfgEbSK3-pSdpVwBbA>
 <xmx:luB5adElmiU0Qfg7HN9mCaFmG1x0nDBgtTPDOy3I7v0AUR72o4_kpp7g>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 05:10:29 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Honnappa Nagarahalli <Honnappa.Nagarahalli@arm.com>
Cc: dev@dpdk.org, "techboard@dpdk.org" <techboard@dpdk.org>, nd <nd@arm.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: ring queue: update maintainer
Date: Wed, 28 Jan 2026 11:10:28 +0100
Message-ID: <4810279.CvnuH1ECHv@thomas>
In-Reply-To: <D6798C6D-8746-46D4-9729-A54BE4E0E286@arm.com>
References: <20260116230945.1536106-1-wathsala.vithanage@arm.com>
 <D6798C6D-8746-46D4-9729-A54BE4E0E286@arm.com>
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

20/01/2026 02:55, Honnappa Nagarahalli:
> > On Jan 16, 2026, at 5:09=E2=80=AFPM, Wathsala Vithanage <wathsala.vitha=
nage@arm.com> wrote:
> >=20
> > Replace Honnapa Nagarahalli with Wathsala Vithanage as a maintainer
> > for the Ring Queue module.
> >=20
> > I have contributed multiple bug fixes critical for correctness
> > under the C11 memory model and have been actively reviewing code
> > for this module over the past year.
> >=20
> > Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
>=20
> Acked-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>

Applied, thanks to both of you for the maintenance of these critical parts.


