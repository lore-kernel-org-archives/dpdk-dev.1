Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD37C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 18:54:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC8E2402F2;
	Wed,  5 Feb 2025 19:54:47 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 24992402E1
 for <dev@dpdk.org>; Wed,  5 Feb 2025 19:54:46 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 5A0252037186; Wed,  5 Feb 2025 10:54:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A0252037186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738781685;
 bh=XAsazyVNfdCGEfBAXy/NOiLRdOSMDiA9ozhNsGPA7z4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CToNERbgM3EUiqyoVLsyNPiDiYeEmIqF2Ees/AJqH2+QgHzwMWyLTh/hQ5B0CkAK8
 mX0tuP+Ow2k0C0W55ZPRHtKgW7Ivy0KL7wGoZ+akylTdGK43XrSC9HeAO0HdSJMDUl
 OQIPJtugGYX/Qc1f3Pwx/1Ip3vTFhbS/b+JCDic4=
Date: Wed, 5 Feb 2025 10:54:45 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 dsinghrawat@marvell.com, palok@marvell.com
Subject: Re: [PATCH v2 2/2] drivers/net: add MSVC compiler flag for unused
 variables
Message-ID: <20250205185445.GA2503@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1735238504-15597-3-git-send-email-andremue@linux.microsoft.com>
 <1736887611-32186-1-git-send-email-andremue@linux.microsoft.com>
 <1736887611-32186-3-git-send-email-andremue@linux.microsoft.com>
 <20250205103357.18fb491f@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205103357.18fb491f@hermes.local>
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

On Wed, Feb 05, 2025 at 10:33:57AM -0800, Stephen Hemminger wrote:
> On Tue, 14 Jan 2025 12:46:51 -0800
> Andre Muezerie <andremue@linux.microsoft.com> wrote:
> 
> > Added MSVC specific compiler flag to ignore warnings about unused
> > variables, like is being done for other compilers.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> This patch series needs rebase now that Intel drivers got reorganized.

Thanks for letting me know Stephen.
I sent out a rebased v3 of the series.
