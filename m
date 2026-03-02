Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2516DD58E73
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 08:03:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C9B740B9A;
	Mon,  2 Mar 2026 09:03:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id D2207402B0
 for <dev@dpdk.org>; Mon,  2 Mar 2026 09:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772438596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R+3oZvTHX9D3c9IxsKEB5bBMD8VKzPfZSWhmQLmfG20=;
 b=D5p3jCWwqJONSF5JO5j2cNN0wb9HMzGi+SBj+gkECoSFv74aBGvNW+357C3h89g98ycImR
 cUKrLM9wmFZcWsgY9HcFczOckj74hmwPi8Ju0yagDp5iUGDnugHSK7hhiKeaqgw4rS7SlI
 ZM4PdDQYNCvnQ6IJL206fJd6FIU2r7A=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-i-8wb3ikPROaUKnfRcJiQA-1; Mon, 02 Mar 2026 03:03:14 -0500
X-MC-Unique: i-8wb3ikPROaUKnfRcJiQA-1
X-Mimecast-MFC-AGG-ID: i-8wb3ikPROaUKnfRcJiQA_1772438593
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3884fe7ace1so41433331fa.1
 for <dev@dpdk.org>; Mon, 02 Mar 2026 00:03:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772438593; x=1773043393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+3oZvTHX9D3c9IxsKEB5bBMD8VKzPfZSWhmQLmfG20=;
 b=Vda+EVDzx0NORTy9PrgUuPrKGl92i/ZbQh+WPmgZuWUVTqE7lIula687hw3GFarq8w
 jj7LLDcGQMXUfW4Czv1srvlp9ar8E5ZE4e+cS/vC3xL9kEwlsZ3mXBnu/86kpuKLsDwT
 lbH2CBYcrktjl8fJILL52ibmDNXwYj0TwNtPZdasJlwbebM4jqgy80Rw93JH1zSsmZ88
 3A13rL0SH0Ap6x99TRxcCMBZj8exMccDvlrXXbCOGDHQtnxqCgWaMIgOg0HM9k0xgmy9
 r1L0gg9LQFeqNP63iIYiBb+InlFMdv5CyiKG9qYPqEggOaGN7j8HQUJ7O8jOUkqnlKgs
 T4Bw==
X-Gm-Message-State: AOJu0YwIjCgqvTMYtNs8e//TPg74FVxomYJZWWo5kORcaJXENlOBn8uM
 oAf0ryiXJMrJDWSPMdYwoSA355nsf+2VL8dVe90MSH1ymEDUx1FqocIf4//Ct0FZjyXIv0K6i9h
 WLP1ghxPXmUzMTDrU3jZUrHqMJMdulG51LoOGX7msZVZOefDcX9YYi8avQEiKSK+Nmahyy+udDp
 svpY5nZ6AXIHmVaBDhjLc=
X-Gm-Gg: ATEYQzzuXPODfkOfsUtjhRt+nqVhI0snJ2nzgRABAD4Wr0omcTQBHLMsDWLfrrel8b4
 /HoNZScp79P8Y2DJh0ShXlmDMO3+ZAbLwfJ7jHNsf+O41FEIyfwiHxVizTiTz4L3UMFae36iec1
 ZFJ+HqAmWbDH9abJKntk53+mSWZv6gwtk8yhK9CQl+ahm0VlcyhWLVra9fEZYhrLIRYwGWbCS9M
 uxmlOUX0gQKrp7kvV0ooTtum6klAwpK01ZLjxGl6ebjoNw68+j8HGMMaMjbD6RMy+h1vw==
X-Received: by 2002:a2e:7016:0:b0:383:1ca9:bd81 with SMTP id
 38308e7fff4ca-389ff137299mr46003531fa.12.1772438593070; 
 Mon, 02 Mar 2026 00:03:13 -0800 (PST)
X-Received: by 2002:a2e:7016:0:b0:383:1ca9:bd81 with SMTP id
 38308e7fff4ca-389ff137299mr46003421fa.12.1772438592589; Mon, 02 Mar 2026
 00:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
 <20260301020726.852401-3-stephen@networkplumber.org>
In-Reply-To: <20260301020726.852401-3-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 2 Mar 2026 09:03:01 +0100
X-Gm-Features: AaiRm53iF_Oifv-dSo8jbG-ENurnb3Do9SHYTwg-YvRuWYRtNaQvi6KSDL8W7bA
Message-ID: <CAJFAV8yoFP-HLLEjCuc4DS59mawbRTuQHDRt=2ARtSDurcgTHA@mail.gmail.com>
Subject: Re: [PATCH v18 02/23] net/pcap: fix build on Windows
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>, 
 Chengwen Feng <fengchengwen@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AUbARb9evsIoCjGK83LSJP0HuTEw58joDEVxWBUPG1Q_1772438593
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

On Sun, 1 Mar 2026 at 03:07, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> The log messages in the pcap OS dependent code for Windows
> was never converted during the last release.
>
> It looks like the osdep part of pcap was not being built.
> Building requires have libpcap for Windows built which is not
> part of the CI infrastructure.
>
> Fixes: 2b843cac232e ("drivers: use per line logging in helpers")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

