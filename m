Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF06F5A8D3
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 03:24:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BDEB40296;
	Tue, 21 Apr 2026 05:24:13 +0200 (CEST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by mails.dpdk.org (Postfix) with ESMTP id CA1714028D
 for <dev@dpdk.org>; Tue, 21 Apr 2026 05:24:11 +0200 (CEST)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-38e91416cc0so40567611fa.1
 for <dev@dpdk.org>; Mon, 20 Apr 2026 20:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776741850; cv=none;
 d=google.com; s=arc-20240605;
 b=HP3+ZeXfslUPSz/9NZv9Bch2AfVuU/5dfKJYLksfBKEVcB8VWME7wP226SywG/1c1a
 PC9i2SR8Usr727SM6/1LVj0sa/FEZeOEeTrsKkzfN0l4g44L9OoKVtNV//Dmwc0MuTZc
 lmsEjwdpyOEiW7UXPxBHy2g2x3xDPGKw6L/ACqVNfFQi5CdG8Heu2PE32kpPg8ZPdWPk
 BGcxroqE6KezuityevzqUiMcbKNIH/cPdd2Y9a5GohoZ+eXU6VqQ2B8CLwBT0t46nQmH
 HotbwwQB5AdOrXDiBpfTqubPAiZuARRGXhMCK/yl2vk9e0ae0BQi0k60N6RuGtktjncB
 UoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=3B85HlngO2WCpFs5o+285fe4JySiGncBZarVnwK18p0=;
 fh=UIqApd0RV49lOrATM5rT28EP3mqeGBV6CeswLKUor8U=;
 b=hseXhGAxU0o/p3EQFNGv9Q302jygGwoHsG6JuyZ1Cr4vnbWg8bTIPl+hTHXCaLbL2P
 +3yronWOCCsRHtvfq1Is3oWisg3/asKawOR2KcP3OoEgYAo8iNqpLwbgWMIdBCsC73f4
 aX0EjxXqJ1l81/y9qhd20arKCk34R5h7k8qJgmSZaUx7Yy6RBd+SPnfhfEBQVA0llj89
 36n9dX87gNIwYhfyOYl1G6KSQI44zoOwEqzO1yTZVDOziSiflAnMhcMV/1ADzydgA+ii
 PKAZHVicUnMowegRNXwTz1S0gF6q9KCoyh/Wz8doDENo7MBqQ1iupgYzbs8qNUlBB46/
 /qNA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776741850; x=1777346650; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3B85HlngO2WCpFs5o+285fe4JySiGncBZarVnwK18p0=;
 b=nRaDZRRT13v/qzMPviNHUZe5TIFYlWtPToa9PiEwpOYV4FXi5k4zeqLuCr1rbgov+P
 LKZB14dOXMGY+XGPTVIM03i7ha436/OvfsFsTwvuBQoOKXAXxjXBvdq8g/SlSzw0dzU3
 NOY/jTcwOuffnJmFwZmnum0njAoi17gF48nMQ2bOOmUAXVPibQrTYwsLZalYR5gYoxOC
 xT22HNYlu3+B+j/9Osq5MpRu4uFk5ub3OXVbt+ucu9ni/r/n6IqF1X3HovFxmbWJVQYN
 GVRsJf5b+lT/8+KqOEUIiXq2ahhA7+XT5kldGC7Sool5cH3DDuoBwOtIjDfs+6JcJ8w2
 NG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776741850; x=1777346650;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3B85HlngO2WCpFs5o+285fe4JySiGncBZarVnwK18p0=;
 b=k4uU+t1XcphY3HOcO9vjI/SgEsuMus03yp6UVajczsScNmsNc/u/CTOmS2SCnLYM+h
 YTI0Y9nM3Ycj3ghOEfe3ERoJ8WywQiqTpd3323zMTH+U1UtEnAwY99Vmx5BU0KKRWlHD
 cVvmlEodCTpsrN9FtUKEDbe222mlZRYjo3FTSLU/bSas8iyfq5AJ1hlsYemDaObhZf1/
 j/gpEqpVTBkYbuao86Oncs2VN6+utxESgoO8QqxwVFz15faxXdYmjrHIupnogu/xk2sw
 KR2AcAFMt7GoD/LZ2D5up+A8gQQr6rv81RHbm2TdY2vz5o25RNpHXvtrzn2g6rvzUjcL
 1Gnw==
X-Gm-Message-State: AOJu0Ywohss4HuRIW36ky/hKG5twn16vtu3TyL1/7FkOd3rvuwETcoj8
 Mz/RwEyqAALG7TI7ffyzpCBImhCNY2hjGzPDsfwfBIEghQ4Oaob+43BxwFJH4RZ3MvT3jD5gMjS
 JG2RWif/qOv37DZ8Ps/oRuZmUMMUhGT3+GnEVcWjotA==
X-Gm-Gg: AeBDiesMUqF/jfqtUtA1EDDPim2Zgc9eiM3y10p1Wu6oECYQ8S43UNX3JTXRJ4r3SMD
 LnwyzWDUgKPAWsaprAYzi/Av+qhve9LAYibcf92nEs1Vmz4WBaj7GlSoMUbWQu6B10FC96Cwmui
 4nfvZZfo2jJrHBVc9SasZuX1XvR9OZRQJ1xoi0P693npIke1QdAFGYalzP0wxNOH8sfi6pxUQVt
 xnADzjTvCjL4tE8scIdSChFPZmDRykjFY6V6l4WKT+ZBD/QuEVNiEkamKWokg1ZYwkYiLNUh59k
 f8RqSFdVEuFx369yP+2KEg0UFPsHjOTS+JDz4LebSxBmZ5qx
X-Received: by 2002:a05:651c:3251:b0:38e:35fe:b79 with SMTP id
 38308e7fff4ca-38ec8ff52famr47065331fa.2.1776741850319; Mon, 20 Apr 2026
 20:24:10 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Mon, 20 Apr 2026 23:23:59 -0400
X-Gm-Features: AQROBzB235dbF2DSkdRCcU1z04CnMwM8ni2klLDYrbJ8XZfTRD1RA4PpQ627SB0
Message-ID: <CAK6DuxuEvY-Ddx3ZUUg9BqQ0RP0Wy+h1Coi6saguBTEFi2ydSw@mail.gmail.com>
Subject: DPDK 26.07 DTS Roadmap
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Lincoln Lavoie <lylavoie@iol.unh.edu>, 
 "abailey@iol.unh.edu" <abailey@iol.unh.edu>, dmarx@iol.unh.edu,
 knimoji@iol.unh.edu, 
 NBU-Contact-Thomas Monjalon <thomas@monjalon.net>, Paul.Szczepanek@arm.com
Content-Type: multipart/alternative; boundary="000000000000d88e07064feff2a0"
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

--000000000000d88e07064feff2a0
Content-Type: text/plain; charset="UTF-8"

Here are the roadmap items for the 26.07 release:

1. Flow Offload testsuite:
   1. Adding VXLAN testcases
   2. Support asynchronous mode
2. PvvP virtio testcase
3. GRE testsuite
   1. GRE testsuite and GRE testcases for the flow offload testsuite as
needed.
4. Code Coverage Reports in DTS
5. Additional Cryptodev testsuite features:
   1. Framework clean up and small bug fixes.
   2. Additional algorithms, and additional running modes of
dpdk-crypto-perf (latency, etc)
6. DTS API: Remove all existing framework imports and replace with imports
from the API

--000000000000d88e07064feff2a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Here are the roadmap items for the 26.07 release:<div><br>=
</div><div>1. Flow Offload testsuite:<br>=C2=A0 =C2=A01. Adding VXLAN testc=
ases <br>=C2=A0 =C2=A02. Support asynchronous mode<br>2. PvvP virtio testca=
se<br>3. GRE testsuite<br>=C2=A0 =C2=A01. GRE testsuite and GRE testcases f=
or the flow offload testsuite as needed.<br>4. Code Coverage Reports in DTS=
<br>5. Additional Cryptodev testsuite features:<br>=C2=A0 =C2=A01. Framewor=
k clean up and small bug fixes.<br>=C2=A0 =C2=A02. Additional algorithms, a=
nd additional running modes of dpdk-crypto-perf (latency, etc)<br>6. DTS AP=
I: Remove all existing framework imports and replace with imports from the =
API<br><div><br></div><div><br></div></div></div>

--000000000000d88e07064feff2a0--
