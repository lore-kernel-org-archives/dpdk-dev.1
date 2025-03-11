Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDBEC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 14:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B6E84027F;
	Tue, 11 Mar 2025 15:39:51 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6E01840263
 for <dev@dpdk.org>; Tue, 11 Mar 2025 15:39:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 80C70211142C; Tue, 11 Mar 2025 07:39:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80C70211142C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741703988;
 bh=U7GM0FYq+fn/cQjOvf+xiAX8lyPNKANmy+NKE4Totsg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H8iIbzqR3k9LAipvIj902fcmlBXBc6NFWIAOpLuC5QH8WF31hYfxqWxAamXDv3ExR
 z7hELJ91c8VKupIHzcbLPW+psXqbenAfdekiX3rTOoQhVzLN+x3eFYvVdAEQwoMjB2
 o4sfTFGM0X8dn+IuG9ZNAta2HmNkPFGDBtkOSrXw=
Date: Tue, 11 Mar 2025 07:39:48 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org
Subject: Re: [PATCH] hash_readwrite_autotest: fix printf parameters
Message-ID: <20250311143948.GA16011@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <Z8q16Ikzl4_flbpK@bricha3-mobl1.ger.corp.intel.com>
 <20250307223401.GA27687@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z87ER_iHAgTw1wuO@bricha3-mobl1.ger.corp.intel.com>
 <20250310083640.46df23bb@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310083640.46df23bb@hermes.local>
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

On Mon, Mar 10, 2025 at 08:36:40AM -0700, Stephen Hemminger wrote:
> On Mon, 10 Mar 2025 10:51:51 +0000
> Bruce Richardson <bruce.richardson@intel.com> wrote:
> 
> > On Fri, Mar 07, 2025 at 02:34:01PM -0800, Andre Muezerie wrote:
> > > On Fri, Mar 07, 2025 at 09:01:28AM +0000, Bruce Richardson wrote:  
> > > > On Thu, Mar 06, 2025 at 12:03:28PM -0800, Andre Muezerie wrote:  
> > > > > Compiling with MSVC logs the warnings below, which result in
> > > > > build error:
> > > > > 
> > > > > ../app/test/test_hash_readwrite.c(73): warning C4476: 'printf' :
> > > > >     unknown type field character ''' in format specifier
> > > > > ../app/test/test_hash_readwrite.c(75): warning C4474: 'printf' :
> > > > >     too many arguments passed for format string
> > > > > ../app/test/test_hash_readwrite.c(75): note: placeholders and
> > > > >     their parameters expect 2 variadic arguments, but 4 were provided
> > > > > 
> > > > > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > > > > ---
> > > > >  app/test/test_hash_readwrite.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >   
> > > > IF the "'" character is not supported, is there some other method to do
> > > > thousands grouping in MSVC?
> > > > 
> > > > /Bruce  
> > > 
> > > The problem exists with all compilers I tried on Windows:
> > > 
> > > 1) MSVC logs the error I mentioned above
> > > 
> > > 2) GCC and Clang don't complain at compile time, but don't honor the "'" as a special
> > > character. As an example,
> > > printf("%'d\n", 1024);
> > > results in
> > > 'd 
> > > 
> > > It seems that for this syntax to work as you would expect, support needs to exist in both the
> > > compiler and the libraries used.
> > > 
> > > Back to your question: there's no equivalent syntax on Windows that provides the thousands grouping.
> > > If really needed (and I understand it is useful for large numbers), we could get the same result
> > > by calling a helper function that would convert the number in the formatted string and use that
> > > in the printf statement.
> > > 
> > > There is a Win32 API that does that. It takes a string as input though: GetNumberFormatA.
> > > (https://learn.microsoft.com/en-us/windows/win32/api/winnls/nf-winnls-getnumberformata)
> > > 
> > > We could use ifdefs to keep the old logic on Linux and use new logic on Windows (for all compilers).
> > > 
> > > Let me know if this is something that would need to be done, or if the current output
> > > without thousands grouping is good enough.
> > > --  
> > The thousands grouping is incredibly helpful when working with large
> > numbers, but given the lack of support for this on Windows, we'll just have
> > to go without, I think.
> > 
> > /Bruce
> 
> Maybe some variation of the pretty printing code that iproute2 has
> (see print_num) would be useful. Feel free to reuse it.
> I wrote the initial version.

That's an interesting suggestion. I'll use that.
