Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C4C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 15:24:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6308402A5;
	Mon, 30 Jun 2025 17:24:54 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id A529040291
 for <dev@dpdk.org>; Mon, 30 Jun 2025 17:24:53 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4a818fdab84so20482181cf.1
 for <dev@dpdk.org>; Mon, 30 Jun 2025 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751297093;
 x=1751901893; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAHrAzW8y/Lm8rkGr/saiDk48IFWRp9VOjys8zal7hQ=;
 b=X8Jw5XA9XzWHQnCql2om5H9+UxyR9riKQ8tIp0VOdWwpJ3E7WIYC685sYVKZL8ski2
 rb/li5jGCTcc1A0FwofwW0qIWddjXXxSJpBFJdVdH/1+6/a96y3lF0MMoZX9M05XrlLV
 e02lZ9+Iq0GIq47g4J58hHWHM3XMxUdvME/seJvyWQ/9Pzh2OIWcRo1J/KkVZnly59Wj
 NCC7WMWO7z+NiiAbC6yKYtvHO7PO+ycgvxWG5Tq9R/j7ELZ4SORQTENBtQBDdDGfpwiO
 M+24L6X6oSjuD2dY6WjTx/VuNPYHUqmyt0Mu8b4jOGb6X0gSvfBdNG0rZZzUQxaWm9hs
 SrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297093; x=1751901893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAHrAzW8y/Lm8rkGr/saiDk48IFWRp9VOjys8zal7hQ=;
 b=h1rKhIAXIV0ZiArw2vZcFupFVZmO1C033aelMEOKyv9A89ycXxOsj1w++bPdhHym8q
 KLE7RKHiRWvgAXQ39ltWp0clPS/296mye8it41y6HRhFqiR2lKfLdNUpE0sz/WWTQjPf
 W/Sfc2+So0gcgav0f2/yYoJYokBp+aObK2HKo3nNj/Dck6o7d9KvMqfmyvIFseAsWXcq
 B2wTatWjwZmzOGgbsBomYWARm42LdVI/LmfITKjtuk9JUKxG+2q/X/nc3fKooDFvsPD9
 F1oEGc8UduqULXEqIQRX76q+yYRNA44eDqoemZxCjJs6VkP7MvKofhpqqkaZ7PfEM0a4
 GnFQ==
X-Gm-Message-State: AOJu0YzAYE6whPJULtonlV1/S6neNSFIvA0oXddGz1BH+KfpWZz8Fpqe
 itJidVCwtd24JVP9+8XHGD4a/0JGEhU86Hw5m2R7TIACOFVpZU34642IsdQrWMpMxRQ=
X-Gm-Gg: ASbGncv2EkdRJG0t/+jQqsw9oFmx03femMHF/BLmhV9fcA+nqtR0iEgog1LvwQIKYWy
 bP1bBGF/IewPMRcmsgKjjyb6CyAXeBCULrh7VRgCg5rnGHDEnjhZDO4pT9U2Ucoj/xGbVnieuGS
 isJ9I9yYxVdjB82apNLy64ZTV2/oVXQysLqCc/qF+DQFQPhuWd7GQeKN7qNo+SBy0SFHnDQlYug
 dmLo2QZM3aMAJ4P4TidG0/A9rOZurvchXEfaYDWGECCueHMqoBfwMezHP3LYbyiu8MYu3naR96a
 wUES19OcCijen7jfVTfrnZNIz8hodujzrPtTrBEVmfuKEXn4v+1NW4rBFaRfkbIWrqoAMvPCfSy
 P9Tm9rcWy/NSfwVgn9F9R7F6fjXN3To1ybug7ooY=
X-Google-Smtp-Source: AGHT+IGj7AVz/5Bz1A9YKNgBVwGgn/hpVIvekZ83nzsvFiJtSiJX9WYbqM/7TrbtwHeVoQJULT+8zg==
X-Received: by 2002:a05:622a:452:b0:4a7:c27b:9f13 with SMTP id
 d75a77b69052e-4a7fca65535mr247761451cf.23.1751297092569; 
 Mon, 30 Jun 2025 08:24:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc55bd7csm59616021cf.37.2025.06.30.08.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:24:52 -0700 (PDT)
Date: Mon, 30 Jun 2025 08:24:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, <fengchengwen@huawei.com>
Subject: Re: [PATCH v2] test/argparse: change initialization to workaround LTO
Message-ID: <20250630082447.4eb86952@hermes.local>
In-Reply-To: <aGKrNT8h5FGVrBjH@bricha3-mobl1.ger.corp.intel.com>
References: <20250627162305.340042-1-stephen@networkplumber.org>
 <20250630145934.56969-1-stephen@networkplumber.org>
 <aGKrNT8h5FGVrBjH@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 30 Jun 2025 16:20:21 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Mon, Jun 30, 2025 at 07:58:49AM -0700, Stephen Hemminger wrote:
> > When compiled with Link Time Optimization, the existing code
> > generated an error, because the compiler was unable to intuit
> > that there was space in the flexible array.
> >=20
> > In function =E2=80=98test_argparse_copy=E2=80=99,
> >     inlined from =E2=80=98test_argparse_init_obj=E2=80=99 at ../app/tes=
t/test_argparse.c:108:2,
> >     inlined from =E2=80=98test_argparse_opt_callback_parse_int_of_no_va=
l=E2=80=99 at ../app/test/test_argparse.c:490:8:
> > ../app/test/test_argparse.c:96:17: warning: =E2=80=98memcpy=E2=80=99 wr=
iting 56 bytes into a region of size 0 overflows the destination [-Wstringo=
p-overflow=3D]
> >    96 |                 memcpy(&dst->args[i], &src->args[i], sizeof(src=
->args[i]));
> >=20
> > Initialiizing a structure with flexible array is special case
> > and compiler expands the structure to fit. But inside the copy
> > function it no longer knew that.
> >=20
> > The workaround is to put the copy inside the same function
> > and use structure assignment. Also macro should be uppper case.
> >=20
> > Fixes: 6c5c6571601c ("argparse: verify argument config")
> > Cc: fengchengwen@huawei.com
> >=20
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> > v2 - simpler fix is to just inline the copy
> >=20
> >  app/test/test_argparse.c | 31 +++++++++++++++----------------
> >  1 file changed, 15 insertions(+), 16 deletions(-)
> >  =20
>=20
> LGTM. One suggestion inline, in case you feel like adjusting things
> further.
>=20
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> > diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
> > index 0a229752fa..d5b777e321 100644
> > --- a/app/test/test_argparse.c
> > +++ b/app/test/test_argparse.c
> > @@ -71,7 +71,7 @@ test_argparse_callback(uint32_t index, const char *va=
lue, void *opaque)
> >  }
> > =20
> >  /* valid templater, must contain at least two args. */
> > -#define argparse_templater() { \
> > +#define ARGPARSE_TEMPLATE { \
> >  	.prog_name =3D "test_argparse", \
> >  	.usage =3D "-a xx -b yy", \
> >  	.descriptor =3D NULL, \
> > @@ -87,25 +87,24 @@ test_argparse_callback(uint32_t index, const char *=
value, void *opaque)
> >  	}, \
> >  }
> > =20
> > -static void
> > -test_argparse_copy(struct rte_argparse *dst, struct rte_argparse *src)
> > -{
> > -	uint32_t i;
> > -	memcpy(dst, src, sizeof(*src));
> > -	for (i =3D 0; /* NULL */; i++) {
> > -		memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));
> > -		if (src->args[i].name_long =3D=3D NULL)
> > -			break;
> > -	}
> > -}
> > =20
> >  static struct rte_argparse *
> >  test_argparse_init_obj(void)
> >  {
> > -	static struct rte_argparse backup =3D argparse_templater();
> > -	static struct rte_argparse obj =3D argparse_templater();
> > -	/* Because obj may be overwritten, do a deep copy. */
> > -	test_argparse_copy(&obj, &backup);
> > +	/* Note: initialization of structure with flexible arrary
> > +	 * increases the size of the variable to match.
> > +	 */
> > +	static const struct rte_argparse backup =3D ARGPARSE_TEMPLATE;
> > +	static struct rte_argparse obj =3D ARGPARSE_TEMPLATE;
> > +	unsigned int i;
> > +
> > +	obj =3D backup;
> > +	for (i =3D 0; ; i++) {
> > +		obj.args[i] =3D backup.args[i];
> > +		if (backup.args[i].name_long =3D=3D NULL)
> > +			break;
> > +	} =20
>=20
> We should consider either making this a "do { } while" loop or adding the
> termination condition to the "for" loop statement as normal. For example:
>=20
> 	unsigned int i =3D 0;
>=20
> 	obj =3D backup;
> 	do {
> 		obj.args[i] =3D backup.args[i];
> 	} while (backup.args[++i].name_long !=3D NULL);
>=20
> or else:
>=20
> 	obj =3D backup;
> 	for (i =3D 0; backup.args[i].name_long !=3D NULL; i++)
> 		obj.args[i] =3D backup.args[i];
> 	obj.args[i] =3D ARGPARSE_ARG_END();
>=20
> I'd tend toward the second, myself, but what is in your patch above is fi=
ne
> as-is too.
>=20
> > +
> >  	return &obj;
> >  }
> > =20
> > --=20
> > 2.47.2
> >  =20

The long term goal here is to build with LTO during review.
Best if there are no outstanding warnings in that case.
LTO has found some pre-existing bugs because it has wider visibility across=
 file boundaries.
