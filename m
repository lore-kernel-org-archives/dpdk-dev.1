Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6331FC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 18:27:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF4624026D;
	Fri, 27 Jun 2025 20:27:25 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id BA3E1400EF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 20:27:24 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4D5B5140018E;
 Fri, 27 Jun 2025 14:27:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 27 Jun 2025 14:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751048844;
 x=1751135244; bh=h602hDdDodDqYpNBFM1QiWq6T+khX58QwoBal9nPwAs=; b=
 b0aiVz9fSWFL7UN978N7906jKeiAvmeH9q3l3NqzsObg1sY3y+FYNExylAmVSRAD
 GiJ6d6Pg+khtnDKo6lfTFwSqB3vXfW7UH9bas0ozOdrCoqM8dhCFQ0l/qMeRbgZn
 5pgWFsyEUvRI7JaqI1imEhTmwTBzhO82S2+0tFT02Grxg7tZQJLRX3bzgdYhplEG
 6hECWgQE0GTyIkJ6/JvjmeBRl6rMTFswTErn7Bd2SkH/zy2wk1pT2jmVfNimXx20
 At/kYAEYqzVPapc/7CTeob6QtTYvpFTGY6wy+vRPHWzz8EQNNhuRXn3wAxTN3Fr2
 okTP+Q7vQSCrcFSLuqDXKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751048844; x=
 1751135244; bh=h602hDdDodDqYpNBFM1QiWq6T+khX58QwoBal9nPwAs=; b=B
 sUGAogwwOma3Acm8pDB1lVJdTOdTmSej+T4F9uBjZTExOWbPQFePfhOyp4bTEK7z
 c/DkTaT25ZdMdET6rl/tc2kpN+Vw02ie6pXgrMo2f111tiL0Zo1N0YlLUrpZAKUd
 xRG2TJLJHBXL9CwI/QDh1DJRfTGcig7jLOG15M+BHHOvEvEC8DIpGOwyJ3ldoyuP
 PqAOwL6Pzkw/rJIqrbsBVrpfXjLb7iqAf4o3CrhC0cv4o4Y3ftEPb4c0D+/+Xrc0
 lbhsx/7+R6UAOADAg8UZx9jH6ncZ0u1RWNAwA9S3+6QWKx2PmMJam4wBo8FhRUTs
 OEYs46w39Ocbx7cszlGFQ==
X-ME-Sender: <xms:i-JeaPraoOSEUNttNTretDJYHqJzkuNRwPSB4QVf8fAHQPNMAb1qwg>
 <xme:i-JeaJr0p8-JwOXdwKLA9RzNGUqSDvgUkkLjRbwU7T3tDAXcVM7_AdssTD6eCPbH8
 15QNWvkEPMMHDEfSA>
X-ME-Received: <xmr:i-JeaMPZnVFHBDClj3pC09ehxRzQxWyCQHyOp4JUDtsUHduYNwOA7xo7-z7Zaqvc-57Qkzusmb8TFfR9ebo71IfIyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopehstghhnhgvihguvgesqhhtihdrqhhurghltg
 homhhmrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 rhgvshhhmhgrrdhprghtthgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehsthgvph
 hhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehjvghrihhn
 jhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehkihhrrghnkhhumhgrrhhksehmrg
 hrvhgvlhhlrdgtohhmpdhrtghpthhtohepnhgurggsihhlphhurhgrmhesmhgrrhhvvghl
 lhdrtghomhdprhgtphhtthhopeihrghniihhihhruhhnpgduieefseduieefrdgtohhm
X-ME-Proxy: <xmx:i-JeaC5WgrADf_g195pOMxmc3XuYL8RHOowFoqC861VnImOonQlqjg>
 <xmx:i-JeaO7Jl9MW4wI4qK7gkl65A8_IqfWZ7pcNgoHb6mMm0asbYuBn5A>
 <xmx:i-JeaKhqW4PgD-YKPP33tFa3b55cHlkZZ_JCep3_l3eqTB5NQCX5aQ>
 <xmx:i-JeaA7rPIUkw72Wd5DIYzh0FjFOtP0KD3Thjgu5b5oUWX99m2nJBg>
 <xmx:jOJeaHcPQHB4zRGMciMa1z5hulhQ-AedF5Ah1xYj3uhBeYo2IRIYm7_B>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 14:27:22 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dylan Schneider <schneide@qti.qualcomm.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
Subject: Re: [PATCH v2] pcapng: allow any protocol link type for the interface
 block
Date: Fri, 27 Jun 2025 20:27:20 +0200
Message-ID: <5716686.dhzUhtFnW9@thomas>
In-Reply-To: <IA3PR02MB10771799502C67457C7CBE257E945A@IA3PR02MB10771.namprd02.prod.outlook.com>
References: <20250529171609.2448832-1-schneide@qti.qualcomm.com>
 <6923574.A9s0UXYOmP@thomas>
 <IA3PR02MB10771799502C67457C7CBE257E945A@IA3PR02MB10771.namprd02.prod.outlook.com>
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

27/06/2025 19:46, Dylan Schneider:
> Can you tell me the build command you're using to produce those errors? I have ran the builds on my test machine and cannot reproduce these. Thanks!

I run devtools/test-meson-builds.sh with an Arm toolchain installed.

Message: 
=================
Libraries Enabled
=================

libs:
        log, kvargs, argparse, telemetry, pmu, eal, ptr_compress, ring, 
        rcu, mempool, mbuf, net, meter, ethdev, pci, cmdline, 
        metrics, hash, timer, acl, bbdev, bitratestats, bpf, cfgfile, 
        compressdev, cryptodev, distributor, dmadev, efd, eventdev, dispatcher, gpudev, 
        gro, gso, ip_frag, jobstats, latencystats, lpm, member, power, 
        rawdev, regexdev, mldev, rib, reorder, sched, security, stack, 
        vhost, ipsec, pdcp, fib, port, table, pipeline, 

Message: 
===============
Drivers Enabled
===============

common:
        cpt, dpaax, ionic, mvep, octeontx, cnxk, mlx5, nfp, 
        nitrox, qat, sfc_efx, zsda, 
bus:
        auxiliary, cdx, dpaa, fslmc, ifpga, pci, platform, uacce, 
        vdev, vmbus, 
mempool:
        bucket, cnxk, dpaa, dpaa2, octeontx, ring, stack, 
dma:
        cnxk, dpaa, dpaa2, hisilicon, odm, skeleton, 
net:
        af_packet, ark, atlantic, avp, axgbe, bnx2x, bnxt, bond, 
        cnxk, cxgbe, dpaa, dpaa2, ena, enetc, enetfec, enic, 
        failsafe, gve, hinic, hns3, e1000, fm10k, i40e, iavf, 
        ice, idpf, ixgbe, cpfl, ionic, mana, memif, mlx4, 
        mlx5, mvneta, mvpp2, netvsc, nfp, ngbe, null, octeontx, 
        octeon_ep, pfe, qede, r8169, ring, rnp, sfc, softnic, 
        tap, thunderx, txgbe, vdev_netvsc, vhost, virtio, vmxnet3, xsc, 

raw:
        cnxk_bphy, cnxk_gpio, cnxk_rvu_lf, dpaa2_cmdif, gdtc, ntb, skeleton, 
crypto:
        armv8, bcmfs, caam_jr, cnxk, dpaa_sec, dpaa2_sec, ionic, mlx5, 
        mvsam, nitrox, null, octeontx, scheduler, virtio, 
compress:
        mlx5, nitrox, octeontx, zlib, 
regex:
        mlx5, cn9k, 
ml:
        cnxk, 
vdpa:
        ifc, mlx5, nfp, sfc, 
event:
        cnxk, dpaa, dpaa2, dsw, opdl, skeleton, sw, octeontx, 

baseband:
        acc, fpga_5gnr_fec, fpga_lte_fec, la12xx, null, turbo_sw, 
gpu:

power:
        acpi, amd_pstate, cppc, intel_pstate, intel_uncore, kvm_vm, 

[...]
  User defined options
    Cross files           : dpdk/config/arm/arm64_armv8_linux_gcc
    buildtype             : debugoptimized
    default_library       : shared
    enable_deprecated_libs: *
    examples              : all
    werror                : True

Found ninja-1.12.1 at /usr/bin/ninja
Cleaning... 75 files.                                                                                
[3652/3653] Linking target drivers/librte_event_cnxk.so.25.2
Error: cannot find librte_pcapng.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
Error: cannot find librte_graph.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
Error: cannot find librte_node.so.25.1 in dpdk-build/build-arm64-generic-gcc/install
Error: cannot find librte_pdump.so.25.1 in dpdk-build/build-arm64-generic-gcc/install



