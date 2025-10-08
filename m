Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA376CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 10:13:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07BED402A0;
	Wed,  8 Oct 2025 12:13:43 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 62B7E40297;
 Wed,  8 Oct 2025 12:13:41 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id F0DB814001AB;
 Wed,  8 Oct 2025 06:13:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Wed, 08 Oct 2025 06:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1759918420;
 x=1760004820; bh=CUpctBJvT+0Vcrv6KZR5xD5CHghoPewINgpdyd9Sk9M=; b=
 RprYa4sTzzYkaeOJX/GK+kt2gxb7J7USfB2/kGHo/A2O0lPGFr/FdSzzZKB9oO4D
 hDbmDbcEk3up2Y8q6RtDJ7YGmHJrtkpIwo9e9LP4tiKMUmYDfW+CME3F68eyoImr
 Wz+yoZJVSkZOe1ya2JJtEGRL0ag6NEJSt0b8QPc7lmMluoSIRSb+oQ0pbDycPsU+
 YRvkb5lAHa1wUz4wdMzFN9NV5dKxw0c8FwahLwcEYwVFmiU4x/aNiAZMRavjHhhg
 5bA+uKoyDlOg1Mu0kOyQAmr2RBvbEujdklF760WZXZdTGhDRAhDSF+ZuYX5Tbqgf
 vt9pK9s51YUuQpECRkIYFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759918420; x=
 1760004820; bh=CUpctBJvT+0Vcrv6KZR5xD5CHghoPewINgpdyd9Sk9M=; b=o
 oXPlDNfz4HpKOgdXz0fYAIudHdoQzlljSSReH8mMbiXq4CdWTdpl9g7t9mrfj3hv
 WmqarAzS1vBMHBfjDArHynemJQ8yPttaiVQ6eXfinZ/lIewzXkuV0Y5niG2U747t
 6tefE7+f4XOuoBO67/N3roTg0GOhVpd+FJQTzzPqGXnL4P428arPOvGA/h4F+03t
 L5XjtFSDswAkrU8CVQptSFJjBFSr5KpbT/Vs2t5PIM1aV9TyQYL4pk7ZY+VqbheI
 78sHih0N8VdLBHi5YKVKY6LH3CueTigeMe5SYu2DfT8YXCl8ikzTyZiq8xzliY+S
 GtlV3BNM6TmfMU1oFgZUw==
X-ME-Sender: <xms:VDnmaGO0m3bM1VHZkx48q-u4ivYBR_ezf2pZPobRYUngTPXCAAbzhA>
 <xme:VDnmaN4ZnY0Ttxl4VBdagrE4T5tDMYQnoPEyQaxGT7ZfTMpfstCfqZwOGbBd-JXWd
 AtoL3kadDNCBIfCkUbs86tEbNQ1OSwvExkdnln-ob8R_hLk58ErVQ>
X-ME-Received: <xmr:VDnmaI2_AiSR1JEHX8QNKAJEKVIGZ0fBDlv190YkauBX6plykrrSJOYsyBXHBUpKuqIpO6irlnx8eE3BdmJgaFfKMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeftdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopegtihgrrhgrrdhlohhfthhushesihhnthgv
 lhdrtghomhdprhgtphhtthhopehtvggthhgsohgrrhguseguphgukhdrohhrghdprhgtph
 htthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehtihhmohhthhihrdhmihhs
 khgvlhhlsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:VDnmaGx-saAjV1B-C2M7PLMiyHQp28frCedkEzcpoJrdWavpuWyuHQ>
 <xmx:VDnmaKs2e19nCjhB9cCdK9Y4u7wd16-JqyTIkIaGrMc4KqVWoCLuCg>
 <xmx:VDnmaIxYJe7MGl7-7LpYTSRi0Am6vGDkvdlKBdrbh-GhJ7lFdQTxRw>
 <xmx:VDnmaNBK-mKO9E_8KuPk6ISEUGoifLUApl8-fdtSgstrFSsARUKI3g>
 <xmx:VDnmaMushDK9WjAK7GAT_7bgLpNpD0gUpkI4pSL2VVjqYUsj72rRlBP3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 06:13:39 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Richardson, Bruce" <bruce.richardson@intel.com>,
 "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: techboard@dpdk.org, "dev@dpdk.org" <dev@dpdk.org>,
 "Miskell, Timothy" <timothy.miskell@intel.com>,
 "techboard@dpdk.org" <techboard@dpdk.org>
Subject: Re: [PATCH 1/2] net/iavf: support VF initiated resets
Date: Wed, 08 Oct 2025 12:13:38 +0200
Message-ID: <3977268.0vhOF50zNu@thomas>
In-Reply-To: <DM3PPF7D18F34A1B51E203D4A7A495540958EE4A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <DM3PPF7D18F34A105FE85AAA7D7387DDD838EE6A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
 <DM3PPF7D18F34A1B51E203D4A7A495540958EE4A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
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

03/10/2025 12:29, Loftus, Ciara:
> > > > Introduce a function that allows a VF to request the PF to reset itself.
> > > > This is useful for example when the application detects that one of the
> > > > queues have hung or any event where a reset is required and the PF is
> > > > unlikely to trigger it.
> > > >
[...]
> > >
> > > In general, I'm not a huge fan of adding driver-specific functions and I
> > > feel like this should fit under the existing reset APIs in some way. That
> > > should avoid the need to update (or such a big update) to testpmd, for
> > > example.
> > > Some thoughts here:
> > >
> > > 1. we could add a devarg to the driver to adjust whether reset does a
> > >    "softer" reset of the VF just resetting itself, or a "hard" reset where the
> > >    PF does a fuller reset of the VF.
> > > 2. rather than a devarg, would do use a driver-specific function to adjust
> > >    this behaviour. The difference here would be that the driver-specific
> > >    function would be an init-time one rather than runtime, so the runtime of
> > >    the app, like testpmd, would be generic.
> > > 3. the most generic solution would be to add an additional parameter to the
> > >    reset() function itself to specify a hard or soft reset. This would mean
> > >    updating all drivers to handle the new parameter (shouldn't be hard, since
> > >    it would be __rte_unused in all cases by default). This also opens up
> > >    the possibility of other drivers - especially VFs - using it in the same
> > >    way. We could actually document that the "hard" option "may be used by
> > VF
> > >    drivers to request a full reset of the VF by the PF".
> > 
> > Hi Bruce,
> > 
> > I did not make it clear in my commit messages the full purpose of this new API.
> > Along with resetting the VF, the VF is also reconfigured and restarted
> > transparently, using the existing iavf_handle_hw_reset implementation.
> > While there is probably merit in extending the reset API to include a soft/hard
> > reset flag, I would still need this new API to fulfil the purpose described above.
> > If we wanted to make this generic I see two options:
> > 1. extend the reset API to optionally reconfigure and restart
> > 2. introduce a new generic API that performs a reset followed by a reconfigure
> > and restart.
> 
> I've submitted a v2 and renamed the function to "restore" instead of "reset" to
> better describe the behaviour of the function - not just resetting, but also
> restoring configuration afterwards and restarting the device.
> 
> I agree that it would be best to avoid a driver-specific function like this. After some
> thought I don't think we can extend the reset API to include this behaviour, the
> reset API should probably leave the device in a reset state.
> 
> I'm wondering if the community would be in favour of creating a new ethdev API
> for restoring/reinitialising a device. It would essentially comprise of reset,
> reconfigure and queue setup, and optionally device start?

It is confusing to add an API if it is a perfect overlap
of what exists already.
If you want to add a new API, you need to explain how it is different
of a combination of reset/configure/start.


