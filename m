Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A51EC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:42:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0079F4060C;
	Wed,  5 Feb 2025 17:42:07 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 65FD140611
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:42:05 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-21f08b44937so185355ad.1
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738773724;
 x=1739378524; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yl2TjygeyxjOhXZF74EBCE13uHTfQODh9qKlJzhAkg=;
 b=CPb+PD/QxAKCdtUvilTKcyU407KYSqh9v6q8YMLq91I3fja6GO+4ZxXn0Z3YZaK8fx
 4/+RslNStgR6dTLWAImVL6gKaVRY/ra3/C/s4FpMqlOnaQdxh8B5Sl1I4owAuBHSEObs
 AJMDi4f+1R6TDn4QraWPyyFF8T90Uq+Prh4TKomzL/DxS/CiPtjLpy2zE89k4a4+tll1
 pJVt+PJPu8Okj74Lynsq1AuVUY5CEvafTJVvKjiEsfQ4RhGr/9nJ8/Jv/RyARmAgnF/q
 HIsTLT0Q8ujyfqlV0PVq7ovxE1eew4wwDCAx8HtA/ehd63GoSyaLO+rAhL5IsBtxP8OS
 yeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738773724; x=1739378524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yl2TjygeyxjOhXZF74EBCE13uHTfQODh9qKlJzhAkg=;
 b=Wh1jQP1u9eX8J8t3/jMOhrMT1B2tsaA1gB/B+ofKkOnJCN0Wj8uuZq1CNJQEhPgww+
 FdOirEiuolcueevPfDgl/sfnSTuKtlIDJPbABGDxDm/lyFMHlz2NUOqAISQmogNgfKd5
 ZpUJZHnTQILRecKnsiyo2HhYIH1iyXp5QDF/hjxKsQ+1IXT7Kh/t+8GSMVMfJLPFCJMU
 3r29CQHRBJEj3l721GdCiYoiFBilrlqbYvsPJZzhUH69zbZoAAiweE5MHh5zbqLC16Nb
 5G+2QiYFskMfxKFYU2iyUZMBnGjaanEKQOd/Wh5Tme7ii+eF7e6v6mEj3AWjaHsGXgR0
 vqFw==
X-Gm-Message-State: AOJu0YzVdrCcx22WNaFN20bjvxIS2VbJfBDxkcBYZmM8fgFkt1zIcs5h
 joSCAWVf93LoeWYbga71+wVR5UAJcKFdZLcsM47U9eSCxUZ2PV6NFrLSzB2b1/Y=
X-Gm-Gg: ASbGncuHLpoAT3WK0zfKF2l/DF0qpg3m1FvuGbvs32q/qiIdt6vWwz1kVKQ4rTM2Jfh
 axgRak20lI1IlRBU/ezUf8a38TYMJO3OknFYVfbdYtMgPNL5X3q32KGd0U9ST6p6s8OB47d4W7+
 tiIlOLCwvC9l2kswlyWYl662ZMs0JQT/fhQi6ovymR7T7lj0YRsBqssALiq96Ax1DtrV0fHAC/F
 jjjF4/3fHqtZt0g3DxmpFTeGK6lE2B337yErF1ZqbsswtGV3FsonKDujo4JlcDsJCLvQnoidId8
 YFTu5qw76ItV9A6ajrCcWh9RoOJhq4pq2HRd8Fn0hXD9BhoNt/ux15trJSCN54JRthxa
X-Google-Smtp-Source: AGHT+IEh2l63UizlBGwx+lWFfqRHkLdFPxfDRn/OKYXF2ARKm3rHp1C5SmlsjAU2GXk/RN91JbtMmg==
X-Received: by 2002:a17:903:41cf:b0:21d:3bd7:afdf with SMTP id
 d9443c01a7336-21f17d4434bmr68671035ad.0.1738773724487; 
 Wed, 05 Feb 2025 08:42:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f050e2b1csm35103895ad.86.2025.02.05.08.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:42:04 -0800 (PST)
Date: Wed, 5 Feb 2025 08:42:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "NBU-Contact-Thomas Monjalon (EXTERNAL)"
 <thomas@monjalon.net>, Tyler Retzlaff <roretzla@linux.microsoft.com>, Parav
 Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rosen Xu <rosen.xu@intel.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, Chengwen Feng
 <fengchengwen@huawei.com>, "NBU-Contact-longli (EXTERNAL)"
 <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Kevin Laatz <kevin.laatz@intel.com>, Jan
 Blunck <jblunck@infradead.org>
Subject: Re: [PATCH v4] bus: fix inconsistent representation of PCI numbers
Message-ID: <20250205084202.264d9781@hermes.local>
In-Reply-To: <SA1PR12MB94915F840D6A2D631AA02E1ABFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20240708165145.1405107-1-shperetz@nvidia.com>
 <20250129085416.226718-1-shperetz@nvidia.com>
 <20250129082518.47630942@hermes.local>
 <SA1PR12MB94915F840D6A2D631AA02E1ABFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
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

On Wed, 5 Feb 2025 16:36:11 +0000
Shani Peretz <shperetz@nvidia.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Wednesday, 29 January 2025 18:25
> > To: Shani Peretz <shperetz@nvidia.com>
> > Cc: dev@dpdk.org; NBU-Contact-Thomas Monjalon (EXTERNAL)
> > <thomas@monjalon.net>; Tyler Retzlaff <roretzla@linux.microsoft.com>; P=
arav
> > Pandit <parav@nvidia.com>; Xueming Li <xuemingl@nvidia.com>; Nipun Gupta
> > <nipun.gupta@amd.com>; Nikhil Agarwal <nikhil.agarwal@amd.com>; Hemant
> > Agrawal <hemant.agrawal@nxp.com>; Sachin Saxena
> > <sachin.saxena@nxp.com>; Rosen Xu <rosen.xu@intel.com>; Chenbo Xia
> > <chenbox@nvidia.com>; Tomasz Duszynski <tduszynski@marvell.com>;
> > Chengwen Feng <fengchengwen@huawei.com>; NBU-Contact-longli
> > (EXTERNAL) <longli@microsoft.com>; Wei Hu <weh@microsoft.com>; Bruce
> > Richardson <bruce.richardson@intel.com>; Kevin Laatz
> > <kevin.laatz@intel.com>; Jan Blunck <jblunck@infradead.org>
> > Subject: Re: [PATCH v4] bus: fix inconsistent representation of PCI num=
bers
> >=20
> > External email: Use caution opening links or attachments
> >=20
> >=20
> > On Wed, 29 Jan 2025 10:54:16 +0200
> > Shani Peretz <shperetz@nvidia.com> wrote:
> >  =20
> > > +create_pci_dev(const char *name)
> > > +{
> > > +     int port_id;
> > > +     uint8_t slave_mac1[] =3D {0x00, 0xFF, 0x00, 0xFF, 0x00, 0x00 };
> > > +     struct rte_ether_addr *mac_addr =3D (struct rte_ether_addr
> > > +*)slave_mac1; =20
> >=20
> > Use different initializer and you can avoid the need for cast here.
> >=20
> >  =20
> > >
> > > +/**
> > > + * General device name comparison. Will compare by using the specific
> > > +bus
> > > + * compare function or by comparing the names directly.
> > > + *
> > > + * @param dev
> > > + *   Device handle.
> > > + * @param name
> > > + *   Name to compare against.
> > > + * @return
> > > + *   0 if the device matches the name. Nonzero otherwise.
> > > + */
> > > +__rte_internal
> > > +int rte_cmp_dev_name(const struct rte_device *dev, const void *name)=
; =20
> >=20
> > It would make more sense to me if name was a character not void pointer.
> >=20
> > The design might be clearer if bus address was more of an typedef with a
> > pointer and size together. Treat it more like an object. =20
>=20
>=20
> Okay so just to understand,
> this is the struct I am adding:
>=20
> 	struct rte_bus_address {
> 	       const void *addr;
> 	       size_t size;
> 	};
>=20
> This is how I pass it to find_device:
> =09
> 	struct rte_bus_address dev_addr =3D {
> 	          .addr =3D da->name,
> 	          .size =3D RTE_DEV_NAME_MAX_LEN
> 	};
> 	dev =3D da->bus->find_device(NULL, rte_cmp_dev_name, &dev_addr);
>=20
> And this is how I use it in rte_cmp_dev_name:
>=20
> 	rte_cmp_dev_name(const struct rte_device *dev1, const void *addr)
> 	 {
> 	       const struct rte_bus_address *dev2_addr =3D addr;
> 	=E2=80=A6
> 	}
>=20
> Is that what you meant?=20
> Also, I'm not sure if the size is really needed, because we check the siz=
e of the parsed name, which may be different than the size of the original =
name
>=20

It would be best to pass rte_bus_address to rte_cmp_dev_name rather than ha=
ving implied cast.
Not sure if that is possible without breaking API though.
