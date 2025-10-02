Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6196CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 07:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE3A440A8A;
	Thu,  2 Oct 2025 09:53:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0069940262
 for <dev@dpdk.org>; Thu,  2 Oct 2025 09:53:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759391612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yuo+9uRHishv8mH6l9AFZRNp8h2u1T7hHI0KbxVki5U=;
 b=FiTeZ1/XH4XlFsN+Hd+FlEvf5z9Df0qk5HFFehmPFwY7lW/j5FXVzS9P2T9o6csN0zvncL
 YfbScY++Az00UXOInCliZAmCA7PZtNc7UCp3ju8JnVwJPxD4uY5Uf0yYv7MM3KdYRsSo5o
 Z3hGpS+Fc1ppekjYFUO0uVX3SKgOybs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-MIjIcxNiNkSQhkzMDG0ewQ-1; Thu, 02 Oct 2025 03:53:29 -0400
X-MC-Unique: MIjIcxNiNkSQhkzMDG0ewQ-1
X-Mimecast-MFC-AGG-ID: MIjIcxNiNkSQhkzMDG0ewQ_1759391608
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5711e6ebaabso412540e87.1
 for <dev@dpdk.org>; Thu, 02 Oct 2025 00:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759391607; x=1759996407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yuo+9uRHishv8mH6l9AFZRNp8h2u1T7hHI0KbxVki5U=;
 b=YTnDh/FAsigvUajXgLb81awf6L0+Zvceyn+rAlH+XGeFvMhwIMv7PXFfTMx39gWUlw
 Tft8ECH1UBcljaMMg/aR2+n+D2xETF/9KMuMYjRME7wLQlMiDoOFZKpMLAFuLRz2BWcN
 B3/AkTyJ6k8pd81pcc4yevVSvBHJz1pVJp3aOIGzMibQVMUTbMXRCNGXaK9HW6kgymLo
 ff30v2mPO0yjA6Lt9zfipZValQroCxg6+BU4sG1JXYLquaFk+szewH/D0DAXm+s8pLbQ
 9NjBVT7sgv5UN/TUppA8OB0iUwIyqlgKpk+pIwha77wV2w/8McsXSNffeyzIKxiJs7RW
 TuqA==
X-Gm-Message-State: AOJu0YxqxtLxMEWNYloRN6gGZF5CSr6esss0LONm+BHf07eaXOoukDXL
 dZDIjsoc57JntP7S1FfKwQKWGv+XX+fHg8d/5wzlkvWlGzoXhGad2tJ+lHn1rdsrqntdveLsD9B
 0TtJF/e23qxlAGClqsPk1JmiZZ7rjTE1+TAwQwpI+V7BJ0XXC3uowkF831JFI7hRdtZTHlXLpCj
 F2l643EFmXxOWgg4sdwWE=
X-Gm-Gg: ASbGnct3/KVHg9rGZ0OwDGv2tJWyUdsjbhkw3ELuAyoJmXlTbZMz2P4Cd+/ZKRv3ZYD
 /Uja/cz1mlg+0B83r4YGHQbpVNBEBia+zXQIAKgr5SmNR0vSFgWsq77uFF8QDgpm4MJRYiZUIA1
 uKH8CLvaRUI1CckcbLWsuQh8LzAPIA
X-Received: by 2002:a05:6512:4001:b0:57b:c798:9eeb with SMTP id
 2adb3069b0e04-58af9f6e9efmr1726895e87.47.1759391607590; 
 Thu, 02 Oct 2025 00:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHevuYIBHFiHztpVoLU0xtOYTGu1UtYttwv8nfOZjKSE41LmuU4li023YDFxFN5GscwSnGvRHLg5cVpeecKO0o=
X-Received: by 2002:a05:6512:4001:b0:57b:c798:9eeb with SMTP id
 2adb3069b0e04-58af9f6e9efmr1726871e87.47.1759391607170; Thu, 02 Oct 2025
 00:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250923165830.527416-1-bruce.richardson@intel.com>
 <20250924111318.567771-1-bruce.richardson@intel.com>
In-Reply-To: <20250924111318.567771-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 2 Oct 2025 09:53:15 +0200
X-Gm-Features: AS18NWBm091mui7vfIzgTVUhMbIV7PYszdwLFV7s0vVJVW0xCOeVs9JBcUot5ak
Message-ID: <CAJFAV8ztEthzEhjCYy-L0T98F7zb2qECG+2Cd0-HavPEBUQnAg@mail.gmail.com>
Subject: Re: [PATCH v2] build: validate libraries returned from meson find
 function
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Nicolas Chautru <nicolas.chautru@intel.com>, 
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, 
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, Srikanth Yalavarthi <syalavarthi@marvell.com>, 
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, 
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>, Rosen Xu <rosen.xu@altera.com>,
 Tomasz Kantecki <tomasz.kantecki@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U0lBz28MIPRWpkp-k5tir1zgol_x_vgCSyNJq-th-vs_1759391608
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

Hello Bruce,

On Wed, 24 Sept 2025 at 13:13, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The meson find_library() API call sometimes finds a library that is
> actually incompatible with the current build, for example, returning a
> 64-bit library when doing a 32-bit build. To avoid problems with this,
> check each library returned from a find_library() call and treat the
> library as unfound if its incompatible.

meson should have all it needs to double check itself that the "found"
library links fine...
But well, we need to live with existing behavior.

It's a pity meson refuses to define user helpers... so much copy/paste
in this patch.


>
> This checking is not necessary (or should not be necessary) for
> dependencies got using pkg-config, since the .pc files for each build
> type are stored in a different directory on the system.

Would it affect the library lookup if we pass has_headers to find_library()?


-- 
David Marchand

