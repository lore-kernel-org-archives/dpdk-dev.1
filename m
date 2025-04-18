Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D50C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 18:17:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74C03402E2;
	Fri, 18 Apr 2025 20:17:08 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 9B4A1402D3
 for <dev@dpdk.org>; Fri, 18 Apr 2025 20:17:06 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-223fd89d036so26386685ad.1
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745000225;
 x=1745605025; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGZBROJb/CRs1dwTkdL9egPTXGeMIqyZyLc826m1c7w=;
 b=xgLCATNz+mU74iVfceBwKARMOmD60nPLOMiJ8SVA+0JR3X5DK6v9dqlBDt/sCyzfu0
 HuvhyORLyyU3/F4ZAdTkEr6uq2KbVvDAfNIzIjtkPurM1JBk7+93jKV/aIQ4lSY9NL4f
 g/0LbLTgw3W+C7ro5a48zZywN325SJS8dzQpLd51KH0cvb/I21esbQDAJHIohJZ3wuOe
 0eVpY9mwPM49Faakc2pqq8KI34lxS+IWMeIfzgeMzzmGMcg33c8oN2qzVXkwwSKxHk3g
 qyCPTFGicKuqRfJ+/IawEXzPxMDGtrkt/PYSd0KwU9CA2SpjspdtTpRl+vJaDHxM8Asm
 HuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745000225; x=1745605025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGZBROJb/CRs1dwTkdL9egPTXGeMIqyZyLc826m1c7w=;
 b=v6ND4DToEU/kZKrHMxaLpBhLfJDQ7h+seuu5UczHU9iulrNKOYCxyRp0pg+lgK4wfF
 aLl1C5XYe9rspM/RE/28Wy5WYmC4ESHZhR7GlRztR9F5hEdOoc0XlfrN5pg0Mh4ZaCJ4
 tf9+AH+6Rop9nLIEwk9Cmmsqd0g1UnmkSKoQMHphsGBChNGdxj9yMHRJ0D1+7pyfNPCa
 2mcGY5yAYdVAxernYuFjTKWCEWs1qQipTQLNoEwqPs2ZVGc0yWTJWSXitt5ZfHoPIdYX
 h7IrkIiH0EbFHJeMmuwyNoNHdx48+6hit9aEjhiL+ODLR6xMyIn+aR75UieApCqISZdv
 MXCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi3kKfiT0m14Cs60ypb5NTts399SzvpTzcKeOIxwy3ffFcOQwH6kwn8qp1oEHNvuKAk2E=@dpdk.org
X-Gm-Message-State: AOJu0Yz3BlbtvfZXIYEq7NAeEfMfnylMOADcNwoMqnoEtT/jhldWL7Jw
 QewSugasDkZL8ma+nxn9GgKprCFDCOfib627Fhrs/GWJm3OAqYZS0c2QOwIPPgA=
X-Gm-Gg: ASbGncvRlsWuULSr616PETowSncfn7UpZEkTKRI//B2twgw5ihDgAs2viImDY+BExMw
 alchzXcvYbP2jkGCNJcXkkzOcjRaWwW5ymG+aybJmpQeORM3NYl+OVu+L2YvrDyPApK6HPX59Lw
 JIe7cPPAmgJSjVIsFVFK+c1nSgIzKXSJd+dgO8wj2KaEsiNsO+fCNxLETol5NX5t0b8C+fczC5g
 kUnnq2XNASMaOHiA6xml3hK+/If4BqithL69vDiVVSz7a0fwa0lVIas0RVrGjKWHlkzXL/ohO/K
 bHtvPtdFoSYK/FL+tbbf16K0UaDO98wku7x398Th/9e1bU1OCFrbhb2SBWvHmoeA9/GR0DeFxbC
 gWIy/pijv1exRLEu+
X-Google-Smtp-Source: AGHT+IEfY1GU5bVFVWvHDKs8dKpkjE5FwgmWtoeRkuYjWaZ4orqBTYO5wOTJhbMATaOVgA8pHZE8SA==
X-Received: by 2002:a17:90b:540e:b0:2ff:4bac:6fbf with SMTP id
 98e67ed59e1d1-3087bb3e7bemr5821333a91.7.1745000225571; 
 Fri, 18 Apr 2025 11:17:05 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df0acb6sm1560570a91.12.2025.04.18.11.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:17:05 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:17:02 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yuan Wang <yuanx.wang@intel.com>
Cc: anatoly.burakov@intel.com, vladimir.medvedkin@intel.com, dev@dpdk.org,
 stable@dpdk.org
Subject: Re: [PATCH] net/ixgbe: fix port mask default value in flow director
Message-ID: <20250418111702.2362454e@hermes.local>
In-Reply-To: <20250418074309.705337-1-yuanx.wang@intel.com>
References: <20250418074309.705337-1-yuanx.wang@intel.com>
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

On Fri, 18 Apr 2025 15:43:09 +0800
Yuan Wang <yuanx.wang@intel.com> wrote:

> The fdir filter should mask L4 protocol in order to process raw IP packets.
> However, the initial value of port mask is 0xFF and the filter will not
> process raw IP packets if the flow rule does not change it.
> 
> Fixed by setting the default value to 0.
> 
> Fixes: 444505f933f1 (net/ixgbe: fix IPv6 mask in flow director)
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yuan Wang <yuanx.wang@intel.com>

Ok, but Intel needs to remove flow director by 25.11.
It has been on the deprecation list for years.
