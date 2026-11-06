Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF57606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Wy3rTwwf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE07C40297;
	Fri,  6 Nov 2026 09:23:45 +0100 (CET)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 3A7A14026A
 for <dev@dpdk.org>; Fri,  6 Nov 2026 09:23:43 +0100 (CET)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6b58cb69927so1683470a12.0
 for <dev@dpdk.org>; Fri, 06 Nov 2026 00:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793953423;
 x=1794558223; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ve/KzFtviOyOOBGQMiQ9KZQj633YB6qlizcXKpvy+SQ=;
 b=Wy3rTwwfKG1W0oycBb9ccNByJuXk6D7q4YCmxdtZ5em/JlLkwHxBiVYIm2+OBHCeK2
 h8AWc0cf7hUbaXWZG+aG3vEmnYJydncrRzDCJRHc1gfjCosrZzGrm0Xx5kgOpgqLstSv
 Gw+RU8PIWG2TjQa8Bstpi6tC8eJgAj/LljnSG+83eBPYvYSp4Om2/tjozdqO1iH/2DIS
 uX7JSCKT1/s1jzrtcLZ0A/AcMAxox15tJlbj0B8CTqKkOuIN2ZdArmI+frldkuCXwxNq
 pNgFzqmVBnPWeDnIfhnNi7MmdsczB7eUxzPFYWFWdpy2nfbW4NVvAx0US3jN8Wtgebco
 5MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793953423; x=1794558223;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ve/KzFtviOyOOBGQMiQ9KZQj633YB6qlizcXKpvy+SQ=;
 b=U8eQ5OhGXnhoMyH/QjrVjsgnzE3LquOTn+4/R2dgqI/GpQYNCx2rgHoeD1MXQtzJsr
 y3vSMeoNwbEsCP4T5vecPOXL/cEniCbyN6kLYLY1+ivs6m/GG2JsZJqikO1J3Y3/7E05
 oZxC83hhtyQb2PB8dYP41bp6b7+BcnLiIITVGGCZQ0yBbhSLYJbuWccymyS4nkOps+Su
 1FigmRXDWq5YLNNxL5ijVg4Rih0gixQfwYcLKmF2Kf99g/zSt3DnylTcKKbm+yDhD1FK
 tWis5r+LBEwkB4L7B87ue7QW/cUAN+dYEyDjqPrtc7hX6APFzzwUAE07AUqPOKQZkawA
 +vrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByCEsRAsW1XktUxb+FYH7MB47lXijBmS1KOcnfyvYGvQcSkQn3Rxo6JaA7O18QfXV5j5TY=@dpdk.org
X-Gm-Message-State: APuU4Z8s813OJpT2eVdApAdOmT8bAXbzCbrNMu9Ix31gDGRwWtiYuOD2
 oglJl7KIhU7Vc7E+0z8TMksxQ5RXwNegiNox/jUSRIx23k0HJ0FHathiTgShMtxfk60=
X-Gm-Gg: AYBFou32+WqMXmBnwZaCtLOj+FRwJ+Z8AFsD6sw7hjfeO04lsQUG4OJ6Sdd+sgLm7/E
 pqOv67LcBq8lARyDGVqHpTAQXFrXH0icigi83HfEOoZDtJNsdgrFWD67KDozrqD3cbFzTIJkrdJ
 XWQWBaj9pg/MrabAAjJ06Cs+uNrH9WW/mZjmv4tFS5V7rf+8/IDcBVJ7UjUCbCj11TC2SZ7CK95
 0hlRDyVJCM4qgBWZkKi/WqVNK4PZsBv9GekTsydQ5x/C4A1F3S9BM1V/wJC4UcjFM+6MnwG2Msy
 4fukJJuez5hhwd+uP1Kar//yFsUx8JDxqKuPBsRaNXOaAOjuF3HSMRKS50FFXi/pOhbFlPVlVaf
 B6a11Ojw2LDlIFsUHvfTx/2pO00qvI4nUIsoUMDGSLLdNU6PTXO2NSvLl+6UJy3QvqcZm7jquIc
 albFCWn0PJ8AZUP3e4qLZ2nkSiXuzhMhTv+dXR+suT16IapaNvA9UgAHCpgXosXefhRruvzL1i8
 jgcyB54P31CMlZcCBMG8tZn02IvhyAKkdscoq2Oya4kQxqKp7ZExhy2U8IQXsdWVfCX00nBnG8o
 D+td8FOEovbA1Q+Rd2lIblJEDTBDy6zC/NUWqXP6L60la6ghYJz8sq08aUFzZdmGFtMUyoCpiWn
 CnyI+sPTP0g/ENg==
X-Received: by 2002:a17:906:ef08:b0:c2a:ac35:95fb with SMTP id
 a640c23a62f3a-c4d207639bdmr392318866b.24.1793953422463; 
 Fri, 06 Nov 2026 00:23:42 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664ae569dsm436348a12.16.2026.11.06.00.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 00:23:42 -0800 (PST)
Date: Fri, 6 Nov 2026 09:23:39 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jerin Jacob <jerinjacobk@gmail.com>
Cc: Nawal Kishor <nkishor@marvell.com>, dev <dev@dpdk.org>, Ashwin Sekhar T
 K <asekhar@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] mempool/cnxk: fix halo enable devarg parsing
Message-ID: <20261106092339.064ce3eb@stephen-xps.local>
In-Reply-To: <CALBAE1MQFnyqc5oo+4qM330pFtUVnKVQLZgNdP-_AhTuuYSFXA@mail.gmail.com>
References: <20261030051726.898902-1-nkishor@marvell.com>
 <CAOaVG17Zkb+0Tn7VxF8SuGpoULYU_W64vC=KnLM7YCXGGq3+Pg@mail.gmail.com>
 <CALBAE1MQFnyqc5oo+4qM330pFtUVnKVQLZgNdP-_AhTuuYSFXA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 22:25:26 +0530
Jerin Jacob <jerinjacobk@gmail.com> wrote:

> On Fri, Oct 30, 2026 at 10:13=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > one more reason to have common code for boolean flags. there is a bigis=
h series to do that =20
>=20
> Is your series merged? Stephen, Can I make this patch as Superseded?

Not merged, because series was so large and 26.11 was so big.

https://inbox.dpdk.org/dev/20260914054912.755403-1-stephen@networkplumber.o=
rg/
