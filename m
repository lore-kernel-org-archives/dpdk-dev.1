Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AD0CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 16:16:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9179402DD;
	Wed, 20 Aug 2025 18:16:45 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 4D66E402CC
 for <dev@dpdk.org>; Wed, 20 Aug 2025 18:16:44 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45a1b0b6ac4so146345e9.2
 for <dev@dpdk.org>; Wed, 20 Aug 2025 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755706604;
 x=1756311404; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gru6yd/O1FoflcQhe5JERSUago08CUAfiT91k+CRZNU=;
 b=iwqc+M2NFpdTXz4hB5H93nNOwOYj4oIAq2dhCyWs5r4s7aG8/ijgI4/BcM2nTXxMlw
 VnSgumeNoxYbi+or/BODOan5Z/Af8pjIaNzsmenyzTFL0Hd/azW5lj+wPK6HzPgS0pkE
 88x95xR6uwn7wxON0g2W1j2tuiavK1A1QrnK3lheaYYF97hN/x+p9pDu3r+pinDJE4o2
 nYh7+hDS71/JFpfN/5/T8legmR8crsa6tnNLeHjJWeZm/ISH/qmHucGHdpvsGwpj0k9P
 JHvSFccRlFcn8zetYAy7PgHVor0UhGnmwJOm4zneE7Nk/+Uxd8UeNdQsSduI2GUIALas
 o+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755706604; x=1756311404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gru6yd/O1FoflcQhe5JERSUago08CUAfiT91k+CRZNU=;
 b=c7gFF6fW0PrpoglLk2e2oDZr/lU9XNvX0EHrL7nsNnynF8MglTjK12Vjw6fDqM+1CK
 NCp/N5sryh8W9gZGzz5rhqX+bsXZhmRJ90XUMAFuASUIipf5T2LfmBNUthilrWGSDgRJ
 0hC6JfvWhejQW5hicbtbbDv3wNP4WVqNpSuJlx8nqSVxFTzLZHU3n9PIWokWO3+3u3mc
 wqy2RgmedtzhUGC1dSVu/Y8w06KMub1QEELdc1GFY6UNvuFlUpkksSAWTuCRweXG1v2E
 3VBb2P8QEasm1BHYpuXENq06dr8Rw8UYU5VKQEg/WGn2F1vFk5cIdYTWCVT1ZmvtYUQD
 HFrg==
X-Gm-Message-State: AOJu0YzHFC7BEcryLxs63gTkk52nTI48xtD5AaIKGnr2fyJGaPHuglpf
 RABmCwYS63Q2CjXW0eYMr3uD+FPkCZtnCy7zOQ5QIrlCCTZNFOamED14F9LX5NSBuzh1K17yjNo
 DA/fKezU=
X-Gm-Gg: ASbGncst2bx6oeLR73L6uTxSiNg0YNmQ5BEvJoCR8ryyX0ARIKSMW1hknrKGOy4Lj85
 Gj/mXG3piZd0fxFAK6hNTyos3tVWWPGDikmvzCck1vBkEoheLO5YKVfZnq9Ymudw8ZCAXQvLSda
 adp4AdYOZ+Hb/ID7pdsaBuEG3Qu68jHAJWSlh1W1jYe2NpAit9HM6M7Gpde6BOaegJYxYVPfUpo
 cFsd0UTUPb1nsU8E6HqBcW7TFnooNNYjHXJGJxG19oOLZVxHvIAFR1zBbjX06daFw26Wira94Dr
 oZvO1Uly/afHjTIIQ6wa/gn8WooFyNZS31NBwcVw/5g918XCQtwgvvY61MUxP5tk0r6/cyacNLD
 s9lRvC0ECajNDAmrMIIuuVL0AivSFKIoZk0ClmraT2hv+X6DCMAc6sQT8rY6sZKiOPprsY3sg/8
 Y=
X-Google-Smtp-Source: AGHT+IENxfproAsRRmYTkgqpK8eUkdkSW8aIYspI3qT6fKrC+sWFwHDfK0ihC8nBMX61Vdyw3tp1Pw==
X-Received: by 2002:a05:600c:3510:b0:456:f00:4b5d with SMTP id
 5b1f17b1804b1-45b479e9be8mr25057245e9.22.1755706603682; 
 Wed, 20 Aug 2025 09:16:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074d43956sm8405393f8f.19.2025.08.20.09.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 09:16:43 -0700 (PDT)
Date: Wed, 20 Aug 2025 09:16:37 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v5 04/17] net/nbl: add Channel layer definitions and
 implementation
Message-ID: <20250820091637.3388306d@hermes.local>
In-Reply-To: <20250819102237.3067518-5-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-5-dimon.zhao@nebula-matrix.com>
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

On Tue, 19 Aug 2025 03:22:24 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +
> +static uint32_t nbl_chan_thread_polling_task(void *param)
> +{
> +	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)param;
> +	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
> +	struct timespec time;
> +	char unused[16];
> +	ssize_t nr = 0;
> +
> +	time.tv_sec = 0;
> +	time.tv_nsec = 100000;
> +
> +	while (true) {
> +		if (rte_bitmap_get(chan_info->mailbox.state_bmp, NBL_CHAN_INTERRUPT_READY)) {
> +			nr = read(chan_info->mailbox.fd[0], &unused, sizeof(unused));
> +			if (nr < 0)
> +				break;
> +		}
> +		nbl_chan_clean_queue(chan_mgt);
> +		nanosleep(&time, 0);
> +	}
> +
> +	return 0;
> +}

This is going to make embedded application developers upset because it uses
a significant part of a CPU polling.

Since you are reading from mailbox, why not implement select/poll/epoll and
have the thread block waiting to read mailbox instead.
