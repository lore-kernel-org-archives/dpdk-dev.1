Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F6606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=1CTcRK4Z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0o2AELkQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BF6B402BF;
	Wed, 18 Nov 2026 21:54:32 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTPS id 4C38F40298
 for <dev@dpdk.org>; Wed, 18 Nov 2026 21:54:31 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 2C2E31D002A3
 for <dev@dpdk.org>; Wed, 18 Nov 2026 15:54:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 18 Nov 2026 15:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795035269;
 x=1795121669; bh=cuYmGowbrIuzvP+7fasFEeVpylHYcvGKoZXB9mQvIFw=; b=
 1CTcRK4Z6OAWPnTL6N4gS2evXiXryXwUotjOsaKSaJYw5tH4wkuVgpXmOQg9JV93
 Cr299NUAdnVMnF5/9fG/u1gJN3NedxiWS+JuK4D2FvHP+ow/fhXTN8zEa2dyyaup
 FNj2mfFJ/pXR73EP3vhw21uw6caoy7ddDVX5TZ2e32nReHKuP65z2bsPGcvgjmSB
 13f2ej/jkvt4b0PWShoTIdtwMIV6g+tBJyhhE8d+lhdEKw7Ml39KYdFU1nDShmDE
 /zd6a66PCNp6JsulNX8WwpG66ohNSi2g+bg1iAqr6JOckokH0171TPeq+7enqM4X
 6q58KOWwcvVygEGC6/c6TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795035269; x=
 1795121669; bh=cuYmGowbrIuzvP+7fasFEeVpylHYcvGKoZXB9mQvIFw=; b=0
 o2AELkQcEUvQY6tDNeUi2sNJvOvCmfVYXklkVuQ3xHIbaCuzoQRGaTrsQu3MtDsK
 wcE2eyrGj5dM1/uCy2EOlWrBfCi6Rg/iuGsk3FrDMyvv7f7Ddc8+n6i6PiY20Q5z
 v73H+JRLxAGPnwJdJPwwt0ohF3a3cDBptKLnw+HWEkUc5+2XdaU1/+sZn5S3CKWw
 hduA97+oPc/jIXT2dSdjJrid5CW7S9yVskB8Oml1nnvX3XMbZS43jtgRJ1/84o9t
 Hsy1WClTAeUevflRnchY8l5wjErb+ZX7nUnkaN6HdRCsGIB/uUYLGUwgLaN+DqNe
 6Y+wZWAw5SezBTrdOa2fQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795035269; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:wYrYhgV9zSKfUADwnEQHsbVbkdlkNOLNZ3duk+uclGqBXJg
 9KfKC1dOOSzeW9xKtbAMtKbaFFc0oxGeaZpwMnf/WUES8Mgsdv80QkgIfdOjQxhE
 a5CuKaBvaaDfsWG2ffjhljruZWLERY0ZFSbvhiSWw+d4Ifd457eTzmvPDwlFJi2l
 DI2uCU22q4J26+ItWqrKy+bUyhF0/UNdr26qrLcx5k0ZLO3vY7ooS8AAll7PIpFK
 b2ALc1y9pJLZH9y235eDYvqOd5YfPdcB8cAMH4iG8AZ5e+277qelbhzqs14EB/aX
 fhm1pMdK8mxRgEYqPs32GdA/hKKqRtgHhfaa8Ow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:njvSLt6xf6ceq84Pkfzesh9u4rx6LV4CQNRICkpyatU=:cuYmGowbrIuzvP+7fasFEeVpylHYcvGKoZXB9mQvIFw=;
X-ME-Sender: <xms:hRD-asSE2oa8V5WpbAlktkfnhcXwK6L9yLI6RBjaHhvIKULEA6ihYg>
 <xme:hRD-auGKmrhqLriuakdfx4FROs4RGjJHWRYZ36YC7h6EhAh2DTm_eBsiWn1ptYUGk
 Mze6ZjOc61z0GnEN9kNVhjSSq2Jk52prxn9XRZaWczLc6-TCGQAukAh>
X-ME-Received: <xmr:hRD-ao_6k3Mmkuy4sabu-MZEWE_L7858JKv6wFtkVCosHVC--bx7gzWjX1GoTPenQmtpmjdNnRX43e_VUSkzdNw>
X-ME-Proxy-Cause: dmFkZTGed2OA5TyKxjXQBlCC3Mzzd3HpM6o9d/TXBm8urCfJG1xKFwhH+egHznPQMZbE3h
 vGLGjGm8Sb+WmOWjNUC7FXH7Qt4/TDtBnjFjGY0TeSfVgYQv7HiLd6v84tzsPiFfb8zeXH
 UkiZsVj5ZAaOtCUHAERHo2fUfLA/otAIGEPmBAEilexG/8U59XAi/Acv3ND5GLT/D3fFez
 IR66WVU2Ln3LjrX4xOD72I+v14SXsHyyPsP0zjQLEytrIDqF9hh8HF7JOXqze9Zi1aq275
 svgn4dxQgnbkmsLjKsb++rlpExoCqUkD+SvkfRd70YxEOs+oxs/dlcGuk9qy1nysIT3dEn
 s4YSMXIrr5OA0s61TKZyeslWV2HWylnAYLYxK9WuoTv8tO/jmkJEs7kBTPfaTTe98idAh7
 k0zZ/RoEVK40JOFThF0VwNP9OQXzuC5ka4j7LXQt66ctCtw3ZjY9HHujZoYpTqm5uJmOKe
 x5ZHoTy2CjpTXazc01WTBW3zzrsXc4liZZ+x/7HpflhBALVy5ptykzCS8TlkKuJwvjn6vt
 lklWbtLTeUb47uqCYhtIrxV2HBdiHdMoxFkbIqIcqvZremE4Bhd3dQrcdfZgUcTPUisJ4s
 k37ug8SN6OFEBk9RYzUm9QmVptE05FHyoW86c09EmNScvn2kF1LKyLNGruFw
X-ME-Proxy: <xmx:hRD-aoIgxNhwN9xdls4Q49VwLZY_18hBRX8E8SQJGlZ0AzhRBSXjeg>
 <xmx:hRD-ararDGkQFn70NAgDB_neA0d6Ep1V9UZR1eaikFhmDVllTteNxw>
 <xmx:hRD-aiIkPSWqnEtsiqp-MgknDce0tCHP_AHMu_e6nGahLrjv7NPyMg>
 <xmx:hRD-ahBqOP-RiVvPnJCzeTzTCvHCj98pPnmaewilTZzbfzLZicVifA>
 <xmx:hRD-ahp2rDpf2ryTKZwjDrwkyYa4fhDvKeybIg-rn9BB3igfrcUvRVJI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 15:54:28 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v7] examples/l3fwd: fix RFC 1812 checks
Date: Wed, 18 Nov 2026 21:54:26 +0100
Message-ID: <4QIGXl1pQp2G7vGRVgrtvA@monjalon.net>
In-Reply-To: <20261113203236.597141-1-mb@smartsharesystems.com>
References: <20260915105822.988106-1-mb@smartsharesystems.com>
 <20261113203236.597141-1-mb@smartsharesystems.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

13/11/2026 21:32, Morten Br=C3=B8rup:
> Five bug fixes and two enhancements.
[...]=20
> Fixes: 4b01cabfb09b ("examples/l3fwd: add option to relax Rx offload")
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.



