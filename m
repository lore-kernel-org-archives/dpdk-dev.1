Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B460BCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 12:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01D1C4026A;
	Tue, 11 Nov 2025 13:17:38 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id B3D6D40144
 for <dev@dpdk.org>; Tue, 11 Nov 2025 13:17:36 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 25F1A1D0014A;
 Tue, 11 Nov 2025 07:17:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 11 Nov 2025 07:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762863456;
 x=1762949856; bh=bez4D7t6ASp4SEBXgmfpbOo3PbpxR21jPTrePhAsPmU=; b=
 ga0Sg818wArS8lfICOxExwpoT5IEfbkcdlUgh4zjVepu46TNdPNI2yVZR/6bzm5C
 ZIsqTn5dvMtKQT3KnyM1jNtA8zv/YNC7zlIqGm6EzvB1DMD7POB27al35e4Jad4r
 Jmsj08mNG7VYAcDeiUF206I6TRHyN6HP544PdbRGPiZ1kYrNz3YyIfnTVqlKjstk
 7fv1Z5l2kDr+LbMHFUi+Boe8w3zli1KibU7tv9/vs+k8/IqDMEq9gktTYLmWALqM
 FZmLw8UkiWS1tL2GR1zVeTLwQFHNpPH0tcp3ONAcCgdaz5Va7UlcrH0VESdFr1/v
 BBy3IOiIP9InRna+USSNnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762863456; x=
 1762949856; bh=bez4D7t6ASp4SEBXgmfpbOo3PbpxR21jPTrePhAsPmU=; b=d
 Xjxo1SZpgFy2CcYJw09p4zhmgwkO7aar4uG0RfJ5F8mdFX0PBuwlw1JiM9UJFeIT
 Z0mk7FF1vCtwUYkmdAVYjBEaGbgxK2gh+t2GgV4LkjHCnJ7xw+mYMcQ4Yr07SxYb
 WSXC8Iq5SgK3oPj5ndM9Hj2sO12sIzzmPOI8Jhye2U71YAqVBOARvE1jaN3NKBGq
 lipcHz7RA9jfhd5dfPhQzbkaU28IRXphV74mQkyWin6T93HiIY3c9HWpwpyTnDi3
 tz0JfjrvpApwl9xnWu88L3qZC/QGrDuVA7mPYgc75W6l2Cp2EiOFTeajEDvAfQTK
 7iiOhAbRI2UjTTJ8giZig==
X-ME-Sender: <xms:XykTaanvQ5tdRUpB57tOx1W05JtlbtpoJERADUqzalR8KOOMiQ7NGQ>
 <xme:XykTaeLNtWQbIiVwBI_aE714UG5KEQ-VNNcASd779SQrXJ6ORbUwE2Ab32MT4MbCX
 1BgtvSXpRXQkq0rRf28vxXDFB0YNZ99DH2OI7b02CkqPOeDvDIoLQ>
X-ME-Received: <xmr:XykTaba-uA9NecG6zVmzWDb6_UY9oNpMmmfCnJYKA9CN_TWRfxPRbR3TfiaSfXGEVZBjKcScvjPQCYrLMtbIM9xXaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduudejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihsh
 htvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:XykTaQZXXClFgVfXkr-DK25rkfRqV01PB_ZWXG8rJh5_LHU3roAJEw>
 <xmx:XykTablnUTQK6qX9n397D3d8IP5Q9JDjA4Ckz8T0pPD6BB5XSmgoVA>
 <xmx:XykTacyoP55-tHwsPcNd1MJhQQruZYEHlYqS-3g2LOlHHerJ1PyBng>
 <xmx:XykTaZOkmAAjHVzVtf_SirHqXRxqQi00bSXo-4FFqkiSgNLGTfJUtg>
 <xmx:XykTaWHUyU0jY2few9KlKyUEUYTwBN-oFgTHgCayftbTjEmLNjQZh0lr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 07:17:35 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] mbuf: improve mbuf comments
Date: Tue, 11 Nov 2025 13:17:33 +0100
Message-ID: <11157846.ICPdZLu4VQ@thomas>
In-Reply-To: <20251107143629.612723-1-mb@smartsharesystems.com>
References: <20251105112810.20838-1-mb@smartsharesystems.com>
 <20251107143629.612723-1-mb@smartsharesystems.com>
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

07/11/2025 15:36, Morten Br=C3=B8rup:
> Updated the comment preceding the 'rearm_data' fields to reflect that some
> ethdev drivers don't really set the rearm_data fields on Rx descriptor
> rearm, but rather when pulling the packet from the descriptor.
> By doing this, they avoid a store operation into the mbuf when they rearm
> the Rx descriptor, and instead postpone it to later, where it will be
> combined with other store operations into the mbuf.
>=20
> Updated the comment describing what the second cache line is used for, to
> reflect that there are exceptions, where some fields are set on Rx too.
>=20
> Updated comments describing what needs to be updated when adding new Rx
> and Tx offload flags.
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.



