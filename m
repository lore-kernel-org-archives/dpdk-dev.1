Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DECD2F35A
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 18:14:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0374402DE;
	Tue, 13 Jan 2026 19:14:02 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 2EAF3402D6
 for <dev@dpdk.org>; Tue, 13 Jan 2026 19:14:02 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so1339939366b.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 10:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768328041;
 x=1768932841; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TG36G7QtAJi3E0+DdqpFtrFIwLOvSZtWIcFhTWekP3c=;
 b=cpRjdjKwkfZx4WcSFHe8EDpudl8dTmtasljXGLqWyAD8wBf1PbPGIvS2kIrZ7dRbHO
 llYHdJMZ6/yON3Z1wZWzCuULITd8a5i+XeJa7kk3v18YtWoQORv7fAV8ClnN9CucdNfA
 af2baIt9GTwnAo8aeAcBRmesu4ik7MlI/4HPhEZztzNBeGWH4oHG9yquSufmUOOGnpe3
 vt1MHXopOk+UwR0yPhMTIQSdHw4lsm4w0aAHSoa2MD5kE7ktJL9yrsZvQNRHtINdz2R5
 91fg9sgm8X74xg7PY1f6pv4nMWQ/6C44stq4z3XVGLe5YjLvhpvOQZlYGrbfAR+VB2e3
 yJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768328041; x=1768932841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TG36G7QtAJi3E0+DdqpFtrFIwLOvSZtWIcFhTWekP3c=;
 b=dDdVuYHmtK6NHos/9ZQTnP40MZDjMZdaPbA3cau3eb3TLdYHSkB3CuepxzZHCDVnh/
 xPJksz74QBbfFbbRMdVzowTpwEdyUpU76LZTGPA2mjvvVjQAgRhHSunn7spvYbnNsdbx
 VjpEj2LymzbWHS2S2PXhPYl7r1V9lRMBoisyH/rnV8XlDyJfVHgmBApXg1kajtl4C80o
 CXUyzQgQPyEoEIYrCw0pN6S1pszJxpTTRuHbAZ7QDnd1vECI93u8Cn5L3AvfJyUOH7o9
 6DiPQYXsEHZhj4W/BY7Hjzw5X+agKO7xred1Fa1VLbHCUdhXbrQjqiamS+3+k0I9wl3b
 ruMA==
X-Gm-Message-State: AOJu0Yyqim2JLaBb0Df1hCRetKv8r0FiD1/RyBSwvyPb0tlQs1ME5lZa
 EIzgjBqbfn6Hu/EwLUkQcHS2ivd594l141m0AXtB6tAdq6fP3x2xdaqS4u2wNc4brIE=
X-Gm-Gg: AY/fxX7tOhV2BAqIwE960MOOv8G78uD+mgxc+bk5ENbRrvyeE4eE9uOt/ebn+Y07i4T
 4QCZYhrD8FVZacmT3JIYik+Fox7V8WL69GYD5ImQYIfrmO4FNQHXM02UwbR9ZkKSUbQKjdgj2xn
 eXuHFgzPozTNgw5SF3gzuckCVJACYdo/8MRfb+Gk8S2c8DMnAv4GgO+jADhb6MiC0ww3FuUpFnC
 OtwBKrjutmOZOJrApyVSWuVoQq+wMenojD6E5klKyijE1vioL8yO9uDRSkDtQnbaZese4slANy+
 BTffRU2lmJLeeSohpAlyHf0aZ3Y4/gSF3bdvxL/YoHoffAKQ9k+RqLDR45oseXR14d7P41p3D6O
 sRwSPMQ4FzcVJtxGPBoWZ8PQYKCAL9WMiSq/PqwOA5je4RzcpgYTR45ufwCQmua0sXsHKn5XmtC
 L1IaY9bGFZVcQUbfrH8DBpgqPmgelVaYBphsWNgt1WbpSD81YV/EiI
X-Google-Smtp-Source: AGHT+IEquzFjWmnMQZLr/ZjZgVcsflX+XHfD5qbHiqUMCzU8Rbpq05ih0PLotzMXijYKZlE43zGQNQ==
X-Received: by 2002:a17:907:9455:b0:b72:58b6:b263 with SMTP id
 a640c23a62f3a-b844516a6f8mr2125196266b.60.1768328041093; 
 Tue, 13 Jan 2026 10:14:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm972235366b.30.2026.01.13.10.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 10:14:00 -0800 (PST)
Date: Tue, 13 Jan 2026 10:13:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shaiq Wani <shaiq.wani@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com
Subject: Re: [PATCH v11 0/3] net/idpf: enable AVX2 for split queue Rx/Tx
Message-ID: <20260113101355.7a482dfc@phoenix.local>
In-Reply-To: <20260105062257.102370-1-shaiq.wani@intel.com>
References: <20250917052658.582872-1-shaiq.wani@intel.com>
 <20260105062257.102370-1-shaiq.wani@intel.com>
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

On Mon,  5 Jan 2026 11:52:54 +0530
Shaiq Wani <shaiq.wani@intel.com> wrote:

> In case some CPUs don't support AVX512. Enable AVX2 for them to
> get better per-core performance.
>=20
> In the single queue model, the same descriptor queue is used by SW
> to post descriptors to the device and used by device to report completed
> descriptors to SW. While as the split queue model separates them into
> different queues for parallel processing and improved performance.
>=20
> v11:
> *Fixed indentation issues.
>=20
> v10:
> *Changed desc reading style in Rx path.
>=20
> v9:
> *Some minor fixes.
>=20
> v8:
> *Reworked the receive func to avoid race conditions in Rx path.
> *Removed unnecessary compiler barriers.
>=20
> v7:
> *Removed (char) casts, ifdef block as suggested.
> *Fixed indentation, line wrapping.
> *Did blind write of data to avoid branching.
> *changed desc building and writing  order for Tx.
>=20
> v6:
> *used single load/store in splitq_recv_pkts function.
> *removed x86-specific intrinsics from common code.
>=20
> v5:
> *Fixed CI errors.
> *Used defined constants instead of numbers.
>=20
> v4:
> *moved splitq_rearm_common to a common location.
> *reduced duplication of code.
> *fixed splitq_recv_pkts function.
>=20
> v3:
> *Fixed some indentation issues.
> *Collapsed wrapper and core function into one.
> *Fixed some pointer casting and naming inconsistency issues.
>=20
> v2:
> *Fixed CI build related issues.
> *Rebased on top of idpf/cpfl rx path selection simplication patch.
>=20
>=20
>=20
> Shaiq Wani (3):
>   net/idpf: enable AVX2 for split queue Rx
>   net/idpf: enable AVX2 for split queue Tx
>   doc: note on unsupported completion queue sharing
>=20
>  doc/guides/nics/idpf.rst                      |   5 +
>  drivers/net/intel/idpf/idpf_common_device.h   |   1 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c     |  59 ++++
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |   8 +
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    | 317 +++++++++++++++++-
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  56 ----
>  drivers/net/intel/idpf/idpf_rxtx.c            |   9 +
>  7 files changed, 397 insertions(+), 58 deletions(-)
>=20

Thanks for sticking with this patchset.
It is worth noting that AI had some review comments.

Summary
Errors (Must Fix)
None critical.
Warnings (Should Fix)

Patch 1 & 2: Commit body text is identical and doesn't specifically describ=
e the Tx patch. Consider making the body patch-specific.
Patch 1: "While as" grammatical error in commit body =E2=86=92 "Whereas" or=
 "While".
Patch 2: Contains unrelated style change (moving tx_id declaration). Should=
 be mentioned in commit message or separated.
Patch 2: Verify IDPD_TXQ_SCAN_CQ_THRESH spelling=E2=80=94appears it might b=
e a typo for IDPF_.
Patch 1 & 2: Inconsistent placement of RTE_EXPORT_INTERNAL_SYMBOL() (before=
 vs. after function).
Patch 3: "Added" is past tense; imperative "Add" is preferred.

Info (Consider)

The series is at v11, indicating significant iteration. The core implementa=
tion looks reasonable for AVX2 vectorized packet processing.
Mid-block variable declarations are used inconsistently=E2=80=94some at fun=
ction top, some mid-block. Consider consistent placement.
Unnecessary initialization of received =3D 0 since it's always assigned bef=
ore use.


Recommendation
Acceptable with minor revisions. The code appears functionally correct for =
enabling AVX2 split queue support. Address the warnings above, particularly:

Fix the "IDPD" vs "IDPF" typo if confirmed
Update commit messages to be patch-specific
Consider separating unrelated style changes



