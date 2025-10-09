Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334AACCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 14:59:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F729402A0;
	Thu,  9 Oct 2025 16:59:00 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id CB9D340267;
 Thu,  9 Oct 2025 16:58:58 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C09CA7A0110;
 Thu,  9 Oct 2025 10:58:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Thu, 09 Oct 2025 10:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760021937;
 x=1760108337; bh=PHgOIdqk8yDxbpPdT9vjkLWkz3i5pZpW1vBPFFCzfp8=; b=
 H6VrFir3sPOl2shJ1eWDnI5DmmPu8Qc3lWeOnaOuva7PlP2qeDz9EwH3/iX5ETUh
 dbVvc0SLjETcK70UpWmQFykZabX3SGDlTcSPMiBR3Ip800ixNpmFWw3/RZV4yctX
 YCr140WpvuqVr1t4mgn12b93Ifinj/GAb5qv8y/nqgIrKyuW7xLhH7c5U3xDpN1J
 9KMryNrGn0mxTQxHE2xEU509nH9vdDTBQjUegrpvgI9tGxai3jcVdHEqulwY/t5X
 1XyzzC76jOn+zWgDfhSmIsJwN9HMMjcgR0bKRiLQkCUKsXwNILGuriwa6z+YMFMX
 UCEh6EjluSSZvaEIeBpODw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760021937; x=
 1760108337; bh=PHgOIdqk8yDxbpPdT9vjkLWkz3i5pZpW1vBPFFCzfp8=; b=l
 StkgyAywXDwSIlBc+YfHO/KDl2NfDr6MJdhDeRunJePHV2FqRxpRS2pNiqI/2Y9i
 S7mEEBSx/vMHiTsLpR+sbL1DnV8rttFvuTRZCMdg0SI2ddZHoDQP5FSNTFdPvIG+
 EgJKr65xk3xyDVr1EFvEMZIkKauqO934AGPzuw0cR6ADd6yzZYxlQFv3l0GAUGI+
 yvY7Cff35EKa9YZ9nXl8mdLUIAO6YFpAjANelt26KxWjyyM7kvge5ydFPzIed2RG
 9IIS4yZuUJTovCOD5ZRjm8ZU1XWw/uJDTlI1rVngxmGeRWVKfzJ3TAnF3Lhe/VRy
 4X/ZCPM2cYMbzBnKKlT8Q==
X-ME-Sender: <xms:sc3naJN_dcGiKiqwFX35HBxAYuwsDypN5GtfQMqj_ukCVK-j4Nu_Rw>
 <xme:sc3naHaxv1MU1ZHsWLW2WEaUOE4FyNYiQzdzmngYAYm741WZcClD-Uzfr5rVAK-LM
 pDPOSSSmeCT8pcXGEDItYI-iakXgv7nP0AzfPLYOvWuSg4g37E0rg>
X-ME-Received: <xmr:sc3naLymwVZv3rcwR6JxeFSF0Pe7nLv9LVFwci2kJGq0hBqSGWeQCgUMKmmHyIJdh_MGBq2_WYSgoVqm_FxnnMZPIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeigeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopegtihgrrhgrrdhlohhfthhushesihhnthgv
 lhdrtghomhdprhgtphhtthhopehtvggthhgsohgrrhguseguphgukhdrohhrghdprhgtph
 htthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehtihhmohhthhihrdhmihhs
 khgvlhhlsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:sc3naKLMvcQj9QwscXyYv3vmh8oAvDgif2vgnYagknAaHiR8kBVQCw>
 <xmx:sc3naNo_FA8rtho3N8a0nm2pl7a5jmBmP-mOM2hYlpYpViHIfyIZ7w>
 <xmx:sc3naBI2lgvQvvpHQ6sM1cmqTLktKaRYalunLk7-17O4v1extbAgWg>
 <xmx:sc3naKTuNo0QW2yvUUv4w0f8vQ8UaaMjsGRQfozJtRCSYkKq3sR-EQ>
 <xmx:sc3naD_n1qpuPDexG4-aEWexsqZ6-8njnofJuvqmeXPNq-9JsB6eSRtN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 10:58:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Richardson, Bruce" <bruce.richardson@intel.com>,
 "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: "techboard@dpdk.org" <techboard@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Miskell, Timothy" <timothy.miskell@intel.com>
Subject: Re: [PATCH 1/2] net/iavf: support VF initiated resets
Date: Thu, 09 Oct 2025 16:58:54 +0200
Message-ID: <2774555.irdbgypaU6@thomas>
In-Reply-To: <PH3PPF7DB70F9CE21D69B81237AB58593BD8EEEA@PH3PPF7DB70F9CE.namprd11.prod.outlook.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <3977268.0vhOF50zNu@thomas>
 <PH3PPF7DB70F9CE21D69B81237AB58593BD8EEEA@PH3PPF7DB70F9CE.namprd11.prod.outlook.com>
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

09/10/2025 12:30, Loftus, Ciara:
> > 
> > 03/10/2025 12:29, Loftus, Ciara:
> > > > > > Introduce a function that allows a VF to request the PF to reset itself.
> > > > > > This is useful for example when the application detects that one of the
> > > > > > queues have hung or any event where a reset is required and the PF is
> > > > > > unlikely to trigger it.
> > > > > >
> > [...]
> > > > >
> > > > > In general, I'm not a huge fan of adding driver-specific functions and I
> > > > > feel like this should fit under the existing reset APIs in some way. That
> > > > > should avoid the need to update (or such a big update) to testpmd, for
> > > > > example.
> > > > > Some thoughts here:
> > > > >
> > > > > 1. we could add a devarg to the driver to adjust whether reset does a
> > > > >    "softer" reset of the VF just resetting itself, or a "hard" reset where the
> > > > >    PF does a fuller reset of the VF.
> > > > > 2. rather than a devarg, would do use a driver-specific function to adjust
> > > > >    this behaviour. The difference here would be that the driver-specific
> > > > >    function would be an init-time one rather than runtime, so the runtime
> > of
> > > > >    the app, like testpmd, would be generic.
> > > > > 3. the most generic solution would be to add an additional parameter to
> > the
> > > > >    reset() function itself to specify a hard or soft reset. This would mean
> > > > >    updating all drivers to handle the new parameter (shouldn't be hard,
> > since
> > > > >    it would be __rte_unused in all cases by default). This also opens up
> > > > >    the possibility of other drivers - especially VFs - using it in the same
> > > > >    way. We could actually document that the "hard" option "may be used
> > by
> > > > VF
> > > > >    drivers to request a full reset of the VF by the PF".
> > > >
> > > > Hi Bruce,
> > > >
> > > > I did not make it clear in my commit messages the full purpose of this new
> > API.
> > > > Along with resetting the VF, the VF is also reconfigured and restarted
> > > > transparently, using the existing iavf_handle_hw_reset implementation.
> > > > While there is probably merit in extending the reset API to include a
> > soft/hard
> > > > reset flag, I would still need this new API to fulfil the purpose described
> > above.
> > > > If we wanted to make this generic I see two options:
> > > > 1. extend the reset API to optionally reconfigure and restart
> > > > 2. introduce a new generic API that performs a reset followed by a
> > reconfigure
> > > > and restart.
> > >
> > > I've submitted a v2 and renamed the function to "restore" instead of "reset"
> > to
> > > better describe the behaviour of the function - not just resetting, but also
> > > restoring configuration afterwards and restarting the device.
> > >
> > > I agree that it would be best to avoid a driver-specific function like this. After
> > some
> > > thought I don't think we can extend the reset API to include this behaviour,
> > the
> > > reset API should probably leave the device in a reset state.
> > >
> > > I'm wondering if the community would be in favour of creating a new ethdev
> > API
> > > for restoring/reinitialising a device. It would essentially comprise of reset,
> > > reconfigure and queue setup, and optionally device start?
> > 
> > It is confusing to add an API if it is a perfect overlap
> > of what exists already.
> > If you want to add a new API, you need to explain how it is different
> > of a combination of reset/configure/start.
> 
> Apologies for any confusion.
> The new API would perform only the necessary reconfiguration
> and setup steps under-the-hood and use the existing device
> configuration. This would differ from a combination of
> reset/reconfigure/start in two ways:
> 1. In some cases (at least in the case of the iavf driver), a
> full rte_eth_dev_configure is not required after an rte_eth_dev_reset.
> So the new API could just call the device callbacks for those functions,
> rather than forcing the user to call the ethdev functions and perform
> some unnecessary reconfiguration steps.
> 2. It takes the burden off the user to build up the device configuration
> again after the reset. Any pertinent configuration can be stored before
> the reset and used to reconfigure the device transparently. All the user
> needs to supply is the port id.
> 
> Anyway, I've submitted a v3 of the non-generic version of this for the
> iavf driver, so if there is no appetite for the generic approach I'll
> continue to pursue the driver-specific one.

A generic API is way better.

I'm trying to understand what is missing in the current API.

I think what you want to achieve is RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE.
What is missing exactly to implement it with the generic API?


