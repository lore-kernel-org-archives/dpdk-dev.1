Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BC1D25B44
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 12:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63BDB40274;
	Wed, 28 Jan 2026 13:00:15 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 05CDB400D7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:00:14 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 8CEA5EC0148;
 Wed, 28 Jan 2026 07:00:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 28 Jan 2026 07:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1769601613; x=
 1769688013; bh=Oo9WRQ6Ie+wX5tB5vQ4qbvzma1eg/z4ExVxHDi/ghZY=; b=c
 SCp6tAZ6ooYcgXKNprOiYB2dR5SHsoBdcE9tCPkvZnOF8cBpa5C9fsO3ORL7i3+C
 1HUtH5//2K5C8JxMJGFRoLYilnYbrdjV2gTqhd3t2dAokjiByS/ZOCjQvKYabcSx
 p9u0xJD9RPxEyf1Z6N6Z9gGXwJ4epvfbexVeWs54usP0w1Ca18umHHJji+mp1xHh
 luEU8rC7wZGyzGzrv+N5uIwd50vkEHQHfbHWMqYmOX4AEeRkllq8Fko0flY2QqkC
 mN9oqKLaYkWbQYmj/xW6McqzPdBJHzk7bFZ+D6TVb1gzM/gx9hkEDhx6qvXeXaFS
 YM3O46DmXafQ58AjRWe1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1769601613; x=1769688013; bh=O
 o9WRQ6Ie+wX5tB5vQ4qbvzma1eg/z4ExVxHDi/ghZY=; b=KWXYkdaAM/Mq7ixVs
 AoLJT7MpXLRmqrgF+9dwfkW4L2KGXnAs5A8KwVQsktyHyLxabrqFQLm9sMdzqXme
 45PyLHvnsZqmN2Gc0TO3Z0h0qzNgeiFxVM9w9dL85HL/q4N6ruxkRu7T1GOCMPOl
 bDHUh8vJz7pHE/jVKKllE4cyFnRrG9USZGWb76ombJAaFOJAoU/udtlQmWA1SMvw
 hTg8G31YSz6pnqh0JSEgk+KlN65Huhbl+DjjoxlF/MuoCWCc2sJzr8XmAYHIpKZ5
 /bdIGZr9hx4RZQfmsc2hcvCWsQq++4uiqnXtn2XnFPAt1/di4/vYJoplclCH+Mih
 MRbnw==
X-ME-Sender: <xms:Tfp5aU5WUYghltS3R_wc5t7p1ckbigUhOSJZ3YjpO5r21xoeVGlPlg>
 <xme:Tfp5aSPAvhNCYj0jLc8_p4ozyW6pLP8k3h-KfWC9jQ_qhyLJNq9RdUyT0LIvGsAki
 -S7_1xkyv6OO78JuwDzqY-NE_5XqL_cmGQLVGn-M-RrTC7AeusEiA>
X-ME-Received: <xmr:Tfp5aWNKGlKId4O8PfvlfyCWh9zyeE1esX-FkAGVVpgsKWXHpOJrfaBbCRuaYZOJ1EPtSqeZ6sVplEdObVDc9PCsJls7NYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeffeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejhfdugeehvddtieejie
 egteeuudfgjeeukeeiledthfetveekhefhieelhfdtnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhguse
 hrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Tfp5aa893tm3MtPWpKochPXYyVEXyTdbgT-sLORLWT5PLIyJegUvbQ>
 <xmx:Tfp5aa5zqELatNz9WzvBNQgkXjTdILdAea7LwXp83E1-uJk8zuHy4Q>
 <xmx:Tfp5aR3e6WmcRC6VwpaYqiKKo3SsVP_c0AfLsp4eJ9T2gBio2ub0GQ>
 <xmx:Tfp5aRAepAgkkTWUGBYhuXWjeJUMeQIh9CFEKfl3qvzZeOilDps44Q>
 <xmx:Tfp5aTuo8zAy6noMko9cIS2QU4-2W9pmiRZvVxUOW6PcIXUjOdwWwPEC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 07:00:12 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com
Subject: [PATCH v4 0/4] more build tests
Date: Wed, 28 Jan 2026 12:58:29 +0100
Message-ID: <20260128120005.2777473-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20210412215339.2439530-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
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

While testing more build types, some errors occur.

v4: fix new warnings with minsize
v3: fix minsize build with GCC
v2: fix init of var buildtype

Thomas Monjalon (4):
  bus/pci: fix unmap on failure in multi-process
  argparse: fix minsize build
  mldev: fix minsize build
  devtools: test different build types

 devtools/test-meson-builds.sh    | 6 ++++--
 drivers/bus/pci/linux/pci_vfio.c | 3 ++-
 lib/argparse/rte_argparse.c      | 2 +-
 lib/mldev/rte_mldev.c            | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.52.0

