Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3DCC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:01:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63CF3402DD;
	Mon, 29 Jun 2026 21:01:06 +0200 (CEST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by mails.dpdk.org (Postfix) with ESMTP id F22DB402D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 21:01:04 +0200 (CEST)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-80e46c00f3bso11115987b3.2
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782759664;
 x=1783364464; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SM9tMiu+4j0OIoWKDwaOQ2dHPxu+KbYHsmMk67qwxTA=;
 b=GtCJBA0WZbpcl8cZ+Q9LO775mG0QmjSn7VSf3fgyMhdAcvT91SYtmUSha/O5kjj+Nj
 DUrbQQq6/VHfgqd4LnBpxLotPabeExzkxWz0e/dpmw4f/BZr3A3FKLRBYSig5wP7Rs3S
 4hcZPFzOoWJkKR3zlaTpnDgGAJ1ab8sg2Unt4ieujbBj8tWo73ZoDeS8pYo5NV49ZlWd
 +mDQF+aP+f4bOf5QnLT95JT/CeqLTAO+rGD7Z7lNC7O0VY/hZS59CK8wuZml3VkE1min
 6wH/xopPozbNUM4DanTEKgH3quhDwR50alBxaiLHDZlTgGegzjiTPHbQ20y+uWl9pBUJ
 qPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782759664; x=1783364464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SM9tMiu+4j0OIoWKDwaOQ2dHPxu+KbYHsmMk67qwxTA=;
 b=PTFXX2E1XUIlOgTMAtsXInIPzZ83190uBBEUWLdh9a0/smW/btt7loi1q4/cHHOuR4
 JI14YTqgHlvPWPUKIjxyGSFJcjcpIbbY6MESwVuUPfFHmLPdS+/zv7jczGFjU/i4VmMC
 p00icWTJQI7rUcY/hCJJyhg22hV8bF2fMgBfRJ1izTQs3Zp+kX3PXXut9SuP8niRkLbM
 kADzrtLPCbv5dVD54qlwfQoTIVZJGBqLWQWX7Ywa8QAnleyizBUn1Z2NpjPWtIifaNs+
 YqfqJ2KCmAplvxTs8plBAvi9QGuC/Bo7Dfhr50N6RxchjJJQqNKzInCRfhVo+4f4ADLf
 tLzg==
X-Gm-Message-State: AOJu0YyKNfBIBtDrngJLAJQ6BrAqxouQYBtVHTbWghZ2mOmt0Uk3jq5k
 pvBvnAPb4b+xSSI1WUFm78Mabx0/vcV1nGBwnnwXHcZG3x+4UtBXCIkcT96V16bjurwnMECknWE
 ZPTqK
X-Gm-Gg: AfdE7cmyo2/Av2+oYUovXa5hNuawXHN8U/GXDPE24VXFVQIisTwSxZ6wc2XKKgf58cl
 6Xq6/uprO2iI8JhHTFIfgOybEGNxavnrGiGMmn2K5fBHvWJ/9+kDOfe9FoZNy9WegBJUUgRw5cK
 DxOa+MLbTiuL/yxKmAgaLGh5HtD91z7oUMOlECLXF4b1TTFyI620c1hBNklzm9IPOUqPotYwgMK
 FkfC+OUXrFwu1L9jNQQzU0IndkQsGPDk327uxX8cijjOc6mH0V5lhGuIXjV6X47uws4r+upGl09
 oVXo0Ny6RIkYYGQl+sjrnxzAUpf+1Wx2JQYbFt4qdMpFzM0D0NXCXW4DQjnb7SzcRwQYXW7Md2D
 4Yr6qw9WlwZgEJzmf7FOhjp4E4TFxtKLeoS+1t2vJ43NkheavKsBSvWTWItzItL5sM4jlzHvfC8
 ZvXze5jbv2ateDOP9/xBYhXTncyyNq/WnZn0nBkQ9VBJmags82J3dmLQ==
X-Received: by 2002:a05:690c:6d0a:b0:806:e2ad:534d with SMTP id
 00721157ae682-810d778b0e2mr8840097b3.7.1782759664138; 
 Mon, 29 Jun 2026 12:01:04 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-810e728652esm1606737b3.10.2026.06.29.12.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:01:03 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:00:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v4 0/9] ENETC driver related changes series
Message-ID: <20260629120059.68eb89f9@phoenix.local>
In-Reply-To: <20260629051819.989176-1-g.singh@nxp.com>
References: <20260623060004.2187716-1-g.singh@nxp.com>
 <20260629051819.989176-1-g.singh@nxp.com>
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

On Mon, 29 Jun 2026 10:48:10 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V4 changes:
>   - Fixed a compilation issue: "txbd may be used uninitialized"
>=20
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
>   - There were some false positives, I have ignored them:
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

Applied to net-next with minor rewording of git commit message
to conform with check-git-log requirements.
