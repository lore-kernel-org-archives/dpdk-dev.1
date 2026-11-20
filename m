Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0A606A325
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=quoU1//l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mz1Yo8Wv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB5FB40263;
	Fri, 20 Nov 2026 11:36:17 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTPS id D331640151
 for <dev@dpdk.org>; Fri, 20 Nov 2026 11:36:15 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CB77614000E6
 for <dev@dpdk.org>; Fri, 20 Nov 2026 05:36:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 20 Nov 2026 05:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795170974;
 x=1795257374; bh=9ZezOAcjsy38B61KzMssu/i+nJvDD5uQlazY+/5klHw=; b=
 quoU1//ldjyf0xnX2677i31fXXK8fbYzuvSyWE+1Omjb8T9qRarWeVeegICn6Ubb
 CuduCSMiWyn2c33w4VmOmCsNX/651VX650bB1y964uuMzT6T46rTFa+4OfM6tQpR
 7OhidMFj2BfPWSUmvWYRggDvtmkcdb6Qp00dFixW5SsccQE97dHKt84ukz7gB4KR
 YRJlgEzGRnJgFbvL6uM4CPqgzsSJocElSvb0eVXJyZiY3gRtREL2fvUR+Xsa9t+A
 bitY1LdwNXs4k+Q14dDy7g5PDmg/COhugnwyIQNWF/6DoNBPc9InTkZBaCwibYUq
 RH3qaxaQMz9LSZIQdOinnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795170974; x=
 1795257374; bh=9ZezOAcjsy38B61KzMssu/i+nJvDD5uQlazY+/5klHw=; b=m
 z1Yo8WvvZuTK5YpYErteCwX4Z2LN1FZW3kvtENiuxTRr3jIDMW3l3grD6IStvErR
 7Ff5MhubrrtE5e02Dh2PcnSc1WQYUpTMQQUKBeNjvr6aAfDBrvaKRMcrTa1TIQ0A
 YIC0N3zbEc93TxhYsZT/VT6n45MfHSboD0MadI8YwCZf7I6A6fAKKg2JwCaUVLaH
 UETw6ZkMYBOS3PusbLdXwSxXFkJY0jjrwrRl4pdfOF/hsJTA39kGsfEZZYjKhFzR
 XxBwYlFtbb4kk1CftKeTyVSm5BGrbeK/FxH74zutdQzbinPBzSa/cJ4j6e51vvHg
 CVHvmNFf5JDlDLfGSbjjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795170974; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:qa5fIuJqpAVTQ+l3TF9wKwTwiXkvwmv+An6Oxm9Ytf/DeRy
 pvgoaWbhtTZylFdX1bEzM3QD4Rlc3ZSHcbspt3ID51s/LQ4HwGeEMIXwzMMwWV/3
 zUkx8jga9BrFgx2TiOmzPHpYEYMSWpdG+roTPYZt4ZJXs7uZQFWPiEQyuy4Ag4Lm
 A3Pejyok5HHyvntg5YdHJJdRPIzRSZJGoUiwgd2zhiSfmjYCEwd6/RVTMijj1ODs
 v63+dKdtpHdYojJ/E5q8RErRW0VGr5PRifUzQsaHKI8xmpZCWX6Ad5tLczHEsye0
 uvdMBDg1CGmllD2PbsFSCN1v5hc6l6GkAwWcmlA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:VyFhozKahMdkOWd++ofIbv+j2svaf+CHvTSSGJZHbkU=:pkHS2bqvGI6pN6VZ2YVVoG6gqISta6afdrDO1p3Wwvo=;
X-ME-Sender: <xms:niIAa5b9fx5FfKE4pb_5uvE89jbTGGLuMbOjjdlm4t79V9RjKmEd5A>
 <xme:niIAa6cc6SZcY0ta1VKDIOKOhC9z3mAKUwrao-YGj8X5p1TBi5jvNgvTVupTB8VB7
 RsfcfU5fewsUGmHiJJS2hFGv6hSzc6z1rPsuVO7_aPe9E9h2UWpMg>
X-ME-Received: <xmr:niIAa72YzbB6LFjoG_ZpKKCGX754Ocwya3zQqS_8RV6pqB1EZiDsSev7uJDgTzg6oYtcAPmGfz59mu2c_Z3ecxI>
X-ME-Proxy-Cause: dmFkZTEHA+hJVK/TNRS8JmthJr/yveCbuq1pj0k4jNnc6z8nzEUC6L5XVqbaKMmFs7sklN
 1azdXRT63Sn+SQmA9FcZi8PqHGaMz8oiGgLHfNZ7VR1zt/YFbwkqN29xzFO8bdjjTZOsVl
 awjhGWJ5rZMfbxQcDL534e9nJ9/cbtzY2mfFB6D7DjBCRK841DLwM7C67QPEG/I/jC2Qqk
 shJBcqjb+Z7ShKMZSntOSGWD0o71ZJyhqPrH5lT4prfiNyugpAsEDqjZBqisEYGl0y0l5P
 IrX5c3cbC2wtGsodz0kmrLCg5/VA6tPTK7j/fc2asVHSkmqqdW04S6zoJl9WEOFYhm3bgg
 OI+oQXgEvswCLoXtkJc9i/fmt2FdtJ85Ir29aXkT6WRDJY0SM6MDvEt8OdksKtno+/4YR1
 RFx+1I6KrDbLcT45gsBSTfGeltHxXKB+toKWeK0Nb9CCVb+3rFgv0Ilu+uaxea/8TBCK9f
 dEGlZF1hpgEYDtVQmTtaKvnmFZP/LUR+zqkn7XaVlzhwm+yDUHKfSPcGxRF6MPNhM9FI3p
 1MGKxuuyRfBGEcYjm7cz1e9wBROJGFTFqqWLd6VweoXG/FEwc8wgGXe1iJ892l8sHCL8+m
 X889fXe3k/xZsSCS5aIL3A8PQgnLa6LMYXLiUJV4M3sG2WV4Eg5o9DkNeFYg
X-ME-Proxy: <xmx:niIAa5LRaEF9vJD7QyD0Vpg89lsj7U9gbI0MCWlOJnX4xO_k-07R1Q>
 <xmx:niIAayElD2ixmPC642KUlKvHtg0dvLxknF-SIlCayBoUv8z7FKhZLQ>
 <xmx:niIAa9WSIzfoqXahVsZMEuNGns0F5MIoQLYm7pRmZ_JkGeRusNk-0w>
 <xmx:niIAayxxq6r8QmkldU77ibmn8tNldzuAgk1hS6Fc_2NHPh0kHQiLnA>
 <xmx:niIAa2VmGG2CDiZSnxaqciwUiwD1fTiIqVIWes887SRWnYUoFjX2x2bO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 05:36:12 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Renyong Wan <wanry@yunsilicon.com>
Cc: dev@dpdk.org, nana@yunsilicon.com, qianr@yunsilicon.com,
 zhangxx@yunsilicon.com, xudw@yunsilicon.com, stable@dpdk.org
Subject: Re: [PATCH v4 2/3] net/xsc: fix leak and missing null check
Date: Fri, 20 Nov 2026 11:36:10 +0100
Message-ID: <PHN9AhH-TR23VM6YCYNEYw@monjalon.net>
In-Reply-To: <1794914060.189871@yunsilicon.com>
References: <1794914060.606144@yunsilicon.com>
 <1794914060.189871@yunsilicon.com>
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

17/11/2026 12:14, Renyong Wan:
> xsc_dev_init() leaks the structure when the dev_ops lookup fails. Free
> it there: xsc_dev_uninit() cannot be used, as xsc_dev_close()
> dereferences xdev->dev_ops.
> 
> xsc_ethdev_tx_queue_setup() misses the NULL check on the
> rte_malloc_socket() result. Return -ENOMEM, as the Rx path does.

I don't see how fixes are related.
It's probably better to have 2 commits.



