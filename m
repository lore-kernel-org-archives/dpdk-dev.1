Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E7CF2591
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 13:44:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2891240270;
	Wed, 19 Nov 2025 14:44:10 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 0B1B740262
 for <dev@dpdk.org>; Wed, 19 Nov 2025 14:44:09 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 9ECFAEC0193;
 Wed, 19 Nov 2025 08:44:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 19 Nov 2025 08:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1763559848;
 x=1763646248; bh=TerkOK5sIupBN+0ElLn7Cqbx2ubFndeAHgqMfNwHjec=; b=
 k6SsagEaxUKBzz3v8QvBMigfNWoDd2T/vdpX/vGvJFMneD/s5iwdOawPLisvWFsG
 vCr05JNZfUzDvGDf89kylgCpKBZNOnGUWNjk7Bv7B+o/x1PbvLiQW4R/vYptcylR
 L9WZeE0j/MGS5XUhCc/C7d3dgC8Wq8cayNfqyQ6Mma4woszZbvpJThg3vt431DQp
 xBIk2QuJQMM4OQqcGkElQSvzo9rk648TwJ40JROSy0QqM9n6ta3RAg33J3eL8msY
 9VrMYRaMDA88NZRHAf+K9+2FpTRFWzbF9+70wN52FrbrIxZl0Lv91pSva6D3GPeK
 cq8X+hijUDoFDnZqp10nMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763559848; x=
 1763646248; bh=TerkOK5sIupBN+0ElLn7Cqbx2ubFndeAHgqMfNwHjec=; b=w
 RpulKxH7aQarQN5zEaihXEsN9OW6eAGf9OLm1euavEvaeD0AMG4qBp5VokycFffU
 TERc+7NKJKzKUCIUufJKIj16LFLWx519Ca/qxPbB+2KJWpjGyEpy1MU9uW53dzqH
 KfY1P6ruuHrA1DLs2oprsaXhKU0fP4Eq0F1AcPem2h9LAI9t8+t5EzC1j0Z5LABa
 Bqmr6it5sFrpOUQvzdLRKRMeKi3+Myj8HbHObYiWwXi2k9JTYiOjm+X5+1m/ba1S
 IQnSyiQSsp9o6y3/Vxmn53M9WgdJw+HQsjQKeVlz3U9XS3ja3NC1ghzs2fzmZAJM
 pYB2O1zcFMZHDEBRDx87w==
X-ME-Sender: <xms:p8kdabbjqN2UYrieFtnllThuJi0azOITs49Y7LOHLoZwdpLdUSgkpQ>
 <xme:p8kdaWRLK9SfZaLHPT7RBeuPGAdItZaowBw6-aowqMz7lHyLohCVH-YOtnw9A02Qi
 rbLMctea-y02cizhypRI0XckOD9utLB8erx7dEmH7n0ABvFtxnsif0>
X-ME-Received: <xmr:p8kdaa8MJkTTBc4JHBwmTPqXbmzsp0VgU0_8WFd6m6beHfDHECMe9S9MY4sdZ021Nz-UHeEzTLg_ZXBC_uF62lGRxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduvddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgssehsmhgrrhhtshhhrghrvghshi
 hsthgvmhhsrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepjhhirgifvghnfihusehtrhhushhtnhgvthhitgdrtghomhdprhgtphhtthhopeihrg
 hnghigihhnghhuiheshhhurgifvghirdgtohhmpdhrtghpthhtohepfhgvnhhgtghhvghn
 ghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopeiirghihihufigrnhhgsehtrh
 hushhtnhgvthhitgdrtghomhdprhgtphhtthhopegtkhhmsehnrghprghtvggthhdrtgho
 mhdprhgtphhtthhopehsihhlqdhplhhvsehnrghprghtvggthhdrtghomhdprhgtphhtth
 hopegtrhhishhtihgrnhdrughumhhithhrvghstghusehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:p8kdaWgLHmSzbS64dRGFIAXv6w05dG1RkvyOzeQVqcYVmUnolan3YQ>
 <xmx:p8kdabaEOxv10DIR5wUgGiHSfTso4G-NTJe6BoZZdDz-HYB8f3OVQQ>
 <xmx:p8kdab9CCXDwXEj3KKJfMqX-7Ls3yOLYSALEG8VWJTOW8STEuDFKPA>
 <xmx:p8kdadObh3agpJiyZw_ecUgyOxE5e7q67ik4rMtvpF08T_S2gFJ8sg>
 <xmx:qMkdaQzyoTSVurPQjIGymnT77KyaGS6SX99vtLMf4d80yMVOxN7_44AI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 08:44:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>,
 Xingui Yang <yangxingui@huawei.com>, Chengwen Feng <fengchengwen@huawei.com>, 
 Zaiyu Wang <zaiyuwang@trustnetic.com>, Christian Koue Muf <ckm@napatech.com>, 
 Serhii Iliushyk <sil-plv@napatech.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Jian Wang <jianwang@trustnetic.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Sunil Kumar Kori <skori@marvell.com>
Subject: Re: [PATCH] drivers/net: fix Tx packet prepare
Date: Wed, 19 Nov 2025 14:44:04 +0100
Message-ID: <3449306.jE0xQCEvom@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65575@smartserver.smartshare.dk>
References: <20251119130333.2697937-1-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F65575@smartserver.smartshare.dk>
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

19/11/2025 14:19, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Wednesday, 19 November 2025 14.04
> >=20
> > After removing callback checks from ethdev fast path,
> > some drivers crashed because tx_pkt_prepare was set to NULL.
> >=20
> > Some drivers (hns3, ngbe, txgbe) need to use
> > rte_eth_tx_pkt_prepare_dummy
> > when configuring queues.
> > Other drivers (ntnic, softnic) does not need to set tx_pkt_prepare
> > as it was set by eth_dev_set_dummy_fops() called by
> > rte_eth_dev_allocate().
> >=20
> > Bugzilla ID: 1834
> > Fixes: 066f3d9cc21c ("ethdev: remove callback checks from fast path")
> >=20
> > Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
>=20
> Searching for "tx_pkt_prepare =3D NULL;" finds a few more, but they are a=
ll in driver cleanup functions, so...
> Reviewed-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Yes I am working on the cleanup side.
But there is no bug in cleanup, it will be a cleanup of cleanup ;)
So cleanup will be handled after 25.11 release.


