Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4563CD98ED
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 21:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CD27402EF;
	Wed, 17 Jun 2026 23:13:41 +0200 (CEST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by mails.dpdk.org (Postfix) with ESMTP id 2BEFB4014F
 for <dev@dpdk.org>; Wed, 17 Jun 2026 23:13:39 +0200 (CEST)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-39677c80386so2626591fa.3
 for <dev@dpdk.org>; Wed, 17 Jun 2026 14:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781730818; cv=none;
 d=google.com; s=arc-20240605;
 b=KFs0s7AF2ROt93xtA9WqwJ9Tc974zJRf3i5+mU5YSm3mDy3I8HksnHaTJdiCgDUxvd
 NGbaaOqUW9tRKOyuQt1NxOQi6HcUYqWfho/cOVnaeGhL0NWVaYHq4pHt2tDsFzkOA7A0
 B6ruoltjRLRK0RQs4aqHGPjR/M5LAfz1zgGsd+Zud+G9iqZauzIzYz4F8o32ZZ8chS+f
 TxszlmnIwsTeR5/hunGn7ILPjCA+tCZCLHdVvqWkZR6wH8LeBSRguiRqXRJDVw57wJgu
 bI0SFe/V5iIkCZjunWvsQ2eI62DU8sL0L1d2c+eD+Rx8e0Z88oJk+s/4zZ9YgcN7R74+
 6peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TpPklP/+mzJz0CLNHCyU4I38ibDIzJ6EZMSlnluyI1w=;
 fh=L7PlYjTBKKtpJjl+RgwGrNyMHYJxmwrIIqb/mtt1BGc=;
 b=IoUJe+kBQ4S3xAUZik+aaYX6ZOlk2DcfH02EhXc7Nr5A0L0ZeOwiYKb/CGUYF38/K7
 JrTASLe9z0fCUh/X0485A2Qmb8Etuggs5+nGSDpetyO1x+tTiEShaMbYRCKsKL90xdZi
 upVnNh6r5ZKgGsXOf38ipjOqT3z0jT3W7SR9f6uX4VApXIXhUFXk5ju5y0sqjFkITyuZ
 jJa/AkYTYaJn9+6+shPm2/u1+csm51Jpm9MaM1hu4sVKqLaBcbyKytmMYvxjwAvrvwdj
 BSUuwVhNBIS9wGFANJrFJnbekv+V7Naha0aNgZoqir0xipmSxFw0nBIcqS3+SNjFknVW
 g71g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781730818; x=1782335618; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TpPklP/+mzJz0CLNHCyU4I38ibDIzJ6EZMSlnluyI1w=;
 b=CnG9RnLr1i3fsDkRZQySrVdlcuCZhuQOvXKa/hmDHHBHKrmo4IV2039B1sWtdmNc0W
 wTsyFrHPKOb4SHdMtkE9u8xMOSnXxsICh06EsIgsJCajMVgPDw8RZ525IC4dzhOuYt4A
 JcwZweGM72xB2SA829k+Os+tTQg74mVOHPFMXNBfP8T2bO1lt/rh+X7cS+C8HUXLbd9B
 +TlpdUW0RpxIRuppV64y1IV6TtW+9J/Lifh3EdN7Z0cEMqcJ761gaeiTAZ+nYwRQfwqc
 RqvKHeREJ+eK1i9wxl2S2NEnG3Z8rfT66DJS3nx5RoAF8EShDRlWQLAsUT8xNjACw1H9
 pKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781730818; x=1782335618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpPklP/+mzJz0CLNHCyU4I38ibDIzJ6EZMSlnluyI1w=;
 b=mcr4ukXw9Ih6R0rIXhStPasAYJm7s+U9GtslROnLKRTePS0kQIwufwUXOHtf353azj
 guNjbCqY0WBzfabmUdnY1WI4K1mE2jYsbdgpUi3eW+62elRM+IHlejd0j3p2Vfb/5PRA
 ROT673O578yD/LwX1JlFA+f/BFiWPX3YhUbiUQdhGmnWceNKK1nLuILujxPkFwgvMJOL
 o7KH9aB7AuXRv24Sejeim6MEHrY2ogNrxWof6Xp2Bau6xZQBIwORRDYK9oY8M9FdniFf
 sc8Dr7vYLQ5DdQCn2Zm8AnV+cnEwYeePLYIhihEOCu0SUvED9mxDUZac+rQGGDcIdfZu
 cx3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+9hRCoEJN4c7x1xhhjMXsHXfrfOsCUQ/ktXNGpkDgqoSDGbhpRecNq4RZBvY2SfvQNngo=@dpdk.org
X-Gm-Message-State: AOJu0YxuqOCirPemN0Sgd5EG8+XfxhfwhAmtMovoWCDaleG4eVfhUVXl
 Q0r4lsCLuaRFhdi8ItenEF3/uLDQHk/FJyucpkaxn0ud1EFDJTjE2iSvMRU5t36FnqTcbL86RFw
 Q27HT/eEro6Qr5KHG3CiuFoRsAVpBe2w=
X-Gm-Gg: AfdE7clm5IkAsV3NSU8B1t7BEGFUgD43a/XZ9fE0qCtBjRwx/34yFTvegpH0aw1gIr3
 JR2IDW3ox+pTtYqSXeJI4DQrn5TS5O05qIiB1Rh1siqnVAO0GciErr3SNDmAo+ZCi3IHnSwxjIW
 Rx7yu3Cc+s6iv1r+o8Kbrp0VkRHEYJLAmRR25YRu3TagcaOkhaOqpFWHelYNuPHvWYzR3YGW0Wt
 ltzN9nbBzyeKBhR2qtHnpGEzZ+bMkZ6GCno+HYbwFukkwDIEopghbw0j7IZuXxTdbYJRr3rrCva
 qnisNPtAXZTDdiWV7HCMZN5uyFzSUg==
X-Received: by 2002:a05:651c:2207:b0:396:c3c:d27e with SMTP id
 38308e7fff4ca-39969b8224amr16072281fa.12.1781730818214; Wed, 17 Jun 2026
 14:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260507163659.40739-1-abailey@iol.unh.edu>
 <20260513154055.134729-1-abailey@iol.unh.edu>
In-Reply-To: <20260513154055.134729-1-abailey@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Wed, 17 Jun 2026 17:13:25 -0400
X-Gm-Features: AVVi8Cd4reD6P1IzZO5U0Bg7OZxEegYw-pthj-DpDTeIzhWwshBJh-N2BQtAoF8
Message-ID: <CAK6Duxv=rS07Wn9OOv=97DbvRYVNGmydH7_MPkcvXL+_dQC51w@mail.gmail.com>
Subject: Re: [PATCH v3] dts: clean cryptodev environment after a test run
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, lylavoie@iol.unh.edu, ahassick@iol.unh.edu, 
 knimoji@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000814e600654798894"
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

--000000000000814e600654798894
Content-Type: text/plain; charset="UTF-8"

So, some cryptodevs must be unbound from their DPDK driver before they can
be destroyed by linux? Out of curiosity, which devices are these?

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>

--000000000000814e600654798894
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>So, some cryptodevs=C2=A0must be unbound from their D=
PDK driver before they can be destroyed by linux? Out of curiosity, which d=
evices are these?</div><div><br></div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:patrickrobb1997@gmail.com">patrickrobb1997@gmail.com</a>&gt;</di=
v>

--000000000000814e600654798894--
