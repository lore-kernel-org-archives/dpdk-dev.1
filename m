Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38749CA6012
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 09:52:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D037C402D0;
	Fri,  9 Oct 2026 11:52:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7D0C140281
 for <dev@dpdk.org>; Fri,  9 Oct 2026 11:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791539576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IqCD3BBtgsp8SUaW3JB91JDnqJE3Bdwi4IwB1Hir/TY=;
 b=QxzSuWji2cD4wVr4HU50nXdc0HXSsKrVHCcH7ogCljedGC81JsqYB2KfzDTs2dagoi0YyR
 +TH/bIf/pQ8BRd5jliN3my2dbd/Ih/whdhZlDb65AzDA39RRvWw0ut3w+8Hnz6Eh1+h2/S
 8iIUSQz4on/HQYV/xR+SyNdqTIBKoPk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-rAuzD-vEOPi8C7GtTrFRYA-1; Fri, 9 Oct 2026 09:52:54 +0000
X-MC-Unique: rAuzD-vEOPi8C7GtTrFRYA-1
X-Mimecast-MFC-AGG-ID: rAuzD-vEOPi8C7GtTrFRYA_1791539573
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so49539875e9.1
 for <dev@dpdk.org>; Fri, 09 Oct 2026 02:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791539573; x=1792144373;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IqCD3BBtgsp8SUaW3JB91JDnqJE3Bdwi4IwB1Hir/TY=;
 b=Y04/t2yx6aKncu8G1w7l0ZTohZdkyn4Gf/55nJUR+YkR//S0sx/a5dlNPnQDCyxO30
 IbEXDhF22z0cdzA1Bo+NpvRDWnlZUnazeNnRtCT5JiZ2FuzPdJxyWM7vrGuXMxr7VvFF
 TserX7yvi1WEQkFUjFDuz4STGCfHCd+K3zJwkCHN/r0gAtE2dCCPzKBL6O5FDmmDshZI
 N0ifrt2Ye1NDwMnAlgqpI7or7jvFLOfr0voQl0KD0jhtcd6+HcHdITVu6jwQ3M1johZD
 497rWZGjxU54AS2Ka+kxzFwLH2AuxbRoI3eQWIUfpNEUS3ylASCm05R21ipsu2Tts+Js
 7VIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBtLCUNue+wZOKYspnnOxzpz/yOD/vIP7FEpN8G0dXjJd9zpJ0tgbhayoYquvCkeT8isI=@dpdk.org
X-Gm-Message-State: AFuF++kYFR3RMiqB60kQP5p3H2p7FeePjj+q/MuFJ+zeliJBYD4l9ANc
 u5VPmNF+cEL6momkeySoiug9ZrDQFxUwuKcBBDHyZIy6HWkMjaGT12DIBAexDFdmRN5MQqFUVz4
 AT8KCq+ruX2NsxLlvRa8vUENX1xTDyUM6UnSFMUdqfbOT
X-Gm-Gg: AYBFou2cyyKvjpQP3Cam8UtoDecwxd1uP7MMAJ5maLkMxkax1qjfNfGh2tN6s4w8wyR
 qica2KS0fN5vOoosQ1/0yLUHrh91xakREEG4eifRTVt03Bqigeg3+8zJJHrj39I5S5yXnIiLLxR
 VXKFHh5mi5OEo69d+f+Az1ewI+1WfLXLXiAKaIY2UrRdWSKYwcBl1jD+72w/DpWpFm0PlYc1H2Q
 SbjvR464KjVh57asf/3unbfcVkdYs9mdGmS0473rzD3p77qmbb/UAl0wSOf7+avPvoulxaQqlMP
 Yrt0eMKl0DrxL83lwXCcGUNrqAuYHAK5G0STbWGeGkSUT1QQ/N48fKm69EpyLCxj5uEVm6xviNm
 MfxC1/uIEkTZFFMgCYtf9otGMSxcAjVI=
X-Received: by 2002:a05:600c:e557:20b0:49f:dd9f:6038 with SMTP id
 5b1f17b1804b1-4a18e4bff94mr15013695e9.25.1791539573336; 
 Fri, 09 Oct 2026 02:52:53 -0700 (PDT)
X-Received: by 2002:a05:600c:e557:20b0:49f:dd9f:6038 with SMTP id
 5b1f17b1804b1-4a18e4bff94mr15013455e9.25.1791539572849; 
 Fri, 09 Oct 2026 02:52:52 -0700 (PDT)
Received: from [192.168.0.66] ([78.16.64.30]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf1358asm50092365e9.4.2026.10.09.02.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 02:52:51 -0700 (PDT)
Message-ID: <4849aff4-5c19-4676-b94d-f8ad393cecbf@redhat.com>
Date: Fri, 9 Oct 2026 10:52:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma/idxd: remove experimental on whole driver
To: Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>
Cc: Luca Boccassi <bluca@debian.org>, Thomas Monjalon <thomas@monjalon.net>,
 dev@dpdk.org, stable@dpdk.org, Conor Walsh <conor.walsh@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>
References: <20261008154351.387445-1-bruce.richardson@intel.com>
 <CAJFAV8zdGwbqmKa=oFLDAJWv=7_rRZ1zBy_gtk_=C5NCOUsPvQ@mail.gmail.com>
 <asit1s5cdr_rqCqy@bricha3-mobl1.ger.corp.intel.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <asit1s5cdr_rqCqy@bricha3-mobl1.ger.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v5rxd_LRYBP8W9scilSJ4J_B3Bx1rQ0rCc2MV4LmrT4_1791539573
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/9/26 10:03, Bruce Richardson wrote:
> On Fri, Oct 09, 2026 at 10:55:49AM +0200, David Marchand wrote:
>> On Thu, 8 Oct 2026 at 17:44, Bruce Richardson
>> <bruce.richardson@intel.com> wrote:
>>>
>>> The idxd DMA driver was marked as experimental in MAINTAINERS file.
>>> Remove this designation as it's been stable for a long time now.
>>>
>>> Fixes: e33ad06eaeeb ("dma/idxd: add skeleton for VFIO based DSA device")
>>> Cc: stable@dpdk.org
>>>
>>> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>>> ---
>>>
>>> Putting the fixline as the original start of the driver implementation,
>>> since there is no good commit point to use to identify the stabilization
>>> of the driver. Since this change should be good to backport to all
>>> currently supported LTS releases, the orignal addition of the driver
>>> works fine as a commit being fixed.
>>
>> No opinion on the backporting aspect.
>> At least the driver looks stable for a while, so the patch lgtm.
>>
> Given that the driver has been around since 2021 and the oldest supported
> LTS is 23.11, I felt it worthwhile to backport. However, if LTS
> maintainers want to avoid this patch, I'm not too concerned :-)

We're saying the main branch is non-experimental _now_ but it has 
diverged from what is in LTS branches e.g. [0]

I think it would be better not to backport this patch to LTS as the 
driver was released as experimental in those releases and the docs 
reflect that.

That it is changing in main is positive :-) but it doesn't seem worth 
evaluating each LTS branch and backports (and any other code context) to 
say if could now say that about the LTS branch too and retro-fitting the 
docs.

[0]
main branch:
$ git log --oneline v23.11..HEAD -- ./drivers/dma/idxd/
47cdad82a1 eal: improve pointer add/sub/align macros
11e237109b dma/idxd: remove next pointer in bus specific device
fbd34e543e dma/idxd: remove specific bus type
be29c42523 bus: implement probe in EAL
76622feba9 bus: refactor device probe
2267d1c26b bus: factorize driver lookup
89127f66f5 bus: consolidate device lookup
b4f0974a99 bus: factorize device list
3e1681fe47 bus: factorize driver list
53045e1e5a dma/idxd: clear device at scan
bba2dca922 bus: factorize device selection
e2287bb112 bus: factorize devargs lookup
ab797d5bcf dma/idxd: mark portal pointer as volatile
62516462cb dma/idxd: use DPDK basename function
fedffb112f dma/idxd: add device ids for new HW versions
fd51012de5 drivers: use portable variadic macros
aa8ed903d2 dma/idxd: set GRPCFG traffic class for better performance
91b026fb46 dma/idxd: fix free function mismatch in device probe
2b843cac23 drivers: use per line logging in helpers
f665790a5d drivers: remove redundant newline from logs
d569af3d4e dma/idxd: fix setup with Ubuntu 24.04
e12a0166c8 drivers: use stdatomic API
27595cd830 drivers: move alignment attribute on types for MSVC
83cfa2cbf3 dma/idxd: verify strdup return

23.11 branch:
$ git log --oneline v23.11..HEAD -- ./drivers/dma/idxd/
5fe3dbe571 dma/idxd: fix free function mismatch in device probe
e56ba1eea6 drivers: remove redundant newline from logs
7353cb767f dma/idxd: fix setup with Ubuntu 24.04
df74839ea1 dma/idxd: verify strdup return

