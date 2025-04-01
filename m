Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6329BC36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 14:15:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 442C5402C8;
	Tue,  1 Apr 2025 16:15:28 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id C49A440275
 for <dev@dpdk.org>; Tue,  1 Apr 2025 16:15:26 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-301a4d5156aso8984280a91.1
 for <dev@dpdk.org>; Tue, 01 Apr 2025 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743516926;
 x=1744121726; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgkk6Lf0IKHHQKQUlGYC7YlAwz65hwAn3Kt92qprhMk=;
 b=S1qJDHsvYyCIzkO2i4HuUrzFydrRkRtQYabrMMo4/SQaGGb6PVO3N8rm0mt9NrOevH
 JWBfwRijKyQAsyTqdpA17a2gGUgYRv4lg20JDkIYVKoQYXE8RKFi/UXq7zpebwxzctbU
 iDhlVWOimlaN6KbQiAZ+3ot0xDIPnvy0U0lAeapzqn9labwxCUsfKsZ4c/0ZwwiWHjzt
 5+/WACV34nvVGF8P0aAZBUQirgm/5YOF0Ah6nK11yIISTJNx2ipPAp/g5iQLDPbdBEpR
 hTCgbv48p1I9wEOmPhLi4bVmMJ4ezl43zZHReU8VIozeGsIM63F7o0U6ugHhQDCNMq0P
 jZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743516926; x=1744121726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgkk6Lf0IKHHQKQUlGYC7YlAwz65hwAn3Kt92qprhMk=;
 b=rP6ORh0ymoWJgNn1gmGfkvyZzHI+5su6VoXhOSPavAGD8IxShnwjk487mciC/lenoS
 E5sGCoJ3Dge0Ozt0Q5qPYNv+1DQSvZB4oMaJiorQmVCXl0tAZkMTlOXrrboEYaORcg8p
 nGpeDdo1m3uDu476F/41WXMORW212UKDRV89ug6k9eGm/XfsUpb4G+xyW4IsGR5nlZwA
 +5vNI1ZmVHahP+vla5EA1gZq3O7cYLSkVEk8E+duI3yZQLysbrWHDmGW3zErqCtPYKqJ
 pw9jvvzjQM0JwvRUBctmVTYxsYqIzuCHM6GGxnku46n71yqJ0LflP90jWVOeMqvgaDo6
 cwAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt6fKRx6RqXKRIBWCWwJqbyI9k8vAmR1tTFhJcj9Y5WYZMBvUe7GJQw57J7DrJLiIkvAA=@dpdk.org
X-Gm-Message-State: AOJu0Yw6jyiDMY1Z7u6C4gkvQyh00gJyOTxgNrw0GzkdPz8LAiU9APwu
 f+OEYcdyjtFiJH6zsQW9Q/w63waoBTr3DlMCVvGSrfHG8LmGXLiVGSxFWzQCVLM=
X-Gm-Gg: ASbGncvxGzMgAqL9I+j4SPZH9nk/OqdlvEsO/KP+vUcME+bJ+oQ7Co7xrMHAzLG5bT5
 Z7bi59rZ8Kx5GWExuYaJc7GfepNxgb8i0upc13ryH0T2x6YQTcOO8U8KSj9xlJEsI8i1iR5TBrM
 XnQcc1qf91oA3IXnq5fd3MwxekBfuU3ppp7QPLSVrXBQx6j0Uhn+Svg0xvpe7vU2Pu7bJa3IJmg
 IC2KqVqqjTfJpk84Pb/u66EcDuHpMv2M8a2hVSoV4702SPaS+pKSuhyY8hLIkebfhsYKk9HdShr
 NC1SzDcpAfLMBUUcu1QlbHAM/VUniXA2ucgq06oZeX3Bd5tfFaP0VD3nrdIH4VGn+Ks/b8uwmEV
 +V0OW0xmrBATqcfF3CXys
X-Google-Smtp-Source: AGHT+IFls3qUqr64gUYdlifeVLh2jgHQ1VX/rLLU/6kROe6GHplWEbNpMPbyEvYFfWJHlrzozRvaYw==
X-Received: by 2002:a17:90b:2e8e:b0:2fe:ba82:ca5 with SMTP id
 98e67ed59e1d1-30531fa1637mr22853662a91.11.1743516925836; 
 Tue, 01 Apr 2025 07:15:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039f1d4b7dsm11637370a91.37.2025.04.01.07.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:15:25 -0700 (PDT)
Date: Tue, 1 Apr 2025 07:15:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>, <dev@dpdk.org>, Jerin Jacob
 <jerinj@marvell.com>, Nitin Saxena <nsaxena16@gmail.com>
Subject: Re: [PATCH 1/2] node: add global node mbuf dynfield
Message-ID: <20250401071522.67cf34eb@hermes.local>
In-Reply-To: <20250401042053.3518757-2-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250401042053.3518757-2-nsaxena@marvell.com>
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

On Tue, 1 Apr 2025 09:50:46 +0530
Nitin Saxena <nsaxena@marvell.com> wrote:

> +int rte_node_mbuf_dynfield_register(void)
> +{
> +	struct node_mbuf_dynfield_mz *f = NULL;
> +	const struct rte_memzone *mz = NULL;
> +	int dyn_offset;
> +
> +	RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_dynfield_t) < RTE_NODE_MBUF_DYNFIELD_SIZE);
> +	RTE_BUILD_BUG_ON(sizeof(rte_node_mbuf_overload_fields_t) <
> +			 RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE);
> +
> +	mz = rte_memzone_lookup(NODE_MBUF_DYNFIELD_MEMZONE_NAME);

Seems wasteful to have a whole memzone for this, the data is small.
Is there a reason it could not just be a global variable like timestamp.

I would prefer this was a clone of timestamp code, and put in rte_mbuf_dynfield.c
