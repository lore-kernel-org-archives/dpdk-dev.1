Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B12C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 17:10:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15E5B427A4;
	Wed, 19 Feb 2025 18:10:02 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9DBDD4028B
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:10:00 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D249D2043DE3; Wed, 19 Feb 2025 09:09:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D249D2043DE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739984999;
 bh=ZBafBxYd+MnbTtWWv6X0Fy7Ww93xXquWkLhhEe0n27I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VHch8qbodfepIvnKUudZwTJZzee2gWUOF2wOGiPlOHQrI855JZQB4/h3ct4oLJzbV
 ge1xcPd8BKLa0HCBByTY64KF5GXBU2P08U7lIETKV9pRBpQrg54oKouhUjiesUQF6Z
 p8pj27dLTUZzbflHc80g3FfbRMGoWVwxbcaaY2eU=
Date: Wed, 19 Feb 2025 09:09:59 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH v2 05/10] test-pmd: avoid undefined behavior
Message-ID: <20250219170959.GB10716@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-6-git-send-email-andremue@linux.microsoft.com>
 <Z7S4Kn_tf08rMpLc@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7S4Kn_tf08rMpLc@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, Feb 18, 2025 at 04:41:14PM +0000, Bruce Richardson wrote:
> On Tue, Feb 18, 2025 at 08:32:04AM -0800, Andre Muezerie wrote:
> > Compiling with MSVC results in warnings like below:
> > 
> > app/test-pmd/cmdline.c(9023): warning C5101: use of preprocessor
> >     directive in function-like macro argument list is undefined behavior
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> > ---
> >  app/test-pmd/cmdline.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
> > index 2afcf916c0..4f0b0340c8 100644
> > --- a/app/test-pmd/cmdline.c
> > +++ b/app/test-pmd/cmdline.c
> > @@ -9011,6 +9011,18 @@ static void cmd_dump_parsed(void *parsed_result,
> >  }
> >  
> >  static cmdline_parse_token_string_t cmd_dump_dump =
> > +#ifdef RTE_EXEC_ENV_WINDOWS
> > +	TOKEN_STRING_INITIALIZER(struct cmd_dump_result, dump,
> > +		"dump_physmem#"
> > +		"dump_memzone#"
> > +		"dump_socket_mem#"
> > +		"dump_struct_sizes#"
> > +		"dump_ring#"
> > +		"dump_mempool#"
> > +		"dump_devargs#"
> > +		"dump_lcores#"
> > +		"dump_log_types");
> > +#else
> >  	TOKEN_STRING_INITIALIZER(struct cmd_dump_result, dump,
> >  		"dump_physmem#"
> >  		"dump_memzone#"
> > @@ -9020,10 +9032,9 @@ static cmdline_parse_token_string_t cmd_dump_dump =
> >  		"dump_mempool#"
> >  		"dump_devargs#"
> >  		"dump_lcores#"
> > -#ifndef RTE_EXEC_ENV_WINDOWS
> >  		"dump_trace#"
> > -#endif
> >  		"dump_log_types");
> > +#endif
> >  
> 
> Rather than defining two separate lists, is a better fix not to provide a
> dummy implementation of dump_trace for windows, that returns e.g. TEST_SKIPPED.
> 
> /Bruce

Good suggestion. I'll update the patch accordingly.
