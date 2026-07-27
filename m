Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E535AC5321C
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 07:20:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF10D40297;
	Mon, 27 Jul 2026 09:20:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 899FF400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 09:20:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785136836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f3bFzz3hSBQjToNQfrCA0BukSk/ZmlWm41vj0ef1RQE=;
 b=iRhqr9RT/xv+JNPp/ULPVT7R9UiuKBlith+peAte5rbJlRiGLUeGR4HmYoEsgxIYrcZSDn
 sFKXpheHzyged99Q6EY9flRebCthOyi71fnNb+3KNePfsGp7EcTsxOyqOt4/sZZBGqrDoK
 FRocBxmQx683lU3cLTC7EpWl2iIKLpc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-05vefS8PPAyUzi1zdT0DZg-1; Mon, 27 Jul 2026 03:20:34 -0400
X-MC-Unique: 05vefS8PPAyUzi1zdT0DZg-1
X-Mimecast-MFC-AGG-ID: 05vefS8PPAyUzi1zdT0DZg_1785136833
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-39cbf7e087eso10863531fa.0
 for <dev@dpdk.org>; Mon, 27 Jul 2026 00:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785136833; x=1785741633;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=f3bFzz3hSBQjToNQfrCA0BukSk/ZmlWm41vj0ef1RQE=;
 b=ISLF3pNwg8QPiEIMLwirkmssJJB3uLniNlh+EYt3B4LEKh1/h0lducPGGIg9sv1T1x
 +WnTMKYJaRfMpH+CG/rwNYBk0V8oKKNQTUsLaIZz8Vs1GL4sPe+6TioxY0I6bxV8qLgA
 oBqpheyHHTwFD4ZoB2iDvI3lSgFTB8zkCWqaeOVt7Ni8brIbHLXyfalo+LgxZxSX6dVS
 ZHx1ExwLm+caXu05hIVftFDSqV5cyiTDETzRgOK+BI6QhtKAIfcJsDXDQ6R6cx33L1iJ
 o/FWbZneGJb4mOQz/1o5zLguB52syZanAaqAEQqfIAWUe+JXbW8pgf7GNLtSPSqoTxwO
 F2Ow==
X-Gm-Message-State: AOJu0Ywgr5DpT4bixSGxmK/l5QeglA5NuWGFLrz7jZfdlzOZWNhKwccI
 lumgcI6c41rS3YPrMcYW7q6FWpRVCCV43r+w3sbkO9Yk0lVsFXqCClMNDhmS+lsM3teDWiyARhb
 iB2SRLW1jmrG24BEQ2Fblz+PqiDJI0hQKYKc5NULlRp7sVsvzDwdeTD0GVXE9pKRGHLHfUCTNsF
 BlJv5DHjzviyc0EHGE6IY=
X-Gm-Gg: AR+sD133Y6ldJ2Vg0w8ipvQv6TFTJWNYeyMNObI9rFhj1CjmNxO7y9uPeKPJpur45fL
 6TM9DaS31GeOCXstyaxIviRyVwFDnvNzwRvogv2u/sxd5c0gcyRKGRe/5l9iK9pZ5Zp+fTU2mcd
 BdJH54PH9XRPBwPgpGZXUTAeOSgnIxfHdILrl2pVEs754x8fhAJZKECtEfr+HVipLH/OaoYl4Vz
 3XZuwVviCUXikMU8tUOeDZ+6nIOemVs5UMmeqZFUSfAXU06
X-Received: by 2002:a05:6512:12c2:b0:5b1:59de:8987 with SMTP id
 2adb3069b0e04-5b2c1b029d8mr1433488e87.16.1785136832934; 
 Mon, 27 Jul 2026 00:20:32 -0700 (PDT)
X-Received: by 2002:a05:6512:12c2:b0:5b1:59de:8987 with SMTP id
 2adb3069b0e04-5b2c1b029d8mr1433483e87.16.1785136832483; Mon, 27 Jul 2026
 00:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260723124200.3069410-1-david.marchand@redhat.com>
In-Reply-To: <20260723124200.3069410-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 27 Jul 2026 09:20:20 +0200
X-Gm-Features: AUfX_mxCT0-cTnln5qdP_P2U42uhKcNj3rShS7Zl-g9PGC2ZyFRj5bMTpe2N_oE
Message-ID: <CAJFAV8xon4iF5sweFHCkOup-sqBAhC53dr7Qj+U=soLsaBkqYQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] Remove limitations coming from legacy VMDq
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iEYWmw6_GcXgpOmDVrNMV1pN6-NbfZT-lk_ftdpRniM_1785136833
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

Hello Stephen,

On Thu, 23 Jul 2026 at 14:42, David Marchand <david.marchand@redhat.com> wrote:
>
> Since the commit 88ac4396ad29 ("ethdev: add VMDq support"),
> VMDq has been imposing a maximum number of mac addresses in the
> mac_addr_add/del API.
>
> Nowadays, new Intel drivers do not support the feature and few other
> drivers implement this feature.
>
> This series enforces that the driver announces VMDq pools before
> using VMDq related features, then remove the limit of number of
> mac addresses for others.
>
> Next step could be to remove the VMDq pool notion from the generic API.
> However I have some concern about this, as changing the quite stable
> mac_addr_add/del API now seems a lot of noise for not much benefit.
>
>
> --
> David Marchand
>
> Changes since v4:
> - rebased,
> - moved mac restoration in dedicated IAVF reset helper,
> - fixed inverted arguments when calling mlx5 mac sync,

If there is no comment on the ethdev changes, could you take the first
3 patches?

I'll send the IAVF and mlx5 changes through the relevant subtrees.


-- 
David Marchand

