Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBA3E9A02C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Feb 2026 17:13:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6EF940269;
	Wed, 18 Feb 2026 18:13:29 +0100 (CET)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 8A4604014F
 for <dev@dpdk.org>; Wed, 18 Feb 2026 18:13:28 +0100 (CET)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-896fa834290so911166d6.1
 for <dev@dpdk.org>; Wed, 18 Feb 2026 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771434808;
 x=1772039608; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBZF/nc3mPYssIeUs2rTyGWP+smXnJx99cV9Fd7wRFQ=;
 b=db6O6SMdumDRjchuD6DnMQjhrvu3WSFnW3JU40PmdZad41/n2uKdQ3Kd/UwWIzaJ5u
 s2/0pcdfdQx10e2no6rezcirWNFHOeRoiAiD8OKgrwp/kZ7JPP2Vxo1w5c3YwcVrqBKP
 kUAlVBvYoQU/mGHMu/HKnWaWJw8E0vrQLSl8aP8OxUaYrlI3XdUeSdF+4+KOQ0oLxG6L
 mAPt8xa0hKtjDza1yxKTbBFfXJ5mX9TXqQDYjtsr0agBNlJGGTqgaKhAnySw0vW7lCHA
 zxMH5Cw4/91JyWyv3xJS4LOnljXwqiHsRzJrDT/kzQv3soiz9ulTZA7G3nAg/n4Awhrf
 HWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771434808; x=1772039608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HBZF/nc3mPYssIeUs2rTyGWP+smXnJx99cV9Fd7wRFQ=;
 b=bdd7QsHsEIGRbf5sNKn/xjlpFU7qWZAMsyd6G6Yug+zMJiwrgbBMFCVl6uRwARSNsw
 gaYS7u49bDD+B8jD3ToZuUuIQzdVg8a1TRR8sQk+1aXWmgUjhlBrLUOEn8844J8b9h2y
 tuJe3A59i+uBXXkVb4RyFX/5udScKGIj9mympghGDg1K72NsVFv8FFOjF9UgqSPWQ1gt
 zDXWRH/h8mMwwSu6Vq+mBAhHbAWBofVruzmSLwP9OAsRKgUzddbvu6IK4E/C+nh/bWCr
 A5AMU/uIe7K+Vsu+RTcQVVpUsXa5tiOWKevo0VzJIZNynICyHffwbJqQLzAa23ZCI3Q8
 6+hw==
X-Gm-Message-State: AOJu0Yw9cf5JyKSBqNM/J+jml3OwXEzS46vTL9Wn8WLXO1TkF0p9bB1t
 BSaT/cFLal468UAK2xHWxYVFkj5h5ojns+SJ0E9AqVLGPsPR60Zl6NujNPMV9zKz4a0=
X-Gm-Gg: AZuq6aJHnBZDVvxKUGlhOEs1pBVYo8D6wsDIfQhNGFTjzRuN8XxMHZcyuSEH1HuaJmG
 wzzCI+ezUZhYZKHoQmFEigoWaWPtNMU9fIOekOJ7Dc8lp8fk90g7zPQwZpXA62TUCAhfHKMr3oY
 +76rsBs9uMJkeQRq/m0QIruQ2guZW4MrIdu7qK4ZKyZGFW90mdF4Y/rrur+eM+UR9w30J0uA8ho
 n0tOdGSqdsph2KFZlE9Kut9DW9islF6QJdVC8NfZsnbMRi2e/jU4h/iQNjzPux5IWR30XKh+7Sh
 JGM+lK4+ux9jN1QryPgqIDvLajbtK2rBbvk9we9jozN/Thcq7JakN/efN2VAnNlLXG6LpuJ4Lxd
 hAFHfSd+vgDU2/+YbUJGsPp0i6iGVQ2A1gGxdNTzzXWl9+Roh3Oo7TFsC0C4naWv+kVcCIXq43c
 PVdTXxlTIZ42A160Q+sctPrF6DkjXMBzd6vml3avYvPzXRR4wWz+C/hn5AAfEkNCdI
X-Received: by 2002:ad4:5cc5:0:b0:87c:19af:4b76 with SMTP id
 6a1803df08f44-89957e17c8bmr37363216d6.17.1771434807664; 
 Wed, 18 Feb 2026 09:13:27 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0bc2d5sm1859418885a.10.2026.02.18.09.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 09:13:27 -0800 (PST)
Date: Wed, 18 Feb 2026 09:13:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>, "Thomas Monjalon" <thomas@monjalon.net>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [RFC] ethdev: clarify rte_eth_tx_burst() return value and
 ownership semantics
Message-ID: <20260218091324.17a671dd@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65728@smartserver.smartshare.dk>
References: <20260216180011.393782-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65728@smartserver.smartshare.dk>
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

On Wed, 18 Feb 2026 09:48:04 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > + *
> > + * A return value equal to *nb_pkts* means that all packets have been
> > + * consumed, and this is likely to signify that other output packets
> >   * could be immediately transmitted again. Applications that implement
> > a
> >   * "send as many packets to transmit as possible" policy can check
> > this
> >   * specific case and keep invoking the rte_eth_tx_burst() function
> > until
> >   * a value less than *nb_pkts* is returned.
> >   *
> > + * If a packet cannot be transmitted due to an error (for example, an
> > + * invalid offload flag), the driver must still consume it and free
> > the
> > + * mbuf, rather than stopping at that point. Such packets should be
> > + * counted in the *tx_errors* port statistic. =20
>=20
> The above paragraph is driver centric, it should be application centric.

Most of the applications are doing it right already since everybody
starts with l2fwd, or l3fwd. The problem I see is buggy drivers.

> Suggest rephrasing as:
>=20
> If a packet cannot be transmitted due to an error (for example, an invali=
d offload flag), the rte_eth_tx_burst() function will still consume it, rat=
her than stopping at that point.
> Such packets are counted in the *oerrors* port statistic.
>=20
> NB: In struct rte_eth_stats [1], the error counter is named "oerrors", no=
t "tx_errors".
>=20
> [1]: https://elixir.bootlin.com/dpdk/v25.11/source/lib/ethdev/rte_ethdev.=
h#L273

Good point, I was thinking of the per-queue stats and xstats.

> While discussing details...
> Let's say a packet has 4 segments, and the driver only has 2 descriptors =
remaining available.
> In that case, I think the driver should not consume the packet, but leave=
 it for the application to either drop it or retry transmitting it later.
> Do we want to mention this case too, or is it a semi-obvious case of the =
descriptor ring having no more room?

There are also other cases of backpressure like when driver talks to kernel=
 and gets EAGAIN or EBUSY

