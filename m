Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63039CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 16:10:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B614402D6;
	Fri,  7 Nov 2025 17:10:30 +0100 (CET)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 8B8A44021F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 17:10:29 +0100 (CET)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-7a9cdf62d31so1212265b3a.3
 for <dev@dpdk.org>; Fri, 07 Nov 2025 08:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762531828;
 x=1763136628; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCoDZX01aXifV7afnHKdZpKwB5V2fKhUEJFcDEb+Xvw=;
 b=VGefddwX88flWsTEGVCBHOB19Y8Pff/ThkratE3hGs6oFyiXdymMdohRAgoWb8V9/z
 3szp5SLN3WPFtcs6wdX+qZYS3r94LOe8IJq/CJfCe1EtSdgYXN/0MF5FbbHrjcCbF/9+
 Sr7Ju2Xjjn7AdPA6IbHJiuTqXKokJnk6k/tlKtnEZAf6v4n52bwibujhQlARhcbrVKCs
 1mTcJXWUki3KouhzTkP1iY5d/TVoqVCeAaU4EMFiv4wrKvTqsOnN1RQ0z+mTfVpK9YJL
 X9wtDp3ZYbfR1eM/rkkzlnILuth4JEaOWRaJK3g8oU4H+ZS5BSzgocBt7+siKzGELa3g
 7jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531829; x=1763136629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WCoDZX01aXifV7afnHKdZpKwB5V2fKhUEJFcDEb+Xvw=;
 b=AHlmfwL4X5mojbqqIlO6e1455BmqeFGMnTAfvIo9cQLC2dZ6VB8ipEuW3lI4/Zhzz3
 KJdG9F+gLO3TtPzfD766aZvmhscqmM9WsD3GC6VvM+GSC4Tbl6SRaRI88dm6G2GLbayU
 vQmXbfrewgM4AWaleh8TX9T+h7xbQm2o2jhwZuYReeJmSkeoXri4YcrTK1TPuPinqW5R
 NmMll42gl3Lzj0LoVO/j+yN97QeQCtmTFftWby7j4R9xNAznFWuXPvcmVHONGHZ/uUnC
 +MFVCS4gIFCJUE1guPGioIY8W6IfGgT7o/v5OgyLnx3W1bAW3P/huGWrKHR7uOvaKzmT
 bOAQ==
X-Gm-Message-State: AOJu0YxidB22nQJ0yW3nFDTOwPagnSRUm8xJP+TyZxj3MFq9nWsvh/GG
 1nHLd8PdxXGGpowBrrBXvKf242lVzz/cVzyayqdEDuWeGHcdpnPfaAbxxwXm+cuIx9Y=
X-Gm-Gg: ASbGncsh5O3Q7mfGo3qDiVrGXSLc5NFx6mm4ASHVyCEp3s3i0/6VVOQ5n24PTdJRFjz
 Raoz4gTJQGiQxzlZhRWjhSMJpCuDgeb08dC48/k1pr109IKbfiGGUwPFkNw6KKfjunE3dVKjB+N
 ML9ZldEikb1rjyddHoEpAE3J/84LQrkcZJLPjPFunDZi/kuJEMSw/eMdvCFVeEssuSclWTPvYp/
 V9SHNLJ0GGcFIUkMCsow0ggYatxCqoOg44B1901wOqlFKQl/DiuuFaYxZsCtTfTvWITp1WMkwsl
 hFv1r/OPzxgMjPkxA6zGpanXEHK4AUTLNZquwqW4T8Ylg7lvLzszkRqDl2mX2mlfD0y0LYnZMJk
 L+4jpalFYQvRe7Mukwv42ffK4lieVDQknr9VSiBm0FgzLYuCKMUz2wv5k6+OSiKc5KPUSyZ86hb
 iB0Np5XfLD0g+klWbeD71XAaNlAnokAFvuaQ==
X-Google-Smtp-Source: AGHT+IHmgliFuZq/xO8uPeKxcKSbvgIvTLNAa3NKJXrzm5+NKJ352OCcdYnSdy5DRtstFbHfvEqf8g==
X-Received: by 2002:a05:6a20:a10b:b0:342:a261:e2bc with SMTP id
 adf61e73a8af0-352292468efmr5765215637.10.1762531828617; 
 Fri, 07 Nov 2025 08:10:28 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba8ffe36bbasm5615322a12.18.2025.11.07.08.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 08:10:28 -0800 (PST)
Date: Fri, 7 Nov 2025 08:10:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Alvin Wang <alvin.wang@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 2/4] net/nbl: add support for Tx and Rx VLAN offload
Message-ID: <20251107081026.0fda595b@phoenix>
In-Reply-To: <20251107073459.3532524-3-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
 <20251107073459.3532524-3-dimon.zhao@nebula-matrix.com>
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

On Thu,  6 Nov 2025 23:34:57 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +static inline void nbl_res_txrx_vlan_insert_out_mbuf(struct rte_mbuf *tx_pkt,
> +						     union nbl_tx_extend_head *u,
> +						     u16 vlan_proto, u16 vlan_tci)
> +{
> +	struct rte_vlan_hdr *vlan_hdr;
> +	struct rte_ether_hdr *ether_hdr;
> +
> +	ether_hdr = (struct rte_ether_hdr *)((u8 *)u + sizeof(struct nbl_tx_ehdr_leonis));
> +	rte_memcpy(ether_hdr, rte_pktmbuf_mtod(tx_pkt, u8 *), sizeof(struct rte_ether_hdr));
> +
> +	vlan_hdr = (struct rte_vlan_hdr *)(ether_hdr + 1);
> +	vlan_hdr->vlan_tci = rte_cpu_to_be_16(vlan_tci);
> +	vlan_hdr->eth_proto = ether_hdr->ether_type;
> +
> +	ether_hdr->ether_type = rte_cpu_to_be_16(vlan_proto);
> +}
> +

Please do not use rte_memcpy for small fixed size structures.
Prefer:
	rte_ether_addr_copy
	struct assignment
	memcpy

There already is a standard function for vlan insert, could this be used here?
