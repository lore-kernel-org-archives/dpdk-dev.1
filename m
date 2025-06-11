Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5977C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 13:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0075D4066F;
	Wed, 11 Jun 2025 15:24:50 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3D437402EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 15:24:48 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 036722115193; Wed, 11 Jun 2025 06:24:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 036722115193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749648287;
 bh=ClNOc0boAtM1ftjlZR8H+0EaF8G65Qyl4/GVKMz5tF4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VMqzQy72Qx+PxemTR2hkRE9DFzeaSW9VCOADzxIjEn2crnGryaZLzHEBphRAWHTfL
 7ObGp0gOknj+wViIuFUpuVJGBVnHcyr8vHtEdpmiptO462M4w7XvbnoMQfGO59sCyY
 MroHBwhg8zO2VPWOJkX5qgSy1SyLEGIAcy5uPzhE=
Date: Wed, 11 Jun 2025 06:24:46 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v7 1/5] dev: hide driver export macros
Message-ID: <20250611132446.GA31263@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250611094532.1242167-1-david.marchand@redhat.com>
 <20250611094532.1242167-2-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611094532.1242167-2-david.marchand@redhat.com>
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

On Wed, Jun 11, 2025 at 11:45:28AM +0200, David Marchand wrote:
> The macros for tagging/exporting informations about a driver do not need
> to be exported in the public API.
> Move this to driver only header.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Acked-by: Andre Muezerie <andremue@linux.microsoft.com>
