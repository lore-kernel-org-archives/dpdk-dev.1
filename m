Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF5FD2D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 12:17:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50BD44028C;
	Tue, 13 Jan 2026 13:17:24 +0100 (CET)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68]) by mails.dpdk.org (Postfix) with ESMTP id 8B6CE40276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 13:17:22 +0100 (CET)
Received: by mail-ed1-f68.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so11112895a12.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 04:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768306642; x=1768911442; darn=dpdk.org;
 h=content-transfer-encoding:in-reply-to:reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYtr/fv0JomFRYxAgzLdeSu3HwLDwSrWGcOOSYwPSwQ=;
 b=Iy93yZzWi+dldCYDMduMyy+yQyOQGKB7SENdIaCBMvleoV4dtSs9QeBZtA7iT11vPn
 XVKUCNOWzAsN9x1BzzPTTIuvNCIxZ6Z7VhHrwLGJZwAxjXsrMnZ+zJkh0MJMKBKxlNEu
 SfOYFB1bdxQejzDPP01oyr2IQlRZiJj6numAtmlOfHPZvG6JdbZZq64HkfICGoEyvttY
 2zBQtCtWMZD5SnL5aj4kbxvj02WW7TycBUU7h81ORJSLwwLkLLj48uioeprthGPdYplw
 VKs3LSW4QFJffi2P8twnmU53IAIkIcuPNYGLpV/GiPki2ijFz/ONxZAf/l42GbvKhEAn
 YCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768306642; x=1768911442;
 h=content-transfer-encoding:in-reply-to:reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYtr/fv0JomFRYxAgzLdeSu3HwLDwSrWGcOOSYwPSwQ=;
 b=agxyBNOYnev2xNdH4oxeRa56e94AfYdVpgo/Xm4O8dQNngLjIhsuLjM2dzoABZSi0W
 Ir3lT40yTRwxsiBkKJvX8yrG2PMv/eKwNE+3RN1xPv4kdERzM6JM09gufnuZ9cW9/0Dw
 ZXaRZHI75YV8Ch7YPQxayRjJTcjYK0dJlbjSkCxkZe0XCwnC7FwGxZog2Qgfq0Ds5q7G
 xo8AvdxM/wYckRWUyvYA62GGLjdaiYwU9gHFKUpTFQTnd1JtaBZi4U7kTJj/aD0lHNzo
 1kRaA46p0/yRK5YRbzqNndnTHg4kDKq8DssT34GiKjTScj0jxsdiPDOHLAr2CIfryaBj
 qv8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUepVdkfwaRbjePJoZqiKBeLEL2EFUmOLMy+PHyrARvhjEEV0UNKKui8CnimgtndP+zlzQ=@dpdk.org
X-Gm-Message-State: AOJu0YytKYfclfsrzHUG/GVdKiGE5NzdmLTaTuGOBIGihhhJvcS7E7Fq
 bJdVWY0jYsILgoKjvvGpeCx/rLtHGEOENkRAbpG8pd0tgAtmD+AOUkPv
X-Gm-Gg: AY/fxX4OSWbfu0usxLwYB9MzHNO7ueQy8o+B2dhx7qPeDwH6ZScEgrC5gqo1Jm2oLiO
 qGKJ1CzHm3sggoBjDd/4m1N79TgLJX0khy4LVWAFEs2cXs3mN9tIpZE1RcGjWUnxpTOXfmHec24
 L35dPzcwigeSpSdfh7TLjIesNWLIrgqJGSnZkIagfwMKVPY6tlsQypGjeIkNjajplt2fFCrQjhX
 gK5qBZ7R+DbGhLrNweeAFVGyZ0hvX0yUSNPinZAMHvBgC+qZTe7l3HxT5M9gN75MVBzOLmv9ark
 Sv0Sr2VDVSSlztbG5NoaGkAum71R+aAEhqVuda9iOlXacRlAUpnFsPxtNo6xBhka4X4dUzfFa3g
 gNApe2lhXoE6OfxLWm93GSEANpkDyehSqFXyaOpeI+fHwxnFB3JmlHpqucdWDCSwM9kqwOaCqIM
 cV9x8YRG9h6m8qWsqqfKFrk0X8oeFTXELRIdw0sWNGuWxW4w==
X-Google-Smtp-Source: AGHT+IHCL+qcmpnUi14acTQL1vykVC6sDxMgTcVWQ9BYxutlGqF39Hk38EnoadEd64u1/dBfuY+a8Q==
X-Received: by 2002:a17:907:d90:b0:b87:1b2b:3310 with SMTP id
 a640c23a62f3a-b87358db869mr256914366b.9.1768306641822; 
 Tue, 13 Jan 2026 04:17:21 -0800 (PST)
Received: from [192.168.1.118] (89-64-21-15.dynamic.play.pl. [89.64.21.15])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a5187afsm2155143366b.58.2026.01.13.04.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 04:17:21 -0800 (PST)
Message-ID: <16c82143-3828-4ede-ab19-fe2e908e2190@gmail.com>
Date: Tue, 13 Jan 2026 13:17:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] bus/pci: don't open uio device in secondary process
To: chenbox@nvidia.com, dev@dpdk.org
References: <20240829085724.270041-1-konrad.sztyber@intel.com>
 <20241011111533.20746-1-konrad.sztyber@intel.com>
 <B7194C63-9B63-4E74-876F-C0B83CD113FA@nvidia.com>
Content-Language: pl, en-US-large
From: Konrad Sztyber <konrad.sztyber@gmail.com>
In-Reply-To: <B7194C63-9B63-4E74-876F-C0B83CD113FA@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: B7194C63-9B63-4E74-876F-C0B83CD113FA@nvidia.com
Errors-To: dev-bounces@dpdk.org

On 9/22/25 10:22 AM, chenbox at nvidia.com (Chenbo Xia) wrote:
>> +static int
>> +pci_uio_send_fd(const struct rte_mp_msg *request, const void *peer)
>> +{
>> +       struct rte_pci_device *dev;
>> +       const struct pci_uio_send_fd_param *param =
>> +               (const struct pci_uio_send_fd_param *)request->param;
>> +       struct rte_mp_msg reply = {};
>> +       int fd;
>> +
>> +       strlcpy(reply.name, request->name, sizeof(reply.name));
>> +       TAILQ_FOREACH(dev, &rte_pci_bus.device_list, next) {
>> +               if (!rte_pci_addr_cmp(&dev->addr, &param->addr))
>> +                       break;
>> +       }
>> +
>> +       if (dev == NULL) {
>> +               PCI_LOG(ERR, "Could not find PCI device (" PCI_PRI_FMT ")",
>> +                       param->addr.domain, param->addr.bus,
>> +                       param->addr.devid, param->addr.function);
>> +               goto reply;
>> +       }
>> +
>> +       fd = rte_intr_fd_get(dev->intr_handle);
>> +       if (fd < 0) {
>> +               PCI_LOG(ERR, "Could not get fd (" PCI_PRI_FMT ")",
>> +                       param->addr.domain, param->addr.bus,
>> +                       param->addr.devid, param->addr.function);
>> +               goto reply;
>> +       }
> Should we just return error instead of calling rte_mp_reply when dev == NULL or fd < 0?

We could, but that means that we won't send any response to the 
secondary process, so it'll timeout. I figured it's better to return a 
response with num_fds = 0 to let it fail immediately.

Konrad

