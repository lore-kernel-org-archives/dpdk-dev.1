Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C4606D810
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=hlCmdj/V
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6994A40E09;
	Thu,  5 Nov 2026 21:32:28 +0100 (CET)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 00A2D40DD5
 for <dev@dpdk.org>; Thu,  5 Nov 2026 21:32:26 +0100 (CET)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-5351d76e1baso12625071cf.1
 for <dev@dpdk.org>; Thu, 05 Nov 2026 12:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793910746; cv=none;
 d=google.com; s=arc-20260327;
 b=KEvuMslqusYgJ80OZEjegbVFXqn0EnhTlic/lAfF73/AzasUYSFMa3MgUHO8iL6li2
 O1o+DSHS6s7G6gJ2ahkiHhHxie6qWBsCUGJ8LCVH3LxbrBCshZfZm+B5urftUO03uieV
 73iev8LJtl2MJlblTQbgy/H2YPQcv9f9o8LJKZxE6AxDfl03gwvguX/qt2LRcGcU8A+h
 H/3lJics+QoEsePAT3CYLcpZb/mt70SXofbe9XoESDwaPnmjQsHiqHWaxB06tuGcqPwy
 h433qHziGOl4+8yM8/pMg3N2upFcu330PZ/z2BlfEhv3hebThgIsuRmVJWJaThT2hvCk
 Z6xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=B3WXBWHmP9mxr1ZGW6lKYpVOzgf2qO2wGFKAbeNvHPE=;
 fh=xdX1C97w2Tl5Q/Lkb3AW9aWTs9th+3N5BSCNfzEFzR8=;
 b=pVrz0CxDmYmIArzwD3raD3hhK1u7q4TzEklO/a4FkEde01sD25eAZC0XIBYXOMYsbZ
 m4Zw3weVfbOU9rHuUjPsp6S24uEZQxtd37ol99Lo4u9bpe7zKouOYIFrR0EWHF2bRaRl
 NVqkY3zRkeB5BD0ixsxWhAnp5VfwG8D1KWsncax+mEDh4trhJ/tjVGbF70J0nGRz0EwY
 f/U3xQh3fR5+8Hxo0wGXudjHbxFiGVl1OjK8+eN4wCoBFEKEbXwHpr59weckfSu/5BWZ
 zi/NpvMT9rLLU0GNCvgBLuIRt4Fr/QSJ/w3IpFL+cuiY1FRvgLo2lbkVaerRVlQ91Fzm
 d4JA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793910746; x=1794515546; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B3WXBWHmP9mxr1ZGW6lKYpVOzgf2qO2wGFKAbeNvHPE=;
 b=hlCmdj/VJa/Cb+xNm8gt5asOKJjurLagi4rM854Jg6f3pYICbhKQzo1/8MGZnLnwJq
 9vEMggGyM1WvJhzLQ24htpGRD8Pd7fly2UZK2nneKso7vrkCnZZt9cdt27hs0KRmr5ed
 WHuHkRjPWXH3OfA/pzr7DzL0hjvjxQtxz2p4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793910746; x=1794515546;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=B3WXBWHmP9mxr1ZGW6lKYpVOzgf2qO2wGFKAbeNvHPE=;
 b=psRJjEhjMyvgHibtu7tqMRzfbA5tlYF9KravGL99mL0Qn4THzaKLUockVcsiV757mw
 C9WMZ9+N0TsA7MzzYrI1StxBSlGr7jZqAEHJfaLxbIlfqsyFXuRVihOXfjuHG0rG0B/9
 0jx5MV418N4iYEDpZIfV0aWO8xHfo6KGsxSqp1AvoWNBDM/NKJVJ5Wrl0eCXqVY6mgcd
 QfVj9veMCJyGYVEzxCVmIHW98/Oi7YJ1U4PDPvBI7ltjo+0cCSnzR+78IQKXmC/inFpX
 tE0qJt7mzN75ts0YS0eZoKZNGYI63j2wgokMqOLhyY/sMf/hk9ZkcuCqwt09r1GYH+Ee
 SyMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBws9gHGIoxy8F99bHud5CDHT0+GY2Q9+ROMkqGSUHdkASTUkv7vlK6wZqfCjr/7mdPndnw=@dpdk.org
X-Gm-Message-State: APuU4Z+/gOqwKaoTicD5NCe2HcCSEbx8HiWXZ35xoZ9ReLpkSFe/hoPs
 IgT+JJ+8Vf5/9tzJ0bKRdVO3YSwnSPAXlaN38/j/22ETZ7jXgC3XcPnOMUpuIaWyMkaUxPYhL3M
 LLmUAxCxhgimuesZ7uv/jx9q9ud+A28dYRMxBCKCXfg==
X-Gm-Gg: AYBFou1Sh06oha5nwq7ko49eul0+JOSGNdqaI0TVqmM4PvTZuJoeHGgFA2h0TuOXjtG
 mFmWUffTtTBT4fZf7zBbFD8+U3QChUwFfwDv8mHDR7qHVfxPQBpS/nkh5+/h+/nDU9tqMK8PEMB
 2XCCnLs1kiOjnhGgGefZj/Qg4tzZ3MEYXOr1kVHqkxYdO/pkdCKZVBnctVCRUQwGw/H5RnUazUl
 +nlBnAO82Shugxx7dv2IWc6DfBcNi0ys0RFrymtT60/P7NSQnsamasCT0mMTL0z1c5sWWfKeM/C
 cy6noafDxr9nQcQgtd+5W6f79Mb72J9E50tIfz8alh6q3/QNOLiEWjhh0qKWlqnIT9y9yUaWEX/
 PlhrKt7l65Uk81hXka5eUMVglUlZp8zynMkXaIbNhW/lgrALeEUbk0D0BHnULizJm8vrcR+KAo6
 ClyQcCFsBu5FqzZev0P2k9EMaiYE+TjU6woSCf832nVU5dsULKHCuWLxlPOMB4QVh5PbUjwt9hH
 RPJjzzqzB7VOzK3hYjSJPFPg1Hb
X-Received: by 2002:a05:622a:3cc:b0:535:a5f7:d594 with SMTP id
 d75a77b69052e-54c9c72cccemr59818441cf.35.1793910745748; Thu, 05 Nov 2026
 12:32:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105174137.498850-1-dladd@iol.unh.edu>
 <20261105200413.513618-1-dladd@iol.unh.edu>
 <20261105200413.513618-2-dladd@iol.unh.edu>
In-Reply-To: <20261105200413.513618-2-dladd@iol.unh.edu>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Thu, 5 Nov 2026 15:31:49 -0500
X-Gm-Features: AclHuK8Xkag-XyrIXWwKIc_hkVxh2S9rnBOhQ7PVVT01y3KIH6JVj6SJESLgYL8
Message-ID: <CAKYPG+wrWLA-8_9La=-reBgWUyoStWvKyf1L2_J2nKWkv=TUNg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: add eventdev pipeline performance test suite
To: Dillon Ladd <dladd@iol.unh.edu>
Cc: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, dev@dpdk.org, 
 abailey@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000c26381065f8d640b"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000c26381065f8d640b
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>

--000000000000c26381065f8d640b
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><span class="gmail-il">Reviewed</span>-<span class="gmail-il">by</span>: Koushik Bhargav Nimoji &lt;<a href="mailto:knimoji@iol.unh.edu" target="_blank">knimoji@iol.unh.edu</a>&gt;</div>

--000000000000c26381065f8d640b--
