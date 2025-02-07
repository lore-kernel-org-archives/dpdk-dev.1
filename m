Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F9CC02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:47:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A66F1427C0;
	Fri,  7 Feb 2025 09:47:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 271EC427B5
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:47:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738918054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ROa/ObxzFkXFrnU0jjBU6ynUR4c+anJdZq84115Ml7o=;
 b=JwQMfSNg3A9HuQRJgg+VC7geGrZnFUckux7CrfeKUxJmiebT/c964ZsDxRgsQ/qhgEmhkc
 nxPOXmV5u++KhgnwPIH8MXgRXFgTmR8Z5PattewEs1xdmkrGeDx9qZt3cCp/bHJv+pbMku
 rbBJeSQGsHaumvZZ2ird6Nxmi9aIUgE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-Xgpv7xw6NMCv6bIbx-I36g-1; Fri, 07 Feb 2025 03:47:32 -0500
X-MC-Unique: Xgpv7xw6NMCv6bIbx-I36g-1
X-Mimecast-MFC-AGG-ID: Xgpv7xw6NMCv6bIbx-I36g
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5428d385b93so1125333e87.3
 for <dev@dpdk.org>; Fri, 07 Feb 2025 00:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738918051; x=1739522851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROa/ObxzFkXFrnU0jjBU6ynUR4c+anJdZq84115Ml7o=;
 b=Ucs83UuMLFDBwiJU3EEokoXUq5QRXD/RD1MHknBhfYptjAJ/CmLvs30VWZFB5+eqfi
 a8XjWnoAy3JIR0MuO+RvcwtvQ6m8URze0xfm5JULjDtsLkzlvGQjSSZ6ayY5kDi7JWTf
 yTLlJFGZjm1fBpHCQETGuBLjyprj8lct1sVz5BCd5qgItYviVDENhOgYboWyyX5N/WFw
 3xbSJpM/YgT9oShiq+t5rmAI7gZtLFVqOd77G2LjhwDhLfBaGi+Tp4B3x5XoWpudp/6i
 41kOads4Qgrzt0g/PkQP/QxKYoZY1Rs0YbfFKq5Fh8RssVFkwlj/Fqm2mlFhhep0Auv6
 3pvQ==
X-Gm-Message-State: AOJu0YwOuaHE6lu/1Fd5HUfP7dx3ttmF5uQBYHLpsUoQtsujYTZ20wyo
 BTfsURlOr16Bbr9eVp02prm9MEzCIM2XhexYcL2W9OSIgitvymIeL8wuzQc7l4m+3eTCXmkWpc9
 NooR2D1+30lrH2fYBIFrGTsO56M9rFiFJZs1cmi26KsDPLt9CDnCasis87co6corotFh8ld+ScK
 6DAo2dpLTULjjSLmo=
X-Gm-Gg: ASbGncud3y9T4QbuLO5kCxL2T+90gyatUCFl/wScA89/rutphR4J6pXm2NtY+M7sqQ7
 WuaNqW0GVkUOQudTks6dXaYVIg3Lzicbafnl3cgQf2z253lAjNYEyllQOmkA0bycb
X-Received: by 2002:a05:6512:1247:b0:543:e3d5:3d3 with SMTP id
 2adb3069b0e04-54414a96477mr584506e87.9.1738918050817; 
 Fri, 07 Feb 2025 00:47:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJcIJqVUoWMKBsi8tonTvPgA3LCGdwKcKqa1whb0tWM+9QlVmxotVBZjot1cv7PuCLEk8/ug5C5TcL9F8q/dE=
X-Received: by 2002:a05:6512:1247:b0:543:e3d5:3d3 with SMTP id
 2adb3069b0e04-54414a96477mr584497e87.9.1738918050430; Fri, 07 Feb 2025
 00:47:30 -0800 (PST)
MIME-Version: 1.0
References: <1735009552-31906-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1735009552-31906-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Feb 2025 09:47:19 +0100
X-Gm-Features: AWEUYZmnFMjWoq1YsmkGfLHbZz8tShB_din-0JkFrBJpI5UBlavupe102MiuEFU
Message-ID: <CAJFAV8z6enOtK6kU+EOEELjWS1N_dk8odHn67B1mrA=2BPxfyQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] use portable macro for weak linking
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0n9Pc8_HRwzXLDbAwlVPomyuv8orDbaQBSCp-Zw_U44_1738918051
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Dec 24, 2024 at 4:06=E2=80=AFAM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> MSVC uses pragmas to indicate weak linking, so the old __rte_weak
> attribute needs to made into a macro so that the same syntax can
> be used for MSVC and other compilers like gcc.
>
> Andre Muezerie (5):
>   lib/eal: add portable macro for weak linking
>   app/test-compress-perf: use portable macro for weak linking
>   drivers/bus: use portable macro for weak linking
>   drivers/common: use portable macro for weak linking
>   drivers/net: use portable macro for weak linking

I am not a fan of the weak linking stuff in the first place.
Reading the code with __rte_weak, I always wonder which symbol is used when=
...
I prefer explicit linking and no duplicate symbols end up in the binaries.

I posted a RFC, can you have a look?
https://inbox.dpdk.org/dev/20250207083252.3131588-1-david.marchand@redhat.c=
om/


--=20
David Marchand

