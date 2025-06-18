Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C630C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 09:25:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6F73427A2;
	Wed, 18 Jun 2025 11:25:07 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 5BD0840EE2
 for <dev@dpdk.org>; Wed, 18 Jun 2025 11:25:06 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id AE246138043E;
 Wed, 18 Jun 2025 05:25:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 18 Jun 2025 05:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750238705;
 x=1750325105; bh=PkWyt9J2TAAGWNxLO8j4nhUvxOrQFAtNXzW75WjBq60=; b=
 Er1RhwK1PJ8LeiC6LRyw+sdtjVSQt6VsvPJVurkiQVOJ0EyhbolGdYMIG0XWqUzQ
 k926B+ZRoxDfTS3Uqm84pbJHAO2rg+eEzB+i7ccKtZb4MAcjLaVkuQ9OrNJLWC/g
 yJVRzOY4GJ7H+PeoQu8qIwUn7cesikOKbcZNvFESf4Rl5z/JRVF3ZmxA2/xbWFsC
 KJkx9Z1QaSd9fOKjjTeBk6NMDV4JE4R9nFXth+KUtWTLhzOWHqVkVaV/bPEKMlr+
 tacTklsGqu4Z0I53l+PzCij1KReswqbmy+rn4PpOwrTpPzxcNsSigMJ29myftuQZ
 e04hPoRbvA4LBixX2B1eyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750238705; x=
 1750325105; bh=PkWyt9J2TAAGWNxLO8j4nhUvxOrQFAtNXzW75WjBq60=; b=K
 rNPFmntJqPjAh3DEgstTH6rsUfY2QmNuQtjkrhgwQY9l6wW5xbCq/+1FX1dKLNe7
 6g4PaP7vx0UTCmkIbvsKFq3Wsb15YK+ivOcaMgI4Ei0P8lDNeV/PsYXo00vUurPS
 f2WoIVIFO5iejThZiikqV2g9D3zq82bNtYH1/+yxKtbUpVSdlT/sGqlwTeFpmhnd
 oBNVtrnJNbMtNEzArltAR5O5knAaYEkned95aK62+aWNbFvWv1+hfKhWo5hxFSoU
 Jxoatwyzm/2ukqdEmPHdlaSThaG/ysBdGU9NG/6McOgCQhZsJitEOUMJdq0Mtmon
 QD7cMSCxwdb/rUklOvfCw==
X-ME-Sender: <xms:8IVSaEIMoqA6BdlSE1Beim__os-asjEyVRnWUPexoHAsVYnH86Ualw>
 <xme:8IVSaEKg0MzP1aBImrTHMtUqfqFnakmGrg0mzOF-wT14sPseKBX0BDHgMtCDgzufy
 c5HMwDXQxbJAruAyw>
X-ME-Received: <xmr:8IVSaEvgB5VBE0iFsU-_Ox0KMqHS3yk8gvw7RWwO_opcaH35oZthm2nLBs_W7wKzNptHAw5TLJ0KHGY6Hrn8RUgaOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedt
 heevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhohifrg
 hruggpfigrnhhgsehrvggrlhhsihhlrdgtohhmrdgtnhdprhgtphhtthhopegrnhgurhgv
 mhhuvgeslhhinhhugidrmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopeguvghvse
 guphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhesihhn
 thgvlhdrtghomhdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrg
 htrdgtohhm
X-ME-Proxy: <xmx:8IVSaBZO5ZtDn06wRBUStFVwqgoQ-LUEt5A5uPsCAO974v4RW5xC_A>
 <xmx:8IVSaLbHVbEymKGKuGXdd5ys-qib9UE5tuSmhjdH22BiYHNgcEE7qg>
 <xmx:8IVSaNAoogOCe1tSSfeyLxWUutXbVrFtOKXBQ6u-rIV7PPjUKwoicw>
 <xmx:8IVSaBbSE6_Xhv1p34cdlXw4KbEVAgkHXWJbC67pxBLI1kmT96_QNg>
 <xmx:8YVSaI0gTnD7WlJFNQDeM8m7ELG6dJPqGFz-Q723HjDZO0bP42aG5CAZ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 05:25:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: howard_wang <howard_wang@realsil.com.cn>
Cc: Andre Muezerie <andremue@linux.microsoft.com>, dev@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v3 2/3] drivers/net: remove use of non-standard array range
 initialization
Date: Wed, 18 Jun 2025 11:25:01 +0200
Message-ID: <5034944.6M6d0yLqnL@thomas>
In-Reply-To: <CAJFAV8yxnGmBKJhTQp3js4QObjwaySHxTS9MekSmwgkVkY9xdg@mail.gmail.com>
References: <1735243903-26857-1-git-send-email-andremue@linux.microsoft.com>
 <1749737842-30538-3-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8yxnGmBKJhTQp3js4QObjwaySHxTS9MekSmwgkVkY9xdg@mail.gmail.com>
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

16/06/2025 09:37, David Marchand:
> On Thu, Jun 12, 2025 at 4:18=E2=80=AFPM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> > diff --git a/drivers/net/r8169/base/rtl8125a_mcu.c b/drivers/net/r8169/=
base/rtl8125a_mcu.c
> > index 5a69b3e094..c9bf5fc6ad 100644
> > --- a/drivers/net/r8169/base/rtl8125a_mcu.c
> > +++ b/drivers/net/r8169/base/rtl8125a_mcu.c
> > @@ -162,7 +162,13 @@ static void
> >  rtl_release_phy_mcu_patch_key_lock(struct rtl_hw *hw)
> >  {
> >         switch (hw->mcfg) {
> > -       case CFG_METHOD_48 ... CFG_METHOD_53:
> > +       /* CFG_METHOD_48 ... CFG_METHOD_53 */
> > +       case CFG_METHOD_48:
> > +       case CFG_METHOD_49:
> > +       case CFG_METHOD_50:
> > +       case CFG_METHOD_51:
> > +       case CFG_METHOD_52:
> > +       case CFG_METHOD_53:
> >                 rtl_mdio_direct_write_phy_ocp(hw, 0xA436, 0x0000);
> >                 rtl_mdio_direct_write_phy_ocp(hw, 0xA438, 0x0000);
> >                 rtl_clear_eth_phy_ocp_bit(hw, 0xB82E, BIT_0);
>=20
> I don't have a strong opinion against this change.
> The driver maintainer already acked this change.
>=20
> So just some comment, on the form.
> switch() here does not seem well suited since this driver code is
> validating a range of values.
> if (hw->mcfg >=3D CFG_METHOD_48 && hw->mcfg <=3D CFG_METHOD_53) seems more
> robust and is easier to read.

Yes I agree with David.
Please could you fix this code to have simpler code with some "if"?


