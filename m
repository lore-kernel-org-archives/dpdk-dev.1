Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B992C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 15:14:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A2DD40A6F;
	Mon,  7 Apr 2025 17:14:54 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7825640261
 for <dev@dpdk.org>; Mon,  7 Apr 2025 17:14:53 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2240b4de12bso59323935ad.2
 for <dev@dpdk.org>; Mon, 07 Apr 2025 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744038892;
 x=1744643692; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IPJkVPVYn2gJU0XV5OxOCE3yPlgQhTk1zVQxQwOL5M=;
 b=0d7fp/ye9G3i0Bpw47k1uV6FcqGEMBvMNIpWI2hR9BulaWDtpWfosAAHdiqzCk30sV
 8YmTtvf8Abi9rrSBS38y5XwoGWm7x8LwR9K8g0Gcgw0Y4Ws8V3ScyZALEfaJA/GEGmXD
 DWz0nLGu5EuKu8fpVfT3v7Z21oTHy/CMxriuZownZf1NRSb6uPEdBTORBK8bVTGYPw8S
 mTFIU//vq+TAeNSD6qld8UQgPdj+wG0W/8906ZuiuUpQp9l5YLMzA9CulwRYRj70igeM
 +4siUKhtYWhj5LPEGwqGTFUp0L2ApytMvWXNE0XB0kHIVAyfUdhNhtwp1YkHZV0tdz65
 yitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744038892; x=1744643692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5IPJkVPVYn2gJU0XV5OxOCE3yPlgQhTk1zVQxQwOL5M=;
 b=kjJZZP6vJHsGBOvHQaSgpOqMHZhITSyF/8Q0V3GCU3f3tMGWWO4lvUjgI0iiO5yEM1
 VSgEokz8GFf3i3dX4V0RLlgR27Y0a2i/M3uKI2nrQ8U1AyfH/4OfVGo9OVH47BmEN6d3
 +71mXuohbJ3K/ish+EU3rNU7k9P5mf3/xZysAUCuOmZvfVIRmSdEnXJwD03/zQ/tk+AX
 y2cix1ptecl8QnNAyNLGeGdPBVYDQTDpD3toIqiB67H7lHLwB9zD81qILiUnf0jVYxdP
 VM7v50NYfaxzEAzObkWkR5oZOhaZE1JU1fqMRdbJqDtA7FRBEPRU7qZnN0slIaaG9WKV
 /qgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAfo2O5F1efs/Us46Qy2IZjP66n9cOlRRaO1EYnp746vqtZ+Z2PeaqLkUaQn2lDffWH+s=@dpdk.org
X-Gm-Message-State: AOJu0YzxSfft2Se+g1e8b2opZd83BYLhvwV1188WWtJ//swKdeaXp3I9
 7gpJBWjDsBOoadgAAE4OewY+EaNtw2Y8tI4rW/XYU7ejy8U55dJlI+1dLnak72M=
X-Gm-Gg: ASbGncvMW6FEN7GyNAFEaQDbUGvqw1dSG8ezJ6nBp6egu310M2NKvHuwnGnhbb01+Xd
 KVLA3OSdyHTOMhmw7aDUrNEsUG7znTiodvguPNM/ly+R9+1fSY+BUWDIUpv4PphrxyKbew0fZJ/
 /G8NnUy5kl9VHV5xTCmCc9PqfByZ+rw3FcXsus6edExmua8YjZWZVOoFziU4aRIxVfNXtukeMHi
 jPS9oQRCGUsV4XoEK+4Nqy4SZMXXnLH+xVRp2oYOsGbyicm1S15gCtAoSL+8w98VZftKjw7mFz4
 SJTSkrxpABo2OiT6DQwUf81XoCqbN0g4K3qKkpHmhngd1FiAIimCtse2/l2FM4tINAhZm06LqWy
 CM5G7dwg2ASgDsqoN4UN5
X-Google-Smtp-Source: AGHT+IEloTmuOzZBZE9FtgNLV/W/Wo3C+qEvgsboGrvN4274EcZQxEFyd8xKliKZ4bVSNHJiBPQwww==
X-Received: by 2002:a17:902:e952:b0:223:37ec:63d5 with SMTP id
 d9443c01a7336-22a8a0659fcmr188477895ad.28.1744038892554; 
 Mon, 07 Apr 2025 08:14:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c015fsm82236685ad.56.2025.04.07.08.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 08:14:52 -0700 (PDT)
Date: Mon, 7 Apr 2025 08:14:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>, "David Marchand"
 <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 0/3] allow easier use of high lcore-ids
Message-ID: <20250407081450.6a1e726c@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FB99@smartserver.smartshare.dk>
References: <20250313113829.1480907-1-bruce.richardson@intel.com>
 <20250324173030.3733517-1-bruce.richardson@intel.com>
 <Z-vzAS8TXWn9WSV0@bricha3-mobl1.ger.corp.intel.com>
 <CAJFAV8zcFU_K0feJMK=YEouyxYxwURUPQq7EGcacJ++RxoTuEw@mail.gmail.com>
 <Z_Ofcb4ktAmn2RqJ@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FB99@smartserver.smartshare.dk>
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

On Mon, 7 Apr 2025 12:15:13 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> > Sent: Monday, 7 April 2025 11.49
> >=20
> > On Mon, Apr 07, 2025 at 09:04:05AM +0200, David Marchand wrote: =20
> > > Hello Bruce,
> > >
> > > On Tue, Apr 1, 2025 at 4:08=E2=80=AFPM Bruce Richardson
> > > <bruce.richardson@intel.com> wrote: =20
> > > >
> > > > On Mon, Mar 24, 2025 at 05:30:26PM +0000, Bruce Richardson wrote: =
=20
> > > > > Traditionally, DPDK has had a direct mapping of internal lcore- =
=20
> > ids, to =20
> > > > > the actual core numbers in use. With higher core count servers =20
> > becoming =20
> > > > > more prevalent the issue becomes one of increasing memory =20
> > footprint when =20
> > > > > using such a scheme, due to the need to have all arrays =20
> > dimensioned for =20
> > > > > all cores on the system, whether or not those cores are in use by=
 =20
> > the =20
> > > > > app.
> > > > >
> > > > > Therefore, the decision was made in the past to not expand the
> > > > > build-time RTE_MAX_LCORE value beyond 128. Instead, it was =20
> > recommended =20
> > > > > that users use the "--lcores" EAL parameter to take the high- =20
> > numbered =20
> > > > > cores they wish to use and map them to lcore-ids within the 0 - =
=20
> > 128 =20
> > > > > range. While this works, this is a little clunky as it means that
> > > > > instead of just passing, for example, "-l 130-139", the user must
> > > > > instead pass "--lcores 0@130,1@131,2@132,3@133,...."
> > > > >
> > > > > This patchset attempts to simplify the situation by adding a new =
=20
> > flag to =20
> > > > > do this mapping automatically. To use cores 130-139 and map them =
=20
> > to ids =20
> > > > > 0-9 internally, the EAL args now become: "-l 130-139 --map-lcore-=
 =20
> > ids", =20
> > > > > or using the shorter "-M" version of the flag: "-Ml 130-139".
> > > > >
> > > > > Adding this new parameter required some rework of the existing =20
> > arg =20
> > > > > parsing code, because in current DPDK the args are parsed and =20
> > checked in =20
> > > > > the order they appear on the commandline. This means that using =
=20
> > the =20
> > > > > example above, the core parameter 130-139 will be rejected =20
> > immediately =20
> > > > > before the "map-lcore-ids" parameter is seen. To work around =20
> > this, the =20
> > > > > core (and service core) parameters are not parsed when seen, =20
> > instead =20
> > > > > they are only saved off and parsed after all arguments are =20
> > parsed. The =20
> > > > > "-l" and "-c" parameters are converted into "--lcores" arguments,=
 =20
> > so all =20
> > > > > assigning of lcore ids is done there in all cases.
> > > > >
> > > > > RFC->v2:
> > > > > * converted printf to DEBUG log
> > > > > * added "-M" as shorter version of flag
> > > > > * added documentation
> > > > > * renamed internal API that was changed to avoid any potential =20
> > hidden =20
> > > > >   runtime issues.
> > > > >
> > > > > Bruce Richardson (3):
> > > > >   eal: centralize core parameter parsing
> > > > >   eal: convert core masks and lists to core sets
> > > > >   eal: allow automatic mapping of high lcore ids
> > > > > =20
> > > > Ping for review.
> > > >
> > > > At a high level, does this feature seem useful to users? =20
> > >
> > > This seems useful, though I am not I would touch the existing =20
> > options. =20
> > > I would have gone with a simple -L option (taking the same kind of
> > > input than -l but with new behavior), and not combine a flag with
> > > existing options.
> > > =20
> >=20
> > That would be an easier patchset to do up. However, it would then mean
> > that
> > we have no less than 4 different ways to specify the cores to use: "-
> > c",
> > "-l", "-L", "--lcores" - and therefore need 4 different sets of parsing
> > options for them, and more checks to ensure we have only one of the 4
> > specified in any run. That's why I chose the modifier option, and to
> > try
> > and consolidate the core setup a bit.
> >=20
> > However, if having a completely new option is preferred, I am happy
> > enough
> > to do up a different patchset for that.
> >  =20
> > > I scanned through the series, not much to say.
> > > Maybe add a unit test for new cmdline option.
> > > =20
> > Sure. Once it's decided what approach (if any) to take, I'll do up a
> > new
> > patchset, taking into account any relevant feedback on this set.
> >=20
> > /Bruce =20
>=20
> Changing the EAL parameter parser to a "two pass parser" makes sense.
> I think checking for existence of more than one lcore specification optio=
ns should suffice; we don't need to accept multiple lcore specification opt=
ions and check for conflicts.

There already is a first pass to catch log parameters, could the offset arg=
 be handled there?

> When remapping, do we need to support gaps in the "lcore" (logical cores)=
 array, e.g. for secondary processes, or can it be continuous from 0 to the=
 number of specified lcores?
>=20
> And are new EAL parameters for this really beneficial?
> Doesn't e.g. "-l 0-9@130-139,100@140" suffice?
>=20

