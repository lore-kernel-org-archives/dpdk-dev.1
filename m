Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A8CCD37B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 10 May 2026 21:21:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82D19402ED;
	Sun, 10 May 2026 23:21:12 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 2EDB040270
 for <dev@dpdk.org>; Sun, 10 May 2026 23:21:11 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 34DEB7A008F;
 Sun, 10 May 2026 17:21:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Sun, 10 May 2026 17:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1778448070;
 x=1778534470; bh=IrtIPnjzXGtXbxbCs57K1Lp03Az2LcptJmy6mq9AYXk=; b=
 WHD/fontJk6c3eb1BdoUajxh61NZ388Kz9NNjrRB5X07MtkxT69C2Gz2nszsXze+
 nz1uoCjCd8eQ3Uy1RCmA/qykJXnkLWzOL16+DkwjesooC7TVVjJFUWJeJumCLlcX
 duh8WD8V9V/4yERKKYdXGQC4gVeTFqHTC8rFU7Son/S4JWRSC6Mv49Ne5Sm/vnTs
 Sg2B/l25OeluZVMA6x/dTJVjZ+2R+PHBvDrgcEJz3Jt+cNtFhUfJWiXTZVXAULqj
 gduXGcHM6/e4v4sqtW/fZ9I3R/Hl0LeVDXm0/W74NMZYGpdOw8LcJY8uYxtw00mt
 rt5/cAkF5YXclz/ET5gr6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778448070; x=
 1778534470; bh=IrtIPnjzXGtXbxbCs57K1Lp03Az2LcptJmy6mq9AYXk=; b=j
 8Nka5vu6Zx9om/uRAMguaHxc2NidodHIhRMPU5UdNtT4FOEG7GFl+yFIiyGEQ92e
 tIJpT7RASKrbH1kYGSB2QH2QRaw/AeHCUvCFlcGNsTK3J7Ed30TSNFWrqo3vWV2H
 94db09R88JcB6CiGLXLRAeDEKdc21F1qA7+tCM20muOLXr1HgITuKqWJltmRMxkF
 F5gVoH5vxY4t1w1OaKZpdOL519ase440EJiiwdSENs3HSXpwNXqFMyssSOBFHHu+
 M+xuOtPIVZgv9C3SnlWSE+F1zizsnLW+4XVfD3ULifz7UTEtJ9G9XoXe1vcIjnpS
 G3eWB0O9zHniPu7PuZorQ==
X-ME-Sender: <xms:xfYAat82ep69i0fPDBFz5tSBQfdd_HNmWeV0-xR4D2u_8uYMczC-Lw>
 <xme:xfYAakSXnXGtkwrj_J6MNrzsvbk1Pc7o78dMnF6jDInVO73NxHMpEUQ2bfdiIXwt2
 OJGVUbv2a26qc-BQjy_h2rYE-duLw9oALv6XUNsguXC0fqvs1RZDg>
X-ME-Received: <xmr:xfYAaupUzueoSoEplpEvsUMPkr3U7UCZUqzNXvAf6x9oNXVSsvS82D5VMghlkt5XCEsoXUTq64bQvzArQt1tU-Q7aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejudejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehprghtrhhitghkrhhosggsudelleejse
 hgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhutggrrdhvihiiiigrrhhrohesrghrmhdr
 tghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopegumhgrrh
 igsehiohhlrdhunhhhrdgvughupdhrtghpthhtoheprggsrghilhgvhiesihholhdruhhn
 hhdrvgguuhdprhgtphhtthhopehknhhimhhojhhisehiohhlrdhunhhhrdgvughupdhrtg
 hpthhtoheplhihlhgrvhhoihgvsehiohhlrdhunhhhrdgvughupdhrtghpthhtohepmhgs
 sehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhm
X-ME-Proxy: <xmx:xfYAahkZaVQe7f0sd8CDaxi3-WbcEAW3xxJAOb37jJ0A_NQKhYWZOA>
 <xmx:xfYAandV2K_kPZRAhDMfM6JUmnJIkdfztZZ5ePhHMmjncKWqbcHttw>
 <xmx:xfYAatoDO0kLby_GA6_WtbJ62bT-jgwpWIfOF281Tgeh3sYnIQ-Okg>
 <xmx:xfYAahN8lZUAMnhTjzpCovfZBEueDqYvudWDQAW0qOOT-Q0Z44HB8g>
 <xmx:xvYAavYgCTsTtk24lBSWc_5wnvg_KUxrDI_O-wG5SYUwIxFL2DzUj426>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 17:21:08 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, knimoji@iol.unh.edu, lylavoie@iol.unh.edu,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH v2] maintainers: update dts maintainer email
Date: Sun, 10 May 2026 23:21:06 +0200
Message-ID: <_7F6G7tHTqKh5X2fMrC6UA@monjalon.net>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65817@smartserver.smartshare.dk>
References: <20260419194836.27602-1-patrickrobb1997@gmail.com>
 <20260427004643.14200-1-patrickrobb1997@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65817@smartserver.smartshare.dk>
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

27/04/2026 07:41, Morten Br=C3=B8rup:
> > From: Patrick Robb [mailto:patrickrobb1997@gmail.com]
> > Sent: Monday, 27 April 2026 02.47
> >=20
> > Patrick Robb will now make contributions to DTS
> > as an individual in his personal capcity. So,
> > updating his email in the MAINTAINERS file to
> > be his personal email.
> >=20
> > Signed-off-by: Patrick Robb <patrickrobb1997@gmail.com>
>=20
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied



