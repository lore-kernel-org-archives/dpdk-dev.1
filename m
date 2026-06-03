Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62A5CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:31:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B98140648;
	Wed,  3 Jun 2026 19:31:12 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 83FF9402C4
 for <dev@dpdk.org>; Wed,  3 Jun 2026 19:31:10 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30759632453so1347044eec.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780507869;
 x=1781112669; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5IqZf1F20ZFD6Z5JdmlvTOV8yfwVeFaZzRdAjQvs68=;
 b=qIqlNLkNVgAgytBbFKzXNxbLzyuUr/gSkaxEyQruTsQnhsMkUGXCxpC0c7yjeUYlqB
 I3NOGiNoFYKicl3FjSqseLVKm6FL8UDirGGOyo94DOkesSHam+dGHVtroQEhdbL72xMW
 GbnNu9ibbOC15IEjatge0qN9RiAEHAJmlZ//5pynv08///GZiM1AkRAyJ9Mhw+ClQJQ3
 ZGbFXv6D8WBezun1t/zkYZr5wNtbLlOhjnC049JwpE1qiKJ8QIyXJ0Z3IgP43F01DLXF
 7Hka/vgyZijxhNkR4UqgPm2WS3xmkYAfKWkRAF+D1JC8fbXXCFWWAtRn4VCCzgLrhSKO
 CvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780507869; x=1781112669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A5IqZf1F20ZFD6Z5JdmlvTOV8yfwVeFaZzRdAjQvs68=;
 b=mUJD2jzFvB/xZ3uwthDN2SkrVGzEH4Q2RGZGoWUt6LX2phUIqdasw92W6+gdNEU+kf
 Fqi0Gxib80MMpiuCEsjk96QrCYhH7QUgMwddgruGpLt1DTnCFAO9/bJZhZ150oBebrf6
 tHjN6zCJ/Ds5dbAW9xE1cssInB7REzyiH+RsWpR28QRAK/x3pKQE6UzIP6WtMS8yxprS
 JQZfF297l3VmxiVajxs4+MOiw6cu31sTN6EyyY9WcqythqZAFnSlg7+cYLZQu2pmf8JM
 yztvffyHrSTL9Xiinohc2iuVGp0TapYHgg1Gb93Qvaf4P7VOkJDfIe4tzoIi7y/nY94q
 MSXQ==
X-Gm-Message-State: AOJu0Yy3GyHLC0Fc3V0HIC6Gr452Q5kGjdDaeib2USAtyuHVK/53KDLi
 jSQrUXiVU8a4dnYJWnZMWsDXgrL9V4PF7ywPxuej2y1KA1hDynbVxZOAH7Fhau+V5fdH5OWmhD2
 Cj4pg
X-Gm-Gg: Acq92OHTo8FThk28oJvU4H+JufiTUXbwf4e6DTrvv7VrmFTpabwQR5DfB3/hnHnJQC/
 Bsy9qqZfD0qh1bBir6I73tCBRN7wfwZACZqW1SZZFlJoQ3WRlFu7PgIGPz1CaSzOqq8ORWi5btm
 31/S0rOYphsYQA9mkdAHK3DbdT8vYWyFiJSJSf8ssBn6SUYCdvTX2a8+KSHWS3mIjoN4CYFzpCL
 DaI+ubcBr3/Zhvfc2DesW2j/6djG/YfB1AxXBjKCqeKrCqoMUTdvVt2ALP/e/TkyOX6ORIuLKLz
 /DAlYTGNbFxOXOUJHj3sffk28SofYIlwrOtxVM0R4khVJkBOJPmLH95lgJEf1E///pIPa6OYeAs
 htCDkKuB5gg3KoI6pyoHOComg9oKg9vSsRJttyn81gBvVKBInn0vXfEX5ru59nzfYn+eS77Zzkx
 ddlzx19TF5RRiGhROhupIKr9e+vgoo5PB/DNXQSnoLx58xJaup5NZ/oEllA0fXeXGWx8S+L9SaJ
 cM=
X-Received: by 2002:a05:7301:100e:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-3074fbc8356mr2164569eec.24.1780507869377; 
 Wed, 03 Jun 2026 10:31:09 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df805d1sm2574457eec.28.2026.06.03.10.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:31:09 -0700 (PDT)
Date: Wed, 3 Jun 2026 10:31:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 00/10] selective Rx
Message-ID: <20260603103106.5f13272e@phoenix.local>
In-Reply-To: <20260602215022.3698662-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602215022.3698662-1-thomas@monjalon.net>
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

On Tue,  2 Jun 2026 23:49:12 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> This is a new feature in ethdev with tests and mlx5 implementation.
> Selective Rx allows to receive partial data,
> saving some hardware bandwidth.
> 
> Note 1: mlx5 support patch is not correctly indented
> to make review easier. An indent patch follows to be squashed.
> 
> Note 2: DTS patch is an attempt to test the feature on day 1,
> it is not mandatory if it is blocking the merge.
> 
> v2: rework after Gregory
> v3: fix bugs found with AI by Stephen
> v4: fix packet type in DTS test
> v5: fix mlx5 Rx to handle discarding first segment
> v6: fix reindent patch
> 
> 
> Gregory Etelson (4):
>   ethdev: introduce selective Rx
>   app/testpmd: support selective Rx
>   common/mlx5: add null MR functions
>   net/mlx5: support selective Rx
> 
> Thomas Monjalon (6):
>   app/testpmd: print Rx split capabilities
>   net/mlx5: fix Rx split segment counter type
>   net/mlx5: reindent previous changes
>   common/mlx5: remove callbacks for MR registration
>   dts: fix topology capability comparison
>   dts: add selective Rx tests
> 
>  app/test-pmd/config.c                         |  17 ++
>  app/test-pmd/testpmd.c                        |  71 ++++-
>  devtools/libabigail.abignore                  |   7 +
>  doc/guides/nics/features.rst                  |  14 +
>  doc/guides/nics/features/default.ini          |   1 +
>  doc/guides/nics/features/mlx5.ini             |   1 +
>  doc/guides/nics/mlx5.rst                      |  86 ++++--
>  doc/guides/rel_notes/release_26_07.rst        |  11 +
>  doc/guides/testpmd_app_ug/run_app.rst         |  20 ++
>  drivers/common/mlx5/linux/mlx5_common_verbs.c |  53 ++--
>  drivers/common/mlx5/mlx5_common.c             |   6 +-
>  drivers/common/mlx5/mlx5_common_mr.c          |  37 ++-
>  drivers/common/mlx5/mlx5_common_mr.h          |  29 +-
>  drivers/common/mlx5/windows/mlx5_common_os.c  |  31 ++-
>  drivers/compress/mlx5/mlx5_compress.c         |   4 +-
>  drivers/crypto/mlx5/mlx5_crypto.h             |   2 -
>  drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   6 +-
>  drivers/net/mlx5/mlx5.c                       |   7 +
>  drivers/net/mlx5/mlx5.h                       |   4 +-
>  drivers/net/mlx5/mlx5_ethdev.c                |  25 ++
>  drivers/net/mlx5/mlx5_flow_aso.c              |  21 +-
>  drivers/net/mlx5/mlx5_flow_hw.c               |  11 +-
>  drivers/net/mlx5/mlx5_flow_quota.c            |   6 +-
>  drivers/net/mlx5/mlx5_hws_cnt.c               |  19 +-
>  drivers/net/mlx5/mlx5_rx.c                    | 186 ++++++++-----
>  drivers/net/mlx5/mlx5_rx.h                    |   5 +-
>  drivers/net/mlx5/mlx5_rxq.c                   |  75 +++--
>  drivers/net/mlx5/mlx5_trigger.c               |  64 ++++-
>  dts/api/capabilities.py                       |   2 +
>  dts/api/testpmd/__init__.py                   |  17 ++
>  dts/api/testpmd/types.py                      |   6 +
>  dts/framework/testbed_model/capability.py     |  10 +-
>  dts/tests/TestSuite_rx_split.py               | 262 ++++++++++++++++++
>  lib/ethdev/rte_ethdev.c                       |  24 +-
>  lib/ethdev/rte_ethdev.h                       |  14 +-
>  35 files changed, 880 insertions(+), 274 deletions(-)
>  create mode 100644 dts/tests/TestSuite_rx_split.py
> 

Still has some issues:

Patch 6: net/mlx5: support selective Rx
 
Error: after a non-critical Rx error CQE, the next packet is processed with
a stale length and stale CQE; the queue effectively wedges.
 
To avoid re-polling the CQE on each leading discard segment of one packet,
v6 wraps the poll in "if (len == 0)" and resets len to 0 at the points where
a packet finishes. Two of the three exits reset it (normal completion and
the "no real segment found" skip both do "len = 0;"), but the non-critical
error-CQE path does not:
 
	if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
		if (seg->pool)
			rte_mbuf_raw_free(rep);
		if (len == MLX5_CRITICAL_ERROR_CQE_RET) {
			rq_ci = rxq->rq_ci << sges_n;
			break;
		}
		rq_ci >>= sges_n;
		rq_ci += skip_cnt;
		rq_ci <<= sges_n;
		MLX5_ASSERT(!pkt);
		continue;	/* len still == MLX5_ERROR_CQE_MASK (0x40000000) */
	}
 
MLX5_ERROR_CQE_MASK is 0x40000000, so len is non-zero on this continue. The
next iteration hits "if (len == 0)" == false and skips mlx5_rx_poll_len()
entirely. The following real segment then sets pkt with PKT_LEN(pkt) ==
0x40000000 and rxq_cq_to_mbuf() reads the stale cqe/mcqe. Because
0x40000000 > DATA_LEN(seg), the "more data" branch keeps consuming
descriptors as one bogus giant packet, walking the whole ring and emitting
nothing. Pre-v6 this worked because the poll was unconditional in the !pkt
block.
 
Suggested fix: reset len before the error-skip continue, matching the other
two exits:
 
		rq_ci >>= sges_n;
		rq_ci += skip_cnt;
		rq_ci <<= sges_n;
		MLX5_ASSERT(!pkt);
		len = 0;
		continue;
 
Minor: "tail = seg;" is now set in both the "first real segment" block and
the "real segment: replenish WQE" block; the first is redundant since the
second always runs for the same segment. Harmless, but the duplicate can be
dropped.
 
