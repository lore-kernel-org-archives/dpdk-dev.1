Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D530C44516
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 09:38:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFCFB402BA;
	Fri, 17 Jul 2026 11:38:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 97B4840E1D
 for <dev@dpdk.org>; Fri, 17 Jul 2026 11:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784281134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TeL2Y6DWDFslpf/HjByi4yaFAOQOwNt3jZUbRdbKb90=;
 b=BQuNgmzAXOrnfhFw/NxAspxZri3n31nA9HzGSDZt+Kt6JWYR14lYHZHJ5Xl53XeyuvfL5J
 MBpGKSAdu4GpkqHc9WFebKkGeTbxwuQVp7YxfR5Zk5OyJc6COkpk2jXgfHUDemZfJxVS8B
 DsQFfRYmuFKjKmrcMQob7WJdRSm0I0A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-XiheJ2uEM0WKQ3MkJ34qHQ-1; Fri, 17 Jul 2026 05:38:52 -0400
X-MC-Unique: XiheJ2uEM0WKQ3MkJ34qHQ-1
X-Mimecast-MFC-AGG-ID: XiheJ2uEM0WKQ3MkJ34qHQ_1784281131
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47485fde05aso4523149f8f.0
 for <dev@dpdk.org>; Fri, 17 Jul 2026 02:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784281131; x=1784885931;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TeL2Y6DWDFslpf/HjByi4yaFAOQOwNt3jZUbRdbKb90=;
 b=g3Y9ZUYnj14qf2QlWi2mKr9+AgFIu3+NDMjPHPVCq6F8T4LbUIfCV/RIuQhg5bMqgg
 UgW6hRYurOAgWV3K5rxMIGP/cg+eFcwtjvuEPDwdvM8sPyDGG8sXK+uRgRLQU3IWUJoX
 2cIukKr3hO8XqVxXh3LCTEHeIckUZmtCQgBEtYQoO16F2+1NtiTUQOCxV5EdihD8gOF0
 Xjo1wsCXEZdMYlmpD1PnVoLkU3OtHpkObSSaNcoDGDaqiSBsLVR+cRI7iKdzb5Bu4DFB
 0HuSiA52LleJSZMj2pLwFA2voEfdvKD5rbwkkwt6T3wGUI7aRr45f94Q90VOdzlCDHVF
 H1Tg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rof3SJZBe0IBp+2SEnCRMQFOylxOQ1LY6UDfQNXANJaJCWHQHRnoxOgXcuS10ydiz6iMgo=@dpdk.org
X-Gm-Message-State: AOJu0YxBQtvcamWmPF9Q1ziJmBAQYzMGd0ao9Cf6STrIdJu8eHwwTJSF
 4/4w8hF2bxSBsD/6GycafhNOTjmqqJWeSmbHhkAkVV7QzpsMiuyi6rreInPOVV/Gxlf6gCOIVUo
 oC7v2juMcL1OzhMaCNJBDhDZRq/YePDFCvyIlB3929Gks
X-Gm-Gg: AfdE7cmeTLv5zZXPEeHeNq+rkIJJkZJ5wtqELiUG3yBDT4NGD5f6IKcdIBziQOFDzFQ
 SpjDtD4UiZMxKSbjC8J/2lIMQ2K8694DgAJX1iQRHkDyuSTylLBs+08kFv+SPL7xKfXZCE6pQnL
 i3qq1Nsea8WEXwWXTE7kIdMsNaOUO7o+BSKffkq43cGTwLSYlzfgK6dQwIMpTv3OSfshdyjWZAs
 G3I1paQBC3LHxduNE6GOODCCa/0X6T7lUa2xlpQpeEH8i29EneaL6dKQwFqfG8RwUYXR0oSkASt
 0/E6LRL9h9u0gxyFuZ9Z7bNgW1bEIoiTqU9C3b7AO74Sdakgbg6rb5mm02mSIUKlQqAUHqsvZJl
 C9I6WT8eWl9j3xAXVXua5vyEButdG2NJBv2/wNy/hjxowp8PE5fU0w+3oW8M=
X-Received: by 2002:a05:6000:1846:b0:476:6559:2a72 with SMTP id
 ffacd0b85a97d-47f62307688mr2449378f8f.2.1784281131406; 
 Fri, 17 Jul 2026 02:38:51 -0700 (PDT)
X-Received: by 2002:a05:6000:1846:b0:476:6559:2a72 with SMTP id
 ffacd0b85a97d-47f62307688mr2449347f8f.2.1784281130888; 
 Fri, 17 Jul 2026 02:38:50 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e499c2sm2101815f8f.4.2026.07.17.02.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 02:38:50 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 17 Jul 2026 11:38:49 +0200
Message-Id: <DK0QVF5D2B66.I9FI8XCFFTCY@redhat.com>
Cc: "Bruce Richardson" <bruce.richardson@intel.com>, "Chengwen Feng"
 <fengchengwen@huawei.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH] usertools/telemetry: load aliases from config directory
User-Agent: aerc/0.21.0-150-g6f19ced00800
References: <20260717091603.1492650-1-thomas@monjalon.net>
In-Reply-To: <20260717091603.1492650-1-thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KNxzBxSXDBQmY4T1KYM9JISVp2pCPeYQZJMdkJ-WXT8_1784281131
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Thomas Monjalon, Jul 17, 2026 at 11:16:
> The default path of the telemetry alias file
> was at the top level of the home directory.
>
> Load aliases from the DPDK configuration directory instead,
> using $XDG_CONFIG_HOME/dpdk/telemetry_aliases
> or $HOME/.config/dpdk/telemetry_aliases.
>
> Keep --alias-file for users who want to provide an explicit path.
>
> Fixes: 410d498412e4 ("usertools/telemetry: support aliases for long comma=
nds")
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Acked-by: Robin Jarry <rjarry@redhat.com>

