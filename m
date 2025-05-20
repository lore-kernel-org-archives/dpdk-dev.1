Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB6DC3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 15:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B3FD402AE;
	Tue, 20 May 2025 17:25:56 +0200 (CEST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 963AE4029C
 for <dev@dpdk.org>; Tue, 20 May 2025 17:25:54 +0200 (CEST)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-ad51ef2424bso841724566b.0
 for <dev@dpdk.org>; Tue, 20 May 2025 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1747754754;
 x=1748359554; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rxOiRbYBppSYMQ8TGnsVXB0O8T3OsXsDvXZ+pUy3vw=;
 b=zEmkRQ5qV5+7dCYkaLDO4+EMGlFGwgqwZQEnHwVet3VXBkoTmKnmZKIEKW44OiWpGz
 /5f/KK8W6/Jfggzl58wWr6kYZ4wHY1tMNe0hTQP/rrJVayep3o00PXqFfBcrZr++H4M8
 7pyNjviRjDs0prMhhDFJCegjKV93U2hcqitZCwb56IgSi78yVTrOhEoTrJVkKcUdhTCc
 F8WuKapLUOQOnk6EAMRHs9UMGW45fpQ/AqGqfG2sRA2XLL1UnmRejfcmJ0qlgBS4l35y
 MYGccnb5jm6QZcLBVPK6iMdWmoO9uZ/sLlcjc9LDj+vINqhBJWVFdAll8Pj0Ut89+IUd
 Sd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747754754; x=1748359554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rxOiRbYBppSYMQ8TGnsVXB0O8T3OsXsDvXZ+pUy3vw=;
 b=uq+WXHSQi8ggjN1fRhglROrQlrS+wpKNUT4/Xx/TG/o248t0YEf3wxuQYn4atpbtYT
 7PipEE9mSQC7i/6pKM+4nKN2kvv2t8j+6Kf/PQJZOH4Ykb+2L7nwIa7p7Z0yA4cozMf6
 HJQlU32Y07JMeErEuv0J2bbqv4B+JATPdumWpVabRADHLsAaNO7XmHuFEJlxKWQV1JmN
 8gRyqxcnrR9uV/tFgfpnmqn5dWBBapLSKrLZ9OQUumQsoL+qRkGiT8lM6RZnmUpBrFdN
 jDmwCaozdvnM5CrOKFP+6vhbS+X20x19mzprpPB16llycmexAVa8b/zmW6jnJ/aEOtsP
 tXLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW97Af0O83ta+o9/5k/oC+mR/5P/e1plitDmT9ytShCYEWWIFy6jfNdjXip2sR6UNATA9g=@dpdk.org
X-Gm-Message-State: AOJu0Yx4FlfrwQaIm/FzrFo6aYgUikLuRuvSkLza8dINFK5Z3+7NDmPu
 lRR//A6LQVKP5F6b80R5O+R40JF3DOpxURZa/F5G+MzyA0wICgIDl+5j2belFjxEcL4=
X-Gm-Gg: ASbGnctLumkMRsdcWV2pwyUqbeoEvcmB9EYXwZrOw/LG8eWLEk+CtulczC94h2Vr1RE
 Aga5n7YMzBbmCHCqwXiPXHOp0r7I2P24OWFWPayBTKHE6e9Xv+Msghm1e2Po751TE5jQUjXfyTE
 0Z+Vwt4NFznwrb3m3gEdQWDh0TOnUxhm1PhbTWN7x8NrYh3lgIm6NzJfQdLDPnBQEo/yBvAjJcU
 rLKFakqHck16BT+2sHThq13eL09v9HoMIvts6DhCPaTxy60fEt6xsMohDyCYJ6cIaGe1jJ3I9y2
 2YWXQ2w1euv620/q01NMhUpIFWEAFbO23+SCd1koEgLX/h1OS0ewIFoLi2NPJdo9IUnXnb+44jx
 xHXfygw+CKYXTnRguLomGUTR3MR26blr+p4O0fcc=
X-Google-Smtp-Source: AGHT+IGJrBN7y+4zdNgFZRTDrht8IP8S3cBOkXaZeO+H6SDWTVmjtHK9vJB1sCB9Ps/7EJGcnzmjJw==
X-Received: by 2002:a17:907:1c11:b0:ad2:48f4:5969 with SMTP id
 a640c23a62f3a-ad52d53e79emr1605233466b.28.1747754753982; 
 Tue, 20 May 2025 08:25:53 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d06b532sm740317766b.43.2025.05.20.08.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:25:53 -0700 (PDT)
Date: Tue, 20 May 2025 08:25:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Sunyang Wu" <sunyang.wu@jaguarmicro.com>, "dev" <dev@dpdk.org>, "Thomas
 Monjalon" <thomas@monjalon.net>, "Ferruh Yigit" <ferruh.yigit@amd.com>,
 "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH] ethdev: optimize how the values of the flag variables
 are assigned
Message-ID: <20250520082545.53836539@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC35@smartserver.smartshare.dk>
References: <20250508023334.28416-1-sunyang.wu@jaguarmicro.com>
 <CAOaVG15=NiMUfxtkjPSdQWXKhqJ7x+9n-F1K-LdKpHuSUYnoAQ@mail.gmail.com>
 <KL1PR0601MB55678B1F0A4D7AC99B21B5F6908BA@KL1PR0601MB5567.apcprd06.prod.outlook.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FC35@smartserver.smartshare.dk>
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

On Thu, 8 May 2025 10:17:44 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Wouldn't the correct fix assume the change has no effect if the operation=
 failed, like the _enable_ functions do, i.e.:
>=20
> int
> rte_eth_promiscuous_disable(uint16_t port_id)
> {
> 	struct rte_eth_dev *dev;
> 	int diag =3D 0;
>=20
> 	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> 	dev =3D &rte_eth_devices[port_id];
>=20
> 	if (dev->data->promiscuous =3D=3D 0)
> 		return 0;
>=20
> 	if (dev->dev_ops->promiscuous_disable =3D=3D NULL)
> 		return -ENOTSUP;
>=20
> -	dev->data->promiscuous =3D 0;
> 	diag =3D dev->dev_ops->promiscuous_disable(dev);
> -	if (diag !=3D 0)
> -		dev->data->promiscuous =3D 1;
> +	if (diag =3D=3D 0)
> +		dev->data->promiscuous =3D 0;
> 	diag =3D eth_err(port_id, diag);
>=20
> 	rte_eth_trace_promiscuous_disable(port_id, dev->data->promiscuous,
> 					  diag);
>=20
> 	return diag;
> }
>=20
>=20
> From: Sunyang Wu [mailto:sunyang.wu@jaguarmicro.com]=20
> Sent: Thursday, 8 May 2025 08.27
>=20
> Thank you for your reply. Personally, I think that when disabling promisc=
uous/all-multicast mode, the corresponding flag should be set based on the =
return value. This is because, at the driver implementation level, the driv=
er may check the flag to determine whether the corresponding disable operat=
ion needs to be executed. If the flag is set before the operation is comple=
ted, the driver will not execute the operation when it checks the flag, as =
it will find that the flag has already been set.
>=20
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Stephen Hemminger <stephen@networkplumber.or=
g>=20
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B45=E6=9C=888=E6=97=A5 1=
3:35
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> =E6=8A=84=E9=80=81: dev <dev@dpdk.org>; Thomas Monjalon <thomas@monjalon.=
net>; Ferruh Yigit <ferruh.yigit@amd.com>; Andrew Rybchenko <andrew.rybchen=
ko@oktetlabs.ru>
> =E4=B8=BB=E9=A2=98: Re: [PATCH] ethdev: optimize how the values of the fl=
ag variables are assigned
>=20
>=20
> External Mail: This email originated from OUTSIDE of the organization!=20
> Do not click links, open attachments or provide ANY information unless yo=
u recognize the sender and know the content is safe.=20
>=20
> Why bother? This is not critical path.=20
> Original code looked fine=C2=A0
>=20
> On Thu, May 8, 2025, 11:34 Sunyang Wu <sunyang.wu@jaguarmicro.com> wrote:
> Set the values of the promiscuous and all_multicast variables
> according to the return value.
>=20
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
> ---
> =C2=A0lib/ethdev/rte_ethdev.c | 9 +++------
> =C2=A01 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
> index d4197322a0..b1f593edc4 100644
> --- a/lib/ethdev/rte_ethdev.c
> +++ b/lib/ethdev/rte_ethdev.c
> @@ -3044,10 +3044,8 @@ rte_eth_promiscuous_disable(uint16_t port_id)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev->dev_ops->promiscuous_disable =3D=3D =
NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOTSUP;
>=20
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0dev->data->promiscuous =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 diag =3D dev->dev_ops->promiscuous_disable(de=
v);
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (diag !=3D 0)
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->data->promis=
cuous =3D 1;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0dev->data->promiscuous =3D (diag =3D=3D 0) ? =
0 : 1;
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 diag =3D eth_err(port_id, diag);
>=20
> @@ -3112,10 +3110,9 @@ rte_eth_allmulticast_disable(uint16_t port_id)
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev->dev_ops->allmulticast_disable =3D=3D=
 NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOTSUP;
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0dev->data->all_multicast =3D 0;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 diag =3D dev->dev_ops->allmulticast_disable(d=
ev);
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (diag !=3D 0)
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev->data->all_mu=
lticast =3D 1;
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0dev->data->all_multicast =3D (diag =3D=3D 0) =
? 0 : 1;
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 diag =3D eth_err(port_id, diag);
>=20

Agree.
The concept is good, but it is not an optimization.
There is a bug here. The flag should not be set if driver returns an error.
The error should be directly returned to application and state should not c=
hange.
