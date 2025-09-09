Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9106FCAC582
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 20:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B21A1402D4;
	Tue,  9 Sep 2025 22:40:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9805D4014F
 for <dev@dpdk.org>; Tue,  9 Sep 2025 22:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757450455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T65oiDyxCipJ+RSgEg7zX2Mm9m/Ty3bnf0OkjuUPHwA=;
 b=DRwOlpexkeEBVTPw2cl7DnE5qcX686Qp0iOon1kZFowYdpDi5oUp3jvFCVAuxWU/3l1J9h
 FhL1zz5UnaoQDemaG+xIsQYK2V3gFYLkDQM2axAbOdnFhWNqwFHbwIhWDseq4hdfq7toWO
 vQ3LSSa1ogErm3/+sVXWlpPCgWT4JqM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-QIaJnngrOWa9gKjLdv6iTQ-1; Tue, 09 Sep 2025 16:40:53 -0400
X-MC-Unique: QIaJnngrOWa9gKjLdv6iTQ-1
X-Mimecast-MFC-AGG-ID: QIaJnngrOWa9gKjLdv6iTQ_1757450452
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3df07c967e9so3704022f8f.2
 for <dev@dpdk.org>; Tue, 09 Sep 2025 13:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757450452; x=1758055252;
 h=in-reply-to:references:user-agent:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wXMNAlhpFQn7ykjE3tlR25qq6lfbvq4YvZgsRvg9ji0=;
 b=VsXzfN2LsPg1y2Gfcma2nK+tRo8dFwxgBjmfI/+q8UjstsWoxCSkmdFqALT4cokrUy
 xi9EQpN7zffJUWteAHYoWLB35kLW36GxprJS1uXujk1WPoTiwco6/wKeddQnFhmANnWZ
 QO4+IUAaAxWIg4GB4iBilI1vuQorNai4LqqHTjItrJ620sAg23TVMK/FQm1XamxfeBDs
 6vL568MJSkhvIlHM6KJhMwj+GXhpdJr0WmsHw6JxBtA941s95AJn5J0bG+l9GqegF/MD
 AtgpR2MIy179owXT90DNkHdNm1KhhpvybRFv0mMzq1xvaMvyZ10BKUov3DJaDmAs3+/8
 OdOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1kxR3KTQU31weLyrwEwsir6jASD5eGuN2zsCAswjQiLVv6yqhJJcMZAEh+1jgT/53qpI=@dpdk.org
X-Gm-Message-State: AOJu0YwQEUFDl/0B4jW+uec7PpAnwUiuq4KZRCuEqv9p4Spi3y8yLMs0
 /EU1IvUooqGunE7oZAIVyEuC0c+L6l9mt58pw/VgzuWGyDAkA4JwNqMuWKU0KFNmRDEDrOBv9Vc
 xDykh15KhhRoCDi8DW5ldu7hojQ8fDEORzMrxy864xsio
X-Gm-Gg: ASbGncskOEgYC2AgRXJYBfpzP9nVSn+I3JJu3J059VHjuHA0b4PX5CNy1xdvN9rtdnR
 agRVAV9PsdftPcZ61j/HertOJA4AjjvHtvtVzh0S3znFUg0DwKM18ih/iLWfuG0wi3G4x+6FHXY
 mS+GXZbXt3BH1h8Ippju6eVz6RcOYBkwGS22nj1l3odYQGBcYurmlF9gPFdLe/fIm+DHurByKDh
 Uh5Dj8RCHIBu6K64h/jKEwJrcPbpFkv6R/Ci3kbNfKqZxsgdYgKUvWHwJj4ZIC11FVCaqKJ/wLW
 xAaHMd3g8IHnBfdO/NX/MRSg+jhR/dREJBVZwICSR/N35uVERvkyZ/h4GyXe1trKt++MsOkXXD5
 H69umbZs0QuL5m9T49HduX6A=
X-Received: by 2002:a5d:5d82:0:b0:3e0:34f4:3225 with SMTP id
 ffacd0b85a97d-3e645e858aemr11421193f8f.45.1757450452355; 
 Tue, 09 Sep 2025 13:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf6lx3LzGN4wXJUxYv4heQ7Av2lGqIA75hJ0TLumw9WfZo5M9QfdPVjiuahKQCZgrk95fv7Q==
X-Received: by 2002:a5d:5d82:0:b0:3e0:34f4:3225 with SMTP id
 ffacd0b85a97d-3e645e858aemr11421181f8f.45.1757450451871; 
 Tue, 09 Sep 2025 13:40:51 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002fb5ec50e5a775d4.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2fb5:ec50:e5a7:75d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45df81e4563sm968395e9.7.2025.09.09.13.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 13:40:51 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 09 Sep 2025 22:40:50 +0200
Message-Id: <DCOK6VADCGM4.147AQDN77QTJO@redhat.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>, <dev@dpdk.org>
Subject: Re: Error with --no-huge when compiled with -fsanitize=address from
 gcc 15
User-Agent: aerc/0.21.0-2-g47ed279078d2
References: <D9WNYZDZHISG.3091PEP8Y34QL@redhat.com>
 <DAIPCY7NIG04.2Z0S17M8BPQUH@redhat.com>
 <9d2e0536-98af-4532-aa57-dd1605d6e070@intel.com>
 <DCK3KYFOL7EF.1CBE546ZJUS04@redhat.com>
 <45a59471-a515-4595-bf07-a74d1c6e8482@intel.com>
In-Reply-To: <45a59471-a515-4595-bf07-a74d1c6e8482@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rARiZyq-QY_vkPZI2NqriXnQEKHRu_eSy5xQ10IC60I_1757450452
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Hi Anatoly,

Burakov, Anatoly, Sep 05, 2025 at 11:17:
> Specifically, it's weird that your DMA width is 42 bits (indicated by=20
> "using dma mask fffffc0000000000" log), running on a physical machine -=
=20
> mine sits at 57 bits, so despite having VA's within the same range as=20
> yours, this works on my machine because my DMA mask is much wider. Maybe=
=20
> there's a kernel command-line of some sort that limits your DMA width?
>
> At first glance I don't think the issue has anything to do with DPDK, at=
=20
> least it doesn't look like it does to me. I do not see how DMA mask=20
> width would be affected by libasan or GCC15, to me it sounds more like a=
=20
> kernel configuration/HW setup problem.

NB: The problem *only* appears when I compile with -fsanitize=3Daddress.
Hence my suspicion around GCC/libasan. There must be something done by
ASAN that changes the address space.

Digging further with your advice (and some help from AI...), I found
that the DMA width (42 bits) as reported by EAL debug logs actually come
from my laptop having a new "security feature" enabled in the BIOS:

=09Kernel DMA Protection

When this "feature" is enabled, IOMMU is forced-on during early boot:

=09DMAR: Intel-IOMMU force enabled due to platform opt in

Also, my IOMMU exposes a limited DMA width (I don't know why). My CPU
model is:

=09Intel(R) Core(TM) Ultra 7 165U

I have disabled DMA protection in the BIOS, and the problem is now gone.

Interestingly, whenever I explicitly enable IOMMU in the kernel boot
arguments (iommu=3Dpt intel_iommu=3Don), the issue manifests itself again.
This is therefore a weird interaction between ASAN, the IOMMU on my
laptop and DPDK memory initialization.

Anyway, sorry for the noise. Maybe, my experience may be useful to
others :)

Thanks for your assistance!

--=20
Robin

> Will stain.

