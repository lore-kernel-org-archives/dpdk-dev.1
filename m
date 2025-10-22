Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC82CCD1BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 17:31:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1624B40262;
	Wed, 22 Oct 2025 19:31:15 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id B59A84025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 19:31:13 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-78f3bfe3f69so6290807b3a.2
 for <dev@dpdk.org>; Wed, 22 Oct 2025 10:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761154273; x=1761759073; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RGCIHBndXd4kSTNiNSwpauehIrkVLpqIeS9h8jCCfPI=;
 b=eNvmoOg/sayTIi29bVplvFWIKsgX6xZIy1RRzqJO6cshCzNHh6mLlxixEdatpQPGVx
 +eJU9xqbkH0h8/a7FCxV2FCAWVHEV/2aZhFDBL0Dn+nLgdkeLzlG6rBwSot+lFR8bQc9
 ccTsHbCKLU7FXaCTKDABghqLXHwLXVZai0zzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761154273; x=1761759073;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RGCIHBndXd4kSTNiNSwpauehIrkVLpqIeS9h8jCCfPI=;
 b=vIs6VQli3DbWInulm/zgwp8I0MCjC3oW/BY71VJbU4Lmq9eGuKLD1lw6RGSb5+QvEk
 gIsImXmnfKt2TqWTWqkYCOtFES9PhNp0vYYWyoeMINzREYhWN7dEJ4oePguaZd4K7cwD
 dcFEesApuq3n215AYRH31GzS0QOUDyOfciRlsjdNWGyptyLgsKONtcftSo8LS6IApnfI
 EPfgGQCJPf0ttmInmNXna7q3TCs8GUxORt/MeUczcsfL1sOTR3M5VGuOkdA1BY9019Ft
 6K+NUHNJSE/Wm60lVqJU1HsR/hpM4vNfoZOpVSZz+O0aEVgGBB2/SnmwVlfGf06PmUVq
 2eHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+rQ12fgPVdmLFL8as0ZXm3C9zlfOVe02CNtnEQvTvVyzpJHox2EtUh37b/rF1Szo+UgY=@dpdk.org
X-Gm-Message-State: AOJu0YxUbvkDh2uCmXCOw+XUKNW+NkrPodiN+aHcNuwdNJIBO4IJI5z7
 fxQ7uEmwANdsTxHz1oRSewbiHkTDyxVrDY0HKs+RNIWSmfv0bXHRwQVSOLHH0zXpOAv+/+0wZ1W
 bBez3cu0tNSrqI1rgWYCL4ZX11mzePCFfZ2YbAttPHg==
X-Gm-Gg: ASbGnctSmAvbRre/l79Lzk8oYVUJQT5dlUFIMh6B1vXfjbu3FFYxrs/rtIv3EW47CWT
 H7/BRhHMlrLEC9K0MTDYo1mj0Cqp8Wivkigb42dH1gaBxEcW7s5FaJK9E0f3VnDAIYg+LzUZghz
 AUhWPirbShoiCWiiDuv6YH0fqQgNgdc4aSCwgoVYWQCb7FcDDZ/goNt6OPh9BJbjTZApJV3gN9n
 4YcYJHZoqmT6XepsjJtD79tNFTOZXHEVohjZ3k4CuqMeDNn7LasJj/mCEvgC5CicN+2rVb72OsF
 Sjz7LfHqswtxOEljkw==
X-Google-Smtp-Source: AGHT+IGKCU2vt4pl7PZaOT/b9/jKRPG2/fV46jbI+XvJObECjMZ2XwQGEylhKlZ8ISEgwgfojDuXx1Y+LgL0YFkm6rM=
X-Received: by 2002:a17:902:fc8e:b0:27d:c542:fe25 with SMTP id
 d9443c01a7336-290cb27c8e8mr281797485ad.41.1761154272753; Wed, 22 Oct 2025
 10:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251011113202.937991-1-16567adigashreesh@gmail.com>
In-Reply-To: <20251011113202.937991-1-16567adigashreesh@gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 22 Oct 2025 13:30:20 -0400
X-Gm-Features: AS18NWCCLIwh61lhtF9cF4cLkeyCkXUbPLNOIs-PDK3khPsmAJ_knrQM7G9ivrk
Message-ID: <CAJvnSUDjbrzEZimKXfK7jNKQTFfUxBMu-Gx25YZRQZSVo6V7UQ@mail.gmail.com>
Subject: Re: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
To: Shreesh Adiga <16567adigashreesh@gmail.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, 
 Jasvinder Singh <jasvinder.singh@intel.com>, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000d288830641c2ae43"
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

--000000000000d288830641c2ae43
Content-Type: text/plain; charset="UTF-8"

This email is triggering a rerun of testing at the DPDK Community Lab for
this patchseries.

Recheck-request: iol-intel-Functional

--000000000000d288830641c2ae43
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">This email is triggering a rerun of testing at the DPDK Community Lab for this patchseries.<br><br>Recheck-request: iol-intel-Functional</div>

--000000000000d288830641c2ae43--
