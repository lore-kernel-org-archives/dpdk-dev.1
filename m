Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFDE606A324
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=S5wI/3Cu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 563B440151;
	Wed, 28 Oct 2026 15:41:15 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 4D2A5400D7
 for <dev@dpdk.org>; Wed, 28 Oct 2026 15:41:14 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so941933a91.0
 for <dev@dpdk.org>; Wed, 28 Oct 2026 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793198473;
 x=1793803273; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=83btXWShitokmA5eeEwbzE/8f716E4zFeSMpYljv3qU=;
 b=S5wI/3CukvwDLjOqG9k3EYXweeBrxTwWVxetlI330Dt0WX83XXvarhWNdr2/rvZAXe
 nDwcFFTluajvjwK3FdIFBz5n/K0370eKltHRDcH9caTHoeNWhUxQUk2tqGHvGbpVkQDj
 n+w9OEyHHu3I6QFdUDFvp3lzPpZL8xFsq54wo9xiamH1eaeFHeEw1CxFcPZTet5FmQW4
 TNrCEMDaTVde9q5/UbmaYzTsnFJ4TnVRcdElXtdVH2oyW3kfNzI/y46OixTuZA+lzqQ4
 WfN7+/PMLRWpUZQKdAh2l8i6gGkTU/8AdpMHQkCwAYcveTGnSMSzs34muQPWYbUI7j3G
 RmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793198473; x=1793803273;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=83btXWShitokmA5eeEwbzE/8f716E4zFeSMpYljv3qU=;
 b=bt//jINRNlUfzvmjeS31dWwjhLjh5LAEElA5WPxHbGvm67mROgtxy1Bw5+fGMuj1ba
 O+SECMjagRWzY8AXCM+RqW93fP+P1za+yzvoIXGj0teMbkSmYUeTgD17jYVPKnByNkxg
 pZd8WURRuS2PVbF4gQVJohJb/wSWtzeWP+9hxyNNo8fcHD5JomuvpPD9QXhLQ4JbIBnT
 LLnz58GNxIZ98V4ZITAQSDekXgarGK2k2X0C+tZ64cwONF/iGjLUeHlD8cl39zX6vHly
 u2/4ajttNpIVYzruT9UkYjU36ApVmsMVNvqrj6IiVEcJVG3QtKSPUnfwOE+q/G37jhca
 BrBA==
X-Gm-Message-State: AFq9FYLyYp4yzvEFeh7njNIj0vlJ2H/x783ZHz9zWI5NiRpIeOhLwnEs
 WzSuJCLHq9ZJ8rq68n6OylBMq/yCuuzGp8hLG7mOseCQvyaLNINW/w2uh6Vw5HskDP0=
X-Gm-Gg: AYBFou1ky9ytzeWSACeNFFw2uqAWdTxwzv0Xcu2fXkX4nn+W7OprMpkttxNHVGYQDFs
 nwJV87Cq10DJKBdOG0FTaEnDxuUdBcGRslzDa536plVny/JY3dd+VGE781I+ev1jX6nAUpG0QR/
 eTfNvhjY7KzuKa1QCX8QAum/dx51Av/ccO010Wyna4hb/2qwviiwZndptqiuAKeX/J3fBHKKYX/
 +dmP8+HI7/E1s/9ctG6sbU+cvicqcdlCffewE50wQBWnqqUwssW5jz4hcQwBxs6pj+TGQ4oNAVL
 h9154wM5Dlm+CSb41Phze3KXQCWNJyj517J5ZSlTqrsGqVm9O5P8GqYW9296gE6OmO5MAdnzmPU
 2Hq7da+JGPHFLz+dt8KWBR80MmXHupccAJtogFp0IE0i+sc4KxDADlRb/Y4LQgVsqYvI24L+Gip
 GdZjJ3IgzoPCJVku+m+EksTatOqV2NAsh2mwBX2bhRjH8oZpJqwcRAtoPh3cLYC+E6ZuifTgBGK
 iu0NfGYrEJ9TJFMksDCF5VVdv0my74nJPp96HTxyNDlspE7Fg9qsyBFdpTv4a4JmSAmRPvqhTZx
 oyHlKgyYTNqZOyfASL8ceIicedQvXtaCVKyOyrxRO2MYwtwSLyDlC5iN6Fw7PyLIRc4mS85u
X-Received: by 2002:a17:90b:2f4f:b0:3ab:f2a9:cacd with SMTP id
 98e67ed59e1d1-3ae5830812cmr1998009a91.49.1793198472610; 
 Wed, 28 Oct 2026 07:41:12 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a9f286fsm3354532a91.15.2026.10.28.07.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:41:12 -0700 (PDT)
Date: Wed, 28 Oct 2026 07:41:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v1 0/3] DPAA driver changes
Message-ID: <20261028074110.4d3b901f@phoenix.local>
In-Reply-To: <20261028085517.705621-1-g.singh@nxp.com>
References: <20261028085517.705621-1-g.singh@nxp.com>
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

On Wed, 28 Oct 2026 14:25:14 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

>  - Adding OH port support.
>  - Updates in shared ethernet code.
>  - Congestion related code cleanup.
> 
> Gagandeep Singh (1):
>   drivers: add offline (O/H) port device support
> 
> Hemant Agrawal (1):
>   net/dpaa: support non fmX-macY type of shared Ethernet name
> 
> Jun Yang (1):
>   drivers: add DPAA cgrid cleanup support
> 
>  doc/api/doxy-api-index.md                |   1 +
>  doc/guides/nics/dpaa.rst                 |  32 +
>  drivers/bus/dpaa/base/fman/fman.c        |  19 +
>  drivers/bus/dpaa/base/qbman/qman.c       |  61 ++
>  drivers/bus/dpaa/bus_dpaa_driver.h       |   4 +-
>  drivers/bus/dpaa/dpaa_bus.c              | 100 ++-
>  drivers/bus/dpaa/dpaa_bus_base_symbols.c |   2 +
>  drivers/bus/dpaa/include/fman.h          |   6 +-
>  drivers/bus/dpaa/include/fsl_qman.h      |  28 +
>  drivers/net/dpaa/dpaa_ethdev.c           | 176 ++++-
>  drivers/net/dpaa/dpaa_ethdev.h           |   3 +
>  drivers/net/dpaa/dpaa_flow.c             |   7 +-
>  drivers/net/dpaa/dpaa_oldev.c            | 875 +++++++++++++++++++++++
>  drivers/net/dpaa/meson.build             |  11 +-
>  drivers/net/dpaa/rte_pmd_dpaa_oldev.h    | 158 ++++
>  15 files changed, 1454 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/net/dpaa/dpaa_oldev.c
>  create

AI review found issues. The biggest one is carrying vendor private
ioctl data structures in DPDK.

Review of [PATCH v1 0/3] DPAA offline port, shared MAC, cgrid cleanup

Series
------

The rte_pmd_dpaa_ol_* functions do not operate on a DPDK port. They
take no port_id and only forward a caller-filled struct to an
out-of-tree kernel driver through ioctl() on /dev/cdx_ctrl. That puts
a vendor kernel ioctl ABI (GTP classification, "telecom application"
flags) into an installed DPDK header under DPDK API/ABI rules. An
application can issue these ioctls itself; this belongs in the vendor
userspace library for that kernel module, not in DPDK. Please drop
rte_pmd_dpaa_oldev.h and the four exported functions.

The drv_oldev bus argument is redundant. The offline port is only
probed if "-a dpaa_bus:oldev1" is given anyway, so create the oldev1
device when its devargs exist and drop drv_oldev, the bus_str parsing,
and the allowlist caveats in dpaa.rst:

	if (rte_bus_find_devargs(&rte_dpaa_bus, "oldev1") != NULL) {
		/* create oldev1 */
	}

No release notes for the new port type. dpaa.rst does not say the
offline port needs the /dev/cdx_ctrl kernel driver or where to get it.


Patch 1/3 drivers: add offline (O/H) port device support
--------------------------------------------------------

Error

dpaa_oldev_init() never sets tx_queues[0].dpaa_intf, and the queue
array comes from rte_zmalloc(), so it is NULL. dpaa_eth_queue_tx()
starts with:

	struct dpaa_if *dpaa_intf = fq->dpaa_intf;
	...
	if (unlikely(dpaa_intf->ts_enable)) {

so the first Tx burst after dev_start dereferences NULL. Set it after
the Tx FQ is initialised:

	ret = dpaa_ol_tx_queue_init(&dpaa_intf->tx_queues[0], 0);
	if (ret)
		goto free_rx;
	dpaa_intf->tx_queues[0].dpaa_intf = dpaa_intf;

Warning

rte_kvargs_count() only tests for presence, so "drv_oldev=0" enables
the offline port. Moot if drv_oldev is removed as above; otherwise
parse the value with rte_kvargs_process().

dev_close() shuts down the Rx/Tx FQs and returns their FQIDs to the
allocator, but the kernel was given those FQIDs and the bpid through
ASK_CTRL_SET_DPDK_INFO and is never told they are gone. The next
qman_alloc_fqid() user can receive frames the kernel enqueues to a
reused FQID. The kernel side needs a reset ioctl issued before the
FQIDs are released.

The cell-index range checks in fman_if_init() and fman_if_init_onic()
fix an out-of-bounds read of mac_idx[] and have nothing to do with the
offline port. The commit message does not mention them, nor the
MEMMAC_REG_OFFSET removal. Split the bounds checks into their own patch
with:

	Fixes: a0edbb8a8e52 ("bus/dpaa: add OH port mode")
	Fixes: 7e5f49ae767d ("bus/dpaa: add ONIC port mode")
	Cc: stable@dpdk.org

drv_bh_port is required, but it is parsed on every dev_start() with a
NULL key list, so a misspelled key is accepted at probe and the port
only fails at start. Parse it once in dpaa_ol_probe() with a valid key
list, store it in the private data, and fail probe if it is missing.

If rte_pmd_dpaa_oldev.h stays, the installed header defines DPA_ISC_*,
DPDK_OLDEV_*, DPDK_CLASSIF_*, DPDK_TELECOM_* and struct dpa_* without
an RTE_/rte_ prefix, and none of the structs or fields have Doxygen.

Info

dpaa_ol_rx_queue_setup() checks queue_idx against nb_rx_queues; ethdev
already does that before calling the PMD.

open(ASK_PATH, O_RDWR) should use O_RDWR | O_CLOEXEC.

In dpaa_create_device_list(), use snprintf() rather than sprintf(), and
drop the memset() after calloc() and the "int i = 0" initialiser.

rte_dpaa_bus_dev_build() gates the num_ethports messages on
oldev_enabled; the condition that matters is dpaa_netcfg != NULL.

The dpaa_bus_parse_bus_args() comment refers to a previous
environment-variable configuration that never existed upstream. The
bh_port_name field comment says "for testing purpose" but the field is
mandatory.


Patch 2/3 net/dpaa: support non fmX-macY type of shared Ethernet name
---------------------------------------------------------------------

Warning

Platform devices created from device-tree nodes without a reg property
are named after the whole parent chain, which is why dpaa_bus.c uses
"/sys/devices/platform/soc/soc:fsl,dpaa". A dpa-ethernet child of that
node is not "ethernet@N" under /sys/bus/platform/devices, so

	node = strrchr(node_path, '/');
	...
	"/sys/bus/platform/devices/%s/net", node

misses and silently falls back to the port name, which is the case the
patch is meant to fix. Match on the netdev's of_node instead:

	/* for each /sys/class/net/<if> */
	snprintf(path, sizeof(path), "/sys/class/net/%s/device/of_node",
		 ifname);
	if (realpath(path, resolved) != NULL &&
	    strcmp(resolved + strlen("/sys/firmware/devicetree/base"),
		   node_path) == 0)
		/* found */

Info

The new dpaa.rst bullet lands at the end of the bus devargs block; it
belongs with the shared MAC description.


Patch 3/3 drivers: add DPAA cgrid cleanup support
-------------------------------------------------

Warning

This fixes a CGRID leak on close and a stale portal list entry on probe
failure, but has no Fixes: tag or stable Cc:

	Fixes: 62f53995caaf ("net/dpaa: add frame count based tail drop with CGR")
	Fixes: 9124e65dd3eb ("net/dpaa: enable Tx queue taildrop")
	Cc: stable@dpdk.org

On the probe error path the initialised Rx FQs (and Tx FQs on free_tx)
were scheduled with QM_FQCTRL_CGE and their cgid, and are never shut
down before

	for (loop = 0; loop < nb_rx_cgr; loop++)
		qman_delete_cgr(&dpaa_intf->cgr_rx[loop]);
	if (rx_cgrid_allocated)
		qman_release_cgrid_range(cgrid[0], num_rx_fqs);

That deletes CGRs that still have members, which the commit message
says must not happen, and hands the CGRIDs to the next probe while live
FQs reference them. Shut down the FQs initialised so far before
deleting the CGRs.

dev_close() releases the CGRID range unconditionally, even when
dpaa_cgr_stale_fq_cleanup() hit an FQ that would not shut down or
qman_delete_cgr() failed. 1/3 deliberately leaks FQIDs in that case;
do the same here and skip qman_release_cgrid_range() if any delete or
shutdown failed.

dpaa_eth_dev_stop() and dpaa_eth_dev_close() never shut down the
port's own Rx/Tx FQs, so the FQs dpaa_cgr_stale_fq_cleanup() finds at
close are this port's live queues, not ones "not cleaned in previous
program". The driver already holds their FQIDs. Shut them down directly
before deleting the CGRs, drop the FQID space scan, and with it the new
qman_pending_fq_by_cgrid_range() export:

	for (loop = 0; loop < dpaa_intf->nb_rx_queues; loop++)
		qman_shutdown_fq(&dpaa_intf->rx_queues[loop]);
	for (loop = 0; loop < MAX_DPAA_CORES; loop++)
		qman_shutdown_fq(&dpaa_intf->tx_queues[loop]);

The existing "Release congestion Groups after releasing FQIDs" comment
is then true.

Info

cgrid is u32; use %u, not %d, in the DPAA_PMD_DEBUG/WARN calls.
