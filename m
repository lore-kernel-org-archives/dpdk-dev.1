Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7FCA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 14:20:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD63640657;
	Wed, 13 Aug 2025 16:20:01 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id CC24940265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 16:19:59 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-459ddf8acf1so56359005e9.0
 for <dev@dpdk.org>; Wed, 13 Aug 2025 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755094799;
 x=1755699599; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDedYmwh2Ae032Mgrbeo/fu5Ee42P4hvTrpX9CCEQEE=;
 b=vhhzJ8oPA9qZ8IcRG7lnyaxFiTq+2VStV9hZOOFBPPUQ63Zct6aHrijBGGojGl8O6C
 RvGGEwAEvDLTuwVsa29YTfjTAk2YmSmbnKmibN6akOU/xmat7vWDgPN+LkGUmYSgD4G7
 AHpYHMfQcJVtucUWebKiK3rmhVkMWodAt6UmbaS6s2EI2jk4joZF1dA6MW7t8ZeUERHY
 A6VAg8fm2owiGAqlfGzopU1h4gJjtAuXUOlTybwGnm9ApdjegobCbhOY2c8onnozp58m
 2M1PrST1mEyIfYyU13CnHoXSns4DpGUGeU1wmIY0XxJQEFS/JFExYEdod416qpg+jbID
 zHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755094799; x=1755699599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDedYmwh2Ae032Mgrbeo/fu5Ee42P4hvTrpX9CCEQEE=;
 b=PU9+Nhgm1rpsIsZYlt4iVWeFv7LROrQkmVH2/d2IEwOiID7aIuKOaSQY35KzGA51Bs
 SWIyWRQKb/95Wx/6//LVEdQTza/hhUUQfNenX6CKaqmbe0dMZlRxzmW/02j67bZ8h9QI
 DWRXbXbUnf+dMLam8NE9EURfhb4SVFx4bJ+YcTLCV6++Sbz2upChvygmZF1Of+ETHfYW
 Zuytz9bIp8oDXWNsMgcR1wezXkROOaEwwI1LrS45XAd0A0tVeEPbSrVvCf3FfGUTvPtq
 tTzST/fSfmEHrUIdktyQFaek7XkCW0wI3vTbfp0o/9OcD9cxfAgEbP/jJn6Zrc29EkHS
 0O+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4xlm60ZLisxQmwC9hFVwehG4Bn0GwqUkF0RpzfLdrjogfmDT0tL9V8D/Ao8lcTe+qDQM=@dpdk.org
X-Gm-Message-State: AOJu0YyhBvUTMRfboqKKnEQs+Jtz6tQXoTi6+ntOwowcMOfqRyYinTZv
 2oxFtEQ4d9hKKXyTJHSGSCcn9MzcET2V09246lY6x/sPE9cNhEDCTAh6X5bJWfUUA5HFyEmSPWU
 RcMKV
X-Gm-Gg: ASbGncuP40mnNiv2HS7/FdJQcpy4ZwJ26q5s/8UITrxY/SIHNv4giZ2LzQb4vuaDf2Z
 Ks+XXaF2SHItTS4r23xEFWwPTOGFqurqSL/ULlVtnCKmJMnk732BKi+IuFTWVM64zpLts1Nxc7o
 vVtfWv6OI8Ak7NytwErWYtXzxWKXEIKHOqJmyMKm+Pp7lliwEWSAGVdXGY/kyLA1ytBNS4yUSzg
 SwZ40ZsABU/iOO9U8dLuRu8w74+DZubdhQZkmZjmSnf+qPKTh6S6S6E5cS2uPj7IubziL3+2rM4
 0uGcqP8fNC9Fe3CW0XLtpDIMnOXlS6BJuuafM3a1/3YGWAlQGr4TA35LDwQoHz/g94Z33/NjQ51
 B1Xb0C2lFiiiywMnhZEFqVYKz1HwIT4oFpK7shMFVTB7x42UcrnKw4xsFBxQvilWF4BC6AX8IVu
 M4HCDR0yElzg==
X-Google-Smtp-Source: AGHT+IEmD2pjuGJl4MExxvt5pXTPuDows2X68CTK6UlYlXLOFIHsJsaR7Vnv7Tpa9K1ygnkgRufnGQ==
X-Received: by 2002:a05:600c:1c22:b0:459:d3ce:2cea with SMTP id
 5b1f17b1804b1-45a1aa6a296mr187435e9.6.1755094799402; 
 Wed, 13 Aug 2025 07:19:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a58f543sm4219875e9.20.2025.08.13.07.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:19:59 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:19:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, dev@dpdk.org, Kyo Liu
 <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v4 03/16] net/nbl: add PHY layer definitions and
 implementation
Message-ID: <20250813071954.03ee8017@hermes.local>
In-Reply-To: <7e666b72-f278-dc26-c24e-a48562a6fa67@arknetworks.am>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-4-dimon.zhao@nebula-matrix.com>
 <7e666b72-f278-dc26-c24e-a48562a6fa67@arknetworks.am>
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

On Wed, 13 Aug 2025 13:30:03 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> > +static int nbl_phy_setup_ops(struct nbl_phy_ops_tbl **phy_ops_tbl,
> > +			     struct nbl_phy_mgt_leonis_snic *phy_mgt_leonis_snic)
> > +{
> > +	*phy_ops_tbl = rte_zmalloc("nbl_phy_ops", sizeof(struct nbl_phy_ops_tbl), 0);  
> 
> This line exceeds 80-column limit. Consider: sizeof(**phy_ops_tbl) .

Current allowed limit is 100 characters
