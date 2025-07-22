Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DD0C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 16:37:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C549340269;
	Tue, 22 Jul 2025 18:37:47 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 182024003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 18:37:46 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 67FF0212689D; Tue, 22 Jul 2025 09:37:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 67FF0212689D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1753202265;
 bh=47TmcjUZkvJzeIQqMJgKC5Ay9aaRwTGXTvdJphQde5k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PBixnIaXfVjR/OcI82IR8YX4Lz4O+ZmcAnpI3I5daWyhDstOvVUFmnmR9Q30O2vT6
 5HAi6re/ypDZZM+/1YI0EEU7usGb/k64sxwBtrYi5JQAdk8UghjTYCX8cdAfgvd5g0
 HQuJA8FKJGvOzGGU+pAZZycrlomT8SYeSltFrVQc=
Date: Tue, 22 Jul 2025 09:37:45 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, dmitry.kozliuk@gmail.com, roretzla@linux.microsoft.com
Subject: Re: [PATCH v2 2/2] test/strsep: add tests for function strsep()
Message-ID: <20250722163745.GA26460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1747401734-6303-1-git-send-email-andremue@linux.microsoft.com>
 <1753130343-29500-1-git-send-email-andremue@linux.microsoft.com>
 <1753130343-29500-2-git-send-email-andremue@linux.microsoft.com>
 <CAJFAV8x4qO9-y+0C_PoJsw0eYmVcPs+CzpfPBvD0=opC7KQ-2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFAV8x4qO9-y+0C_PoJsw0eYmVcPs+CzpfPBvD0=opC7KQ-2w@mail.gmail.com>
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

On Tue, Jul 22, 2025 at 04:30:57PM +0200, David Marchand wrote:
> Hello Andre,
> 
> On Mon, Jul 21, 2025 at 10:39 PM Andre Muezerie
> <andremue@linux.microsoft.com> wrote:
> > diff --git a/app/test/test_strsep.c b/app/test/test_strsep.c
> > new file mode 100644
> > index 0000000000..19df8f31ee
> > --- /dev/null
> > +++ b/app/test/test_strsep.c
> > @@ -0,0 +1,108 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause
> > + * Copyright (C) 2025 Microsoft Corporation
> > + */
> > +
> > +#include <string.h>
> > +#include <rte_os_shim.h>
> > +
> > +#include "test.h"
> > +
> > +static int
> > +test_strsep_helper(const char *str, const char *delim,
> > +                  const char * const expected_tokens[], size_t expected_tokens_count)
> > +{
> > +       char *s = str != NULL ? strdup(str) : NULL;
> > +       const char *token;
> > +       for (size_t i = 0; i < expected_tokens_count; i++) {
> > +               token = strsep(&s, delim);
> 
> The reference to the dupped string gets lost, since calling strsep updates s.
> Caught by ASan:
> 
> ==49990==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 51 byte(s) in 4 object(s) allocated from:
>     #0 0x5632dd8cbe83 in strdup
> (/home/runner/work/dpdk/dpdk/build/app/dpdk-test+0x271e83) (BuildId:
> 01a7571ab7814bc83923733b3dae34d28e6ff3e1)
>     #1 0x5632de39bad2 in test_strsep_helper
> /home/runner/work/dpdk/dpdk/build/../app/test/test_strsep.c:14:26
>     #2 0x5632dd91d86f in unit_test_suite_runner
> /home/runner/work/dpdk/dpdk/build/../app/test/test.c:364:20
>     #3 0x5632dd91c2b0 in cmd_autotest_parsed
> /home/runner/work/dpdk/dpdk/build/../app/test/commands.c:68:10
>     #4 0x7fba8b3bfc58 in __cmdline_parse
> /home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline_parse.c:296:3
>     #5 0x7fba8b3bfc58 in cmdline_parse
> /home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline_parse.c:305:9
>     #6 0x7fba8b3bcbf7 in cmdline_valid_buffer
> /home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline.c:25:8
>     #7 0x7fba8b3c50ec in rdline_char_in
> /home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline_rdline.c:456:5
>     #8 0x7fba8b3bcfde in cmdline_in
> /home/runner/work/dpdk/dpdk/build/../lib/cmdline/cmdline.c:154:9
>     #9 0x5632dd91d2ba in main
> /home/runner/work/dpdk/dpdk/build/../app/test/test.c:231:15
>     #10 0x7fba89a29d8f in __libc_start_call_main
> csu/../sysdeps/nptl/libc_start_call_main.h:58:16
> 
> SUMMARY: AddressSanitizer: 51 byte(s) leaked in 4 allocation(s).
> ------------------------------------------------------------------------------
> 
> 
> -- 
> David Marchand

Thanks for sending this info. I'll send out a fixed version.
