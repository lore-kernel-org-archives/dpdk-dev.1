Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA4D73E81
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 17:28:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE9DE402C1;
	Thu, 29 Jan 2026 18:28:21 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 7918F4014F
 for <dev@dpdk.org>; Thu, 29 Jan 2026 18:28:20 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4801c2fae63so9905335e9.2
 for <dev@dpdk.org>; Thu, 29 Jan 2026 09:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769707700;
 x=1770312500; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYlkjI9mel+2aCwqYwrl34+dMe84FAt2iohDjDikHBs=;
 b=LdUM268+BaPgnVls0svCrIOh0v3oHbMi6nCSq8dtV1xjGSEGCjbhOdHk2iMA3cuDn3
 WM3PPufJzl+qLR7GVJ6Aocb1yk2lGOQNwff+FszKqqS5MKTeRyhKNUOby2LxO44UjIop
 RtJoFHNyO3GRzDEizTEFwUeYzNhIxSW6XDE40x0hU+LqmdmU2lezdk7WhdURoNyyvdBc
 /MtIZSmHd/RVMeq1EYowqpXakGKpbUZCdaULH3+oYUFCiAR0P0bhm+Sk9EHjX/TYrS8D
 21k080xh1fYC4V1e1Rgz/nojNo1jXHIv327koZLS4R+QKHi9wsuQNpe7lWU1xa4BmtCm
 Rj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769707700; x=1770312500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jYlkjI9mel+2aCwqYwrl34+dMe84FAt2iohDjDikHBs=;
 b=lN4NMYKVvgQMG9e0RIhD58PGqz1Vr4QlKFWUmV5N3b38jPLPL4Bo/ZtMt/gg0SQtNm
 iPI3eFH8PZlkZeenEWMModbiee2O6PY0lL7qykupejs73SNX2pBhTuBa2AtNZLyiXHnG
 v+/OVnaX0NZSxENmSviDIbVtLKs6RjeZeTpZMRgPKW3F9Yt3faZObcBm0LeAOY+gHNKy
 0wi2+STssTydmOrhOfn+ZhO7ClKvq8opZ23l7LnpCYlqGgiA71NF3plILvkPvSDPw7Nj
 f/WFCnjpmjYT6Hs6OuvAFW/qrLgh5fB2K+qoPMOicWC6UVkeKFGS9q2OvByU9PWyzTpL
 Vtxg==
X-Gm-Message-State: AOJu0YyUnDcUfn0lXDbLG4Yr6ycvMJhVPJVicrdfmgqbLqTbu2z8g4yE
 nHhQ+SRBKqC8qWLd/dR9DSAn4zWcuCHaHlc8lTyb0BepL8n0iWWkSKTx1tZNEXlUiY8=
X-Gm-Gg: AZuq6aIgmKu+BmU2C4WG59rAbkuLTL8NAXuN9fWQ5j8uT+1FgCO+UmnyEdYXyu3rmjs
 TUwj9RqJiXi1EGTYWDYWkN+vmllJsLekegHoPr325xNhKevHXCMjdVmpQQhxdxTvYKMyxvrlgFG
 +I2oEaw4BfqiIgZ9UqGQ6HlKBLwDp4YjEcate2O/E/ywyYuOswCC8xcJkvIwTDG+eoyTDPdhsrw
 FPeTvKDQ2piWm11E+dUF1qWzKS5A2y7uVHUv4Yo2mdSvjWXYbod6gQOkXZuLn1U6BAq2cVIx5fp
 1XoAAdlCw1MD+oZ40uOS9IYUevLxhFWw6Fke1uuSQ2EO7PrBSm4ayUFGiVTkC4B9Hhi8GNrgEe2
 dNkcPHY5AHDLnNr7jWi6guLXAAnd49PyVf/UklJ7n1Xn/gRuhsCn9rcFmTTmQNFlmeGYV7rccAr
 0ZL2kILSZy7EUleOLRv+3K8g4ZVQbGrk7nX3cNz8NCLYbs2gmzksNu
X-Received: by 2002:a05:600c:a08c:b0:47e:f481:24b7 with SMTP id
 5b1f17b1804b1-48069c480camr132350345e9.17.1769707699951; 
 Thu, 29 Jan 2026 09:28:19 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131cfd4sm15167238f8f.25.2026.01.29.09.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:28:19 -0800 (PST)
Date: Thu, 29 Jan 2026 09:28:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v8 3/6] flow_parser: add shared parser library
Message-ID: <20260129092815.750af8c6@phoenix.local>
In-Reply-To: <20260129114202.61185-4-sismis@dyna-nic.com>
References: <20260129114202.61185-1-sismis@dyna-nic.com>
 <20260129114202.61185-4-sismis@dyna-nic.com>
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

On Thu, 29 Jan 2026 12:41:59 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> +
> +struct rte_flow_parser_ctx {
> +	struct rte_flow_parser_vxlan_encap_conf vxlan_encap_conf;
> +	struct rte_flow_parser_nvgre_encap_conf nvgre_encap_conf;
> +	struct rte_flow_parser_l2_encap_conf l2_encap_conf;
> +	struct rte_flow_parser_l2_decap_conf l2_decap_conf;
> +	struct rte_flow_parser_mplsogre_encap_conf mplsogre_encap_conf;
> +	struct rte_flow_parser_mplsogre_decap_conf mplsogre_decap_conf;
> +	struct rte_flow_parser_mplsoudp_encap_conf mplsoudp_encap_conf;
> +	struct rte_flow_parser_mplsoudp_decap_conf mplsoudp_decap_conf;
> +	struct rte_flow_action_conntrack conntrack_context;
> +	struct raw_encap_conf raw_encap_confs[RAW_ENCAP_CONFS_MAX_NUM];
> +	struct raw_decap_conf raw_decap_confs[RAW_ENCAP_CONFS_MAX_NUM];
> +	struct ipv6_ext_push_conf ipv6_ext_push_confs[IPV6_EXT_PUSH_CONFS_MAX_NUM];
> +	struct ipv6_ext_remove_conf ipv6_ext_remove_confs[IPV6_EXT_PUSH_CONFS_MAX_NUM];
> +	struct rte_flow_action_raw_encap raw_encap_conf_cache[RAW_ENCAP_CONFS_MAX_NUM];
> +	struct rte_flow_action_raw_decap raw_decap_conf_cache[RAW_ENCAP_CONFS_MAX_NUM];
> +	struct rte_flow_action_ipv6_ext_push
> +		ipv6_ext_push_action_cache[IPV6_EXT_PUSH_CONFS_MAX_NUM];
> +	struct rte_flow_action_ipv6_ext_remove
> +		ipv6_ext_remove_action_cache[IPV6_EXT_PUSH_CONFS_MAX_NUM];
> +	struct raw_sample_conf raw_sample_confs[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct rte_flow_action_mark sample_mark[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct rte_flow_action_queue sample_queue[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct rte_flow_action_count sample_count[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct rte_flow_action_port_id sample_port_id[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct rte_flow_action_raw_encap sample_encap[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct action_vxlan_encap_data sample_vxlan_encap[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct action_nvgre_encap_data sample_nvgre_encap[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct action_rss_data sample_rss_data[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct rte_flow_action_vf sample_vf[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct rte_flow_action_ethdev sample_port_representor[RAW_SAMPLE_CONFS_MAX_NUM];
> +	struct rte_flow_action_ethdev sample_represented_port[RAW_SAMPLE_CONFS_MAX_NUM];
> +};

How big is this beast?
