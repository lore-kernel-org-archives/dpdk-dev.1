Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5306CF531CC
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 20:35:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 444B2402E1;
	Mon, 13 Apr 2026 22:35:45 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 87864402CC
 for <dev@dpdk.org>; Mon, 13 Apr 2026 22:35:43 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 9976C1D00239;
 Mon, 13 Apr 2026 16:35:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 13 Apr 2026 16:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1776112542;
 x=1776198942; bh=Q7uA5JLJfDrO1EUq854aj54FaDxPV+9xigwMAFts/BU=; b=
 FH2tpg1dS7ctyt8w5n6akwVS99unjFo6SX4ZX96aKTs5zcRChqROeWlZcZ1bdZZx
 oHydRo3cNFg/CAt2/AyvJGkRV6i14Ykfrme30XRxbpXe4RxmF00k4EqBgG461fTN
 1sCJ1NCwpKF8Lg32l0FAhZxnfNIXeVRh4oKrfZtkaLuMfpcIVdrxqNn7Z6+cFlC6
 SyD+AOGEyYLUkTggxIzO3DjhlRxBoERRwIWHnLl5KSvgaIjWt9sUZ9MOK3g9kRJ4
 fGqUI/NSgF0tOEKfOBiLYvQNsEkMDpHyc0/mNItIry2rGoUKHsZOCwa139sZyjLb
 D9W/9ikukraFjY1wf4HIiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776112542; x=
 1776198942; bh=Q7uA5JLJfDrO1EUq854aj54FaDxPV+9xigwMAFts/BU=; b=V
 6RdtWz1F68Kn8jsFI654OCToAuwg3zuHJd7Dr8OfV9vfyyOtxBhVpern814wHnuz
 fMKRA4x6q0WWiPxX2wGhKDLjwJ8zUjdWYl5Kd++6+SRsvSEkGOEbBmNkQr44dFXc
 930sed0fIoiZFan1Wc/K0TQXRKtbyG8Tq55VZ5quzPKguukDr2eEUGweWeHuBx8o
 GjssFesLfuPQv3tZYRY9hgFLI93EFFPN0/yROzskMvHcQNOQ+BGAiS4wzs3UblNA
 YKpGIlOlSjx2ktFFM5y4tPNtY3oZpXmbkNLahe41aC6bvb+QuyXjpYSKzknFmNkV
 lGW8h7c21vJo/0xxlr5tQ==
X-ME-Sender: <xms:nVPdaY-HRMVKZhQCVbRF9wW5ZfmGgPzd1fpok0OT_JlTAaSIxy2D7g>
 <xme:nVPdaayRGdyS_eSTpF9uW_usZXv-dIz446zHQZQ0hSd0WBTyz5b3ZnSCeE0atH0X6
 YVq4sV0t7GoaoO36ty45hPGrAFCPLeGf1y92mzd0OEBfQ6zghbpAg>
X-ME-Received: <xmr:nVPdad7pLZayowW8dgsrLdestE6_YBCYnUU32B99qKmURXYvw-0ABz2Hm3Ep7-KP7g4bWEXziIV7yWtbF8hc6QaJUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefledvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomhdprhgtphhtthhope
 hrjhgrrhhrhiesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhgvmhgrnhhtrdgrghhr
 rgifrghlsehngihprdgtohhmpdhrtghpthhtohepmhgrgihimhgvsehlvghrohihshdrfh
 hrpdhrtghpthhtohepkhhtrhgrhihnohhrsehrvgguhhgrthdrtghomhdprhgtphhtthho
 pegrnhgurhgvfidrrhihsggthhgvnhhkohesohhkthgvthhlrggsshdrrhhu
X-ME-Proxy: <xmx:nVPdaZ8Cu9xZINoAcyMavDhv9pwXhG-cAks99KbGdKaEhFd5whNR_w>
 <xmx:nVPdaaq1G-AG-b5mErkXtDm4hJCuGP5YbyxP4BkecC_AS5K0Pnyryw>
 <xmx:nVPdaSozpKrNzdVCfepuujmiD5iBjm0S02QQ-sTlNhDi-phf3ys_KA>
 <xmx:nVPdaV0T2OyhtJeljKP-4CRlyMJsfWrCP1o01DxJDG-E9j3f2tvM8Q>
 <xmx:nlPdaT5hh2j5qOCXVXEum-nnKt4hMgtkW5_CvBZG1Gz39AAAF5Sbw_hh>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 16:35:40 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>, Kevin Traynor <ktraynor@redhat.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH v3 7/7] eal: configure initial device probing
Date: Mon, 13 Apr 2026 22:35:39 +0200
Message-ID: <48004715.fMDQidcC6G@thomas>
In-Reply-To: <20260407115211.1903623-8-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260407115211.1903623-1-david.marchand@redhat.com>
 <20260407115211.1903623-8-david.marchand@redhat.com>
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

07/04/2026 13:52, David Marchand:
> +*   ``-A, --no-auto-probing``
> +
> +    By default, EAL probes all devices on every available bus, unless some ``-a``/``-b``
> +    options are passed.
> +    Disable automatic probing of non-blocked devices.
> +
> +.. Note::

Usually we write such RST directive in lowercase: note

> +    Block list cannot be used when auto probing is disabled.

It would be good to mention the option -b here.

> +
> +    On the other hand, disabling auto probing does not affect the VDEV bus.
> +    The VDEV bus is not concerned by automatic probing and requires explicit

Repetition of "VDEV bus" may be simplified in one sentence.

> +    ``-a`` or ``--vdev``.

We could add at the end "to be created".

There is no mention in this doc of the other option to force auto-probing?


