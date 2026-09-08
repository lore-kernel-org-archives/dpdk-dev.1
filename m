Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA9BC79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 14:06:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7762D40691;
	Tue,  8 Sep 2026 16:06:54 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id CB239402DF
 for <dev@dpdk.org>; Tue,  8 Sep 2026 16:06:52 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d8fd3b729dso38524505ad.1
 for <dev@dpdk.org>; Tue, 08 Sep 2026 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788876412;
 x=1789481212; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tM4vIrsdM9ecVBN+t0RWMhArdi7jdQte/zIkcwwVHhs=;
 b=SY8i8KxFqQDQFFP5MAPKqG1EWM14MOhlWsgcPA9VnDSsQVN+7Tq9UVRAQxXK67BpMR
 JlDazMOdMLJ1xhT09gG64tHOvgAseRozjM1cPosoAiDmReZrZBpWr2zgNyveHkap8SsE
 UtbB2lyKsFVPLr2vdItorKdxKQm5fYBaUBompHHcKdqDOKmTdBrHWN89B9XDun+oebbH
 oShqc/rLpKiLLvKdHGzVE8Ec0qIsBWqr7aZHfncAV1a2ZUiN0cgt5xBD8Jj7HTXf1Zta
 YbLaqjxTrAG2FcMou756L8I2pQCmx6z7CwVprZ7bfEwN7b2Hv0v+4GDTKh/K8ioG+V6v
 gi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788876412; x=1789481212;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tM4vIrsdM9ecVBN+t0RWMhArdi7jdQte/zIkcwwVHhs=;
 b=YXqEEds6MXQa3jw+ssn4N/54rDH+C5FDGc1fJ1EP4Tu89PdCPUGyXAAs8neKYSQbpL
 19QsSZt/7hy+1Cay2WH61DXt8Ii6LH92dY03uT+FVjTVlr4q3Hfkk0G+z6n61mdaIN3C
 +E2i3NFv4g1yE1kfroZKJG7mdGrb4j2Y8zcMUQ5l/fwu5Q50xvfqmxdOPuwdvgVGZ1rf
 hUvT/VV982sV9FbsdNToWW4gIqSD0YfmsKEermBGEQR/K4bxFVMvZc0u5QCCicnUBk3C
 3Wvvv+a0yo2CzgXMzMnCpirBnXIUNK77Vb8VqmS1JZgLTMFPuGJw1xq54xSr3GS3wl0v
 6anQ==
X-Gm-Message-State: AFuF++lAapIa8gLyhiwyblOaFRa4NxeZo9aan7AztBQN9ybwM49c12S3
 Tn4V86I0Ep0Novd7nbQdEO0dwOGh5MwD1Hv+BypY9Y27jscIwKQcZEXdUop8h4Lh9wk=
X-Gm-Gg: AYBFou2y92U/cEJ6AHYzzCQuSVuHT7Z7NJOiI+kqO4eJv8ysy9XPhTetdAU90mk7KIj
 dMoxz8JeLH4QgcJyrvBNeAc9MliqPo28QEBuipoYJdIYXOruDc6FGW29TNlypKrKTD+4ZS280bt
 IWZ9bBUSYmmkz19F4cd2RGxdwygkMJYC8YcyEdUl0qo6xqmNDkEbX50+ar/B9Q0m/Rfvn7m5Mxz
 ZWAbvHlIxw2NTXShh7d5zdpNp2/WL5TTbtWu0Y4TdklHkNMR1sQvijAD/CsDR2UsrxQ6/fLcrvh
 SWfAvdpaclx41iL5yf0MZ3l7/efBNLlvAk9J0ZpwjJ0AyabbxxVoMkBwZRZyqbOp91y+UuV4MBB
 Bvy6CwTJMHTE9zUTCl+68+r8m1ttyo7oMQCXOdwpuS47PAeQVWgGmnrKWectGUIPwz+bUbbpLWu
 bCZg3443pxpd6mVLl+uu6p9iD2EBBz64XGDFTANHF0sBXaYokKppR09LPPacevScdlztXk6qRhl
 bK7vltAtSiT3dHKaFTtwH7dsOeo1IQ+jV3BhvfA
X-Received: by 2002:a17:903:2c6:b0:2d8:d4d3:da50 with SMTP id
 d9443c01a7336-2db126aae2dmr510090135ad.20.1788876411407; 
 Tue, 08 Sep 2026 07:06:51 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1495b2f8sm59014645ad.21.2026.09.08.07.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 07:06:50 -0700 (PDT)
Date: Tue, 8 Sep 2026 07:06:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v13 00/15] net/enetc: add new features for ENETC4 on i.MX95
Message-ID: <20260908070642.72269043@phoenix.local>
In-Reply-To: <20260908054736.842738-1-g.singh@nxp.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260908054736.842738-1-g.singh@nxp.com>
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

On Tue,  8 Sep 2026 11:17:21 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V11-Changes:
>  - Added enetc4_vf.ini for VF only features.
>  - Fixed the secondary-process guards leave the burst function
>    pointers NULL
>  - Fixed rxq_info_get and txq_info_get report the doubled ring size
>  - Move the VFs only features to enetc4_vf.ini
>  - Setting the dev->data->lro
>  - Added a comment to use devargs to change delay and timeout to process
>    PSI message to avoid any interrupts stall.
>  - Fixed link_update() now rewrites RBMR on every Rx ring.
>  - Regestering - enetc4_txq_wr in VF
>  - Updated enetc4_rd64 with re-read to confirm the correctness.
>  - Removed the dead code and un-used macros.
>  - Added Vlan check for maximum allowed value.
>  - fixed pre-existing ring write function for TX path.
>=20
> V10-Changes:
>  - Fixed enetc4_txq_prior and enetc4_txq_wrr have no effect at queue
>    setup issue.
>  - Updated ENETC_CLASS_ID_SI_VLAN_ISO reply check.
>  - Updated enetc4.ini for VLAN offload.
>  - Added else part for burst functions selection for RSC and TSO.
>  - Updated enetc4_rd64()
>  - Fixed RBICR0 issue.
>  - Removed GENMASK.
>=20
> V9-Changes:
>  - Mid-body variable declaration moved to top of the function.
>  - ret=3D0 dead code is removed.
>  - Added check on return value of rte_intr_callback_unregister()
>  - The pre-existing reply_msg leak fixed.
>  - Added primary-process guard in enetc4_vf_dev_init
>  - Removed Flow control from enetc4.ini
>  - Fixed VF stats_reset baseline underflows on counter wrap
>  - Fixed VF vlan_pvid_set fails on every successful command
>=20
> V8-changes:
>  - Fixed Warning RBMR RMW races between threads by adding lock
>  - Fixed `static const` arrays in `enetc.h`
>  - Proper pthread_mutexattr_t initialization added as suggested by AI
>  - VSIMSGSR stale re-read race is eliminated
>=20
> V7-changes:
>  - added missing 14th patch.
>=20
> V6-changes:
>  - fixed free() on memory allocated with rte_zmalloc().
>  - fixed eventfd and vector-list leak on interrupt teardown
>  - fixed Rx ring doubling still bypasses
>  - fixed VSI-PSI transaction issued from the interrupt handler
>  - fixed the free-and-reallocate of msg is unnecessary churn
>  - fixed unsynchronized access to tx_pause_active and RBMR
>  - fixed signed shift overflow in the register-dump version field
>  - fixed the fw_size =3D=3D 0 early return reports the length of "0.0"
>  - unwanted blank lines removed.
>  - parse_txq_prior() returns updated.
>=20
> V5-changes:
>  - Patch 1 Build fixes which includes:
>     'prev_seg' undeclared fixed.
>     redefinition of 'dev_rx_offloads_sup' fixed.
>     Error: duplicate rx_enable declaration fixed.
>    PF loses Scattered Rx and Multi-segment Tx
>  - mbuf leak in enetc_xmit_pkts_lso() fixed.
>  - fixed conversion on ENETC4_TXBD_FLAGS_F issue.
>  - fixed link speed decode has no upper bound.
>  - fixed mailbox ops added to the no-VSI ops table.
>  - new devargs documented.
>=20
> V4-changes:
>  - fix doc build issue: WARNING: undefined label: pmd_build_and_test
>=20
> v3-changes:
>  - fix doc build issue.
>  - fix compilation issue on fedore:43-gcc-minsize
>=20
> V2-changes:
>  - compilation fixes.
>=20
> V1-changes:
> This series adds new PMD features to the ENETC4 driver targeting the
> NXP i.MX95 NETC IP.
>=20
> The series covers:
>=20
>  - KEEP_CRC Rx offload: preserve the Ethernet FCS in the receive buffer.
>  - TSO: TCP Segmentation Offload for the VF Tx path.
>  - RSC/LRO: hardware Receive Segment Coalesce for PF and VF Rx paths.
>  - Link speed code: extend the PF-to-VF mailbox field from 4-bit to
>    8-bit to support speeds beyond 10G.
>  - Firmware version: report the NETC IP version via fw_version_get.
>  - Register dump: dump SI, port (PF) and BD ring registers.
>  - Ring parameters: implement rxq_info_get / txq_info_get for the VF.
>  - Link-up interrupt: refresh the cached link speed on each VF link-up
>    interrupt so that link_update returns the current speed immediately.
>  - Stats reset: software snapshot/delta approach for VF counter reset.
>  - Per-queue Rx interrupt: MSI-X per-queue Rx interrupts for the VF,
>    enabling interrupt-driven receive with l3fwd-power.
>  - SI VLAN: hardware port VLAN insertion/removal for PF and VF.
>  - VF link status bitmask: switch VF link status to bitmask encoding
>    to align with the PF and newer kernel driver conventions.
>  - TX PAUSE: VF sets Rx congestion mode when the PF signals TX PAUSE
>    negotiated on the wire; adds Flow control =3D Y to enetc4.ini.
>  - WRR Tx scheduler: per-ring WRR weights via enetc4_txq_wrr devarg.
>=20
> Gagandeep Singh (15):
>   net/enetc: add keep-CRC Rx offload for ENETC4
>   net/enetc: add TSO support for ENETC4 VF
>   net/enetc: add RSC (hardware LRO) support for ENETC4
>   net/enetc: extend PF-VF link speed field to 8 bits
>   net/enetc: add VF supported features file
>   net/enetc: support firmware version get for VF
>   net/enetc: support registers dump
>   net/enetc: support ethtool ring parameters
>   net/enetc: refresh link speed on VF link-up interrupt
>   net/enetc: support stats reset for VF
>   net/enetc4: add per-queue Rx interrupt support for VF
>   net/enetc4: add SI-based port VLAN insertion and removal
>   net/enetc4: update VF link status to bitmask encoding
>   net/enetc4: enable Tx PAUSE via VF Rx congestion mode
>   net/enetc4: add WRR Tx scheduler devarg for VF rings
>=20
>  MAINTAINERS                            |   1 +
>  doc/guides/nics/enetc4.rst             | 114 ++-
>  doc/guides/nics/features/enetc4.ini    |   4 +
>  doc/guides/nics/features/enetc4_vf.ini |  28 +
>  doc/guides/rel_notes/release_26_11.rst |  21 +
>  drivers/net/enetc/base/enetc4_hw.h     | 148 +++-
>  drivers/net/enetc/base/enetc_hw.h      |   6 +
>  drivers/net/enetc/enetc.h              | 133 +++-
>  drivers/net/enetc/enetc4_ethdev.c      | 559 +++++++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 928 ++++++++++++++++++++++---
>  drivers/net/enetc/enetc_rxtx.c         | 530 +++++++++++++-
>  11 files changed, 2284 insertions(+), 188 deletions(-)
>  create mode 100644 doc/guides/nics/features/enetc4_vf.ini


Before merging did a recheck AI review. It was mostly good (will save you
the long winded version). But it did mention:

Two findings

Warning =E2=80=94 calloc() reverted to rte_zmalloc().
Patch 15 changes the allocation that upstream
commit 662e61c3 ("net/enetc: set configurable priority to Tx rings")
deliberately made calloc():

-	hw->txq_prior =3D calloc(hw->max_tx_queues, sizeof(uint32_t));
+	hw->txq_prior =3D rte_zmalloc(NULL, hw->max_tx_queues * sizeof(uint32_t),=
 0);

and the new txq_wrr array follows suit.

These are small control-path arrays read only in tx_queue_setup() and
tx_queue_start() =E2=80=94 no hugepage memory, NUMA locality, or
secondary-process access is needed. This was changed to calloc() at
review request in the original series; please keep it. (The
free()=E2=86=92rte_free() pairing is consistent within the patch, so there's
no mismatch =E2=80=94 just the wrong allocator.)

Warning =E2=80=94 the new validation errors are swallowed.
The parsers now return -EINVAL, but nothing acts on it:

+	if (!strcmp(key, ENETC4_TXQ_WRR)) {
+		if (rte_kvargs_process(kvlist, key,
+				       parse_txq_wrr, (void *)dev) < 0) {
+			rte_kvargs_free(kvlist);
+			return 0;

and enetc4_dev_configure() discards the return of enetc4_get_devargs() enti=
rely.

So enetc4_txq_wrr=3D"2|99|1" logs an error, applies weight 2 to ring 0,
leaves the rest at the zero default, and configures
successfully. Entries parsed before the bad token stay live. Either
free and NULL the array on the error path so nothing is applied, or
propagate the failure out of dev_configure().
