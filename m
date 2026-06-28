Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD4DC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Jun 2026 22:40:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6566B4021E;
	Mon, 29 Jun 2026 00:40:28 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id E1594400D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 00:40:26 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-139edc6bfc0so4513757c88.1
 for <dev@dpdk.org>; Sun, 28 Jun 2026 15:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782686426;
 x=1783291226; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYcnqUmqvJ5EUqw/79AOtcM/R/jwXsOt2DObbepbwXI=;
 b=aGqi0sYpeK0H/v1zS5BoKyi455tHdxf2i8FS4CFmRPtnac4uIiXn7oPboYfjQSVZIA
 Z28biJZbyfQlZbWrVfXImaDGGPQ2XcSamCUy8YRZf5T97IWig4vEnRoS39WTlwwLFytm
 CH7n+uq5NhwcVfnfoU5YpimSPPhcD0okOdSZouB+WkoieajxzeUhP6QMmdRG5CdUb881
 3FqqW6GqdBsg85VqmnCRXqnl1TZtKUCO+oUVz8xQopZLr4AqmD0c6gyMJig+mXsGRdEB
 HH57YI55aKnfv4GFOjOexqeFjQgxNfk40Q3YJ8eVQb71ZEtTDVldCruCED3KZy/7523q
 FrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782686426; x=1783291226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TYcnqUmqvJ5EUqw/79AOtcM/R/jwXsOt2DObbepbwXI=;
 b=PuBk/PloNVYRRocA/ZEkvZK1S6w3xeT/ZiLmUANKRG1QERCCkeEnAIl5LkHg8TtPEd
 Ix1RuIz8kjuCDNcdbtKrbMDXJHgdAN9L7uLed6AP9ODXxMJyg7klAlZJRdn1teDAJQNL
 RgpQOeFdz9r6NclhGkXXEiSHUqVZLLDYFuIBDC+h4nM8K2NPYaqPAjydntXecXObrfNJ
 Fy5GMwm+Be5D25Mij/JDI20JKsonL7m/R1dS7RZu7czl9TnA85t3m7qqqC11wUAWOU8g
 n/2t/1koOqkwBgEgBQwiTKTZ3sBU4M9gEgYY5FqCOHmA2lLxYXbbvHlxaqnfqLDahOZ7
 xirQ==
X-Gm-Message-State: AOJu0YzGQck5VcPG3ejb+HupV5X7M3YGHfMvxdhxLTIvyF2IXB2f4bkR
 ur4FSedhZ+6yE2UFE2vb1uPdLeYxN13kVa1vd2l4kSCiWjbUH6OI4lMCJ0TrXRuerrc=
X-Gm-Gg: AfdE7ckERity+6BxOaUAxomkpWGtaVhKwbmHohSkMgo7M7LFIWxOg+AeVk4j2uvJ+Kx
 wfb7z6up0YLchgzA2l2+CHe12iEI+UdzlCHTP3zhQ2DtFSj629k5AczU6QsEn6NhERp929ahiMw
 4xdXKRX2JvzsYNCLbQYiN9400P9gtvr6L7pdjrRPF6/zOmDpvNh8ntXJTNqTsHhK/57Gdb5h7ku
 tPp4jAqSiV4YczNABGp7BjdK95ufNIHS4npY8zsl6+0UUDCFEtVG7HU0rA0spiIrCfaI+Tj1qIk
 cTIH2NcAmRJWdKNcPKfBPpo/eT3AB2KDG2NT186w9GWBTAMLGAIFKUjI/15M6+sqBMDoCKsdGEn
 xjGsQ64kKbJVZL6DNB1o+OVeZ41b4XSnrD0CfM6qucsp8+G0tmG7UQ+ejcxWm23WRt11qCHCuOv
 F3wH3agaVNyc/nXOa98p6iYq+Agwqtju3yeNAetyKJ6RmzBD3andEEZQ==
X-Received: by 2002:a05:7022:faa:b0:139:8674:e3d3 with SMTP id
 a92af1059eb24-139dbb529fdmr12080192c88.30.1782686425396; 
 Sun, 28 Jun 2026 15:40:25 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fcf63021sm5546804c88.0.2026.06.28.15.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 15:40:25 -0700 (PDT)
Date: Sun, 28 Jun 2026 15:40:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v3 0/9] ENETC driver related changes series
Message-ID: <20260628154019.4c7697ca@phoenix.local>
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

LOL AI apologized for missing this in review.

You're right, and I missed it =E2=80=94 twice. I explicitly considered that
txbd guard in my v2 review and talked myself out of flagging it as
"over-defensive," but the runtime argument (the inner loop always
executes because tx_pkts[start] is non-NULL) is invisible to the
compiler. Under -Werror=3Dmaybe-uninitialized at -Os that's a hard build
break, and per-commit buildability is non-negotiable. That's a real
review failure on my part. Let me reproduce it, pin down which patch
introduces it, and confirm the fix.

drivers/net/enetc/enetc_rxtx.c

  enetc_xmit_pkts_nc() and enetc_xmit_pkts_cacheable() both fail to
  build with -Werror=3Dmaybe-uninitialized (-Os, gcc):

    error: 'txbd' may be used uninitialized

  txbd is declared without an initializer and assigned only inside the
  inner per-segment loop; the compiler cannot prove that loop runs
  before txbd is read after it. Initialize at declaration:

    -	struct enetc_tx_bd *txbd;
    +	struct enetc_tx_bd *txbd =3D NULL;

  The _nc fix belongs in patch 5 (so that commit builds independently);
  the _cacheable fix belongs in patch 9.


