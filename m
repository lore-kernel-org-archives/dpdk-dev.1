Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBCBC5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 17:53:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74BF840268;
	Wed, 26 Aug 2026 19:53:37 +0200 (CEST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mails.dpdk.org (Postfix) with ESMTP id CBDD540264
 for <dev@dpdk.org>; Wed, 26 Aug 2026 19:53:36 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so1607325b3a.1
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787766816;
 x=1788371616; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LdprnvHiHJ0Mjw2//ES4E0OoBCAc/nQXYGM6fmpI9wg=;
 b=CSOnv8jKZXIMvFDmQ2vjzFp9XB6YgRaz3DQ8TKIHbmNhSyOsDPGibaCeqiUWc8+TRe
 ShgRZQyvK5OYNH35XES9TBLRdxA2HBGoVkAJOmd5LxMcVenK0y5OwJKgMHJBEbBmoaP/
 2+AQvc6YtKqrISYxuEOvtstbNM785FOQ5/07Y3H8oWGvuBlhd/jgrHySgPOcQxhZss3d
 9r34pdxfNBplgnBlTgRlhwYz6V1aTCn3bqO5jrkknni4kTygBOXJZhS2omucdBaDLizi
 AaXEFlJDjcaksSyKqBENC7zmj+bryp0Fl0xpBovKrcKDaqgCVk9YZQTHpHnmtBa8eM1s
 in5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766816; x=1788371616;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LdprnvHiHJ0Mjw2//ES4E0OoBCAc/nQXYGM6fmpI9wg=;
 b=UqHwnHMubdzZSlaXqJy7yyvnIoq/AYo4p+HBeKJNJP4Ke2vIohcw+iZL4S0Blwb/Jj
 9Bk08WYY16f6MlRlf+IoWJkhaHOShNI2Mo2VYV6vZwJ12TtRt8tRFbWnUeGse+5yDi+k
 VBDjul/78yPmDxb/o0yTcpg9DBrRpYH6P0MrKdNrCWDmP4Hs1whDSaSgC3sjZUZHeZBw
 ND7QC1C6gcWeteh5FdlEJGZvZVUfPCyYbu1KcGi6ytCYsMR7Kv604QufUMkUp7Ow0n0A
 gs/PpxIc9TI22tSK0wIIIh4kCzfIIXye3oRWEn1khUJklYwAmGm6t0ZnRPCsl3jcadI5
 abjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpR9IjiD78U1DdVUqyxE/NeIil6pBOaGZI0yA8AahJQ3sk1cbPC8vPNLEp4bvGMT5wyjrM=@dpdk.org
X-Gm-Message-State: AFuF++nX+447g/oyccR2cvY2+gsq4RQ1oxWeKur+bG2ZuqZU2AiCEJnR
 V+hESg8liAMHQD2Qe6TRZlYv8zeMwbMuqxpVA5dfP2hdXNDN4lEf+3MrdAknbXQWk70=
X-Gm-Gg: AR+sD139sOmfdEccI5Xi1WLcPAjiBoaZM8oz8kuEaCkjBkOE2N/n9w8ZIsXYMFcZF/s
 wFfo6eSg2z1QI+ANgyGqQlkQhcCieM1P3GKcV3FAcV6BOvGzGaLO5eYGKGuBztu32t+dAMOtWO9
 cBMUYePDU7GIf1iSIAe/Oov6SW5CKImB7g0/E3fRh37elRQof2zuaCuZyZcfbwufdUimhOKZNKc
 +yQS/4Yk0c9gZP3swR2J00e8x0At4/IE+KzmgtD+KzOxOFRk263Co19DXU7yDmoIrh55Nqk+CUw
 +649YDdkDuwLXSUiGDOUggfvZuL+6gHOuNhUAiR4XlLZsKSSQxGPMAStmAAB0qvbUJpAxZmmmSU
 Qp9Q00erMJYYKCJmacWONflDQGC+zsOzPbi4a9DPKRKdXwVajrOsDEEFu/IzJ/Z0mcqcmnn/KUy
 ZBQpB3ju02rSc5mMHdstdoPfx34sjA2/o53Qf0dd/PqO+/grcnDQDXpgvSQSL/gj8TOZqdshVHs
 beMzNaFxDqyXb60fW8NyZ/A173doPwZ/OhvLier
X-Received: by 2002:a05:6a00:8019:b0:84c:1cd2:142b with SMTP id
 d2e1a72fcca58-85373fb5cbemr18164200b3a.9.1787766815503; 
 Wed, 26 Aug 2026 10:53:35 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cec6515sm1219952b3a.46.2026.08.26.10.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:53:35 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:53:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Weijun Pan <wpan3636@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)"
 <humin29@huawei.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
 dev@dpdk.org
Subject: Re: [RFC PATCH v3] net/bonding: restrict secondary control operations
Message-ID: <20260826105325.1b13342d@phoenix.local>
In-Reply-To: <20260826161009.37875-1-wpan3636@gmail.com>
References: <20260823151625.18687-1-wpan3636@gmail.com>
 <20260826161009.37875-1-wpan3636@gmail.com>
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

On Wed, 26 Aug 2026 11:10:09 -0500
Weijun Pan <wpan3636@gmail.com> wrote:

> Bonding configuration and LACP state are owned by the primary
> process. Install a reduced dev_ops table in secondary processes so
> ethdev rejects control operations, and reject the bonding control
> API when called from a non-primary process. Query and detach remain
> available.
> 
> Bugzilla ID: 1900
> 
> Signed-off-by: Weijun Pan <wpan3636@gmail.com>
> ---

I would like to see link update use rte_eth_linkstatus_set() helper.
And do another check that documentation matches reality after this patch.


Overly verbose (sorry) AI review was:

Applies cleanly to main (d55ccd4), diffstat matches, and builds with
-Dwerror=true for net/bonding.  checkpatches.sh is clean.

Fixed since v2
--------------

- rte_eth_bond_8023ad_member_info(), _ext_collect_get() and
  _ext_distrib_get() are now rejected in a secondary, so they no
  longer return all-zero LACP state read out of the process-local
  bond_mode_8023ad_ports[].

- eth_dev_priv_dump is no longer in the secondary ops table, so
  dump_lacp() cannot walk that array from a secondary either.

- The two near-identical primary-process helpers are collapsed into
  bond_check_primary().

- The stray double blank line in rte_eth_bond_member_add() is gone.

- The programmer's guide now states the secondary datapath is a
  stub, which matches bond_ethdev_rx_secondary() and
  bond_ethdev_tx_secondary().

The set of API gated in this version looks right to me.  Every
mutator in rte_eth_bond_api.c and rte_eth_bond_8023ad.c is covered,
rte_eth_bond_free() is deliberately left open for detach, and the
getters that are left ungated (mode_get, primary_get, members_get,
xmit_policy_get, 8023ad_conf_get, 8023ad_agg_selection_get, ...) all
read bond_dev_private, which is in shared memory.  Omitting dev_stop
from secondary_dev_ops is also correct: rte_eth_dev_stop() writes
dev->data->dev_started, and rte_eth_dev_close() has its own
secondary path so detach still works.

Warnings
--------

1. link_update is retained in secondary_dev_ops, so dev_link is now
   written from two processes without using the ethdev accessors.

   bond_ethdev_link_update() assigns ethdev->data->dev_link.* field by
   field, and dev_link lives in the shared rte_eth_dev_data.  With
   .link_update present, any rte_eth_link_get() in a secondary
   republishes the primary's link record:

	if (dev->data->dev_conf.intr_conf.lsc && dev->data->dev_started)
		rte_eth_linkstatus_get(dev, eth_link);
	else {
		if (dev->dev_ops->link_update == NULL)
			return -ENOTSUP;
		dev->dev_ops->link_update(dev, 1);
		*eth_link = dev->data->dev_link;
	}

   Readers on the LSC path use rte_eth_linkstatus_get(), a 64-bit
   atomic load, so a reader can observe a torn combination of
   link_status, link_speed and link_duplex.

   The driver should use rte_eth_linkstatus_set() rather than touching
   dev->data->dev_link directly.  That is one atomic exchange of the
   whole word, which closes the window on the primary path as well and
   makes the secondary's recomputation harmless -- it derives the same
   value from the same shared member state.  Build the result locally
   and publish once:

	struct rte_eth_link link;

	rte_eth_linkstatus_get(ethdev, &link);
	link.link_speed = RTE_ETH_SPEED_NUM_NONE;

	if (ethdev->data->dev_started == 0 ||
			bond_ctx->active_member_count == 0) {
		link.link_status = RTE_ETH_LINK_DOWN;
		goto out;
	}

	link.link_status = RTE_ETH_LINK_UP;
	...
   out:
	rte_eth_linkstatus_set(ethdev, &link);
	return 0;

   Seeding from rte_eth_linkstatus_get() keeps link_duplex and
   link_autoneg for the modes that never set them; the interior
   "return 0" paths become "goto out".

   The rest of the driver has the same problem and is worth a
   preparatory patch: bond_ethdev_start() and bond_ethdev_stop() set
   link_status directly (rte_eth_bond_pmd.c:2068, 2220), as does
   bond_ethdev_lsc_event_callback() at 3101, and
   bond_ethdev_member_link_status_change() writes link_autoneg and
   link_duplex at 1439.  Nothing in bonding currently uses the
   accessors.

2. The documentation does not match what the code now rejects.

   The new prog_guide paragraph lists configure, start/stop, queue
   setup, member changes, mode, RSS, MAC, MTU and rte_flow.  It omits
   everything else the patch turns into an error in a secondary:

	- all of rte_eth_bond_8023ad_* except conf_get and
	  agg_selection_get, including member_info(),
	  ext_collect_get() and ext_distrib_get(), which are queries
	- dedicated queue enable/disable
	- xmit policy, link monitoring interval, link up/down
	  propagation delays, primary member selection
	- stats reset, promiscuous and allmulticast, VLAN filter,
	  private dump

   The commit message and the release note both say "query ... remain
   available", and the guide says "supported query and detach
   operations", so a reader would reasonably conclude
   rte_eth_bond_8023ad_member_info() still works in a secondary.  It
   no longer does.  Please say explicitly which queries survive
   (device info, stats, link, RETA and RSS hash config, bonding mode,
   members, and the LACP configuration) and that LACP runtime state
   queries do not.

   Worth stating the supported teardown too: rte_eth_dev_stop()
   returns -ENOTSUP in a secondary and rte_eth_dev_close() is the
   detach call.  A secondary that does the usual stop-then-close will
   now see an error from the stop.

3. Release note is in the wrong section.

   This changes the behaviour of already-exported functions -- calls
   that previously returned 0 now return -ENOTSUP or -1 -- so it
   belongs under "API Changes", not "New Features".  Same comment as
   on v2.

4. bond_ethdev_stats_get() ignores the rte_eth_stats_get() return.

   Pre-existing, but the patch puts .stats_get in secondary_dev_ops,
   which makes the failure case realistic:

	struct rte_eth_stats member_stats;
	...
	for (i = 0; i < internals->member_count; i++) {
		rte_eth_stats_get(internals->members[i].port_id,
				  &member_stats);
		stats->ipackets += member_stats.ipackets;

   eth_stats_qstats_get() runs RTE_ETH_VALID_PORTID_OR_ERR_RET before
   the memset, so on -ENODEV member_stats is left untouched.  On the
   first iteration that is uninitialized stack; on later iterations it
   is the previous member's counters, double-counted.  A secondary
   that attached to the bonding device but did not probe the member
   ports (blocklist, or members added by the primary after the
   secondary started) hits exactly this.

	ret = rte_eth_stats_get(internals->members[i].port_id,
				&member_stats);
	if (ret != 0)
		continue;

   Better as a separate fix ahead of this patch, since it is not
   secondary-specific.

Info
----

- Three of the 8023ad functions declare a second int purely for the
  new check while an existing one is right there:

	struct port *port;
	int res;
	int ret;

	ret = bond_check_primary(__func__, -ENOTSUP);
	if (ret != 0)
		return ret;

  ext_distrib_get() and ext_collect_get() reuse err instead, which
  reads better.  Reusing res in ext_collect(), ext_distrib() and
  ext_slowtx() would drop three declarations and make the series
  consistent.

- rte_eth_bond_api.c passes -1 and rte_eth_bond_8023ad.c passes
  -ENOTSUP.  Each matches its own file's existing convention, so this
  is defensible, but a caller cannot distinguish "wrong process type"
  from "bad port id" in the api.c cases.  -ENOTSUP everywhere would
  be clearer if you are willing to change those return values.

- The <stdbool.h> addition to eth_bond_private.h is unrelated to this
  change; bool is already used at line 184 and was working by
  transitive include.  It is a real fix, just not this patch's.

- Dropping eth_dev_priv_dump entirely costs some debuggability.  Only
  dump_lacp() touches the process-local array; dump_basic() reads
  bond_dev_private, which is shared.  Keeping .eth_dev_priv_dump in
  secondary_dev_ops and skipping the LACP section in a secondary
  would let a secondary still dump mode, members and offloads.
