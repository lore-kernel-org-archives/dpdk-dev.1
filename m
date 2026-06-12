Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AC0CD98CE
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 15:20:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 264B3427B7;
	Fri, 12 Jun 2026 17:20:15 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 061FF40279
 for <dev@dpdk.org>; Fri, 12 Jun 2026 17:20:12 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-137dd4cc208so696351c88.1
 for <dev@dpdk.org>; Fri, 12 Jun 2026 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781277612;
 x=1781882412; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7bJLdW2XS/lXtNg1pkgBw8ioJcUuuw+2gUybll7NOY=;
 b=ECaubxcXOQR4Ii3xOKnz4bUcXQP3JYqlVnFmmt7eGddPJdx1r5/M+0kyQWpq40IHIM
 Cwmp7A4d9RYJJ+/hxXl20EU4CDIeLRuDtYhlBTqIDvokRCmNZdjwGm53EbADUU0E3l09
 urOtQzwLNWpPe824xUVaBnPA3pCdo1t6cd20A1GrFrXRKsGCp+44PDP3c/alJUndVfD2
 BdVm8X88ju0xP29c8PBA8LMfKJoY4mw5Ta4NdnlJN8yLavnRxw5ol6e3O82Uyn2WPg76
 fXKDreanKdAEdb7N+NZagZCASUBmHEZEf3tmrbGsKQSSqdrQulC1vBIyDr++1asRCz3Y
 Uw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781277612; x=1781882412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D7bJLdW2XS/lXtNg1pkgBw8ioJcUuuw+2gUybll7NOY=;
 b=IIkt7dF1gvMU3kimpHKr3+gsjTQZyXJCe/a3hJ6dHw8l25G6F/f2MdqsqmHo2qC4N9
 iaugBMw2QPsNhjvCVrS9eIK+K0zwXJM2yVI0pGb+ovqhpT3fas4wxSOCwqMz1Em9GGOy
 IXfq/R0x13x8rEWqhCydiegZzjzy5i42Wowwz6GLAdnWRIywD9j83MYHldUvGixzQRho
 zCcBjDAS+6SlsVoUgSV6l2Z+xTbIVZxMBBLYOW3c19yTmFBmotvV7tBmkb5maCu1IAgd
 gVMi9oLmBQM/VMA6lDC2dAY4uCvfchxCOEuAv3WUUjKR8GNJjpsGdo4xXpab/aSrlK6m
 Y9Bw==
X-Gm-Message-State: AOJu0YywZU9/hgvmo3PJ8R6cwLlwVXwzh9dMGubS4ZjDWPKa+yeX6pxd
 4hPW+gWYSKnEwptpRXR3iXP1xfmRd3rYjClAku7jzPS9ytaOQ2Tao61tHIrpGhOF8IY=
X-Gm-Gg: Acq92OEr85jMFs8MXaLuU+M0PEZy9KvBn3CuAJNoWoMLXoNlNZfLEddZOwj9JC9xM98
 EtKjfeNssgVD9c5JNr3nuFgOTSrEzx6vdCpMwoGBRFIjsJ4N5R7bjf7ogaVeI+Q2JwW9D9eG0Lg
 4U/OPcJCHSZORRIGYgIoY1OZ6yHQbHWyHuf2Hs3CeoAOVkD7qClgGeWczC2tSn7tlRygJxXfly2
 wdFeEmZZxALvxY6o0TDmEfx3GErPwHsdKPMCZq/7YutsZBCDPVdvu/dMB0LTtTuAxXNgdhzoyFv
 6y49CrQ6ro4by1Rp6TKA6uKRO8T1WF179rusLOW53K8FABBMci5tIFhnCn4HrfnDPNKdd+pJlPI
 7tsIATMoyK0FaEVvS2PhgjHWF3WZBH1HX8ib1PEM5uj2KVGOhSZK6Vs6Q0qc8BrcOr78TcYoBLh
 gOswJt25+r25CxCUaZMHOZl99V+trcwUu+fu0rHbKAbJ0Ba5ZpPKGdjifO69nTT+L1
X-Received: by 2002:a05:701b:42d3:20b0:12a:8122:24a9 with SMTP id
 a92af1059eb24-1384b438985mr1266679c88.22.1781277611734; 
 Fri, 12 Jun 2026 08:20:11 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea43f69sm3540925eec.20.2026.06.12.08.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 08:20:11 -0700 (PDT)
Date: Fri, 12 Jun 2026 08:20:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: <dev@dpdk.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <yangshuaisong@h-partners.com>, <lihuisong@huawei.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: Re: [PATCH] app/testpmd: add padding mode to txonly engine
Message-ID: <20260612082005.0bf14115@phoenix.local>
In-Reply-To: <20260612073715.2739007-1-yangxingui@huawei.com>
References: <20260612073715.2739007-1-yangxingui@huawei.com>
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

On Fri, 12 Jun 2026 15:37:15 +0800
Xingui Yang <yangxingui@huawei.com> wrote:

> Add a new padding mode to the txonly forwarding engine, which allows
> sending packets with configurable small sizes without standard L2/L3
> headers. This is useful for testing NIC padding logic.
> 
> When padding mode is enabled via --tx-pkt-pad-mode flag:
> - l2_len and l3_len are set to 0 instead of standard header lengths
> - Packet data is filled with a static pattern instead of
>   Ethernet/IP/UDP headers
> - Minimum packet length validation is bypassed to allow small
>   packet sizes (e.g., set txpkts 14)
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---

Why add yet another setting to already bloated testpmd command?
Instead I would suggest allowing user to specify any length from
14 up to UINT32_MAX.  The code to format packet would need to
handle it there.
