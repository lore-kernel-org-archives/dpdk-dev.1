Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC50CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 15:18:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 882EE4029E;
	Wed, 27 Aug 2025 17:18:08 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 2355640292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 17:18:06 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B50E71400163;
 Wed, 27 Aug 2025 11:18:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 27 Aug 2025 11:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1756307885; x=
 1756394285; bh=J3EJFkx1BfD5X1wMoW9+hpeRmX2WTrO4tZJ3BsETtRk=; b=n
 wiOELEWvtiq0WLYfc46cG/wULD3GOSzg5ej8RzbHeUFBqumNpMUmIXEzOqrsyIQD
 7pVuzjcGyfTkaVHO3RYBMwGntStEn6+l4262W2XIcXehFkK6xca7Qad28N0O9vmr
 mTZIVlxfhAOWVpe+2sHMlpxdeRTki3Uwh6X9/WA3khAQcdKZidpf7MxYsg8Y5jXh
 IaiV+z4EkSHhk2YUL3P/+BnwswJhuVteok+MRzd22BOVSJwyYIMJD7Rt/LY0WQjD
 wMttvJP9f0fLC1fzINYUicuLz8tgGSxw9YOFF1nz1uPfy22wmtP/XogcA8rchwyA
 Gj8D722W2P8pvJdZatjTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1756307885; x=1756394285; bh=J
 3EJFkx1BfD5X1wMoW9+hpeRmX2WTrO4tZJ3BsETtRk=; b=Ndz1TVFVN00NEAZJu
 gkVHK/jGy6G1l1VTDu2yaWYbgua+UVIdipEZcYi0j+7sNrL/cCkZZbZc7GnT7Iaw
 tuW77FI6t6W4+UJZL/t8kitPgbievz2hcE6Rwlkj2oZz75cLatKU/TXkQ2r2essS
 zSVOV2gi7Va6VU21wcevaU1v0vhRasSAcoatO+y8n+Odvviafh8H52CNz93YW6J3
 tICP7kkUSaXAEyWPR81f8lrdKtaCIBE5aAhCe4KQcobA6S6ssF0srEK6KKmFsHPy
 6GLVLnrAkGA31fUVUI6m+KKe+5sezB/N+YFwMQmeaL4o4/X+Cqz0TKqe8VljIy8C
 KnvBQ==
X-ME-Sender: <xms:rSGvaOwvV1qwVSyZ6b9CYANYl8PWFKnvOaeb0QMfQ0rjR2G1HeixxQ>
 <xme:rSGvaPh4vLDzmO6KeibF-FxwmMKoAo8L4-5YNVVRHhu60hSj3t3NMXE7TOBy8xCnl
 UmQjsopVhWGMZ1dnA>
X-ME-Received: <xmr:rSGvaCDxIQIDtG-USVnocgtF00Ss7W8sGQ_ZhUGkP5oCRVhwjHFAF50d8dSrScPkhGx5mU6KA4TrkOhX8jZKiakMHoZ1bAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekgeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejhfdugeehvddtieejie
 egteeuudfgjeeukeeiledthfetveekhefhieelhfdtnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsoh
 hnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:rSGvaMtg36RoFBt6bKOZpWLI-xUGhErxA77G4NZylGyO7dY3Ucfzhg>
 <xmx:rSGvaHbhEFEKeVUwO7UuOWcYzGqZ9l8a6T_bNaTcyL61eALEakZeDA>
 <xmx:rSGvaPWATsWBzwuf19ppvYmhr0W5k5jei3qZOW9q0iriLoWFziUlDA>
 <xmx:rSGvaL7xvH_88buQDQNyvxN7G3PHx2D8nZiU4l5FB7ILGl7ikkEAFg>
 <xmx:rSGvaNwiuRVTz9UxeMnQpaRYodkGoGJYctK7ZxwJKMS8fxm5YxQULRol>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 11:18:04 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 0/3] fix build with MinGW 13
Date: Wed, 27 Aug 2025 17:16:40 +0200
Message-ID: <20250827151759.1448018-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250813152829.457463-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After an upgrade to MinGW version 13 on Arch Linux,
some compilation errors appear in PCI, mlx5 and bbdev code.
This series fixes them all.

Bruce doesn't see them with MinGW 13.2 on OpenSUSE Tumbleweed,
but perhaps just missing some dependencies.

Thomas Monjalon (3):
  bus/pci: fix build with MinGW 13
  net/mlx5: fix build with MinGW 13
  bbdev: wrong fix for MinGW 13

v2: make status_str variable local in bbdev patch

 drivers/bus/pci/windows/pci_netuio.c      | 6 ------
 drivers/bus/pci/windows/pci_netuio.h      | 4 +++-
 drivers/net/mlx5/windows/mlx5_ethdev_os.c | 2 +-
 lib/bbdev/rte_bbdev.c                     | 8 ++++++--
 4 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.47.1

