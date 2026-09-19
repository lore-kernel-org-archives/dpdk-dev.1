Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33E1C982D7
	for <dpdk-dev@archiver.kernel.org>; Sat, 19 Sep 2026 21:05:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 999354027A;
	Sat, 19 Sep 2026 23:05:53 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id AF65840272
 for <dev@dpdk.org>; Sat, 19 Sep 2026 23:05:52 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 d9443c01a7336-2dd88a115ebso15277575ad.2
 for <dev@dpdk.org>; Sat, 19 Sep 2026 14:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789851951;
 x=1790456751; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fzRihx9jKvGDyQSYktzfZAwGrIvY17cfCKdI/l1RWhU=;
 b=rTS6GvxGT51/JJO0vEdeFiMeOzhLLHH9byFlfndF7VFc+ctCvqLwmkt4F+uhGQDO+/
 ZIOyq5AOo4VuQWGnwcwz66ffn98N7CN8wvocoz8MRFGQ8nAOGyFWVoC5mDbHpmUX5B8V
 A0Y2MpsAAKGXPeJtv9DlV0rlFkywQoCNZeCBtb7IBdQU+Xh0OIXEjYA/2iFHTxfMEeNN
 IMVsgQ5ROcs6PFC4AGc83wwAlLIX74IcsTwxmHr6PhCSU95zHCLkF3KI7R2WU59B+pDo
 6u96mEPQxEBVpmXKeLkZ+SuULReMNHVzylmuqcSwQ37txEcxBsVX/PTUPrpCPqOPg1ST
 dbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789851951; x=1790456751;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fzRihx9jKvGDyQSYktzfZAwGrIvY17cfCKdI/l1RWhU=;
 b=Mm1wikwdka3YqrWUvwhzxAfjRdYtjDkyMQH5MC2/ieI1GrO0iyk7UTuqNhuc5OiEV4
 hcmK38e+WpVrryLQjoAhGUBGSfvaqX0A3SxXmpcGixfmUQ3bMcFSeZNX8CWYtixb8hef
 lqsq7DcyZGhvkTqKUa040jpsgd/SHcA/RFlCVUIj8qYJJi4Eu9SWQSUeLDjV04wYLBoU
 qZadrn/tqc+lx/PJuFBw3BHzclkl2gFQeTB6T+aI/fY41Zbwf/Nc4Xi/48lcpSO+FNvY
 htbTRjCuzcWRsZPN5AaezzlzO5PMYNTmLGQ7NqZBE4fwNhz0N+YCigWUhje/BNKTUfR+
 eXYA==
X-Gm-Message-State: AFuF++mAI+i9OBIgu6fa/0LMZ77J2lXc6nNwjqIFnlOkkog0hX5nK147
 fphqPp7qS3lBjrPUzxch+OpEtBgvmu+ZNwFtnHQFhaOL0MebeTehV+V+ngXecpIkT8M=
X-Gm-Gg: AYBFou1wCkIQLqiGqylacHJJJVTqu7xgdUc6Kz5qit/7BVK5KqSgqhzQRWs5Ed5raya
 Ks0Bk/kjp0+FXIzgX2j0K355V25+cmJZVSeovuD3hMrlVMv9ctIlUq+wnp6nU8bJU+mytt/y2Qd
 EFgGvbXUTe3gRwPBgI9FgfBEpAM2kuppWSoJFTLUOeaPEtxBWL8UqVWMPLBRot9Azql48zdzi+U
 XiqEgwcBR/ksJhDmJbJGiehPhIzLU2R5fgPRXslukdg/HiuUJIATYvZP9IqXXv2x300kuNnDkrx
 MNLY9R/RqyiexhrI89a+PwFNx8PtfthO1dCtPlbuNRomvUZS8saOIkP1Q93CIONpBcnF/MGBNf/
 FX7PjbbfYNRfmLLAkG309HK2WhSpLGxHDhvXD23qpBxz/rpSflTmKReBO33nB28Fc1OuDlS/kU3
 32tmWS+dgUD3kPeG5WMZ9GYvamW8QewbTlh5FU4sEsHXyp3lE3gNEO7HH6L+n/esS55LkEdw2Bd
 MF9hc9QeK+p+L0WUxNxPZRuBXhgtQ7xozllkc2G
X-Received: by 2002:a17:903:b07:b0:2dd:c100:4248 with SMTP id
 d9443c01a7336-2ddc1004545mr48108405ad.44.1789851951388; 
 Sat, 19 Sep 2026 14:05:51 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc17d70f9sm12681455ad.67.2026.09.19.14.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 14:05:51 -0700 (PDT)
Date: Sat, 19 Sep 2026 14:05:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Md Rayhanul Islam <r97yhan@gmail.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, Chuanyu Xue
 <chuanyu.xue@uconn.edu>, Song Han <song.han@uconn.edu>, Md Rayhanul Islam
 <md_rayhanul.islam@uconn.edu>
Subject: Re: [PATCH 0/2] make PCIe DMA work on Broadcom BCM2711
Message-ID: <20260919140549.1f5f3c0b@phoenix.local>
In-Reply-To: <20260918225045.177125-1-r97yhan@gmail.com>
References: <20260918225045.177125-1-r97yhan@gmail.com>
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

On Fri, 18 Sep 2026 18:50:42 -0400
Md Rayhanul Islam <r97yhan@gmail.com> wrote:

> DPDK cannot transmit a single packet on a Raspberry Pi Compute Module 4
> with an Intel I210.  Nothing reports an error: rte_eth_tx_burst() returns
> the full count, the link is up at 1 Gbps, and testpmd in txonly mode
> still shows TX-packets: 0.  Received data is DMA'd somewhere other than
> the mbuf.  The same card works on x86, and the same board works through
> the kernel's igb driver.
> 
> This has been reported twice and never explained: on Stack Overflow in
> October 2023 with DPDK 23.07 [1], where TX-dropped equalled TX-total at
> 55 million with both vfio-noiommu and uio_pci_generic, and on dpdk-users
> in January 2026 with DPDK 25.03 [2].  Two years apart, so this is the
> platform, not a regression.
> 
> There are two independent causes, hence two patches.
> 
> First, the PCIe host bridge does not present memory to devices at CPU
> physical addresses.  Its device tree says so, and DPDK does not look:
> 
>   $ hexdump -C /proc/device-tree/scb/pcie@7d500000/dma-ranges
>   02000000 00000004 00000000  00000000 00000000  00000001 00000000
> 
>   PCI memory space | bus 0x4_0000_0000 | CPU 0x0 | size 4 GiB
> 
> A device reaching CPU physical address P must therefore be programmed
> with P + 0x4_0000_0000.  In IOVA_PA mode every ring and mbuf address
> DPDK hands the NIC falls outside the inbound window and is discarded
> silently.  Patch 1 reads the translation from the host bridge and
> applies it to IOVAs; that alone made the NIC transmit.
> 
> Second, the bus is not cache coherent -- no "dma-coherent" on the bridge
> or any ancestor -- so the NIC read stale rings: zeroed descriptors with
> DD set and null buffer addresses.  Patch 2 does the cache maintenance
> the kernel DMA API would do.  Two details took the longest to find:
> 
>   - Cleaning to the point of unification (DC CVAU) was not enough.  Only
>     a clean to the point of coherency made the device see CPU stores.
> 
>   - A clean writes back a whole 64-byte line, which holds four
>     descriptors, so cleaning one erased DD bits the NIC had just set on
>     its neighbours.  TX completion therefore comes from the hardware
>     head register, and RX descriptors are refilled a whole line at a
>     time, once every descriptor in that line has come back.
> 
> The cache maintenance sits in the driver.  Every driver on such a bus
> needs the same thing, so an arch or EAL helper may be the better home; I
> kept it local to e1000 for a first submission and am happy to move it.
> 
> Each patch documents its own half, since the failure gives nothing to
> search for.
> 
> The device is bound to uio_pci_generic throughout: this SoC has no
> IOMMU, so VFIO cannot be used to sidestep the address question.
> 
> Tested on a Compute Module 4 (BCM2711, 4 GB, Cortex-A72, 64-byte cache
> lines) with an I210 (8086:1533 rev 03) on uio_pci_generic, Ubuntu 22.04
> arm64, kernel 5.15, pcie_aspm=off.  With this series applied to current
> main, testpmd txonly reaches 1.42 Mpps at 64-byte frames, which is 1 GbE
> line rate, with 0 TX errors; without it, TX-packets stays 0.  The same
> code based on v25.03 also passed a 300k-frame MAC loopback with no loss
> and byte-exact payloads, and 390-run round-trip campaigns against a
> second board with ICMP and UDP probes, 100 to 1500 byte packets, 1k
> pkt/s to line rate, with no unexplained loss.
> 
> Not tested: any other board, SoC or NIC.  The offset is read from the
> device tree rather than hardcoded, but I have only seen this platform.
> Only e1000 was changed, so other drivers on a non-coherent bus still
> read stale descriptors.
> 
> [1] https://stackoverflow.com/questions/77225289/
> [2] https://mails.dpdk.org/archives/users/2026-January/008433.html
> 
> Md Rayhanul Islam (2):
>   eal/linux: apply PCIe inbound DMA translation
>   net/e1000: maintain caches on non-coherent DMA

Short observations:
  1. Too much AI generated slop, extra docs, comments on everything.
     New code should look like the surrounding code.
     This looks like AI wasn't quite sure and left lots of docs for future self.
  2. Handling DMA coherence should not be in the driver.
     It should be done in EAL.
  3. EAL helpers should be similar to helpers used in other OS (Linux and FreeBSD)
     when handling DMA issues.

AI observations:


Patch 1

- The offset is a property of one host bridge but is applied to every
  IOVA in the process, and it comes from whichever PCI node readdir()
  finds first under /proc/device-tree. BCM2712 already has several
  PCIe controllers with different dma-ranges. The offset has to come
  from the bridge the probed device sits behind. That is bus driver
  work: walk /sys/bus/pci/devices/<bdf> up to the host bridge of_node
  and read dma-ranges there, the same walk patch 2 does for
  dma-coherent. Bus scan runs before memory init and already feeds
  IOVA mode selection, so the offset can be delivered the same way.

- Lazy scan inside rte_mem_virt2iova() with a racy static is the
  wrong lifecycle. Compute once at init and keep it in shared
  mem_config so secondaries see the same value.

- No environment variables. If an override is needed it is an EAL
  option.

Patch 2

- The asm has no dsb after the dc loops, and DPDK's arm64 barriers
  are all dmb, which do not order cache maintenance. The clean can
  still be in flight when the tail register is written.

- EL0 cannot execute dc ivac, only civac, so every buffer the device
  may write must be cleaned before it is handed over. TX data and
  descriptors are cleaned, RX buffers on refill are not. Dirty lines
  from the application's previous use of the mbuf get written back
  over received data. txonly/rxonly/loopback never modify packets in
  place so the tests would not catch it; macswap would.

- TX completion from TDH: check the I210 datasheet. TDH advances when
  the descriptor is fetched, not when the data DMA completes, and the
  kernel igb driver never uses it for cleanup. Freeing the mbuf on TDH
  can corrupt frames still in flight.

- Coherence state is a process-global static set in queue_setup. Two
  ports on different buses get one answer, and a secondary process
  never runs queue_setup so it treats the device as coherent. Needs to
  be per-device, set by the bus, in shared device data.

- Every descriptor on every platform now tests igb_dma_noncoherent.
  Use separate burst functions selected at setup and leave the
  coherent path alone.

- em_rxtx.c in the same PMD is untouched.

The right next step is an RFC for the EAL sync API and the bus hook,
with igb as the first user, rather than a v2 of these patches.



