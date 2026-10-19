Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F20606A31F
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=uc0Qxrmw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1469B40430;
	Mon, 19 Oct 2026 19:20:56 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id C96774021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 19:20:54 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cd5cd8d89a7so871010a12.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792430454;
 x=1793035254; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4Y3h7FTSKYhpIj7bXRAjB0ysEOFLBocE57c7xY3u09w=;
 b=uc0Qxrmw+kZgVIztBc36ZQTSERIxIZI/6ytLW19tuUtCOBcZF88Wf+Q9qVjON3mzER
 GcKIrA0hteBIkU1ktf35jWRbugo+KEatX2Ta2cEdGUBt7n155Tb1m/qF3/Q40NU4bGOy
 fTYHMms62HlKFCyiMLX2tIxacxI53BtpvaGSGmpZZy9s0W4CEPejwTcpx5GqEJsMslDL
 ekhHb36XRBrN9ZtY5XfjtZfjyhAVnsuuC8MoKv+WbHmxpoHS539x7j3U1UCXT22yX9TT
 tiJYOmL6tZpuCVIwm0pgi7ml83+n4Y4GC6grIW/bXjRAio2hIQ383DJcmQ6Bx8tD4+TQ
 vC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430454; x=1793035254;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Y3h7FTSKYhpIj7bXRAjB0ysEOFLBocE57c7xY3u09w=;
 b=tzApN2Ke3+BQZmX9Fq4dEWxbmpzRnHQZ5TNXNhyob5UBXOgus7NeoQA+j1g96NpwwV
 heDvL6LUpeUxRD5MmEnYkc/6c8Ru7cWF3o86eYHm3rvpibWclF+Suf4okiY0Z6bYkR0i
 ZA10FyYkfG9BTvRwG4CMA/SPqaXoYpyP0em/hNQLN8tj+C65R1M0cpWUr5j/yc7nZ217
 FcFTfd+R2Chq3YC2rTp73MpMjNtCqQZuc7z7VVXWYEpIcrZTFor0fRFBRQPwo39tDdas
 vCIzdF9e4AGPPhkbtHEKsjYw6NHCWwOnzHVcZ2EMHape6KbDcVzd1gCvMhvxfWOqIGSg
 n6OQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAvAGqNIJ5sKSGG0jwHTgBA7AS/78d4dZFl41NsoZLLoHNUnHdYOyz2XLvn792JeK0Bho=@dpdk.org
X-Gm-Message-State: AFq9FYIlgmXqxM5H7H0SgW8hXyWJzqqNeThN5WNTsBzRvmgRlChDqiVP
 Hh/JdQ3BRtbX968ZUKmsXMQOFB6O8Brxd2G0y6evI1kfFI3LzL03+WTLP/57yVGLeGY=
X-Gm-Gg: AYBFou0xT2b+Ja4JvuLD8Y/AVTTN+5wkqlMJqe71o2m5zjK3l2MtdSHc0C+lZFTtOxw
 CeX3Hb9/JhILMxfSdAismxyi3CQmh/d3UnixjEFZfcEqjhz5JSSxRGACKtaLuLEDv7zaNCFmHww
 QpfuVI06rhzxor3vNtL7/ujX6wJ3I0nN46RR/HygoypktZ6TNpM0aVqn501xSuNfxxli7ymgWsS
 uuHiG3KNeiS6nAs/fmExGw0atipLQ4wSyc5jzz4B15FbjUS5liQz26sd43Ba8Wt67b4EiiBwOop
 QASI0ywCg0Ahtnv5Gqf5mYkJi+LQe8gTK6v8D+fEldtBaCaAgovn7Z0EIh/Htwnj1CsYzXtsoIf
 WCLIGYvkgcHcqDvi5jECa/fjg8puwGw2ZazaaIP2tKxvvWvGe3mkc/RNB8Cg37YbP1z87gLD/RA
 3v9Wlh82PtdJXHZh/H6wDKsIusKiDRoIYs2ip0dLmmvBP45HheowTneeO3lYVKT8gUPkj3gFTia
 ZDsvnayaeZCu0/au3WuOz0EexeU51trA7/qeQ4beGtFia048l4=
X-Received: by 2002:a17:90b:4c49:b0:3ac:aa8d:19d6 with SMTP id
 98e67ed59e1d1-3aceebb68d3mr6686241a91.17.1792430451921; 
 Mon, 19 Oct 2026 10:20:51 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad5df655b1sm322102a91.17.2026.10.19.10.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:20:51 -0700 (PDT)
Date: Mon, 19 Oct 2026 10:20:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: Harman Kalra <hkalra@marvell.com>, dev@dpdk.org, "Burakov, Anatoly"
 <anatoly.burakov@intel.com>
Subject: Re: [RFC 0/3] fix bogus interrupt FD leak warnings
Message-ID: <20261019102050.3f4c4c50@phoenix.local>
In-Reply-To: <CAJFAV8x9JDsQdxEispOeAcRGsPT9erxGx_c2EHMVWqH-KQV1JQ@mail.gmail.com>
References: <20261017203621.3136254-1-stephen@networkplumber.org>
 <CAJFAV8x9JDsQdxEispOeAcRGsPT9erxGx_c2EHMVWqH-KQV1JQ@mail.gmail.com>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 16:12:30 +0200
David Marchand <david.marchand@redhat.com> wrote:

> > - Patch 2 resets dev_fd at the two unmap sites. Doing it inside
> >   dev_vfio_release_device(), next to the close, would cover any other
> >   caller.  
> 
> The current fix is a symetric to the map path, where the VFIO
> subsystem gives back to the PCI bus a device FD tracked in the
> interrupt handle object of the PCI device object.
> 
> The VFIO subsytem has no idea about the intr handle stuff.
> All it knows about is the device FD, which seems correctly closed by
> VFIO on call to dev_vfio_release_device() indeed.
> 
> I don't see why it should change, can you clarify?


Not sure, these patches were AI generated, based off of
"I see these warnings now in testpmd, where are they coming from and fix"
