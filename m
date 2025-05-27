Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA09C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 14:54:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18771402A0;
	Tue, 27 May 2025 16:54:02 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id A3BBA4027A;
 Tue, 27 May 2025 16:54:00 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 52E4F11400AD;
 Tue, 27 May 2025 10:54:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 10:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1748357640;
 x=1748444040; bh=gRZV+flnnb3sEEkkAxsUn4dkNvxL0Mo2I3wxnl741+c=; b=
 Bt9MinZcrYCwXkonwxMR4d2jy3Mo0vbEQp+qfd/iLHGdk/wuUqqNo9rHP91hDU3m
 FD7v7rETP0zUkbCEPigjFOboZd5PxFyL6Lx7XuZswCSRTOBuwhpZkEkwiYg+wzpp
 WsPSfq2WYdWCLnUIo9QrLzReyIATJ+rLIVFXUAvwvltxzoL54ZZ27i2s1h1LVYhl
 lmEDy+PO2mUuOkYv/hEdi0rvXt3N//7jg/OZ3o8Uw+z4a8cpqum/pGIe0qR3ftS3
 RQNRVKnrPzGpUMjBV+N3MuH4mpN08KWhyqGYZOw59Nbmzpi0uNTBvibY1fi45KCg
 TYhi3vnTlWwdjxME9td6BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748357640; x=
 1748444040; bh=gRZV+flnnb3sEEkkAxsUn4dkNvxL0Mo2I3wxnl741+c=; b=W
 wxLNjgn7mffPJIKgh3admrHDpvDkmuuYkX2eWi/smhuLos7epH6aR+wZ8zAt/fsD
 NlVWt1JyBnv3qBM3uoTBbdayh99uSTyeh99+9vWZec8PLnidIr+c158nbF+7LsSw
 OBCOjKhoMU78HWiYBjLD8DvAqywu9b5AY+XgHfY7v41xWbbGEj+q+43ZnwwBoyj8
 tVZK/JFo0Nil6ALisiM0BRb1af41CHAb1bEmJcyxZKrVwnVVZy4KuSJRUBU7Zgpb
 EGujNNWA3zSELFeONoGLfSMieIgeOWn3Jj9i/Cad8kh859qN22SVAODxFpaLqAbY
 m1oe2mnpgP9q2kphDfAPQ==
X-ME-Sender: <xms:B9I1aJam7ne7eKEg9KSisoisGLJcDamTM8iB0PwgXUsS4N1QDEO5Yg>
 <xme:B9I1aAbOhWhiDm1UgdC0mKCEgvSTMWZRwudc3Q5yuKFw4POxhDWhuvvUNPEO-bfqH
 lI7RDH-qJZAjKru2g>
X-ME-Received: <xmr:B9I1aL90-tAOyIWx657wZkPSB5T3VpnV_NvDx7FmDCMKTU8-SfJ1jffjSp8mpzRXAilpyv5T6egfb6qFSt-NxF4JqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdeijeculddtuddrgeefvddrtd
 dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
 fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
 dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgj
 fhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuc
 eothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjedu
 veehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluh
 hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
 htpdhrtghpthhtoheprhhuihdrfhgvrhhrvghirhgrudeshhdqphgrrhhtnhgvrhhsrdgt
 ohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtrggslh
 gvseguphgukhdrohhrghdprhgtphhtthhopegurghvihgurdhmrghrtghhrghnugesrhgv
 ughhrghtrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhihvghvse
 hhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:B9I1aHq7foZtUGcLQgT1nCyHbUVsraQjlZ4KBgo99jgBW40qC2J8mw>
 <xmx:B9I1aEozIf1mxQrnh80e58ZAhVnzJDyLJgDb_1OZ88hyutY2-vNiNQ>
 <xmx:B9I1aNTuVZCVmbl9eM_POLIu-txH9Csbi0R3ie_k0WkkYVV7dvuAAg>
 <xmx:B9I1aMq5Nh-xya5MXR8rFaA6HUAQ0MiJn5jcWyZIQiLmTK5_ULrOyw>
 <xmx:CNI1aAmTMKqRbX-PdN_KPtz10cTnCp9434LCBraBXydHWNF4Hyq9h6mJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:53:58 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Rui Ferreira <rui.ferreira1@h-partners.com>
Cc: dev@dpdk.org, stable@dpdk.org, David Marchand <david.marchand@redhat.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: Re: [PATCH v2] fix eal/linux: unregister alarm callback before free
Date: Tue, 27 May 2025 16:53:57 +0200
Message-ID: <1969712.QZUTf85G27@thomas>
In-Reply-To: <20250522155944.65342-1-rui.ferreira1@h-partners.com>
References: <20250520160150.50401-1-rui.ferreira1@h-partners.com>
 <20250522155944.65342-1-rui.ferreira1@h-partners.com>
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

Hello,

Did you see the comment from David about fixing for Windows and FreeBSD at the same time?
I think you just need to apply the same logic in 3 different places.
If you cannot test all, that's OK to submit the changes without full coverage testing.

Thank you


22/05/2025 17:59, Rui Ferreira:
> This was flagged by Address sanitizer as a use after free. The
> intr_handle ptr is shared between the main thread and the interrupt
> thread. The interrupt thread can dereference the ptr after free (from
> the alarm callback). free is called when the main thread cleans up.
> 
> The interrupt thread never terminates (eal_intr_thread_main) so
> use rte_intr_callback_unregister_sync during cleanup to
> ensure the callback is removed before freeing the ptr.
> 
> To be more defensive clear out the pointer and registration
> variable if we can unregister.
> 
> rte_intr_callback_unregister_sync may (optionally) use traces
> so the alarm cleanup must happen before eal_trace_fini to avoid
> accessing freed memory.
> 
> Bugzilla ID: 1683
> 
> Signed-off-by: Rui Ferreira <rui.ferreira1@h-partners.com>
> ---
>  .mailmap                  | 1 +
>  lib/eal/linux/eal.c       | 3 ++-
>  lib/eal/linux/eal_alarm.c | 9 ++++++++-
>  3 files changed, 11 insertions(+), 2 deletions(-)



