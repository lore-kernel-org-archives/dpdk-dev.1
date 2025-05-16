Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45670C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 13:14:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2097140292;
	Fri, 16 May 2025 15:14:44 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7140C4028F
 for <dev@dpdk.org>; Fri, 16 May 2025 15:14:43 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5A003201DB03; Fri, 16 May 2025 06:14:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A003201DB03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747401282;
 bh=jV8aybsETpwwUZcf2IgTxVXcGh8as5RHHCobKlnS6Qw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cJKzHH8scp1jsFbcl77ETxm95VXNuBSDiJytWD94G88pGxDtC8uXrrGsT03Tzo3jA
 X/lMsVge7ohBo1kScH9E/h4pWCj5S10eRtPpPLZVPqUHlxx2iwZZhyGg4kCFOSyDkq
 /volJh83KlywAo6YUs6mRlKz07NAro1rnIIwq7II=
Date: Fri, 16 May 2025 06:14:42 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH v3 1/1] buildtools: avoid break due to failure to cleanup
 temporary directory
Message-ID: <20250516131442.GC29027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746474405-5056-1-git-send-email-andremue@linux.microsoft.com>
 <1746627671-28659-1-git-send-email-andremue@linux.microsoft.com>
 <1746627671-28659-2-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8zvB0Bn+r4JiNq5RzgDXZgQr_XRaT66TqR4rWoAwoGvZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zvB0Bn+r4JiNq5RzgDXZgQr_XRaT66TqR4rWoAwoGvZQ@mail.gmail.com>
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

On Fri, May 16, 2025 at 11:34:10AM +0200, David Marchand wrote:
> Hello Andre,
> 
> On Wed, May 7, 2025 at 4:21 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > When compiling drivers on Windows, instances have been seen where a
> > temporary directory fails to get cleaned up due to
> > ERROR_SHARING_VIOLATION (32).
> >
> > This issue was not seen on operating systems other than Windows.
> >
> > This patch eliminates the use of tempfile.TemporaryDirectory, which
> > was triggering the issue.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> How does this change interact (except a merge conflict) with the other
> series that adds pmdinfo for MSVC?
> https://patchwork.dpdk.org/project/dpdk/list/?series=35065&state=%2A&archive=both
> 

I suggest applying this patch as early as possible. I can rebase the other patch
which will merge conflict with it after if needed.

On my dev machine I'm building the drivers folder, and that doesn't succeed without
this patch. I want to enable that on the official branch as well, but can't until
this patch is merged.

> 
> -- 
> David Marchand
