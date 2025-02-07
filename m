Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEF7C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 15:07:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3614E42DDC;
	Fri,  7 Feb 2025 16:07:28 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 163C442DC1
 for <dev@dpdk.org>; Fri,  7 Feb 2025 16:07:27 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 679212109CE9; Fri,  7 Feb 2025 07:07:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 679212109CE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738940846;
 bh=UT0p1+3NEBFgb83vEhyYFN1j38Ch84VHVDBfhG9ajmM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cnjFMF1RuDWtXlkkhWW0dJ4Bi4ndLdzOkVTPPRP3ejiZnIsE+g91j5ytOmtM22UlA
 MdaQjGf8QBtmxcJmq7VjoVGKumVjJU96wLm8Q9L5uIL6WMGz2RN33VmKLGxGwRiMGI
 VAIG5MeAZhFHLuoQa5js7wuhRuLYdUBSIsrRyBk8=
Date: Fri, 7 Feb 2025 07:07:26 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5] eal: define __SIZEOF_LONG__ when using MSVC
Message-ID: <20250207150726.GA21754@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
 <1738771937-18083-1-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8zamNXCdmyO2YNGnF_2nE0vHCPgV_CtRy5W7fNshj49zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8zamNXCdmyO2YNGnF_2nE0vHCPgV_CtRy5W7fNshj49zg@mail.gmail.com>
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

On Fri, Feb 07, 2025 at 11:56:13AM +0100, David Marchand wrote:
> On Wed, Feb 5, 2025 at 5:12 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> >
> > Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
> > Therefore the errors below are seen with MSVC:
> >
> > ../lib/mldev/mldev_utils_scalar.c(465): error C2065:
> >     '__SIZEOF_LONG__': undeclared identifier
> > ../lib/mldev/mldev_utils_scalar.c(478): error C2051:
> >     case expression not constant
> >
> > ../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
> >     '__SIZEOF_LONG__': undeclared identifier
> > ../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
> >     case expression not constant
> >
> > The fix is to define __SIZEOF_LONG__ in a common header when
> > MSVC is used.
> >
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  lib/eal/include/rte_compat.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> 
> rte_compat only deals with symbol versioning.
> I think a better location would be windows/rte_os.h.
> 
> 
> 
> -- 
> David Marchand

Thanks for the suggestion. I updated the patch accordingly.
