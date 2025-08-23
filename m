Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8470CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 Aug 2025 14:28:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 705F440674;
	Sat, 23 Aug 2025 16:28:38 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 5491340674
 for <dev@dpdk.org>; Sat, 23 Aug 2025 16:28:37 +0200 (CEST)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-45a1b004a31so22158025e9.0
 for <dev@dpdk.org>; Sat, 23 Aug 2025 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755959317;
 x=1756564117; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoBmpPeyrWwGRAgM+rf2hPmFWMqSKgbpEM3aELwsSPM=;
 b=lfZ4uLPpdCmtEHISQnRwILQelrb3qk8hX0Q1qK0i/pmY+nDbt9FMYBJ7C68VZzMtBj
 DnyWjHT/1niN2efhQJkZ0Cxf21Yv7cwcPLLfRxCxJeKTfATWL0RbyjItpFNRED4r983B
 CQf7FENGb6m5bjt6k6UPZz+cZRhzBcJuwdq2oRvIkDepcb7BiKtK7mT9PoFm6j7UH0Qg
 8VuDUrRx7FYxywIr4i490AjzsOHaqIAyqTUlmvD0+c9KKOedr/SS1msnMMygU/xRPkNm
 i7QSepkagHc6q9lhGj3FX+yPG1hD/CorTr1t9p5Wf9kN2Dtd3WzQzm0mAQi2d1kYmHjW
 UqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755959317; x=1756564117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoBmpPeyrWwGRAgM+rf2hPmFWMqSKgbpEM3aELwsSPM=;
 b=MfUF0K8SVPijJ9fEtZC2USGrylJFOgQX2eCj9a2dMsudfc+hx+X91YsOj3eHCx6Usu
 RGS5SKvYNVdPDdwOJ18dkwnqXp3zYFeTM/jztwgj4OzF9Qio9oKSe/4gd9YK+mtGxn3H
 rPph6+JU5Rv0oRiMf4ovMGBZ64Ciq8EpHft/OIwjDuqNgV8H1iJBq5IXsWzISCW2EDdu
 YMVOy5m1Qncxr1KWs5mvZdtcPOhqK4nKnR5jRTXwi0BSmpwUHbpia2CLiYWCBkBaZkdi
 YfuEJR3n7Fdo4VNXSkufCFrH+JIrt7css+GTbsl6SWX+lmzMSn7XWR7K6WhwLJ2J/AQA
 xXsQ==
X-Gm-Message-State: AOJu0Yx0QbKUGe35gyS5wllznZ+4S2Qi6sa5RGg5lbENz0IA6MZLqQH6
 lkTwCkdPo/lzah5aXc7zHBZbYJEB3zNAoKNCyV76Z6+y0mQWdh3TgkOG1NZBZwJ4Ucc=
X-Gm-Gg: ASbGncvj/2sWhzZ0WdOLRW3ncnP18IQUTOFlbX6oKvUYi/yvhpxY72/+r8m/AS4FzBp
 7/UAv8My1Z9gR3+BP32zEuWWLs6gWri/3pBhMhDvkFV5Jrze7djr9IWTFCNtKuQ3MqgH1xTNtnh
 SUrCKoviNe5gyLdhXWE1BoCmUrBJsbPiQyzNcm2yBB9AfOk6cuvw8gYOupgFZC3cQ64JszU4bou
 Vsf9WYON4Q6B8gqwxk98fhO9hnBmU+mgaPeY6WHJAQj9TbRUSv6SGiBrJMs/kxrj2YuTXagmBIZ
 WFgFG/TUrVfBFgPWdo/y3ht6pffMGZk0wmkpzPEiTjFPE9eG8ci+0DiqwUFYQE37I5P64f/LTBd
 UjgoeOAVGtLJUJrqAz0mtQ8lOREyqIvHfCyxmqjB/kC2kXmVxseH+11d7+LWE6va3kEKUTniKiN
 Q=
X-Google-Smtp-Source: AGHT+IHi6+vkdu6DuibyQOVYHiLzvQ4WBaqgK2C4DtDbCM38o9pcmdIvBO9rFe2Ml4aaIoy67QwVzQ==
X-Received: by 2002:a05:600c:26c6:b0:459:e165:2661 with SMTP id
 5b1f17b1804b1-45b5185a644mr37245685e9.23.1755959316416; 
 Sat, 23 Aug 2025 07:28:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4e8f4552sm55811695e9.8.2025.08.23.07.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Aug 2025 07:28:36 -0700 (PDT)
Date: Sat, 23 Aug 2025 07:28:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Bruce Richardson
 <bruce.richardson@intel.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 3/3] mbuf: optimize reset of reinitialized mbufs
Message-ID: <20250823072829.0176a907@hermes.local>
In-Reply-To: <20250823063002.24326-4-mb@smartsharesystems.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
 <20250823063002.24326-1-mb@smartsharesystems.com>
 <20250823063002.24326-4-mb@smartsharesystems.com>
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

On Sat, 23 Aug 2025 06:30:02 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> An optimized function for resetting a bulk of newly allocated
> reinitialized mbufs (a.k.a. raw mbufs) was added.
>=20
> Compared to the normal packet mbuf reset function, it takes advantage of
> the following two details:
> 1. The 'next' and 'nb_segs' fields are already reset, so resetting them
> has been omitted.

This doesn't matter, since they are on the same cache line the
operation of touching them costs nothing.
