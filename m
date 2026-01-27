Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641ACD19512
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 00:37:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13961402C1;
	Tue, 27 Jan 2026 01:37:18 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id ECE65402A7
 for <dev@dpdk.org>; Tue, 27 Jan 2026 01:37:16 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so42160985e9.3
 for <dev@dpdk.org>; Mon, 26 Jan 2026 16:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769474236;
 x=1770079036; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dzf+YN4CAacn1Yj7pme5DsCTHzmVUUDfL673YFmSWI=;
 b=mEeN205OE9hTiFCTQJDsftQGXsHY9p87LHZI4PzlPLRngjQ+78FkHMQazBoUfsEcwo
 HTQosy5M0nb/BBtHtZpxKJwJU91JMBa4fUxNRzkuybK4LXe5qfeKBL7kCtLFK4fQMpWu
 7HuZzveJkGpD86kTvwyY6ZI8O5PJeq/LQpXWCC7np2hQsYbRbGzwMZH5BB7PUTPOerXk
 nAvahYrU5Ha1KU2cDpKutaMTiLbMwVd1Fpo55eDsvObvFWq3VUAMFhNifIw8AXnSsgnS
 jhMYbD61AIgoArhWKytGiILbUzXyy5XGnS4mbe6UxyQVTCQZDNfS56LhJjva1gFdiaIR
 qEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769474236; x=1770079036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6dzf+YN4CAacn1Yj7pme5DsCTHzmVUUDfL673YFmSWI=;
 b=fDixJUIeKemH796KWPzky9C+cwSupeWojBdMij+NgS3tiw1NPRwaL1+CICZvSTq+Bb
 RzHaSam9Yk7ETr5FIL2ffi1dPEDERB6pV3Ljo67+jQK3LiCwpzTdGPk4w5RhZ1wiV99z
 LZk9Z1k0phU5oAAtMY/lOOM4E6xvpX6n68YLel3/UwOCPFGla75gcU/qgSdq0S8M/13p
 Ag8tPwE0IJRECgUk3JY/967t0C/IRVUYhShQ1Q8sHRIaDT+rxMu4fTnufhLaWTvdoYP3
 Jjxkp+dZK6ikqY6JctkSTZhULeKwhsyPetdUI/Z1qmAwnd1h4KppzZQbqpbHft3F9VJ3
 xscA==
X-Gm-Message-State: AOJu0YxV27TuMsAsCFsx4f+LYbJNFhWg1YV0lK+BooXaOyN6noUIoUMr
 LCUkU4OA3mKydJ5Hv4aARL2GchTNiM81HqdCWzhbXkRKdQVXG2V19H0uiRr1XW1l0q3hL4N6VH7
 w67lF
X-Gm-Gg: AZuq6aJz3cYKkkiu13jjOQho9lZ46CUk5l7q5+a/GBo+OxhS8ak3+B9QMZg8iIQa8k2
 u9R7vmXx//qQ06BpNvucYBKwb7Bz2VDAQTL7/muiVnKvc4B/ffrsoLx50UfSTKL1C4ALgl2oEre
 OUI4gN3tO6nOFgP1PSlwur0kbxzoOEnpQ1G9nJg5RAXxgwYv+li2b01/NnOwTWUVE6NeLSK8L+F
 e77sgSaz7g+Vul/qjn4J7nSGXOqsRh8APQGiZ64Fer9OzqAFhk0T8waI6zYs+NaPJ80XXxFjhQT
 U2Oh3oP/ttpjWaTAE+LUqp2HDCYvhn4Bi5iRuAnlDT/jjs2+9NE3KzlKixyD6lNQIG+iphFdyk0
 ygU455SNZA+UAxWIbAqhgcTb0iQ2BMRd6W+J131CUIQZhNoxzzsjnjh5iL5cmGzGN5Uw5BchgIk
 ku/ZQs9oF4q6ejThCtxtrFD2beUf50t1ehESubDMzITGcyLd2VDANi
X-Received: by 2002:a05:600c:628f:b0:480:1c85:88bf with SMTP id
 5b1f17b1804b1-4805cf67216mr88103065e9.27.1769474236182; 
 Mon, 26 Jan 2026 16:37:16 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c0f3f7sm32944415e9.13.2026.01.26.16.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 16:37:15 -0800 (PST)
Date: Mon, 26 Jan 2026 16:37:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 2/8] net/nfb: create one ethdev per ethernet port
Message-ID: <20260126163710.5bf8a275@phoenix.local>
In-Reply-To: <20260123172224.1567362-3-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260123172224.1567362-1-spinler@cesnet.cz>
 <20260123172224.1567362-3-spinler@cesnet.cz>
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

On Fri, 23 Jan 2026 18:22:18 +0100
spinler@cesnet.cz wrote:

> +struct nfb_ifc_create_params {
> +	struct nfb_probe_params *probe_params;
> +	struct nc_ifc_map_info map_info;
> +	struct nc_ifc_info *ifc_info;
> +
> +	int basename_len;       /* Cached real length of original probe_params->name */
> +};
> +
> +/* The TAILQ entries are used for cleanup of allocated resources
> + * in situations, where dev_close is not called.
> + */
> +TAILQ_HEAD(nfb_pmd_internals_head, pmd_internals);

You should put static in front of TAILQ_HEAD so that the head is not
global if you don't need it to be.

> +static struct nfb_pmd_internals_head nfb_eth_dev_list =
> +	TAILQ_HEAD_INITIALIZER(nfb_eth_dev_list);
> +
