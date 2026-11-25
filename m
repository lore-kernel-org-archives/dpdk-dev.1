Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D1606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=aXqf/D40;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cP3JwZsz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1319E402B2;
	Wed, 25 Nov 2026 12:38:32 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTPS id 813954027A
 for <dev@dpdk.org>; Wed, 25 Nov 2026 12:38:30 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D1DF71400406
 for <dev@dpdk.org>; Wed, 25 Nov 2026 06:38:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 25 Nov 2026 06:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795606709;
 x=1795693109; bh=mDFONEmn6lCJX8jmcSWsmufc4gkym4o6P7SrzA8/XKc=; b=
 aXqf/D4091it3s7nh0jNvhKBdbVA5F7xl0xsW56lLorG0JBs7kugxj7TK1gkk0AO
 HfZ6aGoExXuT/GVAxypZZJmXX6BmB2CJ5/zpCajvsJgA5D3VMHDVczk7p2gs5caL
 sztKpcMgwuhfp/JXwZewVyQ+u0W+878EIxltT6hShbu+c8hiMfc54kq6etJfbju/
 ubH5BTw3mWYcMx2UGI26fE0h/g8OyC0MrCwucL2bXhV3KkVmpUf2k1fDRqC1ti14
 rAFB+2J3efGTQnXbRgNv6253wim2Cvc0IV7xTISsgYaafcDLMD+Yfvzwni5I0GRJ
 Hbq1fG91rdN/T1GzkEwJYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795606709; x=
 1795693109; bh=mDFONEmn6lCJX8jmcSWsmufc4gkym4o6P7SrzA8/XKc=; b=c
 P3JwZszGmZuwceM0/Fh0eLFFGXB9P7RxwdbRQnsiDhN3vxi4WNqxE8WOhcYY2A+l
 b0v2JxDrBe2xNu6+0AQmgqOsifhll5QMCkdvbiSyOE6Qo3HJYBHWCGlhdIHeW+/o
 YYoUbfFpRasfdyNNoWrxj5a0vZjVTqp5/zJv1cU4+IpJjwxzrnHUCxaqp4Y5QFmL
 TjmA9QsF4AX0hP+lNON82+Z79LU9KbL0PDDEzPOG0UhWn7BIrCne73SKtDYiCPkv
 As1LRnkNtH03GQpQ/aBhBVS7ZgIWpw36L/he6sh0RhArgfOp5E3xWl1Z0/05UcHm
 WJH2dUjMygZpUIk9cOu1w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795606709; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:u/jL82xDjPbfZYKjGzaWhebVw3+htJuG/0OFu5qZvcNapnv
 Qdn45SIk4JDv4lj9yNuKSi9krTGgivty5JWlFZhNCtM0s4ve1ly49+gEhNyEfBga
 V4TQeqKk8LrFaliNLRmyMv1PyEgVE+Q03m/WKjy3nWWqfvJDSpVBzlkmqF/5p4cS
 azRPeFVXZg8eo/NtkpCbHHX0Avm9TMzTx//l0fbHwBdt786473Zm2HKxrh+WiduG
 z+OfnZsKJhI1MFDUcFP1n+CTYB2a8qCSmAtkAkIp5BRuasU193e4DJUtwzFyeZjB
 wtMTdeKI/8p4uXrCTwsgcDxhgBwV7gauJtvYzDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:af1bTHQtcjGWMO8GdllZBSO37Dzg/nhRB9ByJNNT158=:tkvl+lOLd1dOcsCpCYWDYkLGWLYbb3LnHMY3/YJMGXk=;
X-ME-Sender: <xms:tcgGa6XwiraQjxFWcdVIYqwjHuUBNvJ7gG3afJa-nXZuNPwxz-r_1A>
 <xme:tcgGa8lTDFQqNMwLsE_FUXOaawwdiTX1GUkcknv1jYlq8lslqNqXOtETIY-QE5riF
 wlvRgFh9Li24BDk0vPEkNW3iw0lYQQJfLv-qUr6ZKurxywjMTAYQyw>
X-ME-Received: <xmr:tcgGa8A4G5yKl-gB28uV9pEVEhBQaVWeTXOujTFY-a2H3vbnuLxpr0z4-2YWiohTvUjimXM7yDprwZxVcM1yX34>
X-ME-Proxy-Cause: dmFkZTEEzPwXM6/u5Q2/X/mXPZNgpqj0vxf7CkHcPT4O9QbiEOIiXEgnpCouyinzqBNLjY
 S/su1AeXsLYnXMjo4EVOVX4nWKdZQPVOm8EchlME4fEh4f+y53owFI17PEiqIp6RtKZz4Y
 JciZ/DRo31HAw8hjYt68o9Jgbxa3OFyFhz7pi4wgvWIPOgTI+YWAZvAbTWL6lrJwAVnSQp
 0rUix6ZIfd0DC63iue3tHxcPYPGXXljNGXiMZjzqKirT74HKvVECHVYd+VlSYUPg8X4jzU
 nyGoRgKfqcJ1T0CfEUvdKP+4v2uTCeWQ4BWuephopRjkrYJH97wottgOVZhrpgkEij0OlB
 jk4QAiSXkAuWPaQ9ROFIyvQiuzgFuEonSaUP3o/chBhYo+g9kc5KsZ1UY4hyhDWJkUA9mh
 gLrQRrVIqKIT9ataN5P7IUie80H03vpx7MKtMCDLzKOp6+t+MvoJU83xAIY8K4rYHxyLcm
 tuU1Y5vW3EFzbVktXgk/AsA1wB57iOofMZzo8phraT3vECMWI0DCPjhH+cBi31UKnFKP5p
 jsF8I1REQbo2SWRt4IpMTHu+9FMondNpknQT3DBgu5fOA5jo624613R10xUqGi1WAyAeh8
 FfrU6bW19Z+WkCxY3HkJ+nORVgwqAqO/+euG3S4+OY+CnQgv2qQdMBobyVqw
X-ME-Proxy: <xmx:tcgGa8fybeUEb7ZewnB28pg3Jof1VRcQOYydK96u0Aoj9Qdx_v7G4Q>
 <xmx:tcgGa3KmKcOAROlq4wmeL79SPVXdlD0CvR8bDoL63EL64F-_bkqsZw>
 <xmx:tcgGa_c19m7lcV2lcMLa5kWcFkY2Jdth2w-hsgOeq5s63qG6LeV4TQ>
 <xmx:tcgGa-2WmUA8WGCnwCHlZ_wvlWIgkIj_72ZnuMqb7w96Dl-GPzVANA>
 <xmx:tcgGa05pBll_tXU5SAT7yfgyWj0SRGHqOpI3k6cg6qjXqYTzeA2ZLFO->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 06:38:29 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Riley Fletcher <rileyf@linux.ibm.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: Power11 results for tested platforms
Date: Wed, 25 Nov 2026 12:38:28 +0100
Message-ID: <hviG55ybR-iHlmUlXcXfnA@monjalon.net>
In-Reply-To: <20261119154604.281229-1-rileyf@linux.ibm.com>
References: <20261119154604.281229-1-rileyf@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

19/11/2026 16:46, Riley Fletcher:
> Power11 testing results for 26.11 release notes
> 
> Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>

Applied, thanks.



