Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044DB606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FpJU1BYy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8682A402BF;
	Tue, 17 Nov 2026 22:04:33 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTPS id 1F152402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 22:04:32 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2efef1516b5so1299485ad.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794949470;
 x=1795554270; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RIxCye6o8uOtmfk5GmrV9+Y8UwzCCXrkussgvHlIvM8=;
 b=FpJU1BYyGCAcuRM5atDku1nGLsqaCnIGEA36+fTOd8XpnBL7zLb4N+iwJzIIpWUpyZ
 vclk+G2+grzo0qW3aCqsOjnPqmWN/na+iDmpuqf4YEqlXiwjNaGGCHnYvZr87BHwnKbJ
 /G6x6jjPbbhFBmMnOPjNt1/lfpuggllvdEJWQSK+ZHE5bW7NCoY+0XVHQ3DFL48exh2y
 t/hQWJJlEAUjvKeAlak0BBqg2g4O0SSALfb5ipgJ/W8fROyh5FXjduy1GnRogET1x1Qc
 rG0/qMlSk3cUtq9ZVGKjKPNtPnWEFDCvT5MkscS09OId2ZX7Qc10j19S+f8XibZcEeGr
 6CUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794949470; x=1795554270;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RIxCye6o8uOtmfk5GmrV9+Y8UwzCCXrkussgvHlIvM8=;
 b=zg3m9NOkba2teTd+Wj1fT6fD1m3tWVyfCcaKy/Wdk0F/4VGQz+8/1vPVu6fBLq2OHP
 kL0a9MDj4ZW4gYa3m81i+NdlxHHW72Khw0/tckMAcXWsW0jedw5J20LBFCY9FgulbeiC
 Jl9u4HC4P8wgdOjHpwL8f1CvUjE9ry5ltl5a3zHlhDodkOJJdKtrh3w4Hj8flWhqmCHQ
 sdksLnnDSqwwMm75uK2NahNmKBxr3jdwTbNH4gMXL61gJL0A7mmejw1YSTCamr/1QZ6w
 mSmEzCwT9bzg98PVLRCZWASzznWb1OsiLKFvyuwht9mHgDcX8oCvtic+MKCS1HPh0uir
 aofA==
X-Gm-Message-State: APuU4Z/IU+gKoALzKSwS28aBwwMrc44I/YhkoRYh2Dp3NEsxD7DkePYV
 HlVoB7tJX+vxfvF1o7FVbmaOcHhNsRrf0/v8TrVnl7KUCUWfN+80018wEqq5Fm8MVkk=
X-Gm-Gg: AZFdTZdmhvxA5/dqhvXch37LBcrtilzuNwUc9fAFx8ywdoilEszW7jzJAt94ygVM3n4
 kt4b9+wkFVpZxyOmNCX9N06VeXUC+gmBqDBiTEUyTnYM2KrFtVkiN4V82HikSrkVqyinI7fx2Pr
 jKLK5IydVJ4kUg8y2xI3LzLiObo+3pNjHRnjx37FlsEgAdtQRD6dcwSEbTtMpBs6hF5JpLoe9aD
 1p2Tj2RPA196aEJbf6JGk2skfXtdOPHluPLkQMasGHh6V7GEwvvXsjFRzH1ir9v0jq0IyWXo/TZ
 8i/IbhlKrxA68Udgxd6q2VqM3E+p6uQikBEuEERSqOCRASBTk6nPheOOOxLYZaXur+LCVR1Cki1
 LfhNMoAgESWdoZk3F55GABUp2JZJ0pcOtrg74wbp/3McYP3InrFLDFvi/MT6TcSs0zyCgQbKVA8
 0zdxyFEx1Rgkn94zvpeJkT8yKs5y8w4DUWzBW1oxwqtPkpxtXp0SfNul9bWcCuI3aiE6vZpaD4d
 PrIOy4SoWSQPQDt9YWtuah0wGF5ikXlS1TwhWlk6esFiFVg+w19hl3GwxBsP4Vyu8k6S9Q2K285
 cuX8/YpR3K1Y9EV6Q3uELBKsKnoTJ5lP3OMU4lJrLedY5LOJ5QU6QDf7tdpN2xQQVPQXcPa9Dw=
 =
X-Received: by 2002:a17:903:8c7:b0:2ef:f3df:7d7d with SMTP id
 d9443c01a7336-2eff75632eamr4676415ad.51.1794949470354; 
 Tue, 17 Nov 2026 13:04:30 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff6214565sm2529785ad.42.2026.11.17.13.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 13:04:30 -0800 (PST)
Date: Tue, 17 Nov 2026 13:04:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH] eal: silence unreachable code warning
Message-ID: <20261117130427.36f2c01d@phoenix.local>
In-Reply-To: <avyoOHd2QAf6aoo7@bricha3-mobl1.ger.corp.intel.com>
References: <20261117174059.736244-1-stephen@networkplumber.org>
 <avyoOHd2QAf6aoo7@bricha3-mobl1.ger.corp.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 19:17:12 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, Nov 17, 2026 at 09:40:59AM -0800, Stephen Hemminger wrote:
> > Clang evalutes strlen of constant string at compile time, then
> > complains about unreachable code. Use extra parenthesis to
> > mark code as explcitly dead.
> > 
> > Bugzilla ID: 2135
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  lib/eal/common/rte_version.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/eal/common/rte_version.c b/lib/eal/common/rte_version.c
> > index 627b89d4a8..62572428fc 100644
> > --- a/lib/eal/common/rte_version.c
> > +++ b/lib/eal/common/rte_version.c
> > @@ -36,7 +36,9 @@ rte_version(void)
> >  	static char version[32];
> >  	if (version[0] != 0)
> >  		return version;
> > -	if (strlen(RTE_VER_SUFFIX) == 0)
> > +
> > +	/* extra paren to silence unreachable warnings */
> > +	if ((strlen(RTE_VER_SUFFIX) == 0))
> >  		snprintf(version, sizeof(version), "%s %d.%02d.%d",
> >  				RTE_VER_PREFIX,
> >  				RTE_VER_YEAR,
> > --   
> 
> Is it guaranteed that the checker won't look inside the double brackets? An
> alternative suggestion is to change RTE_VER_SUFFIX to the function call to
> the (public) API rte_version_suffix() and use strlen on that. We can even
> mark the function as __rte_noinline to avoid optimizer getting rid of the
> call in future and reintroducing the warning.
> 
> Also, when fixing this, I think it would be nice to also fix the indent of
> the else leg.
> 
> /Bruce

Clang suggests it as a fix so I think that should always work.
Gcc unreachable flag is a noop, the compiler structure makes it too
hard for them to do the analysis.

Ok, can fix the indent as well.
