Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77A606A33D
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 22:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=odf35n1F
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE4654026F;
	Mon, 16 Nov 2026 23:48:50 +0100 (CET)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 643DF40150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 23:48:48 +0100 (CET)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3b3a914e4c8so353056a91.0
 for <dev@dpdk.org>; Mon, 16 Nov 2026 14:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794869326;
 x=1795474126; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NDoCiIg+tzQX8TdNhQwFNyIcNC/67aWUgGo63Av15bQ=;
 b=odf35n1FNxcvojkKGrFtxguPOu3LmNaXome3QvgXIkOfLa34zXxwn/MeaB/3P8OrXQ
 z+sRlnugORfQbMjafdrmmutXau0SpiWlIBzxvomKz4c5QLubVXrqoaWM56yZYs0FCkeI
 rxO5Sa70IpLVBgf78a2EvAf4+FKgufyM2/hR98iiHNwygxLLPp9qFLFlNs3YFOlJfaK3
 O7CMxsRmy+UiIDu5UggUO1v7FHYmYIytfZ1ytvJTJmVCEl9LzqadiBGFRvETHjwLZ7Kv
 YUz6qYJTtwoY9JL0vdgQTEd6cx0T00jpPQcX+JwQ0D9Q7G0InxsP42sUnXyv1GkqJbXB
 +DwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794869326; x=1795474126;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NDoCiIg+tzQX8TdNhQwFNyIcNC/67aWUgGo63Av15bQ=;
 b=RSTViEQIV0vnOByCw2yboCLuLKmdsQG5YU22E0RSD3mFXzjqGDEBXAz7l7vyLo0fdV
 DI3kWUxfWcvKxRQQcunzMO2K+U52LZyFQY3nbpdGLB8zQ0FmWy06CcsMRiOhIe3SEL5C
 DgC13vSvShQeD1Q+D2ep0gMd9GxEp0FUonqfdQOVGVyzyaec+gh+T/h9CSd91dvD2q8V
 kxIygwM9hZDfDfFtw2xjfyfpGRXuikvE5F61yA+87UEACjRn9Bg0FHZosCny76/qd2nK
 7NRJ895dqmaDqTiyybAOsUhj/94i//yuNsv5WQBFjOx218I56aaV9FtYuTNzqEJhnT+9
 YAhA==
X-Gm-Message-State: APuU4Z8/NZMhcqWgGA8uXPdw7M2Q8mwY6M5+1Gdo85csbF9iWlom6OHS
 mgw/DgoaalMwsHBY8ujm6N9S/kyHh7EkfP0k9fS51O6DSc0A3nHtdNjERjIFA9xxQx4=
X-Gm-Gg: AZFdTZcyjdKchIle+ju6036Wy2r9FSDEOxM4o06XD5TmDyMsLRYP7qcxXgy3N/nheYY
 tjLD0E4DNqK9fsI2I+jjNHXsenkPbwEeyp/8pK+wiw0K2HckQgsJ4GTb8rifBpuM8FThUCxYxdv
 ghhO4Dk6YV2GJz4uIvGon0ANl/fZqMMN1Mmt4mVWHkphMWX9xHJt1AWeB/w9Dz98P1n5gECoRTe
 kJmGBPgQqvMeJ3c8LSmQVTJiA2P0JSkR7NHSWXsE7sJNv7ALZeOpnvgpWYLIbm5NRf3AtKxQkHp
 U2onkC6F3ew0s3Q/Auar7b2/gc+ri7NQGbxED3KCCOOi+tckrdxOueRai1mzrqM3sLcrTQVQOgx
 7M67dkYw1ojzsX3ksX83KOIVlOFCmDV7tO/DEc+lSNj4f2nPXqQ2GSNx8OqbVRRc+1RWwh6fl4h
 58+zSV14MLX0HGel7aSw4qZ0qSq2U45serZAJw8mW6suITJlctLzjPeKVoUTnnyQAFh+bhhtQ2z
 EyYXVKgU5X4bvcvob9VqXRJ2NMmDLSgz5mLR8ofqR1xZSNhh4EvlcBBYHSzzO9d/EUQYy6UUIPK
 aopHNo2ZfySZyjg9WXpVBf6ONeEH43eU0XiwbgG9kzgwugQBjmBxvjLQHrhZf7eKZEFZgI9pRw=
 =
X-Received: by 2002:a17:90a:c105:b0:3b0:9976:c1c6 with SMTP id
 98e67ed59e1d1-3b1b0b8752fmr10986233a91.66.1794869326307; 
 Mon, 16 Nov 2026 14:48:46 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abeb2517sm1015411a91.15.2026.11.16.14.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:48:46 -0800 (PST)
Date: Mon, 16 Nov 2026 14:48:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v4 0/4] DPAA driver changes
Message-ID: <20261116144844.03348c93@phoenix.local>
In-Reply-To: <20261116062512.726405-1-g.singh@nxp.com>
References: <20261103093601.3736486-1-g.singh@nxp.com>
 <20261116062512.726405-1-g.singh@nxp.com>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 11:55:08 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V4-Changes:
>  - Fixed ol_fd leak issue.
>  - Fixed the FQID hold be kernel issue.
>  - removed the not required locks.
>  - fixed unwanted line and memcpy issue.
>  - We want to have rte_pmd_dpaa_ol_* functions, the reason we sent over
>    the email.


Still some findings from AI review

Subject: Re: [PATCH v4 0/4] DPAA offline port, shared MAC name, cgrid cleanup

Series applies to main and builds at every commit (bus/dpaa,
mempool/dpaa, net/dpaa, -Dwerror=true). Patches 1 and 3 have no
findings.


Patch 2/4 drivers: add offline (O/H) port device support
---------------------------------------------------------

Warning: FQ info set in dev_start but only reset in dev_close.

dpaa_ol_dev_start() sends ASK_CTRL_SET_DPDK_INFO on every start;
dpaa_ol_dev_stop() only swaps the Tx burst. After stop the kernel
keeps steering frames into the Rx FQ using buffers from the DPDK
pool, and a stop/start cycle issues a second SET with no RESET in
between. Pair them: reset in stop, set in start.

  static int dpaa_ol_reset_fq_info(struct dpaa_if *dpaa_intf)
  {
          struct ask_ctrl_dpdk_fq_info_s fq_info = { 0 };
          int ret;

          if (!dpaa_intf->ol_fq_info_set)
                  return 0;
          fq_info.tx_fq_id = dpaa_intf->tx_queues[0].fqid;
          fq_info.rx_fq_id = dpaa_intf->rx_queues[0].fqid;
          ret = ask_reset_fq_info(dpaa_intf, &fq_info);
          if (ret == 0)
                  dpaa_intf->ol_fq_info_set = false;
          return ret;
  }

  static int dpaa_ol_dev_stop(struct rte_eth_dev *dev)
  {
          dev->tx_pkt_burst = dpaa_eth_tx_drop_all;
          return dpaa_ol_reset_fq_info(dev->data->dev_private);
  }

dpaa_oldev_queues_release() can then call the same helper.

Warning: received mbufs carry the wrong port id.

dpaa_eth_fd_to_mbuf() sets mbuf->port = dpaa_intf->ifid. ifid is
never set for the offline port, so it stays 0 from rte_zmalloc().
The oldev sorts after all ETH devices on the bus, so port 0 is
always some other port. Set it in dpaa_oldev_init():

  dpaa_intf->ifid = eth_dev->data->port_id;

Info: struct ask_ctrl_dpdk_fq_info_s is an ioctl ABI shared with an
out-of-tree module, but it uses bool members, implicit padding and
no version check. The public rte_pmd_dpaa_*_s structs are passed
straight to the same ioctls, so their layout is now frozen by the
CDX module rather than by DPDK. Consider fixed-width types and a
version query at probe so a mismatched cdx module fails cleanly.


Patch 4/4 drivers: add DPAA cgrid cleanup support
-------------------------------------------------

Warning: stale FQ scan runs at close, after the CGRs have been in
use for the whole run.

If a stale FQ from a previous run still references a CGRID handed
out at probe, it is a member of this port's CGR from the moment
qman_create_cgr() runs; its frames count against the tail-drop
thresholds for the life of the port. Removing it at close is too
late. Do the scan in dpaa_dev_init() right after
qman_alloc_cgrid_range(), before any CGR is created:

  ret = qman_alloc_cgrid_range(&cgrid[0], num_rx_fqs, 1, 0);
  ...
  if (!dpaa_cgr_stale_fq_cleanup(eth_dev, cgrid[0],
                                 num_rx_fqs, "rx")) {
          ret = -EBUSY;
          goto free_rx;
  }

and the same for cgrid_tx. Close then only needs to shut down the
port's own FQs.

Warning: dpaa_cgr_stale_fq_cleanup() returns true when max_loop is
exhausted.

The comment says true means the range was fully scanned. If the
loop runs out after cgrid_num * DPAA_CGR_STALE_FQ_MAX shutdowns,
more stale FQs may remain, yet cgrid_ok stays true and the CGRIDs
are released while still referenced. Fall out of the loop with
false:

          start_fqid = fqid + 1;
  }
  DPAA_PMD_WARN("%s: stale %s FQ limit reached",
                dev->data->name, dir);
  return false;

Info: qman_pending_fq_by_cgrid_range() walks every implemented
FQID with up to two management commands each, and close runs it
twice per port (Rx and Tx). With several ports this is a
noticeable stall on shutdown. If the scan moves to probe as
suggested, one combined pass over all of the port's CGRIDs (Rx
and Tx are both known by then) would halve it.
