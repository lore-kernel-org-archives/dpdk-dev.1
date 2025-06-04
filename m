Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD13AC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 14:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8570742D7A;
	Wed,  4 Jun 2025 16:52:09 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 38424402B1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 16:52:07 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 50A76201FF53; Wed,  4 Jun 2025 07:52:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 50A76201FF53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749048726;
 bh=n4GXORMfHLLNCQaB2Q0cJ+Z0ez/NriYs0vm07L1MPOo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Su/p2R0LeE61f/VRPo5ye2v44M8aGHiAUYuQN+O9Gy6UXqW+shUueNF5dZzlSOg8a
 xaHotMuA9OSgxTN0VkMdAUnUvRdDfY+8JYSr6panr0v5RAJBVyn6nv6X5FN29KxRRb
 GT8TCfEJKSUfpHGnu0FHfmzHtSkZFDjTbcsm2MnQ=
Date: Wed, 4 Jun 2025 07:52:06 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 1/4] eal: add macro to embed information in binaries
Message-ID: <20250604145206.GB9366@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-1-git-send-email-andremue@linux.microsoft.com>
 <1744839898-15745-2-git-send-email-andremue@linux.microsoft.com>
 <aEBUo5B5EIT2eLG1@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEBUo5B5EIT2eLG1@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, Jun 04, 2025 at 03:13:55PM +0100, Bruce Richardson wrote:
> On Wed, Apr 16, 2025 at 02:44:55PM -0700, Andre Muezerie wrote:
> > DPDK uses GCC attribute "used" through macro __rte_used to indicate
> > that a variable not referenced in the code should be assumed being
> > used and therefore not be optimized away. This technique is used to embed
> > information in the binaries, by having crafted information stored in
> > them.
> > 
> > MSVC offers similar functionality, but it differs significantly: MSVC
> > requires a pragma to be used to send a command to the linker telling it
> > explicitly the name of the symbol that should be included (even if not
> > referenced). As a side-effect, variables called out to be included cannot
> > be static, otherwise their symbols are not "seen" by the linker. This
> > restriction requires some DPDK code to be refactored.
> > 
> > To assimilate these requirements/restrictions, macro RTE_INCLUDE is
> > introduced in this patch.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  lib/eal/common/eal_common_options.c | 2 +-
> >  lib/eal/include/rte_common.h        | 6 ++++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
> > index b6fff7ec05..8d115a5bd7 100644
> > --- a/lib/eal/common/eal_common_options.c
> > +++ b/lib/eal/common/eal_common_options.c
> > @@ -135,7 +135,7 @@ static const char *default_solib_dir = RTE_EAL_PMD_PATH;
> >   * Note: PLEASE DO NOT ALTER THIS without making a corresponding
> >   * change to usertools/dpdk-pmdinfo.py
> >   */
> > -static const char dpdk_solib_path[] __rte_used =
> > +RTE_INCLUDE(const char, dpdk_solib_path)[] =
> >  "DPDK_PLUGIN_PATH=" RTE_EAL_PMD_PATH;
> >  
> >  TAILQ_HEAD(device_option_list, device_option);
> > diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> > index a6085dce27..4c5a3b668f 100644
> > --- a/lib/eal/include/rte_common.h
> > +++ b/lib/eal/include/rte_common.h
> > @@ -231,6 +231,12 @@ typedef uint16_t unaligned_uint16_t;
> >  /**
> >   * Force symbol to be generated even if it appears to be unused.
> >   */
> > +#ifdef RTE_TOOLCHAIN_MSVC
> > +#define RTE_INCLUDE(type, name) __pragma(comment(linker, "/include:" RTE_STR(name))) type name
> > +#else
> > +#define RTE_INCLUDE(type, name) __attribute__((used)) type name
> 
> Any reason we shouldn't also have "static" here, for the non-MSVC case?
> 

The keyword "static" can't be used here with MSVC. It is nice to have the same source code
for MSVC and non-MSVC, and I don't see a good reason to have "static"
here just for the non-MSVC case. To some extent it is even somewhat contradictory to
have "static" and "__attribute__((used))" in the same line (hide it here but expose it there).

Let me know if you see a strong reason to have "static" just for the non-MSVC case.

> As a general question, is this needed for any/many tasks other than putting
> in place strings? Rather than having a general include macro,
> I'm just wondering if we are better doing specific macros for the driver
> string, and then other-string use-cases.

There might be other use cases for RTE_INCLUDE, but for now it has only been used
to put in place strings in drivers and common code
(like lib\eal\common\eal_common_options.c).

In most cases RTE_INCLUDE is not being called directly - it's called by other macros
like the one below:

#define RTE_PMD_REGISTER_KMOD_DEP(name, str) \
RTE_INCLUDE(const char, DRV_EXP_TAG(name, kmod_dep_export))[] = str

That being said, I don't see strong reason to prevent people from calling it directly.

> 
> /Bruce
