Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE65AC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 23:42:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5E6E402E3;
	Wed, 18 Jun 2025 01:42:13 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id BFB7940279
 for <dev@dpdk.org>; Wed, 18 Jun 2025 01:42:11 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6fad79433bbso67070146d6.0
 for <dev@dpdk.org>; Tue, 17 Jun 2025 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750203731;
 x=1750808531; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkxcyDjrdHx1SPNfHldSknlghN7jsBwr0mQ6qbKi+w0=;
 b=xok7IsyjuDaZ9zVmOFpogqQAIn/9NqDONNzIbr910t0pjZDg9Z7T6afWQVNgygU8Ax
 NfRU/zO5AQiFuR9QOWD3Lnjb4MVaaBanAF3HgppC8Hg4ky/sJ/yUKo9MAB6+aTmyZiid
 ghSKUSx+pg0MzjDhjK02b0EK2uTt57fDCQyd6CepAZ4p+sOylDQGteBroV1j2eMCZcZG
 V7cqEKROm7kyqKWW2RYdc7MgypQ5265UuxT0egXccb3Z5w7eYlpKTIVLve79n3zn8YJB
 iE2wtRuJxxyB8F0vOXN/3S9dPx6yJCMBTgpkDHyvpR447Q8ss2v6S3jYnd9fTw3h6MGv
 pvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750203731; x=1750808531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OkxcyDjrdHx1SPNfHldSknlghN7jsBwr0mQ6qbKi+w0=;
 b=L0oOzw7tY7Vv8Ixcp/JZjpWHJsspG3BTi/vOcjTmtAfzgB2ATqGGvlby3Qfg/BL96y
 0+iPZ87/6uj0liVe0Kx9RpUHj+FtQclHmML9DOANdSM0yqomTJ6YOrrE8CKVoBxUnYk/
 upFl3P65QJGauc4cotHGJsOQBBIeaBzBLvvJNjrQDkr9LcOY9VDBm+9iZm+mLrP46yQQ
 Bg4GUCWGiWRl6i78HJNMyYppFNsoW0zlm22L25yOzKR2/Kg5i/T4mes9RbZTuWT2CykK
 uET1RrcDIFlPhDJgE1kfGmD+Nxqu/Vhfd/B+Hg4OyzBBHnHUm+p6NRAvjNdKUMLcDplj
 dENQ==
X-Gm-Message-State: AOJu0YzQVJueZcaJVMDB1zJc6keU4sc5TC1XIeI72GPkci3l76bF5obA
 +kASrS304AWEOw4h4nALkPLG4Za0eRgXLS/wvOMTmdJLB7bS/V1ib8s7rGrZYkDGIzU=
X-Gm-Gg: ASbGncsTNZ5OfISZQEvDTDBULyKdbe0KS4r7yeutJid5miPEerEk06t3zFI4J6yazA+
 E4tborLWir5i/wMgBYFF47YEp9KNHdF4tS2iLcNB9uSREXGQTQnhEAxew1QD6qYnVFx12+NP8ak
 +0ud8jtI1vFpCBwllLcLqX+OxcNfGhU+0+4pfSl/04i59j7wV93u5bMdg6yuKRKuJZGqhX792nX
 a+RJ822GBM9+e27s/ourddY3gYWBH3hS1qPptGMhdhrjR+iK8jQ33F0haIC/1ZRTWACTITsgmJL
 2aVbO+IposTMrxFsGG1zJDi+/034tZRKNkZDPJYUZaRE+xjqa8PfnOZz7BEpnaTkVOwxs+Q+0H/
 hL7LW1K3WEsp+54kaL4CQt3ebP7ZMHKFGMPJiHbU=
X-Google-Smtp-Source: AGHT+IElP8FuN2NIMLeLhcKY9lHcM5KF/O1ZGvz+gvwdjTfYSfvtQmxbX0b3jysbytcsVOXDNBbOoQ==
X-Received: by 2002:a05:6214:8108:b0:6fb:4cd0:d1cd with SMTP id
 6a1803df08f44-6fb4cd0d545mr136806826d6.38.1750203730826; 
 Tue, 17 Jun 2025 16:42:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb5f63431bsm11587996d6.43.2025.06.17.16.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 16:42:10 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:42:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: <dev@dpdk.org>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>
Subject: Re: [PATCH 1/3] doc: gro API changes notice
Message-ID: <20250617164207.306e3124@hermes.local>
In-Reply-To: <20250617154255.190093-1-mkashani@nvidia.com>
References: <20250617154255.190093-1-mkashani@nvidia.com>
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

On Tue, 17 Jun 2025 18:42:52 +0300
Maayan Kashani <mkashani@nvidia.com> wrote:

> when using --no-numa option,
> gro should be initiated with SOCKET_ID_ANY
> to allow using cross NUMA.
> 
> API changes notice:
> Changed socket_id field in struct rte_gro_param from uint16 to
> int32 to support negative value -1 (== SOCKET_ID_ANY).
> Changed gro_tbl_create typedef to receive negative socket input.
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>

GRO has experimental in the comments, but not the exported symbol
that was a mistake. It either is experimental or not. Given that
the tools check the exported symbol table, I would argue it is not
experimental now.

Most of the API's in ethdev use "unsigned int socket_id", I see no
reason for GRO to be different.

Why not use function versioning to do it now?





