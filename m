Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F13CA6002
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 16:25:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF143410D5;
	Wed,  7 Oct 2026 18:25:40 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7A6E940EDF
 for <dev@dpdk.org>; Wed,  7 Oct 2026 18:25:39 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso18189645ad.2
 for <dev@dpdk.org>; Wed, 07 Oct 2026 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791390338;
 x=1791995138; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=27aRfK317x0mcATIiFJxeqDUtr5pi+Kzn7gaQWYfRBA=;
 b=b2s4pz4WkanNdIBOBMSi2OAe8EfzW7j7EKtYRAJ0NhGzYAHlILghA4n4Ls4GOkgtEq
 xR4/cyEWcIyBJ+UVIjqQypXpUDba6ldTHc0EHbLLn7+p1bOJzVlpdjoVMXhc9g8YpZ1g
 sxEjuCZrcI5CCXb1eoQWcqt6KoUHDVqOD/B3zmeUtQpn9T6mnGyD3rPdqSBmu0lz7gYk
 xUK/IJe7L4J0I+XH90PqPh7A1GrAE9BcFSjZN2WC1v8J2xFuIvSJUpYICVRGOiCE2svC
 B3nXy1eFJei1/OiMR3D/Ui5BOv5gdF+AMc4Oq8+AggQxT+xlm8VQjNVdhJQJ1/pD8jZL
 OD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791390338; x=1791995138;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=27aRfK317x0mcATIiFJxeqDUtr5pi+Kzn7gaQWYfRBA=;
 b=MLdBEimSYBgIyxKajjb++sFA4lcNxIVCI4dqp2nHbabljPlmSRUhTQo26vMg6qopzy
 o3dTY1P6auMkYOdjXnP8356QYecjr0Ggj2LZ3rg0l3Of2FSd1E2YX3sznAXCwqg0hF5H
 XrWcN7Lpg/OubK8vcXoYLuNuusllcgnJvF4bSrqhLO6ghTft4ofEkB7exxaIDLDq4vVZ
 Vc3MYf+Ig/lcYDJTVMbFMNrzbis1AYKMYOoHpXxJJfC6FR+Cv6lsBpzjI+Oy9Af86ouZ
 ptFbD4XcZW1BdlLXeL+Wy5f9tbUb70ecl6zHPIv3dvnbJT1SR5Z0JWxx+eXWWl9rUYcw
 XbxA==
X-Gm-Message-State: AFq9FYIB0Swwg+qDHvcgzQDUvxv971PJB/0MiQVK6IUVg3Wv4/UJAQWs
 83062qUTXz+aq1e0oGSXGpDRx/k19bljoMaMN9iaJYtkEWaREfm/cBuDNbnA2VCeIx+nZzlICad
 t/rnfjDU=
X-Gm-Gg: AYBFou2ThZBsh5vp+xob0fyZfUj/3p/bk82BKxIBdPhwKc0fU7v1GyXn3hr2ZoTQoM5
 4Qk25ZeYhaSKh535iMVpAT0Pb3Wc9vMuxpmKmBsQlTV4eRptBp/bMChaXoiV5X4P0OD6eghI9M/
 1C6pTa3AvjL/jykUxUg87PdbnNAf8FyzAQT5Um6oC3IrWlQ2hufFwrgdtk4lLQ0uaWimmhCueJ3
 C1FCwRG/fz9nLOnxK7YNtgABwf0OafDgOv53HpQu3wfQcczJxOqcPzKKNJjbKSlS39HWrsf2a+W
 EdO3HKGpl5ahWTGsU+fM7JfwshJuE3OMaIOawVCwhtx5wyh7kcw/eAP9d0kfQgUsv4lGQ1ww+54
 hd0Z6cX/gFH3x3tkTgsNvmDPbWZySIpUr6+XswP3SQCQ6IE0izRRLnOgCpf8ySZ2W+fCiAgYnX4
 ZeDv9UgY0msA4t1rzfLJkfsLBlC2h6jS3mDZI//NEY+uAVYB4A3zbbnLNm6pbewdhGYtuROtCcJ
 Pmm8KOh1WL4hUhp1TRiu3g0tnxYK0PCC/ZqIym9MQ==
X-Received: by 2002:a17:903:41cd:b0:2e6:943:39df with SMTP id
 d9443c01a7336-2e609433e0fmr19793965ad.25.1791390338489; 
 Wed, 07 Oct 2026 09:25:38 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e6046fe05fsm13890965ad.27.2026.10.07.09.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 09:25:38 -0700 (PDT)
Date: Wed, 7 Oct 2026 09:25:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v7-S2 00/13] net/dpaa2: flow, meter and parser features
Message-ID: <20261007092511.668f4333@phoenix.local>
In-Reply-To: <20261007060227.219835-1-prashant.gupta_3@nxp.com>
References: <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
 <20261007060227.219835-1-prashant.gupta_3@nxp.com>
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

On Wed,  7 Oct 2026 11:32:14 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This is the second of four series upstreaming the missing NXP dpaa2
> driver changes. It does not depend on series 1 and can be applied
> independently. It adds the net/dpaa2 flow, metering and parser features:
> 
> - fix an integer overflow in the CCSR region mapping,
> - set Tx confirmation on device init and support a larger burst size,
> - support MPLS and PPPoE flow distribution, meter and policing, and the
>   flow drop action, with a per-device default flow miss action,
> - identify Rx mbuf hash information by FLC and add minimum key size
>   support,
> - restructure the parser processing, parse tunnel and fragmented packet
>   types, remove the unused soft parser driver and rename the Rx queue
>   flags.
> 
> Note that patch 12 removes the soft parser driver and, with it, the
> rte_flow VXLAN and eCPRI pattern items that were only accepted while an
> SP image was believed to be loaded. Both items are dropped from the dpaa2
> feature matrix and a release note is added.

Ran manual review with AI and looked at the output, boiled the results
down to these issues:

Review: [PATCH v7-S2 00/13] net/dpaa2 updates

Applies to main and on top of S1. Patch 10 (parser restructure) got
only a light pass. Patches not listed below have no findings.


[PATCH 05/13] net/dpaa2: support meter and policing

Warning: dpaa2_mtr_meter_create() drops meter_lock around
dpaa2_mtr_hw_program() and re-takes it to insert. If control
operations can be concurrent, there is a race here: two creates
with the same mtr_id both pass the duplicate check, and a profile
or policy can be deleted while hw_program uses it. If they are not
allowed (the usual ethdev rule), what is the point of meter_lock?
Nothing in the Rx/Tx path touches the meter lists. Either hold the
lock across check, program and insert, or drop it.

Error: meter state leaks on close. dpaa2_dev_close() never frees
priv->profiles, priv->policies or priv->meters. Add a
dpaa2_mtr_deinit() and call it next to dpaa2_tm_deinit():

void
dpaa2_mtr_deinit(struct rte_eth_dev *dev)
{
	struct dpaa2_dev_priv *priv = dev->data->dev_private;
	struct dpaa2_dev_meter *m;
	...

	rte_spinlock_lock(&priv->meter_lock);
	while ((m = LIST_FIRST(&priv->meters)) != NULL) {
		LIST_REMOVE(m, next);
		rte_free(m);
	}
	/* same for priv->policies and priv->profiles */
	rte_spinlock_unlock(&priv->meter_lock);
}

Warning: cbs/pbs (and pir/cir in packet mode) are cast to uint32_t
in dpaa2_mtr_hw_program() without a range check. Reject at
profile_add:

	if (p->cbs > UINT32_MAX || p->pbs > UINT32_MAX)
		return -rte_mtr_error_set(error, EINVAL,
			RTE_MTR_ERROR_TYPE_METER_PROFILE, NULL,
			"burst size too large");

Warning: profile_update and policy_update set meter->profile_id /
policy_id before dpaa2_mtr_hw_program(). If the MC command fails,
software points at the new profile while hardware runs the old one.
Commit the id only on success:

	ret = dpaa2_mtr_hw_program(dev, mtr_id, profile, policy);
	if (ret)
		return -rte_mtr_error_set(error, -ret,
			RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
			"HW policing set failed");
	meter->profile_id = profile_id;

Warning: capabilities advertise n_max = num_rx_tc even when the
DPNI was created without DPNI_OPT_HAS_POLICING. Return ENOTSUP from
capabilities_get and meter_create in that case:

	if (!(priv->options & DPNI_OPT_HAS_POLICING))
		return -rte_mtr_error_set(error, ENOTSUP,
			RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
			"policing not enabled in DPNI");

Info: leftovers. dpni_set_rx_tc_policing_v1() is declared but not
defined. DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS is unused.


Release notes (05/13, 07/13, 12/13)

Error: the "Updated NXP DPAA2 net driver" block is added above the
"New Features" heading, in the template header. There is already an
"Updated NXP DPAA2 ethernet driver" entry under New Features; put
the bullets there. Drop "Tx queue based flow control" and "software
parser based packet dump". Neither is added by this series, and
12/13 removes the soft parser.


[PATCH 07/13] net/dpaa2: set default flow miss action per device

Warning: the commit message and release note say the miss flow id
is now 0, but the code sets

	priv->default_flow = RTE_MIN(priv->fs_entries,
		priv->dist_queues) - 1;

which is the last queue. Fix whichever is wrong. If fs_entries can
be 0 this also underflows to 0xffff.


[PATCH 08/13] net/dpaa2: identify Rx mbuf hash information by FLC

Warning: FS frames are reported with RTE_MBUF_F_RX_FDIR plus
rte_mbuf_sched_set(). hash.sched is a Tx scheduler field. 10/13 then
removes the FDIR flag, so the final state sets no flag at all and
applications cannot tell hash.sched from hash.rss. Use the standard
FDIR ID reporting in this patch and leave it alone in 10/13:

	m->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
	m->hash.fdir.hi = (tc << 16) | flow;


[PATCH 09/13] net/dpaa2: add minimum key size support

Info: the removed comment says the MC only supports a fixed 56 byte
entry size. Say in the commit message which MC/DPNI version accepts
24, and if older firmware is still supported gate it like 03/13:

	if (key_max_size > DPAA2_FLOW_ENTRY_MIN_SIZE ||
	    dpaa2_dev_cmp_dpni_ver(priv, X, Y) < 0)
		return DPAA2_FLOW_ENTRY_MAX_SIZE;


[PATCH 10/13] net/dpaa2: restructure dpaa2 parser processing

Warning: the commit message lists fixes to earlier patches in the
same series ("Restore Rx timestamp", "Drop RTE_MBUF_F_RX_FDIR").
Fold each into the patch that introduced the problem so every commit
is correct on its own.
