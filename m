Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEEDE9A745
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 09:19:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85B54402BE;
	Tue, 24 Mar 2026 10:19:30 +0100 (CET)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 0EDBC4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 10:19:29 +0100 (CET)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8cfc137464dso545934485a.2
 for <dev@dpdk.org>; Tue, 24 Mar 2026 02:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774343968; cv=none;
 d=google.com; s=arc-20240605;
 b=f1VCKxDFwaVvXpTF99hPbrId7hN1MHyx5iA+Tu1sctc0kGcJjzDeVHoe9ffN1BLLDS
 bvjqZe4kcwqMu3smY9nMdzWoDLTHTO6ULg0HW//1TPhW/F1pAXTqOk5xQLjGBIS3W4Wg
 g2iOJAYIM9beqUsD+YFprIlgf0cXieDN+G25APseRyitWaxXUMmA9S7t17EoWv5lTAhv
 c/5TJVWPsomvvCUrroomisnAYnFe69l+o03IMXcMjbboydi6T2Mds3MyCQV0CueklBxG
 9957AsMvIVNnMVQcXgELP5hXRbQNkXSXYiFcPbkvje21CTa8+b/VHfC+vRnArG3NTl3L
 8PAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=mwa2XgUppmz1CE2e/noWDQLQrSy/4iNACxXaFwW9V1A=;
 fh=8pT7u9hk2WTvbcf39wd7+qskt9leLQ+Z/kZWEYezVaw=;
 b=EyDSJe49EiHB1X66x04z3c36NkvCQNTTnutdSbyLQK8nMFELxzP/67IMJgfP/MO5V9
 ly9LdYvSBTg/kzjBEFwef8vRgqU5ytfsu27OCwJyQuApAPIv3AxN8Gjgn8+2fMP/S2et
 RFIxWtghKji/NIvvsFIg95QPNCQXuQo2npy/efFwgDs9lOtVoYQ1L8IESH3pYYCuZ9Rw
 pmO7E4A3N+7UFqyBh8tZzDgUGVJTTAEj/tdmMdI4ph7F9UZ5igZYJ8mNVl2lhHrz9li6
 GnViUw6COK0fkjqo1XjsA7OgOtG2efB1C9XtJC330Nr1LEM7ptesY1g3klfz41C8Z8Vl
 scYw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774343968; x=1774948768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mwa2XgUppmz1CE2e/noWDQLQrSy/4iNACxXaFwW9V1A=;
 b=eBNtpOVamtGj5OEy3/+FAxRFNmn+TiFm5KxpHv2JCFT2zS8fEdRXh2enTXhoEWgi4m
 cDk2fv6xaUHoC31FF5Wze4NJsWIE+jIVvwKXcXwV4Te+AznM69XglGY1oR3kS92KHanz
 By4Tuc7ih0Uc4uKdn8P/hwtt5YlkcDt+9fI5OXVoU3zQFmxjq4XjZsWCpkcdCyj9CHuN
 N6RMHKVrOGDbIR/6OZwTewF6a+aeUZnBylN3q5ExCj7e11g8tZTq2r8+JaVt0oCQnkdJ
 R9ig7kYwqMU2dXQyBtdAmW69rBoYxZpyhyEtMOUq8oRFrddIQbVSsG+SxZLEI+DyST0/
 bW/g==
X-Gm-Message-State: AOJu0YyP+U6n3uXX3YqReX4malFSKEznEWA+jtjGJjFV1Wxg9H00ct9W
 apZro+aW0yAD8ECBTWRdemZOM3s0CyERkB40ThHE1U96euaSkbefmLTlHL3NaaK19Zd138RPYQ4
 AOXsocjsZctaLBtzisQH/rqPXsi+uBVs=
X-Gm-Gg: ATEYQzwwBtwMXAsrlFBGRV30n+Bcz4X2hXnKmeFMXkHS/rvtpg9NJmLLndsjDsYrjrv
 AseYi2eYF1o2sepHp70MKaGHXDDljqk2U7+N3/Cp7A3M5vWQ0QYUyRup0xA31lgiUc81s6IIV+g
 BHX2Oj9ifzVSSLarwWXHNMzSi3RbCL06wUZKMwsMMKo74B8xsh/L1E1eTkfkW+gO+qv4Se40Ote
 dYjxJ4zpe81UnpsqIKyajdSYErwhGZI62EwqEgZmuPikwDh8nOuVtjpLPUZkofS+hAr/WHPN7Y7
 QoBj
X-Received: by 2002:a05:620a:45a9:b0:8cf:c218:739b with SMTP id
 af79cd13be357-8cfc7e7312dmr2178403585a.18.1774343968159; Tue, 24 Mar 2026
 02:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
 <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
 <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
 <d944f17d-35a7-42d3-9011-2d368f530474@intel.com>
In-Reply-To: <d944f17d-35a7-42d3-9011-2d368f530474@intel.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Tue, 24 Mar 2026 10:19:17 +0100
X-Gm-Features: AQROBzA4jxlCJZXtLlPi-CWKDgvog0pm_l0ox-GmzW3Y5nf2KAdqfwi6pE_uy18
Message-ID: <CAHHRULXCfeFrgTosCJCvMK0+Qe-eBy2bJs43KDvEwYC6A6GRCg@mail.gmail.com>
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

Hi Vladimir,

On Mon, Mar 23, 2026 at 7:46=E2=80=AFPM Medvedkin, Vladimir
<vladimir.medvedkin@intel.com> wrote:
>
>
> On 3/23/2026 2:53 PM, Maxime Leroy wrote:
> > On Mon, Mar 23, 2026 at 1:49=E2=80=AFPM Medvedkin, Vladimir
> > <vladimir.medvedkin@intel.com> wrote:
> >> Hi Maxime,
> >>
> >> On 3/23/2026 11:27 AM, Maxime Leroy wrote:
> >>>    Hi Vladimir,
> >>>
> >>>
> >>> On Sun, Mar 22, 2026 at 4:42=E2=80=AFPM Vladimir Medvedkin
> >>> <vladimir.medvedkin@intel.com> wrote:
> >>>> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths b=
y
> >>>> allowing a single FIB instance to host multiple isolated routing dom=
ains.
> >>>>
> >>>> Currently FIB instance represents one routing instance. For workload=
s that
> >>>> need multiple VRFs, the only option is to create multiple FIB object=
s. In a
> >>>> burst oriented datapath, packets in the same batch can belong to dif=
ferent VRFs, so
> >>>> the application either does per-packet lookup in different FIB insta=
nces or
> >>>> regroups packets by VRF before lookup. Both approaches are expensive=
.
> >>>>
> >>>> To remove that cost, this series keeps all VRFs inside one FIB insta=
nce and
> >>>> extends lookup input with per-packet VRF IDs.
> >>>>
> >>>> The design follows the existing fast-path structure for both familie=
s. IPv4 and
> >>>> IPv6 use multi-ary trees with a 2^24 associativity on a first level =
(tbl24). The
> >>>> first-level table scales per configured VRF. This increases memory u=
sage, but
> >>>> keeps performance and lookup complexity on par with non-VRF implemen=
tation.
> >>>>
> >>> Thanks for the RFC. Some thoughts below.
> >>>
> >>> Memory cost: the flat TBL24 replicates the entire table for every VRF
> >>> (num_vrfs * 2^24 * nh_size). With 256 VRFs and 8B nexthops that is
> >>> 32 GB for TBL24 alone. In grout we support up to 256 VRFs allocated
> >>> on demand -- this approach forces the full cost upfront even if most
> >>> VRFs are empty.
> >> Yes, increased memory consumption is the
> >> trade-off.WemakethischoiceinDPDKquite often,such as pre-allocatedmbufs=
,
> >> mempoolsand many other stuff allocated in advance to gain performance.
> >> For FIB, I chose to replicate TBL24 per VRF for this same reason.
> >>
> >> And, as Morten mentioned earlier, if memory is the priority, a table
> >> instance per VRF allocated on-demand is still supported.
> >>
> >> The high memory cost stems from TBL24's design: for IPv4, it was
> >> justified by the BGP filtering convention (no prefixes more specific
> >> than /24 in BGPv4 full view), ensuring most lookups hit with just one
> >> random memory access. For IPv6, we should likely switch to a 16-bit TR=
IE
> >> scheme on all layers. For IPv4, alternative algorithms with smaller
> >> footprints (like DXR or DIR16-8-8, as used in VPP) may be worth
> >> exploring if BGP full view is not required for those VRFs.
> >>
> >>> Per-packet VRF lookup: Rx bursts come from one port, thus one VRF.
> >>> Mixed-VRF bulk lookups do not occur in practice. The three AVX512
> >>> code paths add complexity for a scenario that does not exist, at
> >>> least for a classic router. Am I missing a use-case?
> >> That's not true, you're missing out on a lot of established core use
> >> cases that are at least 2 decades old:
> >>
> >> - VLAN subinterface abstraction. Each subinterface may belong to a
> >> separate VRF
> >>
> >> - MPLS VPN
> >>
> >> - Policy based routing
> >>
> > Fair point on VLAN subinterfaces and MPLS VPN. SRv6 L3VPN (End.DT4/
> > End.DT6) also fits that pattern after decap.
> >
> > I agree DPDK often pre-allocates for performance, but I wonder if the
> > flat TBL24 actually helps here. Each VRF's working set is spread
> > 128 MB apart in the flat table. Would regrouping packets by VRF and
> > doing one bulk lookup per VRF with separate contiguous TBL24s be
> > more cache-friendly than a single mixed-VRF gather? Do you have
> > benchmarks comparing the two approaches?
>
> It depends. Generally, if we assume that we are working with wide
> internet traffic, then even for a single VRF we most likely will miss
> the cache for TLB24, thus, regardless of the size of the tbl24, each
> memory access will be performed directly to DRAM.

If the lookup is DRAM-bound anyway, then the 10 cycles/addr cost
is dominated by memory latency, not CPU. The CPU cost of a bucket
sort on 32-64 packets is negligible next to a DRAM access (~80-100
ns per cache miss). That actually makes the case for regroup +
per-VRF lookup: the regrouping is pure CPU work hidden behind
memory stalls, and each per-VRF bulk lookup hits a contiguous
TBL24 instead of scattering across 128 MB-apart VRF regions.

> And if the addresses are localized (i.e. most traffic is internal), then
> having multiple TBL24 won'tmake the situationmuchworse.
>

With localized traffic, regrouping by VRF + per-VRF lookup on
contiguous TBL24s would benefit from cache locality, while the
flat multi-VRF table spreads hot entries 128 MB apart. The flat
approach may actually be worse in that scenario

> I don't have any benchmarks for regrouping, however I have 2 things to
> consider:
>
> 1. lookup is relatively fast (for IPv4 it is about 10 cycles per
> address, and I don't really want to slow it down)
>
> 2. incoming addresses and their corresponding VRFs are not controlled by
> "us", so this is a random set. Regrouping effectively is sorting. I'm
> not really happy to have nlogn complexity on a fast path :)

Without benchmarks, we do not know whether the flat approach is
actually faster than regroup + per-VRF lookup.

>
> >
> > On the memory trade-off and VRF ID mapping: the API uses vrf_id as
> > a direct index (0 to max_vrfs-1). With 256 VRFs and 8B nexthops,
> > TBL24 alone costs 32 GB for IPv4 and 32 GB for IPv6 -- 64 GB total
> > at startup. In grout, VRF IDs are interface IDs that can be any
> > uint16_t, so we would also need to maintain a mapping between our
> > VRF IDs and FIB slot indices.
> of course, this is an application responsibility. In FIB VRFs are in
> continuous range.
> >   We would need to introduce a max_vrfs
> > limit, which forces a bad trade-off: either set it low (e.g. 16)
> > and limit deployments, or set it high (e.g. 256) and pay 64 GB at
> > startup even with a single VRF. With separate FIB instances per VRF,
> > we only allocate what we use.
> Yes, I understand this. In the end, if the user wants to use 256 VRFs,
> the amount of memory footprint will be at least 64Gb anyway.

The difference is when the memory is committed. With separate FIB
instances per VRF, you allocate 128 MB only when a VRF is actually
created at runtime. With the flat multi-VRF approach, you pay
max_vrfs * 128 MB at startup, even if only one VRF is active.

On top of that, the API uses vrf_id as a direct index (0 to
max_vrfs-1). As Stephen noted, there are multiple ways to model
VRFs. Depending on the networking stack, VRFs are identified by
ifindex (Linux l3mdev), by name (Cisco, Juniper), or by some
other scheme. This means the application must maintain a mapping
between its own VRF representation and the FIB slot indices, and
choose max_vrfs upfront. What is the benefit of this flat
multi-VRF FIB if the application still needs to manage a
translation layer and pre-commit memory for VRFs that may never
exist?

> As a trade-off for a bad trade-off ;) I can suggest to allocate it in
> chunks. Let's say you are starting with 16 VRFs, and during runtime, if
> the user wants to increase the number of VRFs above this limit, you can
> allocate another 16xVRF FIB. Then, of course, you need to split
> addresses into 2 bursts each for each FIB handle.

But then we are back to regrouping packets -- just by chunk of
VRFs instead of by individual VRF. If we have to sort the burst
anyway, what does the flat multi-VRF table buy us?

> >
> >>> I am not too familiar with DPDK FIB internals, but would it be
> >>> possible to keep a separate TBL24 per VRF and only share the TBL8
> >>> pool?
> >> it is how it is implemented right now with one note - TBL24 are pre
> >> allocated.
> >>> Something like pre-allocating an array of max_vrfs TBL24
> >>> pointers, allocating each TBL24 on demand at VRF add time,
> >> and you suggesting to allocate TBL24 on demand by adding an extra
> >> indirection layer. Thiswill leadtolowerperformance,whichIwouldliketo a=
void.
> >>>    and
> >>> having them all point into a shared TBL8 pool. The TBL8 index in
> >>> TBL24 entries seems to already be global, so would that work without
> >>> encoding changes?
> >>>
> >>> Going further: could the same idea extend to IPv6? The dir24_8 and
> >>> trie seem to use the same TBL8 block format (256 entries, same
> >>> (nh << 1) | ext_bit encoding, same size). Would unifying the TBL8
> >>> allocator allow a single pool shared across IPv4, IPv6, and all
> >>> VRFs? That could be a bigger win for /32-heavy and /128-heavy tables
> >>> and maybe a good first step before multi-VRF.
> >> So, you are suggesting merging IPv4 and IPv6 into a single unified FIB=
?
> >> I'm not sure how this can be a bigger win, could you please elaborate
> >> more on this?
> > On the IPv4/IPv6 TBL8 pool: I was not suggesting merging FIBs, just
> > sharing the TBL8 block allocator between separate FIB instances.
> > This is possible since dir24_8 and trie use the same TBL8 block
> > format (256 entries, same encoding, same size).
> >
> > Would it be possible to pass a shared TBL8 pool at rte_fib_create()
> > time? Each FIB keeps its own TBL24 and RIB, but TBL8 is shared
> > across all FIBs and potentially across IPv4/IPv6. Users would no
> > longer have to guess num_tbl8 per FIB.
> Yes, this is possible. However, this will significantly complicate the
> work with the library, solving a not so big problem.

Your series already shares TBL8 across all VRFs within a single
FIB -- that part is useful, and it does not require the flat
multi-VRF TBL24.

In grout, routes arrive from FRR (BGP, OSPF, etc.) at runtime.
We cannot predict TBL8 usage per VRF in advance -- it depends on
prefix length distribution which varies per VRF and changes over
time. No production LPM (Linux kernel, JunOS, IOS) asks the
operator to size these structures per routing table upfront.
Today we do not even have TBL8 usage stats (Robin's series
addresses that), and there is no way to resize a FIB without
destroying and recreating it.

Could you share performance numbers comparing the flat multi-VRF
lookup against regroup + per-VRF lookup?

> >>> Regards,
> >>>
> >>> Maxime Leroy
> >>>
> >>>> Vladimir Medvedkin (4):
> >>>>     fib: add multi-VRF support
> >>>>     fib: add VRF functional and unit tests
> >>>>     fib6: add multi-VRF support
> >>>>     fib6: add VRF functional and unit tests
> >>>>
> >>>>    app/test-fib/main.c      | 257 ++++++++++++++++++++++--
> >>>>    app/test/test_fib.c      | 298 +++++++++++++++++++++++++++
> >>>>    app/test/test_fib6.c     | 319 ++++++++++++++++++++++++++++-
> >>>>    lib/fib/dir24_8.c        | 241 ++++++++++++++++------
> >>>>    lib/fib/dir24_8.h        | 255 ++++++++++++++++--------
> >>>>    lib/fib/dir24_8_avx512.c | 420 +++++++++++++++++++++++++++++++---=
-----
> >>>>    lib/fib/dir24_8_avx512.h |  80 +++++++-
> >>>>    lib/fib/rte_fib.c        | 158 ++++++++++++---
> >>>>    lib/fib/rte_fib.h        |  94 ++++++++-
> >>>>    lib/fib/rte_fib6.c       | 166 +++++++++++++---
> >>>>    lib/fib/rte_fib6.h       |  88 +++++++-
> >>>>    lib/fib/trie.c           | 158 +++++++++++----
> >>>>    lib/fib/trie.h           |  51 +++--
> >>>>    lib/fib/trie_avx512.c    | 225 +++++++++++++++++++--
> >>>>    lib/fib/trie_avx512.h    |  39 +++-
> >>>>    15 files changed, 2453 insertions(+), 396 deletions(-)
> >>>>
> >>>> --
> >>>> 2.43.0
> >>>>
> >> --
> >> Regards,
> >> Vladimir
> >>
> >
> --
> Regards,
> Vladimir
>

Regards,

Maxime
