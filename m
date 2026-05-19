Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608B1CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 15:03:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A002E4065F;
	Tue, 19 May 2026 17:03:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3FDA440268
 for <dev@dpdk.org>; Tue, 19 May 2026 17:03:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779202987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8lV1JzAPGsB6fNOPx8Pcn2Cl+qQ3YVu/I+xnnI60UI=;
 b=dwWHjPDLw3WfmPWEh0qMVwe5mMegFD1q2loVIVUu3Nx0V04coIDhuPaP7sdHwDo8pdG1KE
 5nFvja0C7P568AkYgkZij3fgLSJ5yxzPYbY5zKXIzEixZemWt/a2gSO5OIM8QpmLHN5C4p
 ua0Psxb4U3At8BRz5OaMDHhD9Q1QHfc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-XuZzyg4VN-eGoQce_IWa1A-1; Tue, 19 May 2026 11:03:05 -0400
X-MC-Unique: XuZzyg4VN-eGoQce_IWa1A-1
X-Mimecast-MFC-AGG-ID: XuZzyg4VN-eGoQce_IWa1A_1779202984
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-393f10a36c0so16796841fa.0
 for <dev@dpdk.org>; Tue, 19 May 2026 08:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202984; x=1779807784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8lV1JzAPGsB6fNOPx8Pcn2Cl+qQ3YVu/I+xnnI60UI=;
 b=GeqjX5eXhbXfls/X8NV7Lo3VN5WQ8MFwKsOaPHnxgIcxIlpepHr3lJc7sczLP97pe2
 iCSHS6eAlKYjW1kZdzEevsDAa1L/dRdauieIQTg2Zo5wcaM0mMM/YWyhj8KKbDqRjifL
 U9dFbnKhowk80Tii+VKqXkQA6hMxFKbcHW81T4Ov+XleOUCUR3+r1HFkct5Eea/8hU5z
 sCeZaM1OeMjEAEnbLMvf6cKXL4X/5ZmDFXwho7xa8s73ODZxiZCT+mlTK2RG+4mlDYTe
 v66q0jplUqMeTtUTPqNhovmBov+1aaWTj4G8CAVDrjIUsq704w3B3/FRQ7JhC5hB8LXg
 s9jA==
X-Gm-Message-State: AOJu0YyS/AfDDfBW+H/DgOXqHsocHzfdJdD0r50CWpprCZLUGeACV4Wf
 rmgepRnuRUjaQyf9wwNLdzJM6S2HIHeuC8oYKDi/Y2zXKFUaP7Lqh2MKaCJoFgdZ3zGnV4RLwVU
 A/NsP/LGb71l9Eobx2FHKoJcQtASad9Z1MgFZInnSdMgBNI5QQ9oUri9DCC+1wTufBt5Xz93uKm
 cxzAYxZImZCtVjF7HCXzw=
X-Gm-Gg: Acq92OGNj1PJiTTILT2vRsp4U1taUzTVDoSS5yQewYBMwcwkG6+wDZTUdkTIaoaOAAM
 ucGAlpC5T3FrvsmbVGj4//DYVTP9KMCIWLzgHAcLR697atckoSG7fs1pQ55g6w+1ZfyXxRxehX3
 naIu4YmfZaQyAUBCndUUfstV99D8GCOoSTZb2RO/7AyMZslRl5lUtZsh/0AMMAdDp2iEaW3ZBnc
 jI9hS7J3OuyMcmxlM8tCJNNHDmHa+reMzGxrbJHOpgSTgLr/Ad702R22N4AYPldBgMNGQ==
X-Received: by 2002:a05:651c:1143:b0:38e:d870:1db4 with SMTP id
 38308e7fff4ca-39561f48e4dmr54248951fa.22.1779202983556; 
 Tue, 19 May 2026 08:03:03 -0700 (PDT)
X-Received: by 2002:a05:651c:1143:b0:38e:d870:1db4 with SMTP id
 38308e7fff4ca-39561f48e4dmr54248661fa.22.1779202982856; Tue, 19 May 2026
 08:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <20260519103640.3986710-1-thomas@monjalon.net>
In-Reply-To: <20260519103640.3986710-1-thomas@monjalon.net>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 19 May 2026 17:02:50 +0200
X-Gm-Features: AVHnY4KrEzOA_BOiJzIsIsQycxQuttiCtdvVWr2csW4L9dP5u_NE7hM1F8fNhS4
Message-ID: <CAJFAV8yj1BVE9ArYG8hY4bAB_3JDsAPCAc6bwaUYV0S2F6nEAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] spinlock: remove volatile qualifier
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, Robin Jarry <rjarry@redhat.com>,
 stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TyMhIK-dqoc2Bl_LmpDvhujxNEs41n7Q5BhBnJ_AvlE_1779202984
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

On Tue, 19 May 2026 at 12:37, Thomas Monjalon <thomas@monjalon.net> wrote:
>
> When compiling with C++20 standard requirement (default in GCC 16),
> the increment and decrement of volatile variables are rejected:
>
> rte_spinlock.h:241:14: error:
>         '++' expression of 'volatile'-qualified type is deprecated
> rte_spinlock.h:252:21: error:
>         '--' expression of 'volatile'-qualified type is deprecated
> rte_spinlock.h:278:14: error:
>         '++' expression of 'volatile'-qualified type is deprecated
>
> The count field of rte_spinlock_recursive_t
> does not need the volatile qualifier
> because it is only accessed by the thread holding the lock,
> which already provides the necessary memory ordering.
>
> The user field can be accessed outside of the lock,
> so it must handled as a C11 atomic variable.
> The name is also changed from user to owner.
> It will break if an application is accessing this field directly,
> which should never happen.
>
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Series applied, thanks.


-- 
David Marchand

