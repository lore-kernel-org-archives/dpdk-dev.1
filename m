Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE78606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=M4STIHNJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Bep0nmUL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C0EB41611;
	Thu, 12 Nov 2026 16:00:49 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTPS id AF67D40682
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:00:47 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D764114000E3
 for <dev@dpdk.org>; Thu, 12 Nov 2026 10:00:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 12 Nov 2026 10:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794495646;
 x=1794582046; bh=zLm2Kf0lqBXojd0sQhmRB0cSFq2XN0xD5Ei0IYhhRos=; b=
 M4STIHNJXtGJi7Vuc1GZRm8x7HRXkslK3zkVJ7P5e+EG4DLdzzXbN6cegwXzIoIi
 PnDDiJJCce6lhst55z2hqQzuJfOG2e2teLXMndkLWm20gAHakSbLPG8/LkIcgJeC
 OVKTzI03OVaJsvQjSPsBQjpehIf31Fem2aYd/ZuZ3p8IHlVJE6RLfYKnDRHrSy9o
 OIdmfpJL2c9gWA+sljIKTVL/3Z1x/5EVvULHhW7f7/DoSL7IQK/0JUBMl1/efor1
 6LgtQvKAZULMBnavrQjBesoN5a+wxShAYtM6f9HvfaNEIG7evk0IZRo/bCr/17N6
 Iw0OKhgFcxx/kU5l2bh4zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794495646; x=
 1794582046; bh=zLm2Kf0lqBXojd0sQhmRB0cSFq2XN0xD5Ei0IYhhRos=; b=B
 ep0nmULFVLMXMywmH8BllaIR71qzGCf4T/Js7ZIoLq4z2zEKdto82kZcB+47XUsI
 l8THlA0XCKzdbTD/uXunoPVSiWfI26XJtEDBExcJBFep/GmlM8dyNfMdE7fFDDow
 JnvwUQlYyZdarCG1XvunsfWaiq4nQWXrgSvbx8lsi7zFYZAibMRRXeyaWag0BHlW
 wOoe4G9ETtYm0ChV6gBuYyI1P7CgHdqPqHGIUTQdu1nDgyvQPdOzfi0yQR7eNkHo
 sQZTM8wihVLbUBsMtE9Z3cDyAYFN8iwAU/t2h6ixojiRhCor/4XkRdr1DDu2BQn7
 fm8NVJV+g79q95sVZ5lMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794495646; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:iu7DX3jBGyYhmCxHoFiXVmvucODS6LSu7fpxx8qs8Hr8ZSa
 QzS6LAtxPFH5+z3zKFcjc+xsusWQfqy0pnSYAe8hke3C90M42D8vYr+sCehY5gmf
 fIN4T01HWEwWpDCPD46WTISBrkLPDSuxryJIZPpQ/IoaH9sJGZz01Roq+JSRjV5Z
 gHAfPo4SoE4u4Y7r0VVHS50uCZobO1qnEM0aDqao5qfPnPoqM++cjABVLIyXHJ29
 k9N6fUYGGY8GdlSGevoWhJOODteOZU8/WMFqQzWqFMmyF3t6iXHM1QjVtLWotCVm
 AkPCAs5EtKuh4rexGBWMfOLEQFreNOtEDa7eIkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:qgfCWTh8pcQziSa1cMCFHSsk4o2OvhCfkFCwWxPjpb0=:/UhTx83e3epmcD9kUl2lIDl08utktBAHofJ4JLLEZng=;
X-ME-Sender: <xms:ntT1an7saNf1a5pq5MXLhoj7mUBsHDAsgWRj1KXCsbi6fyI2zwkKwQ>
 <xme:ntT1ahPR5eExtmGzwjFYrGxwZHlwciADMxZn_29-vnhgj2L76eW1BteOC-iFT31gM
 MJHAS8ejNOzg-udpbtn7w89L07Di4y1_UKAALIr7gx1myX5YLdRRkg>
X-ME-Received: <xmr:ntT1atnJybv3-eSokXvylDrB2clSUaxlIfQqHihl4xfwsmPE1ElgjpNceua8scl_2-tPlMc4dvZkOXbxlhb7j2Y>
X-ME-Proxy-Cause: dmFkZTFBAHrQ/JbiClFbQYJK075v0zJAaZTKrezMoecD4kSJa7Qmc5sb7eB9e704zNw/Qu
 JUVnEuI2mere9UP2GeuCYiEWwYHL8BSlK8Xl2dq+GmogB1rpSVtE4V3bkxhym8l63vXeA7
 DfuQwxcTqWWQUejO5A3fZTXuf66j9akfy/NuJw2lcc+aSpkzLsWOEDSLV0QCqggeIeM2aY
 O6vNQjiUFRHpgC8n6stLGcWhhete6o0IdMEy6v0Z+7bHWeJUiZOEj9CpNQt39EQeSZpmaR
 7Pw0rGSgpZEQVwBFFyedJX3UtaHxV5dCoqGl4oMxI7XrrIIxdexeZb+ovzg87ZhufqJZX1
 XwgQNhPeGCe+7WuBHYMEbj0vMu+2SZ2GGOLgp7KKN8vtoEpnmqwm+zhtyJjSXAedEUmONx
 DGu1Q5WqhOE6LMtp/4yqzPajWD/1fuf8F1wo+oJHEP9USsTX8QQgncocxvNTuPGbgtLlVV
 9C9tw5iRtmi1W6JZWbNihVQxVwrs3YvxJhwB5ozSQ8nXAFkOI52j2yopOx4tv2zq+ZEOSW
 anKxMdxjjUO4HaxCQdjaGgAPHXxC/9MWkGO0EnKyk13C83YmzWNlx+y1QTqWT/JOa7bykv
 1lteWCJ1Q1VLN2TDOHuyjJ/hd6N5HLRfsuB3RcnyDX1fc2ObLd+impHHfLVg
X-ME-Proxy: <xmx:ntT1agTfITSIpGh5JZApMaNlvP2MVBlIxdAb--xCfrS3YY3zh4vI6Q>
 <xmx:ntT1ahCV9-SuPLFhG77tkpn47-zBJpkD8pK9ZGNd3_S7IVi4XOAYjg>
 <xmx:ntT1anRb4SCjKGNwv5leWbIDSMFRmQEhQZsNhcF4jqbuo-0GvWN92Q>
 <xmx:ntT1avqjb8n8kS4uc8IqCNBS-XcfSiXd1lUXByr_2dJ9-BpwzktRow>
 <xmx:ntT1an7vAlCS-831QP3j6ideCSYpc7FSuyajadCN9ab_v1m-3-ys8q5k>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 10:00:45 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kai Ji <kai.ji@intel.com>, Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] crypto/ipsec_mb: remove unused ML-DSA helper
Date: Thu, 12 Nov 2026 16:00:43 +0100
Message-ID: <MojlejOjQoWia4uN0nw3WQ@monjalon.net>
In-Reply-To: <47dfd5a4-afad-430c-b234-d00a5a9e2a85@intel.com>
References: <20261112130510.945641-1-thomas@monjalon.net>
 <47dfd5a4-afad-430c-b234-d00a5a9e2a85@intel.com>
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

12/11/2026 14:28, Radu Nicolau:
> 
> On 12-Nov-26 1:05 PM, Thomas Monjalon wrote:
> > With IPsec MB 3.0 or newer,
> > Clang reports aesni_mb_ml_dsa_sig_sz() as unused.
> >
> > Remove the helper, which has no callers.
> >
> > Fixes: 4ff2a4d23d84 ("crypto/ipsec_mb: support ML-KEM and ML-DSA")
> >
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> > ---
> Acked-by: Radu Nicolau <radu.nicolau@intel.com>

Applied



