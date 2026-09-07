Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2ADC79F9E
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 20:36:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2544240655;
	Mon,  7 Sep 2026 22:36:04 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id D0863402E8
 for <dev@dpdk.org>; Mon,  7 Sep 2026 22:36:02 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-8623e5d435cso133970b3a.1
 for <dev@dpdk.org>; Mon, 07 Sep 2026 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788813362;
 x=1789418162; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KhqBQF+PxAHnasH58l+1Q856cbw/gYTN8tlQl2HAQc0=;
 b=om4dJ+4dEf6l47zH2WZupTUTJ0rtbaUzTOOxuXAUYT7WjWzycPZbPOHPFYndc+EJbT
 SamW+SIYfDnYoHxAhqhPk1Op4mUxEy/VBbeqZRvuBe2L8gTzSazg1MF4AYos0cRgc8pC
 e4UABgkzqO0q9cy5q2d1G22+araH0bNKhJ4IDnBefl0vUH5TkZeZtMt2VEjt/RNMrVIP
 JEM0zPbSozLwD0K+Nz4a+onOMQAQU/XNJHTczNOd3DR/tYdOC8rT/1RoNxkk2QffIBr2
 JDuNKAkfzDEAZENC902kETl57AnK0Iwz4Qz8npYupdOpjZbJRntMau3Vi4GZ9LzpFMDR
 BpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813362; x=1789418162;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KhqBQF+PxAHnasH58l+1Q856cbw/gYTN8tlQl2HAQc0=;
 b=HfmeFAy/CvItbYSMv+b9Ir7bt9grIeuayLQT5gQ2FrwOgWB5GCuDRvfcnilIomvBXR
 AcdzZG5pyVR+lcORLDDi19P0iVB6CfkQ2+oGYil7DG66TR+XCd3yaR+msbIoF0Rt3h7k
 +l03Hlk7RG2b0YzZuQ+A5b5J/QtTelCKuLqiDW+ru8hpNN0n+WJBZQinJxrVxIBWAIQ5
 lahVYNZXNwa58jM8J2w0sH0+qf47xPnw+Ys0kE8ETh9rSigx62WHVtYFA/buonxklq6Z
 A8FTz8I2YNyJFo1fPb6bpl7c+QzzW3O3VPpZqKyqb8unj+9NPNE7AdmZAb75XFK5BfAQ
 qlqA==
X-Gm-Message-State: AFuF++kUypIzkIyrSzByv5l2CsL2Pu0lpse2G2f8vR0XK9w6rFjfLSX+
 a5UoB3euyR6XlCNf9fU5UmPwOJVYDnbtqiJf7sT3yY50Px7+uWg/eqdmNE6dfGB1/0I=
X-Gm-Gg: AYBFou3QO0Kv+Mqqo9r+5rUGLZE6bgC+gdrRSd+gA/u3OYVrVOCRSCjrXS9LQeJ/YG/
 yUzDSG6+mBwMBtvqdfn0IHdkrnG1Hg7Z23ZPHcMBRg8TgLIyby88400lZp4rlCom2+JYeYIYlAn
 JJaDnw58pv24+LZvUFvjCbbyxIgYsBPtx8mDScS1jY6LL5AqQgj7NVb2G8bZ9USIVquxRlccxJR
 sng/T46zOreDoPMurH0dJpCViLac7m/oIDi0KT27BNBqcO0ZobO+RLksP0phfTmUdEgtKsFvi1a
 NU0mddmlfGIbI0wt3SrBKmmr3FLW96IIUvr85yrhKQJzxtQkV2pHKmKfWccgTfcrqQHvBacmuCL
 t7+ZII3ckSMxcG2oAvGAGfDQQe41Sjh53k+x83LBz4nSdCLjqldIOKphuWoEKc8cVoA/tf0DmJx
 iot63AmY+yAzG9VA9wobHSEAs3ffEEnBbNzAEfCyiDV9C00DFOz4S3mVjid2zlyFu9LlMJBEVTg
 LCYOL++v7SH99Nsbf0fvH4KwhHvxw==
X-Received: by 2002:a05:6a00:1151:b0:857:72f8:dca3 with SMTP id
 d2e1a72fcca58-8669a9151f5mr2398364b3a.9.1788813361695; 
 Mon, 07 Sep 2026 13:36:01 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8628622d20dsm3635258b3a.51.2026.09.07.13.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:36:01 -0700 (PDT)
Date: Mon, 7 Sep 2026 13:35:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 00/45] net/dpaa2: features and fixes for NXP DPAA2 drivers
Message-ID: <20260907133551.405006d1@phoenix.local>
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
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

On Thu,  3 Sep 2026 19:23:08 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This series brings the NXP DPAA2 driver stack up to date with the
> functionality carried in the NXP internal tree, together with a number of
> bug fixes. It covers the crypto (dpaa2_sec), net, dma, mempool, event and
> bus/fslmc drivers.


Since it was big, ran AI review with Fable. It stopped after finding
errors in the first 8 patches.

DPAA2 series review (bundle 2096), patches 1-8 of 45
Base: upstream main d55ccd4; all 45 patches apply cleanly with
git am --3way.

Patch 3: crypto/dpaa2_sec: support AES-GMAC

Warning: The patch adds RTE_CRYPTO_AEAD_AES_GMAC to the public
enum rte_crypto_aead_algorithm in lib/cryptodev/rte_crypto_sym.h
but does not add it to crypto_aead_algorithm_strings[] in
lib/cryptodev/rte_cryptodev.c, so
rte_cryptodev_get_aead_algo_string() returns NULL for it and
rte_cryptodev_get_aead_algo_enum("aes-gmac") fails, which also
breaks test-crypto-perf/testpmd-style string selection. There is
no entry in doc/guides/rel_notes/release_26_11.rst for the new
public API value. The lib/cryptodev change should be its own
patch ahead of the driver patch, with the string table and release
note.

Warning: dpaa2_sec_capabilities[] (the same table returned by
rte_cryptodev_info_get() via dpaa2_sec_dev_infos_get) now
advertises AES-GMAC as a symmetric AEAD capability, but only the
IPsec security path (dpaa2_sec_ipsec_aead_init) handles it; the
plain-crypto dpaa2_sec_aead_init() falls into the default case and
returns -ENOTSUP. An application that walks
rte_cryptodev_sym_capability_get() will find AES-GMAC and then fail
session creation. Either advertise it only through the security
capability crypto_capabilities or add the plain AEAD path.

Patch 6: crypto/dpaa2_sec: add support for env variables

Error: The env fallback overrides devargs rather than acting as a
fallback. dpaa2_sec_get_devargs() is called twice from
dpaa2_sec_dev_init(), once per key:

	dpaa2_sec_get_devargs(cryptodev, DRIVER_DUMP_MODE);
	dpaa2_sec_get_devargs(cryptodev, DRIVER_STRICT_ORDER);

and the env_set: block reads both environment variables
unconditionally:

	env = getenv(DRIVER_STRICT_ORDER);
	if (env)
		internals->en_loose_ordered = !atoi(env);

	env = getenv(DRIVER_DUMP_MODE);
	if (env) {
		dpaa2_sec_dp_dump = atoi(env);

With devargs "drv_dump_mode=2" and env drv_dump_mode=0, the first
call sets dump mode 2 from devargs and returns; the second call
finds no drv_strict_order key, jumps to env_set, and overwrites
dpaa2_sec_dp_dump with 0 from the environment. The same happens
in the other direction for en_loose_ordered. Read the env vars once
after both devargs keys have been processed, and only for keys that
were absent from devargs.

Warning: getenv() in a driver. Devargs already exist for both of
these knobs; per-device runtime configuration belongs in devargs,
and checkpatches flags getenv in drivers/ as a forbidden token.
Lower-case names like "drv_strict_order" are also unusual for
environment variables and easy to confuse with the devargs keys.

Patch 7: drivers: fix double free of dpaa2 device on uninit

Error: Moving dpaa2_dpdmai_dev_uninit() ahead of
rte_dma_pmd_release() in dpaa2_qdma_remove() breaks both teardown
orders.

	dpaa2_dpdmai_dev_uninit(dmadev);

	ret = rte_dma_pmd_release(dpaa2_dev->device.name);

(a) Application called rte_dma_close() before the device is
removed (rte_dev_remove / hotplug unplug -> fslmc_bus_unplug_device
-> drv->remove). rte_dma_close() -> dma_release() does
memset(dev, 0, sizeof(struct rte_dma_dev)), so dpaa2_dev->dmadev
points at a zeroed slot and dpaa2_dpdmai_dev_uninit() dereferences
dev->data (NULL):

	struct dpaa2_dpdmai_dev *dpdmai_dev = dev->data->dev_private;

(b) Device removed without a prior close. uninit runs first, does
rte_free(qdma_dev) and sets dpdmai_dev->qdma_dev = NULL. Then
rte_dma_pmd_release() sees state READY, calls rte_dma_close() ->
dpaa2_qdma_close(), which immediately returns:

	if (!qdma_dev)
		return 0;

so qdma_dev->vqs, the per-VQ fle_pool mempools, ring_cntx_idx and
the Rx queue storage are never freed. Before this patch close ran
uninit last, after freeing those. Suggested order in remove: if the
dmadev is still READY call rte_dma_close() (or dpaa2_qdma_close())
first so the VQ resources are released, then dpdmai_close() the MC
object and free qdma_dev, and only then rte_dma_pmd_release(); and
guard uninit against a dmadev that has already been released.

Info: struct rte_dma_dev is used as a pointer member in
bus_fslmc_driver.h without a forward declaration; adding
"struct rte_dma_dev;" avoids an implicit file-scope tag
declaration inside the struct.

Patch 8: net/dpaa2: fix integer overflow in CCSR region mapping

Warning: The fix is incomplete. page_size is validated, but the
two lines immediately before still use the PAGE_MASK macro, which
expands to ~(sysconf(_SC_PAGESIZE) - 1) and is the same
unchecked signed value Coverity complained about:

	start = addr & PAGE_MASK;
	offset = addr - start;
	len = len & PAGE_MASK;

Compute a local mask from the validated page_size
(e.g. uint64_t page_mask = ~((uint64_t)page_size - 1)) and use it
for start and len; the later "len & ~(page_size - 1)" is then
redundant with the earlier "len = len & PAGE_MASK".

Review-Result: ERROR
