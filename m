Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81C2C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 14:31:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23A3740287;
	Thu, 26 Jun 2025 16:31:36 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 91C9F40156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 16:31:34 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7d402c901cbso96963185a.3
 for <dev@dpdk.org>; Thu, 26 Jun 2025 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750948294;
 x=1751553094; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xb9y+3KSx04TBwAVy4ka4oF1l1RiwRMNLB9QsCC3VgQ=;
 b=aTcOe8pP+LUld3Wwax92Kij5yM/RNjL/lutJ4EQ+w5yaRPcPrLP/QJIRpTP31YWl02
 ZvXYjNQS2CZ/CHuUYtFzFuwwpOM5N+/DEYXcpENVx49tY9YO6yxzWYGMiKfKm1XgNWkQ
 HOvgcAiJCUkJ/r6sLt8PEilrBMjZxfVw8B279YJ+r731LGxMH9XgstHqKbG/EqmwF4gy
 BwF6AbNGALL2h4efKE0NXqjC7UbmV5Yllbb8fkvHyljoyD8ozejdbXms0dzzGTbYC4bf
 Qnk/86oY4zTkFHwLT4RGrFHcW7fNLMv/QfWaa7Zw2F4aOttiE7fpA0MUS/0MfNK2Gw8L
 YUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750948294; x=1751553094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xb9y+3KSx04TBwAVy4ka4oF1l1RiwRMNLB9QsCC3VgQ=;
 b=Z+NxwEvjr83IYmt/2KrtLoWZaKboyT7PH5Y9QCLqFdTCmxPm8yyJod1wpLTqvQHyk3
 2/QF+4CsRSmx06z/WVkKwvVeC1p2aS91yJPIYL0rEKzT83vLX4JL4HHlZ/hyCPpffLKk
 kVI6lbodBoB0B2a6brvd36NWkFO0zeessquvBp38LZvJv/LA87HM1EcGFrL3v3lIpD+R
 fBc/RBiCFlqYJyg/jgK/Tgo/oeobS/NYThqTNxO0kXXY8QgBUiTRlon2tpGLD8NEZxqB
 XSosXIenK0YjT+8ujGOVgNj0LwGTW3hqPm5nrU3hI5txHQUI0Xjt37yI196yuiV5Yu0K
 yCZA==
X-Gm-Message-State: AOJu0Yyo9UG9uoOuLhyTqNb8vaLHjEbNV9DoXtjY4ziaDM0QO7OvTn8T
 t706v8qAmTu9AsE52PUgYGgwc20IUFuYCFW+C5bxXFsJSX+J2RM6u1IxOmpGIvpfMDSuKTNhCdk
 EABJh
X-Gm-Gg: ASbGncufZNPkBuYrQ1aU8Roh+H7AyYuq9kYAq6sk68BZRQATx7H1Tel7VLtKH4QaDNd
 xbskv/jU44jbEUkKN46WAi0d3a6hBUUDEfSqkzVzUmPzk0ybYWKnuLEkKIx68yJrP+7ZAKFerG+
 /MFbu/HNgK5BqIRr9UbTarQ00T7BxC90qbK7/c/FsKPNSyzjloNJxk6wI/MsEmdMMwr/QxwAlLh
 2qSBs/NkBBw0xuVqMKXiC06Wn8rISm4Rdy+lux6wVMEHposAJ/Ewm9lh/evA+1CCHmXWJ5y8t8d
 7ZeDMAqNZGkz6pCRkdjn1U7cyFoFWXKiU8Jmtz8GmxtIr+BDxsu9PiO/SEGAHLLR/C5nNQ+TqNj
 F6TaAMFy4QioHwaqCby/QYXICUuM4YkE8zd096JM=
X-Google-Smtp-Source: AGHT+IECqDNGcpMbo4PAAkr6tMcAvzgkoWN/Ah361L2j0TKKhwc5dCwdRTS6c9fTvOxjyyg5ybqyQg==
X-Received: by 2002:a05:620a:2488:b0:7d2:1953:a410 with SMTP id
 af79cd13be357-7d4296979e3mr889394985a.17.1750948293655; 
 Thu, 26 Jun 2025 07:31:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44322dc9fsm5826985a.94.2025.06.26.07.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 07:31:33 -0700 (PDT)
Date: Thu, 26 Jun 2025 07:31:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: Function to fail at build time?
Message-ID: <20250626073131.1b4e3449@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FD40@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FD40@smartserver.smartshare.dk>
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

On Thu, 26 Jun 2025 01:55:02 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> I was wondering if this was somehow possible:
>=20
> #define RTE_VERIFY(exp) do { \
> +	if (__rte_constant(exp)) \
> +		FAIL_AT_BUILD_TIME(); \
> 	if (unlikely(!(exp))) \
> 		rte_panic("line %d\tassert \"%s\" failed\n", __LINE__, #exp); \
> } while (0)
>=20
> I tried static_assert(), but it cannot be used in this way.


What happens?
