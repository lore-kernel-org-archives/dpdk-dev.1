Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8DCCCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 13:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93B2B402CC;
	Tue, 14 Oct 2025 15:19:46 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id B85DD402A8;
 Tue, 14 Oct 2025 15:19:44 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C46027A01C1;
 Tue, 14 Oct 2025 09:19:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Tue, 14 Oct 2025 09:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760447983;
 x=1760534383; bh=R0uvZ1CCZEC+JvGla6dVxTjAGTAt1bRiJwrX0ixOFcs=; b=
 H81ndk3GSr8WSrDYZMZZPRUb3y8IvOo82zTXOGohjwSemnhkLWoap+H+ImMik/U1
 uFFALYd9z3WTK6DGHlO8Ri8AhtJQbm/UNsJ88IvUM+E+fOZwb0sWxLrYU2GbXUdx
 Pbd+qQZhIah7QkPun3lhH0J5svu8VZde4lNs8dZzsh4AK11y2ZiA71sQ4Fe966F9
 jrOOcxhRXkOXj4iFBGhsbt/pIcaxGKYMMCtJDGxASj2/Wht3PFiIRd9ttxDgOb36
 jisUPO50JSlY1i/xgUMKWdZMsyQXJc8BymZFgTEDmdpS0HxnbiiIHyuj/7AAuog1
 zvMx2w8yxKeH0CNwbtpOBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760447983; x=
 1760534383; bh=R0uvZ1CCZEC+JvGla6dVxTjAGTAt1bRiJwrX0ixOFcs=; b=d
 DHGe9XhgBzZCNegpbd8uBQG23S+vK4UeDI3H7L3Qjch/tcyE2XzYJ7HBHQ4I8T2v
 5SzhSElUN76VxC23TzrsJ0UTnYLYPqAYx7wZs+EnWt4CvOK4q02EPYgb7hX7uyU7
 UYXBrE9G7ckvQK/chk3DOQbabesEfHZpZoqg2F/m+a4FQGqosXhtS8D/KUssHRXn
 jGQDC8bPPpfsoRT9T9gjV8f47FWIbwdSTR6xj5t+Zgq/wozOHOPGXcb2u7kr6SQO
 hTFC6/5/Z5aP4fAiLIg8rtgcK9rBnt9GcQslhk/kNh0TAU0zXoreWOfmVBn4Cebe
 rsuIHQfgQqp92s08gybJA==
X-ME-Sender: <xms:703uaBA5fJ0S1g5mNPOLTqQVI1_rCGxTfeZ_cmdXNZgE9zGJVF831Q>
 <xme:703uaK_5fnJOq0m21hVoqbWsAFgbEr2frAYcwAfFmSJ19XKKfuftPb3rK1f8chlkx
 U7_SA6MTz3ChiCsQUwVONbvAwRPIE5C8Zipe6dD1d8y_ZBuaURtpw>
X-ME-Received: <xmr:703uaAGdokt1g6rLNazfUhlqfMJs1b_1VZozLTsDDUz7Tk6phAPwWqPrzxZ04Wj7clv7zXT_ujqRw9GWy6ZuqgAEsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtieefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:703uaAOmZAMGid_oDmxlqf8SWRfm62pVKD8_qglE7Sb6DhuUTQTDLg>
 <xmx:703uaCf01yZIZsj-CUjwCqEvNz1M9_XiHGa4fm94B13vyZHn9Zmc4w>
 <xmx:703uaNso4_p0INOC2NbI6CzXXu7afwKsIgc0d791Q5SwbWHiqsJK8g>
 <xmx:703uaDnkZrLZEBIGYsvrLgVVkn2bV1vf2txrfwI_jy60cE9CsGd79w>
 <xmx:703uaGiWPGUVEHUUGP4zW74GWnrwK6DkYz62T4fJwhnMbaaLlx_MolyN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 09:19:42 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: "Richardson, Bruce" <bruce.richardson@intel.com>,
 "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: "techboard@dpdk.org" <techboard@dpdk.org>, "dev@dpdk.org" <dev@dpdk.org>, 
 "Miskell, Timothy" <timothy.miskell@intel.com>
Subject: Re: [PATCH 1/2] net/iavf: support VF initiated resets
Date: Tue, 14 Oct 2025 15:19:41 +0200
Message-ID: <16117372.JCcGWNJJiE@thomas>
In-Reply-To: <IA3PR11MB8986D47057F5DE567C811B548EEFA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20250929143039.547207-1-ciara.loftus@intel.com>
 <2774555.irdbgypaU6@thomas>
 <IA3PR11MB8986D47057F5DE567C811B548EEFA@IA3PR11MB8986.namprd11.prod.outlook.com>
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

10/10/2025 15:48, Loftus, Ciara:
> > 
> > 09/10/2025 12:30, Loftus, Ciara:
> > > >
> > > > 03/10/2025 12:29, Loftus, Ciara:
> > > > > > > > Introduce a function that allows a VF to request the PF to reset
> > itself.
> > > > > > > > This is useful for example when the application detects that one of
> > the
> > > > > > > > queues have hung or any event where a reset is required and the PF
> > is
> > > > > > > > unlikely to trigger it.
> > > > > > > >
> > > > [...]
> > > > > > >
> > > > > > > In general, I'm not a huge fan of adding driver-specific functions and I
> > > > > > > feel like this should fit under the existing reset APIs in some way. That
> > > > > > > should avoid the need to update (or such a big update) to testpmd,
> > for
> > > > > > > example.
> > > > > > > Some thoughts here:
> > > > > > >
> > > > > > > 1. we could add a devarg to the driver to adjust whether reset does a
> > > > > > >    "softer" reset of the VF just resetting itself, or a "hard" reset where
> > the
> > > > > > >    PF does a fuller reset of the VF.
> > > > > > > 2. rather than a devarg, would do use a driver-specific function to
> > adjust
> > > > > > >    this behaviour. The difference here would be that the driver-specific
> > > > > > >    function would be an init-time one rather than runtime, so the
> > runtime
> > > > of
> > > > > > >    the app, like testpmd, would be generic.
> > > > > > > 3. the most generic solution would be to add an additional parameter
> > to
> > > > the
> > > > > > >    reset() function itself to specify a hard or soft reset. This would
> > mean
> > > > > > >    updating all drivers to handle the new parameter (shouldn't be hard,
> > > > since
> > > > > > >    it would be __rte_unused in all cases by default). This also opens up
> > > > > > >    the possibility of other drivers - especially VFs - using it in the same
> > > > > > >    way. We could actually document that the "hard" option "may be
> > used
> > > > by
> > > > > > VF
> > > > > > >    drivers to request a full reset of the VF by the PF".
> > > > > >
> > > > > > Hi Bruce,
> > > > > >
> > > > > > I did not make it clear in my commit messages the full purpose of this
> > new
> > > > API.
> > > > > > Along with resetting the VF, the VF is also reconfigured and restarted
> > > > > > transparently, using the existing iavf_handle_hw_reset implementation.
> > > > > > While there is probably merit in extending the reset API to include a
> > > > soft/hard
> > > > > > reset flag, I would still need this new API to fulfil the purpose described
> > > > above.
> > > > > > If we wanted to make this generic I see two options:
> > > > > > 1. extend the reset API to optionally reconfigure and restart
> > > > > > 2. introduce a new generic API that performs a reset followed by a
> > > > reconfigure
> > > > > > and restart.
> > > > >
> > > > > I've submitted a v2 and renamed the function to "restore" instead of
> > "reset"
> > > > to
> > > > > better describe the behaviour of the function - not just resetting, but also
> > > > > restoring configuration afterwards and restarting the device.
> > > > >
> > > > > I agree that it would be best to avoid a driver-specific function like this.
> > After
> > > > some
> > > > > thought I don't think we can extend the reset API to include this
> > behaviour,
> > > > the
> > > > > reset API should probably leave the device in a reset state.
> > > > >
> > > > > I'm wondering if the community would be in favour of creating a new
> > ethdev
> > > > API
> > > > > for restoring/reinitialising a device. It would essentially comprise of reset,
> > > > > reconfigure and queue setup, and optionally device start?
> > > >
> > > > It is confusing to add an API if it is a perfect overlap
> > > > of what exists already.
> > > > If you want to add a new API, you need to explain how it is different
> > > > of a combination of reset/configure/start.
> > >
> > > Apologies for any confusion.
> > > The new API would perform only the necessary reconfiguration
> > > and setup steps under-the-hood and use the existing device
> > > configuration. This would differ from a combination of
> > > reset/reconfigure/start in two ways:
> > > 1. In some cases (at least in the case of the iavf driver), a
> > > full rte_eth_dev_configure is not required after an rte_eth_dev_reset.
> > > So the new API could just call the device callbacks for those functions,
> > > rather than forcing the user to call the ethdev functions and perform
> > > some unnecessary reconfiguration steps.
> > > 2. It takes the burden off the user to build up the device configuration
> > > again after the reset. Any pertinent configuration can be stored before
> > > the reset and used to reconfigure the device transparently. All the user
> > > needs to supply is the port id.
> > >
> > > Anyway, I've submitted a v3 of the non-generic version of this for the
> > > iavf driver, so if there is no appetite for the generic approach I'll
> > > continue to pursue the driver-specific one.
> > 
> > A generic API is way better.
> > 
> > I'm trying to understand what is missing in the current API.
> > 
> > I think what you want to achieve is
> > RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE.
> > What is missing exactly to implement it with the generic API?
> > 
> 
> Thanks for the recommendation, I think there is probably a place in the
> iavf driver for RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE when we
> detect a PF-to-VF reset. However I don't think it lends itself to this
> problem.
> 
> What is missing is the trigger for the sequence to start.
> RTE_ETH_ERROR_HANDLE_MODE_PROACTIVE seems to be concerned
> with recovering from hardware errors detected by the PMD. There
> doesn't seem to be a way to ask the PMD to enter the recovery mode,
> you must wait for a detected error - please correct me if I am wrong.
> 
> What I am looking to implement is an API that will allow the user to
> trigger the PMD to perform a reset followed by recovery (configure,
> setup and device start). Yes this can be done using existing APIs:
> rte_eth_dev_reset
> rte_eth_dev_configure
> rte_eth_rx_queue_setup
> rte_eth_tx_queue_setup
> rte_eth_dev_start
> 
> But that involves potentially unnecessary reconfiguration and more
> burden on the user in building up the device conf, versus an API that
> just accepts the port_id.
> 
> The user may want to tear down the device and bring it straight back
> up again in cases where something has gone wrong eg. a queue
> appears to be hung, and resetting it may help resolve the issue.

OK your description makes sense.

Please draft a RFC of the API with all the needed explanations,
so we can discuss it in more details.
Or are you asking the techboard to discuss it before the draft?


