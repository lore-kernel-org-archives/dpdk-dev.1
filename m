Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89EBD46C01
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:07:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8CBC402BA;
	Thu, 29 Jan 2026 02:07:23 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 4C41540297
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:07:21 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so3164955e9.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769648841;
 x=1770253641; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXMbfdo5deb7LQzNnPSMKjNbKlXxyssiuW3NfNvz4Sg=;
 b=iGvnfVG7Q06nyRkZR2RAgD2749g1VrD29KUc8DTVkXeIaIA867fseaXtMoVMPP6yFC
 kV6zL2m+I6agzQoxLaiLpXRYLrG5SDvvMItW8SYUSOvtYiaNsPeU2NpFYUPgCGVS0yi/
 aQRiv7Wi+FufjOpXlP/o/F7rCFVUAUCiIzT9ymCqqBf3duvFSXVGcLkx26hprYT3MUpX
 /ZNYWqsZlg8kRx4JLV+sZric1dCVjSUsnHunhs6V/+Kb30adk8CrY+8F0cGkK8g0fp9Y
 771kXTfULLlDf8YHRa/VG7PjHlwULSLtuxKIdy1e3VZivaTmmnERXpT/D/fZIgkmlkA/
 YIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769648841; x=1770253641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JXMbfdo5deb7LQzNnPSMKjNbKlXxyssiuW3NfNvz4Sg=;
 b=ZnSYwuigwXpmc+GZIu7nlc7vEm73gufykLrhtDfYd+OKBemZ/SiOZZuqdc/NRVzkh5
 FU6dvqBxEZPwVofOezhl4oM/LY8izGFoD3oPOPW3B0wjaKB7DV4aFXSkgEhV21vcnWGU
 B9ZuS5wQOFhYfzO6i8wVEUNYyZqSIbrduMl1uoCeSVdqesee4xs9iSvMxUQvQ3s9v+0h
 D+Am0R8LOn53M0o6aWOimPQUQim0uz5UMjSycFBl70QGho5FgSDQsLU+R/J9N2qqQTQB
 FM2VChg9EMML5XCNSi4c9ocHHTRaa68ezAE+2RC61Glv3fpAAQOt5Ijz06J4mll98q1I
 8thg==
X-Gm-Message-State: AOJu0YygRN7cl1xzxYeCDVjKuEic3WHOYX8GV7eKTmdMbWR8FCdgwQOB
 qTZPgTVMvzWVTrd8S36e5KlR6DQUArxWcLGTOlbfzXppYfmwhkeDYhtiibTVWSUG5OQ=
X-Gm-Gg: AZuq6aJDaKCk7WpRf4dcH6YGAleV42bQ/NjgNqk9Onpgv4iTfM9iY4MhabwxkO5nh5l
 hnZolFf0Lq/ltmWruXQZMEG36OmnsNYCkxZAD0u+1O3LZduYUrfqEgBOIFnJQVTXgkY2NydxjPt
 nC2FCDLq9KS+rrK167uL+EhkZ2FaHrawD8SrDFGqllX2pJVDpj8/k7lEmxzx2vCvjhXYiL1F0/d
 B5Ey3/X1FFyg887GdhtLZ7iUaXvZl70+5TFox/E9phW0zbaKdEp7VF0HSIkpPz/LuxJiQliZsgR
 uHcYMR97YsDEK+5vpHU0Ozsdx9LC/7WOkhAmchxAXWrby3H9SxCZGpe0v9YkXVej4mBxxnteJKV
 QajoLITWrPty4jl+jX+Y0P/EChaSIvBetVbDgrgpuLPEsM+dgX97mlDaF75XB6b04tUeB9WwfSj
 Kzb9lRBT2JHLWNvF/StRLOKhoRE8flHaSWOkJ/BP+aR2wU8S+GfFE6
X-Received: by 2002:a05:600c:5489:b0:47e:de23:dd6f with SMTP id
 5b1f17b1804b1-48069c4a7fbmr85688505e9.12.1769648841039; 
 Wed, 28 Jan 2026 17:07:21 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c37433sm148335095e9.10.2026.01.28.17.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:07:20 -0800 (PST)
Date: Wed, 28 Jan 2026 17:07:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: scott.k.mitch1@gmail.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 2/4] net/af_packet: RX/TX unlikely, bulk free, prefetch
Message-ID: <20260128170715.3bced6c7@phoenix.local>
In-Reply-To: <20260128191032.78916-3-scott.k.mitch1@gmail.com>
References: <20260128093607.62908-1-scott.k.mitch1@gmail.com>
 <20260128191032.78916-1-scott.k.mitch1@gmail.com>
 <20260128191032.78916-3-scott.k.mitch1@gmail.com>
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

On Wed, 28 Jan 2026 11:10:30 -0800
scott.k.mitch1@gmail.com wrote:

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
> 
> - Add rte_prefetch0() to prefetch next frame/mbuf while processing
>   current packet, reducing cache miss latency
> - Use rte_pktmbuf_free_bulk() in TX path instead of individual
>   rte_pktmbuf_free() calls for better batch efficiency
> - Add unlikely() hints for error paths (oversized packets, VLAN
>   insertion failures, sendto errors) to optimize branch prediction
> - Remove unnecessary early nb_pkts == 0 when loop handles this
>   and app may never call with 0 frames.
> 
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>

Drop the prefetch stuff, it doesn't matter.


	Original	Prefetch	Quad/Dual
TX	1.427 Mpps	1.426 Mpps	1.426 Mpps

RX	0.529 Mpps	0.530 Mpps	0.533 Mpps
 loss	87.93%		87.98%		88.0%
