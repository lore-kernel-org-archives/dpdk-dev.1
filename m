Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA11606A33F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DgKT0Ipx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0B124026F;
	Tue, 17 Nov 2026 09:50:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id B62CE40041
 for <dev@dpdk.org>; Tue, 17 Nov 2026 09:50:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794905413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VPNwuSkSoUHgxCsMFKb6H0ztS8LZ0AxmJoHNYtlGD0I=;
 b=DgKT0IpxzEN30g4nZCuJ3ZPnuqTV1sTVPjn97N3Lu/O8GPTYQ5C/147SZDGTTjXHw1PmIZ
 ++yAKZsXZR+cQTAMY7P1HGXyHPVN53jy6uTC8K//d14QNmZYpWWNyRih8Alf2Beic785xI
 Mo5MdZdD5852o4BKyE2w4x9zh02SLpM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-8x6ljltBPvqzedA9JXLhRQ-1; Tue, 17 Nov 2026 03:50:11 -0500
X-MC-Unique: 8x6ljltBPvqzedA9JXLhRQ-1
X-Mimecast-MFC-AGG-ID: 8x6ljltBPvqzedA9JXLhRQ_1794905410
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3adf220e5e2so21657031fa.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 00:50:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794905410; x=1795510210;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VPNwuSkSoUHgxCsMFKb6H0ztS8LZ0AxmJoHNYtlGD0I=;
 b=HMtj/YLsYmLT1/QT5lKfUwCH/+ONefPNLqZjBemudXrsgDDSZlcTh7aakj2OuBpJ0b
 Bo6yBUd4iLQMD7sjEBqNoow390ccc8YY+InB3QySZm0n4WNR6YgUOIrnpiWnwmvM2jCd
 In4jj7d452lw12yb2dCt2z/hwQOH8ia1qsk7rRVWRewqkYK5G88IIkSKGqySjnqiSqIh
 NYnnX+krt9E9rNEVtzqtwNhkqrYxD6StBekeWBBrV8cCWmemH8DIYyPIAZSUSiMyEITM
 sqq68tCHBm+0TcbGRK9D+EKUOid8Qh8l2ZW7plm8oXXf6mVVA7mQK0nX+WaOSJNbSwdq
 BFwQ==
X-Gm-Message-State: APuU4Z9mufKN/v1lgoEQYcJQxgym/+peAtLK4Ccp11AWkTOngMd9qnYW
 nw+4vOk2Z5Z/ltTsyctVBwbg4AI+/EdlNx/gWe63rdg0X0pWC8Cof4axmEzmDvy6W1bvp0rAb2d
 Vy8ErzEki/PwCmHQk3CyktQkWqjp8OOy8pypavWR1chHTnie3My6JvdkzKBKD9skpLD1v2Fwx71
 FF5UaiUfBx6dzamRdfEcI=
X-Gm-Gg: AYBFou3zFqq2v88rURHao0M57TsVFtY6k/SkwcYd/GKbsKsvazidIn8sbKO64gVdddk
 Di+vkXgTJwfhdP/v5QUfzoiGifybGFGICSDpN+5huP54TFcZKGOT7dGVNOQqqCkZbd5NqLlshf3
 B8cE/6y8uUU82cNSl7pimt9TW1jh2Ds/CdkBXQD/jsuXNKMzdo88wFN10gv5McKWkqSAl4CmtFg
 8HG+m49WN56T1huDc2rB0Y7q/aGC6YahSAZ398gvooGAhDR
X-Received: by 2002:a2e:a105:0:b0:3a9:a1ed:634a with SMTP id
 38308e7fff4ca-3ae2b5223dbmr37466291fa.21.1794905409944; 
 Tue, 17 Nov 2026 00:50:09 -0800 (PST)
X-Received: by 2002:a2e:a105:0:b0:3a9:a1ed:634a with SMTP id
 38308e7fff4ca-3ae2b5223dbmr37466181fa.21.1794905409429; Tue, 17 Nov 2026
 00:50:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260602090847.905721-1-bruce.richardson@intel.com>
 <20261104201506.4091374-1-bruce.richardson@intel.com>
In-Reply-To: <20261104201506.4091374-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 17 Nov 2026 09:49:57 +0100
X-Gm-Features: AclHuK8Us6BkMb19CQbLLRILklw5OkmSjbiQyMLyRnlXaHdWlxuCTbdS7OQ-1VU
Message-ID: <CAJFAV8zg33QXRMkeoCqOAbbc4DFH7Ptrws+PBatwA8WQN-mUrw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] deprecate unneeded build options/support
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z0Y0-eRatAuSFmlXX3w39fmxnaRPLkSq9byXhTv1WZk_1794905410
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 21:15, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Having unnecessary build options just makes things confusing for
> the user, and expands the set of potential builds. This set
> deprecates 3 build options, including deprecating all HPET support,
> and marks them for future removal.
>
> ---
> v2: rather than always building HPET to remove the option, deprecate
>     all HPET support, which will also allow option removal in future.
>
> Bruce Richardson (3):
>   build: deprecate kernel dir option
>   build: deprecate standalone tests option
>   build: deprecate HPET support
>
>  app/meson.build                      |  6 +-----
>  doc/guides/linux_gsg/enable_func.rst | 32 ----------------------------
>  doc/guides/linux_gsg/sys_reqs.rst    |  3 ---
>  doc/guides/rel_notes/deprecation.rst | 11 ++++++++++
>  meson_options.txt                    |  6 +++---
>  5 files changed, 15 insertions(+), 43 deletions(-)

For the series,

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

