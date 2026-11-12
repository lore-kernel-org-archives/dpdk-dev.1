Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF8606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=i9RBDB8F;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eX++YUF2
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B09642E3A;
	Thu, 12 Nov 2026 22:56:40 +0100 (CET)
Received: from fhigh-b4-smtp.messagingengine.com
 (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mails.dpdk.org (Postfix) with ESMTPS id DAA7B42E24
 for <dev@dpdk.org>; Thu, 12 Nov 2026 22:56:38 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CA5A27A054C
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:56:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 16:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794520597;
 x=1794606997; bh=yuK8e43Cj164VAcBw3qqMfA1dgfceaWrYawBZoIBvuc=; b=
 i9RBDB8FRvrA+0jQSVVn2aSeJFldVhoIcwf+sjLDb3tQF35ouxQT4cdSWGAwzYnt
 /iNcR8feYbtVTTakeCfSb5A7+D4yQDp8ZZcJ57d56vNeFbn1y9nYPzg/BoRPFJvh
 pSUpKoQBX7fGvrOv+K5+YwBP+Mvc5/bS+YXu7yPxrLDpj2vxKlq24eKtRuwv/8sd
 SU1DN/Rw1cO2ziScn7MjsHJ6Te5Zuc2MsSJAVy78ow74QZZlKRyvV1ZSy1hzwDOJ
 K71VgbICpmY0U2goaBfDSID4teet3IFvPCAVi4QwERI7ziFTOl5fFraSxYqzpSKP
 kOgHws68aVcyNblftLZs9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794520597; x=
 1794606997; bh=yuK8e43Cj164VAcBw3qqMfA1dgfceaWrYawBZoIBvuc=; b=e
 X++YUF2JZDKSe+iyCjlQpwBgFoTOSnMQojBaTIjswLGwRSSv9nNsufBseUGjZENs
 hxvoaXS0SE7PX1Q1+NkmVeFwj6OJnnIHSpT32zWo99VsUkNM6xmtdad7G2Q8A9j0
 9s5xZTjnqIdMeoaM5RsbgTwgSX+6my7u7x5eUzZNUAOAAH8SSyjdBrZQrRF9K21n
 krzbAs35O/vaD0rWWWDTy9VzeUu3yvAYv7mgr+0qNnwQK2+AOeEkvBaAbrir15Yk
 vpfPU8Z4PYMofKDHvx0LBggFozYsCxQtDFUBquNQCgWVOYm2eTU1lN7Y1ipvHua4
 ScuBJisCagrWV9d/lODDw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794520597; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:BrOqv+aHt/ZzvK4SEPsRpNb+btQx741/CP0YuwE6UT6Zvpi
 2X0FZqB6LPaGy1wrEzpJ5FGknY0SG1+1EUfQtCsjzCRlggaR8twhUrTdI8RwekvC
 Me6BnWwOfDzzo6XNhk6tz9NZ/Bu6NtLCb9OzLvb75I2zcZVdNbuOgrmJf88kdeNs
 aQvsV4OlCgGz6DH0ouwU4Hak1V/k/r/drgZ6vFTuNHZSKDoRUFn4iyH+LJcSc++R
 Ax8oeqylxawGtUOh/OjT8PVwX83KXgwxVN0kLmD5pJVV/+I8d+f5vwEALwIRmEcD
 kzwmUimS0lsW/Uf1ERS5d1FVK6k1rRDClKfWBeg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:31QlsqoovCR1njnUreuhYPqx95/D4n1i3XOt5n0CSeY=:QRyG3ZM06kKoiZPUj9ukBSVdMJbizhxPiibpurBa1+0=;
X-ME-Sender: <xms:FTb2arr9fSTtlOZxDm_SgBKUCSBDZBPFlYn2TEe7WWA6UxW5E5lr1Q>
 <xme:FTb2ap8PqozUojPhGfbjbSTxHF72yKJ9jNLaUSM704sK74KubhdDo0ymo9fitdlWW
 qW9SPTGLeUmfRGUtlvK2TQ1PL1qsXcObRoYCCaxj58nZVRd4evBcpI>
X-ME-Received: <xmr:FTb2anUzmtIcMnzDnoQLQ6x5X_DZfOzseabNwK3yb46udnhm4d0GyqvF13vlT-K6fAlkV9tuU6mta9KNsxMRTGg>
X-ME-Proxy-Cause: dmFkZTE3haW+Dw3AeNFOcR/xI2FBwa7M6SWlsIqBD8vRSm5pnteM7bxg32ka+WQTeMTR/9
 fwZqFnT+67esfbhhj33CkiFugMLIjFXOZ9DhjZwQWa48DDbOJU6sGjsj+C4b14HNw2yTBK
 /x1eGX/Jb0KwNZcrLHbR+UCYUd7JcFTTOoHEy21F5eOPeouRPubJu9l2wNqfETohogKo+X
 N3lRty+F5MIfJ5QhVKLY4pxbAGvLUMu5hBS0NS2KPWCXJ1M57V9mhfYpCqMLYxgSLoUUdB
 2+zzCeDq1BVhEeVkHc4Nk1lPH826vU3PooSAw2bxo3HnuqgW1EUharZgoc2usdySbNOViF
 /1jcsMKkEQ/HESZ/fBuM5D6Ut3lJMuqYamwmWMZoDAF84vz3n7k0OQiL7ud+FxUsAWowIN
 GsSB5u93mID/PgjDzbmTEAVIU0yDkgSeUPAsuY6S//CKUjLsPdNwXZnZ2VoYkF3oxiK+U4
 vQgmaV/2z9g8UWHvKqsbLgsWZmM+clq5ruqv3MJgA8ND9DrbHVUU49G0Qk6JMZYp9MOrxn
 Cwgexc28icyIyKPZlVC4lF+A4E724JWkLTSPKH12EVxZeCFhXBwSS+l9LsbV927d2nG5yf
 DC/rsAAtgFJaMAYSBA1s0WC0kQclVITN0JNhtf0nWJqxoHAzRCcpEC5UkMdw
X-ME-Proxy: <xmx:FTb2anD-kM1qB5qKwQiWL331mfA8N1kB8lMyTQzGsVomFhvt77JHgw>
 <xmx:FTb2agz-Eq9QH6sp5d4oZ6QdRCOKnbRR3wFLNTJ13Js4ZbDcu8nv8g>
 <xmx:FTb2asB2Lx_XyRm9cyZ-a3NCc790tsfWwlDl9BUIHOpDcmpGF5Fx5g>
 <xmx:FTb2alaLR0_b2UEG5Pm2vCbjMZ-glkCQHl_AMBOg6i1fmuMbH6QNcQ>
 <xmx:FTb2auUI55Fo85BQaUW1MmvNlmeVgLzA30p8Bi2Metl7bFcF-jNTPKTG>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 16:56:36 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Su Sai <spiderdetective.ss@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] app/test: lpm6 perf autotest fix lpm delete total time
Date: Thu, 12 Nov 2026 22:56:35 +0100
Message-ID: <PLCfV-XiTzmgt-HvpFlQPg@monjalon.net>
In-Reply-To: <20260819022844.58986-1-spiderdetective.ss@gmail.com>
References: <20260819022844.58986-1-spiderdetective.ss@gmail.com>
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

19/08/2026 04:28, Su Sai:
> Make total_time from '+='' to '=' when test rte_lpm6_delete
> 
> Signed-off-by: Su Sai <spiderdetective.ss@gmail.com>

Fixes: 5c510e13a9cb ("lpm: add IPv6 support")
Cc: stable@dpdk.org

Applied, thanks


