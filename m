Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2DFC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 14:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B2A4402A4;
	Wed,  5 Mar 2025 15:50:27 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B748F40275
 for <dev@dpdk.org>; Wed,  5 Mar 2025 15:50:25 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 04DBD210EAFB; Wed,  5 Mar 2025 06:50:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04DBD210EAFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741186225;
 bh=DzdnqLIn+vHhWQpGjsWFoHiEC+l52vCyHRG815Ujj+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k5dlGSPII1mSsauo0H6oYbyLloZWIYUVB+DAIKxQDiimQ3tMgVOLUpnwqoUcaXcg0
 bIRBMa6ExVrWBZQuwSQwucqZFMgRpR3EOKxv5e8Nte3gFwrQrzzEB9Qza/cGfHheid
 /cPNieSzRnLh6iNZw6xVLimcVbv8YFiaDxR+LkZo=
Date: Wed, 5 Mar 2025 06:50:24 -0800
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, sameh.gobriel@intel.com, vladimir.medvedkin@intel.com,
 yipeng1.wang@intel.com
Subject: Re: [PATCH v2 2/2] app/test: add test_init_m128i using compiler
 intrinsic
Message-ID: <20250305145024.GB32194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1732748278-14796-1-git-send-email-andremue@linux.microsoft.com>
 <1741125199-1217-1-git-send-email-andremue@linux.microsoft.com>
 <1741125199-1217-2-git-send-email-andremue@linux.microsoft.com>
 <Z8gXQylzSC2geGp_@bricha3-mobl1.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8gXQylzSC2geGp_@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, Mar 05, 2025 at 09:20:03AM +0000, Bruce Richardson wrote:
> On Tue, Mar 04, 2025 at 01:53:19PM -0800, Andre Muezerie wrote:
> > This test initializes an __m128i data type using the old
> > non-portable way used until now and the more portable way
> > using compiler intrinsics. The test ensures the resulting
> > values after initialization match.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> > ---
> >  app/test/test_thash.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/app/test/test_thash.c b/app/test/test_thash.c
> > index 33b0c6adac..5f7081a3ad 100644
> > --- a/app/test/test_thash.c
> > +++ b/app/test/test_thash.c
> > @@ -1029,6 +1029,35 @@ test_keygen(void)
> >  	return TEST_SUCCESS;
> >  }
> >  
> > +#ifdef RTE_ARCH_X86
> > +#ifndef RTE_TOOLCHAIN_MSVC
> > +static int
> > +test_init_m128i(void)
> > +{
> > +	/* When initializing __m128i with two constant values like below
> > +	 * MSVC issues warning C4305:
> > +	 *     'initializing': truncation from 'unsigned __int64' to 'char'
> > +	 */
> > +	static const __m128i a = {
> > +			0x0405060700010203ULL, 0x0C0D0E0F08090A0BULL};
> > +
> > +	/* Using compiler intrinsics to initialize __m128i is therefore
> > +	 * preferred, like below
> > +	 */
> > +	const __m128i b = _mm_set_epi64x(
> > +			0x0C0D0E0F08090A0BULL, 0x0405060700010203ULL);
> > +
> > +	if (memcmp(&a, &b, sizeof(a)) != 0) {
> > +		printf("Same value was expected when initializing data "
> > +				"type using compiler intrinsic\n");
> > +		return -1;
> > +	}
> > +
> > +	return TEST_SUCCESS;
> > +}
> > +#endif
> > +#endif
> > +
> Do we still need this patch? I don't think its necessary.

It was important to give me confidence that I was flipping the arguments correctly. I
agree that moving forward this test does not add much value and can be removed.

What is the correct process to do that? Should I send a new series without that
patch or can it be simply ignored during merge?
