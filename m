Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8640ECE8D4F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:05:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8FC340E2C;
	Fri, 14 Nov 2025 17:05:37 +0100 (CET)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 4F32340151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:05:36 +0100 (CET)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-7b8d99ad095so1773384b3a.0
 for <dev@dpdk.org>; Fri, 14 Nov 2025 08:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763136335;
 x=1763741135; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUUs+Xu56ke++Yao/xXZseWtCSGmexDgjy+S6E1/q+c=;
 b=jmLuEmxxCVPYLYYZW1fPHRT7qR6Apqf7ueq/DVzzsu1zrNRMpk6RrRsA4XEwfq/cC5
 /MMhEdS/5q0Q9KFP1A+vA7g9raJh9JapawORwKlHKeesU7l5HrSqVLPyc2eCiPk7KAnY
 geHU7IqT8yTsufxs+dX1DH5+R1Mf0gzK9RTLC5tgp3UEqWJManumx4PDFOqWM65Ggou3
 Ll4OXLkFDspVRXUtbJdIt9N2+GK0JXOxHpWvKdh1nChbWtF4bNWFAf8PYB9qfQl7Ub3h
 0hDlj/EsCA7KwKOJZi9G0FqXhusIbhXerG+V3WgH3pA0OHqjox0MWKdqgudQ54eiDUFl
 zm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763136335; x=1763741135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zUUs+Xu56ke++Yao/xXZseWtCSGmexDgjy+S6E1/q+c=;
 b=jphacfYMKBhMGm0DfqoD7Obf+d/CXSyhyIGTruKGmms9cS3AhFqxENy9eEt3pIbxeA
 YCQIGROeCsbomN7zFs/bOJieTwxGUo3bTmpRLac3Agx4c+yhiC3bvFBby/+yrcyIP6JO
 xGXdkVK6iCFfLEpzhUjCjXnvxd53aoy5YBhSWVq/EmrXY4b6NeRO4VjyyQCy6+A5NPe9
 BctGQ5s5CqII5E42qLcn2zolqXD3m2wAFO2cronfB+Fmpv5KWv2qV1Vc+IE8PpZVApbK
 yHWM3hyTq1NUO14Ww7zaedTatGL1qfQece6ejKLEKWge9S6elgkXSX1eo3w1lEFJ0ltB
 o4Og==
X-Gm-Message-State: AOJu0YwliA8qnylt/CemYBvNOUUlkSUmJ1qSoSoghT+GkRrqCnNvISgs
 KhHsTkihD9Vhfy/48SF54Yy4UgPlN05aqVVoH7/GbwzkeZKNdbpvVBSQbAjW14cIvMk=
X-Gm-Gg: ASbGncvQdipxcI5qfpRabzc/l25kg15GiW6CSs5UYC+OrI/oSw6Qi4SvOKe97aUjPbU
 1pxB3OtXeZdGQ6TXpLeDiZPtU2kdOcK9ZY2Oda7Z6cSmxVIbGMciqc+n/CIt/16iPlNB4O2MUEA
 dXZZRfOfkqHRZfzOZOUtSWUE15+cwVLkVdZ4gacmo5pY/F30B8AGfPjBRdLLeBqD7qp4b5+2J4e
 PCfV+i2VlqC6XaYI2mOWM00d3SSWt9/0xU1T1x1FDGB8sxWfi89Z336aT8v4adT8NAv3jBGQafv
 /bg7snGDzXhDtqYVlUXfB4pXS7zl8zkSokzMS28cvAWDQORu+HvPAL1CyQg4Ik2WIdPOVDvuiQI
 oDhsskHK6VCkTB6XvVY0BxTtgG4VngFl329OhKzjGTOm3KQZyzOIptxD+B6UB1+zwmYhGAkO9Ag
 cZ+3P1hgWoyQF1ZuUWyyHlK2MZRUKpkRRO8fKPRNyVYGDHGHeVgUl4dQA=
X-Google-Smtp-Source: AGHT+IFq0xF2CJ7pQkoiJnZ44832nmrWjsnkKrBajFwGQNOo70FFZd/Jf4NrOogkt5piArgCKLZajg==
X-Received: by 2002:a05:7022:4429:b0:119:e569:f850 with SMTP id
 a92af1059eb24-11b033ae64bmr1482065c88.7.1763136335068; 
 Fri, 14 Nov 2025 08:05:35 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49dad0aefsm9141275eec.3.2025.11.14.08.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 08:05:34 -0800 (PST)
Date: Fri, 14 Nov 2025 08:05:32 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Christophe Fontaine <cfontain@redhat.com>, stable@dpdk.org
Subject: Re: [PATCH dpdk] net: ipv6 link local compliance with rfc 4291
Message-ID: <20251114080532.1e86d13e@phoenix>
In-Reply-To: <20251114105751.54802-3-rjarry@redhat.com>
References: <20251114105751.54802-3-rjarry@redhat.com>
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

On Fri, 14 Nov 2025 11:57:53 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> diff --git a/app/test/test_net_ip6.c b/app/test/test_net_ip6.c
> index cfc550940306..e4642c9a39d9 100644
> --- a/app/test/test_net_ip6.c
> +++ b/app/test/test_net_ip6.c
> @@ -160,7 +160,7 @@ test_ipv6_llocal_from_ethernet(void)
>  {
>  	const struct rte_ether_addr local_mac = {{0x04, 0x7b, 0xcb, 0x5c, 0x08, 0x44}};
>  	const struct rte_ipv6_addr local_ip =
> -		RTE_IPV6(0xfe80, 0, 0, 0, 0x047b, 0xcbff, 0xfe5c, 0x0844);
> +		RTE_IPV6(0xfe80, 0, 0, 0, 0x067b, 0xcbff, 0xfe5c, 0x0844);
>  	struct rte_ipv6_addr ip;

Reading the kernel source there is also special handling to include device
id into link local address. This is to handle corner case where multiple network
cards have same hardware MAC address.

Perhaps DPDK should roll port id into link local address?
