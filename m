Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AEFC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 08:47:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 312FD4028B;
	Fri, 17 Jul 2026 10:47:57 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 655314028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 10:47:55 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E144A140007D;
 Fri, 17 Jul 2026 04:47:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 17 Jul 2026 04:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784278074;
 x=1784364474; bh=K1W7prYRA3ZFu1aVpQqPuKdQ+NL3nKqZTv8oOVOQtxQ=; b=
 CM9aQAzN4tiQJL4ovwCoJnZ2Uqu11PZskUF58f8lr/ylCtkK1fUMz7FVCFi7im7e
 hQXbB6DL/P0PIkrkQVtIWbu6KKAJg0mF3jgLHcGJzy7vZlTQhZuvO5RY96v8gCLC
 HFQ+gKoU+Qam82vTzfDZ3EeEOM/sIH0iO07xde/0xfhhl1b5jwd0YK0s0u6BX7jz
 GsFa8LFEQK/YISYFyGltSTFu9dmUW9C4IzIQGN3R9DifXFFxwXrcSSZkTTTDkryd
 GvO+3RPQL0QFHeSxwqfqmKw0aoxfkyAl8/Icq9ZCmtTIIefXSfMJCXW8qrSu9wqc
 koBXk1zwdI3OUWBI6cXEeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784278074; x=
 1784364474; bh=K1W7prYRA3ZFu1aVpQqPuKdQ+NL3nKqZTv8oOVOQtxQ=; b=q
 oz3Pp8tDczNQ1uQBZqCd0KRg4DWyuA0eppJD5JVGvY7SZVgiXw9aXaSkkY35RK6J
 47868ye37ZIJttiL1mD/trTJX4yO5gR8xtjF4BTxcVW0FMJ3TNO9zvf7qMNuuBZu
 sglBNqf+goX1wcC7NXZdTm14W9c0xWo+DZ1PqTbfs9Xq6PANzFQfo0COHp+dq9GQ
 VMkbmAcgIhzZ2JBcyA4gLoiQWZmhEboQ/mWrKJXHr95PzdX8Z441yXFRAUFLamS5
 dekoFABKg8KpNjNFdgxjPAZrEYY1LSmDTxvVnNgoOlRwzbB5xmJvthcnf1ErX6w+
 rDzF/bRPjTQofVXPB4uuQ==
X-ME-Sender: <xms:OuxZalmWnE-yEDKbe3ti1oqJt-tJq18wMWoJWbdYBONvTFv_lHOUcw>
 <xme:OuxZasRHYqvg5ZL7FGbFoOlr41ng5lPZdKvqigqGs-tPFciRfQ1n_KG0J37r6VbDc
 e6sEJYOkV4UBym3F54NwSFIE0k_saa6C01ZR1zkV7x6eqGDKVOEVQ>
X-ME-Received: <xmr:OuxZavK57e0RtShozq-qd3HTdak8xDaZtET-Fcbzq9nSvylabp7LLruWS-q0PT89cmJhiu2T3ttufTAcsw>
X-ME-Proxy-Cause: dmFkZTE/pgmkM2XFz3lWUqfrLT+H1BOwVlftEgnLBEOgPhq6O3yFwRTm5HXzs1kvwCNkMY
 MdBZaJNG2/llLK5S8e8zx0wWYMwLfgIS3p3AssTP5qLjMp6cJi6QDqxNr1Y6TM2dfApkjd
 s7OKNNT0bedKxMRERwqkc+sK/gwxCJ55RPFs6LLuv0/Phep/1ceyall7+Em3THLZMBtayN
 Jk4rVfzjcQ8n2BhdtSF6dYbf8LWQDXpbWTSfNtrYfZctCH0WNJSNsEqr7km11a71wdKMr4
 i7hjqbXGph4ixeHOyVYqMBy40WqKLRsZ7cTzjlqq+mNNokzX3pL92wC1FNJT2s8S0JveNA
 XX9mhhI5uWRkWa87KSply3adTTBvIaGwD+D4kiGSaAxfEOsRo+hHyUo84HZ6MyXbOWwRj/
 6XteQao9HDRpIptfxj2oaQV+QwH+AP9BzqZqxxq1j/uucCDChTC2b0VMJ87F9c2MN90JHd
 SLYwJej1P5P6QsWTLHay2/pa/yQnfZPDpEOevaYxIDGhx4HpVyAafN3fJZ+zWe9epkuYQS
 N0+HiFemVtQ3Utr0mqPaE3r3rlzHeFDzmSKrN8POwU3iVk4b8AtCk3FqrtiFv1SPUQQE9/
 qBuy3d89xgUwAfXGRNLxCt9r+K/R/Bsad6uMQftHEXpBs+EHW3uZqW1JGg0g
X-ME-Proxy: <xmx:OuxZaqB-jEWPGZnjoFM_hczAgh8TROo_J839j-H-TuHmf9HkrOUgJQ>
 <xmx:OuxZagA9KPXCexRAsOx8VEy-w3sZl9j9XzfqnA3Km4NEBv2_tPlEhQ>
 <xmx:OuxZakAjkUodF7aVezXhJgOlEQEPKLDD6cJ2UI6l3Q21AU56JTDaJg>
 <xmx:OuxZajo_jVml1Ann6YASuH5XcFenCmz69GdsqbisA2rfEbMI4dXCCQ>
 <xmx:OuxZagz_M_IV32-ixTVCTV1O_Az8m-qBBpE9KAoVZ1pX52gCgiSfV6Yy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:47:53 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chris MacNamara <chris.macnamara@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH v1] doc/guides: update monitor PMD mode description
Date: Fri, 17 Jul 2026 10:47:50 +0200
Message-ID: <pIqnrFoZS-utStOxQPalPw@monjalon.net>
In-Reply-To: <20250221105005.40567940@hermes.local>
References: <20250221165440.832528-1-chris.macnamara@intel.com>
 <20250221105005.40567940@hermes.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

21/02/2025 19:50, Stephen Hemminger:
> On Fri, 21 Feb 2025 16:54:40 +0000
> Chris MacNamara <chris.macnamara@intel.com> wrote:
> 
> > A recent CPU change requires an extra enabling step for
> > the umonitor instruction on Intel CPUs.
> > This is now detailed in the l3 fwd power manager doc.
> > 
> > Signed-off-by: Chris MacNamara <chris.macnamara@intel.com>
> > ---
> >  .mailmap                                          | 1 +
> >  doc/guides/sample_app_ug/l3_forward_power_man.rst | 5 +++++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/.mailmap b/.mailmap
> > index a03d3cfb59..c4bc38752f 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -263,6 +263,7 @@ Christopher Reder <christopher.reder@broadcom.com>
> >  Christoph Gysin <christoph.gysin@gmail.com>
> >  Christos Ricudis <ricudis@niometrics.com>
> >  Chris Wright <chrisw@redhat.com>
> > +Chris MacNamara <chris.macnamara@intel.com>
> >  Chuanshe Zhang <zhangchuanshe@icloudshield.com>
> >  Chuanyu Xue <chuanyu.xue@uconn.edu>
> >  Chuhong Yao <ych@panath.cn>
> > diff --git a/doc/guides/sample_app_ug/l3_forward_power_man.rst b/doc/guides/sample_app_ug/l3_forward_power_man.rst
> > index 3271bc2154..d0af28e0ec 100644
> > --- a/doc/guides/sample_app_ug/l3_forward_power_man.rst
> > +++ b/doc/guides/sample_app_ug/l3_forward_power_man.rst
> > @@ -293,6 +293,11 @@ and has three available power management schemes:
> >  ``monitor``
> >    This will use ``rte_power_monitor()`` function to enter
> >    a power-optimized state (subject to platform support).
> > +  On recent Gen 4 Xeon Scalable Processors the umonitor instruction
> > +  is disabled by default.
> > +  An additional step is required to enable the umonitor instruction.
> > +  Writing 0 to bit 6 of register 0x123 will enable umonitor.
> > +  `More details are available via Monitor and Umonitor Performance Guidance <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/monitor-umonitor-performance-guidance.html>`_
> >  
> 
> This should be done by the power library, what is the point of having a power API
> if we require applications to test for CPU type and go tweak some CPU register bits.
> And it may be restricted by OS permissions etc.

Any update please?



