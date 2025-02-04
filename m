Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1E7C02193
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 16:27:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FE164042E;
	Tue,  4 Feb 2025 17:27:06 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EDFE3400EF;
 Tue,  4 Feb 2025 17:27:04 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 42C9A205491A; Tue,  4 Feb 2025 08:27:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42C9A205491A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738686424;
 bh=d3+LTk2uYid/dyE1kMI90BRxXqfFmWS11tAV5qfBJXQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gj+bhyaa8n9yGWifY717w7W5GQ9Su5f0KIcBYF85sswLWybYYY+JOUUqLeStyc2ax
 12RNMV8EuelJRSuuy5rh+mcew7SfPAiUxgLWBsNh8VbN8yl37Qk46yTlEVyM4biUQo
 Dp1NJSqpiehCYmfu5HlP8nvzemeL932vnwXydgVc=
Date: Tue, 4 Feb 2025 08:27:04 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Patrick Robb <probb@iol.unh.edu>
Cc: David Marchand <david.marchand@redhat.com>, dev@dpdk.org,
 konstantin.ananyev@huawei.com, thomas@monjalon.net, ci@dpdk.org,
 Aaron Conole <aconole@redhat.com>, Cody Cheng <ccheng@iol.unh.edu>
Subject: Re: [PATCH v19 00/27] remove use of VLAs for Windows
Message-ID: <20250204162704.GA16594@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1713397319-26135-1-git-send-email-roretzla@linux.microsoft.com>
 <1738555590-12753-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8z+aLY+etV+0knb0ZJMyocDZMYWStSBLiVZyeW1ZAVFsw@mail.gmail.com>
 <CAJvnSUASYqe39J3MTXqfEPSVWi6=z95TdN7z6e20QyJLeSNGug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJvnSUASYqe39J3MTXqfEPSVWi6=z95TdN7z6e20QyJLeSNGug@mail.gmail.com>
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

On Tue, Feb 04, 2025 at 10:38:55AM -0500, Patrick Robb wrote:
> It looks like this failed the check-meson script which we incorporated into
> our apply/build pipeline recently, which is why this series got a "build
> failure." It is indicating there are issues with lib/vhost/meson.build
> and app/test/meson.build.
> 
> Obviously we need to provide an email body which makes clear that
> check-meson was the source of the failure, and I have a UNH Lab ticket for
> this.
> 
> Running Check Meson
>  Error: Incorrect indent at app/test/meson.build:257
>  Error: Incorrect indent at app/test/meson.build:258
>  Error: Incorrect indent at lib/vhost/meson.build:23
>  Error: Incorrect indent at lib/vhost/meson.build:24

Thanks for clarifying that Patrick.
I submitted v20 for this series fixing the errors above.
--
Andre Muezerie
