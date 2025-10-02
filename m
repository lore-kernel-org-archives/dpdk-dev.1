Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F88CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 12:45:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AF6C40B9D;
	Thu,  2 Oct 2025 14:45:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2BF6B40A84
 for <dev@dpdk.org>; Thu,  2 Oct 2025 14:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759409146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i5jvXJAW1Fmw5i1+JJ+VMgySARxbsL1gfzJ9nBUvppM=;
 b=Nhg7QNofw0q4pYqNN05HkPRAs+ZV9k2pMZ2nUzgKPsQhP2RjYe2hhRfWD8fdHtrj3R7sFu
 8QfQLYfIUJQHLHYoz86V6SpZQcmNPPmDYV7a3894QVtLxsbbCbv4cJCCQF+o7IRrfCOK1t
 YcFaXce576BTfHp6pCgzx1/JrD0baKA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-gsGmyHTHOSeXqUNNFEX02Q-1; Thu, 02 Oct 2025 08:45:44 -0400
X-MC-Unique: gsGmyHTHOSeXqUNNFEX02Q-1
X-Mimecast-MFC-AGG-ID: gsGmyHTHOSeXqUNNFEX02Q_1759409143
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-35f62a3c170so4172251fa.0
 for <dev@dpdk.org>; Thu, 02 Oct 2025 05:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759409143; x=1760013943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i5jvXJAW1Fmw5i1+JJ+VMgySARxbsL1gfzJ9nBUvppM=;
 b=L2ehRzP9/5iIdnLLN/qZHcRtWWq8PvDy0rIHQQDLme8Z09t55StEq3mqj2Lwq4Dk9x
 ZKtTZaJ7iLKcfWgL9dAJfbJ8IEG2uhi918TdFGzQXSPl5ZbejIxcf6a5C+oJJDnpewft
 gfWWz4QE14gsPjej/3EUvYLB+lcUoIfoZ8Zd4tY12jrnhnRmtIYlDg5epAUPEAqvNV36
 4Qe48DrnuQDjNaGqknXW+n7VeOFT/Ppf9L9+Kl9UTbeVuIdjZ3M4ckMhvkgdiHmgb6Ut
 tSszflaoMWFNUaUxN8j9qYwNxuQM3dKPoCHEPUnnAQBxKDrWf16hBSSu22II3hpxGClB
 7b4g==
X-Gm-Message-State: AOJu0Ywq+tYcsVS22Nx6Dcu1WlnPiubpGvQmRyUoG+JoU3Oa3p0ww29X
 9v/+JzgObOnPcLDdb7TMxs+RXwbfa3KVhxlC+uVOeUJLQDJqQcHH2+Y2WP4sjEV8kS/h9UDkSG5
 ywLKdkp9P5UPRZlJP7hoD7AHInkXu+eS2Dd8cYg3RGH52i3C/6HSzwleHv1XeMpmOkghTVDpJnk
 CF7ufAe7uHxvVwVTrmSrM=
X-Gm-Gg: ASbGncs1G3dEZ02D03rlBsGkv62PU+AgRPhDPpNtYnxb9mhmE0mFagHMC/2dkYKRY1h
 y37woxzyjxe37Nlp8bZpmEHSz81+VBB2F2Wf2w+68omywPboWi1xX9nxEH7JoeTHOOKefGpWyto
 +CpdwXPVEGPQKSyYtaSWPEDnl8L+iw
X-Received: by 2002:a05:651c:150b:b0:336:dec9:38bb with SMTP id
 38308e7fff4ca-373a6fce3b8mr20976451fa.0.1759409143005; 
 Thu, 02 Oct 2025 05:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoI/5sSjJURyfJPA94HzmbxIYYTQXwMEZbifXzBtD+VeKEd6ofX3Z2zk/ntXSqXUycVVQIS3BbHwK8DIinloc=
X-Received: by 2002:a05:651c:150b:b0:336:dec9:38bb with SMTP id
 38308e7fff4ca-373a6fce3b8mr20976231fa.0.1759409142541; Thu, 02 Oct 2025
 05:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250923165830.527416-1-bruce.richardson@intel.com>
 <20250924111318.567771-1-bruce.richardson@intel.com>
 <CAJFAV8zv3GzBQk7u8qHjuq=Y6yu2WNuGCZMc0B=w_-PUsG1NOQ@mail.gmail.com>
In-Reply-To: <CAJFAV8zv3GzBQk7u8qHjuq=Y6yu2WNuGCZMc0B=w_-PUsG1NOQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 2 Oct 2025 14:45:31 +0200
X-Gm-Features: AS18NWBkngx81wSya9YCtbGXMr9vcpTcaDaU25X0mI1ynWLuHeWyO0-oYYHTBjM
Message-ID: <CAJFAV8z9e9B7BfwXRr_H76sm_5kTGyjnv8MaT5NriBTykbyQgg@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: A53g8QmgvFanP3mxqkeYqNdAl-5-vxQ_-18sIh6EeLk_1759409143
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

On Thu, 2 Oct 2025 at 13:54, David Marchand <david.marchand@redhat.com> wrote:
> On Wed, 24 Sept 2025 at 13:13, Bruce Richardson
> <bruce.richardson@intel.com> wrote:
> >
> > The meson find_library() API call sometimes finds a library that is
> > actually incompatible with the current build, for example, returning a
> > 64-bit library when doing a 32-bit build. To avoid problems with this,
> > check each library returned from a find_library() call and treat the
> > library as unfound if its incompatible.
> >
> > This checking is not necessary (or should not be necessary) for
> > dependencies got using pkg-config, since the .pc files for each build
> > type are stored in a different directory on the system.
> >
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
>
> Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

