Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E616BC531C9
	for <dpdk-dev@archiver.kernel.org>; Sun, 26 Jul 2026 17:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0AEF40269;
	Sun, 26 Jul 2026 19:32:48 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 803CB40150
 for <dev@dpdk.org>; Sun, 26 Jul 2026 19:32:47 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-848d21bbaffso2045163b3a.0
 for <dev@dpdk.org>; Sun, 26 Jul 2026 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785087166;
 x=1785691966; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uNEbUnrdO5jmlemdWIdo/s3l0kSAaHh7wLDJ5H33nFw=;
 b=ycfSOW8oj/zbofoLyqZAebqEs66BwbMdMarMnILHHhMP111P6YY8a+xX9TgtJI+DLX
 SqMVmUgtDscf/v3VWdvDkjWAVtWQveQXEUtbIGgn3WwdvmSJK+mtZGK7zz6gyXii6y9r
 /FxvU0QVNX3RfsG/kNdSQKjdVT/AayAB86ryLugLZ2Xq2HRXP2YN++98pNryzyxKjXmn
 0ie4ksw1rbvJj041nRoJ7bmAyxuWeLUkhEa7DsJwMrhUUIoQFMKrMk6wq9nSaiGIGxpH
 z0xjSE91tbVtEW7gbQguW+6CImJ+QXKz4fEhDK6vBSvuTW3tQZczq0iRfTHmUKY3sgre
 v8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785087166; x=1785691966;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uNEbUnrdO5jmlemdWIdo/s3l0kSAaHh7wLDJ5H33nFw=;
 b=Pwnx/ijT8YRhVlf7DWdB54nHupd7f3mNf/fNtUy71/fekZBUdmE45hPKxNZqVuJqqr
 LYAmRwI1OQDDLFOWMRt2NdrUEjAg+6z0muvz+YRNEz2cdmXf6eFdLg2cNugPyiGwRmm0
 DfGwvLNIJ2BNYjqTG7QWCp7iIJbwGnQVH9W3hYMaMNbjngsP9Rbh/iswpcsFtFQWfjXh
 v/uEZFaRvlIWxC6yMXPwJ+wEW74ITCEcM7V2Wg4b29p+gf1wJGd1Wd22g/nie+qbRoN0
 vYACvgoTBexo2dwXHN3raKIDA7GY31o1r9ni3lq6BGoro0QHL9Rc8ALb/8qNe1bP+IrP
 rCHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGE1TdQNaMNqUZ4XCCq83Jwytrrh6wynbQvny4maoiZ0OoQraE3CL0iV2il3X7oLyp2bM=@dpdk.org
X-Gm-Message-State: AOJu0YwaDa3A4NtSmkhnFN1BT9vg+g9uzn04W/TyHj2Cl2glrU3L07+v
 CjgoT30AyinuRJjGO3igPcwhjvh0BHHrUb5g2mI6SbEphx+AmyBov+mPGlbfzzZzkPo=
X-Gm-Gg: AR+sD12dIrXubLAwvT+V3Gz/8bMUqKcJ6XbPBh4ZjEEbSw5wbi/Gqo5LEDsjwcas0Qh
 uoQUBTH6t758/gORBxlgK8N390H/nJlBlh8u/KCq6FD5OnkLnIVDGxNPPoZ2xeswZP2ajQE6ymJ
 mb0wOl0ClTa19dLXSlCnyYcyqEl3PB4lUw6KR1VJtHfWvjPuCTsU6uObsXH/ymtA6B5fkJJtcad
 btK05izJAHxAsufRJtdVTLuBJ6ZSHpdzYYNuX4aSE3YACkxjWNKWJPST2kYtBwSEAzDPEanpQGZ
 FlNC/8Tk0++AafP84nWC1Dz1GmhxdoLN9Om2YcUV3/1DrmZWRKmT+JNz8HyQ0tXA6DmQfgp89pf
 0TMdEANDAA8PDbF6Hza4qUBzPHjA2HanhRpgWtx5sSeU5+IgVJ0goiQ1cHsO688R1qbebzHxzqE
 QwH+vGf1JJ8dOpNTjGR4DKZBU7peqwj/U98zqvsU6/nro=
X-Received: by 2002:a05:6a20:9f46:b0:3c4:46ca:3350 with SMTP id
 adf61e73a8af0-3c67dae9748mr5792306637.6.1785087166419; 
 Sun, 26 Jul 2026 10:32:46 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5a04b2sm21244328eec.28.2026.07.26.10.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 10:32:46 -0700 (PDT)
Date: Sun, 26 Jul 2026 10:32:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Weijun Pan <wpan3636@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 dev@dpdk.org
Subject: Re: [RFC PATCH] net/bonding: reject control operations in secondary
Message-ID: <20260726103243.437be4b2@phoenix.local>
In-Reply-To: <20260708174204.72574-1-wpan3636@gmail.com>
References: <20260708174204.72574-1-wpan3636@gmail.com>
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

On Wed,  8 Jul 2026 12:42:04 -0500
Weijun Pan <wpan3636@gmail.com> wrote:

> The bonding PMD installs safe secondary burst functions when real
> secondary datapath support is not available. This avoids crashes, but
> secondary processes must not be able to change bonding control-plane
> state if the primary process is the owner of that state.
> 
> Reject bonding control-plane operations from secondary processes. This
> keeps bonding configuration and LACP state owned by the primary process
> and is a prerequisite for future limited secondary datapath support.
> 
> Bugzilla ID: 1900
> 
> Signed-off-by: Weijun Pan <wpan3636@gmail.com>
> ---

This is the right path, but AI review found things that need work.

Review: [RFC PATCH] net/bonding: reject control operations in secondary
Message-Id: <20260708174204.72574-1-wpan3636@gmail.com>

Verified against DPDK main (38f72e500b3b). Applies cleanly, builds clean
with -Dwerror=true, checkpatches.sh reports no issues.

The intent is right, but the checks are placed one layer too low, which
means the stated goal -- "secondary processes must not be able to change
bonding control-plane state" -- is not actually met for dev_configure,
and one legitimate secondary path is broken.

Errors
------

1. rte_eth_bond_pmd.c: bond_ethdev_configure()

   Returning -ENOTSUP from the dev_configure op does not prevent the
   secondary from mutating shared state -- it makes it worse.
   rte_eth_dev_configure() has already done this before it calls the PMD
   (lib/ethdev/rte_ethdev.c):

     1364  memcpy(&orig_conf, &dev->data->dev_conf, ...)
     1587  diag = eth_dev_rx_queue_config(dev, nb_rx_q);
     1596  diag = eth_dev_tx_queue_config(dev, nb_tx_q);
     1606  diag = dev->dev_ops->dev_configure(dev);
     1646  reset_queues:
     1647    eth_dev_rx_queue_config(dev, 0);
     1648    eth_dev_tx_queue_config(dev, 0);

   On the -ENOTSUP the code jumps to reset_queues, and
   eth_dev_rx_queue_config(dev, 0) calls dev_ops->rx_queue_release() on
   every queue and rte_free()s dev->data->rx_queues, then sets
   nb_rx_queues = 0 (lib/ethdev/ethdev_private.c:455). Those are the
   primary's queues in shared memory. bond_ethdev_rx_queue_release() /
   bond_ethdev_tx_queue_release() are not gated by this patch, so they
   run.

   Net effect: a stray rte_eth_dev_configure() from a secondary now
   destroys the primary's Rx/Tx queue arrays instead of being rejected.

2. rte_eth_bond_api.c: rte_eth_bond_free()

   This blocks the only supported way for a secondary to detach its
   local port. rte_vdev_uninit() is process-local and works in a
   secondary; bond_remove() has a deliberate secondary branch
   (rte_eth_bond_pmd.c:4003):

     if (rte_eal_process_type() != RTE_PROC_PRIMARY)
             return rte_eth_dev_release_port(eth_dev);

   That branch is now unreachable through the public API. Compare
   bond_ethdev_close() ten lines away (2310), which returns 0 rather
   than an error for non-primary, and the comment in
   rte_eth_dev_close() explaining that a secondary must be able to
   close to release its process-private resources. Teardown paths need
   to stay callable; only reconfiguration should be rejected.

Warnings
--------

3. Structural: use a separate ops table rather than 17 in-function
   checks.

   bond_probe() already installs the ops table for the secondary
   explicitly (rte_eth_bond_pmd.c:3889):

     eth_dev->dev_ops = &default_dev_ops;

   ethdev already returns -ENOTSUP for every one of these ops when the
   pointer is NULL -- dev_configure (1347), dev_start (1801),
   rx_queue_setup (2307), promiscuous_enable (3027), mtu_set (4400),
   reta_update (5007), mac_addr_add (5415), mac_addr_remove (5479),
   and so on -- and it does so *before* touching dev->data, which is
   exactly what fixes finding 1. Defining

     static const struct eth_dev_ops secondary_dev_ops = {
             .dev_close         = bond_ethdev_close,
             .dev_infos_get     = bond_ethdev_info,
             .link_update       = bond_ethdev_link_update,
             .stats_get         = bond_ethdev_stats_get,
             .reta_query        = bond_ethdev_rss_reta_query,
             .rss_hash_conf_get = bond_ethdev_rss_hash_conf_get,
             .eth_dev_priv_dump = bond_ethdev_priv_dump,
     };

   and assigning it in the secondary branch of bond_probe() gets you
   identical semantics with one hunk instead of eighteen, and no
   runtime check on the primary's path.

4. Wrong polarity. All three helpers test

     rte_eal_process_type() != RTE_PROC_SECONDARY

   The established idiom is != RTE_PROC_PRIMARY: 357 occurrences under
   drivers/ against 3 of the form used here, and both existing checks
   in this driver (bond_ethdev_close at 2310, bond_remove at 4003) use
   the primary form. As written, RTE_PROC_AUTO and RTE_PROC_INVALID
   fall through to the permissive path.

5. Three byte-identical static helpers in three files
   (bond_8023ad_primary_only, bond_api_primary_only,
   bond_ethdev_primary_only). One static inline in
   eth_bond_private.h.

6. The helper's return value is computed and discarded:

     if (bond_8023ad_primary_only(__func__) != 0)
             return -ENOTSUP;

   Either propagate it (ret = ...; if (ret != 0) return ret;) or make
   the helper return bool and name it accordingly.

7. Coverage gaps. flow_ops_get is not gated, so rte_flow_create() /
   rte_flow_destroy() from a secondary still mutate bonding state.
   rx_queue_release / tx_queue_release are ungated while the
   corresponding setup ops are gated -- see finding 1 for why that
   combination bites.

8. No documentation. This changes the observable behaviour of exported
   API, but doc/guides/prog_guide/link_bonding_poll_mode_drv_lib.rst
   says nothing about multi-process, and
   doc/guides/rel_notes/release_26_07.rst is not touched. The guide
   needs a short section stating which operations are primary-only.

9. Bugzilla ID 1900 is cited with no Fixes: tag and no
   Cc: stable@dpdk.org. If 1900 is a crash being fixed, both are
   needed. If this is groundwork for secondary datapath support, say
   so and drop the implication.

Info
----

10. Statements are inserted ahead of the declarations in every touched
    function. Legal under c11, but it inverts the DPDK function layout
    (declarations, blank line, statements) throughout. Folding the
    check into the existing declaration block would avoid it; the ops
    table in finding 3 avoids it entirely. Also, rte_eth_bond_api.c
    gains a double blank line after bond_api_primary_only().

11. rte_eth_dev_stop() resets that process's fast-path ops to the dummy
    functions before calling dev_stop (rte_ethdev.c:1819). With
    bond_ethdev_stop() now returning -ENOTSUP, a secondary that calls
    stop ends up with a dead local datapath, dev_started still 1, and
    no way to restart since dev_start is also gated.

Given findings 1 and 2, no Reviewed-by on this revision.
