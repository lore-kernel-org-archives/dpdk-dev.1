Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FA7E65298
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 19:04:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DBD8402F0;
	Sun,  1 Feb 2026 20:04:12 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 8522240150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 20:04:11 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so3227188f8f.1
 for <dev@dpdk.org>; Sun, 01 Feb 2026 11:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769972651;
 x=1770577451; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqcUT3NbyxjR4p9dzhWI8KSz07ZicwGtQZbQxGZ47bU=;
 b=wK7ICp7QEoI5VwHZ/aoefZQj5QKZat50KB8xZ2oljM8TmRm+eoQg94DE6G0JTO324P
 grGdYHlKiHgdJtSa3UO8EZyYvdGDCJbotZ5PsGmgmlNfbgHQsEhzEU83P0/EIgW5EM7f
 G/OQM8iKBLg34GLhCYIHTTu22Qt9lvx+dWAm+Am+BG49uKTyq57FeUr6hIFkkncSidw4
 Xd261Fj9Ik/625WI0sP7T/2bzyF/ThKUfoOpNzh3bXH9dg8SjzkG6CGNfkE+EWEXByZF
 /gy1+0XJ1BYzTKwmS+qnmpAgUmg3ywcOLgZ/kGfQnuncufl9TtDbe4dntVfVs1UkmVNA
 UiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769972651; x=1770577451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uqcUT3NbyxjR4p9dzhWI8KSz07ZicwGtQZbQxGZ47bU=;
 b=tTlZgw9hJZMKJSODM4hf79Rjj2NHge5cf0nPmoLvA+xLbaIhBKWxlzGDKBjQnRjGiW
 QDNoCAfpyVAaDS+xPqGIQIAEkW8t5QpragM7P00D1WqntuyCDDXzkQZTyVEXcpCd2kmI
 UXNOGmg1HHQO/F29xOiuRTMQsH3TA6JfEROnEU8NpFndAQxDz9BCcfRkjknS28EE+HHD
 bOlKnlCU0C9MMQkINSSnE3MGmvAyGVHFsbQt7qkPrM1b0cu04mTS+SuFZAoQMwZUZldU
 Myy2SiallRzzK/GaMVeh6zNwChxmW/EBknxkUovNo36asWZ1ZHkd3ppiMASnffNannP9
 iNSw==
X-Gm-Message-State: AOJu0YxgWgkBzFUvzwzbvpz0nPxYJuYMtdy4niZ+lrMKHsbWahGHZ6D6
 ddWSkian85b4MCkV4WarnMbwtQuAcpdtVUeK3nptI0T4Aahlhl4uyv4+TXp+y7nlvRI=
X-Gm-Gg: AZuq6aJPWVeHOYezpvm3dzY8Gj5a2ZAUNvsHmv9B3dC/3hoYv9rr/67RA3/M4ua+sj1
 BZMv8bd7RN09DlieOoWJEG371LcA9ae322f8gxCAwPTfKlsnbYGQi1cOJxwYUNt8c+kRAZ9KKqV
 9GijyA2E1jyfkESaAlR2fhwy4DZo90iGn3tRBSHuH2DHbMh2PujVBLw+lJK6rP+HzkTYA2XNR+6
 rKEBKyYtHDygYPf7GPTK+hhOM5zMiHI78ka/HKiH6UP50j3b5ZQhaCSgZs9im8I2nsxpDIXj/zi
 Kqc08a0Zps5YNBpDoFrux2+2XAh8yH8og4ARFL9iUTu44U2kx0+ZhOHtdGZ3Ii7+nGhhyBbVqOP
 cMSMUrg7DmpBiTR6j3Th5xNBfVTgwcc84HhQTifuBBaTkbh1wbnXQFnZoo/j9V50s/PWBGxMk6K
 cf2TH8AppPHuvUvxULAo5Ad7wBuCeW/cT1+ij5C+NLgEkSckvTVsKC
X-Received: by 2002:a05:6000:2388:b0:435:a52e:7758 with SMTP id
 ffacd0b85a97d-435f3ad8627mr14859203f8f.57.1769972651044; 
 Sun, 01 Feb 2026 11:04:11 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1048a54sm36897024f8f.0.2026.02.01.11.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 11:04:10 -0800 (PST)
Date: Sun, 1 Feb 2026 11:04:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, Zijian <zijian.oerv@isrc.iscas.ac.cn>, =?UTF-8?B?U3Rh?=
 =?UTF-8?B?bmlzxYJhdw==?= Kardach <stanislaw.kardach@gmail.com>, Nithin
 Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>
Subject: Re: [PATCH v2] node: lookup with RISC-V vector extension
Message-ID: <20260201110405.0768a904@phoenix.local>
In-Reply-To: <20260201160931.1896432-1-sunyuechi@iscas.ac.cn>
References: <20260201160931.1896432-1-sunyuechi@iscas.ac.cn>
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

On Mon,  2 Feb 2026 00:09:31 +0800
Sun Yuechi <sunyuechi@iscas.ac.cn> wrote:

> +static uint16_t
> +ip4_lookup_node_process_vec(struct rte_graph *graph, struct rte_node *node,
> +			void **objs, uint16_t nb_objs)
> +{
> +	struct rte_mbuf **pkts;
> +	struct rte_lpm *lpm = IP4_LOOKUP_NODE_LPM(node->ctx);
> +	const int dyn = IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx);
> +	rte_edge_t next_index;
> +	void **to_next, **from;
> +	uint16_t last_spec = 0;
> +	uint16_t n_left_from;
> +	uint16_t held = 0;
> +	uint32_t drop_nh;
> +
> +	/* Temporary arrays for batch processing */
> +	uint32_t ips[RVV_MAX_BURST];
> +	uint32_t res[RVV_MAX_BURST];
> +	rte_edge_t next_hops[RVV_MAX_BURST];
> +
> +	/* Speculative next */
> +	next_index = RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;
> +	/* Drop node */
> +	drop_nh = ((uint32_t)RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP) << 16;
> +
> +	pkts = (struct rte_mbuf **)objs;
> +	from = objs;
> +	n_left_from = nb_objs;
> +
> +	/* Get stream for the speculated next node */
> +	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
> +
> +	while (n_left_from > 0) {
> +		rte_edge_t fix_spec = 0;
> +
> +		size_t vl = __riscv_vsetvl_e32m8(RTE_MIN(n_left_from, RVV_MAX_BURST));
> +
> +		/* Extract IP addresses and metadata from current batch */
> +		for (size_t i = 0; i < vl; i++) {
> +			struct rte_ipv4_hdr *ipv4_hdr =
> +				rte_pktmbuf_mtod_offset(pkts[i], struct rte_ipv4_hdr *,
> +						sizeof(struct rte_ether_hdr));
> +			ips[i] = ipv4_hdr->dst_addr;
> +			node_mbuf_priv1(pkts[i], dyn)->cksum = ipv4_hdr->hdr_checksum;
> +			node_mbuf_priv1(pkts[i], dyn)->ttl = ipv4_hdr->time_to_live;
> +		}
> +
> +		/* Perform LPM lookup */
> +		rte_lpm_lookup_vec(lpm, ips, res, vl, drop_nh);
> +
> +		for (size_t i = 0; i < vl; i++) {
> +			/* Update statistics */
> +			if ((res[i] >> 16) == (drop_nh >> 16))
> +				NODE_INCREMENT_XSTAT_ID(node, 0, 1, 1);
> +
> +			/* Extract next hop and next node */
> +			node_mbuf_priv1(pkts[i], dyn)->nh = res[i] & 0xFFFF;
> +			next_hops[i] = res[i] >> 16;
> +
> +			/* Check speculation */
> +			fix_spec |= (next_index ^ next_hops[i]);
> +		}
> +
> +		if (unlikely(fix_spec)) {
> +			/* Copy successfully speculated packets before this batch */
> +			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));

Please use memcpy for this small copy

> +			from += last_spec;
> +			to_next += last_spec;
> +			held += last_spec;
> +			last_spec = 0;
> +
> +			/* Process each packet in current batch individually */
> +			for (size_t i = 0; i < vl; i++) {
> +				if (next_index == next_hops[i]) {
> +					*to_next++ = from[i];
> +					held++;
> +				} else {
> +					rte_node_enqueue_x1(graph, node, next_hops[i], from[i]);
> +				}
> +			}
> +
> +			from += vl;
> +		} else {
> +			last_spec += vl;
> +		}
> +
> +		pkts += vl;
> +		n_left_from -= vl;
> +	}
> +
> +	/* Handle successfully speculated packets */
> +	if (likely(last_spec == nb_objs)) {
> +		rte_node_next_stream_move(graph, node, next_index);
> +		return nb_objs;
> +	}
> +
> +	held += last_spec;
> +	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));

Since compiler doesn't bounds check rte_memcpy() use memcpy here please
