Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20438CCF9EF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 08:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35AD340262;
	Tue, 28 Oct 2025 09:28:12 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id B090D4021E;
 Tue, 28 Oct 2025 09:28:10 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 2FECCEC049C;
 Tue, 28 Oct 2025 04:28:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 04:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1761640090;
 x=1761726490; bh=kflyvQR7OfWLF1X0eVIXwObt8Wk+DAhwLeA59ZCJd1g=; b=
 Bleg/8vfmGYCx+C6SLOywdSAfvMEmQR8WJfTOef17GeEmw2XWpqjPs3JZBKO0/n8
 sBixLmUbBuSxnVYoNx7LrVE5kvtyGFBR4JeBhlLYSwD5lDHu6GnwiAGEJJz3/U/N
 QAefl2q9PbCGBvckdYaJRNlcPYdrdf+2L12yFjYSMvsjf5KfskOyue0tQLvgVLsS
 iER06tHj8caj0FZb07h1po9KPLOw5fcIn0NhOBN39lcNhnRyiFXIO59PELIx5c5w
 WKl+9kmZxlZ7iXvy7sPhz31B3vyAPRxSkRXybps9qqLJubLmwplwM6FCSKkiAkfv
 G4Sh2aX4VjoNKb9Xrt4Wsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761640090; x=
 1761726490; bh=kflyvQR7OfWLF1X0eVIXwObt8Wk+DAhwLeA59ZCJd1g=; b=b
 XJ8BPXS9Rjq9FxNS+6E0TVjS44IaqhcxT66pmDgQ9lVgdQUsr404Nrtce4Xl9RQ3
 Tg+IMD0Udhsalnk04MvMbohdWoGNPLukb7Lwo6VI8J+nBPIo0ArKYfRXvHjq/Kqm
 xPT8J7QVKjHmy4rWWAUDo9q1t1X9YqQ4DuyMzzf/TWd6rH8nvfkNc8xIBlqZswQ/
 QZlfhTzIG3V+83jqK9hCD42xYnb/4ncWorgsyMa/V3of6wg7T5QlTVBb0Cti4ns+
 rOuBxmcna70j4DEXRmI6Dp0zGh0aje2msdzp/z8gZp9Z1g36YVaXLFbmizS/hRqn
 p0QWNEXm0k/CxcSVwsE9g==
X-ME-Sender: <xms:mX4AaelRx4M388HqG__dBMaeTkwyJ5SdMmPaoMwyMIN7Fss3NYDSWg>
 <xme:mX4AaaIh2V0grxJTXckBCwiDIE6alW4iOfODLZmw3zMe3LBG7fUoXCFILLyw8D6M3
 c3Qk5OrREadR9ydFyIaHXCX8GenVup2o1dbxxoTml_53TqYqy4c>
X-ME-Received: <xmr:mX4AabyQl2I-szl56dKrsGQTaAZQWo-H5eHbKGdCSxMlYRO5JRZKP_eS9-j5236Q7fM_sbacBWnAYm_6sAx_gSwXJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtfeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
 hushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefufffkjghfggfgtges
 thhqredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomh
 grshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeeuleeiffejledt
 ueekleegudehheeggedvgedvheelfeejiedttdfgkeekvedthfenucffohhmrghinhepoh
 hffhhitggvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtoh
 epfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprgguvghlqddvrdgsvghlkhhh
 ihhrihesphholhihmhhtlhdrtggrpdhrtghpthhtohepuhhsvghrshesughpughkrdhorh
 hgpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:mX4Aaat_s00Le_4oIaQE1ubInaeO5i7Giw1qfZdVJn5q1qARWMj6UQ>
 <xmx:mn4AaSsGQ4rCWyqJJAhWc0ouVDEypluwYxn-yhJAtQKUCNVq_nuQIQ>
 <xmx:mn4AafPFgvhgv_vtAXpGipTgB1VDI68Jp2wbBCgziBDAbMs_AJOKIA>
 <xmx:mn4AaQ0W7O29H74bA-q6Sv-EdvHwhZ8ZPjDa6OJ6OpOPZRB7Bj6qjg>
 <xmx:mn4AaTUEJaPbgoDwO1T8YbjrjRXPa7t1edNBeebegXAzT27-tGp43wel>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 04:28:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Adel Belkhiri <adel-2.belkhiri@polymtl.ca>
Cc: "users@dpdk.org" <users@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: DPDK observability survey =?UTF-8?B?KOKJiDc=?= min)
Date: Tue, 28 Oct 2025 09:28:07 +0100
Message-ID: <4909502.ghgXmdF2J7@thomas>
In-Reply-To: <YT1PR01MB88261798F3919CB8AF4D68DB8EFCA@YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM>
References: <YT1PR01MB88265C8B9023D8653C29BCB58EF2A@YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM>
 <2720733.htQpZWrp2x@thomas>
 <YT1PR01MB88261798F3919CB8AF4D68DB8EFCA@YT1PR01MB8826.CANPRD01.PROD.OUTLOOK.COM>
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

OK, I suppose that presenting in a DPDK Summit would fit very well.

Thank you


27/10/2025 16:31, Adel Belkhiri:
> Hello Thomas,
> Thank you very much for your comment. What I meant by bare metal was actu=
ally on top of the OS, so you are absolutely right that the phrasing was co=
nfusing. I=E2=80=99ve reworded the question according to your suggestion.
> Regarding the results, I=E2=80=99m currently preparing an academic paper =
to submit either to the International Conference on Performance Engineering=
 (ICPE) or the Network Operations and Management Symposium (NOMS). I also p=
lan to share the results at the next DPDK Summit.
> If you think it would be interesting to share the findings here in the gr=
oup, I=E2=80=99d be happy to do so=E2=80=95or I can send you a copy of the =
paper once it=E2=80=99s completed.
> Cheers,
> Adel
>=20
> ________________________________
> From: Thomas Monjalon <thomas@monjalon.net>
> Sent: Friday, October 24, 2025 10:06 AM
> To: Adel Belkhiri <adel-2.belkhiri@polymtl.ca>
> Cc: users@dpdk.org <users@dpdk.org>; dev@dpdk.org <dev@dpdk.org>
> Subject: Re: DPDK observability survey (=E2=89=887 min)
>=20
> Hello Adel,
>=20
> 21/10/2025 16:18, Adel Belkhiri:
> > Quick reminder about our =E2=89=887-minute survey
> > on how you debug and observe DPDK-based applications in real environmen=
ts.
> >
> > Survey: https://forms.office.com/r/6zRAqxWYKj
>=20
> In the question "Runtime environment",
> I suppose "Bare Metal" means just on top of the OS?
> DPDK used to be a real bare metal environment,
> so I suggest rewording this question.
>=20
>=20
> > This will help guide open-source observability work (Trace Compass anal=
yses)
> > by Polytechnique Montr=C3=A9al, Ericsson Canada, and Ciena.
>=20
> Will you share the results here?
>=20
> Thank you





