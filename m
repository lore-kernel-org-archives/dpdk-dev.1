Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DD4CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 18:16:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B602E4042F;
	Fri, 22 May 2026 20:16:26 +0200 (CEST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id 51DC9402B8
 for <dev@dpdk.org>; Fri, 22 May 2026 20:16:25 +0200 (CEST)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2f33ae12f97so1464766eec.1
 for <dev@dpdk.org>; Fri, 22 May 2026 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779473784;
 x=1780078584; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaSHOCerjhfbeZ36EME4BEP8RCI7CJaPzPv6shCWlSk=;
 b=w/0eViLVCe3WooUIhrp+erx4uoRA5S9ok5c4wGChU7rL2lnxIiuI7EnHw/oAs6iFFL
 JL0Nd7W/h0PDe5F+IKv88Mh0/8wuuwV2h6UP7ecHL0o5OsSupwcGfY1ortmCZAJ9mqNZ
 rf9PyjArCqeLAy/RqusJz5NS9wlODoooE8JYWcSdEnP0nzLpg5zd1GgUL7Glk7zy7QhF
 m2Ge7fIyqaehtsIwK9xZK1FsAsAJe6Ser2H7aGvkHH/8QW/hP74JF6WB83VxFzpdDGyE
 Qzn4TyOpXRLYqRs9exNQnbjaBmDtrl3zrOLhRku3m+zg8vJFYb1vuZiEulcb0hx4VMEC
 /JHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779473784; x=1780078584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CaSHOCerjhfbeZ36EME4BEP8RCI7CJaPzPv6shCWlSk=;
 b=GtyXzfpwNW3Bf4R/6Z6Av3xBAf0Sclmd438+4UKq5YYW3TFuVuzYu8bfrNCx7RhDvW
 +vdk/GjJaQ/9xRs7vSwP0uB+dICRqHI7hBGbDtoXAnlY1U6nuiR42uqAfKKRLAHY49QO
 uRYAyRejTxmmHePP5mllb/MrcAoSQ/w3AsjQZICaQurTxYLioxKeaKGXBFYdD8aAmJGB
 0US+JS3W0VfdnTfU/K7J7p8EVnI2wwgdMFRTWjV0j0hRRh8vXdh5m0USsbUTIj8BJR0p
 niWkwx0LCjIc8rj/eMQkRbHMqeWB3sEiGNNItGBkYo4Z0YMmvWJU2nhRWiCJmzy0jZ9N
 l1qg==
X-Gm-Message-State: AOJu0Yz0T+NwneA9M2znt3foPBoAHmenxPYNJpvh47zt5RFZKynOtLhC
 oZ7fzFuhEJrZyojg6ZDZK1yrCiURxkDzyZOEFocrZdcrJRmuHCz7JOgSaIPqqqgjHsPC+tzkEtm
 o9LH1
X-Gm-Gg: Acq92OGUr3yr1FKrcFSjTMDC0wriOaqdONq7k7/JQLsWyKf58FZoNZmjPNittKdZleY
 bxvWLZk2f9jrCS7dujYx1DPEkC18YPrt0WrSvW6FQbHir8oL6WS5Sjdk4IwDhMx1u6YTk14aKOv
 EXecA0g4/VrLUvwwXVFtFNMzI6Cn3tPAVKltPM4oGZWbyZGFaBu653T3lAjwMzuv907PJOO4lwF
 rZkjG/Z3GfWxXmaL6KCTvHgdGGFkmb6oZt1dw7glyjnXGcDdife2rekLPHlGRV8bz13Cm5GQen+
 /oM79M+tgm6sYR/WnOmHFLQlLsFDBNwVVO26Nn/j7BCtK1IiSLbQjkZ81nHkUBKicg4kMgWpVsh
 UqJyDZMSaZcX1DLx7vnndk9tXKrAOfzclHW+DtvK5pdFRO5LyUqOIv/8B25Rr+nAktzB/RTJ3dF
 76/k6tFYNzdR6AF8O4RIPklRW9j7RJAfzj4hqJy46x4K/jqbJUbmH+h9RcPEAq9CQK
X-Received: by 2002:a05:7301:6003:b0:2c5:60d0:701e with SMTP id
 5a478bee46e88-30448ffd0e8mr2619311eec.3.1779473784077; 
 Fri, 22 May 2026 11:16:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452259de0sm1513122eec.22.2026.05.22.11.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:16:23 -0700 (PDT)
Date: Fri, 22 May 2026 11:16:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH 0/3] flow_compile: textual flow rule compiler
Message-ID: <20260522111621.12540f0c@phoenix.local>
In-Reply-To: <CAPQRu6GMtF1B24vaOA1Er7j2iB5HpmCP9CAAcbj_T6FmXys6Eg@mail.gmail.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
 <20260506033338.480610-1-stephen@networkplumber.org>
 <CAPQRu6GMtF1B24vaOA1Er7j2iB5HpmCP9CAAcbj_T6FmXys6Eg@mail.gmail.com>
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

On Fri, 22 May 2026 17:27:26 +0200
Luk=C3=A1=C5=A1 =C5=A0i=C5=A1mi=C5=A1 <sismis@dyna-nic.com> wrote:

> (My) original idea was to reuse one parser for both the testpmd and the
> library to avoid multiple implementations of essentially the same thing.
>=20
> How would "flow compile" be useful if testpmd already has the "flow creat=
e"
> command? Perhaps as a library demo only? I would expect testpmd users to
> like the `flow create` endpoint more for its more comprehensive support.
> Similarly, at this moment, since testpmd supports interactivity, I cannot
> see how the `_compile` API would replace functions in testpmd. But perhaps
> it would be part of a greater effort to migrate to flex/bison solution.
> Since this is also a simple, single-rule, stateless parser, it is not ful=
ly
> compatible with all of TestPMD's commands (e.g., "set raw_encap"). (Ok,
> noticed, you highlighted this)
> Perhaps it is fine, just wanted to highlight this.
>=20
> From the user-as-an-engineer's perspective, I would be generally happy for
> this parser to exist. The drop-filter feature in Suricata, in my view,
> requires just a simple network pattern specification so looking at the
> supported patterns already ticks off most of the items I've had in mind,
> except, e.g., MPLS. I can also see this as a viable way for Suricata
> user-specified decap options for better applicability of RSS.
>=20


I am taking this is in a slightly different direction in next step.
The syntax of testpmd filters is just raw expression of what rte_flow items
are. The compiler should not need all the seperators and end marker.
It should be user friendly and hide the internals not expose them
