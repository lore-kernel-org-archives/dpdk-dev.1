Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC61606A324
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RWvlyKZc
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B99040608;
	Tue, 20 Oct 2026 16:23:38 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 8EF5A40283
 for <dev@dpdk.org>; Tue, 20 Oct 2026 16:23:37 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2ea1e7fad99so4680515ad.1
 for <dev@dpdk.org>; Tue, 20 Oct 2026 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792506216;
 x=1793111016; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vn/u3kbpOL64AWh5A4afd5z1dX5k0nFijbvdyNhQv/w=;
 b=RWvlyKZcEqznSI5DnnQdMFWdBRudJMjZBcSZ3eReIGvbP6e90NVX2IRAp+FSH/ypN/
 wjClStiOPgh5gxhFX30fBIEyhpYdFsYGPMkiOgA4Oy/q81mYqOcNh2qoJgMfU4jH4Fe1
 wFOBqVjZMTIdPIkXkgg5s/8uU41CEMt9T9EzO2u0NaQ+ra1xQHS35ISLdCOG3E+8KWhx
 c26/IwhznD2Z8BUvZJvnzbmBPQGVsHCHCdSm/4a0OZvDzKgDt63iUydvG3e5ui/rx8y9
 31L7tebicD/veJJIrhLLr/tSM/CXKVInHbWx8SR4ZMXY0Lg0eS4IWrON6+aQRoNd+UUQ
 vXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792506216; x=1793111016;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vn/u3kbpOL64AWh5A4afd5z1dX5k0nFijbvdyNhQv/w=;
 b=1urX4NAsxOlu7za/0ffsa6QBByiWRg4aYLupSec/WFQXNSvC89H3IrNqab8b4EN7ef
 vVf1uTXSgDDG/ezFEabf3pyrIX8fd7ebERnm2jheT+SfFuVOig2F3C86keBncFNG91tb
 rDRKXPiJbQbvJKz3Ub0NyldzWJX+ePVrdLSRAjC2iMAtaupWqELEcrX+3ciD3AGr26Mk
 yJX+4Af3u4xIW9dh/XvGjDO3275HYf6xjOwsAOF0iW5uEjyK/KXlhrcZ/5Ych+OL7GWj
 gitLL+Z7nrVyq3PUWTaCjQaDk+D8twR+6vhKX8OY1RgiK8WwJNncRV+sWYtJKQBxUSr/
 M7ew==
X-Gm-Message-State: AFq9FYL/m6zqIt1Iy/2yptfsjJQaKbgRF8l64Hmon3RGYTN9itYSdUXD
 g3dEWnGvSc2Uy7hLkeP+gq3z+bY7D5uazsi/I0Mq8NjDCktzHAslTCYtiF4hN+Yvfj4=
X-Gm-Gg: AYBFou0XmHQpCjoPv6pWAdinacgVf6dF2aSbsqBqMPe6n48G4L2Wp264234RDb22p4Z
 MNDiTKylKuqTE09SZMAJE/c7RZzfC39UnT/fcJeR/KkPuNrJ3EotguE/CURDkzsM8RMVgBuSlba
 4KftUWwdVEnMPNQvDkk1h0u78P9REHAtuWsj0NbSQstLo3Y7oYdpA7QkwSaNqOljC0fIQ47VHlT
 tvbXBIlncmsNSBZ/QLeEjaWz0RpGgq9dOKG4Bu0VwRXoV/W+KAh+XVNaW9QtDwbJGoY5xZKzSDo
 DI7Y1cNdpyIig+rnUZXYDvBY+JqMWzUjt9OeOiIHFUMPF2O3+MkgGDcSPaKwthrm+ZGsgZbuxPK
 hPceIXjEh3f6vhKujJ3JWDO+0JkkaOJi67qqjsshwf7DU9AmOLmkFAJadFrbXWskI9vZUsT3/5d
 XGm38TkYJ80nC5RO3zsnq3jwCWfr2domAXSVx4n5zf8QJJpKZCUVi+TafUWaxaTGVhy7NkanjVa
 bgeppt8dp4XPIaitZUL0PCAOamy5bSjDkvjXtdLOo42J5FvG22dGCLYu3p+S82eSguBFS07PdV6
 nyA15WeRGc3tk7KCtSEuyZxNX6o8j3hgkm8vAWWH294=
X-Received: by 2002:a17:903:19c7:b0:2e9:723a:cf37 with SMTP id
 d9443c01a7336-2e9a7054fa2mr78103425ad.50.1792506216469; 
 Tue, 20 Oct 2026 07:23:36 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea14deaa17sm13060615ad.36.2026.10.20.07.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:23:36 -0700 (PDT)
Date: Tue, 20 Oct 2026 07:23:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Bruce Richardson
 <bruce.richardson@intel.com>, Ali Alnubani <alialnu@nvidia.com>
Subject: Re: [PATCH] stack: fix pile GCC memcpy warnings
Message-ID: <20261020072333.30593486@phoenix.local>
In-Reply-To: <20261020084944.3188987-1-mb@smartsharesystems.com>
References: <20261020084944.3188987-1-mb@smartsharesystems.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 08:49:44 +0000
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> On architectures where rte_memcpy() is defined as memcpy(),
> GCC warns about source/destination overflow when copying more than the
> source/destination size, even for code paths that are not taken in cases
> where the sizes are smaller.
>=20
> The relevant compiler warnings were disabled for GCC at the two
> occurrences, and comments describing the reason were added.
>=20
> NB:
> It has not been investigated which GCC versions are affected.
> GCC version 10 and up was chosen because that was what the previous
> versions of x86 rte_memcpy() disabled sligthly similar warnings for.
>=20
> PS:
> The alternative was to obfuscate the code, but that would make the code
> less readable, and might have unintended effects on architectures and
> compilers not suffering by this issue.
>=20
> Bugzilla ID: 2061
> Fixes: ee0822a0ef41 ("stack: introduce pile")
>=20
> The pile was introduce with this DPDK release, so no need to backport.
>=20
> Reported-by: Ali Alnubani <alialnu@nvidia.com>
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---

I don't like using compiler pragmas for this. It also means that if
compiler gets fixed or behaves differently you will never see it.


AI analysis shows some other options.

Root cause is --buildtype=3Ddebug, i.e. -O0, not the GCC version. At -O0 no=
thing removes the dead n_bulk > 0 path for rte_stack_push(s, &obj, 1), so t=
he constant 256-byte memcpy is checked against obj (8 bytes) and warns. Rep=
roduced with GCC 13.3 and 14.2 at -O0; silent at -Og and above. That means =
the GCC_VERSION >=3D 100000 gate is wrong at both ends: any GCC with the wa=
rning fires (overflow since 8, overread since 11), and on GCC 10 the -Wstri=
ngop-overread pragma itself is a -Wpragmas error under -Werror. If the prag=
ma stays, drop the version gate (keep RTE_TOOLCHAIN_GCC) and fix the commen=
t: GCC does not =E2=80=9Cknow=E2=80=9D the path is dead, that is the whole =
problem.


This should have a big ass comment, and it should use same pragma set as ex=
isting one in lib/ring.

Other alternative is to use bulk object array as structure and do assignmen=
t.
But that replaces ugly pragmas with ugly casts...

--- a/lib/stack/rte_stack_pile.h
+++ b/lib/stack/rte_stack_pile.h
@@
+/* Bulk object array as a single object, so a copy is one assignment. */
+struct rte_stack_pile_bulk_objs {
+	void *objs[RTE_STACK_PILE_BULK_SIZE];
+};
+
@@ __rte_stack_pile_bulk_pop_elems
 		for (unsigned int i =3D 0; i < num; i++, tmp =3D tmp->next)
-			rte_memcpy(&obj_table[i * RTE_STACK_PILE_BULK_SIZE],
-					((struct rte_stack_pile_bulk_elem *)tmp)->objs,
-					sizeof(void *) * RTE_STACK_PILE_BULK_SIZE);
+			*(struct rte_stack_pile_bulk_objs *)&obj_table[i * RTE_STACK_PILE_BULK_=
SIZE] =3D
+				*(struct rte_stack_pile_bulk_objs *)((struct rte_stack_pile_bulk_elem =
*)tmp)->objs;
@@ __rte_stack_pile_push
 	for (i =3D 0; i < n_bulk; i++, tmp =3D tmp->next)
-		rte_memcpy(((struct rte_stack_pile_bulk_elem *)tmp)->objs,
-				&obj_table[(n_bulk - i - 1) * RTE_STACK_PILE_BULK_SIZE],
-				sizeof(void *) * RTE_STACK_PILE_BULK_SIZE);
+		*(struct rte_stack_pile_bulk_objs *)((struct rte_stack_pile_bulk_elem *)=
tmp)->objs =3D
+			*(const struct rte_stack_pile_bulk_objs *)&obj_table[(n_bulk - i - 1) *=
 RTE_STACK_PILE_BULK_SIZE];


