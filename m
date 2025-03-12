Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184B0C28B2F
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 14:22:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C9C3402CE;
	Wed, 12 Mar 2025 15:22:19 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D04F940265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 15:22:17 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id DA3AD2033431; Wed, 12 Mar 2025 07:22:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA3AD2033431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741789336;
 bh=7kpacDgpUDYhq6i4PdHeCk/svh9jImFjl1e+o4qoodw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I/qm7lp9OPIYMkhJRWJcEGgjEab9/7CW7z5HqmKzXndsQH11KdxguuhzL0xN+7rgY
 tFotsGsMwBq/nWQ1IlVmdJPsWxuPgLqnkFd4dOoeRQBhLuWUs+O1D5U3rDzY5DhPaG
 /FNtymyxkxMrHA+7jwTP+B1OQnh1TTlYQjp1du3o=
Date: Wed, 12 Mar 2025 07:22:16 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Ian Stokes <ian.stokes@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] drivers: remove invalid options for MSVC
Message-ID: <20250312142216.GA12838@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741745636-20165-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8zw8WaafXmZtfe1OwoxZWrKaq03zPb_a-Vb5woXL4r40g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zw8WaafXmZtfe1OwoxZWrKaq03zPb_a-Vb5woXL4r40g@mail.gmail.com>
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

On Wed, Mar 12, 2025 at 08:51:12AM +0100, David Marchand wrote:
> On Wed, Mar 12, 2025 at 3:14 AM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > When compiling "drivers" directory with MSVC the errors below popped up:
> >
> > 1)
> > LINK : warning LNK4044: unrecognized option
> > '/Wl,/def:V:\github\dpdk\build\drivers\rte_bus_vdev_exports.def'; ignored
> 
> I reworked passing the export map in my RFC series.

That's right. I'll remove this part then.

> 
> >
> > 2)
> > cl : Command line warning D9002 : ignoring unknown
> >     option '-fno-asynchronous-unwind-tables'
> 
> This part lgtm.
> 
> >
> > The fix is to remove the unnecessary/invalid option when using MSVC.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> 
> -- 
> David Marchand
