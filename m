Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CD6C624D6
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 14:13:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31761402DE;
	Wed,  2 Sep 2026 16:13:25 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id D2D0A40262
 for <dev@dpdk.org>; Wed,  2 Sep 2026 16:13:23 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d944747d41so12576395ad.0
 for <dev@dpdk.org>; Wed, 02 Sep 2026 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788358403;
 x=1788963203; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qpoDlEChTiBWRzGfjUEY7JQeSAhwfe91g4W3j971Amw=;
 b=NUdh0zBplKlbvu15LnS6XB3rf8WnfpOPBvCUpZxyLRuV4kAWfmd3sxJws6MUociM40
 ZSJsmGR2yJUsja1PkmLffSjs82Z0R1aZNuf+OeOFklWOI3Zd8qQMOs4e+i/OH5V6dAtK
 wvrdTy+Qpvbek5dS/N9CLeKk6PUicCFuVuGM1UoDRVMnhb7txm5rhBcuQtIL3hPuk6tu
 o6oO4aWlrOEF8GSGCSYwh2N1vN1er1rt358p8ctWkVEPFcEB/xnamR3cdk7DxBHx1i5C
 z8oVyyu42L1iZwh2DMu0fNWClK9cucJFAgNTpCLkYWgK7ro93+iSnbqP/nHAFWaIuj8h
 EUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358403; x=1788963203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qpoDlEChTiBWRzGfjUEY7JQeSAhwfe91g4W3j971Amw=;
 b=WCaY2w4KHwANB5+EQXgKN5kAKhGo2qAmo20A2nk5sxP7OtqSz741sre6E/Bf2mdx7a
 k4zNbCb9Rk8f7sHmj0po70U2nqYfj2kpvtKzmVL7VuBxXu0Y+apoLVcWI04bJSMA69h4
 YhKrf7BfH/Mk2A5atS9duaccRhc2SoviBZh7rQSqLDA4LYXPcaCzWaWF172jAMyy2Htj
 hiyifZTLBR/J2Ptj/1rA5zsrQiWM0KM90is6xUE7WY1GBiNQmLHHm/ePGZbUxctQbQau
 0C5XNBD8csOlAuJTtCtEckYfSlN3k7sf2H3wvTcLdh1Us0ksklWyrOM5SmVtPpD0aENS
 hU2g==
X-Gm-Message-State: AFuF++k+Ah6E+w05QAd9/o8mhzJ+7Q2PORe7APfac1IcU6mzRvwtBrIB
 rJFz9y/vCWDTJybRuDMiHQWlJR7VqhahRvd3ZD5agNfdstGyN48cvTE+F0LAWjJ5dmo=
X-Gm-Gg: AYBFou1cQtKABS4TqqIb/S+M98wKrfqJsRhtIrzQZzBlYledmV11fZFolcD+5Thgtaj
 HawsspHd6qLvfayCkT7k0pCJZD64warLAjpUKuE55cY2O+uM5KV73hT8lHChzML1gFtEAWttqhz
 rCIPc6gYJliXiQK1v2+IdwMDi3x3Ah8rls7sNlS9M3PgsNI8tpvFEgP6E2o32qz4KLhiHBuiRU1
 aaxVEiT2JoXCshDYnI5ALyPJUgRX0/QQmuYrEK2OoOaDO6ilVwey0+A6HBCL6P1xPlL4jHTQSqL
 XWcG2VIEkklaifErps1F06MmGBtXxHlxswmJZMhvPWFu2n5Fgx019Utkrw+x9KYYBOyZcV2MpXl
 9itzLnfMDAzns7WDGVNqdj2NS1I+mgLrP4nho5gdrcMSqZqFvpWGyU07cIAgmmDHBIeFE1hzDgq
 IRa2SyqP40pR5ymmkXwCcGDZ1fbo3b/85xrln92eWAmtMprqVUU6u/iyb+aaBfPvRf++1C351Bh
 5VI8SqWpgmo9zAifdIT/Afg3Mbwcw==
X-Received: by 2002:a17:902:f641:b0:2d8:d4ce:7e3b with SMTP id
 d9443c01a7336-2daec710639mr80492605ad.16.1788358402495; 
 Wed, 02 Sep 2026 07:13:22 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd4893e2sm13857965ad.40.2026.09.02.07.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:13:22 -0700 (PDT)
Date: Wed, 2 Sep 2026 07:13:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rajesh Kumar <rajesh3.kumar@intel.com>
Cc: dev@dpdk.org, thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, aman.deep.singh@intel.com
Subject: Re: [RFC PATCH v4 1/3] ethdev: add Tx timestamp slot management APIs
Message-ID: <20260902071311.5e28db7d@phoenix.local>
In-Reply-To: <20260902055125.836268-2-rajesh3.kumar@intel.com>
References: <20260827122200.339388-2-rajesh3.kumar@intel.com>
 <20260902055125.836268-1-rajesh3.kumar@intel.com>
 <20260902055125.836268-2-rajesh3.kumar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed,  2 Sep 2026 11:21:22 +0530
Rajesh Kumar <rajesh3.kumar@intel.com> wrote:

> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_slot_alloc,=
 26.11)
> +int
> +rte_eth_timesync_tx_timestamp_slot_alloc(uint16_t port_id,
> +					 uint32_t *slot_id)

Could join to one line, max line line is now 100

> +{
> +	struct rte_eth_dev *dev;
> +
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +	dev =3D &rte_eth_devices[port_id];
> +
> +	if (slot_id =3D=3D NULL) {
> +		RTE_ETHDEV_LOG_LINE(ERR,
> +			"Cannot allocate ethdev port %u Tx timestamp slot to NULL",
> +			port_id);

Minor nit the wording of that error message is awkward.
Similar problem in other messages.

> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_dynfield_registe=
r, 26.11)
> +int
> +rte_eth_timesync_tx_slot_dynfield_register(void)
> +{
> +	const struct rte_mbuf_dynfield slot_dynfield =3D {
> +		.name  =3D RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME,
> +		.size  =3D sizeof(uint32_t),
> +		.align =3D alignof(uint32_t),
> +	};
> +	uint16_t port_id;
> +
> +	if (rte_eth_timesync_tx_slot_dynfield_offset >=3D 0)
> +		return 0;
> +
> +	rte_eth_timesync_tx_slot_dynfield_offset =3D
> +			rte_mbuf_dynfield_register(&slot_dynfield);
> +	if (rte_eth_timesync_tx_slot_dynfield_offset < 0)
> +		rte_eth_timesync_tx_slot_dynfield_offset =3D
> +				rte_mbuf_dynfield_lookup(
> +					RTE_ETH_TIMESYNC_TX_SLOT_DYNFIELD_NAME, NULL);
> +	if (rte_eth_timesync_tx_slot_dynfield_offset < 0)
> +		return -ENOTSUP;
> +
> +	{
> +		int flag_bit =3D rte_mbuf_dynflag_register(
> +			&(const struct rte_mbuf_dynflag){
> +				.name =3D RTE_ETH_TIMESYNC_TX_SLOT_DYNFLAG_NAME});
> +		if (flag_bit < 0)
> +			flag_bit =3D rte_mbuf_dynflag_lookup(
> +				RTE_ETH_TIMESYNC_TX_SLOT_DYNFLAG_NAME, NULL);
> +		if (flag_bit < 0)
> +			return -ENOTSUP;
> +		rte_eth_timesync_tx_slot_dynflag =3D RTE_BIT64(flag_bit);
> +	}

No need for basic block {} here.

> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_dynfield_unregis=
ter, 26.11)
> +int
> +rte_eth_timesync_tx_slot_dynfield_unregister(void)
> +{
> +	uint16_t port_id;
> +
> +	/* Reset cached state without freeing dynamic-field bytes. */
> +	rte_eth_timesync_tx_slot_dynfield_offset =3D -1;
> +	rte_eth_timesync_tx_slot_dynflag =3D 0;
> +
> +	RTE_ETH_FOREACH_VALID_DEV(port_id)
> +		eth_timesync_tx_slot_info_refresh(port_id);
> +
> +	return 0;
> +}
> +

If it always returns 0 why not void.
Not sure what the point of this function is. It doesn't really do anything.

> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_timestamp_stamp_mbuf,=
 26.11)
> +int
> +rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id,
> +						 uint32_t slot_id, struct rte_mbuf *m)
> +{
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +	if (m =3D=3D NULL)
> +		return -EINVAL;
> +	if (rte_eth_timesync_tx_slot_dynfield_register() !=3D 0)
> +		return -ENOTSUP;
> +	*RTE_MBUF_DYNFIELD(m, rte_eth_timesync_tx_slot_dynfield_offset,
> +			   uint32_t *) =3D slot_id;
> +	m->ol_flags |=3D rte_eth_timesync_tx_slot_dynflag;
> +	return 0;
> +}

This is possibly in data path, use unlikely() here.


> diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
> index ee400b386f..bde391dea4 100644
> --- a/lib/ethdev/rte_ethdev.h
> +++ b/lib/ethdev/rte_ethdev.h
> @@ -5513,6 +5513,19 @@ int rte_eth_timesync_read_rx_timestamp(uint16_t po=
rt_id,
>  /**
>   * Read an IEEE1588/802.1AS Tx timestamp from an Ethernet device.
>   *
> + * This is the legacy Tx timestamp API and is intended for register-based
> + * timestamp reads. It does not provide per-packet correlation.
> + *

Rather than weak guidance which will get ignored and stale.
  1. Convert all in-tree uses of old API
  2. Announce deprecation in this release
  3. Mark legacy API as deprecated

AI had even more observations (Fable 5.1)

> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_timesync_tx_slot_infos, 26.11)
> +struct rte_eth_timesync_tx_slot_info
> +rte_eth_timesync_tx_slot_infos[RTE_MAX_ETHPORTS];

Exporting a RTE_MAX_ETHPORTS sized array from the public header bakes
build config into ABI. rte_eth_fp_ops lives in ethdev_driver.h, this
should too; only PMDs read it.

The per-port array also has no per-port content. offset and dynflag are
process globals; the only per-port part is "caps say PER_PACKET". Put
the two globals in ethdev_driver.h and let the PMD that implements
slots check them. Drops the array, the refresh loop, and the forward
declaration.

> +static void eth_timesync_tx_slot_info_refresh(uint16_t port_id);

Move the definitions above first use instead.

> +	ret =3D eth_err(port_id, dev->dev_ops->timesync_enable(dev));
> +	if (ret =3D=3D 0)
> +		eth_timesync_tx_slot_info_refresh(port_id);

No matching reset in timesync_disable. Info stays stale after disable.

> +int
> +rte_eth_timesync_tx_timestamp_stamp_mbuf(uint16_t port_id,
> +						 uint32_t slot_id, struct rte_mbuf *m)
> +{
> +	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
> +	if (m =3D=3D NULL)
> +		return -EINVAL;
> +	if (rte_eth_timesync_tx_slot_dynfield_register() !=3D 0)
> +		return -ENOTSUP;

Calling register from the per-packet path is wrong. First call takes
the mbuf dyn lock and walks every port calling into driver dev_ops.
Header says "safe for concurrent callers"; it is not, two threads
racing on first stamp both run registration on plain globals.

port_id is validated but otherwise unused. Stamping a SINGLE_REG port
succeeds and sets a flag nothing reads. Check the port's slot info,
return -ENOTSUP if dynflag =3D=3D 0, and require the app to have called
register up front (which the doc already says it must, before pool
create).

> +	rte_eth_timesync_tx_slot_dynfield_offset =3D -1;
> +	rte_eth_timesync_tx_slot_dynflag =3D 0;

Written unlocked, read from Tx datapath on other cores. Also cannot
free the dynfield. Agree with dropping unregister entirely.

> + * -ENOTSUP and the PMD TX path falls back to the port-level ptp_tx_index
> + * (legacy mode) on every port.

ptp_tx_index is an Intel driver internal. Does not belong in rte_ethdev.h.

> + * The underlying DPDK dynfield bytes are NOT freed =E2=80=94 DPDK provi=
des no dynfield

Non-ASCII dash in source.

> +typedef int (*eth_timesync_tx_ts_get_caps_t)(struct rte_eth_dev *dev,
...
> +	eth_timesync_tx_ts_get_caps_t timesync_tx_ts_get_capabilities;
...
> +int rte_eth_timesync_tx_timestamp_slot_get_capabilities(uint16_t port_id,
...
> +int rte_eth_timesync_read_tx_timestamp_slot(uint16_t port_id,

Three spellings of the same op, and the read function breaks the
rte_eth_timesync_tx_timestamp_slot_* prefix the release note
advertises. One prefix for all of it, rte_eth_timesync_tx_slot_{caps,
alloc,read,release,stamp} is shorter and consistent.

Also TX/Tx mixed throughout comments and docs. Tx.

> +struct rte_eth_timesync_dual_domain_timestamp {
> +	int64_t adjusted_ns;
> +	int64_t raw_ns;
> +	uint32_t valid_mask;
> +};

4 byte tail hole. Fine for experimental, but say so or reorder before
it goes stable.

> +++ b/doc/guides/prog_guide/ethdev/timesync.rst

Lines up to 150+ chars. Doc guideline is one sentence per line. Half
of this file documents existing clock/Rx API, which is a separate
patch from the slot feature.
