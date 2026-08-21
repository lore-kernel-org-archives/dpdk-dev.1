Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C16C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:10:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DCF940289;
	Fri, 21 Aug 2026 21:10:29 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 779A34027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:10:28 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2caed617615so15364605ad.3
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787339427;
 x=1787944227; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GdnLiUJaDp0J3pU9SavlaQ2wV+s+4UQ1W6N5BzBwrYk=;
 b=OI1gHSClNGA8cde62xxR+mHGcvM6tAJ4ltqdJf9okiUDmSSQ7dWbfpY7PF2Vee2uUs
 EJ/JpxEVM0h9FnovFtUBM2um6EUpsPQkScsI1wR0gFzRC8CPGKILwZQ6/rXipQZ7+zM6
 A31QjzXH8vulrN+zHLXchBJymmwh9qJC/g7CVhYbHO260E7bNUJRWilk7atqiC+cZ8s0
 akesDC72Pyh92k5e0PKFTza6OP28cmQhkfrha2/sKffHjtVx69S2jQdv1LtTM4ufhKTx
 oTUmvECLJGQeeQU8SP8C5gemhJ7grg+FFkRUKh7k8wnt11TB+YxE3bGrbFJy6MP9TdBt
 z7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787339427; x=1787944227;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GdnLiUJaDp0J3pU9SavlaQ2wV+s+4UQ1W6N5BzBwrYk=;
 b=r8X2GlByqO3EAD1pjVuKeAQKU6qumCRFGftyhRfMWrGt836UI4szsez7G+pDgwpfjF
 J5BG2V8sywgf35b7ULYe6cTMyZWLs/zXrYoSoNlExpq0XOj/UQNZBUe1++DvUgBcd2Ku
 KGY3j0ObLBTKsy5ElSzz1XOQ7OBIfeYH02nFpo8h1Zn1DjPFnTg5P1VUdtaW2NAA3n5t
 j+TpgQIeQs3sRAz1RQZbzIH3Tk2FUsBMIckoG5kT2Na/eWNlJpGu613sZArDkvFmHymZ
 udgV8fc1Q0ZIHj1AhNcYKeVrZ23yZFypX+x82MpVVE/2pjuFqAplqu7pomBoSPziXIuP
 6UsA==
X-Gm-Message-State: AFuF++kpPh2vWPddV0gmlMdr6KM5SRhGqpNi5Z2114oNIg6HllJn2y7H
 /ebe0j0SUBw/KBK9FFpUPScOtUeIBDiDopHJqjdz2PYracEsYPGsp2c8y+AVXEFTi9Y=
X-Gm-Gg: AR+sD10r6GXlfiB70vZbt6D73NqOapji/XfqXKOJwDiOCAYlCOlye7LrYr1qqp7+VNt
 NO+yPpSm76hUjJ0xlVxbqppmd8+5zkKPush5ZpiqHnbAdFC6gUXQua3454xrv7oLIFYZWG4arUv
 MvBuwAh8aYgn6uoTVJboTJegsD+TYrIiBsWZuR39atmNT/HmycZVcRW5cfB5zUhYf1tMd6Aka+q
 UlOOmNBQELzFpPnq6yG/ulOIN1WaS4RKOIbmV1FHmbtSTA2i/FEFC6/eVFQ7urU64W2gdygTC4u
 oikmTwNtb4Gekc23RNjavvKev6RKqHZXKp5kVLq0EYPxjek+lMiTVquioqD3rI3WCY8LEhGUBwv
 wrCmcqPABueAsc/tD4BtYa03sYJzqEJlmGrWZR/Vl+PLTDQH2Ht0Hxvgyy5x0Y1HmmL1TdKyikR
 3O/WOM3cWG4hi8htyClZ5lfISVp4j6ahl7w7DZt8fKY05bIjcHIoJ9065AROdz9rYqJ2LpBB/2h
 J3ndn1+KcIApu8b2D0hBIro0ZXy5Q==
X-Received: by 2002:a17:90b:39ab:b0:393:19a3:4e5 with SMTP id
 98e67ed59e1d1-395df686f1dmr1179075a91.16.1787339427606; 
 Fri, 21 Aug 2026 12:10:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c37996sm4212743a91.16.2026.08.21.12.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:10:27 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:10:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 2/2] net/sfc: provide cached dev info to use in
 secondary process
Message-ID: <20260821121018.6c8ba96f@phoenix.local>
In-Reply-To: <20260820130314.12251-3-ivan.malov@arknetworks.am>
References: <20260820130314.12251-1-ivan.malov@arknetworks.am>
 <20260820130314.12251-3-ivan.malov@arknetworks.am>
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

On Thu, 20 Aug 2026 17:03:14 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Secondary process support in the 'test-pmd' application now requires that
> the driver expose the 'dev_infos_get' method within that context. Use the
> cached dev info from the primary process in order to meet the requirement.
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
> ---

This patch has issues.



Patch 2/2: net/sfc: provide cached dev info to use in secondary process

Error: the cached snapshot is missing the defaults that
rte_eth_dev_info_get() fills in before it calls the driver callback,
so the secondary process reports zero for several fields.

rte_eth_dev_info_get() pre-populates the struct and then calls
.dev_infos_get(), so a PMD callback only has to set the fields it
actually knows about.  Besides switch_info.domain_id and device
(both handled by this patch) it pre-sets:

  rx_desc_lim.nb_seg_max      = UINT16_MAX
  rx_desc_lim.nb_mtu_seg_max  = UINT16_MAX
  tx_desc_lim.nb_seg_max      = UINT16_MAX
  tx_desc_lim.nb_mtu_seg_max  = UINT16_MAX
  rss_algo_capa               = RTE_ETH_HASH_ALGO_CAPA_MASK(DEFAULT)
  max_rx_bufsize              = UINT32_MAX

sfc_dev_infos_get() never writes any of these, and neither do the
datapath get_dev_info() helpers (sfc_ef100_rx_get_dev_info() and
sfc_ef100_get_dev_info() only touch nb_min and nb_align).  In the
primary process that is fine because the ethdev layer supplied the
values.  Here the cache is filled by calling sfc_dev_infos_get()
directly on a zeroed structure, so those fields stay zero, and
sfc_dev_infos_get_secondary() then overwrites the ethdev pre-fill
wholesale with

	*dev_info = sfc_adapter_shared_by_eth_dev(dev)->dev_info_cache;

A secondary process therefore sees nb_seg_max = 0,
nb_mtu_seg_max = 0, max_rx_bufsize = 0 and rss_algo_capa = 0, which
differs from what the same call returns in the primary.  Applications
that validate multi-segment Tx against tx_desc_lim.nb_seg_max, or
that check the RSS hash algorithm capability mask, will get wrong
answers.

Suggested fix: seed the cache with the same defaults before the
snapshot is taken, e.g.

	static const struct rte_eth_desc_lim lim = {
		.nb_max = UINT16_MAX,
		.nb_min = 0,
		.nb_align = 1,
		.nb_seg_max = UINT16_MAX,
		.nb_mtu_seg_max = UINT16_MAX,
	};

	sas->dev_info_cache.rx_desc_lim = lim;
	sas->dev_info_cache.tx_desc_lim = lim;
	sas->dev_info_cache.max_rx_bufsize = UINT32_MAX;
	sas->dev_info_cache.rss_algo_capa =
		RTE_ETH_HASH_ALGO_CAPA_MASK(DEFAULT);
	sas->dev_info_cache.switch_info.domain_id =
		RTE_ETH_DEV_SWITCH_DOMAIN_ID_INVALID;
	(void)sfc_dev_infos_get(dev, &sas->dev_info_cache);

This duplicates ethdev knowledge in the driver and will drift when
new pre-filled fields are added.  An alternative that avoids the
duplication is to have sfc_dev_infos_get_secondary() copy only the
fields the PMD owns, or to keep the caller's pre-filled struct and
merge the cached values into it.

Info: switch_info.name is left pointing at the primary process copy
of dev->device->driver->name.  The comment in
sfc_dev_infos_get_secondary() only mentions the device pointer, but
this is the same class of problem; the string lives in the driver
image rather than in per-process heap, so it happens to work under
the usual multi-process assumptions, but it would be more consistent
to re-derive it next to the device pointer:

	if (dev_info->switch_info.name != NULL)
		dev_info->switch_info.name = dev->device->driver->name;

Info: the cache is a snapshot taken at the end of sfc_eth_dev_init().
Everything sfc_dev_infos_get() reports is fixed at attach time today
(NIC config, rxq_max/txq_max, offload capabilities, MAE status), so
the snapshot is accurate.  Worth a note in the sfc.h comment that any
future dev_info field derived from post-attach state must not be
served from this cache.
