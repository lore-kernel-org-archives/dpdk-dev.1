Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A05C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 17:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47D5140E34;
	Mon,  9 Jun 2025 19:14:00 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id C56F24064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 19:13:58 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7d098f7bd77so520988185a.0
 for <dev@dpdk.org>; Mon, 09 Jun 2025 10:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749489238;
 x=1750094038; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFzYv7H1JJVm4aFoQr5X0sdTXtUI8wh4aXtpXL2oPcI=;
 b=VFd3shhyVZK+LzfGdREZk1KuVb+nVl+4iMdWrrwUABojWpiSLj5dpuIu9A8q0oOtHI
 H/A51yEeRrCDaRGorpGi32n1wuEPcuUCIL1XnM6LlcFaVNfXJZpD9s5TTWRvI+wT38vI
 MiCqhZ7K8IBr2F08FTofti2W01JgYtbUtIoCwn0/WR2NFhN2KOlukqHjZL2jkWjY+Vyd
 mlkw7egZpSuhsa7+0nGydIzIOWLxyaEjgdD0AIxUICao2FYPjYpVCFOrqjZ/DV9GhjKo
 QAWCrxSuCNks9+36CZU/P6sJTdPOPjHjUOGF4WwTm7NqsIohv3A6TsLm0C51S/2zN6kf
 VdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749489238; x=1750094038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TFzYv7H1JJVm4aFoQr5X0sdTXtUI8wh4aXtpXL2oPcI=;
 b=HqHVn5Sqxkbop2lbW7SRy0tkwFPwJec4+Wayq8whMeN8AGplpCu0tf/3/ir/J6v6IK
 Qc7Edpt9VyG71L0JzVjsIR74oBpvRx79ItRcT6cBAsZLp8m6sQQsSdFrRovgHF2oCRBG
 kDYjeKCGnW43MJEmVKfOLnVec5Rjuv6cNM2LnUxDlEqBxEPq2U3IPvPX63saa+AL0doF
 1gHUCS13BdU8pEIzLZB9p/ziu5w00yI6kjgneJW+M2QvfdTtD3K040PfxnKKpjHBfKLF
 ZgS3dY6lb1+EIBNA0awy/rggIpuNkamK/MPypHoXOzzGhL4eLMrQzonVwsbYJhfzRNpj
 5h+w==
X-Gm-Message-State: AOJu0YxAHpHSnfX6Xe33JyaPNBoLXBsSngDhPRZR2hWk+fBGcqS0kd+X
 umN+VysiCfUU9r2vdZbkqEN7gRqHJChWCUL7qloJtr9qAg3YcuBH3nxDb2kexssS1fk=
X-Gm-Gg: ASbGncuvGYiLQaC6HJre3Okk94c8XxHcilNcFB9qQg+ue3revCwHOPnewNwJEvCUIgQ
 Uw97mpMvHCb5RuSs2R8tIE3c1WjA/+V2B5COmL4nfFIhn6DefFNbi4DfwL1gkTExrTIQHbV27oR
 cVUmzOQYpnPhTCY4ujfg6vpezp64Coi7lZkTjzdHc/QxZzYJkp+IH+enQearK5Wa7Fbp+w9IsWF
 BqQ5xevgm5N3/YN8Lx93Wkaiw9o9rybiWFKg/QfwZPQRiSDmsq/vFAbsK/sxKwNs8xVwr8uuEQC
 XudlA8EtCdlICtZWCyAnVdrfUB/s9zezELdaJDkbPY41skIZS9sH2USEQi6z/uKsN6ChykzCccp
 nSCVkSvqsBwHvpbzV+hnMr22FXhW37r1iufc4zH0=
X-Google-Smtp-Source: AGHT+IEDPcVoP4strFeu2/76biO3iPZyXWWxknR+NYD8OXX55rrXnPWwGuqS53rl6uTta/eQG1bE5A==
X-Received: by 2002:a05:620a:4415:b0:7ce:ea5d:abfb with SMTP id
 af79cd13be357-7d39d8ad67fmr59005985a.12.1749489238172; 
 Mon, 09 Jun 2025 10:13:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d2517fa678sm569834785a.22.2025.06.09.10.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 10:13:58 -0700 (PDT)
Date: Mon, 9 Jun 2025 10:13:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: <dev@dpdk.org>, <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <liuyonglong@huawei.com>
Subject: Re: [PATCH 1/3] net/hns3: fix the hardware GRO function is abnormal
Message-ID: <20250609101354.45732d12@hermes.local>
In-Reply-To: <20250609130651.2752977-2-huangdengdui@huawei.com>
References: <20250609130651.2752977-1-huangdengdui@huawei.com>
 <20250609130651.2752977-2-huangdengdui@huawei.com>
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

On Mon, 9 Jun 2025 21:06:49 +0800
Dengdui Huang <huangdengdui@huawei.com> wrote:

> +	rem = dma_addr & (HNS3_RX_DMA_ADDR_ALIGN_128 - 1);
> +	if ((rx_offload & RTE_ETH_RX_OFFLOAD_TCP_LRO) && rem > 0) {
> +		hns3_err(hw, "Hardware GRO is not supported when mbuf DMA "
> +			 "address is 64-byte aligned");
> +		return -EINVAL;

Best to not break messages across source lines, it makes it harder for users
and tools looking for error messages in the source.

I.e do:
		hns3_err(hw, 
			 "Hardware GRO is not supported for if mbuf DMA not 64-byte aligned");
			 "
I can fix during merge if that is ok? or you can resubmit
