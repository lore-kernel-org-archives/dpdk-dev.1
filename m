Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE96D3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 10:28:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED6164042E;
	Mon,  8 Dec 2025 11:28:19 +0100 (CET)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46]) by mails.dpdk.org (Postfix) with ESMTP id 6094440280
 for <dev@dpdk.org>; Mon,  8 Dec 2025 11:28:18 +0100 (CET)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-640f88b873bso4166839d50.3
 for <dev@dpdk.org>; Mon, 08 Dec 2025 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765189697; x=1765794497; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EM19knwNvQTcLSP0UmeM5OJzn1Qju+p4RgGVLzxS1cM=;
 b=E83vpDJc6D5Hi+heUmnSF2QjpXUUZfrmciejoCZYhGMFlXnmhrMf3/7hNXTsuOGusb
 1B3HpcK0FXn9Q7tjuODnD/e0lC1GlEkGRLU+dGD+lvN1hcThpUKWl4kCaBJVzG4AMaWb
 mgHBWr/GaCDh5+BsF7u6luGOFVMo9SXUjIEkkbKDldPT7qK0d54gLBFEbQEKDnDeWKdC
 ORA5UmbPetPToQgk/tnMR2jQ6hO/Dp0b0fJGjQDNAeqMnW1gMqn5wMfq1C5qocORxjgv
 mQzLfcSBk5Iaxp1gNr4mJStFwNGauOe6epWJuMO8FC8/dedrFwi8dbA5uYX0Bt0Q90Gc
 rIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765189697; x=1765794497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EM19knwNvQTcLSP0UmeM5OJzn1Qju+p4RgGVLzxS1cM=;
 b=J/iYXZdA65JNSXI85iiKvt+mNAMdaiFc1QKHyQGUr3+7pver7dL5G759pcpCdPBzxD
 xniFNlceCc9tWVyvz1NZ8sllfyGuM3Pgy7mpQMfeTborwXqT5gobycosBVCHJ1LJjCTD
 dDa5WQdcTaIFJYlx+IYWElCWAp6xSn3VM4Rg4bUWn22rTMYa0wMm2hOQ4he4IX0l/ivQ
 u76Jl+VHBnQq13Z/F58g0t+mTt4En2HqnaHy7ctLgDJ4GuPemJUpq1eplB6RkIc8ToME
 9RIbTCe6ST+9l++kpVikJ+Yj4ora5NExgc4YInKZi7EeoM2vr3W8kKEoNT1I/znwMCdG
 C9Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPpnd7MVMAAJuOOEHWGWMmN/ixc3MpQAYVdcDU4TYUssEmijblFoOn0Az+8OpbyBu4GqQ=@dpdk.org
X-Gm-Message-State: AOJu0Yykv5n29w18ErdiZ1dgQYRhfd9G7xRk44Dd72IAYpHmH9sseVsB
 0Pfow0/vCFdkB8a8iMlZ6cKez641HzI1FM5CR4J0LwcbMkTak9EOaOTkiJLgo+2Rtf1bHEllCpC
 ZQZkV7wCvaYtodFLuzmNcqe1AAtSMn0I=
X-Gm-Gg: ASbGncughRgCbX30QLEu3VBKXGqh5SjQPV9rT1R11hbntBcHNoqaEK427kxXpTREjp9
 /eGJuxbiTVfH7onbAtCZmyooyhycJIBlbHNzIrRKhst/CBMmAMaXd+byjb3tIBxyO1tGoku6px4
 BN+ueaqnrTRC8bpjgSnaWcoRWbJoRAVY2/+22WS5p74qFZwD90Imih/ps+bNkz6ZoW36SGpZuGr
 EAAgY1wNfDzqJ7rQT2A9FbcGTSUgZts1xe1NmNxeo+QAeLg2DYqZjlFx5wtGoT2q642LkFE6IcP
 8smN1Qtj5Y7+xjUozWaTd24GxrfjnA==
X-Google-Smtp-Source: AGHT+IFsRnWFGm7MQLP1MZPydIXNEWWeiGCB7NJ3gc674XZ6EzgJgvGNtlfZYxqgv0OsEl603MOaxuHtRPmEPTcX2Ng=
X-Received: by 2002:a05:690e:159a:10b0:641:eeca:193a with SMTP id
 956f58d0204a3-6444e757271mr4968422d50.3.1765189697590; Mon, 08 Dec 2025
 02:28:17 -0800 (PST)
MIME-Version: 1.0
References: <20251204005603.3236032-1-luca.boccassi@gmail.com>
 <CAGYh1E-wQi5cn+ejg4+q+v4TvsBbYkGfpNQKr279gAunNzxzXQ@mail.gmail.com>
In-Reply-To: <CAGYh1E-wQi5cn+ejg4+q+v4TvsBbYkGfpNQKr279gAunNzxzXQ@mail.gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 8 Dec 2025 10:28:06 +0000
X-Gm-Features: AQt7F2q4kQgzohL5nRwrCADOWPG5EX7w4yaTAMnD-bi51qeD86M8hPGQ82j31fE
Message-ID: <CAMw=ZnSYF11kgH7dO34FuhHy9pBArYUgPaYLqdpzBDNiN9Z2Ag@mail.gmail.com>
Subject: Re: 22.11.11 patches review and test
To: Yanghang Liu <yanghliu@redhat.com>
Cc: stable@dpdk.org, dev@dpdk.org, John McNamara <john.mcnamara@intel.com>, 
 Pei Zhang <pezhang@redhat.com>, Chao Yang <chayang@redhat.com>
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

On Mon, 8 Dec 2025 at 08:03, Yanghang Liu <yanghliu@redhat.com> wrote:
>
> I tested below 18 scenarios on RHEL 9.6 host and didn't find any new dpdk issues.
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
> qemu-kvm-9.1.0
> kernel 5.14
> libvirt 10.10
> ovs 3.3
> git describe
>
> v22.11.11-rc1
>
> Test device : X540-AT2 NIC(ixgbe, 10G)
>
> Tested-by: Yanghang Liu <yanghliu@redhat.com>

That's great, thank you
