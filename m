Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE9FFEFB4F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 13:43:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2B57402C5;
	Fri, 27 Feb 2026 14:43:51 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id ACCA74027F
 for <dev@dpdk.org>; Fri, 27 Feb 2026 14:43:50 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 10710EC0AFB;
 Fri, 27 Feb 2026 08:43:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 27 Feb 2026 08:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1772199830;
 x=1772286230; bh=HXv98A8MhSEq5NGWzd3EEGuai2lcfnwvPTJb6aSa2Gw=; b=
 brJgsTuffvX6/1Bx65yukX22vm2WAt1q3KPeunThnu/QX90xGmUX/x1j8zejPUL2
 M7SF/cZ6j2CXQW2ShaJRq7s6HuzFM+zRKWvIX5zQLIZPj19gzFoIScq+BHZVTnME
 /J7TU/CCBTsdSZA85zL/IEksU1RE0pEK2jmbc9n3fITrdNLtif/aXhTLTWgzHYYe
 9lejnsM9J6dIPjNXXcEflXMUEnLPsRb5s2OIVGBkNltEldDS57oNJXjgPAKqUUud
 ElkWyqQG0v+bZW6yhsusY4hJqS0QZUEsq69ndUisdaa1V77nEGUsgxyWqhFkkVF6
 5gmPXPW9rMbyohqny9NJhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772199830; x=
 1772286230; bh=HXv98A8MhSEq5NGWzd3EEGuai2lcfnwvPTJb6aSa2Gw=; b=h
 0dV7KorKvuxlhQNRHrqW2MrJydWVfOj6DHUHnMRTGCvhOs+7MEE2nRK0f+DOkPa5
 yg8zNY0A4qO5fYI002WyQA3KUh/yPfHncFM6JcuT9LLXL1d802TMTgkTNe8+xJ/w
 c9tfWibP42zjH8YBgc/cL+5KlBggWR4wZt4VBMtB18rVf7bfliCC52fsjE/ty/hZ
 Bnpn5YGYyxIPxz7ciHhfCdUoPm7E3kwtg1F6YK25zI6nyBh4uj0Gbv/B4YdvIMUG
 RiPV+Xpik9xfbQfXnPyhe2NzOD/RZool9G8GliFcpv1Q8RAklyrgPB26PtDtdY7R
 5dIuHtG8x3qN5rB19gj8g==
X-ME-Sender: <xms:lZ-haaLFXciCmc6rzW7xILG427r8XhdRegO78BtfBKOF3QnMmCJr8w>
 <xme:lZ-hadn_aouTye6tYQ8bpG3eixXcOQZtiGmQ9YfCQwgCBL7A7YAP0MPdKca-fKO8-
 oTFsngeg_z144HVusZ_jjsCFCtEaZf7Z67kmkUj6xS33PwUXo99vwg>
X-ME-Received: <xmr:lZ-haeP4YhCWjGNWnHLhYG4ltJLjdTbT3OXkMEYpMKvtYqJs5lLgIeUpL9NIAjlkYM1tpcofAOucEnYVV6dFmd9CKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeludehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrh
 gvughhrghtrdgtohhmpdhrtghpthhtoheprhhjrghrrhihsehrvgguhhgrthdrtghomhdp
 rhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegrnhgurhgvfidrrh
 ihsggthhgvnhhkohesohhkthgvthhlrggsshdrrhhupdhrtghpthhtohepsghruhgtvgdr
 rhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:lZ-haT3RMExx_dM48gvXvBzIJRk3T0BowsORLLuGcPr4-CaILIII-A>
 <xmx:lZ-hadl3FLr6JfVJwcAJ4pKPfZmSs21GzopOXcpMf6H5R5Uz3mDI6Q>
 <xmx:lZ-haaUnEc62LQzYDdBRIZzDMRCr5fmWWUtu1W0u1hOLiNZkY4-ePg>
 <xmx:lZ-haTvcHf5Op7LultcEnOu9wusdxiXzDch3gMHazW9HaDbQCu_DIQ>
 <xmx:lp-haWYoPjjAV9HgrFvOMDtZdYfh4drP2SoNyaMSOj2JqskJYLFz568Z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 08:43:48 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>, Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce <bruce.richardson@intel.com>
Subject: Re: [RFC v2 5/5] eal: configure initial device probing
Date: Fri, 27 Feb 2026 14:43:46 +0100
Message-ID: <4506449.8Dcp7MaWsk@thomas>
In-Reply-To: <DGP1R1WJWJGI.1TU6RUU13GBYQ@redhat.com>
References: <20260225112922.3982104-1-david.marchand@redhat.com>
 <20260226162057.207202-6-david.marchand@redhat.com>
 <DGP1R1WJWJGI.1TU6RUU13GBYQ@redhat.com>
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

26/02/2026 17:50, Robin Jarry:
> David Marchand, Feb 26, 2026 at 17:20:
> > Some applications use port hotplug as their primary way for using DPDK
> > resources.
> > Having a systematic device probing is a problem when not all available
> > resources will be used by the application, as such applications won't set
> > an explicit allow list at startup.
> >
> > This is the case for OVS on systems with multiple mlx5 devices:
> > one device can be used by the kernel while the other(s) are used by DPDK.
> > In such a setup, the kernel used device may get reconfigured in
> > unexpected ways and trigger issues like the one described by Kevin
> > not so long ago in bugzilla 1873.
> >
> > Add an EAL option so that we can change the default behavior from
> > block-listing to allow-listing.
[...]
> > +	const char * const argv29[] = {prgname, prefix, mp_flag, eal_debug_logs,
> > +				       "--allow-explicitly" };
> 
> I am not convinced by the option name. What do you think of:
> 
> 	--no-autoprobe
> 
> That would match the Linux sriov_drivers_autoprobe sysfs.

The name --no-autoprobe is better indeed.

The exact effect of this option is to disable initial probing
of devices on all buses (except vdev).
Another name could be --no-initial-probing

I think we should add the opposite option as well
to allow changing the default mode later.
For such an option, --autoprobe looks better than --initial-probing.

Other opinions?


[...]
> Depending on what option name we settle on, could you add a short flag
> too? E.g.:
> 
> BOOL_ARG("--no-autoprobe", "-N", "Disable automatic probing of non-blocked devices", no_autoprobe)
> 
> Or:
> 
> BOOL_ARG("--no-autoprobe", "-P", "Disable automatic probing of non-blocked devices", no_autoprobe)

I don't see the benefit of a short flag.
It makes reading commands less obvious.



