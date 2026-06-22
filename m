Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D54CDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 15:04:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C773840652;
	Mon, 22 Jun 2026 17:04:05 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id E787340647
 for <dev@dpdk.org>; Mon, 22 Jun 2026 17:04:04 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-13809223fd4so4989108c88.1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782140644;
 x=1782745444; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmZocy/awv7Pmq6zPQWI0+dhw82MCzoXuMp/mZxEdaA=;
 b=LFeMFqOwIa8pa32Q9L1F859HuQw4pxSgZCCvae1gfHhdFi7HR0/nfYgSwbyPZrPNt/
 I9sIRxGbwozzCGPHNYG2B2wkdLO2vbc+95hNCrtlYm17szMceCKhSVWWWWHL09cQrJ5A
 SuHGzyAvPEosPnkFmsml/kbMZ57eF3xtYKHyT1/qDlyuu/WdKlwCBaOMucNLzPg5LH8I
 RrtnwdG6KZPI/lUqqQFegA9KxF5Wkez1/T+pxqV0b9zjRazDVi27J2WOqSb9bpRoZrEc
 /LVjQ730uxGuV5yk6HpkgsWiWtHoH6jeKyM3izGNdcUP2oaC/PuQIGLc/W2w6qvXy3pr
 EGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782140644; x=1782745444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vmZocy/awv7Pmq6zPQWI0+dhw82MCzoXuMp/mZxEdaA=;
 b=duHZcOIisGX9gwxoOHQWBxmJe9oQ643nS+YBVoRE6Q0ZZjISNtR7mHBjz72R7qlPdL
 AZJTsmQF9QMBMfV+9WRfYB1F/qatKuf+Haf/S8SgVZQ7WnId3tDCxdECIEJ40iIaFvp8
 A1QOU+kOy2h1rEp3vm/+13rFFu2zWteQzrpLdBwehVBxuP3NcW+c7bh2EeB/fFlLzcSc
 KCVyUgXrT41OTLX7R3Y9kEeJai/Q4cb3JwNofcfA9V7cF0PBB7I9RiGl83T4UpG6mWja
 z4x74QFUc8gQCzdGwwveAtWZpPn1hr7CfVKvzpPrKj2e5093LIRy/x1LTsKvlGNy54Mn
 f3IQ==
X-Gm-Message-State: AOJu0YxeiuSn17xCio+dtGwCBZwn2zt9HCbv0509PviHdFtTB+DXipYg
 WuqQXLkWMqcY9q4gei16gH9tKe57Kcr78slqG9pFp9lFYaTMvvaGe9F5Uy9R8r63SwMsRSyblWE
 zKQjf
X-Gm-Gg: AfdE7cns9uaFqgH6PVuSFdnTPakyrCYQlKsM7QsKxDVAE3T8Yrn2l7REe098T3N4x3K
 TykF4mL64rlZeWiw+8bPrkr7uHqBCqU2uJ7B+YC6tzzulbFb45bSUmsSvrJcoL07XdH1eDD1rFf
 6I/KqiHOEaqKZChDdBy0sWtazh7UFt/lXWN+dbZs4RFau22ftmfkFlEgmUUqdqf4agt3PpjbQlz
 gxRoDUf7wiehL0/wEukMMZ7BEOy9Xkbh9dKlpWbvcT2rdkLIlLm8sevG/zh69EziIQJC+0pP8Cs
 20+9PfImHgEKx7s/3/nPsTjdNhjVKyoR35VdmwdjlV/7LOIyG1zxZrrvzWJ/0oBtPim85amuj5E
 VRkehQMMfoAKLOwNB9uAwFVFPN6IUTmcLqJg0X05Ga334Zp4lrIIFEMmSlwgHzb6r1HoJvWAs96
 fnD7mV4Fp83vuU61tjNfKaaBSXDvest9yYh9rbqhocoVSiCFuFgJuXCDmhLmXWY2h2
X-Received: by 2002:a05:7023:b02:b0:138:417f:ab79 with SMTP id
 a92af1059eb24-139a386af01mr8138019c88.20.1782140643403; 
 Mon, 22 Jun 2026 08:04:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adcc5f14sm8591469c88.6.2026.06.22.08.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:04:02 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:03:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, "Konstantin Ananyev"
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH 2/6] ip_frag: discard datagrams with overlapping fragments
Message-ID: <20260622080359.28ab3022@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65934@smartserver.smartshare.dk>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260616210656.464062-3-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F6592A@smartserver.smartshare.dk>
 <20260619100124.655e5540@phoenix.local>
 <98CBD80474FA8B44BF855DF32C47DC35F65934@smartserver.smartshare.dk>
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

On Mon, 22 Jun 2026 17:01:18 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Friday, 19 June 2026 19.01
> >=20
> > On Fri, 19 Jun 2026 15:12:21 +0200
> > Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:
> >  =20
> > > > +		/*
> > > > +		 * Overlap with an existing fragment. Per RFC 8200 section
> > > > 4.5
> > > > +		 * (and RFC 5722) the datagram must be discarded; the same
> > > > is
> > > > +		 * applied to IPv4. Free all collected fragments, drop this
> > > > one,
> > > > +		 * and invalidate the entry.
> > > > +		 */
> > > > +		if (ofs < fp->frags[i].ofs + fp->frags[i].len &&
> > > > +				fp->frags[i].ofs < ofs + len) { =20
> > >
> > > This only catches fragments that are smaller than existing fragments,=
 =20
> > i.e. fit within one of the existing fragments. =20
> > > It should be:
> > > if ((ofs >=3D fp->frags[i].ofs &&
> > > 		ofs < fp->frags[i].ofs + fp->frags[i].len) ||
> > > 		(ofs + len >=3D fp->frags[i].ofs &&
> > > 		ofs + len < fp->frags[i].ofs + fp->frags[i].len)) {
> > > =20
> > > > +			ip_frag_free(fp, dr); =20
> >=20
> > The code here is comparing an incoming fragment N against existing
> > fragment E,
> > using half-open ranges [start, end).
> >=20
> > The test in the patch is symmetric in N and E.
> >        ofs < e.ofs + e.len && e.ofs < ofs + len
> >=20
> > The one you propose tests that either endpoint of N lands inside E.
> >=20
> > Take a fixed stored fragment E =3D [200, 400) and run several incoming
> > fragments through both.
> >  N0 =3D ofs, N1 =3D ofs+len.
> >=20
> > N inside E: N =3D [250, 300)
> >=20
> > E:        |=3D=3D=3D=3D=3D=3D=3D=3D=3D|        (200..400)
> > N:           |=3D=3D=3D|           (250..300)
> >=20
> > Patch: 250 < 400 && 200 < 300 =E2=86=92 T && T =E2=86=92 overlap.
> > Proposed: (250=E2=89=A5200 && 250<400) =E2=86=92 T =E2=86=92 overlap.
> > Both agree.
> >=20
> > N encloses E: N =3D [100, 500)
> >=20
> > E:        |=3D=3D=3D=3D=3D=3D=3D=3D=3D|        (200..400)
> > N:      |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|      (100..500)
> >=20
> > Patch: 100 < 400 && 200 < 500 =E2=86=92 T && T =E2=86=92 overlap.
> > Proposed: (100=E2=89=A5200 && =E2=80=A6) =E2=86=92 F, (500=E2=89=A5200 =
&& 500<400) =E2=86=92 T && F =E2=86=92 F, so F
> > || F =E2=86=92 no overlap, MISSED.
> >=20
> > This is the case the new version version drops. Neither endpoint of N
> > (100 or 500) sits inside [200,400),
> > because N straddles E completely, so new version endpoint-in-E check
> > fails even though the ranges clearly overlap.
> > Patch version catches it because the interval test doesn't care which
> > range is larger.
> >=20
> > N partial on the left: N =3D [100, 300)
> >=20
> > E:        |=3D=3D=3D=3D=3D=3D=3D=3D=3D|        (200..400)
> > N:      |=3D=3D=3D=3D=3D=3D|             (100..300)
> >=20
> > Patch: 100 < 400 && 200 < 300 =E2=86=92 T =E2=86=92 overlap.
> > Proposed: (300=E2=89=A5200 && 300<400) =E2=86=92 T =E2=86=92 overlap.
> > Agree.
> >=20
> > N partial on the right: N =3D [300, 500) =E2=80=94 symmetric to the abo=
ve, both
> > catch it.
> >=20
> > So on the four genuine-overlap geometries, your suggestion catches all
> > four and his misses the enclosing one.
> > That is not right since the enclosing overlap is a legitimate attack
> > shape (a big fragment overwriting a smaller stored one).
> >=20
> > There is another issue.
> > The >=3D on the exclusive end produces a false positive on fragments th=
at
> > merely abut, which is the normal case.
> > Take E already stored as [1400, 2800) and an in-order-but-late fragment
> > N =3D [0, 1400) arriving after it (ordinary out-of-order delivery):
> >=20
> > N:      |=3D=3D=3D=3D=3D=3D|             (0..1400)
> > E:             |=3D=3D=3D=3D=3D=3D|      (1400..2800)
> >=20
> > These share no bytes; byte 1400 belongs only to E.
> > Patch: 0 < 2800 && 1400 < 1400 =E2=86=92 T && F =E2=86=92 no overlap, c=
orrect.
> > Proposed: (1400=E2=89=A51400 && 1400<2800) =E2=86=92 T && T =E2=86=92 o=
verlap, wrong.
> > This test would discard a perfectly valid datagram whenever a left-
> > abutting fragment arrives after its neighbor.
> > Adjacent fragments abutting is what fragmentation produces by design,
> > so this would fire constantly under reordering.
> >=20
> > Bottom line: the patch was correct as far as I can tell. =20
>=20
> Thank you for the detailed explanation, Stephen.
> Agreed, and sorry about the noise. :-)
>=20

I will give credit to Claude for the detail. I reviewed the general
code here; but had to prod it into giving a more detailed explaination
because it was confusing..
