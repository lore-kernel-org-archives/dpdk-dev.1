Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9360FE6689C
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 22:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9EC14060A;
	Fri, 19 Dec 2025 23:05:31 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id D63164027A
 for <dev@dpdk.org>; Fri, 19 Dec 2025 23:05:29 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2a2ea96930cso22912345ad.2
 for <dev@dpdk.org>; Fri, 19 Dec 2025 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1766181929; x=1766786729; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yUbLgY28BKQmvGFfLNsYDwOYIp8zJUNSUkKH3XG6Gp0=;
 b=Wgo7cFwjtk+BqFNEmolRbttrS3Fr2QLErRRIzgYYiX3307pPPgseqdLIuaRcBp7oPU
 TG8HTZCzPlHOr13S9L29yMqf1h8Q8lu8avZMsKRr+0Nlp64lwCPaMgVlhIkWR5ItTdx4
 c53vUM0DTEu0+oTVMyU9gjUCgXqtviSJw2LUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766181929; x=1766786729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUbLgY28BKQmvGFfLNsYDwOYIp8zJUNSUkKH3XG6Gp0=;
 b=oypbVRmihxdBe7Pjxf+IRMLlq1tlGBzorc9VRWfulP7Ig1PJjFq9dZlzC3Q7lhLEmW
 3oTHwLhOGf41+v4i30tLD18D+/oAjgIB28lVYCtbDskxpK6tdakKq/2xz9qlDxGHt7CI
 8RY+Zhr4JnKq37tEVZhC+T2YFCXkA3rCNjk9Gj6OcEshmqG1pguxiRbDkz1SlvILOuUG
 Qlt/muotCg1zgKVTzYzFItsF+NIS1waHdUfpcHiKufVJICxfUKfm6hYIjzYzUbvAJqiT
 VSSW+fBdagyFbHz+zukRdj6DF7lKGhYPhjsnqvF/F3/ctXmpnmYnpQzRBUIano0Kv7yx
 JmUA==
X-Gm-Message-State: AOJu0YxoF7GXu0fChnJDcZdgq4LenoOT6OBh7aYoMpt+K0vcJ+9carAc
 6vEHtpoUNT/qO8R9nQB0i7lrFVwozJ4XOmNV5ZwJsi6RdvUDYXvK39zwWsAXwoTivaHUbBdg46w
 zZGdLW2y7eTcHzhiNbbVO5WeU7Cz6P/R03jkaY4LwEQ==
X-Gm-Gg: AY/fxX6OAfmOKDpo0uQyKj2+eyK4aJ6LhOZyWNgIFWDd1cuqR/3Op3ElPRaYqg/YTge
 aeiXwZZ8FTq+ht/uNzdTQQJ9X9poBzI/17m6ZX1mVOUQlGA0r/Hr1105l4bVzUI6qdz/1861GUj
 n5ZMUoU0Yc48fIuJyHn+Anlw/nuimIvd4GHcp4axbjwynu4SKPYu0SE9dLhsfzdAbpT0beztq+y
 2w8wib2nWSUkyAA8fKJIxwyWlqQJYq8O0XCgrEZ2LqcTaUztWRscmSO5JtUei5JP4ohkHj7bZND
 SgJvxoGm27EbIEtvrVyM
X-Google-Smtp-Source: AGHT+IFwXqEQ6KLKRhkCIKWw4Q7uPGU1pvCaPg3nhQmLeEFbSzGk6/HA73BFwesD4QusehD4rCUe9aOUiSkwe6ITNLY=
X-Received: by 2002:a05:7022:b88b:b0:11b:b179:6e17 with SMTP id
 a92af1059eb24-121723092d6mr4030856c88.34.1766181928508; Fri, 19 Dec 2025
 14:05:28 -0800 (PST)
MIME-Version: 1.0
References: <20251206182441.68354-1-anurag.mandal@intel.com>
In-Reply-To: <20251206182441.68354-1-anurag.mandal@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 19 Dec 2025 17:03:37 -0500
X-Gm-Features: AQt7F2qsk8-YBpuMJQi4vY_prGEMYcadm43h67i64WjGUvNHSOSafP-E_iANQHg
Message-ID: <CAJvnSUBFF_GC9mn-mHUgYYW=tiq+RszDZPhnU74_rS__1-ZH5Q@mail.gmail.com>
Subject: Re: [PATCH] net/i40e: fix QinQ stripping
To: Anurag Mandal <anurag.mandal@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, stable@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000007530070646554683"
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

--0000000000007530070646554683
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

I am putting in a CI retest - no action is needed on your end.

--0000000000007530070646554683
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0iol-intel-Performance<div><br></div>=
<div>I am putting in a CI retest - no action is needed on your end.</div></=
div>

--0000000000007530070646554683--
