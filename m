Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3855C83F1A
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Jul 2025 16:52:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B591C402D3;
	Thu, 17 Jul 2025 18:52:53 +0200 (CEST)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id C6C124013F
 for <dev@dpdk.org>; Thu, 17 Jul 2025 18:52:52 +0200 (CEST)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4ab554fd8fbso19661891cf.1
 for <dev@dpdk.org>; Thu, 17 Jul 2025 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752771172;
 x=1753375972; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06ij7yPK3gKfNF2yE+sikQmc+d/VSreFzojeRDUi2fM=;
 b=W9343KtNSAviOj60NiF7Aqo+OJgm5odLQeRKHw7kcdRlAx79pCaw5LeIBBf/ZtSZH4
 m0p/6b8w7A0iF/xz7iRrU8rWH1ChehX9i6AbjDt69Pr4ONlX0jKxSkQQm8SXxTCAp9co
 b67f6yS6VxBVfioG+029lQQwFRQFN+fxHG9MEpUV+4b9SubZ7i+686ZmtGXVYgZ/VRGp
 moUl+mqZKyMgHXzrTVjKe8RchjnGo55GiTkv1nG1W+3uoK3lzuuoFwWk1PH02Ps2ZzUc
 X24VDtDrg31CVjLZkDKnTHmD4tSKdOhlM5A3X27ihQTcc+7svnMn9MlZSsqjAnUeANME
 l4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752771172; x=1753375972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06ij7yPK3gKfNF2yE+sikQmc+d/VSreFzojeRDUi2fM=;
 b=XRfryPbVLJXfxWyxlN5nFv9rLwEUxImAiCNY2+MLiBpwBcB5peovxYuGjGP/EZlGZq
 alRsU2u1D5gbQJBgR2eu7VxEfbf8xH9NKrdaRwMSu3LXlKyFBG2uVzmzvd/aJ1IEnKEA
 uaT8aOFYvqLH+XA6DMqSoIC0tmw9BABlVS+4GNvddLL+X8k110mXIOEkuIpaPtlg1e9o
 ybUdns9UxX3q1A0ylov43pv/f2Xef3xlFGNdU+DDmZsSOuiKoE4E1/p+yowQlN+qjAgu
 s14PJQ31VMm4TVF4ptZTZs0RPDFjg+gIoj6mThDNRT3NEpU9fYgBIEgsfZgfhAhyz2aX
 yKYw==
X-Gm-Message-State: AOJu0YxlnF2W2ImCxGdBLS3W/9aZ2EfAzZVSpLOXxiNdZYJkTH0fcdPX
 RpyeB8SJtUj82+ikSAkW4jgNRo+vOvDwWgMXCCmYRHiPMHn2nzHkAhvAKIffEJ5uWYGXgBTOJEi
 jwfCZ
X-Gm-Gg: ASbGncv22zawp9Xf0bfHNAA7ekO1CtEvv+CcBtW+sOHX9OE56Zb0cKpf+EwulVZhLpL
 8clKg6lex4RZHcg8rvp4zCv8GLf1z47nkVgoEdpqJsaNQIWtf/6wU1QA9FHy1z7zzRG9al6/Ffk
 VDF+Yx9pDCzHadlRnzFmwsencMSMLDYHBY0xCpT48mJWBewyrvVxyM98BUbJHaRki9598oHYN00
 LYOKgnXmWU8mE7tTRklXldvgg044kSBvkAsoTPi+R4zpA8dV9KOfR3OH7TZzFIMuZB3qHpIAK+B
 LAMiyyudp0+FWv2jhI+wUfoi3ZFH6WfkEIZEFDX67I1jaSUswKYFa4V0sWmK1zmFbkNAIt92Qvb
 bPMr3KB4WtFBWL/e+jXuEVpPEBDlTJfxkH0NvN56pfjY6wlC/Ohqg2GjNIz++fu4ti8ANn7DSLe
 E=
X-Google-Smtp-Source: AGHT+IGcn6RY5iw+HocEnCr1/sluncdutLzhM+p/3QvYfTW5vEmrEpGNfJ5o16x7YCtBm8Lp7jK4Iw==
X-Received: by 2002:a05:622a:a14:b0:4a9:7366:40dd with SMTP id
 d75a77b69052e-4aba263f133mr68094941cf.19.1752771171929; 
 Thu, 17 Jul 2025 09:52:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ab6d02cb7bsm48466511cf.66.2025.07.17.09.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:52:51 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:52:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 06/14] net/sxe: add filter function
Message-ID: <20250717095249.6348a1ef@hermes.local>
In-Reply-To: <20250716082930.83026-6-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-6-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:22 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

>  
> +static u8 sxe_sw_uc_entry_add(struct rte_eth_dev *eth_dev, u8 index,
> +	u8 *mac_addr)
> +{
> +	u8 i, pool;
> +	struct sxe_adapter *adapter = eth_dev->data->dev_private;
> +	struct sxe_uc_addr_table *uc_table = adapter->mac_filter_ctxt.uc_addr_table;
> +
> +	pool = sxe_vf_num_get(eth_dev);
> +	for (i = 0; i < SXE_UC_ENTRY_NUM_MAX; i++) {
> +		if (!uc_table[i].used) {
> +			uc_table[i].pool_idx = pool;
> +			uc_table[i].used = true;
> +			uc_table[i].rar_idx = i;
> +			uc_table[i].original_index = index;
> +			uc_table[i].type = SXE_PF;
> +			rte_memcpy(uc_table[i].addr, mac_addr, SXE_MAC_ADDR_LEN);
> +			break;
> +		}
> +	}
> +

Please do not use rte_memcpy here, instead use memcpy which has compiler
can check better.

Same in pf logic.
