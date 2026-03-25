Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913F21093168
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 21:43:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48165406BC;
	Wed, 25 Mar 2026 22:43:56 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9469E4067B
 for <dev@dpdk.org>; Wed, 25 Mar 2026 22:43:55 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-5094ba0af1aso4134411cf.0
 for <dev@dpdk.org>; Wed, 25 Mar 2026 14:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774475035; cv=none;
 d=google.com; s=arc-20240605;
 b=e/F/xZggNOWtXVEaURsBA5FEBflVorqxEkCn9r0NvrpYbr1TywUQpYQQJIPqaGF9qY
 m0Ln4MlVkFaogacC7PSf75iAmCxu2GC1phoOXYY9iRKch4GR3+t3xcoiyzgz9Tf6ndBg
 vYucloKh8JAIKEGPBoNRh2kqeZb2K7SuyX8O/MAtt7uttRv0I8IWxlUVA+vc1MTKG3mR
 qZ7e5UyahMTifAXrH8OxPPYbX1lZSvYRwefH4mmz15epYZ5u2InTegju5QRBta9i3pKg
 dAeBV+OrpVw3/EETAJTFxCVhtv5aY1BEWYyMLm9dpA5xEAYLW/iSeMV55eTty1OQ4xH1
 /6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=F/Ltg+n53UjRj/ZyjvJucV6NyqlB6aQs52RdBLwRi/0=;
 fh=8pT7u9hk2WTvbcf39wd7+qskt9leLQ+Z/kZWEYezVaw=;
 b=UVjSEg1t4gYiYUqx09DAlizralh7BqA8FNAfKY8oDenTiwjCLouD99mlv0S5MTR/HG
 dEkNDPKCuWeLCBbZCAtgAaHduN7+hts1BvYQraAHFYWzwAQwH/K1FUpeu/KNB3KEz0pI
 3b5vEcZADXqd7tdZ0qCFpwYgbk9u4lgQomyNejh8l7Zo2MApxt34Y1HPNybkBpRJGDyK
 ohV26CwmW1i0PXqWPu9VUmTcp3oNnFzhOgJc09fbzhr4BXaCRaWveIAXVaQ1AhYl9UMw
 SnF6dotiGM4sGwycy6trCdeUPXOO7RmmxvagAUFFb2a7eZp4Q/ShYauoXTY8O8ZDaPwN
 jk8A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475035; x=1775079835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F/Ltg+n53UjRj/ZyjvJucV6NyqlB6aQs52RdBLwRi/0=;
 b=XTY4BbO8lWlcySg2FY01O55DV74xgXFUj7wcbeRcJYVsKAW2fUJ+MPISZg0CRYqSuO
 oBAjAM3IEaPfYKYOi5NgZc4U646baVw8X0pW41s9dZXyfQxYFWWBd8tm7hbWGOgMFeQk
 LHZgyDkSVxQK34QwOMSNqtn9rlH6DUBdsABVdsu33G1Bw+rsBhaVS8LnHCT1j6eCtM+r
 g1E9ZoadiLhCc7lx7+2g79xpznofkEjAhXDO96J56FcyeRLJybGQ0egpsgCivcLeToEW
 kb9aDWa0MaUXTr4aEDXtDdlmWbWMp3CLMxww7N40E/fsnslOYhLBGZFmUa+Guk1zWG5E
 fijQ==
X-Gm-Message-State: AOJu0YwVXQOsGm+t445sacWDKtS7o2sSDefc+s2vrAreh89Nv+hLWRFi
 99LWVVVP6+IBoNvbxFizmgY3LPSy0O/hkFP+tgxGZS9pvinKfEI8BStR5bi6FMwZPpcPXyFvBgy
 i/h8SewH04EJpC/Sma3wgA8fa8nx2JBg=
X-Gm-Gg: ATEYQzx0pBY8nLthb/PmeuZmrsq66NmPeW3R8TyNRj4u6jtmm4Pi8sDZ0CvJ6jpfoj+
 SK7noKJxnWBZlp9c/6eLHf/x3Lfj3mRNEDUT8YcPcT28ayVzN5skH/Nm/591eWgu83N0E7894fm
 3hmsBSWkUUw7qFyNjWWjaqSVtkXPexXgDVoie+jrYxApMpGTuEK+Ukp6gVdzL7a1YV7eU5LvZ28
 VfoDRgQ4vF8m80oozZCX3Zone2EXKXu1CPXqD1dIp16fSnpLLsbzzTKh5nOiiBdFCGEulmV7VNk
 BVk1H4BsVq8HNF+5pCRqFV4Vd1/rziTgOCBBGg==
X-Received: by 2002:ac8:7dcd:0:b0:50b:3a6d:db64 with SMTP id
 d75a77b69052e-50b80e1ebdcmr81580101cf.48.1774475034669; Wed, 25 Mar 2026
 14:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
 <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
 <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
 <d944f17d-35a7-42d3-9011-2d368f530474@intel.com>
 <CAHHRULXCfeFrgTosCJCvMK0+Qe-eBy2bJs43KDvEwYC6A6GRCg@mail.gmail.com>
 <a3a95872-2cc7-4b9d-ae70-179050339bd8@intel.com>
In-Reply-To: <a3a95872-2cc7-4b9d-ae70-179050339bd8@intel.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Wed, 25 Mar 2026 22:43:42 +0100
X-Gm-Features: AaiRm52IuRsKszgdh9kBIZzhLYcA5cglFdyScumnGvNZwThIU-19ZgLbP8QHK4Y
Message-ID: <CAHHRULUHTLohJ+2=uTRwB5mq54yK=wytfC0vCf-sa2Bv-rwX8g@mail.gmail.com>
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

On Wed, Mar 25, 2026 at 4:56=E2=80=AFPM Medvedkin, Vladimir
<vladimir.medvedkin@intel.com> wrote:
>
>
> On 3/24/2026 9:19 AM, Maxime Leroy wrote:
> > Hi Vladimir,
> >
> > On Mon, Mar 23, 2026 at 7:46=E2=80=AFPM Medvedkin, Vladimir
> > <vladimir.medvedkin@intel.com> wrote:
> >>
> >> On 3/23/2026 2:53 PM, Maxime Leroy wrote:
> >>> On Mon, Mar 23, 2026 at 1:49=E2=80=AFPM Medvedkin, Vladimir
> >>> <vladimir.medvedkin@intel.com> wrote:
> >>>> Hi Maxime,
> >>>>
> >>>> On 3/23/2026 11:27 AM, Maxime Leroy wrote:
> >>>>>     Hi Vladimir,
> >>>>>
> >>>>>
> >>>>> On Sun, Mar 22, 2026 at 4:42=E2=80=AFPM Vladimir Medvedkin
> >>>>> <vladimir.medvedkin@intel.com> wrote:
> >>>>>> This series adds multi-VRF support to both IPv4 and IPv6 FIB paths=
 by
> >>>>>> allowing a single FIB instance to host multiple isolated routing d=
omains.
> >>>>>>
> >>>>>> Currently FIB instance represents one routing instance. For worklo=
ads that
> >>>>>> need multiple VRFs, the only option is to create multiple FIB obje=
cts. In a
> >>>>>> burst oriented datapath, packets in the same batch can belong to d=
ifferent VRFs, so
> >>>>>> the application either does per-packet lookup in different FIB ins=
tances or
> >>>>>> regroups packets by VRF before lookup. Both approaches are expensi=
ve.
> >>>>>>
> >>>>>> To remove that cost, this series keeps all VRFs inside one FIB ins=
tance and
> >>>>>> extends lookup input with per-packet VRF IDs.
> >>>>>>
> >>>>>> The design follows the existing fast-path structure for both famil=
ies. IPv4 and
> >>>>>> IPv6 use multi-ary trees with a 2^24 associativity on a first leve=
l (tbl24). The
> >>>>>> first-level table scales per configured VRF. This increases memory=
 usage, but
> >>>>>> keeps performance and lookup complexity on par with non-VRF implem=
entation.
> >>>>>>
> >>>>> Thanks for the RFC. Some thoughts below.
> >>>>>
> >>>>> Memory cost: the flat TBL24 replicates the entire table for every V=
RF
> >>>>> (num_vrfs * 2^24 * nh_size). With 256 VRFs and 8B nexthops that is
> >>>>> 32 GB for TBL24 alone. In grout we support up to 256 VRFs allocated
> >>>>> on demand -- this approach forces the full cost upfront even if mos=
t
> >>>>> VRFs are empty.
> >>>> Yes, increased memory consumption is the
> >>>> trade-off.WemakethischoiceinDPDKquite often,such as pre-allocatedmbu=
fs,
> >>>> mempoolsand many other stuff allocated in advance to gain performanc=
e.
> >>>> For FIB, I chose to replicate TBL24 per VRF for this same reason.
> >>>>
> >>>> And, as Morten mentioned earlier, if memory is the priority, a table
> >>>> instance per VRF allocated on-demand is still supported.
> >>>>
> >>>> The high memory cost stems from TBL24's design: for IPv4, it was
> >>>> justified by the BGP filtering convention (no prefixes more specific
> >>>> than /24 in BGPv4 full view), ensuring most lookups hit with just on=
e
> >>>> random memory access. For IPv6, we should likely switch to a 16-bit =
TRIE
> >>>> scheme on all layers. For IPv4, alternative algorithms with smaller
> >>>> footprints (like DXR or DIR16-8-8, as used in VPP) may be worth
> >>>> exploring if BGP full view is not required for those VRFs.
> >>>>
> >>>>> Per-packet VRF lookup: Rx bursts come from one port, thus one VRF.
> >>>>> Mixed-VRF bulk lookups do not occur in practice. The three AVX512
> >>>>> code paths add complexity for a scenario that does not exist, at
> >>>>> least for a classic router. Am I missing a use-case?
> >>>> That's not true, you're missing out on a lot of established core use
> >>>> cases that are at least 2 decades old:
> >>>>
> >>>> - VLAN subinterface abstraction. Each subinterface may belong to a
> >>>> separate VRF
> >>>>
> >>>> - MPLS VPN
> >>>>
> >>>> - Policy based routing
> >>>>
> >>> Fair point on VLAN subinterfaces and MPLS VPN. SRv6 L3VPN (End.DT4/
> >>> End.DT6) also fits that pattern after decap.
> >>>
> >>> I agree DPDK often pre-allocates for performance, but I wonder if the
> >>> flat TBL24 actually helps here. Each VRF's working set is spread
> >>> 128 MB apart in the flat table. Would regrouping packets by VRF and
> >>> doing one bulk lookup per VRF with separate contiguous TBL24s be
> >>> more cache-friendly than a single mixed-VRF gather? Do you have
> >>> benchmarks comparing the two approaches?
> >> It depends. Generally, if we assume that we are working with wide
> >> internet traffic, then even for a single VRF we most likely will miss
> >> the cache for TLB24, thus, regardless of the size of the tbl24, each
> >> memory access will be performed directly to DRAM.
> > If the lookup is DRAM-bound anyway, then the 10 cycles/addr cost
> > is dominated by memory latency, not CPU. The CPU cost of a bucket
> > sort on 32-64 packets is negligible next to a DRAM access (~80-100
> > ns per cache miss).
> memory accesses are independent and executed in parallel in the CPU
> pipeline
> >   That actually makes the case for regroup +
> > per-VRF lookup: the regrouping is pure CPU work hidden behind
> > memory stalls,
> regrouping must be performed before memory accesses, so it cannot be
> amortized in between of memory reads

With internet traffic, TBL24 lookups quickly become limited by
cache misses, not CPU cycles. Even if some bursts hit the same
routes and benefit from cache locality, the CPU has a limited
number of outstanding misses (load buffer entries, MSHRs) --
out-of-order execution helps, but it is not magic.

The whole point of vector/graph processing (VPP, DPDK graph, etc.)
is to amortize that memory latency: prefetch for packet N+1 while
processing packet N. This works because all packets in a batch
hit the same data structure in a tight loop.

With separate per-VRF TBL24s, a bucket sort by VRF -- a few
dozen cycles, all in L1 -- gives you clean batches where
prefetching works as designed. This is exactly what graph nodes
already do: classify, then process per-class in a tight loop.

> >   and each per-VRF bulk lookup hits a contiguous
> > TBL24 instead of scattering across 128 MB-apart VRF regions.
>
> why is a contiguous 128Mb single-VRF TBL24 OK for you, but bigger
> contiguous multi-VRF TBL24 is not OK in the context of lookup (here we
> are talking about lookup, omitting the problem of memory consumption on
> init)?

The performance difference may be small, but the flat approach
is not faster either -- while costing 64 GB upfront.

> In both of these cases, memory access behaves the same way within a
> single batch of packets during lookup, i.e. the first hit is likely a
> cache miss, regardless of whether we are dealing with one or more VRFs,
> it will not maintain TBL24 in L3$ in any way in a real dataplane app.
>
> >
> >> And if the addresses are localized (i.e. most traffic is internal), th=
en
> >> having multiple TBL24 won'tmake the situationmuchworse.
> >>
> > With localized traffic, regrouping by VRF + per-VRF lookup on
> > contiguous TBL24s would benefit from cache locality,
>
> why so? There will be no differences within a single batch with a
> reasonable size (for example 64), because within the lookup session, no
> matter with or without regrouping, temporal cache locality will be the sa=
me.
>
> Let't look at it from a different angle. Is it
> worthregroupingipaddressesby/8(i.e. 8 MSBs)withthe
> currentimplementationof a singleVRFFIB?
>
> >   while the
> > flat multi-VRF table spreads hot entries 128 MB apart. The flat
> > approach may actually be worse in that scenario
> >
> >> I don't have any benchmarks for regrouping, however I have 2 things to
> >> consider:
> >>
> >> 1. lookup is relatively fast (for IPv4 it is about 10 cycles per
> >> address, and I don't really want to slow it down)
> >>
> >> 2. incoming addresses and their corresponding VRFs are not controlled =
by
> >> "us", so this is a random set. Regrouping effectively is sorting. I'm
> >> not really happy to have nlogn complexity on a fast path :)
> > Without benchmarks, we do not know whether the flat approach is
> > actually faster than regroup + per-VRF lookup.
> feel free to share benchmark results. The only thing you need to add is
> the packets regrouping logic, and then use separate single-VRF FIB
> instances.

Your series introduces a new API that optimizes multi-VRF lookup.
The performance numbers should come with the proposal.

> >>> On the memory trade-off and VRF ID mapping: the API uses vrf_id as
> >>> a direct index (0 to max_vrfs-1). With 256 VRFs and 8B nexthops,
> >>> TBL24 alone costs 32 GB for IPv4 and 32 GB for IPv6 -- 64 GB total
> >>> at startup. In grout, VRF IDs are interface IDs that can be any
> >>> uint16_t, so we would also need to maintain a mapping between our
> >>> VRF IDs and FIB slot indices.
> >> of course, this is an application responsibility. In FIB VRFs are in
> >> continuous range.
> >>>    We would need to introduce a max_vrfs
> >>> limit, which forces a bad trade-off: either set it low (e.g. 16)
> >>> and limit deployments, or set it high (e.g. 256) and pay 64 GB at
> >>> startup even with a single VRF. With separate FIB instances per VRF,
> >>> we only allocate what we use.
> >> Yes, I understand this. In the end, if the user wants to use 256 VRFs,
> >> the amount of memory footprint will be at least 64Gb anyway.
> > The difference is when the memory is committed.
> yes, this's the only difference. It all comes down to the static vs
> dynamic memory allocation problem. And each of these approaches is good
> for solving a specific task. For the task of creating a new VRF, what is
> more preferable - to fail on init or runtime?

The main problem is that your series imposes contiguous VRF IDs
(0 to max_vrfs-1). How a VRF is represented is a network stack
design decision -- in Linux it is an ifindex, in Cisco a name,
in grout an interface ID. Any application using this API needs
a mapping layer on top.

In grout, everything is allocated dynamically: mempools, FIBs,
conntrack tables. Pre-allocating everything at init forces
hardcoded arbitrary limits and prevents memory reuse between
subsystems -- memory reserved for FIB TBL24 cannot be used for
conntrack when the VRF has no routes, and vice versa. We prefer
to allocate resources only when needed. It is simpler for users
and more efficient for memory.

> >   With separate FIB
> > instances per VRF, you allocate 128 MB only when a VRF is actually
> > created at runtime. With the flat multi-VRF approach, you pay
> > max_vrfs * 128 MB at startup, even if only one VRF is active.
> >
> > On top of that, the API uses vrf_id as a direct index (0 to
> > max_vrfs-1). As Stephen noted, there are multiple ways to model
> > VRFs. Depending on the networking stack, VRFs are identified by
> > ifindex (Linux l3mdev), by name (Cisco, Juniper), or by some
> > other scheme. This means the application must maintain a mapping
> > between its own VRF representation and the FIB slot indices, and
> > choose max_vrfs upfront. What is the benefit of this flat
> > multi-VRF FIB if the application still needs to manage a
> > translation layer and pre-commit memory for VRFs that may never
> > exist?
> This is the control plane task.
> >
> >> As a trade-off for a bad trade-off ;) I can suggest to allocate it in
> >> chunks. Let's say you are starting with 16 VRFs, and during runtime, i=
f
> >> the user wants to increase the number of VRFs above this limit, you ca=
n
> >> allocate another 16xVRF FIB. Then, of course, you need to split
> >> addresses into 2 bursts each for each FIB handle.
> > But then we are back to regrouping packets -- just by chunk of
> > VRFs instead of by individual VRF. If we have to sort the burst
> > anyway, what does the flat multi-VRF table buy us?
> >
> >>>>> I am not too familiar with DPDK FIB internals, but would it be
> >>>>> possible to keep a separate TBL24 per VRF and only share the TBL8
> >>>>> pool?
> >>>> it is how it is implemented right now with one note - TBL24 are pre
> >>>> allocated.
> >>>>> Something like pre-allocating an array of max_vrfs TBL24
> >>>>> pointers, allocating each TBL24 on demand at VRF add time,
> >>>> and you suggesting to allocate TBL24 on demand by adding an extra
> >>>> indirection layer. Thiswill leadtolowerperformance,whichIwouldliketo=
 avoid.
> >>>>>     and
> >>>>> having them all point into a shared TBL8 pool. The TBL8 index in
> >>>>> TBL24 entries seems to already be global, so would that work withou=
t
> >>>>> encoding changes?
> >>>>>
> >>>>> Going further: could the same idea extend to IPv6? The dir24_8 and
> >>>>> trie seem to use the same TBL8 block format (256 entries, same
> >>>>> (nh << 1) | ext_bit encoding, same size). Would unifying the TBL8
> >>>>> allocator allow a single pool shared across IPv4, IPv6, and all
> >>>>> VRFs? That could be a bigger win for /32-heavy and /128-heavy table=
s
> >>>>> and maybe a good first step before multi-VRF.
> >>>> So, you are suggesting merging IPv4 and IPv6 into a single unified F=
IB?
> >>>> I'm not sure how this can be a bigger win, could you please elaborat=
e
> >>>> more on this?
> >>> On the IPv4/IPv6 TBL8 pool: I was not suggesting merging FIBs, just
> >>> sharing the TBL8 block allocator between separate FIB instances.
> >>> This is possible since dir24_8 and trie use the same TBL8 block
> >>> format (256 entries, same encoding, same size).
> >>>
> >>> Would it be possible to pass a shared TBL8 pool at rte_fib_create()
> >>> time? Each FIB keeps its own TBL24 and RIB, but TBL8 is shared
> >>> across all FIBs and potentially across IPv4/IPv6. Users would no
> >>> longer have to guess num_tbl8 per FIB.
> >> Yes, this is possible. However, this will significantly complicate the
> >> work with the library, solving a not so big problem.
> > Your series already shares TBL8 across all VRFs within a single
> > FIB -- that part is useful, and it does not require the flat
> > multi-VRF TBL24.
> >
> > In grout, routes arrive from FRR (BGP, OSPF, etc.) at runtime.
> > We cannot predict TBL8 usage per VRF in advance
> and you don't need it (knowing per-VRF consumption) now. If I understood
> your request here properly, do you want to share TBL8 between ipv4 and
> ipv6 FIBs? I don't think this is a good idea at all. At least because
> this is a good idea to split them in case if one AF consumes (because of
> attack/bogus CP) all TBL8, another AF remains intact.

If TBL8 isolation per AF is meant as a protection against route
floods, then the same argument applies between VRFs: your series
shares TBL8 across all VRFs within a single FIB, so a bogus
control plane in one VRF exhausts TBL8 for all other VRFs.

But more fundamentally, this is not how route flood protection
works. It is handled in the control plane: the routing daemon
limits the number of prefixes accepted per BGP session
(max-prefix) and selects which routes are installed via prefix
filters -- before those routes ever reach the forwarding table.

The Linux kernel is a good reference here. IPv6 used to enforce
a max_size limit on FIB + cache entries (net.ipv6.route.max_size,
defaulting to 4096). It caused real production issues and was
removed in kernel 6.3. IPv4 never had a FIB route limit. There
is no per-VRF route limit either. The kernel relies entirely on
the control plane for route flood protection.

> >   -- it depends on
> > prefix length distribution which varies per VRF and changes over
> > time. No production LPM (Linux kernel, JunOS, IOS) asks the
> > operator to size these structures per routing table upfront.
>
> - they are using different lpm algorithms
> - you use these facilities, developers properly tuned them. FIB is a low
> level library, it cannot be used without any knowledge, it will not
> solve all the problems with a single red button "make it work, don't do
> any bugs"
> P.S. how do you know how JunOS  /IOS implements their LPMs? ;)
>

I do not need to know their LPM implementation -- I only need
to know how they are configured. No production router requires
the operator to size internal LPM structures.

We can impose a maximum number of IPv4/IPv6 routes on the user
-- even though the kernel does not need this either. But TBL8
is a different problem: the application cannot predict TBL8
consumption because it depends on prefix length distribution,
which varies per VRF and changes over time with dynamic routing.
Today there is no API to query TBL8 usage, and no API to resize
a FIB without destroying it.

This is exactly why a shared TBL8 pool across VRFs is useful:
VRFs with few long prefixes naturally leave room for VRFs that
need more. This is the valuable part of your series. But it
does not require a flat multi-VRF TBL24 -- separate per-VRF
TBL24s sharing a common TBL8 pool would give the same benefit
without the 64 GB upfront cost.

> > Today we do not even have TBL8 usage stats (Robin's series
> > addresses that)
> I will tryto findtimetoreviewthispatchinthe nearfuture

Thanks, Robin's TBL8 stats series would help users understand
their TBL8 consumption -- a more practical improvement for
current users.

Regards,
Maxime
