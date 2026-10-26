Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20565606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=PfdyulYw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F2D8402A3;
	Mon, 26 Oct 2026 18:13:55 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 9704F40275
 for <dev@dpdk.org>; Mon, 26 Oct 2026 18:13:54 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so2121184a91.2
 for <dev@dpdk.org>; Mon, 26 Oct 2026 10:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1793034833;
 x=1793639633; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tQNb/6bvtv35zUELbMDITCde2Hq5DY3kmbURv9mNzl4=;
 b=PfdyulYwLysspQerKsM2m2Jbbgg4gouBPkvYukOmFJb+6aZShWXmoVnTVeeurmbZgy
 vUiaNBgQBltn3Ea+5/fhn3NBTGx/ft2waYmCGL9CamnQ8kTlIZompBXskMlF13LX7ZIG
 2fgJm/QyZ3DRTGG9WD4edUq0SichDvKx5YxtgE0XKJCDWra9EVCZLDG2Xt+ViHCiPzQ0
 lTvF3oNghJJJLcrLXnZTNgHhmwe37pt8ld8QduKINOdNXT+S7qHS06uScgxqgYr8Eyiq
 I0db1sD0Ek8aKLV7On1O7H6oAbLzfd4zTSfzMywKjxXIyN+64Gc/1mg/p46DtRaByXFT
 +laQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793034833; x=1793639633;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tQNb/6bvtv35zUELbMDITCde2Hq5DY3kmbURv9mNzl4=;
 b=l9L0OGu7EbUshDtWt0phlUaQyvvVaVcwr3dq3ittzzyKOB7R4sAzh1G0/zT4iE4RWo
 I0+FcI61o4hSsqXrnV+GJxqyY8OO+ZUwNcOPH7XL8r6pboAmGYe9adXHKstbZDpiPPLy
 2cfB+Myd/Q20c+fkTBbr5FdM1jnIUk4yCe1eGcNidPeUXvQgzfI45AiL3jnFP79wQO+l
 X0QSgHAx0vb+jWu82W8e/V6KG7GInKNymh5IhSVQbk8jSYhmZx2OLOVEuHZynA2CgIDr
 PF12m8n1NP8IbgKwE81i4VFVcSs5MN/Y2T56t02uRtIf+VDFqYBH8pyyLLXN2rF7khb2
 v/VA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwq4OystSg/+31lwK3iQkBIPGLb4gF+Vs+tPEQu/k7FTn1VIOdwbnt1EHZpN56SwrDj2VA=@dpdk.org
X-Gm-Message-State: AFq9FYKWe47FINUCP9bKG0eITQ0KLEgB8+A6pH/8ajUgf6A8Exo6tPpj
 mwUJ0IMYtspv+YmXIWfND8M9IXDLc6Sp34HYx5DMInH+gmaAjKfvnPrjBo6sSyEQpPg=
X-Gm-Gg: AYBFou1OrP9FIjKPJ1QDMXqTA2LaVzHcQn6xtYiXVXo7m93GI03ysMk7wu50m3316m9
 viW8mzsQ0EIOMejV0vwiuqRxzLSNoV/CkA5sT5E1HhXdIs6h45gys0ScmWBW3hq2j3nnSel4rfJ
 ycSpVuwuLhYVW9gCHDlmMLgaECjmm0Yckh5rp29bmM+Vxy7G2AG35FGNVuJFnwwfKuf7T0X3Kku
 lFt4Fk1RNFtsejHpPBFBpOCvrdwncSdP56dBMdwlOza7s9DM44CHbPG90MV4aPwvGkRqVzJir/s
 Ttfi4txlUr2i4wt0ylIdQYIT/3IjD1Qri5mPendUgAEcV6df0S6vuJl28BC6YyF1UPuWuX8+7iA
 hVEdN75QkWTfzqKnyhRbOnsVjEuv1HD87NerYJWKIZZ1wtmv/FjUIPQYsNN43mLZKkTTnzOJ065
 Up2+3D/SvOjwXOeOEKIbqi3ZMeypn5UlvHom89KgYKUuqK0DXn7TeoHCJQvDrkQmHmmfU90ukJ3
 ne8Le7WnTJRjyGkFwHFuE/1y904TWP0ucdlIpJdH6wdioXCxxulHpAwYgdU4rPtr12KXJcHDlbs
 riyBkoLFheSyPqSiOZxt3A==
X-Received: by 2002:a17:90b:3c05:b0:3ac:a7ee:6780 with SMTP id
 98e67ed59e1d1-3adeafcf072mr5720909a91.66.1793034833075; 
 Mon, 26 Oct 2026 10:13:53 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adeba31797sm6818151a91.1.2026.10.26.10.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:13:52 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:13:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 <dev@dpdk.org>, <stable@dpdk.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH] net/mlx5: move to polling for LSC interrupts
Message-ID: <20261026101348.497e2caa@phoenix.local>
In-Reply-To: <20261026160400.1290443-1-dsosnowski@nvidia.com>
References: <20261026160400.1290443-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 17:04:00 +0100
Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:

> mlx5 networking driver on Linux implemented LSC interrupts
> by listening on netlink events.
> This method is unfortunately not reliable enough,
> because of linkwatch mechanism. It can delay link up/down events
> for up to ~1 second. This introduces unnecessary delay
> when mlx5 ports are used with DPDK bonding driver for examples.
> 
> This patch addresses that by migrating LSC checks
> to polling on link status using ETHTOOL_GLINK command.
> This ethtool command, implemented by mlx5 since kernel 4.14,
> will always get the current link status.
> As a side effect it is also flushes the pending link watch events.
> 
> Fixes: 17f95513adca ("net/mlx5: fix link status change detection")
> Cc: dmitry.kozliuk@gmail.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> ---

Agree that 1s delay is bad for bonding, there are historical reasons for
link watch. With some old NIC's the PHY would stream up/down on loose
cables causing DoS on the machine. If you are using LSC for bonding
and implementing LSC in driver, you might want to consider some rate
limiting.

AI review showed some issues.

[PATCH] net/mlx5: move to polling for LSC interrupts

Applies cleanly to main (a635140). Moves Linux LSC detection from
netlink RTM_NEWLINK to a 100ms EAL alarm polling ETHTOOL_GLINK.

Warning

1. Poller stores a partial, non-atomic dev_link.

lsc_intr_check_links() copies dev->data->dev_link, flips only
link_status, and writes the struct back with a plain assignment.
mlx5_link_update() (now using rte_eth_linkstatus_set(), an atomic
exchange on val64) can run concurrently from an application thread,
so the read-modify-write can lose that update. On link up, speed and
duplex are left at whatever the last link-down stored. The poller
also ignores IFF_UP while mlx5_link_update() reports
IFF_UP && carrier, so the two paths can disagree.

Keep the cheap carrier probe, and on change refresh the full record
through the existing path:

	ret = mlx5_link_carrier_get(dev);
	if (ret < 0 || ret == dev->data->dev_link.link_status ||
	    mlx5_link_update(dev, 0) <= 0) {
		devs[i] = NULL;
		continue;
	}

2. Polling cost on the host.

ETHTOOL_GLINK runs under rtnl_lock in the kernel. This is 10 Hz per
started port with lsc=1, including representors in switchdev setups,
per DPDK process. The adaptive period only reacts to latency seen by
the DPDK interrupt thread, not to rtnl contention imposed on the rest
of the system. Was this measured with a large number of representors?

The delay 17f95513adca worked around was IFF_RUNNING lagging the IB
port event. With the query now done via ETHTOOL_GLINK (reads carrier
and syncs linkwatch), going back to IBV_EVENT_PORT_ACTIVE/ERR on the
existing shared async handler and querying carrier there would give
immediate events without polling. Please explain why that was not
chosen, or use it.

3. Not stable material as is.

A new 300 line polling framework using rte_bitset (24.11 only) is
not a backport candidate for 23.11, and reducing a ~1s notification
delay is not a regression fix. Suggest splitting:
  - small fix: use ETHTOOL_GLINK in mlx5_link_update_unlocked_gs/gset
    (Fixes: 17f95513adca, Cc: stable)
  - the LSC mechanism change, without Fixes/Cc stable

Info

4. Windows stub logs ERR on every dev_start with lsc=1, while the PCI
driver still advertises RTE_PCI_DRV_INTR_LSC. The old path logged
INFO. Make the stub silent; mlx5_dev_start() already logs. Also
"failed configure" -> "failed to configure" in that message.

5. Leftovers: the rte_io_wmb() in the mlx5_dev_spawn() error path
ordered the removed nl_ih_port_id store and can go; <stdbool.h> in
mlx5_lsc_intr.h is unused.

6. mlx5_link_update() now reports only link_status changes instead
of a memcmp of the whole struct. Fine, but mention it in the commit
message.

7. Commit message: "for examples" -> "for example",
"it is also flushes" -> "it also flushes".
