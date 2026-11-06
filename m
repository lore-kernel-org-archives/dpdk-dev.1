Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD6606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jscyPY37
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECD30402D8;
	Fri,  6 Nov 2026 13:50:56 +0100 (CET)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by mails.dpdk.org (Postfix) with ESMTPS id 4B02E402B8
 for <dev@dpdk.org>; Fri,  6 Nov 2026 13:50:55 +0100 (CET)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b596afb4c5so558190a12.1
 for <dev@dpdk.org>; Fri, 06 Nov 2026 04:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793969454;
 x=1794574254; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XUC6K6ANgvKIyoc15ghxlV3n+0ixPDit7mL2qjIkt8Y=;
 b=jscyPY372BsAazekUkqh82NZA9XWF1U4meuNxA4zOzv5vPhdn4kFdm9OgZcQmLVcXY
 G53FqbgEj7v0WJjf1FJHW7sbDCblaww1U/1AsfUwDR7zGZUEZdvL1OCmSaKKZvsp26r4
 3bOgnBUvR2xiXVAO98qh68MxjWwpigucSRZv+IXdNA36EoEZ7/kqb84mxCsSFxnIr0PA
 +cpAfmKQl80NShzvz1MlL/OV/cWYATp2MaNaYCkMVnJ4UXsAJI5yh9vMe8Pc/4V6oM6q
 QKcs5jTn3mos5yGcodLwhVNHkSJuIXeb0Fo9H0GBudJfSY7SATQq0WkBh6GqXxyEGPwP
 3Cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793969454; x=1794574254;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XUC6K6ANgvKIyoc15ghxlV3n+0ixPDit7mL2qjIkt8Y=;
 b=inrXADdLJtTitYwMtVSDTsbC+Xsa1iyy9Isqn4z36poX+2piVHAEXBJWcPC3wPodsM
 v6VGewFZfvFH/c1kY59wklgKvDjl6B8aZSR37ojftnuJcGYxxFkHlZtuAjAIZLfRkK3t
 OyRTLPvzgnH82QX4ehROLUdibzO4HA+cvjyKkxqlvHAEFprK09OSMld0x84yXPVs4Hsy
 pSyQzpKYx+xK0knA9TSENjDcxbvpinifOeSrvuTz3g8RQEfUeSm9tNqF49I/1djMsdLf
 o6hd0YzDDMXoxUhJPEdw/aUgsrQKLlBo5nRZV0Oi5wS2QDdxtaszejXdkgkHQ4hSDeeL
 8ZOg==
X-Gm-Message-State: APuU4Z+4rKsbNO7kbtuml9P7nFcl3irZVvcf08JTn+MDbb6yi+N6Y8lS
 gTsTJHQwCK4rJpFjiDU/Q6oAq+fIGKc35OF2KbCaucsMzpCKzJ0zT5Ud1ROT7ZesRms=
X-Gm-Gg: AYBFou0QQe8OP4nJWMJh4OeYM3jTHER6t6ERVfyR1lAcLQWT1fJG0/fdLBEaOOnojg7
 7gpj0k+CQyGaWd/HixQudb8B2nRguna8gib7PRU5KTHYFVDUtWLWWnRLGyo6Sy0O1NkZn8PQIsJ
 Rht3xzG3+pky2uwPxS39X/at7dLbiM45vsiu/Svum8jaOLw0odnBXPZMnbKrtvyTAA7yP5uCniY
 0dtU1mWiSxJQxvz0euqMQ/fMgiZu5rLXW/HgyqlVNrlop3j/zARRyAeaW6vvJtFWb+g20Fva2a5
 4d/EL31y15WB/X1UsxmpyWewAijPulxAYaof2SeDQJBhPPhT68pXWqSTd48uMU1nfR0Quka42aA
 KwJJ7e3F6LBrPuArOY8fjfU9kF7ghUNRrxDHgYP1R8YdEy9rUnsdIjBlikZI6P06vMcUvG2YDHO
 gTzUmfffn5iEqWGT2MKuVchCsCbqcFuV2WwLnkPagBwRNFLeFnz43pULsoL0cGcIEIr+wWLMEiX
 NPWN/PE3uj7zA9TWhqcthEOQhZmBnaTpMhONEJ00mmEzGWdj3/sIR0rKsBp57aGMyNblEVCMWYt
 vde7PZ1VV2fpo72mEN59PMJFKN7Oxaoa9RkvcAlqQvAPZB+1MGYs5h2VnTar821CjT/wZ4dCMhQ
 xLdTadGa0wa86sA==
X-Received: by 2002:a05:6402:3889:b0:6b5:665a:d5d9 with SMTP id
 4fb4d7f45d1cf-6b5977ddea5mr1584960a12.14.1793969454231; 
 Fri, 06 Nov 2026 04:50:54 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b664afe901sm715278a12.24.2026.11.06.04.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 04:50:53 -0800 (PST)
Date: Fri, 6 Nov 2026 13:50:50 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>, <jingjing.wu@intel.com>,
 <bhagyada.modali@amd.com>, <Selwin.Sebastian@amd.com>,
 <bruce.richardson@intel.com>
Subject: Re: [PATCH v2 00/15] raw/ntb: post-merge fixes
Message-ID: <20261106135050.650879bf@stephen-xps.local>
In-Reply-To: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
 <20261106055045.720805-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 11:20:30 +0530
Raghavendra Ningoji <raghavendra.ningoji@amd.com> wrote:

> This series addresses the post-merge review of the AMD NTB support
> by Stephen. Some of the issues also exist in the Intel code and in
> released versions; those patches are tagged for stable.
> 
> - Patches 1-4 fix the type confusion in rte_pmd_ntb_get_mem_align(),
>   the unbounded peer memory window count, the off-by-one in the
>   address remapping and the memory window leaks.
> 
> - Patch 5 fixes the doorbell interrupts with vfio-pci: only MSI-X
>   vector 0 (DB0) was serviced, so the DB1/DB2 exchange of dev_stop
>   never completed and the stop waited for its 1s timeout.
> 
> - Patch 7 removes the AMD hardware event handling, which could not run
>   as wired, and documents that hardware events are not handled.
> 
> - Patches 8-9 fix the Rx path: a partially consumed packet was leaked
>   and desynchronized the ring, and an mbuf owned by the application
>   could be freed again on device stop.
> 
> - Patches 14-15 fix the peer device status accesses between the
>   interrupt thread and the stop/data paths, and the missing checks at
>   queue setup.
> 
> - The other patches are documentation and cleanup.
> 
> The peer memory window size check suggested for the AMD handshake is
> not added: all the AMD scratchpads are in use, and the window limit
> register programmed with the local memzone length already bounds what
> the peer can reach.
> 
> Tested with vfio-pci on two AMD EPYC Embedded hosts: handshake,
> file transfer, and stop/quit with DB1/DB2 exchange.
> 
> ---
> Changes since v1:
> - Patch 4: embed the memory window size array in struct ntb_hw instead
>   of freeing it on close, as the device stays attached after close and
>   mw_size could then be dereferenced as NULL.
> - Patch 5: allocate the doorbell interrupt handle array with calloc(),
>   as it only holds process-private pointers.
> - Added patch 14 for the peer device status atomic accesses.
> - Added patch 15 for the queue setup checks, also covering the Tx side
>   (unchecked nb_desc, and queue leak on invalid tx_free_thresh).
> 
> Raghavendra Ningoji (15):
>   raw/ntb: fix device check in memory alignment query
>   raw/ntb: fix peer memory window count check
>   raw/ntb: fix memory window bound in address remapping
>   raw/ntb: fix memory leaks
>   raw/ntb: fix doorbell interrupts with VFIO MSI-X
>   raw/ntb: fix AMD processor names
>   raw/ntb: remove AMD hardware event handling
>   raw/ntb: fix Rx of incomplete packets
>   raw/ntb: fix double free of Rx mbufs on stop
>   examples/ntb: fix raw/ntb library linking
>   doc: add NTB device info change to ABI section
>   doc: add IOVA requirement for NTB
>   raw/ntb: remove unused AMD register definitions
>   raw/ntb: fix peer device status access
>   raw/ntb: fix queue setup checks
> 
>  doc/guides/rawdevs/ntb.rst             |  12 +-
>  doc/guides/rel_notes/release_26_11.rst |   6 +-
>  drivers/raw/ntb/ntb.c                  | 212 +++++++++++++++++++------
>  drivers/raw/ntb/ntb.h                  |  17 +-
>  drivers/raw/ntb/ntb_hw_amd.c           |  60 ++-----
>  drivers/raw/ntb/ntb_hw_amd.h           |  25 +--
>  drivers/raw/ntb/ntb_hw_intel.c         |  17 +-
>  examples/ntb/Makefile                  |   3 +-
>  8 files changed, 210 insertions(+), 142 deletions(-)
> 

This version gets clean review from manual AI run.
It did see one pre-existing bug though.

Subject: Re: [PATCH v2 00/15] raw/ntb: post-merge fixes

v2 applies to main (26.11-rc2) and builds at every commit with
-Dwerror=true, and with -Denable_stdatomic=true at the tip.
The v1 comments on 04/15 and 05/15 are addressed; 14/15 and 15/15
cover the pre-existing items.

Patch 15/15 raw/ntb: fix queue setup checks

Info (pre-existing, not introduced by this patch): ntb_queue_setup()
still leaks on two paths the commit message does not cover.

ntb_txq_setup() runs first and installs the queue:

	hw->tx_queues[qp_id] = txq;

so when ntb_rxq_setup() then fails (rx_mp NULL, or allocation
failure), the Tx queue is left installed. Any second setup of the
same queue id (retry after that failure, or reconfiguration)
overwrites hw->tx_queues[qp_id] and hw->rx_queues[qp_id] without
freeing the previous queues.

Validate the shared conf before touching either queue, and release
what is already there:

	if (queue_id >= hw->queue_pairs)
		return -EINVAL;

	if (conf->rx_mp == NULL)
		return -EINVAL;

	if (hw->tx_queues[queue_id] != NULL ||
	    hw->rx_queues[queue_id] != NULL)
		ntb_queue_release(dev, queue_id);

	ret = ntb_txq_setup(dev, queue_id, queue_conf, conf_size);
	if (ret < 0)
		return ret;

	ret = ntb_rxq_setup(dev, queue_id, queue_conf, conf_size);
	if (ret < 0)
		ntb_queue_release(dev, queue_id);
	return ret;

(ntb_txq_release()/ntb_rxq_release() log an error on NULL, so a
NULL check on each would be needed for the last release.) Fine as a
follow-up.

