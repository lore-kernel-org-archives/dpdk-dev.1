Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D8E9D810
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Apr 2026 16:11:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 255C840265;
	Sun,  5 Apr 2026 18:11:44 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 6059A40261
 for <dev@dpdk.org>; Sun,  5 Apr 2026 18:11:40 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-82c68339cf0so2313879b3a.0
 for <dev@dpdk.org>; Sun, 05 Apr 2026 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775405499;
 x=1776010299; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaGj2ylJ6mwUaqouaah45BFVnB50MmJXIlnfkenreKE=;
 b=WPaysxMZprUxbqyKQsX0mLmpcysAxDBnzwhODWK5fd4G3Go40gg+XlVTjK0N47YKJg
 4P28nASy4xIg5I4VxiZxlZt+tMP4GUOvkyqPTmW5ms8vqbjUPIbwGa05yNi17up4Z9H0
 91dKHFrjWQy8YmhGYOuMc6z2Mty2rx0r2qWgkcgiJQqbeAatwW0pcj9Qaq+DAXvUluYY
 UlFi1kZc6XCpomv0YPvckpRJgTiyvlFLe6X95vcFS+unbh40BhQeVknah0kpXuZejyqz
 PQDgTXJPturQpNHeGz35qjHk1L1AD7dJaSY9QrIiImUX50l0vjAFIEwit3q/oESxr3Gj
 we3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775405499; x=1776010299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iaGj2ylJ6mwUaqouaah45BFVnB50MmJXIlnfkenreKE=;
 b=dPaoKZ1yDglgI930upl1eusnUwhKem3ocHmaFVdQZtznCnvyYYmTjotGtz7+/NhCPV
 tLit1FP70i9jtuO9d+C8LH/OiQHGmxzMx1eE/M6K6iWLCjxqZ1hVdEfTsyYbjJR3HfZF
 vSUN2cIrL0cQF6izDeJlngHkP03T8WTrnTf+e0/MrlF/7zLQ5JL63iVt7XqPdhQt9+X5
 78VFOjwAtUxNBRNCJqEA03iL8m2YpFelu1I42Cig2FSnSoE1MTg2scXzZg27WXn/tV4x
 kyLHbXK0gXRnXDc5/RAw5o/DfMK9ANLUZT+436tS0+t1ohLWkFILlSr3cU+a9lLal8xP
 ASyw==
X-Gm-Message-State: AOJu0Yx/x5TlY6vT9cnxkjVpagC+nyiOCZGtYltdrxgg4qJ2Pc6EZxsJ
 0w3HOx9hRyPxw92JpJZPM2wOtMaZL3lwn0z07lEYrJYURBGqc8dfqRmZ1ErVoiYkjTBcGnZ2w2Q
 iE60F
X-Gm-Gg: AeBDievhdIVdBwfBGRFNOM3nVRyWHSkU4ckvhLK9pjXMmS0QuOyGh9By4y773aUQrO5
 XP+c/v0OY6ywRjojj9Tp6fA3h1HGJKULCM19TG+tpYwjnL5QH1td4O6OlnO8p9Xfpy9iHIoAj9b
 u5y/aFuGzm3FKnW+f2xozuP/o9iw4AozHnQwYfg2PmxRBYqMD723h3nOID714RBO4eikcam7IZK
 G7QcA4FIEB0Yy5UwXxbgeZQUZ17grkMXqAK1YvGQB5mTvbnk/Z1frbEn3s6XIaMSD7XKnuD3Cx3
 mecjjD4/5Ado6+U2GoWDkZ4IJn5XPhfjrJAym9MkSJB299fHnxu/fX+h8ca1aVZywv9pyzvrtPe
 BIA/OZyRMHkIypqx4pJ9Uz7tIZP1+4GN2He4/auQ7KjawGsU4cxQOAlE0EiOprI6KWih/QodbEi
 5Km2SsdauSXnNpNrSl8RQUrMPyoNSqaOqbkMc=
X-Received: by 2002:a05:6a00:f04:b0:82a:7918:7f4b with SMTP id
 d2e1a72fcca58-82d003ce360mr11420930b3a.34.1775405499374; 
 Sun, 05 Apr 2026 09:11:39 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b5fb22sm14311257b3a.26.2026.04.05.09.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 09:11:39 -0700 (PDT)
Date: Sun, 5 Apr 2026 09:11:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Selwin Sebastian <selwin.sebastian@amd.com>
Subject: Re: [PATCH 2/4] net/axgbe: fix Rx queue leak on descriptor init
 failure
Message-ID: <20260405091131.78575283@phoenix.local>
In-Reply-To: <20260218164324.915065-3-stephen@networkplumber.org>
References: <20260218164324.915065-1-stephen@networkplumber.org>
 <20260218164324.915065-3-stephen@networkplumber.org>
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

On Wed, 18 Feb 2026 08:41:00 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> When wrapper_rx_desc_init() fails to allocate an mbuf for queue i,
> only queue i is released. Queues 0 through i-1 have already been
> fully populated with mbufs assigned to sw_ring entries and
> programmed into hardware descriptors, but are never cleaned up.
> This leaks all mbufs from the previously initialized queues.
>=20
> Fix by releasing all previously initialized queues when an
> allocation failure occurs.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

AI found off by one in its own patch...

Patch 2 has an off-by-one in the cleanup loop.=20
The do-while releases queue i first (the failing queue), then loops while i=
-- > 0.=20
Since 0 > 0 is false, queue 0 is never released =E2=80=94 its mbufs leak.=20
Should use i-- !=3D 0 or a forward for-loop through 0..i.
