Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C93606A321
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=GVVke8uU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LyTv0PW/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78277410F1;
	Thu, 12 Nov 2026 12:10:53 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTPS id C9BAC40E15
 for <dev@dpdk.org>; Thu, 12 Nov 2026 12:10:51 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.phl.internal (Postfix) with ESMTP id 00917EC0121
 for <dev@dpdk.org>; Thu, 12 Nov 2026 06:10:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Thu, 12 Nov 2026 06:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794481850;
 x=1794568250; bh=QDE91pegxCsL4r93vxdEg2/nc2wL4hBIfblaEe8hCy0=; b=
 GVVke8uUW02HM2rUAFKs+RT5fvlGveYa3ke0DLTvq6lPjIg+hwboCd4u5QOc1odV
 usK1Hyjlx0vHyeGUSx+swRyzUXfDcUru8PgAMzoabqzGZbA5RMXClHxwkxsQmEZK
 afXS7rJg3iLYtk9xlF6w2xVkdXJMlNj8Hf/98sy53wbcRxtCOwaTgRVXpE0LEnp/
 VeciFnJ4zAAXHgBZCof1PlUVGx2nhWqHczP4ZvaFSHJHdcrv0d5DVw3BYq/6hDKG
 I+QAT/BSxaXcz3A2cK8+kx+wPAjIz1Z77lGXmGQ0PRDgqnJ2z9vHRiPe0/dJ1/Ji
 ZiY7eLemYZ6ldye8sB84YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794481850; x=
 1794568250; bh=QDE91pegxCsL4r93vxdEg2/nc2wL4hBIfblaEe8hCy0=; b=L
 yTv0PW/+l2S/MHrSEzVMD0rxHBGF4+p/EJ4Y3iNkFAg/2Fz6H88XEJYZfSUgWxNW
 G9xhNGkxQqEed0p2tT/4MPmxBcNiKu66ps4j8ebIdMbsJVSi8Ftivuv06p6X6TfJ
 cmGBVBSIptLEnII+RSGRAALcwXJ0OoZFtezgjXD8iMUtEWVPbtJ2NAMa116sNXi5
 ry6LQkiR2xP7TppdxhBxyiZ9BUYzl02MOv45+6SqLAQSRMQWxW7MjH7AtmZwOec6
 zd2fP3HGIioqN9MclLm4Vh2r+haJre6pj8h1ZzepYkeKQVBHDm04njSFZbRs4lcr
 Sy1HWuukI9r+VTGBfaaww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794481850; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:iWV9BStRMxbTpAO+h5ZgaemzlsV+GZweFfGsf+SoJlYB/65
 twBLuJUBWALqm/jx7VWSU5Ekcn+s/LeGGrbgiC4lFCV3aib3x2AEAikmIbd70Egx
 xXnx4J1TyE+0r5CBZZB0AYjgbIAt2TtsVt8fnCE738qKlaGradoEu3WuAFo91kPZ
 +BBI/XLgm6MDjQT3Qndgqgtud7lFtWz5QbGEvIlHB/HPRKOKEoTuKK5u4/ANMlZb
 fuLWuGQQj09HCImdy66IM4kh6xpNvv70sbCSr2UBpCOhPqE8rf2NHA2iBJiDrRCp
 b1E0FrseyadtI/q/omZFHuolisp+v3qJs3MGGSA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:GW5G8IB1op8Yrt8GQ9jhOZLiYguCf0/+TwVbxz/QmIY=:nHBry+VwVP5JGNNg3dpHkS4sCGjLENdY7bvJXga/P7U=;
X-ME-Sender: <xms:up71atG1Q2fv3QDf3is_8jzVJRDNuHblbXfVpLPTeGnXKbdInj65DQ>
 <xme:up71amobckU4fTnGvBjDF5MW-xLcgLua6S1lO1ITa_T3SF-THtL9Z3V_1keCsnM3g
 aXc6IoLV-rFq9IrZF-ieEjwabyrz9c7qaJ0UQM2_0bLOpUrys7fjfh2>
X-ME-Received: <xmr:up71auSagyMdz-EUgjI5jQB8QjePAK2Itp8rzzDJMk59bTIUbMPPgGzlhk8obVDRDcJiDiCv6DY77Amvfhn27vM>
X-ME-Proxy-Cause: dmFkZTGUHKAU45ZbthFq/AgeBv0i2iaCbtJPg/j64uO7vjIe2iT2lxV09fZfHbYfB96H17
 wsl/B5oIHWhr7B90tKoENY0DdW28YmRzMfJFxODTPI1Sla5fLNNqazQcjVFHXTm2iCdNDq
 RDjI2//fUfIFPqp3Conp8WMONIcspW6GP40fB2df6LOZCLxzXKvD/RD8DDpR+773okaljl
 fXmf+hOV4EW2p9S3C4dAQW6XZJYOukcopFI8sc3xO+E4HbbzguJq+yBvnTakg0t99QgJnB
 c6Op22OCQG87VNdvwah0GnmVlYuwEDePdvb7Dr8MVZ64X2S5tocaUhZvLcFFD5MY2KosfT
 bm4LsoLcecPeXEB5njk9r7W4IwuA8FYFx1qCauh/1JwDnCS/wWbM9LmjE1TVU5Rz52ovAI
 U59HmFlUKyJb/JYWjDq+mR6rluuqt29pjrerXOyBDaJJU1eTub0r4hpE10jj73OSKwD9w6
 UmVUTE6clnfthi2AwNcfnhxRvZmIBbkid/Kvuoo51/5Yv0ojiidFu54FnnNRPApqS23igh
 pzbK6o8/Rvt59qvXuKgxC5kwXwim/J+HhCAY9qDQgwDDh77Lzr3iQXRF1z5cvc1cXlU8wR
 jIAZcrv0wKaIo2r/QRYIvKFvgkEO6+kTM75/iDzJkAK66aoMVnHcZUe3Aosw
X-ME-Proxy: <xmx:up71arPCM5B_VTuReSIRjteS8D16glNvgXsw_iLOtaOBsHUp4L3RHw>
 <xmx:up71apPAeNIb-_M7jSx5VPmSk3cPTEVCL9t2irO69VV5wt7pJmEaaw>
 <xmx:up71ajuUvAR0BjTIGYhPGpS7uuA6tyvoXrBBRexbSCwUI7ryhB-mTQ>
 <xmx:up71arWaPawJzXYZRVGmTisZU3EWkWhww3OxX-rz_JfrlZGbewbT6Q>
 <xmx:up71agOr-1oz8t4pVEIHUBPGyueeFRyayrdmApr7kYOBXUTDhQZTPMjC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 06:10:50 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andrey Mokrushin <a.mokrushin@ideco.ru>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net: fix tunnel parsing of non-IP packets
Date: Thu, 12 Nov 2026 12:10:48 +0100
Message-ID: <6RD3s_sNTiOQb4LPi95WEQ@monjalon.net>
In-Reply-To: <20261109133712.152780-1-a.mokrushin@ideco.ru>
References: <20261109133712.152780-1-a.mokrushin@ideco.ru>
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

09/11/2026 14:37, Andrey Mokrushin:
> When the EtherType is neither IPv4 nor IPv6, rte_net_get_ptype()
> skips the L3 parsing but then calls ptype_tunnel_without_udp() with
> the EtherType still in proto. This function compares proto with IP
> protocol numbers, so on little-endian EtherType 0x0400 (also an 802.3
> length field), 0x2900 and 0x2F00 are taken as IPIP, IPv6 and GRE:
> the packet is reported as an IP tunnel, and the data after the
> Ethernet header is parsed as the inner packet.
> 
> Return after L2 for non-IP packets.
> 
> Fixes: d21d855464ff ("net: support GRE in software packet type parser")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Andrey Mokrushin <a.mokrushin@ideco.ru>

Applied, thanks.


