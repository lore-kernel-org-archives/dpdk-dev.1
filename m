Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FAFE7317E
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 01:50:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C7D34028B;
	Tue,  3 Feb 2026 02:50:25 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id F2ADC40151
 for <dev@dpdk.org>; Tue,  3 Feb 2026 02:50:22 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so5354562f8f.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 17:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770083422;
 x=1770688222; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNO8eqy3WbeD4fXGr9EKoHxErZDEZrLDwYlOP1GdVc0=;
 b=J5EAE/mIy1zskcwsK6SLlY8M7Z7DtcKeqTHMKt23m6of2AFDOHJAxvgTh7naiuOrbA
 ZD2rkpqK+2HH6W9sbjE1iAT5coqMO5mwFJAfUBrbqG2cl+DiRXcjURsoCet6gEBq/ZRM
 FqlptYOiZ24bOGKFLvM+lxNLvCSqtjMrv9CjLMHPf3nFpkHutD1o+BUJMO/GpXOJe/M2
 9LqENY+OqGBfmUwHH9XoUA+J2ByG2wFUm0Tl9UmJmej0NtYb/JtXH59B7bfwnenlRALa
 pgUfA3iBPhO/8VjajYkCG6a9MfnBuJ7NZWa+mYBV1ibciBNHxEs5DIEb1+veqMwAXfqb
 yeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770083422; x=1770688222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aNO8eqy3WbeD4fXGr9EKoHxErZDEZrLDwYlOP1GdVc0=;
 b=Avsd4K84p53PW5mBAiUTtm9gEr85NolFdDLaQp40k+YVn9xiSAMSzO+V0Og8e1Tpfn
 vU8IMGLNR9wou51c84urMc0qP8e4S/nT8XPlu2cg0JTPeq39GUBzblDn4hvZXJgNENR7
 qUIJZtN8WZDJ/FF7L4gHXFQTqfJrs6rGseM1cCnk3/xCuR5vtKaPYx4iAkQIrQszCTmd
 Z1rHY/WDH2bXTVzktUZhnuDLBjgCsR8mvaBQM/clvQwzlS5yShtW+PWTQqn3FrSI9uka
 0+Va8NkaxPO1wAKqWUAVGWmOOFNgAAMhvkJuBNjkxLbIGUwlfEz2lU5v5sZ6qBG4mjm6
 F83g==
X-Gm-Message-State: AOJu0YzcGIfnt8bOyaw9ns9sqQrZSoAFkgFShB/ppMduNjT87I7KgwiF
 l9ANWoFumqmrNVczBxGVmMtiy0g9VJHhkl689qqoEZEnL2yZJT0WZF5qTuu/kUgZUeg=
X-Gm-Gg: AZuq6aKgBPS/WbOZCxbHtUCKLfSk4vmA21VQOD0xxv1llOKdS0S7fsEZFC8mSD1Oh62
 K/2NyJlx9D9tona28YHT7gk59Jq1a+/Lq0BxOrGOMzWDCKpvTdK8vArMJulTbOrAqhgTq5Hly4k
 0LJONXbJXq8FFqvXVNztCfvrpMWfeku+qf+nMpLndu1sZpyP6iaAZnCeSaMAJCjxDWHA0PgmvY7
 eM/qXJQfu744gvh3IZ8ZDvTHDtbZeQCfcEi/MNBJWGHHCzfimcbqPtPX1mUvSxLVuBFcpgJ0nfK
 rKELj8RRAaKnB/SNoMiN2QAWrp2LaI1fViVOdrExxb81ratkhZZEjRlmQw1fxcSAdDwSYFTFGze
 IqhOWGOlQHTS3WAzm7sgcDnO6maQRIfnmnryVCuxjHEQS3epNmm0FWoe18xW1FzzoUfzAwJ5Ahf
 m2wFJFVGsy+IO/GSwtiUQpsK0zlwAJkYyyBDUkxm13M+FlFr3tcO7C
X-Received: by 2002:a05:6000:1868:b0:42f:bbc6:eda2 with SMTP id
 ffacd0b85a97d-435f3ab214dmr20917802f8f.40.1770083422299; 
 Mon, 02 Feb 2026 17:50:22 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e13235f5sm45486395f8f.29.2026.02.02.17.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 17:50:21 -0800 (PST)
Date: Mon, 2 Feb 2026 17:50:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/6] net/nfb: code cleanup
Message-ID: <20260202175013.64da846a@phoenix.local>
In-Reply-To: <20260202193330.3324681-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260202193330.3324681-1-spinler@cesnet.cz>
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

On Mon,  2 Feb 2026 20:33:24 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
>=20
> This patchset mainly cleans up the code and prepare it for another
> quite large rework. Also it resolves some unpleasant behavior.
>=20
> ---
> v5:
> * Rebased to next-net-main
>=20
> Martin Spinler (6):
>   net/nfb: use constant values for max Rx/Tx queues count
>   net/nfb: fix bad pointer access in queue stats
>   net/nfb: update timestamp calculation to meaningful value
>   net/nfb: use process private variable for internal data
>   net/nfb: release allocated resources correctly
>   net/nfb: stop only started queues in fail path
>=20
>  doc/guides/nics/nfb.rst      |   6 +-
>  drivers/net/nfb/nfb.h        |  14 ++-
>  drivers/net/nfb/nfb_ethdev.c | 166 +++++++++++++++++++++--------------
>  drivers/net/nfb/nfb_rx.c     |   2 +-
>  drivers/net/nfb/nfb_rx.h     |  13 +--
>  drivers/net/nfb/nfb_rxmode.c |  12 +--
>  drivers/net/nfb/nfb_stats.c  |  46 +++++-----
>  drivers/net/nfb/nfb_tx.c     |   2 +-
>  8 files changed, 152 insertions(+), 109 deletions(-)
>=20

AI patch review summary.  My comments afterward,

> Here's the review. The series is in good shape overall =E2=80=94 no error=
s found across all six patches. The main items worth raising with Martin:
> Patch 2: The new queue iteration still doesn't NULL-check the per-queue p=
ointer before dereferencing. Given the commit message specifically calls ou=
t the pointer validity problem, this seems like an oversight.
> Patch 4: rte_zmalloc_socket for a small control structure of file handles=
 is using limited hugepage memory unnecessarily =E2=80=94 plain calloc woul=
d suffice.
> Patch 5: The removal of dev_stop from close relies on the ethdev layer ca=
lling stop first. That's fine for modern DPDK but worth a sanity check. Sim=
ilarly, the dev_started =3D 0 removal is correct if the minimum supported D=
PDK version manages that flag in the ethdev layer.
> Everything else =E2=80=94 commit messages, tags, formatting, error paths,=
 the timestamp arithmetic, the start error unwinding =E2=80=94 looks clean.

Ignore the comment on 5.

Patch 4 raises a good point, file handles are per-process so doesn't need t=
o be in hugepages.

Not sure about comment about Patch #2. The queues are set to null on close.=
 So there might be small race with another process getting stats.

I needed to do some manual application to workaround patch fuzz.
Then queued to next-net.




