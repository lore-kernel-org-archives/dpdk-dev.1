Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0867C36014
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Apr 2025 15:21:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA27740E4D;
	Fri,  4 Apr 2025 17:21:44 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id EC6D740E4B
 for <dev@dpdk.org>; Fri,  4 Apr 2025 17:21:43 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso20446185ad.1
 for <dev@dpdk.org>; Fri, 04 Apr 2025 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743780103;
 x=1744384903; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByLzwzExWA/O5Z967mxoTIHghwfc2RmrklKZ7ohwmdk=;
 b=UerrLKuKQjJKlV/pKkA4TOqBJ2VQ749tyTSYfVuFUIue9P1XXOnHrOKcj9oPIHCSp5
 kAWFDkwLV657YBqYyYKvBot1NmBVm3NMx1JIpmUueQdsZrsuqKG6z7GwnqS9fUidDUsI
 tBp3y7LZmreDh6o+ZwOUKTNJi+Mx39eH42AVRUwh6Ixi11Gj4Jr1SaW9l9xhOB7NUVnt
 aAmA/Dpe25W1ts3Wsc84EsmQ9OON+QhAWJpVlYjuNewzMi+xFvmefD7EhloM5LKqPCX/
 IyxKg/fofzDaeFWh29NdSJG2EfMJiIuetmCcVe92BTfykPEO1KC6Kb50f8+XI4WHLGIB
 Wn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743780103; x=1744384903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ByLzwzExWA/O5Z967mxoTIHghwfc2RmrklKZ7ohwmdk=;
 b=YnlEmySKinEKzQ9HiEkW2YRBZYgcdXixaGlXHaFpFP74sWgnG6KYOuIR9cBosZYW2+
 Ukj7e5Jpux0KiHDPPKGICF9klSdgNF7tc7DkwunsX+YkjdwFm8s5xE1O8qcGdXQZHd55
 46o6TUsqWdhB4Be0do5floyfREkWn3QMLbfKGMDCM6xrK+zqdKq4Urpw5YW2lGPFscK3
 yvRaJo/gDMPbaq0nCfH0GEg6Trxl8MbSGmj2HeU2wHPw0VF61tZZJYg4loDVW7A/ouw0
 seyMC5O8MDFVcKlfL8FQEXRM+8MDYl2AnCXcB7Dc7RY6/cUPfSA0bko5WSvm4gNHZqWQ
 Y9KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpOPslyNvoV1G7eW/J5czaqW879aXOC4dz1Fr42h+ejNKjoa841wt4+AG6evW2ORtXzwQ=@dpdk.org
X-Gm-Message-State: AOJu0YwUd2gON15vizJ13QwsbHeV7Nq+Xzm9DvZZ/womRKvmcSsP3qkN
 NBHbbA6yIYcuFRGy+eOEdmAMWwWBaJ5G+7qddvLwgY9VORneT+VaIN32kPL0baY=
X-Gm-Gg: ASbGncuGsB25I4oT27Xj3/2bOc411YIrY4hEvDyzT468nBZT5rgCKg42qOwMDKiJSSf
 2twhO/KaO4mzhEF0AhnDiZpwcBJA9F1q7al0GAwEdNSe7oCweGYcb6HpGi/+nE71ajggurks5+B
 8APYEZ2Qxa8g0g7qlBN1dbNA7tnM1pYjZcnsAiePpVAbSI9cRLJkpKJP1BOAxMNN99zru/vi1FA
 oLxsE+wah7NHq+To5jFptFVWFcuQc0waJ7fDV249hlyHugcEOCM0EJ0JfpIYHJOk9Vs2itrgfsG
 nAskWiKmhiB/HmO+QBX6AX5afg3AuaQqvbF6ZyMjj0i9Ww/oybVTKQmsbTxJYIMvjtNGc+UK6jZ
 RbeVFg6xTvymGI47y2V/8
X-Google-Smtp-Source: AGHT+IEuxtme25DxNbkzNVJPeSXtHze0SGlPz6ULiYHAaoiNsipGX5jVoq7qenLsYQaBpjbKwVCJlQ==
X-Received: by 2002:a17:902:cf11:b0:21f:7078:4074 with SMTP id
 d9443c01a7336-229765bd234mr99845995ad.7.1743780102867; 
 Fri, 04 Apr 2025 08:21:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0b41besm3483715b3a.127.2025.04.04.08.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 08:21:42 -0700 (PDT)
Date: Fri, 4 Apr 2025 08:21:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com>
Cc: Nitin Saxena <nsaxena16@gmail.com>, Nitin Saxena <nsaxena@marvell.com>,
 Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, Robin Jarry
 <rjarry@redhat.com>, Christophe Fontaine <cfontain@redhat.com>,
 "dev@dpdk.org" <dev@dpdk.org>, Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/2] node: add global node mbuf dynfield
Message-ID: <20250404082138.11549962@hermes.local>
In-Reply-To: <PH0PR18MB40861D73C3869C46BCCB4410DEA92@PH0PR18MB4086.namprd18.prod.outlook.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250401042053.3518757-2-nsaxena@marvell.com>
 <20250401071522.67cf34eb@hermes.local>
 <CAG6-93zdmJ0V=zFzj-r3GZtjEiygLpHbhE_8SW6odoocz5S-5A@mail.gmail.com>
 <PH0PR18MB40861D73C3869C46BCCB4410DEA92@PH0PR18MB4086.namprd18.prod.outlook.com>
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

On Fri, 4 Apr 2025 08:11:07 +0000
Pavan Nikhilesh Bhagavatula <pbhagavatula@marvell.com> wrote:

> > Hi Stephen,
> >=20
> > Thanks for commenting. See response inline.
> >=20
> > Regards,
> > Nitin
> >=20
> > On Tue, Apr 1, 2025 at 7:45=E2=80=AFPM Stephen Hemminger
> > <stephen@networkplumber.org> wrote: =20
> > >
> > > On Tue, 1 Apr 2025 09:50:46 +0530
> > > Nitin Saxena <nsaxena@marvell.com> wrote:
> > > =20
> > > > +int rte_node_mbuf_dynfield_register(void)
> > > > +{
> > > > +     struct node_mbuf_dynfield_mz *f =3D NULL;
> > > > +     const struct rte_memzone *mz =3D NULL;
> > > > +     int dyn_offset;
> > > > +
> > > > +     RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_dynfield_t) < =20
> > RTE_NODE_MBUF_DYNFIELD_SIZE); =20
> > > > +     RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_overload_fields_t) <
> > > > +                      RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE);
> > > > +
> > > > +     mz =3D =20
> > rte_memzone_lookup(NODE_MBUF_DYNFIELD_MEMZONE_NAME); =20
> > >
> > > Seems wasteful to have a whole memzone for this, the data is small.
> > > Is there a reason it could not just be a global variable like timesta=
mp.
> > > =20
> > Replaced usage of memzone with global variable in v2 =20
>=20
> We need to use memzone to share the offset between primary and secondary
> processes I don=E2=80=99t see any other way.


Normally secondary just uses dynamic field lookup to find the offset.
