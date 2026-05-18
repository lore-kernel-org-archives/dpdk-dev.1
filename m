Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E26CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 03:30:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED46A402A7;
	Mon, 18 May 2026 05:30:33 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 4895E40264
 for <dev@dpdk.org>; Mon, 18 May 2026 05:30:33 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1331e851faaso734103c88.1
 for <dev@dpdk.org>; Sun, 17 May 2026 20:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779075032;
 x=1779679832; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRuuvXNyhqX9BaUyff7xauJ4wC2ZIs3fw0lpms4VYds=;
 b=bV2bF9yrluoijvUUlJmVWjQVHNL0TeQ7I+wZaqeR7DvHPFnj24TFWmmNSUHEMAT93+
 W0E4Gb+JI9K+JlRVkZlAMBsinIpsD8lmP7ZALHuvhohHJXCFdlIuMH3FfXp/C6UdWXhd
 NpBsxIozCYlw0Z7XdaL9icaDnqPf8ENMhIgYvstR1QdgsE/4jWm6BtaoiiTxWzFLUdHB
 FbJ9vsLdqUtJB2Vlr7W6ZEscSh0LuZZcNCqXcVivMgBCbLV5aMY1XuZNbNDxDRY4qCTC
 mC6NWnG9m60mXwSLicAcGfFN9mIHlBb4bHR+CK6w50cDYZHeg4gnSV1TWl4hvpC0Zodh
 r8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779075032; x=1779679832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XRuuvXNyhqX9BaUyff7xauJ4wC2ZIs3fw0lpms4VYds=;
 b=sfjd2apjqxM62t6Wz9lgAIB0IzarS8utio+wlApk+1AAZkOcAhEHQ8JNtjj55oIY5Z
 4E0++EmdYKni49ShnWA7AueIteZk3ItcGEAcXSKBk0Ta3R0UomYB7LIMkoyU8DW2Z26B
 Bi9cnFtvPOXPvdSm0WiB2Gh6Mxr/cKKxaE2L6L6KSAr8p0mVwJoR/Sah/CnJoMLR895o
 YdmnMkp+H8hIrwux9sZvBz1Kqba2FRHtkaWthSNTmKty76/ALNHBZj6SU6hl9/xLDNPN
 L088/jnNS7Ybhd8lA+w2oTShi7kGa8FtFWkWR4dUoaRDAOXLqpjw7bdi2CnGOXJe6IMx
 QL9A==
X-Gm-Message-State: AOJu0YxbSJ99Xv0hTW36/N9LZxs9/PNxAjlVjuPSYB9wu4eMnl1pZagU
 OFBhiv2+CAjKdIXJuGSeRX9itWMONAzJZiI/oq/qe1MT5JZc2am7ffknkBufSvElPis=
X-Gm-Gg: Acq92OFwYjTQwAiRIN/RTkd3LTp+3rq0KKSgb0DCcom1CHHoo+byDF8P+C4uAIPZIE1
 hze365ulxn1grvDvh2/Kowk6IIdHqM/zH371KthtXf8/7p+/HbXSLj96NuYZ5m/cH2JTh5dd6Jk
 ZOEAUBneN0TZOFwpWbyyvx11Ykb/vi3CLCqzZ1f+Pe/jjOi92mnEukFpMFZXgpvs1lvTIVhE1IJ
 pAPuonWXpwaS2UA6I8HLQxWxpI4alo33yvyC3oOxKdqg+uKo2/ZWO6ITIK6tlxqiLHJ0VdqhEqA
 V6A5Vte83B146x2HyT5lThqCwfQVytgH00uatZvXMhx2qsfjnavcrCvDDGdi6iaPK7TY6yHdPLW
 DfEP+Pu7yRUX6lUqeVue2UvTYKE9/QxVkrtO/9px/oePjS/jQJjVVtF1g9HZO7KqogUZM8jSnNg
 E6QfzMMDjBD70dd+vuLCx6eo8Eg0KZKPj7KVg=
X-Received: by 2002:a05:7022:43a8:b0:12c:81b:c74b with SMTP id
 a92af1059eb24-134c880b9a3mr7065985c88.1.1779075031686; 
 Sun, 17 May 2026 20:30:31 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbdcf140sm18921519c88.5.2026.05.17.20.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 20:30:31 -0700 (PDT)
Date: Sun, 17 May 2026 20:30:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH v2] net/hns3: fix L4 checksum incorrect for tunnel packets
Message-ID: <20260517203028.0a4e3063@phoenix.local>
In-Reply-To: <20260509064753.3292074-1-yangxingui@huawei.com>
References: <20260509064753.3292074-1-yangxingui@huawei.com>
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

On Sat, 9 May 2026 14:47:53 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> In HIP09 simple BD mode, the driver incorrectly calculates L4_START
> position for tunnel packets. The current implementation only uses
> l2_len + l3_len without considering outer header lengths (outer_l2_len
> and outer_l3_len), causing hardware to calculate checksum from wrong
> offset.
> 
> For a typical NvGRE tunnel packet with structure:
>   Outer Eth(14) + Outer IPv6(40) + NvGRE(8) + Inner Eth(14) +
>   Inner IPv6(40) + TCP(20)
> 
> Expected L4_START: 116 bytes (from packet start to inner TCP header)
> Actual calculation: 62 bytes (missing outer headers)
> 
> This results in incorrect TCP/UDP checksum for all tunnel packets when
> using simple BD mode, including NvGRE, VxLAN, GRE, GENEVE tunnels.
> 
> Fix by adding outer_l2_len and outer_l3_len to L4_START calculation
> when RTE_MBUF_F_TX_TUNNEL_MASK flag is set.
> 
> Fixes: 6393fc0b823c ("net/hns3: simplify hardware checksum offloading")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
>  drivers/net/hns3/hns3_rxtx.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
> index 573604b0cd..4d48cbdc11 100644
> --- a/drivers/net/hns3/hns3_rxtx.c
> +++ b/drivers/net/hns3/hns3_rxtx.c
> @@ -3982,6 +3982,7 @@ hns3_handle_simple_bd(struct hns3_tx_queue *txq, struct hns3_desc *desc,
>  {
>  #define HNS3_TCP_CSUM_OFFSET	16
>  #define HNS3_UDP_CSUM_OFFSET	6
> +	uint32_t l4_start;
>  
>  	/*
>  	 * In HIP09, NIC HW support Tx simple BD mode that the HW will
> @@ -4003,9 +4004,13 @@ hns3_handle_simple_bd(struct hns3_tx_queue *txq, struct hns3_desc *desc,
>  	    ((m->ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_TCP_CKSUM ||
>  	     (m->ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_UDP_CKSUM)) {
>  		/* set checksum start and offset, defined in 2 Bytes */
> +		l4_start = m->l2_len + m->l3_len;

Applied to next-net; moved declaration of l4_start into that basic block.
