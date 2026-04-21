Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F82F89244
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Apr 2026 10:02:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8962340647;
	Tue, 21 Apr 2026 12:02:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 15A49402B8
 for <dev@dpdk.org>; Tue, 21 Apr 2026 12:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776765763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DrXxYMa2cjh9awhPj5EP6RqpNUr+kJ/Sk50wv8WDZOM=;
 b=bZ0WI5FMBJ0Xy+H/Gs5Nc+ZVIFm8hLN5EOjlfTe7wR7osg8l04RPDji7Mg817iQ0MCo9wP
 B8UeyjJGYvDO8SXWJgy0kUHs/tC8//651CRAMRSAaPOMvpaSdJqhbSf39S0xLgCIhJPN5d
 yan2E1J3wdOGt9SFwM4NqsnTfasxKFA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-YgjaYeM4MAme-ONCoBw6GQ-1; Tue, 21 Apr 2026 06:02:42 -0400
X-MC-Unique: YgjaYeM4MAme-ONCoBw6GQ-1
X-Mimecast-MFC-AGG-ID: YgjaYeM4MAme-ONCoBw6GQ_1776765761
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d7757463eso2775318f8f.0
 for <dev@dpdk.org>; Tue, 21 Apr 2026 03:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776765761; x=1777370561;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrXxYMa2cjh9awhPj5EP6RqpNUr+kJ/Sk50wv8WDZOM=;
 b=BCkLJuRhzCCHJTW5ZAHU/cvfNYkaCCqG2qRg2RGDQtgkUQwdXqLCCcu6SHa7cPhxr4
 jbxhUW14qPdXmoMWSj54zIyG6jTHa4t9f7pamn73n/hvFnSR0MmUd+jPj9Kb47Xx3Ifc
 2Y2k8B/K1SJohWmCi5jtipvZIwDMDpN/Pz5Ar3qHa6/tyYdBJNE1W4x41Mv/niFjoFPB
 tRbYt44HuEjf1gPGGxGUojeRVmf4mo1/GwBPs4o5uFv7GcNwh25PREokXb3zqY8e6M9x
 TYoqdtnmpneG5cOr+7Euaaupeeky8Ov08gEBjXn7D7g5e33/hpAARpEYLpjF46CLlOUE
 UZsQ==
X-Gm-Message-State: AOJu0Ywpl4JvWjcsynn+OaD0z/xpweBmhiUTOIuqpvrSXkJqaSYBPZpW
 ePugj8DYH0giEZkoCd/4zmR8ZJQ9AJl3l2VHr1zhVS6cxxi5isfRA0iU5hzzJ/M/IUDFTkvttCh
 CYThEve+TR+KQlHel+ehHZG2LLh0XzifwGtb6h5Ff8WBZ
X-Gm-Gg: AeBDies5SR+q1181LQlgoUzZv2V7Pvr+ejZk1lb0c2zCCED3K5C+vW5SwaoBhjEaPxZ
 DjBEGYGS3Cb7SGBtfxNLFfK4RizkPjUpplpmYltw+LgubdGkpV8xWbdvfBvIeIecsSw503yFsc6
 W5yd5Rq13S1tr1o4mDyxxR7fRoyKjuEySNBb9kUV9FFdDUyuVSACsoaPkmvfWKVWZPRWDsouPjy
 7fB4WvbGO4mz5cCBpnD3h0WxICozDVDnk1k0AUpvFPr8TB9vBAKdE4RLQ7oWZLxBeNeXBvA7pc6
 si90q/7Qef0PfhpI9fQPleOrsr3x5MWw2Um+5Yo+XNic+/eS2/6SGk+zxoP5ngu8VEgB9ljGz3R
 SLJvhDgGWyG53v/b8aLuAR8viejfBtUiZnQ==
X-Received: by 2002:a05:6000:2dc6:b0:43d:7512:6f7b with SMTP id
 ffacd0b85a97d-43fe3f35785mr27232282f8f.5.1776765758209; 
 Tue, 21 Apr 2026 03:02:38 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc6:b0:43d:7512:6f7b with SMTP id
 ffacd0b85a97d-43fe3f35785mr27232092f8f.5.1776765756529; 
 Tue, 21 Apr 2026 03:02:36 -0700 (PDT)
Received: from [192.168.0.65] ([78.16.130.40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4411c9f4f03sm6943211f8f.1.2026.04.21.03.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 03:02:35 -0700 (PDT)
Message-ID: <3218ea91-e9ed-4a14-a17f-b4aa9fa68061@redhat.com>
Date: Tue, 21 Apr 2026 11:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 25.11.1 patches review and test
To: Riley Fletcher <rileyf@linux.ibm.com>, stable@dpdk.org
Cc: dev@dpdk.org, Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, benjamin.walker@intel.com,
 David Christensen <drc@linux.vnet.ibm.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Ian Stokes <ian.stokes@intel.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, qian.q.xu@intel.com,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon
 <thomas@monjalon.net>, Yanghang Liu <yanghliu@redhat.com>,
 yuan.peng@intel.com, zhaoyan.chen@intel.com,
 Shani Peretz <shperetz@nvidia.com>
References: <20260402164454.669125-1-ktraynor@redhat.com>
 <0ccdfe867dfbd01e6d13017c00465696fafe0d46.camel@linux.ibm.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <0ccdfe867dfbd01e6d13017c00465696fafe0d46.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FzCmXtGhrA5V09pK_ixSQVJBTUKB0Ueom3QLLfJLaVw_1776765761
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 4/21/26 6:47 AM, Riley Fletcher wrote:
> IBM - Power Systems Testing
> DPDK v25.11.1-rc1
> 
> * Build CI on Fedora 40, 41, 42 and 43 container images for ppc64le
> * Basic PF on Mellanox: No issues found
> * Performance: TestPMD throughput single core tests
> * OS:- RHEL 10.1  kernel: 6.12.0-124.39.1.el10_1.ppc64le
>          with gcc version 14.2.1 20250110 (Red Hat 14.2.1-7)
> 
> Systems tested:
>   - LPARs on IBM Power11 CHRP IBM, 9105-22A
>      NICs:
>      - Mellanox Technologies MT4129 Family [ConnectX-7 100 GbE 2-Port]
>      - Firmware Version: 28.47.1088
>      - OFED 26.01-1.0.0
> 
> All looks well on our end.
> 
> Regards,
> 
> Riley Fletcher

Hi Riley,

Thanks for testing this. Great to have you onboard testing LTS!

thanks,
Kevin.

