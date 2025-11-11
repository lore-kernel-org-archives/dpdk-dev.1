Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD87CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 18:25:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6054B40280;
	Tue, 11 Nov 2025 19:25:10 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 1116F4026D;
 Tue, 11 Nov 2025 19:25:09 +0100 (CET)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfout.stl.internal (Postfix) with ESMTP id 47ED31D00170;
 Tue, 11 Nov 2025 13:25:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Tue, 11 Nov 2025 13:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762885508;
 x=1762971908; bh=M49hjSQ3GKqX2vpcSIqthSotioT7mPEl0VgLxfpo+q8=; b=
 klySV3CVg6l0COSJJWoapUdVGZpJ5g3o6kyc2W6dngRrgmbqoJ0TK+JiOLs7Ca86
 4rhQcu+P+dE3Xvji+2gHv7ar4/A/9uI4R1X+scBUMwnn+SQalelMRXnJrm30iWx9
 s8HRRa/kkk09IE9hDmqjeZ42P9tYK8i/QEl2zBdQ49rH5aor7R7hD/yZVHNcrpny
 KqY9KKgfIwCwsNKVxOTuSH1CQLFav6lRJPUpCegXjUvukVXED01RAtRDRkOw2fwu
 9CjFE6h06GezndBBvExTHAFO4vMxwe9R/BRQGkyLPqVQg/pQ9BmdAKyQ00YQQdi0
 CbdmMR8Si/m9AXYLnJwWxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762885508; x=
 1762971908; bh=M49hjSQ3GKqX2vpcSIqthSotioT7mPEl0VgLxfpo+q8=; b=1
 ikuOe+AkX25O/Omdu4sqWLsOzljfIkZyWR5FWp1ZVsF69eNiziSvJ2DgWSFmay56
 bNg6cl13C1JZurIQJuLg/bV9qrS4N6ZmwvKrQr2zMI8oeUZFK4FW2waoQfAA8+yL
 oQToRcQj5PjpF/QO9RvCAVF4vgiVABNiFObcRBmbI6hMA01lStJtFARPDS9GfvVI
 A97nnDjT1fxqvRY7YRv7aWAWv4NtSG2ZQ0vBumE7bp1T6uLt7pf9hlFtvBUI1ZsU
 f+UaVRKoDIfdleLSFEtVSWTFkgFytFtF9eqYrwZiY+R7XQrSxmB65KmDDd2jzviz
 dHAJaxwemUmMNkZOuniGQ==
X-ME-Sender: <xms:g38TaSkFCYyKDBh8Y0MF7SW9x05ek_JG9Q6IE0NZ0djaLPuTmx_REQ>
 <xme:g38TaR_aRDXs9K26Sro6WAIZiEu7iVGbKA8STkfhEAD_-JDoqvkls4elFcq62-Ztv
 F-lwfGHPQzCC_SfSlSzvRQ5JY3FHJ9GaFqHN7m2o03KQ-86qpo5sQ>
X-ME-Received: <xmr:g38TaQLHdUo3KRQ2QVAyyPu5MlHUHUVvjyJ24jmlm2ZrYsS8y08_MnWi8bhGz1m-e_8nWvh1rNqCppmKLBNk6YyrXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduledtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedufedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhivhgrphhrrghsrggurdhtuhhmmh
 grlhgrsegrmhgurdgtohhmpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdp
 rhgtphhtthhopehmsgesshhmrghrthhshhgrrhgvshihshhtvghmshdrtghomhdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepkhhtrhgrhihnohhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehkohhnshhtrg
 hnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtghpthhtohepkhhonhhs
 thgrnhhtihhnrdhvrdgrnhgrnhihvghvseihrghnuggvgidrrhhupdhrtghpthhtohepmh
 grgihimhgvrdgtohhquhgvlhhinhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprggt
 ohhnohhlvgesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:g38TaWgGNAnJJ7eeriAU7hPruYvh34reLQGPG891OAhfePDnNDg5tw>
 <xmx:g38Tac9LuD1qp_xFU8ty4IsnTb9gA5G6KvAm8tvhEm6cb5_XzjA-dA>
 <xmx:g38TabPg1aXz3k4OnUJJvuKmdIE0BuN5IQvATzZhZMfYDXniODsTRQ>
 <xmx:g38TaQCJ37sX0LHNgRYYZzSYzQvYAL5vQQN1h3KdXbuSHRZ5w3BdPQ>
 <xmx:hH8TaYiV9_KhYLa20vnzzVs9795stOtEMKz9DeydQZ08-NpStRYj9Muh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 13:25:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: stable@dpdk.org, mb@smartsharesystems.com, david.marchand@redhat.com,
 ktraynor@redhat.com, konstantin.ananyev@huawei.com,
 konstantin.v.ananyev@yandex.ru, maxime.coquelin@redhat.com,
 aconole@redhat.com, ferruh.yigit@amd.com, dev@dpdk.org,
 ciara.power@intel.com, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] examples/l3fwd-power: fix telemetry command registration
Date: Tue, 11 Nov 2025 19:25:04 +0100
Message-ID: <5662854.jrt8l4j9yI@thomas>
In-Reply-To: <aQylobE5s0YtsnDt@bricha3-mobl1.ger.corp.intel.com>
References: <20251006101058.191495-1-sivaprasad.tummala@amd.com>
 <aQylobE5s0YtsnDt@bricha3-mobl1.ger.corp.intel.com>
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

06/11/2025 14:41, Bruce Richardson:
> On Mon, Oct 06, 2025 at 10:10:58AM +0000, Sivaprasad Tummala wrote:
> > Telemetry command registration fails if the command name contains
> > characters other than alphanumeric, underscore (_), and forward
> > slash (/).
> > 
> > The l3fwd-power example previously used "/l3fwd-power/stats"
> > as telemetry command, which includes a hyphen (-) and causes
> > registration failure.
> > 
> > This patch fixes the issue by replacing the hyphen with an
> > underscore, changing the command to "/l3fwd_power/stats"
> > 
> > Fixes: a35919a1139b ("examples/l3fwd-power: use new telemetry")
> > Cc: ciara.power@intel.com
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



