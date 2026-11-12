Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241D9606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=2kHuZK3A;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JJqhA0l/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB33E42831;
	Thu, 12 Nov 2026 21:28:27 +0100 (CET)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTPS id ACAD6427DD
 for <dev@dpdk.org>; Thu, 12 Nov 2026 21:28:26 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CDBB97A057A
 for <dev@dpdk.org>; Thu, 12 Nov 2026 15:28:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 12 Nov 2026 15:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794515305;
 x=1794601705; bh=TAa8moozvTctMWDUMPUgv8XqDGvMX+xn90SX2iaABTk=; b=
 2kHuZK3ANLl1oIeq5B/si8ufruLxALq1Q6QJ6XQzCVwYr7MulydmoXILb8FRIX/j
 WAYQicRUgDA29T+lEFBPirDzdVHYHlS0Cz7PjZxtZpPXSuDzmyoPvJTjrYgV7IjM
 i9t7mygsPqsJtVdLc9VZwNFyGTampMQIsg/WDPcGne3tPfbkH/ecwI3P+fVYE2b3
 r8oczkTf5iLhMYGs4BxSZjAPOUeHB1ZeSu4wIdvC/wyj7GfRc+PduccNgouDePeU
 foxc08TpnM2hYXaWTBZxNXHeGa2F8ZA46xVIKwceFQm6tOKSIH50DPg3zTSFSTgv
 HSOKZEtxnqcMbiIg/nQY7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794515305; x=
 1794601705; bh=TAa8moozvTctMWDUMPUgv8XqDGvMX+xn90SX2iaABTk=; b=J
 JqhA0l/5XEWzG3xOs/djf9xj7i2WQH8lOoAfbXzHGJ6bn2E6p0j/O3VNKLTBluR8
 X4BnB6yXP+qxAMTB2Bjkv7Pxm5WnpD721kXnqGo7IbCQkgZ+E7ExMtRP8WGnoHim
 k4Rkg+MLpkMyqrgUJith+cgmyazxkUpJ4tZREN+OwRlzb1VEboNscAIacXz+JJeR
 7BhUq4Bt2J0olgY3F8sZHxpp9qRK4U+pe2YhGjkKSwU7aeuh1haPwvvJo7AI2COc
 d3ijAnZhjOaN+HiC5xc/pug2wQfVC4VihUZfzimd0Ya4dNyb1ss2ZGU0STkRcALv
 0R4/neEWSTEAsxZQyBh1w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794515305; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:JSJFEPywMImMY6umffOkYGfL4pdqDp7guQkxh80GLOQC2QS
 g8EgMa7fcqFxZfcL9cNcCCSyfZeM5JB2m5lB6u0aAZnjPhM6/J33Of5LBwNzcQB/
 jPdt+6e1D0DFMcrwzPuDuBRYwHWL4NdQAJ9keZOk6dK701SGkCJIPlNFpj0bNtG9
 g+R/l/8x9+7D4ix9HB6A5oF/xU8ydI/RrIYPdDhs7TVWFL3D7FDftYymi9ssswl4
 92Um+UtlzBCdT9SajH2vnP+p1eZBy38ZKu7pBKsWypWqfKTDTXGDqI2QJaiN9G/G
 YFGsWKNdtAILZnSJDPqTChjzuvHuHGSDBAtBs0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:oxMOV+l4gkiRAelCnYKJCG8VjFupQpv6/NFXfHF7FKw=:x4wkLRBtyvygIiU/WQmKYsRWHk8VVhS5vlZASIfKOiI=;
X-ME-Sender: <xms:aSH2ataSQ-8UrkhuxLQNba32xTsKXuALQvPx2kQG8Lq_LTxDZRjvCg>
 <xme:aSH2akhKi5GaVhEfUf3pfYFxfQokEL8xlIdZfWZ7YrbowZk1-DHkLoZXWUtE4NBAt
 buJKMpJ2C-5W7hdRX2bAvAyCTTsKKdD-ib3WBtku1_1TisKBbcFNXc>
X-ME-Received: <xmr:aSH2an5aPnVtUjOCAivK11W_DKMnnHXbL2x2hGAB7fbOi3u8Vk7qYfzoZxAKdRZbaXHaHEsIEhgL6me06K2bIHM>
X-ME-Proxy-Cause: dmFkZTGboblClk2i1xXTPguvySht4fl49fE1njtY/+xx7aE/byzDEgb2XQoJbHYK9WzQ5z
 JTCIRTM4FPrgKNf7wwrGNXOL5a41HNte6FCPSRKOTYCv99OWN8SklGXSIkvzAJ2O5/GUBH
 pUpPrlGLNcC+40sM98yDe3iDb3g0tl1o3CASg713XfY/Ohp7zyfhs1CCGH0fbi2S1pQDyh
 iIWG8IP/NiWbNYJE640MTBYx9m34mmHrr6ZZQNDbnrSJ1+5W5wRD8cz7jvnWa9SZuVhYF0
 T4n6ROp465jqr1+YypO8EjHXgxHpasxKopNy/vna7Gp1m9oJFmpmUC3EveWt+0WoEMA7jj
 qoBF/fJoDfQoWnPfeQtvwe9qEehaWqQ6QiaaJwO/wUZxD87Bl56IVbiwO9dxjzQ4gojsVV
 tn0NFB/7Qi4MMsxopPIlyxDn6X4hwGF+pR36FCNztiZENwrxxjLt0j0hXz9kwS7LyN8vEB
 OqpuVqfHdzS5/H0RvcLnnOtM01DLcxhwsrQgXvk+X2oOx6QjOWHT6FbWqJT6jix8gzc0W6
 8A6Dt1ZO1o6pYWSiazYXTCAALI7vv78CB/PPHwsjXDBwe96Zau499bI4wXzKc26AWnXgo4
 zU8CZNGxCAGkqtEPsDPy6ve0mJ6gSWAtYy/uusGeW6ztMUl5shNsadmVYCUg
X-ME-Proxy: <xmx:aSH2aj58MATd6Bkh6fGVuEcvY4BeTjmiEVxxGXa09ZdsV5kiWsMvyw>
 <xmx:aSH2ajeoVhM26dY6Ao9MGPwtB7hjKx7RC0X4v1qwzMVF4PpMBAE9bA>
 <xmx:aSH2anAX27TboaPuEWYRxZBq50Ask13wZFMdNftuUkpM_Z53g6XBgg>
 <xmx:aSH2am_Q2EDT0she2U5fdKSp9N1anAGimCsXRaZQeeUe_XBJzqapWg>
 <xmx:aSH2amtLFoyJmYu-FoJDeCuCPxEX0wHzF0jEVahRi8gfVsqEYPZ-8qUG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 15:28:24 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yang Xiaoliang <xiaoliangyang69@gmail.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, john.mcnamara@intel.com
Subject: Re: [PATCH v2 1/1] examples/skeleton: fix typo in initialization
 comment
Date: Thu, 12 Nov 2026 21:28:23 +0100
Message-ID: <7E0-9BWFSJSFofgODAUnig@monjalon.net>
In-Reply-To: <20260813161102.41575-2-xiaoliangyang69@gmail.com>
References: <20260813161102.41575-1-xiaoliangyang69@gmail.com>
 <20260813161102.41575-2-xiaoliangyang69@gmail.com>
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

13/08/2026 18:11, Yang Xiaoliang:
> Fix "Initializion" typo, should be "Initialization".
> 
> The sample app guide includes the comment via literalinclude with
> :start-after: anchored on the same string, so update both files
> together to keep the snippet extraction working.
> 
> Signed-off-by: Yang Xiaoliang <xiaoliangyang69@gmail.com>
> ---
>  .. literalinclude:: ../../../examples/skeleton/basicfwd.c
>      :language: c
> -    :start-after: Initializion the Environment Abstraction Layer (EAL). 8<
> +    :start-after: Initialization the Environment Abstraction Layer (EAL). 8<
>      :end-before: >8 End of initialization the Environment Abstraction Layer (EAL).

Replaced with "Initialize" and "End of initializing".
Applied, thanks.


