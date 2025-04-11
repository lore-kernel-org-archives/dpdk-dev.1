Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80360C36010
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 13:45:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67DD9406BC;
	Fri, 11 Apr 2025 15:45:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0E5BC4025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 15:45:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744379105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u3z7pZIGajzaN6G0C/9zS98WDHtzWWIVWwjdy1bbpMg=;
 b=IA3lBtPXmQuR4arydBB3Fc3tegXN5T68eCDKnARwOHWU6lKBaE1pmnOTbaYBsz6D4Mjgv6
 iz62j6G8sdWU+c/F1K8FYgkBNw7bLlCmKKNrqjvbQnnhgkO/x7qRBfi4I8VidNRgjPv5Z3
 myYcGXy3u/QckOvwyfzMfVCJtScy77Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-gV8nanLVPIW1L0UmoQASBg-1; Fri, 11 Apr 2025 09:45:04 -0400
X-MC-Unique: gV8nanLVPIW1L0UmoQASBg-1
X-Mimecast-MFC-AGG-ID: gV8nanLVPIW1L0UmoQASBg_1744379103
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso14058085e9.1
 for <dev@dpdk.org>; Fri, 11 Apr 2025 06:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744379103; x=1744983903;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3z7pZIGajzaN6G0C/9zS98WDHtzWWIVWwjdy1bbpMg=;
 b=bDy3u4FN/ETYk11gWEkMlEWicPjCTY165dc6qEPhk4pewfOY3EPS3rJZ4pGAUEnfop
 1VxyvA9owqd2iXHCrDADKbpaokywOcmNqP82HRk2rPuhBWyalUU0QOJDDiEsqBNVznNb
 kcqAsT0qZgdnHbtTFk9a85cSEC2pXQPl3VeJVG0gSHT5MaZfiJW9HrULE22LR+FZIRnT
 ScjVH1PsGmT4sGaBSd5jNwH7BR9pFcnksJqWlXfZVvwtcK+s0l5U+rttJFTzsWzHZgcx
 rC09fKaz2GAqn9jkwgzWFJAvBYZZZEmUtg8K1ELKUM5PJxERmmY16Lo1+SvznToAgNwV
 KBXA==
X-Gm-Message-State: AOJu0YwOFQpW6UUyBymIW2tkSY9Z4plcDnla9BrPM7AM8hcjmsaYnDN0
 q84LdKtnuby64mIgV7UGsjvIC6dx/qL4GlDn6KE8XfGJB3dBYQd8X3lzotUGzfDjIDsCpWkcj4p
 rx8HX7CTTK7lWVpE0iAKCiSLUh0caOm9qsWoe82kN+cnAAPiO
X-Gm-Gg: ASbGncs7Xg6ZjMiV+I1KfpV9qAu9KNq3UsWtSL0olND7BwFLsbhIWuhSpBZr+ujDHga
 vXTQh1iCXSugC+y+De7wWlqcrlDe8FXP1b3q1vgzdT7mp5FsgzvNoR3Lu/XPZBs3EQRpmb9HdBr
 SJiYjevPWK7KWwb8Btwq8DMSTD9FQsbppV4dSblqGwwToP5sO8hRwY6tlVxxHc9VVeCdtO4PSnp
 Opy611/1dce2UeIBc6eNSTmltypQAq9DX8UdIRF7yYr8UVbnm8R5xvt5Wf+IelBIk1+Yuqa1KZX
 75qrnKG3l3W1
X-Received: by 2002:a05:600c:c83:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-43f3a926c70mr26546395e9.4.1744379102885; 
 Fri, 11 Apr 2025 06:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi221lKf4G+LqTq/v7xjcjjEr3f/+ewoIvnkWe9yMXVoKWlI3olGhMPf67rZW+TtV+vTf91g==
X-Received: by 2002:a05:600c:c83:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-43f3a926c70mr26546135e9.4.1744379102507; 
 Fri, 11 Apr 2025 06:45:02 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.128.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2075fca5sm90988745e9.32.2025.04.11.06.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 06:45:01 -0700 (PDT)
Message-ID: <51cac182-1eca-4a78-80ac-ce686d88ea47@redhat.com>
Date: Fri, 11 Apr 2025 14:45:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.2 patches review and test
To: Ali Alnubani <alialnu@nvidia.com>, stable@dpdk.org
Cc: dev@dpdk.org, Luca Boccassi <bluca@debian.org>,
 Raslan Darawsheh <rasland@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>
References: <20250328101435.250876-1-ktraynor@redhat.com>
 <bcf9bb55-af24-4191-afb6-6ac01a2c89b3@nvidia.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <bcf9bb55-af24-4191-afb6-6ac01a2c89b3@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zmHjx9wOK5gHc3EkLRhcs_ExpqV4MA4PVP78GTysHC8_1744379103
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 10/04/2025 15:40, Ali Alnubani wrote:
> Hello,
> 

> We ran the following functional tests with Nvidia hardware on v24.11.2-rc1:
> 
> - Basic functionality:
>    Send and receive multiple types of traffic.
> - testpmd xstats counter test.
> - testpmd timestamp test.
> - Changing/checking link status through testpmd.
> - rte_flow tests 
> (https://doc.dpdk.org/guides/nics/mlx5.html#supported-hardware-offloads)
> - RSS tests.
> - VLAN filtering, stripping, and insertion tests.
> - Checksum and TSO tests.
> - ptype tests.
> - link_status_interrupt example application tests.
> - l3fwd-power example application tests.
> - Multi-process example applications tests.
> - Hardware LRO tests.
> - Buffer Split tests.
> - Tx scheduling tests.
> 
> Functional tests ran on:
> - NIC: ConnectX-6 Dx / OS: Ubuntu 22.04 / Driver: 
> MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 22.43.2566
> - NIC: ConnectX-7 / OS: Ubuntu 22.04 / Driver: 
> MLNX_OFED_LINUX-24.10-2.1.8.0 / Firmware: 28.43.2566
> - DPU: BlueField-2 / DOCA SW version: 2.10.0 / Firmware: 24.44.1036
> 
> Additionally, we ran build tests with multiple configurations on the 
> following OS/driver combinations (all passed):
> - Ubuntu 22.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.
> - Ubuntu 24.04 with MLNX_OFED_LINUX-24.10-2.1.8.0.
> - Ubuntu 22.04 with rdma-core master (9e9a957).
> - Ubuntu 24.04 with rdma-core v50.0.
> - Fedora 41 with rdma-core v51.0.
> - Fedora 43 (Rawhide) with rdma-core v56.0.
> - OpenSUSE Leap 15.6 with rdma-core v49.1.
> - Windows Server 2022 with Clang 16.0.6.
> 
> We don't see new issues caused by the changes in this release.
> 
> Thanks,
> Ali
> 

Thanks Ali. I will add these to the release notes.

Kevin.

