Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52910C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 21:15:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6F1E42E76;
	Mon, 21 Sep 2026 23:15:21 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id B413F40B94
 for <dev@dpdk.org>; Mon, 21 Sep 2026 23:15:19 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747ed6d6eso34282935ad.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790025319;
 x=1790630119; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dasRi+zB71mnATaaWe3J0ktHhZqsge2S28kvEuHrr0o=;
 b=h1DCjSspFU7H6fUqSMSnhJD5G4b57hEAgKdBUcez0ldmh45OfqA4fvz5IrzHYv2ia1
 YzHl9P8/MfzVfKwd82AzQtaTL5aAPy88iJacTlk4viq18Tv8K4q6lAiwccibyvlu3iQz
 49NwmqLZpSWl/yNlOC3Y6av3HGtJKqxDCmrISb3z1kUzJkRrE14YHq0Qm26q2XZCCexG
 nnr7q1IXvV9KtVXFwwN3RdpJZX1p4FMW6M+TfHa+VYYbIpNWb+F2fLYJ0C+ezXvS1nef
 d1w4XuTVbLAra6N0ZRk095EY819bIE1eGSC8PqRY1USCdEXLUYQQi1O6bw3fp1lp9Nlh
 Wk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790025319; x=1790630119;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dasRi+zB71mnATaaWe3J0ktHhZqsge2S28kvEuHrr0o=;
 b=qfTieHdlGIy50hY/lyv//rmdtpBb0HoXfQWg+Zp1vqZslwxylWDEgAdCJtsGirIByF
 f6S8J55tFmjfp5GpiVEi+/YE5DRZAXLmAeM2uPRSayC7g7LIoE7YfLx4OW6FU3AlCf+/
 +Xo+A+nOS9xGGAx3NU6ibEmya40NE+WbgrO27Gji0IEYLjhR9dHLGuVqgEacQO5QK7v8
 kP+G9C34GsRBuHIvMcqPJdALGakVvIToIDMHyldXtMh22IvcxWixvr2VKT1Es3NG0RJY
 rq5Df0s9EDjwtIleMWKgwMDsn8KqCCANmoS5DyWbjYqQbu4xQe6v2W7LtFJ5129U43Z/
 soPA==
X-Gm-Message-State: AFuF++mwvuKMjdVGTg2UdoqjuqTEpjJN9Fdw3aqpSguZjkAvleu8fZ2y
 xwZIOUOFqotz5MLJoCrXWewYk8os7LaCsEGN0HjudiFeZepll8oZVdpnINJrDo5fhnw=
X-Gm-Gg: AYBFou1sJ5y+a9NQvcWDvU3fpE/LDxnD5sV67++EcOv13xRa+sqdw+2rKtzT5BrDUhD
 8U2r0DZd9ee6nkPSvt72w6HaCn2cs9veufPmQfmCIVEu9/EWnbo0iVOsD7P7KB+QxJsOR9vuLHO
 kuaiW6fEvAnEVflSrDZnlBBMGvl9Ff67v4TPyUivV49Je8m2QEi/FFNzmU1upunvxaz+u2Ibtbb
 6tdkfHK8gctxuNpXyh13GJg2HY5uRakwyyVzy7yKOQlPLYB+Yjv+1CrPr7f11CtXJ0RNq5tBKf6
 fQ06+nQZGSG4etjES9r3snE/me/HjS7MtQkCZvGIaFSyOb9mtp4UoD3xBewWnlYOKMS/9cR48XX
 Qcn+bHMLEHQbPpZKwRh2du2ItNc818A06+blE3P8O0pll7utIbt0RTBytHimXVLORYswDLKN7i6
 bE8wTTKJ6w45Q9f0o0kDxKWzZ0Z8zExI/xLXD0oknXfQtDCwA4+adrAzusbcgfdyuQ+tvTt5qfv
 eE5DKMAFBf19NvRrMRN5cB1qN3q27Jx0AZFbUCH
X-Received: by 2002:a17:902:d4c4:b0:2dd:ad74:6d21 with SMTP id
 d9443c01a7336-2ddb1bca13fmr180314985ad.30.1790025318578; 
 Mon, 21 Sep 2026 14:15:18 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5b782ebfsm697935ad.16.2026.09.21.14.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:15:18 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:15:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Aleksandr Khromov <haa@amicon.ru>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <konstantin.ananyev@huawei.com>,
 <olivier.matz@6wind.com>, <sdl.dpdk@linuxtesting.org>, <rrv@amicon.ru>,
 <stable@dpdk.org>
Subject: Re: [PATCH] net: fix signed shift overflow in IPv6 phdr cksum
Message-ID: <20260921141515.759647f5@phoenix.local>
In-Reply-To: <20260918074729.79205-1-haa@amicon.ru>
References: <20260918074729.79205-1-haa@amicon.ru>
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

On Fri, 18 Sep 2026 10:47:29 +0300
Aleksandr Khromov <haa@amicon.ru> wrote:

> In rte_ipv6_phdr_cksum() the next header field, a uint8_t, is promoted to
> a signed int before the left shift by 24. For protocol values >= 128
> (for example IPPROTO_SCTP), proto << 24 does not fit in int, which is
> undefined behaviour (signed left shift overflow) reported by UBSan:
> 
>   rte_ip6.h: runtime error: left shift of 132 by 24 places cannot be
>   represented in type 'int'
> 
> Cast the operand to uint32_t before the shift so it is performed in
> unsigned arithmetic. The resulting value is unchanged on two's
> complement platforms. The same idiom is already used in RTE_IPV4().
> 
> Fixes: 6006818cfb26 ("net: new checksum functions")
> Cc: stable@dpdk.org
> Signed-off-by: Aleksandr Khromov <haa@amicon.ru>
> ---

Looks good, but there is also a pre-existing byte order issue here.

Review: [PATCH] net: fix signed shift overflow in IPv6 phdr cksum
Patchwork: 169805

Applies cleanly to main. Fixes: 6006818cfb26 verified; the line was
introduced there and carried over by 1a2b549bb4 (header split).
Cc: stable is correct.

The fix is right. ipv6_hdr->proto is uint8_t, promoted to int, and
proto << 24 for proto >= 128 (SCTP = 132) overflows int. Casting the
operand to uint32_t makes the shift unsigned; generated code is the
same.

Info

  drivers/net/hinic/hinic_pmd_tx.c:740 has an identical copy of this
  code with the same UB:

      psd_hdr.proto = (ipv6_hdr->proto << 24);

  Worth fixing in the same patch (or a v2 as a two patch series) so
  the pattern does not survive in the driver.

  Consider rte_cpu_to_be_32(ipv6_hdr->proto) instead of the shift.
  psd_hdr.proto is rte_be32_t and must hold proto in the last byte in
  memory. proto << 24 only achieves that on little-endian; on a
  big-endian build it lands in the first byte and the pseudo-header
  sum is wrong. rte_cpu_to_be_32() removes the shift, is correct for
  both byte orders, and the compiler folds it to the same shift on
  little-endian. Not a blocker since the endian issue is pre-existing.

