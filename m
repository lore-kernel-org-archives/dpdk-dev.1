Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0536606A320
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=N+I+Cwve;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fWUz6u56
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D240402DF;
	Thu, 19 Nov 2026 02:27:01 +0100 (CET)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTPS id 379D6402DE
 for <dev@dpdk.org>; Thu, 19 Nov 2026 02:26:59 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 534DEEC0169
 for <dev@dpdk.org>; Wed, 18 Nov 2026 20:26:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 18 Nov 2026 20:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795051618;
 x=1795138018; bh=oqGWYWFZeKh8QFK3CTaSbJA49ubAidhugVWwd737EyE=; b=
 N+I+Cwve0bSN++Nv3DcXBXMaiVZWcG9MobHObiNoCyNyaKSzSY4dqmT4Q16CI463
 u7B16ecm2SXCydqWyxzyLAkgQgtdPu7qQpCK/KnGhELozn8I642FyJc9PPG1Vhn0
 Wk84uc3EFqqCar9/1vW31cqYnWd1qNpopRT2NUlLRSjbWx7fCkOiY/SvwFgn/0jU
 qpNBQ57baztnEc7wIJavIuLPXbjjnJAZiqIpzhO3liTHgYrv95KUieX/EwompBaZ
 kI+vl+C9JbmQdX1AGcgAAOX8pqe1RgazIsYNGqfQr4jSdxXvpWlBC0RCVhoTMQ4T
 tYaUqr6UF2wkaHGqKyMV8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795051618; x=
 1795138018; bh=oqGWYWFZeKh8QFK3CTaSbJA49ubAidhugVWwd737EyE=; b=f
 WUz6u56WmnQMUwfZudXrU2z+MYu3e5zNfFBumj0nodUpm/ZTVW6n2nCBmKxOr6cG
 pWVEU0U3DrhSobEUhJXaRO6Ku+LI9QqQ4ovi8Tc0mlTyVt6s2QqShbtv53zXSdG2
 XoCm1zTM3wAM96DIvSWk/OgbM7UMGJZZ75m7aHJgqWbc32ZfGID4pAuVOidUnwre
 uT4hBXTQTOXWXElsSmRjjkf/1GcsLf3WUqct9SqBQKVQOKDSm6n0fLwfbbXglDzI
 8Z8pMfjnUCIbBNusyuPQLfl97377zEFbLY4n2p1mJ6Gy22UMFZZAADFJCbywIDfl
 HKhwRO4dDdJ7jZoHmz1XA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795051618; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:fYxCuJv+NSP5yE7qWASR7HUW5vgjmEA7/HTP3S4UK2WSlox
 qW14A0Ik3qFNnm3q14yIf0rlcInZQCx081wLnCCwf7L381JeYuwXE5XtdsqGXFlu
 svzNWSb7AJNVf9GhlB4qAZGly1+NcAIxOsX8r4RJaOuo+uqFaViT8AS6MQ79JY+d
 9hWS+o9oLcUqUkae2v/ejEXQUruDObu+O1AA3jaWHVvPDNvU+t4WrEvzOvD34YvY
 9yh+l5sKoHAiB2g+nT8zoMRDImSWGyb+gBZ8re/DZ17SPVyBa8YQezBJJxKAdZ7D
 1DQrcD+/fNuDGoKd2hBK0WHLg67+avZgQ+igIow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:4Le2aLk3bFBfGVh9UQlURDY0nVGl1JpIhF5Esmg6Hpo=:JLdwNU3C+mlDqy8LcInYuu7K3a3nWaIShir9WZS6Uyk=;
X-ME-Sender: <xms:YlD-apWzMhJ1g0Ib1jyq5_50uhWlrXmWZGXTbPhSrwA5z1v70JoN_w>
 <xme:YlD-apvV2xrHeYdlU72DKX3bcd-tBxahoWsHC3sUceXaYJvNUQ2cuMkRcxV7HdK4B
 BoEAfVmwzEKKqtxOIUkFLXPyQuV9RSDzEk2KG4Sq-MUaJIuyslJE_w>
X-ME-Received: <xmr:YlD-atU-OrRhB-O2SO23DUKdxkC5ZPNx4Ou6qxXYuQhvphhE9tIqTm8ObvtFv-sfFvyf5z2maav-vLB0eRKpNUE>
X-ME-Proxy-Cause: dmFkZTGMSbCw7h+usmDaotbPGu9H6NNAm/GIHRSBjspcciT+jENMMOYei7C3oeI2DyCU7c
 aMvWlkB92AOnowHzUXfsk+AKMHLX5+SRUIbj8bkSj9jKVRztgLRm9dhJ7i3GnPAPNG9Ddp
 2e0Q1ZKC3EcUbYWEnhkyMEFj84NZ4eEzlbkm1nQ332GKVZJJmtXrN0Fewc+x2XfdAgcXTg
 k4oToHeWYzS5OsCJEReq+4F6+maiplz8qJzXEQsh0zdaSklr9MgZBjhRPHuSAZrHIxnMTf
 Dn1evYMb6IeW2dwPYaql/Gt89z76Y4L9gQ2HTtPSnC+IwxYDeXGfOa8gNYY0aFS3+qmWYA
 BakmmPOnz+xWBLnS0GDNnleSvywSkb5oL5VYiMqSGxggBlEQgIYuyeJFC2xl8ozt65NddS
 capsIv6Q5CS/RXyodOs3QekXDvLJxlUEVBTCpK/uYtxHK8ifccCuo/jGm3re9+ZEK40qUv
 TM3ROX/hYGBZ2A0AhCyu+WY/VrMc5a+NI9cAKckCjg2QOTOfDUg0t0gsAFRCKji4um8Pw+
 4DNVOTpVnTDabHd9k/xQx8CItcQael8tZDCVWxbK4k9tKZvQk5CvBHa9nrM5ta1jEHx1O6
 TuQ8ft3u+YXqbvNn9F5kfsmV3QSTMup4DnNlFOb18kiFqoCUEf+kHjOvQDRA
X-ME-Proxy: <xmx:YlD-aknfyhYOPE8iKvTBAJhrLNMEBKJ_SU1TFXZ2-vDa61DdYOFFKQ>
 <xmx:YlD-aua1MoxYt4qEKOPGIVxcGSio1uMY9-tGOCjDyLjty5XaHqmllQ>
 <xmx:YlD-avMkLD7G6OJezR3tbtgKMdSKziSN5t_h8YdRxgcfTZPTPr0TNw>
 <xmx:YlD-ajZDQ5mw9Z0UYbZrWVdXo9zMA4neXlHJfUnFIau3MqweY6HGVQ>
 <xmx:YlD-aqCbEkNQxVu-Q3kzXHuh2Ntxz2fLCXibXpsjgyEDom_PBKbwXs_V>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 20:26:57 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v2] app/test: rewrite telemetry test in python
Date: Thu, 19 Nov 2026 02:26:55 +0100
Message-ID: <XfuFZ-HpQwi2KkquRcjNkg@monjalon.net>
In-Reply-To: <20260812190224.678892-1-stephen@networkplumber.org>
References: <20260724201541.801099-1-stephen@networkplumber.org>
 <20260812190224.678892-1-stephen@networkplumber.org>
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

12/08/2026 21:01, Stephen Hemminger:
> The test_telemetry.sh was failing with test timeout.
> This was caused by the overhead of spawning a fresh dpdk-telemetry.py
> for every command it walked. With every endpoint queried three times,
> that is several hundred Python interpreter startups per run.
> 
> Replace the shell script with a python test that opens the telemetry
> socket once and issues every command over that single connection.
> 
> Each reply is parsed as JSON and checked directly in Python.
> This also drops the jq dependency.
> 
> Bugzilla ID: 1972
> Fixes: 9da71dc4f96e ("test: add test case for scripted telemetry commands")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



