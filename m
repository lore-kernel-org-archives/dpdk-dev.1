Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601FEC982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 21:59:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 579D640B94;
	Mon, 21 Sep 2026 23:59:31 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 87CC2402B0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 23:59:30 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747ee1f38so35679435ad.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790027969;
 x=1790632769; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WX4TMLmtMXTWJKDW/rf6cQbDBnRHbke9L67Fmt6DvCY=;
 b=Z5no0tz0OLmHJr9a3095JTAEackoSt2sfakgYfa6nn2YZyffiMDKzoMAocjpATGiEF
 DJXjSMp5U03ML+C5hzbjT9bayDffLfBaSqYjFAsQX92vOGM401HTcybXWytliEhfazMZ
 oAbB0j3GBfF30GVcgpuZvJGlw63kFlc6GdFrdQHXCjGZqE3BB+QX7ZN/GimXyZ7M0nLo
 xm0w/E7MaYTLC82kqxkUmceKUh/T2FMcK6J+49RLXiJwa/OnNp1iLMG2jKyyIT25BnYo
 TsqaPShZzZd1hfmPLHMTi3sIMywvwMIQL6GCfa9PUfSZXAU1us4xlw3U7DSUuh0L5eDA
 A0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027969; x=1790632769;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WX4TMLmtMXTWJKDW/rf6cQbDBnRHbke9L67Fmt6DvCY=;
 b=yRV+uaFfUJLxh4Jua7xZ20RrdaCG6OBs6btmAnctGnN+3gTt5ny0JLxcyq2njQDRsK
 t0XovpKibxaUveq7Tn5YxCdJOAM+mM6Ellq/TZQy6WkmX3lyat6SdpcWcwCGzgdOYxEU
 5xu82k5gWOifeirqead2ze4zMweCJzuLmNaSSDySz5W4WMJ7tyWFx4wNf8RZjxWJqRxL
 YEKfZRKnE/gmQRg9Hl5U70Byq+qvmGYAhUaObFylVfwMrcu0V/z7vp+dYWxaQvfIHvWf
 xf6Ycl8byneTziZCgKzChHwA0CyIWyQJuBPOxgiE/YhU4ee4dpA+4k5EuNKKozVkUQ1n
 C11w==
X-Gm-Message-State: AFuF++mb/+fqMcJbe9PNmXKpQbNxKTZ9c4hhq6vpXhA5e7MzK0q90IeP
 5EGXGkPr5MBsuJsp9ZeDO4Fz7voTGLDy3C99SQ6PZK1n3pcL0LVD3xfPa1+oW+p4kTs=
X-Gm-Gg: AYBFou24VWN8lKDqi7/Yp0n35n3mMWR+NBfhvOTpmluzy1rg/TYlbJkXCPzhaNbOyBS
 6qUiWaa98piPMKDwdMi34nZtTZVWrGjvTgonttwLg9/42bHbrqCiev9PSlyBskaFkkOJjpDKq/p
 3WHv9zch4/78mr7ayBdD/sAPEwiVmMCafz05LKY3A4CcObUZNIwsB9XyDjbKwkiLCSsrW3nNl24
 9SIQX9ucKkOdEuHREmMDjLc+yR+JayC+gO7u7bzdLlwAL83SI8MVy9QFsXEr/j1DOmUyOJs8adE
 CHUAllOZ5+wAoumJqTrvMOT5pBOOZDqKtYJalnfNP9HuoSlHwk7bKQV9pYA0k9gdqxXimVWjtjB
 qcClcD3e4tMjus4djRupPMpJ1fc9sjVxi17kfSnM+/kEN1yR12rnIPPWakITxIn8t1Ow2dZ8eRl
 cnyxxo9UWOWRirg44NWjta68w7XzipCC5L0WoJvU66ltWYDKfONwVWD6HqhRPbzkpcbBLLSi2PM
 KNSlKhMcrzNxVQP4osl5V3uwSeSv0/a4XwkL87A
X-Received: by 2002:a17:903:2ac6:b0:2dd:ad73:5b69 with SMTP id
 d9443c01a7336-2ddb1c4219cmr168996385ad.25.1790027969400; 
 Mon, 21 Sep 2026 14:59:29 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5b80409dsm858975ad.80.2026.09.21.14.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:59:28 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:59:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anurag Mandal <anurag.mandal@intel.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, vladimir.medvedkin@intel.com
Subject: Re: [PATCH v2] fib, rib: fix name prefixes
Message-ID: <20260921145927.7e3a1331@phoenix.local>
In-Reply-To: <20260813074626.1134195-1-anurag.mandal@intel.com>
References: <20260812110258.1128632-1-anurag.mandal@intel.com>
 <20260813074626.1134195-1-anurag.mandal@intel.com>
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

On Thu, 13 Aug 2026 07:46:26 +0000
Anurag Mandal <anurag.mandal@intel.com> wrote:

> The RIB library named the mempool holding its nodes "MP_<name>".
> That prefix is the one the mempool library itself prepends to
> the backing memzone, so the memzone ended up named
> "MP_MP_<name>" which is improper.
>=20
> The FIB library passed its own name unchanged to the underlying
> RIB and did not add a prefix to the RIB name.
>=20
> This patch makes name each object after its owner.
> The node mempool of a RIB is now "RIB_<name>" or "RIB6_<name>",
> and the RIB owned by a FIB is now "FIB_<name>" or "FIB6_<name>".
>=20
> A mempool name is limited to RTE_MEMPOOL_NAMESIZE, which is much
> shorter than RTE_RIB_NAMESIZE.
> The name was passed down silently and an oversized one surfaced
> as an opaque rte_mempool_create() failure, so check the derived
> name up front and return ENAMETOOLONG instead.
> As the prefixes above are added on top of the name, the new
> maximum length of a name is limited to the following:
> RIB : 21 characters
> RIB6: 20 characters
> FIB : 17 characters
> FIB6: 15 characters
> Hence, shortening  the names used by the graph nodes, the l3fwd
> example and the unit tests accordingly.
>=20
> Bugzilla ID: 1981 1982
> Fixes: 5a5793a5ffa2 ("rib: add RIB library")
> Fixes: f7e861e21c46 ("rib: support IPv6")
> Fixes: 39e927248416 ("fib: add FIB library")
> Fixes: 40d41a8a7b34 ("fib: support IPv6")
>=20
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

This looks good, but would also like to bump up memzone size as well.

AI review:
Review: [PATCH v2] fib, rib: fix name prefixes

Applied to main (6bbb7b3) with the release notes hunk excluded; that
hunk does not apply and needs a rebase. Builds with -Dwerror=3Dtrue.
rib, rib6, fib and fib6 autotests pass. Name length limits verified
with a probe program against the built libraries.

Warning

1. Fixes tags on a change that shrinks the accepted name length.

   RTE_MEMPOOL_NAMESIZE is 26, so a mempool name is at most 25
   characters. Before this patch the RIB mempool was "MP_<name>" and
   FIB passed its name through unchanged, so RIB, RIB6, FIB and FIB6
   all accepted names up to 22 characters. After this patch:

     RIB   22 -> 21
     RIB6  22 -> 20
     FIB   22 -> 17
     FIB6  22 -> 15

   An application using a 16..22 character FIB6 name works on 25.11
   and fails with ENAMETOOLONG after this patch. With Fixes tags the
   stable maintainers will consider it for backport, which would be a
   regression in an LTS.

   The "MP_MP_" memzone name is cosmetic. Split into two patches:
   the up-front length check with the Fixes tags (backportable, no
   limit change), and the prefix rename without Fixes for 26.11 only.

2. FIB length check does not enforce the FIB limit.

   rte_fib_create() and rte_fib6_create() check the prefixed name
   against sizeof(mem_name), which is RTE_FIB_NAMESIZE (64). The real
   limit is enforced one level down in rte_rib_create(), so an
   18 character FIB name produces:

     RIB: RIB name FIB_aaaaaaaaaaaaaaaaaa is too long, limit is 21
     FIB: Can not allocate RIB for FIB: FIB_aaaaaaaaaaaaaaaaaa

   The user never passed "FIB_..." and the stated limit is wrong for
   the FIB caller (21 vs 17; 20 vs 15 for FIB6). Check against the
   derived limit in FIB itself, and put the maximum name lengths in
   the public headers so applications can size names without reading
   release notes.

3. No test for the new ENAMETOOLONG path.

   The tests were only shortened to fit. Add cases to test_rib,
   test_rib6, test_fib and test_fib6 that create a name at the limit
   (expect success) and at limit + 1 (expect NULL with
   rte_errno =3D=3D ENAMETOOLONG).

Info

4. Release notes: "name,the" is missing a space; "maximum length of
   a name are" should be "is". The four limit lines are not a list in
   RST and render as one run-on paragraph; use a nested bullet list.

5. "Bugzilla ID: 1981 1982" should be one tag per line.

6. The comment "Add FIB Prefix to its mempool name" in rte_fib.c and
   rte_fib6.c is inaccurate; the prefixed string is the RIB name.
