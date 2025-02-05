Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A34C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 18:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FD09402F2;
	Wed,  5 Feb 2025 19:46:04 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 5353A402F0
 for <dev@dpdk.org>; Wed,  5 Feb 2025 19:46:03 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2f9d5e0e365so14827a91.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 10:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738781162;
 x=1739385962; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCTbFwqZlsdOIXhyHq6v/kiatU9DVP1iY+WjDBLhNK8=;
 b=dV5YX2EWIwwBm8aa1dEW5tmF6feQfGH5qrzNIVmQu0PBUvukfEZzH2HQU42vm1OQfX
 ri8+YoMXdJCVmernvkguhmfZm5T6d7w0bRD06VOphdZ/iw/ajbKiRJ0pkuH8RKBNmjg+
 0BPeAhaSX0p84DEAE7jSQbBiqyc7w64WPYMrMmEVCSeOG28v0TtggxiocHAAmBM6yn3L
 hSfNvJ48lD1wxdkSXu2ssLpFmBnycxiAsbQEFiKOvBvCv3ugS67FtL3ylx5WFpVnm62p
 NTlrSk2T4hQJaA6LaQReZdzb6/5jWk9Pge9FVRXCy7r8pdUVQty9uXpvzdqAPQod+TGW
 WShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738781162; x=1739385962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCTbFwqZlsdOIXhyHq6v/kiatU9DVP1iY+WjDBLhNK8=;
 b=m9+v92ufd2lOjn1klAmnWGxdTUrbt55j1xEUU0U93Hj2RFBIDE9HXgdaALX8odzq9j
 xxj3xwrNd90qNAH+G4Ob9iTUCBDZdBFa7k/NeTa7RqsWOU7Z2vQO+WD1s1qKAcd0gGFd
 8ES2Sm6rAWms/8jTXCdGpvlp/6vc0zeOQMobwLUZF/cNK2AcOrHsmN61QhruDPcn7mIC
 6N4oAQIu+hZGrY8Hbob7nsxAT12J9uGWLw4l5/UQzsBi/AZVOVQ0zZxBvygnKro2bjsP
 6lg4RD4oMzm76TrU2JefiOBqYrQnUkDfiEu78hKZylAfD4q4zZII18mysINVWQZ+/+vs
 URjg==
X-Gm-Message-State: AOJu0Yy4u2G4Xr5BCKgYmj/jBgh1wPnLoSxz8/jy6RQcls4X2LlwTYaV
 PdfMNbqKJjMb07BqcB3mDonnmJFggDdXItPfKRPB0Z1y0yp9iqV/sZTaR5OIml9PIomts/MGBFr
 /JGI=
X-Gm-Gg: ASbGncsdbTyVBxv7Y2tdwwMpLhLWsngb29v7nSxKQiH9n5TbTPxHfPyDKK3n/3eYp1M
 wpugRCjwTZ28idK6n2GzRGf1kZok41xiAO+OPAvWKiwfTpGXe1G+Lpiwsr636aK6c4rYm+DrUoV
 AOUPnSxnMhGEIxihjkL03pnZWFjvVYlxv9c8qacdrJiPpSQ0SYlSxYrI5uxU4Bclmkoxl1C3giC
 aeG7BgNhO/j2ArHNUgesAdEFiTcpCilmBPmHreA5xcVy+Ln653hbq3nWSJKNpuwnRbEJTE6Tr7A
 lhgRWCkAtbnYIZNV/T6PHs7GXK0/L5Ixow/KnbCIFRnOpU6+zx2vbK122pQHNNbGej/s
X-Google-Smtp-Source: AGHT+IHnOsmD2vkCV0ADNoSAiQAwyhWTe2aLTGrwCxrkSR+31sPHjhRqjguX4crKvnOmZ6IDBSfRAw==
X-Received: by 2002:a17:90b:3842:b0:2ea:37b4:5373 with SMTP id
 98e67ed59e1d1-2f9e076162fmr6152757a91.10.1738781162378; 
 Wed, 05 Feb 2025 10:46:02 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d89a12sm1947890a91.21.2025.02.05.10.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 10:46:02 -0800 (PST)
Date: Wed, 5 Feb 2025 10:46:00 -0800
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
Message-ID: <20250205104600.3bf2afdc@hermes.local>
In-Reply-To: <SA1PR12MB9491A6FDB9AD2FC28CC5A0BEBFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
References: <20240708165145.1405107-1-shperetz@nvidia.com>
 <20250129085416.226718-1-shperetz@nvidia.com>
 <20250129082518.47630942@hermes.local>
 <SA1PR12MB94915F840D6A2D631AA02E1ABFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
 <20250205084202.264d9781@hermes.local>
 <SA1PR12MB9491A6FDB9AD2FC28CC5A0BEBFF72@SA1PR12MB9491.namprd12.prod.outlook.com>
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

On Wed, 5 Feb 2025 17:37:54 +0000
Shani Peretz <shperetz@nvidia.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Wednesday, 5 February 2025 18:42
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
> > On Wed, 5 Feb 2025 16:36:11 +0000
> > Shani Peretz <shperetz@nvidia.com> wrote:
> >  =20
> > > > -----Original Message-----
> > > > From: Stephen Hemminger <stephen@networkplumber.org>
> > > > Sent: Wednesday, 29 January 2025 18:25
> > > > To: Shani Peretz <shperetz@nvidia.com>
> > > > Cc: dev@dpdk.org; NBU-Contact-Thomas Monjalon (EXTERNAL)
> > > > <thomas@monjalon.net>; Tyler Retzlaff
> > > > <roretzla@linux.microsoft.com>; Parav Pandit <parav@nvidia.com>;
> > > > Xueming Li <xuemingl@nvidia.com>; Nipun Gupta =20
> > <nipun.gupta@amd.com>; =20
> > > > Nikhil Agarwal <nikhil.agarwal@amd.com>; Hemant Agrawal
> > > > <hemant.agrawal@nxp.com>; Sachin Saxena <sachin.saxena@nxp.com>;
> > > > Rosen Xu <rosen.xu@intel.com>; Chenbo Xia <chenbox@nvidia.com>;
> > > > Tomasz Duszynski <tduszynski@marvell.com>; Chengwen Feng
> > > > <fengchengwen@huawei.com>; NBU-Contact-longli
> > > > (EXTERNAL) <longli@microsoft.com>; Wei Hu <weh@microsoft.com>; Bruce
> > > > Richardson <bruce.richardson@intel.com>; Kevin Laatz
> > > > <kevin.laatz@intel.com>; Jan Blunck <jblunck@infradead.org>
> > > > Subject: Re: [PATCH v4] bus: fix inconsistent representation of PCI
> > > > numbers
> > > >
> > > > External email: Use caution opening links or attachments
> > > >
> > > >
> > > > On Wed, 29 Jan 2025 10:54:16 +0200
> > > > Shani Peretz <shperetz@nvidia.com> wrote:
> > > > =20
> > > > > +create_pci_dev(const char *name)
> > > > > +{
> > > > > +     int port_id;
> > > > > +     uint8_t slave_mac1[] =3D {0x00, 0xFF, 0x00, 0xFF, 0x00, 0x0=
0 };
> > > > > +     struct rte_ether_addr *mac_addr =3D (struct rte_ether_addr
> > > > > +*)slave_mac1; =20
> > > >
> > > > Use different initializer and you can avoid the need for cast here.
> > > >
> > > > =20
> > > > >
> > > > > +/**
> > > > > + * General device name comparison. Will compare by using the
> > > > > +specific bus
> > > > > + * compare function or by comparing the names directly.
> > > > > + *
> > > > > + * @param dev
> > > > > + *   Device handle.
> > > > > + * @param name
> > > > > + *   Name to compare against.
> > > > > + * @return
> > > > > + *   0 if the device matches the name. Nonzero otherwise.
> > > > > + */
> > > > > +__rte_internal
> > > > > +int rte_cmp_dev_name(const struct rte_device *dev, const void
> > > > > +*name); =20
> > > >
> > > > It would make more sense to me if name was a character not void poi=
nter.
> > > >
> > > > The design might be clearer if bus address was more of an typedef
> > > > with a pointer and size together. Treat it more like an object. =20
> > >
> > >
> > > Okay so just to understand,
> > > this is the struct I am adding:
> > >
> > >       struct rte_bus_address {
> > >              const void *addr;
> > >              size_t size;
> > >       };
> > >
> > > This is how I pass it to find_device:
> > >
> > >       struct rte_bus_address dev_addr =3D {
> > >                 .addr =3D da->name,
> > >                 .size =3D RTE_DEV_NAME_MAX_LEN
> > >       };
> > >       dev =3D da->bus->find_device(NULL, rte_cmp_dev_name, &dev_addr);
> > >
> > > And this is how I use it in rte_cmp_dev_name:
> > >
> > >       rte_cmp_dev_name(const struct rte_device *dev1, const void *add=
r)
> > >        {
> > >              const struct rte_bus_address *dev2_addr =3D addr;
> > >       =E2=80=A6
> > >       }
> > >
> > > Is that what you meant?
> > > Also, I'm not sure if the size is really needed, because we check the
> > > size of the parsed name, which may be different than the size of the
> > > original name
> > > =20
> >=20
> > It would be best to pass rte_bus_address to rte_cmp_dev_name rather than
> > having implied cast.
> > Not sure if that is possible without breaking API though. =20
>=20
> I think you are right, also it will require to change the signature of fi=
nd_device which will make it even bigger change

Could you post patch with something "good enough" that builds and passes te=
sts?
