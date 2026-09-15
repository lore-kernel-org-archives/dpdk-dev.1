Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA5C88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 07:01:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 249B0406B4;
	Tue, 15 Sep 2026 09:01:07 +0200 (CEST)
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by mails.dpdk.org (Postfix) with ESMTP id 6993940290
 for <dev@dpdk.org>; Tue, 15 Sep 2026 09:01:05 +0200 (CEST)
Received: by mail-yx2-f13.google.com with SMTP id
 00721157ae682-8659af7454eso27953967b3.1
 for <dev@dpdk.org>; Tue, 15 Sep 2026 00:01:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789455664; cv=none;
 d=google.com; s=arc-20260327;
 b=Z17HvqslenRJXp6vz0kpwsuhbOlPXCtHIUBD+GgdYkAT1uMuPXTKMJdWONTFLEX+4+
 rVvXgXJYZ1IwrED8riMmqk5Z7EFJxIcDCWpRTNbix+sYWNUfuD+ET7YNiarObAT8nZQg
 ytPOzsvaU+EYqgB4Ie5mSjbjxg79IFn+k+PLCit2lOKn1fihaze9PStybfqmTbJkbDoE
 71cuhBVrACbXRGxZkkRV8DHJ9fFfCfmvw0LtoM1EDsUKc9Qhjiim2tjVo9KoDz9GnEdX
 dBqxWLxJyND41PNf9IuD/EGssqGkLZpMJ8XKCaUhUEYbxnj+myvdT/np2VPy3KiZuBTJ
 a5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J4t3HsriFkBsm9jKN4rKMF9PEVE2pwhUNgKwgrfBPSY=;
 fh=lAl6fCF5zytnZOe2Fupkc+mj4NGOLpy6djGkIobTFjs=;
 b=oY8tcY1BqcJXHdl0d/3791p5DVm9HXPM3cGs7fUIB3rk7LGJULJmjXAp7Vg9sOTgu4
 vocZhlYUx12wFBvbk1RI57fPqSF8ihIuzCGH5So+t1ihnBF0wxqWK7rSLsAGlUMBbvEF
 HF3L/vf6ofz1IrmEiAAmNZzfGjjzNOZ9X1x0HN6VyFncfY34r8ZJ51wbskwd1JqNs+kQ
 9jGOpVt113lmG55Q5S8i3lhe3/WEg0i7c6fjfrIl6G4lmfyC2n77OiEtXum6fQG8jzyg
 hMnBf/shAhZovUJfuGJlWWyWfCg07sRTqvuwy696/5J4SuPCaY76AvG5Woe1/Tybfozq
 Jcbg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789455664; x=1790060464; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J4t3HsriFkBsm9jKN4rKMF9PEVE2pwhUNgKwgrfBPSY=;
 b=bFTFwEwbPYOL7+qMRDZWo5Xn8laP3OtWNiC4Ey6ngYMt21H272xXE6NkrNF4Q4v3TX
 okc8+TM7oDahmac9mBa35l1NrQhD6oLJVLgl2nbze1LAhLHLC9M34CtRU4wGxfKJOhgU
 s1eU0PUW0vm1eyADuRrvu/s9ZQjNIvSPYpJxnkIEHLW9ypC1Flfnfaj6XKWS1qQ2UOT3
 g9ZEJbAJSo+RqtN3a/BPA4yJUTpzz8AyYmlEP1U8oxPscCZbsCovOkrSEiO8TEkowWGo
 DAieh/rljHc6/0rdDuGXci25t7wntpEoybMV2N7c4ZxKZH4utGMPYK+OTPqfWmVaWTTx
 0eqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789455664; x=1790060464;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J4t3HsriFkBsm9jKN4rKMF9PEVE2pwhUNgKwgrfBPSY=;
 b=P6tzOHOsjlFfePNtm9Pnt6CG/bPsrG+J9FokqU7qpCSIzJclH55GQtqXnX2whhXg9s
 LlOM64Ttt7iAmtqphNn66dOdJ9iYxzUJdcJEV96H1bWynmqNUiVu13CD95dMPLnlmWhN
 o29L5nRx+BGoy9N31wwglyBgSYw74JfObk/umyQ4SRcxT+YrKLmaQU44RwdCSu55kWXl
 YCHRr0BQWD8Y3UhXtG7/zj0JLRer3QoJ9Qud0X0t7byEXJrcKV5glHaZwsdNwXnSK+ss
 lB7dPkyS26wL5goaTAWm2GRUVJu7Koeirh95FPyjFLf6w8nl2erjMBkCXG4+B7AvEpdG
 kolw==
X-Gm-Message-State: AFuF++lXfHspXKkNsFOhcAyCCflg5LKY2IeJT3XOKR9f0jR5Gr2B8v5o
 zRAlY4CVrgyx3SuD++LY6Yr11IB8wx9dC745wsjWnW0O0tchGHcIY9YiEdtZwsfCdrKRK02Q5ni
 tdfcI7jj7y0FbuY6dG54jzNvfndqr/3Q=
X-Gm-Gg: AYBFou0Y3ShwSHrSiBqtbL2FwVIDCPhKTY/dMi/YcUr9dEqH8FxF9V0oRrNrfo9MKbE
 np7q2xHIMeO5jV4u11yrdjZTR2F4EEZ3Bn/X9Da38OGAp3Ye0xgfU5EC5uAjj1nvN/kvaBxTp4S
 L4RELQrt/Dl0IeDjnLOwmvO3JPt25UUnRKqDVjPyXEPzmJUr14yZCWDudyN5qNNIV5f1AwwxJ/g
 7EgxoxBTqG+WpFP0vOqwgg6J3nWLVIDM92lpZQSEWC2RWgI5Gy7+K/66haPA9lAn8nrYsyEKDv7
 JMwcBOn3tD7ch7ffMcbtt49BESM8n7jFbjj6laUlsVS7yfg5AYeL/bktgAcNk1T8NLXnRp8Twj2
 Qf8ykUYnamcu/Kekp6kuUbyoZ47oWOJ2xPxkAoVBBE2HYhfZB+6HirO2D0y9JpACNARSTeBOdC3
 oEUycf5mZ8gkrzTRA1Ww==
X-Received: by 2002:a05:690c:4ab0:b0:873:5c0f:28f with SMTP id
 00721157ae682-88d23c93dccmr13827007b3.57.1789455663995; Tue, 15 Sep 2026
 00:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260830163133.1399749-1-vattunuru@marvell.com>
In-Reply-To: <20260830163133.1399749-1-vattunuru@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 15 Sep 2026 12:30:37 +0530
X-Gm-Features: AcwNN1VmS5SaQbEKXwAQBZb5dmN9ESJ_0RDNfo_-xWrr7oDMI5Q1Irm2lEHdLAY
Message-ID: <CALBAE1Psij4MSnPjNnP9BAkRxQKVZi1+gJt183dTev3gj8EL+A@mail.gmail.com>
Subject: Re: [PATCH v0 1/1] net/octeon_ep: add CN20K SDP VF endpoint support
To: Vamsi Krishna <vattunuru@marvell.com>
Cc: dev@dpdk.org, jerinj@marvell.com, ndabilpuram@marvell.com
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

On Sun, Aug 30, 2026 at 10:02=E2=80=AFPM Vamsi Krishna <vattunuru@marvell.c=
om> wrote:
>
> From: Vamsi Attunuru <vattunuru@marvell.com>
>
> Introduce CN20K mailbox, ring setup, and TX & RX handling
> in the octeon_ep driver, with PCI probe and ethdev integration
> for O20 endpoint hardware.
>
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>

1) Please update the release notes
2) Please update doc/guides/nics/octeon_ep.rst
3) Fix the genunine issues mentioned in
https://mails.dpdk.org/archives/test-report/2026-August/1037042.html
4) Use C11 rte_atomic APIs instead of rte_smp_rmb()



> ---
>  drivers/net/octeon_ep/cn20k_ep_mbox.c   | 825 ++++++++++++++++++++++++
>  drivers/net/octeon_ep/cn20k_ep_mbox.h   | 133 ++++
>  drivers/net/octeon_ep/cn20k_ep_vf.c     | 425 ++++++++++++
>  drivers/net/octeon_ep/cn20k_ep_vf.h     | 175 +++++
>  drivers/net/octeon_ep/cnxk_ep_rx.c      |  90 ++-
>  drivers/net/octeon_ep/cnxk_ep_rx.h      |  29 +-
>  drivers/net/octeon_ep/cnxk_ep_rx_avx.c  |  38 +-
>  drivers/net/octeon_ep/cnxk_ep_rx_neon.c |  71 +-
>  drivers/net/octeon_ep/cnxk_ep_rx_sse.c  |  29 +-
>  drivers/net/octeon_ep/meson.build       |   2 +
>  drivers/net/octeon_ep/otx_ep_common.h   |   9 +
>  drivers/net/octeon_ep/otx_ep_ethdev.c   |  88 ++-
>  drivers/net/octeon_ep/otx_ep_mbox.c     |  16 +-
>  drivers/net/octeon_ep/otx_ep_rxtx.c     |   3 +
>  14 files changed, 1850 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/net/octeon_ep/cn20k_ep_mbox.c b/drivers/net/octeon_e=
p/cn20k_ep_mbox.c
> new file mode 100644
> index 0000000000..625f807ca2
> --- /dev/null
> +++ b/drivers/net/octeon_ep/cn20k_ep_mbox.c
> @@ -0,0 +1,825 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2026 Marvell.
> + */
> +
> +#include <errno.h>
> +#include <string.h>
> +
> +#include <rte_common.h>
> +#include <rte_cycles.h>
> +#include <rte_malloc.h>
> +
> +#include "otx_ep_common.h"
> +#include "otx2_ep_vf.h"
> +#include "cn20k_ep_vf.h"
> +#include "cn20k_ep_mbox.h"
> +
> +#define MBOX_RSP_TIMEOUT_MS     10000
> +#define MBOX_CMD_TIMEOUT_US     1000000
> +
> +#define CN20K_MBOX_MSGS_OFFSET  RTE_ALIGN(sizeof(struct cn20k_mbox_hdr),=
 MBOX_MSG_ALIGN)
> +
> +static int
> +cn20k_mbox_wait_wr_cmd_out(struct otx_ep_device *otx_ep, uint16_t offset=
)
> +{
> +       uint64_t timeout =3D (MBOX_CMD_TIMEOUT_US * rte_get_timer_hz()) /=
 1000000;
> +       uint64_t start =3D rte_get_timer_cycles();
> +
> +       while (oct_ep_read64(otx_ep->hw_addr + CN20K_SDP_RMT_VFX_MBOX_WR_=
CMD_CTL) &
> +              CN20K_MBOX_WR_CMD_OUT) {
> +               if (rte_get_timer_cycles() - start >=3D timeout) {
> +                       otx_ep_err("Mbox write timeout waiting for CMD_OU=
T clear (offset %u)",
> +                                  offset);
> +                       return -ETIMEDOUT;
> +               }
> +               rte_pause();
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +cn20k_mbox_wait_rd_cmd_out(struct otx_ep_device *otx_ep, uint16_t offset=
)
> +{
> +       uint64_t timeout =3D (MBOX_CMD_TIMEOUT_US * rte_get_timer_hz()) /=
 1000000;
> +       uint64_t start =3D rte_get_timer_cycles();
> +
> +       while (oct_ep_read64(otx_ep->hw_addr + CN20K_SDP_RMT_VFX_MBOX_RD_=
CMD_CTL) &
> +              CN20K_MBOX_RD_CMD_OUT) {
> +               if (rte_get_timer_cycles() - start >=3D timeout) {
> +                       otx_ep_err("Mbox read timeout waiting for CMD_OUT=
 clear (offset %u)",
> +                                  offset);
> +                       return -ETIMEDOUT;
> +               }
> +               rte_pause();
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +otx_ep_cn20k_mbox_write(struct otx_ep_device *otx_ep, uint16_t offset, v=
oid *buf, size_t len)
> +{
> +       uint64_t *data =3D (uint64_t *)buf;
> +       size_t num_words =3D (len + 7) / 8;
> +       uint64_t ctl;
> +       size_t i;
> +       int ret;
> +
> +       otx_ep_dbg("CN20K: mbox_write called: offset=3D%u, len=3D%zu", of=
fset, len);
> +
> +       if (offset & 0x7) {
> +               otx_ep_err("Mailbox offset 0x%x not 8-byte aligned", offs=
et);
> +               return -EINVAL;
> +       }
> +
> +       ret =3D cn20k_mbox_wait_wr_cmd_out(otx_ep, offset);
> +       if (ret)
> +               return ret;
> +
> +       oct_ep_write64(offset, otx_ep->hw_addr + CN20K_SDP_RMT_VFX_MBOX_W=
R_CMD_OFFSET);
> +
> +       for (i =3D 0; i < num_words; i++) {
> +               uint64_t timeout =3D (MBOX_CMD_TIMEOUT_US * rte_get_timer=
_hz()) / 1000000;
> +               uint64_t start =3D rte_get_timer_cycles();
> +
> +               oct_ep_write64(data[i], otx_ep->hw_addr + CN20K_SDP_RMT_V=
FX_MBOX_WR_CMD_DATA);
> +
> +               do {
> +                       ctl =3D oct_ep_read64(otx_ep->hw_addr + CN20K_SDP=
_RMT_VFX_MBOX_WR_CMD_CTL);
> +                       if (rte_get_timer_cycles() - start >=3D timeout) =
{
> +                               otx_ep_err("Mbox write timeout waiting fo=
r CMD_DONE");
> +                               return -ETIMEDOUT;
> +                       }
> +                       rte_pause();
> +               } while (!(ctl & CN20K_MBOX_WR_CMD_DONE));
> +
> +               if (ctl & CN20K_MBOX_WR_CMD_ERR) {
> +                       otx_ep_err("Mbox write error at offset %u", offse=
t + (uint16_t)(i * 8));
> +                       oct_ep_write64(CN20K_MBOX_WR_CMD_ERR,
> +                                      otx_ep->hw_addr + CN20K_SDP_RMT_VF=
X_MBOX_WR_CMD_CTL);
> +                       return -EIO;
> +               }
> +
> +               if (ctl & CN20K_MBOX_WR_DROP) {
> +                       otx_ep_err("Mbox write dropped at offset %u", off=
set + (uint16_t)(i * 8));
> +                       oct_ep_write64(CN20K_MBOX_WR_DROP,
> +                                      otx_ep->hw_addr + CN20K_SDP_RMT_VF=
X_MBOX_WR_CMD_CTL);
> +                       return -EIO;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +otx_ep_cn20k_mbox_read(struct otx_ep_device *otx_ep, uint16_t offset, vo=
id *buf, size_t len)
> +{
> +       size_t i, num_words =3D (len + 7) / 8;
> +       uint64_t *data =3D (uint64_t *)buf;
> +       uint64_t ctl;
> +       int ret;
> +
> +       otx_ep_dbg("CN20K: mbox_read called: offset=3D%u, len=3D%zu", off=
set, len);
> +
> +       if (offset & 0x7) {
> +               otx_ep_err("Mailbox offset 0x%x not 8-byte aligned", offs=
et);
> +               return -EINVAL;
> +       }
> +
> +       ret =3D cn20k_mbox_wait_rd_cmd_out(otx_ep, offset);
> +       if (ret)
> +               return ret;
> +
> +       oct_ep_write64(offset, otx_ep->hw_addr + CN20K_SDP_RMT_VFX_MBOX_R=
D_CMD_OFFSET);
> +
> +       for (i =3D 0; i < num_words; i++) {
> +               uint64_t start =3D rte_get_timer_cycles();
> +               uint64_t timeout =3D (MBOX_CMD_TIMEOUT_US * rte_get_timer=
_hz()) / 1000000;
> +
> +               rte_smp_wmb();
> +               if (i =3D=3D 0) {
> +                       /* Dummy write, loads Offset =3D 0 data into CSR.=
 Value doesn't matter,
> +                        * it gets ignored by hardware.
> +                        */
> +                       oct_ep_write64(0, otx_ep->hw_addr + CN20K_SDP_RMT=
_VFX_MBOX_RD_CMD_DATA);
> +                       rte_smp_wmb();
> +                       do {
> +                               ctl =3D oct_ep_read64(otx_ep->hw_addr +
> +                                                   CN20K_SDP_RMT_VFX_MBO=
X_RD_CMD_CTL);
> +                               if (rte_get_timer_cycles() - start >=3D t=
imeout) {
> +                                       otx_ep_err("Mbox read timeout wai=
ting for CMD_DONE");
> +                                       return -ETIMEDOUT;
> +                               }
> +                               rte_pause();
> +                       } while (!(ctl & CN20K_MBOX_RD_CMD_DONE));
> +               }
> +
> +               data[i] =3D oct_ep_read64(otx_ep->hw_addr + CN20K_SDP_RMT=
_VFX_MBOX_RD_CMD_DATA);
> +
> +               do {
> +                       ctl =3D oct_ep_read64(otx_ep->hw_addr + CN20K_SDP=
_RMT_VFX_MBOX_RD_CMD_CTL);
> +                       if (rte_get_timer_cycles() - start >=3D timeout) =
{
> +                               otx_ep_err("Mbox read timeout waiting for=
 CMD_DONE");
> +                               return -ETIMEDOUT;
> +                       }
> +                       rte_pause();
> +               } while (!(ctl & CN20K_MBOX_RD_CMD_DONE));
> +
> +               if (ctl & CN20K_MBOX_RD_CMD_ERR) {
> +                       otx_ep_err("Mbox read error at offset %u", offset=
 + (uint16_t)(i * 8));
> +                       oct_ep_write64(CN20K_MBOX_RD_CMD_ERR,
> +                                      otx_ep->hw_addr + CN20K_SDP_RMT_VF=
X_MBOX_RD_CMD_CTL);
> +                       data[i] =3D 0;
> +                       return -EIO;
> +               }
> +       }
> +
> +       ret =3D cn20k_mbox_wait_rd_cmd_out(otx_ep, offset);
> +
> +       return 0;
> +}
> +
> +static int
> +otx_ep_cn20k_mbox_msg_send(struct otx_ep_cn20k_mbox_priv *mbox)
> +{
> +       struct otx_ep_device *otx_ep =3D mbox->otx_ep;
> +       struct cn20k_mbox_hdr tx_hdr, rx_hdr_zero =3D {0};
> +       int ret =3D 0;
> +
> +       tx_hdr.msg_size =3D mbox->msg_size;
> +       tx_hdr.num_msgs =3D mbox->num_msgs;
> +       tx_hdr.sig =3D OCTEP_CN20K_MBOX_REQ_SIG;
> +
> +       rte_smp_wmb();
> +
> +       if (mbox->mbase !=3D mbox->hwbase) {
> +               ret =3D otx_ep_cn20k_mbox_write(otx_ep, (uint16_t)mbox->t=
x_start, &tx_hdr,
> +                                             sizeof(tx_hdr));
> +               if (ret) {
> +                       otx_ep_err("Failed to write TX header");
> +                       goto err;
> +               }
> +
> +               rte_smp_wmb();
> +               ret =3D otx_ep_cn20k_mbox_write(otx_ep,
> +                                             (uint16_t)(mbox->tx_start +=
 CN20K_MBOX_MSGS_OFFSET),
> +                                             (uint8_t *)mbox->mbase + mb=
ox->tx_start +
> +                                             CN20K_MBOX_MSGS_OFFSET, mbo=
x->msg_size);
> +               if (ret) {
> +                       otx_ep_err("Failed to write message payload");
> +                       goto err;
> +               }
> +
> +               rte_smp_wmb();
> +               ret =3D otx_ep_cn20k_mbox_write(otx_ep, (uint16_t)mbox->r=
x_start, &rx_hdr_zero,
> +                                             sizeof(rx_hdr_zero));
> +               if (ret) {
> +                       otx_ep_err("Failed to clear RX header");
> +                       goto err;
> +               }
> +       }
> +
> +       rte_smp_wmb();
> +       oct_ep_write64(MBOX_DOWN_MSG, otx_ep->hw_addr + mbox->trigger);
> +
> +err:
> +       return ret;
> +}
> +
> +static int
> +otx_ep_cn20k_mbox_check_rsp_msgs(struct otx_ep_cn20k_mbox_priv *mbox)
> +{
> +       struct otx_ep_device *otx_ep =3D mbox->otx_ep;
> +       struct cn20k_mbox_hdr rx_hdr;
> +       int ret;
> +
> +       ret =3D otx_ep_cn20k_mbox_read(otx_ep, (uint16_t)mbox->rx_start, =
&rx_hdr, sizeof(rx_hdr));
> +       if (ret) {
> +               otx_ep_err("Failed to read RX header");
> +               return ret;
> +       }
> +
> +       if (rx_hdr.num_msgs =3D=3D 0)
> +               return 0;
> +
> +       if (rx_hdr.msg_size > mbox->rx_size - CN20K_MBOX_MSGS_OFFSET) {
> +               otx_ep_err("RX message size %u exceeds buffer (%u)",
> +                          (uint32_t)rx_hdr.msg_size,
> +                          (uint32_t)(mbox->rx_size - CN20K_MBOX_MSGS_OFF=
SET));
> +               return -EINVAL;
> +       }
> +
> +       if (mbox->mbase !=3D mbox->hwbase) {
> +               ret =3D otx_ep_cn20k_mbox_read(otx_ep,
> +                                            (uint16_t)(mbox->rx_start + =
CN20K_MBOX_MSGS_OFFSET),
> +                                            (uint8_t *)mbox->mbase + mbo=
x->rx_start +
> +                                            CN20K_MBOX_MSGS_OFFSET, rx_h=
dr.msg_size);
> +               if (ret) {
> +                       otx_ep_err("Failed to read response messages");
> +                       return ret;
> +               }
> +       }
> +
> +       mbox->msgs_acked =3D rx_hdr.num_msgs;
> +
> +       return 0;
> +}
> +
> +static int
> +otx_ep_cn20k_mbox_wait_for_rsp(struct otx_ep_cn20k_mbox_priv *mbox)
> +{
> +       uint64_t start =3D rte_get_timer_cycles();
> +       uint64_t timeout =3D (MBOX_RSP_TIMEOUT_MS * rte_get_timer_hz()) /=
 1000;
> +
> +       while (rte_get_timer_cycles() - start < timeout) {
> +               if (mbox->num_msgs =3D=3D mbox->msgs_acked)
> +                       return 0;
> +               rte_delay_us(1000);
> +               otx_ep_cn20k_mbox_check_rsp_msgs(mbox);
> +       }
> +
> +       otx_ep_err("Mbox response timeout");
> +
> +       return -ETIMEDOUT;
> +}
> +
> +static void *
> +otx_ep_cn20k_mbox_alloc_msg(struct otx_ep_cn20k_mbox_priv *mbox, int siz=
e, int size_rsp)
> +{
> +       struct otx_ep_cn20k_mbox_msghdr *msghdr;
> +
> +       if ((uint32_t)(mbox->msg_size + size) > mbox->tx_size - CN20K_MBO=
X_MSGS_OFFSET) {
> +               otx_ep_err("Mailbox message size exceeds limit");
> +               return NULL;
> +       }
> +
> +       msghdr =3D (struct otx_ep_cn20k_mbox_msghdr *)((uint8_t *)mbox->m=
base + mbox->tx_start +
> +                                             CN20K_MBOX_MSGS_OFFSET + mb=
ox->msg_size);
> +
> +       memset(msghdr, 0, size);
> +
> +       msghdr->ver =3D OCTEP_CN20K_MBOX_VERSION;
> +       mbox->msg_size +=3D size;
> +       mbox->rsp_size +=3D size_rsp;
> +       mbox->num_msgs++;
> +       msghdr->next_msgoff =3D mbox->msg_size + CN20K_MBOX_MSGS_OFFSET;
> +
> +       return msghdr;
> +}
> +
> +static struct otx_ep_cn20k_ready_msg_req *
> +otx_ep_cn20k_mbox_alloc_msg_ready(struct otx_ep_device *otx_ep)
> +{
> +       struct otx_ep_cn20k_mbox *cn20k_mbox =3D otx_ep->mbox_info;
> +       struct otx_ep_cn20k_mbox_priv *mbox =3D &cn20k_mbox->mbox;
> +       struct otx_ep_cn20k_ready_msg_req *req;
> +
> +       req =3D otx_ep_cn20k_mbox_alloc_msg(mbox, sizeof(*req),
> +                                         sizeof(struct otx_ep_cn20k_read=
y_msg_rsp));
> +       if (!req)
> +               return NULL;
> +
> +       req->hdr.id =3D OCTEP_CN20K_MBOX_CMD_VF_READY;
> +       req->hdr.sig =3D OCTEP_CN20K_MBOX_REQ_SIG;
> +       req->hdr.pcifunc =3D 0;
> +
> +       return req;
> +}
> +
> +static int
> +otx_ep_cn20k_mbox_setup(struct otx_ep_cn20k_mbox_priv *mbox, int directi=
on)
> +{
> +       switch (direction) {
> +       case MBOX_DIR_HOSTVF_HOSTPF:
> +               mbox->tx_start =3D CN20K_MBOX_DOWN_RX_START;
> +               mbox->tx_size =3D CN20K_MBOX_DOWN_RX_SIZE;
> +               mbox->rx_start =3D CN20K_MBOX_DOWN_TX_START;
> +               mbox->rx_size =3D CN20K_MBOX_DOWN_TX_SIZE;
> +               mbox->trigger =3D CN20K_SDP_RMT_VFX_MBOX_SEND_INT;
> +               break;
> +       case MBOX_DIR_HOSTVF_HOSTPF_UP:
> +               mbox->tx_start =3D CN20K_MBOX_UP_TX_START;
> +               mbox->tx_size =3D CN20K_MBOX_UP_TX_SIZE;
> +               mbox->rx_start =3D CN20K_MBOX_UP_RX_START;
> +               mbox->rx_size =3D CN20K_MBOX_UP_RX_SIZE;
> +               mbox->trigger =3D CN20K_SDP_RMT_VFX_MBOX_SEND_INT;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int
> +otx_ep_cn20k_mbox_bbuf_init(struct otx_ep_cn20k_mbox *mbox_info)
> +{
> +       mbox_info->bbuf_base =3D rte_zmalloc("cn20k_mbox_bbuf", CN20K_VF_=
MBOX_SIZE,
> +                                          RTE_CACHE_LINE_SIZE);
> +       if (!mbox_info->bbuf_base)
> +               return -ENOMEM;
> +
> +       mbox_info->mbox.mbase =3D mbox_info->bbuf_base;
> +       mbox_info->mbox_up.mbase =3D mbox_info->bbuf_base;
> +
> +       return 0;
> +}
> +
> +static int
> +otx_ep_cn20k_setup_mbox(struct otx_ep_device *otx_ep)
> +{
> +       struct otx_ep_cn20k_mbox *mbox_info;
> +       int ret;
> +
> +       if (otx_ep->mbox_info)
> +               return 0;
> +
> +       mbox_info =3D rte_zmalloc("otx_ep_mbox", sizeof(*mbox_info), RTE_=
CACHE_LINE_SIZE);
> +       if (!mbox_info) {
> +               otx_ep_err("MBOX structure allocation failed");
> +               return -ENOMEM;
> +       }
> +
> +       mbox_info->otx_ep =3D otx_ep;
> +       mbox_info->mbox.otx_ep =3D otx_ep;
> +       otx_ep->mbox_info =3D mbox_info;
> +       mbox_info->mbox_up.otx_ep =3D otx_ep;
> +
> +       ret =3D otx_ep_cn20k_mbox_setup(&mbox_info->mbox, MBOX_DIR_HOSTVF=
_HOSTPF);
> +       if (ret) {
> +               otx_ep_err("Failed to setup downward mailbox");
> +               goto free_mbox;
> +       }
> +
> +       ret =3D otx_ep_cn20k_mbox_setup(&mbox_info->mbox_up, MBOX_DIR_HOS=
TVF_HOSTPF_UP);
> +       if (ret) {
> +               otx_ep_err("Failed to setup upward mailbox");
> +               goto free_mbox;
> +       }
> +
> +       ret =3D otx_ep_cn20k_mbox_bbuf_init(mbox_info);
> +       if (ret) {
> +               otx_ep_err("Failed to init bounce buffer");
> +               goto free_mbox;
> +       }
> +
> +       mbox_info->mbox.hwbase =3D NULL;
> +       mbox_info->mbox_up.hwbase =3D NULL;
> +
> +       otx_ep_dbg("CN20K VF mailbox initialized (CMD register based)");
> +
> +       return 0;
> +
> +free_mbox:
> +       rte_free(mbox_info);
> +       otx_ep->mbox_info =3D NULL;
> +       return ret;
> +}
> +
> +static void
> +otx_ep_cn20k_delete_mbox(struct otx_ep_device *otx_ep)
> +{
> +       struct otx_ep_cn20k_mbox *mbox_info =3D otx_ep->mbox_info;
> +
> +       if (!mbox_info)
> +               return;
> +
> +       if (mbox_info->bbuf_base)
> +               rte_free(mbox_info->bbuf_base);
> +
> +       rte_free(mbox_info);
> +       otx_ep->mbox_info =3D NULL;
> +
> +       otx_ep_dbg("CN20K VF mailbox cleaned up");
> +}
> +
> +int
> +otx_ep_cn20k_mbox_send_cmd(struct otx_ep_device *otx_ep, union otx_ep_mb=
ox_word cmd,
> +                          union otx_ep_mbox_word *rsp)
> +{
> +       struct otx_ep_cn20k_mbox *mbox_info =3D otx_ep->mbox_info;
> +       struct otx_ep_cn20k_mbox_priv *mbox;
> +       struct otx_ep_cn20k_mbox_msghdr *msghdr;
> +       union otx_ep_mbox_word *msg_data;
> +       int ret;
> +
> +       if (!mbox_info)
> +               return -EINVAL;
> +
> +       mbox =3D &mbox_info->mbox;
> +
> +       mbox->msg_size =3D 0;
> +       mbox->rsp_size =3D 0;
> +       mbox->num_msgs =3D 0;
> +       mbox->msgs_acked =3D 0;
> +
> +       msghdr =3D otx_ep_cn20k_mbox_alloc_msg(mbox,
> +                                            sizeof(struct otx_ep_cn20k_m=
box_msghdr) + sizeof(cmd),
> +                                            sizeof(struct otx_ep_cn20k_m=
box_msghdr) +
> +                                            sizeof(*rsp));
> +       if (!msghdr)
> +               return -ENOMEM;
> +
> +       msghdr->id =3D cmd.s.opcode;
> +       msghdr->sig =3D OCTEP_CN20K_MBOX_REQ_SIG;
> +       msghdr->ver =3D OCTEP_CN20K_MBOX_VERSION;
> +       msghdr->pcifunc =3D 0;
> +
> +       msg_data =3D (union otx_ep_mbox_word *)(msghdr + 1);
> +       *msg_data =3D cmd;
> +
> +       ret =3D otx_ep_cn20k_mbox_msg_send(mbox);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D otx_ep_cn20k_mbox_wait_for_rsp(mbox);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D otx_ep_cn20k_mbox_check_rsp_msgs(mbox);
> +       if (ret)
> +               return ret;
> +
> +       msghdr =3D (struct otx_ep_cn20k_mbox_msghdr *)((uint8_t *)mbox->m=
base + mbox->rx_start +
> +                                             CN20K_MBOX_MSGS_OFFSET);
> +       msg_data =3D (union otx_ep_mbox_word *)(msghdr + 1);
> +       *rsp =3D *msg_data;
> +
> +       if (msghdr->rc) {
> +               otx_ep_err("Mailbox command failed: rc=3D%d", msghdr->rc)=
;
> +               return msghdr->rc;
> +       }
> +
> +       return 0;
> +}
> +
> +int
> +otx_ep_cn20k_mbox_bulk_read(struct otx_ep_device *otx_ep, enum otx_ep_mb=
ox_opcode opcode,
> +                           uint8_t *data, int32_t max_size, int32_t *siz=
e)
> +{
> +       union otx_ep_mbox_word cmd =3D {0};
> +       union otx_ep_mbox_word rsp;
> +       int data_len, tmp_len, read_cnt, i, ret;
> +
> +       if (!otx_ep->mbox_info || !data || !size || max_size <=3D 0)
> +               return -EINVAL;
> +
> +       rte_spinlock_lock(&otx_ep->mbox_lock);
> +
> +       cmd.s_data.opcode =3D opcode;
> +       cmd.s_data.frag =3D 0;
> +       ret =3D otx_ep_cn20k_mbox_send_cmd(otx_ep, cmd, &rsp);
> +       if (ret) {
> +               otx_ep_err("CN20K mbox bulk read request failed");
> +               goto unlock;
> +       }
> +
> +       memcpy(&data_len, rsp.s_data.data, sizeof(data_len));
> +       tmp_len =3D data_len;
> +       if (data_len <=3D 0 || data_len > max_size) {
> +               otx_ep_err("CN20K mbox bulk read invalid length %d", data=
_len);
> +               ret =3D -EINVAL;
> +               goto unlock;
> +       }
> +
> +       otx_ep->mbox_data_index =3D 0;
> +       cmd.u64 =3D 0;
> +       cmd.s_data.opcode =3D opcode;
> +       cmd.s_data.frag =3D 1;
> +       while (data_len) {
> +               ret =3D otx_ep_cn20k_mbox_send_cmd(otx_ep, cmd, &rsp);
> +               if (ret) {
> +                       otx_ep_err("CN20K mbox bulk read fragment failed"=
);
> +                       otx_ep->mbox_data_index =3D 0;
> +                       memset(otx_ep->mbox_data_buf, 0, MBOX_MAX_DATA_BU=
F_SIZE);
> +                       goto unlock;
> +               }
> +               if (data_len > OTX_EP_MBOX_MAX_DATA_SIZE) {
> +                       data_len -=3D OTX_EP_MBOX_MAX_DATA_SIZE;
> +                       read_cnt =3D OTX_EP_MBOX_MAX_DATA_SIZE;
> +               } else {
> +                       read_cnt =3D data_len;
> +                       data_len =3D 0;
> +               }
> +               if (otx_ep->mbox_data_index + read_cnt > MBOX_MAX_DATA_BU=
F_SIZE) {
> +                       otx_ep_err("CN20K mbox bulk read buffer overflow"=
);
> +                       ret =3D -EINVAL;
> +                       goto unlock;
> +               }
> +               for (i =3D 0; i < read_cnt; i++) {
> +                       otx_ep->mbox_data_buf[otx_ep->mbox_data_index] =
=3D
> +                               rsp.s_data.data[i];
> +                       otx_ep->mbox_data_index++;
> +               }
> +               cmd.u64 =3D 0;
> +               cmd.s_data.opcode =3D opcode;
> +               cmd.s_data.frag =3D 1;
> +       }
> +
> +       memcpy(data, otx_ep->mbox_data_buf, tmp_len);
> +       *size =3D tmp_len;
> +       otx_ep->mbox_data_index =3D 0;
> +       memset(otx_ep->mbox_data_buf, 0, MBOX_MAX_DATA_BUF_SIZE);
> +
> +unlock:
> +       rte_spinlock_unlock(&otx_ep->mbox_lock);
> +       return ret;
> +}
> +
> +static void
> +otx_ep_cn20k_mbox_intr_handler(void *param)
> +{
> +       struct rte_eth_dev *eth_dev =3D (struct rte_eth_dev *)param;
> +       struct otx_ep_device *otx_ep =3D (struct otx_ep_device *)eth_dev-=
>data->dev_private;
> +       uint64_t intr_status;
> +
> +       /* Read and clear interrupt */
> +       intr_status =3D oct_ep_read64(otx_ep->hw_addr + CN20K_SDP_RMT_VFX=
_MBOX_RINT);
> +       if (intr_status & CN20K_MBOX_INTR) {
> +               /* Clear interrupt (W1C) */
> +               oct_ep_write64(CN20K_MBOX_INTR, otx_ep->hw_addr + CN20K_S=
DP_RMT_VFX_MBOX_RINT);
> +       }
> +}
> +
> +int
> +otx_ep_cn20k_mbox_init(struct rte_eth_dev *eth_dev)
> +{
> +       struct rte_pci_device *pdev =3D RTE_CLASS_TO_BUS_DEVICE(eth_dev, =
*pdev);
> +       struct otx_ep_device *otx_ep =3D eth_dev->data->dev_private;
> +       int rc;
> +
> +       rc =3D otx_ep_cn20k_setup_mbox(otx_ep);
> +       if (rc) {
> +               otx_ep_err("Failed to setup CN20K PF-VF mailbox");
> +               return rc;
> +       }
> +
> +       rte_intr_callback_register(pdev->intr_handle, otx_ep_cn20k_mbox_i=
ntr_handler,
> +                                  (void *)eth_dev);
> +
> +       rc =3D rte_intr_enable(pdev->intr_handle);
> +
> +       if (!(rc =3D=3D -1 || rc =3D=3D 0)) {
> +               otx_ep_err("rte_intr_enable failed");
> +               return -1;
> +       }
> +
> +       oct_ep_write64(CN20K_MBOX_INTR, otx_ep->hw_addr + CN20K_SDP_RMT_V=
FX_MBOX_RINT_ENA_W1S);
> +
> +       otx_ep_dbg("CN20K mailbox initialized successfully");
> +
> +       return 0;
> +}
> +
> +void
> +otx_ep_cn20k_mbox_uninit(struct rte_eth_dev *eth_dev)
> +{
> +       struct rte_pci_device *pdev =3D RTE_CLASS_TO_BUS_DEVICE(eth_dev, =
*pdev);
> +       struct otx_ep_device *otx_ep =3D eth_dev->data->dev_private;
> +
> +       oct_ep_write64(CN20K_MBOX_INTR, otx_ep->hw_addr + CN20K_SDP_RMT_V=
FX_MBOX_RINT_ENA_W1C);
> +
> +       rte_intr_disable(pdev->intr_handle);
> +       rte_intr_callback_unregister(pdev->intr_handle, otx_ep_cn20k_mbox=
_intr_handler,
> +                                    (void *)eth_dev);
> +
> +       otx_ep_cn20k_delete_mbox(otx_ep);
> +}
> +
> +int
> +otx_ep_cn20k_mbox_send_ready(struct otx_ep_device *otx_ep)
> +{
> +       struct otx_ep_cn20k_mbox *cn20k_mbox;
> +       struct otx_ep_cn20k_mbox_priv *mbox;
> +       struct otx_ep_cn20k_ready_msg_req *req;
> +       struct otx_ep_cn20k_ready_msg_rsp *rsp;
> +       int ret;
> +
> +       if (!otx_ep->mbox_info) {
> +               otx_ep_err("CN20K mailbox not initialized");
> +               return -EINVAL;
> +       }
> +
> +       cn20k_mbox =3D otx_ep->mbox_info;
> +       mbox =3D &cn20k_mbox->mbox;
> +
> +       mbox->msg_size =3D 0;
> +       mbox->num_msgs =3D 0;
> +       mbox->msgs_acked =3D 0;
> +
> +       req =3D otx_ep_cn20k_mbox_alloc_msg_ready(otx_ep);
> +       if (!req) {
> +               otx_ep_err("CN20K: Failed to allocate VF_READY message");
> +               return -ENOMEM;
> +       }
> +
> +       otx_ep_dbg("CN20K: Allocated VF_READY request (id=3D0x%x, sig=3D0=
x%x, ver=3D0x%x)", req->hdr.id,
> +                  req->hdr.sig, req->hdr.ver);
> +
> +       ret =3D otx_ep_cn20k_mbox_msg_send(mbox);
> +       if (ret) {
> +               otx_ep_err("CN20K: Failed to send VF_READY request: %d", =
ret);
> +               return ret;
> +       }
> +
> +       otx_ep_dbg("CN20K: VF_READY request sent to PF");
> +
> +       ret =3D otx_ep_cn20k_mbox_wait_for_rsp(mbox);
> +       if (ret) {
> +               otx_ep_err("CN20K: Timeout waiting for VF_READY response:=
 %d", ret);
> +               return ret;
> +       }
> +
> +       ret =3D otx_ep_cn20k_mbox_check_rsp_msgs(mbox);
> +       if (ret) {
> +               otx_ep_err("CN20K: Failed to read VF_READY response: %d",=
 ret);
> +               return ret;
> +       }
> +
> +       rsp =3D (struct otx_ep_cn20k_ready_msg_rsp *)((uint8_t *)mbox->mb=
ase +
> +                                                   mbox->rx_start + CN20=
K_MBOX_MSGS_OFFSET);
> +
> +       if (rsp->hdr.sig !=3D OCTEP_CN20K_MBOX_RSP_SIG) {
> +               otx_ep_err("CN20K: Invalid VF_READY response signature: 0=
x%x (expected 0x%x)",
> +                          rsp->hdr.sig, OCTEP_CN20K_MBOX_RSP_SIG);
> +               return -EINVAL;
> +       }
> +
> +       if (rsp->hdr.rc !=3D 0) {
> +               otx_ep_err("CN20K: VF_READY rejected by PF: rc=3D%d", rsp=
->hdr.rc);
> +               return rsp->hdr.rc;
> +       }
> +
> +       otx_ep_dbg("CN20K: VF_READY acknowledged by PF (sig=3D0x%x, rc=3D=
%d)", rsp->hdr.sig,
> +                  rsp->hdr.rc);
> +
> +       return 0;
> +}
> +
> +int
> +otx_ep_cn20k_mbox_alloc_sdp_rings(struct otx_ep_device *otx_ep, uint16_t=
 nr_rings)
> +{
> +       struct otx_ep_cn20k_mbox *cn20k_mbox =3D otx_ep->mbox_info;
> +       struct otx_ep_cn20k_mbox_priv *mbox;
> +       struct sdp_rings_alloc_req *req;
> +       struct sdp_rings_alloc_rsp *rsp;
> +       struct otx_ep_cn20k_mbox_msghdr *msghdr;
> +       int ret;
> +
> +       if (!cn20k_mbox) {
> +               otx_ep_err("CN20K mailbox not initialized");
> +               return -EINVAL;
> +       }
> +
> +       if (nr_rings =3D=3D 0) {
> +               otx_ep_err("Invalid nr_rings=3D0");
> +               return -EINVAL;
> +       }
> +
> +       mbox =3D &cn20k_mbox->mbox;
> +
> +       mbox->msg_size =3D 0;
> +       mbox->rsp_size =3D 0;
> +       mbox->num_msgs =3D 0;
> +       mbox->msgs_acked =3D 0;
> +
> +       req =3D otx_ep_cn20k_mbox_alloc_msg(mbox, sizeof(*req), sizeof(st=
ruct sdp_rings_alloc_rsp));
> +       if (!req) {
> +               otx_ep_err("Failed to allocate SDP_RING_ALLOC message");
> +               return -ENOMEM;
> +       }
> +
> +       req->hdr.id =3D MBOX_MSG_SDP_RING_ALLOC;
> +       req->hdr.sig =3D OCTEP_CN20K_MBOX_REQ_SIG;
> +       req->hdr.pcifunc =3D 0;
> +       req->nr_rings =3D nr_rings;
> +       memset(req->rsvd, 0, sizeof(req->rsvd));
> +
> +       otx_ep_dbg("VF requesting %u SDP rings from PF", nr_rings);
> +
> +       ret =3D otx_ep_cn20k_mbox_msg_send(mbox);
> +       if (ret) {
> +               otx_ep_err("Failed to send SDP_RING_ALLOC message: %d", r=
et);
> +               return ret;
> +       }
> +
> +       ret =3D otx_ep_cn20k_mbox_wait_for_rsp(mbox);
> +       if (ret) {
> +               otx_ep_err("Failed to get response: %d", ret);
> +               return ret;
> +       }
> +
> +       msghdr =3D (struct otx_ep_cn20k_mbox_msghdr *)((uint8_t *)mbox->m=
base +
> +                                                    mbox->rx_start + CN2=
0K_MBOX_MSGS_OFFSET);
> +       if (msghdr->rc) {
> +               otx_ep_err("PF returned error for SDP_RING_ALLOC: %d", ms=
ghdr->rc);
> +               return msghdr->rc;
> +       }
> +
> +       rsp =3D (struct sdp_rings_alloc_rsp *)msghdr;
> +
> +       if (rsp->count =3D=3D 0)
> +               return -EIO;
> +
> +       return rsp->count;
> +}
> +
> +int
> +otx_ep_cn20k_mbox_free_sdp_rings(struct otx_ep_device *otx_ep, uint16_t =
ring, uint8_t all)
> +{
> +       struct otx_ep_cn20k_mbox *mbox_info =3D otx_ep->mbox_info;
> +       struct otx_ep_cn20k_mbox_msghdr *msghdr;
> +       struct otx_ep_cn20k_mbox_priv *mbox;
> +       struct sdp_rings_free_req *req;
> +       int ret;
> +
> +       if (!mbox_info) {
> +               otx_ep_err("CN20K mailbox not initialized");
> +               return -EINVAL;
> +       }
> +
> +       mbox =3D &mbox_info->mbox;
> +       mbox->msg_size =3D 0;
> +       mbox->rsp_size =3D 0;
> +       mbox->num_msgs =3D 0;
> +       mbox->msgs_acked =3D 0;
> +
> +       req =3D otx_ep_cn20k_mbox_alloc_msg(mbox, sizeof(*req), sizeof(st=
ruct otx_ep_cn20k_msg_rsp));
> +       if (!req) {
> +               otx_ep_err("Failed to allocate SDP_RING_FREE message");
> +               return -ENOMEM;
> +       }
> +
> +       req->hdr.id =3D MBOX_MSG_SDP_RING_FREE;
> +       req->hdr.sig =3D OCTEP_CN20K_MBOX_REQ_SIG;
> +       req->hdr.pcifunc =3D 0;
> +       req->ring =3D ring;
> +       req->all =3D all;
> +
> +       if (all)
> +               otx_ep_dbg("VF requesting to free all SDP rings");
> +       else
> +               otx_ep_dbg("VF requesting to free SDP ring %u", ring);
> +
> +       ret =3D otx_ep_cn20k_mbox_msg_send(mbox);
> +       if (ret) {
> +               otx_ep_err("Failed to send SDP_RING_FREE message: %d", re=
t);
> +               return ret;
> +       }
> +
> +       ret =3D otx_ep_cn20k_mbox_wait_for_rsp(mbox);
> +       if (ret) {
> +               otx_ep_err("Failed to get rsp for SDP_RING_FREE message: =
%d", ret);
> +               return ret;
> +       }
> +
> +       msghdr =3D (struct otx_ep_cn20k_mbox_msghdr *)((uint8_t *)mbox->m=
base +
> +                                                   mbox->rx_start + CN20=
K_MBOX_MSGS_OFFSET);
> +       if (msghdr->rc) {
> +               otx_ep_err("PF returned error for SDP_RING_FREE: %d", msg=
hdr->rc);
> +               return msghdr->rc;
> +       }
> +
> +       return 0;
> +}
> diff --git a/drivers/net/octeon_ep/cn20k_ep_mbox.h b/drivers/net/octeon_e=
p/cn20k_ep_mbox.h
> new file mode 100644
> index 0000000000..0d03978b2c
> --- /dev/null
> +++ b/drivers/net/octeon_ep/cn20k_ep_mbox.h
> @@ -0,0 +1,133 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2026 Marvell.
> + */
> +
> +#ifndef _CN20K_EP_MBOX_H_
> +#define _CN20K_EP_MBOX_H_
> +
> +#include <stdint.h>
> +
> +#include "otx_ep_mbox.h"
> +
> +struct otx_ep_device;
> +
> +/* CN20K-specific mailbox opcodes */
> +enum otx_ep_cn20k_mbox_opcode {
> +       OCTEP_CN20K_MBOX_CMD_VF_READY =3D 0x100,  /* CN20K VF readiness n=
otification */
> +};
> +
> +/* SDP mbox IDs */
> +#define MBOX_MSG_SDP_RING_ALLOC        0x1002
> +#define MBOX_MSG_SDP_RING_FREE 0x1003
> +
> +/* Mailbox message header */
> +struct otx_ep_cn20k_mbox_msghdr {
> +       uint16_t pcifunc;       /* VF/PF identifier */
> +       uint16_t id;            /* Message ID (opcode) */
> +#define OCTEP_CN20K_MBOX_REQ_SIG (0xdead)
> +#define OCTEP_CN20K_MBOX_RSP_SIG (0xbeef)
> +       uint16_t sig;           /* Signature for verification */
> +#define OCTEP_CN20K_MBOX_VERSION (0x000b)
> +       uint16_t ver;           /* Mailbox version */
> +       uint16_t next_msgoff;   /* Offset to next message */
> +       int rc;                 /* Return code */
> +};
> +
> +/* Generic request msg used for those mbox messages which
> + * don't send any data in the request.
> + */
> +struct otx_ep_cn20k_msg_req {
> +       struct otx_ep_cn20k_mbox_msghdr hdr;
> +};
> +
> +/* Generic response msg used as ack or response for those mbox
> + * messages which don't have a specific rsp msg format.
> + */
> +struct otx_ep_cn20k_msg_rsp {
> +       struct otx_ep_cn20k_mbox_msghdr hdr;
> +};
> +
> +/* VF_READY request message (VF =E2=86=92 PF) */
> +struct otx_ep_cn20k_ready_msg_req {
> +       struct otx_ep_cn20k_mbox_msghdr hdr;
> +};
> +
> +/* VF_READY response message (PF =E2=86=92 VF) */
> +struct otx_ep_cn20k_ready_msg_rsp {
> +       struct otx_ep_cn20k_mbox_msghdr hdr;
> +};
> +
> +#define MBOX_MSG_ALIGN 16
> +#define MBOX_DOWN_MSG  1
> +#define MBOX_UP_MSG    2
> +
> +/* Mailbox message header */
> +struct cn20k_mbox_hdr {
> +       uint64_t msg_size;
> +       uint16_t num_msgs;
> +       uint16_t opt_msg;
> +       uint16_t sig;
> +};
> +
> +enum cn20k_mbox_dir {
> +       MBOX_DIR_HOSTVF_HOSTPF =3D 0,
> +       MBOX_DIR_HOSTVF_HOSTPF_UP =3D 1,
> +};
> +
> +struct otx_ep_cn20k_mbox_priv {
> +       struct otx_ep_device *otx_ep;
> +       void *hwbase;
> +       void *mbase;
> +       uint64_t trigger;
> +       uint64_t rx_start;
> +       uint64_t tx_start;
> +       uint16_t rx_size;
> +       uint16_t tx_size;
> +       uint16_t msg_size;
> +       uint16_t rsp_size;
> +       uint16_t num_msgs;
> +       uint16_t msgs_acked;
> +};
> +
> +/* Main mailbox container for VF */
> +struct otx_ep_cn20k_mbox {
> +       struct otx_ep_cn20k_mbox_priv mbox;
> +       struct otx_ep_cn20k_mbox_priv mbox_up;
> +       struct otx_ep_device *otx_ep;
> +       void *bbuf_base;
> +       int num_msgs;
> +       int up_num_msgs;
> +};
> +
> +/* SDP Ring allocation/free structures (same as octeon_ep) */
> +struct sdp_rings_alloc_req {
> +       struct otx_ep_cn20k_mbox_msghdr hdr;
> +       uint16_t nr_rings;
> +       uint16_t rsvd[16];   /* Reserved */
> +};
> +
> +struct sdp_rings_alloc_rsp {
> +       struct otx_ep_cn20k_mbox_msghdr hdr;
> +       uint16_t count; /* Number of rings allocated */
> +       uint16_t rsvd[16];   /* Reserved */
> +};
> +
> +struct sdp_rings_free_req {
> +       struct otx_ep_cn20k_mbox_msghdr hdr;
> +       uint16_t ring;
> +       uint8_t all;
> +};
> +
> +int otx_ep_cn20k_mbox_init(struct rte_eth_dev *eth_dev);
> +void otx_ep_cn20k_mbox_uninit(struct rte_eth_dev *eth_dev);
> +
> +int otx_ep_cn20k_mbox_send_cmd(struct otx_ep_device *otx_ep, union otx_e=
p_mbox_word cmd,
> +                              union otx_ep_mbox_word *rsp);
> +int otx_ep_cn20k_mbox_bulk_read(struct otx_ep_device *otx_ep, enum otx_e=
p_mbox_opcode opcode,
> +                               uint8_t *data, int32_t max_size, int32_t =
*size);
> +
> +int otx_ep_cn20k_mbox_send_ready(struct otx_ep_device *otx_ep);
> +int otx_ep_cn20k_mbox_alloc_sdp_rings(struct otx_ep_device *otx_ep, uint=
16_t nr_rings);
> +int otx_ep_cn20k_mbox_free_sdp_rings(struct otx_ep_device *otx_ep, uint1=
6_t ring, uint8_t all);
> +
> +#endif /* _CN20K_EP_MBOX_H_ */
> diff --git a/drivers/net/octeon_ep/cn20k_ep_vf.c b/drivers/net/octeon_ep/=
cn20k_ep_vf.c
> new file mode 100644
> index 0000000000..5c162de6fc
> --- /dev/null
> +++ b/drivers/net/octeon_ep/cn20k_ep_vf.c
> @@ -0,0 +1,425 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2026 Marvell.
> + */
> +
> +#include <inttypes.h>
> +#include <errno.h>
> +
> +#include <rte_common.h>
> +#include <rte_cycles.h>
> +#include <rte_memzone.h>
> +#include "otx_ep_common.h"
> +#include "cnxk_ep_vf.h"
> +#include "cn20k_ep_vf.h"
> +
> +static void
> +cn20k_ep_vf_setup_global_iq_reg(struct otx_ep_device *otx_ep, int q_no)
> +{
> +       volatile uint64_t reg_val =3D 0ull;
> +
> +       /* Select ES, RO, NS, RDSIZE,DPTR Format#0 for IQs
> +        * IS_64B is by default enabled.
> +        */
> +       reg_val =3D oct_ep_read64(otx_ep->hw_addr + CN20K_EP_R_IN_CONTROL=
(q_no));
> +
> +       reg_val |=3D CNXK_EP_R_IN_CTL_RDSIZE;
> +       reg_val |=3D CNXK_EP_R_IN_CTL_IS_64B;
> +       reg_val |=3D CNXK_EP_R_IN_CTL_ESR;
> +
> +       oct_ep_write64(reg_val, otx_ep->hw_addr + CN20K_EP_R_IN_CONTROL(q=
_no));
> +}
> +
> +static void
> +cn20k_ep_vf_setup_global_oq_reg(struct otx_ep_device *otx_ep, int q_no)
> +{
> +       volatile uint64_t reg_val =3D 0ull;
> +
> +       reg_val =3D oct_ep_read64(otx_ep->hw_addr + CN20K_EP_R_OUT_CONTRO=
L(q_no));
> +
> +       reg_val &=3D ~(CNXK_EP_R_OUT_CTL_IMODE);
> +       reg_val &=3D ~(CNXK_EP_R_OUT_CTL_ROR_P);
> +       reg_val &=3D ~(CNXK_EP_R_OUT_CTL_NSR_P);
> +       reg_val &=3D ~(CNXK_EP_R_OUT_CTL_ROR_I);
> +       reg_val &=3D ~(CNXK_EP_R_OUT_CTL_NSR_I);
> +       reg_val &=3D ~(CNXK_EP_R_OUT_CTL_ROR_D);
> +       reg_val &=3D ~(CNXK_EP_R_OUT_CTL_NSR_D);
> +       reg_val &=3D ~(CNXK_EP_R_OUT_CTL_ES_I | CNXK_EP_R_OUT_CTL_ES_D);
> +
> +       /* INFO/DATA ptr swap is required  */
> +       reg_val |=3D (CNXK_EP_R_OUT_CTL_ES_P);
> +       oct_ep_write64(reg_val, otx_ep->hw_addr + CN20K_EP_R_OUT_CONTROL(=
q_no));
> +}
> +
> +static int
> +cn20k_ep_vf_setup_global_input_regs(struct otx_ep_device *otx_ep)
> +{
> +       uint64_t q_no =3D 0ull;
> +
> +       for (q_no =3D 0; q_no < (otx_ep->sriov_info.rings_per_vf); q_no++=
)
> +               cn20k_ep_vf_setup_global_iq_reg(otx_ep, q_no);
> +       return 0;
> +}
> +
> +static int
> +cn20k_ep_vf_setup_global_output_regs(struct otx_ep_device *otx_ep)
> +{
> +       uint32_t q_no;
> +
> +       for (q_no =3D 0; q_no < (otx_ep->sriov_info.rings_per_vf); q_no++=
)
> +               cn20k_ep_vf_setup_global_oq_reg(otx_ep, q_no);
> +       return 0;
> +}
> +
> +static int
> +cn20k_ep_vf_setup_device_regs(struct otx_ep_device *otx_ep)
> +{
> +       int ret;
> +
> +       ret =3D cn20k_ep_vf_setup_global_input_regs(otx_ep);
> +       if (ret)
> +               return ret;
> +       ret =3D cn20k_ep_vf_setup_global_output_regs(otx_ep);
> +       return ret;
> +}
> +
> +static int
> +cn20k_ep_vf_setup_iq_regs(struct otx_ep_device *otx_ep, uint32_t iq_no)
> +{
> +       struct otx_ep_instr_queue *iq =3D otx_ep->instr_queue[iq_no];
> +       int loop =3D OTX_EP_BUSY_LOOP_COUNT;
> +       volatile uint64_t reg_val =3D 0ull;
> +       uint64_t ism_addr;
> +
> +       reg_val =3D oct_ep_read64(otx_ep->hw_addr + CN20K_EP_R_IN_CONTROL=
(iq_no));
> +
> +       /* Wait till IDLE to set to 1, not supposed to configure BADDR
> +        * as long as IDLE is 0
> +        */
> +       if (!(reg_val & CNXK_EP_R_IN_CTL_IDLE)) {
> +               do {
> +                       reg_val =3D oct_ep_read64(otx_ep->hw_addr + CN20K=
_EP_R_IN_CONTROL(iq_no));
> +                       rte_delay_ms(1);
> +               } while ((!(reg_val & CNXK_EP_R_IN_CTL_IDLE)) && loop--);
> +       }
> +
> +       if (loop < 0) {
> +               otx_ep_err("IDLE bit is not set");
> +               return -EIO;
> +       }
> +
> +       /* Configure input queue instruction size. */
> +       if (otx_ep->conf->iq.instr_type =3D=3D OTX_EP_32BYTE_INSTR)
> +               reg_val &=3D ~(CNXK_EP_R_IN_CTL_IS_64B);
> +       else
> +               reg_val |=3D CNXK_EP_R_IN_CTL_IS_64B;
> +       oct_ep_write64(reg_val, otx_ep->hw_addr + CN20K_EP_R_IN_CONTROL(i=
q_no));
> +       iq->desc_size =3D otx_ep->conf->iq.instr_type;
> +
> +       /* CN20X supports 16B instruction instead of 32B instruction */
> +       if (otx_ep->chip_gen =3D=3D OTX_EP_CN20XX && iq->desc_size =3D=3D=
 OTX_EP_32BYTE_INSTR)
> +               iq->desc_size =3D OTX_EP_16BYTE_INSTR;
> +
> +       /* Write the start of the input queue's ring and its size  */
> +       oct_ep_write64(iq->base_addr_dma, otx_ep->hw_addr + CN20K_EP_R_IN=
_INSTR_BADDR(iq_no));
> +       oct_ep_write64(iq->nb_desc, otx_ep->hw_addr + CN20K_EP_R_IN_INSTR=
_RSIZE(iq_no));
> +
> +       /* Remember the doorbell & instruction count register addr
> +        * for this queue
> +        */
> +       iq->doorbell_reg =3D (uint8_t *)otx_ep->hw_addr + CN20K_EP_R_IN_I=
NSTR_DBELL(iq_no);
> +       iq->inst_cnt_reg =3D (uint8_t *)otx_ep->hw_addr + CN20K_EP_R_IN_C=
NTS(iq_no);
> +
> +       otx_ep_dbg("InstQ[%d]:dbell reg @ 0x%p instcnt_reg @ 0x%p",
> +                  iq_no, iq->doorbell_reg, iq->inst_cnt_reg);
> +       loop =3D OTX_EP_BUSY_LOOP_COUNT;
> +       do {
> +               reg_val =3D rte_read32(iq->inst_cnt_reg);
> +               rte_write32(reg_val, iq->inst_cnt_reg);
> +               rte_delay_ms(1);
> +       } while (reg_val !=3D 0 && loop--);
> +
> +       if (loop < 0) {
> +               otx_ep_err("INST CNT REGISTER is not zero");
> +               return -EIO;
> +       }
> +
> +       /* Clear the IQ doorbell  */
> +       loop =3D OTX_EP_BUSY_LOOP_COUNT;
> +       while ((rte_read64(iq->doorbell_reg) !=3D 0ull) && loop--) {
> +               rte_write32(OTX_EP_CLEAR_INSTR_DBELL, iq->doorbell_reg);
> +               rte_delay_ms(1);
> +       }
> +
> +       if (loop < 0) {
> +               otx_ep_err("INSTR DBELL is not zero");
> +               return -EIO;
> +       }
> +
> +       /* IN INTR_THRESHOLD is set to max(FFFFFFFF) which disable the IN=
 INTR
> +        * to raise
> +        */
> +       oct_ep_write64(OTX_EP_CLEAR_SDP_IN_INT_LVLS,
> +                      otx_ep->hw_addr + CN20K_EP_R_IN_INT_LEVELS(iq_no))=
;
> +       /* Set up IQ ISM registers and structures */
> +       ism_addr =3D (otx_ep->ism_buffer_mz->iova | CNXK_EP_ISM_EN
> +                   | CNXK_EP_ISM_MSIX_DIS)
> +                   + CNXK_EP_IQ_ISM_OFFSET(iq_no);
> +       rte_write64(ism_addr, (uint8_t *)otx_ep->hw_addr +
> +                   CN20K_EP_R_IN_CNTS_ISM(iq_no));
> +       iq->inst_cnt_ism =3D
> +               (uint32_t __rte_atomic *)((uint8_t *)otx_ep->ism_buffer_m=
z->addr
> +                            + CNXK_EP_IQ_ISM_OFFSET(iq_no));
> +       otx_ep_dbg("SDP_R[%d] INST Q ISM virt: %p, dma: 0x%" PRIX64, iq_n=
o,
> +                  (void *)(uintptr_t)iq->inst_cnt_ism, ism_addr);
> +       *iq->inst_cnt_ism =3D 0;
> +       iq->inst_cnt_prev =3D 0;
> +       iq->partial_ih =3D ((uint64_t)otx_ep->pkind) << 36;
> +
> +       return 0;
> +}
> +
> +static int
> +cn20k_ep_vf_setup_oq_regs(struct otx_ep_device *otx_ep, uint32_t oq_no)
> +{
> +       volatile uint64_t reg_val =3D 0ull;
> +       uint64_t oq_ctl =3D 0ull;
> +       int loop =3D OTX_EP_BUSY_LOOP_COUNT;
> +       struct otx_ep_droq *droq =3D otx_ep->droq[oq_no];
> +       uint64_t ism_addr;
> +
> +       /* Wait on IDLE to set to 1, supposed to configure BADDR
> +        * as long as IDLE is 0
> +        */
> +       reg_val =3D oct_ep_read64(otx_ep->hw_addr + CN20K_EP_R_OUT_CONTRO=
L(oq_no));
> +
> +       while ((!(reg_val & CNXK_EP_R_OUT_CTL_IDLE)) && loop--) {
> +               reg_val =3D oct_ep_read64(otx_ep->hw_addr + CN20K_EP_R_OU=
T_CONTROL(oq_no));
> +               rte_delay_ms(1);
> +       }
> +
> +       if (loop < 0) {
> +               otx_ep_err("OUT CNT REGISTER value is zero");
> +               return -EIO;
> +       }
> +
> +       oct_ep_write64(droq->desc_ring_dma, otx_ep->hw_addr + CN20K_EP_R_=
OUT_SLIST_BADDR(oq_no));
> +       oct_ep_write64(droq->nb_desc, otx_ep->hw_addr + CN20K_EP_R_OUT_SL=
IST_RSIZE(oq_no));
> +
> +       oq_ctl =3D oct_ep_read64(otx_ep->hw_addr + CN20K_EP_R_OUT_CONTROL=
(oq_no));
> +
> +       /* Clear the ISIZE and BSIZE (22-0) */
> +       oq_ctl &=3D ~(OTX_EP_CLEAR_ISIZE_BSIZE);
> +
> +       /* Populate the BSIZE (15-0) */
> +       oq_ctl |=3D (droq->buffer_size & OTX_EP_DROQ_BUFSZ_MASK);
> +
> +       oct_ep_write64(oq_ctl, otx_ep->hw_addr + CN20K_EP_R_OUT_CONTROL(o=
q_no));
> +
> +       /* Mapped address of the pkt_sent and pkts_credit regs */
> +       droq->pkts_sent_reg =3D (uint8_t *)otx_ep->hw_addr + CN20K_EP_R_O=
UT_CNTS(oq_no);
> +       droq->pkts_credit_reg =3D (uint8_t *)otx_ep->hw_addr + CN20K_EP_R=
_OUT_SLIST_DBELL(oq_no);
> +
> +       rte_write64(OTX_EP_CLEAR_OUT_INT_LVLS, otx_ep->hw_addr + CN20K_EP=
_R_OUT_INT_LEVELS(oq_no));
> +
> +       /* Clear PKT_CNT register */
> +       rte_write64(OTX_EP_CLEAR_SDP_OUT_PKT_CNT, (uint8_t *)otx_ep->hw_a=
ddr +
> +                   CN20K_EP_R_OUT_PKT_CNT(oq_no));
> +
> +       /* Clear the OQ doorbell  */
> +       rte_write32(OTX_EP_CLEAR_SLIST_DBELL, droq->pkts_credit_reg);
> +       loop =3D OTX_EP_BUSY_LOOP_COUNT;
> +       while ((rte_read32(droq->pkts_credit_reg) !=3D 0ull) && loop--) {
> +               rte_write32(OTX_EP_CLEAR_SLIST_DBELL, droq->pkts_credit_r=
eg);
> +               rte_delay_ms(1);
> +       }
> +
> +       if (loop < 0) {
> +               otx_ep_err("Packets credit register value is not cleared"=
);
> +               return -EIO;
> +       }
> +
> +       otx_ep_dbg("SDP_R[%d]_credit:%x", oq_no, rte_read32(droq->pkts_cr=
edit_reg));
> +
> +       /* Clear the OQ_OUT_CNTS doorbell  */
> +       reg_val =3D rte_read32(droq->pkts_sent_reg);
> +       rte_write32((uint32_t)reg_val, droq->pkts_sent_reg);
> +
> +       otx_ep_dbg("SDP_R[%d]_sent: %x", oq_no, rte_read32(droq->pkts_sen=
t_reg));
> +       /* Set up ISM registers and structures */
> +       ism_addr =3D (otx_ep->ism_buffer_mz->iova | CNXK_EP_ISM_EN
> +                   | CNXK_EP_ISM_MSIX_DIS)
> +                   + CNXK_EP_OQ_ISM_OFFSET(oq_no);
> +       rte_write64(ism_addr, (uint8_t *)otx_ep->hw_addr +
> +                   CN20K_EP_R_OUT_CNTS_ISM(oq_no));
> +       droq->pkts_sent_ism =3D
> +               (uint32_t __rte_atomic *)((uint8_t *)otx_ep->ism_buffer_m=
z->addr
> +                            + CNXK_EP_OQ_ISM_OFFSET(oq_no));
> +       otx_ep_dbg("SDP_R[%d] OQ ISM virt: %p dma: 0x%" PRIX64, oq_no,
> +                  (void *)(uintptr_t)droq->pkts_sent_ism, ism_addr);
> +       *droq->pkts_sent_ism =3D 0;
> +       droq->pkts_sent_prev =3D 0;
> +
> +       loop =3D OTX_EP_BUSY_LOOP_COUNT;
> +       while (((rte_read32(droq->pkts_sent_reg)) !=3D 0ull) && loop--) {
> +               reg_val =3D rte_read32(droq->pkts_sent_reg);
> +               rte_write32((uint32_t)reg_val, droq->pkts_sent_reg);
> +               rte_delay_ms(1);
> +       }
> +
> +       if (loop < 0) {
> +               otx_ep_err("Packets sent register value is not cleared");
> +               return -EIO;
> +       }
> +
> +       otx_ep_dbg("SDP_R[%d]_sent: %x", oq_no, rte_read32(droq->pkts_sen=
t_reg));
> +
> +       /* Set Watermark for backpressure */
> +       oct_ep_write64(OTX_EP_OQ_WMARK_MIN,
> +                      otx_ep->hw_addr + CN20K_EP_R_OUT_WMARK(oq_no));
> +
> +       return 0;
> +}
> +
> +static int
> +cn20k_ep_vf_enable_iq(struct otx_ep_device *otx_ep, uint32_t q_no)
> +{
> +       uint64_t reg_val =3D 0ull;
> +
> +       reg_val =3D oct_ep_read64(otx_ep->hw_addr + CN20K_EP_R_IN_ENABLE(=
q_no));
> +       reg_val |=3D 0x1ull;
> +
> +       oct_ep_write64(reg_val, otx_ep->hw_addr + CN20K_EP_R_IN_ENABLE(q_=
no));
> +
> +       otx_ep_info("IQ[%d] enable done", q_no);
> +
> +       return 0;
> +}
> +
> +static int
> +cn20k_ep_vf_enable_oq(struct otx_ep_device *otx_ep, uint32_t q_no)
> +{
> +       uint64_t reg_val =3D 0ull;
> +
> +       reg_val =3D oct_ep_read64(otx_ep->hw_addr + CN20K_EP_R_OUT_ENABLE=
(q_no));
> +       reg_val |=3D 0x1ull;
> +       oct_ep_write64(reg_val, otx_ep->hw_addr + CN20K_EP_R_OUT_ENABLE(q=
_no));
> +
> +       otx_ep_info("OQ[%d] enable done", q_no);
> +
> +       return 0;
> +}
> +
> +static int
> +cn20k_ep_vf_enable_io_queues(struct otx_ep_device *otx_ep)
> +{
> +       uint32_t q_no =3D 0;
> +       int ret;
> +
> +       for (q_no =3D 0; q_no < otx_ep->nb_tx_queues; q_no++) {
> +               ret =3D cn20k_ep_vf_enable_iq(otx_ep, q_no);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       for (q_no =3D 0; q_no < otx_ep->nb_rx_queues; q_no++)
> +               cn20k_ep_vf_enable_oq(otx_ep, q_no);
> +
> +       return 0;
> +}
> +
> +static void
> +cn20k_ep_vf_disable_iq(struct otx_ep_device *otx_ep, uint32_t q_no)
> +{
> +       uint64_t reg_val =3D 0ull;
> +
> +       /* Reset the doorbell register for this Input Queue. */
> +       reg_val =3D oct_ep_read64(otx_ep->hw_addr + CN20K_EP_R_IN_ENABLE(=
q_no));
> +       reg_val &=3D ~0x1ull;
> +
> +       oct_ep_write64(reg_val, otx_ep->hw_addr + CN20K_EP_R_IN_ENABLE(q_=
no));
> +}
> +
> +static void
> +cn20k_ep_vf_disable_oq(struct otx_ep_device *otx_ep, uint32_t q_no)
> +{
> +       volatile uint64_t reg_val =3D 0ull;
> +
> +       reg_val =3D oct_ep_read64(otx_ep->hw_addr + CN20K_EP_R_OUT_ENABLE=
(q_no));
> +       reg_val &=3D ~0x1ull;
> +
> +       oct_ep_write64(reg_val, otx_ep->hw_addr + CN20K_EP_R_OUT_ENABLE(q=
_no));
> +}
> +
> +static void
> +cn20k_ep_vf_disable_io_queues(struct otx_ep_device *otx_ep)
> +{
> +       uint32_t q_no =3D 0;
> +
> +       for (q_no =3D 0; q_no < otx_ep->sriov_info.rings_per_vf; q_no++) =
{
> +               cn20k_ep_vf_disable_iq(otx_ep, q_no);
> +               cn20k_ep_vf_disable_oq(otx_ep, q_no);
> +       }
> +}
> +
> +static const struct otx_ep_config default_cnxk_ep_conf =3D {
> +       /* IQ attributes */
> +       .iq                        =3D {
> +               .max_iqs           =3D OTX_EP_CFG_IO_QUEUES,
> +               .instr_type        =3D OTX_EP_32BYTE_INSTR,
> +               .pending_list_size =3D (OTX_EP_MAX_IQ_DESCRIPTORS *
> +                                     OTX_EP_CFG_IO_QUEUES),
> +       },
> +
> +       /* OQ attributes */
> +       .oq                        =3D {
> +               .max_oqs           =3D OTX_EP_CFG_IO_QUEUES,
> +               .info_ptr          =3D OTX_EP_OQ_INFOPTR_MODE,
> +               .refill_threshold  =3D OTX_EP_OQ_REFIL_THRESHOLD,
> +       },
> +
> +       .num_iqdef_descs           =3D OTX_EP_MAX_IQ_DESCRIPTORS,
> +       .num_oqdef_descs           =3D OTX_EP_MAX_OQ_DESCRIPTORS,
> +       .oqdef_buf_size            =3D OTX_EP_OQ_BUF_SIZE,
> +};
> +
> +static const struct otx_ep_config*
> +cn20k_ep_get_defconf(struct otx_ep_device *otx_ep_dev __rte_unused)
> +{
> +       const struct otx_ep_config *default_conf =3D NULL;
> +
> +       default_conf =3D &default_cnxk_ep_conf;
> +
> +       return default_conf;
> +}
> +
> +int
> +cn20k_ep_vf_setup_device(struct otx_ep_device *otx_ep)
> +{
> +       /* If application does not provide its conf, use driver default c=
onf */
> +       if (!otx_ep->conf) {
> +               otx_ep->conf =3D cn20k_ep_get_defconf(otx_ep);
> +               if (!otx_ep->conf) {
> +                       otx_ep_err("SDP VF default config not found");
> +                       return -ENOENT;
> +               }
> +               otx_ep_info("Default config is used");
> +       }
> +
> +       otx_ep_info("SDP RPVF: %d", otx_ep->sriov_info.rings_per_vf);
> +
> +       otx_ep->fn_list.setup_iq_regs       =3D cn20k_ep_vf_setup_iq_regs=
;
> +       otx_ep->fn_list.setup_oq_regs       =3D cn20k_ep_vf_setup_oq_regs=
;
> +
> +       otx_ep->fn_list.setup_device_regs   =3D cn20k_ep_vf_setup_device_=
regs;
> +
> +       otx_ep->fn_list.enable_io_queues    =3D cn20k_ep_vf_enable_io_que=
ues;
> +       otx_ep->fn_list.disable_io_queues   =3D cn20k_ep_vf_disable_io_qu=
eues;
> +
> +       otx_ep->fn_list.enable_iq           =3D cn20k_ep_vf_enable_iq;
> +       otx_ep->fn_list.disable_iq          =3D cn20k_ep_vf_disable_iq;
> +
> +       otx_ep->fn_list.enable_oq           =3D cn20k_ep_vf_enable_oq;
> +       otx_ep->fn_list.disable_oq          =3D cn20k_ep_vf_disable_oq;
> +
> +       return 0;
> +}
> diff --git a/drivers/net/octeon_ep/cn20k_ep_vf.h b/drivers/net/octeon_ep/=
cn20k_ep_vf.h
> new file mode 100644
> index 0000000000..6342b885ec
> --- /dev/null
> +++ b/drivers/net/octeon_ep/cn20k_ep_vf.h
> @@ -0,0 +1,175 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2026 Marvell.
> + */
> +#ifndef _CN20K_EP_VF_H_
> +#define _CN20K_EP_VF_H_
> +
> +#include <rte_io.h>
> +#include <rte_bitops.h>
> +
> +#include "otx_ep_common.h"
> +
> +#define CN20K_MAX_RINGS_PER_VF     (8)
> +
> +#define CN20K_EP_R_IN_CONTROL_START        0x40000
> +#define CN20K_EP_R_IN_ENABLE_START         0x40008
> +#define CN20K_EP_R_IN_INSTR_BADDR_START    0x40010
> +#define CN20K_EP_R_IN_INSTR_RSIZE_START    0x40018
> +#define CN20K_EP_R_IN_INSTR_DBELL_START    0x40020
> +#define CN20K_EP_R_IN_CNTS_START           0x40030
> +#define CN20K_EP_R_IN_INT_LEVELS_START     0x40040
> +#define CN20K_EP_R_IN_CNTS_ISM_START       0x40050
> +#define CN20K_EP_R_IN_PKT_CNT_START        0x40460
> +#define CN20K_EP_R_IN_BYTE_CNT_START       0x40470
> +#define CN20K_EP_R_ERR_TYPE_START          0x10400
> +
> +#define CN20K_EP_RING_OFFSET              (0x1ULL << 12)
> +
> +#define CN20K_EP_R_ERR_TYPE(ring)                 \
> +       (CN20K_EP_R_ERR_TYPE_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define CN20K_EP_R_IN_CONTROL(ring)          \
> +       (CN20K_EP_R_IN_CONTROL_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define CN20K_EP_R_IN_ENABLE(ring)          \
> +       (CN20K_EP_R_IN_ENABLE_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define CN20K_EP_R_IN_INSTR_BADDR(ring)          \
> +       (CN20K_EP_R_IN_INSTR_BADDR_START + ((ring) * CN20K_EP_RING_OFFSET=
))
> +
> +#define CN20K_EP_R_IN_INSTR_RSIZE(ring)          \
> +       (CN20K_EP_R_IN_INSTR_RSIZE_START + ((ring) * CN20K_EP_RING_OFFSET=
))
> +
> +#define CN20K_EP_R_IN_INSTR_DBELL(ring)          \
> +       (CN20K_EP_R_IN_INSTR_DBELL_START + ((ring) * CN20K_EP_RING_OFFSET=
))
> +
> +#define CN20K_EP_R_IN_CNTS(ring)          \
> +       (CN20K_EP_R_IN_CNTS_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define CN20K_EP_R_IN_INT_LEVELS(ring)          \
> +       (CN20K_EP_R_IN_INT_LEVELS_START + ((ring) * CN20K_EP_RING_OFFSET)=
)
> +
> +#define CN20K_EP_R_IN_CNTS_ISM(ring)          \
> +       (CN20K_EP_R_IN_CNTS_ISM_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define    CN20K_EP_R_OUT_CNTS_START            0x40130
> +#define    CN20K_EP_R_OUT_INT_LEVELS_START      0x40140
> +#define    CN20K_EP_R_OUT_CNTS_ISM_START        0x40150
> +#define    CN20K_EP_R_OUT_SLIST_BADDR_START     0x40110
> +#define    CN20K_EP_R_OUT_SLIST_RSIZE_START     0x40118
> +#define    CN20K_EP_R_OUT_SLIST_DBELL_START     0x40120
> +#define    CN20K_EP_R_OUT_CONTROL_START         0x40100
> +#define    CN20K_EP_R_OUT_WMARK_START           0x40128
> +#define    CN20K_EP_R_OUT_ENABLE_START          0x40108
> +#define    CN20K_EP_R_OUT_PKT_CNT_START         0x40560
> +#define    CN20K_EP_R_OUT_BYTE_CNT_START        0x40570
> +
> +#define CN20K_EP_R_OUT_CONTROL(ring)          \
> +       (CN20K_EP_R_OUT_CONTROL_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define CN20K_EP_R_OUT_ENABLE(ring)          \
> +       (CN20K_EP_R_OUT_ENABLE_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define CN20K_EP_R_OUT_SLIST_BADDR(ring)          \
> +       (CN20K_EP_R_OUT_SLIST_BADDR_START + ((ring) * CN20K_EP_RING_OFFSE=
T))
> +
> +#define CN20K_EP_R_OUT_SLIST_RSIZE(ring)          \
> +       (CN20K_EP_R_OUT_SLIST_RSIZE_START + ((ring) * CN20K_EP_RING_OFFSE=
T))
> +
> +#define CN20K_EP_R_OUT_SLIST_DBELL(ring)          \
> +       (CN20K_EP_R_OUT_SLIST_DBELL_START + ((ring) * CN20K_EP_RING_OFFSE=
T))
> +
> +#define CN20K_EP_R_OUT_WMARK(ring)          \
> +       (CN20K_EP_R_OUT_WMARK_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define CN20K_EP_R_OUT_CNTS(ring)          \
> +       (CN20K_EP_R_OUT_CNTS_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define CN20K_EP_R_OUT_INT_LEVELS(ring)          \
> +       (CN20K_EP_R_OUT_INT_LEVELS_START + ((ring) * CN20K_EP_RING_OFFSET=
))
> +
> +#define CN20K_EP_R_OUT_CNTS_ISM(ring)          \
> +       (CN20K_EP_R_OUT_CNTS_ISM_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define CN20K_EP_R_OUT_PKT_CNT(ring)          \
> +       (CN20K_EP_R_OUT_PKT_CNT_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define CN20K_EP_R_OUT_BYTE_CNT(ring)          \
> +       (CN20K_EP_R_OUT_BYTE_CNT_START + ((ring) * CN20K_EP_RING_OFFSET))
> +
> +#define PCI_DEVID_CN20KA_EP_NET_VF             0xC203
> +#define PCI_DEVID_CNF20KA_EP_NET_VF            0xCA03
> +
> +#ifndef BIT_ULL
> +#define BIT_ULL(n) RTE_BIT64(n)
> +#endif
> +
> +int
> +cn20k_ep_vf_setup_device(struct otx_ep_device *sdpvf);
> +
> +/* ##################### CN20K Mailbox Registers #######################=
### */
> +/* CN20K uses a completely different mailbox architecture compared to CN=
9X/CN10X
> + * - Uses command/data/control register interface
> + * - Shared DMA memory buffer (allocated by PF in system RAM)
> + * - VF accesses via indirect CMD registers with offset/data/control
> + * - PF accesses directly via pointers to DMA memory
> + */
> +
> +/* VF Write Command Registers - for VF_PF communication */
> +#define CN20K_SDP_RMT_VFX_MBOX_WR_CMD_CTL       0x24040
> +#define CN20K_SDP_RMT_VFX_MBOX_WR_CMD_OFFSET    0x24048
> +#define CN20K_SDP_RMT_VFX_MBOX_WR_CMD_DATA      0x24050
> +
> +/* VF Read Command Registers - for PF_VF communication */
> +#define CN20K_SDP_RMT_VFX_MBOX_RD_CMD_CTL       0x24060
> +#define CN20K_SDP_RMT_VFX_MBOX_RD_CMD_OFFSET    0x24068
> +#define CN20K_SDP_RMT_VFX_MBOX_RD_CMD_DATA      0x24070
> +
> +/* VF Mailbox Interrupt Registers */
> +#define CN20K_SDP_RMT_VFX_MBOX_RINT             0x24020
> +#define CN20K_SDP_RMT_VFX_MBOX_RINT_W1S         0x24028
> +#define CN20K_SDP_RMT_VFX_MBOX_RINT_ENA_W1C     0x24030
> +#define CN20K_SDP_RMT_VFX_MBOX_RINT_ENA_W1S     0x24038
> +
> +/* VF Send Interrupt to PF */
> +#define CN20K_SDP_RMT_VFX_MBOX_SEND_INT         0x24000
> +
> +/* Direct Mailbox Data Access (8K registers * 8 bytes =3D 64KB) */
> +#define CN20K_SDP_RMT_VFX_MBOX_DATA_START       0x30000
> +#define CN20K_SDP_RMT_VFX_MBOX_DATA(offset)     \
> +       (CN20K_SDP_RMT_VFX_MBOX_DATA_START + ((offset) * 8))
> +
> +/* Command Control Bit Definitions */
> +#define CN20K_MBOX_WR_CMD_DONE      BIT_ULL(0)
> +#define CN20K_MBOX_WR_CMD_ERR       BIT_ULL(1)
> +#define CN20K_MBOX_WR_CMD_OUT       BIT_ULL(2)
> +#define CN20K_MBOX_WR_COMMIT        BIT_ULL(3)
> +#define CN20K_MBOX_WR_DROP          BIT_ULL(4)
> +
> +#define CN20K_MBOX_RD_CMD_DONE      BIT_ULL(0)
> +#define CN20K_MBOX_RD_CMD_ERR       BIT_ULL(1)
> +#define CN20K_MBOX_RD_CMD_OUT       BIT_ULL(2)
> +
> +/* Mailbox Interrupt Bits */
> +#define CN20K_MBOX_INTR             BIT_ULL(0)
> +
> +/* Mailbox Memory Layout (64KB per VF, same as PFAF) */
> +#define CN20K_VF_MBOX_SIZE          (64 * 1024)
> +#define CN20K_MBOX_DOWN_RX_START    0
> +#define CN20K_MBOX_DOWN_RX_SIZE     (46 * 1024)
> +#define CN20K_MBOX_DOWN_TX_START    (CN20K_MBOX_DOWN_RX_START + CN20K_MB=
OX_DOWN_RX_SIZE)
> +#define CN20K_MBOX_DOWN_TX_SIZE     (16 * 1024)
> +#define CN20K_MBOX_UP_RX_START      (CN20K_MBOX_DOWN_TX_START + CN20K_MB=
OX_DOWN_TX_SIZE)
> +#define CN20K_MBOX_UP_RX_SIZE       (1 * 1024)
> +#define CN20K_MBOX_UP_TX_START      (CN20K_MBOX_UP_RX_START + CN20K_MBOX=
_UP_RX_SIZE)
> +#define CN20K_MBOX_UP_TX_SIZE       (1 * 1024)
> +
> +/* Non-IOQ Interrupt Configuration */
> +#define CN20K_VF_NUM_NON_IOQ_INTR   16    /* Vectors 0-15 for non-IOQ (c=
ontrol path) */
> +#define CN20K_VF_IOQ_INTR_BASE      16    /* IOQ interrupts start at vec=
tor 16 (data path) */
> +
> +/* Non-IOQ Interrupt Vector Assignments */
> +#define CN20K_VF_NON_IOQ_INTR_MBOX  0     /* Vector 0: Mailbox (control =
path) */
> +/* Vectors 1-15: Reserved for other non-IOQ interrupts (errors, etc.) */
> +
> +#endif /*_CN20K_EP_VF_H_ */
> diff --git a/drivers/net/octeon_ep/cnxk_ep_rx.c b/drivers/net/octeon_ep/c=
nxk_ep_rx.c
> index 9678cec90b..f9bfffe759 100644
> --- a/drivers/net/octeon_ep/cnxk_ep_rx.c
> +++ b/drivers/net/octeon_ep/cnxk_ep_rx.c
> @@ -8,56 +8,94 @@ static __rte_always_inline void
>  cnxk_ep_process_pkts_scalar_mseg(struct rte_mbuf **rx_pkts, struct otx_e=
p_droq *droq,
>                                  uint16_t new_pkts)
>  {
> +       struct otx_ep_droq_desc *desc_ring =3D droq->desc_ring;
>         struct rte_mbuf **recv_buf_list =3D droq->recv_buf_list;
>         uint32_t total_pkt_len, bytes_rsvd =3D 0;
>         uint16_t nb_desc =3D droq->nb_desc;
>         uint16_t pkts;
>
>         for (pkts =3D 0; pkts < new_pkts; pkts++) {
> +               union cn20k_ep_rx_compl_t compl;
>                 struct otx_ep_droq_info *info;
>                 struct rte_mbuf *first_buf =3D NULL;
>                 struct rte_mbuf *last_buf =3D NULL;
>                 struct rte_mbuf *mbuf;
> -               uint32_t pkt_len =3D 0;
> +               uint32_t i, pkt_len =3D 0;
>
>                 mbuf =3D recv_buf_list[droq->read_idx];
> -               info =3D cnxk_pktmbuf_mtod(mbuf, struct otx_ep_droq_info =
*);
>
> -               total_pkt_len =3D rte_bswap16(info->length >> 48) + OTX_E=
P_INFO_SIZE;
> +               if (droq->chip_gen =3D=3D OTX_EP_CN20XX) {
> +                       uint32_t num_bufs;
>
> -               while (pkt_len < total_pkt_len) {
> -                       int cpy_len;
> +                       compl.u =3D rte_bswap64(desc_ring[droq->read_idx]=
.info_ptr);
> +                       num_bufs =3D compl.s.num_buf;
>
> -                       cpy_len =3D ((pkt_len + droq->buffer_size) > tota=
l_pkt_len)
> -                                       ? ((uint32_t)total_pkt_len - pkt_=
len) : droq->buffer_size;
> +                       first_buf =3D mbuf;
> +                       *(uint64_t *)&first_buf->rearm_data =3D droq->rea=
rm_data;
> +                       first_buf->pkt_len =3D compl.s.pkt_len;
> +                       first_buf->nb_segs =3D num_bufs;
>
> -                       mbuf =3D droq->recv_buf_list[droq->read_idx];
> +                       first_buf->data_len =3D droq->buffer_size;
> +                       last_buf =3D first_buf;
>
> -                       if (!pkt_len) {
> -                               /* Note the first seg */
> -                               first_buf =3D mbuf;
> -                               *(uint64_t *)&mbuf->rearm_data =3D droq->=
rearm_data;
> -                               mbuf->pkt_len =3D cpy_len - OTX_EP_INFO_S=
IZE;
> -                               mbuf->data_len =3D cpy_len - OTX_EP_INFO_=
SIZE;
> -                       } else {
> -                               mbuf->pkt_len =3D cpy_len;
> -                               mbuf->data_len =3D cpy_len;
> -                               first_buf->nb_segs++;
> -                               first_buf->pkt_len +=3D mbuf->pkt_len;
> -                       }
> +                       for (i =3D 1; i < num_bufs; i++) {
> +                               droq->read_idx =3D otx_ep_incr_index(droq=
->read_idx, 1,
> +                                                                  nb_des=
c);
> +                               mbuf =3D recv_buf_list[droq->read_idx];
> +                               if (unlikely(!mbuf))
> +                                       break;
>
> -                       if (last_buf)
> -                               last_buf->next =3D mbuf;
> +                               if (i =3D=3D (num_bufs - 1))
> +                                       mbuf->data_len =3D compl.s.last_b=
uf_len;
> +                               else
> +                                       mbuf->data_len =3D droq->buffer_s=
ize;
>
> -                       last_buf =3D mbuf;
> +                               last_buf->next =3D mbuf;
> +                               last_buf =3D mbuf;
> +                       }
> +                       last_buf->next =3D NULL;
>
> -                       pkt_len +=3D cpy_len;
>                         droq->read_idx =3D otx_ep_incr_index(droq->read_i=
dx, 1, nb_desc);
> -                       droq->refill_count++;
> +                       droq->refill_count +=3D num_bufs;
> +               } else {
> +                       info =3D rte_pktmbuf_mtod(mbuf, struct otx_ep_dro=
q_info *);
> +                       total_pkt_len =3D rte_bswap16(info->length >> 48)=
 + OTX_EP_INFO_SIZE;
> +
> +                       while (pkt_len < total_pkt_len) {
> +                               int cpy_len;
> +
> +                               cpy_len =3D ((pkt_len + droq->buffer_size=
) > total_pkt_len)
> +                                               ? ((uint32_t)total_pkt_le=
n - pkt_len) :
> +                                                droq->buffer_size;
> +
> +                               mbuf =3D droq->recv_buf_list[droq->read_i=
dx];
> +
> +                               if (!pkt_len) {
> +                                       /* Note the first seg */
> +                                       first_buf =3D mbuf;
> +                                       mbuf->data_off +=3D OTX_EP_INFO_S=
IZE;
> +                                       mbuf->pkt_len =3D cpy_len - OTX_E=
P_INFO_SIZE;
> +                                       mbuf->data_len =3D cpy_len - OTX_=
EP_INFO_SIZE;
> +                               } else {
> +                                       mbuf->pkt_len =3D cpy_len;
> +                                       mbuf->data_len =3D cpy_len;
> +                                       first_buf->nb_segs++;
> +                                       first_buf->pkt_len +=3D mbuf->pkt=
_len;
> +                               }
> +
> +                               if (last_buf)
> +                                       last_buf->next =3D mbuf;
> +
> +                               last_buf =3D mbuf;
> +
> +                               pkt_len +=3D cpy_len;
> +                               droq->read_idx =3D otx_ep_incr_index(droq=
->read_idx, 1, nb_desc);
> +                               droq->refill_count++;
> +                       }
>                 }
>                 mbuf =3D first_buf;
>                 rx_pkts[pkts] =3D mbuf;
> -               bytes_rsvd +=3D pkt_len;
> +               bytes_rsvd +=3D mbuf->pkt_len;
>         }
>
>         droq->pkts_pending -=3D pkts;
> diff --git a/drivers/net/octeon_ep/cnxk_ep_rx.h b/drivers/net/octeon_ep/c=
nxk_ep_rx.h
> index 5db32c4448..c06e9d858c 100644
> --- a/drivers/net/octeon_ep/cnxk_ep_rx.h
> +++ b/drivers/net/octeon_ep/cnxk_ep_rx.h
> @@ -11,6 +11,18 @@
>  #define CNXK_EP_OQ_DESC_PER_LOOP_SSE 4
>  #define CNXK_EP_OQ_DESC_PER_LOOP_AVX 8
>
> +union cn20k_ep_rx_compl_t {
> +       uint64_t u;
> +       struct cn20k_ep_rx_compl_s {
> +               uint64_t pkt_len : 16;
> +               uint64_t last_buf_len : 16;
> +               uint64_t num_buf : 10;
> +               uint64_t rsvd : 20;
> +               uint64_t ptp : 1;
> +               uint64_t done : 1;
> +       } s;
> +};
> +
>  static inline int
>  cnxk_ep_rx_refill_mbuf(struct otx_ep_droq *droq, uint32_t count)
>  {
> @@ -32,7 +44,10 @@ cnxk_ep_rx_refill_mbuf(struct otx_ep_droq *droq, uint3=
2_t count)
>                 if (i < count - 1)
>                         rte_prefetch_non_temporal(recv_buf_list[refill_id=
x + 1]);
>                 buf =3D recv_buf_list[refill_idx];
> +
>                 desc_ring[refill_idx].buffer_ptr =3D rte_mbuf_data_iova_d=
efault(buf);
> +               if (droq->chip_gen =3D=3D OTX_EP_CN20XX)
> +                       desc_ring[refill_idx].info_ptr =3D 0;
>                 refill_idx++;
>         }
>
> @@ -164,12 +179,14 @@ cnxk_ep_rx_pkts_to_process(struct otx_ep_droq *droq=
, uint16_t nb_pkts)
>  static __rte_always_inline void
>  cnxk_ep_process_pkts_scalar(struct rte_mbuf **rx_pkts, struct otx_ep_dro=
q *droq, uint16_t new_pkts)
>  {
> +       struct otx_ep_droq_desc *desc_ring =3D droq->desc_ring;
>         struct rte_mbuf **recv_buf_list =3D droq->recv_buf_list;
>         uint32_t bytes_rsvd =3D 0, read_idx =3D droq->read_idx;
>         uint16_t nb_desc =3D droq->nb_desc;
>         uint16_t pkts;
>
>         for (pkts =3D 0; pkts < new_pkts; pkts++) {
> +               union cn20k_ep_rx_compl_t compl;
>                 struct otx_ep_droq_info *info;
>                 struct rte_mbuf *mbuf;
>                 uint16_t pkt_len;
> @@ -180,9 +197,15 @@ cnxk_ep_process_pkts_scalar(struct rte_mbuf **rx_pkt=
s, struct otx_ep_droq *droq,
>                               void *));
>
>                 mbuf =3D recv_buf_list[read_idx];
> -               info =3D cnxk_pktmbuf_mtod(mbuf, struct otx_ep_droq_info =
*);
> -               read_idx =3D otx_ep_incr_index(read_idx, 1, nb_desc);
> -               pkt_len =3D rte_bswap16(info->length >> 48);
> +               if (droq->chip_gen =3D=3D OTX_EP_CN20XX) {
> +                       compl.u =3D rte_bswap64(desc_ring[read_idx].info_=
ptr);
> +                       pkt_len =3D compl.s.pkt_len;
> +                       read_idx =3D otx_ep_incr_index(read_idx, 1, nb_de=
sc);
> +               } else {
> +                       info =3D cnxk_pktmbuf_mtod(mbuf, struct otx_ep_dr=
oq_info *);
> +                       read_idx =3D otx_ep_incr_index(read_idx, 1, nb_de=
sc);
> +                       pkt_len =3D rte_bswap16(info->length >> 48);
> +               }
>                 mbuf->pkt_len =3D pkt_len;
>                 mbuf->data_len =3D pkt_len;
>
> diff --git a/drivers/net/octeon_ep/cnxk_ep_rx_avx.c b/drivers/net/octeon_=
ep/cnxk_ep_rx_avx.c
> index 47eb1d2ef7..37b613dbf5 100644
> --- a/drivers/net/octeon_ep/cnxk_ep_rx_avx.c
> +++ b/drivers/net/octeon_ep/cnxk_ep_rx_avx.c
> @@ -7,6 +7,7 @@
>  static __rte_always_inline void
>  cnxk_ep_process_pkts_vec_avx(struct rte_mbuf **rx_pkts, struct otx_ep_dr=
oq *droq, uint16_t new_pkts)
>  {
> +       struct otx_ep_droq_desc *desc_ring =3D droq->desc_ring;
>         struct rte_mbuf **recv_buf_list =3D droq->recv_buf_list;
>         uint32_t bytes_rsvd =3D 0, read_idx =3D droq->read_idx;
>         const uint64_t rearm_data =3D droq->rearm_data;
> @@ -25,6 +26,11 @@ cnxk_ep_process_pkts_vec_avx(struct rte_mbuf **rx_pkts=
, struct otx_ep_droq *droq
>                         _mm256_set_epi8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF=
F, 20, 21, 0xFF, 0xFF, 20,
>                                         21, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,=
 0xFF, 0xFF, 0xFF, 0xFF,
>                                         0xFF, 0xFF, 0xFF, 7, 6, 5, 4, 3, =
2, 1, 0);
> +               const __m256i mask1 =3D
> +                       _mm256_set_epi8(0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF=
F, 25, 24, 0xFF, 0xFF, 25,
> +                                       24, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,=
 0xFF, 0xFF, 0xFF, 0xFF,
> +                                       0xFF, 0xFF, 0xFF, 7, 6, 5, 4, 3, =
2, 1, 0);
> +
>
>                 /* Load indexes. */
>                 for (i =3D 1; i < CNXK_EP_OQ_DESC_PER_LOOP_AVX; i++)
> @@ -46,16 +52,28 @@ cnxk_ep_process_pkts_vec_avx(struct rte_mbuf **rx_pkt=
s, struct otx_ep_droq *droq
>                 for (i =3D 0; i < CNXK_EP_OQ_DESC_PER_LOOP_AVX; i++)
>                         m[i] =3D recv_buf_list[idx[i]];
>
> -               /* Load rearm data and packet length for shuffle. */
> -               for (i =3D 0; i < CNXK_EP_OQ_DESC_PER_LOOP_AVX; i++)
> -                       data[i] =3D _mm256_set_epi64x(0,
> -                               cnxk_pktmbuf_mtod(m[i], struct otx_ep_dro=
q_info *)->length >> 16,
> -                               0, rearm_data);
> -
> -               /* Shuffle data to its place and sum the packet length. *=
/
> -               for (i =3D 0; i < CNXK_EP_OQ_DESC_PER_LOOP_AVX; i++) {
> -                       data[i] =3D _mm256_shuffle_epi8(data[i], mask);
> -                       bytes_rsvd +=3D _mm256_extract_epi16(data[i], 10)=
;
> +               if (droq->chip_gen =3D=3D OTX_EP_CN20XX) {
> +                       for (i =3D 0; i < CNXK_EP_OQ_DESC_PER_LOOP_AVX; i=
++)
> +                               data[i] =3D _mm256_set_epi64x(rte_bswap64=
(desc_ring[idx[i]].info_ptr),
> +                                                           0, 0, rearm_d=
ata);
> +
> +                       for (i =3D 0; i < CNXK_EP_OQ_DESC_PER_LOOP_AVX; i=
++) {
> +                               data[i] =3D _mm256_shuffle_epi8(data[i], =
mask1);
> +                               bytes_rsvd +=3D _mm256_extract_epi16(data=
[i], 10);
> +                       }
> +               } else {
> +                       uint64_t len;
> +                       /* Load rearm data and packet length for shuffle.=
 */
> +                       for (i =3D 0; i < CNXK_EP_OQ_DESC_PER_LOOP_AVX; i=
++) {
> +                               len =3D cnxk_pktmbuf_mtod(m[i], struct ot=
x_ep_droq_info *)->length;
> +                               data[i] =3D _mm256_set_epi64x(0, len >> 1=
6, 0, rearm_data);
> +                       }
> +
> +                       /* Shuffle data to its place and sum the packet l=
ength. */
> +                       for (i =3D 0; i < CNXK_EP_OQ_DESC_PER_LOOP_AVX; i=
++) {
> +                               data[i] =3D _mm256_shuffle_epi8(data[i], =
mask);
> +                               bytes_rsvd +=3D _mm256_extract_epi16(data=
[i], 10);
> +                       }
>                 }
>
>                 /* Store the 256bit data to the mbuf. */
> diff --git a/drivers/net/octeon_ep/cnxk_ep_rx_neon.c b/drivers/net/octeon=
_ep/cnxk_ep_rx_neon.c
> index 2cb5cf4ad8..4b9792c261 100644
> --- a/drivers/net/octeon_ep/cnxk_ep_rx_neon.c
> +++ b/drivers/net/octeon_ep/cnxk_ep_rx_neon.c
> @@ -12,6 +12,7 @@ cnxk_ep_process_pkts_vec_neon(struct rte_mbuf **rx_pkts=
, struct otx_ep_droq *dro
>                                   4, 5, 0xff, 0xff, 4, 5, 0xff, 0xff};
>         const uint8x16_t mask1 =3D {8,  9,  0xff, 0xff, 8,  9,  0xff, 0xf=
f,
>                                   12, 13, 0xff, 0xff, 12, 13, 0xff, 0xff}=
;
> +       struct otx_ep_droq_desc *desc_ring =3D droq->desc_ring;
>         struct rte_mbuf **recv_buf_list =3D droq->recv_buf_list;
>         uint32_t pidx0, pidx1, pidx2, pidx3;
>         struct rte_mbuf *m0, *m1, *m2, *m3;
> @@ -47,29 +48,53 @@ cnxk_ep_process_pkts_vec_neon(struct rte_mbuf **rx_pk=
ts, struct otx_ep_droq *dro
>                 m2 =3D recv_buf_list[idx2];
>                 m3 =3D recv_buf_list[idx3];
>
> -               /* Load packet size big-endian. */
> -               s01 =3D vsetq_lane_u32(cnxk_pktmbuf_mtod(m0, struct otx_e=
p_droq_info *)->length >> 48,
> -                                    s01, 0);
> -               s01 =3D vsetq_lane_u32(cnxk_pktmbuf_mtod(m1, struct otx_e=
p_droq_info *)->length >> 48,
> -                                    s01, 1);
> -               s01 =3D vsetq_lane_u32(cnxk_pktmbuf_mtod(m2, struct otx_e=
p_droq_info *)->length >> 48,
> -                                    s01, 2);
> -               s01 =3D vsetq_lane_u32(cnxk_pktmbuf_mtod(m3, struct otx_e=
p_droq_info *)->length >> 48,
> -                                    s01, 3);
> -               /* Convert to little-endian. */
> -               s01 =3D vrev16q_u8(s01);
> -
> -               /* Vertical add, consolidate outside the loop. */
> -               bytes +=3D vaddq_u32(bytes, s01);
> -               /* Separate into packet length and data length. */
> -               s23 =3D vqtbl1q_u8(s01, mask1);
> -               s01 =3D vqtbl1q_u8(s01, mask0);
> -
> -               /* Store packet length and data length to mbuf. */
> -               *(uint64_t *)&m0->pkt_len =3D vgetq_lane_u64(s01, 0);
> -               *(uint64_t *)&m1->pkt_len =3D vgetq_lane_u64(s01, 1);
> -               *(uint64_t *)&m2->pkt_len =3D vgetq_lane_u64(s23, 0);
> -               *(uint64_t *)&m3->pkt_len =3D vgetq_lane_u64(s23, 1);
> +               if (droq->chip_gen =3D=3D OTX_EP_CN20XX) {
> +                       uint32x4_t lens;
> +
> +                       /* Load packet size (completion is in big-endian =
order) */
> +                       lens =3D vdupq_n_u32(0);
> +                       lens =3D vsetq_lane_u32((uint32_t)rte_bswap64(des=
c_ring[idx0].info_ptr),
> +                                             lens, 0);
> +                       lens =3D vsetq_lane_u32((uint32_t)rte_bswap64(des=
c_ring[idx1].info_ptr),
> +                                             lens, 1);
> +                       lens =3D vsetq_lane_u32((uint32_t)rte_bswap64(des=
c_ring[idx2].info_ptr),
> +                                             lens, 2);
> +                       lens =3D vsetq_lane_u32((uint32_t)rte_bswap64(des=
c_ring[idx3].info_ptr),
> +                                             lens, 3);
> +                       lens =3D vandq_u32(lens, vdupq_n_u32(0xFFFF));
> +                       bytes =3D vaddq_u32(bytes, lens);
> +
> +                       m0->pkt_len =3D m0->data_len =3D vgetq_lane_u32(l=
ens, 0);
> +                       m1->pkt_len =3D m1->data_len =3D vgetq_lane_u32(l=
ens, 1);
> +                       m2->pkt_len =3D m2->data_len =3D vgetq_lane_u32(l=
ens, 2);
> +                       m3->pkt_len =3D m3->data_len =3D vgetq_lane_u32(l=
ens, 3);
> +               } else {
> +                       uint8x16_t len_vec;
> +                       uint32_t p0, p1, p2, p3;
> +
> +                       /* Load packet size big-endian. */
> +                       p0 =3D cnxk_pktmbuf_mtod(m0, struct otx_ep_droq_i=
nfo *)->length >> 48;
> +                       p1 =3D cnxk_pktmbuf_mtod(m1, struct otx_ep_droq_i=
nfo *)->length >> 48;
> +                       p2 =3D cnxk_pktmbuf_mtod(m2, struct otx_ep_droq_i=
nfo *)->length >> 48;
> +                       p3 =3D cnxk_pktmbuf_mtod(m3, struct otx_ep_droq_i=
nfo *)->length >> 48;
> +
> +                       s01 =3D vsetq_lane_u32(p0, s01, 0);
> +                       s01 =3D vsetq_lane_u32(p1, s01, 1);
> +                       s01 =3D vsetq_lane_u32(p2, s01, 2);
> +                       s01 =3D vsetq_lane_u32(p3, s01, 3);
> +                       /* Convert to little-endian. */
> +                       len_vec =3D vrev16q_u8(vreinterpretq_u8_u64(s01))=
;
> +                       bytes =3D vaddq_u32(bytes, vreinterpretq_u32_u8(l=
en_vec));
> +                       /* Separate into packet length and data length. *=
/
> +                       s23 =3D vreinterpretq_u64_u8(vqtbl1q_u8(len_vec, =
mask1));
> +                       s01 =3D vreinterpretq_u64_u8(vqtbl1q_u8(len_vec, =
mask0));
> +
> +                       /* Store packet length and data length to mbuf. *=
/
> +                       *(uint64_t *)&m0->pkt_len =3D vgetq_lane_u64(s01,=
 0);
> +                       *(uint64_t *)&m1->pkt_len =3D vgetq_lane_u64(s01,=
 1);
> +                       *(uint64_t *)&m2->pkt_len =3D vgetq_lane_u64(s23,=
 0);
> +                       *(uint64_t *)&m3->pkt_len =3D vgetq_lane_u64(s23,=
 1);
> +               }
>
>                 /* Reset rearm data. */
>                 *(uint64_t *)&m0->rearm_data =3D droq->rearm_data;
> diff --git a/drivers/net/octeon_ep/cnxk_ep_rx_sse.c b/drivers/net/octeon_=
ep/cnxk_ep_rx_sse.c
> index d17ec46211..7802d73477 100644
> --- a/drivers/net/octeon_ep/cnxk_ep_rx_sse.c
> +++ b/drivers/net/octeon_ep/cnxk_ep_rx_sse.c
> @@ -17,6 +17,7 @@ hadd(__m128i x)
>  static __rte_always_inline void
>  cnxk_ep_process_pkts_vec_sse(struct rte_mbuf **rx_pkts, struct otx_ep_dr=
oq *droq, uint16_t new_pkts)
>  {
> +       struct otx_ep_droq_desc *desc_ring =3D droq->desc_ring;
>         struct rte_mbuf **recv_buf_list =3D droq->recv_buf_list;
>         uint32_t read_idx =3D droq->read_idx;
>         struct rte_mbuf *m0, *m1, *m2, *m3;
> @@ -32,6 +33,8 @@ cnxk_ep_process_pkts_vec_sse(struct rte_mbuf **rx_pkts,=
 struct otx_ep_droq *droq
>                                                         0xFF, 4, 5, 0xFF,=
 0xFF, 0, 1);
>                 const __m128i cpy_mask =3D _mm_set_epi8(0xFF, 0xFF, 9, 8,=
 0xFF, 0xFF, 9, 8, 0xFF,
>                                                       0xFF, 1, 0, 0xFF, 0=
xFF, 1, 0);
> +               const __m128i cpy_mask1 =3D _mm_set_epi8(0xFF, 0xFF, 13, =
12, 0xFF, 0xFF, 9, 8,
> +                                                      0xFF, 0xFF, 5, 4, =
0xFF, 0xFF, 1, 0);
>                 __m128i s01, s23;
>
>                 idx1 =3D otx_ep_incr_index(idx0, 1, nb_desc);
> @@ -43,13 +46,25 @@ cnxk_ep_process_pkts_vec_sse(struct rte_mbuf **rx_pkt=
s, struct otx_ep_droq *droq
>                 m2 =3D recv_buf_list[idx2];
>                 m3 =3D recv_buf_list[idx3];
>
> -               /* Load packet size big-endian. */
> -               s01 =3D _mm_set_epi32(cnxk_pktmbuf_mtod(m3, struct otx_ep=
_droq_info *)->length >> 48,
> -                                   cnxk_pktmbuf_mtod(m1, struct otx_ep_d=
roq_info *)->length >> 48,
> -                                   cnxk_pktmbuf_mtod(m2, struct otx_ep_d=
roq_info *)->length >> 48,
> -                                   cnxk_pktmbuf_mtod(m0, struct otx_ep_d=
roq_info *)->length >> 48);
> -               /* Convert to little-endian. */
> -               s01 =3D _mm_shuffle_epi8(s01, bswap_mask);
> +               if (droq->chip_gen =3D=3D OTX_EP_CN20XX) {
> +                       /* Load packet size (completion is in big-endian =
order) */
> +                       s01 =3D _mm_set_epi32((uint32_t)rte_bswap64(desc_=
ring[idx3].info_ptr),
> +                                           (uint32_t)rte_bswap64(desc_ri=
ng[idx2].info_ptr),
> +                                           (uint32_t)rte_bswap64(desc_ri=
ng[idx1].info_ptr),
> +                                           (uint32_t)rte_bswap64(desc_ri=
ng[idx0].info_ptr));
> +                       s01 =3D _mm_shuffle_epi8(s01, cpy_mask1);
> +               } else {
> +                       uint32_t p0, p1, p2, p3;
> +
> +                       /* Load packet size big-endian. */
> +                       p0 =3D cnxk_pktmbuf_mtod(m0, struct otx_ep_droq_i=
nfo *)->length >> 48;
> +                       p1 =3D cnxk_pktmbuf_mtod(m1, struct otx_ep_droq_i=
nfo *)->length >> 48;
> +                       p2 =3D cnxk_pktmbuf_mtod(m2, struct otx_ep_droq_i=
nfo *)->length >> 48;
> +                       p3 =3D cnxk_pktmbuf_mtod(m3, struct otx_ep_droq_i=
nfo *)->length >> 48;
> +                       s01 =3D _mm_set_epi32(p3, p1, p2, p0);
> +                       /* Convert to little-endian. */
> +                       s01 =3D _mm_shuffle_epi8(s01, bswap_mask);
> +               }
>                 /* Vertical add, consolidate outside loop */
>                 bytes =3D _mm_add_epi32(bytes, s01);
>                 /* Separate into packet length and data length. */
> diff --git a/drivers/net/octeon_ep/meson.build b/drivers/net/octeon_ep/me=
son.build
> index cbb729b689..b2101bc670 100644
> --- a/drivers/net/octeon_ep/meson.build
> +++ b/drivers/net/octeon_ep/meson.build
> @@ -11,6 +11,8 @@ sources =3D files(
>          'otx_ep_mbox.c',
>          'cnxk_ep_rx.c',
>          'cnxk_ep_tx.c',
> +        'cn20k_ep_vf.c',
> +        'cn20k_ep_mbox.c',
>  )
>
>  if arch_subdir =3D=3D 'x86'
> diff --git a/drivers/net/octeon_ep/otx_ep_common.h b/drivers/net/octeon_e=
p/otx_ep_common.h
> index 53de8b18d6..406155078b 100644
> --- a/drivers/net/octeon_ep/otx_ep_common.h
> +++ b/drivers/net/octeon_ep/otx_ep_common.h
> @@ -19,12 +19,14 @@
>  #define OTX_EP_CN8XX  RTE_BIT32(0)
>  #define OTX_EP_CN9XX  RTE_BIT32(1)
>  #define OTX_EP_CN10XX RTE_BIT32(2)
> +#define OTX_EP_CN20XX RTE_BIT32(3)
>
>  #define OTX_EP_NW_PKT_OP               0x1220
>  #define OTX_EP_NW_CMD_OP               0x1221
>
>  #define OTX_EP_MAX_RINGS_PER_VF        (8)
>  #define OTX_EP_CFG_IO_QUEUES        OTX_EP_MAX_RINGS_PER_VF
> +#define OTX_EP_16BYTE_INSTR         (16)
>  #define OTX_EP_32BYTE_INSTR         (32)
>  #define OTX_EP_64BYTE_INSTR         (64)
>  /*
> @@ -406,6 +408,9 @@ struct otx_ep_droq {
>          */
>         void *pkts_sent_reg;
>
> +       /* Generation */
> +       uint32_t chip_gen;
> +
>         /* Use ISM memory */
>         uint8_t ism_ena;
>
> @@ -572,6 +577,10 @@ struct otx_ep_device {
>
>         /* Use ISM memory */
>         uint8_t ism_ena;
> +
> +       uint8_t configured;
> +
> +       struct otx_ep_cn20k_mbox *mbox_info;
>  };
>
>  int otx_ep_setup_iqs(struct otx_ep_device *otx_ep, uint32_t iq_no,
> diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_e=
p/otx_ep_ethdev.c
> index 876d2f9d7d..8a2dd877a1 100644
> --- a/drivers/net/octeon_ep/otx_ep_ethdev.c
> +++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
> @@ -9,6 +9,8 @@
>  #include "otx_ep_vf.h"
>  #include "otx2_ep_vf.h"
>  #include "cnxk_ep_vf.h"
> +#include "cn20k_ep_vf.h"
> +#include "cn20k_ep_mbox.h"
>  #include "otx_ep_rxtx.h"
>  #include "otx_ep_mbox.h"
>
> @@ -16,6 +18,7 @@
>         ((struct otx_ep_device *)(_eth_dev)->data->dev_private)
>
>  #define OTX_ISM_ENABLE "ism_enable"
> +#define OTX_MAX_RINGS  "max_rings"
>
>  static const struct rte_eth_desc_lim otx_ep_rx_desc_lim =3D {
>         .nb_max         =3D OTX_EP_MAX_OQ_DESCRIPTORS,
> @@ -42,6 +45,7 @@ parse_flag(const char *key, const char *value, void *ex=
tra_args)
>  static int
>  otx_ethdev_parse_devargs(struct rte_devargs *devargs, struct otx_ep_devi=
ce *otx_epvf)
>  {
> +       uint8_t max_rings =3D CN20K_MAX_RINGS_PER_VF;
>         struct rte_kvargs *kvlist;
>         uint8_t ism_enable =3D 0;
>
> @@ -53,10 +57,12 @@ otx_ethdev_parse_devargs(struct rte_devargs *devargs,=
 struct otx_ep_device *otx_
>                 goto exit;
>
>         rte_kvargs_process(kvlist, OTX_ISM_ENABLE, &parse_flag, &ism_enab=
le);
> +       rte_kvargs_process(kvlist, OTX_MAX_RINGS, &parse_flag, &max_rings=
);
>         rte_kvargs_free(kvlist);
>
>  null_devargs:
>         otx_epvf->ism_ena =3D !!ism_enable;
> +       otx_epvf->sriov_info.rings_per_vf =3D max_rings;
>
>         return 0;
>
> @@ -69,7 +75,8 @@ otx_ep_set_tx_func(struct rte_eth_dev *eth_dev)
>  {
>         struct otx_ep_device *otx_epvf =3D OTX_EP_DEV(eth_dev);
>
> -       if (otx_epvf->chip_gen =3D=3D OTX_EP_CN10XX || otx_epvf->chip_gen=
 =3D=3D OTX_EP_CN9XX) {
> +       if (otx_epvf->chip_gen =3D=3D OTX_EP_CN10XX || otx_epvf->chip_gen=
 =3D=3D OTX_EP_CN9XX ||
> +           otx_epvf->chip_gen =3D=3D OTX_EP_CN20XX) {
>                 eth_dev->tx_pkt_burst =3D &cnxk_ep_xmit_pkts;
>                 if (otx_epvf->tx_offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS=
)
>                         eth_dev->tx_pkt_burst =3D &cnxk_ep_xmit_pkts_mseg=
;
> @@ -87,7 +94,7 @@ otx_ep_set_rx_func(struct rte_eth_dev *eth_dev)
>  {
>         struct otx_ep_device *otx_epvf =3D OTX_EP_DEV(eth_dev);
>
> -       if (otx_epvf->chip_gen =3D=3D OTX_EP_CN10XX) {
> +       if (otx_epvf->chip_gen =3D=3D OTX_EP_CN10XX || otx_epvf->chip_gen=
 =3D=3D OTX_EP_CN20XX) {
>                 eth_dev->rx_pkt_burst =3D &cnxk_ep_recv_pkts;
>  #ifdef RTE_ARCH_X86
>                 eth_dev->rx_pkt_burst =3D &cnxk_ep_recv_pkts_sse;
> @@ -338,6 +345,11 @@ otx_ep_chip_specific_setup(struct otx_ep_device *otx=
_epvf)
>                 otx_epvf->chip_id =3D dev_id;
>                 ret =3D cnxk_ep_vf_setup_device(otx_epvf);
>                 break;
> +       case PCI_DEVID_CN20KA_EP_NET_VF:
> +       case PCI_DEVID_CNF20KA_EP_NET_VF:
> +               otx_epvf->chip_id =3D dev_id;
> +               ret =3D cn20k_ep_vf_setup_device(otx_epvf);
> +               break;
>         default:
>                 otx_ep_err("Unsupported device");
>                 ret =3D -EINVAL;
> @@ -384,11 +396,16 @@ otx_epdev_init(struct otx_ep_device *otx_epvf)
>                    otx_epvf->chip_id =3D=3D PCI_DEVID_CNF10KB_EP_NET_VF) =
{
>                 otx_epvf->eth_dev->rx_pkt_burst =3D &cnxk_ep_recv_pkts;
>                 otx_epvf->chip_gen =3D OTX_EP_CN10XX;
> +       } else if (otx_epvf->chip_id =3D=3D PCI_DEVID_CN20KA_EP_NET_VF ||
> +                  otx_epvf->chip_id =3D=3D PCI_DEVID_CNF20KA_EP_NET_VF) =
{
> +               otx_epvf->eth_dev->rx_pkt_burst =3D &cnxk_ep_recv_pkts;
> +               otx_epvf->chip_gen =3D OTX_EP_CN20XX;
>         } else {
>                 otx_ep_err("Invalid chip_id");
>                 ret =3D -EINVAL;
>                 goto setup_fail;
>         }
> +
>         ethdev_queues =3D (uint32_t)(otx_epvf->sriov_info.rings_per_vf);
>         otx_epvf->max_rx_queues =3D ethdev_queues;
>         otx_epvf->max_tx_queues =3D ethdev_queues;
> @@ -407,6 +424,7 @@ otx_ep_dev_configure(struct rte_eth_dev *eth_dev)
>         struct rte_eth_rxmode *rxmode;
>         struct rte_eth_txmode *txmode;
>         struct rte_eth_conf *conf;
> +       int rc;
>
>         conf =3D &data->dev_conf;
>         rxmode =3D &conf->rxmode;
> @@ -417,6 +435,20 @@ otx_ep_dev_configure(struct rte_eth_dev *eth_dev)
>                 return -EINVAL;
>         }
>
> +       if (otx_epvf->chip_gen =3D=3D OTX_EP_CN20XX) {
> +               if (otx_epvf->configured) {
> +                       otx_ep_cn20k_mbox_free_sdp_rings(otx_epvf, 0, tru=
e);
> +                       otx_epvf->configured =3D 0;
> +               }
> +
> +               rc =3D otx_ep_cn20k_mbox_alloc_sdp_rings(otx_epvf, eth_de=
v->data->nb_rx_queues);
> +               if (rc !=3D eth_dev->data->nb_rx_queues) {
> +                       otx_ep_err("Failed to allocate the rings");
> +                       otx_epvf->configured =3D 0;
> +                       return rc;
> +               }
> +       }
> +
>         otx_epvf->fn_list.setup_device_regs(otx_epvf);
>         otx_epvf->fn_list.disable_io_queues(otx_epvf);
>
> @@ -425,6 +457,7 @@ otx_ep_dev_configure(struct rte_eth_dev *eth_dev)
>
>         otx_epvf->rx_offloads =3D rxmode->offloads;
>         otx_epvf->tx_offloads =3D txmode->offloads;
> +       otx_epvf->configured =3D 1;
>
>         return 0;
>  }
> @@ -660,8 +693,11 @@ otx_ep_dev_close(struct rte_eth_dev *eth_dev)
>                 return 0;
>
>         otx_epvf =3D OTX_EP_DEV(eth_dev);
> -       otx_ep_mbox_send_dev_exit(eth_dev);
> -       otx_ep_mbox_uninit(eth_dev);
> +
> +       if (otx_epvf->chip_gen !=3D OTX_EP_CN20XX) {
> +               otx_ep_mbox_send_dev_exit(eth_dev);
> +               otx_ep_mbox_uninit(eth_dev);
> +       }
>         otx_epvf->fn_list.disable_io_queues(otx_epvf);
>         num_queues =3D otx_epvf->nb_rx_queues;
>         for (q_no =3D 0; q_no < num_queues; q_no++) {
> @@ -686,6 +722,14 @@ otx_ep_dev_close(struct rte_eth_dev *eth_dev)
>                 return -EINVAL;
>         }
>
> +       if (otx_epvf->chip_gen =3D=3D OTX_EP_CN20XX) {
> +               if (otx_epvf->configured) {
> +                       otx_ep_cn20k_mbox_free_sdp_rings(otx_epvf, 0, tru=
e);
> +                       otx_epvf->configured =3D 0;
> +               }
> +               otx_ep_cn20k_mbox_uninit(eth_dev);
> +       }
> +
>         return 0;
>  }
>
> @@ -724,8 +768,14 @@ static const struct eth_dev_ops otx_ep_eth_dev_ops =
=3D {
>  static int
>  otx_ep_eth_dev_uninit(struct rte_eth_dev *eth_dev)
>  {
> -       if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY)
> -               otx_ep_mbox_uninit(eth_dev);
> +       struct otx_ep_device *otx_epvf =3D OTX_EP_DEV(eth_dev);
> +
> +       if (rte_eal_process_type() =3D=3D RTE_PROC_PRIMARY) {
> +               if (otx_epvf->chip_gen =3D=3D OTX_EP_CN20XX)
> +                       otx_ep_cn20k_mbox_uninit(eth_dev);
> +               else
> +                       otx_ep_mbox_uninit(eth_dev);
> +       }
>
>         return 0;
>  }
> @@ -835,7 +885,9 @@ otx_ep_eth_dev_init(struct rte_eth_dev *eth_dev)
>             otx_epvf->chip_id =3D=3D PCI_DEVID_CN10KA_EP_NET_VF ||
>             otx_epvf->chip_id =3D=3D PCI_DEVID_CN10KB_EP_NET_VF ||
>             otx_epvf->chip_id =3D=3D PCI_DEVID_CNF10KA_EP_NET_VF ||
> -           otx_epvf->chip_id =3D=3D PCI_DEVID_CNF10KB_EP_NET_VF) {
> +           otx_epvf->chip_id =3D=3D PCI_DEVID_CNF10KB_EP_NET_VF ||
> +           otx_epvf->chip_id =3D=3D PCI_DEVID_CN20KA_EP_NET_VF ||
> +           otx_epvf->chip_id =3D=3D PCI_DEVID_CNF20KA_EP_NET_VF) {
>                 otx_epvf->pkind =3D SDP_OTX2_PKIND_FS0;
>                 otx_ep_info("using pkind %d", otx_epvf->pkind);
>         } else if (otx_epvf->chip_id =3D=3D PCI_DEVID_OCTEONTX_EP_VF) {
> @@ -847,17 +899,28 @@ otx_ep_eth_dev_init(struct rte_eth_dev *eth_dev)
>                 goto exit;
>         }
>
> -       if (otx_ep_mbox_init(eth_dev)) {
> +       if (otx_epvf->chip_gen =3D=3D OTX_EP_CN20XX)
> +               ret =3D otx_ep_cn20k_mbox_init(eth_dev);
> +       else
> +               ret =3D otx_ep_mbox_init(eth_dev);
> +
> +       if (ret) {
>                 ret =3D -EINVAL;
>                 goto exit;
>         }
>
> -       if (otx_ep_eth_dev_query_set_vf_mac(eth_dev,
> -                               (struct rte_ether_addr *)&vf_mac_addr)) {
> +       if (otx_epvf->chip_gen =3D=3D OTX_EP_CN20XX) {
> +               ret =3D otx_ep_cn20k_mbox_send_ready(otx_epvf);
> +               if (ret)
> +                       goto exit;
> +       }
> +
> +       if (otx_ep_eth_dev_query_set_vf_mac(eth_dev, (struct rte_ether_ad=
dr *)&vf_mac_addr)) {
>                 otx_ep_err("set mac addr failed");
>                 ret =3D -ENODEV;
>                 goto exit;
>         }
> +
>         rte_ether_addr_copy(&vf_mac_addr, eth_dev->data->mac_addrs);
>
>  exit:
> @@ -893,6 +956,8 @@ static const struct rte_pci_id pci_id_otx_ep_map[] =
=3D {
>         { RTE_PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN10KB_EP_NET_VF=
) },
>         { RTE_PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CNF10KA_EP_NET_V=
F) },
>         { RTE_PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CNF10KB_EP_NET_V=
F) },
> +       { RTE_PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CN20KA_EP_NET_VF=
) },
> +       { RTE_PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_CNF20KA_EP_NET_V=
F) },
>         { .vendor_id =3D 0, /* sentinel */ }
>  };
>
> @@ -908,4 +973,5 @@ RTE_PMD_REGISTER_PCI_TABLE(net_otx_ep, pci_id_otx_ep_=
map);
>  RTE_PMD_REGISTER_KMOD_DEP(net_otx_ep, "* igb_uio | vfio-pci");
>  RTE_LOG_REGISTER_DEFAULT(otx_net_ep_logtype, NOTICE);
>  RTE_PMD_REGISTER_PARAM_STRING(net_otx_ep,
> -                             OTX_ISM_ENABLE "=3D<0|1>");
> +                             OTX_ISM_ENABLE "=3D<0|1> "
> +                             OTX_MAX_RINGS "=3D<1-8>");
> diff --git a/drivers/net/octeon_ep/otx_ep_mbox.c b/drivers/net/octeon_ep/=
otx_ep_mbox.c
> index 5e6be29a96..47aec5f7a2 100644
> --- a/drivers/net/octeon_ep/otx_ep_mbox.c
> +++ b/drivers/net/octeon_ep/otx_ep_mbox.c
> @@ -10,6 +10,8 @@
>  #include "otx_ep_vf.h"
>  #include "otx2_ep_vf.h"
>  #include "cnxk_ep_vf.h"
> +#include "cn20k_ep_mbox.h"
> +#include "cn20k_ep_vf.h"
>  #include "otx_ep_mbox.h"
>
>  /*
> @@ -95,7 +97,11 @@ otx_ep_send_mbox_cmd(struct otx_ep_device *otx_ep,
>                 rte_spinlock_unlock(&otx_ep->mbox_lock);
>                 return -EOPNOTSUPP;
>         }
> -       ret =3D __otx_ep_send_mbox_cmd(otx_ep, cmd, rsp);
> +
> +       if (otx_ep->chip_gen =3D=3D OTX_EP_CN20XX)
> +               ret =3D otx_ep_cn20k_mbox_send_cmd(otx_ep, cmd, rsp);
> +       else
> +               ret =3D __otx_ep_send_mbox_cmd(otx_ep, cmd, rsp);
>         rte_spinlock_unlock(&otx_ep->mbox_lock);
>         return ret;
>  }
> @@ -264,8 +270,12 @@ int otx_ep_mbox_get_link_info(struct rte_eth_dev *et=
h_dev,
>         struct otx_ep_device *otx_ep =3D
>                 (struct otx_ep_device *)(eth_dev)->data->dev_private;
>         memset(&link_info, 0, sizeof(struct otx_ep_iface_link_info));
> -       ret =3D otx_ep_mbox_bulk_read(otx_ep, OTX_EP_MBOX_CMD_GET_LINK_IN=
FO,
> -                                     (uint8_t *)&link_info, (int32_t *)&=
size);
> +       if (otx_ep->chip_gen =3D=3D OTX_EP_CN20XX)
> +               ret =3D otx_ep_cn20k_mbox_bulk_read(otx_ep, OTX_EP_MBOX_C=
MD_GET_LINK_INFO,
> +                                                 (uint8_t *)&link_info, =
sizeof(link_info), &size);
> +       else
> +               ret =3D otx_ep_mbox_bulk_read(otx_ep, OTX_EP_MBOX_CMD_GET=
_LINK_INFO,
> +                                           (uint8_t *)&link_info, (int32=
_t *)&size);
>         if (ret) {
>                 otx_ep_err("Get link info failed");
>                 return ret;
> diff --git a/drivers/net/octeon_ep/otx_ep_rxtx.c b/drivers/net/octeon_ep/=
otx_ep_rxtx.c
> index 09ed3c8da0..a21764868d 100644
> --- a/drivers/net/octeon_ep/otx_ep_rxtx.c
> +++ b/drivers/net/octeon_ep/otx_ep_rxtx.c
> @@ -378,6 +378,9 @@ otx_ep_init_droq(struct otx_ep_device *otx_ep, uint32=
_t q_no,
>
>         otx_ep->io_qmask.oq |=3D (1ull << q_no);
>
> +       if (otx_ep->chip_gen =3D=3D OTX_EP_CN20XX)
> +               droq->chip_gen =3D OTX_EP_CN20XX;
> +
>         return 0;
>
>  init_droq_fail:
> --
> 2.34.1
>
