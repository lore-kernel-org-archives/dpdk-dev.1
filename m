Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D158106B53B
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 13:38:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F141402CE;
	Wed, 25 Mar 2026 14:38:03 +0100 (CET)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id A06E74028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 14:38:01 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 20A8F1D00150;
 Wed, 25 Mar 2026 09:38:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 09:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774445879;
 x=1774532279; bh=2fEkTZvPOqppR3niGqYQOxj08U1bZW/OstfhQdMLc+w=; b=
 NmW8P3C9ZtQVcw4ULeEJ1YMax45XvdmJh1xNgjI1bz3e8WYHCMmUBHRlLca9JgWM
 mRU5LdzwYmUUL4LrIcMj2Pa+Gl5d5iyudGN0DY7w8m8WmP8JpUpZnvbD9qjkmp8g
 486FGo0FDpPX1HUW39biL3VEgEzEFIbFmLzWbAs72YZ+/v+oDJubzbbHNy4kSyDn
 BEW9x0zXO6eC5uXiXE1Y9lg3PMKRZKMbWk0KkwyfsiGRy4w6xCnqP9bUhfNnKZmE
 u8lV9LXjQu0qV+uqXoFu6KE9dYYEWblUhg01ldZAi16Td/eXLMKbpeh1z2ZLu8V6
 Mx8OFeM8eTY/bbsy8+HGUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774445879; x=
 1774532279; bh=2fEkTZvPOqppR3niGqYQOxj08U1bZW/OstfhQdMLc+w=; b=1
 oPLF+jHN8AYmz+RnVoY53xtL0iMeQ9coADP6XotTwgZgsRT7JaGx0LQ+hCHEfnei
 9S/I9qNinMOdhOgyMyhMi9v7kjJlTUiOSbCLZujwf5bELXn/NkV3/YrJlEQOEKFr
 LQg6S0QS3Whk7ZnBOZ6e4hUpMq3S5cJ1ux7aJCisEccM+s40JLYcR+giMByReopU
 CEzcNJ77SZrOC48hnC56HNY/rYxw6GPSGBRKffYRdmKYkKCIszuSxF2WntZuskI2
 euhc58eipCuvj7xTA+0jMGoIX6TGIftpztI3aYBpmh0+E9tRanWKvGMuJHHTSzXa
 +20aRkSSs1rwIrFqiFNew==
X-ME-Sender: <xms:N-XDaVO6QizmHbgvVRDjr7shoVpRytomCjRru6W5W2Ch73iq6izVSA>
 <xme:N-XDae-ngu31rKSTWT_H4g0pnEb5fNudwkPYY6S6Rq9dpcaM3Ld8MIL6VMAbJB_M0
 krzA12fLdiW6RcbWhhmfNKdRLAzw3rWliusq9GYz_lONQMS5LQprw>
X-ME-Received: <xmr:N-XDaZRIwAMpIKg1DjnF0D2cJAbTEKxbl7onf9mxZnT1GsZ4QZcrpBrl_H4BNigkITqG5UdF9ZCXhczBzX_-915qJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegiedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeifrghnghhfvghifhgvihegtdeshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgs
 vghrrdhorhhgpdhrtghpthhtohepfihffhgplhhighhhthesvhhiphdrudeifedrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:N-XDaQnto3Pi2_XGiFTfOjEoG71TvJPp-sDTDurfQVZuANjmWlh9RA>
 <xmx:N-XDaZQ4T4MMdw2l5Wcls5wix32E1XkK-u8c0nknUTYNHfhTm4fgTA>
 <xmx:N-XDaeNcluSC_mMBJE_m4UOFVA616vHTVzrETbLcBFgZ0vP2FkU1yQ>
 <xmx:N-XDaSWSqG6z8NsPX1xKHNrzvQmX_Pijnc2uD5P3NWLh_L8jCEq4Mg>
 <xmx:N-XDaWMSkfzYPsw6ad8ibHjRnAFhbPo7OlXybSjuz1_VZkFPUhDGlywU>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 09:37:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Feifei Wang <wangfeifei40@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Feifei Wang <wff_light@vip.163.com>, dev@dpdk.org
Subject: Re: [PATCH v8 0/7] hinic3 change for support new SPx NIC
Date: Wed, 25 Mar 2026 14:37:57 +0100
Message-ID: <4112223.CQOukoFCf9@thomas>
In-Reply-To: <20260324074236.613d2f1a@phoenix.local>
References: <20260316134335.1640-1-wff_light@vip.163.com>
 <20260324015516.201-1-wff_light@vip.163.com>
 <20260324074236.613d2f1a@phoenix.local>
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

24/03/2026 15:42, Stephen Hemminger:
> On Tue, 24 Mar 2026 09:55:03 +0800
> Feifei Wang <wff_light@vip.163.com> wrote:
> 
> > From: Feifei Wang <wangfeifei40@huawei.com>
> > 
> > Change hinic3 driver to support Huawei new SPx series NIC.
> 
> When merged did small changes to Subject to resolve check-git-log
> warnings.

Compilation is broken in the middle of this series.
I'm checking if that's something which can be repaired.


