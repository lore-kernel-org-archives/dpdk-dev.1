Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AB0C7EE31
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 13:59:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C9BC4025D;
	Thu, 26 Jun 2025 15:59:07 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id E164140156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 15:59:05 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7d0a0bcd3f3so114288085a.1
 for <dev@dpdk.org>; Thu, 26 Jun 2025 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750946345;
 x=1751551145; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9xa+ubJOyOLciImjkk8Ed+Z55TqXa1LzSjIjeIRfUN0=;
 b=dVN4GtMTsEuXRPCVB1ARpLxPwJWq/KO5h0r0MvQCS4ZA03yWZ61ONqTFVitb8oo+ik
 XEx8VD3Nvj+q16L7621ufxlJVgZQRYT16xG46t4kA9GhYZyB/ZHiqIaDCUQBnViWOJGc
 wdnrNlTBoSuqoDV3+zzu45yA3/SxUU2U82pvbHuDMIlw3O12xw+sXk1jHwgTlz5IM9O/
 cn3IUcJZvtciR4fw+WhIiqry+sQSYW2nqMBzLmMJ1hrNyc5Knxf1vU5yHa4bz2+iCeeg
 CfAftxvkYveKRffvisOzcVaM60a8s67vVVASu660mX32taBcMaAZUWFnU6wa4/82agOy
 6VXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750946345; x=1751551145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9xa+ubJOyOLciImjkk8Ed+Z55TqXa1LzSjIjeIRfUN0=;
 b=kuEN/YlHIXGfz4x87ut1wup2yVc54szdDM0B4aO3G/EzwYn6PzG2/c8gJRiN22jMhn
 b3wQrnBTOy7dJWg4Usgf0vcQehBXsy+03Rx/xA8BOrmGHF+lw/8Wk12lxcerS69Nb+XT
 bVayVBRe9EzGQpcdXnFEB9Itb1Zvix6M/2kjaCCg4PNTvzuSEyDkF2Fen3yEqSTBYet5
 i6pV7X/4NafO/k1O2Gslk2qwUaUMoJ/KzwDRguv5/pfOWw3+j/leqxFH8aLjU94f6G9X
 5eeqGGLj2W2Qt/7gUyciDNxzZ8ecR92ZRgcq9c7txL2ZQgJH1NOZZeMbEB/UILDYsAaB
 HPQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgd2Pn/LzAMT1rMANPur5bhCz4sFkS/WJT4tbxP6OCO7b3kAV3dVTGmtcM/aunzl8z/lI=@dpdk.org
X-Gm-Message-State: AOJu0Yxqnhnr0agr04Iv87awetJkNAanxj/NU0LrDe7rmA3ODi5jipyg
 bxfx7gITi/GOTFaUt7KpygeAVvniSv3YnMkZyzqsYkOycKYWrUVDBXXHT+74cGVwC1I=
X-Gm-Gg: ASbGnctXlmG3L0ur8/UieaVsMeCBtbfDJtBQVN0bl0dOkAovfieINci4aecy+O3hKmN
 y/OJD5cP6LGWcX1LnKWKxFcFuRULK59vlRXxEyRaCdB+CuCNMm2wP9bO8uI1VF4q8zlfXvoxjsS
 4oMsshpq3uA0TqD1ONOyFOb/xg0bZAigeWVCNaTxRWocQdAyDUAWTIRQPYYzKI6mOWeMr9G7DmG
 rvAZqyTSofX1YcHrGaTxiB7fR8PWQeqnjxaKqxEMZKFmSRbiyKDlmJHKacWfke71fTUxcitqA2q
 kHW291h3yJS9NpnmVIocZ6+vGwL+D0nlVT4IsEnaxMPflb3unJceD4my2PsIEwaNoAKDHEbWYYG
 +u/rdZEfK5dO8cdCe19SavzLrzGP55dTC4DhoRAQ=
X-Google-Smtp-Source: AGHT+IElCAtVm84/oS5YLOQHGAA3FxdPb/xE76TCx0SEmcI05HqHsu0XxG457A2VMYTgRwPcLfbZUQ==
X-Received: by 2002:a05:620a:258d:b0:7d3:b957:cd00 with SMTP id
 af79cd13be357-7d43bbf16b9mr516748985a.20.1750946344908; 
 Thu, 26 Jun 2025 06:59:04 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730aa6bsm7545266d6.104.2025.06.26.06.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 06:59:04 -0700 (PDT)
Date: Thu, 26 Jun 2025 06:59:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nitin Saxena <nsaxena@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Robin Jarry <rjarry@redhat.com>, "Christophe
 Fontaine" <cfontain@redhat.com>, <dev@dpdk.org>, Jerin Jacob
 <jerinj@marvell.com>, Nitin Saxena <nsaxena16@gmail.com>
Subject: Re: [PATCH v7 1/2] node: add global node mbuf dynfield
Message-ID: <20250626065901.55d0dcbd@hermes.local>
In-Reply-To: <20250619154501.3869031-2-nsaxena@marvell.com>
References: <20250401042053.3518757-1-nsaxena@marvell.com>
 <20250619154501.3869031-1-nsaxena@marvell.com>
 <20250619154501.3869031-2-nsaxena@marvell.com>
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

On Thu, 19 Jun 2025 21:14:49 +0530
Nitin Saxena <nsaxena@marvell.com> wrote:

> +#ifndef RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE
> +/** Size of persistent mbuf fields */
> +#define RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE          (0)
> +#endif /* RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE */
> +
> +#ifndef RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE
> +/** Size of overloadable mbuf fields */
> +#define RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE        (8)
> +#endif /* RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE */
> +
> +/** Size of node mbuf dynamic field */
> +#define RTE_NODE_MBUF_DYNFIELD_SIZE     \
> +	(RTE_NODE_MBUF_PERSISTENT_FIELDS_SIZE + RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE)
> +
> +/**
> + * Node mbuf overloadable data.
> + *
> + * Out-of-tree nodes can repurpose overloadable fields via
> + * rte_node_mbuf_overload_fields_get(mbuf). Overloadable fields are not
> + * preserved and typically can be used with-in two adjacent nodes in the graph.
> + */
> +typedef struct rte_node_mbuf_overload_fields {
> +	union {
> +		uint8_t data[RTE_NODE_MBUF_OVERLOADABLE_FIELDS_SIZE];
> +	};
> +} rte_node_mbuf_overload_fields_t;

Having a blank scratchpad rather than a real defined structure means you
lose any type checking or potential overflow checking.
