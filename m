Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B39F459F7
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 17:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 997874026C;
	Fri, 10 Apr 2026 19:37:29 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 816E4400D5
 for <dev@dpdk.org>; Fri, 10 Apr 2026 19:37:28 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2b2589c26e3so21852915ad.1
 for <dev@dpdk.org>; Fri, 10 Apr 2026 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775842647;
 x=1776447447; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbFs0p3r2gqPWKs2/W0qHX64KOVi7m+IvHll97RYZmo=;
 b=rS9hLK7PLgmmF2J4ffITQVjenYVVAYpLKOYDGOt2LDMkP5+z/Q2GJvxvaLpBUPMzZD
 OkbJ7e317t/pbJ+eqZqaPGKxr5nSYjUswyalOoSQXsErmkeVTy3S4VZ38x0JMJZE4b9W
 5Kvzq2I7P9ULhpEjj3e1n8wc14ZMi1thxqWzMK7BSxHJIucC06DU0BY/wfeVujK5cVKK
 /TqapbgGFDKRL9E0DOHRibnn+ZMzf0TVK3H0ANJ5SHZ57zq8cMGerLDgeepc6LTBuzS6
 VM81oMi1cXyx6Y1gAezgkJwe5LXn4RdPgpDAfyn0h+gQzYOVEKy5OIgA5OCkuBnTgHZg
 IOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775842647; x=1776447447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gbFs0p3r2gqPWKs2/W0qHX64KOVi7m+IvHll97RYZmo=;
 b=l4Q8NeHK6VwDFYRFte2DSafPpoaeC6Nrn6JMeCaS6qmvpPocaBHscMWI5Hx1Dg1Bmf
 gf3KCLjFMC2Ep0LSqqvfFtyMmoc5/C8VsGRtOQcn+djN4MTyJWj3o+0OEtXcTg+qqR8x
 hSuKfqiJgigQ9VB7TQ2NHAz1ad/Jqi9AlZJPohsYLnhD+vbJAdifr0jiIAwAVU2/Cn86
 //5VoIPLKY1FlWtORAKA0rEIc7LOXDxmxI7NZ5Np4ErwZPUbKyf6mWpryWhVCKZuzp5W
 RAeGh9qi4Hx+l07T9L8DCOaa91732Bylwvp3z/UKYJll3KdOH9bhmQ+714gJ2YrAyiVR
 BanQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxAggZVjwI1x8q8PPI4O+dpDxIF93MIxlHChfLZNYWZcq66dOD1VD2bd8B1mDeAPlIjpg=@dpdk.org
X-Gm-Message-State: AOJu0YzECkgCR5kgC4ETbC2MuCo1raK9bLNB+Srddk+WrkE2j3HKdsKp
 rdE2owUcWAapZcfUBpndRt/rGDbsNzptj2PWz5fVxHNxaLAfxFvEQbdMWN4/THWqOY8=
X-Gm-Gg: AeBDiescBx7bZaR1HkAvuO9EGizVAgTk+5cmqUzBr5dyTRcyRYc67lnaBXYEsdu5zbg
 5seguOLQEEv5KufxiYFIlZCtYSyPNS2S92+RpH1l1zOQYH56ZgmMuPx0CKeSNDmzUXoCArikJku
 dkFyZ6uElEQm+NQgittJzpGSWXv/UM/M0yfL/EjI5L/ig44qvr/VfMub4LskKqyfCKSWPDallal
 3bFJRfM8g0uRU6VPaC65db54EyWI2AiwjI9XuZL4q/aoJpqiqkX4M0V6m0hG7TS1lQ9nrXx/jZk
 B4XMV0dhOJn+fmNbd3nE5Q3QQgmSKK99uPD33Vvq2n4wPggaPLMhgjhxkBL/d3uJdSzy9SuClwz
 xkddKwbIkwYu97tb2rH4IC/t5IO4ZouNwLx4HodW6xX4AZODleshwTVd3BYnTQK+73KNVGJCnJM
 LL2um4Cw6cUM8MgphChVMTwNAO5I4FGlo9hfo=
X-Received: by 2002:a17:903:b45:b0:2b2:4e1a:b002 with SMTP id
 d9443c01a7336-2b2d5aa263cmr45480285ad.42.1775842647432; 
 Fri, 10 Apr 2026 10:37:27 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f37086sm34024045ad.68.2026.04.10.10.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:37:27 -0700 (PDT)
Date: Fri, 10 Apr 2026 10:37:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "David Marchand" <david.marchand@redhat.com>, "Bruce Richardson"
 <bruce.richardson@intel.com>, "Robin Jarry" <rjarry@redhat.com>, "Hemant
 Agrawal" <hemant.agrawal@nxp.com>, "Maxime Leroy" <maxime@leroys.fr>,
 "Kevin Traynor" <ktraynor@redhat.com>, <dev@dpdk.org>, matan@nvidia.com,
 longli@microsoft.com, weh@microsoft.com
Subject: Re: [PATCH v3 0/7] Rework device probing
Message-ID: <20260410103717.5a52289a@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <98CBD80474FA8B44BF855DF32C47DC35F657DF@smartserver.smartshare.dk>
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

On Fri, 10 Apr 2026 16:34:56 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> Is there a workaround until this patch is added, if I don't want rte_eal_=
init() to probe any devices, but I want my application to probe devices lat=
er by calling rte_bus_scan() followed by rte_bus_probe()?
>=20
> It's not something we really need, so if you don't know it off the top of=
 your head, don't spend time trying to figure it out.
>=20
>=20
> Venlig hilsen / Kind regards,
> -Morten Br=C3=B8rup

We do need it because of the problems with vdev_netvsc.
The issue is that vdev_netvsc tries to setup failsafe on all netvsc
devices it sees, and it determines which ones are used by OS based on
somewhat fragile OS probes with netlink.

I would recommend getting rid of vdev_netvsc, or make the the auto
scanning there something that has to be forced by devargs.
But that really is up to the netvsc maintainers.
