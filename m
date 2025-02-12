Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DDBC0219B
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 01:16:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 262AF40EF0;
	Wed, 12 Feb 2025 02:16:54 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id BC7CA40269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 02:16:52 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id F05132107AB5; Tue, 11 Feb 2025 17:16:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F05132107AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739323011;
 bh=zilLXdHb4bdezlpthvnKv23q7EQ3ie/XVXZrc8uYPY8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XbPbGGgmmzUXgOSee2AwZPq6IOIKQEHFq5KMwLYMsGLSqnyTcShYoLYDVhBWsbwW8
 Ri8Gwn8MGacz5bn5ROx3PQUBaBagcJ/NYzRPPzyTtZbgVi2qFqAAkDfXZ4zxj09zNx
 DRmehEdA3Lt0GSIz52N4ah1Xrt7Klnd7/JoqOQRE=
Date: Tue, 11 Feb 2025 17:16:51 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, dev@dpdk.org
Subject: Re: [PATCH 08/10] test-pmd: declare lcore_count atomic when using
 C11 memory model
Message-ID: <20250212011651.GA19389@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739311325-14425-9-git-send-email-andremue@linux.microsoft.com>
 <20250211141212.45e90ab2@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211141212.45e90ab2@hermes.local>
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

On Tue, Feb 11, 2025 at 02:12:12PM -0800, Stephen Hemminger wrote:
> On Tue, 11 Feb 2025 14:02:04 -0800
> Andre Muezerie <andremue@linux.microsoft.com> wrote:
> 
> > Compiling with MSVC results in the error below:
> > 
> > app/test/test_ring_perf.c(197): error C7712: address argument to atomic
> >     operation must be a pointer to an atomic integer,
> >     'volatile unsigned int *' is not valid
> > 
> > The fix is to mark lcore_count as atomic when using C11 memory model.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> Prefer using RTE_ATOMIC() all teh time now.

You mean even when not explicitly using the C11 model, right?
