Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075ACAC587
	for <dpdk-dev@archiver.kernel.org>; Sat, 13 Sep 2025 16:26:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4A5940156;
	Sat, 13 Sep 2025 18:26:48 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2F43D4003C
 for <dev@dpdk.org>; Sat, 13 Sep 2025 18:26:48 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7f04816589bso286038785a.3
 for <dev@dpdk.org>; Sat, 13 Sep 2025 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757780807;
 x=1758385607; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnezJkogRqxvSsH9phu8+8/LtkGLsSseg7TSByGTWfs=;
 b=BTQiIjbjUIJ5U/y7EEg/ibxIKGbmlzLec8J1glj6mnnI1taNQa0BJReOEcyB9zcoWD
 gZfTr3aesLo1bCe7AZB8kkKZGx0ueT+6cDmpcEfsvKrYst7tQrOHmr5fOSa5tQjMbZpU
 RFiQ1cxFP7MiaCXjK6U/ctPDTCU3yPlbGDQAjcyj9BdcwH3Q2/RT+mJW5EsGDXDdMyNV
 wZMkEh/X1u8hCeo/dqsG7TI8PjzQ0nhzdngdJXk372mqc2prZmAiUCveLgzEhOaECA45
 gT6GD388Ydd4gLOhs42QfSbjCh3gz2k2j14ivrzc0LisscICI28Cw2LfSBoS/NHP9pSc
 NwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757780807; x=1758385607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TnezJkogRqxvSsH9phu8+8/LtkGLsSseg7TSByGTWfs=;
 b=VBJaC6QCzTxmY0wwh6F8xdqhRj3pdxTImN9Izx5QDdWk5pVUBVWjZ4lPytZN2uQewN
 rr2+q5yM7/z9MX37l9UqrVYkoIXXO0j/G8MNXXs31enMAMTfPfHWrHQRAGzRZ53z9m4W
 AkYB9/4tL6lbrihbLKDfiavdoQSlCm0Jvs5w4BjvFpcsJop1PMGEqDrciqwjDRNzpLXG
 ruMzsE4Y4pZbnKQhXqVUta61ALeWAxEkI4BRHT4bVpjkD/6uWPuaVkZQOPUta7RdrY1/
 zUukzCul6Mkt27NRljLeUHM+D5Heu8O4nfySkd221sZrHEFJOkG9SMg5ZMSXFErGJiyu
 pzhg==
X-Gm-Message-State: AOJu0YzpN9PdmjvT3/6TOtjqwpYg8351lvw1P1tO5lMXkRALxiOv/+q0
 hiRJW4iNZ9qrPgaw/U7VmR6+kkdmZk3IE8sf3HhToyTI8/NPHvtW1eqvQDDwVhql5KM=
X-Gm-Gg: ASbGncs4eIfBFD769g6v1+VoBsC7PF5WBLs8ZfN/bC1eXjJoWCPVoa9fOegn5V/JLjK
 Mdu7NG95tqEf6lbml6HuIV4I9C7LOJ7BKExZXGGsBZsrMgaiNN0EED9turQ9fsd74DqnfSbY7xR
 NTSp6zUcJS39/aJuk/wohSAtpEG3O2DD35NRHyu4Bx/RjNDmRZcaG5CvdoMf3Nwcu+9QrOTkI6E
 GxM+90MtDqFiWhxhKjl4oFMQ2wn1rBFApodHycbLxi9buqcPzTyNZ+CsJgGTma+1h+GgPi3Dm4v
 OZZhmMqNIBgOpcXKVx698L9XwV+0UeQS+U3shu6YA9LRvOWuDeVdK91lsXyZLujM/4sGldtimLM
 ac4vwzvZsbdje1x8JLj3nX+9ztRlC90W8NCldzSJEdKMMCqtfWcECLae3mw/thDz5Bd/21MhaI9
 0=
X-Google-Smtp-Source: AGHT+IEmKO8Jw9RERuUM03G6IzInnmtGzK3XtBaqQXn8jXZNTjCrgUyBil3V6leC+VHFyfKaEIR1Ng==
X-Received: by 2002:a05:620a:d88:b0:807:87a9:89a1 with SMTP id
 af79cd13be357-823fd41926bmr974716085a.37.1757780807470; 
 Sat, 13 Sep 2025 09:26:47 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c8ac45e5sm474896085a.7.2025.09.13.09.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 09:26:47 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:26:43 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ed Czeck <ed.czeck@atomicrules.com>
Cc: dev@dpdk.org, Shepard Siegel <shepard.siegel@atomicrules.com>, John
 Miller <john.miller@atomicrules.com>
Subject: Re: [PATCH v2 4/4] net/ark: improve Rx queue recovery after mbuf
 exhaustion
Message-ID: <20250913092643.19f7b698@hermes.local>
In-Reply-To: <20250910185720.995300-4-ed.czeck@atomicrules.com>
References: <20250910185720.995300-1-ed.czeck@atomicrules.com>
 <20250910185720.995300-4-ed.czeck@atomicrules.com>
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

On Wed, 10 Sep 2025 14:57:20 -0400
Ed Czeck <ed.czeck@atomicrules.com> wrote:

> use 4-K page aligned buffers to reduce PCIe requests
> reduce message spew
> attempt to allocate smaller chunks of buffers during starvation
> 
> Signed-off-by: Ed Czeck <ed.czeck@atomicrules.com>
> ---
> v2:
> - reduced message to single line.
> - Added comments on buffer alignment.  PCIe devices deal with page
> size of 4096 bytes.  By aligning this buffer to a 4K boundary, we
> will reduce the number of PCIe read requests.

It would be clearer if there was a #define for the magic 4096 size.
Is the IOMMU page size? The PCI devices themselves don't usually
have page visibility.

Alignment in this case is really a workaround for "don't cross
the boundary". It looks like the rte_malloc library doesn't have
better way to express that.
