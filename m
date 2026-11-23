Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD822606A32D
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dWQgf9l4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21BBA40262;
	Mon, 23 Nov 2026 08:58:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id CEB5C400D5
 for <dev@dpdk.org>; Mon, 23 Nov 2026 08:58:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795420683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nZ9NC6HIM3g1KdjDd1gqB2fulQ0AFocsY44z5Y6wGyQ=;
 b=dWQgf9l4OwesmI0p5mgPD5Kuoc/hnjyE6jfCNJyFiOU6RQCfQn3Zl10coqm9BPjjxAqf8C
 ifDYeuaWXiwypHp7UBm5ze8GNlRnZmErNaX169xdkyIfE3IhvXOubzqqu19EcxQCNN0mmS
 Vxw61eNHziVJVOcc6m6/uUEEgtklNRM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-3goaLU1zPX64-exg_UrksQ-1; Mon, 23 Nov 2026 07:58:01 +0000
X-MC-Unique: 3goaLU1zPX64-exg_UrksQ-1
X-Mimecast-MFC-AGG-ID: 3goaLU1zPX64-exg_UrksQ_1795420680
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5bfd95238e3so1850167e87.0
 for <dev@dpdk.org>; Sun, 22 Nov 2026 23:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795420680; x=1796025480;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nZ9NC6HIM3g1KdjDd1gqB2fulQ0AFocsY44z5Y6wGyQ=;
 b=C5qELBudG1KwAVP5lex2Yz8qMiUkDMzCps/C5z82M2o4wRslqb/BQhqn8M3u2FT4Rk
 y5YVLdTBjEMpY+oI7xZo/10SNF3+En+nrAnHeUHBBMzKoqgYyABEyKgMz3F2mzsCUswm
 AbzVwbPyr3ZbbCG30ZWXxear6fnWKpLlWRpJXfVihszpS8IntHmFqCdX6ckLikNGrCvz
 zESpVyYs1tfrDqlbubABpmuiMYzY9ARMiDvbyWdaeha2rNf5pKkKfoU0B8xs6Icq70kG
 e0BJdJnP/ZWqIUOvzmQP723D9dmH4Scw0bO9ofstiFYTj1HbE9sgbAkrqnbAr1QLYCll
 wp2g==
X-Forwarded-Encrypted: i=1;
 AL+hErE8mwYP8pU+QVEQ5MzQ8nzIslHI9mEr0RMAf1yEJE+i//Nr6/V9XOrvv5iA+LtZoABivjI=@dpdk.org
X-Gm-Message-State: APuU4Z8RLNUQ7lxGkTpiXmgSJM58yJCFeD6hcZMPr0u4sdr7PjPhyfXy
 dL0fMPriq6pRw6GIOzCINM7G7oqdltCh1lAMj4SblJzUIOZZ6lRwP1CUPHx2msBKRKHNEFx4kZ9
 E/o/NJ8sozO+3EcmbuLwSqqZ3SDb1XNZ5yTAcuBzGB6I6sC8pSMhrLP+dCYK052OmpB/5NFrKvV
 UzWFNeePc95K4Gv/52HBY=
X-Gm-Gg: AZFdTZfOTb/qJFjFz0mYknxraGqxmx1ZMcWfjE4LPNYO5N8nKT/N6uLnrdl5E1/MQCF
 x0iWyPcYDoDzkzu97Sclum8E8LOI9osUQSAzBjsSqdW7h64wX4c6BxmOqVfRnCTnUH/sdpCaE2n
 P6BuXTcRBTBiahvpyWzMtZSQFm/uPanBrUrAqCl2SV9Y3NxlKda9QKapVG7CErVfDs8fn0pu6xf
 HTzcI6/43dn8rFN1qILavihkTGNmSTs9ZYBWBFeoqj3jSVR
X-Received: by 2002:a05:6512:a85:b0:5bf:d9c1:58d9 with SMTP id
 2adb3069b0e04-5c1bc8ceb91mr2123216e87.23.1795420679890; 
 Sun, 22 Nov 2026 23:57:59 -0800 (PST)
X-Received: by 2002:a05:6512:a85:b0:5bf:d9c1:58d9 with SMTP id
 2adb3069b0e04-5c1bc8ceb91mr2123204e87.23.1795420679417; Sun, 22 Nov 2026
 23:57:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123061319.163645-1-cheryl.bansal@altera.com>
 <20261123061319.163645-2-cheryl.bansal@altera.com>
In-Reply-To: <20261123061319.163645-2-cheryl.bansal@altera.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 23 Nov 2026 08:57:45 +0100
X-Gm-Features: Aa3M54p3VO3yzo4uTrZiNST0gKO2iRVvdvlrZ39gH4LFglrQY7yvydWQkB6-k6c
Message-ID: <CAJFAV8zeicsv9kS5zv8uk4TgpRmz2_TahkYbMvYV+G6GL=rmTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] bus/pci: add selective BAR mapping support
To: Cheryl Bansal <cheryl.bansal@altera.com>
Cc: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, 
 Nipun Gupta <nipun.gupta@amd.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JsVdbiPLzxibZ0bwzkGu93nwUSisJGh3Ng92eH-iVz0_1795420680
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 07:13, Cheryl Bansal <cheryl.bansal@altera.com> wrote:
>
> Drivers that only need a subset of PCI BARs still pay the cost of
> mapping every valid BAR. There is no bus-level way to select which
> BARs are mapped without changing each PMD.
>
> Add the bar_mask PCI bus argument to select which BARs to map. If it
> is omitted, all valid BARs are mapped. A zero mask, a value outside
> BAR0-BAR5, or a malformed value is rejected. The argument is parsed
> from bus_str so it is not passed to PMDs. UIO and VFIO map slots are
> indexed by BAR number so primary and secondary processes stay
> consistent when some BARs are skipped.
>
> Example: -a bus=pci,addr=0000:01:00.0,bar_mask=0x05
>
> Signed-off-by: Cheryl Bansal <cheryl.bansal@altera.com>

Clearly too late for 26.11.
And don't Cc: stable.


Adding a devargs looks like a bad idea.
Why should a user know about such an internal consideration?

A change in the internal PCI bus API seems a better direction.

I wonder, which DPDK in-tree driver would benefit from this change?


-- 
David Marchand

