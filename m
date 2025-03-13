Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E877DC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 14:06:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDCBA410E3;
	Thu, 13 Mar 2025 15:06:33 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id A8B0840FDE
 for <dev@dpdk.org>; Thu, 13 Mar 2025 15:06:32 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9D90B210B176; Thu, 13 Mar 2025 07:06:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D90B210B176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741874791;
 bh=6phbF/sAZRKKPv2myqnScnyOJ38ojbAjeZD2U6u6aQc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jkqhjd7mIpjJMIs9nPxbh0WBPTUGL5c8tQiThbsDWNznsCbZhXDgaBRBimlUiWOEm
 RcB7yDGBNdQiD2/k6WfN+mo5OJ/ybWMqmp8jnHXzl2BvjA0jUir26Wl02pUUxb8Tl2
 h0Ec74jTzs6387PSgCQUBNhDe05IqKNzEedvSGV8=
Date: Thu, 13 Mar 2025 07:06:31 -0700
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, sameh.gobriel@intel.com, vladimir.medvedkin@intel.com,
 yipeng1.wang@intel.com
Subject: Re: [PATCH v3 1/3] eal: add function rte_size_to_str
Message-ID: <20250313140631.GA14053@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1741291408-26509-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-1-git-send-email-andremue@linux.microsoft.com>
 <1741807714-26748-2-git-send-email-andremue@linux.microsoft.com>
 <Z9K2cdB-nL9CSXaP@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9K2cdB-nL9CSXaP@bricha3-mobl1.ger.corp.intel.com>
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

On Thu, Mar 13, 2025 at 10:41:53AM +0000, Bruce Richardson wrote:
> On Wed, Mar 12, 2025 at 12:28:32PM -0700, Andre Muezerie wrote:
> > It's common to use %' in the printf format specifier to make large numbers
> > more easily readable by having the thousands grouped. However, this
> > grouping does not work on Windows. Therefore, a function is needed to make
> > uint64_t numbers more easily readable. There are at least two tests that
> > can benefit from this new function.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  lib/eal/common/eal_common_string_fns.c | 44 ++++++++++++++++++++++++++
> >  lib/eal/include/rte_common.h           | 31 ++++++++++++++++++
> >  lib/eal/version.map                    |  3 ++
> >  3 files changed, 78 insertions(+)
> > 
> > diff --git a/lib/eal/common/eal_common_string_fns.c b/lib/eal/common/eal_common_string_fns.c
> > index 9ca2045b18..4cc7f35652 100644
> > --- a/lib/eal/common/eal_common_string_fns.c
> > +++ b/lib/eal/common/eal_common_string_fns.c
> > @@ -4,6 +4,7 @@
> >  
> >  #include <ctype.h>
> >  #include <errno.h>
> > +#include <inttypes.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  
> > @@ -87,6 +88,12 @@ rte_str_to_size(const char *str)
> >  		endptr++; /* allow 1 space gap */
> >  
> >  	switch (*endptr) {
> > +	case 'E': case 'e':
> > +		size *= 1024; /* fall-through */
> > +	case 'P': case 'p':
> > +		size *= 1024; /* fall-through */
> > +	case 'T': case 't':
> > +		size *= 1024; /* fall-through */
> >  	case 'G': case 'g':
> >  		size *= 1024; /* fall-through */
> >  	case 'M': case 'm':
> > @@ -98,3 +105,40 @@ rte_str_to_size(const char *str)
> >  	}
> >  	return size;
> >  }
> > +
> > +int
> > +rte_size_to_str(char *buf, int buf_size,
> > +		uint64_t count, bool use_iec)
> > +{
> > +	const char *prefix = "kMGTPE";
> > +	const unsigned int base = use_iec ? 1024 : 1000;
> > +	uint64_t powi = 1;
> > +	uint16_t powj = 1;
> > +	uint8_t precision = 2;
> > +
> > +	if (count < base)
> > +		return snprintf(buf, buf_size, "%"PRIu64" ", count);
> > +
> > +	/* increase value by a factor of 1000/1024 and store
> > +	 * if result is something a human can read
> > +	 */
> > +	for (;;) {
> > +		powi *= base;
> > +		if (count / base < powi)
> > +			break;
> > +
> > +		if (!prefix[1])
> > +			break;
> > +		++prefix;
> > +	}
> > +
> > +	/* try to guess a good number of digits for precision */
> > +	for (; precision > 0; precision--) {
> > +		powj *= 10;
> > +		if (count / powi < powj)
> > +			break;
> > +	}
> > +
> > +	return snprintf(buf, buf_size, "%.*f %c%s", precision,
> > +			(double)count / powi, *prefix, use_iec ? "i" : "");
> > +}
> > diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> > index 386f11ae40..781c56adcd 100644
> > --- a/lib/eal/include/rte_common.h
> > +++ b/lib/eal/include/rte_common.h
> > @@ -14,9 +14,11 @@
> >  
> >  #include <assert.h>
> >  #include <limits.h>
> > +#include <stdbool.h>
> >  #include <stdint.h>
> >  #include <stdalign.h>
> >  
> > +#include <rte_compat.h>
> >  #include <rte_config.h>
> >  
> >  /* OS specific include */
> > @@ -919,6 +921,35 @@ __extension__ typedef uint64_t RTE_MARKER64[0];
> >  uint64_t
> >  rte_str_to_size(const char *str);
> >  
> > +/**
> > + * Converts the uint64_t value provided to a human-readable string.
> > + * It null-terminates the string, truncating the data if needed.
> > + *
> > + * Sample outputs with "use_iec" disabled and enabled:
> > + * 0 : "0 ", "0 "
> > + * 700 : "700 ", "700 "
> > + * 1000 : "1.00 k", "1000 "
> > + * 1024 : "1.02 k", "1.00 ki"
> > + * 21474836480 : "21.5 G", "20.0 Gi"
> > + * 109951162777600 : "110 T", "100 Ti"
> > + *
> > + * @param buf
> > + *     Buffer to write the string to.
> > + * @param buf_size
> > + *     Size of the buffer.
> > + * @param count
> > + *     Number to convert.
> > + * @param use_iec
> > + *     If true, use IEC units (1024-based), otherwise use SI units (1000-based).
> > + * @return
> > + *     Number of characters written (not including the null-terminator),
> > + *     or that would have been required when the buffer is too small.
> 
> Just one further minor query on the API return value.
> 
> While this is a good return value for handling error cases, for
> convenience I wonder if it might be better to have the function return
> "buf" or NULL on error. For basic usage where the buffer is known to be
> sufficiently big, that would allow use inline in printfs/logs, rather than
> requiring a separate call e.g.:
> 
> printf("Value is %sB/s\n", rte_size_to_str(buf, RTE_DIM(buf), value, true));
> 
> WDYT?
> /Bruce

That's a good point. Given that this function is used specifically for converting
numbers it's a valid assumption that the buffer space needed is always known and
available. It's not like snprintf which has a more generic use.

Allowing this function to be used inline would be nice. I'll make this change.
