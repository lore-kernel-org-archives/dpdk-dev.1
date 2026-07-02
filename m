Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15DBC43327
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Jul 2026 18:34:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93AF6402D1;
	Thu,  2 Jul 2026 20:34:16 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 377C140041
 for <dev@dpdk.org>; Thu,  2 Jul 2026 20:34:15 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8266D140007C;
 Thu,  2 Jul 2026 14:34:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 02 Jul 2026 14:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783017254;
 x=1783103654; bh=dOgSKc7gITe2BLQrv30p8qCb04MHcam18ebYh9jrv7I=; b=
 Xo49uGs055CWa6jm6bYaZGpGPh3L+NyTneE1pAsnKAyRbNFk1BGDw3P/aC1ZExx0
 y3g+u62B/cO4jyXLgMphkV+4jIgMvqn/MFUkWBtf1Woo9HWT+BDvYwYEVs7+TLy8
 VQ2rsnTMKmIq+SdX4m3KhfRaHC9SNZzDs20/pPWxCgZFIh8KcST/rznhN1nQdFVa
 atou41hGe4E3kyLgafdYTzOACG1j5AO9o3AkiMsJkB97NVIlcKSS4b0chNLOlchI
 0gcvIK2cgFTdD3Y140rsHFePM5kTiTUv+ZmNySsA2lKmjWwMOc/D8Zdonq0SMffv
 3WOmIdGmqmj8Ye0junMPMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783017254; x=
 1783103654; bh=dOgSKc7gITe2BLQrv30p8qCb04MHcam18ebYh9jrv7I=; b=F
 sOPcPZp+5SQrAo954kuK7sr1BbdGhxCvkB+XSGsgk0P+gz+vhpeqN5JfJnnYS+0r
 +U8JXNvi7eqJugx2f2BQhc8V0vlDDU9tu/3JSG2UOy9wNi/9wdA3r3lLhl6dzbuO
 qHVuuIk9b/2CaBZxOxYfBJ3MatSBqMMNIy/K6i2trUEGFMLW+sRd1UnW3NZFhlJ4
 yCTuh9HLvVe+y5HBscrwzFT5S0CQZrK5/MY2u9FvDH89/TdU1sdxohy8zQ7uB/s5
 xr16YfPN4DnvzmK5H/gImnwjGeiMvB29lJ8ao4Mm4oE0D6OE5jmYARKjwRQvZ5Ox
 FA5UYPCu/4r/BxmH2xGNA==
X-ME-Sender: <xms:Jq9Gat-gQrongGOmnolLJsE_G_7Kcjw99sdLJZkhu8GaEeGEG9INlg>
 <xme:Jq9Gah1aDOXwp7XXHqBRa3xgRKnBcspbhSWtcWNERE4JsUpVEAWfq1Q2h_WR4WeXz
 um01XOIlA8hivVN5O0wr3krYAkv8qlENFIaTx5FuTVUyVqOlGXnzQ>
X-ME-Received: <xmr:Jq9Gai92x0Vrai8yEoI-_2f5gPXgQaMqtErIZp6aQ4z6ihN8KpVVeJgb_eBsTF-_VGmDjUWvtx1nNdDC43rkZmzqUA>
X-ME-Proxy-Cause: dmFkZTGsZNkd3LuFdtFSuXoCLtOJ+VXA+9DxvxCfZzwfge+OluHjVwV+atUevbhdROvW/a
 QRjeZriryZgFFz0VYwQpvRVPfEEEALbhNYeWGXO/aT7pQTIdJCsV3PS7CpYWdIPQ9oaA8X
 TlVAj8QkMy1Uq1cS6gHMo8Vjtk1vf/CqHv/pVELvmIBwMa/EDxjrAo5VrDvG+4pYU8E63Y
 4ARCPos8QC/aIkAQymMhusr/+JfL5bzhulD0zbgcgjrIF/rxILWP+IJvNKeUJxXpeVVlrP
 fs3sSHuMdD/jxyD16waADy86Oc8uqqxMzx3fAKXYYmwDTHs56bl6U+nSIGrzGCyWsoXlbS
 oX5+R9GX4QbJJUlg2SohlMaAvNaFVkUbM5mkoGYzrGf8bzkh/IBkuo3AzgVCF0HQld8Ece
 td9LTd3QSm71k34dm1LSNz4+FTAqvQDySn0CvfnMn0dho8NNr3A9sYRNj5LrHnMuLZc6rP
 C53ZhhK1Hy8EyJoB7q/fD8mnp0/FyJmDWHk/xwszb8yvlP8s8xaSd0Yzc94MLBWRa307sU
 H1SSgjYajXsHteEcpFauEiXzgucB9txEmq4gVx2rnfYNsZqx57B6sWZRzD5cqsCbVSst4H
 tQy658RD1PjFWq7FMk8Acz/rTZY30uJZMhg+4CtLyTU0kHq/r3h73hGwcySw
X-ME-Proxy: <xmx:Jq9GaptMngK-ZCU_c8S5RiDT_h92_K3wXi9mqNJUDu03vROCBjs1KA>
 <xmx:Jq9GatDtB81B4j9hrACO8E6lS8R8jZbMv8IpIHNLz183v7XRUgrUFg>
 <xmx:Jq9GapUv6eB8JD7GRaVrY0R-0Ln_bsjJcgyjqgrkYW7KE8v3IZTyLA>
 <xmx:Jq9GajBWpgSvbD86V9xFP7I1tvZcseP5cplG3-zy5g2Hn4wW1zbBjA>
 <xmx:Jq9Gah_i_K9Rck7wixVzpWSD9Kq00H6qH5kgebpf6fmSUECPu22U6gc5>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 14:34:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Emma Finn <emma.finn@intel.com>
Cc: Kai Ji <kai.ji@intel.com>, dev@dpdk.org, gakhil@marvell.com
Subject: Re: [v1] crypto/qat: fix IPsec MB header include for ARM
Date: Thu, 02 Jul 2026 20:34:11 +0200
Message-ID: <DqaxNFu5T2S8ms6IzYcdAg@monjalon.net>
In-Reply-To: <20260630100105.2330637-1-emma.finn@intel.com>
References: <20260630100105.2330637-1-emma.finn@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

30/06/2026 12:01, Emma Finn:
> Update the header file to always include the platform-specific
> IPsec MB header.
> 
> Fixes: 03c475d609eb ("crypto/qat: require IPsec MB for HMAC precomputes")
> 
> Reported-by: Thomas Monjalon <thomas@monjalon.net>
> Signed-off-by: Emma Finn <emma.finn@intel.com>

It solves the previous error, but there is another one:
build-arm64-generic-gcc/../../dpdk/drivers/crypto/qat/qat_sym.h:187:
undefined reference to `des_cfb_one'

It seems des_cfb_one() is not supported on Arm.


