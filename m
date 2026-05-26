Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58ADCD5BC8
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 13:59:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 915DC402AC;
	Tue, 26 May 2026 15:59:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D57E440290
 for <dev@dpdk.org>; Tue, 26 May 2026 15:59:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779803994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EY9iVdMTVrZA1pCialuDOVjZwqRit1ibDgyMPRddua0=;
 b=d9vVveZD/IFmF+mkfycgGBG3xxftHDu9EsZBzU67NPm1vedlQVUyDTDULECpGyRPK2xxsA
 y2BuwGdBcHs/suTS1LHDxgVXJRESUBulPeBhqNVbft3RADkKEKE6SKyw6cNuiLvLN76Y85
 aHm75QgkwZcHflYQk2AjDiILHV9OXq8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-n51pZoyQPLCssLsqbIFpCg-1; Tue, 26 May 2026 09:59:51 -0400
X-MC-Unique: n51pZoyQPLCssLsqbIFpCg-1
X-Mimecast-MFC-AGG-ID: n51pZoyQPLCssLsqbIFpCg_1779803990
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39389bc702eso48111421fa.2
 for <dev@dpdk.org>; Tue, 26 May 2026 06:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779803989; x=1780408789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EY9iVdMTVrZA1pCialuDOVjZwqRit1ibDgyMPRddua0=;
 b=X+DD+Isv4UPd0PZ6n1GeNCI+8ooDBnLUsEpqoi190GgyG27cuGxZtr5uvVBoRIfkfv
 1i3+OBrNRN9ymXPsWoAdqo8Yih/7frMtoUondf/QrAyckgBj19Q8a6OplXyjYUSd0p0E
 Is4XxwAdfjcnGQTO8e8rzi3zAZAK4LRxlGKUDCGFqsXZtznw2sj+T2RNjOeBzvNgrFiv
 tC1QwycmkLuMD68fpLj3D95weH6HX/7qLC8DOB/We/Q5h2oJvhmsj75QmOxTjxZIZZG6
 +zgBpmwRZLvIBQm3Len1OUl7QRdkBvchTVNxi4d7d1b1djkCNOS4l2kXr26GdKs5V3wz
 aKAg==
X-Gm-Message-State: AOJu0YxonjAGM50R/sqiBPd0SEnMmv+5OpzZCviKCPZlfTtJRMjsyMKb
 I2AZuc0J6k540KHJGLV6wLH+ZiCuGn0Obi86evuhA6fqyfdvdyNn6yNrfI7FOtOr839MxdMdMH4
 QdZiiO3psM+XkseYjp688qpD2abD815n4LP+27Xdv4vhUrALxsT7FwcpL1KwLLtbTkoulDCPbSr
 lo9T72bnyActmEQquPatvb3ifgULc=
X-Gm-Gg: Acq92OH5n1nMSau7ygvFCUZzAgLoAVZgK4hTTfm7ajk8U5ldpKffsUEk6BhdVzjMxZG
 Wxc/5eXCUnAON2uts9rwrrEqWj3yhqMqIuLtM2XctQ4ZUV8G21xW4eW9NiBWp4hhhHOWVZ7Nnai
 WfV7KyRypwijqDsbv6+/WeyIDKndbQXY//GH0Hkib3T5XVVjCJ1FVbkAqn+XXe3yW9eY9rq0nNj
 kIV0+XqZVTTcre4q99BEFdKfZJ1SPUKqG3KFYjooNr1mCgfkDpXPrL85stYP1rqFuwU3uXaDIIV
 BpFM
X-Received: by 2002:a2e:980c:0:b0:38e:d3ec:4f91 with SMTP id
 38308e7fff4ca-395d8c931f0mr42302531fa.8.1779803989474; 
 Tue, 26 May 2026 06:59:49 -0700 (PDT)
X-Received: by 2002:a2e:980c:0:b0:38e:d3ec:4f91 with SMTP id
 38308e7fff4ca-395d8c931f0mr42302411fa.8.1779803988923; Tue, 26 May 2026
 06:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260526084212.3145685-1-david.marchand@redhat.com>
 <CAJFAV8wAt1hyHrL0N1AxQ1kBjKoQNtuo89m_H7LHZJmtGea_gQ@mail.gmail.com>
In-Reply-To: <CAJFAV8wAt1hyHrL0N1AxQ1kBjKoQNtuo89m_H7LHZJmtGea_gQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 26 May 2026 15:59:37 +0200
X-Gm-Features: AVHnY4IqnJsUoynFPGlNMD9DwkY9bv6yffLcPDU8wIhjkgN4838rSlHRBTSnVos
Message-ID: <CAJFAV8ztAtqY6-tDCYyFGOzf4=nnAhS-HsZpfwenVkwg=5sPig@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] Consolidate bus driver infrastructure
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org, 
 bruce.richardson@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kyzytoWvEPUc2dRXBY3E8QRygHDADywpXDUXq6mPrqo_1779803990
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 26 May 2026 at 11:03, David Marchand <david.marchand@redhat.com> wrote:
>
> On Tue, 26 May 2026 at 10:42, David Marchand <david.marchand@redhat.com> wrote:
> >
> > This is a continuation of the work I started on the bus infrastructure,
> > but this time, a lot of the changes were done by a AI "friend".
> > It is still an unfinished topic as the current series focuses on probing
> > only. The detaching/cleanup aspect is postponed to another release/time.
> >
> > My AI "friend" really *sucked* at git and at separating unrelated changes,
> > so it required quite a lot of massage/polishing afterwards.
> > But it seems good enough now for upstream submission.
> >
> > I would like to see this series merged in 26.07, so that we have enough
> > time to stabilize it before the next LTS.
> > And seeing how it affects drivers, it is probably better to merge it
> > the sooner possible (so Thomas does not have to solve too many conflicts
> > when pulling next-* subtrees after, especially wrt the last patch).
> >
> >
> > This series refactors the DPDK bus infrastructure to consolidate common
> > operations and reduce code duplication across all bus drivers.
> > Currently, each bus implements its own specific device/driver lists,
> > probe logic, and lookup functions.
> > This series moves these common patterns into the EAL bus layer,
> > providing generic helpers that all buses can use.
> >
> > The refactoring removes approximately 1,400 lines of duplicated code across
> > the codebase while maintaining full functional equivalence.
> >
> > Key changes:
> > - Factorize device and driver lists into struct rte_bus
> > - Implement generic probe, device/driver lookup, and iteration helpers in EAL
> > - Introduce conversion macros (RTE_BUS_DEVICE, RTE_BUS_DRIVER, RTE_CLASS_TO_BUS_DEVICE)
> >   to safely convert between generic and bus-specific types
> > - Remove bus-specific device/driver types from most driver code
> > - Move probe logic from individual buses to rte_bus_generic_probe()
> > - Separate NXP-specific metadata from generic bus structures
> >
> > Benefits:
> > - Significant code reduction (~1,400 lines removed)
> > - Consistent behavior across all bus types
> > - Simplified bus driver implementation
> > - Easier maintenance and future enhancements
> >
> > The series is structured as a progressive refactoring:
> > - Remove redundant checks and helpers (patches 1-5)
> > - Add conversion macros and factorize lists (patches 6-8)
> > - Consolidate device/driver lookup and iteration (patches 9-11)
> > - Refactor probe logic (patches 12-15)
> > - Remove bus-specific types from drivers (patches 16-23)
> >
> > Note on ABI:
> > This series breaks the ABI for drivers (changes to rte_pci_device,
> > rte_pci_driver, and similar structures for other buses). However, the DPDK
> > ABI policy does not provide guarantees for driver-level interfaces.
> >
> >
> > --
> > David Marchand
> >
> > Changes since v2:
> > - fixed dma/idxd probing as reported by Bruce,
> > - moved api_ver setting (from match to scan) in bus/uacce,
> > - fixed transient bug in the vdev code (in the middle of the series).
> >   tl;dr the high level difference for bus/vdev between v2 and v3 == 0,
> > - fixed doxygen,
> > - enhanced API description,
>
> There was some hiccup from Red Hat SMTP when sending the series..
> hopefully my resending of the second half of the patches is good
> enough.
> At least, patchwork looks happy.

The sxe drivers got merged and pulled in main, so I'll prepare a v4
and send it probably tomorrow.
Comments still welcome.


-- 
David Marchand

