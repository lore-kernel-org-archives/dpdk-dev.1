Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482C606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tEdkaIhT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 692EF402BF;
	Tue, 17 Nov 2026 18:09:42 +0100 (CET)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by mails.dpdk.org (Postfix) with ESMTPS id 95D02402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:09:41 +0100 (CET)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5ed2f163a2fso1423728e0c.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:09:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794935380; cv=none;
 d=google.com; s=arc-20260327;
 b=M/z+Wt/9WAjm+6wnEZSiJotjTo4mNtY/KurHliNvggiHNTQxcrLyeo0Pbbr1AL5b7O
 AP5GlpdngYyyqS2Ch3/eVXOYFztsANWjDzjRWzQ6U9QIGWlF+uOhcdMyebHt8oSlh5lf
 TPlp1tbNnJfsnNcfX4W+neE8JYD0Jx0YAeDo1jl+64aBacqGA0ZPBzFIMTXa8PEYzWaj
 rQbedDUNNyztdFGld52CNnMr1SjpGBLVlp1gmot/Sj66ozAceOMCbn6eKPGFnfdDgs6W
 oHsuP2XVFEW+crCXWMtv7zWqZ/DxbJZlhx7gJoqZd4vMlb0vrG2mnc1T92cqatckoXk7
 585g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Up7Y4AB22V4/5vR61PvSzVR1t9mcZEuNkLr1aVGGtrg=;
 fh=GnwyJ0cmalPJ0M4AI5jSHCrUCklbr0WFBfmBqp2CelI=;
 b=TnQuPy9v7Pl0goSkbEHzu0/3L7s60WWSgJp4SkSVYiw0Ta3LDrjd4rAHRt6+QVebSi
 Ml7kH7cBZWN7OCB1QGordQItHNpAGIKSJbKt5im8GsBEzR7z5sWiXBbkMH+ykWobSvbW
 7D7U/RwR2bU7XJIhHWYBE/Zb7dzBYTAQvLQTuSRAdgZJ0771CGZAAkkpQfytQctwFFn8
 yiwplmJ57YA3dzJGwbTSIXLU086puaryiKr8delGmp/qo4eWeP2r1sV92ILp+IdCgPeG
 /HyVRKGQEXUd3iedt9bGO1PhMKbqpSs7HxyvitY0TKNp1If+r9nta9iREskzhuwVVMuO
 GQ3g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794935380; x=1795540180; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Up7Y4AB22V4/5vR61PvSzVR1t9mcZEuNkLr1aVGGtrg=;
 b=tEdkaIhTXYGwyFcy0H/uO7kVV5dsKznB4RZIqZAOIa9ak5M8mVa2k8kUZnqrBI7Tji
 0FwWwAE1Bpivzj9aBKn8vVUTeCTU2y4mcW2cVhKRsDBUymNf12bLtqMJQzZbwURSKtFt
 4PUd8FJhgmRNHm+n+7phmh7oKMvTk2mABfogVGSY4r59C4R5j+7oApRUBH9HhDZ+w6kr
 W3UVanCPGL/TkMrOzmC1s7Kc682CaDWqA6J0ND3r2vSqFojttIR/eW4i71CDBrlzZOri
 lTneyxKodKU4ty7gLb45AKZwC33w6YjJ/37+o42ras78Z6iFvOXSF4n6XQl0oZCY3JHL
 z9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794935380; x=1795540180;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Up7Y4AB22V4/5vR61PvSzVR1t9mcZEuNkLr1aVGGtrg=;
 b=QHKUAxdFklI9z+YdUyB0Oifck5U2IfSM18xwiz7s6sYu+7ji+lXVeFOCW88H9cllNb
 4atSbJY9Y+Cy80tUa3pojiXzPlMOJrRZPkBpmZUnduwXhOq/zwFpAoxGqBXVE6JFbtXQ
 s5zhKdGxrtafpykosgLGu4X7gZmt2u0bbpEhQxs7RtewXxSmmWkBljBEncTh0Upelmze
 nPEYLy8/9zvpre0Pc4jJ4LgyPl0T1Hj0phP6o6CHvnDlj9KDHnjhxOBgsi44rVeV5RFq
 hVlSBndzsO8wHFSt96dlqQuohTK4HKFe3XrbZdu97F75xzHljtpG6UBexfZKrK2XigM6
 rWDw==
X-Forwarded-Encrypted: i=1;
 AL+hErGmjjwyUt1nfq1nT7jYT7X4clNPoqDRMf6lzipcVoZSVWufIwk8YgkpYr6kMDpArq4OXPU=@dpdk.org
X-Gm-Message-State: APuU4Z+Tr7KZ1X5hlkmprmpZbwQA1nubS9G4qLcuw2821xFLGUDLisUH
 v96B/7Jb2jB4U4MK91HZ4wrA5NcLX7CpOZlwACuRCAvUbSvehKX4UGlUxfpepA3xwmvAWKYgixk
 9607m44TxLaP4Ib07hL5tp9vpf6/DJNI=
X-Gm-Gg: AYBFou31buzzQhBMcuFVk8RcJTMVsR3Aty7byGIzz1mCGdVDcfC1c5iLP3Lx5TFucIl
 7RM8HIjhCqfmuu1LZe9NrxGiFziIm3NapN4kR5WXD6sgha4Jncov44b0B9h+Q04TGujVH7mm45d
 ltBGNEAT59T+7tlDut/LRPcrm0bGMWRSwFMfhmRuvGxSa2EIF+SYHFJZQlyKN9ok1prMvC0upL+
 0/Php85dOKfEx3TlWRZjxw3v1hTdS/wJl+hUgFN8wu/XiVYchRx2mbi4Nvv9JlCgce70GQ606fm
 SUzLPbTxEbtrZj1ydoEv/xX6M78bGk8+1PB4vpNzwsRDW63+d2IYZBedQHNYu2rJ+Z3tQEX51/B
 3hkH82BE7510vNHVgR8FnVg2do3gdw6EOH8D+CNLVR9HT8vl8viEXrr12KgzomUhKnoG2Y0FNSk
 xceRcdKMw+zwiDwGeURw==
X-Received: by 2002:a05:6122:e202:b0:5ec:d5e1:ee2b with SMTP id
 71dfb90a1353d-5ee64786444mr167516e0c.23.1794935380325; Tue, 17 Nov 2026
 09:09:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261107013011.2443138-1-pravinpathakdev@gmail.com>
 <CALBAE1NduwOw_4wfYt088jhwmR_nxuApepuyYYus+P-=3L=cOw@mail.gmail.com>
 <CAPbG5O_hYnLaSARh3jnw3LFToaF_S9dnjpNPFVfmJHGN2Lr9qQ@mail.gmail.com>
 <CALBAE1N77y7PkK9o09JwJ=e1GDin9jxyN7VfjvDgY2oFEr9prw@mail.gmail.com>
 <SA1PR11MB680680CA639972DE92DB11B390712@SA1PR11MB6806.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB680680CA639972DE92DB11B390712@SA1PR11MB6806.namprd11.prod.outlook.com>
From: Pravin Pathak <pravinpathakdev@gmail.com>
Date: Tue, 17 Nov 2026 12:09:32 -0500
X-Gm-Features: Aa3M54osBMj4iN1EBzGozUBmsH2MFAsuUkiKbV7RXKvr9TckKrzbKxdA18qDUmY
Message-ID: <CAPbG5O8uWmOcsWrY1DJ5MzNgeFZkAXBdMPvRcN7QBs4byoU2Ng@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] event/slb: introducing software load balancer
 eventdev PMD
To: "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Cc: Jerin Jacob <jerinjacobk@gmail.com>, "dev@dpdk.org" <dev@dpdk.org>, 
 "jerinj@marvell.com" <jerinj@marvell.com>, 
 "mike.ximing.chen@intel.com" <mike.ximing.chen@intel.com>, 
 "Richardson, Bruce" <bruce.richardson@intel.com>,
 "thomas@monjalon.net" <thomas@monjalon.net>, 
 "david.marchand@redhat.com" <david.marchand@redhat.com>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>, 
 "chenbox@nvidia.com" <chenbox@nvidia.com>, mattias.ronnblom@ericsson.com
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 9:22=E2=80=AFAM Sarkar, Tirthendu
<tirthendu.sarkar@intel.com> wrote:
>
> On Mon, Nov 9, 2026 at 6:25 PM Jerin Jacob <jerinjacobk@gmail.com> wrote:
> > Lets get the performance  numbers for SLB vs DSW based on same test
> > case so  that we can decide.
> > Performance and scalability will be the aspect to decide the usage of
> > YET ANOTHER SW driver.
>
> Hi Pravin,
>
> A few points on top of Stephen's review, plus some early numbers since
> Jerin asked for SLB vs DSW data.
>
> +1 to Stephen's two Errors in patch 2 (reorder slot reuse when RELEASE
> returns credits before the slot drains, and the lost wakeup in
> slb_reorder_drain()) and to the credit-threshold issue in patch 1.
> Those look like the ones that can lose or strand events.
>
> Additional comments:
>
> 1. slb_event.c, slb_event_enqueue_burst_generic(): the return value of
>    rte_event_ring_enqueue_burst() is ignored on every path and the
>    function always returns events_len. Correctness then depends
>    entirely on credits guaranteeing ring space. If that ever fails
>    (e.g. the credit-threshold or reorder issues above, or application
>    misuse), events are silently dropped and their credits leak. At
>    minimum, check the return value and report a short enqueue.
>    Because the burst is sorted by destination queue before enqueue,
>    a clean prefix count isn't possible after a partial failure, so
>    this probably needs a space check up front or an explicit design
>    statement that rings can never fill.
>
> 2. RTE_VERIFY(num_forward + num_release <=3D cur_pending) in the
>    enqueue fast path aborts the whole process on application misuse
>    (forwarding more events than were dequeued on that port). Please
>    fail the enqueue and set rte_errno instead.
>
> 3. slb_configure(): max_inflight =3D RTE_MAX(nb_events_limit,
>    nb_ports * SLB_PORT_MAX_CREDITS), so the device can hold more
>    events than the application configured via nb_events_limit. If
>    that is intended (to avoid credit-cache deadlock), please document
>    it in slb.rst.
>
> 4. slb_queue_setup() ignores queue_conf->priority; priority comes only
>    from the link priority, yet dev_info reports
>    max_event_queue_priority_levels =3D 2. Either honour queue priority or
>    report 1 and document that priority is per link.
>
> Performance
> -----------
> Preliminary data from dpdk-test-eventdev perf_queue, series applied on
> v26.11-rc2, release build, Xeon 6505P (2x12C), physical cores only,
> turbo on, default device settings, worker_deq_depth 16, 1024 flows.
> Mpps, 1 synthetic producer, workers on socket 0:
>
>   stlist   driver   1w     2w     4w     8w
>   p          slb       79.7   71.5   44.5   34.0
>   p          dsw     50.1   46.3   45.1   41.9
>   a          slb       54.3   65.3   57.0   43.9
>   a          dsw     50.3   47.3   46.7   40.5
>   a,a,a    slb      20.8    16.9   22.9   26.7
>   a,a,a    dsw    20.8    18.4   20.1   18.2
>   o          slb      61.7    29.5   36.6   27.4
>   o          sw        7.7    10.0   11.7   13.7
>   o,a       slb      36.0    19.5   28.3   28.9
>   o,a       sw       3.8       5.7     7.5      7.2
>
> (event_dsw does not support ordered queues, so ordered rows are
> against event_sw.)
>
> Observations:
> - SLB is ahead at low worker counts but loses throughput faster as
>   workers are added on single-stage parallel/atomic queues, which is
>   consistent with all workers contending on one MP/MC ring per queue.
> - Ordered queues are well ahead of event_sw (the only other SW PMD with
>   ordered support), but SLB ordered throughput halves going from 1 to
>   2 workers (61.7 -> 29.5 Mpps, reproduced), so the "close to
>   parallel" claim only holds for a single worker (parallel: 79.7 ->
>   71.5). This looks like the serialized reorder drain.
> - With workers spanning both sockets (16/20 workers) all drivers drop
>   sharply; SLB falls to 5-10 Mpps vs DSW 3-14 depending on stlist.
> - Note that with multiple producers perf_queue creates a separate
>   queue set per producer, which splits SLB's per-queue contention; SLB
>   scales very well in that mode (4 producers, 8 workers, atomic:
>   ~235 Mpps vs ~158 for DSW at worker_deq_depth 16), but that does not
>   reflect a pipeline where all traffic shares one atomic queue.
> - order_queue passes with up to 16 workers. In that test SLB slows down
>   as workers are added: with 8 workers it sustained ~1.0 M events/s vs
>   ~2.5 M events/s for event_sw (steady-state rate from the progress
>   counter, 20M events); with 1-2 workers SLB was faster than event_sw
>   (rough end-to-end timings, ~3.2 vs ~1.6-2.1 M events/s).
>
> These are untuned runs. In the 1-producer table the SLB/DSW atomic and
> a,a,a rows, DSW parallel and SLB ordered were run twice and agreed
> within ~5%; the other rows are single runs. Treat them as indicative.
> It would help if v2 included your own perf_queue/pipeline numbers with
> the exact command lines, ideally including a shared-queue case and
> workers on more than one socket.
>
> Thanks,
> Tirthendu

Thanks Tirtha for the readings and comments. The main intention of introduc=
ing
SLB is to bridge the current gap where there is no distributed
software eventdev
supporting ordered queues and priorities. Current event_sw has a limitation=
 of
single core scheduling limit. You can see it clearly from below
performance tests
where event_sw saturates early.
SLB provides option for moving from hardware with accelerator supporting
ordered queue and priority to new hardware where accelerator is not availab=
le.

Performance Testing using test-eventdev on Patch V2 where all current feedb=
ack
is implemented.

$ dpdk-test-eventdev -l 0-13 event_xx  -- --test=3Dperf_queue
--plcores=3D1 --wlcores=3D5-8
--nb_flows=3D64 --nb_pkts=3D200000000 --worker_deq_depth=3D64 --slist=3Dx

--slist=3Dx   SLB     DSW     SW
--------------------------------------
p             108.0      53       30.0
a              76.5     54       26.8
o              78 .0    NA      17.9
p,p,p,p     47.8     27        8.6
a,a,a,a     24.8     28.2     7.2
o,o,o,o     22.4     NA       4.8
p,a,p,a     33.8     26.5     7.0

Scaling test
$ dpdk-test-eventdev -l 0-15 event_xx  -- --test=3Dperf_queue
--plcores=3D1,2 --wlcores=3D5-x
--nb_flows=3D64 --nb_pkts=3D200000000 --worker_deq_depth=3D64 --slist=3Dx

workers   --slist=3Dx       SLB      DSW      SW
----------------------------------------------
      2   p             134.0    110.4    26.2
      4   p             206.0    101.8    29.1
      6   p             180.0      93.7    30.1
      8   p             141.0      82.5    28.9
     10   p            119.5      74.7    27.2

      2   a              76.5     114.0    29.9
      4   a             112.8    107.0    26.2
      6   a             126.2      93.4    23.8
      8   a             122.0      87.4    22.8
     10   a            111.2      77.5    21.1

      2   o               55.1      NA     18.8
      4   o               82.4      NA     19.2
      6   o             106.4      NA     19.1
      8   o             124.0      NA     18.7
     10   o            135.5      NA     17.5

Priority Testing (My own test cases)
----------------------------------------------------------------------
 QID | Priority | Events | Avg Latency | Min Latency | Max Latency
----------------------------------------------------------------------
   0 | HIGH         | 250000 |   11738.30 ns |        462.81 ns |  466678.0=
0 ns
   1 | HIGH         | 250000 |   11810.06 ns |        512.92 ns |  468083.8=
5 ns
   2 | NORMAL   | 250000 | 902657.03 ns | 381863.42 ns | 1156287.10 ns
   3 | NORMAL   | 250000 | 908277.05 ns | 383254.46 ns | 1161556.63 ns
-----------------------------------------------------------------------
