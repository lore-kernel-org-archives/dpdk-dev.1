Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E4CD12689
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 23:48:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88D174021F;
	Wed,  3 Dec 2025 00:48:46 +0100 (CET)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 57D2A400D5
 for <dev@dpdk.org>; Wed,  3 Dec 2025 00:48:45 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8b1f2fbaed7so549159785a.2
 for <dev@dpdk.org>; Tue, 02 Dec 2025 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764719324;
 x=1765324124; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjRU9PFyjVj+6xY+zmq3/I995FZAm0KPuHRNNhAXSjo=;
 b=wCKpYJEa0LHWs+/uhEC+mBkjpd0Uh4Ma4PfxCwOuJG0mie5MvFeWEe0PSNihQ4eTCv
 58VpXza57annIrGdGtppSQy+Y/Ga36mXoj0WMtTdexz97lCfEnGx5+FJ2SLDOBAebOeP
 vt4hZac8D9459Mc905nucyhGBGl9j1uhEmCBZhWy8JlbO1RGvKzkMKkFMnfcvEPkhjlk
 z2kwkJI6uXuswdm570AlEtO8+T9kMSGTlDWs+fWJBKAsoBYb5pkhqOg87c3yHjXZ53zM
 4jwGDT6eUbWhIlzD2FYMU4+5xegE5gOCH5mC1MtvBrKsXIcyTgdDM1OsAjfLYXdZfkYA
 gvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764719324; x=1765324124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JjRU9PFyjVj+6xY+zmq3/I995FZAm0KPuHRNNhAXSjo=;
 b=w0YuUoRpqJhOlXYO1WuYrjcpIK+FBQDjHaZ3JPcMxMSN/KhTXL4hTJzAOuTAv3Gndp
 UKAMnWnNOytIoWz6QNS3fhsw68/eYchhKdhupfkdye1T+PmytobruEdik49R2KNlwZmC
 4QmYKk7JNhEO1SzSyMgRCHn0Ca2P3GXGiBznpRABgeJ4sT63C8DhwLmVnHbLu3EAqdEd
 HGToyyGgdRKpAm5ta0WELWE79ex5zKMbt9He5UHQZdSSeWGpMKSH/6jvUnIeNpROX4dn
 /dK1v6Vskp3PUK5glBkL1ghLwMdKCYRqE8v7m4IQ4QXve5RCPRm39zPTKs309SbtGFsZ
 em7g==
X-Gm-Message-State: AOJu0YwwGGFO9XeWC//6KDItDvyQk9YxdEZPW+M1E0IevU5PjJ8Zn1ts
 /XhdMkfBoWZd8XMm/Qah/kc7QeQFQMWTXXgMOAgIZkoYIZFi8qBTkZIOIPYE9+usyw8=
X-Gm-Gg: ASbGncvSiXlLqKa0xyNY5o0G8tULD44IddKs/upkB2wYGRqClNVYMTKGbEIX51/iNyr
 QsAqGOGjmNxuYVHYkxUicZRPf2xWrVBgDaogmepncuYInqmjRoh4vcTZwPgofVwii+DfdZahjFE
 NthPfuTy4AmTaA4Su/wGBr19eQR1y1ISdv2va74ETaSDq58wNLdjlOuQE4vAzZSf58nrPGOvy2s
 v8HCcMGTALO/1SS8aNoSpFX92MdsZ3SqpdYSnCpKrkKIdLwua8ugbjANxQ9XX9cE7NPB20OQxWC
 Rh93MFps/tBPzdZPUg2IxhvMEkU5aCtoL/BvwTWr1uSsaIn2yVAxC8a0Ej3HuUlN2BmUrwgj4rq
 ZDn8INN6o8SDbvRrBUXuU8+7N27DWtAtPPQC5gMXLDPh7JEZsv3dC8GUXGdV8mWRNa2W06oyYYC
 DAyJuTjs4D66RNeJEjruRkSE92pZHMnTbjYnOsT2CFY4MMS7GPozYr
X-Google-Smtp-Source: AGHT+IG98ZXItFi191ZuXuf/eMvu4skqQzu/iBuU+y/QdVJ08bIwYAUx1yYPQogS5f6dxErPcbeaGQ==
X-Received: by 2002:a05:620a:4416:b0:8b5:5a03:36df with SMTP id
 af79cd13be357-8b5e47d0452mr43093785a.3.1764719324401; 
 Tue, 02 Dec 2025 15:48:44 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b529994c8fsm1197494485a.6.2025.12.02.15.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 15:48:44 -0800 (PST)
Date: Tue, 2 Dec 2025 15:48:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Aman Singh
 <aman.deep.singh@intel.com>, Gregory Etelson <getelson@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH] app/testpmd: fix memory leak in port attach
Message-ID: <20251202154840.5579f76a@phoenix.local>
In-Reply-To: <20251202095720.264195-1-shperetz@nvidia.com>
References: <20251202095720.264195-1-shperetz@nvidia.com>
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

On Tue, 2 Dec 2025 11:57:20 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> The convert_pci_address_format() function was leaking memory because
> rte_devargs_parse() allocates memory internally via strdup(), but the
> function never called rte_devargs_reset() to free it.
> 
> Add a cleanup label to ensure rte_devargs_reset() is called on all
> return paths.
> 
> Fixes: 12c2405989f6 ("app/testpmd: canonicalize short PCI name format")
> Fixes: acbff64ea5b1 ("app/testpmd: fix devargs format in port attach")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

Queued to next-net for 26.03
