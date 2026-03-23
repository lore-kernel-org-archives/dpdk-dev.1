Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0518EFC72D2
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 23:52:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC8424060C;
	Tue, 24 Mar 2026 00:52:01 +0100 (CET)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 7C013402D6
 for <dev@dpdk.org>; Tue, 24 Mar 2026 00:51:59 +0100 (CET)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so993574eec.1
 for <dev@dpdk.org>; Mon, 23 Mar 2026 16:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774309918;
 x=1774914718; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vptaMOqWtlJZ0zEU7Y69YwLMaL+ws0mm70Saa91kqgc=;
 b=dKM3mWAbz3c+nWXdmKJSG3R7DEifoTHuqHElEjZUwPVYtSs39x1rLSoK0TiKpcnxn+
 GN4T26q5CDT1cfpRDY5alH4wyyJecmBkRw1RvVH1INsD+fHMCbl/F6DlAssvIifgJ3sG
 NORGiMbdHPHQ99sBLj6oqTnag7yrGw+VQSEQMXu/42xkF6rGdHzmDzE2RRRQeAAjiTtQ
 zyamwC45czQBc/GPpcuvhgnYARg95V3pq2R3n51uynWU50Xsl7Hhwoc7mLajHuvuMZr8
 gBgHlq5iahHcHHFOQDwpxeCj8+dgqXwXcexw3l0eHUXmTnDCvK1y9dsmRM8ltLT63Dgo
 n/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774309918; x=1774914718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vptaMOqWtlJZ0zEU7Y69YwLMaL+ws0mm70Saa91kqgc=;
 b=pGxBSeD/WFx8msYS58kJnEfAIoiX7YyyXmbd3pwH3IJxZPc46QsoMGnEN6ZMkt2WAu
 gpJZdcmIlHaOBA5E4zdaiCyKmvxOGmej8Vq422QKS5bHVx5JrxNjaa44OWawyiVLx+W+
 EYu7B/+6D0JmkdBMmVJvwVkCOosaxbjfpHc6CLMAl0f4FCcSvKdplA83SWF9QZyjTjSV
 CBLovHeZF21Mmu3XInTof7jcizrgRDXgyTPzMcTzntZlrl/c5hvxW7r7x7oVR5lxuwF2
 8K0rF+6OtktPNF81VoDIUDCJ6dA7V7sRKHAb+7HwfqL9fz86/Wk0otAinQNl2rBcbIeI
 0rDA==
X-Gm-Message-State: AOJu0Yzq4uwiWroapalOeSHtmv44W1xMN1UJbZH26PHewGqivOtyZcQw
 4xWny6s0uJAl5cBxDEuLlHxyVwasDO5lkatrejyEC+qUxAHy90ymJjkeLpVUxXEANZg=
X-Gm-Gg: ATEYQzyeSfycCn1cITvw1EasR+7gZ454XILT6MIBJVlZH+UVrpzxa+LZhMGXHNSsdk6
 my1+8JW+5TjqRDUWnV8o8BdfzBmuLFdPFMnYrSTLN/IWbeP2XKRf88iQmA7/zBT6kyHXnICpzFI
 TqVN9L6yh6LJFLHi6xs51fiigaV6OJ4fN6/4e5GtsAvN1XCDbQUquONItm8oa3H8DkYHDw462AW
 32GKNe+UBMtbsuOH5EPxHGUosc32H4Ni2JmwmbGdXrc9hIJ2rXThkZJN6IrE+C+dVYU2eMP+arx
 PdJCCqPf+GiCXJITAVAh8Thw7650Pi5atcRrs2Xdo+uOXbKBcZKF7m5o1R0A18g/fQmfut3ySSq
 mrTXigul+l8Ro/OWkjF7W2RQt9TL8RU0A3I5IPN/tV78hQBvlF/sD4WJyV0Q6LE4po46je1l8fZ
 CRJyTSOKN2fXDCWT2TXtPBc03apy0IOf8T4Mg=
X-Received: by 2002:a05:7301:4586:b0:2be:e8d:a34 with SMTP id
 5a478bee46e88-2c10974f271mr6691741eec.17.1774309918493; 
 Mon, 23 Mar 2026 16:51:58 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29c941sm13488061eec.15.2026.03.23.16.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 16:51:58 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:51:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: KAVYA AV <kavyax.a.v@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com,
 vladimir.medvedkin@intel.com, shaiq.wani@intel.com, stable@dpdk.org
Subject: Re: [PATCH v2] app/testpmd: fix DCB queue allocation for VMDq devices
Message-ID: <20260323165155.7f7d7bd9@phoenix.local>
In-Reply-To: <20260316055255.2134834-1-kavyax.a.v@intel.com>
References: <20260313101553.1827216-1-kavyax.a.v@intel.com>
 <20260316055255.2134834-1-kavyax.a.v@intel.com>
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

On Mon, 16 Mar 2026 05:52:55 +0000
KAVYA AV <kavyax.a.v@intel.com> wrote:

> When using DCB mode with VT disabled and requesting more queues than
> traffic classes (e.g., rxq=3D64 with 8 TCs), testpmd crashes with null
> pointer errors because it artificially limits queue allocation to
> num_tcs.
>=20
> For VMDq devices, use device-specific queue count (nb_rx_queues/
> nb_tx_queues) instead of limiting to num_tcs. This allows VMDq devices
> to utilize their full queue capacity while maintaining compatibility
> with non VMDq devices.
>=20
> Fixes null pointer dereference when queue structures are accessed
> beyond the allocated range.
>=20
> Fixes: 2169699b15fc ("app/testpmd: add queue restriction in DCB command")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: KAVYA AV <kavyax.a.v@intel.com>
> ---

It makes sense to do this but AI review raised a number of issues:


Error: Wrong field =E2=80=94 nb_rx_queues reflects the previous configure, =
not the device's DCB queue capacity

The patch changes the vmdq_pool_base > 0 path from num_tcs to dev_info.nb_r=
x_queues / dev_info.nb_tx_queues. However, dev_info.nb_rx_queues is the con=
figured queue count from the rte_eth_dev_configure() call that happened ear=
lier in this same function (line 4413: rte_eth_dev_configure(pid, nb_rxq, n=
b_rxq, &port_conf)). So dev_info.nb_rx_queues just reflects whatever nb_rxq=
 was before entering this block =E2=80=94 it is not the device's inherent D=
CB queue capacity.

If nb_rxq was previously set to 64 by the user (rxq=3D64), then after confi=
gure dev_info.nb_rx_queues will be 64, and this code sets nb_rxq =3D 64 =E2=
=80=94 which is circular. It does avoid the crash from using num_tcs (which=
 could be too small), but it doesn't set the queue count to a value derived=
 from the device's VMDq/DCB capability. Compare with the DCB_VT_ENABLED bra=
nch just above, which uses dev_info.nb_rx_queues only when max_vfs > 0 beca=
use the VF driver legitimately constrains nb_rx_queues during configure.

For the VT_DISABLED + vmdq_pool_base > 0 case, the intent is to limit queue=
s to those available to the PF (since VMDq pools consume some). The origina=
l num_tcs was an approximation; nb_rx_queues is another approximation that =
happens to be the user's requested count echoed back. Consider whether the =
correct value should be derived from vmdq_queue_base or vmdq_queue_num fiel=
ds instead, which describe the actual PF/VMDq queue layout.

Warning: Comment is misleading

The added comment says "Use device queue counts to prevent null pointer err=
ors" but dev_info.nb_rx_queues is the configured count, not a device-intrin=
sic limit. The comment should describe why this value is appropriate for th=
e VMDq-with-pool-base case.
