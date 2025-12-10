Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4E9D3C92B
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Dec 2025 17:03:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B41B40B99;
	Wed, 10 Dec 2025 18:03:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BA3BA4028F
 for <dev@dpdk.org>; Wed, 10 Dec 2025 18:03:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765386188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ghRGa4GLwJixm7diNNNhFqZF38J0D9HLhk4x/axW4dI=;
 b=ah4C/irbxDq0lYnVVleiyPc8BFCnQ4T3iKAfdMcIl/jc6fz8nLEg/5SxcQz3H8cQv2kwVk
 8yPVl1uTxwfW0xZbFo2Jei2vZW9wlYobnUY0DXM9R6eak8nh+G8dxdQ1RbgzTllDzojm8l
 AnkMbI9VP5Cw7XK4YpdI8Xt7Ol7qBL8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-24CK6qMuPmehylOg0CMx9Q-1; Wed, 10 Dec 2025 12:03:07 -0500
X-MC-Unique: 24CK6qMuPmehylOg0CMx9Q-1
X-Mimecast-MFC-AGG-ID: 24CK6qMuPmehylOg0CMx9Q_1765386186
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42f9ed47dd8so975847f8f.3
 for <dev@dpdk.org>; Wed, 10 Dec 2025 09:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765386186; x=1765990986;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghRGa4GLwJixm7diNNNhFqZF38J0D9HLhk4x/axW4dI=;
 b=bVL5n8/2koY0DrwZEcFd4YPIzMsyk6Zt8f+/1MEJWXNn8oVTSPZ18EmSeIT+wA3E5B
 s02s4kBogyI0LmBVJsIBtcbh/nEH7eodFyMoUeP3iW9NEM/KpLG5sTRSVP3HDN5AqUzZ
 fU3echfp4vJKyeuxS7F0cgsG5eY8nT0S5pdf3KLzUYpSxgnFiJjCkyr4VheW1Pyjq1Lj
 lnUL+4YlOHMQAgXSoEBL4C+7MwcBplYuTOQMqRuBsAlhcPa9jSfMzXya8ZI+Kw1mj2bB
 LO4vqCpANkEmnr9rtQMDnT26DCPB4RYAi3uaZsc+4q6xCOwJvBucgPijT+g2zG3ZE3Ww
 jLWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1RVBDiHySlU87dj3yRqw1/4R4MNQwJyDcZtjI/39YAUhN2/OeMmADQyKfX8WpdFLo1v0=@dpdk.org
X-Gm-Message-State: AOJu0YyBsxlO1firfrywHojd5PrCZEllB883Vb8ZN59wh7JaB+rvsm5E
 0cbN1Vu2cgQ1Lq3u0FkJltI01kA3SY/NVp8l03i+PLC/LX73MGOhiKMvmombZbYyujI3GTeewvd
 Fv1I93TPwOI4Hu6+2++zEiatpfCLarU64TEMMCo5OJqDS
X-Gm-Gg: AY/fxX588K59v9e1OiPhmoWb7gMyqOSbvEknp1X0Mou1gaRryHI7pJGvv63FuvL36Tl
 hVNu5eHcZ+hq6dTPFnjX0dGG+asok+110VgEYln5VS1OsBo4qKR5atMC+up4DHPSBDF7REpt2Qh
 3ag7IHtUX85iIo+HoCaMLrjKisdALns/7BFhQimbh+5AbuFCmcNyfhLu+tkf01NF1GvVI0y0wIn
 jKivifE1r963MgzDkuoR6N+CwpD1ReLwpmBFypugN1pXgxDySQkhLxM0y82+SUKkRaHjDNFyXoy
 8O0OKGl96TCE80A82Yu18Q1NnB24xcD9YbvN5nA2Nuu+dmyNK34qOcMmg0mEnO2/hAVjC/c0dmu
 BC8OKwVDmoVEi
X-Received: by 2002:a05:6000:1863:b0:42f:9f18:8f59 with SMTP id
 ffacd0b85a97d-42fa3b16efcmr3463410f8f.42.1765386185913; 
 Wed, 10 Dec 2025 09:03:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEym/Yu8U+cghq1zaoiLbkvEwbviaQCMov+L6SVmwWrZsSpgcFRV7xCa9TstG4j+4Fv9FKJ1w==
X-Received: by 2002:a05:6000:1863:b0:42f:9f18:8f59 with SMTP id
 ffacd0b85a97d-42fa3b16efcmr3463305f8f.42.1765386184832; 
 Wed, 10 Dec 2025 09:03:04 -0800 (PST)
Received: from [192.168.0.56] ([78.16.128.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85feasm26904f8f.27.2025.12.10.09.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 09:03:03 -0800 (PST)
Message-ID: <44b37eba-c1a2-484c-90a0-7958a5cb6ead@redhat.com>
Date: Wed, 10 Dec 2025 17:03:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 24.11.4 patches review and test
To: Yanghang Liu <yanghliu@redhat.com>
Cc: stable@dpdk.org, dev@dpdk.org,
 Abhishek Marathe <Abhishek.Marathe@microsoft.com>,
 Ali Alnubani <alialnu@nvidia.com>, David Christensen
 <drc@linux.vnet.ibm.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Jerin Jacob <jerinj@marvell.com>, John McNamara <john.mcnamara@intel.com>,
 Ju-Hyoung Lee <juhlee@microsoft.com>, Luca Boccassi <bluca@debian.org>,
 Pei Zhang <pezhang@redhat.com>, Raslan Darawsheh <rasland@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>, Chao Yang <chayang@redhat.com>
References: <20251205095931.160577-1-ktraynor@redhat.com>
 <CAGYh1E_NSVmawQ=sWeivv+k_4svT2odeypr9-u_=n4kt=gdcmw@mail.gmail.com>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <CAGYh1E_NSVmawQ=sWeivv+k_4svT2odeypr9-u_=n4kt=gdcmw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Pxi8jJ9lOct1Sykvezfzm_F2tXHTWX_cMnIbyx7AjIs_1765386186
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

On 09/12/2025 09:23, Yanghang Liu wrote:
> I tested below 18 scenarios on RHEL 9.4 host and didn't find any new dpdk
> issues.

Thanks for testing and the report Yanghang.

> 
>    - VM with device assignment(PF) throughput testing(1G hugepage size):
>    PASS
>    - VM with device assignment(PF) throughput testing(2M hugepage size) :
>    PASS
>    - VM with device assignment(VF) throughput testing: PASS
>    - PVP (host dpdk testpmd as vswitch) 1Q: throughput testing: PASS
>    - PVP vhost-user 2Q throughput testing: PASS
>    - PVP vhost-user 1Q - cross numa node throughput testing: PASS
>    - VM with vhost-user 2 queues throughput testing: PASS
>    - vhost-user reconnect with dpdk-client, qemu-server(qemu reconnect):
>    PASS
>    - vhost-user reconnect with dpdk-client, qemu-server(ovs reconnect): PASS
>    - PVP  reconnect with dpdk-client, qemu-server: PASS
>    - PVP 1Q live migration testing: PASS
>    - PVP 1Q cross numa node live migration testing: PASS
>    - VM with ovs+dpdk+vhost-user 1Q live migration testing: PASS
>    - VM with ovs+dpdk+vhost-user 1Q live migration testing (2M): PASS
>    - VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS
>    - VM with ovs+dpdk+vhost-user 4Q live migration testing: PASS
>    - Host PF + DPDK testing: PASS
>    - Host VF + DPDK testing: PASS
> 
> Test Versions:
> 
>    - qemu-kvm-8.2.0
>    - kernel 5.14
>    - libvirt 10.0
>    - ovs 3.3
>    - git describe
>       - v24.11.4-rc1
> 
> 
>    - Test device : X540-AT2 NIC(ixgbe, 10G)
> 
> Tested-by: Yanghang Liu <yanghliu@redhat.com>
> 
> Best Regards,
> Yanghang Liu

