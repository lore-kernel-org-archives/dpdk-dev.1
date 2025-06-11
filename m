Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2771AC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 13:28:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 724974066F;
	Wed, 11 Jun 2025 15:28:36 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B8251402EF
 for <dev@dpdk.org>; Wed, 11 Jun 2025 15:28:34 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9ABFC203B878; Wed, 11 Jun 2025 06:28:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9ABFC203B878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749648513;
 bh=Hc+kJZ203K55s0upeKiesXDYYxOYUR2wpCERORV1QWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HrZlxppvX8Gecgtv5v8sKkLKSvWLeWWbxzBkAU488eRvu063zjBIyUeM26mRsPDOW
 Uq38kiWKigBUu80uoQjIcf4x3e//+cnoxAlBhbfq9p2EFPgH/KYxxpK7fL23hkyhxs
 0FvanSRhFGML9IU/g8lxDrH/JA2QrJ200C2/MA4w=
Date: Wed, 11 Jun 2025 06:28:33 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>
Subject: Re: [PATCH v7 4/5] buildtools: embed driver information with MSVC
Message-ID: <20250611132833.GD31263@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250610100947.421877-1-david.marchand@redhat.com>
 <20250611094532.1242167-1-david.marchand@redhat.com>
 <20250611094532.1242167-5-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611094532.1242167-5-david.marchand@redhat.com>
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

On Wed, Jun 11, 2025 at 11:45:31AM +0200, David Marchand wrote:
> From: Andre Muezerie <andremue@linux.microsoft.com>
> 
> The archiver tool from the MSVC toolset is lib.exe. It has different
> parameters then it's GNU counterpart "ar".
> 
> buildtools\meson.build was updated to use lib.exe when MSVC compiler is
> used. This is to allow the code to be built without requiring GNU "ar"
> to be installed in that scenario.
> 
> Script gen-pmdinfo-cfile.py was updated to use the correct parameters
> when using lib.exe.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---

Acked-by: Andre Muezerie <andremue@linux.microsoft.com>
