Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1136FCDB46F
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 15:06:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A56140150;
	Mon, 22 Jun 2026 17:06:21 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 3EDD140144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 17:06:20 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30bf132969bso5511898eec.0
 for <dev@dpdk.org>; Mon, 22 Jun 2026 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782140779;
 x=1782745579; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSLdtzJRcpMOcb7ufYxgFg5ajA04pVDAD44XO5aiQJQ=;
 b=FJPJ80KfJkbWb96NFmANPedvOL0vG7DxAsdpc2wjapsu1pDwkmkQDZlSAIbmKf497k
 tU8emmU9H0EtX3W1nq3O1FVybokWpIo8XGNZnC/tEEub1cFIVYZRVR7KRlBhECe4EuxD
 i+W5uKrBo4M27gL6wyh7eMaDYh2gex1QSH5qdsutDdGP2PQv8eIyzRrD1C74KVygrY9Z
 4+DjtuIZ0G8J7vtqqegg9Kmo9MOVL3UEylSkC7PlEp6nSQQYcnf7OEkge6FvX33x/AOO
 2OCYKTghMb/ubfc3vVSe39KlasVUxysSJ1ywH3OYtI06JvLhp7JiRYoOgi8k0vw+TBIm
 NgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782140779; x=1782745579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pSLdtzJRcpMOcb7ufYxgFg5ajA04pVDAD44XO5aiQJQ=;
 b=C8T3i+Ahku/7spclAk91+PJepQOP8jjji/8QuW4hq7NZcm78BAe+wQ0PMEGtRXGTRR
 Vls+Z+0+F8nRmjY4VNwsm17r5Dzl2wfcoADHcdCquU9depo6gWyeIThY5GYbhu3y521Q
 Rk8SeJPaoTAioUMcGbe/yW9FRVAaTZG8r8wTjd1n27N3V6+SEK76WQEtioqedveidgbu
 jwAV/I5ork7Wii9wQGA8i8nfQHrXs8pAOqYNDMc91PZC9+LJWfje1Hf0JWQRF+ZK+fMV
 bDPfxcAVTIJHcQLNNxAftrKG85t9Vbn6LOj05BwHSzN/mkwtvSVoSRdBQ1xyJ4VK0GJr
 8fIQ==
X-Gm-Message-State: AOJu0Yxe6fhawKhYpGk8L+TjoCAEaL78zFpN3jKPAO5+TzWuT5vp1eoo
 8A1fvtuCzb7BzpWowUoaFO/a8oHgNMDUrJ91xMqmkUIUDyNYYpLUxJ7FAwy1ImWlq2s=
X-Gm-Gg: AfdE7ck/SpvS3hcKds1/1dknNzOd37DB11A7X8ZEq3B3C7J0TzH0Xo8PEX0ukUK/STn
 tsOBLmWd2yztC/LdWa7S0uLwgahkkkmDjXvv/72X+lbI95zRh7qYCmrsuocbooNlxoHGjGQtQTg
 +EZg17Qf+sXvUZUUbxXdvg21wk/IzDUkgIbDZAZp+dfYeDvVilOCv4WfDDhK5N7MAUhkeLUDbLi
 UpQqODpUvw8bA7QdhtyWJqTJIbYphWVAMSVsITjTtTKg3rW+5UAZ9MBrHi8pBwNDyhPeaHUxIO9
 eeCGfWpAc9SWTOJxlxAzokBKreeppB8H2muZhIMOfJBPh8t20yyqEYyRZwsHFMdfYPrHg9A4Tdk
 TleV7Dvqx294EmVMSAK/sAg8WB8Q9KZHmXQZTcjklA0KBZHnBMfizeBPbpcApcnWALaHby3v/Ul
 Zm0JC0U7vkGGH9clafMU/L72IGxbksNmfTPq7iFNQTBocSz46i8MbFGw==
X-Received: by 2002:a05:7300:6c89:b0:2be:7fc2:fc38 with SMTP id
 5a478bee46e88-30c06fb6c13mr10092174eec.5.1782140778765; 
 Mon, 22 Jun 2026 08:06:18 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm9722957eec.15.2026.06.22.08.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:06:17 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:06:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v2 0/9] ENETC driver related changes series
Message-ID: <20260622080615.6f397799@phoenix.local>
In-Reply-To: <20260622113517.1616028-1-g.singh@nxp.com>
References: <20260619184427.522518-1-g.singh@nxp.com>
 <20260622113517.1616028-1-g.singh@nxp.com>
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

On Mon, 22 Jun 2026 17:05:08 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V2 changes:
>   - Fixed an un-used variable compilation issue reported on fedora:43-gcc=
-minsize
>   - Fixed various AI reported issues:
> 	- Release notes updated for all new devargs
> 	- enect4.ini features doc updated for scattered RX.
> 	- removed Not required RTE_PTYPE_UNKNOWN.
> 	- Fixed mid-frame mbuf leak in SG case.
> 	- Enabled SG for enetc4 PF also.
> 	- move to calloc from rte_zmalloc in parse_txq_prior().
> 	- added vaidation checks on strdup, strtoul.
> 	- added NC devargs to use cacheable ops conditionally.
> 	- removed dead code like bd_base_p etc.
> 	- Fixed rte_cpu_to_le_16() conversion on flags and combined
> 	  all flags related patches in one patch.
> 	- Fixed memory leak issue due to TXQ priority patch.
>    - There were some false positives, I have ignored them:
> 	Race condition on flags field:
> 		clean_tx_ring only touches HW-completed BDs (next_to_clean=E2=86=92hwci=
),
> 		never newly-submitted BDs; doorbell hasn't fired yet.
> 	Missing dcbf in clean_tx_ring:
> 		DPDK is single-threaded per queue; TX path always overwrites
> 		flags completely before dcbf.
> 	TX dcbf granularity with wrap:
> 		Safe (AI admits it).
> 	RX refill flush at wrap:
> 		In-loop dcbf at i & mask =3D=3D 0 already flushes aligned groups;
> 		trailing flush only needed for partial groups.
> 	RX reading before invalidate:
> 		dccivac precedes the read for every group in the loop
>=20
> Gagandeep Singh (7):
>   net/enetc: fix TX BD structure
>   net/enetc: fix queue initialization
>   net/enetc: support ESP packet type in packet parsing
>   net/enetc: update random MAC generation code
>   net/enetc: add option to disable VSI messaging
>   net/enetc: add devargs to control VSI-PSI timeout and delay
>   net/enetc4: add cacheable BD ring support with SW cache maintenance
>=20
> Vanshika Shukla (2):
>   net/enetc: support scatter-gather
>   net/enetc: set user configurable priority to TX rings
>=20
>  doc/guides/nics/features/enetc4.ini    |   1 +
>  doc/guides/rel_notes/release_26_07.rst |  10 +
>  drivers/net/enetc/base/enetc_hw.h      |  13 +-
>  drivers/net/enetc/enetc.h              |  31 +-
>  drivers/net/enetc/enetc4_ethdev.c      | 172 ++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 204 ++++++++++--
>  drivers/net/enetc/enetc_ethdev.c       |  25 +-
>  drivers/net/enetc/enetc_rxtx.c         | 430 ++++++++++++++++++++++---
>  8 files changed, 768 insertions(+), 118 deletions(-)
>=20

Better but still had some AI feedback if I asked it for more complete revie=
w.
Agree that putting new devargs in doc is needed.

Error
=3D=3D=3D=3D=3D

[PATCH v2 7/9] net/enetc: add devargs to control VSI-PSI timeout and delay

drivers/net/enetc/enetc4_vf.c, enetc4_vf_dev_init()

  kvlist is leaked on the two invalid-value error paths. It is
  allocated by rte_kvargs_parse() (line 1347) and only freed at
  line 1385, but both

      return -1;   /* invalid VSI Timeout, line 1367 */
      return -1;   /* invalid VSI Delay,   line 1380 */

  return before that free. A malformed enetc4_vsi_timeout=3D or
  enetc4_vsi_delay=3D leaks the kvargs structure on every probe.

  Free before returning, e.g.:

      if (errno !=3D 0 || hw->vsi_timeout =3D=3D 0) {
              ENETC_PMD_ERR("Invalid VSI Timeout value =3D %u",
                              hw->vsi_timeout);
              rte_kvargs_free(kvlist);
              return -1;
      }

  (same for the delay path), or restructure with a goto.


Warning
=3D=3D=3D=3D=3D=3D=3D

Series (patches 6-9)

  The new runtime devargs - enetc4_vsi_disable, enetc4_vsi_timeout,
  enetc4_vsi_delay, enetc4_txq_prior, and nc - are registered via
  RTE_PMD_REGISTER_PARAM_STRING and noted in the release notes, but
  doc/guides/nics/enetc4.rst has no Runtime Configuration section
  describing them. Convention is to document devargs in the NIC guide
  so users can find the syntax (e.g. the nc=3D1 / 'a|b|c' priority list
  formats are non-obvious).

Info
=3D=3D=3D=3D

[PATCH v2 5/9] and [PATCH v2 9/9] - RX multi-segment reassembly

  In enetc_clean_rx_ring_nc() and enetc_clean_rx_ring_cacheable(),
  on the frame-last BD:

      first_seg->pkt_len -=3D rx_ring->crc_len;

  reduces pkt_len but leaves the final segment's data_len unchanged,
  so pkt_len !=3D sum(data_len) when crc_len is non-zero. The old
  single-segment path kept them equal (pkt_len =3D data_len =3D buf_len
  - crc_len).

  This is currently unreachable: enetc4 does not advertise
  RTE_ETH_RX_OFFLOAD_KEEP_CRC, so crc_len is always 0 and the
  subtraction is a no-op. Flagging only so the asymmetry is on record
  if KEEP_CRC is ever added - at that point the last segment's
  data_len would need the same adjustment (and the CRC may straddle
  the last two segments).
