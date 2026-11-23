Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C447606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rfEIY/46
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6153F4027E;
	Mon, 23 Nov 2026 18:03:25 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTPS id A10E44027A
 for <dev@dpdk.org>; Mon, 23 Nov 2026 18:03:24 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8a052aff9e9so2688131b3a.0
 for <dev@dpdk.org>; Mon, 23 Nov 2026 09:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795453403;
 x=1796058203; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r1L/6oaOCUSIFCAqBW+m2iUmHVVAMqBr3uJ5FKzBqQ0=;
 b=rfEIY/46HzwYkqzbu2l96TF8m7zMACYgKJy3KqNH/FFjFzfatRxPu4lE8LXUis3jZJ
 MfEy+dLvRawlncwej1V5XYSFBnnbaxq+yi3sZ8JY5APU1Rl0extFtXhJEMLNOZs3039m
 jQc7uiWhjoHA571zNUZAEFy3W3TAM2WOdMP1Dy2WEOqGV+z7JTBeKtcgSv9/LoPnxdcl
 q+s4Zpw8VaRcjYnVzSf3QFsAbbguDfxweukk0SKWy2SPtlTEgiIr0bhC+H2plJG6wJAP
 KR46o7su0hSL3o4VW5yLXjSdvKM53RygpAZNItv5SfzpiCMHXASvec+dlfaljtQSiGGt
 kQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795453403; x=1796058203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r1L/6oaOCUSIFCAqBW+m2iUmHVVAMqBr3uJ5FKzBqQ0=;
 b=q812Xq3RXarNWuaTt+ebrZzHaz5WVVl8T7+CUQ/UMW1d96a+uQ+eSfpIbKlABcrFKE
 zmavFnQDDc9Z91PIaYXH0VaU/PdKMdM5dOKcCWGg2iOGLR7pXWlzEp6CNxGc7RPg4QTH
 +sSI+TqElfT3bA3KITMUlGMTWPTYn+dTqtqJ2P6fmXNaU7cffDdHOb9+uFgd5SEFaOVR
 SnCkdwPDUD5sRBcJpFbUBFyB2EGaJVrRG6rq8VhHayaBHJgZS1YvLNVaZXMj9Ic85Yd5
 tSYZuVfCGoLrauFvHG5KSXldvDez0Mg55/RrSFNZ2BqvEhH6IuLRWJ1okcliqWnyv+eO
 LSsg==
X-Forwarded-Encrypted: i=1;
 AL+hErE0xYYeziScl1fOIeib8FuilvCuIlTnfre/3qmsXWjPRZFK9xOU+94vHDR9OTFGrNMxsaA=@dpdk.org
X-Gm-Message-State: APuU4Z/DrGsVDoUAZ3iKg2NOp89NmezQwU2t0w0K04rmb/Z6WhyWkNZk
 crW+R0fSyjtE55aLDPOtfvoCjddruK18PIfSLdn6kUi3zfnVmSzFMBS4Cn0Sf42IZzo=
X-Gm-Gg: AZFdTZfKB8a0KrmmvK9iFDdwlBUQoaMzbOBUQDxkHsnW3m8n+q55U1F+foB6c3918vy
 5kZeTMJJcva2n2M7GEHVW58gnosEgim9bK33K887N1wz+uZ1itAGyzHqre1y+hZ29NRO/UCSFOd
 zVD3Vph3QgXR/a1jbEO39otBPt6w/PzShsBMpl4gSGj2KAsL9JAKDtHkeEJ3ydMHfxArLoLvz2P
 K4ogLVs7jv+4SizZs9/fyrATL+nosDl910JOAV5K+hwQ8mpwTEkiYiaUJriqvvlsrL2PBxHMXIH
 +Bc/LCI9ZzCEXhnZDVKYNdnaChdy2e+opL0Xex7PUvFdvbpvS1WdH59DprJgRJ9jElkHH6vhMe6
 WWGQApHxEnb6GMZBiN+XeGeaScyD7LqSeLeUk1OYBk3do1yf3wp3AUQnyVjPRVjDROV/yKeHp6T
 2xiONu8q6gxMigZLS5QyMcW+So/iAPTzMyd+99+jMa+MJ5SOKtQ6eIhFeAEjyj7P5zzpUZV6Jqx
 DqJLkIBcEj2goItnqPF1tjZeaMw/xFUWSf/HBtOcsL8XEgu4Gms9pIwJ948iLmDjb8Y33iV/DuX
 DX18Dmz5bdPd6r7atOvWezNohegJjgHPDIhsUwPnmShUlEZe9/+qkvt85CpaXk6jd4+DwqI=
X-Received: by 2002:a05:6a00:2d0b:b0:881:4b47:f305 with SMTP id
 d2e1a72fcca58-8c8794b9136mr11145914b3a.5.1795453402820; 
 Mon, 23 Nov 2026 09:03:22 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c86d821637sm6092379b3a.0.2026.11.23.09.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 09:03:22 -0800 (PST)
Date: Mon, 23 Nov 2026 09:03:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Cheryl Bansal <cheryl.bansal@altera.com>, Yipeng Wang
 <yipeng1.wang@intel.com>, Sameh Gobriel <sameh.gobriel@intel.com>, Bruce
 Richardson <bruce.richardson@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>, Chenbo Xia <chenbox@nvidia.com>, Nipun
 Gupta <nipun.gupta@amd.com>, dev@dpdk.org, Thomas Monjalon
 <thomas@monjalon.net>
Subject: Re: [PATCH 2/2] bus/pci: add selective BAR mapping support
Message-ID: <20261123090320.33037bfe@phoenix.local>
In-Reply-To: <CAJFAV8zeicsv9kS5zv8uk4TgpRmz2_TahkYbMvYV+G6GL=rmTw@mail.gmail.com>
References: <20261123061319.163645-1-cheryl.bansal@altera.com>
 <20261123061319.163645-2-cheryl.bansal@altera.com>
 <CAJFAV8zeicsv9kS5zv8uk4TgpRmz2_TahkYbMvYV+G6GL=rmTw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 23 Nov 2026 08:57:45 +0100
David Marchand <david.marchand@redhat.com> wrote:

> On Mon, 23 Nov 2026 at 07:13, Cheryl Bansal <cheryl.bansal@altera.com> wrote:
> >
> > Drivers that only need a subset of PCI BARs still pay the cost of
> > mapping every valid BAR. There is no bus-level way to select which
> > BARs are mapped without changing each PMD.
> >
> > Add the bar_mask PCI bus argument to select which BARs to map. If it
> > is omitted, all valid BARs are mapped. A zero mask, a value outside
> > BAR0-BAR5, or a malformed value is rejected. The argument is parsed
> > from bus_str so it is not passed to PMDs. UIO and VFIO map slots are
> > indexed by BAR number so primary and secondary processes stay
> > consistent when some BARs are skipped.
> >
> > Example: -a bus=pci,addr=0000:01:00.0,bar_mask=0x05
> >
> > Signed-off-by: Cheryl Bansal <cheryl.bansal@altera.com>  
> 
> Clearly too late for 26.11.
> And don't Cc: stable.
> 
> 
> Adding a devargs looks like a bad idea.
> Why should a user know about such an internal consideration?
> 
> A change in the internal PCI bus API seems a better direction.
> 
> I wonder, which DPDK in-tree driver would benefit from this change?
> 
> 

Agree. Too late for 26.11 and devargs is not the best way to handle.
I wonder if bus API could allow probe to reject a device?
How does Linux and FreeBSD handle it?
