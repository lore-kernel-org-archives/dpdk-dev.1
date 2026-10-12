Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B0CA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 22:07:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB5DB40279;
	Tue, 13 Oct 2026 00:07:53 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 57C7B40272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 00:07:52 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-88cfa501c5cso701119b3a.3
 for <dev@dpdk.org>; Mon, 12 Oct 2026 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791842871;
 x=1792447671; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aRJDHV9CY+POtAZZUPj2WKGIsyuaBRYhoLQxa8ao85A=;
 b=e8wLZlzSBE6rZwSIwNyFrQfZlWBmyqqeOBsEk3TNf6tAUdHNygrBGMsc8Oymlsk2Fz
 Q/DFdn/eJAmQp0DUlhLjBme/3RsEV9ZzodkAi4D4PQ6QVvzfZmVKWzykoJeMt5qhYn+Y
 nn+2fqv0YxZGbhSRFlVpx+9+Z8XDheb9lfnVEfwgRiEQ9r2hzHO6rZPTtmni6JP/AgZs
 8wNWghQza1C6UWC6x2ZNOpMIO0e1vHLqur2zlzuz4Uu/5caLCDkgD1T/8b5iZ+y560tH
 EoXkSD1CaE+gKcqBNTtwubPWY77iFLeGtFKr8amoVLrxCi9usu5Y0BcTv8aQgZqL8qjm
 P5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791842871; x=1792447671;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aRJDHV9CY+POtAZZUPj2WKGIsyuaBRYhoLQxa8ao85A=;
 b=G/AaxxyiNNpUlQ/A+Phd3PPTAK0EnQHz7j2Sou8DbgSzgmRR3yICy3I8fEVZHk//zs
 2CvK9UU9TmlZzIsWY5QZOxUFi/dpoo3ENSLJpkNvvfAD1PKl3xb4fKi98E0ZiaMJXyfi
 7sTrInG0nyfpnh9+OrqzsftpmgGJfN4Um/kb35D20nglVJk0UinGh+P0hYHpDFYbTYKd
 3btBz3VofQRgwzHBAZNJFcrcyPlPd1MNrWYVIZE4xp3pFgYsJ5+o6b53dEN7sBIJJ2hS
 JiU/EIbznwxzfwaOWGqg2cSbLy/IfvgYK/nr5qIcXl1s6jiQuXtSCfXr7c9Ibtor92PD
 UQlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxjQLy6PqQfsaHVE14g3tF7VqxTYQoRmUfdKUXoSh39gnVgn0q8fEA5Tf0DXT6jwyLNGc=@dpdk.org
X-Gm-Message-State: AFq9FYLEUdhb2vbehuHiI3CdbiHyrF4Co0qchQui5a9DVNgXB/z1dDUw
 pAc/KIVDKlCrKJw3AGcwhTqoC0NrTdYMJFFwEMIvwMCRk8YPAyQHnvEaxWemcR4Hvd8=
X-Gm-Gg: AYBFou2tNNfO0z6xAygVlYpmpcwogkv96csPcLU3Ty83jHS0Ay9XiEpfeuFom9FWREG
 dPRt7hq+HUg9QoRoiA5qEsDVGK9jetMFQsILnvLAWqlBZZV+kEGX9tThMM08tuC7jJE34CA7Y29
 aDvowMsFBXom7XhojrdWA+wZbuj1SsdXS/gItXLjdnV85S5Ajh7pA1gzjSxsybigxRiVULtaeVi
 eenP8oBIz6XD8bCPPQfIwc+FmXPahUv6Vuo2ka/hMO8Uwebu6MQeO+5++bnKgfbmxOaCkHUVYb7
 BhEn9DgmRU8TtdSrgsCpd1H96jZJAtRfNB4T8AtifX+ucJbuWP1g6NMmVbb4KY97pzxbAkrhfSq
 74Oi96iFEteiRRBQOaggei0FRcTdXsOL57r3gdQhx0iNQWkvUkbe/oU3Pdss8/egHCfrY0gbXd6
 y9DLfyVaqyZlSgI1haBv8LdVomaGz+toNTItETy5COmIaD7XlrsuaXVgNozuNVUWCWodwF3SYtM
 UrJhn2NERo3poxGOarQb0G/Rb9CdhC5rgnUbLsvNLuT/32pD7o=
X-Received: by 2002:a05:6a00:4fcd:b0:888:402c:b95c with SMTP id
 d2e1a72fcca58-897c7cd601bmr11482713b3a.52.1791842871157; 
 Mon, 12 Oct 2026 15:07:51 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c43ad3ccsm4127042b3a.47.2026.10.12.15.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:07:50 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:07:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v24 00/27] NXP DPAA driver enhancements and fixes
Message-ID: <20261012150748.3b54dd26@phoenix.local>
In-Reply-To: <20261012080845.2325199-1-hemant.agrawal@nxp.com>
References: <20261009091101.1703494-1-hemant.agrawal@nxp.com>
 <20261012080845.2325199-1-hemant.agrawal@nxp.com>
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

On Mon, 12 Oct 2026 13:38:18 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
> 
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue and congestion-group
> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> handling, and several new features: offline (O/H) port device support,
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration via devargs, Rx/Tx taildrop threshold devargs, non
> fmX-macY shared Ethernet naming, and DMA scatter-gather and
> errata-workaround devargs. Documentation and release notes are updated
> accordingly.
> 
> v24:
> * fix clang 23 compilation
 
Still lots of open issues from AI review.

Review of [PATCH v24 01/27..27/27] DPAA bus/net/mempool/dma/crypto

The series applies to main (693eeab) and every commit builds with
-Dwerror=true for bus/dpaa, mempool/dpaa, net/dpaa, dma/dpaa and
crypto/dpaa_sec.

Series level
------------

New per-driver devargs keep getting added where ethdev already has the
knob. drv_rx_taildrop is already overridden by nb_rx_desc (see 19);
Tx should take its threshold from nb_tx_desc the same way. A DPAA port
should not need different command line options than every other PMD
to control queue depth.

The offline port API in 25 is an ioctl pass-through to an out-of-tree
kernel module (/dev/cdx_ctrl) carrying application specific GTP and
local-gateway configuration. That belongs in the application or the
vendor SDK, not in a DPDK installed header. If it stays, it needs a
real justification in the commit message, proper namespacing, docs
and a test.


[PATCH v24 11/27] drivers: add DPAA cgrid cleanup support

Error: CGRIDs are released while the port's own FQs still reference
them.

dpaa_eth_dev_close() does not retire the port's Rx/Tx FQs before the
CGR teardown, so they are still scheduled with CGE set and a cgid in
range. dpaa_cgr_stale_fq_cleanup() therefore finds this port's own
queues, not leftovers from a previous run, and retires them with
qman_shutdown_fq_by_fqid(), i.e. on the affine portal. A push mode Rx
FQ is scheduled on its own portal's dedicated channel (rxq->ch_id); if
frames are queued the retire goes PENDING and patch 12 returns -EBUSY.
A Tx FQ with frames pending hits the DCP channel case, also -EBUSY.
The loop breaks and then, unconditionally:

	qman_release_cgrid_range(dpaa_intf->cgr_rx[0].cgrid,
				 dpaa_intf->nb_rx_queues);

returns the CGRID to the allocator while an FQ still points at it; the
next port probed can get the same ID. The probe error path has the
same problem: Rx FQs already passed to qman_init_fq() with that cgid
are left in place while free_rx releases the range. Before this patch
the IDs leaked, which was the safe failure.

qman_delete_cgr() can also fail (-EINVAL when called from a different
portal than the creator, without unlinking the node); the range is
released anyway.

Retire the port's own queues by descriptor first (patch 10 made
qman_shutdown_fq() use fq->qp, which is what push mode needs), and
only return the IDs when everything came down cleanly:

	bool clean = true;

	for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++)
		if (qman_shutdown_fq(&dpaa_intf->rx_queues[loop]) != 0)
			clean = false;

	dpaa_cgr_stale_fq_cleanup(...);	/* real leftovers only */

	for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++)
		if (qman_delete_cgr(&dpaa_intf->cgr_rx[loop]) != 0)
			clean = false;
	if (clean)
		qman_release_cgrid_range(dpaa_intf->cgr_rx[0].cgrid,
					 dpaa_intf->nb_rx_queues);

Same for Tx, and the same rule on the free_tx/free_rx probe path.


[PATCH v24 19/27] net/dpaa: support Rx/Tx taildrop threshold devarg

Warning: drv_rx_taildrop does not do what dpaa.rst says.
dpaa_eth_rx_queue_setup() already sets the CGR threshold from the ring
size:

	qm_cgr_cs_thres_set64(&cgr_opts.cgr.cs_thres, nb_desc, 0);
	ret = qman_modify_cgr(&dpaa_intf->cgr_rx[queue_idx], 0, &cgr_opts);

so any non-zero drv_rx_taildrop is replaced by nb_rx_desc at queue
setup. The only visible effect is that =0 skips CGR creation. Drop
drv_rx_taildrop.

For Tx, dpaa_eth_tx_queue_setup() has nb_desc marked __rte_unused. Use
it the same way as Rx (qman_modify_cgr() on cgr_tx with nb_desc) and
drop drv_tx_taildrop along with the DPAA_TX_TAILDROP_THRESHOLD
getenv(). NAK on the devargs as posted.


[PATCH v24 24/27] net/dpaa: enhance VSP port support

Warning: the shared-MAC base profile is no longer exempt from the
one-pool-per-VSP check. dpaa_eth_rx_queue_setup() stores the pool
before calling dpaa_port_vsp_update():

	dpaa_intf->vsp[vsp_id].vsp_bp[0] = DPAA_MEMPOOL_TO_POOL_INFO(mp);
	dpaa_intf->vsp[vsp_id].bp_num = 1;

and the shared base profile early return only clears bp_num, leaving
vsp_bp[0] set. Previously that case set vsp_bpid to 0, so
dpaa_eth_rx_queue_bp_check() let a second queue on that profile use a
different mempool; now it fails with "Various MPs are assigned". Test
bp_num in the check:

	if (dpaa_intf->vsp[vsp_id].bp_num != 0 &&
	    bpid != dpaa_intf->vsp[vsp_id].vsp_bp[0]->bpid)


[PATCH v24 25/27] drivers: add offline (O/H) port device support

Error: NULL dereference on the first Tx burst. dpaa_oldev_init() sets
the back pointer only on the Rx FQ:

	dpaa_intf->rx_queues[0].dpaa_intf = dpaa_intf;

dpaa_ol_dev_start() installs dpaa_eth_queue_tx(), which does

	struct dpaa_if *dpaa_intf = fq->dpaa_intf;
	...
	if (unlikely(dpaa_intf->ts_enable)) {

and tx_queues[0].dpaa_intf is NULL from rte_zmalloc(). Add

	dpaa_intf->tx_queues[0].dpaa_intf = dpaa_intf;

after dpaa_ol_tx_queue_init(). Multi-segment Tx also allocates from
dpaa_tx_sg_pool, which only net_dpaa probe creates; with drv_oldev and
no fmX-macY port allowed it is NULL.

Warning: rte_pmd_dpaa_oldev.h is installed but exports unprefixed
names: struct dpa_ip_addr_s, dpa_ip_pair_s, dpa_lgw_subnet_s and the
DPA_ISC_*, DPDK_OLDEV_*, DPDK_CLASSIF_*, DPDK_TELECOM_* macros. All
need an rte_pmd_dpaa_ / RTE_PMD_DPAA_ prefix. The structs and flags
have no Doxygen, and the four new functions have no test or testpmd
hook.

Warning: drv_oldev as a bus devarg means any user of the offline port
must also list every Ethernet port with -a, since a bus argument flips
the bus to allowlist scan (the doc spells this out). Create the device
when /dev/cdx_ctrl exists instead and drop the devarg.

Info: rte_dpaa_bus_dev_build() now continues with dpaa_netcfg NULL
when drv_oldev is set, but under RTE_LIBRTE_DPAA_DEBUG_DRIVER

	dump_netcfg(dpaa_netcfg, stdout);

dereferences it.


[PATCH v24 08/27] bus/dpaa: scan max BPID from DTS

Info: the commit message says it updates "the default BMAN HW version
for Layerscape devices"; the code removes version detection. It also
makes bman_global_init() fail when the fsl,bman node is missing or
bman_init_ccsr() fails, where it only logged before. Say so.


[PATCH v24 18/27] dma/dpaa: add devargs for SG and errata workaround

Info: dpaa_dma_data_validation and dpaa_dma_sg_disable are documented
as debugging aids. Debug knobs do not need to be stable user facing
devargs; keep validation under RTE_LIBRTE_DPAA_DEBUG_DRIVER or a log
level instead.


[PATCH v24 20/27] net/dpaa: support fmcless rxq number as devarg

Info: with the default now creating DPAA_MAX_NUM_PCD_QUEUES FQs, the
application already picks how many it uses with nb_rx_queues at
configure. drv_fmcless_rxq only trims resources; consider dropping it.


[PATCH v24 21/27] net/dpaa: support non fmX-macY type of shared ...

Info: rather than having the user supply the kernel interface name,
the driver can look up the netdev bound to the same MAC node in sysfs.
That removes the devarg and works after udev renames.


[PATCH v24 22/27] bus/dpaa: optimize DPAA multi-entry buffer pool ...

Info: the comment and commit message say entry 0 is written separately
to avoid the valid bit, but

	r->bufs[0].opaque = bm_bufs[0].opaque;

stores byte 0, which is __dont_write_directly__verb. It is harmless
(bm_rcr_start() zeroed the line and bm_rcr_pvb_commit() writes the
verb last), but then the split is no different from one memcpy().
Either write only bpid/hi/lo for entry 0, as the kernel does, or drop
the claim. bm_buffer_get64_from_be() should be a static inline, not a
statement-expression macro.


[PATCH v24 01/27] net/dpaa: fix double close and null deref on remove

Info, pre-existing: rte_dpaa_remove() frees dpaa_tx_sg_pool without
clearing it:

	rte_mempool_free(dpaa_tx_sg_pool);

A later probe (hotplug after the last remove) sees a non-NULL pointer
in rte_dpaa_probe() and uses the freed pool. Set it to NULL.

Review-Result: ERROR
