Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14EACDB471
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 15:47:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3B314029D;
	Tue, 23 Jun 2026 17:47:02 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id A0C9240150
 for <dev@dpdk.org>; Tue, 23 Jun 2026 17:47:01 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-1397e093f90so603224c88.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782229620;
 x=1782834420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oPMQ9NcFKuFkbL1kbpuvyGJZqtHTO4Too8pCpfvAf8=;
 b=AXFZWNgy1JB0pc9SwRLIlTI73E+FguSO7aKVvfGSYRIHYuNYuihC5DeWlgEyARga6D
 8x80vudnYkJ1oHZ+tnczx2ezFXu7lTegfuwKiCUPStGjQxO39i9KPh1c+2+OK7XqD6u6
 GRGGeELlTFoNRJKlhfzziuxk7GInnmbOypXD6U4yyEqh4bsle2VwMOlGa4i/vepJ4Qrl
 bWbWhjWDglVGgrSQtLaparEHm8ySvv9ctTeSOdB7CMm7m/foFLKP4M8S8qwVN2nK/0nU
 QLnC5VPOEFmZs7NCjfbGExQeVOhV1qJUUZS8ND8zM7oUR+nti+Bguvt3eS8nZuBNz4fE
 RJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782229620; x=1782834420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9oPMQ9NcFKuFkbL1kbpuvyGJZqtHTO4Too8pCpfvAf8=;
 b=ikoTp571Zoi2wJoHI4Fnn6z05Q0eBj7F+BKi5EvgTYCRTgN3tPonmKdnk6N6DKuJbC
 rqj06EtzZXEg9z/m16su2wzjh9NcPZ0phC8psQMWewveuCVi9NVinSID31f/aWCSQeIB
 BEh5aeldNGnikGRcUyNsR2HpC804n4DxqqPz5UcviT7pCDm6Posr7LVa0h38H8sfY1if
 OT2WX067JkdRqaWe+WcKi2Vds4K3qxZHXXuPk5rpRfT1nuCfLQo7qfrK5i1gjsa1qply
 19PId4etZ6WfmhzwAnzX/xL3lcFGwDbAZhKULRIG84LwmlkSP1RSwYpOn59s5r6B3Gqa
 lDqg==
X-Gm-Message-State: AOJu0Yyt1Z94j7hUZBWBi7tAmPIA/TNQPe/nM4uDm5MGLELkyQOyXwH4
 BdbPtKGbqcJUblz0lFW1rijsTkPK+vF/1gmQUhLWe90DJvYDRfRmL5/pdCfIxtup3tA=
X-Gm-Gg: AfdE7ck9AODNHzwNLFIbtpLLcXkA4Kp06PKe/zS5+UVCTTzmXCIoskh9dIMq7b9/u2v
 /7xEjYU0KwTRiu5BS8hrnkDCXx/cQLFHc0b9bZ5PmSP8miWWXwkTPG08H0K0oPsFgpKRwO+xDLm
 XbWSInD7mifT7ciyDL1WXaXZsLsQiombnsG7665lXQj9jkzK84EuOZuRujCsI9mEzSFU4OrICan
 VnfCMC3VmYMgor/1LDOtjj3tom39lD41tHDex0vboGyTa2Ff2l+NU4+4A7EqXWZC2eb3O8CmFbv
 pO79n4LjUOVOpHei4KQ7+w54M/xgntM8X8iRXol1PKUYetVp1qjORjoDvS22K08FJgQZkRuSWK7
 7eNbfEA5PUfaLcGAcTAayiHHCy9gdMUJSS0R5MuZCxNdeokAzzVtA0zThqwfoXhI6+jVDvQCOT3
 ws7lFgOYBc7NvbqGQbKug6u42rg0w0YZiYo2qyG+cy4tTn282+EmXF3A==
X-Received: by 2002:a05:7300:1491:b0:304:e566:e000 with SMTP id
 5a478bee46e88-30c07070d48mr14233808eec.31.1782229620352; 
 Tue, 23 Jun 2026 08:47:00 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba635d8sm18817939eec.10.2026.06.23.08.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 08:46:59 -0700 (PDT)
Date: Tue, 23 Jun 2026 08:46:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v3 0/9] ENETC driver related changes series
Message-ID: <20260623084657.0923ab04@phoenix.local>
In-Reply-To: <20260623060004.2187716-1-g.singh@nxp.com>
References: <20260622113517.1616028-1-g.singh@nxp.com>
 <20260623060004.2187716-1-g.singh@nxp.com>
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

On Tue, 23 Jun 2026 11:29:55 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V3 changes:
>   - Added documentation for all devargs in enetc4.rst.
>   - Fixed kvlist memory leak issue.
>=20
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
>  doc/guides/nics/enetc4.rst             |  62 +++-
>  doc/guides/nics/features/enetc4.ini    |   1 +
>  doc/guides/rel_notes/release_26_07.rst |  10 +
>  drivers/net/enetc/base/enetc_hw.h      |  13 +-
>  drivers/net/enetc/enetc.h              |  31 +-
>  drivers/net/enetc/enetc4_ethdev.c      | 172 ++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 206 ++++++++++--
>  drivers/net/enetc/enetc_ethdev.c       |  25 +-
>  drivers/net/enetc/enetc_rxtx.c         | 430 ++++++++++++++++++++++---
>  9 files changed, 831 insertions(+), 119 deletions(-)
>=20

Did followup AI review and it had some more things that need fixing:

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
