Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92CAC79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 17:55:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABBEC402D8;
	Tue,  8 Sep 2026 19:55:42 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id 9505E4028D
 for <dev@dpdk.org>; Tue,  8 Sep 2026 19:55:40 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so4167321a91.2
 for <dev@dpdk.org>; Tue, 08 Sep 2026 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788890140;
 x=1789494940; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QbEr4xP8z6IeFgDkNVAtXO/eJsY0x2aWxTyy3SVt7GM=;
 b=Ed+8W1GgQwn+JA54F5Ls9oK8A0Gytnt6FYC6Ezxjsv1HJQyeumIKmW36iLehigJiwt
 vEiq0LirR8sL1ccnintXoNf1KVRYvGi79eq3sFAgTUxMq4WPXOdOZXWZ6Crc3p1eF5Cg
 RKewIUjrP4ephYZ0PbSCkYh2jmQ8AtCyh382CxVChTVlG8CuEC2+TH4o2oqQfQgalCi5
 xl9kQhZbFB7cLBtYf1vPuUmYWn7cDcLwEjJ/6vE9RPiwN7pukYg31HB6MOpf0/sEiRZa
 JrS9Vxe9Aai89QmB8Zr+vkSjlTEl+6fIbq+wyzx8uSKqe2HN0lja0shEVSnKrneCk9Jk
 pMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788890140; x=1789494940;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QbEr4xP8z6IeFgDkNVAtXO/eJsY0x2aWxTyy3SVt7GM=;
 b=R+wFdTXWTUBrW46jpWiVIdkN3M9ydFjH0t3aAevV+Y+vmkf9iIelGS567wkSQ6ImqN
 vmHF5kEZYEu3j7k4VkQZ6aHyUc+Jf0lCso1aLG7bk+6okbkITQ7Ws4M41Qi5GCvlWmG7
 hNpxxPiR9c6PcfJ4/+agKo8ux1QZqpAn60ZzgqCF6PjD8PUnQhhBXiZkTve69Y8aNc3k
 OkN1KTFUa0A2rc/CM5pVgvVg+/rTLxkGmQD5I7SjEumSeEFzVHTms0fmuMSWlu26W6P3
 k8Xlj5cgIxXx75uyfLgBPDlsXhbw2UaMCgyhrH7SKkEHpc9+AbHqsBZTVqdaFGMPF6iJ
 RRaQ==
X-Gm-Message-State: AFuF++mxqtVJjeaWXcPnFNwxplhiHiPIdiAF7ytplb+141O8mZbgmH+L
 ZIFGyf/EeZRlR342WyBowdXpsdXIrlYYJ494TUeI48aufLus+K3pBYJ892WtvXGQ+PM=
X-Gm-Gg: AYBFou21VIaHjiszc4YoNvu0dAy7Um4BI7RjjK9zy2/AZYCXCPa/dDF6QJMYgeeqWFf
 kyLzj7T9TjgaumyxLXxsqpyVLu0r+cIWWlT1NWoZ+t4fJHz31bxrB4t9rDmoGvqWKZ43c54u9Ge
 DizRz9JLyUvWQcupNefOABsVTwQOw0e4COhAt8lggm3ilgo9V7CC85X02yFoEmY5DZE2gRVOssx
 tUalEPcmNmyvO+UnWkxe+eUw6DPs6vjgafucvhkAT9A3srM1MMPCUB9Soy5l80ySmVRQDqEtYgO
 ALiTBLaw/LKTuHHb/i3fciWikBnjnDvJJN3iCNgKEzrQSxzdTb/bGQwBU8JR1RqVNEQfb2J2yH1
 +2jGwczScQwGKE8lgtXoLwkdz4tNurK4DreUS/0Km0MDrUvZAS/uYecTiP8zxoUhdSkXBUawfHT
 b1cBObxgUK+h1Jxzmx9pEmf5P6Eev0++DOc7tThhTqzc9h5NyOainoHGHqTEdiQCawJIfWWc3Bt
 rNd/EQe/2GkrEYZAz1NQI7sf7io7g==
X-Received: by 2002:a17:90a:e703:b0:398:e969:87ef with SMTP id
 98e67ed59e1d1-39b2629926dmr47235706a91.24.1788890139485; 
 Tue, 08 Sep 2026 10:55:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b2ad8028dsm8239398a91.4.2026.09.08.10.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:55:39 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:55:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mukul Katiyar <mukul@versa-networks.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] Highly efficient reader-writer lock (EPRW) for
 mostly-read applications
Message-ID: <20260908105529.4ac68572@phoenix.local>
In-Reply-To: <DS7PR11MB885556AF77C5110C85609B7B8CB22@DS7PR11MB8855.namprd11.prod.outlook.com>
References: <DS7PR11MB885556AF77C5110C85609B7B8CB22@DS7PR11MB8855.namprd11.prod.outlook.com>
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

On Tue, 8 Sep 2026 03:55:12 +0000
Mukul Katiyar <mukul@versa-networks.com> wrote:

> Hi all,
>=20
> Sharing a userspace reader-writer lock that has been running in productio=
n in a DPDK-based network function for several years and wanted to check if=
 there would be interest in contributing it to DPDK as rte_eprwlock.
>=20
> The Enhanced Passive Reader-Writer (EPRW) lock eliminates atomic operatio=
ns on the reader fast path, giving near-flat per-reader performance as core=
 count grows. It is compatible with poll-mode lcore discipline =E2=80=94 no=
 heartbeat or periodic refresh required from registered threads.
>=20
> Details, correctness proof, memory ordering analysis (x86-TSO and ARM), a=
nd performance evaluation against rte_rwlock and pthread_rwlock_t are in a =
preprint at:
> https://zenodo.org/records/22636501
>=20
> Would this be a useful addition to DPDK?
>=20
> Regards,
> Mukul Katiyar
> Versa Networks
>=20

As an exercise, also point Fable AI to do analysis of the paper versus curr=
ent DPDK code.
Surprisingly AI is relatively good at understanding locking; probably becau=
se it has been
trained on a huge data set of academic papers.

Short version: this is a write-up of Versa fixing a bug in their own
userspace port of Liu's PRW lock. It is not a critique of rte_rwlock
and does not cite any DPDK primitive (DPDK is cited as "Intel
Corporation 2024", which tells you how closely they looked). "Outdated
DPDK" is too generous; there is no DPDK survey at all. The DPDK
relevance is only the deployment context.

Analysis:

1. What the algorithm actually is. Once the writer scan checks `RP[i]
=3D=3D Present && TV[i] !=3D GV`, the version counter only distinguishes
"spinning at boundary" from "inside CS". A three-state per-thread flag
(ABSENT/WAITING/ACTIVE) does the same job with no GV, no unlock
broadcast, no rollover. The only thing TV buys is a WAITING to ACTIVE
transition without a store+fence, because the writer's GV++ invalidates
the match for it. That is the contended path, so it does not affect
throughput. Strip that and you have a per-thread-flag rwlock: Hsieh and
Weihl 1992, Linux 2.4 brlock, Dice/Shavit read indicators,
percpu_rw_semaphore slow path. The "heartbeat" was self-inflicted: they
dropped the kernel IPI and did not add an offline state. `RP =3D Absent`
is `rte_rcu_qsbr_thread_offline()`.

2. The premise contradicts DPDK practice. Section 3 says per-lcore
periodic reporting is incompatible with poll-mode discipline.
`rte_rcu_qsbr_quiescent()` per loop iteration is exactly how lib/rcu is
used, with online/offline for idle threads. Section 10 admits the QSBR
analogy but not that DPDK ships it. liburcu (Desnoyers et al., TPDS
2012) is the canonical treatment of replacing kernel IPI/quiescence in
userspace and is not cited either. RCU also gives readers zero wait and
real reclamation; EPRW writers still spin on every in-CS reader.

3. No comparison, no numbers. Missing: rte_rwlock (4 bytes, WAIT bit so
writers cannot starve), rte_pflock (bounded wait both sides),
rte_seqlock/seqcount, rte_rcu_qsbr, rte_mcslock, rte_ticketlock.
Microbenchmarks "left for future work". EPRW has no fairness: a reader
spinning on W must catch a window between one writer's `W =3D Absent` and
the next writer's CAS, and back-to-back writers skip it forever since
its TV matches. That is the case pflock was added for.

4. Concrete defects:
   - Lemma 8.1 is wrong. `Try_Write_Lock` increments GV and on failure rele=
ases W without the broadcast. A caller retrying try_wlock against a reader =
stuck in its CS (preempted control thread, slow path) gets 65536 failures, =
GV wraps, `TV[i] =3D=3D GV`, false boundary match, exclusion violated. The =
16-bit variant is unsafe as published. Trivial fix, but the proof did not c=
over its own try path.
   - ARMv8 `Read_Lock`: the exit load of W has no acquire. The DMB after th=
e RP store does not order that load against later CS loads, so a reader can=
 see pre-write data. Same in `Try_Read_Lock`. Section 6 walks every barrier=
 site and misses this one. Fine on TSO.
   - Plain-C data races: readers load GV while the writer does a non-atomic=
 increment; TV[i] is stored by thread i and by the broadcasting writer. Wor=
ks on hardware with aligned words, UB in C11. Any DPDK version would need r=
te_stdatomic relaxed ops anyway.
   - Compact mode packs 3-byte slots: 32 threads in 3 cache lines, so every=
 read lock/unlock is a store to a shared line. That reintroduces the cohere=
nce traffic PRW exists to avoid. The 64-byte alignment in the original is t=
he whole point. No measurement.
   - Write_Unlock broadcast invalidates N reader-owned lines per write on t=
op of the scan. Fine for read-mostly, but it is why per-lcore-slot locks do=
 not fit "hundreds of locks", which is their own compact-mode motivation.
   - `TV[tid] =3D GV` in the Write_Lock contention loop is dead: a plain co=
ntender has RP Absent, so the winner's scan skips it regardless. Only Upgra=
de needs it.
   - "Non-atomic upgrade" (return 1) is a read unlock followed by a write l=
ock; data can change in between. The name invites misuse.
   - Reader fast path uses MFENCE. rte_smp_mb() uses `lock addl` on x86 for=
 a reason; xchg for the RP store folds store and barrier.

