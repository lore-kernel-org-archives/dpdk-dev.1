Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A796C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 10:09:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A13574065A;
	Mon, 31 Mar 2025 12:09:08 +0200 (CEST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 by mails.dpdk.org (Postfix) with ESMTP id 92B4140650;
 Mon, 31 Mar 2025 12:09:07 +0200 (CEST)
Received: by mail-yb1-f182.google.com with SMTP id
 3f1490d57ef6-e60b75f8723so3009738276.0; 
 Mon, 31 Mar 2025 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743415747; x=1744020547; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vXpZrzgtQh7h4bbKv+C8cUPe8LYs6D/P8q/GFsZJBNw=;
 b=evaV2/EWPs+OOffIyZClG2gfhT0rS5nJ7YSvJD6AK9MQWzuYdzw3AaHzt0KrVrj9Pg
 wXvUtJXUrVKnaMK4Z2SmQzinhxAHPVENTeEk5sIV4OTp0NAI+MTHjSVXQ0DPBx4qL6T6
 HP/UUHChdMelB88ZT069nHXUbJDnusfh3RP1n0bA+79vLMup3TcfYwSQWKvPWEzXqcQi
 ejyJ763JmMOir6hBZgiH3CRkLdy0++tRgTCH5Y6lwbUoeRkX0Oh8ciWj5FrGQYNjTB0D
 lNVqj5wfpIeFCw297lCKwdgCn4g8CUm8vpnekuDycyPH23Kxlj9/94IlWriGslSWUshz
 CBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743415747; x=1744020547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vXpZrzgtQh7h4bbKv+C8cUPe8LYs6D/P8q/GFsZJBNw=;
 b=tT0u8BmUmJzVpwwz+5gcEeGXHnC04OLCPhcQ5oxaYigx6MPyHuaMQGjokGkOsRH1JI
 7xi2/fp8cy1UsRKEBgzUZKe5iUGJ6B1H6+S9woTehXG8qz30EcspOYV1fvit35WnFuNB
 H8wYeo+f5Lhrdxy/6fWVpz1wVwJWSEyprfDHod0wkW4ItBqeDKz5f7c2i4S5/yxMG4C8
 /JNIr3WL0UtPSCIRwab1NiRyRuw/8NoQRul7DjQWdmtp+JiVtkOl7IxH3SWbiXEbyUU7
 JFP0ps8h+a4SSjlQAW6h7FQlqUAmixQCkfMaGxHHDUhVZchj6Yvq31J69nJa0beEd5wz
 XxJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVknjU7jugRrZLLHtldK/5i980XkO+wx3V+EGlT0WdcGt77Tp2AcG9lP+BqFevw05IKT4s=@dpdk.org
X-Gm-Message-State: AOJu0Yysg93H+U5SnhDUjkzu8Ntmfg2DobJOmBCRXHDJDB0VBJXPm6xv
 DXITSrlwmplXrcyqgkyr9YZyVeZLRIOgetqgfnt6+4o6oT/fYRT6Xcjgbe3Lme6H2Gliuvcw3LN
 NgCLgS1y+mchZG5DnDAi/jaOm39I=
X-Gm-Gg: ASbGncvmcIOTHSHNWy2pAr21zW0MzBoMwjRhI+lPU/ZgtXi6PPALSJ7GI1rZR56IXo7
 pDgwUwZ9eVLkgOLJKmfHQ8hcrOqmDD1L7OVutDGKWL7/fFRE5OgrFjf6KskL+iDnAj6Z2R2fGX5
 SiNpdB0q11JAqaJ6JQ6A3/ISq8OXUvPB5LDrpgr0u1l/QdlTvSiwLLg2ObuMc=
X-Google-Smtp-Source: AGHT+IGteRVcVef4aNe4qEh3ovdO2jya7/MUCdzuezDqNFtYd6xn2OcqEVQajDnAWzuFYcXajlPSaETtyZpIDUFIMgc=
X-Received: by 2002:a05:6902:e04:b0:e63:d299:8719 with SMTP id
 3f1490d57ef6-e6b83ad958cmr9739739276.39.1743415746716; Mon, 31 Mar 2025
 03:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250326115132.1444530-1-luca.boccassi@gmail.com>
 <CAGYh1E-M+DHvhyVb0CMTL9t4yw9LE2WOvOi58yGF69J1bA=fGg@mail.gmail.com>
In-Reply-To: <CAGYh1E-M+DHvhyVb0CMTL9t4yw9LE2WOvOi58yGF69J1bA=fGg@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 31 Mar 2025 10:08:55 +0000
X-Gm-Features: AQ5f1Jryx6cHLR_NO8Sm75DU3adezDz-5MgVusHeLUiSykuj5mKjzd_MftECaRw
Message-ID: <CAMw=ZnTc9PjQ-JyCq_+X_p-s0cug14AwKasQtWTsTPuaCbht6A@mail.gmail.com>
Subject: Re: 22.11.8 patches review and test
To: Yanghang Liu <yanghliu@redhat.com>
Cc: stable@dpdk.org, dev@dpdk.org, John McNamara <john.mcnamara@intel.com>, 
 Kevin Traynor <ktraynor@redhat.com>, Pei Zhang <pezhang@redhat.com>,
 Chao Yang <chayang@redhat.com>
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

On Mon, 31 Mar 2025 at 10:08, Yanghang Liu <yanghliu@redhat.com> wrote:
>
> I tested below 18 scenarios on RHEL 9.2 hosts and didn't find any new dpdk issues.
>
> VM with device assignment(PF) throughput testing(1G hugepage size): PASS
> VM with device assignment(PF) throughput testing(2M hugepage size) : PASS
> VM with device assignment(VF) throughput testing: PASS
> PVP (host dpdk testpmd as vswitch) 1Q: throughput testing: PASS
> PVP vhost-user 2Q throughput testing: PASS
> PVP vhost-user 1Q - cross numa node throughput testing: PASS
> VM with vhost-user 2 queues throughput testing: PASS
> vhost-user reconnect with dpdk-client, qemu-server(qemu reconnect): PASS
> vhost-user reconnect with dpdk-client, qemu-server(ovs reconnect): PASS
> PVP  reconnect with dpdk-client, qemu-server: PASS
> PVP 1Q live migration testing: PASS
> PVP 1Q cross numa node live migration testing: PASS
> VM with ovs+dpdk+vhost-user 1Q live migration testing: PASS
> VM with ovs+dpdk+vhost-user 1Q live migration testing (2M): PASS
> VM with ovs+dpdk+vhost-user 2Q live migration testing: PASS
> VM with ovs+dpdk+vhost-user 4Q live migration testing: PASS
> Host PF + DPDK testing: PASS
> Host VF + DPDK testing: PASS
>
>
> Test Versions:
>
> qemu-kvm-7.2.0
> kernel 5.14
> libvirt 9.0
> ovs 3.1
> git log
>
> commit 684d996a201182b5335012055df33284e753d832
>
> Author: Luca Boccassi <luca.boccassi@gmail.com>
>
> Date:   Wed Mar 26 11:26:26 2025 +0000
>
> version: 22.11.8-rc1
>
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
>
> Test device : X540-AT2 NIC(ixgbe, 10G)
>
> Tested-by: Yanghang Liu <yanghliu@redhat.com>
>
>
> Best Regards,
> Yanghang Liu

That's great to hear, thanks!
