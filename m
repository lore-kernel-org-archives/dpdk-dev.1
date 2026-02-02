Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1E6E7DF0F
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 17:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 215094027D;
	Mon,  2 Feb 2026 18:50:40 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 3D9114026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 18:50:39 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so52706295e9.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 09:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770054639;
 x=1770659439; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l91j9Mw0UGWeIL3Xxlfv5mvn2cxZV8YUPF6qsBhdo6A=;
 b=Gs2WjFs14Ia5uppOnxELCy0a+EKhf81Gb9hkE+a1GqspHtWHSFM5xadHBSnrDwQ4ep
 o2E0uFm2e7VPFz0KifTrCVc7IQd26O+b3e0i9hEpYohDlQscIdsRhkryoD9fKdgxqeqn
 QLurCevuD+g1YWaxeXz6FHptNJ77xflD289/LiA0UXmiwWQwxse9UA8QDmAjUe4O+CrI
 zpXOrXR3v1gzhgr+n5QfVE+3T8/ssd57hWhNGqvXjbjpF0JLJBdV2vxMFu1Y79yY/lsq
 gbUOv5g2jN4WyPH72yq6fEKvT/fEVzJoBMLpfP8PJTBO9cootukHQGgqBhCi4oAsgu6M
 J/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770054639; x=1770659439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l91j9Mw0UGWeIL3Xxlfv5mvn2cxZV8YUPF6qsBhdo6A=;
 b=bKyV6Biv4551rq7WJu3NBwt+lnw1myNOsHBwlQvvGWF/xSWL9+NzyDkwo6e2Hx3SOQ
 FzEP/FUzUAXjkHFT/+fIOzosYLpWGL3vtYxhFDWd1ZDGvd5dMDLkbhXR9u+6b8+Rq+nQ
 KEQbeP40H/g+aoTSHXp1Mf8jWXaxhAr4QDB6MYS+ng3XWRy0yodwLJL9GexDh3D6dyaN
 sGkG9XabeVKHmMdfxnBoBS3C7uyhHS/q2hJBsDCqIyKj6k75Vn+aY0KatG2FX4PsOCGL
 oLmOE8LOZEAa4pgK59rbR7ERChCEOpjnbTirAbnd3XXRKjtgwqbulS5fJJJBiokvPlU7
 9AmQ==
X-Gm-Message-State: AOJu0YwS3YM8YN1U6NesD+4NTdbbO3IcTFPb5nLfxzipBHK9zeYNG0/S
 YjJ6UMQ+/eSi/n6zRk8lOpuU+SguK4cHT7SW6Wv3BB7JrDHQVLMRfKTQXTGDiomCCCM=
X-Gm-Gg: AZuq6aKYyUSKbP6BXLJ8vFFexRVVgbZpA3vb8gHcFrF5DZxAsdBpM2YRjoKIgchfL5A
 DHupDAzdpjD7IrShQn1wJj31KQSz+h7Mdxpl41KA9NUgY4KaNRL59Ju8EMUoeGbXdLe2LJMG+ia
 SGZp48WGeuIbjkohbdPg3Jslgi35jVEbsFVffgnQDJsgy92xEFdubgixOWezbzK8y56W4TzAC4+
 eaDju7yGdx+vtkZMcKhH3FRNNUFbUmdDIpq7RQCnG/5pagpkjys+kKglL+MNHXXCHyNapS/pgIr
 YarLV8to/Wgx+VWLN/8Eq3sKUOctuaUdAgoQoqIKDgz8amigKxBFYUUwspDRT7b9saYxiu7M+KB
 SZL/WFZPzVCmLH485KwzpjT3Y1q30diWO463gG78+BQ8iIHb3q990bBQ21uvrrqmGkGn+rSGMCc
 dLTfwq6tW9eezvZ2Tcudr9dGqNH1cFrvqmLJ+8JGV4MrE0hFmINFVGiATufFnJJk4=
X-Received: by 2002:a05:600c:4443:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-482db4a1030mr172442185e9.32.1770054636234; 
 Mon, 02 Feb 2026 09:50:36 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051286e0sm4512925e9.5.2026.02.02.09.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 09:50:35 -0800 (PST)
Date: Mon, 2 Feb 2026 09:50:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 1/8] net/nfb: prepare for indirect queue mapping scheme
Message-ID: <20260202095031.0a755945@phoenix.local>
In-Reply-To: <20260202153449.3295979-2-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260202153449.3295979-1-spinler@cesnet.cz>
 <20260202153449.3295979-2-spinler@cesnet.cz>
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

On Mon,  2 Feb 2026 16:34:42 +0100
spinler@cesnet.cz wrote:

> 		priv->queue_map_rx = rte_calloc("NFB queue map", (max_rx_queues + max_tx_queues),
> +				sizeof(*priv->queue_map_rx), 0);

You could drop the parenthesis around max_rx_queues + max_tx_queues and shorten line that way.
