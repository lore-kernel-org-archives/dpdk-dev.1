Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3ECC4453C
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 12:51:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0853140270;
	Wed, 22 Jul 2026 14:51:02 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id DFF164014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 14:51:00 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id B40D21D0000B;
 Wed, 22 Jul 2026 08:50:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 22 Jul 2026 08:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784724659;
 x=1784811059; bh=3h0K6HIK44TpgXnA0Xi3Ic1hNIXhmsTr964Y6Q9P4Ow=; b=
 VSMbPz84A7NpiaES7SE4tcfDebsBTa1bpYn2tefHj1zTU8Ku7dtAHjg+k5O/zsD0
 HE1uohW/N7acNPNXqXapHPKcsVPaOrbjWBfDTAHjE5SyLFTiOkN38dSm9ddxaxbx
 7msNHnLPR3elrg7unScuBJn5KbfZbjulNN4g03ddvN6Q1kWnm4OP1Jcbf3XIybZ0
 /8kNy2Ftz/C1O7HSZ4AmorEVtPnb/mI/NB4obznnfo4F5wXbQYzj9o4OAirOQhFy
 fIj5twELCwJIb+vJSCJpmLEJus3w20CkcxtBi0c5f7oKI6aqyESThK+nfrwrSc2p
 +GOZEvoWyZTkB2dzzMlNqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784724659; x=
 1784811059; bh=3h0K6HIK44TpgXnA0Xi3Ic1hNIXhmsTr964Y6Q9P4Ow=; b=c
 +JdbF/II2frxk6PoHWV4e56xKlrdB4aWJRO0vkd44DY48r9Hb0G+hkBeNGsNsnJ0
 +etY9V578WwdhnV7pj9LpCVgdr8rIG04syUqcn9Qij3S3WDP6z/0Drvqg0jbqqGS
 W5sFG9dvwTVFxtA8qfh5Lu2WBNdz4c1mEcHTlMUWlQIdgaOIZfON7XT6a2jUMVe0
 3y91Hj9+irj5OUoSTuoQ42jiQXnq6UUs5pK9uh+LJDe3sXfeCvSCUsHKY71HzIiV
 bI3p3fjFQYTophq8Q4VdWPR0zYDFQeW7zQOBJ+fKUxy7IHyDQNujKpUW2yRWIEuA
 3wxQXOesi/4SdxxTEnNgw==
X-ME-Sender: <xms:s7xganrKZtdSZ_DOx1ePDwSdS4enbKid2BJIT_hNQSPkcL1ZWrUpyg>
 <xme:s7xgavkZX9uOrVJh0fQsQb9wUv1JDk_9k6W556nlwwTyzAio51ZIbnAetEGvq1j85
 rlRsU8VxoNqQjLCrMMXm-Uzg3zfi2v6SJopCxdMwSfzYuWQMgnbKA>
X-ME-Received: <xmr:s7xgamgG0a_80pdgxap_Lce6s1G8yuIJheUZWuct3Vk6yKPZ10y56sXTtLjfF7Eo1IOhsHY0sJ4gZzneGWVdVhHWLw>
X-ME-Proxy-Cause: dmFkZTGjK2ESerbQ8zs3NOe6VDHLBwM1QxYFH3oAtrbI2lDKwzovwAJaA3cxPuls57ZAwk
 s38PDwwwRsE5hrM2XfYmhA9CyzNh5WPzRbdTtJClf2MpxPlswc7zVK+L6/N9J9KUBxpboT
 Av68dM2bXkqlDKafbvAnvPUi2fP2MDI78EYZlbXlf79i9/zW81AzD9qPFb7qvPq7MeXWzU
 B8FfIQx1KJoxk6ycBr58OXFJ7YRHSuJNURVsHC1gtbYmLsQTvtc5j0Z5yv90iVpFxyqDfs
 WoPaShoBzGB1Qnqw3bRwgdywAjbDoKkAWbr8mJuyPJM2uCI40yvMuieXrGXNFnie8qylGW
 2hRkiC4OnI/Ak1ScQ2av1Gtq2oa48yJ1BoKlmhpVVs+oEKH0wBgstOt3L3G1V67YDbczde
 4hV23Bn5pk5GfyBPFIQTatiJZun4MUEPUTB4HmZGUDEN8YzTeysWpA4goCAKvTYK1Esx91
 3YXPQdDryhKA7MQf3MrIO7owswP+yS12LlzvWnTKeJj77BZ7dvzXdkRMt/e0CRcYhS1jDs
 JgseIvfLCTlcqG+a4plqJGK9durlUNHEMDDk7i7n5Fxo+s+ZzUgPfzEqK8i68RWQ0dlZXH
 IK1LPv9xBBhBLJEkGP5boyRwx8vkXpRM1vasDHtq/Rm2xN7wGy+qdxrFzw5Q
X-ME-Proxy: <xmx:s7xgaveEZAgOC2VhORa_cBO-8nbD_gGt-xVX5GnJYNdVTz00UaQR4w>
 <xmx:s7xgauj244sYm1Bdx0dgqta9rZo-quWSMR3JS2lRjd8yccxlupkHkw>
 <xmx:s7xgavxfOpRMH1Vd5kZTJMUgv7MkCMdA8yWoiA3amJavNuJeq4OrMw>
 <xmx:s7xgaiNllyKM1xDOvJc4nnsmiDmA7uFGonB2eQ3aPHlRyjSBKmT5yg>
 <xmx:s7xgapCMNNAsB4DWG0Y2CXo5Ul4JKXKw6pF3TL57N2xhaNmcuTWK61TW>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 08:50:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>
Cc: Jerin Jacob <jerinjacobk@gmail.com>, dev@dpdk.org, dev@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH dpdk] doc: announce rte_graph ABI changes for 26.11
Date: Wed, 22 Jul 2026 14:50:56 +0200
Message-ID: <E5WzQYaQTHOt3V64fDcigA@monjalon.net>
In-Reply-To: <al9dKzan6h0Mxe17@bricha3-mobl1.ger.corp.intel.com>
References: <20260717090121.1859773-2-rjarry@redhat.com>
 <CALBAE1OmG3d4=63YfqYCs+ZWWVzitpCcTBRTjr5yhLA-RZGgmA@mail.gmail.com>
 <al9dKzan6h0Mxe17@bricha3-mobl1.ger.corp.intel.com>
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

21/07/2026 13:51, Bruce Richardson:
> On Tue, Jul 21, 2026 at 03:53:56PM +0530, Jerin Jacob wrote:
> > On Fri, Jul 17, 2026 at 2:47=E2=80=AFPM Robin Jarry <rjarry@redhat.com>=
 wrote:
> > >
> > > The graph library internal scheduling will change from a circular
> > > buffer to a topological bitmap. This affects struct rte_graph and
> > > struct rte_node layouts.
> > >
> > > Signed-off-by: Robin Jarry <rjarry@redhat.com>
> >=20
> > Acked-by: Jerin Jacob <jerinj@marvell.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


