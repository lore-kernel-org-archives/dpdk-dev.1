Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98CDC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 00:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC4EC4021F;
	Thu, 12 Jun 2025 02:11:12 +0200 (CEST)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mails.dpdk.org (Postfix) with ESMTP id 18DB940156
 for <dev@dpdk.org>; Thu, 12 Jun 2025 02:11:11 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 52A9E11400A8;
 Wed, 11 Jun 2025 20:11:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 11 Jun 2025 20:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749687070;
 x=1749773470; bh=p5pV59q2J6FCRJiagGkTn0o6ez1jfcJNBbsz7ZnsFpk=; b=
 VI1VA2uiOkmTbRlzFmwulYEdd0+1ekOPYU04LlaQI3DFwdOaWJ8Uz7RkeFD3oLw4
 bmm/SgaInjJEYugK63kcxeFrzE6yAZfuhz8B83ZnwGfkPADMGhGBTyJQVGqbYSqX
 2Bbn7RcdiTpcfN93KjCvT92aesaOP+0lobT94XlX0bi0lIqNbsn+H0A8m+8o1ycd
 eXhWplN8G1I2XiF6B6eyIdQK/S8kYNu8Iowcl57p4CVSFS+tiivm+H5fEoRIneoJ
 zdCr8S71Hu6WbSN+NsTh2ULaNIx5uH9QNkIcwml+6WudehwQwKgcEhKAFZMQdgHv
 6To1U0GfvtEx3/GU8pqHHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749687070; x=
 1749773470; bh=p5pV59q2J6FCRJiagGkTn0o6ez1jfcJNBbsz7ZnsFpk=; b=D
 riD/E0+Z2wpEpQVJSpsBYt0nwImNHwvaJGCF1DfxpXiZ9OgMHGP52LoiC58HVaEp
 /eSklk++tUtg3ojwtOGQQWixqT7PaxzGUhmKGn66Vxsez37RS7kZmiZ7a+7ZMof8
 oUL3nDYd7MnsS698puRsECuBMS8sH84mmTYG45+Svhm1FhuiZnV/yIghdMoQFlZe
 GQY6xM4O7gRx+rOcSfkYoeAx2fCWhx3exXLZ+fSHenzi3cwheQ3V4Ugo745qR856
 q/HUYgKN+Ouqcmhke0uAlL6G4EQ+CsIG6JYfpQBa8nIoX/f/JYPdjYW0HJM2Yp/Z
 q78CTc8DjopU6EMF6J30Q==
X-ME-Sender: <xms:HRtKaF-95xCBdal8A5HDpcceU2grm6e5t61d17DqnwB9hMHKphlq7A>
 <xme:HRtKaJsXWaRs4utyl0pAv_pg5LuptqprZl1Tb0LbNkhaIvO0GsNGcJxK4bnr4D4qW
 qMhf7Mys4ZnS-3awQ>
X-ME-Received: <xmr:HRtKaDCnaCmQNcpZ3KWIjSMb6in_akc5y80m8x0PDD9BUxK8QWGQu5ZSrtKRsR9tDUQVgypaPQHMPVWh3-vd_d1kNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeehlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruh
 gtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhg
X-ME-Proxy: <xmx:HRtKaJe756zhUeCoWSkwcwM-1fs6Y6rzCDmWWkX7GFIQ2iWY8ZUdsw>
 <xmx:HRtKaKNNrO7xMvGuhzgw5TkMu6nY8eILMY5tIITpBZ6ykspe6s6CSA>
 <xmx:HRtKaLkcSNqiIJ1KJQttul6_nw-pK1EgIGX1daRBXBRG8MOyhCZNmg>
 <xmx:HRtKaEsCrBWE3IVbIOETLNg4T7EEYnfs52iVri55HihoM-f6UavG2g>
 <xmx:HhtKaPfkHGkk05zRJX163slGRjQKFE4DUjhi3_r6lw9w5PRxBRpyolAr>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 20:11:09 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: add release note entry for EAL lcores flag
Date: Thu, 12 Jun 2025 02:11:07 +0200
Message-ID: <4590883.TLnPLrj5Ze@thomas>
In-Reply-To: <20250610145055.1497390-1-bruce.richardson@intel.com>
References: <20250610145055.1497390-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

10/06/2025 16:50, Bruce Richardson:
> Add an entry in the release notes about the "-l" flag now being the
> same as the "--lcores" flag. Refer to the GSG for examples.
> 
> Fixes: 1ea3833e9c4e ("eal: merge corelist and core mapping options")
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



