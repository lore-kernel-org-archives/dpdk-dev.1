Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54D606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JqAmpQwq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9FB740298;
	Mon, 19 Oct 2026 22:01:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 501FC4021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 22:01:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792440077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4PKWbzVOXuY3ME5ZvHGlm18CXEmnqu7DPkRy+h4AGQ=;
 b=JqAmpQwq52KjvPoUSGCOVZ8SdR/bJWpAvUwNwsjvwnZD1gnazAyZ3lQ7cbT7YqNu2nM9kB
 jyc3NSK1JeHgb9MhBOmlzxlNgO7j69Dw43+Ajp6zo/cF8n5cAOowZ7UFaUDsyX/HHeYSjj
 iLSOmYVmd/CkZXGUHXdmpoTAnsjwP5A=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-NQ1wX49AMPSYzMfyCdT1dA-1; Mon, 19 Oct 2026 20:01:16 +0000
X-MC-Unique: NQ1wX49AMPSYzMfyCdT1dA-1
X-Mimecast-MFC-AGG-ID: NQ1wX49AMPSYzMfyCdT1dA_1792440075
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-14373747468so1326062c88.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 13:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792440075; x=1793044875;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T4PKWbzVOXuY3ME5ZvHGlm18CXEmnqu7DPkRy+h4AGQ=;
 b=zJl1wjCgsSsaeWDF0Q1vzN/Nlc8N+cd63iDRbNGlV5N90wVAWxDhyZaWH/TeD0OxjK
 omMxGJkTqw0IHq1rLojPOpV3GGmmeSB15Qlcm9vK2pUICo5DNndgG5UgjWYLcOkf2QIH
 /5BHe/WqOyAjB+uuhOBEFBLPlyrAbXevgJFPvF+Fl8Y+exAnH4lZRd6gOXIIigKAWkAs
 V2W1wENKNDDi0H/3UbwE67DdcVFtt4ZwZa1RWVe1wWSJMWUkBpTgL0wXWJuV3KJYDHSW
 NdccdmjjQyHzrk8+cuzwQcI8K8tI27zMJhhzFJj2F8acV34rsu5afaDoHmhcCLbWL1Rr
 QUnA==
X-Gm-Message-State: AFq9FYLmmLmhlNDoNYQk8dYSsXdNYmIQrRaDndB3ZVvqiLwCgVIkTyiw
 NhsViQtG9HNY6NwdMeRwALvehZXMpmwQjTKuaGsCsJymYnPA1uk2/nmg/knJNMf99IuOPaOAgu5
 yoKLMMPISw72UAB6S2l5H2Om3MAkSktZdmDRlFd3yeXIyLDRC0EeAmoVCFTlbXGkn4GBswk5WNk
 MB0sWsdNJ4FSX+2yX0b9Y=
X-Gm-Gg: AYBFou1gc2KiXPieW8pr4KiEE0SUJSSeeTbIXc9albm0MrsjQTm5cgTVEE9SchD3kzi
 rRIOM04SvGdZTWOuFZ57APxSAyAL8G+6vgVm6xromQ8m4igZbdTpCuIB9R0SHFS0qyY3fbaFDBG
 OSzCH85SHw3JMgvEYH+w5rgO7vkuyjZfUdTrsFMMLEbD7CMszz00ImI61QoNZdzkndKy3SdX12N
 rDE11CCARFmIfGNQaSHlXSZ7XPAhERvf8WX1MZD1PBrvAuECE6TmPhJs2bWnhMo2uJX6hzdmjvN
 O1segt4YgsgIO7rJ+aifwoVeKpZUQu/j/E2cqTe8NJc=
X-Received: by 2002:a05:701b:2807:b0:14e:7162:2ab3 with SMTP id
 a92af1059eb24-185120a8369mr10999150c88.8.1792440070423; 
 Mon, 19 Oct 2026 13:01:10 -0700 (PDT)
X-Received: by 2002:a05:701b:2807:b0:14e:7162:2ab3 with SMTP id
 a92af1059eb24-185120a8369mr10999111c88.8.1792440069779; Mon, 19 Oct 2026
 13:01:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260918165133.1945089-1-bruce.richardson@intel.com>
In-Reply-To: <20260918165133.1945089-1-bruce.richardson@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 19 Oct 2026 22:00:57 +0200
X-Gm-Features: AclHuK8ASANlamDQ6-C64YuxJ9AdTMncDCEbyh21xziuFk8jLsac4_GFzNr2e54
Message-ID: <CAO55csy5OvKxiW3E6kTMeRxzTLaQvhtwQRNa+y_ByQP7A10arA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/ifc: fix argument parsing
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, stable@dpdk.org, 
 Xiao Wang <xiao.w.wang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wcfub2eiooREeFrcjASjyRCjxHqVHcVYO67_0hhAhk0_1792440075
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Sep 18, 2026 at 6:51=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The argument parsing in ifcvf was storing only 2 bytes to a 4-byte
> integer value, leaving the int possibly with garbage in the top two
> bytes. However, despite being an int, the value was actually used as a
> boolean both times something was passed. Therefore, fix the bug by using
> bool values and change the arg parsing function to match that.
>
> Bugzilla ID: 2040
> Fixes: 40ef35f4a504 ("net/ifc: detect if VDPA mode is specified")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/vdpa/ifc/ifcvf_vdpa.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>

Applied to next-virtio/for-next-net.

Thanks,
Maxime

