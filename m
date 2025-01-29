Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFC9C0218D
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jan 2025 13:19:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51DE8402E4;
	Wed, 29 Jan 2025 14:19:17 +0100 (CET)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id A8AE6402AE;
 Wed, 29 Jan 2025 14:19:15 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 0892340270
 for <announce@dpdk.org>; Wed, 29 Jan 2025 14:19:13 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id 1B4AA11401AF;
 Wed, 29 Jan 2025 08:19:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Wed, 29 Jan 2025 08:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1738156752; x=1738243152; bh=GJhYqKUnx6
 eSMnoMTPbmttOVCZSvuGleM6Q+xMW+eJk=; b=LhspKZbeyjcky2+E2JV9o8tnYk
 JuBdxvprLKb4EOOkJ3EffvH7gwqtKz/t2sNwzUmd/KATiaXCCXv5aR5P53SlcNaQ
 t64fK6Fy2DoRBk1fvQY6X3FrBtuAAZvHt+8MiUWTTrc1apZjy0/dF+rJog1BWelp
 WE3X8i3r92W7m7KEt1bnN9cMk0qBiCtpajqcR89NDaLKgD1HeaO7+rVeSYi/f5zV
 ei/nCadWeFde1N1VcxnN3I6Kq0TwBH6sEPEtXlTOZ77THcFeWIJiagDjUk88zJCY
 bPBRFHiFqdU3gMPOO21MYDl/gRitXQrAOQ6EKjV4cUKZLQurMoAW8wW7oNIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1738156752; x=1738243152; bh=GJhYqKUnx6eSMnoMTPbmttOVCZSvuGleM6Q
 +xMW+eJk=; b=SNvPhe8sCEZWFKAZQCOiF8A+NCemwIbqRaSRgexqC1oJjx+uPeZ
 yCwoVyGwxgym19fCTGcvuVHkLw3XcdoHKZLhPRl4f/offb6JAQR435Mop7b6koPt
 4B7Nv66dSEm/cMHV6KWX6I0y6E5rHHsAJXHD+F+TYlcXAz2KbXaYKXvuzFtTAGP/
 ZQZquezNjn0r8Ak/vMX31IBaC4DGxGqAtCgqfCETMdkRGGxp3WgwWTn9ufA7Bb85
 AgWJkuAvgaOgJof4SxRIHgv5ZOH0A4aWh7MeBvkNJ+bGm8kXa8oUJA8HaBMPG7u5
 Ur8XElUtAEHdLJs7Kb23/U1j8YJUelIPb/g==
X-ME-Sender: <xms:0CqaZ36y1wT8SpRnbRquUlviZas3sarrRH0ZoCDOBA2478Dsi7LYIg>
 <xme:0CqaZ85PUvKvqrXzWSXqNRsfT_HvsoBTnc8ThceCaD7JWPTL6-AW_pfVyzPGjcwEn
 sj0PqKHw9SYnEisLQ>
X-ME-Received: <xmr:0CqaZ-dmB05dBozV8mGeifN1LwyFpE0kphNfMh5XKBY5GpW-rV6ryYWCvbiZeiR03T4IujuPSXe_GZajM4qZD5mw5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
 fkggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcu
 oehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeehud
 eifefhkeekvddvveduffevuefgfeehleekjeekfeejkeehffdtueeifeffgeenucffohhm
 rghinheplhhinhhugihfohhunhgurghtihhonhdrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhn
 rdhnvghtpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopegrnhhnohhunhgtvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:0CqaZ4LGcVM0Xgu6B5s7YY_pc3bLo9Zg20cTvmnmTlPqsVgfiqBg4g>
 <xmx:0CqaZ7IV5rcYLh785t1G1D3pKmY_X9vfP3J6OGXNCuYnIMfg2A8vtw>
 <xmx:0CqaZxzFc-HA7F1dIqFAxi3J7MfdomlkEDUybZ592NV0qNxg9V0uag>
 <xmx:0CqaZ3Kmz3FfQm35OnS_o2k-Tyku8dGRAzl6M2tB0UtSJevaoBA41w>
 <xmx:0CqaZxhgFvb3wxgxYdVnC6CK8FTM60_Keu8d54dFIWWmQtniIPdciA_2>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Wed, 29 Jan 2025 08:19:12 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: CFP - DPDK Summit in Prague
Date: Wed, 29 Jan 2025 14:19:10 +0100
Message-ID: <2121297.K71DO8KEF6@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

The next DPDK Summit will happen on May 8-9 in Prague, Czech Republic.

The website is open for registrations and all venue details.
Follow this link to submit a talk proposal:

https://events.linuxfoundation.org/dpdk-summit/program/cfp/

There is one month remaining in the Call For Papers (CFP) period.

The DPDK Summit is welcoming anyone having an interest in DPDK
and the technologies used in fast networking.
This is a great opportunity to meet and discuss with the community.

See you there


