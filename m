Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CACB606A31E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=goHuQu6G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PMvN7ADs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 675DB402B2;
	Wed, 25 Nov 2026 19:02:45 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTPS id 219DC40274
 for <dev@dpdk.org>; Wed, 25 Nov 2026 19:02:44 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 06F221D00602
 for <dev@dpdk.org>; Wed, 25 Nov 2026 13:02:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Wed, 25 Nov 2026 13:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795629762;
 x=1795716162; bh=ObjWl1QS/FNhaDx7Xp8X3BiWg7cGLI6jMxCpZvnv7z4=; b=
 goHuQu6GO9RA3afh0GDL9T2gDiJRblNVJZFf5DVL1G+RUKgkgBzL1BUjuNml/ajA
 dfXM+rdTMaPr7ebFqYWL48dzdbo1PJLVK/DE7FVBcTFO0NrfhIpo+lvL541LMRvL
 3/xKbqTQ1RBzpsefVYtxTyim6CuvTC5qlFU+UHUa0H76U80Eud66HvJeoTM3F51G
 KS77joVaXcidZmy5DhgcOnp1ANcnXfGLNBhUWGSOMzmh1hnSGgHsJ7yeXbJ0uw+3
 OpBX/FJBILjeSRqqtR9G6hCf/0vRDDMEYlFCcJNzrSD0lDUYPvl2zxiUJwG7mtU7
 SUpO+mXD2N0nO0d9LM+mog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795629762; x=
 1795716162; bh=ObjWl1QS/FNhaDx7Xp8X3BiWg7cGLI6jMxCpZvnv7z4=; b=P
 MvN7ADsZoHEVA8cr1lx9vcjrT8fF76PZHpVYPPFZX7EZLetX6t6eEv3s99jI9oAM
 LwuwkS54COP5+UU+n7tiFHJcyce/jMdrlD5zagpYSjg6/7eYn+/KS4iOhTqk1tmv
 SQb1Oob3PijIw5zyl/8a2iUfOD7v8DhNGAecgF11iZ3m5RUAYiuc/UFQfMZ8QKwl
 zGhOvmEmdftoC4Tc6AyIOxOko0xNVqpyX11D7kiLg8moCjCXYwpa7Y4hU6SfbTFY
 OUYVjeOO17d7gHWS29pJrHqS+vfiS5oxOgxswyMwyb1B2rM4eDPaWC+9Y9anl0ZA
 mZnpTIW25mgdrgeF2KXxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795629762; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:y7kub0T6Ri/DzK+wf0nUXdvT3y6UVvYKf1h5+ALccWaVu+y
 DGLQr/i8pGCmnsbLGhUIxqjCF3q+mUZNOmW/lv/SX6kL9omUwqFTeWRcRHdO1z42
 ss1x/2w9fdI0yVo1JYXX4RU+nIlGKBRUCX+a+ulf4Fe8vhB37aE0jII2yNj+zNUE
 zAv4aDdUUtLMXykMuOMH5iNuySIgzc3FeO9jd+fYYuiKWw9Xq9Aa0bqWD4kiT6L/
 MUvFze9XxRXJJZhHKYnI7yaQ+C8bRtfH0O/y/3Bc8jfTHXR+5GeTtfxDbDw2sXI+
 xsU09yxsS+r5ITnvR259nUbIJPpweSnb4PV1rcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ybsuKYQFSVOilCLk5WjgyxZferApDsvd9RpGprkVWqI=:DRlMiyZ6Qb3VZWjJpK0ppsfeE2rFUBqYMgjn/JuU6As=;
X-ME-Sender: <xms:wSIHa3LUSj_jKovM2jMTmI7Th1EzkB7H6VQdJCPuImF62BHP_74bZA>
 <xme:wSIHa_fLaoAu8nSxGE2iHFQDkgkRUbSut6Tm7NaD0F9nC4_rhDVJvn6rijJ5XQ1fV
 oAq8iOc9r6S3S8kvNOF8TczYYOIiS4UbFRVszA7ZoRhOQ7ko8eLiZQ>
X-ME-Received: <xmr:wSIHa-10AbbBeLBLFVIkgdTNd-eoGG1yVUV3gkFKQgC7I6hL1VXjBC8KRYJ0w6EdXTCK19joKkZarXbhRbzArQc>
X-ME-Proxy-Cause: dmFkZTF2NphaW63xLZST4XeCtCLPiD1MZ+Wa8NvLmCyap60UG/yNkPVE5ZzwfCevEz9Bic
 wI0ky16+CQ3A0NKC5sraC6VrvSde+4GemceXtWNutfC5L3vxHzaly2GNE2YjGpIiRu3VRs
 rdp8uKdLa4AvijUc3iDfurqUCeEtL87s3FKYqO7iySHtZ6XGg63gEIulJ06fxPQFGFyEoO
 3/MNHeJZLCGG/OtzKpMT/Zc3o2w1Tg6r3movuPPuvnQ5kR5eD6mxIa+TZA83t3vh6XaEFz
 J8LlC94C3hi2fwIsINQ/3qdxsPpkRqxZow7LHSigmTZ0di1w3LZep7s7VeDpbHYkZVZHgt
 zSpufCG/Ddmj11D01iiENkIg7c0T8o9FjULiGIdUCWXKf1BppFzyE432e6244UMB1UeW/N
 UcgIkAPSAgBnri5T1ygsli4da7GYmPf5CJk5pK8Tb5ia14zLw+0CjYe1qAmv0xHmuauAaJ
 9DMHBnKG8did8NjttMbpic7A2QgzSkQHc91xhRaUOewboFv8zB60paDdFC+HUoTMGvucLD
 O1/2vBmS7TqHDzlXC8pvopYfgEP1OiNd2BIq0hkB450nLfXKfHJ5tngUYIJ8Or2O8qiKht
 Y6F0TkKujLtcTuMF41BFp1fZ1pRoJDdlvGav4/EaaAzybkrxghKsCsL5NaJQ
X-ME-Proxy: <xmx:wSIHa4iu-c8G_wjoszXgJ99CDan1Bv6SRkMZwdu6iU3UUYrrrFiQDQ>
 <xmx:wSIHa0SI--lteL7_9ERWu2gJRyr9X1RKYw1VAK-hsn02LKK9WoQGtA>
 <xmx:wSIHa5igABy4wRa_dddQgQJfximezSJlNAC3aTNzAsMI7c96z3YFCQ>
 <xmx:wSIHa05sDsMGnXk-K7WZM66K6Znnx5b09SzR-ie-Pv4nzs0nCJZ3cw>
 <xmx:wiIHa4ei2R6KwyuFJXoSvDkJgKp0M4ECCQ0YND192JeA6QKfJ0yJyDGR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 13:02:40 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com
Subject: Re: [PATCH v4 0/7] doc: build for all public headers
Date: Wed, 25 Nov 2026 19:02:38 +0100
Message-ID: <q2aJr271QK20qbG6ukeplg@monjalon.net>
In-Reply-To: <20260721145841.7424-1-marat.khalili@huawei.com>
References: <20260707085048.15295-1-marat.khalili@huawei.com>
 <20260721145841.7424-1-marat.khalili@huawei.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

21/07/2026 16:58, Marat Khalili:
> Marat Khalili (7):
>   doc: detect ignored public headers
>   doc: fix typos in rte_avp_common.h
>   doc: fix typos in rte_bus_pci.h
>   doc: fix typos in rte_bus_vmbus.h
>   doc: add missing globs to doxy-api.conf.in
>   doc: add missing drivers to doxy-api.conf.in
>   doc: add missing headers to doxy-api-index.md

As explained in the thread, we need a bit more work to have a clean Doxygen,
but it is going in the right direction.
For now I can merge the fixes in Doxygen comments and the missing drivers.
I make sure the drivers are added in both files .in and .md.

The .md file and the detection are left.
Some headers need some addition to have a proper Doxygen,
and we may simplify the markdown index.
Do you want to continue this work or you prefer I propose something?

Thank you


