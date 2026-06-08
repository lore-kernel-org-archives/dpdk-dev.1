Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9A3CD6E79
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 17:44:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16752402C5;
	Mon,  8 Jun 2026 19:44:33 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 6394B4029D
 for <dev@dpdk.org>; Mon,  8 Jun 2026 19:44:31 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so6587057c88.0
 for <dev@dpdk.org>; Mon, 08 Jun 2026 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780940670;
 x=1781545470; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oqf3wl0takYwBwUYL955WVOkSULbS4oq58fW31VBwqk=;
 b=EcqqokVQQCLDpPxbYONoKoGQG9o1Af9++baeLwf63HOsRzNWTHGLlICTqxxsng7zmB
 +UY5NeFb7QJBxgVaVEgyDadf46e3ElnjV5l46RJ3a089m8GxnBgsKJBdz4K9OUu+TYgz
 t+gbw/ROj6UbzaRw4QA5NtnadONS4wGd8kLKviOewRiRWvk0P7RAHA6xS9A2T531uB0M
 /3ePkVRclDGhXpxG38dj4ep+aIEK3rP++UD60PFCvf/p9sNsAPxn5TGw4OBvVxQws8S1
 TMrOj2N7vNOIg0VGKxJwJdy2U1q8j2oqhx04NCwo3qwkkJLbI/3iLl12jXVWNgVwZgZT
 UkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780940670; x=1781545470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oqf3wl0takYwBwUYL955WVOkSULbS4oq58fW31VBwqk=;
 b=YV3Eei6m+h6/Br68u3cjlARZIwE/Q2yLqBv9oZnMCPdMvpOY2/A552kj0KBmDOXiKt
 gsGKPCSzOftEluCZzHcI2vRGOTVWkkDkSDUGDwtUJBq+NWo8OJ2dgJ4NwVvs3CdiC7Eu
 CLX1xfP4qKgFPWB5ojwR5W7x1engNhCymJXLyVD8FzT/smb4+e1aZqSw1WRe/xKZXKSN
 gef8GrPBhwuPvQNWpUmeuXPbj+zAfL7IfgNYCt4DSf+u+NWgpxEhJ7+YELhlfFAHdX2T
 JAUiltmqYot/iQ2xqWJ5p3c3IDJrU3TCl/mDf0JzAux66uufih4cg54QyJYQ/BPBghsR
 yAGA==
X-Gm-Message-State: AOJu0YzyU1B9yd7vp2+w4yXn3bAJYh3loNPYAZPhHFvhPVOJX/4WnoHo
 Qrapv++JjPyHrdmDnPGZ7YWfJ+DatdPh2ylZecOkVMqgYFlBMMZhCPWnE/EXN5xPdcQ=
X-Gm-Gg: Acq92OHBRRf6dRR+sZvekvefZoO2Wsd4Gu+jtNqOnP4DDfuaQdP6yn6igXJYd70ce8M
 TTUNRR9GEUfwudYlWJRH6c2zl8r3HOnvgWIX9MV9L0EVaHvqWcOgj0GPrUWkdFXnt1Y+NtHzA9X
 5CRQoyCM4GMsGgsJwRgUgxyz773B9AI2ifGkUm2u7HAJ/po44R5gJ4by/1GT07IudLrBidcdQGc
 rA37zy9KqUABPeQ5hs/1TVneOlMgpgJQX3FHFShvjYycywZ3v8aAGSgYVzWzfR39dOvmZTysk9z
 9WpcYHC0KMC3GxtorPsJinfpq3db57ohJxlFR1/S8mGw0Ps5kfNxQ3H5CzvYp4LrAvyupRY90bs
 8LuDzFUBW8MCzrO+Qqj3KeKYZnscYJhmSfb3xNOL2RiDKWJOjDLosoJoHiY6ULFsVSfOJqXpyg0
 5q9i1n+llgdAjNjPkOuohriOB852KKA+beE/jypAyPk9+XBMAsS9OY98O2GrlZmi69mIxpPdccD
 JQ=
X-Received: by 2002:a05:7022:e01:b0:12d:de3f:f3e6 with SMTP id
 a92af1059eb24-1380675c41cmr6862433c88.38.1780940670056; 
 Mon, 08 Jun 2026 10:44:30 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13828ae3944sm1948288c88.15.2026.06.08.10.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 10:44:29 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:44:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jerin Jacob <jerinjacobk@gmail.com>
Cc: dev@dpdk.org, Pavan Nikhilesh <pbhagavatula@marvell.com>, Shijith
 Thotton <sthotton@marvell.com>
Subject: Re: [PATCH v2 2/3] event/cnxk: add pause to spinloops
Message-ID: <20260608104426.6ceb4ad8@phoenix.local>
In-Reply-To: <CALBAE1PzEtyBzKiKaU83q0OtwRwaCTmqDETsc5NNODDQ9hzauw@mail.gmail.com>
References: <20260121180845.889190-1-stephen@networkplumber.org>
 <20260413164652.33291-1-stephen@networkplumber.org>
 <20260413164652.33291-3-stephen@networkplumber.org>
 <CALBAE1PzEtyBzKiKaU83q0OtwRwaCTmqDETsc5NNODDQ9hzauw@mail.gmail.com>
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

On Mon, 8 Jun 2026 21:19:20 +0530
Jerin Jacob <jerinjacobk@gmail.com> wrote:

> On Mon, Apr 13, 2026 at 10:36=E2=80=AFPM Stephen Hemminger
> <stephen@networkplumber.org> wrote:
> >
> > On SMT systems when a spinloop is done without a pause
> > it may cause excessive latency. This problem was found
> > by the fix_empty_spinloops coccinelle script.
> >
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org> =20
>=20
> rte_pause() translates to YIELD instruction. Since cnxk is an
> integrated SoC and it is a single threaded core, it won't help on
> anything other than adding one instruction bit more latency.
> In general 3/3 devtool is good. Please send a it separate version so
> that 3/3 patches can be merged through the main tree.


It matters if your SOC has SMT where two cores are sharing
and one core is waiting for its partner.
