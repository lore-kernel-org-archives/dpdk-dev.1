Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B00CA5FDD
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 08:23:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 873C24026A;
	Sat,  3 Oct 2026 10:23:39 +0200 (CEST)
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by mails.dpdk.org (Postfix) with ESMTP id 8484E4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 22:09:29 +0200 (CEST)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-9104e54b1abso3692256d6.1
 for <dev@dpdk.org>; Fri, 02 Oct 2026 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790971769; x=1791576569; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CUfm+JL2pqs1DTmUv0xM4qHkfxYRXPGePCiscdmdWHg=;
 b=UxxsKYU7T0lG2Y5Ya9ZTQCEcV4q+TvRuPG5FL5AED9Y30n9HXSfWvxPEKi/mY3Rb+/
 KWo9+9/ndX3G9lRxUCWOWU4GDADw+Go45g4wrJBYtlzgxXnlCrzVKu3hlTEElo+U+Mtt
 ejv45fCHyh8a7ETkhp/8/DTtncClbh4XrmqUaFmODsKZRbODXzq6pyiSTBDoPVTAi/Z+
 QtLAf/Oz0sfoHEeYKZgRc0obfxWu1tcR+a+G2KgqBdAYHV3A/S8DLJdGXh39GkhmtLeX
 Tvx2d0cAnuIuu8X1XWVxekeL3NQBbqDYU4ON3HDk7SqYoXIxMz3Pg+r76CRFfnqtgmhy
 mphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790971769; x=1791576569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CUfm+JL2pqs1DTmUv0xM4qHkfxYRXPGePCiscdmdWHg=;
 b=taQFf5+/u0NWkfRKDrn8qPN/5vmjy8WmEpwRzIWf3527eUz2Sroul/hkbdJBg6M5mv
 BLL47vb1JnTUeXIvYdzJjlSyoY6q8XpncVQWefEM+rtFfx3DczODqF+D5Uc34wOA9Bph
 xwjDI+OQ4buA8chUpgweWJNn3EZNrI3StDFzUD5h4g39jpN9pmlt/LrQV2bIgpN1PeBL
 da27a8ABXVd/ZyLHYTIpuDTAiuvzvKMghC4kvvXxmCy1JhGuEmcPodw7mS3zeGTWkxTK
 4cxkQo1cNzXFCP/Fvg8BHuKfO1HcRwB2NA0p+QT+izR5xrNckr1abf3CPxCeZXVjYRvN
 B8mw==
X-Gm-Message-State: AFuF++kyr/nMVwJwxmfH7Nl1EXFa7O3SgQBbevCO0J/VTeMLCwnMHOu7
 bCA+ZLW5q7M4lR0hDfr5PcShZvTCA5nx+i4gP8hX8+lxrOjlNwSjLNwcpe1NX5KJ
X-Gm-Gg: AYBFou3IZUFbNTgvwcRuG1oPgAP2SoP+BGZol3IJj0TBwdhM/mHt8vAzkmkORmyWqCY
 U7WN5WY2+AQmKD/oJfhdbPvV7uiOQjExftK9rH9nHh4/12YMKgyOpY5W1n8AUaNrhPVi95p2NyK
 y3Dwu48X8+GadG3GQDlJLEvGTlzPSv3s8Ag2WISpD50xZbD9RfCSd4R33TRmi/dLKMIBpCOUIRV
 Welg7F9fP6BQs+fJ5tZC3PoOHlkFRiBuTu8zEna4BYg2BK4uGz0R5ZgnAXlaX3kenqDpL9BaLAJ
 oM1foY1AqdNDTGHL+sEiR+8Vv/tcBRdxUUp+9HX6LCoasI2ghv6K1oST0HVIlE62o9vKRl7ADp0
 YWMmEc9qvHVahQcfrzkpFer1049La9bk0qL9H2Qofx6W+7/qIhUA4zB7/p0eEPks0VilTv+pbHf
 NdzH43xrbE7erPYmf9uygHdOG2JaqNdOiZo3mdYWhFk2SdVqMHyb7Wj2lBFMcVjGHxHbVbVcAaS
 naKbcDAUgJx
X-Received: by 2002:a05:6214:5002:b0:914:525b:8ff3 with SMTP id
 6a1803df08f44-917c00bf201mr77543886d6.23.1790971768605; 
 Fri, 02 Oct 2026 13:09:28 -0700 (PDT)
Received: from ubuntu-desktop.. ([137.99.252.104])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0bc98fbsm27933156d6.29.2026.10.02.13.09.28
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:09:28 -0700 (PDT)
From: Md Rayhanul Islam <r97yhan@gmail.com>
To: dev@dpdk.org
Subject: [RFC PATCH 0/2] per-device DMA properties, with igb as the first user
Date: Fri,  2 Oct 2026 16:09:25 -0400
Message-Id: <20261002200927.6235-1-r97yhan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918225045.177125-1-r97yhan@gmail.com>
References: <20260918225045.177125-1-r97yhan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Oct 2026 10:23:38 +0200
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

This RFC reworks the BCM2711 DMA fix around a per-device DMA context and
an EAL sync API, after the feedback on the first posting [1].

On Raspberry Pi 4 / Compute Module 4 the PCIe host bridge translates DMA
addresses and is not cache coherent, so a device such as the Intel I210
cannot DMA at all without both being handled.

What changed since the first posting:

* The translation and the coherency are read per device from its own
  bridge, not kept as one process-wide offset.  EAL no longer rewrites
  IOVAs; the driver translates where it programs the hardware.
* A driver opts in with RTE_PCI_DRV_DMA_NONCOHERENT, and the bus refuses
  such a device to any driver that has not.  That replaces the refusal
  written into em by hand.
* The cache maintenance is an experimental EAL interface with explicit
  directions, and the loops end in DSB SY.
* Completion comes from the Done bits, not the head register.
* Both environment variables are gone.

Tested between two Compute Module 4 boards with Intel I210s, both running
this series: testpmd txonly holds 1.42 Mpps with 64-byte frames, and a
512 MB UDP transfer with DPDK at both ends arrives byte-identical.  Built
with GCC and with clang 14 -Werror.

[1] https://inbox.dpdk.org/dev/20260918225045.177125-1-r97yhan@gmail.com/

Md Rayhanul Islam (2):
  eal/pci: add per-device DMA translation and synchronization
  net/e1000: support non-coherent DMA

 .mailmap                               |   1 +
 doc/guides/rel_notes/release_26_11.rst |  20 ++
 drivers/bus/pci/bus_pci_driver.h       |   2 +
 drivers/bus/pci/linux/pci.c            |   6 +
 drivers/bus/pci/linux/pci_dma_ranges.c | 168 ++++++++++
 drivers/bus/pci/linux/pci_init.h       |   2 +
 drivers/bus/pci/meson.build            |   1 +
 drivers/bus/pci/pci_common.c           |  17 +
 drivers/bus/pci/private.h              |   2 +
 drivers/bus/pci/rte_bus_pci.h          |  52 ++++
 drivers/net/intel/e1000/e1000_ethdev.h |  19 ++
 drivers/net/intel/e1000/igb_ethdev.c   |   9 +-
 drivers/net/intel/e1000/igb_rxtx.c     | 409 +++++++++++++++++++++++--
 lib/eal/include/meson.build            |   1 +
 lib/eal/include/rte_mem_sync.h         | 133 ++++++++
 15 files changed, 815 insertions(+), 27 deletions(-)
 create mode 100644 drivers/bus/pci/linux/pci_dma_ranges.c
 create mode 100644 lib/eal/include/rte_mem_sync.h

-- 
2.34.1

