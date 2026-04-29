Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3850BFF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 15:13:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECA6340666;
	Wed, 29 Apr 2026 17:13:03 +0200 (CEST)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54]) by mails.dpdk.org (Postfix) with ESMTP id C746E40151
 for <dev@dpdk.org>; Wed, 29 Apr 2026 17:13:01 +0200 (CEST)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-40ede943bf0so8784079fac.2
 for <dev@dpdk.org>; Wed, 29 Apr 2026 08:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777475581;
 x=1778080381; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5H+yx/G+ecote8rYI5XhBhYycsLlMNN2O8ddiu5LSyQ=;
 b=tX6iK2ZKYhiAJPq5oWd8RXzFmnk6QRJY+Eb38L2fNfBnkEzG2O5r67DLPFC4aJSDAG
 kIQQVuu/1b9yVrgbE7Ze737GPkp/aZ7/5hPRX12jkCvYv56QqsNC1oNz3qiOzmMRyz+d
 laPYbHHo/dmPqqkExdkicLsGlqYuJl0olOozP0cGV41cSFeqXpDbB9T0t57yGuEkIHrg
 9R/xX2Jh/ypPCKyPcgZXrLd4KRC2Bhz1itaJs350hOYmu2Q3fz09Nt2SJ22EMjgtTuDs
 4sLd8VtMAjXydeKjQEuTirqybl20PoEaH3K5Qi7d9EKh9oftBaXdzNAf7jeyt25VJHaJ
 8qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777475581; x=1778080381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5H+yx/G+ecote8rYI5XhBhYycsLlMNN2O8ddiu5LSyQ=;
 b=m+m2kvFwfDQxyxzK82QtPWxx5QWBxFTP0kskEtRnbcoGO4Zwc6lqzy42WzTBiuFBQ7
 dhMqdaznEvCkrhcoHoo9MgH5zRlaO0QdcHcKkiIFtf8fglgBpruKuk0xq7XbXd3sUR5y
 c6wYmV+SXVaPup0Aq2gzvqbwMERObzVHsbu/qtj7KdizkloFkbVFATHg5opfztkyw6bL
 nx4IFIIi361a7t2FFNGRhHdKSLmmwMX8bosk9U1xt/3nyYUjed274nX9/utwcF7nV5+O
 3jIHRWCshccifGlUj/wtmWpjHUhbe8xrGY7dFhd9gzAfqegyXsJj/7nkc1cBrJpT2yNE
 i+lA==
X-Gm-Message-State: AOJu0YzAr2HqhPlcXnmaPl/lDM8A4vCDRatUVL+xOm0sx0SzoEOT+DZD
 iQb8PX5+vPVy+j5F5aIfcIlVStQ55j848wWZIKgXTHWnRjvfCrdySZjfe8CgZ0Ro9E8=
X-Gm-Gg: AeBDietAnU0fAPedS0PX995EUqUMGXhMsTggwQGnWkoKuKemsZ++gJLkxBcNEuo50Pm
 zyKZbj9iEn1u20GRF67O6U/gVOh+nmYsMJY61kBJw0H+kLRqlfvIPd7NGTrkeYNOEe7qK5ni0ic
 AUAuzeC9/ZP45PGWwXN6zjsWFS/8CS9c4XOn1Kk4DRaOiUq8opfTWM/1U3AQzEUNzT8hX5Mu8jE
 Fm9XhGl6aB87RlI6+T1qSfe1suC+ZEDxCn3JM76DWa8O2m+uPNzKFpliHTqrBC58Nok3uFOZXQb
 il1ThtILJquJqN/9tWDIwT524qnTqHZlSlInt6tQ5hkebJSnDhGwI/E+buwB7E+Uk1YtvrbLu/4
 Tclbx3fjCwQvR+kbrKXCwTmF3dKhQ95u3xTk96u/EFwAAULk5D8XHGHoZd8cvD6uqr4re/EUiEt
 X69VGsZw62e2TfOsU0OcXss+BUqqdlMTFy+VXOGKEEwuir1A==
X-Received: by 2002:a05:6871:e809:b0:42c:1b45:e8c3 with SMTP id
 586e51a60fabf-433f3ab0685mr4600014fac.33.1777475580742; 
 Wed, 29 Apr 2026 08:13:00 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340e981839sm2161537fac.13.2026.04.29.08.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:13:00 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:10:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 08/20] net/txgbe: fix link flow control registers for
 Amber-Lite
Message-ID: <20260429081037.23d4dd63@phoenix.local>
In-Reply-To: <20260429102515.58880-9-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-1-zaiyuwang@trustnetic.com>
 <20260429102515.58880-9-zaiyuwang@trustnetic.com>
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

On Wed, 29 Apr 2026 18:25:02 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> The flow control counter registers on AML NICs differ from those on SP
> NICs. Update the register offsets accordingly to ensure the counters
> work correctly.
>=20
> Fixes: fb6eb170dfa2 ("net/txgbe: add basic link configuration for Amber-L=
ite")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
> ---

AI review warning:

Warning: txgbe_ethdev.c, in the AML branch added in txgbe_read_stats_regist=
ers(), uses assignment instead of accumulation:

=EF=BF=BC
if (hw->mac.type =3D=3D txgbe_mac_aml || hw->mac.type =3D=3D txgbe_mac_aml4=
0) {
	hw_stats->rx_xon_packets =3D rd32(hw, TXGBE_PBRXLNKXON_AML);
	hw_stats->rx_xoff_packets =3D rd32(hw, TXGBE_PBRXLNKXOFF_AML);
} else {
	hw_stats->rx_xon_packets +=3D rd32(hw, TXGBE_PBRXLNKXON);
The AML registers are write-clearable (cleared with wr32(reg, 0) in txgbe_c=
lear_hw_cntrs) rather than read-on-clear. Reads return the absolute count f=
rom the hardware. txgbe_dev_stats_reset() zeros hw_stats but does not clear=
 the hardware register, so on the next stats_get() the counters will jump b=
ack to the absolute hardware value rather than restarting from zero. The AM=
L path needs the same offset-tracking pattern that UPDATE_QP_COUNTER_32bit =
uses (or the AML registers need to be cleared in stats_reset).

