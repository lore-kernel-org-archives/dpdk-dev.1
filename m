Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB7AE9A026
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:49:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 171C940261;
	Tue, 17 Feb 2026 18:49:22 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 16D4F400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:49:21 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 795CFEC05BA;
 Tue, 17 Feb 2026 12:49:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 17 Feb 2026 12:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771350560;
 x=1771436960; bh=bQkSfSOCWPbIW3s5VMYP3djJhXwKeBWYoi32DdZ6alg=; b=
 eCgs9YpCau8iJyp7GEpJZ6sTjYkebPtzbtqfzUlqcXzPXXF62kJWo1Ub74p1lR4x
 b/EBLdLY2rVVlkK0nh0sIre4LZZgA6hcqd2cufuFvuRi/5JkjY45FWu+iQUjBB+D
 Sb32c+ZmpDxNahJyzmlomNLLVHFzu/k2nG55C+RubqN6dyIV2ElEecujZFjw+I9X
 cpHgjxvnk8WTT7lhBrtDauvTpIIEm6pZcs/K+E6fPU/wPVMUkoMdGLyQqIVvSSuy
 4CdVU6i3+DFbGvav/jtgPdy0FV8s01WcdHutniFyjmZQvhdccC9kclJffNk8O6LZ
 L7+pSnOxsX9/qYXZOJsrAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771350560; x=
 1771436960; bh=bQkSfSOCWPbIW3s5VMYP3djJhXwKeBWYoi32DdZ6alg=; b=h
 nY22xIIyRmJvfGhwN1Or4EjOgYSQlfI+w4p0YjCGgWBp10DlMFdLLKZ7IIaiyf+0
 nHNd+aaen2GxQDrcdkCI+JRN0DyQvhTTEVEHTgLTjunsR6DUOsj0tNBEhGzPxPqZ
 FD62ChvGL00ZxHXKD3ZJVFUZ6pbRKnpKFoFUEXnTUR6F/pP957WP+7JvW9Vn3dN0
 cshmq3n3FOif0WvFiRCRnYpGJ4Uems52j+B9shrHGSdigQUuU89OAGxYV/Cj88X+
 dlDxRMR7Jsdm6+jhT29gw0rISm2t0sYoiKKXRDuXeDkpd9k8r9PSmLugrZ67VDww
 +c4qtkDnuh9RX71G8AgGw==
X-ME-Sender: <xms:IKqUaZRwLBBTZUEl8F_KUKOtyR9n8V8nyGMFX0sF8iC_LBGwpQi6Dw>
 <xme:IKqUaXHSGI5xpatDGxTFyZuo2OO_DF1vwWwDHxgJihDF-udW5gSc7oIRdhfNrDLfw
 0xueq2yFeoUPGCf1Ujr7khGI_bDNw5k50OPYkJvbtxuBN_-xkQvGw>
X-ME-Received: <xmr:IKqUad_SY6cQEJAT6C3shrJAWEWPRsQYb1qEpiuOgPLNE1aD8tJALaEPPdb8RzOVcXunu-S4P2yVmRC6KU4sG3vPDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtgedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomh
X-ME-Proxy: <xmx:IKqUaZIaW25sPSKuuWjuky8Is-LRHH_J4Xn8iNa8iPg_NFGTKRhd4g>
 <xmx:IKqUaYaEvyU0SFEqX99zVWLzvv9DXtTkSUGO8TNhz-_V1K8pD2CgLQ>
 <xmx:IKqUabJU7msYqTEg4tPuLDGe1IlQw1OJi2xjdYJef9ozxe4Klejy_Q>
 <xmx:IKqUaWB3C-8QNFw5Ydqt_bWGnDj95HKn9uYIfsjyzEH2a7HiGjSInw>
 <xmx:IKqUaafb4-xZjA5WUX7w7Q__BqrDgTLQ8YG9kqksF2m44IJPKiFJOQva>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 12:49:19 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH 0/4] examples: memcpy cleanups
Date: Tue, 17 Feb 2026 18:49:17 +0100
Message-ID: <7759164.pCHx6aDRiZ@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65689@smartserver.smartshare.dk>
References: <20260121170540.785735-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35F65689@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

21/01/2026 19:55, Morten Br=C3=B8rup:
> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Wednesday, 21 January 2026 18.05
> >=20
> > Looking at examples and noticed stuff around use
> > of rte_memcpy. Probably mostly copy/pasted.
> >=20
> > Stephen Hemminger (4):
> >   examples/vhost: replace memcpy with assignment
> >   examples/vmdq: replace memcpy with structure assignment
> >   examples/vmdq_dcb: replace memcpy with assignment
> >   examples: remove unnecessary include
> >=20
>=20
> Structure assignment is better than [rte_]memcpy().
> And this is slow path only, so no need to discuss performance.
>=20
> For the series,
> Reviewed-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
>=20
> Thank you for cleaning this up.

Applied with a small fix as notified in this thread.



