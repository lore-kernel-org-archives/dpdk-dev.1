Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987ECF46135
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 14:53:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84FD240268;
	Mon, 23 Mar 2026 15:53:25 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id AEC2F4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 15:53:23 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-8cfbfdabf3fso20348385a.3
 for <dev@dpdk.org>; Mon, 23 Mar 2026 07:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774277603; cv=none;
 d=google.com; s=arc-20240605;
 b=OF7fYk6cZn2Q5OZXj7EIgUiVsEmAhEmIbnB/UEZn6RGELmm2WbCXuPvUb/fMPaMgrG
 +8ajeDtkPGEidMimfJsGJfdiIt3+dwWwMobtP3yycPsE7uWjgbY7NCp/bfO6UmsyVpdz
 S/SznK97n5r4GfYJqod4Dl9PRLTRmIBoFzNx55ccqFslys+H7OESTis3hk630X+wxadH
 0Z2E6djU/CBcraoSV1XWfiYzzOoE38dCrnbWgWkvdhiplD+8yhdCt8tSg4xleBHg31Yl
 Tmf6rbvWewBCG60FkR2mHJYZ4UOJZDIxCnqkveJHkwPNywCn+OoLLco5yng+0nqFSWYt
 dJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=LREh7+FGhCcFmcXDEHRH7iRgWpKH9kqPCNXlfodO1h4=;
 fh=8pT7u9hk2WTvbcf39wd7+qskt9leLQ+Z/kZWEYezVaw=;
 b=Lm6LvgSo060HBMTSeHZXtzykpPaXRhjO99+5BHSHSuUPL7If6M7XaTCP5/Rzc4YyDv
 9robwgKdK/4z5Zvo1Nvk3DiW5n1Dd+IhSyRK8/QkVW7UweP9fUeBbXjaiNKnYhmkBgWb
 0NJt2zj807P962e+mKP3G4gURK/9e/bEbXvI3+p2ZY1h0iw24cIzvYVApEyp4F0aVC2X
 N4ifGcuxFuSUFDIpLXOX4kyUKwNCZ4RFSkN4pyiKfKdMtVzmlRpN6V4GTf5gSoDWARBT
 XLFpC4YFgXq0faDTD5WnQ31bB/lPhLkrIVI0o+Gw1VtzWIGzXe6pIfOhkn89L9RYNwl4
 HBlg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774277603; x=1774882403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LREh7+FGhCcFmcXDEHRH7iRgWpKH9kqPCNXlfodO1h4=;
 b=SAN7nlcuM4hw5Gw5yj9QwHvnLGuO3lZOgNP2OGo0Vz0u9DBGfrx2J7y7z6bCLmoVg+
 n43lvqtd93Uc3TzkOcPpFXyaqGLtQ2fLYTOEendZeZYYIhTLascwXgUnfoLXUO96qxGL
 CEdx8ywuDa7MLGGSr6AkyniMzdBLMly494Dq7dJMPgPmEQMDNuYIeSOWlVlL+eqXmY59
 +xWz1XPY8lPdnN2U2LaCjlS6fPoxAP8HQ8z8tfN0d4bXpYnyJMKA50q5d55N5wq3lJ1B
 7ssk55GCQYdupS3A849OC5mIpFg7rjhJ2UokY1IODA2dy9qmk+PkOc7PtuK6hFE2gjz6
 U38g==
X-Gm-Message-State: AOJu0YwiQCcVR26iLRQriklzGBiqukqFQzv0GRRY2wtm4CRYcSOe6sxo
 z7D9qCGCCKOHZ95XxrJ1/5apkwQWy4/3PypW0+pCDr+4L9ii0C4uU/cnga4Ni3p6h2e3C+LF4vE
 nIjrnj0M9rpnWA/Vvdv8Sm22xcaNUEAw=
X-Gm-Gg: ATEYQzyWuBrTsOKvbv4b0hniSdjM7o2eoNWXoy7SfL4lA3rmV0whvAsRIqqdnZQcNqZ
 xx2C+qSozNF6AYRpERWP2rdUGITetsb5yVYVwwpS04QCJKwu8vGAEwJGHAX/pKL/mccX93Ti7Po
 pwNUhTJSU19D4r1IJwyce/NyT8ce7nMHuM2hpAXCwIw1q2ywVBUfbahvnfMwJwzFWimmjaOJ7k/
 1hVWjgZwKD/b5RO9srDYOXpUJSE5woJleKRso5MCKCRclUFCPfDk8zcEtf5coe+eo2eSlRWBaW4
 ibBm
X-Received: by 2002:a05:6214:1c0e:b0:89a:7c6b:6905 with SMTP id
 6a1803df08f44-89c859a93c6mr208755056d6.3.1774277602627; Mon, 23 Mar 2026
 07:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
 <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
In-Reply-To: <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Mon, 23 Mar 2026 15:53:11 +0100
X-Gm-Features: AQROBzBWRMSqm22JyyjoO1QMB9Eg9VNe6dPrz1jBCvYCN95K3Ev4o4gG61qRTEk
Message-ID: <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
To: "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
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

On Mon, Mar 23, 2026 at 1:49=E2=80=AFPM Medvedkin, Vladimir
<vladimir.medvedkin@intel.com> wrote:
>
> Hi Maxime,
>
> On 3/23/2026 11:27 AM, Maxime Leroy wrote:
> >   Hi Vladimir,
> >
> >
> > On Sun, Mar 22, 2026 at 4:42=E2=80=AFPM Vladimir Medvedkin
> > <vladimir.medvedkin@intel.com> wrote:
> >> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths by
> >> allowing a single FIB instance to host multiple isolated routing domai=
ns.
> >>
> >> Currently FIB instance represents one routing instance. For workloads =
that
> >> need multiple VRFs, the only option is to create multiple FIB objects.=
 In a
> >> burst oriented datapath, packets in the same batch can belong to diffe=
rent VRFs, so
> >> the application either does per-packet lookup in different FIB instanc=
es or
> >> regroups packets by VRF before lookup. Both approaches are expensive.
> >>
> >> To remove that cost, this series keeps all VRFs inside one FIB instanc=
e and
> >> extends lookup input with per-packet VRF IDs.
> >>
> >> The design follows the existing fast-path structure for both families.=
 IPv4 and
> >> IPv6 use multi-ary trees with a 2^24 associativity on a first level (t=
bl24). The
> >> first-level table scales per configured VRF. This increases memory usa=
ge, but
> >> keeps performance and lookup complexity on par with non-VRF implementa=
tion.
> >>
> > Thanks for the RFC. Some thoughts below.
> >
> > Memory cost: the flat TBL24 replicates the entire table for every VRF
> > (num_vrfs * 2^24 * nh_size). With 256 VRFs and 8B nexthops that is
> > 32 GB for TBL24 alone. In grout we support up to 256 VRFs allocated
> > on demand -- this approach forces the full cost upfront even if most
> > VRFs are empty.
>
> Yes, increased memory consumption is the
> trade-off.WemakethischoiceinDPDKquite often,such as pre-allocatedmbufs,
> mempoolsand many other stuff allocated in advance to gain performance.
> For FIB, I chose to replicate TBL24 per VRF for this same reason.
>
> And, as Morten mentioned earlier, if memory is the priority, a table
> instance per VRF allocated on-demand is still supported.
>
> The high memory cost stems from TBL24's design: for IPv4, it was
> justified by the BGP filtering convention (no prefixes more specific
> than /24 in BGPv4 full view), ensuring most lookups hit with just one
> random memory access. For IPv6, we should likely switch to a 16-bit TRIE
> scheme on all layers. For IPv4, alternative algorithms with smaller
> footprints (like DXR or DIR16-8-8, as used in VPP) may be worth
> exploring if BGP full view is not required for those VRFs.
>
> >
> > Per-packet VRF lookup: Rx bursts come from one port, thus one VRF.
> > Mixed-VRF bulk lookups do not occur in practice. The three AVX512
> > code paths add complexity for a scenario that does not exist, at
> > least for a classic router. Am I missing a use-case?
>
> That's not true, you're missing out on a lot of established core use
> cases that are at least 2 decades old:
>
> - VLAN subinterface abstraction. Each subinterface may belong to a
> separate VRF
>
> - MPLS VPN
>
> - Policy based routing
>

Fair point on VLAN subinterfaces and MPLS VPN. SRv6 L3VPN (End.DT4/
End.DT6) also fits that pattern after decap.

I agree DPDK often pre-allocates for performance, but I wonder if the
flat TBL24 actually helps here. Each VRF's working set is spread
128 MB apart in the flat table. Would regrouping packets by VRF and
doing one bulk lookup per VRF with separate contiguous TBL24s be
more cache-friendly than a single mixed-VRF gather? Do you have
benchmarks comparing the two approaches?

On the memory trade-off and VRF ID mapping: the API uses vrf_id as
a direct index (0 to max_vrfs-1). With 256 VRFs and 8B nexthops,
TBL24 alone costs 32 GB for IPv4 and 32 GB for IPv6 -- 64 GB total
at startup. In grout, VRF IDs are interface IDs that can be any
uint16_t, so we would also need to maintain a mapping between our
VRF IDs and FIB slot indices. We would need to introduce a max_vrfs
limit, which forces a bad trade-off: either set it low (e.g. 16)
and limit deployments, or set it high (e.g. 256) and pay 64 GB at
startup even with a single VRF. With separate FIB instances per VRF,
we only allocate what we use.

> >
> > I am not too familiar with DPDK FIB internals, but would it be
> > possible to keep a separate TBL24 per VRF and only share the TBL8
> > pool?
> it is how it is implemented right now with one note - TBL24 are pre
> allocated.
> > Something like pre-allocating an array of max_vrfs TBL24
> > pointers, allocating each TBL24 on demand at VRF add time,
> and you suggesting to allocate TBL24 on demand by adding an extra
> indirection layer. Thiswill leadtolowerperformance,whichIwouldliketo avoi=
d.
> >   and
> > having them all point into a shared TBL8 pool. The TBL8 index in
> > TBL24 entries seems to already be global, so would that work without
> > encoding changes?
> >
> > Going further: could the same idea extend to IPv6? The dir24_8 and
> > trie seem to use the same TBL8 block format (256 entries, same
> > (nh << 1) | ext_bit encoding, same size). Would unifying the TBL8
> > allocator allow a single pool shared across IPv4, IPv6, and all
> > VRFs? That could be a bigger win for /32-heavy and /128-heavy tables
> > and maybe a good first step before multi-VRF.
>
> So, you are suggesting merging IPv4 and IPv6 into a single unified FIB?
> I'm not sure how this can be a bigger win, could you please elaborate
> more on this?

On the IPv4/IPv6 TBL8 pool: I was not suggesting merging FIBs, just
sharing the TBL8 block allocator between separate FIB instances.
This is possible since dir24_8 and trie use the same TBL8 block
format (256 entries, same encoding, same size).

Would it be possible to pass a shared TBL8 pool at rte_fib_create()
time? Each FIB keeps its own TBL24 and RIB, but TBL8 is shared
across all FIBs and potentially across IPv4/IPv6. Users would no
longer have to guess num_tbl8 per FIB.

>
> > Regards,
> >
> > Maxime Leroy
> >
> >> Vladimir Medvedkin (4):
> >>    fib: add multi-VRF support
> >>    fib: add VRF functional and unit tests
> >>    fib6: add multi-VRF support
> >>    fib6: add VRF functional and unit tests
> >>
> >>   app/test-fib/main.c      | 257 ++++++++++++++++++++++--
> >>   app/test/test_fib.c      | 298 +++++++++++++++++++++++++++
> >>   app/test/test_fib6.c     | 319 ++++++++++++++++++++++++++++-
> >>   lib/fib/dir24_8.c        | 241 ++++++++++++++++------
> >>   lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
> >>   lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++------=
--
> >>   lib/fib/dir24_8_avx512.h |  80 +++++++-
> >>   lib/fib/rte_fib.c        | 158 ++++++++++++---
> >>   lib/fib/rte_fib.h        |  94 ++++++++-
> >>   lib/fib/rte_fib6.c       | 166 +++++++++++++---
> >>   lib/fib/rte_fib6.h       |  88 +++++++-
> >>   lib/fib/trie.c           | 158 +++++++++++----
> >>   lib/fib/trie.h           |  51 +++--
> >>   lib/fib/trie_avx512.c    | 225 +++++++++++++++++++--
> >>   lib/fib/trie_avx512.h    |  39 +++-
> >>   15 files changed, 2453 insertions(+), 396 deletions(-)
> >>
> >> --
> >> 2.43.0
> >>
> >
> --
> Regards,
> Vladimir
>


--=20
-------------------------------
Maxime Leroy
maxime@leroys.fr
