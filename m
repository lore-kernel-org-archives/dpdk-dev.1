Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA79DC35FFC
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 14:10:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1393140A6D;
	Tue, 25 Mar 2025 15:10:22 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 792504027C
 for <dev@dpdk.org>; Tue, 25 Mar 2025 15:10:20 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-223a7065ff8so46636395ad.0
 for <dev@dpdk.org>; Tue, 25 Mar 2025 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742911819;
 x=1743516619; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eO70k0tWg9j0I5ezfXqM24CAy5AffD+peCvUgnCTjw4=;
 b=NoAOJyNnf8676mS2TgdlJO9L9QhT8499DJczpDHuVomgIpLOdDyXhFNv4YhaAcF9Q/
 +A2zmcsz2B7DLDNv5aVHUjCwEQi4OXT2nrm5pbqfuDhWPto/wLSSP3RPpVHNQjseKM/e
 CROGgWsr25o3jtdQFliWTJk6loph/8DtvSn2G3b0Bko+S2Dl0DV7I14QumkEt3vm+LIH
 9TSZvBWsrQnTQTKx6hqzZrXwYPBFTeUP61C/l3ErZ1t2K1ufF6nIU5G48k/bYbSV24Gt
 BscFvHa0zzZWhKwe/5LytxgXiPn5XnKVp7sly//GSyG1R/hrOj9479tR7slK47fXUQXI
 JMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742911819; x=1743516619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eO70k0tWg9j0I5ezfXqM24CAy5AffD+peCvUgnCTjw4=;
 b=SRjs9evR0HSBS+UD3x8GBzCjR6yxcgdULwu3aIcVAiTm1Xi8Vg83SknaqAhPpGsypi
 0UGthIO/PHkBNp7HzAjWVqhzlAa+nox6xfEAlVD96IKwwpOUpuFqAlxyByh7o6VIEwko
 f2JcCSUu4xvh49KL65b6+FyPhjBSc/W++yC4BghNcYaccpaoeA673wD35/uk0slxfOWa
 T3KDwU07uraQ0D9eyMJeEVPCEFPyC8qG7CoQo/WntOlu1M/QVMBXDMva+rS3ZzyC3zhc
 qRDQLZElZiGW6xgMwGKM+ahs0hg44oDf4LgkCSSCP7vDU6yffHQEy+WV2VaJl8fY8aak
 ZpNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAZbJMv5MjYOaWs1DX4VtTQQZq25rePaOzXn4fnCgNRP8DiJHxtCOtFZejr6hz+l1ve8c=@dpdk.org
X-Gm-Message-State: AOJu0YxxiHxa7xvQaQtwURyJSxiYZ2lsyarJJPTDyZ9tIxS9ZIPCkqMS
 03uxU+bSnTa9a460UbGuZ2j910brLmd252/FG+vBtQnbiaeC0iev8sUliD/wexI=
X-Gm-Gg: ASbGnctJ6bx1cwNTpGY3y9nPoigrRCN++BOSVugJRQLBsuvvFx1B8Xe4gYqGmiC255P
 VL1yeUjjRh8MPniVajY08icrzfTPA7Wg0JdRkrQoE7xyPPv6XzpnJ6ckoddA1qtFqvbV8v0Ejff
 lBoW5WKTX81xCknWB/pDV5pttG28v7HdCGBdKhydfiLx1suHtGMVE2hB0TsudV9Kr1IMAjU0C+u
 QS2jVRZqZPPhqWO9mfd7mq++3JDnL7m4RkyFDOk+xBBRd/jz1J6kG6sWyhTTVQ9Nz9735MiCYFv
 iO+IltaCHkZSJw9XRJWChYB3qHTMgtVNDRZgmmed9rZdGq8EAd2YLfDhv08jfxtjfK0e+DNzsqn
 kS3AjxL3zAhBZh4o0RH0I
X-Google-Smtp-Source: AGHT+IEVZ/1FuZVqWqCMJAzwslRmphl6PlwzkrihlIdoADR5ZwXfGugP7PyAc0hP2fv2uCOz/gF8QA==
X-Received: by 2002:a17:903:40cb:b0:223:5379:5e4e with SMTP id
 d9443c01a7336-22780c525b2mr315664665ad.10.1742911819449; 
 Tue, 25 Mar 2025 07:10:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f443asm90065045ad.228.2025.03.25.07.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 07:10:19 -0700 (PDT)
Date: Tue, 25 Mar 2025 07:10:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Liu <liuwenbo109@gmail.com>
Cc: rasland@nvidia.com, dev@dpdk.org
Subject: Re: [PATCH] drivers/net/mlx5: fix mlx5 send packet failed
Message-ID: <20250325071003.11775779@hermes.local>
In-Reply-To: <1742899140-2013-1-git-send-email-liuwenbo109@gmail.com>
References: <1742899140-2013-1-git-send-email-liuwenbo109@gmail.com>
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

On Tue, 25 Mar 2025 18:39:00 +0800
Wenbo Liu <liuwenbo109@gmail.com> wrote:

> Test Environment: ARM architecture, OpenEuler operating system
> CPU: HUAWEI Kunpeng 920 5220, BIOS Vendor ID: HiSilicon
> Network Card: Mellanox Technologies MT27800 Family [ConnectX-5]
> DPDK program sending self-encapsulated packets with MAC, IP, and UDP headers
> continuously prints the following errors and ceases packet transmission
> 
> mlx5_common: Failed to modify SQ using DevX
> mlx5_net: Cannot change the Tx SQ state to RESET Remote I/O error
> 
> Signed-off-by: Wenbo Liu <liuwenbo109@gmail.com>

Patch has compile failures in CI and coding indent issue reported by checkpatch.
