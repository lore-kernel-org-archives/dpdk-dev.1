Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B30EC88E6F
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 17:00:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E622940ED1;
	Mon, 14 Sep 2026 19:00:19 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id B293440A7F
 for <dev@dpdk.org>; Mon, 14 Sep 2026 19:00:18 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d8fb334e72so22995945ad.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789405218;
 x=1790010018; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5KMCZFywSUkRmWXYPijEm6MTR7+SLLQPUEjGOlkTEDo=;
 b=apgbd+QWqbTjb3qkb8zZIkN5bu5V4Wi4FRHX/KdnPRmSqqcwRVBZlS2kwkxD2PJeCp
 NiaF8cS/ItzpfkFYuKwz2PnnDefiT7+Mb7PjRXqtkiStPzKw8ut+ynxnkYn/iDw34dub
 YJcppa7bHnZZNZ+wDvOFl8eZAmHiBCYsKImCdS7y0O5QD/sg8vGDBpfhKZD2aJdcCefa
 GBa3cQkf/87V3tDD9mEz4znXprjJSjyshEXgdAtowk6O/znvb0C+szbCOL++YH5leNfP
 NdlmLZE31T4uEIkyVnV7ucHY1GngPOq/f2/U00tSIfQidzShIOc8MQoOSvAm6nr1GneI
 vSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789405218; x=1790010018;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5KMCZFywSUkRmWXYPijEm6MTR7+SLLQPUEjGOlkTEDo=;
 b=OJWq9oXJRhiyZ55EWO1IwZBaVTGCCpm9Oniydf+IgDJpsdGi5Gw/L8lgJYMK1Dx7eW
 PvJ8AB7PKop51q8XMhKBCQPuJWFOnek8PfRl4Xd7CjC3YoehXbro5TtWNvhb6yVdCVhZ
 1wwhZFCa42wIQd0HWBn1Ni05XRBG0KHhDbQNZZym2C3XoLTbMUZnl8KuyqxpgvdKJKoa
 8LXxDdfTWg6oQDt2s/F7NGo6lrxrzDsu+Uto440P8UKFamrS/ljSzJG6sPG0PCt7Rpkz
 CnEjUMb2kTj0tRM/+6ELTItG3vi2CwHpaOO50Y++cXPE5puLC0eAPUHbddv252s635M/
 1FsA==
X-Gm-Message-State: AFuF++n4WsB/QYlgiZoUBQ1dpfn4mafhj++a6omY4Gufz4obBycHXokz
 2aVrYSzevGtpc3XuNseR2ZB1/MsUmFInqyY6hfARTsBR7IDescFtxEV8Dhx42V7dAyg=
X-Gm-Gg: AYBFou1qwbpkwiXgy5lf7JPtmVgt5GV2dSPizcRsKG3uEg/KPrEQJFRCqJiAguQEos1
 IM9Wt0jJ+O0p6Nf9wT3VzDD1tOxyOwR1RAHRTaD7J8HkB+8vfAQhXejGOn2X2DGmQVE317ayGbl
 Q7fltqXaDEbdafaOJPgTo88igzmN3ttPFdeK77uncv3ZTrMeBtdbQlVSBKfa69ahEciE5EsM6+a
 s1Y2SPV4nOJcY09mIR6rpD4evFA23vC0BpEVn/y2f/NMY2SoimrR/DhOwV/kQjZCpWCngVA+DLb
 FGRFlGRpT99faINL2bIhKqsfxWybUC5djuY1Mt3J6mwvpw7zgRjvTKuy91R8VVYIYQ6l49ic8Cg
 wO4Wvvmu5m20vHq2UQbobOrcxOq1EUq3TSp/aEsPjsB1pib3QfcdoAAi8DPwkuVX0sWWPbAFamB
 527OjSDE1bxyE2JPX+bDh9wdGABUGqye+uUX5lYZO/yMrqroVNgZ97jmAFc//0On3ssOdsgPaYc
 ThakMCdKNxkRCmSZwLq1nKx0oLIY51EvH/QiQNi
X-Received: by 2002:a17:902:ce0a:b0:2d7:3f6e:5cb9 with SMTP id
 d9443c01a7336-2dd6c5ef145mr75432795ad.8.1789405217688; 
 Mon, 14 Sep 2026 10:00:17 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd3f0faed5sm46328605ad.10.2026.09.14.10.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 10:00:17 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:00:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH 1/1] net: fix L2 ptype for VLAN-tagged packets
Message-ID: <20260914100008.3e36f56a@phoenix.local>
In-Reply-To: <20260913233655.21866-1-ivan.malov@arknetworks.am>
References: <20260913233655.21866-1-ivan.malov@arknetworks.am>
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

On Mon, 14 Sep 2026 03:36:55 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> When a tag is discovered, the code does not remove 'RTE_PTYPE_L2_ETHER'
> set on function entry. For single-tagged packets, 'RTE_PTYPE_L2_ETHER'
> and 'RTE_PTYPE_L2_ETHER_VLAN' give 'RTE_PTYPE_L2_ETHER_QINQ' when
> OR-ed together. Clear previously set L2 type when handling VLANs.
> 
> Also, since 'RTE_PTYPE_L2_ETHER_VLAN' requires that the EtherType field
> in the Ethernet header be set to 0x8100 and 'RTE_PTYPE_L2_ETHER_QINQ'
> requires that it be set to 0x88a8, it is the outermost (first) tag
> that determines what the software L2 ptype should be. Clarify that.
> 
> Fixes: 1f250674085a ("net: fix packet type for stacked VLAN")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> ---

Applied to next-net
