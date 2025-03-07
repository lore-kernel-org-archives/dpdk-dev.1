Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D067C282DE
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 22:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B334140656;
	Fri,  7 Mar 2025 23:34:03 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2E8154025F
 for <dev@dpdk.org>; Fri,  7 Mar 2025 23:34:02 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 365B62038F3B; Fri,  7 Mar 2025 14:34:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 365B62038F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741386841;
 bh=g8pfdR2x5LPYB/+fGsxRAqvKd3qD81+XIAI3O7b3m2I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NVgNN/iTBUbAaf1kKHfJLJ9QLJbznb2f0WV5Q4wcuMo5CLdDFH8IJLvZOhWGmOXr3
 oNCQVKODEmrj2xoc+89t7ykRCb/0qD0BJUdKDtBQpEfVvYYoYNrG/mgCJjSsGYZJpp
 3Nt4rjOYkL7+pXyZ5UVr9aPJkdjj16ioC1fq6zFg=
Date: Fri, 7 Mar 2025 14:34:01 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] hash_readwrite_autotest: fix printf parameters
Message-ID: <20250307223401.GA27687@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <Z8q16Ikzl4_flbpK@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8q16Ikzl4_flbpK@bricha3-mobl1.ger.corp.intel.com>
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

On Fri, Mar 07, 2025 at 09:01:28AM +0000, Bruce Richardson wrote:
> On Thu, Mar 06, 2025 at 12:03:28PM -0800, Andre Muezerie wrote:
> > Compiling with MSVC logs the warnings below, which result in
> > build error:
> > 
> > ../app/test/test_hash_readwrite.c(73): warning C4476: 'printf' :
> >     unknown type field character ''' in format specifier
> > ../app/test/test_hash_readwrite.c(75): warning C4474: 'printf' :
> >     too many arguments passed for format string
> > ../app/test/test_hash_readwrite.c(75): note: placeholders and
> >     their parameters expect 2 variadic arguments, but 4 were provided
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  app/test/test_hash_readwrite.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> IF the "'" character is not supported, is there some other method to do
> thousands grouping in MSVC?
> 
> /Bruce

The problem exists with all compilers I tried on Windows:

1) MSVC logs the error I mentioned above

2) GCC and Clang don't complain at compile time, but don't honor the "'" as a special
character. As an example,
printf("%'d\n", 1024);
results in
'd 

It seems that for this syntax to work as you would expect, support needs to exist in both the
compiler and the libraries used.

Back to your question: there's no equivalent syntax on Windows that provides the thousands grouping.
If really needed (and I understand it is useful for large numbers), we could get the same result
by calling a helper function that would convert the number in the formatted string and use that
in the printf statement.

There is a Win32 API that does that. It takes a string as input though: GetNumberFormatA.
(https://learn.microsoft.com/en-us/windows/win32/api/winnls/nf-winnls-getnumberformata)

We could use ifdefs to keep the old logic on Linux and use new logic on Windows (for all compilers).

Let me know if this is something that would need to be done, or if the current output
without thousands grouping is good enough.
--
Andre Muezerie
