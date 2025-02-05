Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC04C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 19:38:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1F99402E7;
	Wed,  5 Feb 2025 20:38:29 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3A5BC402E1
 for <dev@dpdk.org>; Wed,  5 Feb 2025 20:38:28 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 8837C20ACD7D; Wed,  5 Feb 2025 11:38:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8837C20ACD7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738784307;
 bh=lQFVhtYyU4uGon+/RD+zXwPgU/Qq2a3hqT2bw4XY6u8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bQ9J+Rt8fykUsuBdYrWdgp3mg8IzVXftn0ymiHw0p/CMq8XBaqNLdV2t0D1Ge06VW
 qv8uD3z/w96Gp0iGgOsY4yeLJ9LB9+4tmAZB6gd2zlmb1MNL1FjF1805VzlHwGxjFQ
 q2VxvzUNN6KPvfiM/zFn00W5GOaRqoiy277Lv6vQ=
Date: Wed, 5 Feb 2025 11:38:27 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 ian.stokes@intel.com, jochen.behrens@broadcom.com,
 vladimir.medvedkin@intel.com
Subject: Re: [PATCH v3] drivers/net: use 64-bit shift and avoid
 signed/unsigned mismatch
Message-ID: <20250205193827.GA11172@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1736888702-3253-1-git-send-email-andremue@linux.microsoft.com>
 <20250205103525.7966beed@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205103525.7966beed@hermes.local>
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

On Wed, Feb 05, 2025 at 10:35:25AM -0800, Stephen Hemminger wrote:
> On Tue, 14 Jan 2025 13:05:02 -0800
> Andre Muezerie <andremue@linux.microsoft.com> wrote:
> 
> > This patch avoids warnings like the ones below emitted by MSVC:
> > 
> > 1)
> > ../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
> >     result of 32-bit shift implicitly converted to 64 bits
> >     (was 64-bit shift intended?)
> > 
> > 2)
> > ../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
> >     signed/unsigned mismatch
> > 
> > The fix for (1) is to use 64-bit shifting when appropriate
> > (according to what the result is used for).
> > 
> > The fix for (2) is to explicitly cast the variables used in the
> > comparison.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> 
> Needs rebase, the Intel drivers got reorganized.

Thanks for letting me know. I rebased and sent out the updated patch.
