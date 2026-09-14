Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C4C88E6F
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 16:47:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CD1140A7F;
	Mon, 14 Sep 2026 18:47:11 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 190E740A75
 for <dev@dpdk.org>; Mon, 14 Sep 2026 18:47:09 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747f01363so16018595ad.2
 for <dev@dpdk.org>; Mon, 14 Sep 2026 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789404428;
 x=1790009228; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=to2JW6+NzxppZXSr+PsPtQdCX7lbzOkI2mpy/xMka0I=;
 b=Mdu9JruLUGlrkukHGpxrZ7wcByRNfOZLniXDNpIHvoX4cBJl11x9CBsrSp2eKYxtd/
 v/dsj+AaEtkfm8EluuXcxPS92cdauel1DWh4ghKtSWEVYvmmiYmizctI+HheD3zZXqQ8
 LVGkPJcMtVIW35zev3T21psmffRtQvHwz0UPzBYt9aoClga749jKHnGU0z1ASZhRyIUo
 jVZW8TXFgDakWTgNZWxHa4XWm1AYWQNdV+XtIUQQSRxgy0OcQPQx23KsLzROw1kY26Gv
 qM1Sbu3Y7nQ8I/tT9fufZOqUT3EV1VFA31CVTyJ97KVGZ+4qxsBC+C8iGzVWpzwBSw6R
 MZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789404428; x=1790009228;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=to2JW6+NzxppZXSr+PsPtQdCX7lbzOkI2mpy/xMka0I=;
 b=BYt6ajrTa+d+DsLY3ujO+7UajxIBLos3OI+jMU25VcxXUFlk2QVqsVPCl9Epm6LgD/
 nfv2o21Mb3QIc2qVtW2CtGEDKIlR91gCY/4if4GpXVlwur6npD3k/5qUV/qv5mBe3Hgv
 ULWXPKHuYdQsGcbq3tM6AQsb2awmdCt3yc7GsKTNsp+k+mzKxlyiik4Euz8pv8fEg5C0
 YBYCTYTmFGLRAMppjcDF9/+UKdgK4TfCquUOxgwWFh/uTXh/MYShFHV0aP14iclqLfKL
 PJJuQFkNCRuOA5RzOFy0VKofk3QyJz7LP4Yn5vRjHFSwaONWRFpVHb91neLEBfWQAHrB
 FVZw==
X-Gm-Message-State: AFuF++kseMsujGfj1Wd6mivFXvWLv4ON2gyeOFDiBwu1LEnatdFaq1OJ
 HIxrkbKI6Gq3yT7B7zPjjh64eL3MqdLdDZo0/ZzhXoN6LZbbgPRhCbUdS2+WkxIWYno=
X-Gm-Gg: AYBFou19UmnKaXh+tjUjE+k43qXNTjSGE6cA/6IfGfiSPjHh+jn/67duB9gCGwrfv2c
 YzNX1v6MZDewO23jb0I5S9XLwu9aTsAqzY+Di7XtLKKOHKU6LK/2nD8d8DWLoTvF3nm7NMKTB+t
 fiWnl815CwEitcigAjRyelp0T4Wn/evfmYwQjdRnAstI1V4dwcqRWn7fmf1G3mWwiBpuUTfvTpk
 xkjm0UnLVGhu7rq4GD492fj2ZQUzxAjn+uJxYPzLpkz5IDgKv81ptmJS7r+2Ilcp87MY3FQ5e55
 sltL3A0XnzwlBRhUHesEu6wxPH/YkS2ysvYavaDewYx6x0B/cRgXOvHWpuTppTrE6qpMi3ShSRt
 erdmPoyMQc7pPUYqca+sc0rEPI9KlciCDvT4aT0VJrDYpY/bwsYBZf9gMF69IWEyCEHPgAAha0y
 cfGSs+j5jE3+QdCMTJmkr8tEjm4tlThAgyftoVqXiachHeaF5Uc9I/0jB7nVNXhjkeNxDENtTX9
 mijLM+NW3YvrQmAYH0PSvcCMazVfdC1hFx47viG
X-Received: by 2002:a17:903:284:b0:2d9:2688:8be6 with SMTP id
 d9443c01a7336-2dd6c760336mr67367795ad.19.1789404428047; 
 Mon, 14 Sep 2026 09:47:08 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd3f0faed5sm46132145ad.10.2026.09.14.09.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:47:07 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:46:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Mattias =?UTF-8?B?UsO2bm5ibG9t?=
 <mattias.ronnblom@ericsson.com>
Subject: Re: [PATCH v2] eal: allow setting random number generator seed
Message-ID: <20260914094656.3c9161e7@phoenix.local>
In-Reply-To: <bd0242b5-44d8-40c7-8928-4586f0191fe1@lysator.liu.se>
References: <20260911225845.3168061-1-stephen@networkplumber.org>
 <20260912161744.201627-1-stephen@networkplumber.org>
 <bd0242b5-44d8-40c7-8928-4586f0191fe1@lysator.liu.se>
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

On Mon, 14 Sep 2026 13:29:22 +0200
Mattias R=C3=B6nnblom <hofors@lysator.liu.se> wrote:

> Den 2026-09-12 kl. 18:16, skrev Stephen Hemminger:
> > Many performance tests use rte_rand() and the random number
> > can perturb the results. Add an ability to override the automatic
> > random seed on DPDK startup. =20
>=20
> There is a way to seed the PRNG already, rte_srand(). Why the tests=20
> can't use this?
>=20
> Provided the test results depend on something that use the PRNG before=20
> the test driver has had the opportunity to call rte_srand(), controlling=
=20
> the *initial* seed may be required.
>=20
> I don't think this feature should be controlled by an environment=20
> variable. There is no precedent for that. If this functionality is=20
> deemed useful, it should be an EAL command line option, it seems to me.

There are several tests already using rte_srand() so that is one option.
The choice of environment variable was to match the existing test harness
infrastructure that uses MALLOC_PERTURB to pre-seed malloc.
