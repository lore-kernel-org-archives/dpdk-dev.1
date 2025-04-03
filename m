Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2F8C36014
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 19:03:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AD1B40A7D;
	Thu,  3 Apr 2025 21:03:25 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 45DA2406B6
 for <dev@dpdk.org>; Thu,  3 Apr 2025 21:03:24 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso2417824a91.0
 for <dev@dpdk.org>; Thu, 03 Apr 2025 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743707003; x=1744311803; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aJTTcR1OI+wXtUg2tS2hwoDkE2sscAmsiF+4NQnUfj8=;
 b=bRp1a0lpgE9Ka5X8jlELBpl4aFKLXUQSI/PLLRZbK+udclgQV/n2NakbXJ7+7QHDbH
 2fkrHArpg7DOcGNTAEIe9S1UOkOlv8eAqrFVMZmH4NVoWoOyCop8I2xPxvKlfNJx/Fm9
 yRpGCbgUz8GoX6zMa9vFZ81f0wUcip1ZRwQRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743707003; x=1744311803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aJTTcR1OI+wXtUg2tS2hwoDkE2sscAmsiF+4NQnUfj8=;
 b=X6nxeEVatviEwBzxfe7Go/v5UZ58OzHc8dkTyr9VAWCm18zEKIUtna+9xvfsXHDHqh
 +Hn8hjGXK9YlVPO8zN7zWi2s5nN16K4CS8ot4L/EmMfkUonw0LccUz0Qg9V42Pg5Ynbe
 C3psamV5NJlAcKm3z9MEfwhMrGtF69GA9h+U2UZ7lKSEdyFfRURtmOj8cIluQJu5UEM8
 KcuY8Ow704fpO4LnRSmMaopd6trl3rbBzwW64JxbS+jm3nO3zB+1DbXY0lrBTD4LgbUH
 PwzMBKCIDqXQzuOb5jc31VWJTh5mll7QJG12CXEZG/EQd3NpkyHA2mUv4+yd3LCH+pTM
 rUwQ==
X-Gm-Message-State: AOJu0YwvXWvUTgilB9wgglo75XAYmCBMVEDBeHhyMDcKk1UeLI+DLHCR
 O5Vbke/lg95/dYA8JxsFuVIYhwfGdfyQNNgQPrYoxMI98Zp33bBy4ifZ3qC/mxPBgBNQq4ztlWK
 Dosr8LkCqwJ5yFcax84FNJ69/nEiDkbp7nOpCayEz/kig+GYEbMs=
X-Gm-Gg: ASbGnctnjDsm24G+5pAj5GTSJpojilHgsmViBbH9KzJyaC4pCJDBCBHGYaApYJyJCjG
 kkovyGLEevRSBSit3cGSrutfaamokPFOJZldICK5moCu2RtBHk+KhuinozoeY6vEIefoleGcYDU
 G0j9VIo89u3dasmnoep540YSDXFsDwa6Njx33Z0JaiEMgMS3xHVMJI0FKBZ8A=
X-Google-Smtp-Source: AGHT+IHVjUlyKiUdg87I3AtSM/HoBUz3k040PSxtnAoeAWe0OSA4U99mmr4nC1EMp5bPej8UZDXjeowkeQ5uq7khvHU=
X-Received: by 2002:a17:90b:50cf:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-3057a59ea63mr6533868a91.2.1743707003082; Thu, 03 Apr 2025
 12:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 3 Apr 2025 14:59:20 -0400
X-Gm-Features: AQ5f1JpfSnNhgTQ7AYy-VU8kzZhU58vWbEQcinUwJhVpNxZWRPa3hz_PTHGZ3Cw
Message-ID: <CAJvnSUCznc9b+R9VCq3VuKpg14udOdHTS3sZwxZFQEm9=pM7bw@mail.gmail.com>
Subject: Re: [PATCH v12 00/10] replace use of term sanity check
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000082f8f70631e46c0d"
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

--00000000000082f8f70631e46c0d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

I was testing Grout on one of our baremetal servers today while DTS was
running at the same time (this was an accident - I thought I had it marked
offline in our CI system). Unfortunately as a result DTS conflicted with
Grout which was using the same mellanox card, and a false fail was reported
for this testsuite.

I will trigger a rerun and the false failure will be overwritten within a
couple hours.

Thanks for your patience.

On Wed, Apr 2, 2025 at 7:24=E2=80=AFPM Stephen Hemminger <stephen@networkpl=
umber.org>
wrote:

> Remove use of expression sanity check across DPDK drivers
> and documentation.
>
> The term sanity-check is on the Tier 2 word list from the Inclusive
> Naming project.
>    https://inclusivenaming.org/word-lists/tier-2/sanity-check/
>
> Rationale
>         This term might be derogatory to neurodiverse people.
>         Jargon, such as =E2=80=9Csanity test=E2=80=9D, is difficult to tr=
anslate and is
> difficult
>         to understand by readers whose first language is not English.
>
> v12 - rebase on 25.07
>       mark old mbuf API functions as deprecated
>
> Stephen Hemminger (10):
>   mbuf: replace term sanity check
>   net/avp: replace use of rte_mbuf_sanity_check
>   net/sfc: replace use of rte_mbuf_sanity_check
>   examples: remove term sanity
>   eal: replace use of sanity check in comments and messages
>   test: replace use word sanity
>   dts: replace use of sanity check in comment
>   doc: remove sanity
>   lib: replace use of sanity check in comments and
>   drivers: remove use of term sanity check
>
>  app/test/test_bitmap.c                        |  4 +-
>  app/test/test_bpf.c                           |  6 +-
>  app/test/test_common.c                        |  2 +-
>  app/test/test_cryptodev.c                     |  2 +-
>  app/test/test_distributor.c                   | 46 +++++------
>  app/test/test_eal_flags.c                     | 20 ++---
>  app/test/test_hash.c                          |  2 +-
>  app/test/test_interrupts.c                    |  9 ++-
>  app/test/test_link_bonding_mode4.c            |  2 +-
>  app/test/test_mbuf.c                          | 30 +++----
>  app/test/test_rawdev.c                        |  2 +-
>  app/test/test_timer.c                         | 10 +--
>  doc/guides/gpus/cuda.rst                      |  2 +-
>  doc/guides/prog_guide/mbuf_lib.rst            |  4 +-
>  doc/guides/rel_notes/deprecation.rst          |  3 +
>  .../sample_app_ug/eventdev_pipeline.rst       |  2 +-
>  doc/guides/tools/testbbdev.rst                |  8 +-
>  drivers/bus/fslmc/qbman/qbman_sys_decl.h      |  2 +-
>  drivers/common/cnxk/roc_nix_tm_ops.c          |  2 +-
>  drivers/common/cnxk/roc_npa.c                 |  6 +-
>  drivers/common/dpaax/caamflib/desc.h          |  2 +-
>  drivers/common/mlx5/linux/mlx5_common_os.c    |  2 +-
>  drivers/common/sfc_efx/base/ef10_nvram.c      |  4 +-
>  drivers/common/sfc_efx/base/efx_rx.c          |  2 +-
>  drivers/crypto/bcmfs/hw/bcmfs4_rm.c           |  6 +-
>  drivers/crypto/bcmfs/hw/bcmfs5_rm.c           |  6 +-
>  drivers/dma/idxd/idxd_pci.c                   |  2 +-
>  drivers/event/opdl/opdl_evdev.c               |  2 +-
>  drivers/event/opdl/opdl_evdev_init.c          |  2 +-
>  drivers/net/ark/ark_ethdev.c                  |  8 +-
>  drivers/net/ark/ark_ethdev_rx.c               |  2 +-
>  drivers/net/avp/avp_ethdev.c                  | 18 ++---
>  drivers/net/bnx2x/bnx2x.c                     |  2 +-
>  drivers/net/bnx2x/bnx2x_stats.c               |  8 +-
>  drivers/net/bnx2x/ecore_sp.c                  |  2 +-
>  drivers/net/bnx2x/elink.c                     |  4 +-
>  drivers/net/bnxt/bnxt_hwrm.c                  |  2 +-
>  drivers/net/bnxt/hsi_struct_def_dpdk.h        |  2 +-
>  drivers/net/bonding/rte_eth_bond_8023ad.c     |  2 +-
>  drivers/net/cnxk/cnxk_ethdev.c                |  4 +-
>  drivers/net/cxgbe/cxgbe_ethdev.c              | 10 +--
>  drivers/net/cxgbe/cxgbevf_main.c              |  4 +-
>  drivers/net/intel/fm10k/fm10k_ethdev.c        |  2 +-
>  drivers/net/intel/fm10k/fm10k_rxtx.c          |  2 +-
>  drivers/net/intel/ixgbe/ixgbe_fdir.c          |  2 +-
>  drivers/net/intel/ixgbe/ixgbe_ipsec.c         |  2 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c          |  2 +-
>  drivers/net/mlx4/mlx4.c                       |  2 +-
>  drivers/net/mlx4/mlx4_flow.c                  |  6 +-
>  drivers/net/mlx5/mlx5_flow_dv.c               |  2 +-
>  drivers/net/mlx5/mlx5_flow_hw.c               |  6 +-
>  drivers/net/mlx5/mlx5_rxq.c                   |  2 +-
>  drivers/net/mlx5/mlx5_rxtx_vec.h              |  2 +-
>  drivers/net/mvpp2/mrvl_qos.c                  |  2 +-
>  drivers/net/nfp/flower/nfp_flower_flow.c      |  2 +-
>  drivers/net/nfp/nfp_net_flow.c                |  2 +-
>  drivers/net/ntnic/nthw/nthw_rac.c             |  2 +-
>  drivers/net/qede/qede_rxtx.c                  |  6 +-
>  drivers/net/ring/rte_eth_ring.c               |  7 +-
>  drivers/net/sfc/sfc_dp_rx.h                   |  2 +-
>  drivers/net/sfc/sfc_ef100_rx.c                |  6 +-
>  drivers/net/sfc/sfc_ef10_essb_rx.c            |  4 +-
>  drivers/net/sfc/sfc_ef10_rx.c                 |  4 +-
>  drivers/net/sfc/sfc_rx.c                      |  2 +-
>  drivers/net/txgbe/txgbe_ipsec.c               |  2 +-
>  drivers/net/txgbe/txgbe_rxtx.c                |  2 +-
>  dts/tests/TestSuite_blocklist.py              |  2 +-
>  examples/ipsec-secgw/event_helper.c           |  2 +-
>  examples/ipv4_multicast/main.c                |  2 +-
>  examples/qos_sched/args.c                     |  2 +-
>  lib/eal/common/eal_common_memory.c            |  2 +-
>  lib/eal/common/eal_common_proc.c              |  3 +-
>  lib/eal/common/eal_common_trace.c             |  2 +-
>  lib/eal/common/eal_memcfg.h                   |  2 +-
>  lib/eal/common/rte_malloc.c                   |  2 +-
>  lib/eal/freebsd/eal.c                         |  2 +-
>  lib/eal/linux/eal.c                           |  2 +-
>  lib/eal/linux/eal_timer.c                     |  2 +-
>  lib/eal/windows/eal.c                         |  2 +-
>  lib/graph/graph.c                             |  2 +-
>  lib/graph/graph_stats.c                       |  2 +-
>  lib/graph/node.c                              |  2 +-
>  lib/jobstats/rte_jobstats.c                   |  6 +-
>  lib/mbuf/rte_mbuf.c                           | 23 ++++--
>  lib/mbuf/rte_mbuf.h                           | 79 ++++++++++---------
>  lib/mbuf/version.map                          |  1 +
>  lib/metrics/rte_metrics.c                     |  2 +-
>  lib/pcapng/rte_pcapng.c                       |  2 +-
>  88 files changed, 244 insertions(+), 235 deletions(-)
>
> --
> 2.47.2
>
>

--00000000000082f8f70631e46c0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgU3RlcGhlbiw8ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgd2FzIHRlc3Rp
bmcgR3JvdXQgb24gb25lIG9mIG91ciBiYXJlbWV0YWzCoHNlcnZlcnMgdG9kYXkgd2hpbGUgRFRT
IHdhcyBydW5uaW5nIGF0IHRoZcKgc2FtZSB0aW1lICh0aGlzIHdhcyBhbiBhY2NpZGVudCAtIEkg
dGhvdWdodCBJIGhhZCBpdCBtYXJrZWQgb2ZmbGluZSBpbiBvdXIgQ0kgc3lzdGVtKS4gVW5mb3J0
dW5hdGVseSBhcyBhIHJlc3VsdCBEVFMgY29uZmxpY3RlZCB3aXRoIEdyb3V0IHdoaWNoIHdhcyB1
c2luZyB0aGUgc2FtZSBtZWxsYW5veCBjYXJkLCBhbmQgYSBmYWxzZSBmYWlsIHdhcyByZXBvcnRl
ZCBmb3IgdGhpcyB0ZXN0c3VpdGUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIHdpbGwgdHJp
Z2dlciBhIHJlcnVuIGFuZCB0aGUgZmFsc2UgZmFpbHVyZSB3aWxsIGJlIG92ZXJ3cml0dGVuIHdp
dGhpbiBhIGNvdXBsZSBob3Vycy7CoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzIGZv
ciB5b3VyIHBhdGllbmNlLjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSBn
bWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5P
biBXZWQsIEFwciAyLCAyMDI1IGF0IDc6MjTigK9QTSBTdGVwaGVuIEhlbW1pbmdlciAmbHQ7PGEg
aHJlZj0ibWFpbHRvOnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnIj5zdGVwaGVuQG5ldHdvcmtw
bHVtYmVyLm9yZzwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21h
aWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+UmVtb3ZlIHVzZSBvZiBl
eHByZXNzaW9uIHNhbml0eSBjaGVjayBhY3Jvc3MgRFBESyBkcml2ZXJzPGJyPg0KYW5kIGRvY3Vt
ZW50YXRpb24uPGJyPg0KPGJyPg0KVGhlIHRlcm0gc2FuaXR5LWNoZWNrIGlzIG9uIHRoZSBUaWVy
IDIgd29yZCBsaXN0IGZyb20gdGhlIEluY2x1c2l2ZTxicj4NCk5hbWluZyBwcm9qZWN0Ljxicj4N
CsKgIMKgPGEgaHJlZj0iaHR0cHM6Ly9pbmNsdXNpdmVuYW1pbmcub3JnL3dvcmQtbGlzdHMvdGll
ci0yL3Nhbml0eS1jaGVjay8iIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBz
Oi8vaW5jbHVzaXZlbmFtaW5nLm9yZy93b3JkLWxpc3RzL3RpZXItMi9zYW5pdHktY2hlY2svPC9h
Pjxicj4NCjxicj4NClJhdGlvbmFsZTxicj4NCsKgIMKgIMKgIMKgIFRoaXMgdGVybSBtaWdodCBi
ZSBkZXJvZ2F0b3J5IHRvIG5ldXJvZGl2ZXJzZSBwZW9wbGUuPGJyPg0KwqAgwqAgwqAgwqAgSmFy
Z29uLCBzdWNoIGFzIOKAnHNhbml0eSB0ZXN04oCdLCBpcyBkaWZmaWN1bHQgdG8gdHJhbnNsYXRl
IGFuZCBpcyBkaWZmaWN1bHQ8YnI+DQrCoCDCoCDCoCDCoCB0byB1bmRlcnN0YW5kIGJ5IHJlYWRl
cnMgd2hvc2UgZmlyc3QgbGFuZ3VhZ2UgaXMgbm90IEVuZ2xpc2guPGJyPg0KPGJyPg0KdjEyIC0g
cmViYXNlIG9uIDI1LjA3PGJyPg0KwqAgwqAgwqAgbWFyayBvbGQgbWJ1ZiBBUEkgZnVuY3Rpb25z
IGFzIGRlcHJlY2F0ZWQ8YnI+DQo8YnI+DQpTdGVwaGVuIEhlbW1pbmdlciAoMTApOjxicj4NCsKg
IG1idWY6IHJlcGxhY2UgdGVybSBzYW5pdHkgY2hlY2s8YnI+DQrCoCBuZXQvYXZwOiByZXBsYWNl
IHVzZSBvZiBydGVfbWJ1Zl9zYW5pdHlfY2hlY2s8YnI+DQrCoCBuZXQvc2ZjOiByZXBsYWNlIHVz
ZSBvZiBydGVfbWJ1Zl9zYW5pdHlfY2hlY2s8YnI+DQrCoCBleGFtcGxlczogcmVtb3ZlIHRlcm0g
c2FuaXR5PGJyPg0KwqAgZWFsOiByZXBsYWNlIHVzZSBvZiBzYW5pdHkgY2hlY2sgaW4gY29tbWVu
dHMgYW5kIG1lc3NhZ2VzPGJyPg0KwqAgdGVzdDogcmVwbGFjZSB1c2Ugd29yZCBzYW5pdHk8YnI+
DQrCoCBkdHM6IHJlcGxhY2UgdXNlIG9mIHNhbml0eSBjaGVjayBpbiBjb21tZW50PGJyPg0KwqAg
ZG9jOiByZW1vdmUgc2FuaXR5PGJyPg0KwqAgbGliOiByZXBsYWNlIHVzZSBvZiBzYW5pdHkgY2hl
Y2sgaW4gY29tbWVudHMgYW5kPGJyPg0KwqAgZHJpdmVyczogcmVtb3ZlIHVzZSBvZiB0ZXJtIHNh
bml0eSBjaGVjazxicj4NCjxicj4NCsKgYXBwL3Rlc3QvdGVzdF9iaXRtYXAuY8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA0ICstPGJyPg0KwqBhcHAvdGVzdC90ZXN0X2Jw
Zi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgNiArLTxicj4N
CsKgYXBwL3Rlc3QvdGVzdF9jb21tb24uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHzCoCAyICstPGJyPg0KwqBhcHAvdGVzdC90ZXN0X2NyeXB0b2Rldi5jwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgYXBwL3Rlc3QvdGVzdF9kaXN0cmli
dXRvci5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDQ2ICsrKysrLS0tLS0tPGJyPg0K
wqBhcHAvdGVzdC90ZXN0X2VhbF9mbGFncy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB8IDIwICsrLS0tPGJyPg0KwqBhcHAvdGVzdC90ZXN0X2hhc2guY8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqBhcHAvdGVzdC90ZXN0X2ludGVy
cnVwdHMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA5ICsrLTxicj4NCsKgYXBw
L3Rlc3QvdGVzdF9saW5rX2JvbmRpbmdfbW9kZTQuY8KgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICst
PGJyPg0KwqBhcHAvdGVzdC90ZXN0X21idWYuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHwgMzAgKysrLS0tLTxicj4NCsKgYXBwL3Rlc3QvdGVzdF9yYXdkZXYuY8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqBhcHAvdGVzdC90
ZXN0X3RpbWVyLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgMTAgKy0t
PGJyPg0KwqBkb2MvZ3VpZGVzL2dwdXMvY3VkYS5yc3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB8wqAgMiArLTxicj4NCsKgZG9jL2d1aWRlcy9wcm9nX2d1aWRlL21idWZfbGliLnJz
dMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA0ICstPGJyPg0KwqBkb2MvZ3VpZGVzL3JlbF9ub3Rlcy9k
ZXByZWNhdGlvbi5yc3TCoCDCoCDCoCDCoCDCoCB8wqAgMyArPGJyPg0KwqAuLi4vc2FtcGxlX2Fw
cF91Zy9ldmVudGRldl9waXBlbGluZS5yc3TCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqBkb2Mv
Z3VpZGVzL3Rvb2xzL3Rlc3RiYmRldi5yc3TCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgOCAr
LTxicj4NCsKgZHJpdmVycy9idXMvZnNsbWMvcWJtYW4vcWJtYW5fc3lzX2RlY2wuaMKgIMKgIMKg
IHzCoCAyICstPGJyPg0KwqBkcml2ZXJzL2NvbW1vbi9jbnhrL3JvY19uaXhfdG1fb3BzLmPCoCDC
oCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgZHJpdmVycy9jb21tb24vY254ay9yb2NfbnBhLmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA2ICstPGJyPg0KwqBkcml2ZXJzL2NvbW1vbi9k
cGFheC9jYWFtZmxpYi9kZXNjLmjCoCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgZHJpdmVy
cy9jb21tb24vbWx4NS9saW51eC9tbHg1X2NvbW1vbl9vcy5jwqAgwqAgfMKgIDIgKy08YnI+DQrC
oGRyaXZlcnMvY29tbW9uL3NmY19lZngvYmFzZS9lZjEwX252cmFtLmPCoCDCoCDCoCB8wqAgNCAr
LTxicj4NCsKgZHJpdmVycy9jb21tb24vc2ZjX2VmeC9iYXNlL2VmeF9yeC5jwqAgwqAgwqAgwqAg
wqAgfMKgIDIgKy08YnI+DQrCoGRyaXZlcnMvY3J5cHRvL2JjbWZzL2h3L2JjbWZzNF9ybS5jwqAg
wqAgwqAgwqAgwqAgwqB8wqAgNiArLTxicj4NCsKgZHJpdmVycy9jcnlwdG8vYmNtZnMvaHcvYmNt
ZnM1X3JtLmPCoCDCoCDCoCDCoCDCoCDCoHzCoCA2ICstPGJyPg0KwqBkcml2ZXJzL2RtYS9pZHhk
L2lkeGRfcGNpLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqBk
cml2ZXJzL2V2ZW50L29wZGwvb3BkbF9ldmRldi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAg
MiArLTxicj4NCsKgZHJpdmVycy9ldmVudC9vcGRsL29wZGxfZXZkZXZfaW5pdC5jwqAgwqAgwqAg
wqAgwqAgfMKgIDIgKy08YnI+DQrCoGRyaXZlcnMvbmV0L2Fyay9hcmtfZXRoZGV2LmPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgOCArLTxicj4NCsKgZHJpdmVycy9uZXQvYXJrL2Fya19l
dGhkZXZfcnguY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoGRyaXZlcnMv
bmV0L2F2cC9hdnBfZXRoZGV2LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IDE4ICsrLS0t
PGJyPg0KwqBkcml2ZXJzL25ldC9ibngyeC9ibngyeC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB8wqAgMiArLTxicj4NCsKgZHJpdmVycy9uZXQvYm54MngvYm54Mnhfc3RhdHMuY8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDggKy08YnI+DQrCoGRyaXZlcnMvbmV0L2JueDJ4L2Vj
b3JlX3NwLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgZHJpdmVy
cy9uZXQvYm54MngvZWxpbmsuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDQg
Ky08YnI+DQrCoGRyaXZlcnMvbmV0L2JueHQvYm54dF9od3JtLmPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB8wqAgMiArLTxicj4NCsKgZHJpdmVycy9uZXQvYm54dC9oc2lfc3RydWN0X2RlZl9k
cGRrLmjCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgZHJpdmVycy9uZXQvYm9uZGluZy9ydGVf
ZXRoX2JvbmRfODAyM2FkLmPCoCDCoCDCoHzCoCAyICstPGJyPg0KwqBkcml2ZXJzL25ldC9jbnhr
L2NueGtfZXRoZGV2LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNCArLTxicj4NCsKgZHJp
dmVycy9uZXQvY3hnYmUvY3hnYmVfZXRoZGV2LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCB8IDEwICst
LTxicj4NCsKgZHJpdmVycy9uZXQvY3hnYmUvY3hnYmV2Zl9tYWluLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCB8wqAgNCArLTxicj4NCsKgZHJpdmVycy9uZXQvaW50ZWwvZm0xMGsvZm0xMGtfZXRoZGV2
LmPCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgZHJpdmVycy9uZXQvaW50ZWwvZm0xMGsvZm0x
MGtfcnh0eC5jwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoGRyaXZlcnMvbmV0L2ludGVs
L2l4Z2JlL2l4Z2JlX2ZkaXIuY8KgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqBkcml2ZXJz
L25ldC9pbnRlbC9peGdiZS9peGdiZV9pcHNlYy5jwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4N
CsKgZHJpdmVycy9uZXQvaW50ZWwvaXhnYmUvaXhnYmVfcnh0eC5jwqAgwqAgwqAgwqAgwqAgfMKg
IDIgKy08YnI+DQrCoGRyaXZlcnMvbmV0L21seDQvbWx4NC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgZHJpdmVycy9uZXQvbWx4NC9tbHg0X2Zsb3cu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA2ICstPGJyPg0KwqBkcml2ZXJzL25ldC9t
bHg1L21seDVfZmxvd19kdi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKg
ZHJpdmVycy9uZXQvbWx4NS9tbHg1X2Zsb3dfaHcuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IDYgKy08YnI+DQrCoGRyaXZlcnMvbmV0L21seDUvbWx4NV9yeHEuY8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoGRyaXZlcnMvbmV0L21seDUvbWx4NV9yeHR4X3Zl
Yy5owqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoGRyaXZlcnMvbmV0L212cHAy
L21ydmxfcW9zLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMiArLTxicj4NCsKgZHJp
dmVycy9uZXQvbmZwL2Zsb3dlci9uZnBfZmxvd2VyX2Zsb3cuY8KgIMKgIMKgIHzCoCAyICstPGJy
Pg0KwqBkcml2ZXJzL25ldC9uZnAvbmZwX25ldF9mbG93LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB8wqAgMiArLTxicj4NCsKgZHJpdmVycy9uZXQvbnRuaWMvbnRody9udGh3X3JhYy5jwqAgwqAg
wqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgZHJpdmVycy9uZXQvcWVkZS9xZWRlX3J4dHgu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCA2ICstPGJyPg0KwqBkcml2ZXJzL25ldC9y
aW5nL3J0ZV9ldGhfcmluZy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgNyArLTxicj4NCsKg
ZHJpdmVycy9uZXQvc2ZjL3NmY19kcF9yeC5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8
wqAgMiArLTxicj4NCsKgZHJpdmVycy9uZXQvc2ZjL3NmY19lZjEwMF9yeC5jwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgfMKgIDYgKy08YnI+DQrCoGRyaXZlcnMvbmV0L3NmYy9zZmNfZWYxMF9lc3Ni
X3J4LmPCoCDCoCDCoCDCoCDCoCDCoCB8wqAgNCArLTxicj4NCsKgZHJpdmVycy9uZXQvc2ZjL3Nm
Y19lZjEwX3J4LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA0ICstPGJyPg0KwqBkcml2
ZXJzL25ldC9zZmMvc2ZjX3J4LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAg
MiArLTxicj4NCsKgZHJpdmVycy9uZXQvdHhnYmUvdHhnYmVfaXBzZWMuY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoGRyaXZlcnMvbmV0L3R4Z2JlL3R4Z2JlX3J4dHguY8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqBkdHMvdGVzdHMvVGVzdFN1aXRl
X2Jsb2NrbGlzdC5wecKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqBleGFtcGxl
cy9pcHNlYy1zZWNndy9ldmVudF9oZWxwZXIuY8KgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+
DQrCoGV4YW1wbGVzL2lwdjRfbXVsdGljYXN0L21haW4uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHzCoCAyICstPGJyPg0KwqBleGFtcGxlcy9xb3Nfc2NoZWQvYXJncy5jwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxicj4NCsKgbGliL2VhbC9jb21tb24vZWFsX2NvbW1v
bl9tZW1vcnkuY8KgIMKgIMKgIMKgIMKgIMKgIHzCoCAyICstPGJyPg0KwqBsaWIvZWFsL2NvbW1v
bi9lYWxfY29tbW9uX3Byb2MuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCAzICstPGJyPg0KwqBs
aWIvZWFsL2NvbW1vbi9lYWxfY29tbW9uX3RyYWNlLmPCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAy
ICstPGJyPg0KwqBsaWIvZWFsL2NvbW1vbi9lYWxfbWVtY2ZnLmjCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqBsaWIvZWFsL2NvbW1vbi9ydGVfbWFsbG9jLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqBsaWIvZWFsL2ZyZWVic2Qv
ZWFsLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0K
wqBsaWIvZWFsL2xpbnV4L2VhbC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8wqAgMiArLTxicj4NCsKgbGliL2VhbC9saW51eC9lYWxfdGltZXIuY8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoGxpYi9lYWwvd2luZG93cy9lYWwu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoGxp
Yi9ncmFwaC9ncmFwaC5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB8wqAgMiArLTxicj4NCsKgbGliL2dyYXBoL2dyYXBoX3N0YXRzLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCAyICstPGJyPg0KwqBsaWIvZ3JhcGgvbm9kZS5jwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIDIgKy08YnI+DQrCoGxp
Yi9qb2JzdGF0cy9ydGVfam9ic3RhdHMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IDYgKy08YnI+DQrCoGxpYi9tYnVmL3J0ZV9tYnVmLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHwgMjMgKysrKy0tPGJyPg0KwqBsaWIvbWJ1Zi9ydGVfbWJ1Zi5owqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IDc5ICsrKysrKysrKystLS0t
LS0tLS08YnI+DQrCoGxpYi9tYnVmL3ZlcnNpb24ubWFwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgfMKgIDEgKzxicj4NCsKgbGliL21ldHJpY3MvcnRlX21ldHJpY3MuY8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIDIgKy08YnI+DQrCoGxpYi9wY2Fwbmcv
cnRlX3BjYXBuZy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgMiArLTxi
cj4NCsKgODggZmlsZXMgY2hhbmdlZCwgMjQ0IGluc2VydGlvbnMoKyksIDIzNSBkZWxldGlvbnMo
LSk8YnI+DQo8YnI+DQotLSA8YnI+DQoyLjQ3LjI8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9k
aXY+DQo=
--00000000000082f8f70631e46c0d--
