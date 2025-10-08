Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8658FCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 10:10:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C925402A0;
	Wed,  8 Oct 2025 12:10:25 +0200 (CEST)
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by mails.dpdk.org (Postfix) with ESMTP id 00C7F40297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 12:10:23 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 69F05EC03B5;
 Wed,  8 Oct 2025 06:10:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 08 Oct 2025 06:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1759918223;
 x=1760004623; bh=zM+LRkiYgPBEv2R2rsvxB/VP8I0pIVNVTj4fVQUMspA=; b=
 I3CfbBXsit13lK5SoIHc40psea8jkogkuQoF6iGMqydnqoxor3fHPjq/wfSbe7g8
 aFx/9Fb3qBvk0ZKu+hOo1v+O6I88u8Xz4Hww19mBqZN7PwhJtuE5/QDDaeiMcJ6A
 ZZ3HeqBSE7BsDm2O3qbd5sCbvLgqO8eOPJilRC02J9NEP/++ZdyC9Mb+RsBuT3HU
 pWPYh7om1V0Pw1ipearhlQlveIRNADgsW3TJVfsjFnQCch1X7gYY9Yw+sEL6ZCxH
 AP+15QBjpJAsbVvcitPDkaj3OnlgL84VzbmZEawlog+fyfA/au7oJ3rtBZ3cDhSm
 ud+KGYfIQRwV9+y1vz7knw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759918223; x=
 1760004623; bh=zM+LRkiYgPBEv2R2rsvxB/VP8I0pIVNVTj4fVQUMspA=; b=k
 U+T9LPsvnBhs/PeBbfgJKMNwNlu9pSIEFk5ao/a/eQWQD1+gO4K8gBA2k4ocB8hB
 UYczK1nK8NnQblWn56DHXR7vRuqcVYoctiAdb2y4EDVAaleJCeQETgWTcmIlGcAB
 jx+tuhWTmVLg32vc2/g3onYmCfCwXiKPQpl46ync65KLcZ4VDr7FHZQ8JU9+qXcp
 leErxuV10jkgDA89Vw/7lJV0cDWatQH9tP6bNNMFMiFBXToNha7Ky6LYAHzreann
 VDDG5EiIQ2ZlhpAIneWIwGhV/DV+gYTym4aPwYaqYQM3xMwzlqJ7stnmoCFSUk/G
 nB74qWa2yUFDCVNss1dBQ==
X-ME-Sender: <xms:jjjmaHbMkLGHRqO7eflp1tJG2P-b9tzMWTGUsL3VhFnl8eB6ROqHOw>
 <xme:jjjmaPVrHYexFAZO1TppmUHgk0MNOARpcyKpC1RXbUpPqEpenIi7IfC_OHwBZLbcI
 igA46KOht7l1pydbQVX6gcoRNRLut0xOBiL61xBpXXdPddHZTsVxxw>
X-ME-Received: <xmr:jjjmaFhdmkjkxvgMDFVUjKT5GN0rlOSVx9B5sDXs1KBmLKMQWwqi-cPi_0xgoF1yqoQKBYwz9qYVCzl6KC9n3EMItg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeftdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehthhhivghrrhihrdhhvghrsggvlhhoth
 esieifihhnugdrtghomhdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonhes
 ihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtth
 hopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
 shhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepoh
 hlihhvihgvrhdrmhgrthiiseeifihinhgurdgtohhm
X-ME-Proxy: <xmx:jjjmaNsPKO4qsApU2j5boJ3KqPo_7TL-Fg03y1q_5w3iDpB-LuGkUw>
 <xmx:jjjmaO7c9DVXBaPFsIJQp9LjoArcZAVdKf1DZ1h-y8-UErpN3St_2Q>
 <xmx:jjjmaBNVFevP7g2BdqaFD8ans0oJa3l1XPJKR-S29fDejX9akta1Gw>
 <xmx:jjjmaEsafpCt86h-J_gS0-441ET2My-caQ55I2qF8_NoVWuF3_NxUg>
 <xmx:jzjmaL9xU1_4iuTtBn3yXCS_EUBbOXt5Gm_YFebi0uFqn86phOnCh_FH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 06:10:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Thierry Herbelot <thierry.herbelot@6wind.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Olivier Matz <olivier.matz@6wind.com>
Subject: Re: [V2] net/intel/e1000: reduce the optimization level for gcc > 11
Date: Wed, 08 Oct 2025 12:10:20 +0200
Message-ID: <4021689.xgJ6IN8ObU@thomas>
In-Reply-To: <aOYi82c71qlZiazJ@bricha3-mobl1.ger.corp.intel.com>
References: <20251006124506.388456-1-thierry.herbelot@6wind.com>
 <20251006130257.391200-1-thierry.herbelot@6wind.com>
 <aOYi82c71qlZiazJ@bricha3-mobl1.ger.corp.intel.com>
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

08/10/2025 10:38, Bruce Richardson:
> On Mon, Oct 06, 2025 at 03:02:57PM +0200, Thierry Herbelot wrote:
> > The e1000 PMD stopped working under Ubuntu-24.04 (using gcc-13) when
> > compiled with -O3 (default level for all DPDK code). There is a crash
> > when starting testpmd:
> > 
> > > (gdb) bt
> > > #0  rte_read32_relaxed (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:290
> > > #1  rte_read32 (addr=0x1100800e00) at ../sources/lib/eal/include/generic/rte_io.h:345
> > > #2  e1000_read_addr (addr=0x1100800e00) at ../sources/drivers/net/intel/e1000/base/e1000_osdep.h:106
> > > #3  e1000_id_led_init_generic (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/base/e1000_mac.c:1844
> > > #4  0x000062aaf653c85f in e1000_init_hw_82540 (hw=0x1586788c0)
> > >     at ../sources/drivers/net/intel/e1000/base/e1000_82540.c:308
> > > #5  0x000062aaf6db8227 in em_hardware_init (hw=hw@entry=0x1586788c0)
> > >     at ../sources/drivers/net/intel/e1000/em_ethdev.c:920
> > > #6  0x000062aaf65340ff in em_hw_init (hw=0x1586788c0) at ../sources/drivers/net/intel/e1000/em_ethdev.c:445
> > > #7  eth_em_dev_init (eth_dev=eth_dev@entry=0x62aaff346000 <rte_eth_devices>)
> > >     at ../sources/drivers/net/intel/e1000/em_ethdev.c:314
> > > #8  0x000062aaf6db8b71 in rte_eth_dev_pci_generic_probe (private_data_size=11240,
> > >     dev_init=0x62aaf6db8310 <eth_em_dev_init>, pci_dev=0x62ab2853dd90) at ../sources/lib/ethdev/ethdev_pci.h:150
> > > #9  eth_em_pci_probe (pci_drv=<optimized out>, pci_dev=0x62ab2853dd90)
> > >     at ../sources/drivers/net/intel/e1000/em_ethdev.c:365
> > > #10 0x000062aaf646adf5 in rte_pci_probe_one_driver (dr=dr@entry=0x62aaf82d8020 <rte_em_pmd>,
> > >     dev=dev@entry=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:299
> > > #11 0x000062aaf6a15f7d in pci_probe_all_drivers (dev=0x62ab2853dd90) at ../sources/drivers/bus/pci/pci_common.c:383
> > > #12 pci_probe () at ../sources/drivers/bus/pci/pci_common.c:410
> > > #13 0x000062aaf7a485f3 in rte_bus_probe () at ../sources/lib/eal/common/eal_common_bus.c:84
> > > #14 0x000062aaf670585d in rte_eal_init (argc=argc@entry=146, argv=argv@entry=0x7fffca468898)
> > >     at ../sources/lib/eal/linux/eal.c:1253
> > 
> > The crash is linked to the use of gcc-13: under Ubuntu-24.04 testpmd
> > compiled with gcc-11 from the same DPDK tree works as expected.
> > 
> > The perfect solution would be for someone to investigate why the
> > PMD crashes. However, this depends on Maintainer availability.
> > 
> > A less-perfect solution is to reduce the optimization level
> > (like another proposal for net/qede: see Link).
> > 
> Thanks for reporting the issue. I'd like to spend a little time trying to
> really root cause the issue before applying this workaround patch. Can you
> provide a bit more info about the setup you used when you hit this issue. I
> expect a lot of use of e1000 driver is in virtualized setups, but can you
> confirm if that was the case here, or were you using real hardware?
> 
> If we do have to apply this workaround fix of reducing optimization level,
> I see you reduce optimization for both the base code and the DPDK-specific
> driver code. Is it necessary to reduce optimization on both, or can we get
> away with just reducing it on the DPDK part alone?

We are not sure the workaround will work with every compilers to come.
Of course it is better to fix the root cause.
If we cannot fix it in time, we can add this workaround in the release notes.
But please, let's not apply it in the codebase.


