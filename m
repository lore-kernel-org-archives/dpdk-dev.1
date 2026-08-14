Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C88C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:47:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E010140288;
	Fri, 14 Aug 2026 17:47:08 +0200 (CEST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 0214440269
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:47:07 +0200 (CEST)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-c96b08cdd1cso863824a12.0
 for <dev@dpdk.org>; Fri, 14 Aug 2026 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786722426;
 x=1787327226; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iXXn8EhBq4AVt1cMCmMVgRk2//7F2+QKdW+Fh11YfjQ=;
 b=HsySZ4f8J8WOVsdBO79TxM4GMKkYGd+tDjrQUi560r+9mari2vn7+6iZQKxom1mZhN
 vhnjTNIArp7kPyP4ODrPN1PMD6rCBA2Eg6tBjWYLhiIEcAHSk33OdcuWdVGCzFEeBubK
 GcThYb7wb+ZXQEh0S/uM733pko/1R6xVZXI2ZQODSUBGOjcrzk9tTV2p68TfdUAcDMzI
 A4aasdNMUJEIKKCILP92yW3wZ+Qxe/JQZ812OrH4rD12lHvtV1lbrkL4zw2lQHWMzlxj
 QwsDn3bvXJAF4+2mvFoRNudKRNHq9AanL3y0YWDW4FlQbQhGpPIfxLuA7LNfP4qENZIr
 KIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786722426; x=1787327226;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iXXn8EhBq4AVt1cMCmMVgRk2//7F2+QKdW+Fh11YfjQ=;
 b=MyNQRlv4tDeO36j8lNTR6PEqikakGBF5WqUJCXkAL4l1R9hrZ5PQCTyXIUR/jVaYHJ
 +hGNf1+oAXcitYQR1Ihbse/SrmQdTF98l+7wK94HBULzFTHKeILpLVZTCJ42BPZyXxEO
 cNpttgQvNaqVO4IRkbCBT1lgf8faklHeKQuHHXgchs86Je0zyro04ZhmirC2lg68zW41
 5cM593i3SFVZWxOjQY1irfFhfOCnujr9oQfp3k/8+2MUt7xVzAzayKBoEHPJWaSwkQn5
 iASqPwYhinJ1HKDAqsh4OcJ5yD9vTQhk9GDGc44k8XyU4yOddb0jMKAtY57IgTj3nx1X
 5y2A==
X-Gm-Message-State: AOJu0YwLEzgravvEqBGMQ/eS2c5hFdtiUPIJKnALJ8er3AKGXU+GFdd7
 QUxOZDdLPpLIXAS3bea6VDpFjl0860TeACriI3Gr3scTWpyvp9B4Szb4F/Yt0NZM2XQ=
X-Gm-Gg: AR+sD11TNHEHL1T3rOMaH7TL5Gjbj34lJIblWUYjGU030qaypkBRwztGsVPpx4gB0a4
 12zAFmbpMAeOqBmKwpcBIrVyrrwq+pwbx+i9VbQF5s+tbUKM7BKVxKFCYype7mGf7wNOHB8QYKK
 UOYdaxQ61S3viEw+begl9WLhPSbOojNee64rknzEKvL/uo46jtmQKx5orB5T/tifVsnJziXssGT
 zq/FXS8DcuTv9gThoEbw9Ct+8lhS7kL2IAYyzDhIOm0jp913rZy1TUGwEjIXq5kH9WDR0IdqLLQ
 WP8tCNzlqJkg3KgS2ELu9/O+p9b0f85C0nIQfeN0xYBsdf+aNaUukmtx95YJ++6FwCGpV6uqwZL
 kk848XGJqo0QJdJaNT0nUmzf4nUIDbr6zMWR6Wa2DH/KU2rUjpd+uklECFVJAZuMBiRr/aS4G2X
 EzQFkC+vU1WRfWeveV04KQlS0lJj4w11Zl8JCPzY/RSaLvV7LympAdqI5TUUirm7kJkNbpk383w
 OJegt6W73aT4Vk0xrYyoQWaL4r9v3mswhJG/SFw
X-Received: by 2002:a05:6a20:3949:b0:3c3:8651:b317 with SMTP id
 adf61e73a8af0-3cc71ced4d0mr7124181637.10.1786722425944; 
 Fri, 14 Aug 2026 08:47:05 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141387af4adsm9848286c88.1.2026.08.14.08.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 08:47:05 -0700 (PDT)
Date: Fri, 14 Aug 2026 08:46:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: sandeep.penigalapati@intel.com
Cc: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan
 <mtahhan@redhat.com>, stable@dpdk.org
Subject: Re: [PATCH v2] net/af_xdp: fix shared UMEM refcount corruption
Message-ID: <20260814084654.22062c9f@phoenix.local>
In-Reply-To: <20260814215107.114582-1-sandeep.penigalapati@intel.com>
References: <20260812220843.75727-1-sandeep.penigalapati@intel.com>
 <20260814215107.114582-1-sandeep.penigalapati@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 14 Aug 2026 17:51:07 -0400
sandeep.penigalapati@intel.com wrote:

> From: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> 
> Shared UMEM is meant to be shared by a limited number of sockets,
> governed by the mempool size (max_xsks). When the UMEM was already at
> capacity (refcnt >= max_xsks), xdp_umem_configure() returned the UMEM
> without incrementing its refcount, so the extra socket used it
> unaccounted for.
> 
> This missing reference has two consequences. During queue setup the
> fill-queue reservation is chosen from the refcount, so the sharing
> socket reserves into its own uninitialised fill queue and crashes. At
> close, the under-counted refcount reaches zero while the UMEM is still
> in use, freeing it early and causing a use-after-free.
> 
> Reject sharing once the UMEM is at capacity by returning NULL, so queue
> setup fails cleanly with -ENOMEM. This applies the per-mempool socket
> limit that shared UMEM was always intended to respect.
> 
> Harden the failure path this makes reachable: clear rxq->umem
> unconditionally when xsk_configure() fails, and skip queues whose UMEM
> is not yet set in get_shared_umem(), so a later scan over the same
> mempool cannot dereference a NULL or dangling UMEM.
> 
> Also document the shared mempool sizing requirement (4096 mbufs per
> socket).
> 
> Note: on stable branches this is a behaviour change. Shared-UMEM setups
> that previously appeared to start, until the fill-queue crash or the
> use-after-free at close, now fail cleanly at Rx queue setup with
> -ENOMEM.
> 
> Fixes: 74b46340e2d4 ("net/af_xdp: support shared UMEM")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
> ---

Looks good, a couple of other minor things from AI review should be addressed.
Yes, this is getting to the "AI bike shedding" stage. So optional

Review of [PATCH v2] net/af_xdp: fix shared UMEM refcount corruption

Re-verified against main (26.11.0-rc0): applies cleanly, net/af_xdp
builds with -Dwerror=true at debugoptimized and minsize, no new lines
over 100 columns.  The v1 findings are all addressed.

Warning:

1. drivers/net/af_xdp/rte_eth_af_xdp.c, get_shared_umem()

   The NULL guard is placed ahead of ctx_exists(), so a queue whose
   setup failed no longer participates in duplicate netdev,qid
   detection.  That is a behaviour change beyond what the commit
   message describes, and the guard only needs to protect the refcnt
   load.  Move it down:

		if (mb_pool == internals->rx_queues[i].mb_pool) {
			if (ctx_exists(rxq, ifname, list_rxq,
					internals->if_name)) {
				ret = -1;
				goto out;
			}
			/* failed setup leaves mb_pool set with no umem */
			if (internals->rx_queues[i].umem == NULL)
				continue;
			if (rte_atomic_load_explicit(...

Info:

2. The capacity log message is three concatenated literals and reads
   long.  Splitting is not needed here -- checkpatches.sh ignores
   LONG_LINE_STRING, and the rest of this file keeps log strings on one
   line -- and the mempool sizing advice is now in af_xdp.rst, so it
   does not have to be repeated at every failure.  Something like:

		AF_XDP_LOG_LINE(ERR, "%s,qid%i: UMEM %s already at max %u sockets",
				internals->if_name, rxq->xsk_queue_idx,
				umem->mb_pool->name, umem->max_xsks);

   cnt is not worth printing: it can only equal or exceed max_xsks at
   this point.  The three-line comment above the check restates the
   commit message and can go to one line or be dropped entirely once
   the message says "already at max".

3. The two new comments use different styles.  The one in
   get_shared_umem() matches the file (/* on its own line); the one in
   xdp_umem_configure() starts text on the opening line.

4. xsk_configure() assigns txq->umem = rxq->umem before the failure
   points, so clearing only rxq->umem leaves rxq->pair->umem pointing
   at a freed or no-longer-referenced UMEM.  Nothing reaches it unless
   an application ignores the queue setup error and starts the port,
   but clearing both together is cheap:

	rxq->umem = NULL;
	txq->umem = NULL;

