Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15772F3D32E
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 16:29:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 095554029D;
	Thu,  5 Mar 2026 17:29:13 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8DF2D40287
 for <dev@dpdk.org>; Thu,  5 Mar 2026 17:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oF5pDQL1sN28kwB4Ty/vomymCuMzywhZFyawyECqj2o=;
 b=f8JikKUd4k4Ekk3mcBnHU79mTmSxxVFM0M7FD7zFU3u9lSdq/Gb5rJhoKkjuFjqayBhH/O
 0oKlfbxGYihed+3zzbLRISLoFChMfSJfboGXiH0s7ic0lMC5eoUrL5sbM2SbYMkc7m1rnt
 50FYrXY8ZFypbGKAUAxXkfTX5mu98Hk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-CXNd7QxRNY--0L0XXGNxQg-1; Thu, 05 Mar 2026 11:29:09 -0500
X-MC-Unique: CXNd7QxRNY--0L0XXGNxQg-1
X-Mimecast-MFC-AGG-ID: CXNd7QxRNY--0L0XXGNxQg_1772728148
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59f8dc94e84so1416367e87.0
 for <dev@dpdk.org>; Thu, 05 Mar 2026 08:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772728148; x=1773332948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oF5pDQL1sN28kwB4Ty/vomymCuMzywhZFyawyECqj2o=;
 b=B429AsVYMmc4GZIXilow/uE/889XAwU8rqyjr2Aqn4BvfFfIrj3E6jTIW3RnfZuHHZ
 H9xmnfRmxOfoqRXZe/755/tx4GEMf1Fow1sOrbnu62OYGqjtPWINAB3u9TgEfgvKPtWB
 K+aralyQ9tNLV80sG9YKk5DCqxzg+62k9qqC/rHWqtnrIFiRlidj2KOyFjEFIP08rqXJ
 gfN3HBU2dvLLqsYvkExBPBD6zlcDNwy8DFDdBzeS3Fjv0q6klOZnfno23wcErATa9YQD
 o+OZmIFFUkSD8DuKXhH9T3PpgdNNsdOq6L2kWNC/xB+zCwwN+TCte2QLgdcqEtEs3H8w
 voiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSDggDwbgK3o2nvLIXSiJsuJBfsKVieBkVFPk1NkqPlkCNxdQlp799iwmzllvALiO2Y78=@dpdk.org
X-Gm-Message-State: AOJu0YzinWd/SkpL8cyoG2FgosrO4bg5orlwH9cQAb/ppsWoruZqpM/6
 RqYkyC6GPRVpDOS8GkKzRc/MbS4LeqvLHvdulZMan3Kp0V8KIrp47s65Y4OxNMLUrjdu+MVxwHM
 o3m3E0h7eW0+/Qpl5pM4mNaQqDt5WlcUj4WoTannBUVOgpyON1nWUEHFq7OY2ukh0Q6DdBPHbMo
 B/J3vAyP3xrIqH4lR7j1Q=
X-Gm-Gg: ATEYQzyYpFJC8tLk71hEP40FbAue2YaaLCdkE1VgnkKfUUx25ZZi5jkAxou3/AzaRLs
 ltWJ4+jlOK3GGXQWiAyjcFFTiNUTEsdkVmPhkY5CJip0bzvEPVtSeqt+jk/WfMTLI8HbqV0A5rH
 O8m3mh4ovCPB75sk/2pRmMl9i/WZNio60rfGZ75UeVXw/X/1ljvhjzjfYhZAIBzDPfh1rwOXrFv
 yGi7WY70/OQ7grNlD+5weeIJp+1CdWcCoU5N2qlar97LU5rWUFw4o67CHcgB2VvnWRQig==
X-Received: by 2002:a05:6512:1596:b0:5a1:28f2:bbe2 with SMTP id
 2adb3069b0e04-5a12c2aa483mr1352963e87.36.1772728148076; 
 Thu, 05 Mar 2026 08:29:08 -0800 (PST)
X-Received: by 2002:a05:6512:1596:b0:5a1:28f2:bbe2 with SMTP id
 2adb3069b0e04-5a12c2aa483mr1352947e87.36.1772728147604; Thu, 05 Mar 2026
 08:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20260304070605.1150502-1-2022302111412@whu.edu.cn>
In-Reply-To: <20260304070605.1150502-1-2022302111412@whu.edu.cn>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 5 Mar 2026 17:28:55 +0100
X-Gm-Features: AaiRm52V-84muK_nFSO3o7YEPEeHfxWhJn89Z0mpV_K2unjtJlww-U5lSuWAngM
Message-ID: <CAJFAV8xaKHKhERrgeNhP6D1WzsKxAHkEmPNtW56_jY-15T=6Hw@mail.gmail.com>
Subject: Re: [PATCH v2] efd: lookup with RISC-V vector extension
To: P1erreCashon <2022302111412@whu.edu.cn>
Cc: Yipeng Wang <yipeng1.wang@intel.com>, 
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>, 
 Sun Yuechi <sunyuechi@iscas.ac.cn>, dev@dpdk.org, 
 gong-flying <gongxiaofei24@iscas.ac.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T0ZAeIwnAIEajdxQ5wiyPSeuvasTvqifF1R5Ttnoaos_1772728148
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

Hello,

Thanks for the patch.


On Wed, 4 Mar 2026 at 16:17, P1erreCashon <2022302111412@whu.edu.cn> wrote:
>
> Implement EFD lookup internal function for RISC-V architecture
> using RISC-V Vector Extension instruction set
>
> Performance results (EFD perf autotest)
> These performance results are the average of five test runs.
> Results (in CPU cycles/operation):
>
> Before optimization:
> Keysize           Add               Lookup            Lookup_bulk       Delete
> 4                 136.0            5.6               5.0               25.6
> 8                 149.4            6.0               6.0               31.4
> 16                156.8           8.0               7.0               36.8
> 32                179.2           13.0             14.0              45.4
> 48                205.8           13.0             15.0              45.6
> 64                214.4           16.0            18.4               46.6
> 9                 152.8             6.2              6.0               30.0
> 13                160.6            7.2               7.0               35.0
> 37                191.2            12.0             13.0              44.2
> 40                195.0            12.0             13.6              43.2
>
> After optimization:
> Keysize           Add               Lookup            Lookup_bulk       Delete
> 4                 131.6             5.0               5.0               26.6
> 8                 143.6             6.0               6.2               33.0
> 16                153.2            7.0               7.0               35.8
> 32                173.6            14.0             14.0             45.0
> 48                201.6            12.6             14.0             46.2
> 64                211.4            15.0             16.0             46.8
> 9                 146.6             6.0               6.0              30.6
> 13                154.8            7.0               7.0               35.0
> 37                189.2            11.0             12.2             45.4
> 40                191.8            11.0             12.4             43.8

I am not sure what is significant in those numbers.
For someone like me who does not run efd test, the difference seems quite small.

Could you add more details?

>
> This patch is co-developed with Gong Xiaofei.
>
> Signed-off-by: gong-flying <gongxiaofei24@iscas.ac.cn>
> Signed-off-by: P1erreCashon <2022302111412@whu.edu.cn>

Please, use real names in the signatures, like for example:
Signed-off-by: Gong Xiaofei <gongxiaofei24@iscas.ac.cn>

P1erre looks like an alias.

-- 
David Marchand

