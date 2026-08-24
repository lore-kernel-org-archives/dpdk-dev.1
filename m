Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A7C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:21:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07D2B40270;
	Mon, 24 Aug 2026 18:21:44 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 103DE400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:21:43 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so3221683a91.0
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787588502;
 x=1788193302; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8krdk5PL2hh/+2uDrZ4CclBe66QkxuN9seLrJjsN0sw=;
 b=PBr4pjyQBoYrbXo2RxpwJ16WtLfHWu5PQhFT87D4o5vd9W/pAeZv1r1yL1CyGLGxdo
 Z7Xj6lt1EwDNhP7Tf1feOA6uoi771ntaIIdERNQyPaI19R4zLd1qpP9VX7OEixiWDJjn
 DRU+BQJ5+Sn/BqTYa78hTCuqyNe2zjkJFEmOkbMRRRmwYb+NU3nO6dyCch8CbxP514qJ
 hs/E8OXjl+9MhlOhnhw0vataG9SARclYz3LHJdkSm9ETHQ5s2hOf+P7kyTmA7Rc9AaCp
 wubjD5xVaCAmn5YqhsL2w45qSOUYgjDKxaZEGxxquk4PnCypjopEyW8rQR4rsGjic+dW
 OVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588502; x=1788193302;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8krdk5PL2hh/+2uDrZ4CclBe66QkxuN9seLrJjsN0sw=;
 b=H4llc7SzppIQEKYCSNrmkh/uwUW1M5dXm8W53kOWw6Eu6onBEObKSVhWse64qzzX6t
 mGotcain9VsyS8DbTZLLZIZeQYu0g5EV54iSSuMYjHDaR4XGnmjM2oJXJ2bLghW9Lzpy
 WXEJ8lQTsephvUEUYK8flLXy+PW5KOrsvBZpNrZ/1A/NokohTRagmOcy6AaEqodlHmaJ
 XvVXGXPvpdw9qw67lt/7Eky9vt2tQeDMerMlJqsW+ok3+znjUd2m9UsyhTcR5NlanOEZ
 ouSfSkyCQlxZVX1xGJ4+BXXmi2pP5QLxLr0gZ8tpcpAJnev4VEqkPf8Fq8nVPmz0Bbnp
 +iRw==
X-Gm-Message-State: AFuF++m2pBs4DuVlnxv/SGBIkbFvKKPzLR4iA4CgcB5hUPPBQyzJyy3Q
 3H1tX54ztsDpHMN2b6QyJE/iyaCcF4NgngYpx9Rzf8tvhHAZT6PvVbPEY5HHn/5Hkqc=
X-Gm-Gg: AR+sD13CTMy5FVA9f1tNgiTHnB2QtMxPYs9dFi3Up8/X+OI2nMvdEkk1bn9ucbwg7Yg
 mYZaV0oE7Ji3If2tgf1GIe3yE7hI8CYQCNecVbIttI+cup2HoRQaN9Of3Yv47J9bROEruqZQd4e
 b4AYGZdCrnWlt7braSxbP08JM5zBvnGbgTyeBuZWC4YWGv/luZotBhzLu6JpPs3XsEzEI/0wAOi
 742wKAU/n7bqRMT6jLYki1J6cxP4kk+0ynjnNauBIJxCmC6xbeFzAHA42zT6JdvHjKhtdHFrXZR
 h1ady6dQAm7IrKUCGrhCdAQR5vWefqGcFbxnYqibRZ11iDqA8WSkIHNtB+77XkIdzfyN0sOGvkS
 6ooMxCPBobxhggHn1DG8RDK9iUADLnX20cXtYQ8BR2xKWbHN7quOaewaAIzWDznagq1vLluBzi0
 MDTZauBMMXReoCmFsFdu1PVzkkMAmZNutJrV39AZfHmM+YeDnIXt304veEaxRxU0ob78XAZhKDR
 S9FmqTmhvTuxViIN7NTtpwtQ3O9hg==
X-Received: by 2002:a17:90b:53c5:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-3964652ad89mr5110a91.12.1787588498642; 
 Mon, 24 Aug 2026 09:21:38 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b17ef5sm144422a91.2.2026.08.24.09.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:21:38 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:21:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, Sunil
 Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman
 Kalra <hkalra@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v6 2/3] ethdev: skip VMDq pools unless configured
Message-ID: <20260824092125.4d074c3a@phoenix.local>
In-Reply-To: <20260824114207.312513-3-david.marchand@redhat.com>
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260824114207.312513-1-david.marchand@redhat.com>
 <20260824114207.312513-3-david.marchand@redhat.com>
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

On Mon, 24 Aug 2026 13:42:06 +0200
David Marchand <david.marchand@redhat.com> wrote:

> The mac_addr_add API describes that only the 0 pool should be passed
> unless VMDq has been enabled, though there was no validation so far.
> Add such a check, then cleanup the MAC related operations (adding,
> removing, restoring).
> 
> As a side effect, the net/cnxk does not need to manually reset the
> mac_pool_sel[] array.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
> ---

Claude Fable AI review has some warnings.

Review of [PATCH v6 0/3] ethdev: VMDq cleanups

Applied cleanly on current main (c1a46b9). Build testing not done
here per your note; findings below are from reading the applied tree.

Patches 1/3 and 3/3: no findings.

Patch 2/3 - ethdev: skip VMDq pools unless configured
-----------------------------------------------------

Error: MAC removal no longer reaches hardware on i40e and bnxt when
VMDq is not configured.

Both drivers read dev->data->mac_pool_sel[index] inside their
mac_addr_remove callback to decide which VSI / VNIC to delete the
filter from:

  drivers/net/intel/i40e/i40e_ethdev.c:4516  i40e_macaddr_remove()
  drivers/net/bnxt/bnxt_ethdev.c:2027        bnxt_mac_addr_remove_op()

Before this patch rte_eth_dev_mac_addr_add() always did
mac_pool_sel[index] |= RTE_BIT64(pool), so a non-VMDq add left bit 0
set and the drivers deleted from pool 0 (main VSI / VNIC 0). After
this patch the bitmap update is guarded by "if (vmdq)", so in RSS or
NONE mode mac_pool_sel[index] stays 0. rte_eth_dev_mac_addr_remove()
then calls dev_ops->mac_addr_remove() while the bitmap is still 0,
both drivers iterate an empty mask, and the hardware filter is never
removed. The software copy in mac_addrs[] is cleared, so the address
looks gone from the API but still receives traffic.

bnxt_restore_mac_filters() (bnxt_ethdev.c:4566) has the same
dependency on the recovery path: with a zero mask it replays nothing.

A second, less common consequence of the guards: after a VMDq ->
non-VMDq reconfigure, rte_eth_dev_mac_addr_remove() no longer clears
mac_pool_sel[index], so stale pool bits survive. A later VMDq
reconfigure that places a new address at the same index does |= on
top of the stale bits and eth_dev_mac_restore() replays the address
into pools it was never added to.

Since ethdev_driver.h documents mac_pool_sel as "Bitmap associating
MAC addresses to VMDq pools" and drivers are entitled to consume it,
ethdev should keep it coherent in all modes. The minimal fix is to
drop the two guards and keep the bitmap always up to date (pool is
already forced to 0 when !vmdq, so bit 0 is recorded):

  In rte_eth_dev_mac_addr_add():

	if (ret == 0) {
		/* Update address in NIC data structure */
		rte_ether_addr_copy(addr, &dev->data->mac_addrs[index]);

		/* Update pool bitmap in NIC data structure */
		dev->data->mac_pool_sel[index] |= RTE_BIT64(pool);
	}

  In rte_eth_dev_mac_addr_remove():

	/* reset pool bitmap */
	dev->data->mac_pool_sel[index] = 0;

The new "if (!vmdq) return 0;" early-return for an already-present
address, the !vmdq branch in eth_dev_mac_restore(), and the cnxk
cleanup all remain valid with this change.

The alternative is to make i40e and bnxt stop depending on
mac_pool_sel[] in non-VMDq mode, but that would need to land in the
same series and is more invasive.

Info: "Port %u: VMDq is not configured (pool %d)" - pool is uint32_t,
use %u.
