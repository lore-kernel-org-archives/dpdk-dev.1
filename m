Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA87C5DF86
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 20:14:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C1B640268;
	Thu, 20 Aug 2026 22:14:07 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id C6594400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 22:14:05 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-39266382df6so175949a91.3
 for <dev@dpdk.org>; Thu, 20 Aug 2026 13:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787256845;
 x=1787861645; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xqLBuj/IFrfm/9GFiITHH/+UY+lbxG5AcL3Gx7LM/ic=;
 b=MG0tTIWWNgI4Pg0m8euir95W6NpHe1dMz1wYiRVTskVHkokhlIpTMvL2jM13iTL/6w
 htPel04dBkevj7Ac8L5bA62RCeGFp8FCltN5aMa4M7L6L6hFWxbwXKbqf3MnmIasCfQk
 VUZnerwjLsgFeuuUg1gYJjK2i2jyoXMG/Rpq3usYz5eS9m/wXS7foBnB5aKR/xQK3DY+
 HhBXMdYwJ82lECyzzLQiN6tVwCXQkdG0eTPkUYd8frxhjbMEI/rYxmsdHKPNTL36z3yR
 yFTpSB/NXMW5AcGso3iHQ8GoANrqV75wgWeev9zZCQgSfuk+9EBT11xOQS1zHGOdaARM
 3ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787256845; x=1787861645;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xqLBuj/IFrfm/9GFiITHH/+UY+lbxG5AcL3Gx7LM/ic=;
 b=e8Ewo9u6M8DQ1ApAI/dXFiQ/3RYVjk9+ubamX0lxtYzmJZitzraHwkUaS7uxrhpb93
 Cm+GnIDBaUg2Bz6tLrh3CIKizXPw7ycnyqiWw4pFt08uOlS6yWn6CxNQpZMwZvtct85d
 RIE1Zq5d+pt0/y2h4KFdh9E0E2NS0xFrt7aEfWi3fo7Rfn1K04wpZXZOl5ST3WquZTUf
 ki4ezaq8fT6iokDfkPMH3ClCt3V50uLIPJvdsqScVUpu2hywT3pnqrVCpp6RDb5LCDSs
 kpaXlAH1fxRw8no21ULn3vLKrXA4Rj7Zo5TkzkGv5xB/WEO77F8OMZu3AkX0setkuMIB
 9L6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgPWDvReRIDwK4bw333hhGS4FV+Ctq/8IVoNQPUtOZCqGCtTKsAJTUH8DjodUiA+kuTwA=@dpdk.org
X-Gm-Message-State: AFuF++lB9BiAviZmMwi8UH4hUONwVNSSNtzEve+4TuIXTtjAGX8VI30a
 W3+tZSKAjq+EU5PhUlaepoyIc9xmg0I0bWFpWBkgEQI3tYoNkSBZypX9qJV3i5hYZgU=
X-Gm-Gg: AR+sD102oHaSphVmsx6o/mCWVTv/5Fbn/iiwRmwujBwqpy6oxcu+LcXH4xyBDvTrD+s
 gz+UMG6QkQ3K6hXYAYXMgcI8E1ns/IhdL5c+iOb6XrAxQraTCXh7/bQUHgesKOzkAKwg1Mx/V/Q
 0ZMdCacbPTmLKPK5bbTXlvJgRI3KIPa2hrlvDaRTelExUBsJRY2iqqisFc+KYAPcl/0geamfgkq
 kKuw6uX3TFzUYShCCPxEcsg4OFHz/fzhr5GqNZMQgsqu2L6YqChbGnhYxsluLmWKsM2Zdcb2kgr
 EgNcRp5B7BQvBRGDSEkmVBLhL/ryc/23TZkHmenq4blQnGSLxM2ZnEDKxskga/zHSKs0p0R8gGU
 7viQ5m8DMeDkvrokd+xOoLMiQVc1v2sr6nV8O3Zrro2t4YC6iD/v6d72UOvVG4srzJetoCWzJqF
 8T1YuMmY44jDnaWdF5j2tnGjtUCMAzvmj8sBlAwmM1hVumws8LzwmvxxlNGrqmcK7Dar9VTkJXv
 l/h1Q0kH8j9q1dBJ/9TL0Dk8kZey7STJrjf3TeJ
X-Received: by 2002:a17:90b:1a90:b0:37f:bfd6:8b40 with SMTP id
 98e67ed59e1d1-395c33a0168mr1387269a91.5.1787256844565; 
 Thu, 20 Aug 2026 13:14:04 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c457126esm247727a91.1.2026.08.20.13.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 13:14:04 -0700 (PDT)
Date: Thu, 20 Aug 2026 13:13:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, <dev@dpdk.org>,
 "Bruce Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH 00/61] reduce use of rte_memcpy
Message-ID: <20260820131355.0b7d971a@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65A06@smartserver.smartshare.dk>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F659FD@smartserver.smartshare.dk>
 <42ecbb8129514f52b456549ee66757b2@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65A01@smartserver.smartshare.dk>
 <f469a51afd3547eca1ce56f6abb0285b@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65A06@smartserver.smartshare.dk>
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

On Thu, 20 Aug 2026 16:00:53 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Konstantin Ananyev [mailto:konstantin.ananyev@huawei.com]
> > Sent: Thursday, 20 August 2026 15.08
> >  =20
> > > > > About replacing rte_memcpy with memcpy()...
> > > > > =20
> > > > > > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > > > > > Sent: Thursday, 20 August 2026 07.12
> > > > > >
> > > > > > The DPDK function rte_memcpy() only exists as an optimization
> > > > > > for shortcomings in performance of libc memcpy() on some =20
> > platforms. =20
> > > > >
> > > > > Yes, and those platforms should benefit from it.
> > > > >
> > > > > E.g. the vhost performance improvements for Haswell and Broadwell=
 =20
> > > > [1]. =20
> > > > > Where similar performance improvements implemented in the =20
> > relevant =20
> > > > > compilers (GCC, Clang, MSVC)?
> > > > >
> > > > > [1]:
> > > > > =20
> > > > =20
> > > =20
> > https://github.com/DPDK/dpdk/commit/4b42e90ef0e421dc777f2b2e377eb237cd =
=20
> > > > > 3675fa
> > > > >
> > > > > IMO, performance should remain a high priority for DPDK. =20
> > > >
> > > > As I can read the series, good few of them do remove rte_memcpy =20
> > from =20
> > > > the CP,
> > > > where it is clearly irrelevant. =20
> > >
> > > Agree!
> > > =20
> > > > For those on the DP, at least for some of them we can run perf =20
> > tests: =20
> > > > let say for hash we do have perf_autotest which can be used to =20
> > measure =20
> > > > the
> > > > perf diff. If there is none, or neglectable - then no point to keep
> > > > rte_memcpy here. =20
> > >
> > > Unless that perf test is run on all platforms, the result only shows =
=20
> > perf diff on =20
> > > the tested platforms. =20
> >=20
> > How this patch differs from all others? =20
>=20
> It removes something that is supposed to be a performance optimization.
> E.g. reference [1] fixes vhost performance on Haswell and Broadwell; if w=
e remove rte_memcpy(), the performance of that use case on those CPU types =
might drop back to being bad.
>=20
> > For each and every change we made in DPDK, to ensure that there is no
> > perf regression introduced we rely on:
> > 1) CI auto testing
> > 2) manual testing from some platform vendors (once per release cycle)
> > 3) good will of submitter to test the changes he produces as much as
> > possible
> > Obviously, yes we are not testing on each possible platform and yes, in
> > theory
> > some regressions can sneak in unseen.
> > But that could happen with other patches too, so from my perspective -
> > we just need our usual testing procedure here, if it shows no
> > regression,
> > the patch is good to go in.
> >  =20
> > > > =20
> > > > > =20
> > > > > > Many platforms have no special rte_memcpy() and just use =20
> > memcpy(). =20
> > > > > >
> > > > > > But many analysis and test tools know that memcpy() is a =20
> > special =20
> > > > > > case and check for overwrite, bounds errors etc. Therefore =20
> > memcpy() =20
> > > > > > should be preferred wherever possible. =20
> > > > >
> > > > > I think this is the only substantial benefit of replacing =20
> > > > rte_memcpy() with =20
> > > > > memcpy()!
> > > > > Could we reap this benefit by having special builds for such =20
> > tools, =20
> > > > where =20
> > > > > rte_memcpy() is modified to use memcpy() instead?
> > > > > Then we wouldn't have to compromise on performance.
> > > > >
> > > > > Also, rte_memcpy() used to have a pragma disabling bounds checks =
=20
> > due =20
> > > > to some =20
> > > > > Intel drivers using [0] instead of []; the pragma was removed =20
> > from =20
> > > > rte_memcpy() =20
> > > > > when the Intel drivers were fixed.
> > > > > I'm not sufficiently familiar with analysis/test tools to say =20
> > what =20
> > > > they can detect =20
> > > > > when using memcpy() instead of the copy methods used by =20
> > rte_memcpy(). =20
> > > > > =20
> > > > > >
> > > > > > This patch series introduces a coccinelle script to find
> > > > > > calls to rte_memcpy() where size is fixed, and change them to
> > > > > > regular memcpy(). This was the starting point for this cleanup.
> > > > > >
> > > > > > There is also some cleanups to include rte_memcpy.h and =20
> > string.h =20
> > > > > > where needed. Often the includes were happening by some other
> > > > > > header. And also removal of rte_memcpy.h where no longer =20
> > needed. =20
> > > > > >
> > > > > > The result is a 46% reduction in use of rte_memcpy.
> > > > > > The remaining rte_memcpy can be cleaned up later:
> > > > > >  - drivers with active maintenance (like mlx5);
> > > > > >  - changes to rte_memcpy which need benchmarking;
> > > > > >  - test code for rte_memcpy can be removed as last step.
> > > > > >
> > > > > > No functional change, no warnings in all compilers including =20
> > LTO. =20
> > > > >
> > > > > memcpy() does not always use inline vector instructions for fixed=
 =20
> > > > size copy [2]. =20
> > > > >
> > > > > [2]:
> > > > > =20
> > > https://inbox.dpdk.org/dev/98CBD80474FA8B44BF855DF32C47DC35F659B8@sma=
 =20
> > > > > rtserver.smartshare.dk/
> > > > >
> > > > >
> > > > > Another disadvantage of rte_memcpy() is the lack of developer =20
> > > > guidance. =20
> > > > > It is not well documented when to use rte_memcpy() and when to =20
> > use =20
> > > > memcpy(). =20
> > > > > We discussed something similar on the Tech Board meeting =20
> > yesterday; =20
> > > > it is not =20
> > > > > well documented when to use which type of "ring" (normal, RTS, =20
> > HTS), =20
> > > > so maybe =20
> > > > > we could remove one of them.
> > > > > But removing an option is not an improvement, if the removed =20
> > option =20
> > > > would =20
> > > > > have been the better choice for some use cases.
> > > > >
> > > > > PS: The general guidance for rte_memcpy() usage is something =20
> > like: =20
> > > > > rte_memcpy() only in fast path,
> > > > > memcpy() everywhere else,
> > > > > assignment "=3D" when copying fixed size structures. =20
> > > >
> > > > I suppose for te_memcpy() we can be even more strict:
> > > > Use it only for DP, and only after measurement, that shows
> > > > clear perf improvement over ordinal memcpy().
> > > > Alnd also ask contributors to document it (in the comments), i.e.:
> > > > /* on <platform testsed> rte_memcpy() gives X% perf boost when =20
> > doing =20
> > > > ...*/
> > > > rte_memcpy(...); =20
> > >
> > > Disagree!
> > > DPDK has performance optimized libs and functions.
> > > Developers should not need to document that using a DPDK function is =
=20
> > faster =20
> > > than using a libc function.
> > > We don't require perf measurements for using DPDK rte_hash instead of=
 =20
> > libc =20
> > > hashmap. =20
> >=20
> > Not sure what libc hashmap you are talking about?
> > AFAIK such thing doesn't exist.. or you talking about c++ maps? =20
>=20
> Sorry, it was hashmap in libmba. Bad example.
>=20
> > If so, then I think the analogy is not correct.
> > Why not to remember another example when we get rid of our own
> > hand-written atomics and barriers in favor of using atomics ones. =20
>=20
> Great example.
> IIRC, many people were involved in this effort, and it was thoroughly rev=
iewed for correctness and performance.
> And some of the old atomics still ended up remaining for performance reas=
ons.
> And C11 atomics is still not the default for DPDK.
>=20
> That level of effort doesn't seem to be on the table for migrating from r=
te_memcpy() to memcpy().
> The vibe I'm sensing is more like: "Compilers' built-in memcpy() is just =
as good as rte_memcpy(), so rte_memcpy() has outlived itself."
> And maybe that statement is true, but I just don't feel confident about i=
t.
> Perhaps I'm just being too cautious here.
>=20
> >  =20
> > >
> > > I agree about not using rte_memcpy() in the control plane.
> > > And I support Stephen's effort to clean this up.
> > >
> > > But why the eagerness to avoid using rte_memcpy() in the fast path? =
=20
> >=20
> > I think we are not talking about 'avoiding' but about 'limiting'.
> > There are many cases, when people use rte_memcpy() just because
> > 'it is used in other places, so it is probably better'
> > In general memcpy()  and rte_memcpy() have same syntax,
> > provide same functionality, plus CC vendors made a good progress in
> > optimizing memcpy(),
> > so now for many cases it provides nearly the same or better
> > performance.
> > I think no-one forces to replace rte_memcpy() in places where it does
> > provide better results,
> > but for the cases when there is no perf difference, I think memcpy()
> > should have precedence. =20
>=20
> You prefer memcpy() over rte_memcpy() when they perform similarly.
> That's your preference.
> And you are not alone with that preference.
>=20
> When they perform similarly, I prefer rte_memcpy().
> And it seems I'm in the minority with that preference.
>=20
> If we set up barriers to using rte_memcpy(), we'll see even more custom i=
mplementations, such as in the ring [3] and stack [4] libraries.
> But maybe (and I'm being serious here!) that might be a good thing after =
all:
> Use memcpy() for general cases, and use individually specialized versions=
 for special use cases.
> (Possibly using pragmas to tweak memcpy() for some of those special use c=
ases.)
>=20
> [3]: https://elixir.bootlin.com/dpdk/v26.07/source/lib/ring/rte_ring_elem=
_pvt.h#L65
> [4]: https://elixir.bootlin.com/dpdk/v26.07/source/lib/stack/rte_stack_st=
d.h#L40
>=20
> Here's an alternative path...
> PowerPC rte_memcpy() uses memcpy() for fixed size copies [5].
> And ARM makes the rte_memcpy() implementation build time optional [6].
> We could start softly by copying these two concepts to X86 architecture.
>=20
> [5]: https://elixir.bootlin.com/dpdk/v26.07/source/lib/eal/ppc/include/rt=
e_memcpy.h#L80
> [6]: https://elixir.bootlin.com/dpdk/v26.07/source/lib/eal/arm/include/rt=
e_memcpy_64.h#L13
>=20


I used to think for DPDK performance should be the highest priority.
Now I think the priorities need to be:
  - security. in the age of AI scanners, security has to come first.
  - performance.
  - architecture. code must be logical and readable as much as possible.
  - consistency. don't do special cases if not needed for 1,2,3

Also, no longer care if performance goes down for users using new releases
on five year old tool chains. If they are on GCC over five years old=20
(pre GCC 10) then the problem is really the tool set not DPDK.
