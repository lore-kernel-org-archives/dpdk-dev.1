Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F604CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 17:46:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3B084029E;
	Wed, 27 Aug 2025 19:46:45 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 35EB640292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 19:46:44 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3cbe70a7923so65925f8f.2
 for <dev@dpdk.org>; Wed, 27 Aug 2025 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756316804;
 x=1756921604; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y16evNB4DsULKHFvx13gRhkqOUVbDLRaUp6v3KYKnz8=;
 b=CGkBfXaHCchPJKczePZLSq3F1UxuLZXWsq/XBUjc0BL4KUZvrYxtVWcnI4yqzukCNv
 oOGGF17VbX1yJ/LyxnjF2Ob0N35ETxeERKqLW2YYe5OGl01ptT89EQ1We7494tGV86KT
 jtR5OfpVokiE7jhAB5fGq3/uBH0Uf1vSuSBmMCJzSgfu+D1zZKLlxQQAcp0D4t9v2EEu
 MinXx+XoD9TcwpzJKEdzx4aDgsxwaotJsumFS/zUVrTlbjB3WHVB4iKBHXmqZThLA334
 CMo/kpCDJKTjQY+UNLRtOAEfhOTRG5RkFZMqkU6Pj/9PSFkNQJPL43+f+3imQRg67pJH
 Fmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756316804; x=1756921604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y16evNB4DsULKHFvx13gRhkqOUVbDLRaUp6v3KYKnz8=;
 b=cFPkFcG80uTJqIUWmiy0neLSQpZAH9uYOLTKuFq3iwffWiE9w2/5KsXsqmqOWRyDr5
 pnq64LbaFh8vVObYIy6Uzsfyio/ftEhW55O0SkyI35LUhQ2ZHewar1nmEemxUT9FfD7f
 4Y9C+a13ovUDVlj45J7iCbqDy65cqSIlwPmn54nmCX4P9jVB2vXQI9EucyuqEm4b2X6O
 79USesnkVgHV5vqFTh7iSz3oHilHfoFaIaMca52td66ug7rtjMkQPcizvhR23ng+fBGq
 1mRNWpSJYK9Tf3hdfyMyMQ7m+/4DmNlRCLa9vmNDbvTt6xo4qVS5G2VgddZYSnbRQeYl
 LYpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6C34xa2tFkC1FL9pcYty/cOz8IwAVlxZK2PNbrzc04G88pi4FJNwujDByPM/X7QoJQQc=@dpdk.org
X-Gm-Message-State: AOJu0YwKCIh7FYOOD2MIp6hXSfzvSS70AJjQvmew4tp2EvwhKuEqsztq
 X77Qo7bn1MXPg9Jb/lnJCgHn8O7LF6iMEHPkjaXK1WK4HhO0pDzS/4YD9Lr8yviKOEs=
X-Gm-Gg: ASbGnctRTChw5Bfu9oTwLuv5tjLzUjtpVJagBo1Dml4yDXQjBgCG7lVIbKBCdiTjswf
 nNi78nEdIe8T4iCk/8mP1ASQLXK4AC1+YhKJiHifFvZs0Za9+hOGbKNG9JTHLG7tFu3mYWppEVh
 uSv+qbspBdppzWz1JSYMyef45pdITIo2PTNDvsQHJouiH6LB/u5V1b7owAoh3deUaK44Q5/k9VF
 vPjS7mDxaA4SwQMAvZSH5KgQTOiGOpVYS186X1+bBMM7Q59y0H/cPsFiDtaNdod7G+cV5sXnKLK
 Z7HnDkMbPCPXE2CN1a19L+yAsyOeAFTRwxqp1dbq4ZSu8JNvAoUxSTC6QpbWcnh87sgCD2/HA1t
 c6fDckOM2vKDi4pqtzJjVGgE4XKYlY017BMhb7S61dIm5yt0MNRmPqYyLm2cqmlrhqaHQyLXpPZ
 w=
X-Google-Smtp-Source: AGHT+IE/s8bwFNg4YrsHeEX4mQqITXoiuM3k0ICWjMvJmmcozWP5Kx/lKnLiqduRIfPk/I42vTjyZQ==
X-Received: by 2002:a5d:64ec:0:b0:3b8:d69b:93b with SMTP id
 ffacd0b85a97d-3c5dd2d8428mr14926706f8f.52.1756316803692; 
 Wed, 27 Aug 2025 10:46:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0d78b4sm43062475e9.7.2025.08.27.10.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 10:46:43 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:46:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Wei Hu <weh@microsoft.com>, dev@dpdk.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v3] net/netvsc: add device argument to configure if NUMA
 information on the device should be used
Message-ID: <20250827104639.6586005a@hermes.local>
In-Reply-To: <1756158627-6548-1-git-send-email-longli@linuxonhyperv.com>
References: <1756158627-6548-1-git-send-email-longli@linuxonhyperv.com>
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

On Mon, 25 Aug 2025 14:50:27 -0700
longli@linuxonhyperv.com wrote:

> From: Long Li <longli@microsoft.com>
> 
> In most cases, netvsc is used with a VF device. The application generally
> runs with better performance when all the device memory is allocated on
> VF's NUMA node, as the VF device carries most of the data packets.
> 
> But sometimes netvsc may run on a different NUMA node than that of the VF.
> This patches adds a device argument "numa_aware" to allow the application
> to configure if netvsc should be NUMA aware. The default behavior for
> netvsc is that it is not NUMA aware. Setting "numa_aware=1" tells netvsc
> to be NUMA aware.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Queued to next-net. Had to resolve some patch fuzz, and trim the commit subject.
