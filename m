Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90295C3ABC9
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 12:50:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61D3240292;
	Fri, 16 May 2025 14:50:38 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5CE514028F
 for <dev@dpdk.org>; Fri, 16 May 2025 14:50:36 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 10AF2201DB23; Fri, 16 May 2025 05:50:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10AF2201DB23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747399835;
 bh=CiOD+cqDjXef5YTuhA+/Gjc2hmvSJyahUF0FSBNAbQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rMI9V53Zn0S2KJDJx2MIHHNGsWubEm/cB/i7K2DUjxH1SsZiO1U1qsar6Z0j2DW8V
 KrJ8qdCrffxEP+0/FuwxZyNRtymy1h9tmyVlr+IKsWStlucgSZ/m71kUPOJLqGyHLG
 lfpjg/wYQ6nLfw9rgOIRgTW90V2A5Ye/U7rOArxY=
Date: Fri, 16 May 2025 05:50:35 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Ori Kam <orika@nvidia.com>, dev@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH] regexdev: enable to be compiled on Windows
Message-ID: <20250516125035.GA29027@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746827534-19881-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8y8vibAGFsAR1XPFedR0-q+KC+Rm1=2cNPyJ5vF3ATKfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8y8vibAGFsAR1XPFedR0-q+KC+Rm1=2cNPyJ5vF3ATKfQ@mail.gmail.com>
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

On Fri, May 16, 2025 at 10:01:42AM +0200, David Marchand wrote:
> On Fri, May 9, 2025 at 11:52 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > Now that mbuf is compiling on Windows, this library can be enabled as
> > well.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> The test-regex app can probably be compiled too.
> Yet.. why do you want to enable this library on Windows?
> 
> Support for this device class is defacto deprecated, as no vendor is
> providing recent hardware implementing this feature.
> 
> Also note that it was not built with clang on Windows so far (I did
> not double check this assertion, I just based on the fact this patch
> removes a is_windows, and not a is_ms_compiler).
> 
> 

I was not aware this code was deprecated. You're right that it was not
being compiled with Clang. This was just part of the effort to increase
code compatibility on Windows.

I see no harm in enabling it, but at the same time, there's no clear
benefit either. I'll let you decide what to do with this.

> -- 
> David Marchand
