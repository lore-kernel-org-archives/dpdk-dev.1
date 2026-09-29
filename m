Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7414BCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:50:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56E7A40E7C;
	Tue, 29 Sep 2026 21:50:04 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id BB168402A2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 21:50:03 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 41be03b00d2f7-cc7979d1deaso1303324a12.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790711403;
 x=1791316203; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fsgHqsoEmVktmki3rLvPRNW4uqUOSN0xMf8lTsHaHW0=;
 b=PyG8Lq3sjofsbQHTEA73O91UBipB6hbrB88rlwakT7RV+IBWAjXSYwxcdWa3jnDddL
 ulD69yXzFWVmGLjfKXeIfxjzMEgjrG7OtHO8N905mPl5jahyDh3UJ25ueroDzabfb6lt
 H2yRvFUci9pqh9Q0fb9Ewxf+vtiOHXrDsM4zCQbukmuXsE5XarsqgqIdKaG8ODTZ2Hig
 z8MNq7IclpT5cD1cMXflFo1/DARyztAaY4lZYv2q/7t5/oMTdJ8t9GEUhzlJTcp8uUC2
 jyiHhiU2kn5XVU0kqeqDy1RzJJZwhXLTTZefgBXYLWynmXjZx2S1HBwC6DbYN5AiuLOw
 k7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790711403; x=1791316203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fsgHqsoEmVktmki3rLvPRNW4uqUOSN0xMf8lTsHaHW0=;
 b=2ckAZuSRUwKVLh4kPHfdDh2QOmjw0ItW7obxUV/PC+94/pe7rg0n/UpNssVnI6dZVq
 5esj7VUGiBR4TppyizVLi+aj3hZw3NEAHiB1/oVwS/w3kOBJ/RK8b7p5l3FrgDZOEafw
 LWYRm6JcLa7ZwPWF/vJaHrNtQaIU94G4HMIRkp4zOmG/6jf3qtixqixdgeH608A+rvGH
 9G1Yno964Rw0655og/K/6J70F4PwawrdEl9hiVfsA2zMHmnsNj0jY3YdXrAkqkzFIEfK
 r0LNbtFu39NLHoj7M/Z8IVHfuTquEghlec+5yuEVXa8ma/a/c0zijCpPnV0FRdg1JKzJ
 Aexw==
X-Gm-Message-State: AFuF++nkYkBIF9QuNvtrZig0ecWvU3JcUroaUvxOXW6OazMBmBuaF0oF
 uW/4D9kpfJtIm3mA+JT1HCpckJnXj8Qnk1aUUqvaZ6jZ0OG+dHBE6vaD2lLugvZaTCQ=
X-Gm-Gg: AYBFou0inwGSW6pT/RYLKLzo8EQHI8eLAXGKhezD/cpkve7XrL1i7g11CLwbV1sS4v2
 nkZ8d3GGqOhbLu+MN8qxhnBjUtVDnZsdA9929pfj/PwHGNxkxDF275X2rZ6lIhp0kf7I2oSIMXR
 MZhkNuFh3WXybpIcH5dxeHN8Ythd8xg0y1A858yNs68jL+xuY7Da52AMVb0us0NFhcAra05cxl3
 ye5jIQrAYhnhwdv3XB+/87fF8CeGkKjhnrMYsoqLQN0crepDpAQ95PsMbBhvXyRsrJMPsPLvgJh
 WtPxyASah4xyI0jJXmvli1wTOIeMKpFZLI8a3IAFJyAO6fn5hFZceD4C+C/rE5j2wi8Eg9cLylP
 9L6JxqUScRlJeouJAbtLpuhGYDEcd3iVE8KDeaF6LZutjyf1HQzfOSHobkomjDBfwDbIxa6uDkw
 SFME9ePSn5wLHwLHzjZEn0RXZxNq0anZYrflF6RFaEJivH3vnKOTXGQhxrrWP/UjmL8hQYLw3C5
 b0iX8Mv4aQaDPftFX+Db+DcIgO7Y8b6mQUz9esI
X-Received: by 2002:a05:6a20:748f:b0:3dd:a197:736e with SMTP id
 adf61e73a8af0-3de95386461mr51009637.71.1790711402617; 
 Tue, 29 Sep 2026 12:50:02 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868c9d74a7sm374884b3a.43.2026.09.29.12.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 12:50:02 -0700 (PDT)
Date: Tue, 29 Sep 2026 12:50:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v4 0/9] Limit usage of internal API in tests
Message-ID: <20260929125000.4800e8a2@phoenix.local>
In-Reply-To: <20260922094026.2636265-1-david.marchand@redhat.com>
References: <20260717093006.229370-1-david.marchand@redhat.com>
 <20260922094026.2636265-1-david.marchand@redhat.com>
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

On Tue, 22 Sep 2026 11:40:16 +0200
David Marchand <david.marchand@redhat.com> wrote:

> We had a few bug reports related to internal (and experimental) symbols
> issues during 26.07 development.
> See for example https://bugs.dpdk.org/show_bug.cgi?id=3D1957 or more
> recently https://bugs.dpdk.org/show_bug.cgi?id=3D1967.
>=20
> To catch such issues earlier in the CI, this series proposes to run
> the unit tests through meson with the ABI reference unit test binary
> against the current ABI libraries and drivers.
>=20
> For this to work, some unit tests must be skipped (since meson may
> invoke the ABI reference code with tests that were unknown at the time).
>=20
> A few unit tests were directly dereferencing internal structures and are
> reworked so they use public APIs.
>=20
> Additionally, unit tests were allowed to use any internal API which has
> hidden a few issues (like a public API backed by internal symbols in the
> hash library).
> So disable the global ALLLOW_INTERNAL_API and move it to code explicitly
> requiring internal API, with the hope it will push us to have better API.

=20
I think this causing breakage with minsize build. It is not correct to use
__rte_internal on inline helper functions in header file. I checked and only
thash has that anti-pattern.


In file included from ../lib/hash/rte_thash_gfni.h:13,
                 from ../lib/hash/rte_thash.h:23,
                 from ../app/test/test_thash_perf.c:13:
In function =E2=80=98rte_thash_gfni=E2=80=99,
    inlined from =E2=80=98run_rss_calc=E2=80=99 at ../app/test/test_thash_p=
erf.c:58:13:
../lib/hash/rte_thash_x86_gfni.h:181:27: error: call to =E2=80=98__rte_thas=
h_gfni=E2=80=99 declared with attribute error: Symbol is not public ABI
  181 |         __m512i xor_acc =3D __rte_thash_gfni(m, tuple, NULL, len);
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98rte_thash_gfni_bulk=E2=80=99,
    inlined from =E2=80=98run_rss_calc_bulk=E2=80=99 at ../app/test/test_th=
ash_perf.c:79:3,
    inlined from =E2=80=98run_thash_test=E2=80=99 at ../app/test/test_thash=
_perf.c:122:13:
../lib/hash/rte_thash_x86_gfni.h:213:27: error: call to =E2=80=98__rte_thas=
h_gfni=E2=80=99 declared with attribute error: Symbol is not public ABI
  213 |                 xor_acc =3D __rte_thash_gfni(mtrx, tuple[i], tuple[=
i + 1], len);
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~


AI analysis:

  Pre-existing: the actual bug

  lib/hash/rte_thash_x86_gfni.h:32 and :67 put __rte_internal on two static=
 inline
  helpers, __rte_thash_xor_reduce and __rte_thash_gfni. The public, stable =
(per
  b9dd86db2a) wrappers rte_thash_gfni() / rte_thash_gfni_bulk() call them. =
Those
  markers date to 4fd8c4cb0d ("hash: add new Toeplitz hash implementation")=
 =E2=80=94
  they've always been wrong. Any external application including rte_thash.h=
 without
  ALLOW_INTERNAL_API was already broken; 1f1c91397c just made DPDK's own tr=
ee hit
  the same wall.

  This is the same class of bug da31ef54c8 ("hash: fix GFNI stubs export") =
fixed
  for the out-of-line stubs =E2=80=94 it missed the inline helpers.

  Why only minsize

  __rte_internal expands to __attribute__((error(...))), which only fires i=
f the
  call survives to codegen:

  -O0 : 6    -O1 : 0    -O2 : 0    -O3 : 0    -Os : 2

  At -O1/-O2/-O3 GCC inlines the helper and the call vanishes. At -Os it de=
clines
  to inline (function too large), at -O0 it never inlines. So the marker wa=
s never
  actually enforcing anything at the default optimization levels =E2=80=94 =
it only
  detonates under specific inlining decisions. minsize and a debug build ar=
e the
  two configs that expose it.

  Recommended fix

  Drop __rte_internal from those two static inline helpers, rather than res=
toring
  ALLOW_INTERNAL_API to app/test. __rte_internal on a static inline in an i=
nstalled
  public header is wrong by construction: there's no exported symbol to pro=
tect,
  and it makes the public wrappers unusable from outside DPDK.

  Verified: with those two markers removed, test_thash.c and test_thash_per=
f.c both
  compile clean at -O0 and -Os (6=E2=86=920 and 2=E2=86=920). I grepped the=
 rest of lib/ and
  drivers/ for __rte_internal immediately preceding static inline in public=
 headers
  =E2=80=94 these two are the only instances, so a single small patch cover=
s it. Fixes:
  should point at 4fd8c4cb0d, not 1f1c91397c.

