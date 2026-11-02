Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249B607B455
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=HLI3OsRG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QfXDaVZK
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5757440E1F;
	Mon,  2 Nov 2026 15:38:59 +0100 (CET)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTPS id BA04A40274
 for <dev@dpdk.org>; Mon,  2 Nov 2026 15:38:57 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id AC48D7A0123
 for <dev@dpdk.org>; Mon,  2 Nov 2026 09:38:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 09:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793630335;
 x=1793716735; bh=po1UQXrnxnRzUxTxAnIbCT7VqHIrFVgNLTBZl2xwL28=; b=
 HLI3OsRGZukbvLpn9T/p6BnrWWaYod+JCyUyeugcnVAFXDLNKGyuALQeRAgqjtXa
 nBby0G/IWqwK++c+VQTKSR2ZompJnajWE7rq+6eFQqNvmsT6LaNOJYb54btNYEmh
 QGMol7tYCYksdfYtbgmANY+KYBFJPJTVx9NEl/Zw05/EqfsW+R9ABGIoIuF6kxha
 7s9QXwh6gKWYlM9tDwMfzswvf80XDPosf7Ms4223TIh4kzKK7FjMO4Z3zx6z2N9p
 /gS6PdrN1era78wuRMlSeMotZg3D+mt2DBQ20bKyaBzFAFKYC5uQL7rYPffKMbKW
 JK6D4nzgTELocs9M1YP4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793630335; x=
 1793716735; bh=po1UQXrnxnRzUxTxAnIbCT7VqHIrFVgNLTBZl2xwL28=; b=Q
 fXDaVZKapKQqCMxcr5UfEg6cAuu3xPIBN75t6XIKAvnIbOzUZAMIMvRU6arpcNYK
 H7yMxVUzSW8S/YsjWAtGEPzDnJ3DZzzP/RVwB1dqj38TTPExTrXAWQTyJkKC+wv0
 60GTh5L43ZNWbCjUFUigyiYfj3avWEjXCioGvUr0JYGn5PlyxuqD/4wZ6V/ehTvs
 suBr5O5PaPJvNQdv0ZH+kLxUxi+Z+agokeUh3rJnFNwt4iyavKMb6VuYSZnkbLd6
 13y+3VtONIxbFHLqpYSC1tSqZ3mChRev4U54iz/DhWicoa6WS4mKVxUZdMrhw1VC
 IDm3fyoJUc/wu59qCHmFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793630335; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:LzImPbE9KN/bwaUkMMGIexAA4E8aBN3I36/hKIbBTa40KMk
 YDVfsVM3jPRC6ahyNkvARHsy2FP2dkBUEuNvdbiIO4jhSP1PLyDc8ZEagELwd7nX
 aFz6VL74rQcT2sBqwkDZEb3kpuXbFwSH8GaLxu/PcshPZf6eN7bHxhFTgjeFe5LW
 eJghicPxwG9cclr5tZYzSN+2QnXOcKO4vRsRQVCCyc7UGNr5WSgp3O81BtPOYIcQ
 HQoQHnDBFp93gQo11z0taxKbby12/nKb6e7r1MfZR5zxAjhNSkp2kRe5RPOKZ3cd
 W21HSZKct1Xb3+l8nHURCL2cqBn+ghl46sNPhng==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:+BMROzR1NZxWDoKjvltWAwa1QIZ98YjOEER+96ZWIxk=:po1UQXrnxnRzUxTxAnIbCT7VqHIrFVgNLTBZl2xwL28=;
X-ME-Sender: <xms:fqDoapgRaWun6vg_1dnxlgrVgz3lCZ_fo0UNGfAWpyOgu7mcOFcYwg>
 <xme:fqDoapdbQXi5TsCVV2VlZ9dSJHmEV36TEOnYxlboDO646oTXaUjlbSvdpDZ1JMXYx
 tDWZIMbqRrgeeyz8byCilVY_y0OJYHoi1Q9AosdXeWtuyok0ys7PrvL>
X-ME-Received: <xmr:fqDoasm8PNVm04gB-5ocjSQR2ziSVPvtX61en6m9LUmVpB5hew_q5py2na_9BmehmlLJJTOOinD_nWvPnP7zfd4>
X-ME-Proxy-Cause: dmFkZTFb5veipoxgbxBi2KojU1iuqT+z+rUOM80yImoHa7+MZCK+RSDbFDpOscswatcH8A
 D70ShrMGshXmWr8nPBdRpYgdxDlc0MpmOu+9j/J2l7O68AVWldUnJfxKBXh12e7CBGPQ8l
 mjsMIP/Bw6gopXEGQPfMoEM1N/4VfGtze3RT5HDGRLIX3KiX6KMqlbaQO7FMoZiCYEq2FY
 htlfnJjzng786FinGF9mZTaLPsBHF4abE7/rrBChrylYT7m2g/uJ8w1q2R6nT9DNEZpBJE
 yuVacpKj88KKbxU72iUafm7q+uHIMHwDh5urd1NDp2XWd0WxUuU4bknF5CQbE52ocHWfYh
 YRW8u3KJPiy6gpR1rOfKdzld7V9hSUUcGZLQLi/Vc8PwRU6wTn9YYSw5kHTQfgYELL++1/
 YyJT2UUr3f+zYsCVnxev5QR7Ei9c+dQ3IsB/mVB0VZHVIficMBI4sKMjZDckf+pOvChxVf
 vJuJEPwZmyH0a+LbnGIm8wxAGceVxkKMzTXUItGwSpXAfbBoAABql5bydWnQL/PteKYFOa
 v50OO5r0Ij8N5ys/fKl/H9GNV2QqDDABT84IixEB/vYzWwKpviC2ys8SZ+fHm9Uvlkc0iG
 U5dXHsgpRIUom/jBZO6C/aHKFyYl8b/YRYNURU97a1gXnsNwRRvqtcOlITQA
X-ME-Proxy: <xmx:fqDoaive8c7Ep_PdiGyzntAipKwU7-Zct_EtiiJpVIM951YeuPH6WA>
 <xmx:fqDoai_NTCf4XV9D4tHel8X-nnc7LE8B-cFWK0iGw2DcItcg7P_yBQ>
 <xmx:fqDoakPBACsRd1WMp9jQ5n8bACg_XxSVPmGuAbsFAO0hwMx2Aqkewg>
 <xmx:fqDoaoE4znUyUx6-US_HVi5PF70r9WbAJhewf6BURqRg0pbo2AheMA>
 <xmx:f6DoaoRfSAgFx92v7LwRnRSb-xYrALYmk48ztjFblr2Pyn_Ow4lXFH1m>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 09:38:53 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>, dev@dpdk.org
Subject: Re: [PATCH v2] doc: remove mempool deprecation notices
Date: Mon, 02 Nov 2026 15:38:51 +0100
Message-ID: <ZE_OMsQ2TM6SfVIXb_wT_w@monjalon.net>
In-Reply-To: <20261023075114.35991-1-dsosnowski@nvidia.com>
References: <20261022164844.34845-1-dsosnowski@nvidia.com>
 <20261023075114.35991-1-dsosnowski@nvidia.com>
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

23/10/2026 09:51, Dariusz Sosnowski:
> Remove deprecation notices for mempool:
>=20
> - removal of flushthresh field in struct rte_mempool_cache
> - object array in struct rte_mempool_cache is now right-sized.
>=20
> Both are addressed in previous commits.
>=20
> Fixes: 7dbec9e69c36 ("mempool: remove deprecated cache flush threshold")
> Fixes: b815acfdfc48 ("mempool: remove cache size limit")
> Cc: mb@smartsharesystems.com
>=20
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.



