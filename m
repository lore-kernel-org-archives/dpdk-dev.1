Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F78D73E9C
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 22:21:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 060A74026F;
	Thu, 29 Jan 2026 23:21:57 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 12FCE4014F
 for <dev@dpdk.org>; Thu, 29 Jan 2026 23:21:55 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-124877d78a6so1939470c88.1
 for <dev@dpdk.org>; Thu, 29 Jan 2026 14:21:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769725314; cv=none;
 d=google.com; s=arc-20240605;
 b=UBp+qkArTUvtuJpteDurTznAwK1WD0/JiZ4v9NYx1yydYzMUGOUfxpQWeIu4cwdHxL
 j+OSqa5arwukdTscsgpbQGXtyCALW868ZvGAkrVkduF1dw05DO5OrA1g6HdFLAV0BFFs
 LDKHnf/FugAD9rCQDzoJGQW3BxF2SrZVsz3g5dzUjx0Ml+lxg3KRX+xPEZ2E4UDDdsQa
 FU5Xf1g2BIBPO6MAUlwWxTydeWVfS4go89qqC1eumDYiMToJ5JsYl+bFcgrughW/ULYR
 TK2IgMDTiMBl3MnuVh1R4A2Eu+HQ4PM898IBKV4O3NgiLm3ZriCPDlIA8CU2RsJ3PIOj
 dg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BSksPbDgp+iAtz9yQgLx8VHyNkNgi1RsQ1zPlFmI/vI=;
 fh=FcbBUiXNZLGtpIypAPK82pctGQ9LPis+DQT+UnOKPB0=;
 b=inhOTNThAIIF7GcvdlM1CQA0V6HBudMKIFHWbWTdiQxSAV4QSvjtEqlchhzb+GJjRl
 GOzyVve4zFLWFWHkZ2megbwNXyU1bUKUkc4Wu5zwJgNysiIxaR6XQE1tpkRtbU93TAvx
 tuuuZ6Fm6Qbuy2yDcsjrQaSNc9L8K4kfDJs5jtlCD3XktdM0Wiq15qb1/s24jGT/QrwN
 /dhaiFpjEXAPY1va0s8eURgS3YlCU9jyQRZglnybKrU4kx9XQHdDuVNaLBDrSTBCwCTN
 e7Mt4gmOihxTxjvn4iiCcHc8kCb9awjlqrnNhVhG9ufKlNSf4dObJ94iYTFObiWizT4U
 RFWQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769725314; x=1770330114; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BSksPbDgp+iAtz9yQgLx8VHyNkNgi1RsQ1zPlFmI/vI=;
 b=cFKs1vKetOW62NxLU8PiHdhLm6AQ9ynwJ9WgepK6s6jTByXeVn2LMiuJZSTWTkEXD6
 L/QY9yTTD9Q4olbQQhs/COqWsQJ9KDdXccRiysH1wt5wLTD2MFi9YKs69WKMQFry6uL7
 d5z6RMyz+bucxw0klXrsJ+w1WH97O7zgYX/p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769725314; x=1770330114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BSksPbDgp+iAtz9yQgLx8VHyNkNgi1RsQ1zPlFmI/vI=;
 b=WKPE9p1PZgEigX48f8D3ThXwwki4Cvg9Z2GIkqiO/5+vG3/bFlnhCuIDEhr1LGXjXZ
 u7Vm1dIiBOxKjg5tAnUJKqwwDvrfdQHwnby/kUAGyWs5QxV00li1QjVHpyLs0D9lYLsi
 t1QF50/H6+QZ1AQghD4ak59pmL10lkEYqqOLOA3UeLLwYX27BlG4x22rblaACBxfcvrK
 GKpjqb5eWJeyynhFKtbtxXqKNiEvx0jT46/PziqNtAOmxhU1KCZeBsEOQko8Wixl1ttp
 mCyN1qZ29LEF2ERUAydlhIyDqKHEdq5E96/g8oRTAXOaYvRIRUy6s0M3MjPtzqFjW31V
 53EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY22i8nuPuSUnsOQkW6A/tGDcPwdyj+4YpOzv3U5Q6xxCSzcGp+VfufSMCF7t06uzW/eQ=@dpdk.org
X-Gm-Message-State: AOJu0Yx4sC32KmmEw67lk26BUWmLM51ThLrg/f2OeN1DwaRtbu8O/MqV
 VSRi3KYWkPabl1eqJ12hYuOq2tiWxx7Z867bCOGToguwxEPuLMj0PEyvMgAd/9E+G95O2A4wIXu
 T4dqBkVeZTR2+bRKwcBv7oFmjpMY35W50bLvcCyia3w==
X-Gm-Gg: AZuq6aJXtZB8TH8gbGwAmRQciPSnQyob0tvWBd5vIWhdbYDaplP1FPG7SDrg2ULp1xp
 VCvRfiIsfiQvji7yI37HgsyHz/ljbO/6jmlpQaLbypUjpNyA39ire0XccaTSqpt13boW+w+S95g
 YOE8eX6zCCGiE73ngiMW9+vg3PXOPcvd6xor4+0mi8c5VlzKEKRV9Ts1w7zCj1HnM/s08HnW4jy
 x+ytBdX5+kjQJ2KtQDx/T117eToqt01VQQgr4ORJ49x3wqA9dIRJhgpdXCEYXkrGgalUw9tKqxo
 2Pvpbnw1yOhtR1GhNPBguO5b9npdXs/3pz8fTxvv9Q==
X-Received: by 2002:a05:7022:fa2:b0:123:3461:99a4 with SMTP id
 a92af1059eb24-125c0fad517mr519573c88.17.1769725313838; Thu, 29 Jan 2026
 14:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20251217182540.715464-1-abailey@iol.unh.edu>
 <20251218150718.738116-1-abailey@iol.unh.edu>
In-Reply-To: <20251218150718.738116-1-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 29 Jan 2026 17:19:28 -0500
X-Gm-Features: AZwV_Qgw_6cLyqFV73IIphE00LX86YQX9gA1zmlZg4NTE7fgvA4jP4WYMDXBM64
Message-ID: <CAJvnSUBEinLXL0SOJ8RqE79ebXgmNLhaSBff-gNFXiN8yrZ0Gw@mail.gmail.com>
Subject: Re: [PATCH v2] dts: update testsuite named to be clear and consistent
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Can you add a fix for the pmd_rss rst file (changing it to simply
rss)? You will need to rebase off of next-dts/for-main first so that
your fix (that adds the rst file in the first place) is pulled in,
which will allow you to modify the file.

On Thu, Dec 18, 2025 at 10:07=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu=
> wrote:
>
> Some test suites were prefixed with PMD which is not meaningful.
> Other test suites used different naming schemes and this patch updates
> this. For example, some abbreviated words that others had not. These
> word are no longer abbreviated.
>
> Bugzilla ID: 1826
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  doc/api/dts/tests.TestSuite_buffer_scatter.rst            | 8 ++++++++
>  doc/api/dts/tests.TestSuite_flow_offload.rst              | 8 ++++++++
>  ...uite_virtio_fwd.rst =3D> tests.TestSuite_l2_forward.rst} | 4 ++--
>  doc/api/dts/tests.TestSuite_l2fwd.rst                     | 8 --------
>  doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst        | 8 --------
>  doc/api/dts/tests.TestSuite_queue_start_stop.rst          | 8 --------
>  doc/api/dts/tests.TestSuite_queue_toggle.rst              | 8 ++++++++
>  doc/api/dts/tests.TestSuite_rte_flow.rst                  | 8 --------
>  doc/api/dts/tests.TestSuite_uni_pkt.rst                   | 8 --------
>  doc/api/dts/tests.TestSuite_unified_packet.rst            | 8 ++++++++
>  doc/api/dts/tests.TestSuite_virtio_forward.rst            | 8 ++++++++
>  ..._pmd_buffer_scatter.py =3D> TestSuite_buffer_scatter.py} | 4 ++--
>  .../{TestSuite_rte_flow.py =3D> TestSuite_flow_offload.py}  | 6 +++---
>  dts/tests/{TestSuite_l2fwd.py =3D> TestSuite_l2_forward.py} | 2 +-
>  ...uite_queue_start_stop.py =3D> TestSuite_queue_toggle.py} | 6 +++---
>  dts/tests/{TestSuite_pmd_rss.py =3D> TestSuite_rss.py}      | 2 +-
>  .../{TestSuite_uni_pkt.py =3D> TestSuite_unified_packet.py} | 2 +-
>  ...estSuite_virtio_fwd.py =3D> TestSuite_virtio_forward.py} | 2 +-
>  18 files changed, 54 insertions(+), 54 deletions(-)
>  create mode 100644 doc/api/dts/tests.TestSuite_buffer_scatter.rst
>  create mode 100644 doc/api/dts/tests.TestSuite_flow_offload.rst
>  rename doc/api/dts/{tests.TestSuite_virtio_fwd.rst =3D> tests.TestSuite_=
l2_forward.rst} (60%)
>  delete mode 100644 doc/api/dts/tests.TestSuite_l2fwd.rst
>  delete mode 100644 doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
>  delete mode 100644 doc/api/dts/tests.TestSuite_queue_start_stop.rst
>  create mode 100644 doc/api/dts/tests.TestSuite_queue_toggle.rst
>  delete mode 100644 doc/api/dts/tests.TestSuite_rte_flow.rst
>  delete mode 100644 doc/api/dts/tests.TestSuite_uni_pkt.rst
>  create mode 100644 doc/api/dts/tests.TestSuite_unified_packet.rst
>  create mode 100644 doc/api/dts/tests.TestSuite_virtio_forward.rst
>  rename dts/tests/{TestSuite_pmd_buffer_scatter.py =3D> TestSuite_buffer_=
scatter.py} (98%)
>  rename dts/tests/{TestSuite_rte_flow.py =3D> TestSuite_flow_offload.py} =
(99%)
>  rename dts/tests/{TestSuite_l2fwd.py =3D> TestSuite_l2_forward.py} (98%)
>  rename dts/tests/{TestSuite_queue_start_stop.py =3D> TestSuite_queue_tog=
gle.py} (97%)
>  rename dts/tests/{TestSuite_pmd_rss.py =3D> TestSuite_rss.py} (99%)
>  rename dts/tests/{TestSuite_uni_pkt.py =3D> TestSuite_unified_packet.py}=
 (99%)
>  rename dts/tests/{TestSuite_virtio_fwd.py =3D> TestSuite_virtio_forward.=
py} (99%)
>
> diff --git a/doc/api/dts/tests.TestSuite_buffer_scatter.rst b/doc/api/dts=
/tests.TestSuite_buffer_scatter.rst
> new file mode 100644
> index 0000000000..ce764ff0d6
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_buffer_scatter.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +buffer_scatter Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +.. automodule:: tests.TestSuite_buffer_scatter
> +   :members:
> +   :show-inheritance:
> diff --git a/doc/api/dts/tests.TestSuite_flow_offload.rst b/doc/api/dts/t=
ests.TestSuite_flow_offload.rst
> new file mode 100644
> index 0000000000..5fcd3f57c3
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_flow_offload.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +flow_offload Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: tests.TestSuite_flow_offload
> +   :members:
> +   :show-inheritance:
> diff --git a/doc/api/dts/tests.TestSuite_virtio_fwd.rst b/doc/api/dts/tes=
ts.TestSuite_l2_forward.rst
> similarity index 60%
> rename from doc/api/dts/tests.TestSuite_virtio_fwd.rst
> rename to doc/api/dts/tests.TestSuite_l2_forward.rst
> index e40cc4ca2b..3570a1e101 100644
> --- a/doc/api/dts/tests.TestSuite_virtio_fwd.rst
> +++ b/doc/api/dts/tests.TestSuite_l2_forward.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: BSD-3-Clause
>
> -virtio_fwd Test Suite
> +l2_forward Test Suite
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -.. automodule:: tests.TestSuite_virtio_fwd
> +.. automodule:: tests.TestSuite_l2_forward
>     :members:
>     :show-inheritance:
> diff --git a/doc/api/dts/tests.TestSuite_l2fwd.rst b/doc/api/dts/tests.Te=
stSuite_l2fwd.rst
> deleted file mode 100644
> index 5a0ca312e9..0000000000
> --- a/doc/api/dts/tests.TestSuite_l2fwd.rst
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -.. SPDX-License-Identifier: BSD-3-Clause
> -
> -l2fwd Test Suite
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -.. automodule:: tests.TestSuite_l2fwd
> -   :members:
> -   :show-inheritance:
> diff --git a/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst b/doc/api=
/dts/tests.TestSuite_pmd_buffer_scatter.rst
> deleted file mode 100644
> index cdf30fd879..0000000000
> --- a/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -.. SPDX-License-Identifier: BSD-3-Clause
> -
> -pmd_buffer_scatter Test Suite
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -
> -.. automodule:: tests.TestSuite_pmd_buffer_scatter
> -   :members:
> -   :show-inheritance:
> diff --git a/doc/api/dts/tests.TestSuite_queue_start_stop.rst b/doc/api/d=
ts/tests.TestSuite_queue_start_stop.rst
> deleted file mode 100644
> index 87121676fb..0000000000
> --- a/doc/api/dts/tests.TestSuite_queue_start_stop.rst
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -.. SPDX-License-Identifier: BSD-3-Clause
> -
> -queue_start_stop Test Suite
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> -
> -.. automodule:: tests.TestSuite_queue_start_stop
> -   :members:
> -   :show-inheritance:
> diff --git a/doc/api/dts/tests.TestSuite_queue_toggle.rst b/doc/api/dts/t=
ests.TestSuite_queue_toggle.rst
> new file mode 100644
> index 0000000000..1d6345511f
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_queue_toggle.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +queue_toggle Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: tests.TestSuite_queue_toggle
> +   :members:
> +   :show-inheritance:
> diff --git a/doc/api/dts/tests.TestSuite_rte_flow.rst b/doc/api/dts/tests=
.TestSuite_rte_flow.rst
> deleted file mode 100644
> index eacbfd3a2a..0000000000
> --- a/doc/api/dts/tests.TestSuite_rte_flow.rst
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -.. SPDX-License-Identifier: BSD-3-Clause
> -
> -rte_flow Test Suite
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -.. automodule:: tests.TestSuite_rte_flow
> -   :members:
> -   :show-inheritance:
> diff --git a/doc/api/dts/tests.TestSuite_uni_pkt.rst b/doc/api/dts/tests.=
TestSuite_uni_pkt.rst
> deleted file mode 100644
> index 95c5a5a28b..0000000000
> --- a/doc/api/dts/tests.TestSuite_uni_pkt.rst
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -.. SPDX-License-Identifier: BSD-3-Clause
> -
> -uni_pkt Test Suite
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -.. automodule:: tests.TestSuite_uni_pkt
> -   :members:
> -   :show-inheritance:
> diff --git a/doc/api/dts/tests.TestSuite_unified_packet.rst b/doc/api/dts=
/tests.TestSuite_unified_packet.rst
> new file mode 100644
> index 0000000000..dddf12b18a
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_unified_packet.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +unified_packet Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +.. automodule:: tests.TestSuite_unified_packet
> +   :members:
> +   :show-inheritance:
> diff --git a/doc/api/dts/tests.TestSuite_virtio_forward.rst b/doc/api/dts=
/tests.TestSuite_virtio_forward.rst
> new file mode 100644
> index 0000000000..9178c73be5
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_virtio_forward.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +virtio_forward Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +.. automodule:: tests.TestSuite_virtio_forward
> +   :members:
> +   :show-inheritance:
> diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSu=
ite_buffer_scatter.py
> similarity index 98%
> rename from dts/tests/TestSuite_pmd_buffer_scatter.py
> rename to dts/tests/TestSuite_buffer_scatter.py
> index 96da67ee7d..48c0167de6 100644
> --- a/dts/tests/TestSuite_pmd_buffer_scatter.py
> +++ b/dts/tests/TestSuite_buffer_scatter.py
> @@ -35,8 +35,8 @@
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
> -class TestPmdBufferScatter(TestSuite):
> -    """DPDK PMD packet scattering test suite.
> +class TestBufferScatter(TestSuite):
> +    """DPDK packet scattering test suite.
>
>      Configure the Rx queues to have mbuf data buffers
>      whose sizes are smaller than the maximum packet size.
> diff --git a/dts/tests/TestSuite_rte_flow.py b/dts/tests/TestSuite_flow_o=
ffload.py
> similarity index 99%
> rename from dts/tests/TestSuite_rte_flow.py
> rename to dts/tests/TestSuite_flow_offload.py
> index 207cbce2d3..7339749908 100644
> --- a/dts/tests/TestSuite_rte_flow.py
> +++ b/dts/tests/TestSuite_flow_offload.py
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2025 University of New Hampshire
>
> -"""RTE Flow testing suite.
> +"""Flow Offload testing suite.
>
>  This suite verifies a range of flow rules built using patterns
>  and actions from the RTE Flow API. It would be impossible to cover
> @@ -32,8 +32,8 @@
>
>
>  @requires_nic_capability(NicCapability.FLOW_CTRL)
> -class TestRteFlow(TestSuite):
> -    """RTE Flow test suite.
> +class TestFlowOffload(TestSuite):
> +    """Flow Offload test suite.
>
>      This suite consists of 12 test cases:
>      1. Queue Action Ethernet: Verifies queue actions with ethernet patte=
rns
> diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2_forwar=
d.py
> similarity index 98%
> rename from dts/tests/TestSuite_l2fwd.py
> rename to dts/tests/TestSuite_l2_forward.py
> index 596b892730..95f9c62bdc 100644
> --- a/dts/tests/TestSuite_l2fwd.py
> +++ b/dts/tests/TestSuite_l2_forward.py
> @@ -28,7 +28,7 @@
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> -class TestL2fwd(TestSuite):
> +class TestL2Forward(TestSuite):
>      """L2 forwarding test suite."""
>
>      #: The total number of packets to generate and send for forwarding.
> diff --git a/dts/tests/TestSuite_queue_start_stop.py b/dts/tests/TestSuit=
e_queue_toggle.py
> similarity index 97%
> rename from dts/tests/TestSuite_queue_start_stop.py
> rename to dts/tests/TestSuite_queue_toggle.py
> index e9048d4245..50d371e975 100644
> --- a/dts/tests/TestSuite_queue_start_stop.py
> +++ b/dts/tests/TestSuite_queue_toggle.py
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2024 University of New Hampshire
>
> -"""Rx/Tx queue start and stop functionality suite.
> +"""Rx/Tx queue toggle functionality suite.
>
>  This suite tests the ability of the poll mode driver to start and
>  stop either the Rx or Tx queue (depending on the port) during runtime,
> @@ -32,8 +32,8 @@
>  @requires_link_topology(LinkTopology.TWO_LINKS)
>  @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
>  @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
> -class TestQueueStartStop(TestSuite):
> -    """DPDK Queue start/stop test suite.
> +class TestQueueToggle(TestSuite):
> +    """DPDK Queue toggle test suite.
>
>      Ensures Rx/Tx queue on a port can be disabled and enabled.
>      Verifies packets are not received when either queue is disabled.
> diff --git a/dts/tests/TestSuite_pmd_rss.py b/dts/tests/TestSuite_rss.py
> similarity index 99%
> rename from dts/tests/TestSuite_pmd_rss.py
> rename to dts/tests/TestSuite_rss.py
> index f6adf262c3..f941248d7a 100644
> --- a/dts/tests/TestSuite_pmd_rss.py
> +++ b/dts/tests/TestSuite_rss.py
> @@ -55,7 +55,7 @@ class HashAlgorithm(StrEnum):
>
>  @requires_link_topology(LinkTopology.ONE_LINK)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_RSS_HASH)
> -class TestPmdRss(TestSuite):
> +class TestRss(TestSuite):
>      """PMD RSS test suite."""
>
>      config: Config
> diff --git a/dts/tests/TestSuite_uni_pkt.py b/dts/tests/TestSuite_unified=
_packet.py
> similarity index 99%
> rename from dts/tests/TestSuite_uni_pkt.py
> rename to dts/tests/TestSuite_unified_packet.py
> index 97d61cd03a..a35e25d25b 100644
> --- a/dts/tests/TestSuite_uni_pkt.py
> +++ b/dts/tests/TestSuite_unified_packet.py
> @@ -34,7 +34,7 @@
>
>
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> -class TestUniPkt(TestSuite):
> +class TestUnifiedPacket(TestSuite):
>      """DPDK Unified packet test suite.
>
>      This testing suite uses testpmd's verbose output hardware/software
> diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virt=
io_forward.py
> similarity index 99%
> rename from dts/tests/TestSuite_virtio_fwd.py
> rename to dts/tests/TestSuite_virtio_forward.py
> index bdecdb76fd..6efaa4e156 100644
> --- a/dts/tests/TestSuite_virtio_fwd.py
> +++ b/dts/tests/TestSuite_virtio_forward.py
> @@ -20,7 +20,7 @@
>  from framework.testbed_model.virtual_device import VirtualDevice
>
>
> -class TestVirtioFwd(TestSuite):
> +class TestVirtioForward(TestSuite):
>      """Virtio forwarding test suite."""
>
>      virtio_user_vdev =3D VirtualDevice(
> --
> 2.50.1
>
