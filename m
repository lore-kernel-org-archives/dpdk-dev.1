Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F1D3F07A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 15:37:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8FA22402AF;
	Wed, 28 Jan 2026 16:37:25 +0100 (CET)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44]) by mails.dpdk.org (Postfix) with ESMTP id 33BC94003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 16:37:25 +0100 (CET)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-9483864e473so3474923241.3
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769614644; cv=none;
 d=google.com; s=arc-20240605;
 b=XGB3WPOeRZIfHuJpgVXmjyKJYEURcr9ovowh6juz7M7hT99fMhUEE+Pc/KDsqhG//L
 DSjCCe2G07OdVUV1UJmqEgoNvHUXvcJKsPwJJTe/9YFeVa4h6Q3IQzP+SSY+3sPaTbXB
 r0TN0AYagEtthU8WRL2XDZianlAwbPvgaRHT9edum7rGzuOnS3QbuDsJ35TFrHtOf8Nf
 Atkhzdc3ykB2jHNu87OD8Uh8O+fY+hFXA5zI/Oh0DIgReppJaz2jo2j2zGjoqvCC1b2l
 oiV4W/+s7HQQSicjEfwH/VfZ9/kJT/dbxaB3xYtuia5DoLf1LOJ3BXtMBckAlffGbPx5
 LulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Emtkuau5xOOo5LO9YkMJ5BLssbvYL29dJ2QoTQM6aso=;
 fh=nb9NsLtKhz4KAWvkuvkLGT3wr9sdnnz/MGxrrqjnXhc=;
 b=QDFKncawEXxH1HjXO5rBU/2lnYHM8+mVEy0q6ncN8/6HNBzq0nAq5ONt7ziDo8NATY
 uR1HlpC9qvuF39hiGFAwxF5etKkzrw88TReJ5d+RgcrPIBOOWtrbcXmk5F+XwbXw7ueT
 0CRfknxdpbLE2E90HPhIII673HVFsKGpGkcv6Y6h6GGe8ZTVP9YwH2p1LEPnOXbW5wTB
 SgMSXhW87AOxZU71WNBQixocZMNo+SsSA4CCMUdGychnJfYDvsah3BPfDjT/C6XMxbU4
 e4oCicZxRQ8d0AomWD39UkHXRU49gkCkm83xt96/OrA/Vm3Z0udmN24zWnl+i7m91xHh
 V8Kw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769614644; x=1770219444; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Emtkuau5xOOo5LO9YkMJ5BLssbvYL29dJ2QoTQM6aso=;
 b=mxpyXWkTbM1J53GpDhpjRWyQPSMUCuAdeqPPJDZDEJJzXh9p86yg0E6tFimK5iai1f
 XvBg/36S+R205Uo6LhY5UiQAUKqUqIKkwHYzptZxhCMbbgFdoMzP6tE7z6Bd/jiEdX7I
 bgmF69PQqzB7wvKm70rr/0sRjUCuOwDzys5+ZCVBglz/D0lNmf3kYiHXwbADl5vxl6+L
 AMWW7fiEbFZtNcXVMBFNF3XvNFOUdzhi3+7xGCGr/wfb/SSdehaiKiosZq4zSxuf7zVe
 LRgxvC3Mh5F1LnwepQHs7a/zfonaxb9r0b0pofrlRajtCp8fWgwLfJ/A4I8feHgFTM70
 FiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769614644; x=1770219444;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Emtkuau5xOOo5LO9YkMJ5BLssbvYL29dJ2QoTQM6aso=;
 b=uxUNvee0yo2QO0n82nDMxBwFFkXSSAJSYJossWiwbMXTc+nTVDHJfWIo6c8Ygqdp7D
 a/VzjQTmh5ROqUugQrbNQo0y79XuSfHmNhr//PisSr/wn85TZADAUP9juCgeuKVhonFG
 y6Sh30ZQnxCxz7XPIUlPd+U6qKzTgI2mMEFhEc42/+RMr8SLnGMezBBgDjOEZLuHQHqJ
 Byjmxr0bxYw79uUD8xJMxN3e4n4GA6bYxEjASUr5nrsYowtp39zB2+i1vqR9Axb3Pbis
 FC22kfr5GhNQYQmRiKlMgkLrDItRTPZFvNAwSvA5UHnQ7W7dwT27vli7cQ6J9mza5DD3
 +N1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjjQ0uMMWpG2kiZVHiKULmF1jENHlfgdqp512KoC+IHOwG3UyioMm9XelhnKFB426UZVY=@dpdk.org
X-Gm-Message-State: AOJu0Yw4+HMdQdqk5rCYr2XRXjR8H6nxPf98nw6uNWxmCeYX7UdHvnRR
 Rdxk6wdbnoGZDkeHyjPAnxC+zJEqB4h36F/FtfQbFEiHnDD5+7kLoauMy+0+3ms5WxS8KoQ3hUz
 FgwYIF9+aAsf+RjOFjHFq5Z1X6z7i8uUBKw==
X-Gm-Gg: AZuq6aKSJuyt9SeYFRR8QHz0hUqmMlYZ9+Y+H33SGV9gte+8nON3Ht3+TFYYIxU0B61
 2C/soWb7h2JIUzcx58m8w1xMt/Mb0qUQkIo3GqYRd8Q/UL83pYoGqO9v4g69wgBwWNKO9WfkZET
 SXIwhGCoZC6QdskjIhm83QWW9xFcOtYH9fOIJpTC+fiIjy2tVrqJ8IqpLmVqzYusd5yelMnO/OI
 EtPOf7bu+F/KzBXak7k6eXiDTxMPdyqkhfWBgXjjohZjPM4hUJpjvY5mRw7KCczy0b9IVtuLA==
X-Received: by 2002:a05:6102:6214:20b0:5f7:307e:80d9 with SMTP id
 ada2fe7eead31-5f7307e814bmr1315358137.28.1769614644136; Wed, 28 Jan 2026
 07:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20260127181355.98437-1-scott.k.mitch1@gmail.com>
 <20260127181355.98437-3-scott.k.mitch1@gmail.com>
 <20260127105440.267abdec@phoenix.local>
 <CAFn2buBzhD=+5fG44xVyVYvLdunSxK7hTUAqi8+acPqoLf508w@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656BF@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656BF@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 28 Jan 2026 07:37:13 -0800
X-Gm-Features: AZwV_Qi49YDwVi-VbrMS4MyfxTYF5AsgafEsFji833PiLUG5wuR_4owYzY03vrM
Message-ID: <CAFn2buA=6ucB+UJ4=q=XU57S=FMd-94v6O0AhCjzCFO+bu0eug@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] net/af_packet: RX/TX rte_memcpy, bulk free,
 prefetch
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Thanks for the context! That makes sense. I dropped rte_memcpy and can
re-evaluate once all my upcoming changes are merged.
