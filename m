Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F2BCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 11:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96D63402CB;
	Thu,  2 Oct 2025 13:55:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 313E74013F
 for <dev@dpdk.org>; Thu,  2 Oct 2025 13:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759406113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ss98BarjsaKPEa2mgzeY1m2Tk4buD5KS15OgN30mHdQ=;
 b=YsW1+KEgYfTmDxckiY40za0dmIbSWp7S+hlO4BgyV9LAiu1/KHSqWr/Gw4QQbKIw3d3Git
 5g6RhPgT7u/MgH3anao0LvUdA/APRun9CIQRAOHkg2sYrGGuOX/hzyQfdy8+evK7/ds+BX
 K2tAZKCsrn9e5axAi3jbGPiQJdZqP0o=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-kpgYG9DNPCu3WzbgFzKw-Q-1; Thu, 02 Oct 2025 07:55:12 -0400
X-MC-Unique: kpgYG9DNPCu3WzbgFzKw-Q-1
X-Mimecast-MFC-AGG-ID: kpgYG9DNPCu3WzbgFzKw-Q_1759406111
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-372932bf858so4410021fa.3
 for <dev@dpdk.org>; Thu, 02 Oct 2025 04:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759406111; x=1760010911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ss98BarjsaKPEa2mgzeY1m2Tk4buD5KS15OgN30mHdQ=;
 b=Y5GVPccedA8lLmAGJBYFETtPZJLgFH1Kw7YZMdO8MSzzPp3vhuGiSgBjHiPEgiUMtx
 Eph1QRot54Ps9qLWJ6EaV8AG3fX4ts/BgRB9Fr1HpGdEu1S1rw0DvWLFOi0Q5wESQWqS
 w5szDwXeNOlcUWXnxJ8F0t46TIJPDI80+3qSfUmZKJdGxMZxRQCPQc/vFBKhIjxIqcdT
 6gjyi0E9fGeX8sETFQL7oqhXu41gI4Evfn6+S7aVZfuMYhTo5TzCsHpiaGQTohqGa2Fz
 zB5CWxSEaDZAXyMgi+TXFxt15ZrlTb47YOfy5uyGU7wCFYG3vNx6ip1qVGXSzGYKWmOF
 65yg==
X-Gm-Message-State: AOJu0YyRWQsKFwHLsZG5wEZ63/rJqkaLpesC9mN4CrowbzCrkRdICe+4
 BMYbIpuPNPl1Ko2Cgxm6Kz5Ne7R8kt3znppMABmgG/HposXQLxpoHqobjLzM9vDClW1dQVFEyDH
 /PVuY7WXf2wqf/Tt2tFwpIgXYNM26CVxoe4I7VS1irxeT0gEoCHm/UhLu72w9AjJyOBtcJnZrnv
 KmCt1cfzXMdoxf7upyTt4=
X-Gm-Gg: ASbGncsw+EbPo85LfbiTbWKug1Q3VIt/ZL9edmcel5nR+ZsGVZrdmmzS3PXSOPLCQX2
 3YvHNOfkV78IN31NzsVEnQjj15ptmTzzeDGKq1TDxd+cKzyJecQ9oNh6z+bbb+ap4YxKep92qcc
 3r+MauqMEfmUPM1/gXmfyaYMXZJuNw
X-Received: by 2002:a2e:bc1c:0:b0:336:df71:e560 with SMTP id
 38308e7fff4ca-373a71159a3mr21644791fa.3.1759406110892; 
 Thu, 02 Oct 2025 04:55:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxLhGHEeUEiiSc3O1W6QTRPWFSTzt3IQE9lILT9gzA5Yphsdf4/rHk3H56wJuwbt+nM7S+YOKztmZOAOEpv14=
X-Received: by 2002:a2e:bc1c:0:b0:336:df71:e560 with SMTP id
 38308e7fff4ca-373a71159a3mr21644641fa.3.1759406110470; Thu, 02 Oct 2025
 04:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250923165830.527416-1-bruce.richardson@intel.com>
 <20250924111318.567771-1-bruce.richardson@intel.com>
In-Reply-To: <20250924111318.567771-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 2 Oct 2025 13:54:58 +0200
X-Gm-Features: AS18NWA1FJOxM2IrldxbFEV9HoEbCbXX5Ofs6qkYM-fbSQwItnW3diGqCtJOewk
Message-ID: <CAJFAV8zv3GzBQk7u8qHjuq=Y6yu2WNuGCZMc0B=w_-PUsG1NOQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: 4ZYrTsDrfmvB37sXzLUUMSD7b2ozuSkfxdevliP9OkM_1759406111
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

On Wed, 24 Sept 2025 at 13:13, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The meson find_library() API call sometimes finds a library that is
> actually incompatible with the current build, for example, returning a
> 64-bit library when doing a 32-bit build. To avoid problems with this,
> check each library returned from a find_library() call and treat the
> library as unfound if its incompatible.
>
> This checking is not necessary (or should not be necessary) for
> dependencies got using pkg-config, since the .pc files for each build
> type are stored in a different directory on the system.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: David Marchand <david.marchand@redhat.com>


-- 
David Marchand

