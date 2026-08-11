Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7DEC5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 20:09:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A489D40298;
	Tue, 11 Aug 2026 22:09:22 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 767B34021E
 for <dev@dpdk.org>; Tue, 11 Aug 2026 22:09:21 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so4092605ad.1
 for <dev@dpdk.org>; Tue, 11 Aug 2026 13:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786478960;
 x=1787083760; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=50BX7E9u3T7kMY/FkEfh7Y+CM1FJ4HRuRV05QsESYv4=;
 b=DZR+6962rxXQQJA5Mkc6yDcHnSlYCsmNRyuCjYP0qI2VptGj+D1eUwdIcwxF50GAX8
 0fqnOKrk+mRYb3EAY3UDaA5qnxjwkN1D4K69Oz3ehBChBUQ7VXf3ADR+lVg8mDjzg5Em
 Wn58Y8UGG4hJXnNrYlF29V4Akg6ALUvc8t9hehC9rh/OcOplrJxSe07v7HjyBbLPd/g7
 p+YvFf35oYSF5SfxloC+o/TbM/SP8ovVSmDhpdUWqGq3oLanv3O+ZkYCwsrV79TY0LpV
 Xmrcz4gSS7ZlIA9qJ16eZRXxjzB8Dy7L87icjMC4WNVkbba5owgROm54BiyoJ8WreHGB
 h/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786478960; x=1787083760;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=50BX7E9u3T7kMY/FkEfh7Y+CM1FJ4HRuRV05QsESYv4=;
 b=AVdgN1U9qr0kQkh831WJiufbBJ6wIb3ea9607nzwsgzPbcKoUf1yREDkGVU/hyDL7N
 6qV1BB3YrNZRTaPA4CXLuDV0/MNhBWVfa9pOSSH4rhS9ufTeEVxfYb93EayksyI4pgcp
 P4XHDfRuXlLw57l2yn3c35RNfOgfuYhnWzsIsWVA7T8gW2IWk9sgmWQNO5gLV+dFdegP
 yA5tD3lkdVMB1lx1nl61Xa6SYBXAyYPfsTkeUUMSkbHVt1CPkIA/VybNokvcuAUJITfs
 /PK6fhDgccaM0zTJ8K3k1xKDulRcpOlaqRth0sWpgTpwnP372aleZ6sEL9WfiCgS5tzc
 NAHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0sPzITwP1qg1URGPBiNnVeP3O85gpE2Tf7QiELcrsdVG2IkF9vEtsxJvE6fiH55XIsXM=@dpdk.org
X-Gm-Message-State: AOJu0YyZFwXzL9psbM7kaiTBtlHEJHLHxt1CaAsbm43mZY/HJqB5v+t6
 85zSi/1YxlJ+RESkRPjhgAqNJVSFFQijqg9bmhuOmTNeOxHOhEco5xlTn4hWLXpSuvE=
X-Gm-Gg: AR+sD11TYKdd6xwhuR8FJ4eLv5bNvWmi9pbxWbz482ThGurLRI1TyRq8q2I8Yxy56tB
 F+yVW8N3ZZyaCGGhAEdToFynM4PcVa0OCJn/LRreA2lDykxBbdbDEQ5kr1clwj0HTUkC2n7VvB8
 /5A50mbtEVpwvDF/zIV/VpgW+mV6l/9lt+fY8Ik6rgiUgXfjxHS903s8M0dHjzpKXhCza2+jKSN
 ERI2ar0E158PJNrN7uSuP53xzhAsbsuXQ3p8RM6L07SLuk7q2KZCGs8f62O1KsxUXQdn3xtmzWG
 +d0JZkhXqg88VH/DefflXlbIJuuLzg4UOR+2VukN2PXVFFS2jdF8nfC6+p/A4zwgIiNVwJAFR3f
 bbks1tevHVpGWhar0Fr/iZFlEiBPaoUuKfqE0gaCjW9fIuxg4dHHH7rwYhLOl/Tv4f1lWhjWPYt
 Iicb1iyv6yDmGoCSlWPE+9kZunpLqqrmP84p+Yq579VcEn5vSy77YY3JomH8JrEJYhaPph1ZHnj
 PEtE/gIV02WfUCPQNZ0fjmMn7yjug==
X-Received: by 2002:a17:903:1b50:b0:2ca:53f7:3c69 with SMTP id
 d9443c01a7336-2d32da4e721mr36443895ad.9.1786478960183; 
 Tue, 11 Aug 2026 13:09:20 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf628e0edsm2360012eec.18.2026.08.11.13.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 13:09:19 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:09:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: hemant.agrawal@nxp.com, dev@dpdk.org
Subject: Re: [RFC 00/11] Device unplug and bus cleanup refactoring for NXP
Message-ID: <20260811130917.3fb16b5b@phoenix.local>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
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

On Thu, 23 Jul 2026 15:53:48 +0200
David Marchand <david.marchand@redhat.com> wrote:

> Hello Hemant,
> 
> This is a followup to the refactoring started in 26.07.
> 
> I took some time with my best AI friend to cleanup DPAA and FSLMC bus
> drivers.
> 
> Like the last time, only compilation has been checked.
> I have no hardware to test runtime.
> 
> One thing that could be broken is either the order of devices
> initialisation, or bugs in the device filtering that I tried to
> simplify.
> 
> I think it is worth testing and fixing, as it will make the two NXP
> bus drivers similar to other bus drivers (but keep the special IO devices
> handling internal to the FSLMC bus for example).
> 

Detailed AI review spotted some things.

Review of [RFC 00/11] bus refactoring for NXP buses

Reviewed against DPDK main (c1a46b9), applied with git am, cross-built
with config/arm/arm64_dpaa_linux_gcc -Dwerror=true.

Patch 02/11: bus/dpaa: allocate interrupt during probing

Error: fd leak on the dpaa_setup_intr() failure path.

  ret = dpaa_setup_intr(dpaa_dev->intr_handle);
  if (ret != 0) {
          ...
          goto release_intr;
  }
  ...
          dpaa_close_intr(dpaa_dev->intr_handle);
  release_intr:
          rte_intr_instance_free(dpaa_dev->intr_handle);

dpaa_setup_intr() opens an eventfd and stores it with rte_intr_fd_set()
before calling rte_intr_type_set().  If rte_intr_type_set() fails, the fd
is already installed in the handle, but the goto lands past
dpaa_close_intr(), so the instance is freed with the fd still open.
Move the label above dpaa_close_intr(), or close the fd inside
dpaa_setup_intr() on its own error paths.

Warning: error propagation lost in dpaa_bus_cleanup().  The old code
returned -1 when drv->remove() failed; the rewritten loop does
"rte_errno = errno; goto next;" and the function unconditionally returns
0.  The local "ret" is also assigned and never read afterwards.  This is
transient (patch 03 replaces the body with rte_bus_generic_cleanup())
but each commit should stand on its own; track the failure in a variable
and return it.

Info: jumping into the middle of an if-block ("release_intr:" inside the
"if (ret != 0)" body) is legal but hard to follow.  A separate error
block would read better.

Patch 04/11: bus/fslmc: fix memory leaks in scan

Warning: fslmc_bus_remove_device() is described as fully freeing a
device, but dev->device.name is strdup()'d in scan_one_fslmc_device()
and never freed here or anywhere else.  Same gap in fslmc_free_device()
added by patch 11.  Since this patch is specifically about scan-time
leaks, freeing the name belongs here.

Patch 07/11: bus/fslmc: refactor device filtering for multiprocess

Error: allowlist mode is broken by moving the ignore test into scan.
scan_one_fslmc_device() now calls rte_bus_device_is_ignored(), which in
RTE_BUS_SCAN_ALLOWLIST mode returns true for every device lacking an
explicit RTE_DEV_ALLOWED devargs.  A single "-a fslmc:dpni.1" sets
rte_fslmc_bus.conf.scan_mode to ALLOWLIST (eal_common_devargs.c:349),
after which dpbp/dpcon/dpci/dprc/dpdmux/dprtc are dropped at scan time.
Those control objects are not probed by a driver; they are initialised
by fslmc_vfio_process_group(), so dropping them at scan leaves the bus
non-functional.  fslmc_filter_control_devices() applies the same test to
DPMCP and DPIO, so allowlist mode also fails "No MC Portal device found"
(-ENODEV).  The old code tested only devargs->policy == RTE_DEV_BLOCKED,
and the generic probe loop already skips ignored devices at probe time,
which is why allowlists worked before.

Error: the DPIO split drops the only DPIO on a primary process.  The old
code guarded the split with "dpio_count > 1":

  if (!is_dpio_in_blocklist && dpio_count > 1) {

The new helper has no such guard, so with exactly one DPIO,
last_index == 0, current_device == 0, and the primary branch removes it:

  } else if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
                  current_device == last_index) {
          fslmc_bus_remove_device(dev);

Restore the dpio_count > 1 condition.

Warning: when a DPMCP is blocklisted, surplus MPORTAL devices are left
in the bus list.  fslmc_vfio_process_group() now breaks out of the
MPORTAL loop after the first device.  When is_dpmcp_in_blocklist is set,
fslmc_filter_control_devices() skips the split, so more than one MPORTAL
can remain and the extras are never removed.  The previous loop had no
break and removed all of them.

Patch 11/11: bus/fslmc: use generic cleanup

Error: cleanup ordering makes fslmc_vfio_close_group() a no-op.

  rte_bus_generic_cleanup(bus);

  ret = fslmc_vfio_close_group();

rte_bus_generic_cleanup() unplugs every device, calls
rte_bus_remove_device() and then bus->free_device(), emptying
rte_fslmc_bus.device_list.  fslmc_vfio_close_group() then iterates that
now-empty list, so fslmc_close_iodevices() is never called for DPIO,
DPCON, DPCI, DPBP or DPDMUX; only fslmc_vfio_clear_group() still runs.
Call fslmc_vfio_close_group() before rte_bus_generic_cleanup().

Warning: the return value of rte_bus_generic_cleanup() is discarded.  It
reports unplug failures via -1/rte_errno; fslmc_cleanup() overwrites
"ret" with the fslmc_vfio_close_group() result and loses it.

Warning: fslmc_free_device() only calls free().  It does not release
dev->intr_handle and does not decrement fslmc_bus_device_count[], both
of which fslmc_bus_remove_device() handles.  Devices torn down through
the generic path therefore leave the per-type counters permanently
stale.

Info (01/11): removing the "struct rte_dpaa2_device *dev" declaration
from the process_once block leaves a stray blank line at the top of the
block in rte_fslmc_scan().

Info (06/11): dev_types[] is a non-static, non-const local array, so it
is rebuilt on the stack for every device.  Make it "static const".

Info (06/11): the sscanf() return value is unchecked, and the new
prefix-based match is weaker than the old strtok() guard.  A name such
as "dpni." matches the prefix, leaves dev_id pointing at "", sscanf()
fails, and the device is registered with object_id 0 -- colliding with a
real dpni.0.  The old code rejected it because strtok(NULL, ".")
returned NULL.  Check that sscanf() returns 1 and skip the device
otherwise.
