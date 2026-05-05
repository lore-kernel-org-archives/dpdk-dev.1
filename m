Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24691FF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 22:03:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A47994060A;
	Wed,  6 May 2026 00:03:28 +0200 (CEST)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44]) by mails.dpdk.org (Postfix) with ESMTP id 4981940275
 for <dev@dpdk.org>; Wed,  6 May 2026 00:03:27 +0200 (CEST)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-42fbf95cca8so4120786fac.0
 for <dev@dpdk.org>; Tue, 05 May 2026 15:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778018606;
 x=1778623406; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+AAjmrRigf0bGI8XoDE5Z18tp0Fxlp3wfDaTFYSxAM=;
 b=o4uqgICoHLJqNT75P7r+lldWMgttbQD91dibs+cqspJ0rqZ4SYlprFBER3HAD8Zj+o
 R69ULJWDiNdvJStUYpWuOVgmNPM/ooxoqPCjSZpCzhCNeYzRqS+jUV8y5iNb/lZjGC+R
 QCaTntMmIB63swelTmA6dxf2swZ7y/7P9QcdjDBZr2O0JR9jqWcz+J4Gv0WZQ92zn1B6
 LjXtiPwA6PBxp+8kNUqjtDmNFPU3G8/RYEp/x1dTvlyGwdTOxT1QumzgMmcs41YZH8bv
 7rrW2XuKIkel9TvhxjBYw5pOUCPbfBf9rmT4MRNIAeLkh/iC6+e4TVZ2t0cnoSWodLYK
 32RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778018606; x=1778623406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x+AAjmrRigf0bGI8XoDE5Z18tp0Fxlp3wfDaTFYSxAM=;
 b=W+6laj1kWVzQK+eEGjs23zlTdttSLWjryIqZnuIiUgcjkbTqz6kLa6yXp0Jz4adRKe
 by5SBTm9SkAbH+xvcQAKvUiZQyBi7gUVw8G3ZKLq/ffYLWW2Z4aS/oHuz2oL9ZkEQ0cj
 0yErk9csIOtQjHhWhTYIk1OB4JzRvv0ki5C8tvkIfODHswAAT8QL2XHm5Ada43yq5Cbt
 AZGfZWzt0Cnr7ZVI6Pxms8IjTCenEhI1IO3oqT+5NYz4075xZx4aqvHsaQIdKuL3aLIp
 FzzwN3qP6XOPJTY5FfYqFMY+SYOFPo4/zfiUhZBXETcs9QkwrprJf6X57ebJGV+yYd21
 gItg==
X-Gm-Message-State: AOJu0YwWECcx+1/3BANFKD3DVPc1DnuAXXLMaXtIXW3cvwYem68kXztU
 H2MShQTa/KO4SrMP3o0hwVtm/3NQ+qb+x+zoRP25nyUhxDfT19bCM6A73YQ0LhG0wUs=
X-Gm-Gg: AeBDiesldi3hvuhIPQKzxdkRPEsOhyfV/RqygsJUoxKFQRQGXlduWDtZKwQBNz2AI2G
 I3IqVP10QYNxNPmAHV+zv90JuL6Y0rjSSA585y03X8RWfdJ82nNwVqLguxnk2VRqx1MvweJJuIA
 ItjZmUP+wChLCdNqI/1LX3ifT+l6Vp+myS8UDeMI7BvSCIU1alCHtwYdu1hbOXShkvdUjY9izQa
 oZeeA1y1NV8y9G8cchduaP867/L+m1RG0pmuzYkKmNrfhciLKa18lA+YvTE3xAcVUDgCAAlUHRA
 FnS/lEQ9hYqSqotZz44ZDGZpw8752untwnF9S+F6ukBQzXdKUy+WPWJA3bVJhdi31LkJbJPWxuL
 x3hN7Tw8FERJvjUYDpPIrM0yFPDVtTAjJhDiheSU1WjGgq0CopUK/LenOP83TqM5Ya7BTsAY7x8
 aegX472X57V3L/AhZHOMbEEDAP8hfarcuzE+7tnF/gMD5N9g==
X-Received: by 2002:a05:6871:80cb:b0:434:e6e8:bb5e with SMTP id
 586e51a60fabf-434f6352982mr852620fac.9.1778018606212; 
 Tue, 05 May 2026 15:03:26 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4345452237bsm14562005fac.0.2026.05.05.15.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:03:25 -0700 (PDT)
Date: Tue, 5 May 2026 15:03:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org
Subject: Re: [PATCH 1/7] net/netvsc: retry VF hotplug indefinitely until PCI
 device disappears
Message-ID: <20260505150322.7f142753@phoenix.local>
In-Reply-To: <20260505204457.267934-1-longli@microsoft.com>
References: <20260505204457.267934-1-longli@microsoft.com>
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

On Tue,  5 May 2026 13:44:50 -0700
Long Li <longli@microsoft.com> wrote:

> After PCI rescan on Azure, the MANA kernel driver can take over 100
> seconds to probe and create the /sys/bus/pci/devices/<dev>/net directory.
> The previous fixed retry limit (NETVSC_MAX_HOTADD_RETRY=3D10, ~12 seconds)
> was insufficient, causing VF re-attach to fail with 'Failed to parse PCI
> device' on systems with slow MANA driver initialization.
>=20
> Replace the fixed retry limit with an indefinite retry that only gives up
> when the PCI device itself disappears from sysfs. This is safe because:
>=20
> - The retry uses rte_eal_alarm callbacks which are serialized on the EAL
>   interrupt thread, preventing races with VF remove or device close paths.
> - Device close (eth_hn_dev_uninit) explicitly cancels all pending hotplug
>   alarms via rte_eal_alarm_cancel and frees the context.
> - If the PCI device is removed while retrying, access() detects the
>   missing sysfs path and stops immediately.
>=20
> A periodic NOTICE log every 30 retries (~30s) provides visibility into
> long waits without flooding the log at DEBUG level.
>=20
> Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
> Cc: stable@dpdk.org
> Signed-off-by: Long Li <longli@microsoft.com>
> ---

Since this series touches lots of stuff, decided to do a more through than
normal AI review

Review of patch series: net/netvsc VF hotplug improvements (7 patches)

Series targets stale interface names, slow MANA driver probe, multi-VF
PCI devices, and adds service-reset event handling. Reviewed against
upstream main as of clone date.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[PATCH 3/7] net/netvsc: retry full probe when IB device not ready during
                       hotplug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Warning:

  drivers/net/netvsc/hn_ethdev.c (around the new ENODEV/EEXIST handling)

  The original code logged failures from rte_eal_hotplug_add at
  PMD_DRV_LOG(ERR). The patch lowers all non-ENODEV, non-EEXIST returns
  to PMD_DRV_LOG(NOTICE):

      if (ret && ret !=3D -EEXIST)
              PMD_DRV_LOG(NOTICE,
                          "Failed to add PCI device %s (ret=3D%d)",
                          d->name, ret);

  -ENOMEM, -EBUSY, -EIO and similar errors from rte_eal_hotplug_add are
  legitimate failures that operators need to see. Recommend keeping ERR
  for unrecognized error codes; only -ENODEV and -EEXIST are now expected
  outcomes worth a quieter log level.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[PATCH 4/7] net/netvsc: add NOTICE-level debug logging for VF hotplug
                       retry
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Warning:

  drivers/net/netvsc/hn_ethdev.c, multiple sites in netvsc_hotplug_retry

  The new log calls inside the readdir() loop fire at NOTICE for every
  directory entry on every retry pass:

    PMD_DRV_LOG(NOTICE, "%s: checking interface %s in %s (retry %d)", ...)
    PMD_DRV_LOG(NOTICE, "%s: device %s sa_family=3D%d not ARPHRD_ETHER, ...=
")
    PMD_DRV_LOG(NOTICE, "%s: MAC mismatch for %s: got ... expected ...")

  Combined with patch 1 (indefinite retries) and patch 5 (up to 120
  mac_retry passes), a multi-NIC VM can produce hundreds of NOTICE lines
  per VF re-attach. Per-iteration trace belongs at DEBUG; reserve NOTICE
  for one-shot state transitions (loop start, match found, give-up).

Info:

  drivers/net/netvsc/hn_ethdev.c, MAC mismatch log

  The format string and byte arguments expand the MAC inline:

      "%02x:%02x:%02x:%02x:%02x:%02x ..."
      eth_addr.addr_bytes[0], ..., eth_addr.addr_bytes[5],
      dev->data->mac_addrs->addr_bytes[0], ...

  rte_ether.h provides RTE_ETHER_ADDR_PRT_FMT and RTE_ETHER_ADDR_BYTES()
  for exactly this; using them is shorter and consistent with the rest
  of DPDK.

Info:

  drivers/net/netvsc/hn_ethdev.c, MAC match block

  The new "} else {" follows an if-branch that already ends in break, so
  the else is redundant =E2=80=94 the log can sit unindented after the clos=
ing
  brace of the if.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[PATCH 5/7] net/netvsc: retry when no matching MAC found in net directory
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Error:

  Commit message vs. code disagree on the retry budget.

  Commit message:
      "This uses a separate mac_retry counter (limit 30, ~30 seconds) so
       the main retry loop remains unlimited."

  Code:
      /* Max retries when net/ directory exists but no matching MAC found.
       * On multi-NIC PCI devices, a second VF may register later.
       * 120 retries =3D ~2 minutes.
       */
      #define NETVSC_MAX_MAC_RETRY 120

  Either the commit message or the macro value needs to be corrected so
  they agree. With NETVSC_HOTADD_RETRY_INTERVAL =3D 1s, 120 retries is
  ~2 min, not ~30 s.

Info:

  drivers/net/netvsc/hn_ethdev.c, in the new "no MAC match" block

      if (di) {
              closedir(di);
              di =3D NULL;

  DPDK style requires explicit pointer comparison: "if (di !=3D NULL)".


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[PATCH 6/7] net/netvsc: forward per-queue stats from VF device
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Warning:

  drivers/net/netvsc/hn_vf.c, hn_vf_stats_get

      if (vf_dev->dev_ops->stats_get)
              ret =3D vf_dev->dev_ops->stats_get(vf_dev, stats, qstats);
      else
              ret =3D rte_eth_stats_get(vf_dev->data->port_id, stats);

  Reaching directly into another ethdev's dev_ops->stats_get is not a
  pattern used anywhere else in DPDK (bonding, failsafe, etc. all go
  through rte_eth_stats_get). The shortcut bypasses three things the
  public wrapper does:

    - RTE_ETH_VALID_PORTID_OR_ERR_RET on the VF port_id
    - memset(stats, 0) and stats->rx_nombuf =3D data->rx_mbuf_alloc_failed
    - eth_err() return-code translation

  The memset is harmless here because the outer ethdev wrapper has
  already zeroed stats/qstats for the netvsc port. The rx_nombuf
  attribution, however, changes: previously stats->rx_nombuf was
  pre-loaded with the VF's data->rx_mbuf_alloc_failed before the VF's
  callback ran; now it's whatever was set for the netvsc port. Worth
  documenting in the commit message if intentional.

  Also, the dev_ops pointer test uses an implicit comparison:

      if (vf_dev->dev_ops->stats_get)

  Per DPDK style this should be "!=3D NULL".

  A cleaner long-term fix would be to extend the ethdev API so per-queue
  stats can be forwarded through the public path, or wrap this dispatch
  in a small helper with a comment explaining why the public API is
  insufficient.

Info:

  drivers/net/netvsc/hn_vf.c

  Some VF drivers may return -ENOTSUP or partial data when called with a
  non-NULL qstats. The patch unconditionally propagates that return,
  which could turn a previously-successful stats_get into a failure for
  netvsc users on certain VF drivers. A graceful fallback to
  rte_eth_stats_get on -ENOTSUP would preserve backward compatibility.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[PATCH 7/7] net/netvsc: handle VF recovery events for service reset
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Warning:

  drivers/net/netvsc/hn_vf.c, hn_eth_recovery_success_callback

      rte_rwlock_write_lock(&hv->vf_lock);
      if (hv->vf_ctx.vf_attached && !hv->vf_ctx.vf_vsc_switched) {
              ret =3D hn_nvs_set_datapath(hv, NVS_DATAPATH_VF);
              ...
      }

  hn_vf_add_unlocked guards the equivalent NVS_DATAPATH_VF switch with
  "if (dev->data->dev_started)" precisely to avoid routing traffic to
  the VF before queues are configured. The new callback omits that
  check. If the user calls rte_eth_dev_stop() on the netvsc port during
  the ERR_RECOVERING -> RECOVERY_SUCCESS window, this callback will
  switch the host data path to a VF whose DPDK queues may have been
  torn down. Recommend mirroring the dev_started check.

Warning:

  drivers/net/netvsc/hn_vf.c, hn_eth_recovering_callback and
                              hn_eth_recovery_success_callback

  Both new callbacks acquire hv->vf_lock as a writer directly in the
  event-callback context. The existing hn_eth_rmv_event_callback
  intentionally does not take vf_lock =E2=80=94 it defers via:

      rte_eal_alarm_set(1, hn_remove_delayed, hv);

  to break a possible lock-order coupling with the calling driver (the
  PMD that fires rte_eth_dev_callback_process may itself be holding an
  internal lock). Taking vf_lock directly inside the recovery callbacks
  introduces a different lock-ordering invariant from the rest of the
  file. Consider either deferring through rte_eal_alarm_set as well, or
  adding a comment explaining why direct acquisition is safe in the
  MANA -> netvsc invocation path.

Info:

  drivers/net/netvsc/hn_vf.c, hn_eth_recovery_failed_callback

      rte_eal_alarm_set(1, hn_remove_delayed, hv);

  The state of hv->vf_ctx.vf_attached is not checked. If RECOVERY_FAILED
  arrives after a concurrent INTR_RMV has already detached the VF, the
  alarm will fire hn_remove_delayed against an already-removed port,
  generating a spurious "Start to remove port 0" log and downstream
  unregister failures. The damage is limited because hn_remove_delayed
  takes the lock and re-checks state, but the noise is avoidable with a
  vf_attached guard before scheduling the alarm.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General notes on the series
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Patches 1, 2, and 5 together turn netvsc_hotplug_retry into a
genuinely-unbounded loop in two dimensions:

  - opendir failures retry indefinitely (patch 1, capped only by PCI
    device disappearance)
  - SIOCGIFHWADDR failures and -ENODEV from rte_eal_hotplug_add reschedule
    without incrementing any counter (patches 2, 3)
  - "no matching MAC" retries are bounded by mac_retry / 120 (patch 5)

Only patch 5's path has a hard upper bound. The other paths rely on the
PCI device eventually disappearing if the VF never comes up. On a
permanently broken VF that stays present in sysfs but never registers
a netdev, the EAL alarm thread will spin forever. Worth confirming that
this is the intended behaviour, or adding an overall ceiling (e.g., a
much higher cap than 30s but still finite) for the opendir / ioctl /
ENODEV paths.
