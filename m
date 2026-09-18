Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F80DC982CC
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 08:17:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 254204027A;
	Sat, 19 Sep 2026 10:17:37 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id A75764026A
 for <dev@dpdk.org>; Sat, 19 Sep 2026 00:56:06 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d91a931f66so8545595ad.0
 for <dev@dpdk.org>; Fri, 18 Sep 2026 15:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789772165; x=1790376965; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dWDThnychASZxXMqRiqqhssKpBONcOKhfp/ZNSw2mY4=;
 b=gdO4hQtBJrcVntWs+iBqa4sZjGZ5reK+8V1XRaN4UMfW2kPE7UZVZW56mZdG+QC99r
 +ubFX1TvAyXdEVwrLDIdsjpeJMsM9uUfi39cDA1cQ8i8mijYd6ig8kDyJ2ZyoroSIfz1
 1vzASie1QdRS8gYFJKqnohTHRVo3mT/E60t345zaharmR6iP5VKBTFPlheOXEaP93tRY
 TeFHU9CJMC/Ms97WRJTyaiJq+dA5uJNDRrIMdgoffpokVi90v0XZV0kR5Ov9Isj7XVJF
 Bw8BzpSuDM4Ns8i14uLg2QqxXTLSyzgzorjzqklKXPUlDWwnsG4U5jFi9scktlER7cjl
 jXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789772165; x=1790376965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dWDThnychASZxXMqRiqqhssKpBONcOKhfp/ZNSw2mY4=;
 b=xXTG0hxIfiYtu8GcIwJV8En9hG9ipn6UgJcg0ILyUpF/c+QzrSvJldhLBTTExjxKed
 +fKU1FnTE9UJ7H4xT3gMIso1P/sU7BgrJOAtsrOCqII8IOc6EtB95d6rqOQyfsTxo5wr
 iuyTLBWfG4xAZ3SMxh4aIxwV/LxSIt6dG4d4dSC/WEde9n7DqQmKZL48wwrRG0+iMpBU
 z6RyVqnNJpp3hd/aSPe1cBnJvmzr1eioBiVQ0TI5R7/5wMWUN2XXNMaB9IRdgfFxXDCS
 eksS+H5N67rElOitwcZ5mAnFFCD44oRwvSt/X3CfomdtC+Ld8Pk8kNyxxr8VQ6zuS4vs
 Bl7w==
X-Gm-Message-State: AFuF++l+0nB52rXjppZEYrjSW9VepGLdL1fdHcdaZvwsk3+GOlby16fx
 w/3sH8+ifng0CCoKeVM/v63N1FaTEvjiv5P02PFq4g4yV4LlJYGGf4AfYR1ZVQct
X-Gm-Gg: AYBFou3uSKFo2Ke1SHZSd/1zelUSH20UDWdoJEzZEUyGN98YEGSNaNC2m86LXZ5lm7S
 eIY0TvAevC5BTmbV0CFvQMoFObT4gnEd91gLwPnSCo/Gxdijsl4INxijTQDF0eAVeR18C8wENhF
 fWzswq2+6DzikmU5011w1qgo15dq0KEIS5ArPeaY//YJiexttme1b2odYHUpeQP2+Tsg89Aq6kT
 IKBGgYpbJD80y0JZPHqDKVC8IZNzB9SfhuIyLuC4+5hnVF5vDFyJG/wXxDGWTqNJxpk+v1+aLlR
 3IfE4N/SXPU0nxGlYDiwaxxH1iOsJsmhbV5XDUBDMX8R/cxBXx4JmA0FtHpS21ryt53J5dIQM5b
 q9ltM64gdtO4HKlmbhSXifuFVcWstb7tv9AP5HWvSZflIFJBYvYC9tcKMBp9MQCU+fadMDUB+bG
 O1Oune/sOsBrohE4HlsYwZoih+XplSUoTmHFduUniURaJLX8HD4OjgxFFnXlqLkO+cxMhWP1iIf
 A==
X-Received: by 2002:a17:903:2343:b0:2db:3b35:1ac6 with SMTP id
 d9443c01a7336-2ddb1ab24edmr82349915ad.5.1789772165407; 
 Fri, 18 Sep 2026 15:56:05 -0700 (PDT)
Received: from ubuntu-desktop.. ([137.99.252.104])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3314313esm1569423eec.14.2026.09.18.15.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 15:56:05 -0700 (PDT)
From: Md Rayhanul Islam <r97yhan@gmail.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Chuanyu Xue <chuanyu.xue@uconn.edu>,
 Song Han <song.han@uconn.edu>,
 Md Rayhanul Islam <md_rayhanul.islam@uconn.edu>,
 Md Rayhanul Islam <r97yhan@gmail.com>
Subject: [PATCH 0/2] make PCIe DMA work on Broadcom BCM2711
Date: Fri, 18 Sep 2026 18:50:42 -0400
Message-Id: <20260918225045.177125-1-r97yhan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Sep 2026 10:17:34 +0200
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

DPDK cannot transmit a single packet on a Raspberry Pi Compute Module 4
with an Intel I210.  Nothing reports an error: rte_eth_tx_burst() returns
the full count, the link is up at 1 Gbps, and testpmd in txonly mode
still shows TX-packets: 0.  Received data is DMA'd somewhere other than
the mbuf.  The same card works on x86, and the same board works through
the kernel's igb driver.

This has been reported twice and never explained: on Stack Overflow in
October 2023 with DPDK 23.07 [1], where TX-dropped equalled TX-total at
55 million with both vfio-noiommu and uio_pci_generic, and on dpdk-users
in January 2026 with DPDK 25.03 [2].  Two years apart, so this is the
platform, not a regression.

There are two independent causes, hence two patches.

First, the PCIe host bridge does not present memory to devices at CPU
physical addresses.  Its device tree says so, and DPDK does not look:

  $ hexdump -C /proc/device-tree/scb/pcie@7d500000/dma-ranges
  02000000 00000004 00000000  00000000 00000000  00000001 00000000

  PCI memory space | bus 0x4_0000_0000 | CPU 0x0 | size 4 GiB

A device reaching CPU physical address P must therefore be programmed
with P + 0x4_0000_0000.  In IOVA_PA mode every ring and mbuf address
DPDK hands the NIC falls outside the inbound window and is discarded
silently.  Patch 1 reads the translation from the host bridge and
applies it to IOVAs; that alone made the NIC transmit.

Second, the bus is not cache coherent -- no "dma-coherent" on the bridge
or any ancestor -- so the NIC read stale rings: zeroed descriptors with
DD set and null buffer addresses.  Patch 2 does the cache maintenance
the kernel DMA API would do.  Two details took the longest to find:

  - Cleaning to the point of unification (DC CVAU) was not enough.  Only
    a clean to the point of coherency made the device see CPU stores.

  - A clean writes back a whole 64-byte line, which holds four
    descriptors, so cleaning one erased DD bits the NIC had just set on
    its neighbours.  TX completion therefore comes from the hardware
    head register, and RX descriptors are refilled a whole line at a
    time, once every descriptor in that line has come back.

The cache maintenance sits in the driver.  Every driver on such a bus
needs the same thing, so an arch or EAL helper may be the better home; I
kept it local to e1000 for a first submission and am happy to move it.

Each patch documents its own half, since the failure gives nothing to
search for.

The device is bound to uio_pci_generic throughout: this SoC has no
IOMMU, so VFIO cannot be used to sidestep the address question.

Tested on a Compute Module 4 (BCM2711, 4 GB, Cortex-A72, 64-byte cache
lines) with an I210 (8086:1533 rev 03) on uio_pci_generic, Ubuntu 22.04
arm64, kernel 5.15, pcie_aspm=off.  With this series applied to current
main, testpmd txonly reaches 1.42 Mpps at 64-byte frames, which is 1 GbE
line rate, with 0 TX errors; without it, TX-packets stays 0.  The same
code based on v25.03 also passed a 300k-frame MAC loopback with no loss
and byte-exact payloads, and 390-run round-trip campaigns against a
second board with ICMP and UDP probes, 100 to 1500 byte packets, 1k
pkt/s to line rate, with no unexplained loss.

Not tested: any other board, SoC or NIC.  The offset is read from the
device tree rather than hardcoded, but I have only seen this platform.
Only e1000 was changed, so other drivers on a non-coherent bus still
read stale descriptors.

[1] https://stackoverflow.com/questions/77225289/
[2] https://mails.dpdk.org/archives/users/2026-January/008433.html

Md Rayhanul Islam (2):
  eal/linux: apply PCIe inbound DMA translation
  net/e1000: maintain caches on non-coherent DMA

 .mailmap                                  |   1 +
 doc/guides/linux_gsg/bcm2711_platform.rst |  71 ++++++
 doc/guides/linux_gsg/index.rst            |   1 +
 doc/guides/rel_notes/release_26_11.rst    |  16 ++
 drivers/net/intel/e1000/igb_rxtx.c        | 356 +++++++++++++++++++++++++++++-
 lib/eal/linux/eal_memory.c                | 265 +++++++++++++++++++++-
 6 files changed, 697 insertions(+), 13 deletions(-)
 create mode 100644 doc/guides/linux_gsg/bcm2711_platform.rst

-- 
2.34.1

