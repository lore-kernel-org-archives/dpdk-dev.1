Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78144CFD376
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Nov 2025 09:15:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7689E4013F;
	Fri, 28 Nov 2025 10:15:23 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 92A1C400EF
 for <dev@dpdk.org>; Fri, 28 Nov 2025 10:15:22 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0CFED1400073;
 Fri, 28 Nov 2025 04:15:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 28 Nov 2025 04:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1764321322;
 x=1764407722; bh=b/WfVIcS8VHmHzXxRZQplD26KecZQnvIpZSyR3UIuQA=; b=
 MQg3B6NhPwBvubuY5cX85DzDcjHoDsyKdg99tG5WEcjMMZlE8/zjAEaP6MoY+uy/
 pFW9XZMCBddP6AEzwDUpG369A3J+/T8Jk447q/55DnY1BdMQ9M/22Ie5KC9924H5
 Z2HMfe+CKmGVYeV0anBrZZkWRCc1waTchu2TTVdMsPPqiWnX/aQbFbeIBb/5iKpZ
 WFeu9B5O585nWQng7fmKybQnXYbYq3j1+myu5JDejSP8ImroYUKk5hWtmDWEhDTm
 gG3l1dey5KX/WpYnvW6scDH73z/zadfRrS1hgxZUdYOYDph98yY2tvLj73yjOjG8
 HQc7XD56Q+qEhpeIQA17ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764321322; x=
 1764407722; bh=b/WfVIcS8VHmHzXxRZQplD26KecZQnvIpZSyR3UIuQA=; b=o
 NZc+ra+y8NENi26vP02ANXYvWSRS7YDRBQx5Q9YaMIXwqJ4e+3cA7YP65k3fKuSz
 xizmzQ0lHmWSaWMyPXvqeKd7IOgqc8fj8kHgWc5uQ5Tus4pkcEUlK10MdF3t0Mem
 OA4m15ZDMhNhiVV/9txQE9nv2bI5pudcKUkE3mPjxsqgB0p+61IADIoe1Uxg9mVU
 2mkIEmljwWM9mEOh5ujq8zu9RVW9oe37HPk94jso/PZFFKDmuWGCmEO3cTFCpx+S
 1DcNV6cpKzmkqO5gh51/H+YBhnNa8WwwKlsG/DcLQcW7YCmcyrXL0LB2oq81GuZJ
 ktSaEm8iKtWUKDa0UGUpQ==
X-ME-Sender: <xms:KWgpaY3HC96MMnl4ib-ERuGxqojWycM_BqwQ84HiGSFxDXgdrlbxRA>
 <xme:KWgpacD-RGAgrMLlKqe6iOAa2OEbiI9ISc8_lQhucXYi8ZedfnVsKu8jnOZYEemQb
 Eh-hYsLhZaXDkwxLP7c9JZY1_vU0wWG6PmNr9su-f67M-Bw-oHn>
X-ME-Received: <xmr:KWgpacc_eqnsXg5ROpYiLfF7ovm9JpVqvwFEUsg_zf-BPg4DWGghLmuoLZVJ4ucXou6SLcU7160V6ULBeseDz2gRhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeelgeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehhvghmrghnthdrrghgrhgrfigrlhesnhigphdrtghomhdprhgtphhtthhopehsrg
 gthhhinhdrshgrgigvnhgrsehngihprdgtohhmpdhrtghpthhtohepshhhrhgvhigrnhhs
 hhdrjhgrihhnsehngihprdgtohhmpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnh
 gusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:KWgpaR4zP1O3Ru6DJfJQZoA8YrFyrA6QjhmD17HR-8yNcvncHPaczg>
 <xmx:KWgpaXUSQab7yv32RfmVxirZj5fDo63253IikvJNV6Vd09qjhWTbhw>
 <xmx:KWgpaY5pE56UiQ_FDQbxwmt9HrC7SIk7HYGCs5LgsioXqpexmy8sig>
 <xmx:KWgpaapUd5hYOELPm7TGoazdM735Y_QAOiuL3hMdy4hXSjmtbGvOUA>
 <xmx:KmgpaQRXVmvloBTkRZViBiQPse7enX1hNWbJbDac4i-CJUI-WTKRQEOR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 04:15:20 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH] bus/fslmc: fix warning in device scan
Date: Fri, 28 Nov 2025 10:15:19 +0100
Message-ID: <5843664.GXAFRqVoOG@thomas>
In-Reply-To: <CAJFAV8zuQVd_z5mKOC3x0VmE9QFGXG2REgaeBH4eVm=wxcFHMA@mail.gmail.com>
References: <20251125144610.37661-1-stephen@networkplumber.org>
 <CAJFAV8zuQVd_z5mKOC3x0VmE9QFGXG2REgaeBH4eVm=wxcFHMA@mail.gmail.com>
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

28/11/2025 09:39, David Marchand:
> On Tue, 25 Nov 2025 at 15:46, Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > With latest glibc (Fedora Rawhide):
> > ../drivers/bus/fslmc/fslmc_bus.c: In function =E2=80=98rte_fslmc_parse=
=E2=80=99:
> > ../drivers/bus/fslmc/fslmc_bus.c:298:15: error: assignment discards =E2=
=80=98const=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarde=
d-qualifiers]
> >    298 |         t_ptr =3D strchr(sep, '.');
> >        |               ^
> > Fixes: e67a61614d0b ("bus/fslmc: support device iteration")
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
>=20
> This build warning can be seen in OBS builds.
>=20
> Acked-by: David Marchand <david.marchand@redhat.com>

It is actually in device name parsing function.

Applied, thanks.


