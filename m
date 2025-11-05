Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEF4CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 21:31:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0868340B95;
	Wed,  5 Nov 2025 22:31:43 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 1D617402E6
 for <dev@dpdk.org>; Wed,  5 Nov 2025 22:31:42 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id B6FE2EC012A;
 Wed,  5 Nov 2025 16:31:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 16:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762378301;
 x=1762464701; bh=JkKBlopPlKq3AKxz8YQz5jlu4RgOps7eprDHDSf/4UA=; b=
 S1xIkL26EWr0uqJ+J/Ac5EWjV9MTItCzugnn8p3spcTKN+DeOaGYgZs+H2gQivoa
 rG46KEQxI2B87+LrS2+lTFAgxtQKcKa/QOjM0KO0CjsoGoMijjy2k4TBozqA9K3g
 pZSwl85oKaNfqSZVe/pVYYNBX0c0e7M/0bb52bOaaIMHpfe9XiI/IRcaBYd5tgE2
 +IqkWyiDQ8ov2kVpagNbzxjZoZNXBuvSNOr3O8sIjAmClxWr6+jEL4jkLyWjzRJq
 d5hAoR+FDhQymyACbo91REZJKN18SbkpsbRlkNIR/EeQaGbnlAhJ+ED8fw5WlG6d
 XinqZc+vVxcdK/sii1WG7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762378301; x=
 1762464701; bh=JkKBlopPlKq3AKxz8YQz5jlu4RgOps7eprDHDSf/4UA=; b=q
 PSOaiOSB12MNDZQ1d3BPBBeztaKaLVt2YC9WIYMdz+OwrJjRHglHXBNfJL+auNE2
 DhAW38sTaxy+4s8aZ90cvvaO5L8jTTIlpLpjHwLF7k7EUHZgWoG3LjFUI4Ml/uwm
 5VoQn9FxZ6zGFY63FkSJtZhVWHzktp5tsYcaq5y+Nx1gXarFWx46lF3vSw3nXcn4
 s8Z7Pzm4dsODTV48EhkSzzGDfCQLtnr22E1A993TG2m542BTuA2DtUXTudxMxvXM
 5AG/EPLp1me6NoSEQLMrXzHVDv7C8LNqJOkrO1YZA4i4KHdEIzOlWYfp39UXFl0o
 o1XwF9UX83c5CW1IHrUsA==
X-ME-Sender: <xms:OsILac08F0h8nBmWf3p1T26MKI98ozAkUi50uVb4vRMSb87YHRs3NA>
 <xme:OsILaWVJN4qpLbwvaH5Slcz-De_vSnSdGCTZAcWL9z2LwJUzh3l2LruEQJAjI6Xtt
 CGYXG6Qb5g4ZS1csr6a6hwdX0s5Q7WBzspS_yUABr8pDao6gVaCUf0>
X-ME-Received: <xmr:OsILaXvy9d7bxgvrCBgr5CCkZ59AN7rlPiToBDGXP2MfcNs7LUycICBJRle33fdFkowID-RsQIELRO3e9X2J73CCCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvtddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhgurggs
 ihhlphhurhgrmhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkihhrrghnkhhumh
 grrhhksehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepshhkohhrihesmhgrrhhvvghl
 lhdrtghomhdprhgtphhtthhopehskhhothgvshhhfigrrhesmhgrrhhvvghllhdrtghomh
 dprhgtphhtthhopehhkhgrlhhrrgesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopegt
 khhmsehnrghprghtvggthhdrtghomhdprhgtphhtthhopehsihhlqdhplhhvsehnrghprg
 htvggthhdrtghomh
X-ME-Proxy: <xmx:OsILadWXyJYOze0-ocGqBVLzJqYGN2mJX-elZB6o76HBbQ9NJJYdIA>
 <xmx:OsILaTVMek2TpaIuJEyIKcEnaQgTjOv6hmZe7dWGRltNpqxqrew6ag>
 <xmx:OsILaXdfafCqxRjyTLRNln8gvzdCqcXwZG7YY2UdycXDPiPHzs20_g>
 <xmx:OsILaa52akVcZYbzX6LwbzXC2ziag0J_72V3ulqRayGEWLHm1vi6Aw>
 <xmx:PcILaXHwpDMYGDTHENAvv_0mszKRpimvV830a0zJkOX9rXBDZ2LmunK6>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:31:35 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Jerin Jacob <jerinj@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>, Rosen Xu <rosen.xu@altera.com>,
 David Christensen <drc@linux.ibm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?B?U3RhbmlzxYJhdw==?= Kardach <stanislaw.kardach@gmail.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>, Jiayu Hu <hujiayu.hu@foxmail.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH 1/1] move SPDX tag on the first line
Date: Wed, 05 Nov 2025 22:31:34 +0100
Message-ID: <18707035.lhrHg4fidi@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65525@smartserver.smartshare.dk>
References: <20251031142018.49319-1-thomas@monjalon.net>
 <98CBD80474FA8B44BF855DF32C47DC35F65525@smartserver.smartshare.dk>
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

31/10/2025 15:55, Morten Br=C3=B8rup:
> > From: Thomas Monjalon [mailto:thomas@monjalon.net]
> > Sent: Friday, 31 October 2025 15.20
> >=20
> > From "Contributor's Guidelines":
> > "
> > DPDK uses first line of the file to be SPDX tag.
> > In case of #! scripts, SPDX tag can be placed in 2nd line of the file.
> > "
> >=20
> > Some .c or .h files had the SPDX identifier on the second line
> > for no good reason, so it is moved to the first line
> > to comply with the guidelines.
> >=20
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
>=20
> Cleaning up is always good.
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied


