Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1097AC61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:19:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36CEA40269;
	Mon, 31 Aug 2026 18:19:05 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 32AB04025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:19:04 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-39647184c73so50503a91.1
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788193143;
 x=1788797943; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5xKlqB8WQYtY2aesv1Q9Ge+L8saGRt7n0XYPWn/Uilg=;
 b=R4/zkiuDCNnIGuS/5jEqzl9ceoNYCtmWOUEqH75XZVaJhGEN+3cGHNMfqq6SfYTujG
 GfOE9evS3LsXhUPvu6kRk+6EpSO91OmQAhh0nI3JF9wALkw/gvGEkzzea3GixTCpfyNQ
 FsugAS7ADl1lr82jUO4je8hqD4eBeKxFMwp4XvpZQ6A0JdKbLLzXF16cDZilhX/1Mxmj
 PsnvRGZhI5bq3GdJHVoRdP5Vsuf2eeirbhOl838n7Og2MIg6KeQdGiHxOqSKaW9N4zeX
 KAVrYOCGGoFGyePKFdY8TUyfpDlQTCnc1bMGRlZb8w3DHT2jO41dWwGHSQOzeDoEnFRG
 Ijrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788193143; x=1788797943;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5xKlqB8WQYtY2aesv1Q9Ge+L8saGRt7n0XYPWn/Uilg=;
 b=CHN3M0r1uhBGPX2s8Hnb0dfC/er9ZKYigFBXvko4kuNqElUoVqTiB5Q0kW2+mOvsjE
 6gj3SpfRoTylKaTbiIXaTwUhzbk+cdfjwxqkqUUb83iCvZSUl0TjwmXktDVQ3RiQ+qSZ
 eGyDPyA70BUFnx3c5w2IGiGZv4vvj5BmxUTLA1FUKMK45PcoCv3zpz0nsHy3733aBHIe
 QrJm/OqHbwf8F56iWkPhEiOeHspGQwY9o6Fvuly1PuFgyIq4xEvG+n+2udesF4cDt3YX
 8lQ0vCaR7c20/tr21zZlLAMcSlbLB7j1No/nYWdhe+wTzAKblYSR5MagZCjoWzMsE1R1
 eW2w==
X-Gm-Message-State: AFuF++kPYLYNdkLrvKGJSlxHP56/icDbKbhgg3ec4MRN8ecPwxW5N9XE
 F2W70Mgi54jaOuRIzwBPVVM+4wYGtqNioXzFkYQnCyxNsZAKeheIZf0NQVeFYhxfaCULJ29IwTV
 yPmuN
X-Gm-Gg: AYBFou07JLFIh/V97JXsRkmL8ECVKI1Yq0MZWGC5lJp/FO4VpB8qINzu5lt3PRh1V8m
 sMk8f8akLpuJT5dIK7YVaixSlTb8CyndmNT5HaX8DSbYpvy0PSV0a1Qu58C/JqkLHY9Rv+19Fyx
 iddlK5nIDJaX4NXv7MNOUejqUOg4B8MPQLn+/by0kNdIDb3QDZzS8vvxDWNQqf24FdKFG1jy8gO
 R5gtYe6yYA8d0F6hoUnscnXtq/DYVer6EQb809OSOn+cvh19EPq0+0YT/yCPUFUM40Nvnk20t2W
 PhAySl0IDyCRv7t08ABu1pBs8y/08x1PzYc49nAO+GAG17TnkBR96aPjiMALw41uEIdHxXK33jU
 SGn0+Pvd9E+zTQhw/MLvR2qftS5vqDnB+nN3PFCLzXk8SVTPjhZ9oI8UvguWFbR8uE19MZoTdP+
 ysYJu1MZCKhzfO6k5yUvQjLxgj1av7y0KJBcDDdeAioHbnLyt7K11Hvy21hN0GSjBQppgCuEOy2
 IZ6xLKz3d58YSC4DsahseNr/WmUFw==
X-Received: by 2002:a17:90b:2cc6:b0:398:9bd3:d6d2 with SMTP id
 98e67ed59e1d1-398da740784mr6974011a91.12.1788193142739; 
 Mon, 31 Aug 2026 09:19:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm172850a91.15.2026.08.31.09.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:19:02 -0700 (PDT)
Date: Mon, 31 Aug 2026 09:18:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v7 00/47] net/sxe2: re-align with reference and fix
 review findings
Message-ID: <20260831091854.6e14d305@phoenix.local>
In-Reply-To: <20260831024103.3230425-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
 <20260831024103.3230425-1-liujie5@linkdatatechnology.com>
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

On Mon, 31 Aug 2026 10:41:03 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This series updates the SXE2 poll mode driver (drivers/net/sxe2) and
> its common library (drivers/common/sxe2), fixing issues found in the
> previous version and re-aligning the driver with the reference
> implementation.
> 
> Changes since v6:
> - drop the now-trivial sxe2_vsi_node_free() helper and inline
>   rte_free() at its call sites
> - unify the duplicated FNAV/ACL COUNT action arms in the flow parser
> - use a file-scope static const ops table for the vectorized Tx path
>   and fail sxe2_tx_queues_vec_prepare() on a NULL txq
> - split "unify vectorized Tx buffer handling" into three commits:
>   the buffer_ring union fix, the NEON Tx 4-wide descriptor fill, and
>   the NEON Rx ptype/memory-ordering fixes
> - use the primary VSI id directly for representors (the kernel
>   guarantees it is always valid)
> - drop the packed/aligned attributes from the TM command message
>   structs to match the historical kernel layout
> - fix VEC mode selection in the Tx/Rx mode set functions
> - clean up commit messages (headline case/length, missing Fixes tags)

Getting much better. There are two items that AI flags that need
a second look; either say "yes thats OK AI is wrong" or put out
a new version.

The two that are worth examining are:

 Patch 26: fnav_enable change. Ends up enabling FDIR on all
   Rx paths per queue

 Patch 31: fnav lane ordering.

AI also gets worried that AVX512 fast-free change will change performance.
But in the overall performance of any real code, that change
will hardly be visible.

I admit AI has dug far more into detail here than I have.

Full report from AI (Claude Opus)


The v6 items are fixed: 14/47 and 15/47 commit messages match the
code now, 26/47 no longer duplicates the fnav command structs, the
command struct patch (now 43/47) states the sxe2_tm_res 4 to 2 byte
change, and the old 30/45 is split into 29, 30 and 31.

I applied the series and read the tree.  I did not build or bisect it.


Patch 08/47: use base device name for representor
---------------------------------------------------

Warning: the commit message says representor devices are allocated
on the same NUMA node as the parent.  The patch sets numa_node, but
the allocation two lines later still uses rte_socket_id():

	eth_dev->data->numa_node = adapter->dev_info.dev_data->numa_node;
	eth_dev->data->dev_private = rte_zmalloc_socket(name,
		sizeof(struct sxe2_adapter),
		RTE_CACHE_LINE_SIZE,
		rte_socket_id());

rte_socket_id() is the socket of the calling thread, not the socket
of the device.  Use the same numa_node for the allocation.

Info: the literal "vf" is passed as a "%s" argument.  Put it in the
format string.


Patch 26/47: add ACL engine event statistics support
------------------------------------------------------

Warning: this patch also changes Rx queue init in sxe2_queues_init():

	if (adapter->flow_ctxt.fnav_inited)
		rxq->fnav_enable = true;

sxe2_flow_init() sets fnav_inited to 1 always, so this sets
fnav_enable on every Rx queue.  Before this patch nothing assigned
that field, so it was always false.  The fnav blocks in all four
vector Rx paths (sse, avx2, avx512, neon) were dead code and are now
live on every queue.

That is a data path change.  It is not ACL statistics and it is not
in the commit message.  Please move it to its own patch and explain
why every queue needs it.


Patch 31/47: fix NEON Rx ptype mapping and memory ordering
------------------------------------------------------------

Warning: the fnav flags still use the old lane order.

The patch builds desc_lo and desc_hi in natural order:

	uint32x4_t q1_01 = vzip2q_u32(d0, d1);
	uint32x4_t q1_23 = vzip2q_u32(d2, d3);

so desc_lo is {d0[2], d1[2], d2[2], d3[2]}.  The old code built
{d1[2], d0[2], d3[2], d2[2]}.  flags lane i is written to rx_pkts[i]
through rearm0..rearm3, so this patch fixes the VLAN, checksum and
RSS flags, which were swapped inside each packet pair.

sxe2_rx_desc_fnav_flags_neon() is not touched and still builds

	descs_tmp1 = vzip1q_u32(d1, d0);
	descs_tmp2 = vzip1q_u32(d3, d2);

which gives {d1[0], d0[0], d3[0], d2[0]}.  That vector is OR'ed into
flags in sxe2_rx_desc_offloads_para_fill_neon(), so
RTE_MBUF_F_RX_FDIR and RTE_MBUF_F_RX_FDIR_ID are still set on the
wrong mbuf of each pair.  The bug is older than this patch, but this
is the patch that fixes lane order, and 26/47 makes the path live.

Warning: the patch is much wider than the commit message.  Besides
the ptype lanes and the fences it also changes:

  - staterr, from a 32 bit zip to a 16 bit zip.  Lanes 0..3 are now
    the low half of the staterr word for pkt0..pkt3 and lanes 4..7
    the high half.
  - the umbcast shuffle mask, the eop shuffle mask, rxe_mask and
    eop_mask.  These follow from the new staterr layout and I read
    them as correct.
  - the DD count.  The old code was rte_popcount64() of the DD bits,
    which counts DD bits anywhere in the group of four.  It could
    return 2 when packets 0 and 2 are done and packet 1 is not, and
    hand up a descriptor the hardware has not written.  The new code
    counts the leading run with rte_ctz64().  That is a real fix and
    it deserves its own patch, or at least a line in the message.

Also, the ptype lane change is not a fix.  With the old staterr
layout, lanes 5/1/7/3 selected pkt0/1/2/3 correctly.  With the new
layout lanes 1/3/5/7 are correct.  Both are right for their own
layout.  The message describes a bug that was not there.


Patch 32/47: refine vectorized Tx/Rx mode setup
-------------------------------------------------

Info: "Tx mode flags:0x%016x" and the Rx one print a uint32_t with a
width of 16, so there are always eight leading zeros.  %08x fits.


Patch 35/47: restore link update call in status query
-------------------------------------------------------

Warning: the commit message says the sxe2_link_update() call is moved
back into sxe2_drv_mac_link_status_get().  The diff does not touch
that function.  It adds two (void)sxe2_link_update() calls in
sxe2_event_irq_common_handler() and keeps the call in
sxe2_link_update_init().

The effect is the same for the three call sites that exist today, so
the code is fine.  Please make the message describe what the patch
does.


Patch 17/47: move PCI register read macro to common
-----------------------------------------------------

Info, pre-existing: the two macros are now next to each other and the
byte order handling does not match.

	#define SXE2_PCI_REG_WRITE(reg, value) rte_write32((rte_cpu_to_le_32(value)), (reg))
	#define SXE2_PCI_REG_READ(reg)         rte_read32(reg)

Other PMDs wrap the read in rte_le_to_cpu_32().  Not a change for
this patch, but worth a follow up.


Patch 37/47: use primary VSI ID for representor VSI
-----------------------------------------------------

Info: I accept the kernel guarantee stated in the commit message.
One loose end: sxe2_vsi_id_str() in sxe2_dump.c maps
SXE2_INVALID_VSI_ID to "NA" and is used for this exact field.  If the
primary VSI id is always valid, that branch is dead and can go.
