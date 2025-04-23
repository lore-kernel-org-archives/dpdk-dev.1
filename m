Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87EFC369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 20:45:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84FBF40156;
	Wed, 23 Apr 2025 22:45:03 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id EF547400D5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 22:45:01 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so308012a91.2
 for <dev@dpdk.org>; Wed, 23 Apr 2025 13:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745441101; x=1746045901; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jSWcvu5f+83Bisezfz9b4QadLonO0ztBw3hfDVx4jag=;
 b=Xq+BB867m5XO6Y4oj/D3QrNWz6Dqc55KvlYqTGoLZ/hIhnTswlITHKgS2Q0lZHfgCt
 XljMybefkyDph3VheHzshyN/eeM2duPmv0TNZhIpZevH2egu6U2UNmEKZsS/qJYFAmmz
 EMyarP8WEO12qwjFpeJRKz6Av7/DYHhI0W47w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745441101; x=1746045901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jSWcvu5f+83Bisezfz9b4QadLonO0ztBw3hfDVx4jag=;
 b=ehVjCqvlzYcSoNBZR/T15NndRAjnmA0jFo8puF0fLrq9FZ2HCuG229TVBaHZQniEP3
 23/5ZJaqXS1g4Bgb7K1uMEREaRlh/qNuu2WXOv5gzZYVwt5iHzN1kzvJcfCPL9oy15+A
 3LaWHlNCWXwp3tg8sFOLyQquEAEQQQkQK7QzWJfZH4ZfVrm2Ec3F2oqrE8U6flNS82yw
 cKzQewlMcdJT4NoegXc9yfhQRnhIJUygzRCjTS3XzlCcNYhDkfEhmmoS4WENPXU7uEF+
 9k48l6AEWipFOyvSOAwVxkITuOTWnfoLbAHprLQrkuiPJcCtUpQMYPSTZsw1sbQM8fMP
 g+Vw==
X-Gm-Message-State: AOJu0Yx6VHuNnta404cZnSJ95X6W21k0yeZXgD4Acr4r1t//LzxnVzI/
 eUKJTUVM+Wnc7weIY3fO7qX+icbHzKMwb56d1z93Sk/fjfWD7KTOeYdrZYIqH8mYohmDzqGR81r
 OHAAGt9dd1gs9p6zpL1lxh75kpredI4OoZZtR/g==
X-Gm-Gg: ASbGncsOHC/gTe0ZRfUuU3s5PMwcnlWM4waf3bBVfZZDSAxm9FwWRkXDdOo6U1nCdfa
 DjxulXeFv49LEdeT/S6lj1zHvz4cqbKioW41Fc5Kce0+uAHotRK5xIjBn0+hKn65cz6yCUtbqb+
 2q26BMBF6foCgx1OEAwL6bOXcQnPbApfUgI9EOPuZoN9Xz3cs=
X-Google-Smtp-Source: AGHT+IFvP8Phxud9ka7A9Z1PIE2cKbi/yygvxJ/co3vAmtCtvqqJMTui/qJrAGss6Qr4d4IzTQOGJDUV7ozYy0WlpHQ=
X-Received: by 2002:a17:90a:e7c5:b0:2ff:5357:1c7f with SMTP id
 98e67ed59e1d1-309ed3424efmr257818a91.30.1745441100964; Wed, 23 Apr 2025
 13:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250103060612.2671836-1-nsaxena@marvell.com>
 <20250421151718.2172470-1-nsaxena@marvell.com>
 <20250421151718.2172470-5-nsaxena@marvell.com>
In-Reply-To: <20250421151718.2172470-5-nsaxena@marvell.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 23 Apr 2025 16:40:40 -0400
X-Gm-Features: ATxdqUFHp9RKzb5U9Hi7bFzp8dfWB8dcadps5V5NxTYdwOiWkYFRvJg8ZyP4IkI
Message-ID: <CAJvnSUD+DWK3CmzgBxUDe63U6BfeHGnBBPAZaxHuUhewRs-FdQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] app/graph: add custom feature nodes for ip4 output
 arc
To: Nitin Saxena <nsaxena@marvell.com>
Cc: dev@dpdk.org, Nitin Saxena <nsaxena16@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ccbe9d0633782c13"
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

--000000000000ccbe9d0633782c13
Content-Type: text/plain; charset="UTF-8"

Hi Nitin,

At the DPDK Community Lab, we inadvertently let CI testing on your patch
run concurrently with some system maintenance we were doing on testbeds
yesterday, and I think the testing on your patch was affected (so you got a
couple fails when you should not have). I'm going to put in some retests
which will correct the record within the next couple hours.

Recheck-request: iol-intel-Functional, iol-unit-arm64-testing

--000000000000ccbe9d0633782c13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Nitin,<div><br></div><div>At the DPDK =
Community Lab, we inadvertently let CI testing on your patch run concurrent=
ly with some system maintenance we were doing on testbeds yesterday, and I =
think the testing on your patch was affected (so you got a couple fails whe=
n you should not have). I&#39;m going to put in some retests which will cor=
rect the=C2=A0record within the next couple hours.=C2=A0</div><div><br></di=
v><div>Recheck-request:=C2=A0iol-intel-Functional,=C2=A0iol-unit-arm64-test=
ing</div></div></div>

--000000000000ccbe9d0633782c13--
