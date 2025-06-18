Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D3BC7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 10:04:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3408B42D28;
	Wed, 18 Jun 2025 12:04:44 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id CF05742D26
 for <dev@dpdk.org>; Wed, 18 Jun 2025 12:04:42 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5B48511400EE;
 Wed, 18 Jun 2025 06:04:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 18 Jun 2025 06:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750241082;
 x=1750327482; bh=naT5+9J4qm7QvFP4ah/ARNgReu8+CpGrwbBRj+prij0=; b=
 dw9vyMiWLUCzAOze4V1PXpKURDq0FbY0m42D5SMNxwV6LuHZlOFjGUdjBxNnCF36
 eyhfjJHg9jOX1RYEd6e1vjfxQWgPM8fgd0MIlhDzt+lSDZ8NerILxQldCb5j9Rjs
 rWavDBcEPiHjHwZFUJJ/GdAZqQ0kRYFDfOrTzTgOUfa+lK+jO3V+IJY+blsZWoL/
 f+lvM5mhAa6GfbYN+fJwYUmEPSeuog6QxR4PsWnuBlZu8NIiwOpTmD8xgSTdiswr
 1yLxN/+aS56W7yNNpZZxhaoPIOOVufh+WxurAWSE+XZZaaHxi+qEX2KE1uwSn38H
 Ky2H0jDvaHzSZNcfkLNm/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750241082; x=
 1750327482; bh=naT5+9J4qm7QvFP4ah/ARNgReu8+CpGrwbBRj+prij0=; b=N
 8pN0SHINXOTwfj0anwbIdo06ErlVtmO3wnCOXkyMf6JRcPGEQEEdifXaGmPLqD5M
 9n6butFd0jd1BlRw/19q+1ST/kNstJ2LcNJ52lI7if5t/yDafxX4Is1bSlwWOAc/
 XN+GU4NTcrr8VkSXqeuZRkTVSSslKO4QcxRG+xB576Y86+K1uXwT4T/5rbFh4AW9
 eg7wxSxD9sw/if4fzSmWhraT4TjQ26No6DxJzvIdTltcW0v8aSCu+Yunc7k+B/Q8
 WVMhxQi0kqJY5sDekTl/AkKDJkAuNxn41nR62pLru8Ne6iAY5dZDGvQLBvifsuxd
 pc2yYzGn6ZNAIu8sd8rRw==
X-ME-Sender: <xms:OY9SaDrf4-mwXh8XAf2T4Jm5TRsVVXpYOflu-9ug_uTo9g9TsTg6ng>
 <xme:OY9SaNpDAq6tZB5dhYYtCkZmr4SAowdJnb9_UH0huuZab5btFDldnF_hjUC5jUC9O
 45HfeRHfSw9hVsvwQ>
X-ME-Received: <xmr:OY9SaAMYRbA3SclrDXBpt7Te-Y1IRT9ykAUGVbpnXyIMD4BlFHo-jRRKvuwMlSU9gu9MqohVT51Oe23oYcHVfLdnoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpefftdeuhfehvdekleelveffvdelhfel
 hedvgedtvddvudeuieevtdfgjedvudegfeenucffohhmrghinhepughpughkrdhorhhgne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhm
 rghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtohephhhofigrrhgupgifrghnghesrhgvrghlshhilhdrtgho
 mhdrtghnpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmihgtrhhoshhofh
 htrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghr
 uhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvh
 hiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:OY9SaG5XpSLfSElxuPOh-469JTgWYX_yDukYTgFXyA1xqglBRQMp9Q>
 <xmx:OY9SaC7Snob2ETua9vVv1YkwtkstgeewZ-yUt98a-LDeeXf_PDrRqA>
 <xmx:OY9SaOhtwyl0AbKlknE2eH9gswc0ogDY78PEPgKGHZnAgtcRrfeRMw>
 <xmx:OY9SaE7NcVFnT-oKvPxOq8V_9X86ffqq_thRilIdbRMTEjRaQIoGUQ>
 <xmx:Oo9SaGUZdYN45PVG0ky6nDOY4JBUswjUL4o8To8NvRFpl-ZEPF8NvJNI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 06:04:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: =?UTF-8?B?546L6aKi?= <howard_wang@realsil.com.cn>
Cc: Andre Muezerie <andremue@linux.microsoft.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, 
 David Marchand <david.marchand@redhat.com>
Subject: Re: =?UTF-8?B?562U5aSNOg==?= [PATCH v3 2/3] drivers/net: remove use of
 non-standard array range initialization
Date: Wed, 18 Jun 2025 12:04:39 +0200
Message-ID: <3903882.R1toDxpfAE@thomas>
In-Reply-To: <1d5377af85fe4025badbf8b717a8a877@realsil.com.cn>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <5034944.6M6d0yLqnL@thomas> <1d5377af85fe4025badbf8b717a8a877@realsil.com.cn>
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

18/06/2025 11:37, =E7=8E=8B=E9=A2=A2:
> Dear Thomas,
>=20
> OK, I will update this part in the next code refactoring.

Thank you

> By the way, I would like to ask how to resolve this error. From what I ca=
n see, it does not seem to be related to the patches I uploaded.
> https://mails.dpdk.org/archives/test-report/2025-June/886815.html

We are working to resolve the Windows errors currently.
We'll have to re-run tests on the patches when it will be resolved in the m=
ain branch.



> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Thomas Monjalon <thomas@monjalon.net>=20
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B46=E6=9C=8818=E6=97=A5 =
17:25
> =E6=94=B6=E4=BB=B6=E4=BA=BA: =E7=8E=8B=E9=A2=A2 <howard_wang@realsil.com.=
cn>
> =E6=8A=84=E9=80=81: Andre Muezerie <andremue@linux.microsoft.com>; dev@dp=
dk.org; Bruce Richardson <bruce.richardson@intel.com>; David Marchand <davi=
d.marchand@redhat.com>
> =E4=B8=BB=E9=A2=98: Re: [PATCH v3 2/3] drivers/net: remove use of non-sta=
ndard array range initialization
>=20
>=20
> External mail : This email originated from outside the organization. Do n=
ot reply, click links, or open attachments unless you recognize the sender =
and know the content is safe.
>=20
>=20
>=20
> 16/06/2025 09:37, David Marchand:
> > On Thu, Jun 12, 2025 at 4:18=E2=80=AFPM Andre Muezerie=20
> > <andremue@linux.microsoft.com> wrote:
> > > diff --git a/drivers/net/r8169/base/rtl8125a_mcu.c=20
> > > b/drivers/net/r8169/base/rtl8125a_mcu.c
> > > index 5a69b3e094..c9bf5fc6ad 100644
> > > --- a/drivers/net/r8169/base/rtl8125a_mcu.c
> > > +++ b/drivers/net/r8169/base/rtl8125a_mcu.c
> > > @@ -162,7 +162,13 @@ static void
> > >  rtl_release_phy_mcu_patch_key_lock(struct rtl_hw *hw)  {
> > >         switch (hw->mcfg) {
> > > -       case CFG_METHOD_48 ... CFG_METHOD_53:
> > > +       /* CFG_METHOD_48 ... CFG_METHOD_53 */
> > > +       case CFG_METHOD_48:
> > > +       case CFG_METHOD_49:
> > > +       case CFG_METHOD_50:
> > > +       case CFG_METHOD_51:
> > > +       case CFG_METHOD_52:
> > > +       case CFG_METHOD_53:
> > >                 rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x0000);
> > >                 rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x0000);
> > >                 rtl_clear_eth_phy_ocp_bit(hw, 0xB82E, BIT_0);
> >
> > I don't have a strong opinion against this change.
> > The driver maintainer already acked this change.
> >
> > So just some comment, on the form.
> > switch() here does not seem well suited since this driver code is=20
> > validating a range of values.
> > if (hw->mcfg >=3D CFG_METHOD_48 && hw->mcfg <=3D CFG_METHOD_53) seems m=
ore=20
> > robust and is easier to read.
>=20
> Yes I agree with David.
> Please could you fix this code to have simpler code with some "if"?
>=20
>=20
>=20





