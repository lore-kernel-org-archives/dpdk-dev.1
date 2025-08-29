Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99D1CA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 12:43:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF53F40263;
	Fri, 29 Aug 2025 14:43:56 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7E3104025A;
 Fri, 29 Aug 2025 14:43:55 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 829FC211081A; Fri, 29 Aug 2025 05:43:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 829FC211081A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1756471434;
 bh=n8dvmif5KuBJHriOPRwYKlnNdSKB5TRz9w2/v0OTLi4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Azl+QoD7dMMXhbkKU14R4Nu+8yZfeJD0nQYV3X8kspr91f9nbnAU0xxnOryBSclxi
 ZJXY+f+KiGc0ypb3+6V2zMwzi9fC/5GVSUiPWxf01Ri1coRCjRdkZFU+FARqMPUQnT
 p9pRrx2uI8etY2+2qlkXPCCZXg9SEniAFLCtxE6k=
Date: Fri, 29 Aug 2025 05:43:54 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 dev@dpdk.org, Raslan Darawsheh <rasland@nvidia.com>, stable@dpdk.org
Subject: Re: [PATCH] net/mlx5: fix matcher flags in counter offset detection
Message-ID: <20250829124354.GA4857@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250820084521.1088620-1-dsosnowski@nvidia.com>
 <CAJFAV8wF0PT58zVDJDcmLcLz6Jt99rjexJOkFHBOmXNAhMw+vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJFAV8wF0PT58zVDJDcmLcLz6Jt99rjexJOkFHBOmXNAhMw+vw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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

On Wed, Aug 27, 2025 at 11:15:57AM +0200, David Marchand wrote:
> On Wed, 20 Aug 2025 at 10:47, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> >
> > This patch fixes a bug in
> > mlx5_flow_dv_discover_counter_offset_support()
> > uncovered by a warning reported by MSVC:
> >
> >     ../drivers/net/mlx5/mlx5_flow_dv.c(19636): warning C5287:
> >         operands are different enum types 'ibv_flow_attr_type' and
> >         'ibv_flow_flags';
> >         use an explicit cast to silence this warning
> >
> > IBV_FLOW_ATTR_FLAGS_EGRESS was incorrectly passed in to
> > type field of mlx5dv_flow_matcher_attr struct,
> > instead of flags field.
> > As a result counter offset support discovery returned a false positive
> > result on application with old rdma-core.
> >
> > Bugzilla ID: 1758
> > Fixes: 4fd5e1484887 ("net/mlx5: fix counter offset detection")
> > Cc: suanmingm@nvidia.com
> > Cc: stable@dpdk.org
> >
> > Reported-by: Andre Muezerie <andremue@linux.microsoft.com>
> > Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> 
> I did not test the patch, but on the principle this lgtm.
> 
> Andre, can you confirm it solves the build warning you were seeing with MSVC?
> 
> 
> -- 
> David Marchand
> 

Dariusz and David,

This patch compiles cleanly with MSVC.
Thanks for fixing this bug!

Andre Muezerie
