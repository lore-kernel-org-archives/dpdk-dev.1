Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A6CD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 17:01:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 582A34029D;
	Fri, 19 Jun 2026 19:01:31 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id EC58A40279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:01:29 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-13809223fd4so2563391c88.1
 for <dev@dpdk.org>; Fri, 19 Jun 2026 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781888488;
 x=1782493288; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pgx6BtAS/shrF4Gu+z1OF7lo62KtY0MrlHJKUevw5jQ=;
 b=N2Beo9NewzOlq+vNwLW4tMGwGzqH99aXUIN60xvOuiIjbzcrGNqkFExZENwh9BW+Ul
 T3TgU1NcG/YMpMzWw0iR3IStZhUy5uUEaBdmlNOlgn9DNjCdbIQDK4iDsqtS2w4/mgSb
 hns2PNkSxEXkqsJbBaEZtqM0gqs/slzgMwWkorjE8tFSJOcKaJ0oxLispOyK13GjkqJN
 rSOckBGnBeBGDYwz/SK1I/W+Er02I1QVWYYf4sC0cIfxWRgBrq2bZxvTr/WMW55vb1vF
 gs+dRey8PYLXWK3QF6Jt3inQMDtm9GXjEqXRr+q8qTDHbrfwsJo6I1FSxq5VYDrwMzqA
 k0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781888488; x=1782493288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pgx6BtAS/shrF4Gu+z1OF7lo62KtY0MrlHJKUevw5jQ=;
 b=dy1Y2ZVx4KnPXSPW6gV2GviOJcdbDW31HOxTJpk5uU5X7074/YbztpF4jWazSZ121M
 Q4yuArXqP8ZPdbaXA5keicPRJQeDPEbO9VIDaiVQt4YF4QSOdFiChVLCTrPzqBzkwzdz
 P0e1c7zIsI1EJAioERkzovn2m4dmi1m4u1hohGL1UxYVGVCxo3zo3fLC6qFJ8qfRF9ms
 2A05dd0mQ3PlyHKiEFQId/wNucNfWh7ZOx+4H0GRfaHmnhSUp0DpZFo+o9T9d18lXSup
 g2n7JL+9mKMXI/orFXPBGFUqe+GG8n1nOkcIueJGauWzUdA/4gefSOjifjTQjcUOVuQX
 6x1g==
X-Gm-Message-State: AOJu0YxUgKM1UBCwZLVGLJkNhB/rWbQgvbmUHX7IDVq3fMJdRZYRm+/t
 imZR9+zaaxWja2UQSvXkejyphELQ7/dnHHWlzzPEW9032hEW0pCz3oE4+TN+7PDM/jI=
X-Gm-Gg: AfdE7cnX/qDEMSvUakJ6rls5y19zLA1NqnYf2/sP4ZPtG4vMc47m8SH/+//ETop6qRX
 4dySVzVH/fnbUudwXTNplomd0A0nurDV24UKtejlJneLHglzxRMT/aFDsAz+yItd7jrYWUkyPD+
 lLNwA6+jgWFDJQNhMCcUZ23AKiN30Mjx20pABC7fPEEIkQBb7p0mcYbCaxpDvOUOaGLePvMEtbB
 yY4rvoMzkLvr+S1R66vj19y4sSt77gsiYh9VJ7v+KntEyIL9fLPugv0zxii0YklbLzJaKKYC+gX
 mhx4jijlk1wX/0d2XEG3N51Rc+TjDEZMRXUprYBogU5Z8ioJJBgRBxSzaNZriFUAyXSv3cz+0bL
 5ovDN3Ysq15wXTHyygNB65utL4r1rNHm5uuIZ6yyPDzh/Wy/WesoD0ob8dAlqet4AAcmjLkbUHp
 SrHGNachxDk8ONl/Ea9v8QfW1WY3EwLYqVCj44Z+Gjeu8O6RU6gIuwCNIVibF4Rv6Z
X-Received: by 2002:a05:7022:f10d:b0:138:43a4:840a with SMTP id
 a92af1059eb24-139a3880d76mr1751328c88.28.1781888488157; 
 Fri, 19 Jun 2026 10:01:28 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139a364a83csm1777982c88.11.2026.06.19.10.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 10:01:27 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:01:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, "Konstantin Ananyev"
 <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH 2/6] ip_frag: discard datagrams with overlapping fragments
Message-ID: <20260619100124.655e5540@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6592A@smartserver.smartshare.dk>
References: <20260616210656.464062-1-stephen@networkplumber.org>
 <20260616210656.464062-3-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F6592A@smartserver.smartshare.dk>
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

On Fri, 19 Jun 2026 15:12:21 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > +		/*
> > +		 * Overlap with an existing fragment. Per RFC 8200 section
> > 4.5
> > +		 * (and RFC 5722) the datagram must be discarded; the same
> > is
> > +		 * applied to IPv4. Free all collected fragments, drop this
> > one,
> > +		 * and invalidate the entry.
> > +		 */
> > +		if (ofs < fp->frags[i].ofs + fp->frags[i].len &&
> > +				fp->frags[i].ofs < ofs + len) { =20
>=20
> This only catches fragments that are smaller than existing fragments, i.e=
. fit within one of the existing fragments.
> It should be:
> if ((ofs >=3D fp->frags[i].ofs &&
> 		ofs < fp->frags[i].ofs + fp->frags[i].len) ||
> 		(ofs + len >=3D fp->frags[i].ofs &&
> 		ofs + len < fp->frags[i].ofs + fp->frags[i].len)) {
>=20
> > +			ip_frag_free(fp, dr);

The code here is comparing an incoming fragment N against existing fragment=
 E,
using half-open ranges [start, end).

The test in the patch is symmetric in N and E.
       ofs < e.ofs + e.len && e.ofs < ofs + len

The one you propose tests that either endpoint of N lands inside E.

Take a fixed stored fragment E =3D [200, 400) and run several incoming frag=
ments through both.
 N0 =3D ofs, N1 =3D ofs+len.

N inside E: N =3D [250, 300)

E:        |=3D=3D=3D=3D=3D=3D=3D=3D=3D|        (200..400)
N:           |=3D=3D=3D|           (250..300)

Patch: 250 < 400 && 200 < 300 =E2=86=92 T && T =E2=86=92 overlap.=20
Proposed: (250=E2=89=A5200 && 250<400) =E2=86=92 T =E2=86=92 overlap.=20
Both agree.

N encloses E: N =3D [100, 500)

E:        |=3D=3D=3D=3D=3D=3D=3D=3D=3D|        (200..400)
N:      |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D|      (100..500)

Patch: 100 < 400 && 200 < 500 =E2=86=92 T && T =E2=86=92 overlap.
Proposed: (100=E2=89=A5200 && =E2=80=A6) =E2=86=92 F, (500=E2=89=A5200 && 5=
00<400) =E2=86=92 T && F =E2=86=92 F, so F || F =E2=86=92 no overlap, MISSE=
D.

This is the case the new version version drops. Neither endpoint of N (100 =
or 500) sits inside [200,400),=20
because N straddles E completely, so new version endpoint-in-E check fails =
even though the ranges clearly overlap.=20
Patch version catches it because the interval test doesn't care which range=
 is larger.

N partial on the left: N =3D [100, 300)

E:        |=3D=3D=3D=3D=3D=3D=3D=3D=3D|        (200..400)
N:      |=3D=3D=3D=3D=3D=3D|             (100..300)

Patch: 100 < 400 && 200 < 300 =E2=86=92 T =E2=86=92 overlap.
Proposed: (300=E2=89=A5200 && 300<400) =E2=86=92 T =E2=86=92 overlap.=20
Agree.

N partial on the right: N =3D [300, 500) =E2=80=94 symmetric to the above, =
both catch it.

So on the four genuine-overlap geometries, your suggestion catches all four=
 and his misses the enclosing one.=20
That is not right since the enclosing overlap is a legitimate attack shape =
(a big fragment overwriting a smaller stored one).

There is another issue.
The >=3D on the exclusive end produces a false positive on fragments that m=
erely abut, which is the normal case.
Take E already stored as [1400, 2800) and an in-order-but-late fragment N =
=3D [0, 1400) arriving after it (ordinary out-of-order delivery):

N:      |=3D=3D=3D=3D=3D=3D|             (0..1400)
E:             |=3D=3D=3D=3D=3D=3D|      (1400..2800)

These share no bytes; byte 1400 belongs only to E.=20
Patch: 0 < 2800 && 1400 < 1400 =E2=86=92 T && F =E2=86=92 no overlap, corre=
ct.=20
Proposed: (1400=E2=89=A51400 && 1400<2800) =E2=86=92 T && T =E2=86=92 overl=
ap, wrong.=20
This test would discard a perfectly valid datagram whenever a left-abutting=
 fragment arrives after its neighbor.
Adjacent fragments abutting is what fragmentation produces by design, so th=
is would fire constantly under reordering.

Bottom line: the patch was correct as far as I can tell.
