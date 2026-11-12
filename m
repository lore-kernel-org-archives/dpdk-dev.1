Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C740606A332
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=rGtLG93s;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=SlO3i6di
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0054A40682;
	Thu, 12 Nov 2026 15:28:46 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTPS id 5134A402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 15:28:45 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 501FD1400076
 for <dev@dpdk.org>; Thu, 12 Nov 2026 09:28:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Thu, 12 Nov 2026 09:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794493724;
 x=1794580124; bh=cJH6453DCbufNqRD0evRrTRMXdbaW//VeZ1h+8HxrkE=; b=
 rGtLG93sgZOMQRS8MNfMcEHNvys+IUm5Z4+tcZsrnt4gHiUEmg0A1GceFzK2NE+t
 BTqcjlR6H+FgRJxAOyXkF2qMPQDY/FdOgqL86a+PQdQaqwCVZnUmV4EOAn1pVsCd
 TzGrynBEWAWUVxAVSlkzf6P7MyCbAHtz6z9FBUEOnK/UcTdRVZD4y9a1TeUSgySH
 Q7618dK0XSVzdUDPfIhAoYKeHypjCxt4twHUR4kJ9tb8Mg8ZBUQT+GJ+saCbX0IG
 Ix2AkqOiNm8YDHLoyzvOxSKX8jg8lko7bbt463vE7x4QBQmBOBJRQfAKAN2Ht9IH
 Q6MPZNqX1cxtFzqmEcACZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794493724; x=
 1794580124; bh=cJH6453DCbufNqRD0evRrTRMXdbaW//VeZ1h+8HxrkE=; b=S
 lO3i6diXstioHM+hrlU6BoGDGuZn5tElaHDd3YRPMJY2AfO3bt0agJuEwx5oQ1uB
 h7sONpjYB4si/JK4PT5bAss6yZHwft93Pg1M51hj+lxi/kE7PTcS60rZq7UafqBe
 GwKv1A5ONz9izUR4eYoEruQ3eiAomAgG+iFUqGKjYdU62ACz28XWwjAHD8i0+/1v
 0/8FnhZ+dzli12Y4QtQckKbE3GlCm76R5iicvETUFDxPBZyMp0Nj0D5QpTvkjapt
 6RmgHu1C45ZkIeGKmZVRsxo8NRAiVZRSG2mc0O8LAW1Ou6McyDEmvjZEgcqQhPIt
 JvoFgv7ndk3GGgV28MXPw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794493724; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:n4OZfk8sROw77Y8A8To1VANPDphCM4weCkZ5jMXXQVO3yjf
 FF7VU4W8piGOTNP+KxBN64IfewDoXSDX8PX1cBC00Me1nyl+rwumJ+x6AGa+I+aj
 LUOW27pgcPe8Jrx01dWHgovOc+eJG+fuMrmJ5KdU9s6eBBh83Qd3FQB5IH+puDsb
 QfCTPJZbF/FAX9FntEfFcTN4uQEO/OYu11NaMBejn0bkPrJMpF7BEauqKyrhHNxk
 PoUuYQcP7bFEuQUKkVNJ8kH0BzT+QWUoQiLxp3kh+aqGCXOyEbX2odrfHwHGLZMD
 y2XjDdAEpZnapXXSiGximdGLtQx9gb7IzgZZISQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:LH8HNz+obktDa+TgIpD8ZKk+qxdfhvLjiYgOw1Uf9gE=:GhGdyxu1iOawqiO/N7EbDfWq2VFIOmqKTpUHifY7PnY=;
X-ME-Sender: <xms:G831aiYHpXkzgb589KzMK5aawgb4OHhIWeDl0Lqz5rOSEVO1CQm55Q>
 <xme:G831ag19TumBkUh4HMJts3gbXvID_EUHeQI_uPsxcSTKBAEXTowjea5lXI5Stl7FY
 oMnDOTw2HHMQj-vezL75lmQ9J0AnmGdyOGBUCZcn6PPsPc03E3pOj8>
X-ME-Received: <xmr:G831agcArPC_gWRbgPMQ5SNw04_yQ8--IJ8zR0uRryjun6cgFjkoyc2hyhs3qvV4_4UQ7kq1BxkxLxu_iH-Un_4>
X-ME-Proxy-Cause: dmFkZTE6msgdWbCXxgL7mHuGrbA0tCcZXe6RgZCnGvFUSvkM6ezkkXuAQqi/fIYXAWaYAO
 Ts/cUiN60vcNV2eWlNaOz06CGz8/7z+KQlxmCR1yQEkOmG+ddpJ7B3kiVFSkVYtBd0zk/Y
 KbjyaW7o9bZMwVhqI/6KxYGVtUMMrZVbf3XtO5glL6me7Ev1+uTLEsF/JqzOAR2DtTHXAV
 OQCwQcSWw0/Y9jrvmHMQGXZyzOfz/jdzYOuEjR7ErsfqKkenctzT5+RHI5G8DqQpCNsvb9
 RLvq2yfwgVX9/Ss3ET/gPzZemC5L3vc5f7IBPP0Faew986/P3rSrd6Svwp+VFB3lxh3bCK
 2Clsl1yLMcoZ2//6I6sYEWYPClWfJX8EKxAlseoaNLtEm4zFwVAIaAcUgVVpm5H8NUl6aZ
 a7rQuxSTDlwnecVmTWoQ41R7j8sBDHZL5hqAItC3UwDvaH4CkAFJw3YnWf5j3jOXAl9+AM
 30b03/uDst+QJpTkzT0ElJxUzo+eUegqcrEVXiEG/MIeDSUkrkpEihXFD7sbv2EB/NfsNj
 JDLjMS9qf/9AiP02Wh076fsGp2A7WYgJB9LjNz/xzuFjasyNPzHSMPjr3NAf9CNHLbRb5d
 1N0IXXkr5fnMH2np6UGGxq0h46BY93H7sC+55Oc0MtYHSYcRpe1PRr0IhcTA
X-ME-Proxy: <xmx:G831apEz4zTUtGC35O5XliuAe0iJCih2-f8j7d5toNheU2SPs6FFLQ>
 <xmx:G831ap3Nz4-B0J1-pqtjMDpxYeqq3OXakOKEWR0WcLk6FJFjS9DS4g>
 <xmx:G831ahnEkibpgjf1coaM2lOxKVWpoMJ5WWHKsKau2Z2VEWP-oYE2xQ>
 <xmx:G831ap-xzfLpwkusl5uDb5AsNVM1oiuziOSReWq07Jdc6KPdhRT7vA>
 <xmx:HM31aoGpPZrN03IlhukKK9bk4yxGtmHox9OIw5FxQ2KbtwauvE52FzMY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 09:28:42 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robert Sanford <rsanford2@gmail.com>, Robert Sanford <rsanford@akamai.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v3] fib6: fix overflow of tbl8 indexes
Date: Thu, 12 Nov 2026 15:28:41 +0100
Message-ID: <YSn1FbUqShSgHYAm_ywGmA@monjalon.net>
In-Reply-To: <6857425e-6101-480c-ae4d-66b9c96f9e3a@intel.com>
References: <5f260c1a-3f03-4e7d-aa38-15b8d6cdaeff@intel.com>
 <20261103004903.3616661-1-rsanford2@gmail.com>
 <6857425e-6101-480c-ae4d-66b9c96f9e3a@intel.com>
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

> > The trie keeps the index of an entry in the tbl8 array, the tbl8 group
> > number times 256 plus one address byte, in 32-bit variables in several
> > places. This breaks large tables in two steps.
> >
> > In build_common_root(), the index returned by get_idx() was stored in
> > an int. Once the tbl8 group number reaches 2^23, the value goes negative
> > and is sign-extended when converted to the uint64_t index passed to
> > get_tbl_p_by_idx(), which yields a bogus table pointer. With random /128
> > routes and 4-byte next hops, adding routes crashes with SIGSEGV in
> > install_to_dp() after about 640,000 routes.
> >
> >  From tbl8 group 2^24 on, the index no longer fits in 32 bits:
> > get_idx() computes it in 64 bits but returns a uint32_t, and
> > get_tbl_val_by_idx() and get_tbl_pos() take a uint32_t. The truncated
> > index points 2^24 groups too low, so routes are written into the wrong
> > tbl8 group and the add still returns 0. In a test with 1,360,000 random
> > /128 routes (17.6M tbl8 groups), every route added after tbl8 group 2^24
> > was allocated returned the default next hop on lookup, and deleting all
> > routes left 853,337 tbl8 groups allocated.
> >
> > Use uint64_t for the tbl8 entry indexes in get_idx(),
> > build_common_root(), install_to_dp(), get_tbl_val_by_idx(),
> > get_tbl_pos() and get_psd_idx(). Keep a separate signed tbl8_idx for
> > the tbl8_alloc() result, which is negative on error, and cast it to
> > uint64_t before shifting it left, in build_common_root() and in
> > write_edge(). The shift was done in int, which can overflow before the
> > result is widened.
> >
> > The tbl8 group number itself stays an int, as returned by tbl8_alloc().
> > trie_create() already limits num_tbl8 to 2^31 - 1 with 4-byte next
> > hops, and to 2^15 - 1 with 2-byte next hops, which cannot reach either
> > problem above.
> >
> > With this change, the same test passes: every lookup returns the right
> > next hop, and no tbl8 group is left after deleting all routes.
> >
> > Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> > Cc: stable@dpdk.org
> >
> > Signed-off-by: Robert Sanford <rsanford@akamai.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Applied, thanks.


