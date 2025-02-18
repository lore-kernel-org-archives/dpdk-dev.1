Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C25C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 15:35:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A3C040261;
	Tue, 18 Feb 2025 16:35:11 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 654804014F
 for <dev@dpdk.org>; Tue, 18 Feb 2025 16:35:09 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 8B63B20376E0; Tue, 18 Feb 2025 07:35:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B63B20376E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739892908;
 bh=jWYwUDZlN3/5B0OHuw3/vZe4x4HO3yoqVwfKldEQdic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GIbIDS8Oity01uYDj0ygZUhp0DGrwimDqgVBCgtSK6fDgDQBXfR73KpesU7wfH3iv
 cOoJOwtYVAH8QalZfX3U9avXNumSvWDkgWCzf/EKIkPW5G7HKPuwA/9GO3xGWMg3bj
 4bU5fjJsClQyTrFt2l3GVzqfZyluJCLPw4T+xxT4=
Date: Tue, 18 Feb 2025 07:35:08 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, dev@dpdk.org, thomas@monjalon.net,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: Re: [PATCH] ci: build with MSVC in GHA
Message-ID: <20250218153508.GA20690@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250213075010.2670431-1-david.marchand@redhat.com>
 <f7teczvbcph.fsf@redhat.com>
 <CAJFAV8zuMwzA6mPxzPsk3d5OHjYu3vVjHtTzwODjxDmm7aJAKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zuMwzA6mPxzPsk3d5OHjYu3vVjHtTzwODjxDmm7aJAKg@mail.gmail.com>
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

On Tue, Feb 18, 2025 at 03:10:13PM +0100, David Marchand wrote:
> On Tue, Feb 18, 2025 at 2:32 PM Aaron Conole <aconole@redhat.com> wrote:
> >
> > David Marchand <david.marchand@redhat.com> writes:
> >
> > > Add a build target in Windows 2022 for MSVC.
> > >
> > > Loading MSVC environment and having successive commands in a single
> > > (cmd or pwsh) shell does not seem to correctly report if one of the
> > > commands failed.
> > > For now, load MSVC environment and run commands in separate shells.
> > >
> > > Signed-off-by: David Marchand <david.marchand@redhat.com>
> > > ---
> >
> > LGTM.
> >
> > Acked-by: Aaron Conole <aconole@redhat.com>
> >
> > How far back will this work (ie: can we backport this to older branches?)
> 
> MSVC was added in 23.11.
> The patch applies cleanly and runs on 23.11 (where only lib/kvargs,
> lib/log and lib/telemetry are compiled) and 24.11.
> 
> I can add Cc: stable if you think it is worth having it in LTS (UNH
> provides some coverage in LTS releases).
> 
> 
> -- 
> David Marchand

LGTM.
--
Andre Muezerie
