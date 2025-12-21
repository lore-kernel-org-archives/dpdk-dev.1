Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E70E66886
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Dec 2025 16:51:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E19C40296;
	Sun, 21 Dec 2025 17:51:05 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 8C48D4025F
 for <dev@dpdk.org>; Sun, 21 Dec 2025 17:51:03 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so22497125e9.0
 for <dev@dpdk.org>; Sun, 21 Dec 2025 08:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766335863;
 x=1766940663; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuU+zC3vjQ8+VUCLSaUNb1UVVJ1g+rXm9leeQvPGRzY=;
 b=bXZiyFakb/GE72TrUmm0/FdOpPDSCWo3gOz71TUQtNeZZ5gi+jVdLCBq1w4XU3dCQS
 70544q6vFl6EpJZgXlrdtLwQXSS293M7PB0RJE9XiXvZNz/LoIMNFzCNGV5GmwJlrMI4
 EGWUiUjkr0jWqNFOVpJRtGlUJkikz9FLb5CGB7xOfw+hOxMDkDRD9yqkWskQRCRapJQS
 adn5cQuSM5YL7uPweN0IN4CGrqRH9tZaZMn0dlkmFyrrsbbtYAWNOd+jMyKvkOI4IXPe
 nAMWnArq/CIaK9SOFHWEQlWvPbjI+U/zAryzqyxvacPDxEnNx2IHNAAyYLCpllGyteJR
 g2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766335863; x=1766940663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VuU+zC3vjQ8+VUCLSaUNb1UVVJ1g+rXm9leeQvPGRzY=;
 b=CM67pVY4hBA4Y5M/M1cDGE5M/mML75D4P1UZaL6UCqbNBBy0/UT8da3BK/6KY5Wbuk
 PvhNlxCgY8L0/od2Q0z/zjUuWm2uCbKyIcRSpFOs9ficUY+cwfqBaBcMoo/AdTrrxC0i
 XN7LpsQMmN3IvruQjl8poEXVOYWGYhBwWt2itayENikZjGpo0P70Q/288wuoLG3gvSA6
 syknCgRzO8kvg7UtWrikLIs7RgoOcfSTDzuwKbtqyNcDVfwmDgNenEIaM5jjd+aO8w6B
 /sNoNppx1eZa2gBWMzfYex/Hq3QQzfci1ywO1zmn2nLFcFKb9/0lpDetafCtIncyIZrp
 1ohA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlI3BkfTnEtjM0gi8+kWKk3pCAkguEeZL0MPvqwkaq4axGdz2jmT811+d9afoDZD2owyc=@dpdk.org
X-Gm-Message-State: AOJu0YwDygzAZG8Xw/r/evFqPZ1E4GX8lWFqS1P3D0m0SCUYO2U3zVZD
 bozMG9OZWYXX0E10dBWkX9kStxT8kqWEoPx6BjpbxV40BKRtJWwymDAL6CBOoBV8ukQ=
X-Gm-Gg: AY/fxX7M2zE3odnL0r70YVS/eJGooNNW/wE/1h729XNO19VbfmRo2uosBFYpuEKqIIx
 V/c1tcXrxkKSVc0x+d9+Bi1heTCbURbi+tshiSY7AIpExsFpXvn6N0x02mbNcKrkNaBSN98pFzF
 J+3G0VSVS8++AyN4JfbPNuUZ/iCLglkAZRgIJ5lxziZoiyuSRehTrXt4viFalG9jY/IF+6wzca2
 E0e/0XBS+siyu8oL5OT59GU73OaNANSFOCL3zDof/NcvQQl2gtrcmeTbYEw5rSz91dRn8k5hqbt
 5obzhajXf2464ky6ElzGJUamo4w1+E0h4dqleKbpzDdJRIkuSaYlLiWigTgiRj5XKk/YAGLiYxn
 ZsEWvjrQoEkFr5Y6cjJJ4igHym5xLeIdYywDVI1byeUjH7Ny+r5cojovZToEdOFFW2nEBrAYpe+
 cNYZZxO+SsgidiX0TIX6EN2WzR+KGdZJE1kM32LQz9UI4R82a/epgY
X-Google-Smtp-Source: AGHT+IGFYjHUYxLHhZIekgJImh2H6R1sF2DkIzpQPVuLRtsEV9MoXp25VGnmpCRmjtqN0Wub4ZZc7Q==
X-Received: by 2002:a05:600c:c16f:b0:47a:810f:1d06 with SMTP id
 5b1f17b1804b1-47d1953bb06mr79214235e9.4.1766335861824; 
 Sun, 21 Dec 2025 08:51:01 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325dbc522esm6671905f8f.11.2025.12.21.08.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 08:51:01 -0800 (PST)
Date: Sun, 21 Dec 2025 08:50:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rakesh Kudurumalla <rkudurumalla@marvell.com>
Cc: Jie Hai <haijie1@huawei.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <ndabilpuram@marvell.com>
Subject: Re: [PATCH v2 1/1] net: fix inner L2 length for GRE and NVGRE
Message-ID: <20251221085055.7a205117@phoenix.local>
In-Reply-To: <20251218090932.1767124-1-rkudurumalla@marvell.com>
References: <20251029130523.1642847-1-rkudurumalla@marvell.com>
 <20251218090932.1767124-1-rkudurumalla@marvell.com>
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

On Thu, 18 Dec 2025 14:39:32 +0530
Rakesh Kudurumalla <rkudurumalla@marvell.com> wrote:

> Inner l2 length needs to be updated to include GRE and NVGRE
> headers. Not updating this would cause failures for applications
> which would be expecting l2_len field to be valid for
> inner checksum offload cases.
> 
> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
> 
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
> ---
> 
> V2: update innner l2 length based of GRE header flags
> for key, sequence and checksum
> 
>  lib/net/rte_net.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
> index c70b57fdc0..a24a0db526 100644
> --- a/lib/net/rte_net.c
> +++ b/lib/net/rte_net.c
> @@ -480,6 +480,19 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
>  			return pkt_type;
>  
>  		pkt_type |= ptype_tunnel_without_udp(&proto, m, &off);
> +		if ((pkt_type & RTE_PTYPE_TUNNEL_MASK) == RTE_PTYPE_TUNNEL_GRE ||
> +		    (pkt_type & RTE_PTYPE_TUNNEL_MASK) == RTE_PTYPE_TUNNEL_NVGRE) {
> +			const struct rte_gre_hdr *gh;
> +
> +			gh = rte_pktmbuf_read(m, prev_off, sizeof(*gh), NULL);

This looks wrong. rte_pktmbuf_read() is intended to handle non-contiguous data
and you should pass a temporary header buffer for it to use.

Or if you can verify that the header is in first mbuf and does not span
segments, then just use rte_pktmbuf_mtod_offset.
