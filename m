Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05BFC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 15:30:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A94A940A76;
	Wed, 12 Mar 2025 16:30:34 +0100 (CET)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id 1628E40265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:30:33 +0100 (CET)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff6ae7667dso75786a91.0
 for <dev@dpdk.org>; Wed, 12 Mar 2025 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741793432; x=1742398232; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iqpsDkhCJycPsblf4zmN3KxvjrB/xOrh1MPXFdSubA=;
 b=XYnzMLjchS+fLvK8cGo5f3oppSSR+V4/uodxzJcv2AiiGN+kQEiWm2xWPdqd+jhUJN
 CnBANEGsDjREjOhhHR0SMBQwE6mja4j7yQ8YzfkyualJ+1rfhOwBdJ8Kev5DGXLj+F4m
 Bi/BPd5jqs+XlmaySXVB7phrCaQ3kUb7aQN5faLWn9+sKghepwo8BztcjL4EWtsBEjtc
 vJ5zmcKJWNScV7qKj4wa+PDjL1UhG64KC0MeEbw98qbQDgPFlnqVVxOEjKCKygidNTjA
 ExVb4tni1MtjRUi9cefTQe+igUmJTMsc6esjXz1YxBedEtAiaHL6zCNRRaUxDUzVdFdE
 QzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741793432; x=1742398232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/iqpsDkhCJycPsblf4zmN3KxvjrB/xOrh1MPXFdSubA=;
 b=u5au2rcXU95NUeqzdvx1R3yk+C8Maf5tIoSE2oindQFar50gkjYGExbS3OacwEvnL4
 zP3MKUDNnQk+MAzMcNglHaQofl4JQxvj2BrRevmAV4hjCZIOz63/P8lQ5/uLs1XB725c
 MeU8DoQbNZG3tHJH2zxI/jK/vczY7kPpDyjc0o7OYKtuk9mzh04Ek41kU+6egCxsbYTU
 08AJVOhe9O0oGN7xBTeMBHKpo1Vugj+kEpmDLMPtZfMtvZQ873eUcEZ0tH6aNY9s/4PT
 W6HKnpA5pIdAMd/rAHi3Us024KofyHD/aPuLy99OZ7mlSEg/uaODt+2hn35WcCD+cqqR
 tNyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuej4KhtpP8lknU2lZ57+8tq8e0MY2ZMqEdeTJYW7ZwGII/BMcp1RZHzo2mf8qu7ZPq9A=@dpdk.org
X-Gm-Message-State: AOJu0YyXgMUTxUgTuIesp3K5mreY2a7sGgc1MfVl4e6wi//TTeecPhvI
 YcM6P4PDnMokQe/ONSG1mHrfU6bfDtEPfmdbwzjUVUnN7CkM/v5CSDCR0UhxCtLCapgfp/ZTccS
 D6+no5lCCcLVJs7RXiCJgAWvwr+U=
X-Gm-Gg: ASbGncsVAjlZCxdBPcAC/WN/fzQAm0FBJ1ySFGuGZ3PZLrt8uLpTOcfLMJD8sM27Oh7
 ptq3ADa4dVSeUmTwhSj4tlDwGuu54Y96jGN5tuCA2Yykgqz1ScedB3URTo7y8p1gIn2e5aDL4n1
 7Od+rlxmCh6ggqoWnVU4n/Fcw7H8U=
X-Google-Smtp-Source: AGHT+IEOe0mR3QaSsRBLst8h6fyncoOHZpwhC9c0yQKPg1qj3o2+B6qrbH4ioqAdd0Brk2HpSVJeIWp/EQWWgB+sAhU=
X-Received: by 2002:a17:90b:4cc4:b0:2ff:5c4e:5acd with SMTP id
 98e67ed59e1d1-2ff7cf3381emr33265370a91.35.1741793432061; Wed, 12 Mar 2025
 08:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250306133713.393057-1-getelson@nvidia.com>
 <20250310091844.4a3ff0d1@hermes.local>
In-Reply-To: <20250310091844.4a3ff0d1@hermes.local>
From: Igor Gutorov <igootorov@gmail.com>
Date: Wed, 12 Mar 2025 18:29:55 +0300
X-Gm-Features: AQ5f1JqLB9H92iF0uE8gA9etbiESggJ-pQhwnu1FdthS6TvqUtSYeqB516uhjVc
Message-ID: <CAL7bPf0QpK_WPoMNmoS7a-WZTUsbFEpB6J1pZssv54VJwotPjg@mail.gmail.com>
Subject: Re: [PATCH] rust: support DPDK API
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Gregory Etelson <getelson@nvidia.com>, thomas@monjalon.net,
 mkashani@nvidia.com, 
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Mar 10, 2025 at 7:34=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The real benefit would the ability to support PMD's built in Rust.

Having DPDK libraries as Rust crates would be beneficial as well. The
mempool library in particular is something I've wanted to use in some
Rust projects. I've previously considered either porting this library
or writing a safe API around bindings, but never actually got to
implementing it yet. IMO, the benefit to DPDK would be more users,
more contributors, etc.
