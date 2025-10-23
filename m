Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6656ACCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 14:33:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9A374025E;
	Thu, 23 Oct 2025 16:33:48 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id DDAAC40151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 16:33:46 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 411281400229;
 Thu, 23 Oct 2025 10:33:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 10:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761230026;
 x=1761316426; bh=eE6kMQam+nEEeT1/FYP6+zbmRL8gsQwBSKRivHCTM1c=; b=
 e5v4ctD7/qAS/bSxMWSsTcG8YJrMn/YHWnMckTesVypFTDGADJ3N+mS0jtuJ3ZEk
 pW48sjZqaAL89iO1CAlySYx58sK3jE3Jb/hau3rafS6deVBNo1iFdt3V1Q7cU/mj
 ScfxNHbphGj0ZuSpNZ4+NEWeaEawpJy5eRt5XXnDF4KudWkXs3Lhnq+Wlpwt0u1M
 yjZUwDqabGTrnTwTjdXT2n6y+CiMpnDZb4WSNoouM3dPLJdqzdjstRen2qIcFl3D
 dyB074QoaOuh9h5clZ+KGQPjcfRF/g+hKIDukktFH+c0+BcTioTiu2XSgSrxee/E
 O6jno9wPZqttHCJmE+kG/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761230026; x=
 1761316426; bh=eE6kMQam+nEEeT1/FYP6+zbmRL8gsQwBSKRivHCTM1c=; b=U
 OrJuFs0ZLp8OKfFkF2nWO81bfdwn6ySMoSP6TEsQO5RLXASMSlDFpAJ4Bpen0PbL
 61MLyDjskO2wTX+ohPDPAOjPpfuWYpM125luzjXLUhLDc2n3X89RaYHtAUx9+d9s
 /evmFskNzQQDFUwum7lJogvlSoKWQ/pllNHgkkg7qo2lQtj7sDTbAVu4QL19mybV
 kZnRn7XmMUr+abH39Mg+Lj+onZ54OlcQblMVRFBdj1EKrLz9NsH90ZTUwIAjoVI3
 uVsMU221KuTCArtCX/T2IGy05NH8wV1IjmNvflvo83VxrSYXuyEBmBLqNAvheHrV
 vykoMGMtMN73upJ7jXAdw==
X-ME-Sender: <xms:yTz6aJECmuWr6BNFOvT3hLnzYfQheJpZ4IV-aaHRmbNKfFQC4CsweQ>
 <xme:yTz6aKpKOP46WwIeqPPxllnB08VWa3hipiSqEb1MWxPvGB7-MYnedSz86dLnSqqev
 -uiXp-LC6sWdYgz5E16e4lLkj_NdNRmTRivo_R-vzisS1eELJM>
X-ME-Received: <xmr:yTz6aN6PwyDpiSwTbD0MDP_Buted_u7tW0kOE3qEJRUc5LHG48Axf7y4N-_MFlJJVtRDC9Vf2I_qRwSuW5T7tCR25w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeijeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhirghlnhhusehnvhhiughirgdrtg
 homhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:yTz6aA5VwaMJN2K1t4_yiPntWQZtY2sshI-f47FzZq0kLuyRc9IFCA>
 <xmx:yTz6aCHB7CxPso1xedGTNYnJEQNnmxvfmciiKgNuhJtuC0MUq8Zdmg>
 <xmx:yTz6aBQqmKao5a6opyFnajY-B0iAg7oeMXVGNQzS3eDjSn98j26vww>
 <xmx:yTz6aDtgzrCaNc_HkBaTHChqYgENQAhWtgfB8O2sOcfwzJVn2YZlug>
 <xmx:yjz6aPEgjX58e0PnTPXxXxOwFhGV7VqO8ChGW3YioHGuFeyXeTkXwJXB>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 10:33:45 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ali Alnubani <alialnu@nvidia.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] devtools: honor -n flag regardless of stdin state
Date: Thu, 23 Oct 2025 16:33:43 +0200
Message-ID: <6805909.NeCsiYhmir@thomas>
In-Reply-To: <20251014074340.2364328-1-alialnu@nvidia.com>
References: <20251014074340.2364328-1-alialnu@nvidia.com>
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

14/10/2025 09:43, Ali Alnubani:
> The checkpatches.sh script was checking if stdin is a terminal before
> honoring the -n flag, causing it to incorrectly attempt to read patches
> from stdin when run without a TTY (e.g., in Jenkins/CI pipelines).
> 
> Reorder the conditionals to check for the -n flag before checking stdin
> state. This ensures the -n flag takes precedence and the script checks
> git commits as intended.
> 
> Signed-off-by: Ali Alnubani <alialnu@nvidia.com>

Applied, thanks.


