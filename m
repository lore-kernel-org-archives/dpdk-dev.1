Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C34F4613C
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 15:08:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD74940268;
	Mon, 23 Mar 2026 16:08:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 43C834025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 16:08:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774278535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEaXiNO6kW9MTbzBop+lUKEX/UfqFNBjO/Uu6wsdl48=;
 b=ifrp+2EEf6hE5T71BvO+dFk+GdcfTiuucAR0xZcUU8NV0xqNDCvjoKvY7UTPKHAeMfTVby
 AFuf9ChFq0pNXUf7ljZF89UDfgTOLYMSMoiBWNNx0Ywkxf/1M+nwetiIBA4BXeTe+YQbMu
 yefBG6OGlXoTiGAYj55GAviHB/RZ4Dg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-CnWAj-bCPoutLqNL-37sqg-1; Mon, 23 Mar 2026 11:08:54 -0400
X-MC-Unique: CnWAj-bCPoutLqNL-37sqg-1
X-Mimecast-MFC-AGG-ID: CnWAj-bCPoutLqNL-37sqg_1774278533
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486fa35b005so5018125e9.2
 for <dev@dpdk.org>; Mon, 23 Mar 2026 08:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774278533; x=1774883333;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zEaXiNO6kW9MTbzBop+lUKEX/UfqFNBjO/Uu6wsdl48=;
 b=XhGvs85AvBiepUQWJmWiu5VNV83/HSFXYuCBm8VCUap+0FlN5bii4coV9QJ7EhKGjE
 U7J/46gw/TklneZuD9Lplz0cPwVR82eiuCrpOJwVxkpPhVCQPI3fkGslYJHqYJkBAouc
 bneHg6G6D2hj7ouORdIknkB+EDwgI/PSVdSoY7PbYbTRT43SmCFzej11R6S5jW0YY/lg
 19iQyr5NrH/KmHcsaZx+6hB5pl5tDdlJMl9rzmr8DvlxMEW8p57jIIWP0+S6ovKx7cBh
 Ql5qkGv6W3UWNtnNFA7YUuwLAAn9IfAshT45sHkkNmM1+M4fkLlfn9DpldpT5sTs3scG
 Pycw==
X-Gm-Message-State: AOJu0YzOYEC2Zm6VNaCWK1UhSEOfdtuoarHwC9fSzuOswB2bTnIj9vHM
 1M8/x53FN2AFdOGLALTa5W++ZdKmmOuGRlaYhFwc2ih3TVX+Ma9+aM2i4BoFXsHfymXw+ruvTkp
 IEeUB2JoYDOqwhoBuRCAjDyCq91Al9BhWxjTWUAB3kQmu
X-Gm-Gg: ATEYQzwYLfFQOQvKG+QAohahiE4svZT8D8FMO2SR/nOjOLYydb56XrnLuc9v7kB4VV4
 AuKUEaxz0u4cglU87DNEy3BB7sSEVmekdXeFfiVImIM5tByJpnj3QmBO3fX39c2MhL526kjMJ/J
 TeJJPjzohRCrSzy1rfRz29Mn9m0KdhBy5d79K1xZiRinK8VWLxGBzI568X6SQ62TNZ/5crbK1kS
 f1qF35SiJrxTpyA6CSLJIYFU3SWMYqF/Org7RkOkbVVuGqUGZqTf3vL1lc5s/6PA079Sc60ZgGx
 ecc9CFFAqlglJJFbg3tvCRHK4H9WtuQxH1YIttSTK3MCZ2nWmolTzsB+LRIV0cuYohuVCZKg3DU
 vIYkoUTfOyexHbXVTEv5LXYbQogVJUCLaf913kM79aH/Jy2OTTZBDToH1humhtv8IV70U/3n0PD
 4yTRdW
X-Received: by 2002:a05:600c:5288:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-486fedc9a5fmr189546925e9.12.1774278532919; 
 Mon, 23 Mar 2026 08:08:52 -0700 (PDT)
X-Received: by 2002:a05:600c:5288:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-486fedc9a5fmr189546555e9.12.1774278532448; 
 Mon, 23 Mar 2026 08:08:52 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe7e2665sm332352025e9.6.2026.03.23.08.08.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 08:08:51 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 23 Mar 2026 16:08:51 +0100
Message-Id: <DHA98WR0DERF.T2XK820FGTF4@redhat.com>
Cc: <dev@dpdk.org>, <nsaxena16@gmail.com>, <mb@smartsharesystems.com>,
 <adwivedi@marvell.com>, <jerinjacobk@gmail.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Maxime Leroy" <maxime@leroys.fr>, "Medvedkin, Vladimir"
 <vladimir.medvedkin@intel.com>
Subject: Re: [RFC PATCH 0/4] VRF support in FIB library
User-Agent: aerc/0.21.0-127-g39acbf663345
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <CAHHRULVmnHih3BqoCnMv-FEj=aC3LehgCFaVhh=0eQ-SLsovXg@mail.gmail.com>
 <22bebf4a-3801-45e9-8ac5-726cb6c89721@intel.com>
 <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
In-Reply-To: <CAHHRULVvLpFpwA-Z8KMuCKmdM24OCeZDrzEMEMs88h2-iqapXw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cbsxnkCgYfFjIXtkTDMbDRUwsOAaoMFbC9dj7tjjMkI_1774278533
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

Hey folks,

Maxime Leroy, Mar 23, 2026 at 15:53:
> Fair point on VLAN subinterfaces and MPLS VPN. SRv6 L3VPN (End.DT4/
> End.DT6) also fits that pattern after decap.
>
> I agree DPDK often pre-allocates for performance, but I wonder if the
> flat TBL24 actually helps here. Each VRF's working set is spread
> 128 MB apart in the flat table. Would regrouping packets by VRF and
> doing one bulk lookup per VRF with separate contiguous TBL24s be
> more cache-friendly than a single mixed-VRF gather? Do you have
> benchmarks comparing the two approaches?

> On the memory trade-off and VRF ID mapping: the API uses vrf_id as
> a direct index (0 to max_vrfs-1). With 256 VRFs and 8B nexthops,
> TBL24 alone costs 32 GB for IPv4 and 32 GB for IPv6 -- 64 GB total
> at startup. In grout, VRF IDs are interface IDs that can be any
> uint16_t, so we would also need to maintain a mapping between our
> VRF IDs and FIB slot indices. We would need to introduce a max_vrfs
> limit, which forces a bad trade-off: either set it low (e.g. 16)
> and limit deployments, or set it high (e.g. 256) and pay 64 GB at
> startup even with a single VRF. With separate FIB instances per VRF,
> we only allocate what we use.

I am also concerned about the global memory consumption. Taking grout as
a live example, we currently support up to 1024 VRFs (each VRF is
an interface so the upper limit is just the number of interfaces).

Pre-allocating 1024 rte_fib and rte_fib6 is virtually impossible.

> On the IPv4/IPv6 TBL8 pool: I was not suggesting merging FIBs, just
> sharing the TBL8 block allocator between separate FIB instances.
> This is possible since dir24_8 and trie use the same TBL8 block
> format (256 entries, same encoding, same size).
>
> Would it be possible to pass a shared TBL8 pool at rte_fib_create()
> time? Each FIB keeps its own TBL24 and RIB, but TBL8 is shared
> across all FIBs and potentially across IPv4/IPv6. Users would no
> longer have to guess num_tbl8 per FIB.

+1 to this. That would help a lot to have a common tbl8 pool. That way
we could keep the single VRF per fib/rib but have a global tbl8 pool
that we can tune to our use case.

Cheers,

