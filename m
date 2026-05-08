Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EE1CD3445
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 15:01:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F33440150;
	Fri,  8 May 2026 17:01:00 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 697384013F
 for <dev@dpdk.org>; Fri,  8 May 2026 17:00:59 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12c45281a06so3620316c88.1
 for <dev@dpdk.org>; Fri, 08 May 2026 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778252458;
 x=1778857258; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKyIfQvRyGSkvqVYGGu7DDd7+cHQScNu0B7kdbrKD/k=;
 b=dreIhKigMsD6XJdrM1A9ehc8Q5WcKeNrfqiZmk1DQzhKXk7sAOICRpuW7twuxZ8ShF
 el/cWCAT9nOCtWtk5aneX6wbtozv3RR7sYM/ponpUjJVh1XUNP2MPzcAbKQ+dHrIVg/5
 j6Obd94KN/x4F6DOcUdd+bTcpOOP90E2YwNtR+tquL+wFcHtIIfgRJGWdlnZ8BRTwJqt
 j2lKnXUdINRN8gWMsZ6c+I5d8G71pyGoUeaeWmynRvklZ1Mvv8486Zsv88+dIZ8uiawT
 NdiNFXHG2JpSNZVzosg//SY+9uz5K3W542v0JJn9kTqVjO18IUkM/NC3+h+AujuDLVKA
 nqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778252458; x=1778857258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UKyIfQvRyGSkvqVYGGu7DDd7+cHQScNu0B7kdbrKD/k=;
 b=bgYMTxDfMbzXJbZ4ujJ+phhFtq2EJ+MKds8Pa1JmJPr1JAXn/F/6Kzu6jwA0+NlquN
 WbSnvATIxUFJzN2HIe+xeQL8M1H5DSblJxcIn9iNFb2JfXiZ42FWetUrmGaBLUEgrkRQ
 9PzJRWeUbsKdjjnjNb1FraDBRRxLIM22vqwHr7fGaheFnTilRqu2hl7TDyNrUrrppfxy
 vYnwfc1f0s39VHys4QSMe/CQ3GMb9e0R6oB/KcrpcSU8nysjQ3SoVnf2OvXp6PD+1GAh
 MEI+f8Qwf79d5mp7IL4jgALNJ9Btt1j/vWcA876v22QD0aoBit38b/L4V2oXtzzVLy4p
 xNmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0neVrOhUwMbdJSxIUv3DSevKAnz37JfcODvlUhmmAWhtNpfICr1/mP/vBfe43Tg2APOo=@dpdk.org
X-Gm-Message-State: AOJu0Yzynrq/1QU4x+ugb4oqu1zBOrwP2hq27AKNrkgZRiy6yCoYBsNO
 LpA9nQEiELOKRUohXAC3gk+6mNBqzNOPoS9+FLFi2uPsVgl0YCyuqA3zKzsCtD4RCXM=
X-Gm-Gg: Acq92OHURO49FOxwndkbbnTz86U8isnjqSyVVNMpqX0M/BLwfatZ6OfinW1T9Xv2bk/
 EJh2bxXluGhd7zLdJW/Cj3yTp0KFsdU3Lk+A+d5qQpdd+Eanf0qZjLLwcrqvkOWODY4F8o/3ZsX
 EFjT7ILIxYl00/+1J5yOf0rOAX1x4I61rTxpknH/5AeO9XbLJel4WT1ikXqexZiEfptrLBCPtYR
 sEy42i593AKElLdBL+5GpA2l9c11Fh6ZTrtgq9tYgf9R7clbtQNpeWf/ukTaU1m7rtM1ea6mIvC
 mG+JWS/vVQGQcvlXsJ5IxQjQIBM9Bn0b3PXe5m+sjcghA+AuvKoGbDtfr1/kZfkEF81tOLGC1Bn
 y9VPewiF0My/NAyYgy0TJeV94hlOrYpaFaelTL7K6I6DJBIThHj4gN7UYQfwY22XGNqfXsqv0hZ
 619MXMX78NSqo8Ke7Sw9AR3SJMGmRM58QUkwQ=
X-Received: by 2002:a05:7301:2f8b:b0:2de:cc07:e8b with SMTP id
 5a478bee46e88-2f548895150mr6414689eec.1.1778252457929; 
 Fri, 08 May 2026 08:00:57 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafc2sm3108782eec.4.2026.05.08.08.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:00:57 -0700 (PDT)
Date: Fri, 8 May 2026 08:00:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>, <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v1 1/4] bus/pci: introduce PCIe TPH support
Message-ID: <20260508080050.08a1e535@phoenix.local>
In-Reply-To: <20260508092855.51987-2-fengchengwen@huawei.com>
References: <20260508092855.51987-1-fengchengwen@huawei.com>
 <20260508092855.51987-2-fengchengwen@huawei.com>
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

On Fri, 8 May 2026 17:28:52 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> + * Used with VFIO_PCI_TPH_GET_CAP operation to return device
> + * TLP Processing Hints (TPH) capabilities to userspace.
> + */
> +struct vfio_pci_tph_cap {
> +	__u8  supported_modes;
> +#define VFIO_PCI_TPH_MODE_IV	(1u << 0) /* Interrupt vector */
> +#define VFIO_PCI_TPH_MODE_DS	(1u << 1) /* Device specific */

Use enum n

> +	__u8  reserved0;
> +	__u16 st_table_sz;
> +	__u32 reserved;
> +};

__u8, __u32 are kernel style types don't use in DPDK API's

I hate reserved fields. They don't do what you think and
create more problems. You end up having to enforce that reserved == 0
and 
