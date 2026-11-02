Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41848606A326
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=PiOT9p1N;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=r6c+mf5Q
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4F7340E34;
	Mon,  2 Nov 2026 14:22:51 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTPS id C58B54003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 14:22:50 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CA37A7A017E
 for <dev@dpdk.org>; Mon,  2 Nov 2026 08:22:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 08:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793625769;
 x=1793712169; bh=9cYy/NdMWAt+A8hLTtTBxwjpyj6M+erFu3ks4nItgV4=; b=
 PiOT9p1NXpx3Q1o1Vho3cwoAkrxAcjm/T/L/0CO1nF3ydBvLFw8SfHcqVC/NcGJ4
 otqM8Ou/4LnOGKDSxQt/1+zC2YLQt1AZjJMemuntr+kK04GdmJN54XUg/azabnkQ
 /GxdyJoU8NdSBcUiwli/5DeO2LlaZ9MdEHxThgFp1qBub/BXZblMHsyAvkxEY3ia
 7R+TD6hPQYbwjNlWy5Ve8sWG21p6QtxVzGimLXje47j6PXurxpcWxxep9zcguflw
 PQbCWQbuSuO0tmPaRFLf2WPvV46eMCI/5wlpLJrZkqN/C0beTBV+WaIFp7ZfBrtV
 rdxvZdsQQc/XJ3zhBw+uuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793625769; x=
 1793712169; bh=9cYy/NdMWAt+A8hLTtTBxwjpyj6M+erFu3ks4nItgV4=; b=r
 6c+mf5QA6HYy4zx+YvywlChE7onhvV9Q0j5Il48Onz0cqfKTuZh/9mwwZ2kdqm/w
 wqFNwLZPNrDdzT3siym+3umIoMHT0IfFnMhYKAt7SaxlHa8SVe8qxzAtaMoVuMtg
 RVxlrec0N8RdGCKci2fI/OJtbwky0jP0A1FttSSVUZcOlW6BYvS535XgrLVC88o7
 u26JUjW0MNU+ninzXXzdizMEDVRTRwEqd/GoLkWpd+qDdWeJl9MTC+mk79iuxkzS
 T3B2diws2JM0wwEXevnxlyWkV/4CmIJeCheB7YXO1lNKrdiIndtHaQEnV49qjNcV
 4kbInU/zxcv0hWr7IjBPg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793625769; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:RPK7bIpKJ32nTKC2OseX7wIZy2/rIob8k/FbvrOTrcJwfJO
 Z/K5mbNv3MPP1gBsAkmqtRD6DbGTCq7HP7Gv4+zu66p2ib9ZVAZ0c/y2qTl1zkhp
 qz6GGyMrsHvugZJH8SuhxM0riWsIwCdMvEjIKH1siGmGQ5GGoaURpvwKN/adn0wV
 dJyV9EDRwvZJQgYo1tAvhS6j0J4UWbNox/IlUsfoaqlMZTMsollGkQ3rDthAVgFF
 7jdU0RAcVNavbua7Yhj/rImQkHGeF5DlZQbRDc8O0f1BKHfuKYUWPOMnGHLtVWi7
 pA55s928PpXoiVunRFN5ephHtlrt1pvOIAWHa6w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:3z1DMXZDsKr9qVeEogKeu6x4VMz2kI1nk/ntVLnlKDw=:kAwISg4k/ka5VSYH4oE10Dgl82MrTP8r1Lugm6O2j4o=;
X-ME-Sender: <xms:qI7oap2gFnFnpU5TU-kEis1V9ckVSXTUIwmazly_a85wroksX_8xMQ>
 <xme:qI7oaggnTcO2QYv92awyPc7zGI-uPdCnoTnvIcGATUsp2-hwI3nouwskXBIvrMLZL
 Tb05_lhdX93oMMcIYiAgyZYRKXqOQvcEtLW0YsYz1q_f1Dljz-PAQc>
X-ME-Received: <xmr:qI7oaqnKUS21SVgbRb61BTYj8zALvndN6hNSfe0DgKddJMhoqZLXa9f60HH0G1zXsT0pE9J2nAeSdJj6MmTwFxU>
X-ME-Proxy-Cause: dmFkZTEM+jM9tqD6X6kwl4Na76dkx1GQrLtP4RDDl1UScI00z1rBjG/jT4iblUiJIIfGhN
 38JGQvABY2oEqXW2Q/g1zZFtULNGA7D/Ma/Imq2oS9nyMw3HhDn4itMtx+2Q6ScZHZfhXd
 tCZPkNx+oM9VOTQQ9fEnPX/0sLrtIiIWawZUeYP0MBa6WgiMY+T+0hT0Crl0KQuza/sd4Y
 NSUO1gB1cadgbZxtOj25uPixKySkQq84/Cm3CV10jYYu8MWx+daU9gempVQ25Vrcc9LZr3
 RvvvnGyHAgKch5i0I4C4I4C1Jx/476qcB6z95YJ0kGOi6CmZNRsQLJYrJHNwhmgJ0E8jt1
 rhCJO/KJCzdCVdpmGn2Hs2XVPTbxlh7LltIibc7ao4n/x5HTnkvtPnT7SLKcVK4vFltNQa
 QXTVSPr6cUJuqSN1dDcydDbE0vMcUkgz635wjJB99Ro4qZbTbuHmLRZN/bUpWczNQ5vBXB
 bHfwg9V+pgoh7JFkd06KPwtF2ILz5xmxDR0VBNgVCMu/9yLBTLX+6eH+2NGdAjByFmV7GB
 DsbxbKW0PNAbKRUWlwlNK4VqQa1p40jL2x/a7TnmTtIRtlCplRsuR99nZ4ioxzZHDX/Vj3
 BvI6XQ/eDFMQPSYtX0+fMYVN39XYB1VYGRyQXuPPhNXQSn0uT3GLzWhxyr4Q
X-ME-Proxy: <xmx:qI7oauYGf6HlWYHrlXkP6V6xQQn4qMjJCocx4rm1JAATnbGrvrBl3w>
 <xmx:qI7oatHM9iZwxhh2JpGCnnF4XtKmTK3oOew9AjWfAlnqJOcrDNJJPw>
 <xmx:qI7oalb8OZJaYcSBItLMVZVeXYfiReV2VY0sQajv0uxu8o-rZM13mg>
 <xmx:qI7oapyMy-phH9hA0z21q9qE3eTkaZwrAXYHB7gzAcrzITe8aDLUEQ>
 <xmx:qY7oahNzAYK4aTkWSwcuCW3XcJf8QN4zZI6FnJcu-EAhB3ymIS-9q81a>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 08:22:47 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Rupesh Chiluka <rchiluka@marvell.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ruifeng Wang <ruifeng.wang@arm.com>, dev@dpdk.org, anoobj@marvell.com,
 ktejasree@marvell.com, jerinj@marvell.com, gakhil@marvell.com,
 stable@dpdk.org
Subject: Re: [PATCH] lpm: fix SVE bulk lookup loop bound for small bursts
Date: Mon, 02 Nov 2026 14:22:45 +0100
Message-ID: <Kdxy9QrvTX-PNS1QkBj3GA@monjalon.net>
In-Reply-To: <20261027161436.231088-1-rchiluka@marvell.com>
References: <20261027161436.231088-1-rchiluka@marvell.com>
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

27/10/2026 17:14, Rupesh Chiluka:
> In __rte_lpm_lookup_vec() (SVE), the main loop condition was
> 
>     for (i = 0; i < n - vl; i += vl)
> 
> where n is uint32_t and vl is uint64_t. When n < vl the subtraction
> is done in 64-bit unsigned arithmetic and wraps to a very large
> value, so the loop does not terminate at the end of the input array.
> It reads past the end of ips[] resulting in a segmentation fault.
> 
> Rewrite the condition as "i + vl < n" so no unsigned wrap occurs. The
> existing tail handling with svwhilelt_b32() covers the remaining
> elements, including n == 0.
> 
> Fixes: b29ccbea24 ("lpm: use SVE for bulk lookup")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>

Applied, thanks.


