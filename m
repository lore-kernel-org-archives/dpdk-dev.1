Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2B3CAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 13:47:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7BD7402D1;
	Tue, 16 Sep 2025 15:47:56 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 85B2E402C2
 for <dev@dpdk.org>; Tue, 16 Sep 2025 15:47:55 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-778d99112fbso37181436d6.1
 for <dev@dpdk.org>; Tue, 16 Sep 2025 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758030475;
 x=1758635275; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zG/TT7FaEMlWTWShN9jyiPRvh51oTgwAKCf8fjqjGdM=;
 b=G6JGQPTFl7wRlpBCAt07f2OK6nkBPA42CGyJhKHSUxRcf/eu97Xkp7+YxReOZMqkGM
 9MYzYBhUMZ8L2EAdk/8zfQwo+pRiCGdnrLyuijHqd9Z3BngDyRjZ1N43NnWqUsz3uLVn
 HcEOe7LRr4O2rD2spjtOrVxR2ZPslUtSEfxjQutR20BPwwaxE04jptaUbQpZq/t8IrxD
 wsb25AvrvNCvq2ef3lw5ilz1W7+1rBZc/9+noO66yPVG1D1jqw8Oyc05g4DZpjDcc5UY
 0sOBxwnyYxDBk+LDAjo/ARaIsuQ7hEh8LoJm+JlN+EP5aqmYiYkS6+COcfsQAhgln9qf
 NCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758030475; x=1758635275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zG/TT7FaEMlWTWShN9jyiPRvh51oTgwAKCf8fjqjGdM=;
 b=QdxSzWEz9rSoNEenGr3M9PSoDhSvZsrARoKPqjgkWXZXPSL3UaSDOWUta/v0URIp7H
 vmc9bb0OlE95ZbWtqxoF/HUAjFrgQtJQuJV9tQmKEiektUgvZW0XkAQkk/d/CakP5/24
 lRVGWti4BsXMWwnOrTlggtQBES7LfQTeb1y06Zh/Uefi4BbwDNgQG2tryXiWhHTG0Y5V
 K69k948B8TflqwQzq1oDAXeXkSVg7qPfdWtyfpF6ox0fJVaNPLYKETZzFgc8qJ6bC+ld
 vOfpGH3ZaOs1p9uH8y2xJVf8ot63GnBpIUAXGDxpTT9uFAkzSQ4TG1MvnDwTODaVdL1k
 qQ2Q==
X-Gm-Message-State: AOJu0Yy1OSB6Z4x6+TmclloByBHYU6QlVq2svrZU0au+zHqsS5E8jJgN
 RvWEvfP/QRCTUYAN+a725edys/5pXVtehREDvpTQKwFvLqPBLNSyNWKGOV0mE20MbX7kIORiELy
 DyrMC
X-Gm-Gg: ASbGncvZS30okZ4vzNGhmmvBV88LATucAdFB1H8onGabIyJ8mMtGR/oAoPRPNNf+cFI
 cwTk/e3HEV8WfICh8AXARTA1Mv4G++gzOsI5mCboIubuu7UN+UI4fXplrnDe79rgIm3wosrNgGK
 yUUu9mmyNlZfysCGtQCAFgupJqVuIgCw3Do5RTu1T3rOmgULUx3hUJNQH/O24nmHWPNXAbs5bHK
 iVkxC+TQcNUbCzq7HPH7i9HI1oEql+sUZY58ImWjYZIihAF6NoJ0c7F5ZdYCL68C4RGt+0KTKuD
 UPqdaN+2uqOOXhHqDNrkGPK02VBakGvTQ9u5C6tPuMQLSyNNXaJw71Z2eybV28+c6XuVlgpMley
 Vb7jtS4V8LepEer0Iiqdy2lSOvNNtujEkucW7VasQzmlliRVcwT4X3mrGYxinoN9DUwphvbhkMi
 s=
X-Google-Smtp-Source: AGHT+IHfo4p+o/lyyE60WwC4M8iDx33Dop8qfsMJONGwOsJMlfzS8zwdSrGhYi/4LngARdxWUhVBFQ==
X-Received: by 2002:a05:6214:202e:b0:78e:2dac:8044 with SMTP id
 6a1803df08f44-78e2dac8155mr5022756d6.2.1758030474436; 
 Tue, 16 Sep 2025 06:47:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-77c1c269327sm48063376d6.22.2025.09.16.06.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 06:47:54 -0700 (PDT)
Date: Tue, 16 Sep 2025 06:47:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: deleleaf <deleleaf@126.com>
Cc: dev@dpdk.org
Subject: Re: a bug in r8169_rxtx.c in dpdk 25.07 version
Message-ID: <20250916064750.6127fb0c@hermes.local>
In-Reply-To: <410a3e7a.3866.19950982d33.Coremail.deleleaf@126.com>
References: <410a3e7a.3866.19950982d33.Coremail.deleleaf@126.com>
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

On Tue, 16 Sep 2025 11:36:14 +0800 (CST)
deleleaf <deleleaf@126.com> wrote:

> hi , 
> I try to driver a nic ('RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller 8168') ,  
> when I use 'rte_eth_dev_configure' which tx port set to 0, then  running  'rte_eth_dev_start' may crash !
> because at this time 'tx_queues' is null, but still access with 'dev->data->tx_queue' at r8169_rxtx.c:1102. 
> detail stack info picture in the attachment.  

A small program (or using testpmd) to reproduce would help.

An application needs call rte_eth_tx_queue_setup() on the transmit queue.
See any of the examples like examples/l3fwd to see the startup order.
