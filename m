Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9E510F92E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 16:13:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9962406FF;
	Tue, 31 Mar 2026 18:13:43 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id 2849D40615
 for <dev@dpdk.org>; Tue, 31 Mar 2026 18:13:42 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A68897A00BF;
 Tue, 31 Mar 2026 12:13:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 12:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1774973621;
 x=1775060021; bh=WdbsX1zdgzfjZUUR5/w6JOudI1BucAVa4FvA/YNQF1U=; b=
 RbRipPjIriVwZEAH3h7ZDPpCRv5TH0AyQxlpT3VLl3SwRBpE7o9BeBC19UNiOL9Z
 +cPJBOYIQKRXplWgYCrjaULLXDcX9dJqJh0oTOiHveX1TaZelA0cqbPTnjxJACsq
 E0dlcmEk6Hwq3sjEPwuLfzW6OlxUdfJbOQItAUscpv21hdXfZ6SR9Uz/L5fVcBV5
 6k0cMKFgBgp16MxkV7qhNkQDoAj5RryXj23i0smLIz1Z66jIVVs4sLhKdM1yk7X1
 UvYsdiao2tdXI6GvM0kNMDsP2XcCqI0bN9yDTPi9CxpK5NTDAnlVgVsvd6Xukeln
 jNjGX729uxpZQ2KHXGODtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774973621; x=
 1775060021; bh=WdbsX1zdgzfjZUUR5/w6JOudI1BucAVa4FvA/YNQF1U=; b=u
 9xhwjXo+jHnrbKv4KgVXq1xInmbJ0mAZLfdrFHeYC8rpV5XC58Y1LpmupJa+9kOE
 fd8S44VuSRsvClFnX0ESL4C6dHjkOeZWiyCTww1f/U9T5yNvuTwoMmg2aKAnWEeh
 1qM9vDMUsk0W/lcY3WeiPILeHvjw5k1Ug7azwoZ7uw7kWDG8PByTiqp7SNO6LoP7
 LG8t6aXnoq4xkmcyaxi3PD/EtofrBzNFVPLStC54fwhGmq1FJem7vANpl/WAXfjw
 2MBEbQjIRKq8inyQ9YogjHt1Ai7OfjgODRticTdb3iORR0GW3TgJ3jf3V2aV9Tu4
 6cRW51eAGfBOJXck52bkw==
X-ME-Sender: <xms:tfLLaUmbDQ00RSCnxWL3H7ocqAMa9rxYZqPSYpAAz5A_IbTxITzSOw>
 <xme:tfLLaYKfMts0Vby1Pdbd6UalojzSbsbXO-ZAD8lIjTA7L8vmzv-QcBNicPLRgYWP9
 Uy6oyH-AlHFpLIGjx6-dHr46UPu23AZEtNN5NAHraft4_r6z_c1_A>
X-ME-Received: <xmr:tfLLaRxpSXMOPO6WBiuI9RrMUIn72rxLM35a2KkZEsNn1mR20azNY9CqqOXoHMgzQM9yfc9nvjlfj1ofjBE0m_7DDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeihecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnth
 gvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehj
 ohhhnhdrmhgtnhgrmhgrrhgrsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:tfLLaYvgUuqIOMTs8E_Gw6Fox1nb_E-ptDYcFg9VxcSYCDXU2ng65Q>
 <xmx:tfLLaYuFqPk1L7cJ5j02wmB72VGB_i28Xx5Gsxy3lkb4SunwKC6D2Q>
 <xmx:tfLLadNBqkOXa3VMYhJAM-_EBEbq7Z_XOQEJagQfkcO4lbXREOd-ZQ>
 <xmx:tfLLaW0Uh9kNzSiXqKFvbtJr4u9KnixMUDhPx3wPbJ0o-wuIe3B5Rg>
 <xmx:tfLLaaWiTxh9QzrOnFhawPrgUVFJlVaL0ucKFRG04z2fecYuWnR2LTAJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 12:13:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "Mcnamara, John" <john.mcnamara@intel.com>
Subject: Re: [PATCH v4 1/2] doc: add devargs documentation
Date: Tue, 31 Mar 2026 18:13:39 +0200
Message-ID: <14008894.uLZWGnKmhe@thomas>
In-Reply-To: <CY5PR11MB6318A5E8AB06EA501A07D6DBFC57A@CY5PR11MB6318.namprd11.prod.outlook.com>
References: <f9c79b16f3f90c3521acabdcaa96a9e61dca705b.1763122378.git.anatoly.burakov@intel.com>
 <17532da36934963d943f54de17c2d0d24dbfe8a2.1772112599.git.anatoly.burakov@intel.com>
 <CY5PR11MB6318A5E8AB06EA501A07D6DBFC57A@CY5PR11MB6318.namprd11.prod.outlook.com>
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

> Currently, the devargs syntax documentation is missing from the
> programmer's guide, and is only documented implicitly through the devargs
> API headers. Add a detailed description of the two supported devargs
> syntaxes.
> 
> Acked-by: John McNamara <john.mcnamara@intel.com>

Acked-by: Thomas Monjalon <thomas@monjalon.net>

Series applied with a bit of formatting, thanks.


