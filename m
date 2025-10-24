Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080EFCCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 22:49:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4912D40151;
	Sat, 25 Oct 2025 00:49:39 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 1990D4014F
 for <dev@dpdk.org>; Sat, 25 Oct 2025 00:49:38 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-33be037cf73so2837117a91.2
 for <dev@dpdk.org>; Fri, 24 Oct 2025 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761346177;
 x=1761950977; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRPCsad8WXHCaC11312iC2aa9ijpssuO+cuDQIWgE/8=;
 b=m9JCDKiHxxrI7NL7JsBeLK2kTmX5rd0vAplfwEj48tTKZ6jbDJjy9WhaShBMXyKPSm
 SMITQxojSaSFmpkcfPpRx09Z4bepbCmBahkmLGF9FIDjm03utCT9vENo/VJkI1627Aap
 LRAZmodmFTmE4LiaegLdT8XoSATVCeYzpG0iZFMb3j6hy5wGr+S5XycLDFoW7oOSNoZS
 JSjTnK8RXDYEfaKHGO6wAaNLsrnycGOqYaXI391QHBjLBUDDg6dTdryr5MJvL2TTVjOv
 jIp5fWWbJfpF6ZCs4bC15zuN/bAqM67Rg+A2GrCthfTvscNdHf47H23UN9YzgGqN21/L
 yJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761346177; x=1761950977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRPCsad8WXHCaC11312iC2aa9ijpssuO+cuDQIWgE/8=;
 b=gycfDgcQKyWHoudAwG5IWP8upPdcho+xvzcsxH6/DavRnD0XZPX5IyQn6JBWGOWNBJ
 sr73Wf0illNUY0IVqDwKI7GbNf5UmDsjpM2UmjbM9MH/TRWTfRe8vU9IGB1kwsSBOMb1
 YsKYo3J7bT1GDr1+7djZ6XnXBjN5SFV6mBHzgQ074DnN9dA7FCwEx2KJHkFbGHfp7tc+
 H59hn2fqMbQGsxOUSMMKI5meGorCBUh6BQEV8KlrQNV27ihp00hnwlNdKGLzvY5F3DvK
 t8Z3aHLGNbrk+5hr181MRbNr3FlKafYUvAkSp5Gcg0KDVnQ8w6Hrv+WycrLcnp5NbI1S
 xIlQ==
X-Gm-Message-State: AOJu0YxarVO6sTXOVk06eGahVqocvHanmU1JE7636V8l7qd0AdN+fZHb
 lO7/afHwKbEY0goFk4RIaV5twc118UFQzt6czDEnDFhhprnUqtchu8E6pFJg5GgDxbrSq5wqm36
 b3Znh
X-Gm-Gg: ASbGnctHXi9da7xMGb24svgl/Vi9tUfntJ343e9HcxHP/VdwVbB8oAZhTBYOWUWCU/a
 A3ZuWma5P5dyTB/FSWnVD1cKsRyxj2bb2bC13ByeZzPdKzN0+68Fi7DrWnpOGqJct6VCpl+51gT
 2MAuXv2FmSiiO0BcA+bf05z9v/EHhqNUBT4zA6nzz1HEJnBtHBDLNqUvWDzDGiT7m/aJ7ZseMV5
 M/cdmwT7uCp0NTt5uopGY//ZRWosfVCRjlbgPfzZMjWGWQYVJ88phhgWYP9JrJACV8o67ZdZT0d
 MSW6x7axP/0rKK73M0Vop6z+gsm2aetAr70Bfd94savrdSmlgMJQDQGh22bMtT1YvddcESfTILq
 9QH8lhAUxu8gTZ2x6s7rx2b7AHxSmh4eeJQz9oLmUg1jyx1EerDQP8DHidkxxRtpfcAcL816bGz
 jhxbPdgd2rhdr61G6c94/JEFqfEV7AM1o+p/Xze2oNAHBb
X-Google-Smtp-Source: AGHT+IFAxQGTht/TPHq5XqHZPiQpBHftmYBLUUCdIFBKpsWb+NAHh+zdXZFRcaEKlj+jsrEZe+Q5MQ==
X-Received: by 2002:a17:90b:28c4:b0:330:852e:2bcc with SMTP id
 98e67ed59e1d1-33bcf8e6348mr38676662a91.21.1761346177144; 
 Fri, 24 Oct 2025 15:49:37 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33fee458463sm40517a91.6.2025.10.24.15.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 15:49:36 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:49:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 0/6] net/txgbe: fill in functionality gaps for
 Amber-Lite NICs
Message-ID: <20251024154934.0ba0fd42@phoenix>
In-Reply-To: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
References: <20251023121356.21944-1-zaiyuwang@trustnetic.com>
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

On Thu, 23 Oct 2025 20:13:49 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> This patchset adds missing functionality for Amber-Lite NICs in the txgbe driver,
> addressing previously overlooked features to improve support for these devices,
> particularly for the VF.
> 
> Zaiyu Wang (6):
>   net/txgbe: add Amber-Lite 25G VF IDs to PCI ID map
>   net/txgbe: add flush operation for Amber-Lite NICs
>   net/txgbe: add RSS register selection for Amber-Lite 25G VF
>   net/txgbe: add BME reset for Amber-Lite 25G VF
>   net/txgbe: add check link for Amber-Lite VF
>   net/txgbe: add PF-triggered VF link status change handling
> 
>  drivers/net/txgbe/base/txgbe_mbx.h  |  2 +
>  drivers/net/txgbe/base/txgbe_regs.h | 16 +++++-
>  drivers/net/txgbe/base/txgbe_vf.c   | 52 ++++++++++++-----
>  drivers/net/txgbe/txgbe_ethdev_vf.c | 87 +++++++++++++++++++++++++++--
>  4 files changed, 136 insertions(+), 21 deletions(-)
> 

Queued to next-net
