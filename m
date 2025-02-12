Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E48C021A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 15:36:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8B5542DC7;
	Wed, 12 Feb 2025 16:35:31 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id D218242DBB
 for <dev@dpdk.org>; Wed, 12 Feb 2025 16:35:29 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 49B461140118;
 Wed, 12 Feb 2025 10:35:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 12 Feb 2025 10:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739374529;
 x=1739460929; bh=XYLSxAbflu2FskbKU624rd4iF9XcsZMTb9lsOXr4R3I=; b=
 huEyJywPHbh7036T6VbmCr3DtPJD2YhgjK2wPBc0QO0dJiCyEfaK4zksIHOeK+6k
 XzZX5gZstEqdiJt82sUHe0gA06PrmIiNX8zrn9q2z348zXpOGoNa48PiCk9yDANh
 JSTQBjIaVDiF21fF4M0K9N87c9zeLhAupYqsUQ6KWeuaoMSrHpuqoP6MtSe+1rBv
 nGBm4BflGqhjja9HK4AwAVsPGm6txNe5ti56xqn3z3xJGGj9ov9aAh3NLr3N5fwm
 Ls91qTb6NsiU+nc4opMWz7BN5/63eRlPzAEuGpgKwrgKH5FoG2mpvYnpSOnI3mos
 6R2PLgpVojizDN1iT6efWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739374529; x=
 1739460929; bh=XYLSxAbflu2FskbKU624rd4iF9XcsZMTb9lsOXr4R3I=; b=L
 9qrmeeJusB/vhFH3j8FGtwHX4fmaPN3TP+Zi+sbhw1QQug2zxUaVxIfmC5nK1mlS
 92eY5JzVbILUOS/jDtkdbqWhoM5hfcMDhxSPK+aQoo6KSBmm6Nk7RC/GAOV1ICXd
 Yfx96zKA+KlwqGglCYPn7ZDRlVHNySSvWlx2ca76Gt5AO7PniBc6pVcH00AhD1UM
 JtRk9XY/gtcFvDpoNEtOzp8jE04V59OoYq1gnGT3x+4EDQ0yC301SRY1FxAus9Jl
 fznkpVuulsZ3ES3FG0wD/RduZ36QLoL1e0+klUfCt/FcQ8YeQE1DqbSopWjvDSyk
 eyEGUoODP4DFKel0U559A==
X-ME-Sender: <xms:wL-sZ_I1ClFiJGUY7tUFGKQ6TrvsMk645UjWyBroPGE34QC-vjyDKA>
 <xme:wL-sZzKA3ozjpsdFgYPUoEgw5B6sFHCSA7C7bgKwnEeusS220uu7T3qFFL8W11hu5
 EiN4P9TS1-fPoNspg>
X-ME-Received: <xmr:wL-sZ3vZYWMh1chqInClkZxzRq2eaevVxkbLjqA6cEMi8rcTu6rQ0_A2MTguyOsq3lMowfdpwLbLZN3k8Q_8-yJUMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedviecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruh
 gtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepihgrnhdrshhtohhkvghssehinhhtvghlrdgtoh
 hm
X-ME-Proxy: <xmx:wL-sZ4aHVaZou3LRinjD1cvVyZLEDSO6kNXpmGKqcmypCD_TlR_NLA>
 <xmx:wL-sZ2bc-Am6YF9nvw-qWlMx3YJDJsy7b9OW6NcFvCUF8brYABHlBg>
 <xmx:wL-sZ8AX6Pf8PCeKhtH15gOAOgRgTyH-mJho65VRMGxDHn1s-C0Wfg>
 <xmx:wL-sZ0YuxuqRnPb2Hk-xCuuVnH9p3kZhQloDKdbAB4k0am1FDm-AzA>
 <xmx:wb-sZ2G1E7CSmdePLzBEzR6Azx0OiMwlaQTscnYoJ1lm8s48QkvI_7mk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 10:35:28 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Richardson, Bruce" <bruce.richardson@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Stokes, Ian" <ian.stokes@intel.com>
Subject: Re: [PATCH] build: allow disabling avx512 support via compiler flag
Date: Wed, 12 Feb 2025 16:35:26 +0100
Message-ID: <5541003.tWeucmBOSa@thomas>
In-Reply-To: <MW6PR11MB83091D62D1060A738AA514E192FD2@MW6PR11MB8309.namprd11.prod.outlook.com>
References: <20250121164114.2311086-1-bruce.richardson@intel.com>
 <MW6PR11MB83091D62D1060A738AA514E192FD2@MW6PR11MB8309.namprd11.prod.outlook.com>
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

11/02/2025 18:02, Stokes, Ian:
> > DPDK build checks for build support for various instruction sets by
> > checking both the target machine and the compiler for support. However,
> > any disabling of instruction sets via compiler flags was not taken into
> > account in many cases. For AVX512 support, check for a user-specified
> > "no-avx512f" flag in the c_args parameter before checking if the
> > compiler can actually build AVX512 code.
> > 
> > As well as providing an option for the user, this can be used to test
> > builds without AVX512 without having to use an older compiler.
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> Thanks Bruce,
> 
> tested ok for me, LGTM.
> 
> Acked-by: Ian Stokes <ian.stokes@intel.com>

Applied, thanks.



