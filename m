Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67783CD8C85
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 04:51:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB9D8402AD;
	Tue,  9 Jun 2026 06:51:25 +0200 (CEST)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42]) by mails.dpdk.org (Postfix) with ESMTP id 27843400EF
 for <dev@dpdk.org>; Tue,  9 Jun 2026 06:51:24 +0200 (CEST)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8ccce57762cso53301206d6.3
 for <dev@dpdk.org>; Mon, 08 Jun 2026 21:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780980683; cv=none;
 d=google.com; s=arc-20240605;
 b=RBaJo8Fc/sEDElQqyw/QeX+XX+IJaE6EIr3pJqSE7tcNMytHF9QxU7Z/UEeWAfYfh1
 I2Ky3i3ZGz04x34z9Hae59idKQ8wjCkzdfZqYe7D+allE02IEhRLwe6tdpxd/wL1yf3G
 wQzq5gBItEVj55iDrXK7l7N9BCONNfLufYkabFKA9Mc8peraP77LhGFgARWIJeHiwEwA
 ELlKU0wTry8+e/spWZ47mBlC+L7l0c4cOVsZeX/cjVef1p9fIdk/PsnMVJRgmnuZzBel
 4Uk/d2K5g/MiEZgOOQ5b8zdnPgcdgfoYb8qRRINL4u2L8ubJ3hF9giEPYQRQhpooVBOS
 N6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5uAHkeN4SQNXreW5/oZyPogSrJfODmz83UIFCWra3SM=;
 fh=EWMbXYxloiF25UKa3+132FbIkngNc9Ix7z+odAXt93c=;
 b=J7ed/hey+JsyoxCT2Qi/CvKzuGjpfDfkD4i4ELHbnq2fJc9Q9kD7SDvLblrIkjAxHH
 nFO6lGdajGxylfiUitWhY2pos4nQm1uaCJRWpON4pRkL2H3p83efByV1KeTDhVKXCbdM
 Z7vdCdmHpP7jLvDiG1ItEAvRX/Iw0HpmxPXkRRIDmCQo21D0d5RHlF7Rk+BjYYEjFJj7
 forExHWf8PvrL1akiNiRWOAhUVe/dO6t0a9MTmdPbpYw8AAQCH5Sy7jMMaD7s8oUH3Zp
 EDcG8wl2noEwRnLUrqxkEYfYBaN4tTLBs7Sw+0H6xRDDbkyQIXt755BP8E5g2ahyxdeK
 Ak2A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780980683; x=1781585483; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5uAHkeN4SQNXreW5/oZyPogSrJfODmz83UIFCWra3SM=;
 b=RgYrP6Ct/5Wy/0BxQZPfukRTi/ODt0UgHb4NdTMI834U6637RxT4Th+5t36ckyzvtI
 V3S7amTIzbuRYYZ5KMag0ipTVAdAyJqBwgkRr/lKWd56ZVgnC0iXhDh/q7ytEZhR29uq
 Wb5dEQpwvIIhHiCjbAXFYJRQybeHEtecyl9WtKXB1LgmSLkBwObc3fadLzx5bHqBGUfY
 f9pYwG0i/k7dna5eR68IOh8LtWyn+yA11FIeVI3dnpRMqJHTOhTw3EaaESebyzVy3WBq
 Q/62l4qlWTI92Bz1+SiwDVH48rUCf8GV32Y/KjCZ6uUP8RAVc1fh7SLgtE6/SWF3kkjG
 wKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780980683; x=1781585483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5uAHkeN4SQNXreW5/oZyPogSrJfODmz83UIFCWra3SM=;
 b=dHBQXV6WNQ/bj9sxLJJHdztzHWASk+nPNyUVQRGuixV0LcBpul9NTalLcoo00Re0iI
 v1aoDUlmZ4+Q0DDuIPAm5ioCO7W71BNx9y1QBlwi34YX+aGO3t8EuxEde1uG6Pbmr6tW
 H7aeGMyoBvxBDU3tzes+WwiAZ8xX1IksxGvh6LKGwTvlrc6vFlmaQ56kQkYlx3zw04kg
 xVgnN4bXOg6E00WEJDg4AWv2qPtv3B/5ud5GYLoM7J57N0asM1mQ8i9RjJOs4Ohy6By6
 7eDd3xsAI583CAvSt03y0SB+1X51eAvVgay2LS5TVsdq40QNllQ+kHoBrQva+JYhTp8Z
 TkyA==
X-Gm-Message-State: AOJu0YxyEdVZNTrkcjzwUN8/8WdXjwu5UdiO7Zb9Fmd2j8uObblBa8dM
 zTjQMPe/sRiED/eziKZOk6MKi9wRegYlWBjWQiqV1xCxDuZei1DycKTUHC8mwJpHG++lk0lFAiA
 mkrii5UO/dw2YwNiVKkDc8Cf6Op6J2G4=
X-Gm-Gg: Acq92OEAoQe30mYXD3B1Cdetfw2G8eTNB95Z4czrD1MHWXAj+8wbp5ql6DulrgYQhNx
 3ZlRfu67EemrpZn2C5HDVDVHGV+B5Kq3tpvw5m0c28uKRuGzIpVslnmq9chj5u3/I+tXuNddBj3
 XX56CejhGCoQ//p8sLlxck4IAoc1DlElNP25H4CVAW22S8NAVCTSk3DoIPGnlcDz7vSGdMSRWHG
 LLS9QFp/onAEQ4UhtAW85mIDiCOGgI0kptLW4sGK0bx8hMXY5hg3aYp6BT6WBYd2+G0jQuSuKrR
 FX7k1FFeOcIg2A==
X-Received: by 2002:a05:622a:114c:b0:517:1481:54a with SMTP id
 d75a77b69052e-51795ca0588mr293024751cf.53.1780980683349; Mon, 08 Jun 2026
 21:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260121180845.889190-1-stephen@networkplumber.org>
 <20260413164652.33291-1-stephen@networkplumber.org>
 <20260413164652.33291-3-stephen@networkplumber.org>
 <CALBAE1PzEtyBzKiKaU83q0OtwRwaCTmqDETsc5NNODDQ9hzauw@mail.gmail.com>
 <20260608104426.6ceb4ad8@phoenix.local>
In-Reply-To: <20260608104426.6ceb4ad8@phoenix.local>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 9 Jun 2026 10:20:56 +0530
X-Gm-Features: AVVi8CdrQj4dJ1koJWH8x2VNrC96cubv5Ic21aKCCMsLfsv1r31nbqVqjdU1puI
Message-ID: <CALBAE1PH-rCiaAJhvPfQ=aQXd0QWpp5C-MKjXgQRO_XKffMCZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] event/cnxk: add pause to spinloops
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Pavan Nikhilesh <pbhagavatula@marvell.com>, 
 Shijith Thotton <sthotton@marvell.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jun 8, 2026 at 11:14=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 8 Jun 2026 21:19:20 +0530
> Jerin Jacob <jerinjacobk@gmail.com> wrote:
>
> > On Mon, Apr 13, 2026 at 10:36=E2=80=AFPM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > On SMT systems when a spinloop is done without a pause
> > > it may cause excessive latency. This problem was found
> > > by the fix_empty_spinloops coccinelle script.
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >
> > rte_pause() translates to YIELD instruction. Since cnxk is an
> > integrated SoC and it is a single threaded core, it won't help on
> > anything other than adding one instruction bit more latency.
> > In general 3/3 devtool is good. Please send a it separate version so
> > that 3/3 patches can be merged through the main tree.
>
>
> It matters if your SOC has SMT where two cores are sharing
> and one core is waiting for its partner.

Yes. As I mentioned earlier, it is not cnxk is not SMT so it will not
be useful for cnxk.
