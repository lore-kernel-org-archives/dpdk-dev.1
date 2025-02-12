Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6FFC021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 02:07:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF0FE402BB;
	Wed, 12 Feb 2025 03:07:30 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C30CC40269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 03:07:28 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D95D82107AB5; Tue, 11 Feb 2025 18:07:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D95D82107AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739326047;
 bh=jAcjc55ntLy7Khzs9bozrYhMy3xLJpeB11FIhrxmmSo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ag3yJDbfG8iyXWpSZlF9F1GF1vVKDGWSEjqJ3UIbHAJn41f9gvAOvMk11ZcwVYFY4
 aB38YUurlJjH2y00MP+9fF+MtKSMfkIbbgIckK09+ZCF4swS6Yps6WdMMww8zxpKRm
 T+iGknEeZ9/aH/X7XrM3qKMW403jUrRCut16HFDQ=
Date: Tue, 11 Feb 2025 18:07:27 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org
Subject: Re: [PATCH 09/10] test: add workaround for __builtin_constant_p in
 test_memcpy_perf
Message-ID: <20250212020727.GB19389@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739311325-14425-10-git-send-email-andremue@linux.microsoft.com>
 <20250211141305.0a46a1cb@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211141305.0a46a1cb@hermes.local>
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

On Tue, Feb 11, 2025 at 02:13:05PM -0800, Stephen Hemminger wrote:
> On Tue, 11 Feb 2025 14:02:05 -0800
> Andre Muezerie <andremue@linux.microsoft.com> wrote:
> 
> > There's no MSVC equivalent for compiler extension __builtin_constant_p,
> > so a workaround is needed.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> Prefer that __rte_constant worked on all platforms,
> but template code is hard to maintain.

I'm not a huge fan of __rte_constant_with_default either. Here are some thoughts about it:

In test_memcpy_perf we could get rid of __builtin_constant_p or similar macros and just use the second argument (def) I'm passing to __rte_constant_with_default as the condition in the if() statement. I only used __rte_constant_with_default to keep the source code practically the same when using non-msvc compilers. But I don't see advantages beyond that, other than not having to pass that second parameter (def), which now we have to anyways.

__rte_constant_with_default is needed though in the first patch of this series, unless we decide to remove that extra check where it is being used.
