Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B207FC71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 10:01:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4ABE42D35;
	Wed, 18 Jun 2025 12:01:50 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 915FF42D26;
 Wed, 18 Jun 2025 12:01:48 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 3B2C5138025F;
 Wed, 18 Jun 2025 06:01:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Wed, 18 Jun 2025 06:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1750240908;
 x=1750327308; bh=Pp/WVLXgeZlRSNTxi5pglTUuo2zfATEHqbplEx5+Em0=; b=
 XaEjfthfz69rXxYl0rjgmGnYpnxdZ5bPXYBXlG6bhE/L9VKs3YvWbCZagyHe0BfF
 1K6roWqE3yrH7qtXWXxRBGpu68pDkEfMTl/7fwh+vp646W6L9oasz7ig8LXgvDjp
 EBFj2IC64wMWmK36xf7N6YkOCu2NV+nHes6p1P72z7ejA4DuDthtUOoySJ7ZS6Hc
 Zwx4nLQXl85Kul7TnbUEUJrNHcaK7U3AZR/3HmjGjROh47H6mXhqRKA8UXfB/BQe
 xeajqm3qiV12lxIggTCIvBL2CgnjGGfHZliBh/dynujpyqbd//9ZIMDD2R0+UtsI
 TkK8Z2857tBIe3Mm+eJQ6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750240908; x=
 1750327308; bh=Pp/WVLXgeZlRSNTxi5pglTUuo2zfATEHqbplEx5+Em0=; b=p
 Fwm6oF2YXIbnxr7WUcG1VaYhuN38KtgSu5dPmZ3S46eMyATpIdRqMTwInjX8hO4o
 3kI+7Sh8FobD3ocij1FG8LB46dc3lEj8uSWs9Hhg9ZbNRHZrSU8i5dDiB+wZLpSi
 RJKw7I1ki0ILcmK8INVXpuJoIrbJY1Q0VuAA/XIxPcqenWgK9WajCkMQEII1tb5v
 ncqJIgo3A1b5zCQvasY3Dr+a6RUmc2zkfDR0J3kWSYXKt27iBZeZX4BsGzQ6c7YG
 k1zXPSus/Ny4QJEGuRe3vrRr7+9aKHxgm0MLjLD2C5kablrlujbUpCl31aaPDy32
 5lSYYFoKoQwXpb7rAvB/g==
X-ME-Sender: <xms:i45SaISPiz5xLFGsHuC9tzM90B0js11U6ao8mPWyyD9hz2H8YVHaNQ>
 <xme:i45SaFzPAhKs2ZeSyIht4XUc4YMhCyhsMhJKW989cbdnUalPZVDd4jg_TrAoWgVG2
 Jy_iwT9LXeQtEyNbQ>
X-ME-Received: <xmr:i45SaF1Krxnl6NlbL7C50ZjrpXxMtQmi3BJcKIt31rFYwSyJukIW1PSsl5e_CYmfdk9LS6YV9lOCyl1YJhftKhsvgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpefftdeuhfehvdekleelveffvdelhfel
 hedvgedtvddvudeuieevtdfgjedvudegfeenucffohhmrghinhepughpughkrdhorhhgne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhm
 rghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmh
 htphhouhhtpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgt
 ohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepthgvtghhsg
 horghrugesughpughkrdhorhhgpdhrtghpthhtohepthguuhhsiiihnhhskhhisehmrghr
 vhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:i45SaMCjEeV2wG3OtVDZ9bx9GoETW6fO7rsJ2qmCqjXGEQGvoUafiA>
 <xmx:i45SaBj95BLs3VlkXtotTShCpBZu6geUXbubZap8y4PjpZH677nMgw>
 <xmx:i45SaIrv6WmUqwO4WJvb4KS7Necwtmpz3ui9sNUUOtt9yjs-DNm-XQ>
 <xmx:i45SaEiLpjcqjGb7aRT2QTbPEqDGzEA4C8bATc1DlAhAiH4lDFX6CQ>
 <xmx:jI5SaN7M4oHv6sdpRPx_jk1_DNr0nhgRYdSg737rikYax9_APtIPJkMI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 06:01:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, techboard@dpdk.org, Tomasz Duszynski <tduszynski@marvell.com>
Subject: Re: DPDK libs as one big shared object
Date: Wed, 18 Jun 2025 12:01:45 +0200
Message-ID: <45747073.doPnVEEUbh@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD09@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD01@smartserver.smartshare.dk>
 <98CBD80474FA8B44BF855DF32C47DC35E9FD09@smartserver.smartshare.dk>
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

18/06/2025 09:39, Morten Br=C3=B8rup:
> > Why are we still building one .so file per DPDK library, instead of just
> > building one big dpdk.so for all DPDK libraries?
> > I think it's legacy from when DPDK libraries were versioned individuall=
y, and
> > thus not relevant anymore.

I think it helps with selective packaging.


> > Wouldn't building one big dpdk.so eliminate the problems with circular
> > dependencies between DPDK libraries?
>=20
> Obviously, the source code should remain organized as individual director=
ies per library.
> I'm only suggesting linking them all into one object, so any DPDK lib can=
 call any function in any other DPDK lib.
>=20
> Perhaps only the core libs or always_enable libs should be linked into on=
e object.
>=20
> Here's an example benefit:
> I'm currently trying to convince the PMU lib author to make PMU depend on=
 EAL [1], so missing error handling of sysconf(_SC_PAGESIZE) can be in the =
EAL for all uses, instead of copy-pasting sysconf(_SC_PAGESIZE) error handl=
ing to everywhere it is used.
> But this is difficult with the dependency chain for the patch adding PMU =
to Trace: Trace depends on PMU, and EAL depends on Trace, therefore EAL dep=
ends on PMU.
>=20
> [1]: https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35E9FD08@sm=
artserver.smartshare.dk/

I don't see a problem to copy-paste in the few libs not depending on EAL.

The real solution for EAL dependencies is to split it more.
The malloc, init & logic part should be in separate libraries,
depending on the real low-level EAL.

Then all libs could depend on the low-level EAL,
and avoid copy-pasting.


