Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A4EC5B555
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 15:23:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3604440283;
	Fri,  6 Jun 2025 17:23:14 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id C559540283
 for <dev@dpdk.org>; Fri,  6 Jun 2025 17:23:12 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4947635914aso21887801cf.3
 for <dev@dpdk.org>; Fri, 06 Jun 2025 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749223392;
 x=1749828192; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4qaturKyIZOeKoNDiazZcOO5lyeF5UKXGVzO6cX8II=;
 b=1B+udqpBt2wM82u0PPXD/pqAbZrF34Tr4DnzXaw0nMy5qeotLwQuZ76xt5Aiybz614
 NX3PoSE7q1wGRnjMDANaBJPJLbsmLcGw6YbXjk/E4BkPs0LYm9xbK8sOo+35Mwmwlckc
 1kCD9WpS/35sJw8MWQuQeAVOJovEVHNGt8QfGd8j1i2PWwPaIDZyL6iEV64SvpXI8UMK
 igTK1nX85F44je0Qc1ZM42gYN0JgGwftMwklxEwJTc8GCU7NIZKUDFIoqHCsYfsEmjSU
 Z+Ube+IvGrWbmdtNkegO6bb3zEK53oD3O2tudMAreSdiwaORbI1MW4c16i+SJOHOdtw1
 HApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749223392; x=1749828192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4qaturKyIZOeKoNDiazZcOO5lyeF5UKXGVzO6cX8II=;
 b=QIdWs/Bwgt2WrVCOCywi6ls7IdWlZzXOYvLWRDD+X8pnoe8qwBk0A/6eSxNBk4KpmC
 nkYpC7kSj8M8X2lAEGzFfPitEImZRiTk17+ks/Yd6iBM06mA7epBzIcFbQinOfTIIuCG
 /5dVl4PYW3/VOjPdqrfv9z5MCTic45vBspi9m9lxcvnU6uUkyulweYpK0sGgjPZCe0Oe
 IqGhHHN2xM0x+gIU17KLy6baT0WL7w0gIIwSxcsaY8LoKomJms9cCZHH8D+bPZeNFiPH
 Vua8Rkw5HA4nPFgxiOras/utHuNkoOamS6FdnS+tBuAHhEqKJTFA9LdFPeQ6cjq8c+oH
 5UVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOWRziRHlp0I6T/BQzRMo18vRcBVErhYWlVC1hZHsRd3cQH59a3RuLsKvjYnSxktlAvxo=@dpdk.org
X-Gm-Message-State: AOJu0YyMNFclxSaJynN0laO3U1mrF0walvIfpNGFBCpZK4jfO7APmCU0
 u4BLqTYDP2m6DoSz0kAlqTo6NXQXkA90fQEFPkjtzIVrHAECs16GYhPUv0uVZ78QVro=
X-Gm-Gg: ASbGncttiW8bqm4kSghxRyRDvzIvaEzHcP55h2SU0a0sEutGflebp6UbkhQLjyqfZdt
 6HsFZPEuAwmOh5ar4E6Rjm307oRbFGwPsCeS7qCO55SIWPG58p4IQib2ZDAoXlipjiZKrDaksUT
 xAJIL7NALFcMFawjuG/LsKkfE/E3r94PV2jZDKQazN085JSUeZiiwCRwRGJRAYWPxSuML9pHIkZ
 L6LBPttjAUd8Zwd4SgBtWvZEJz3cWbJmQGSSy8fc4+1AMmC7U/H6Uwspx71tPrBK0kmZWexN4Zl
 2QZMuXllOj77z/hmsk6r1le7k/Icy7LxCkd9SzB+m90HVteEtd2gvHJ0Dl+AYhnbS7Jx4KmXqQ+
 4GXNLIOU2LPZqbbxTpxsLzHQpK6VhGqdLvjzekYzOTuEWE4XOvw==
X-Google-Smtp-Source: AGHT+IHtPhoVE2rcjC/CvTPj0zqXu0/0fEDVUQ1+NiGMg4B5YLqT+b2IJxAA+1BBbWGzFw2Ju+qHkQ==
X-Received: by 2002:a05:622a:90e:b0:494:b251:d216 with SMTP id
 d75a77b69052e-4a5b9a29356mr70644281cf.18.1749223392016; 
 Fri, 06 Jun 2025 08:23:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a61114fcc8sm14026981cf.12.2025.06.06.08.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 08:23:11 -0700 (PDT)
Date: Fri, 6 Jun 2025 08:23:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <skori@marvell.com>, "Thomas Monjalon" <thomas@monjalon.net>, "Ferruh
 Yigit" <ferruh.yigit@amd.com>, "Andrew Rybchenko"
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, "Nithin Dabilpuram"
 <ndabilpuram@marvell.com>, <jerinj@marvell.com>
Subject: Re: [PATCH v2 1/1] ethdev: add support to provide link type
Message-ID: <20250606082307.152616f3@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FCD0@smartserver.smartshare.dk>
References: <20250605113159.3035480-1-skori@marvell.com>
 <20250606092904.3145608-1-skori@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FCD0@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, 6 Jun 2025 11:54:52 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: skori@marvell.com [mailto:skori@marvell.com]
> > Sent: Friday, 6 June 2025 11.28
> >=20
> > From: Sunil Kumar Kori <skori@marvell.com>
> >=20
> > Adding link type parameter to provide the type
> > of port like twisted pair, fibre etc.
> >=20
> > Also added an API to convert the RTE_ETH_LINK_TYPE_XXX
> > to a readable string.
> >=20
> > Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> > Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
> > ---
> > +/**@{@name PORT type
> > + * Ethernet port type
> > + */
> > +#define RTE_ETH_LINK_TYPE_NONE  0x00 /**< Not defined */
> > +#define RTE_ETH_LINK_TYPE_TP    0x01 /**< Twisted Pair */
> > +#define RTE_ETH_LINK_TYPE_AUI   0x02 /**< Attachment Unit Interface */
> > +#define RTE_ETH_LINK_TYPE_MII   0x03 /**< Media Independent Interface
> > */
> > +#define RTE_ETH_LINK_TYPE_FIBRE 0x04 /**< Fibre */
> > +#define RTE_ETH_LINK_TYPE_BNC   0x05 /**< BNC */
> > +#define RTE_ETH_LINK_TYPE_DA    0x06 /**< Direct Attach copper */
> > +#define RTE_ETH_LINK_TYPE_OTHER 0x1F /**< Other type */
> > +/**@}*/ =20
>=20
> I don't see the use case for this patch, when only ancient interface type=
s are defined.
> How about RMII, GMII, RGMII, XGMII, XAUI, XAUI4, CAUI4, SFP, SFP+, SFP28,=
 etc.
>=20
> Please don't blindly port stuff from Linux to DPDK.
>=20
>=20

Agree with Morten here.
Plus, it isn't really much use to user unless all drivers report it.
Also, it breaks ABI (see build failures).
