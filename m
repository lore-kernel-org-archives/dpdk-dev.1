Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3591FEC01CB
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 11:27:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73ED840268;
	Mon, 23 Mar 2026 12:27:16 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 8E4D24025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 12:27:15 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-89c4f7f8650so46957766d6.0
 for <dev@dpdk.org>; Mon, 23 Mar 2026 04:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774265235; cv=none;
 d=google.com; s=arc-20240605;
 b=ePjgq6KfUS6G0+jjafNYGjMcTFzPUM5itbCR7rWyrdAHJTAPGDLZ3p1gdQvQv7/uEC
 hOn1bbS9bRYTAwRw1OBwrdCj1OBYAmvS4uZJKlcTgEIxb1WTsQHB1OPLWqYullWCqjTe
 K6nPZdMFP/7Fefmy/TDP9fKKK0/Gqs+hvjiRWDEpYMjw4Qz2edkSBbrD+MpqpKg7NJm/
 cjuJBw30nFhM/s0eSreEQfqTVw/plMrG+ypLBl6wWn8mNiJZr7Ub4R23meDLzNPvAaH6
 VZSflAPz9tn5fmyHEuF7n7mbdWahrMiy9+/sIMiYZJHu+IUhrI/HkQM65AJI7SxwNLdX
 gxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=GiKc3hqs5CADVFGtBgFyIgkDLBXh/8jUJCpvgC8RlMA=;
 fh=xVVqTmflr9u9pzgx9CdvkZxnz5ZOSjVXxTmuLZ6Z6Eo=;
 b=cOX/pp0f35E6Tg9AfsxEGP6i8vWbWcY6bZlCUiONAifJ/zGB1JJsEAXVNkPCCMDwSi
 +cWSMTGxPfdGJa0eIwKP3NDUwXEJDIWj+Dl3EKP4gJzRZImav4a9t0/eBFDsKDmqXweq
 /vhM6zssW9hktfTE7vDDTw9n0fvvg+wjgtYsqo6WRZ3rrGFssxmEgkUVG4rVPNxtUuII
 DBqLpKMCB9O6eqf2HxjSL4fBFP9poqNBKndAE17ZbMhAeel1H17qDVOnrl+t3s8ifPU6
 FZgHI4XUr8mI9kX8FX2te2FWidLftE7etbqo2TMS+CoiFwTKmuJ9FJ7ChxKeAxQdxpv0
 vWhQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774265235; x=1774870035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GiKc3hqs5CADVFGtBgFyIgkDLBXh/8jUJCpvgC8RlMA=;
 b=XizwOccqW4Jf5QgdBU7Kf8uh60jafoKHMA6SeH9tWL+jpQ4CsSOh59yygCXPGbX9Et
 +ldAFVwLW2R1dCCItbg8HPMnxj4pAnKBEAu2NFkl+8sODUjbokY43uhdhi3cWvV13PuI
 XYa/4IcUvIQoCywoC1kgMrM9VfJ5GlTk+eCPBCOoSN4Kc1hJEzlX1qxLECCaFaUdmCPl
 pErvM97Gx+dhHI5yTXWVMnzWvm7Iexiuf8P3vrkrmU13vMHvraMptM6nV5SQ0rADn7+X
 dl9ji310yPC5UscxcOV6W1p3xdgT8DB0jGigMAVNi4wkmu5B64w3+9k2Fr9MVlLf/jxG
 b+pA==
X-Gm-Message-State: AOJu0YzqiN029yzg8h4v5XU8BV1WB6NK1dlMfuyvyWbCo95WzoblSIVt
 +qDrKwY5kacyKrN8BGtQOUxio1actTZGJ022hUOI4yWAmYpKaWIP3Dl5JXxFeVMuehmUIe1aWLJ
 a5SXA0eKU+Vbkim2JwijpKp5svclu8kQ=
X-Gm-Gg: ATEYQzzzEARpwZ8yHW9vVgp56529DL9BMw+MTDZ/FBqjDQl5DVX9UgbtaFO7hnHMyz3
 PeipaVxiVuThN5XISeUFv7gcF4rTFvE5QmRVckmB8tSXiBpzESm6Mfgiu9RXqsleZZzQcNL8d+A
 nXy6iw8URxK1VTyMvo83V0Ry7+ClvjH6pbMevgKBACVHnn24alJae27DoKUzSHtnluH/4+kSzui
 RaYo2Dd086jTvFG64BemP6cKSv9AbNL5MkdTIMjcsuUXt3DyXqrxjZATyoKZQqLr5p/+QpAeYzo
 OfR5
X-Received: by 2002:a05:6214:21ae:b0:89c:8671:10a with SMTP id
 6a1803df08f44-89c8671033dmr187955686d6.0.1774265234663; Mon, 23 Mar 2026
 04:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
In-Reply-To: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 23 Mar 2026 12:27:03 +0100
X-Gm-Features: AaiRm50e4HITKa_0AcBhE_mSWkr76J14k-ohKmDKXczRd57-7CrozSx2VWZTPrw
Message-ID: <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, nsaxena16@gmail.com, 
 mb@smartsharesystems.com, adwivedi@marvell.com, jerinjacobk@gmail.com
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

 Hi Vladimir,


On Sun, Mar 22, 2026 at 4:42=E2=80=AFPM Vladimir Medvedkin
<vladimir.medvedkin@intel.com> wrote:
>
> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
> allowing a single FIB instance to host multiple isolated routing domains.
>
> Currently FIB instance represents one routing instance. For workloads tha=
t
> need multiple VRFs, the only option is to create multiple FIB objects. In=
 a
> burst oriented datapath, packets in the same batch can belong to differen=
t VRFs, so
> the application either does per-packet lookup in different FIB instances =
or
> regroups packets by VRF before lookup. Both approaches are expensive.
>
> To remove that cost, this series keeps all VRFs inside one FIB instance a=
nd
> extends lookup input with per-packet VRF IDs.
>
> The design follows the existing fast-path structure for both families. IP=
v4 and
> IPv6 use multi-ary trees with a 2^24 associativity on a first level (tbl2=
4). The
> first-level table scales per configured VRF. This increases memory usage,=
 but
> keeps performance and lookup complexity on par with non-VRF implementatio=
n.
>

Thanks for the RFC. Some thoughts below.

Memory cost: the flat TBL24 replicates the entire table for every VRF
(num_vrfs * 2^24 * nh_size). With 256 VRFs and 8B nexthops that is
32 GB for TBL24 alone. In grout we support up to 256 VRFs allocated
on demand -- this approach forces the full cost upfront even if most
VRFs are empty.

Per-packet VRF lookup: Rx bursts come from one port, thus one VRF.
Mixed-VRF bulk lookups do not occur in practice. The three AVX512
code paths add complexity for a scenario that does not exist, at
least for a classic router. Am I missing a use-case?

I am not too familiar with DPDK FIB internals, but would it be
possible to keep a separate TBL24 per VRF and only share the TBL8
pool? Something like pre-allocating an array of max_vrfs TBL24
pointers, allocating each TBL24 on demand at VRF add time, and
having them all point into a shared TBL8 pool. The TBL8 index in
TBL24 entries seems to already be global, so would that work without
encoding changes?

Going further: could the same idea extend to IPv6? The dir24_8 and
trie seem to use the same TBL8 block format (256 entries, same
(nh << 1) | ext_bit encoding, same size). Would unifying the TBL8
allocator allow a single pool shared across IPv4, IPv6, and all
VRFs? That could be a bigger win for /32-heavy and /128-heavy tables
and maybe a good first step before multi-VRF.

Regards,

Maxime Leroy

> Vladimir Medvedkin (4):
>   fib: add multi-VRF support
>   fib: add VRF functional and unit tests
>   fib6: add multi-VRF support
>   fib6: add VRF functional and unit tests
>
>  app/test-fib/main.c      | 257 ++++++++++++++++++++++--
>  app/test/test_fib.c      | 298 +++++++++++++++++++++++++++
>  app/test/test_fib6.c     | 319 ++++++++++++++++++++++++++++-
>  lib/fib/dir24_8.c        | 241 ++++++++++++++++------
>  lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
>  lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++--------
>  lib/fib/dir24_8_avx512.h |  80 +++++++-
>  lib/fib/rte_fib.c        | 158 ++++++++++++---
>  lib/fib/rte_fib.h        |  94 ++++++++-
>  lib/fib/rte_fib6.c       | 166 +++++++++++++---
>  lib/fib/rte_fib6.h       |  88 +++++++-
>  lib/fib/trie.c           | 158 +++++++++++----
>  lib/fib/trie.h           |  51 +++--
>  lib/fib/trie_avx512.c    | 225 +++++++++++++++++++--
>  lib/fib/trie_avx512.h    |  39 +++-
>  15 files changed, 2453 insertions(+), 396 deletions(-)
>
> --
> 2.43.0
>


--=20
-------------------------------
Maxime Leroy
maxime@leroys.fr
