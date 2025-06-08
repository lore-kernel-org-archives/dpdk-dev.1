Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624A9C5B552
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 16:49:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25A7F402A9;
	Sun,  8 Jun 2025 18:49:22 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id EAEC440269;
 Sun,  8 Jun 2025 18:49:19 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3DB5511400E6;
 Sun,  8 Jun 2025 12:49:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 08 Jun 2025 12:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749401359;
 x=1749487759; bh=5YGZyrwOcNpIP9+fKP0j3aGbXCUqDcOKeMDRSNtNs/w=; b=
 jnDGkPNZJoHwYqJW3jFx5c5XwNN2wsOe0ucSQrpoFlHFwPtN9ZrGkubk/0tvEtyZ
 hNUPdciQp3AA4g65ko0eRh8bSQe8nnNdhqqUR1QhsH/7VJIix4AiDHO3t1Zh02jy
 y2+MMQW/pwM1hLu+USzGUIS9uR65lE1A4DTnR5t2lHIltYmgsF4EqVWWPkAqmzFZ
 5owyKPcPauY8I0bJ5B4rU2JkQOiKgLqMESEPKrdY3Qp6HBI359UI6m4wPfjq74Mw
 2CQTeiALcHEoPof82owxJKsMHenAiaKDePlnTi9zHjAsUoI+WCIPiLqM8XhuVZPk
 t/wBXDmMIo47v9tzxaVLQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749401359; x=
 1749487759; bh=5YGZyrwOcNpIP9+fKP0j3aGbXCUqDcOKeMDRSNtNs/w=; b=b
 iNtNqk6w1MXI4Di++ADrJpNgm7KSvaucCnHcQVo26tiHwV4/KAEf6EpkIiaUUNPI
 2CtqOuHHhGqoWvUNeRamg/xkdkCJ8LkbhLEi9Hgd+RFoG/c38rqFgIakaZbIVz7y
 mKuP+fx07OADxaf0hvxZCJSu4QfqaF/mYLSHPAyY+Qh6nTZi0wlbLJndkT8NSDDk
 ueEAJ3DwQJ0DZ5VO/kUFXFVhl+PVddfUNE3RjcMQun1sNUBzJayWAj3EXGmOCZN4
 Wz3FXQP3IcRUvM8rdFRcPro7DjxIGJ9PP5X7cw0iMAOOkIgGxQImEoCOsZlSK1w1
 gJtI873tGnpIPCePVZc/A==
X-ME-Sender: <xms:Db9FaCzoX1kpLYxMLfWKvOFXYV1KjbkjgPxdPbez4NiPChMqeYPbIA>
 <xme:Db9FaOR-87CykUAFoealV410y_sEfHdttzNTWr6Y4z1iryh5qZ9eYHp_9guvFJJfJ
 _lgmLKocgF2A3_MQA>
X-ME-Received: <xmr:Db9FaEU3PsUzOqTjVv3IL8lspKNHcd8diPif3ddZArmlR49hfHz9bTLQlnJHsJpOzS0-plE2jBrHF7GBPIH6bRdNYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekudduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedt
 heevtdekiedvueeuvdeiuddvleevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnhi
 grnhhgrdifuhesjhgrghhurghrmhhitghrohdrtghomhdprhgtphhtthhopeguvghvsegu
 phgukhdrohhrghdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpth
 htohepshhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthht
 ohepfhgvrhhruhhhrdihihhgihhtsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvg
 ifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphhtthhopehmsges
 shhmrghrthhshhgrrhgvshihshhtvghmshdrtghomh
X-ME-Proxy: <xmx:Db9FaIjypO-QLWsHE5UujOwyWu08QZkkeQy8P7L65CT5keprfu6qbw>
 <xmx:Db9FaEA4xfzkjFWWGLUJYiTXHeMktW0DprIjO_iulI2lBK1GIymacQ>
 <xmx:Db9FaJIPaaxaORMNisxMz5GmcMqU5w6-BRW7sYc6bhKzq5JjtM4Lxw>
 <xmx:Db9FaLBe7jVZ4ndj_U0HES3kmbrNNz3-Xl8fmH3rpWsg0SNcFPJAnw>
 <xmx:D79FaMXH0OFa_apmoBTFJmUoIvmotWzX3bmX5LLSYFrjk5F_-bohKouc>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 12:49:16 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev@dpdk.org, stable@dpdk.org, stephen@networkplumber.org,
 ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH v3] ethdev: fix the bug where the flag variables are
 assigned
Date: Sun, 08 Jun 2025 18:49:14 +0200
Message-ID: <5605516.V25eIC5XRa@thomas>
In-Reply-To: <20250522074242.30376-1-sunyang.wu@jaguarmicro.com>
References: <20250522074242.30376-1-sunyang.wu@jaguarmicro.com>
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

22/05/2025 09:42, Sunyang Wu:
> Set the values of the promiscuous and all_multicast variables
> according to the return value.
>=20
> Fixes: af75078fece3 ("first public release")

This is reset to 0 since day 1, so next root cause is not needed.

> Fixes: de5ccf0775ae ("ethdev: do nothing if all-multicast mode is
> applied again")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>

Acked-by: Thomas Monjalon <thomas@monjalon.net>

> -	dev->data->promiscuous =3D 0;
>  	diag =3D dev->dev_ops->promiscuous_disable(dev);
> -	if (diag !=3D 0)
> -		dev->data->promiscuous =3D 1;
> +	if (!diag)
> +		dev->data->promiscuous =3D 0;

Updated the commit log to explain the issue,
and changed the check to compare diag with explicit 0 for success.

Applied, thanks.


