Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CD60A260C
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=Z9IYcYYV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QMp3+tdU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92B4E40E34;
	Mon,  2 Nov 2026 15:00:09 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTPS id 7DD7A40274
 for <dev@dpdk.org>; Mon,  2 Nov 2026 15:00:08 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8D0C37A01F2
 for <dev@dpdk.org>; Mon,  2 Nov 2026 09:00:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 09:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793628007;
 x=1793714407; bh=7O/F5YNWhfowCden5DjsotCGEuntabrLD9MKl+NEiqg=; b=
 Z9IYcYYVDrl4Sfmd873DhcakaUsb3JyRcC8vM30HW8py99wAkiCtJ83PJ7zDlgsO
 qZNHWN6DRTURwO+QdE+tvlvASBLT6x2pMQUa+gEcAjTofNUyDzp2Wo2MDMDtcJRE
 LyePuw7RXdsfjDpQDv2Jrz+kpFMX4x4ONeiu2d6nhqeajo0WwfBfxlg95Xqqwnwh
 lw3cTC6jkQkiX7YGquw9MbQkPQSagv814QOzK7kGuo3ZAA1n1FvnHc+vXW2lsN5v
 LsZxDAqURzUd2i5SXC/Bsq/PuNR9nAehVDMQtL3v+KdBsBoHJH0C8pv8CwZPXFhm
 NSXMiF8deIgf59Z9nHrM6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793628007; x=
 1793714407; bh=7O/F5YNWhfowCden5DjsotCGEuntabrLD9MKl+NEiqg=; b=Q
 Mp3+tdULBAl+tGixP7QSRYMogh9q5M9MOjeHR75qIVivUgYA0Z4RHNnGxSU43J8q
 yzSvZkPJoOhcAT4ki6wLe5GBZJjzHvazk6eaeOfXplMcHXpZo8ERP8IS8lYW2zE5
 LcMeOlbR5gtfp9tMSrYS38GkmPCVmbMqDqMnC+bj4eRnV4A66LTNXJNMRfm2a5Rt
 cMaeGojBSHy2ZqgEAi217vmWk0UUYGlcso0WQit/fXUFURhs/WKJPsYkaII6r3ML
 VZZEYCkLVRWb2SQBpSpxoQbEVq5xruSEn4cNqRf1Bm9WQNLOdUUKRW0MXNBKaIIM
 Mw/jUF9hJFEz5KC/l891g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793628007; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:JhxXkpsI0GMq9P3VmzLmFldpeNlA0Q/86k4MVHHhiP4MBHm
 ZRz3pRq2n9A0qRXWUmpz2yK4/e/l8KOVFXQIJTuHOQ/Lb0MbwR93Hi7sKgCTrALA
 WLA+Bl9O04Wb0l2VOLFMIZsPdcf59LpcdDXQsI812TRcu/3NPsjwWWJ8KGqvJ0gc
 46PJciBULrrdz1rYYXZUwM5DYj3EPShd6/zPn6KQsKqSqAE9octRCbUc6z981UdP
 wPMQKhjql5yA7tm7tnMFtRaFzB/k9NehyD01eABYUQ9MMTXuqcbd1IdSoKrQbWfx
 aezn+5hsXZ0VQXpQGNh9/NmkX4r12QMOd1w+TWQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:OPoGdTWIX2oovbpoGz8n5Wc96y767XYmIxOkSa0JHYw=:9XAcPrIQEhBHieypOT+jbcRCE5NHG5BsUGpawp0Tipo=;
X-ME-Sender: <xms:ZpfoahZDxlHdp5d6VQ_p7fIu9ZnDCsMWa-5AyvLNqLeRCgUAA1ADag>
 <xme:ZpfoaojVieiVQKCeKkKoMQ1IVjazguZtKT9-NjdNx5S56xhS6pjQAp-8vzwCNpzQO
 AuqT6YKyUocisLUuuaJi1s7bJGdn3aha6CLIXN5tdAYcau2BisZiVQ>
X-ME-Received: <xmr:Zpfoar4kuw-6Kdo0J5mjn_IVJz3hzqDaQlMl2qYX9vn9xJ3l70_1bV28_qkGF7JU-prcqn2QmvAu91G0ObNJEHU>
X-ME-Proxy-Cause: dmFkZTEryWMRrMGBNyFe6rqcEb/OYYemfuWCgIq0k1u9cc5laJJTVVls1VJMLqKjYo7UU4
 B9KEBNWEXzorsy4LjxKHWS1VhG+rT8SyR4ZNwrfRD+4bLzYiF7Z5c/d1tXKxy9NNkhyIrs
 r0Bn3nTWY7h2b7A6YpfjT52mZiC7xj3+1/H12ttJbu40xAft08XKaarCwTAGSNRVHwxM+q
 wSs2LD339eX22GtYUGaTnBWu97Cu5evovj6fzxOnF8XDSxVI8AqAwsmDKxrntXPtiiPiu0
 4iSyAan2i0xQg6RnjjRp0uEZ9xeAP1nomvwKMIq416Qg1ACny+Kzu3jm7FJBerinC8xktL
 SVR5KkR+5rCBfUbQuzv9vW7FkjGkXKBungLRF/gQYL0DagiUNQmhUTK5T9ntPVWU4j58n4
 cP86dU1USug5j5nnM8XEaMYPtUO3ZL99RepZydgIUilpDVuP2ix9izw6g5R/2Ur0UJyV4v
 EfYAEd08XiuzLbCruStRdeT18GhYVQeIB43O5Ul1AaHd8OVfW9pFKmQSiodK9C074YAgOx
 TT7K9uVkBTm4tSc4wNnj+OrwzsCGWwUtAcmeY+pdQZcbUcU+ZRtvNPyjkHid9RnNQpkGTs
 W9OzjOaQpiTEhXKX/4RZebedAWaBHNOHNVo+9pvxRGVfXmGyz2xI7tCwesag
X-ME-Proxy: <xmx:Zpfoan4ZCNyr_eb5x4r9dfSswpVtfzggxSv-DffXGjMIz4dXsypOVA>
 <xmx:ZpfoanccbCjtTqyt5CT3PMnBRJTQKIIA2xmzDFssH0RfXDfycsJNlg>
 <xmx:ZpfoarAWb6A-G_CCSPsbKPBoTHL28ocnsdZumrllEWxqLTnYpbTeNg>
 <xmx:Zpfoaq_-L1UOC4BHJDedqGn1O7ShwLEand22CKHspMs4NMd1JliT3Q>
 <xmx:Z5foaiZuF8EzycnWn7bPRPKsRS6TBLY9--LPVGOyABpAaDH19HObA-Dd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 09:00:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, maxime@leroys.fr, stable@dpdk.org
Subject: Re: [PATCH 1/3] fib6: fix temporary tbl8 for byte-aligned prefixes
Date: Mon, 02 Nov 2026 15:00:04 +0100
Message-ID: <4l3L1QKoSBWeTMnchJ0yyA@monjalon.net>
In-Reply-To: <20261020132155.980174-1-vladimir.medvedkin@intel.com>
References: <20261020132155.980174-1-vladimir.medvedkin@intel.com>
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

20/10/2026 15:21, Vladimir Medvedkin:
> Currently, `install_to_dp()` builds one tbl8 level more than a route
> range needs when the range ends on a byte boundary. If the range
> spans a whole table at its first uncommon byte, e.g. a /32 or a /40,
> `build_common_root()` allocates a tbl8 one level too deep, all of
> its entries get the same next hop and `recycle_root_path()` frees it
> again. Below /24, an edge aligned on /24, e.g. of a /16, gets a tbl8 that
> `write_edge()` fills and recycles at once.
> 
> These temporary tbl8s are not covered by `rsvd_tbl8s`, which counts
> only the levels the route set keeps. With a nearly full pool, an add
> that passed the reservation check runs out of tbl8s in the middle of the
> install, the tbl8 already linked into the dataplane is leaked and a later
> add that fits is refused. A /32 can not be added to a pool of one tbl8,
> nor deleted from a full pool.
> 
> Fix it by not building these levels.
> 
> Bugzilla ID: 1970
> Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> Cc: stable@dpdk.org
> 
> Reported-by: Maxime Leroy <maxime@leroys.fr>
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Series applies, thanks.



