Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB6606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=QVNcuwQQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3YmCO7ed
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2172F42D7B;
	Thu, 12 Nov 2026 22:11:45 +0100 (CET)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTPS id 2437942D2E
 for <dev@dpdk.org>; Thu, 12 Nov 2026 22:11:44 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id DBA791D00147
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:11:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 16:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794517902;
 x=1794604302; bh=yM2nrfGF9jOtLARSawNuh8eQRj3y1lSTuQ8tUSR/+rs=; b=
 QVNcuwQQVqiNjwsKM6PniG0GXgtqGCVOFHGCFxvaDEpeEzPIeYYjFp9F/UF8IIYd
 Q2OTPM6lhj6d35coYww5Ud2b6/PIagi3DxS2kGOKrVm1Op6t4nmQFFFg+MaRbso+
 WRXmgjaXjzCARqnLtgpBfCLtZRZjtiM64TpH1NWHfYZiaOdMjqgeoKjHvBf4b16L
 iqBYXcdEQ5V6oGmt6jBSoYEdaxgX2s+hGgtdwwnr5fpCWLXjyXQzkKclVjEJ/qyq
 CHzR0ee6BmOcbqlV28hs8ZJlYyrTiMgk/P+/dG1x7uMj+bkGKWzkWLASuog/7QpR
 bERKn/6f7s9i6sac23hnRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794517902; x=
 1794604302; bh=yM2nrfGF9jOtLARSawNuh8eQRj3y1lSTuQ8tUSR/+rs=; b=3
 YmCO7edJfVIzVHKw6rxOQA1qp3GjMd37e4MNL+bko86FtlgTvntO4+R4RGBlO/H0
 ozbhecAe+S9iYrrtLosAVWAxkrTYMJOJdhB/QnpzE3oUkDsuxNAkpLghMz5732xU
 LuX+EHreqa+vdnaEaQSiBEf+KDELD6rO7aKOuplMGlbxOEgROpJ06TYwuLB5AIGb
 DVnPY0MQxZsa4dfoJnWjT9PpbAhlHYvvVArxsitQr1mPAwZfDA1aW0ZdGyFgv42Q
 kRB+KsxsAofxwAdFsXx7a6wI+bgoXnVTK/8RyxaqKzOnXqqA1YmW+Q1uzJdwZSM6
 T3dLV/Y1K+Wy63ugy1Zwg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794517902; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:O4zDffQKwXmDIghLjIY36/TShbBYV2x93UXgxDBKY8A8XpU
 L9uku6BO6qivmoUEnxJYfTpAdw1uLLw2XJYU9yJj3a3wSR1rgrYAqnHDHHA/URht
 qRNlB5vws2fE6Ivzc6IWJZ06lEUIVMem9qy9/SibosPK9lNQroZTUuY7aRc+6cmb
 ttUaO6Il3jDV/8pr4V1+vp+nL1b3tFI7xNumwJGQ7OOKsOfgkFgC7XVNZlRYBVu4
 F1fg/ycqgT8aeCkqN0ZaAjf4xqCjcdc+4G1levdUJklY4fvIbaWL58+jX+20Q0mu
 TEAKLM9lpU1TLcii3HXPAzfm7FK52zGTx45Zm4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:k6aKTz6tTZDwWO9iqBfJSjgONzFT3MRzAWSapBQ4He0=:8ynwGAf1dl3B4RdNwojvZE2smUaERNtKZChXCUMTBiE=;
X-ME-Sender: <xms:jiv2av8n0vWM-Y02HzKDaRM-KLpwkGw-d0ugoLFJU6hWNU1hZCezyA>
 <xme:jiv2agANFhna8FX-Am75FSO-qccG_JN_EUIk3Ol0rSMO7FX85QVyWWtlye8WY655f
 _sKUI0eygzfU9hv2XkxKqgShX_-X4VftaxHfdolwIWjBLTvFdcN0Ak>
X-ME-Received: <xmr:jiv2asI7plWRL1ZRJc6rjGBMKI8MzpKBgzKx4Bom9p623q5OjKKOuD4cuvCeq-xIQwR0SOB_uBaTVEDzijnUoac>
X-ME-Proxy-Cause: dmFkZTE/VgCCkyjjkp7rMui9dxxwo5LQGChed92Jmo893/rXMO9Ak0Hq/yQROwyKy2S5YZ
 aHz2H3UZCfT+HAnnBtpOk0moLcKnWrCLKC9YPgakUfXMF4sqE/6QmmIory+rO0tTPHDlQK
 hi/YVmbLW1OT9Ul+ig0msJQgGnwHKrx3RnfsiosED0zS1Iwx7gRAJlIBIMeaxnX02oVkzQ
 lh+jFSs13ddW0gN8d4SKolzC3Ot+nRG9zXVHAFlYCS5h7KuyQsIUpUVs7EuiZBspBc77b9
 ZAds68WebEZdqdlujNMwG52Tm/9fu98aHeJNl2h261bXw0ZMkzZ5hEicJ3YKD50qZ9+bdv
 hiPs9AYwvuoiaF1vaNZ9uhOqBKrwSHoHC1/ZE1olJKktNPj5y5iYNS8sqXvTI2utqZvGQ8
 SxDZFkLb8RR0jDIbBRnIbyWcvQpS+U6tTeZL25KEWQHYSAFkcnu/3fASg0A0oUat/AQjHV
 yfyKpEGKCgZWvHVncZ8fJXAiBmuLZFYZZshFQxYHMvLoEBvscoZm/eKeO1k205XR8QMEAk
 FUuIfbvFH6TDdVaorymV9MxGhDFVw5W7UunM/Sm8KoFA09MGB0Pr4iqQlsLKQkM62GXrht
 jdqA8GiPlxSo3MHMREg+ID7eU6tz5kioQCwwLeytXRyoD3ohMOKnWXKuhsAg
X-ME-Proxy: <xmx:jiv2ajm1IdbGidh5imIC4s4O0LCcxyjoGQYiu4ICXZC4AvqKJf8_xw>
 <xmx:jiv2aqFnNSji4NbkP1u21WdDvtXInDl-cENDXRJwYEHzwkYCw2tbFg>
 <xmx:jiv2ajFJDimAN5Iza1G7dUKt3t4uK12Z4w9ig0Wi9ePNScYu9PQ2dA>
 <xmx:jiv2anOrZLKGt-_NTwsbjnHNp0WhnNMl5yxKtOwBV5lSJnyOdEw4Vw>
 <xmx:jiv2atk6gPmVBxntaSChVUB_4DjzTMUzQraeKYnvXxe-G1nzQv3JZ5t->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 16:11:41 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v5] examples/l3fwd: fix RFC 1812 checks
Date: Thu, 12 Nov 2026 22:11:40 +0100
Message-ID: <p157maOqQ8evUr4r5eTihA@monjalon.net>
In-Reply-To: <20261024123557.3234240-1-mb@smartsharesystems.com>
References: <20260915105822.988106-1-mb@smartsharesystems.com>
 <20261024123557.3234240-1-mb@smartsharesystems.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

24/10/2026 14:35, Morten Br=C3=B8rup:
> Four bug fixes and an enhancement.

3 comments from AI:

=2D The software checksum reads the header before validating its length.
  A truncated packet with an oversized IHL causes an out-of-bounds read.

=2D CKSUM_NONE packets are accepted without rebuilding their checksum,
  so forwarding leaves it invalid.

=2D Pre-existing: the EM path still calls send_single_packet()
  after validation frees the packet and returns BAD_PORT,
  causing an out-of-bounds array access.


